Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135611AbRDSKUU>; Thu, 19 Apr 2001 06:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbRDSKUL>; Thu, 19 Apr 2001 06:20:11 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:7926 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S135611AbRDSKUD>; Thu, 19 Apr 2001 06:20:03 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-pm-devel@lists.sourceforge.net>
Subject: Re: PCI power management
Date: Thu, 19 Apr 2001 12:18:52 +0200
Message-Id: <20010419101852.7992@mailhost.mipsys.com>
In-Reply-To: <3ADEA108.50BB415D@mandrakesoft.com>
In-Reply-To: <3ADEA108.50BB415D@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ! Glad to see things moving around Power Management ;)

>This was originally a private reply to Patrick Mochel, but the e-mail
>kept getting longer and longer :)

Note: we have setup a list for PM issues

http://lists.sourceforge.net/lists/listinfo/linux-pm-devel

Not very much used yet, but I, at least, plan to spam it with all
sort of things we need for PowerBook PM... I'm forwarding your
message there and I suggest we continue that discussion there as well.

>The current state of PCI PM is this:
>
>pci_enable_device (1) enables IO and mem decoding, (2) assigns/routes
>the PCI IRQ, and (3) brings the device to D0 using pci_set_power_state. 
>Linus believes the power state transition should occur before (1) and
>(2), and I agree.
>
>pci_set_power_state brings a device to a new D state.  If the D state
>transition is D3->D0, then we (1) save key PCI config registers, (2) go
>to D0, and (3) restore saved PCI config registers.  This originally
>comes from Donald Becker's acpi_wake function, which is used only for
>the case of device enabling (where he had no problems), not for the case
>of returning-from-suspend (where we see problems).

I beleive the current scheme is not enough. Here are some of my own
thoughts about this:

 - Some devices won't properly give you their config space when
in D3 state. You shouldn't save the configuration when in D3 to restore
it after switching to D0, but you must have previously saved it before
originally putting the device into D3 state.

 - There need to be some arch "hooks" in this mecanism. Some machines
have the ability (from the arch specific code, by tweaking ASIC bits)
to remove clock and/or power from selected devices. That mean power
management can be done even with devices not supporting PCI PM provided
that the driver can recover them from a PowerOn reset.

 - Some devices just can't be brought back to life from D3 state without
a PCI reset (ATI Rage M3 for example) and that require some arch specific
support (when it's possible at all).

 - The current scheme provide no way for the kernel to "know" if a
driver can handle recovering the device from a PowerOn reset. Some
drivers can, some can't (the video drivers usually can't as they
require the board's PLL to be properly setup by the BIOS). Some
advanced PM modes we use on pmacs will cause the motherboard ASIC to
turn off power to PCI & AGP cards when putting the machine to sleep.
We need a way to prevent/allow this "deep sleep" mode depending
on what the card supports.

 - Ordering of power management may matter. On PowerBooks, we run
through all notifiers first with a "sleep request" message. None of
the drivers will actually put anything to sleep at this point, but
they will allocate all the memory the might need for doing so (saving
state, saving a framebuffer in some cases, etc...). Once all devices
have accepted the request (they can refuse it), I then send a 
"sleep now" message. This way, I can make sure all memory allocations
have been performed and disks properly sync'ed before putting the swap
devices to sleep and such things. 

 - On SMP, we need some way to stop other CPUs in the scheduler
while running the last round of sleep (putting devices to sleep) at least
until all IO layers in Linux can properly handle blocking of IO queues
while the device sleeps.

 - We need a generic (non-x86 APM or ACPI dependant) way of including
userland process that request it in the loop. Some userland process
that bang hardware directly (X, but not only X) need to be properly
suspended (and the kernel has to wait for ack from them before continuing
with devices sleep).

>"apm -s" causes the apm driver to map all suspends to the ACPI D3
>state.  An apm suspend triggers a pm_send_all call, which in turns
>triggers pci_pm_suspend.  This code [from Linus iirc] walks the root
>buses, recursively suspending downstream buses and then attached
>devices.  The resume code does the exact opposite.  The PCI core
>suspend/resume code has this comment, and we note the current
>requirement that -all- drivers should export suspend/resume somehow, in
>order for a sane PM system to work here.

Yup. They should also be able to return an error (fail or just limit
to a higher level like D2). They should also be able to tell the kernel
if they support recovering from a power down.

>It is up to the drivers to implement ::suspend() and ::resume(), and few
>do.  The few that do, even fewer work well in practice.

I would have preferred that a PM node be created for each PCI node and
have the PM nodes organised as a tree structure. That way, arch fixup
hooks can re-arrange the tree as the PCI bus->child dependency may not
be true. On some portables, some ASICs located on the PCI bus are not
dependent on their parent host bridge power plane.

>That's the current state of things.  I do not think the system -- at the
>PCI core level -- is poorly designed.  I think it just takes a lot of
>grunt work with drivers at this point, plus maybe a few new pci helper
>functions.
>
>So here's a random list of notes and issues on Linux PCI PM.
>
>1) pci_enable_device needs to power up the device before enabling it.

Right. And we need a equivalent power down function. For example, some
drivers may improve power management by powering down the device when
it's /dev node is not opened (or when the device have been idle for some
time). However, those power up/down functions have to be arch-dependant,
you can't rely on the PCI power management to be the only PM scheme.

>2) AFAICT, it is safe to turn off a PCI device's bus-mastering bit and
>take the device to D3, if it exports the PCI PM capability.  My
>previously-submitted pci_disable_function function turns off the
>bus-mastering bit, and should probably take the device to D3 too.

No, D3 is not safe on all devices. However, if pci_disable_function() is
under driver control, then the driver may decide not to call it. In some
case, D2 is the only acceptable mode. In other cases, the device doesn't
support PM but the motherboard has ways to shut the clock down or the
power supply.

>3) The current pci_set_power_state implementation is non-spec, and even
>though it works for some cases it does not appear like the right thing
>to do.

Definitely.

>4) Because of #2, I have create pci_power_on and pci_power_off. 
>pci_power_off saves ALL the PCI config registers, turns off
>busmastering, and goes to D3.  pci_power_on takes the device to D0, then
>blasts the stored PCI config register data back to the hardware.

That's better. I would however separate the config save/backup and
other housekeeping from the actual D-state change. As I wrote earlier,
D3 is not always a good solution and some motherboard specific mecanism
may be used here. I would have liked a bitmask of "options" of what
the driver allows (D1, D2, D3, static (no clock), power down, ...). 
Then, the arch-specific implementation of power down can pick the
best mode supported by the driver.

>5) In testing, this works sometimes, but other times it causes the
>upstream bridge of the device being resumed to stop decoding the device.

I beleive the bridge has to be power managed too (save/restore). The
G4 PowerMacs, when going to sleep, will cut power off the PCI<->PCI
bridge as well. The host bridge is another matter and is fully arch
dependant.

>6) One solution to #4 is to save and restore the PCI bridge registers
>too.  This comes partially from a Linus suggestion, and partially from
>an end user who solved their eepro100 suspend/resume problems with a
>setpci command to their PCI bridge (not to the eepro100 device).  In my
>own testing this solution works 100%, but (a) it might not be right, and
>thus (b) it might cause problems.  I am -very- interested in feedback on
>this solution, or a better one.

Well, I beleive we should indeed save & restore PCI<->PCI bridges.

I still beleive as well that instead of having PCI-specific
suspend/resume functions, we should have a real PM node per PCI node.
That way, we can add additional power notifications.

>7) Due to #5 an open issue is to re-read the bridge and PCI PM specs. 
>Some portions of the spec imply that the bridge should never be touched
>during device suspend or resume :)

PCI PM specs should be cached :)

>8) Who can predict what a laptop's AML tables want to do with the PCI
>bus, and if Linux will be interfering with ACPI suspend, or if ACPI will
>be interfering with Linux resume, etc.
>
>9) A truly green driver should register itself then disable its
>hardware.  It is wasting power otherwise.  That implies waking up
>hardware on dev->open and sleeping on dev->release.  Some net drivers do
>this already.  This further implies problems down the road with stuff
>like char drivers, where applications often open and close the device
>node very rapidly.  This happens in OSS audio land when some audio apps
>start up, for example.  Maybe an inactivity timer would work here, to
>power down the device after time passes with no open(2) calls.

I beleive it's up to each driver to handle that. Maybe some "framework"
for this can be provided with the generic PM nodes...

>10) We might wind up needing northbridge, southbridge, and/or PCI bridge
>drivers.  They will likely be small, but I think eventually they will
>need to exist in order to provide complete power management coverage.

Indeed, but those are in the arch side. We definitely to have a way
for the arch to hook deeply into the sleep process. There can be some
weird dependencies going on on portable motherboards or embedded
devices, like an ethernet device beeing also used to provide reset
signals to another PCI device, etc...

That's why I prefer the idea of having the PM nodes in a tree and
a node for each PCI device. The arch would then "hook" on the
pci_register_pm_node() or whatever we call it and have the ability
to move the node elsewhere in the tree depending on motherboard
details.

>11) Hard drives.  Our IDE and SCSI subsystems stink when it comes to
>working with the PCI PM framework.  Andre has spoken of plans to use
>pci_driver in 2.5, and turn the IDE subsystem "inside out" so that PCI
>drivers call out to registration functions, etc., instead of the current
>system.  The same thing needs to happen for SCSI.

Right, along with the problem of properly blocking IO queues. A similar
issue exist with all "bus" drivers. USB drivers should be properly notified
of sleep before the host controller gets suspended (I had some weird crashes
that were due to the OHCI controller getting mad because it was beeing
"tapped" while suspended by some drivers still feeding it with requests).
Also, some devices don't handle properly the errors they may get because
requests were interrupted by sleep. 
So busses like USB, FireWire, etc... need a similar "tree" architecture. I
strongly beleive generalizing the PM node is the way to go. Beeing
a "notifier" like mecanism, it allows to add specific messages if needed
(for example, USB bus suspend is different than machine sleep, that could
be an additional PM message sent by the host controller to USB drivers,
etc...)

>12) Continuing #11, there needs to be a general notion of when the
>system should -not- write stuff to disk.  This is mainly a userspace
>issue, ie. low-priority syslog messages should not prevent the system
>from idling the hard drive and spinning it down.  BUT..  the kernel may
>need to be the central arbiter if only to have a single place which says
>"hard drive is idle now"...

Yup. That's what I've more or less worked around on powerbooks with
the 2-step sleep process described above. When disks and IDE controller
are acutally put to sleep (powered off in my case), I will have already
allocated all the memory I need (backup storage from the frambuffer
etc...), have sync'ed the disks, waited a bit, and will no longer schedule
explicitely (and I should no longer schedule implicitely neither, but
that can be difficult to acheive as some of the current PM hooks will
cause schedules to happen). I also have a priority-based ordering
mecanism so that I can "fix" some of these issues by putting
things like display & disk to sleep latest, but that's a workaround.
>

Regards,
Ben.



