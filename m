Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUHBQpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUHBQpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266617AbUHBQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:45:38 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:17341 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S266615AbUHBQpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:45:03 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Solving suspend-level confusion
Date: Mon, 2 Aug 2004 09:40:14 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200407310723.12137.david-b@pacbell.net> <1091308167.7396.31.camel@gaston>
In-Reply-To: <1091308167.7396.31.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408020940.14300.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 14:09, Benjamin Herrenschmidt wrote:
> On Sun, 2004-08-01 at 00:23, David Brownell wrote:
> 
> > So suspend-to-RAM more or less matches PCI D3hot, and
> > suspend-to-DISK matches PCI D3cold.  If those power states
> > were passed to the device suspend(), the disk driver could act
> > appropriately.  In my observation, D3cold was never passed
> > down, it was always D3hot.
> 
> Not really, they really have nothing to do with the PCI state
> at all.

The PCI power state is rather fundamental to what PCI suspend()
does!  Even if you want to redefine the "u32 state" parameter
to be something that's first got to be mapped _into_ a PCI
power state before calling pci_set_power_state().


> Besides, the difference between PCI D3 hot and D3 cold 
> is dependent on what happens on the mobo after the chip gets
> set to D3...

Except then you've deprived the driver up-front of the knowledge
that this device will be fully powered off (D3cold) ... which is what
you were saying (wrongly IMO) could only be provided by passing
a _system_ power state into a _device_ suspend call.  The API is there,
but there's some confusion about what it means ... affecting the
drivers that can suspend() to states other than D3hot.


> > These look to me like "wrong device-level suspend state" cases.
> 
> No. The driver interface provide a semantic that indicates in what
> state the system is going to, it's driver policy to translate that into
> appropriate actions,

How does your answer change when you go down the path I was
describing:  the drivers are passed a device-specific state?  Which for
PCI means no API changes; the drivers already expect to see
the PCI state number.


> > > USB is another example. Typically, suspend-to-RAM wants to do a bus
> > > suspend, eventually enabling remote wakeup on some devices, and expects
> > > to recover the bus on wakeup, while suspend-to-disk is roughtly
> > > equivalent to a full shutdown & reconnect on wakeup.
> > 
> > Same thing:  an HCD could do the right thing if it was told to go
> > into D1, D2, or D3hot (supports USB suspend) vs D3cold (doesn't).
> 
> And your whole PM code would suddently become PCI specific ...

Nope -- only the PCI drivers.  After all, they already have PCI-specific
PM rules they need to follow.  


> > Though the PM core doesn't cooperate at all there.  Neither the
> > suspend nor the resume codepaths cope well with disconnect
> > (and hence device removal), the PM core self-deadlocks since
> > suspend/resume outcalls are done while holding the semaphore
> > that device_pm_remove() needs, ugh.
> 
> That's an old problem, I don't know how to fix this one best in USB,
> I've always had problem with the whole PM semaphore for that reasons
> among others but I'll let Greg & Patrick find a solution there.

Patrick once posted a patch that morphed the semaphore into a
spinlock (in at least some cases), which worked for me, but that
never got merged.


> > > No, I don't agree. It's a driver policy to decide what PCI state
> > > to use based on the system suspend level.
> > 
> > You've not persuaded me on that point at all ...
> > 
> > Consider:  device PM calls  aren't only made as part of changing
> > a "system suspend level".  ...
> 
> And who resumes it ? Or you just lockup as soon as your VM try to
> swap in from the flash ? If it self-wakes up then it's driver internal
> policy. Again, the PM interface exposed to the kernel and userland has,
> imho, nothing to do with the actualy low level bus states.

If you're still using the device for swap, isn't a user error to suspend
the device?  Drivers could certainly have self-resume modes ,and
should use them if they  self-suspend.  But I'd expect a default policy
more like "suspend all idle devices", and anything mounted (for
swap, root fs, etc) wouldn't be idle unless there was a self-suspend
mechanism in some driver layer.  (IDE? SCSI? Block? PCI? USB?)


> > Consider a system PM policy including "suspend all idle devices".
> > With N devices supporting only "on" and "suspend" states, that's
> > something like 2^N system suspend levels.  Or more; most
> > devices support more than two suspend states (add at least
> > "off", plus often light weight suspend states).  And N is system-specific,
> > so there's no way all those system states can be given small
> > integer values ... much less fit into a "u32 state".
> 
> And ? that's not the point. "standby" is defined as a kernel PM state
> that could be used to implement that. It's per-driver policy to decide
> how to react to "standby" of the HW can only do on/off (which usually
> turns into go to "off" if the transition back to "on" is fast, or do
> nothing if not).

Actually no; I was describing what would be an ACPI G0/S0 state
where most devices/drivers are powered down, not the G1/S1 state
described as "suspend".   CPU would be running, for example.  It's
a power management policy, not a suspend policy ... it kicks in
during normal operation.


> There's also one thing we haven't dealt with is since queues are blocked
> etc..., there need to be some explicit action waking things up. We don't
> yet have provisions for devices themselves to trigger wakeup,

The PCI API certainly has hooks, and some network drivers try to
use the Wake-on-LAN capabilities.  So presumably they work in
at least some configurations.


> either of 
> the whole tree, or themselves individually, based on activity. things like
> USB remote wakeup usually hook through the firmware/motherboard to trigger
> the system wakeup, but all of this is useless for such a standby state
> where we actually want a pending request to the disk, for example, to
> wakeup the whole subsystem.

That's the difference between wakeup (== external event trigger,
flipper meets keyboard) and resume (== internal event trigger,
request meets queue).  There's a lot of common code in the
resume() path ... the wakeup "IRQ" just needs to arrange for
something to call resume().

- Dave
