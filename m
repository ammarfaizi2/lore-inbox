Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUE3Lnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUE3Lnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUE3Lnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:43:31 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:53632 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263147AbUE3LnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:43:09 -0400
Date: Sun, 30 May 2004 13:43:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040530114332.GA1441@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b23d2eba99fff039896a6@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 12:20:32PM +0200, Giuseppe Bilotta wrote:

> By looking at the header files, or into the documentation, I 
> have problems finding what keycode is supposed to be assigned 
> to have a key act as the corresponding "Microsoft-compatible" 
> keyboard.
> 
> My thoughts are that, even without an event driver interface 
> for X, it is possible to use the present model provided that 
> the emulated rawmode provides the widest possible set of 
> features provided by the union of 'all' available keyboards. 
> With a (possibly documented) set of keycodes that needs to be 
> assigned to get this or that function.

The emulated rawmode unfortunately cannot cover every keyboard out
there, because of the limitations of the PS/2 protocol, which only can
transfer about 240 different scancodes.

The event interface of course doesn't have this limitation.

> With my limited knowledge (i.e. by what I see looking at the 
> source files and include headers) I see the kernel lacking in 
> two fields:
> 
> * X allows for the shift, ctrl, alt, meta, super, hyper (left 
> and right) modifiers. In the kernel headers I only see 
> references to shift ctrl and alt. (Actually X also has a wild 
> bunch of other modifiers for group shift, composition etc.)

The kernel input layer doesn't treat modifiers as special keys, and
currently (include/linux/input.h) has shift, alt, ctrl and meta keys.
Both left and right.  This covers all keyboards I've seen so far,
including SGI, Sun, Mac, and other keyboards.

This is different from the X keysym modifiers, because the super and
hyper modifiers usually don't correspond to real physical keys on the
keyboard.

> * No (documented) set of keycodes to assign to get mapped to 
> multimedia/internet keys (volume up/down, play, stop, next, 
> prev, email, internet, blah blah blah)

include/linux/input.h has the documented set of keycodes. It's largely
based on what 2.4 uses for keycodes - sanitized PS/2 codes.

> If we want to go the 'full emulation' way, such things must be 
> set in a standard, documented way. Which is not the case yet, 
> unless I'm just going blind.

The emulated scancodes are not documented at the moment, but you can
find out a scancode for a documented keycode by looking at
drivers/char/keyboard.c, which has a mapping table in it.

> And I noticed there was this excellent "keyfuzz" utility 
> recently released which is aimed at providing exactly this 
> feauture. But it doesn't work as expected. Not yet. Because 
> keycodes have to be assigned by trial and error and trying to 
> re-do assignments causes strange effects since scancodes start 
> shifting as well in a very strange way. Which is why at a 
> certain point (over a month now) I just gave up and patched 
> atkbd.c directly to have it work with my keyboard.

It was written for 2.4 unfortunately, and 2.6's emulated rawmode
confuses it no end.

> Setkeycodes works by trial and error. MS-compatible multimedia 
> keys scancodes are not exactly well-documented, not anywhere I 
> can see. Also, does MS-compatible mutlimedia scancodes emulate 
> the whole set of keys some ridiculous humongous keys provide?

Not really. There is a method that's almost straightforward. Press the
key, type 'dmesg', and you'll see two lines suggesting the setkeycodes
command. There you get the first parameter - scancode. Then you look up
the key in include/linux/input.h, and there you find the keycode.

And then you use the command.

After that, you have the kernel acquainted with your keyboard. You can
verify with evtest (attached), that the kernel understands every key on
your keyboard correctly.

Next is X.

For X, you use showkey -s, and record the scancodes the kernel
generates. These will be the same on every machine. Then you modify xkb
to understand them.

The X step could be avoided if we had a definition file for xkb for the
kernel emulated keyboard.

> > > When the kernel will provide a complete enough HAL, we can 
> > > start talking about 'not needing a real raw mode'. *In the mean 
> > > time*, real raw mode *is* needed.
> > 
> > As Andries convinced me, it'll always be needed, if only for debugging
> > and setting up the translation tables easily (without checking the
> > kernel log).
> > 
> > I'll buy some food and start hacking at it today evening.
> 
> Thank you very much :)

It turns out it's not as easy as it seems to be. But I'll hopefully have
something finished today.

> > Note that I did provide a transition capability, although it isn't a
> > perfect one. If I didn't, there would be _no_ raw mode and X wouldn't
> > work at all, which might have been better. ;)
> 
> It would have been interesting to see the reactions :)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
