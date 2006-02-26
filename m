Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWBZM1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWBZM1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWBZM1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:27:08 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:30985 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751077AbWBZM1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:27:06 -0500
Message-ID: <44019E96.20804@superbug.co.uk>
Date: Sun, 26 Feb 2006 12:27:02 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca>
In-Reply-To: <4401122A.3010908@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> David Greaves wrote:
>>
>> Linux haze 2.6.16-rc4patched #1 PREEMPT Sat Feb 25 19:29:11 UTC 2006
>> i686 GNU/Linux
>>
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: error=0x04 { DriveStatusError }
>> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> sd 1:0:0:0: SCSI error: return code = 0x8000002
>> sdb: Current: sense key: Medium Error
>>     Additional sense: Unrecovered read error - auto reallocate failed
>> end_request: I/O error, dev sdb, sector 398283329
>> raid1: Disk failure on sdb2, disabling device.
>>         Operation continuing on 1 devices
>
> Oh good, *now* we've gotten somewhere!!
>
> Albert / Jens / Jeff:
>
> The command failing above is SCSI WRITE_10, which is being
> translated into ATA_CMD_WRITE_FUA_EXT by libata.
>
> This command fails -- unrecognized by the drive in question.
> But libata reports it (most incorrectly) as a "medium error",
> and the drive is taken out of service from its RAID.
>
> Bad, bad, and worse.
>

I have what looks like similar problems. The issue I have is that I 
don't think the problem is ONLY libata related.
I have two linux PCs. One called "games", the other called "localhost".
The problem happens quite quickly on the old "games" machine, but I can 
run for days/weeks until I see the problem on the "localhost".
It might be happening on the "localhost", but I am just not noticing. 
The difference being that if reiserfs sees this error, it cannot 
recover, and I have reiserfs on the "games" machine. The "localhost" 
only uses ext3, and ext3 recovers gracefully from this problem.
Can I use libata on this old "games" machine? It is an old Pentium 3 
machine.
In any case, The "games" machine is currently switched off until I can 
find a kernel that works, so I will happily test different kernels and 
patches, if people have suggestions.

I have two desktop linux machines. One is an old Pentium 3 which shows 
the following errors(no libata involved):
Linux version 2.6.15-rc4 (root@games) (gcc version 4.0.3 20051111 
(prerelease) (Debian 4.0.2-4)
) #1 Sat Dec 3 18:47:19 GMT 2005
Dec 16 22:51:57 games kernel: hdc: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x40 { 
UncorrectableError }, LBAsect=53058185, sector=53057951
Dec 16 22:52:32 games kernel: ide: failed opcode was: unknown
Dec 16 22:52:32 games kernel: end_request: I/O error, dev hdc, sector 
53057951
Dec 16 22:52:32 games kernel: hdc: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=53058185, sector=53057959
Dec 16 22:52:32 games kernel: ide: failed opcode was: unknown

The other has the following errors:
Linux version 2.6.15.1 (root@localhost) (gcc version 3.4.5 (Gentoo 
3.4.5, ssp-3.4.5-1.0, pi
e-8.7.9)) #3 SMP PREEMPT Fri Feb 3 23:19:05 GMT 2006
Feb 10 23:30:07 localhost kernel: ata3: command 0xb0 timeout, stat 0xd0 
host_stat 0x0
Feb 10 23:30:07 localhost kernel: ata3: translated ATA stat/err 0xd0/00 
to SCSI SK/ASC/ASCQ 0xb/47/00
Feb 10 23:30:07 localhost kernel: ata3: status=0xd0 { Busy }
Feb 10 23:30:07 localhost kernel: ATA: abnormal status 0xD0 on port 
0xF880E087
Feb 10 23:30:07 localhost last message repeated 3 times
Feb 10 23:30:10 localhost kernel: ata3: PIO error
Feb 10 23:30:10 localhost kernel: ata3: status=0x50 { DriveReady 
SeekComplete }
Feb 11 10:18:10 localhost kernel: ata2: command 0xb0 timeout, stat 0xd0 
host_stat 0x0
Feb 11 10:18:10 localhost kernel: ata2: translated ATA stat/err 0xd0/00 
to SCSI SK/ASC/ASCQ 0xb/47/00
Feb 11 10:18:10 localhost kernel: ata2: status=0xd0 { Busy }
Feb 11 10:18:10 localhost kernel: ATA: abnormal status 0xD0 on port 0x177
Feb 11 10:18:10 localhost last message repeated 3 times


