Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263441AbTCNSzm>; Fri, 14 Mar 2003 13:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263442AbTCNSzm>; Fri, 14 Mar 2003 13:55:42 -0500
Received: from h-64-105-35-119.SNVACAID.covad.net ([64.105.35.119]:51590 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263441AbTCNSzk>; Fri, 14 Mar 2003 13:55:40 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Mar 2003 11:06:23 -0800
Message-Id: <200303141906.LAA02228@adam.yggdrasil.com>
To: dwmw2@infradead.org
Subject: Re: devfs + PCI serial card = no extra serial ports
Cc: driver@jpl.nasa.gov, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-14 at 15:23:50, David Woodhouse wrote:
>On Mon, 2003-03-10 at 18:25, Bryan Whitehead wrote:
>> [snip]
>> >       There is nothing in devfs that prevents you from registering
>> > devfs devices even if they are not yet bound to specific hardware
>> > (you do not need a sysfs mapping, for example).  So, you should be
>> > able to register /dev/tts/0..N at initialization, where N is the
>> > maximum number of serial devices you want to support.
>> 
>> are you saying there is a way to force devfs to make more entries in 
>> /dev/tts/ without any hardware being attached to the entries? Then i can 
>> use setserial? so on boot I'd have 4 entries in /dev/tts ?

>Don't do this. The whole concept of opening a device node for a device
>which is _absent_, then doing magic ioctls on it to make the driver
>probe for the hardware, is utterly bogus.

>Fix it properly instead -- disallow opening of a /dev/ttySx node with
>uart type unknown, and implement a proper way to tell the serial driver
>'please look for a device _here_', via sysfs or something. 

	I don't know what you mean by "is utterly bogus."  You need to
explain why you think this practice results in a larger kernel
footprint, lower throughput, longer latency, larger object or source
code size, or is worse by some other objective external metric when
compared to a specific alternative (another element you seem to have
omitted).

	This is a frequent problem that I see in many public technical
discussions.  Using intimidation words like "is utterly bogus" to
cover for not stating real technical reasons not only wastes peoples
time in reading an unnecessary email exchange but also can mislead
people into decision chains that tack toward producing software that
is bigger, slower, harder to maintain, lacking in functionality or
worse by most weightings of external benefits that people would
accept.

	Getting back to the topic of /dev devices without a constant
binding to hardware devices, a device having at least a
context-depenedent binding goes back as far as /dev/tty.  Being able
to define a new serial device with open and ioctl have been in the
Linux kernel since before devfs ever existed.  Non-devfs systems
generally have many device files in /dev that are not actually bound
to any existing devcies.  For example, a non-devfs system may have
device files for the first four SCSI disks even on a system that has
no SCSI disks.  In fact, such a device file may become valid later if
a USB disk is plugged in.  User programs seem to be working OK with
the non-constance of a device file's binding to a specific hardware
device (i.e., there has not been some big unintended consequence that
has caused systems lock up when they boot or when it's time to run
fsck or after 8 hours of use or whatever).  So, the costs of this
approach that I can think of seem pretty small.

	Being able to open a device and then using ioctl's to define
it (such as is currently the case in serial and loop devices) creates
a programming interface that is more easily ported to other operating
systems that don't have /sys and but do have open and ioctl.  The
existing approach is also more capitable with versions of Linux that
lack /sys.

	Before these ioctl's are run on a serial device to set the
UART type, interrupt and IO port, the kernel does not necessarily know
that there is a UART at a particular IO location, what type it is and
what interrupt it is associated with.  So, it sounds like a /sys
interface would be more kernel code than the current scheme without
solving any real problem or delivering any real benefit that I see.

	Also, the dynamic configuration of serial ports with setserial
is code that has been widely used for a long time, so its reliability
should be pretty good.

	So, it seems to me that the expected reliability,
compatability, kernel code size and user code size benefits are likely
to exceed those of defining some new creation process using /sys.  If
you disagree, then please come up with some specific proposal (even if
just for purposes of example), list these trade-offs and whatever
others you perceive, and then we can discuss which approach each of
thinks provides the most benefit on balance.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
