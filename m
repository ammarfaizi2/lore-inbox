Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUE2Ng5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUE2Ng5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUE2Ng5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:36:57 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:29060 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264917AbUE2Ngp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:36:45 -0400
Date: Sat, 29 May 2004 15:37:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040529133704.GA6258@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b22ab00a1ccd0799896a3@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 03:14:42PM +0200, Giuseppe Bilotta wrote:

> The answer could be to the raw mode emulation of the current 
> aux and kbd modules. The best thing would be to let the raw 
> codes just bleed through the layers, together with the 
> translated ones, and then letting the input event choose which 
> one to pass on to the application depending on whether the 
> application requested raw access or not. I don't know if this 
> would work with AUX, but it would be the best solution for the 
> keyboard driver.

With AUX it's indeed tough, since you cannot share the port for the
simple reason that you don't just listen, but also talk to the mouse.
This has led to lots of problems in the past, and the invention of
repeater mode in GPM.

With keyboard, it's doable, if the application would keep using IOCTLs
to set the LEDs. But I don't see the point of doing that. Actually, I
have a few point why NOT to do it:

1) USB keyboards don't have scancodes per se. And if you take HUT codes
as scancodes, they'd be completely different and wouldn't work with any
application. Thus there is nothing to pass on in that case.

2) Application has no bussiness knowing the raw scancodes. It should be
interested in keycodes if anything. The scancode emulation is there just
for backward compatibility, and I hope one day I'll be able to remove
it.

3) If I'd add the raw scancode passing through the input system, nobody
would fix X and friends to stop using rawmode. Ever.

> In the specific case of the keyboard module, the biggest 
> problem (I don't know if it's a bug or WAD) is that some raw 
> scancodes don't get emulated correctly *unless* very specific 
> keycodes are assigned to it. I have seen this happen with the 
> multimedia keys on my keyboard, which do not have any keycode 
> assigned by default. Basically what happens is that a key with 
> scancode xx, assigned a keycode of yy might return a scancode 
> of zz != xx. See for example Chris Osicki's post.

Yes. This is because there is a direct 1:1 mapping of keycode->scancode
in the emulation. The kernel always presents a "Linux keyboard" to
applications which insist on seeing rawmode. This "Linux keyboard" is
the same on all platforms (except mac), and thus it'd be enough to teach
X about this single "Linux keyboard", and noone would ever need to
change the xkb tables again. It's not been done yet, though.

So: If you have X configured to understand Linux scancodes (or someone
fixes it to use keycodes - the so called medium raw mode), then when you
exchange your keyboard, just a few setkeycode statements will tell the
kernel about it, and X will keep working without noticing anything.

> What happens is basically that the 'raw emulation' table is 
> *not* updated by changes in the keycode assignments. I don't 
> know if this is a bug in setkeycodes, a bug in the kernel 
> modules, or some kind of misinteraction between the two.

This is intentional. The table is static. It's purpose is not to return
the original raw codes (which in the USB case don't exist at all), but
to create some that make sense, and are always the same, for a certain
key.

> Considering that in case of multiple keyboards one *should* 
> have multiple raw emulation tables (one for each keyboard), I 
> really think that it would be more troubles than anything to 
> keep and maintain this 'raw emulation' method, which is why I 
> suggest a 'bleed through' of raw codes, to be passed on when 
> application request them.

Why would you want to have several different rawmodes bleed to
userspace? They'd be mixed together at the console, and would just be a
complete mess.

> > One more thought: The emulated PS/2 mouse so many people are complaining
> > about is there only because applications like X cannot use the native
> > event interface. It was intended to be removed after that support is
> > added, but with X development being as slow as it is, it didn't ever
> > happen.
> 
> WRT this, would it be possible to create a GPM driver for the 
> event interface?

Yes. Even better, it exists. And I though it's been integrated into GPM
as well, but I might be wrong on this one.

> This way, once kernel support for all the GPM-
> supported mice is complete, we would have the three-layered:
> 
> kernel | gpm | app

No, this isn't needed.

> stream, which IIRC should work even with X, since X can read 
> the gpm socket ...

Because it's easily possible to create a driver for X that will read the
event interface, too, for _both_ keyboard and mouse.

It's then

kernel ---- gpm
       `--- X -- app

> BTW, what degree of support do we have for non-Synaptics 
> touchpads, in particular ALPS?
 
ALPS support is in my patch queue, but there are some problems with it
(like that ALPS touchpads cannot be autodetected).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
