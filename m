Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVBJM4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVBJM4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 07:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBJM4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 07:56:08 -0500
Received: from styx.suse.cz ([82.119.242.94]:14256 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262108AbVBJMzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 07:55:54 -0500
Date: Thu, 10 Feb 2005 13:53:44 +0100
From: Jirka Bohac <jbohac@suse.cz>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Jirka Bohac <jbohac@suse.cz>, lkml <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, roman@augan.com, hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050210125344.GA5196@dwarf.suse.cz>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl> <20050209171921.GB11359@dwarf.suse.cz> <20050209200330.GB15005@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209200330.GB15005@apps.cwi.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 09:03:30PM +0100, Andries Brouwer wrote:
> On Wed, Feb 09, 2005 at 06:19:21PM +0100, Jirka Bohac wrote:
> 
> > There are presently two ways around this, neither of them good enough
> > 1) assigning one of the other modifier keysyms to the CapsLock key 
> >    -- the LED will not work
> 
> True.

Well, we need to solve this. It seems that CapsLock and NumLock should really 
be modifiers -- the assumption that CapsLock simply inverts the state of Shift is 
wrong. My patch solves this.

> > But by adding two modifiers to almost every keyboard map, you would
> > increase the space occupied by the keymaps four times. ... erm ... eight
> > times, because there is also this "applkey" (application keypad) flag,
> > that will be needed as another modifier.
> 
> But keymaps are allocated dynamically.
> Any number of new modifiers does not cost anything until
> one actually uses some particular modifier combination.
> 
> New modifiers are not expensive at all.

Addidng two modifiers is not expensive. But adding CapsLock, NumLock ( ->
and applkey) would actually require them to be used in most keyboard maps,
probably in combination with all the other modifiers they're currently
using. Thus, increasing their size 4 or 8 times. (Maybe the applkey is not
strictly needed as a modifier, but it makes things much nicer and cleaner
... with the new approach, making applkey a modifier does not hurt at all)

This was the reason I decided to go the keytable way.
The current default map has 7 keymaps -> 3.5kB ... * 4 = 14kB
The current "us" map has 9 keymaps -> 4.5kB ... *4 = 18kB
The current "cz" map has 42 keymaps -> 27kB
    Now, don't want to demagogic here ... maybe not all combinations
    with CapsLock and NumLock are really needed, but most of them probably
    are ... 27kB * almost 4 = almost 108kB
    !! Anyway ... the 27kB is bad enough on its own !!

Also, it seems that in the future it will be necessary to increase NR_KEYS
beyond 256 (probably 512 ?). So, better multiply the above numbers by two
;-)

Now ... with the keytables patch, there is a fixed amount of memory eaten
by the key_tables array ... NR_KEYS * 8 bytes in most cases = 2k (4k in
the future).

By adding many modifier-dependent meanings to a couple of keys, you
increase only the table associated with that couple of keys. The default
map I supplied uses 155 32B blocks = 4960B in 114 tables and 507 entries.
So the total is 7kB for the default keymap. Ok, this is two times worse
than the current 3.5kB but also two times better than the 14kB needed to
implement the current map with CapsLock and NumLock.

But the way is much better suited for future extensions. More keycodes
won't hurt. More modifiers won't hurt, even in combinations with the
current ones.

I haven't written the "cz" map in the new format yet, but it is obvious
that it would be just slightly larger than the default map (I'd bet it
would fit in 10k, not 27k, not 104k). Just have a look at these maps in
the old format, and try to count the number of VoidSymbols in there.

> > - the proposed keyboard map file format is IMHO much much nicer
> 
> Keymap files live in user space. The layout of a keymap file
> has no bearing on the kernel implementation of keymaps.

Well, not quite true in this case, because the new format is not a
traditional "map". It is a lookup table. Anyway, this is not important...

> The present kernel code organizes things in maps, one for
> each modifier combination that people want to use.
> You want to organize things per keystroke.

Seems logical to me. Defines what individual modifiers do to keys, instead
of having huge maps for every modifier combination you want to use
(possibly for a single key).


> I see no great advantages. Many small arrays allocated
> by kmalloc() leads to more overhead - probably your version
> would lead to larger memory usage, but I have not checked.

For very basic maps yes ... slightly larger. For usable maps smaller.

> It looks like your code is larger.

Well, the big and ugly part is the backwards compatibility code. This
would go away after some time. The rest looks like being cleaner and
better structured (?)

> It also looks like your code is slower, with a loop instead of a table
> lookup.  (Not that those things are very important

True ... both parts ;-) ... no, really, the tables typically have up to
ten elements, this shouldn't hurt

> Of more interest are the added features.
> You come with a single big patch, but some parts are independent.

Sorry, I really could have splitted this. Will do.

> For example, I see
> 
> +struct kbdiacruc {
> +       unsigned char diacr, base;
> +       unsigned int result;    /* UCS */
> +};
> 
> Ten years ago we made the mistake of being too careful with memory.
> Today it is a very bad idea to introduce new ioctls that act on
> 8-bit quantities. These must all be int's.

Looks like a good idea. I will probably make the KDGKBTBL and KDSKBTBL
ioctls also use int for the keysym, because I just copied the idea from
the current system, where the unicode does not have full 16 bits (the ^
0xf000 hack). You're right, it would be very unfortunate to have to extend
the ioctls once again because of saving on bits here.

regards,

-- 
Jirka Bohac <jbohac@suse.cz>
SUSE Labs, SUSE CR

