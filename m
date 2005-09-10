Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbVIJFQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVIJFQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbVIJFQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:16:18 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:21456 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S1030406AbVIJFQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:16:17 -0400
Date: Fri, 9 Sep 2005 22:16:07 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Nuno Silva <nuno.silva@vgertech.com>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID resync speed
In-Reply-To: <43226701.1000606@vgertech.com>
Message-ID: <Pine.LNX.4.63.0509092156420.32348@twin.uoregon.edu>
References: <432240E9.9010400@eyal.emu.id.au> <43224ABB.3030002@vgertech.com>
 <4322506A.1010303@eyal.emu.id.au> <43226701.1000606@vgertech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Nuno Silva wrote:

> Eyal Lebedinsky wrote:
>> Nuno Silva wrote:
>>> Hi,
>>> Eyal Lebedinsky wrote:
>>>> I noticed that my 3-disk RAID was syncing at about 40MB/s, now that I
>>>> added a fourth disk it goes at only 20+MB/s. This is on an idle machine.
>>> 3*40=120
>>> 4*20=80
>> What does this mean? The raid is syncing at 20MB/s, not each disk, so I do
>> not see what the multiplication is about.
>
>
> Yes, you're correct :-)

The raid resync speed min and max are governed by the linux raid 
subsystem, I do not remember how to tweak them off hand and it's isn't in 
the software raid howto.

>
>>>> Individually, each disk measures 60+MB/s with hdparm.
>>> And concurrent hdparms? Or some dd's concurrently?
>> 
>> I do not see this as relevant, but four concurrent hdparms (each to a
>> different disk) give about 30MB/s per disk. I expect the controller
>> to talk to the four disks at their full speed so concurrency should
>> not be the issue.
>
>
> I guess you're using linux's software raid?
> If so, you're hitting the 120MB/sec (and I *think* this time I'm correct! :-)
>
> If this is a PCI32/33mhz slot you're not going to be able to get more juice. 
> (I bet that 3 concurrent dd's gets you 40MB each).
>
> Anyway, this may be offtopic because the problem (only 20MB/sec for the raid 
> with 4 disks) should be something else... Sorry for the noise.

Generally the maximum throughput for a pci controller is a bit less than 
the theoretical limit. some if not most motherboard implementations these 
days have the south brdiges sata ports attached to something other than 
the pci bus... This will get even more important in the context of 
sataII. pci-x or pci express sata controllers help quite a bit as 
well for machines that need more ports. Even some of the lower-end promise 
cards will run in a 66mhz slot these days though it's sort of wasteful to 
toss a 32bit card in a pci-x slot.

>>>> kernel: 2.6.13 on ia32
>>>> Controller: Promise SATAII150 TX4
>>>> Disks: WD 320GB SATA
>>>> 
>>>> Q: Is this the way the raid code works? The way the disk-io is
>>>> managed? Or
>>>> could it be due to the SATA controller?
>>> 
>>> You can isolate the performance drop with some dd's. Maybe this card is
>>> in a pci32/33mhz and you're hitting the pci bus' limits? (120~130MB/sec).
>> 
>> 
>> 'hdparm -T' gives about 1250 MB/sec so this is not the limiting
>> factor.
>
>
> Mine outputs some fabulous values too... I'm not sure I trust them ;)
>
> # hdparm -T /dev/sda
>
> /dev/sda:
> Timing cached reads:   3536 MB in  2.00 seconds = 1767.38 MB/sec

Those are measuring the performance of the linux buffer cache without disk 
access. really this a benchmark of the processor and memory of the system 
not the disk. -t meuse speed through the buffer without caching, which 
might give you a ballpark indication of disk speed. Really you need to use 
something like iozone to get a sense of how fast a disk is.

on the laptop I'm sending the mail on...

[root@podocarpus-totara joelja]# hdparm -T /dev/sda

/dev/sda:
  Timing cached reads:   2480 MB in  2.00 seconds = 1240.19 MB/sec

[root@podocarpus-totara joelja]# hdparm -t /dev/sda

/dev/sda:
  Timing buffered disk reads:   90 MB in  3.04 seconds =  29.60 MB/sec


30MB/s is pretty fast for a laptop, but it is a 100GB 5400rpm drive so 
it's probablly a little faster than what I'm used to.

> Regards,
> Nuno Silva
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

