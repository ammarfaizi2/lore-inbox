Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSJOCr6>; Mon, 14 Oct 2002 22:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262283AbSJOCr6>; Mon, 14 Oct 2002 22:47:58 -0400
Received: from h-64-105-137-41.SNVACAID.covad.net ([64.105.137.41]:38058 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262289AbSJOCr4>; Mon, 14 Oct 2002 22:47:56 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 14 Oct 2002 19:53:40 -0700
Message-Id: <200210150253.TAA02434@adam.yggdrasil.com>
To: ebiederm@xmission.com
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:
>>       You do not understand.  The fundamental problem is that
>> sys_reboot in linux-2.5.42/kernel/sys.c makes exactly the same power
>> management call for a reboot and for a halt (device_shutdown()).  I
>> want my IDE, SCSI, USB, and FireWire hard disks to spin down if I do a
>> halt.  I do not want them to do that when I reboot.  I also do not
>> want my reboot to wait for an interrupt from a sound card because
>> remove() needs to determine if it is being called because the device
>> had just been unplugged.  It is not just about IDE disk drives.
[...]
>Do you seriously have a hot-plug sound card, that waits for an
>interrupt to be certain the card is plugged in during remove?

        Although I was being hypothetical, come to think of it, I do
some USB speakers that I have not been using, and detecting their
removal is done by the host contoller polling the hub for an
"interrupt", typically once per millisecond.

>If there is non-trivial work to detect if a card is present it
>probably makes sense to factor remove into
>->quiet() and ->remove()
>Where quiet would put the device into a quiescent state, and
>remove would simply clean up the driver state.

        Splitting into ->quiet() and ->removed() would be helpful
in any case, where removed() would normally not touch the hardware,
since it is quite possible the device has already been removed,
since the callers of these routines generally know if they are
calling because the device has been removed or because they want
just want to turn it off, while ->remove() currently has to guess,
which not only wastes time but also can be difficult to do safely
when you don't know if the device that you're talking to is even
present anymore.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
