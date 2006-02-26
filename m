Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWBZC2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWBZC2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWBZC2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:28:01 -0500
Received: from rtr.ca ([64.26.128.89]:47317 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751173AbWBZC2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:28:00 -0500
Message-ID: <4401122A.3010908@rtr.ca>
Date: Sat, 25 Feb 2006 21:27:54 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com>
In-Reply-To: <4400B439.8050202@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
>
> Linux haze 2.6.16-rc4patched #1 PREEMPT Sat Feb 25 19:29:11 UTC 2006
> i686 GNU/Linux
> 
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: error=0x04 { DriveStatusError }
> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
> ata2: status=0x51 { DriveReady SeekComplete Error }
> ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
> ata2: status=0x51 { DriveReady SeekComplete Error }
> sd 1:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sdb, sector 398283329
> raid1: Disk failure on sdb2, disabling device.
>         Operation continuing on 1 devices

Oh good, *now* we've gotten somewhere!!

Albert / Jens / Jeff:

The command failing above is SCSI WRITE_10, which is being
translated into ATA_CMD_WRITE_FUA_EXT by libata.

This command fails -- unrecognized by the drive in question.
But libata reports it (most incorrectly) as a "medium error",
and the drive is taken out of service from its RAID.

Bad, bad, and worse.

Libata should really recover from this, by recognizing that
the command was rejected, and replacing it with a simple
WRITE_EXT instead.  Possibly followed by FLUSH_CACHE.

So.. I've forgotten who put FUA into libata, but hopefully
it's one of the folks on the CC: list, and that nice person
can now generate a patch to fix this bug somehow.

Cheers
