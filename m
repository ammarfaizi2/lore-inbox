Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280690AbRKBNhM>; Fri, 2 Nov 2001 08:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280691AbRKBNhD>; Fri, 2 Nov 2001 08:37:03 -0500
Received: from 32.ppp1-4.ski.worldonline.dk ([212.54.90.160]:27264 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280690AbRKBNg5>; Fri, 2 Nov 2001 08:36:57 -0500
Date: Fri, 2 Nov 2001 14:36:39 +0100
From: Jens Axboe <axboe@suse.de>
To: "White, Charles" <Charles.White@COMPAQ.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] cpqarray + cciss bugs/cleanups
Message-ID: <20011102143639.E608@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

It's bothered me for some time that cpqarray and cciss release the
request command before completing the command. This doesn't really break
anything in 2.4, but it can later be a bug. Other things:

- Not releasing request on error
- Queueing loop cleanup and optimization
- io_request_lock dropped when not needed
- Don't calculate sector size of request, we already know it

-- 
Jens Axboe


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpqarray-cciss-1

diff -u /opt/kernel/linux-2.4.14-pre7/drivers/block/cciss.c linux/drivers/block/cciss.c
--- /opt/kernel/linux-2.4.14-pre7/drivers/block/cciss.c	Wed Oct 31 09:39:12 2001
+++ linux/drivers/block/cciss.c	Fri Nov  2 14:32:47 2001
@@ -1214,7 +1214,12 @@
 				status=0;
 		}
 	}
-	complete_buffers(cmd->bh, status);
+	complete_buffers(cmd->rq->bh, status);
+
+#ifdef CCISS_DEBUG
+	printk("Done with %p\n", cmd->rq);
+#endif /* CCISS_DEBUG */ 
+	end_that_request_last(cmd->rq);
 }
 
 
@@ -1269,7 +1274,7 @@
 {
 	ctlr_info_t *h= q->queuedata; 
 	CommandList_struct *c;
-	int log_unit, start_blk, seg, sect;
+	int log_unit, start_blk, seg;
 	char *lastdataend;
 	struct buffer_head *bh;
 	struct list_head *queue_head = &q->queue_head;
@@ -1278,13 +1283,12 @@
 	struct my_sg tmp_sg[MAXSGENTRIES];
 	int i;
 
-    // Loop till the queue is empty if or it is plugged
-    while (1)
-    {
-	if (q->plugged || list_empty(queue_head)) {
-                start_io(h);
-                return;
-        }
+	if (q->plugged)
+		goto startio;
+
+queue_next:
+	if (list_empty(queue_head))
+		goto startio;
 
 	creq =	blkdev_entry_next_request(queue_head); 
 	if (creq->nr_segments > MAXSGENTRIES)
@@ -1296,17 +1300,18 @@
                                 h->ctlr, creq->rq_dev, creq);
                 blkdev_dequeue_request(creq);
                 complete_buffers(creq->bh, 0);
-                start_io(h);
-                return;
+		end_that_request_last(creq);
+		goto startio;
         }
 
 	if (( c = cmd_alloc(h, 1)) == NULL)
-	{
-		start_io(h);
-		return;
-	}
+		goto startio;
+
+	spin_unlock_irq(&io_request_lock);
+
 	c->cmd_type = CMD_RWREQ;      
-	bh = c->bh = creq->bh;
+	bh = creq->bh;
+	c->rq = creq;
 	
 	/* fill in the request */ 
 	log_unit = MINOR(creq->rq_dev) >> NWD_SHIFT; 
@@ -1330,10 +1335,8 @@
 #endif /* CCISS_DEBUG */
 	seg = 0; 
 	lastdataend = NULL;
-	sect = 0;
 	while(bh)
 	{
-		sect += bh->b_size/512;
 		if (bh->b_data == lastdataend)
 		{  // tack it on to the last segment 
 			tmp_sg[seg-1].len +=bh->b_size;
@@ -1367,7 +1370,7 @@
 		h->maxSG = seg; 
 
 #ifdef CCISS_DEBUG
-	printk(KERN_DEBUG "cciss: Submitting %d sectors in %d segments\n", sect, seg);
+	printk(KERN_DEBUG "cciss: Submitting %d sectors in %d segments\n", creq->nr_sectors, seg);
 #endif /* CCISS_DEBUG */
 
 	c->Header.SGList = c->Header.SGTotal = seg;
@@ -1377,28 +1380,26 @@
 	c->Request.CDB[4]= (start_blk >>  8) & 0xff;
 	c->Request.CDB[5]= start_blk & 0xff;
 	c->Request.CDB[6]= 0; // (sect >> 24) & 0xff; MSB
-	c->Request.CDB[7]= (sect >>  8) & 0xff; 
-	c->Request.CDB[8]= sect & 0xff; 
+	c->Request.CDB[7]= (creq->nr_sectors >>  8) & 0xff; 
+	c->Request.CDB[8]= creq->nr_sectors & 0xff; 
 	c->Request.CDB[9] = c->Request.CDB[11] = c->Request.CDB[12] = 0;
 
-			
+	spin_lock_irq(&io_request_lock);
+
 	blkdev_dequeue_request(creq);
 
-	
         /*
          * ehh, we can't really end the request here since it's not
          * even started yet. for now it shouldn't hurt though
          */
-#ifdef CCISS_DEBUG
-	printk("Done with %p\n", creq);
-#endif /* CCISS_DEBUG */ 
-	end_that_request_last(creq);
-
 	addQ(&(h->reqQ),c);
 	h->Qdepth++;
 	if(h->Qdepth > h->maxQsinceinit)
 		h->maxQsinceinit = h->Qdepth; 
-   }  // while loop
+
+	goto queue_next;
+startio:
+	start_io(h);
 }
 
 static void do_cciss_intr(int irq, void *dev_id, struct pt_regs *regs)
diff -u /opt/kernel/linux-2.4.14-pre7/drivers/block/cciss_cmd.h linux/drivers/block/cciss_cmd.h
--- /opt/kernel/linux-2.4.14-pre7/drivers/block/cciss_cmd.h	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cciss_cmd.h	Fri Nov  2 14:24:35 2001
@@ -228,7 +228,7 @@
   int			   cmd_type; 
   struct _CommandList_struct *prev;
   struct _CommandList_struct *next;
-  struct buffer_head *	   bh;
+  struct request *	   rq;
 } CommandList_struct;
 
 //Configuration Table Structure
diff -u /opt/kernel/linux-2.4.14-pre7/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- /opt/kernel/linux-2.4.14-pre7/drivers/block/cpqarray.c	Wed Oct 31 09:39:12 2001
+++ linux/drivers/block/cpqarray.c	Fri Nov  2 14:32:47 2001
@@ -911,21 +911,19 @@
 {
 	ctlr_info_t *h = q->queuedata;
 	cmdlist_t *c;
-	int seg, sect;
 	char *lastdataend;
 	struct list_head * queue_head = &q->queue_head;
 	struct buffer_head *bh;
 	struct request *creq;
 	struct my_sg tmp_sg[SG_MAX];
-	int i;
+	int i, seg;
 
-// Loop till the queue is empty if or it is plugged 
-   while (1)
-{
-	if (q->plugged || list_empty(queue_head)) {
-		start_io(h);
-		return;
-	}
+	if (q->plugged)
+		goto startio;
+
+queue_next:
+	if (list_empty(queue_head))
+		goto startio;
 
 	creq = blkdev_entry_next_request(queue_head);
 	if (creq->nr_segments > SG_MAX)
@@ -937,15 +935,14 @@
 				h->ctlr, creq->rq_dev, creq);
 		blkdev_dequeue_request(creq);
 		complete_buffers(creq->bh, 0);
-		start_io(h);
-                return;
+		end_that_request_last(creq);
+		goto startio;
 	}
 
 	if ((c = cmd_alloc(h,1)) == NULL)
-	{
-                start_io(h);
-                return;
-        }
+		goto startio;
+
+	spin_unlock_irq(&io_request_lock);
 
 	bh = creq->bh;
 
@@ -955,7 +952,7 @@
 	c->size += sizeof(rblk_t);
 
 	c->req.hdr.blk = ida[(h->ctlr<<CTLR_SHIFT) + MINOR(creq->rq_dev)].start_sect + creq->sector;
-	c->bh = bh;
+	c->rq = creq;
 DBGPX(
 	if (bh == NULL)
 		panic("bh == NULL?");
@@ -963,9 +960,7 @@
 	printk("sector=%d, nr_sectors=%d\n", creq->sector, creq->nr_sectors);
 );
 	seg = 0; lastdataend = NULL;
-	sect = 0;
 	while(bh) {
-		sect += bh->b_size/512;
 		if (bh->b_data == lastdataend) {
 			tmp_sg[seg-1].size += bh->b_size;
 			lastdataend += bh->b_size;
@@ -991,26 +986,12 @@
 	}
 DBGPX(	printk("Submitting %d sectors in %d segments\n", sect, seg); );
 	c->req.hdr.sg_cnt = seg;
-	c->req.hdr.blk_cnt = sect;
+	c->req.hdr.blk_cnt = creq->nr_sectors;
 
-	/*
-	 * Since we control our own merging, we know that this request
-	 * is now fully setup and there's nothing left.
-         */
-	if (creq->nr_sectors != sect) {
-		printk("ida: %ld != %d sectors\n", creq->nr_sectors, sect);
-		BUG();
-	}
+	spin_lock_irq(&io_request_lock);
 
 	blkdev_dequeue_request(creq);
 
-	/*
-	 * ehh, we can't really end the request here since it's not
-	 * even started yet. for now it shouldn't hurt though
-	 */
-DBGPX(	printk("Done with %p\n", creq); );
-	end_that_request_last(creq);
-
 	c->req.hdr.cmd = (creq->cmd == READ) ? IDA_READ : IDA_WRITE;
 	c->type = CMD_RWREQ;
 
@@ -1019,7 +1000,11 @@
 	h->Qdepth++;
 	if (h->Qdepth > h->maxQsinceinit) 
 		h->maxQsinceinit = h->Qdepth;
-   } // while loop
+
+	goto queue_next;
+
+startio:
+	start_io(h);
 }
 
 /* 
@@ -1096,7 +1081,13 @@
                         cmd->req.sg[i].addr, cmd->req.sg[i].size,
                         (cmd->req.hdr.cmd == IDA_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
         }
-	complete_buffers(cmd->bh, ok);
+
+	complete_buffers(cmd->rq->bh, ok);
+
+	DBGPX(printk("Done with %p\n", cmd->rq););
+	end_that_request_last(cmd->rq);
+
+
 }
 
 /*
diff -u /opt/kernel/linux-2.4.14-pre7/drivers/block/ida_cmd.h linux/drivers/block/ida_cmd.h
--- /opt/kernel/linux-2.4.14-pre7/drivers/block/ida_cmd.h	Wed Jul 25 23:12:01 2001
+++ linux/drivers/block/ida_cmd.h	Fri Nov  2 14:24:20 2001
@@ -93,7 +93,7 @@
 	int	ctlr;
 	struct cmdlist *prev;
 	struct cmdlist *next;
-	struct buffer_head *bh;
+	struct request *rq;
 	int type;
 } cmdlist_t;
 	

--qDbXVdCdHGoSgWSk--
