Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWAQKDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWAQKDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAQKDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:03:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932373AbWAQKDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:03:08 -0500
Date: Tue, 17 Jan 2006 11:05:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 __disk_stat_add() called without preempt disabled
Message-ID: <20060117100508.GE3945@suse.de>
References: <13179.1137398969@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13179.1137398969@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2006, Keith Owens wrote:
> 2.6.15 on ia64, gcc 3.3.3, CONFIG_PREEMPT_DEBUG=y.
> 
> scsi(0): Resetting Cmnd=0xe00000b479ea7810, Handle=0x0000000000000001, action=0x0
> scsi(0): Resetting Cmnd=0xe00000b479ea79e8, Handle=0x0000000000000002, action=0x0
> scsi(0): Resetting Cmnd=0xe00000b479ea63c8, Handle=0x0000000000000003, action=0x0
> scsi(0): Resetting Cmnd=0xe00000b479ea7810, Handle=0x0000000000000202, action=0x2
> scsi(0:0:2:0): Queueing device reset command.
> qla2300 0000:03:01.0: Mailbox command timeout occured. Issuing ISP abort.
> qla2300 0000:03:01.0: Performing ISP error recovery - ha= e0000034790b4518.
> scsi(0): mailbox timed out, mailbox0 4000, ictrl 0006, istatus 6006
> qla2300 0000:03:01.0: LIP reset occured (f7f7).
> qla2300 0000:03:01.0: LOOP UP detected (2 Gbps).
> qla2300 0000:03:01.0: scsi(2:2:1): Abort command issued -- 2ea 2003.
> sd 2:0:2:1: scsi: Device offlined - not ready after error recovery
> sd 2:0:2:1: scsi: Device offlined - not ready after error recovery
> BUG: using smp_processor_id() in preemptible [00000001] code: scsi_eh_2/4665
> caller is __end_that_request_first+0x1b0/0x8e0
> 
> Call Trace:
>  [<a000000100013280>] show_stack+0x40/0xa0
>                                 sp=e00000b007dbfc00 bsp=e00000b007db90e8
>  [<a000000100013b10>] dump_stack+0x30/0x60
>                                 sp=e00000b007dbfdd0 bsp=e00000b007db90d0
>  [<a0000001003d7880>] debug_smp_processor_id+0x160/0x1a0
>                                 sp=e00000b007dbfdd0 bsp=e00000b007db90b0
>  [<a000000100399c90>] __end_that_request_first+0x1b0/0x8e0
>                                 sp=e00000b007dbfdd0 bsp=e00000b007db9028

Hmm indeed, we are not necessarily atomic there, it's quite ok to be
called with preemption+interrupts enabled.

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index bfcde0f..d715b0b 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3195,7 +3195,7 @@ static int __end_that_request_first(stru
 	if (blk_fs_request(req) && req->rq_disk) {
 		const int rw = rq_data_dir(req);
 
-		__disk_stat_add(req->rq_disk, sectors[rw], nr_bytes >> 9);
+		disk_stat_add(req->rq_disk, sectors[rw], nr_bytes >> 9);
 	}
 
 	total_bytes = bio_nbytes = 0;

-- 
Jens Axboe

