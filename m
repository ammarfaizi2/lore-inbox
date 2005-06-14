Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFNRiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFNRiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFNRiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:38:10 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:51407 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261263AbVFNRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:37:52 -0400
Message-ID: <42AEB30B.1070808@cyte.com>
Date: Tue, 14 Jun 2005 03:35:55 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Jens Axboe <axboe@suse.de>
Subject: Re: amd64 cdrom access locks system
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org>	 <42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>	 <42ADB5B4.1020704@cyte.com> <58cb370e05061400555407d144@mail.gmail.com>
In-Reply-To: <58cb370e05061400555407d144@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using "dev=/dev/hda" yeilds the exact same behavior...

   Jun 14 03:21:50 localhost kernel: ide-cd: cmd 0x3 timed out
   Jun 14 03:21:50 localhost kernel: hda: lost interrupt
   Jun 14 03:22:50 localhost kernel: ide-cd: cmd 0x3 timed out
   Jun 14 03:22:50 localhost kernel: hda: lost interrupt
   Jun 14 03:23:30 localhost kernel: hda: lost interrupt

And I'm a little confused by Robert's suggestion... Should it
ever be possible for a user-space application to cause lost
interrupts and other kernel state problems regardless of what
"interface" is used?? Sure, if the application uses the wrong
interface it should get spanked somehow but should it be able to
mess up the kernel for other applications as well? (Like now
I can't read or eject.)

The output from the cdrecord command was:
   root@mail:~# cdrecord -v -eject -tao dev=/dev/hda stupid.iso
   Cdrecord-Clone 2.01.01a01 (x86_64-unknown-linux-gnu) Copyright (C) 
1995-2004 Joerg Schilling
   NOTE: this version of cdrecord is an inofficial (modified) release of 
cdrecord
         and thus may have bugs that are not present in the original 
version.
         Please send bug reports and support requests to 
<cdrtools@packages.debian.org>.
         The original author should not be bothered with problems of 
this version.

   cdrecord: Warning: Running on Linux-2.6.12-rc6-jw14
   cdrecord: There are unsettled issues with Linux-2.5 and newer.
   cdrecord: If you have unexpected problems, please try Linux-2.4 or 
Solaris.
   TOC Type: 1 = CD-ROM
   scsidev: '/dev/hda'
   devname: '/dev/hda'
   scsibus: -2 target: -2 lun: -2
   Warning: Open by 'devname' is unintentional and not supported.
   Linux sg driver version: 3.5.27
   Using libscg version 'ubuntu-0.8ubuntu1'.
   cdrecord: Warning: using inofficial version of libscg 
(ubuntu-0.8ubuntu1 '@(#)scsitransp.c      1.91 04/06/17 Copyright 
1988,1995,2000-2004 J. Schilling').
   SCSI buffer size: 64512
   atapi: 1
   Device type    : Removable CD-ROM
   Version        : 0
   Response Format: 2
   Capabilities   :
   Vendor_info    : 'SONY    '
   Identifikation : 'DVD RW DRU-500A '
   Revision       : '2.0h'
   Device seems to be: Generic mmc2 DVD-R/DVD-RW.
   Current: 0x0009
   Profile: 0x001B
   Profile: 0x001A
   Profile: 0x0014
   Profile: 0x0013
   Profile: 0x0011
   Profile: 0x0010
   Profile: 0x000A
   Profile: 0x0009 (current)
   Profile: 0x0008

Since the kernel gets messed up and reports losts interrupts I'm
inclined to believe that this is a kernel/driver issue and not my
misuse of an application/interface. Though I realize cdrecord is
being run as the superuser and therefore might be overiding some
kernel security checks and messing with the kernel so I might be
wrong about that.

One question comes to mind... Would Robert's suggestion and my
results be affected by the fact that I don't have Packet Writing
for CD drives turned on the current kernel?

Any other ideas?

Bartlomiej Zolnierkiewicz wrote:
> [ Jens added to cc: ]
> 
> On 6/13/05, Jeff Wiegley <jeffw@cyte.com> wrote:
> 
>>Andrew Morton said I should carbon copy the IDE developer on this
>>issue so I have in the hopes of re-opening this issue and making
>>some progress since I'm still unable to write anything with my
>>cd-burner.
>>
>>Here's what I know to date:
>>
>>    I have the alim15x3 IDE driver installed and running.
>>    I do NOT have any of the generic IDE drivers installed or
>>       even compiled as they grossly interfere with the alim15x3
>>       and cause a kernel panic.
>>    My hardware is an AMD64 FX55 in a Shuttle ST20G5 case with a
>>       serial ATA harddrive.
>>    I'm using a stock 2.6.12-rc6 kernel.
>>    Debian unstable distribution.
>>
>>At first I can read from the drive fine.
>>    For instance I did two "cdparanoia -B -d /dev/hda" without
>>    a hitch. Nothing was reported in /var/log/kernel as a result.
>>
>>The problem is that I can't write to the drive (burn cds with
>>cdrecord) with causing a lost interrupt and then nothing works;
>>even reads don't respond.
>>
>>When I do:
>>    cdrecord -v -tao dev=ATAPI:/dev/hda something.iso
>>
>>I get this output:
>>   Cdrecord-Clone 2.01.01a01 (x86_64-unknown-linux-gnu) Copyright (C)
>>1995-2004 Joerg Schilling
>>   NOTE: this version of cdrecord is an inofficial (modified) release of
>>cdrecord
>>         and thus may have bugs that are not present in the original
>>version.
>>         Please send bug reports and support requests to
>><cdrtools@packages.debian.org>.
>>         The original author should not be bothered with problems of
>>this version.
>>
>>   cdrecord: Warning: Running on Linux-2.6.12-rc6-jw14
>>   cdrecord: There are unsettled issues with Linux-2.5 and newer.
>>   cdrecord: If you have unexpected problems, please try Linux-2.4 or
>>Solaris.
>>   TOC Type: 1 = CD-ROM
>>   scsidev: 'ATAPI:/dev/hda'
>>   devname: 'ATAPI:/dev/hda'
>>   scsibus: -2 target: -2 lun: -2
>>   Warning: Using ATA Packet interface.
>>   Warning: The related Linux kernel interface code seems to be
>>unmaintained.
> 
> 
> ^^^
> 
> 
>>   Warning: There is absolutely NO DMA, operations thus are slow.
> 
> 
> ^^^
> 
> What is the result of using "dev=/dev/hda" interface instead
> (as suggested by Robert)?
> 
> Bartlomiej


-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)
