Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281506AbRKHKgr>; Thu, 8 Nov 2001 05:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281509AbRKHKgh>; Thu, 8 Nov 2001 05:36:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25351 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281506AbRKHKg0>;
	Thu, 8 Nov 2001 05:36:26 -0500
Date: Thu, 8 Nov 2001 11:36:15 +0100
From: Jens Axboe <axboe@suse.de>
To: J Sloan <jjs@pobox.com>
Cc: J Sloan <jjs@lexus.com>, Robert Love <rml@tech9.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: preempt-patch cleared of blame
Message-ID: <20011108113615.F27652@suse.de>
In-Reply-To: <3BE8B460.A23E1A67@pobox.com> <1005109646.884.0.camel@phantasy> <3BE9A506.82D64AE4@lexus.com> <3BEA0078.F938623B@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <3BEA0078.F938623B@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07 2001, J Sloan wrote:
> I think there may be a problem with the
> compaq smart/2p raid drivers, since
> the "do_ida_intr" code keeps showing
> up in the oops, and I have not seen a
> problem with 2.4.14 on any other system.

Does this fix it?

-- 
Jens Axboe


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpq-dequeue-1

--- drivers/block/cpqarray.c~	Thu Nov  8 11:33:11 2001
+++ drivers/block/cpqarray.c	Thu Nov  8 11:35:31 2001
@@ -942,6 +942,8 @@
 	if ((c = cmd_alloc(h,1)) == NULL)
 		goto startio;
 
+	blkdev_dequeue_request(creq);
+
 	spin_unlock_irq(&io_request_lock);
 
 	bh = creq->bh;
@@ -987,13 +989,10 @@
 DBGPX(	printk("Submitting %d sectors in %d segments\n", sect, seg); );
 	c->req.hdr.sg_cnt = seg;
 	c->req.hdr.blk_cnt = creq->nr_sectors;
-
-	spin_lock_irq(&io_request_lock);
-
-	blkdev_dequeue_request(creq);
-
 	c->req.hdr.cmd = (creq->cmd == READ) ? IDA_READ : IDA_WRITE;
 	c->type = CMD_RWREQ;
+
+	spin_lock_irq(&io_request_lock);
 
 	/* Put the request on the tail of the request queue */
 	addQ(&h->reqQ, c);

--HlL+5n6rz5pIUxbD--
