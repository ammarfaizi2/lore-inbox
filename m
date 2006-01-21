Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWAURWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWAURWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 12:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWAURWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 12:22:41 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:43992 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932212AbWAURWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 12:22:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=oXcL0hXqy1eIMzENelDI1PKYL04Z0Sq914s23mPq2L8+99HX8Io7hi0EWg5FkIg+ZrLho+ttpjaNwyc0g9k+IJ88Rqn4WyfPKHK5T1wuV8I4OQhbmBN4GbDULpb2Cn4NSyl5Fd92LpITH1lG1L59rue3eM1XNlB0dR0rSp5N9c4=
Date: Sun, 22 Jan 2006 02:22:33 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] BLOCK: use disk_stat_add instead of __disk_stat_add in __end_that_request_first
Message-ID: <20060121172233.GA18239@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike end_that_request_last, caller is supposed to own the request
when it calls __end_that_request_first and thus allowed to call from
any context without any locking.  When SCSI EH completes requests, it
calls __end_that_request_first from kernel thread context without
holding any lock and none of preemption/bh/irq disabled.  This results
in the following warning.

BUG: using smp_processor_id() in preemptible [00000001] code: scsi_eh_6/927
caller is __end_that_request_first+0xbf/0x500
 [<c01046e3>] show_trace+0x13/0x20
 [<c010470e>] dump_stack+0x1e/0x20
 [<c02231c8>] debug_smp_processor_id+0xa8/0xb0
 [<c021167f>] __end_that_request_first+0xbf/0x500
 [<c0211ad1>] end_that_request_chunk+0x11/0x20
 [<c03360b2>] scsi_end_request+0x32/0x110
-- snip --

This patch makes __end_that_request_first() use undashed
disk_stat_add() which doesn't assume preemption is disabled.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8e27d0a..eb0473b 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3153,7 +3153,7 @@ static int __end_that_request_first(stru
 	if (blk_fs_request(req) && req->rq_disk) {
 		const int rw = rq_data_dir(req);
 
-		__disk_stat_add(req->rq_disk, sectors[rw], nr_bytes >> 9);
+		disk_stat_add(req->rq_disk, sectors[rw], nr_bytes >> 9);
 	}
 
 	total_bytes = bio_nbytes = 0;
