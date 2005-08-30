Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVH3UGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVH3UGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVH3UGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:06:23 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:8939 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932427AbVH3UGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:06:22 -0400
Date: Tue, 30 Aug 2005 20:06:21 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <20050829202529.GA32214@midnight.suse.cz>
Message-ID: <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005, Vojtech Pavlik wrote:

> On Mon, Aug 29, 2005 at 06:20:56PM +0000, Holger Kiehl wrote:
>> Hello
>>
>> I have a system with the following setup:
>>
>>     Board is Tyan S4882 with AMD 8131 Chipset
>>     4 Opterons 848 (2.2GHz)
>>     8 GB DDR400 Ram (2GB for each CPU)
>>     1 onboard Symbios Logic 53c1030 dual channel U320 controller
>>     2 SATA disks put together as a SW Raid1 for system, swap and spares
>>     8 SCSI U320 (15000 rpm) disks where 4 disks (sdc, sdd, sde, sdf)
>>       are on one channel and the other four (sdg, sdh, sdi, sdj) on
>>       the other channel.
>>
>> The U320 SCSI controller has a 64 bit PCI-X bus for itself, there is
>> no other device on that bus. Unfortunatly I was unable to determine at
>> what speed it is running, here the output from lspci -vv:
>
>> How does one determine the PCI-X bus speed?
>
> Usually only the card (in your case the Symbios SCSI controller) can
> tell. If it does, it'll be most likely in 'dmesg'.
>
There is nothing in dmesg:

    Fusion MPT base driver 3.01.20
    Copyright (c) 1999-2004 LSI Logic Corporation
    ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 217
    mptbase: Initiating ioc0 bringup
    ioc0: 53C1030: Capabilities={Initiator,Target}
    ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, low) -> IRQ 225
    mptbase: Initiating ioc1 bringup
    ioc1: 53C1030: Capabilities={Initiator,Target}
    Fusion MPT SCSI Host driver 3.01.20

>> Anyway, I thought with this system I would get theoretically 640 MB/s using
>> both channels.
>
> You can never use the full theoretical bandwidth of the channel for
> data. A lot of overhead remains for other signalling. Similarly for PCI.
>
>> I tested several software raid setups to get the best possible write
>> speeds for this system. But testing shows that the absolute maximum I
>> can reach with software raid is only approx. 270 MB/s for writting.
>> Which is very disappointing.
>
> I'd expect somewhat better (in the 300-400 MB/s range), but this is not
> too bad.
>
> To find where the bottleneck is, I'd suggest trying without the
> filesystem at all, and just filling a large part of the block device
> using the 'dd' command.
>
> Also, trying without the RAID, and just running 4 (and 8) concurrent
> dd's to the separate drives could show whether it's the RAID that's
> slowing things down.
>
Ok, I did run the following dd command in different combinations:

    dd if=/dev/zero of=/dev/sd?1 bs=4k count=5000000

Here the results:

    Each disk alone
    /dev/sdc1 59.094636 MB/s
    /dev/sdd1 58.686592 MB/s
    /dev/sde1 55.282807 MB/s
    /dev/sdf1 62.271240 MB/s
    /dev/sdg1 60.872891 MB/s
    /dev/sdh1 62.252781 MB/s
    /dev/sdi1 59.145637 MB/s
    /dev/sdj1 60.921119 MB/s

    sdc + sdd in parallel (2 disks on same channel)
    /dev/sdc1 42.512287 MB/s
    /dev/sdd1 43.118483 MB/s

    sdc + sdg in parallel (2 disks on different channels)
    /dev/sdc1 42.938186 MB/s
    /dev/sdg1 43.934779 MB/s

    sdc + sdd + sde in parallel (3 disks on same channel)
    /dev/sdc1 35.043501 MB/s
    /dev/sdd1 35.686878 MB/s
    /dev/sde1 34.580457 MB/s

    Similar results for three disks (sdg + sdh + sdi) on the other channel
    /dev/sdg1 36.381137 MB/s
    /dev/sdh1 37.541758 MB/s
    /dev/sdi1 35.834920 MB/s

    sdc + sdd + sde + sdf in parallel (4 disks on same channel)
    /dev/sdc1 31.432914 MB/s
    /dev/sdd1 32.058752 MB/s
    /dev/sde1 31.393455 MB/s
    /dev/sdf1 33.208165 MB/s

    And here for the four disks on the other channel
    /dev/sdg1 31.873028 MB/s
    /dev/sdh1 33.277193 MB/s
    /dev/sdi1 31.910000 MB/s
    /dev/sdj1 32.626744 MB/s

    All 8 disks in parallel
    /dev/sdc1 24.120545 MB/s
    /dev/sdd1 24.419801 MB/s
    /dev/sde1 24.296588 MB/s
    /dev/sdf1 25.609548 MB/s
    /dev/sdg1 24.572617 MB/s
    /dev/sdh1 25.552590 MB/s
    /dev/sdi1 24.575616 MB/s
    /dev/sdj1 25.124165 MB/s

So from these results, I may assume that md is not the cause of the problem.

What comes as a big surprise is that I loose 25% performance with only
two disks and each hanging on its own channel!

Is this normal? I wonder if other people have the same problem with
other controllers or the same.

What can I do next to find out if this is a kernel, driver or hardware
problem?

Thanks,
Holger

