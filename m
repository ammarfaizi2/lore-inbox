Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278664AbRJXReF>; Wed, 24 Oct 2001 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278672AbRJXRd5>; Wed, 24 Oct 2001 13:33:57 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:41639 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S278664AbRJXRdk>; Wed, 24 Oct 2001 13:33:40 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Wed, 24 Oct 2001 19:33:49 +0200
Message-Id: <20011024173349.20613@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Why would you _ever_ get "sg.c" and other crap involved in the suspend
>process?

Ahhh... ;)

>The device tree is for _device_ suspend, not for "subsystem suspend". The
>SCSI subsystem is a piece of cr*p, but even if it was perfect it should
>never get involved with the act of suspension.

I agree I'd like subsystems to avoid polluting the PM tree (or device tree).
If there are a few cases where a subsystem needs to know a driver it's using
is asleep, it's probably up to the interface of this susbystem to provide
a function to be called by the driver when it's going to suspend mode.

I can't really tell how it would be done for SCSI, I admit I got quickly
lost in the current drivers/scsi midlayer trying to figure out how
it layered things, but Andre told me it should be rewritten. I beleive
the proper way here would be to have an _interface_ (no mid-layer)
exposed by drivers who can receive SCSI commands (them beeing either USB,
ATAPI, FireWire or real SCSI devices).

However, Alan makes a point about state information. For example, the
"generic" CD-ROM driver for SCSI-protocol (those CD-ROMs beeing either
ATAPI, real SCSI, ...) would be the only one to know some state information
like rotation speed or whatever configuration info a given device may
support (placing ourselves in an ideal world of course, where all CDs
using the SCSI protocol share the same driver). So it must be some
way involved in the PM process.

I don't know what people plan for SCSI & ATAPI overhaul in 2.5, but
depending on how that scheme is done will impact the PM process. 

>We should not have pending IO, but that's for a totally different reason:
>the first thing the much much MUCH higher levels of suspend should be
>doing is to make sure that user apps are "quiescent". And that isn't done
>by getting involved with sg.c or anything similar, but by basically
>stopping all user apps (think of the equivalent of a "kill -STOP -1", but
>done internally in the kernel without actually using a signal).

Is this necessary ? That would definitely make things easier to implement
to forget about incoming requests, but I'm not sure it's the right way.
In fact, is it really working ? You could well have in-kernel threads
triggering IOs or launching new userland stuffs (what happens if a not
yet suspended driver for, let's say USB, see a new device coming in 
and starts /sbin/hotplug). Some filesystems have garbage collector threads
that can do IOs eventually. There are various kind of IOs that can in fact
be triggered entirely within the kernel.

Also, if you don't stop userland, wakeup is amazingly fast since
userland is up very soon, a sound app (mp3 player for example) will
be blocked until the driver it's write()'ing to is woken up, 
a swapping app is blocked until the IO requests for that page is
completed (which means if it was blocked in a block driver queue,
once the block driver have resumed operations), etc...
Currently, on pmacs, i don't have the tree but I do have some
kind of priority mecanism. Userland is woken up as soon as the
disk is ready. I think scheduling only have to be disabled between
step 2 and 3 of the sleep process, that is after all IOs have been
blocked  and before shutting down devices (that is before the step
that runs with IRQs off).

I really don't think it's _that_ difficult to properly do this blocking.
For things like sound drivers, a simple semaphore is plenty enough. For
network drivers, stopping the output queue is a one-line thing,
for block devices, it usually a matter of marking ourselves busy and
letting requests pile on our queue. The should be no risk of blocking
the sleep process itself this way since we made sure we did all allocations
needed by drivers prior to starting the actual blocking of requests, so we
won't block swap out.

Userland apps that hack on hardware directly like X will have been
suspended earlier (possibly via the existing /dev/apmbios interface
but we should rather define a new cleaner way to have PM control
from userland.

I have all of this more or less working on pmac laptops. I don't have
the new device model, so I handle dependencies manually with a priority
mecanism, but it's already good enough to let me resume userland before
ADB and sound, and possibly stuffs. (Which is nice since my sound chips
usually need one or 2 second to recalibrate and ADB need a few seconds to
probe the bus, all this happens asynchronously).

>> Also, the dependency issue is made worst if you let RAID enter into
>> the dance as I beleive ultimately, nothing would prevent a volume to
>> spawn over several devices from different controllers or even different
>> controller types.
>
>Why would you get RAID involved? There is no _IO_ involved in suspending:
>we just stop doing what we're doing, and leave it at that. We don't try to
>flush state, we just freeze the machine.

Ok.

>The act of "suspend" should basically be: shut off the SCSI controller,
>screw all devices, reset the bus on resume.

Well, some devices will need some state saving. You may need to save and
restore some speed setting for example. You want pending requests to
be properly terminated before you shut down, etc...

>The act of suspend on USB should be to turn off the host controller and
>remove power from devices. End of story. Nothing fancy.

Ehh... no, you want to put the USB bus into suspend state, which isn't
the same ;) Or you lose the ability to wake up the machine from the
USB keyboard, which on some iMacs is I think, the only way.

So before doing so, you need to iterate all childs of the controller
(that's fine, they have struct device entries with PM functions in them),
and tell them to suspend. Some devices need to be sent a command for
enabling remote wakeup. Others may need other housekeeping before the
bus goes to suspend.

But there's nothing magic there, nor anything fancy.
Just USB drivers have a struct device for each USB device, and are
notified of suspend normally as part of the device tree walk.
They are childs of the USB controller, we are guaranteed the controller
won't be down before devices.

I agree that is this is properly done, then we know the controller
won't have to deal with pending or new incoming IOs once it's its turn
to go sleeping, and can just enter it's suspend state immediately.

>If somebody removes a disk or equivalent while we're suspended, that's
>_his_ problem, and is exactly the same as removing a disk while the disk
>is running. Either the subsystem (like USB) already handles it, or it
>doesn't. Suspend is _not_ an excuse to do anything that isn't done at
>run-time.

Yup.

>So suspend is _not_ supposed to be equivalent of a full clean shutdown
>with just users not seeing it.  That's way too expensive to be practical.
>Remember: the main point of suspend is to have a laptop go to sleep, and
>come back up on the order of a few _seconds_.

Yup.

>And if there are desktops which would like to suspend but cannot because
>they aren't strictly designed for it, then tough - we should not try to
>design a heavy suspend for hardware that doesn't live with it well.
>
>Also, realize that the act of suspension is STARTED BY THE USER. Which
>means that before the kernel suspends, you _can_ have user programs that
>basically take disk arrays off-line etc if that is what you want. But
>that's not ae kernel suspend issue.

Yes. We do that on pmac as well. The lid of the laptop is monitored by
a userland daemon, which runs scripts before and after sending the real
suspend ioctl to our PM driver.

There is also /dev/apm_bios which allows for the suspend process to
notify (and wait for ack) userland apps that requested X (in our case,
X so it stop banging the HW, properly save it's own state and properly
resume the card on wakeup). 

However, that interface could as well be completely userland (X
requesting notifications from the PM daemon). 

Ben.

