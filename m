Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265015AbRFZQWq>; Tue, 26 Jun 2001 12:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbRFZQWa>; Tue, 26 Jun 2001 12:22:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11535 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265015AbRFZQWO>;
	Tue, 26 Jun 2001 12:22:14 -0400
Date: Tue, 26 Jun 2001 18:22:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: patch: highmem zero-bounce
Message-ID: <20010626182215.C14460@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I updated the patches to 2.4.6-pre5, and removed the zone-dma32
addition. This means that machines with > 4GB of RAM will need to go all
the way to low mem for bounces. I did this for several reasons:

- Linus didn't like the extra zone, so I'm probably redoing it the way
  he suggested.
- The current version had a bug that prevented 64GB highmem working.

The core has received no other updates that removal of GFP_DMA32 parts
and gfp_mask for bouncing.

I can't put the patch on kernel.org atm, so I've just attached it here.
It's not that big anyway. As soon as I can log back in, I'll post it
there too.

-- 
Jens Axboe


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=block-highmem-all-6

diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/cciss.c linux/drivers/block/cciss.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/cciss.c	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cciss.c	Mon May 28 02:32:42 2001
@@ -1124,7 +1124,7 @@
 	{
 		temp64.val32.lower = cmd->SG[i].Addr.lower;
 		temp64.val32.upper = cmd->SG[i].Addr.upper;
-		pci_unmap_single(hba[cmd->ctlr]->pdev,
+		pci_unmap_page(hba[cmd->ctlr]->pdev,
 			temp64.val, cmd->SG[i].Len, 
 			(cmd->Request.Type.Direction == XFER_READ) ? 
 				PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
@@ -1220,7 +1220,7 @@
 static int cpq_back_merge_fn(request_queue_t *q, struct request *rq,
                              struct buffer_head *bh, int max_segments)
 {
-        if (rq->bhtail->b_data + rq->bhtail->b_size == bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(bh))
                 return 1;
         return cpq_new_segment(q, rq, max_segments);
 }
@@ -1228,7 +1228,7 @@
 static int cpq_front_merge_fn(request_queue_t *q, struct request *rq,
                              struct buffer_head *bh, int max_segments)
 {
-        if (bh->b_data + bh->b_size == rq->bh->b_data)
+	if (bh_bus(bh) + bh->b_size == bh_bus(rq->bh))
                 return 1;
         return cpq_new_segment(q, rq, max_segments);
 }
@@ -1238,7 +1238,7 @@
 {
         int total_segments = rq->nr_segments + nxt->nr_segments;
 
-        if (rq->bhtail->b_data + rq->bhtail->b_size == nxt->bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(nxt->bh))
                 total_segments--;
 
         if (total_segments > MAXSGENTRIES)
@@ -1259,7 +1259,7 @@
 	ctlr_info_t *h= q->queuedata; 
 	CommandList_struct *c;
 	int log_unit, start_blk, seg, sect;
-	char *lastdataend;
+	unsigned long lastdataend;
 	struct buffer_head *bh;
 	struct list_head *queue_head = &q->queue_head;
 	struct request *creq;
@@ -1267,10 +1267,15 @@
 	struct my_sg tmp_sg[MAXSGENTRIES];
 	int i;
 
-    // Loop till the queue is empty if or it is plugged
+	if (q->plugged) {
+		start_io(h);
+		return;
+	}
+
+    // Loop till the queue is empty
     while (1)
     {
-	if (q->plugged || list_empty(queue_head)) {
+	if (list_empty(queue_head)) {
                 start_io(h);
                 return;
         }
@@ -1318,12 +1323,12 @@
 		(int) creq->nr_sectors);	
 #endif /* CCISS_DEBUG */
 	seg = 0; 
-	lastdataend = NULL;
+	lastdataend = 0;
 	sect = 0;
 	while(bh)
 	{
 		sect += bh->b_size/512;
-		if (bh->b_data == lastdataend)
+		if (bh_bus(bh) == lastdataend)
 		{  // tack it on to the last segment 
 			tmp_sg[seg-1].len +=bh->b_size;
 			lastdataend += bh->b_size;
@@ -1331,9 +1336,10 @@
 		{
 			if (seg == MAXSGENTRIES)
 				BUG();
+			tmp_sg[seg].page = bh->b_page;
 			tmp_sg[seg].len = bh->b_size;
-			tmp_sg[seg].start_addr = bh->b_data;
-			lastdataend = bh->b_data + bh->b_size;
+			tmp_sg[seg].offset = bh_offset(bh);
+			lastdataend = bh_bus(bh) + bh->b_size;
 			seg++;
 		}
 		bh = bh->b_reqnext;
@@ -1342,9 +1348,8 @@
 	for (i=0; i<seg; i++)
 	{
 		c->SG[i].Len = tmp_sg[i].len;
-		temp64.val = (__u64) pci_map_single( h->pdev,
-			tmp_sg[i].start_addr,
-			tmp_sg[i].len,
+		temp64.val = (__u64) pci_map_page( h->pdev,
+			tmp_sg[i].page, tmp_sg[i].len, tmp_sg[i].offset,
 			(c->Request.Type.Direction == XFER_READ) ? 
                                 PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
 		c->SG[i].Addr.lower = temp64.val32.lower;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/cciss.h linux/drivers/block/cciss.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/cciss.h	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cciss.h	Mon May 28 02:29:48 2001
@@ -16,8 +16,9 @@
 #define MAJOR_NR COMPAQ_CISS_MAJOR 
 
 struct my_sg {
-	int len;
-	char *start_addr;
+	struct page *page;
+	unsigned short len;
+	unsigned short offset;
 };
 
 struct ctlr_info;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/cpqarray.c	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cpqarray.c	Mon May 28 02:33:10 2001
@@ -363,7 +363,7 @@
 static int cpq_back_merge_fn(request_queue_t *q, struct request *rq,
 			     struct buffer_head *bh, int max_segments)
 {
-	if (rq->bhtail->b_data + rq->bhtail->b_size == bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(bh))
 		return 1;
 	return cpq_new_segment(q, rq, max_segments);
 }
@@ -371,7 +371,7 @@
 static int cpq_front_merge_fn(request_queue_t *q, struct request *rq,
 			     struct buffer_head *bh, int max_segments)
 {
-	if (bh->b_data + bh->b_size == rq->bh->b_data)
+	if (bh_bus(bh) + bh->b_size == bh_bus(rq->bh))
 		return 1;
 	return cpq_new_segment(q, rq, max_segments);
 }
@@ -381,7 +381,7 @@
 {
 	int total_segments = rq->nr_segments + nxt->nr_segments;
 
-	if (rq->bhtail->b_data + rq->bhtail->b_size == nxt->bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(nxt->bh))
 		total_segments--;
 
 	if (total_segments > SG_MAX)
@@ -528,6 +528,7 @@
 		q = BLK_DEFAULT_QUEUE(MAJOR_NR + i);
 		q->queuedata = hba[i];
 		blk_init_queue(q, do_ida_request);
+		blk_queue_bounce_limit(q, BLK_BOUNCE_4G);
 		blk_queue_headactive(q, 0);
 		blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
 		hardsect_size[MAJOR_NR+i] = ida_hardsizes + (i*256);
@@ -919,17 +920,22 @@
 	ctlr_info_t *h = q->queuedata;
 	cmdlist_t *c;
 	int seg, sect;
-	char *lastdataend;
+	unsigned long lastdataend;
 	struct list_head * queue_head = &q->queue_head;
 	struct buffer_head *bh;
 	struct request *creq;
 	struct my_sg tmp_sg[SG_MAX];
 	int i;
 
-// Loop till the queue is empty if or it is plugged 
+	if (q->plugged) {
+		start_io(h);
+		return;
+	}
+
+// Loop till the queue is empty
    while (1)
 {
-	if (q->plugged || list_empty(queue_head)) {
+	if (list_empty(queue_head)) {
 		start_io(h);
 		return;
 	}
@@ -969,19 +975,20 @@
 	
 	printk("sector=%d, nr_sectors=%d\n", creq->sector, creq->nr_sectors);
 );
-	seg = 0; lastdataend = NULL;
+	seg = lastdataend = 0;
 	sect = 0;
 	while(bh) {
 		sect += bh->b_size/512;
-		if (bh->b_data == lastdataend) {
+		if (bh_bus(bh) == lastdataend) {
 			tmp_sg[seg-1].size += bh->b_size;
 			lastdataend += bh->b_size;
 		} else {
 			if (seg == SG_MAX)
 				BUG();
+			tmp_sg[seg].page = bh->b_page;
 			tmp_sg[seg].size = bh->b_size;
-			tmp_sg[seg].start_addr = bh->b_data;
-			lastdataend = bh->b_data + bh->b_size;
+			tmp_sg[seg].offset = bh_offset(bh);
+			lastdataend = bh_bus(bh) + bh->b_size;
 			seg++;
 		}
 		bh = bh->b_reqnext;
@@ -990,9 +997,9 @@
 	for( i=0; i < seg; i++)
 	{
 		c->req.sg[i].size = tmp_sg[i].size;
-		c->req.sg[i].addr = (__u32) pci_map_single(
-                		h->pci_dev, tmp_sg[i].start_addr, 
-				tmp_sg[i].size,
+		c->req.sg[i].addr = (__u32) pci_map_page(
+                		h->pci_dev, tmp_sg[i].page, tmp_sg[i].size,
+				tmp_sg[i].offset,
                                 (creq->cmd == READ) ? 
 					PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
 	}
@@ -1099,7 +1106,7 @@
 	/* unmap the DMA mapping for all the scatter gather elements */
         for(i=0; i<cmd->req.hdr.sg_cnt; i++)
         {
-                pci_unmap_single(hba[cmd->ctlr]->pci_dev,
+                pci_unmap_page(hba[cmd->ctlr]->pci_dev,
                         cmd->req.sg[i].addr, cmd->req.sg[i].size,
                         (cmd->req.hdr.cmd == IDA_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
         }
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/cpqarray.h linux/drivers/block/cpqarray.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/cpqarray.h	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cpqarray.h	Mon May 28 02:25:18 2001
@@ -57,8 +57,9 @@
 #ifdef __KERNEL__
 
 struct my_sg {
-	int size;
-	char *start_addr;
+	struct page *page;
+	unsigned short size;
+	unsigned short offset;
 };
 
 struct ctlr_info;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/elevator.c	Fri Feb 16 01:58:34 2001
+++ linux/drivers/block/elevator.c	Mon May 28 17:56:24 2001
@@ -110,7 +110,6 @@
 			break;
 		} else if (__rq->sector - count == bh->b_rsector) {
 			ret = ELEVATOR_FRONT_MERGE;
-			__rq->elevator_sequence -= count;
 			*req = __rq;
 			break;
 		}
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/ll_rw_blk.c	Tue Jun 26 00:15:57 2001
+++ linux/drivers/block/ll_rw_blk.c	Tue Jun 26 18:01:02 2001
@@ -22,6 +22,7 @@
 #include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/bootmem.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -129,6 +130,7 @@
 static int high_queued_sectors, low_queued_sectors;
 static int batch_requests, queue_nr_requests;
 static DECLARE_WAIT_QUEUE_HEAD(blk_buffers_wait);
+unsigned long blk_max_low_pfn;
 
 static inline int get_max_sectors(kdev_t dev)
 {
@@ -267,6 +269,24 @@
 	q->make_request_fn = mfn;
 }
 
+/**
+ * blk_queue_bounce_limit - set bounce buffer limit for queue
+ * @q:  the request queue for the device
+ * @bus_addr:   bus address limit
+ *
+ * Description:
+ *    Different hardware can have different requirements as to what pages
+ *    it can do I/O directly to. A low level driver can call
+ *    blk_queue_bounce_limit to have lower memory pages allocated as bounce
+ *    buffers for doing I/O to pages residing above @page. By default
+ *    the block layer sets this to the highest numbered "low" memory page, ie
+ *    one the driver can still call bio_page() and get a valid address on.
+ **/
+void blk_queue_bounce_limit(request_queue_t *q, unsigned long dma_addr)
+{
+	q->bounce_limit = mem_map + (dma_addr >> PAGE_SHIFT);
+}
+
 static inline int ll_new_segment(request_queue_t *q, struct request *req, int max_segments)
 {
 	if (req->nr_segments < max_segments) {
@@ -279,7 +299,7 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct buffer_head *bh, int max_segments)
 {
-	if (req->bhtail->b_data + req->bhtail->b_size == bh->b_data)
+	if (bh_bus(req->bhtail) + req->bhtail->b_size == bh_bus(bh))
 		return 1;
 	return ll_new_segment(q, req, max_segments);
 }
@@ -287,7 +307,7 @@
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct buffer_head *bh, int max_segments)
 {
-	if (bh->b_data + bh->b_size == req->bh->b_data)
+	if (bh_bus(bh) + bh->b_size == bh_bus(req->bh))
 		return 1;
 	return ll_new_segment(q, req, max_segments);
 }
@@ -297,7 +317,7 @@
 {
 	int total_segments = req->nr_segments + next->nr_segments;
 
-	if (req->bhtail->b_data + req->bhtail->b_size == next->bh->b_data)
+	if (bh_bus(req->bhtail) + req->bhtail->b_size == bh_bus(next->bh))
 		total_segments--;
     
 	if (total_segments > max_segments)
@@ -431,6 +451,8 @@
 	 */
 	q->plug_device_fn 	= generic_plug_device;
 	q->head_active    	= 1;
+
+	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, table);
@@ -621,7 +643,7 @@
 	if (req->cmd != next->cmd
 	    || req->rq_dev != next->rq_dev
 	    || req->nr_sectors + next->nr_sectors > max_sectors
-	    || next->sem)
+	    || next->sem || req->special)
 		return;
 	/*
 	 * If we are not allowed to merge these requests, then
@@ -704,9 +726,7 @@
 	 * driver. Create a bounce buffer if the buffer data points into
 	 * high memory - keep the original buffer otherwise.
 	 */
-#if CONFIG_HIGHMEM
-	bh = create_bounce(rw, bh);
-#endif
+	bh = blk_queue_bounce(q, rw, bh);
 
 /* look for a free request. */
 	/*
@@ -751,8 +771,13 @@
 			elevator->elevator_merge_cleanup_fn(q, req, count);
 			bh->b_reqnext = req->bh;
 			req->bh = bh;
+			/*
+			 * may not be valid, but queues not having bounce
+			 * enabled for highmem pages must not look at
+			 * ->buffer anyway
+			 */
 			req->buffer = bh->b_data;
-			req->current_nr_sectors = count;
+			req->current_nr_sectors = req->hard_cur_sectors = count;
 			req->sector = req->hard_sector = sector;
 			req->nr_sectors = req->hard_nr_sectors += count;
 			blk_started_io(count);
@@ -802,7 +827,7 @@
 	req->errors = 0;
 	req->hard_sector = req->sector = sector;
 	req->hard_nr_sectors = req->nr_sectors = count;
-	req->current_nr_sectors = count;
+	req->current_nr_sectors = req->hard_cur_sectors = count;
 	req->nr_segments = 1; /* Always 1 for a new request. */
 	req->nr_hw_segments = 1; /* Always 1 for a new request. */
 	req->buffer = bh->b_data;
@@ -1130,6 +1155,7 @@
 			req->nr_sectors = req->hard_nr_sectors;
 
 			req->current_nr_sectors = bh->b_size >> 9;
+			req->hard_cur_sectors = req->current_nr_sectors;
 			if (req->nr_sectors < req->current_nr_sectors) {
 				req->nr_sectors = req->current_nr_sectors;
 				printk("end_request: buffer-list destroyed\n");
@@ -1207,6 +1233,8 @@
 						low_queued_sectors / 2,
 						queue_nr_requests);
 
+	blk_max_low_pfn = max_low_pfn;
+
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
 #endif
@@ -1327,3 +1355,5 @@
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
 EXPORT_SYMBOL(queued_sectors);
+EXPORT_SYMBOL(blk_queue_bounce_limit);
+EXPORT_SYMBOL(blk_max_low_pfn);
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/block/loop.c linux/drivers/block/loop.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/block/loop.c	Tue Jun 26 00:15:57 2001
+++ linux/drivers/block/loop.c	Tue Jun 26 17:59:04 2001
@@ -453,9 +453,7 @@
 		goto err;
 	}
 
-#if CONFIG_HIGHMEM
-	rbh = create_bounce(rw, rbh);
-#endif
+	rbh = blk_queue_bounce(q, rw, rbh);
 
 	/*
 	 * file backed, queue for loop_thread to handle
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/ide/hpt34x.c	Sun May 20 02:43:06 2001
+++ linux/drivers/ide/hpt34x.c	Sun May 27 17:50:26 2001
@@ -425,6 +425,7 @@
 			hwif->autodma = 0;
 
 		hwif->dmaproc = &hpt34x_dmaproc;
+		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/ide/hpt366.c	Sun May 20 02:43:06 2001
+++ linux/drivers/ide/hpt366.c	Sun May 27 17:50:26 2001
@@ -710,6 +710,7 @@
 			hwif->autodma = 1;
 		else
 			hwif->autodma = 0;
+		hwif->highmem = 1;
 	} else {
 		hwif->autodma = 0;
 		hwif->drives[0].autotune = 1;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/ide/ide-disk.c	Fri Feb  9 20:30:23 2001
+++ linux/drivers/ide/ide-disk.c	Mon May 28 02:10:44 2001
@@ -27,9 +27,10 @@
  * Version 1.09		added increment of rq->sector in ide_multwrite
  *			added UDMA 3/4 reporting
  * Version 1.10		request queue changes, Ultra DMA 100
+ * Version 1.11		Highmem I/O support, Jens Axboe <axboe@suse.de>
  */
 
-#define IDEDISK_VERSION	"1.10"
+#define IDEDISK_VERSION	"1.11"
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
@@ -140,6 +141,7 @@
 	int i;
 	unsigned int msect, nsect;
 	struct request *rq;
+	char *to;
 
 	/* new way for dealing with premature shared PCI interrupts */
 	if (!OK_STAT(stat=GET_STAT(),DATA_READY,BAD_R_STAT)) {
@@ -150,8 +152,8 @@
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
 		return ide_started;
 	}
+
 	msect = drive->mult_count;
-	
 read_next:
 	rq = HWGROUP(drive)->rq;
 	if (msect) {
@@ -160,14 +162,15 @@
 		msect -= nsect;
 	} else
 		nsect = 1;
-	idedisk_input_data(drive, rq->buffer, nsect * SECTOR_WORDS);
+	to = ide_map_buffer(rq);
+	idedisk_input_data(drive, to, nsect * SECTOR_WORDS);
 #ifdef DEBUG
 	printk("%s:  read: sectors(%ld-%ld), buffer=0x%08lx, remaining=%ld\n",
 		drive->name, rq->sector, rq->sector+nsect-1,
 		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
 #endif
+	ide_unmap_buffer(to);
 	rq->sector += nsect;
-	rq->buffer += nsect<<9;
 	rq->errors = 0;
 	i = (rq->nr_sectors -= nsect);
 	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
@@ -201,14 +204,15 @@
 #endif
 		if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
 			rq->sector++;
-			rq->buffer += 512;
 			rq->errors = 0;
 			i = --rq->nr_sectors;
 			--rq->current_nr_sectors;
 			if (((long)rq->current_nr_sectors) <= 0)
 				ide_end_request(1, hwgroup);
 			if (i > 0) {
-				idedisk_output_data (drive, rq->buffer, SECTOR_WORDS);
+				char *to = ide_map_buffer(rq);
+				idedisk_output_data (drive, to, SECTOR_WORDS);
+				ide_unmap_buffer(to);
 				ide_set_handler (drive, &write_intr, WAIT_CMD, NULL);
                                 return ide_started;
 			}
@@ -238,14 +242,13 @@
   	do {
   		char *buffer;
   		int nsect = rq->current_nr_sectors;
- 
+
 		if (nsect > mcount)
 			nsect = mcount;
 		mcount -= nsect;
-		buffer = rq->buffer;
 
+		buffer = ide_map_buffer(rq);
 		rq->sector += nsect;
-		rq->buffer += nsect << 9;
 		rq->nr_sectors -= nsect;
 		rq->current_nr_sectors -= nsect;
 
@@ -259,7 +262,7 @@
 			} else {
 				rq->bh = bh;
 				rq->current_nr_sectors = bh->b_size >> 9;
-				rq->buffer             = bh->b_data;
+				rq->hard_cur_sectors = rq->current_nr_sectors;
 			}
 		}
 
@@ -268,6 +271,7 @@
 		 * re-entering us on the last transfer.
 		 */
 		idedisk_output_data(drive, buffer, nsect<<7);
+		ide_unmap_buffer(buffer);
 	} while (mcount);
 
         return 0;
@@ -451,8 +455,10 @@
 				return ide_stopped;
 			}
 		} else {
+			char *buffer = ide_map_buffer(rq);
 			ide_set_handler (drive, &write_intr, WAIT_CMD, NULL);
-			idedisk_output_data(drive, rq->buffer, SECTOR_WORDS);
+			idedisk_output_data(drive, buffer, SECTOR_WORDS);
+			ide_unmap_buffer(buffer);
 		}
 		return ide_started;
 	}
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/ide/ide-dma.c	Mon Jan 15 22:08:15 2001
+++ linux/drivers/ide/ide-dma.c	Tue May 29 15:42:32 2001
@@ -215,30 +215,37 @@
 {
 	struct buffer_head *bh;
 	struct scatterlist *sg = hwif->sg_table;
+	unsigned long lastdataend;
 	int nents = 0;
 
 	if (rq->cmd == READ)
 		hwif->sg_dma_direction = PCI_DMA_FROMDEVICE;
 	else
 		hwif->sg_dma_direction = PCI_DMA_TODEVICE;
+
 	bh = rq->bh;
+	lastdataend = 0;
 	do {
-		unsigned char *virt_addr = bh->b_data;
-		unsigned int size = bh->b_size;
-
-		if (nents >= PRD_ENTRIES)
-			return 0;
-
-		while ((bh = bh->b_reqnext) != NULL) {
-			if ((virt_addr + size) != (unsigned char *) bh->b_data)
-				break;
-			size += bh->b_size;
+		/*
+		 * continue segment from before?
+		 */
+		if (bh_bus(bh) == lastdataend) {
+			sg[nents - 1].length += bh->b_size;
+			lastdataend += bh->b_size;
+		} else {
+			struct scatterlist *sge;
+			/*
+			 * start new segment
+			 */
+			if (nents >= PRD_ENTRIES)
+				return 0;
+
+			sge = &sg[nents];
+			set_bh_sg(sge, bh);
+			lastdataend = bh_bus(bh) + bh->b_size;
+			nents++;
 		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = size;
-		nents++;
-	} while (bh != NULL);
+	} while ((bh = bh->b_reqnext) != NULL);
 
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
@@ -450,6 +457,24 @@
 	return 0;
 }
 
+#ifdef CONFIG_HIGHMEM
+static inline void ide_toggle_bounce(ide_drive_t *drive, int on)
+{
+	unsigned long flags, addr = BLK_BOUNCE_HIGH;
+
+	if (on && drive->media == ide_disk && HWIF(drive)->highmem) {
+		printk("%s: enabling highmem I/O\n", drive->name);
+		addr = BLK_BOUNCE_4G;
+	}
+
+	spin_lock_irqsave(&io_request_lock, flags);
+	blk_queue_bounce_limit(&drive->queue, addr);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+#else
+#define ide_toggle_bounce(drive, on)
+#endif
+
 /*
  * ide_dmaproc() initiates/aborts DMA read/write operations on a drive.
  *
@@ -471,15 +496,17 @@
 	ide_hwif_t *hwif = HWIF(drive);
 	unsigned long dma_base = hwif->dma_base;
 	byte unit = (drive->select.b.unit & 0x01);
-	unsigned int count, reading = 0;
+	unsigned int count, reading = 0, set_high = 1;
 	byte dma_stat;
 
 	switch (func) {
 		case ide_dma_off:
 			printk("%s: DMA disabled\n", drive->name);
+			set_high = 0;
 		case ide_dma_off_quietly:
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 		case ide_dma_on:
+			ide_toggle_bounce(drive, set_high);
 			drive->using_dma = (func == ide_dma_on);
 			if (drive->using_dma)
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/ide/pdc202xx.c	Wed May  2 01:05:00 2001
+++ linux/drivers/ide/pdc202xx.c	Sun May 27 17:50:26 2001
@@ -855,6 +855,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->dmaproc = &pdc202xx_dmaproc;
+		hwif->highmem = 1;
 		if (!noautodma)
 			hwif->autodma = 1;
 	} else {
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/ide/piix.c linux/drivers/ide/piix.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/ide/piix.c	Tue Jun 26 00:15:58 2001
+++ linux/drivers/ide/piix.c	Tue Jun 26 17:59:04 2001
@@ -512,6 +512,7 @@
 	if (!hwif->dma_base)
 		return;
 
+	hwif->highmem = 1;
 #ifndef CONFIG_BLK_DEV_IDEDMA
 	hwif->autodma = 0;
 #else /* CONFIG_BLK_DEV_IDEDMA */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/aic7xxx/aic7xxx_linux_host.h linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Sat May  5 00:16:28 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Sun May 27 17:50:26 2001
@@ -81,7 +81,8 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 1					\
+	use_new_eh_code: 1,					\
+	can_dma_32: 1						\
 }
 
 #endif /* _AIC7XXX_LINUX_HOST_H_ */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/hosts.c linux/drivers/scsi/hosts.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/hosts.c	Mon Oct 30 23:44:29 2000
+++ linux/drivers/scsi/hosts.c	Sun May 27 17:50:26 2001
@@ -230,6 +230,7 @@
     retval->cmd_per_lun = tpnt->cmd_per_lun;
     retval->unchecked_isa_dma = tpnt->unchecked_isa_dma;
     retval->use_clustering = tpnt->use_clustering;   
+    retval->can_dma_32 = tpnt->can_dma_32;
 
     retval->select_queue_depths = tpnt->select_queue_depths;
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/hosts.h linux/drivers/scsi/hosts.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/hosts.h	Sat May 26 03:02:21 2001
+++ linux/drivers/scsi/hosts.h	Tue Jun 26 18:05:42 2001
@@ -286,6 +286,8 @@
      */
     unsigned emulated:1;
 
+    unsigned can_dma_32:1;
+
     /*
      * Name of proc directory
      */
@@ -384,6 +386,7 @@
     unsigned in_recovery:1;
     unsigned unchecked_isa_dma:1;
     unsigned use_clustering:1;
+    unsigned can_dma_32:1;
     /*
      * True if this host was loaded as a loadable module
      */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/qlogicfc.h linux/drivers/scsi/qlogicfc.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/qlogicfc.h	Mon Jun 26 21:02:16 2000
+++ linux/drivers/scsi/qlogicfc.h	Thu Jun  7 14:22:13 2001
@@ -100,7 +100,8 @@
 	cmd_per_lun:		QLOGICFC_CMD_PER_LUN, 			   \
         present:                0,                                         \
         unchecked_isa_dma:      0,                                         \
-        use_clustering:         ENABLE_CLUSTERING 			   \
+        use_clustering:         ENABLE_CLUSTERING,			   \
+	can_dma_32:		1					   \
 }
 
 #endif /* _QLOGICFC_H */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi.c	Tue Jun 26 00:15:59 2001
+++ linux/drivers/scsi/scsi.c	Tue Jun 26 17:59:03 2001
@@ -176,10 +176,13 @@
  *              handler in the list - ultimately they call scsi_request_fn
  *              to do the dirty deed.
  */
-void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt) {
-	blk_init_queue(&SDpnt->request_queue, scsi_request_fn);
-        blk_queue_headactive(&SDpnt->request_queue, 0);
-        SDpnt->request_queue.queuedata = (void *) SDpnt;
+void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt)
+{
+	request_queue_t *q = &SDpnt->request_queue;
+
+	blk_init_queue(q, scsi_request_fn);
+	blk_queue_headactive(q, 0);
+	q->queuedata = (void *) SDpnt;
 }
 
 #ifdef MODULE
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi.h	Sat May 26 03:02:21 2001
+++ linux/drivers/scsi/scsi.h	Tue Jun 26 18:05:42 2001
@@ -391,7 +391,7 @@
 #define CONTIGUOUS_BUFFERS(X,Y) \
 	(virt_to_phys((X)->b_data+(X)->b_size-1)+1==virt_to_phys((Y)->b_data))
 #else
-#define CONTIGUOUS_BUFFERS(X,Y) ((X->b_data+X->b_size) == Y->b_data)
+#define CONTIGUOUS_BUFFERS(X,Y) (bh_bus((X)) + (X)->b_size == bh_bus((Y)))
 #endif
 
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi_lib.c linux/drivers/scsi/scsi_lib.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi_lib.c	Sat May  5 00:16:28 2001
+++ linux/drivers/scsi/scsi_lib.c	Wed May 30 16:13:00 2001
@@ -360,37 +360,21 @@
 				     int frequeue)
 {
 	struct request *req;
-	struct buffer_head *bh;
         Scsi_Device * SDpnt;
-	int nsect;
 
 	ASSERT_LOCK(&io_request_lock, 0);
 
 	req = &SCpnt->request;
-	req->errors = 0;
-	if (!uptodate) {
-		printk(" I/O error: dev %s, sector %lu\n",
-		       kdevname(req->rq_dev), req->sector);
-	}
+
 	do {
-		if ((bh = req->bh) != NULL) {
-			nsect = bh->b_size >> 9;
-			blk_finished_io(nsect);
-			req->bh = bh->b_reqnext;
-			req->nr_sectors -= nsect;
-			req->sector += nsect;
-			bh->b_reqnext = NULL;
-			sectors -= nsect;
-			bh->b_end_io(bh, uptodate);
-			if ((bh = req->bh) != NULL) {
-				req->current_nr_sectors = bh->b_size >> 9;
-				if (req->nr_sectors < req->current_nr_sectors) {
-					req->nr_sectors = req->current_nr_sectors;
-					printk("scsi_end_request: buffer-list destroyed\n");
-				}
-			}
+		if (!req->bh) {
+			printk("scsi_end_request: missing bh\n");
+			break;
 		}
-	} while (sectors && bh);
+		sectors -= req->bh->b_size >> 9;
+		if (!end_that_request_first(req, 1, "scsi"))
+			break;
+	} while (sectors > 0);
 
 	/*
 	 * If there are blocks left over at the end, set up the command
@@ -406,7 +390,6 @@
 
                 q = &SCpnt->device->request_queue;
 
-		req->buffer = bh->b_data;
 		/*
 		 * Bleah.  Leftovers again.  Stick the leftovers in
 		 * the front of the queue, and goose the queue again.
@@ -485,6 +468,8 @@
  */
 static void scsi_release_buffers(Scsi_Cmnd * SCpnt)
 {
+	struct request *req = &SCpnt->request;
+
 	ASSERT_LOCK(&io_request_lock, 0);
 
 	/*
@@ -503,9 +488,8 @@
 		}
 		scsi_free(SCpnt->request_buffer, SCpnt->sglist_len);
 	} else {
-		if (SCpnt->request_buffer != SCpnt->request.buffer) {
-			scsi_free(SCpnt->request_buffer, SCpnt->request_bufflen);
-		}
+		if (SCpnt->request_buffer != req->buffer)
+			scsi_free(SCpnt->request_buffer,SCpnt->request_bufflen);
 	}
 
 	/*
@@ -541,6 +525,7 @@
 	int result = SCpnt->result;
 	int this_count = SCpnt->bufflen >> 9;
 	request_queue_t *q = &SCpnt->device->request_queue;
+	struct request *req = &SCpnt->request;
 
 	/*
 	 * We must do one of several things here:
@@ -570,7 +555,7 @@
 
 		for (i = 0; i < SCpnt->use_sg; i++) {
 			if (sgpnt[i].alt_address) {
-				if (SCpnt->request.cmd == READ) {
+				if (req->cmd == READ) {
 					memcpy(sgpnt[i].alt_address, 
 					       sgpnt[i].address,
 					       sgpnt[i].length);
@@ -580,10 +565,11 @@
 		}
 		scsi_free(SCpnt->buffer, SCpnt->sglist_len);
 	} else {
-		if (SCpnt->buffer != SCpnt->request.buffer) {
-			if (SCpnt->request.cmd == READ) {
-				memcpy(SCpnt->request.buffer, SCpnt->buffer,
-				       SCpnt->bufflen);
+		if (SCpnt->buffer != req->buffer) {
+			if (req->cmd == READ) {
+				char *to = bh_kmap_irq(req->bh);
+				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
+				bh_kunmap_irq(to);
 			}
 			scsi_free(SCpnt->buffer, SCpnt->bufflen);
 		}
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi_merge.c linux/drivers/scsi/scsi_merge.c
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/scsi_merge.c	Fri Feb  9 20:30:23 2001
+++ linux/drivers/scsi/scsi_merge.c	Tue May 29 15:42:48 2001
@@ -6,6 +6,7 @@
  *                        Based upon conversations with large numbers
  *                        of people at Linux Expo.
  *	Support for dynamic DMA mapping: Jakub Jelinek (jakub@redhat.com).
+ *	Support for highmem I/O: Jens Axboe <axboe@suse.de>
  */
 
 /*
@@ -95,7 +96,7 @@
 		printk("Segment 0x%p, blocks %d, addr 0x%lx\n",
 		       bh,
 		       bh->b_size >> 9,
-		       virt_to_phys(bh->b_data - 1));
+		       bh_bus(bh) - 1);
 	}
 	panic("Ththththaats all folks.  Too dangerous to continue.\n");
 }
@@ -223,8 +224,7 @@
 			 * DMA capable host, make sure that a segment doesn't span
 			 * the DMA threshold boundary.  
 			 */
-			if (dma_host &&
-			    virt_to_phys(bhnext->b_data) - 1 == ISA_DMA_THRESHOLD) {
+			if (dma_host && bh_bus(bhnext) - 1 == ISA_DMA_THRESHOLD) {
 				ret++;
 				reqsize = bhnext->b_size;
 			} else if (CONTIGUOUS_BUFFERS(bh, bhnext)) {
@@ -241,8 +241,7 @@
 				 * kind of screwed and we need to start
 				 * another segment.
 				 */
-				if( dma_host
-				    && virt_to_phys(bh->b_data) - 1 >= ISA_DMA_THRESHOLD
+				if( dma_host && bh_bus(bh) - 1 >= ISA_DMA_THRESHOLD
 				    && reqsize + bhnext->b_size > PAGE_SIZE )
 				{
 					ret++;
@@ -304,7 +303,7 @@
 }
 
 #define MERGEABLE_BUFFERS(X,Y) \
-(((((long)(X)->b_data+(X)->b_size)|((long)(Y)->b_data)) & \
+(((((long)bh_bus((X))+(X)->b_size)|((long)bh_bus((Y)))) & \
   (DMA_CHUNK_SIZE - 1)) == 0)
 
 #ifdef DMA_CHUNK_SIZE
@@ -424,14 +423,11 @@
 		 * DMA capable host, make sure that a segment doesn't span
 		 * the DMA threshold boundary.  
 		 */
-		if (dma_host &&
-		    virt_to_phys(req->bhtail->b_data) - 1 == ISA_DMA_THRESHOLD) {
+		if (dma_host && bh_bus(req->bhtail) - 1 == ISA_DMA_THRESHOLD)
 			goto new_end_segment;
-		}
 		if (CONTIGUOUS_BUFFERS(req->bhtail, bh)) {
 #ifdef DMA_SEGMENT_SIZE_LIMITED
-			if( dma_host
-			    && virt_to_phys(bh->b_data) - 1 >= ISA_DMA_THRESHOLD ) {
+			if (dma_host && bh_bus(bh) - 1 >= ISA_DMA_THRESHOLD) {
 				segment_size = 0;
 				count = __count_segments(req, use_clustering, dma_host, &segment_size);
 				if( segment_size + bh->b_size > PAGE_SIZE ) {
@@ -480,14 +476,12 @@
 		 * DMA capable host, make sure that a segment doesn't span
 		 * the DMA threshold boundary. 
 		 */
-		if (dma_host &&
-		    virt_to_phys(bh->b_data) - 1 == ISA_DMA_THRESHOLD) {
+		if (dma_host && bh_bus(bh) - 1 == ISA_DMA_THRESHOLD) {
 			goto new_start_segment;
 		}
 		if (CONTIGUOUS_BUFFERS(bh, req->bh)) {
 #ifdef DMA_SEGMENT_SIZE_LIMITED
-			if( dma_host
-			    && virt_to_phys(bh->b_data) - 1 >= ISA_DMA_THRESHOLD ) {
+			if (dma_host && bh_bus(bh) - 1 >= ISA_DMA_THRESHOLD) {
 				segment_size = bh->b_size;
 				count = __count_segments(req, use_clustering, dma_host, &segment_size);
 				if( count != req->nr_segments ) {
@@ -635,10 +629,8 @@
 		 * DMA capable host, make sure that a segment doesn't span
 		 * the DMA threshold boundary.  
 		 */
-		if (dma_host &&
-		    virt_to_phys(req->bhtail->b_data) - 1 == ISA_DMA_THRESHOLD) {
+		if (dma_host && bh_bus(req->bhtail) - 1 == ISA_DMA_THRESHOLD)
 			goto dont_combine;
-		}
 #ifdef DMA_SEGMENT_SIZE_LIMITED
 		/*
 		 * We currently can only allocate scatter-gather bounce
@@ -646,7 +638,7 @@
 		 */
 		if (dma_host
 		    && CONTIGUOUS_BUFFERS(req->bhtail, next->bh)
-		    && virt_to_phys(req->bhtail->b_data) - 1 >= ISA_DMA_THRESHOLD )
+		    && bh_bus(req->bhtail) - 1 >= ISA_DMA_THRESHOLD )
 		{
 			int segment_size = 0;
 			int count = 0;
@@ -791,29 +783,6 @@
 	struct scatterlist * sgpnt;
 	int		     this_count;
 
-	/*
-	 * FIXME(eric) - don't inline this - it doesn't depend on the
-	 * integer flags.   Come to think of it, I don't think this is even
-	 * needed any more.  Need to play with it and see if we hit the
-	 * panic.  If not, then don't bother.
-	 */
-	if (!SCpnt->request.bh) {
-		/* 
-		 * Case of page request (i.e. raw device), or unlinked buffer 
-		 * Typically used for swapping, but this isn't how we do
-		 * swapping any more.
-		 */
-		panic("I believe this is dead code.  If we hit this, I was wrong");
-#if 0
-		SCpnt->request_bufflen = SCpnt->request.nr_sectors << 9;
-		SCpnt->request_buffer = SCpnt->request.buffer;
-		SCpnt->use_sg = 0;
-		/*
-		 * FIXME(eric) - need to handle DMA here.
-		 */
-#endif
-		return 1;
-	}
 	req = &SCpnt->request;
 	/*
 	 * First we need to know how many scatter gather segments are needed.
@@ -830,24 +799,16 @@
 	 * buffer.
 	 */
 	if (dma_host && scsi_dma_free_sectors <= 10) {
-		this_count = SCpnt->request.current_nr_sectors;
-		goto single_segment;
-	}
-	/*
-	 * Don't bother with scatter-gather if there is only one segment.
-	 */
-	if (count == 1) {
-		this_count = SCpnt->request.nr_sectors;
+		this_count = req->current_nr_sectors;
 		goto single_segment;
 	}
-	SCpnt->use_sg = count;
 
 	/* 
 	 * Allocate the actual scatter-gather table itself.
 	 * scsi_malloc can only allocate in chunks of 512 bytes 
 	 */
-	SCpnt->sglist_len = (SCpnt->use_sg
-			     * sizeof(struct scatterlist) + 511) & ~511;
+	SCpnt->use_sg = count;
+	SCpnt->sglist_len = (count * sizeof(struct scatterlist) + 511) & ~511;
 
 	sgpnt = (struct scatterlist *) scsi_malloc(SCpnt->sglist_len);
 
@@ -860,7 +821,7 @@
 		 * simply write the first buffer all by itself.
 		 */
 		printk("Warning - running *really* short on DMA buffers\n");
-		this_count = SCpnt->request.current_nr_sectors;
+		this_count = req->current_nr_sectors;
 		goto single_segment;
 	}
 	/* 
@@ -872,11 +833,9 @@
 	SCpnt->request_bufflen = 0;
 	bhprev = NULL;
 
-	for (count = 0, bh = SCpnt->request.bh;
-	     bh; bh = bh->b_reqnext) {
+	for (count = 0, bh = req->bh; bh; bh = bh->b_reqnext) {
 		if (use_clustering && bhprev != NULL) {
-			if (dma_host &&
-			    virt_to_phys(bhprev->b_data) - 1 == ISA_DMA_THRESHOLD) {
+			if (dma_host && bh_bus(bhprev) - 1 == ISA_DMA_THRESHOLD) {
 				/* Nothing - fall through */
 			} else if (CONTIGUOUS_BUFFERS(bhprev, bh)) {
 				/*
@@ -887,7 +846,7 @@
 				 */
 				if( dma_host ) {
 #ifdef DMA_SEGMENT_SIZE_LIMITED
-					if( virt_to_phys(bh->b_data) - 1 < ISA_DMA_THRESHOLD
+					if (bh_bus(bh) - 1 < ISA_DMA_THRESHOLD
 					    || sgpnt[count - 1].length + bh->b_size <= PAGE_SIZE ) {
 						sgpnt[count - 1].length += bh->b_size;
 						bhprev = bh;
@@ -906,12 +865,12 @@
 				}
 			}
 		}
-		count++;
-		sgpnt[count - 1].address = bh->b_data;
-		sgpnt[count - 1].length += bh->b_size;
-		if (!dma_host) {
+
+		set_bh_sg(&sgpnt[count], bh);
+		if (!dma_host)
 			SCpnt->request_bufflen += bh->b_size;
-		}
+
+		count++;
 		bhprev = bh;
 	}
 
@@ -934,6 +893,10 @@
 	for (i = 0; i < count; i++) {
 		sectors = (sgpnt[i].length >> 9);
 		SCpnt->request_bufflen += sgpnt[i].length;
+		/*
+		 * only done for dma_host, in which case .page is not
+		 * set since it's guarenteed to be a low memory page
+		 */
 		if (virt_to_phys(sgpnt[i].address) + sgpnt[i].length - 1 >
 		    ISA_DMA_THRESHOLD) {
 			if( scsi_dma_free_sectors - sectors <= 10  ) {
@@ -969,7 +932,7 @@
 				}
 				break;
 			}
-			if (SCpnt->request.cmd == WRITE) {
+			if (req->cmd == WRITE) {
 				memcpy(sgpnt[i].address, sgpnt[i].alt_address,
 				       sgpnt[i].length);
 			}
@@ -1014,8 +977,7 @@
 	 * single-block requests if we had hundreds of free sectors.
 	 */
 	if( scsi_dma_free_sectors > 30 ) {
-		for (this_count = 0, bh = SCpnt->request.bh;
-		     bh; bh = bh->b_reqnext) {
+		for (this_count = 0, bh = req->bh; bh; bh = bh->b_reqnext) {
 			if( scsi_dma_free_sectors - this_count < 30 
 			    || this_count == sectors )
 			{
@@ -1028,7 +990,7 @@
 		/*
 		 * Yow!   Take the absolute minimum here.
 		 */
-		this_count = SCpnt->request.current_nr_sectors;
+		this_count = req->current_nr_sectors;
 	}
 
 	/*
@@ -1041,28 +1003,30 @@
 	 * segment.  Possibly the entire request, or possibly a small
 	 * chunk of the entire request.
 	 */
-	bh = SCpnt->request.bh;
-	buff = SCpnt->request.buffer;
+	bh = req->bh;
+	buff = req->buffer = bh->b_data;
 
-	if (dma_host) {
+	if (dma_host || PageHighMem(bh->b_page)) {
 		/*
 		 * Allocate a DMA bounce buffer.  If the allocation fails, fall
 		 * back and allocate a really small one - enough to satisfy
 		 * the first buffer.
 		 */
-		if (virt_to_phys(SCpnt->request.bh->b_data)
-		    + (this_count << 9) - 1 > ISA_DMA_THRESHOLD) {
+		if (bh_bus(bh) + (this_count << 9) - 1 > ISA_DMA_THRESHOLD) {
 			buff = (char *) scsi_malloc(this_count << 9);
 			if (!buff) {
 				printk("Warning - running low on DMA memory\n");
-				this_count = SCpnt->request.current_nr_sectors;
+				this_count = req->current_nr_sectors;
 				buff = (char *) scsi_malloc(this_count << 9);
 				if (!buff) {
 					dma_exhausted(SCpnt, 0);
 				}
 			}
-			if (SCpnt->request.cmd == WRITE)
-				memcpy(buff, (char *) SCpnt->request.buffer, this_count << 9);
+			if (req->cmd == WRITE) {
+				char *buf = bh_kmap_irq(bh);
+				memcpy(buff, buf, this_count << 9);
+				bh_kunmap_irq(buf);
+			}
 		}
 	}
 	SCpnt->request_bufflen = this_count << 9;
@@ -1110,14 +1074,6 @@
 	q = &SDpnt->request_queue;
 
 	/*
-	 * If the host has already selected a merge manager, then don't
-	 * pick a new one.
-	 */
-#if 0
-	if (q->back_merge_fn && q->front_merge_fn)
-		return;
-#endif
-	/*
 	 * If this host has an unlimited tablesize, then don't bother with a
 	 * merge manager.  The whole point of the operation is to make sure
 	 * that requests don't grow too large, and this host isn't picky.
@@ -1149,4 +1105,16 @@
 		q->merge_requests_fn = scsi_merge_requests_fn_dc;
 		SDpnt->scsi_init_io_fn = scsi_init_io_vdc;
 	}
+
+	/*
+	 * now enable highmem I/O, if appropriate
+	 */
+#ifdef CONFIG_HIGHMEM
+	if (SHpnt->can_dma_32 && (SDpnt->type == TYPE_DISK)) {
+		blk_queue_bounce_limit(q, BLK_BOUNCE_4G);
+		printk("SCSI: channel %d, id %d: enabling highmem I/O\n",
+			SDpnt->channel, SDpnt->id);
+	} else
+		blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+#endif
 }
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/drivers/scsi/sym53c8xx.h linux/drivers/scsi/sym53c8xx.h
--- /opt/kernel/linux-2.4.6-pre5/drivers/scsi/sym53c8xx.h	Sat May 26 03:03:07 2001
+++ linux/drivers/scsi/sym53c8xx.h	Sun May 27 17:50:26 2001
@@ -96,7 +96,8 @@
 			this_id:        7,			\
 			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
 			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
-			use_clustering: DISABLE_CLUSTERING} 
+			use_clustering: DISABLE_CLUSTERING,	\
+			can_dma_32:	1} 
 
 #else
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/fs/buffer.c linux/fs/buffer.c
--- /opt/kernel/linux-2.4.6-pre5/fs/buffer.c	Tue Jun 26 00:15:59 2001
+++ linux/fs/buffer.c	Tue Jun 26 17:59:02 2001
@@ -1270,13 +1270,11 @@
 	bh->b_page = page;
 	if (offset >= PAGE_SIZE)
 		BUG();
-	if (PageHighMem(page))
-		/*
-		 * This catches illegal uses and preserves the offset:
-		 */
-		bh->b_data = (char *)(0 + offset);
-	else
-		bh->b_data = page_address(page) + offset;
+	/*
+	 * ->virtual is NULL on highmem pages, so we can catch the
+	 * offset even though using page_address on it
+	 */
+	bh->b_data = page_address(page) + offset;
 }
 
 /*
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/asm-i386/kmap_types.h linux/include/asm-i386/kmap_types.h
--- /opt/kernel/linux-2.4.6-pre5/include/asm-i386/kmap_types.h	Thu Apr 12 21:11:39 2001
+++ linux/include/asm-i386/kmap_types.h	Mon May 28 01:28:29 2001
@@ -6,6 +6,7 @@
 	KM_BOUNCE_WRITE,
 	KM_SKB_DATA,
 	KM_SKB_DATA_SOFTIRQ,
+	KM_BH_IRQ,
 	KM_TYPE_NR
 };
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/asm-i386/page.h linux/include/asm-i386/page.h
--- /opt/kernel/linux-2.4.6-pre5/include/asm-i386/page.h	Sat May 26 03:01:26 2001
+++ linux/include/asm-i386/page.h	Sun May 27 18:26:59 2001
@@ -116,7 +116,8 @@
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
-
+#define page_to_phys(page)	(((page) - mem_map) * PAGE_SIZE)
+#define page_to_bus(page)	page_to_phys((page))
 
 #endif /* __KERNEL__ */
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/asm-i386/pci.h linux/include/asm-i386/pci.h
--- /opt/kernel/linux-2.4.6-pre5/include/asm-i386/pci.h	Tue Jun 26 00:15:59 2001
+++ linux/include/asm-i386/pci.h	Tue Jun 26 18:02:14 2001
@@ -28,6 +28,7 @@
 
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 #include <asm/scatterlist.h>
 #include <linux/string.h>
 #include <asm/io.h>
@@ -84,6 +85,27 @@
 	/* Nothing to do */
 }
 
+/*
+ * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
+ * to pci_map_single, but takes a struct page instead of a virtual address
+ */
+extern inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
+				      size_t size, int offset, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	return (page - mem_map) * PAGE_SIZE + offset;
+}
+
+extern inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+				  size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -102,8 +124,26 @@
 extern inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 			     int nents, int direction)
 {
+	int i;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
+
+	/*
+	 * temporary 2.4 hack
+	 */
+	for (i = 0; i < nents; i++ ) {
+		if (sg[i].address && sg[i].page)
+			BUG();
+		else if (!sg[i].address && !sg[i].page)
+			BUG();
+
+		if (sg[i].page)
+			sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
+		else
+			sg[i].dma_address = virt_to_bus(sg[i].address);
+	}
+
 	return nents;
 }
 
@@ -173,10 +213,9 @@
 /* These macros should be used after a pci_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
  * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
+ * returns.
  */
-#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
+#define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 /* Return the index of the PCI controller for device. */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/asm-i386/scatterlist.h linux/include/asm-i386/scatterlist.h
--- /opt/kernel/linux-2.4.6-pre5/include/asm-i386/scatterlist.h	Mon Dec 30 12:01:10 1996
+++ linux/include/asm-i386/scatterlist.h	Mon May 28 02:02:36 2001
@@ -1,12 +1,34 @@
 #ifndef _I386_SCATTERLIST_H
 #define _I386_SCATTERLIST_H
 
+/*
+ * temporary measure, include a page and offset.
+ */
 struct scatterlist {
-    char *  address;    /* Location data is to be transferred to */
+    struct page * page; /* Location for highmem page, if any */
+    char *  address;    /* Location data is to be transferred to, NULL for
+			 * highmem page */
     char * alt_address; /* Location of actual if address is a 
 			 * dma indirect buffer.  NULL otherwise */
+    dma_addr_t dma_address;
     unsigned int length;
+    unsigned int offset;/* for highmem, page offset */
 };
+
+extern inline void set_bh_sg(struct scatterlist *sg, struct buffer_head *bh)
+{
+	if (PageHighMem(bh->b_page)) {
+		sg->page = bh->b_page;
+		sg->offset = bh_offset(bh);
+		sg->address = NULL;
+	} else {
+		sg->page = NULL;
+		sg->offset = 0;
+		sg->address = bh->b_data;
+	}
+
+	sg->length = bh->b_size;
+}
 
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.4.6-pre5/include/linux/blkdev.h	Sat May 26 03:01:40 2001
+++ linux/include/linux/blkdev.h	Tue Jun 26 18:02:49 2001
@@ -38,7 +38,7 @@
 	unsigned long hard_sector, hard_nr_sectors;
 	unsigned int nr_segments;
 	unsigned int nr_hw_segments;
-	unsigned long current_nr_sectors;
+	unsigned long current_nr_sectors, hard_cur_sectors;
 	void * special;
 	char * buffer;
 	struct semaphore * sem;
@@ -112,6 +112,8 @@
 	 */
 	char			head_active;
 
+	struct page		*bounce_limit;
+
 	/*
 	 * Is meant to protect the queue in the future instead of
 	 * io_request_lock
@@ -123,6 +125,27 @@
 	 */
 	wait_queue_head_t	wait_for_request;
 };
+
+extern unsigned long blk_max_low_pfn;
+
+#define BLK_BOUNCE_HIGH		(blk_max_low_pfn * PAGE_SIZE)
+#define BLK_BOUNCE_4G		PCI_MAX_DMA32
+
+extern void blk_queue_bounce_limit(request_queue_t *, unsigned long);
+
+#ifdef CONFIG_HIGHMEM
+extern struct buffer_head *create_bounce(int, struct buffer_head *);
+extern inline struct buffer_head *blk_queue_bounce(request_queue_t *q, int rw,
+						   struct buffer_head *bh)
+{
+	if (bh->b_page <= q->bounce_limit)
+		return bh;
+
+	return create_bounce(rw, bh);
+}
+#else
+#define blk_queue_bounce(q, rw, bh)	(bh)
+#endif
 
 struct blk_dev_struct {
 	/*
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/linux/fs.h linux/include/linux/fs.h
--- /opt/kernel/linux-2.4.6-pre5/include/linux/fs.h	Tue Jun 26 00:16:00 2001
+++ linux/include/linux/fs.h	Tue Jun 26 18:00:35 2001
@@ -278,6 +278,8 @@
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
+#define bh_bus(bh)		(page_to_bus((bh)->b_page) + bh_offset((bh)))
+
 extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);
 
 #define touch_buffer(bh)	SetPageReferenced(bh->b_page)
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/linux/highmem.h linux/include/linux/highmem.h
--- /opt/kernel/linux-2.4.6-pre5/include/linux/highmem.h	Sat May 26 03:01:28 2001
+++ linux/include/linux/highmem.h	Tue Jun 26 18:02:00 2001
@@ -13,8 +13,7 @@
 /* declarations for linux/mm/highmem.c */
 FASTCALL(unsigned int nr_free_highpages(void));
 
-extern struct buffer_head * create_bounce(int rw, struct buffer_head * bh_orig);
-
+extern struct buffer_head *create_bounce(int rw, struct buffer_head * bh_orig);
 
 static inline char *bh_kmap(struct buffer_head *bh)
 {
@@ -26,6 +25,26 @@
 	kunmap(bh->b_page);
 }
 
+/*
+ * remember to add offset!
+ */
+static inline char *bh_kmap_irq(struct buffer_head *bh)
+{
+	unsigned long addr = (unsigned long) kmap_atomic(bh->b_page, KM_BH_IRQ);
+
+	if (addr & ~PAGE_MASK)
+		BUG();
+
+	return (char *) addr + bh_offset(bh);
+}
+
+static inline void bh_kunmap_irq(char *buffer)
+{
+	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
+
+	kunmap_atomic((void *) ptr, KM_BH_IRQ);
+}
+
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
@@ -39,6 +58,8 @@
 
 #define bh_kmap(bh)	((bh)->b_data)
 #define bh_kunmap(bh)	do { } while (0)
+#define bh_kmap_irq(bh)	((bh)->b_data)
+#define bh_kunmap_irq(bh)	do { } while (0)
 
 #endif /* CONFIG_HIGHMEM */
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.4.6-pre5/include/linux/ide.h	Sat May 26 03:02:42 2001
+++ linux/include/linux/ide.h	Tue Jun 26 18:03:30 2001
@@ -457,6 +457,7 @@
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
+	unsigned	highmem	   : 1; /* can do full 32-bit dma */
 	byte		channel;	/* for dual-port chips: 0=primary, 1=secondary */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	struct pci_dev	*pci_dev;	/* for pci chipsets */
@@ -752,6 +753,21 @@
 	ide_preempt,	/* insert rq in front of current request */
 	ide_end		/* insert rq at end of list, but don't wait for it */
 } ide_action_t;
+
+/*
+ * temporarily mapping a (possible) highmem bio
+ */
+#define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
+
+extern inline void *ide_map_buffer(struct request *rq)
+{
+	return bh_kmap_irq(rq->bh) + ide_rq_offset(rq);
+}
+
+extern inline void ide_unmap_buffer(char *buffer)
+{
+	bh_kunmap_irq(buffer);
+}
 
 /*
  * This function issues a special IDE device request
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/include/linux/pci.h linux/include/linux/pci.h
--- /opt/kernel/linux-2.4.6-pre5/include/linux/pci.h	Tue Jun 26 00:16:00 2001
+++ linux/include/linux/pci.h	Tue Jun 26 18:02:50 2001
@@ -314,6 +314,8 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define PCI_MAX_DMA32		(0xffffffff)
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.6-pre5/kernel/ksyms.c linux/kernel/ksyms.c
--- /opt/kernel/linux-2.4.6-pre5/kernel/ksyms.c	Tue Jun 26 00:16:00 2001
+++ linux/kernel/ksyms.c	Tue Jun 26 17:59:02 2001
@@ -122,6 +122,8 @@
 EXPORT_SYMBOL(kunmap_high);
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(create_bounce);
+EXPORT_SYMBOL(kmap_prot);
+EXPORT_SYMBOL(kmap_pte);
 #endif
 
 /* filesystem internal functions */

--EVF5PPMfhYS0aIcm--
