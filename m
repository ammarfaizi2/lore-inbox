Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbULEXei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbULEXei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULEXei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:34:38 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:40065 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261422AbULEXcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:32:17 -0500
Date: Mon, 6 Dec 2004 00:31:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] swsusp-bigdiff: power-managment changes that are waiting in my tree
Message-ID: <20041205233110.GB1490@elf.ucw.cz>
References: <20041205214910.GA1293@elf.ucw.cz> <1102284611.11763.97.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <1102284611.11763.97.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > +ON -- no need to do anything except special cases like broken
> > +HW.
> 
> I'm not sure what is this one supposed to be ... The description is
> definitely not clear, can you precise in what context it is sent and
> give maybe an example of "broken hw" ?
> 
> Ok, now I'm reading the rest of the mail and I see but your description
> is really confusing. Also, we really need the resume argument to be
> added for the opposite (after resume) call to be sent. It makes little
> sense to pipe it through the suspned() callback.

Oh I just wanted to have ON for future expansion, like that "warning
userland is going away" or something like that. Maybe it can be even
killed.

> > +SUSPEND -- like FREEZE, but also put hardware into low-power state. If
> > +there's need to distinguish several levels of sleep, additional flag
> > +is probably best way to do that.
> 
> Here add a blurb about transitions. They are only from a resumed state
> to a suspended state, never between 2 suspended states.

Applied.

> > +All events are: 
> > +
> > +#Prepare for suspend -- userland is still running but we are going to
> > +#enter suspend state. This gives drivers chance to load firmware from
> > +#disk and store it in memory, or do other activities taht require
> > +#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
> > +#are forbiden once the suspend dance is started.. event = ON, flags =
> > +#PREPARE_TO_SUSPEND
> 
> Note that we should probably fix kmalloc itself to turn GFP_KERNEL into
> GFP_NOIO during the suspend process. For call_usermodehelper, I wnated
> to "queue" them, but greg suggested that instead, we fail them, and at
> the end of the suspend process, we send a special /sbin/hotplug event
> telling userland to rescan sysfs.

Actually I do not think that automatically doing GFP_NOIO instead of
GFP_KERNEL is right thing. Is it that hard to teach drivers to get it
right?

> Now about your (long) list bewlow, it's really confusing as a
> documentation. People will think they have somewhat to switch/case on
> all these possible 'events' which is implied by the fact that you
> indicate different actions for each of them. I would redo that
> documentation completely differently.

No idea, it is certainly usefull for me :-). Hopefully noone is stupid
enough to do case according to this, and flags are not even defined
just yet, so spending extra time writing docs does not seem that great
right now...

Anyway, feel free to send improved version...

> > +Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
> > +may need to be enabled on some devices. This actually has at least 3
> > +subtypes, system can reboot, enter S4 and enter S5 at the end of
> > +swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
> > +SYSTEM_SHUTDOWN, SYSTEM_S4
> 
> Hrm... shuoldn't we rather use different calls for the above ? For S3/S4
> do a SUSPEND call rather than freeze ?

S3 needs SUSPEND (and I specify it like that). At suspend-to-disk, you
don't care about hardware state before poweroff (on PC anyway) so
FREEZE seems like right thing to do.

Attached is my version of file with one paragraph added.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devices.txt"


Device Power Management


Device power management encompasses two areas - the ability to save
state and transition a device to a low-power state when the system is
entering a low-power state; and the ability to transition a device to
a low-power state while the system is running (and independently of
any other power management activity). 


Methods

The methods to suspend and resume devices reside in struct bus_type: 

struct bus_type {
       ...
       int             (*suspend)(struct device * dev, u32 state);
       int             (*resume)(struct device * dev);
};

Each bus driver is responsible implementing these methods, translating
the call into a bus-specific request and forwarding the call to the
bus-specific drivers. For example, PCI drivers implement suspend() and
resume() methods in struct pci_driver. The PCI core is simply
responsible for translating the pointers to PCI-specific ones and
calling the low-level driver.

This is done to a) ease transition to the new power management methods
and leverage the existing PM code in various bus drivers; b) allow
buses to implement generic and default PM routines for devices, and c)
make the flow of execution obvious to the reader. 


System Power Management

When the system enters a low-power state, the device tree is walked in
a depth-first fashion to transition each device into a low-power
state. The ordering of the device tree is guaranteed by the order in
which devices get registered - children are never registered before
their ancestors, and devices are placed at the back of the list when
registered. By walking the list in reverse order, we are guaranteed to
suspend devices in the proper order. 

Devices are suspended once with interrupts enabled. Drivers are
expected to stop I/O transactions, save device state, and place the
device into a low-power state. Drivers may sleep, allocate memory,
etc. at will. 

Some devices are broken and will inevitably have problems powering
down or disabling themselves with interrupts enabled. For these
special cases, they may return -EAGAIN. This will put the device on a
list to be taken care of later. When interrupts are disabled, before
we enter the low-power state, their drivers are called again to put
their device to sleep. 

On resume, the devices that returned -EAGAIN will be called to power
themselves back on with interrupts disabled. Once interrupts have been
re-enabled, the rest of the drivers will be called to resume their
devices. On resume, a driver is responsible for powering back on each
device, restoring state, and re-enabling I/O transactions for that
device. 

System devices follow a slightly different API, which can be found in

	include/linux/sysdev.h
	drivers/base/sys.c

System devices will only be suspended with interrupts disabled, and
after all other devices have been suspended. On resume, they will be
resumed before any other devices, and also with interrupts disabled.


Runtime Power Management

Many devices are able to dynamically power down while the system is
still running. This feature is useful for devices that are not being
used, and can offer significant power savings on a running system. 

In each device's directory, there is a 'power' directory, which
contains at least a 'state' file. Reading from this file displays what
power state the device is currently in. Writing to this file initiates
a transition to the specified power state, which must be a decimal in
the range 1-3, inclusive; or 0 for 'On'.

The PM core will call the ->suspend() method in the bus_type object
that the device belongs to if the specified state is not 0, or
->resume() if it is. 

Nothing will happen if the specified state is the same state the
device is currently in. 

If the device is already in a low-power state, and the specified state
is another, but different, low-power state, the ->resume() method will
first be called to power the device back on, then ->suspend() will be
called again with the new state. 

The driver is responsible for saving the working state of the device
and putting it into the low-power state specified. If this was
successful, it returns 0, and the device's power_state field is
updated. 

The driver must take care to know whether or not it is able to
properly resume the device, including all step of reinitialization
necessary. (This is the hardest part, and the one most protected by
NDA'd documents). 

The driver must also take care not to suspend a device that is
currently in use. It is their responsibility to provide their own
exclusion mechanisms.

The runtime power transition happens with interrupts enabled. If a
device cannot support being powered down with interrupts, it may
return -EAGAIN (as it would during a system power management
transition),  but it will _not_ be called again, and the transaction
will fail.

There is currently no way to know what states a device or driver
supports a priori. This will change in the future. 


Driver Detach Power Management

The kernel now supports the ability to place a device in a low-power
state when it is detached from its driver, which happens when its
module is removed. 

Each device contains a 'detach_state' file in its sysfs directory
which can be used to control this state. Reading from this file
displays what the current detach state is set to. This is 0 (On) by
default. A user may write a positive integer value to this file in the
range of 1-4 inclusive. 

A value of 1-3 will indicate the device should be placed in that
low-power state, which will cause ->suspend() to be called for that
device. A value of 4 indicates that the device should be shutdown, so
->shutdown() will be called for that device. 

The driver is responsible for reinitializing the device when the
module is re-inserted during it's ->probe() (or equivalent) method. 
The driver core will not call any extra functions when binding the
device to the driver. 

pm_message_t meaning

pm_message_t has two fields. event ("major"), and flags.  If driver
does not know event code, it aborts the request, returning error. Some
drivers may need to deal with special cases based on the actual type
of suspend operation being done at the system level. This is why
there are flags.

Event codes are:

ON -- no need to do anything except special cases like broken
HW.

FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
scratch. That probably means stop accepting upstream requests, the
actual policy of what to do with them beeing specific to a given
driver. It's acceptable for a network driver to just drop packets
while a block driver is expected to block the queue so no request is
lost. (Use IDE as an example on how to do that). FREEZE requires no
power state change, and it's expected for drivers to be able to
quickly transition back to operating state.

SUSPEND -- like FREEZE, but also put hardware into low-power state. If
there's need to distinguish several levels of sleep, additional flag
is probably best way to do that.

Transitions are only from a resumed state to a suspended state, never
between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).

All events are: 

#Prepare for suspend -- userland is still running but we are going to
#enter suspend state. This gives drivers chance to load firmware from
#disk and store it in memory, or do other activities taht require
#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
#are forbiden once the suspend dance is started.. event = ON, flags =
#PREPARE_TO_SUSPEND

Apm standby -- prepare for APM event. Quiesce devices to make life
easier for APM BIOS. event = FREEZE, flags = APM_STANDBY

Apm suspend -- same as APM_STANDBY, but it we should probably avoid
spinning down disks. event = FREEZE, flags = APM_SUSPEND

System halt, reboot -- quiesce devices to make life easier for BIOS. event
= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT

System shutdown -- at least disks need to be spun down, or data may be
lost. Quiesce devices, just to make life easier for BIOS. event =
FREEZE, flags = SYSTEM_SHUTDOWN

Kexec    -- turn off DMAs and put hardware into some state where new
kernel can take over. event = FREEZE, flags = KEXEC

Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
may need to be enabled on some devices. This actually has at least 3
subtypes, system can reboot, enter S4 and enter S5 at the end of
swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
SYSTEM_SHUTDOWN, SYSTEM_S4

Suspend to ram  -- put devices into low power state. event = SUSPEND,
flags = SUSPEND_TO_RAM

Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
devices into low power mode, but you must be able to reinitialize
device from scratch in resume method. This has two flavors, its done
once on suspending kernel, once on resuming kernel. event = FREEZE,
flags = DURING_SUSPEND or DURING_RESUME

Device detach requested from /sys -- deinitialize device; proably same as
SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
= FREEZE, flags = DEV_DETACH.

#These are not really events sent:
#
#System fully on -- device is working normally; this is probably never
#passed to suspend() method... event = ON, flags = 0
#
#Ready after resume -- userland is now running, again. Time to free any
#memory you ate during prepare to suspend... event = ON, flags =
#READY_AFTER_RESUME
#

--/9DWx/yDrRhgMJTb--
