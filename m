Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTDNJrG (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDNJrF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:47:05 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:23250 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S262931AbTDNJrA (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 05:47:00 -0400
Subject: Subtle semantic issue with sleep callbacks in drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050314423.5574.65.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2003 12:00:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick !

While implementing power management of PowerBooks based on
the new model (while porting my drivers at the same time), I
found a couple of problems that could be solved by better defining
the values of the "state" parameter passed to drivers. Or maybe it
is already, in which case, let me know :)

Basically, the driver need to know what kind of support is provided
by the motherboard for wake up and what will happen to the chip. The
typical example is the radeon driver which shows all cases:

- On mac laptops, the AGP slot is unclocked. That means the driver
has to go to D2 (for which I have full code from ATI). That is
independant from other things on the motherboard, some things are
powerd off, but not the AGP slot, so I need a way to affect the
"state" parameter on a per-slot basis.

- On non-laptops, the AGP slot is powered off. So I beleive I
basically need to tell the driver to go to D3 (or basically prepare
to re-POST the card on wakeup).
However, we can't do that. We don't have enough infos from ATI to
be able to do it right now, which is why I don't support suspend-to-RAM
on non-laptops pmacs. So here, the driver should fail the suspend
request if it's told, via the "state" parameter that the chip will be
powered off by the system

- On non-PPC machines, the slot will eventually go to D3, but the APM
BIOS or ACPI will be able to re-POST the card properly on wakeup, so the
driver only needs to restore the current display mode, at least I guess
so since I don't know much about x86's. Similar will happen once I have
an OF emulator ready on PPC to re-POST some cards, thus changing the
previous example into this one. In this case, the driver can put the
chip to D3 and can _accept_ the sleep request because it's explicitely
told by the system (how ?) that the card will be re-POSTED prior to the
resume() callback.

- On any machine, with suspend to disk, the slot is powered off (along
with the entire host machine). But the machine will be rebooted and the
device put back to "idle" state some way by the loader kernel, so this
ends up a bit like the above case.


So basically, the "state" parameter should encore not only what state
we want to go to, but rather, what will happen to the slot:

- Nothing (it's entirely up to the driver to do it's own power
management, that happens for some devices inside Apple ASIC), though in
this case at least, those driver have control over the chip power, reset
lines, etc...
- Slot will be unclocked (it's up to the driver, it the chip supports
static mode, to go to D2 or D3 if the driver can deal with it, though
the system will do nothing to help the driver)
- Slot will be powered off. This case should be broken up (via an
additional flag passed to the driver ?) into 1) the system _will_
re-POST the card before resume (BIOS/ACPI support, swsusp) or the
system will NOT re-POST the card, the driver shall fail the sleep
request if it can't do it by itself.
 - Embedded people may have even more weird cases ?

Any comments ?

I also noticed the IDE PM code is hopeless, I'll try to hack something
that works at least as good than what I had in the pmac 2.4 code, and
the fbdev PM code is almost unexisting (I need at least a way for the
driver to tell the PM layer not to mess with the framebuffer once the
driver is asleep). I'll hack something as well.

Regards
Ben.
 
