Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267201AbUHIVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbUHIVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHIVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:32:51 -0400
Received: from gprs214-227.eurotel.cz ([160.218.214.227]:3456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267318AbUHIVaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:30:09 -0400
Date: Mon, 9 Aug 2004 23:29:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040809212949.GA1120@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Uh, not really. During suspend-to-disk, you would call
> 
> 	device_stop();
> 	device_save();
> 	<snapshot system>
> 	class_device_start(suspend_device);
> 	<write snapshot>
> 	class_device_stop(suspend_device);
> 	device_power_down(state);

Ok, I can live with that.

> > Semantics of dev_stop is "may not do DMA and interrupts when stopped",
> > right?
> 
> To be more precise, "device is not processing any transactions and will
> not be used to submit more to". It's up to the class to remove it from any
> queues, etc, so DMA never has a chance to begin.

Well, "no DMA" needs to be part of definition, too, because some
devices (USB) do DMA only if they have nothing to do.

> It's not too complex; it's simply that the driver core is the one
> responsible between mapping a system suspend state to the device suspend
> state, based on values that the driver knows a priori. If you push that
> responsibility down to the drivers, you require all of them to implement
> the same thing, causing code duplication, which means more
> copy-n-pasting,

...well, no, if device wants (for example) PCI state, it can call
to_pci_state() function from core. That should avoid code
duplication. OTOH if driver wants to do something more advanced, it
still can be done.

> and more of a chance to get it wrong. If we choose to do it once and right
> in the driver core, the resulting drivers become simpler, since they only
> have to respond to something that says "enter this power state, damnit"
> 
> On the other hand, if it's too complicated for you, I encourage you to
> modify the patch or create a new one that solves all of the problems in a
> simpler manner.

Well, if runtime suspend is the goal, your patch reflects that
complexity.

> > I believe different state is needed for "quiesce for atomic copy" and
> > for "we are really going down to S4 now".
> 
> There is nothing fundamentally different at the functional level - you
> don't want any devices fulfilling any request. Besides, by the time the
> system is actually ready to be placed in S4, the devices have long-since
> been stopped, and the class devices do not need another notification
> beyond "stop"

You are right, I was not reading carefully enough.

Anyway, there's still one problem:

if something like this gets merged, it will immediately break swsusp
because initially no drivers will have "stop" methods.

Passing system state down to drivers and having special "quiesce"
(as discussed in rather long thread) state has advantage of
automagicaly working on drivers that ignore u32 parameter of suspend
callback (and that's most of them). David's patches do not bring us
runtime suspend capabilities, but do not force us to go through all
the drivers, either...

You could perhaps make the code call suspend when no stop callback is
present... That should add a simple migration path... and would
probably work for me.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
