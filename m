Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUCDTKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUCDTKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:10:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:51677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262076AbUCDTKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:10:07 -0500
Date: Thu, 4 Mar 2004 11:12:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rui Saraiva <rmps@joel.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm2: 3 dumps at __make_request, system freeze
Message-Id: <20040304111204.6db8bd6e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403041834350.28568@joel.ist.utl.pt>
References: <Pine.LNX.4.58.0403041834350.28568@joel.ist.utl.pt>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Saraiva <rmps@joel.ist.utl.pt> wrote:
>
> Yesterday I got these 3 dumps (on dmesg) while compiling (on ext3 fs) the
> kernel and some other userland utilities. 

Could you please add this?

--- 25/drivers/block/ll_rw_blk.c~blk-unplug-when-max-request-queued-fix	Wed Mar  3 16:03:01 2004
+++ 25-akpm/drivers/block/ll_rw_blk.c	Wed Mar  3 16:03:32 2004
@@ -2004,7 +2004,8 @@ EXPORT_SYMBOL(__blk_attempt_remerge);
 
 static int __make_request(request_queue_t *q, struct bio *bio)
 {
-	struct request *req, *freereq = NULL;
+	struct request *req = NULL;
+	struct request *freereq = NULL;
 	int el_ret, rw, nr_sectors, cur_nr_sectors, barrier, ra;
 	sector_t sector;
 
@@ -2154,7 +2155,7 @@ out:
 		int nr_queued = q->rq.count[READ] + q->rq.count[WRITE];
 
 		if (nr_queued == q->unplug_thresh ||
-				req->nr_sectors == q->max_sectors)
+				(req && req->nr_sectors == q->max_sectors))
 			__generic_unplug_device(q);
 	}
 	spin_unlock_irq(q->queue_lock);

_

