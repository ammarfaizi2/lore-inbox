Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVBIRVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVBIRVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVBIRVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:21:42 -0500
Received: from styx.suse.cz ([82.119.242.94]:13969 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261853AbVBIRVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:21:34 -0500
Date: Wed, 9 Feb 2005 18:19:21 +0100
From: Jirka Bohac <jbohac@suse.cz>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Jirka Bohac <jbohac@suse.cz>, lkml <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, roman@augan.com, hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050209171921.GB11359@dwarf.suse.cz>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209152740.GD12100@apps.cwi.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 04:27:40PM +0100, Andries Brouwer wrote:
> On Wed, Feb 09, 2005 at 02:26:54PM +0100, Jirka Bohac wrote:
> > Hi folks,
> > 
> > find attached a patch that improves the keycode to keysym mapping in the
> > kernel. The current system has its limits, not allowing to implement keyboard
> > maps that people in different countries are used to. This patch tries to solve
> > this. Please, tell me what you think, and merge if possible.
> > 
> > Current state:
> > --------------
> > 
> > The keycodes are mapped into keysyms using so-called keymaps. A keymap is
> > an array (of 255 elements per default) of keysyms, and there is one such
> > keymap for each modifier combination. There are 9 modifiers (such as Alt,
> > Ctrl, ....), so one would need to allocate 2^9 = 512 such keymaps to make
> > use of all modifier combinations. However, there is a limit of 256 keymaps
> > to prevent them eating too much memory. In short, you need a whole keymap
> > to add a new modifier combination to a single key -- bad.
> > 
> > The problem is, that not all keyboard modifiers can actually be assigned a
> > keyboard map - CapsLock and NumLock simply aren't on the list.
> 
> The current keyboard code is far more powerful than you seem to think.
> 
> Keymaps are allocated dynamically, and only few people use more than 16.
> You can have 256 keymaps, but they are not necessarily the 2^8 maps
> belonging to all 2^8 combinations of simultaneously pressed modifier keys.
> 
> You can assign the "modifier" property to any key you like.
> You can assign the effect of each modifier key as you like.
> There are modifier keys with action while pressed, and modifier keys
> that act on the next non-modifier keystroke (say, for handicapped),
> and modifier keys that lock a state (say, to switch between Latin
> and Cyrillic keyboards).

I know that. But still, there is a problem with K_CAPS and K_NUM. They are
hard wired into the code on several places. They toggle the state of the keyboard LED, 
and later the state of the LED directly influences the keycode->keysym mapping; e.g.:

if (type == KT_LETTER) {
	type = KT_LATIN;
        if (vc_kbd_led(kbd, VC_CAPSLOCK)) {
        	key_map = key_maps[shift_final ^ (1 << KG_SHIFT)];
                if (key_map)
                	keysym = key_map[keycode];
        }
}


> 
> It seems very unlikely that you cannot handle Czech with all
> combinations of 8 keys pressed, and need 9.
> Please document carefully what you want to do and why you want
> to do it. I think most reasonable things are possible.

In the standard Czech keyboard, there are letters with diacritics on the
1234567890 keys, this is what you should get wgen pressing those keys:

1) with CapsLock off:
1a) no shift pressed: plus, ecaron, scaron, ccaron, rcaron, zcaron, yacute, aacute, iacute ,eacute
1b) SHIFT pressed: 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
2) with CapsLock on:
1a) no shift pressed: Plus, Ecaron, Scaron, Ccaron, Rcaron, Zcaron, Yacute, Aacute, Iacute ,Eacute
1b) SHIFT pressed: 1, 2, 3, 4, 5, 6, 7, 8, 9, 0

This is not possible to achieve with the current code, because the K_CAPS
behaviour is hard wired in the code and not controlled by an extra set of
keymaps.

There are presently two ways around this, neither of them good enough
1) assigning one of the other modifier keysyms to the CapsLock key 
   -- the LED will not work
2) assigning a nonstandard keysym to the Shift key -- will breeak 
   programs like mcedit

The NumLock is hardwired in the code in a similar way. I think this is a
design misconcept. These keys should have been treated as other modifiers.

But by adding two modifiers to almost every keyboard map, you would
increase the space occupied by the keymaps four times. ... erm ... eight
times, because there is also this "applkey" (application keypad) flag,
that will be needed as another modifier.

This, of course, is undesirable. The new implementation solves this
problem:

- you only define the meaning of additional modifiers for those keys for
  which they make any difference - not wasting memory by huge keymaps that
  are mostly filled by K_HOLEs

- all the clever things you pointed out are still there

- the resulting memory size occupied by the needed structures will
  generally be smaller or equal to the current state. Of course there are
  insane worst-case examples that end up bloating much more memory.

- the implementation is fully compatible with the old IOCTL interface --
  the only drawback is, that the resulting keytables created by the old
  IOCTLs are not optimal and actually take up more memory than the
  original implementation. But this is a temporary state, which can be
  fixed by creating a keyboard map in the new format

- the proposed keyboard map file format is IMHO much much nicer than the
  old one, although this is dependent on personal tastes. Maybe by looking
  at an example, people will better understand how it works:

  	keytable Esc {     		#defines the escape key
          	alt      = Meta_Escape	#if alt is pressed, produce Meta_Escape
	         	 = Escape	#if not, produce an escape
	}

	# This effectively defined all the 4096 combinations on two lines.
	# The first line says: Only have look at the curent state of ALT,
	#	and if it is on, produce a Meta_Escape. 
	# The second line says: Don't look on the state of anything and
	#	produce Escape
	

	keytable Enter {	
	        !shift !altgr !control alt !shiftl !shiftr !ctrll !ctrlr !capsshift = Meta_Control_m
		= Return
	}

	# In this example, the first line says: Have look at the state of
	#	the shift, altgr, control, alt, shiftl, shiftr, ctrll,
	#	ctrlr and capshift modifiers. If all of them are off,
	#	except alt which is on, produce a Meta_Control_m
	# The second line fallbacks to Return.

   As you can see, this is quite effective. And this is exactly the way it
   is represented in the memory - each of the lines is represented by a
   6-byte entry in the keytable. 

   Have a look at the default keymap, which is included in the patch, to
   see just how effective this can get. It saves both typing and memory.
   Once you get the simple idea, it is much clearer to understand than the
   old format, imho.

> (The weakest part is the support for Unicode / UTF8 - don't know
> whether improvement would be good - it is clear that one doesnt
> want to have full Unicode support in the kernel, but there is
> continued pressure to add some support for diacriticals. We might.)

There is unicode support for everything BUT the dead keys, WRT to keyboard
mappings. It seems that dead keys were simply forgotten.

regards,

-- 
Jirka Bohac <jbohac@suse.cz>
SUSE Labs, SUSE CR

