Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135748AbRDSXEe>; Thu, 19 Apr 2001 19:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135750AbRDSXEZ>; Thu, 19 Apr 2001 19:04:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38925 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135748AbRDSXEU>; Thu, 19 Apr 2001 19:04:20 -0400
Date: Thu, 19 Apr 2001 16:03:49 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI power management
In-Reply-To: <3ADEA108.50BB415D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10104191510540.7690-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> pci_enable_device (1) enables IO and mem decoding, (2) assigns/routes
> the PCI IRQ, and (3) brings the device to D0 using pci_set_power_state. 
> Linus believes the power state transition should occur before (1) and
> (2), and I agree.

Yes, that's correct. The device should have power before it obtains any
resources. And, when coming back from suspend, obtaining those values
requires simply plugging the values in struct pci_dev in.

> pci_set_power_state brings a device to a new D state.  If the D state
> transition is D3->D0, then we (1) save key PCI config registers, (2) go
> to D0, and (3) restore saved PCI config registers.  This originally
> comes from Donald Becker's acpi_wake function, which is used only for
> the case of device enabling (where he had no problems), not for the case
> of returning-from-suspend (where we see problems).

That is bad. There are two D3 states - D3[cold] and D3[hot]. The former is
supported by all devices by default - it is when Vcc has been cut to the
device. The latter is supported by most modern PCI devices, I think. Under
this state, software access to the register space will work correctly.
This may work on power up or coming back from suspend for some wacky
reason, but it shouldn't. Both STR and STD cut power to the PCI bus, so we
shouldn't get anything coherent by reading from the config space.

Is it possible that it works on boot because of any initialization that
the BIOS has done to PCI?

> >  * We do not touch devices that don't have a driver that exports
> >  * a suspend/resume function. That is just too dangerous. If the default
> >  * PCI suspend/resume functions work for a device, the driver can
> >  * easily implement them (ie just have a suspend function that calls
> >  * the pci_set_power_state() function).

So what happens to devices that don't implement those functions when we
resume? Are they completely reinitialized? If so, you could just be rude
about it and cut power to them, which is essentially what the BIOS is
doing anyway. 

Seriously, though, all drivers should implement those functions. 

> That's the current state of things.  I do not think the system -- at the
> PCI core level -- is poorly designed.  I think it just takes a lot of
> grunt work with drivers at this point, plus maybe a few new pci helper
> functions.

Yep. But there is also the case of non-PCI devices - USB, PCMCIA, system
devices attached to the motherboard, ISA deviecs. It has been mentioned
that we just create a PCI struct for each one, but it seems like overkill.
Plus that would imply a new root bus and a need for the infrastructure to
support non-PCI devices masquerading as PCI devices.

> 1) pci_enable_device needs to power up the device before enabling it.

Yes. Easy enough.

> 2) AFAICT, it is safe to turn off a PCI device's bus-mastering bit and
> take the device to D3, if it exports the PCI PM capability.  My
> previously-submitted pci_disable_function function turns off the
> bus-mastering bit, and should probably take the device to D3 too.

You must disable I/O and memory space as well as bus-mastering before
entering any suspend state. For D3, every device supports that, whether it
means just writing to the PowerState field in the Capability or just
cutting power.

> 3) The current pci_set_power_state implementation is non-spec, and even
> though it works for some cases it does not appear like the right thing
> to do.

Hmm. Maybe it should do only what it advertises - set the power state.
Leave the saving/restoring of the state to the driver. There can be a
generic function that does what pci_set_power_state wrt the state, and
leave pci_set_power_state only write the bits to the PowerState field.

> 4) Because of #2, I have create pci_power_on and pci_power_off. 
> pci_power_off saves ALL the PCI config registers, turns off
> busmastering, and goes to D3.  pci_power_on takes the device to D0, then
> blasts the stored PCI config register data back to the hardware.
> 
> 5) In testing, this works sometimes, but other times it causes the
> upstream bridge of the device being resumed to stop decoding the device.

Alright, this is where your expertise takes over. The PCI PM Spec says:

"When attempting to place a PCI function in a low power state D1-D3, it is
the operating system's responsibility to ensure that the function has no
pending (host initiated) transactions, of in the case of a bridge device,
that there are no PCI functions behind the bridge that require the bridge
to be in the fully operational D0 state." (Section 8.2, p. 66)

It also goes on to say that it must ensure that there is no peer-to-peer
transfers to the target function during sleep.

So somehow, all knowledge of the PCI function must be disavowed, and I am
pretty clueless as how to guarantee this.

> 6) One solution to #4 is to save and restore the PCI bridge registers
> too.  This comes partially from a Linus suggestion, and partially from
> an end user who solved their eepro100 suspend/resume problems with a
> setpci command to their PCI bridge (not to the eepro100 device).  In my
> own testing this solution works 100%, but (a) it might not be right, and
> thus (b) it might cause problems.  I am -very- interested in feedback on
> this solution, or a better one.
> 
> 7) Due to #5 an open issue is to re-read the bridge and PCI PM specs. 
> Some portions of the spec imply that the bridge should never be touched
> during device suspend or resume :)

The PCI PM spec has specific information wrt to bridges, but I haven't
looked at it myself.

> 8) Who can predict what a laptop's AML tables want to do with the PCI
> bus, and if Linux will be interfering with ACPI suspend, or if ACPI will
> be interfering with Linux resume, etc.

Laptops _should_ have it down pretty well, though I won't put my lunch
money on it. I would be more worried about desktop systems. One more thing
to blame on broken BIOSes...

> 9) A truly green driver should register itself then disable its
> hardware.  It is wasting power otherwise.  That implies waking up
> hardware on dev->open and sleeping on dev->release.  Some net drivers do
> this already.  This further implies problems down the road with stuff
> like char drivers, where applications often open and close the device
> node very rapidly.  This happens in OSS audio land when some audio apps
> start up, for example.  Maybe an inactivity timer would work here, to
> power down the device after time passes with no open(2) calls.

This is a little farther down the road, but yes, all devices should enter
some sleep state during inactivity. At the very least, the device could
enter D1 initially, and gradually move to D2 and D3[hot] during longer
periods of inactivity.

> 10) We might wind up needing northbridge, southbridge, and/or PCI bridge
> drivers.  They will likely be small, but I think eventually they will
> need to exist in order to provide complete power management coverage.

The only thing that they should need are the suspend/resume functions,
right? 

> 12) Continuing #11, there needs to be a general notion of when the
> system should -not- write stuff to disk.  This is mainly a userspace
> issue, ie. low-priority syslog messages should not prevent the system
> from idling the hard drive and spinning it down.  BUT..  the kernel may
> need to be the central arbiter if only to have a single place which says
> "hard drive is idle now"...

There should be a general notion of when a device should not do I/O. Not
just for runtime power management, but also for suspend. What do we do
when we want to go to sleep, but there are continuous requests to write to
disk or to some network card? There has to be a point when a driver cuts
off the I/O, queueing it up (or dropping it). It seems this is best left
up to the driver, since all devices may have a different mechanism for
determining when and where the cutoff point is. Maybe a serialize()
function for struct pci_driver?

	-pat

