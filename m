Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136249AbRD0WW0>; Fri, 27 Apr 2001 18:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136250AbRD0WWR>; Fri, 27 Apr 2001 18:22:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64908 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S136249AbRD0WWJ>;
	Fri, 27 Apr 2001 18:22:09 -0400
Date: Sat, 28 Apr 2001 00:22:07 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104272222.AAA33242.aeb@vlet.cwi.nl>
To: astavitsky@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Seagate ST340824A and (un)clipping max LBA: 2.2.19+ide04092001 patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alexander Stavitsky <astavitsky@yahoo.com>

    Disk capacity unclipping routines in ide.2.2.19.04092001.patch do not unclip
    Seagate ST340824A.

    I have to use the jumper on the drive to make system boot.
    I tried "setmax" program and it is able to unclip the capacity,
    kernel however does not.

    I digged a little and I think the problem is that ST340824A does not follow
    the ATA standard - it does support both READ NATIVE MAX ADDRESS
    and SET MAX ADDRESS, but does not advertise support for
    Host Protected Area feature set.

(maybe support is incomplete and therefore not announced?)

    drive->id->command_set_1 =3D 0x306b for the this drive.

    The unclipping routines compare
    drive->id->command_set_1 and 0x0400 (Host Protected Feature set)

That is correct.

    The earlier version of the patch compared
    drive->id->command_set_1 and 0x000a (Security Mode & Power Managment ???)

    When I changed it back to 0x000a, it unclipped the capacity just fine.
    But 0x000a doesn't make any sense to me.

No. Maybe someone can tell us about its origin, but in your case
of course this just works because 0xa intersects 0x306b. You might
comment out this entire test.

    What is the correct solution?

In the case of this particular disk the manufacturer says:
Use the Set Features command (EF) with subfunction F1.
That tells the disk to report full capacity.
(ATA-6 says that F1 is reserved for use by the Compact Flash Association)

[Could you try that and report identify output before and after?]

    Also a related question: when I use "setmax", the drive reports full
    capacity through "hdparm -I /dev/hd*", but kernel still uses the old info.
    How does one update the kernel info after using "setmax"?

Details depend on kernel version and patches used.
There is not yet a good framework here.
(Many kernel versions will believe the partition table, even if it
extends beyond the end of the disk. That may be regarded as a bug,
but is useful in cases like this where the disk lies about its size.)


Andries
