Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUGaVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUGaVLn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUGaVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:11:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:29323 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264251AbUGaVLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:11:31 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200407310723.12137.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200407302102.12554.david-b@pacbell.net> <1091252962.7387.14.camel@gaston>
	 <200407310723.12137.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091308167.7396.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 07:09:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 00:23, David Brownell wrote:

> So suspend-to-RAM more or less matches PCI D3hot, and
> suspend-to-DISK matches PCI D3cold.  If those power states
> were passed to the device suspend(), the disk driver could act
> appropriately.  In my observation, D3cold was never passed
> down, it was always D3hot.

Not really, they really have nothing to do with the PCI state
at all. Besides, the difference between PCI D3 hot and D3 cold
is dependent on what happens on the mobo after the chip gets
set to D3...

> These look to me like "wrong device-level suspend state" cases.

No. The driver interface provide a semantic that indicates in what
state the system is going to, it's driver policy to translate that into
appropriate actions, eventually involving some bus power state (or not,
for some archs, we'll haev no choice but have some driver level arch
hacks in there anyway, like some macs wanting video chips to be in D2
state etc...)

> > USB is another example. Typically, suspend-to-RAM wants to do a bus
> > suspend, eventually enabling remote wakeup on some devices, and expects
> > to recover the bus on wakeup, while suspend-to-disk is roughtly
> > equivalent to a full shutdown & reconnect on wakeup.
> 
> Same thing:  an HCD could do the right thing if it was told to go
> into D1, D2, or D3hot (supports USB suspend) vs D3cold (doesn't).

And your whole PM code would suddently become PCI specific ...

> Though the PM core doesn't cooperate at all there.  Neither the
> suspend nor the resume codepaths cope well with disconnect
> (and hence device removal), the PM core self-deadlocks since
> suspend/resume outcalls are done while holding the semaphore
> that device_pm_remove() needs, ugh.

That's an old problem, I don't know how to fix this one best in USB,
I've always had problem with the whole PM semaphore for that reasons
among others but I'll let Greg & Patrick find a solution there.

> And FWIW Greg's now merged the CONFIG_USB_SUSPEND code
> into his tree, as experimental ... so now all the relevant integration
> issues can start to get sorted out.  Eventually, that PM core deadlock
> can get fixed.  And remote wakeup needs work ... x86 machines need
> a way to tell ACPI to pay attention to PME# wakeups (which Len says
> is in some recent ACPI patch), and maybe the PPC/Mac platforms
> will need something similar.
> 
>  
> > > The problem I'm clear on is with PCI suspend, which some
> > > earlier driver model PM changes goofed up.  It's trying to
> > > pass a system state to driver suspend() methods that are
> > > expecting a value appropriate for pci_set_power_state().
> > > You're proposing to fix that by changing the call semantics,
> > > while I'd rather just see the call site fixed.
> > 
> > No, I don't agree. It's a driver policy to decide what PCI state
> > to use based on the system suspend level.
> 
> You've not persuaded me on that point at all ...
> 
> Consider:  device PM calls  aren't only made as part of changing
> a "system suspend level".  Minimally, there's the ability to suspend
> a single device through sysfs.  And in general, we need to be able
> to do that directly ... one device suspending **must** be able to
> trigger another one suspending, without assuming that every
> device on the system is suspending to the same state.
> 
> As for example, suspending a USB flash storage device must
> be able to suspend its subsidiary storage and block devices,
> without necessarily suspending the network link on an adjacent
> hub port.  Or a USB port on a camera (or cell phone) that must
> act as either host or peripheral (USB OTG) ... at most one of those
> controllers should be active at a time.

And who resumes it ? Or you just lockup as soon as your VM try to
swap in from the flash ? If it self-wakes up then it's driver internal
policy. Again, the PM interface exposed to the kernel and userland has,
imho, nothing to do with the actualy low level bus states.

> Consider a system PM policy including "suspend all idle devices".
> With N devices supporting only "on" and "suspend" states, that's
> something like 2^N system suspend levels.  Or more; most
> devices support more than two suspend states (add at least
> "off", plus often light weight suspend states).  And N is system-specific,
> so there's no way all those system states can be given small
> integer values ... much less fit into a "u32 state".

And ? that's not the point. "standby" is defined as a kernel PM state
that could be used to implement that. It's per-driver policy to decide
how to react to "standby" of the HW can only do on/off (which usually
turns into go to "off" if the transition back to "on" is fast, or do
nothing if not).

There's also one thing we haven't dealt with is since queues are blocked
etc..., there need to be some explicit action waking things up. We don't
yet have provisions for devices themselves to trigger wakeup, either of
the whole tree, or themselves individually, based on activity. things like
USB remote wakeup usually hook through the firmware/motherboard to trigger
the system wakeup, but all of this is useless for such a standby state
where we actually want a pending request to the disk, for example, to
wakeup the whole subsystem.

Ben.


