Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUHCAzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUHCAzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUHCAzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:55:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:21658 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264750AbUHCAxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:53:32 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408020940.14300.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200407310723.12137.david-b@pacbell.net> <1091308167.7396.31.camel@gaston>
	 <200408020940.14300.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091494202.7395.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:50:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 02:40, David Brownell wrote:

> The PCI power state is rather fundamental to what PCI suspend()
> does!  Even if you want to redefine the "u32 state" parameter
> to be something that's first got to be mapped _into_ a PCI
> power state before calling pci_set_power_state().

no no no

you ask a driver to quiesce, it's the driver's policy to decide what is
the best suitable HW state based on what system state we are going into
(or what is asked by userland, that is quiesce, shutdown, or whatever
semantics we'll provide once we clanup the sysfs side of things).

only the driver knows what the chip can do and if it can wake it up
from d3 cold at all... though there's always the problem of knowing what
the motherboard will do on system suspend, but that I didn't find a
proper way to represent yet.

> > Besides, the difference between PCI D3 hot and D3 cold 
> > is dependent on what happens on the mobo after the chip gets
> > set to D3...

> Except then you've deprived the driver up-front of the knowledge
> that this device will be fully powered off (D3cold) ... which is what
> you were saying (wrongly IMO) could only be provided by passing
> a _system_ power state into a _device_ suspend call.  The API is there,
> but there's some confusion about what it means ... affecting the
> drivers that can suspend() to states other than D3hot.

But we don't know that at upper level neither. If you read old mailing
list threads, I was actually advocating passing 2 parameters to drivers,
one is what will "happen" to the device (be powered down for example, or
just be unclocked, or nothing) and one be the system state we are
entering. That was rejected back then. At this point, only the platform
code may have a clue about what will be happening.

> > > These look to me like "wrong device-level suspend state" cases.
> > 
> > No. The driver interface provide a semantic that indicates in what
> > state the system is going to, it's driver policy to translate that into
> > appropriate actions,
> 
> How does your answer change when you go down the path I was
> describing:  the drivers are passed a device-specific state?  Which for
> PCI means no API changes; the drivers already expect to see
> the PCI state number.

Change ? How so ? I always said the same thing... and no, that is NOT a
PCI state number, since that does NOT map to system states, (and I also
think it's not a good idea to have the parameters to suspend() be
different for different bus types anyway).

> > > > USB is another example. Typically, suspend-to-RAM wants to do a bus
> > > > suspend, eventually enabling remote wakeup on some devices, and expects
> > > > to recover the bus on wakeup, while suspend-to-disk is roughtly
> > > > equivalent to a full shutdown & reconnect on wakeup.
> > > 
> > > Same thing:  an HCD could do the right thing if it was told to go
> > > into D1, D2, or D3hot (supports USB suspend) vs D3cold (doesn't).
> > 
> > And your whole PM code would suddently become PCI specific ...
> 
> Nope -- only the PCI drivers.  After all, they already have PCI-specific
> PM rules they need to follow.  

At the driver level, not at the upper level.
> 
> > > Though the PM core doesn't cooperate at all there.  Neither the
> > > suspend nor the resume codepaths cope well with disconnect
> > > (and hence device removal), the PM core self-deadlocks since
> > > suspend/resume outcalls are done while holding the semaphore
> > > that device_pm_remove() needs, ugh.
> > 
> > That's an old problem, I don't know how to fix this one best in USB,
> > I've always had problem with the whole PM semaphore for that reasons
> > among others but I'll let Greg & Patrick find a solution there.
> 
> Patrick once posted a patch that morphed the semaphore into a
> spinlock (in at least some cases), which worked for me, but that
> never got merged.

Patrick ? Do you still have that around ?

> If you're still using the device for swap, isn't a user error to suspend
> the device? 

But you don't _know_ unless you are sure you don't have any file mapped
on it whatsoever, no executable running from it, and if you do, your
userland error suddenly stuck the kernel with unkillable processes stuck
in page fault...

>  Drivers could certainly have self-resume modes ,and
> should use them if they  self-suspend.  But I'd expect a default policy
> more like "suspend all idle devices", and anything mounted (for
> swap, root fs, etc) wouldn't be idle unless there was a self-suspend
> mechanism in some driver layer.  (IDE? SCSI? Block? PCI? USB?)

Low level drivers, at this point, don't really know if they are in use
in some cases, do they ? But anyway, to get userland originated suspend
to possibly do anything useful, we first need to fix sysfs so that it
does partial tree suspend and not individual deviecs suspend only.
There's also a semantic breakage between who updates the power state in
struct device, system suspend relies on the driver doing so afaik, while
sysfs originated calls to the driver suspend will do it in sysfs (which
I think is the wrong thing to do).

> Actually no; I was describing what would be an ACPI G0/S0 state
> where most devices/drivers are powered down, not the G1/S1 state
> described as "suspend".   CPU would be running, for example.  It's
> a power management policy, not a suspend policy ... it kicks in
> during normal operation.

And who wakes up the devices in this ACPI state ? (just curious)
> 
> > There's also one thing we haven't dealt with is since queues are blocked
> > etc..., there need to be some explicit action waking things up. We don't
> > yet have provisions for devices themselves to trigger wakeup,
> 
> The PCI API certainly has hooks, and some network drivers try to
> use the Wake-on-LAN capabilities.  So presumably they work in
> at least some configurations.

Yes, but it's not something we have abstracted in any useful way (nor I
think we should try to at this point)
> 
> > either of 
> > the whole tree, or themselves individually, based on activity. things like
> > USB remote wakeup usually hook through the firmware/motherboard to trigger
> > the system wakeup, but all of this is useless for such a standby state
> > where we actually want a pending request to the disk, for example, to
> > wakeup the whole subsystem.
> 
> That's the difference between wakeup (== external event trigger,
> flipper meets keyboard) and resume (== internal event trigger,
> request meets queue).  There's a lot of common code in the
> resume() path ... the wakeup "IRQ" just needs to arrange for
> something to call resume().

Note that there's the same problem here than what we have with sysfs
originated suspend/resume, we need to resume more than one device, but a
whole branch of the PM tree.

Ben.


