Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWBYRpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWBYRpK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWBYRpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:45:10 -0500
Received: from lucidpixels.com ([66.45.37.187]:24471 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932680AbWBYRpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:45:08 -0500
Date: Sat, 25 Feb 2006 12:45:06 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <440083B4.3030307@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602251244070.20297@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second patch fails for me.

On a clean 2.6.15.4 source tree:

p34:/usr/src# ls -ld linux
lrwxrwxrwx  1 root src 14 2006-02-25 12:41 linux -> linux-2.6.15.4/

The one from your e-mail earlier:
p34:/usr/src/linux# patch -p1 < /tmp/patch1
patching file drivers/scsi/libata-scsi.c
Hunk #1 succeeded at 404 (offset -16 lines).
Hunk #2 succeeded at 414 (offset -16 lines).
Hunk #3 succeeded at 493 (offset -16 lines).
Hunk #4 succeeded at 505 (offset -16 lines).
Hunk #5 succeeded at 547 (offset -16 lines).
Hunk #6 succeeded at 622 (offset -16 lines).

p34:/usr/src/linux# patch -p1 < /tmp/12_libata_ata_opcode.patch
patching file drivers/scsi/libata-core.c
Hunk #1 succeeded at 245 (offset -8 lines).
Hunk #2 succeeded at 267 (offset -8 lines).
Hunk #3 succeeded at 288 (offset -8 lines).
Hunk #4 succeeded at 310 (offset -8 lines).
Hunk #5 succeeded at 500 (offset -8 lines).
Hunk #6 FAILED at 626.
1 out of 6 hunks FAILED -- saving rejects to file 
drivers/scsi/libata-core.c.rej
patching file drivers/scsi/libata-scsi.c
Hunk #1 succeeded at 414 (offset -24 lines).
Hunk #2 succeeded at 493 (offset -24 lines).
Hunk #3 FAILED at 505.
Hunk #4 succeeded at 547 (offset -24 lines).
Hunk #5 succeeded at 622 (offset -24 lines).
Hunk #6 succeeded at 1308 (offset -29 lines).
1 out of 6 hunks FAILED -- saving rejects to file 
drivers/scsi/libata-scsi.c.rej
patching file include/linux/ata.h
Hunk #1 succeeded at 239 (offset -5 lines).
patching file include/linux/libata.h
Hunk #1 succeeded at 368 (offset -52 lines).
Hunk #2 succeeded at 452 (offset -60 lines).
p34:/usr/src/linux#


Should I be using 2.6.16-rcX?

On Sat, 25 Feb 2006, Mark Lord wrote:

> David Greaves wrote:
> ..
>> Thanks Mark - I've finally gotten this patch applied.
>> 
>> With smartd disabled and no smart commands issued, a readonly badblocks
>> scan of /dev/sdb2 shows no problems and now gives:
>> Feb 25 10:38:31 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>> Error }
>> Feb 25 10:38:32 haze kernel: ata2: no sense translation for op=0x28
>> status: 0x51
>> Feb 25 10:38:32 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
>> Error }
>> Feb 25 10:38:35 haze kernel: ata2: no sense translation for op=0x28
>> status: 0x51
>> hundreds of times.
> ..
>
> Mmmm.. okay, it's happening due to a SCSI READ_10 opcode,
> which means it isn't being triggered by any of the FUA stuff.
>
> But there's still no obvious reason for the error.
> The drive is basically just saying "command rejected",
> and libata-scsi is translating that into "medium error"
> for some unknown reason.
>
> Unfortunately, the design of the current libata is such that
> we no longer have access to the actual ATA opcode that was rejected.
> It gets overwritten by the returned drive status on completion.
>
> So.. I need to generate another patch for you now, to save/show
> the real ATA opcode that was used to cause the errors.
> My theory is that we'll discover that it is one that your drive
> legitimately is rejecting (unsupported LBA48 or something..).
>
> But we won't know until we see the output.
>
> Second patch is attached:  apply *in addition* to the first one.
>
> Cheers
>
>
