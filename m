Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUE2NPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUE2NPR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUE2NPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:15:17 -0400
Received: from main.gmane.org ([80.91.224.249]:45495 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264737AbUE2NO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:14:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sat, 29 May 2004 15:14:42 +0200
Message-ID: <MPG.1b22ab00a1ccd0799896a3@news.gmane.org>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-243-130.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Regarding the raw interface to the AUX (and possibly also KBD)
> interfaces, I'm not opposed to that, however, I don't see an easy way to
> add it that would be able to coexist with the other drivers.
> 
> Eg. one cannot load both the 'psmouse' and the raw 'psaux' modules, as
> the access to the serio port is exclusive. So far I don't very much like
> the fact that one would have to unload the psmouse module to get raw
> access to the port.

The answer could be to the raw mode emulation of the current 
aux and kbd modules. The best thing would be to let the raw 
codes just bleed through the layers, together with the 
translated ones, and then letting the input event choose which 
one to pass on to the application depending on whether the 
application requested raw access or not. I don't know if this 
would work with AUX, but it would be the best solution for the 
keyboard driver.

In the specific case of the keyboard module, the biggest 
problem (I don't know if it's a bug or WAD) is that some raw 
scancodes don't get emulated correctly *unless* very specific 
keycodes are assigned to it. I have seen this happen with the 
multimedia keys on my keyboard, which do not have any keycode 
assigned by default. Basically what happens is that a key with 
scancode xx, assigned a keycode of yy might return a scancode 
of zz != xx. See for example Chris Osicki's post.

What happens is basically that the 'raw emulation' table is 
*not* updated by changes in the keycode assignments. I don't 
know if this is a bug in setkeycodes, a bug in the kernel 
modules, or some kind of misinteraction between the two.

Considering that in case of multiple keyboards one *should* 
have multiple raw emulation tables (one for each keyboard), I 
really think that it would be more troubles than anything to 
keep and maintain this 'raw emulation' method, which is why I 
suggest a 'bleed through' of raw codes, to be passed on when 
application request them.

At least in theory this shouldn't be much of a problem: just 
adding a parameter to the interface between the input events 
modules and the lower level modules.

> Regarding GPM and duplication of work between it and the kernel - as far
> as I know, GPM development isn't going forward very much, and there is a
> bunch of things it doesn't (and likely won't) support - like the
> passthrough port on synaptics touchpads.
> 
> So, yes, I'd eventually like (and will accept patches) the kernel to be
> able to use every mouse (or other device) GPM supports. I believe we're
> pretty near already, except for a few rather obscure ones.
> 
> BUT, we still will need GPM, because something needs to do screen
> copy-and-paste. And GPM will need to be able to implement touchpad
> functionality (taps, edge scrolling, etc) from absolute pad data, like
> the X synaptics driver does.
> 
> That's about it. I'd be happy to merge the raw access driver, if there
> is a real need for it, and if it can be made to work together with the
> other PS/2 kernel drivers.
> 
> One more thought: The emulated PS/2 mouse so many people are complaining
> about is there only because applications like X cannot use the native
> event interface. It was intended to be removed after that support is
> added, but with X development being as slow as it is, it didn't ever
> happen.

WRT this, would it be possible to create a GPM driver for the 
event interface? This way, once kernel support for all the GPM-
supported mice is complete, we would have the three-layered:

kernel | gpm | app

stream, which IIRC should work even with X, since X can read 
the gpm socket ...

BTW, what degree of support do we have for non-Synaptics 
touchpads, in particular ALPS?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

