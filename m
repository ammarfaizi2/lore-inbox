Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbWLNUrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWLNUrb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWLNUrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:47:31 -0500
Received: from brick.kernel.dk ([62.242.22.158]:4752 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbWLNUra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:47:30 -0500
Date: Thu, 14 Dec 2006 21:48:56 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061214204855.GQ5010@kernel.dk>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <200612142016.55286.s0348365@sms.ed.ac.uk> <20061214202854.GM5010@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214202854.GM5010@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Jens Axboe wrote:
> > I'll do that if nobody comes up with anything obvious.
> 
> If you can just test 2.6.19-git1, then we'll know if it's the SG_IO
> patch again.

Actually, you should test 2.6.19-git1 with this patch applied as well.

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 11 Dec 2006 09:01:34 +0000 (+0100)
Subject: [PATCH] fix SG_IO bio leak
X-Git-Url: http://git.home.kernel.dk/?p=linux-2.6-block.git;a=commitdiff;h=77d172ce2719b5ad2dc0637452c8871d9cba344c

[PATCH] fix SG_IO bio leak

This patch fixes bio leaks in SG_IO. rq->bio can be changed after io
completion, so we need to reset rq->bio before calling blk_rq_unmap_user()

http://marc.theaimsgroup.com/?l=linux-kernel&m=116570666807983&w=2

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
---

--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -228,6 +228,7 @@ static int sg_io(struct file *file, requ
 	struct request *rq;
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	unsigned char cmd[BLK_MAX_CDB];
+	struct bio *bio;
 
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
@@ -308,6 +309,7 @@ static int sg_io(struct file *file, requ
 	if (ret)
 		goto out;
 
+	bio = rq->bio;
 	rq->retries = 0;
 
 	start_time = jiffies;
@@ -338,6 +340,7 @@ static int sg_io(struct file *file, requ
 			hdr->sb_len_wr = len;
 	}
 
+	rq->bio = bio;
 	if (blk_rq_unmap_user(rq))
 		ret = -EFAULT;
 

-- 
Jens Axboe

