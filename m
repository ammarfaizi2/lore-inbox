Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJMWIo>; Sun, 13 Oct 2002 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbSJMWIn>; Sun, 13 Oct 2002 18:08:43 -0400
Received: from h-64-105-34-19.SNVACAID.covad.net ([64.105.34.19]:28546 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261725AbSJMWIm>; Sun, 13 Oct 2002 18:08:42 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 13 Oct 2002 15:14:27 -0700
Message-Id: <200210132214.PAA00953@adam.yggdrasil.com>
To: ebiederm@xmission.com
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:
>Eric Blade <eblade@blackmagik.dynup.net> writes:

>> On Sun, 2002-10-13 at 15:24, Adam J. Richter wrote:
>> > 	At first, I suspected IDE, but I think the new behavior in IDE
>> > of spinning down the hard drives on suspend is correct.  The problem
>> > is that the warm reboot system call is trying to suspend all of the
>> > devices before a warm reboot for no reason.


>There is a very good reason for calling the driver->remove() function
>on a reboot so that we place the devices in a consistent state.  And
>stop any on going DMA etc.

	A warm reboot is supposed to do this by the platform dependent
machine_restart(), and whatever processes machine_restart sets off
(e.g., by making a RESET signal active).  If a device driver needs
some special processing prior to that, that is what the reboot
notifier chain is for.

>The reboot notifier call chain, is highly underused, and all of the drivers
>already have the code they need in their remove function.

	What specific drivers are you referring to that meet all three
of the criteria you have stated?:

		1. They need to use reboot_notifier because the
		   machine_restart() is not enough to reset them,

		2. They do not currently use reboot_notifier,

		3. They have a device->remove() that does what the
		   reboot_notifier should do (shuts down ongoing DMA,
		   because they have a some device that ignores a reset
		   signal or something like that).

	In general I would expective that a driver->remove(device)
function would not be able to touch much of the hardware at all,
because it would have to assume that the device has been or is being
physically yanked out of the computer, so it should do software cleanup
and maybe talk to the PCMCIA socket, USB hub port, etc. that previously
held the device.

	If you have a platform where, for example, somehow PCI devices
are able to continue jabbering away after the computer has been reset,
then that could probably be done more consistently for most drivers by
having machine_restart on that platform walk the PCI bus and shut down
everything (drivers that need to do something really special would
still use the reboot notifier).

	I could even see calling device_shutdown from machine_restart
on that platform only, and I could even image
"if(buggy_motherboard) device_shutdown();", but I would be really
surprised to learn that sort of thorough resetting is necessary for
most hardware on ordinary x86 PC's.

	I could also understand something like your system call for
booting Linux from Linux needing to do more thorough shutdowns and
resets, but not something that uses machine_restart().

>> I am not talking about
>> > eliminating that.  I am only talking about the soft reboot putting
>> > devices into a power saving mode that is allowed to take a long
>> > recovery time, especially given that the reboot is likely to want to
>> > talk to every hardware device connected to the system.

>If 
>driver->remove() 
>does that it is an issue with that device driver.

	device_shutdown and device_suspend are for power management.
It is important to turn the device off as soon as possible if a power
management routine has told you that the device is not going to be
used any more.

	If you've identified a bunch of devices that need
reboot_notifier, please list them so we can fix them rather than
taxing the users with unnecessarily slow reboots or poor battery life
(due to device not being shut down when they are no longer being used).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
