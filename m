Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVCCHEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVCCHEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVCCHAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 02:00:23 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:29792 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261545AbVCCG5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:57:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fEpOOC/rHMC6w0KBZO/Kxyb+Y/FZv82BXI1uPZfGykxu8/viLHbc/CpyM3pkCSC3j4DvU1tnU8uFOf6CDyTzZl3cFne9FlKfY/A7ubRrMHxSuiC5Sh6iwRzGWJ9Mrn5sHeFBLrnNTe7XwUTgrLg2geY4jhvdfgSY40Rk1ToQ9EM=
Message-ID: <4226B54E.6020709@gmail.com>
Date: Thu, 03 Mar 2005 15:57:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH ide-dev-2.6] ide: ide_dma_intr oops fix
References: <20050303030318.GA25410@htj.dyndns.org> <20050303064925.GB19505@suse.de>
In-Reply-To: <20050303064925.GB19505@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello, Jens.

Jens Axboe wrote:
> On Thu, Mar 03 2005, Tejun Heo wrote:
> 
>> Hello, Bartlomiej.
>>
>> This patch fixes ide_dma_intr() oops which occurs for TASKFILE ioctl
>>using DMA dataphses.  This is against the latest ide-dev-2.6 tree +
>>all your recent 9 patches.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>Index: linux-taskfile-ng/drivers/ide/ide-dma.c
>>===================================================================
>>--- linux-taskfile-ng.orig/drivers/ide/ide-dma.c	2005-03-03 11:59:16.485582413 +0900
>>+++ linux-taskfile-ng/drivers/ide/ide-dma.c	2005-03-03 12:00:07.753376048 +0900
>>@@ -175,10 +175,14 @@ ide_startstop_t ide_dma_intr (ide_drive_
>> 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
>> 		if (!dma_stat) {
>> 			struct request *rq = HWGROUP(drive)->rq;
>>-			ide_driver_t *drv;
>> 
>>-			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
>>-			drv->end_request(drive, 1, rq->nr_sectors);
>>+			if (rq->rq_disk) {
>>+				ide_driver_t *drv;
>>+
>>+				drv = *(ide_driver_t **)rq->rq_disk->private_data;;
>>+				drv->end_request(drive, 1, rq->nr_sectors);
>>+			} else
>>+				ide_end_request(drive, 1, rq->nr_sectors);
>> 			return ide_stopped;
>> 		}
>> 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
> 
> Why not just set rq_disk for taskfile requests as well, seems a lot
> cleaner than special casing the end_request handling.

  Just because other places were fixed this way and the whole drive 
command issue/completion codes are just about to be restructured.  Above 
code will go away soon.  Please consider it a quick fix.

  Thanks.

-- 
tejun

