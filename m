Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135765AbRDTATz>; Thu, 19 Apr 2001 20:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135767AbRDTATi>; Thu, 19 Apr 2001 20:19:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33808 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135765AbRDTATP>; Thu, 19 Apr 2001 20:19:15 -0400
Date: Thu, 19 Apr 2001 17:05:49 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-devel@lists.sourceforge.net,
        linux-power@phobos.fachschaften.tu-muenchen.de
Subject: Re: PCI power management
In-Reply-To: <19031231222908.21882@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10104191607280.7690-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  - There need to be some arch "hooks" in this mecanism. Some machines
> have the ability (from the arch specific code, by tweaking ASIC bits)
> to remove clock and/or power from selected devices. That mean power
> management can be done even with devices not supporting PCI PM provided
> that the driver can recover them from a PowerOn reset.

All devices should handle having power removed from them. And, all of the
drivers should as well, since that is the only way we're going to get
power management out of legacy devices and other things on the board. This
involves saving the current context on suspend, and reinitializing the
device, and restoring the context as much as possible when we resume. It
should behave almost identically to the boot-time init code.

>  - Some devices just can't be brought back to life from D3 state without
> a PCI reset (ATI Rage M3 for example) and that require some arch specific
> support (when it's possible at all).

When a device comes out of D3[hot], the equivalent of a soft reset is
performed. From D3[cold], PCI RST# is asserted, and the device must be
completely reinitialized.

>  - The current scheme provide no way for the kernel to "know" if a
> driver can handle recovering the device from a PowerOn reset. Some
> drivers can, some can't (the video drivers usually can't as they
> require the board's PLL to be properly setup by the BIOS). Some
> advanced PM modes we use on pmacs will cause the motherboard ASIC to
> turn off power to PCI & AGP cards when putting the machine to sleep.
> We need a way to prevent/allow this "deep sleep" mode depending
> on what the card supports.

It's not about what the device supports, it's about what the driver
supports. STR and STD imply that all devices will lose power. The drivers
are responsible for reinitializing the devices, regardless of what that
may involve. 

>  - Ordering of power management may matter. On PowerBooks, we run
> through all notifiers first with a "sleep request" message. None of
> the drivers will actually put anything to sleep at this point, but
> they will allocate all the memory the might need for doing so (saving
> state, saving a framebuffer in some cases, etc...). Once all devices
> have accepted the request (they can refuse it), I then send a 
> "sleep now" message. This way, I can make sure all memory allocations
> have been performed and disks properly sync'ed before putting the swap
> devices to sleep and such things. 

Hmm. How about doing two walks of the device tree - the first calls a
save_state() function for each device, which gives it the opportunity to
allocate memory and save appropriate registers, etc. The second actually
places the device in a low power state.  

This could give the kernel the chance to disable swap, or for the action 
to be cancelled before anything is actually put to sleep.

>  - On SMP, we need some way to stop other CPUs in the scheduler
> while running the last round of sleep (putting devices to sleep) at least
> until all IO layers in Linux can properly handle blocking of IO queues
> while the device sleeps.

Ugh. SMP. Not yet.

>  - We need a generic (non-x86 APM or ACPI dependant) way of including
> userland process that request it in the loop. Some userland process
> that bang hardware directly (X, but not only X) need to be properly
> suspended (and the kernel has to wait for ack from them before continuing
> with devices sleep).

Hmm. Like init?

> Yup. They should also be able to return an error (fail or just limit
> to a higher level like D2). They should also be able to tell the kernel
> if they support recovering from a power down.

Another sleep level is not acceptable when entering a system sleep state,
except for S2, but I've never seen a system that supports that. Power will
be cut to all devices, and there is no getting around it. If the driver
can't support reinitializing the device, it should return an error and the
sleep request be cancelled.

The PCI PM Capabilities can be read from a device's config space. The PCI
PM Spec has register descriptions. There are also #defines for the fields
in pci.h. So a driver can know exactly what is expected of it.

> >It is up to the drivers to implement ::suspend() and ::resume(), and few
> >do.  The few that do, even fewer work well in practice.
> 
> I would have preferred that a PM node be created for each PCI node and
> have the PM nodes organised as a tree structure. That way, arch fixup
> hooks can re-arrange the tree as the PCI bus->child dependency may not
> be true. On some portables, some ASICs located on the PCI bus are not
> dependent on their parent host bridge power plane.

I favor the idea of having a tree view of _all_ devices in the system, but
that's another story, and something I discussed in a post to the
linux-power list.

The PCI bus-child dependency and ordering should always be true, AFAIK.
Some PCI functions may have another source of power, but should only be
to support the generation of wake events when the device is in D3[cold] -
it must maintain some of its capability state.

> Right. And we need a equivalent power down function. For example, some
> drivers may improve power management by powering down the device when
> it's /dev node is not opened (or when the device have been idle for some
> time). However, those power up/down functions have to be arch-dependant,
> you can't rely on the PCI power management to be the only PM scheme.

Possibly a better term is bus-dependent? 

> >2) AFAICT, it is safe to turn off a PCI device's bus-mastering bit and
> >take the device to D3, if it exports the PCI PM capability.  My
> >previously-submitted pci_disable_function function turns off the
> >bus-mastering bit, and should probably take the device to D3 too.
> 
> No, D3 is not safe on all devices. However, if pci_disable_function() is
> under driver control, then the driver may decide not to call it. In some
> case, D2 is the only acceptable mode. In other cases, the device doesn't
> support PM but the motherboard has ways to shut the clock down or the
> power supply.

How is D3 not safe on all devices? You mean to tell me that I cannot turn
my workstation off because it is not safe to cut power to some device?
Every device supports that state. When placing the system in a sleep
state, you have no choice. D0-D2 are not an option. It's the _driver_ that
has problems and must be fixed if it can't recover from D3. 

> I beleive it's up to each driver to handle that. Maybe some "framework"
> for this can be provided with the generic PM nodes...

You mean a ... policy? 

Yes, it is definitely needed, and should be able to be genericized for all
PM schemes and all types (buses).

> Indeed, but those are in the arch side. We definitely to have a way
> for the arch to hook deeply into the sleep process. There can be some
> weird dependencies going on on portable motherboards or embedded
> devices, like an ethernet device beeing also used to provide reset
> signals to another PCI device, etc...

It is the responsibility of the PM layer to ensure that this doesn't
happen. This is not the fault of the device or the driver, but must be
disabled.

> That's why I prefer the idea of having the PM nodes in a tree and
> a node for each PCI device. The arch would then "hook" on the
> pci_register_pm_node() or whatever we call it and have the ability
> to move the node elsewhere in the tree depending on motherboard
> details.

I don't understand why you would want to change the parent of a device. A
device will always sit behind a bridge, logically if nothing else. It
should adhere to the semantics to the bus on which it resides. This could
just be fanciful idealism, but damn it, it makes sense.

Though, I can see the need for a driver to have multiple nodes in the
device tree. If it were a PCI card, it would have one that was a child of
the root PCI bus. But it could also implement some logical ACPI object,
such as a wake-enabled device, in which case another node would be a child
of the root bus. Maybe.

> So busses like USB, FireWire, etc... need a similar "tree" architecture. I
> strongly beleive generalizing the PM node is the way to go. Beeing
> a "notifier" like mecanism, it allows to add specific messages if needed
> (for example, USB bus suspend is different than machine sleep, that could
> be an additional PM message sent by the host controller to USB drivers,
> etc...)

What about considering just the USB root host or Firewire equivalent as
nodes in the tree. When they are put to sleep, they handle walking the
device scheme that lies behind them, much in the same manner that PCI does
it now. This way, a bus-specific implementation could be achieved,
depending on what is needed.

There are a couple of things that I wanted to respond to. First, it is
evident that a PM scheme must be implemented for the bridges. They support
various power states, as well as have state that must be preserved across
suspend. 

A tree view of the all the devices in the system is needed to support
proper ordering when suspending and resuming. At the moment, it's not
necessary to modify anything to obtain, at least for PCI. PCI handles
walking its own device tree, which is not a bad model for the rest of
the buses present on the system.

But, I also can see a benefit in a two-stage approach, where a call is
made to save the state of each device, then another is called to put the
device to sleep. In this case, a complete tree view almost seems
necessary. Or at least like we would only have to implement the interface
once, instead of n times.

	-pat

p.s. Every device supports D3. It must. The drivers must be fixed to do so
as well. It's absolutely necessary in order to support system sleep
states.

