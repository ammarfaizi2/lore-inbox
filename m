Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSJOStq>; Tue, 15 Oct 2002 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSJOStp>; Tue, 15 Oct 2002 14:49:45 -0400
Received: from h-64-105-136-201.SNVACAID.covad.net ([64.105.136.201]:6848 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264639AbSJOStE>; Tue, 15 Oct 2002 14:49:04 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 15 Oct 2002 11:54:50 -0700
Message-Id: <200210151854.LAA04132@adam.yggdrasil.com>
To: mochel@osdl.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
>> 	If you've identified a bunch of devices that need
>> reboot_notifier, please list them so we can fix them rather than
>> taxing the users with unnecessarily slow reboots or poor battery life
>> (due to device not being shut down when they are no longer being used).

>No, reboot notifiers are the completely wrong way to go, for one reason 
>alone: ordering. device_shutdown() does a depth-first walk of the tree to 
>shut down children devices before ancestors. You cannot guarantee that 
>with reboot notifiers.

	The question is not whether reboot notifiers should also be
part of struct device for sequencing purposes.  Nobody is arguing
against that.

	The question is whether it is impractical to have a distinct
device->reboot_notifier() for those devices that truely need it so
that we can avoid calling ->remove() for most devices.  To answer that,
I think you need list a large number of devices that match ALL THREE
of the following criteria:

|		1. They need to use reboot_notifier because the
|		   machine_restart() is not enough to reset them,
|
|		2. They do not currently use reboot_notifier,
|
|		3. They have a device->remove() that does what the
|		   reboot_notifier should do (shuts down ongoing DMA,
|		   because they have a some device that ignores a reset
|		   signal or something like that).

>Please don't try and convolute the code because you're worried about a few
>microseconds. It's about correctness first; then we can worry about
>micro-optimizing the hell out of it.

	1. When something has gone wrong with a device driver, you generally
	   gather what information you can and then try a warm reboot,
	   especially when one is working remotely.  Data structures in
	   device drivers can often corrupted under these circumstances.
	   So it is important that warm reboots reboot the system as
	   simply as they can with reliability.  That means only executing
	   the special shutdown code that really needs to be executed.

	2. For small platforms, I can about keeping the __devexit code out
	   of the kernel footprint.  I don't want Linux to lose the
	   competition small embedded devices (grated such decisions do not
	   pivot on __devexit alone, but a cultrue of wastefulness leads
	   creates bloat in steps such like this one).

	3. I do care that reboot goes fast.  Optimizations for speed and
	   space generally come about by making lots of little clean ups.
	   The standard power on self-test takes ages on most PCs, but
	   it doesn't have to be that way, and it isn't necessarily that
	   way on other platforms.  I'd linux not to be an impedement
	   to having systems where you don't even see the screen go black
	   when you reboot.

	Also, while your post is a very mild example, circular
arguments that implicitly attempt to define a term like "correctness"
waste everyone's time at best. At worst, such arguments lead to
software that unnecessarily biggers, less functional, slower to run,
or slower to be developed, harder to maintain or inferior by some
other real metric because someone made a trade-off against a real
benefit in favor of something that sounded beneficial but was actally
just a a circular definition.

	Instead, please show underlying benefits.  Show me how calling
->remove() for every device to do a warm reboot will make the kernel
smaller or will make reboots go faster.  If your change improves
reliability, then you should be able show real examples where reboots
work in 2.5.8+ and fail in 2.4, so that we might try to quantify the
probable trade-off between that scenario (where we still have reboot
notifiers available) and potentially running into problems by calling
clean-up code in each device driver.  In comparison, I frequently get
into trouble with the IDE drivers by inserting and removing
CompactFlash cards (haven't tried in 2.4.42), so I really do not want
any more clean-up code called that is necessarily if the kernel is
confused.  If you cannot show some benefit, it looks like calling all
those remove() routines will be a lose on speed, size and even
reliability.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
