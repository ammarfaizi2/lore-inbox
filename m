Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279170AbRKINit>; Fri, 9 Nov 2001 08:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279805AbRKINig>; Fri, 9 Nov 2001 08:38:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37387 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S279170AbRKINi0>;
	Fri, 9 Nov 2001 08:38:26 -0500
Date: Fri, 9 Nov 2001 14:37:20 +0100
From: Jens Axboe <axboe@suse.de>
To: "Ronny Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
Subject: Re: 2.4.14: crashing on heavy swap-load with SmartArray (dmesg/.config output)
Message-ID: <20011109143720.T4946@suse.de>
In-Reply-To: <3BEBD6E9.3F7F8057@eed.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <3BEBD6E9.3F7F8057@eed.ericsson.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09 2001, Ronny Lampert (EED) wrote:
[smart array crashing]

Apply this on top of 2.4.14 and you'll be fine.

-- 
Jens Axboe


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpq-dequeue-1

--- linux/drivers/block/cpqarray.c~	Thu Nov  8 11:33:11 2001
+++ linux/drivers/block/cpqarray.c	Thu Nov  8 11:35:31 2001
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

--Dxnq1zWXvFF0Q93v--
