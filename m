Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271083AbRHOHvJ>; Wed, 15 Aug 2001 03:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271086AbRHOHuv>; Wed, 15 Aug 2001 03:50:51 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:27655 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S271085AbRHOHuc>; Wed, 15 Aug 2001 03:50:32 -0400
Date: Wed, 15 Aug 2001 09:50:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
Subject: [patch] zero-bounce highmem I/O
Message-ID: <20010815095018.B545@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I updated the patches to 2.4.9-pre4 along with a few other changes:

- Fix bh_kmap_irq nested irq bug (Andrea, me)

- Remove __scsi_end_request changes and add hard_cur_sectors locally.
  Done to minimize changes on core code, the new code was not buggy but
  it's probably more of a 2.5 thing. (me)

- Remove 'enabling highmem I/O' messages (me)

- Up queue_nr_requests a bit (me)

- Drop page_to_bus and page_to_phys from my tree, identical version are
  in the main line now. (me)

- Sync pci-dma changes with my bio patch set -- use of sg_list and
  pci_map_sgl makes support of highmem easy. See ide-dma changes. The
  single page mappings of pci_map_page/unmap_page are good too, of
  course.  SCSI uses the horrible pci_map_sg hack... (me)

There are just two patches now:

- block-highmem-all-7 has everything

- pci-dma-high-1 has PCI DMA changes to support mapping of highmem pages
- block-highmem-7 has core and driver updates

The two latter patches equals the former. Currently it will only compile
on x86 due to the scatterlist changes, I'd appreciate info from arch
maintainers on whether the pci-dma-high-1 patch does something which
can't be readily supported on non-x86 platforms. Dave, comments on that?
To me it looks fine, but I could be missing something. And Dave, should
I add the 64-bit stuff I started again? :-)

Testers are more than welcome. Oracle had some very abysmal profiling
numbers for the stock kernel and bouncing, I won't even show those here
in fear of inducing vomit attacks in the readers. The patch is
considered stable.

Can't get in to kernel.org currently, so I'm attaching the two patches.
They aren't that big anyway...

-- 
Jens Axboe


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=pci-dma-high-1

diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/asm-i386/pci.h linux/include/asm-i386/pci.h
--- /opt/kernel/linux-2.4.9-pre4/include/asm-i386/pci.h	Wed Aug 15 09:19:05 2001
+++ linux/include/asm-i386/pci.h	Wed Aug 15 09:36:55 2001
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
 static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
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
 
@@ -119,6 +159,32 @@
 	/* Nothing to do */
 }
 
+/*
+ * meant to replace the pci_map_sg api, new drivers should use this
+ * interface
+ */
+extern inline int pci_map_sgl(struct pci_dev *hwdev, struct sg_list *sg,
+			      int nents, int direction)
+{
+	int i;
+
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	for (i = 0; i < nents; i++)
+		sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
+
+	return nents;
+}
+
+extern inline void pci_unmap_sgl(struct pci_dev *hwdev, struct sg_list *sg,
+				 int nents, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
  *
@@ -173,10 +239,9 @@
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
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/asm-i386/scatterlist.h linux/include/asm-i386/scatterlist.h
--- /opt/kernel/linux-2.4.9-pre4/include/asm-i386/scatterlist.h	Mon Dec 30 12:01:10 1996
+++ linux/include/asm-i386/scatterlist.h	Wed Aug 15 09:30:21 2001
@@ -1,12 +1,56 @@
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
+/*
+ * new style scatter gather list -- move to this completely?
+ */
+struct sg_list {
+	/*
+	 * input
+	 */
+	struct page *page;	/* page to do I/O to */
+	unsigned int length;	/* length of I/O */
+	unsigned int offset;	/* offset into page */
+
+	/*
+	 * original page, if bounced
+	 */
+	struct page *bounce_page;
+
+	/*
+	 * output
+	 */
+	dma_addr_t dma_address;	/* mapped address */
+};
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
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/linux/pci.h linux/include/linux/pci.h
--- /opt/kernel/linux-2.4.9-pre4/include/linux/pci.h	Fri Jul 20 21:52:38 2001
+++ linux/include/linux/pci.h	Wed Aug 15 09:41:02 2001
@@ -314,6 +314,8 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define PCI_MAX_DMA32		(0xffffffff)
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2

--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=block-highmem-all-7

diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/cciss.c linux/drivers/block/cciss.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/cciss.c	Mon Jul  2 22:56:40 2001
+++ linux/drivers/block/cciss.c	Wed Aug 15 09:14:26 2001
@@ -1129,7 +1129,7 @@
 	{
 		temp64.val32.lower = cmd->SG[i].Addr.lower;
 		temp64.val32.upper = cmd->SG[i].Addr.upper;
-		pci_unmap_single(hba[cmd->ctlr]->pdev,
+		pci_unmap_page(hba[cmd->ctlr]->pdev,
 			temp64.val, cmd->SG[i].Len, 
 			(cmd->Request.Type.Direction == XFER_READ) ? 
 				PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
@@ -1225,7 +1225,7 @@
 static int cpq_back_merge_fn(request_queue_t *q, struct request *rq,
                              struct buffer_head *bh, int max_segments)
 {
-        if (rq->bhtail->b_data + rq->bhtail->b_size == bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(bh))
                 return 1;
         return cpq_new_segment(q, rq, max_segments);
 }
@@ -1233,7 +1233,7 @@
 static int cpq_front_merge_fn(request_queue_t *q, struct request *rq,
                              struct buffer_head *bh, int max_segments)
 {
-        if (bh->b_data + bh->b_size == rq->bh->b_data)
+	if (bh_bus(bh) + bh->b_size == bh_bus(rq->bh))
                 return 1;
         return cpq_new_segment(q, rq, max_segments);
 }
@@ -1243,7 +1243,7 @@
 {
         int total_segments = rq->nr_segments + nxt->nr_segments;
 
-        if (rq->bhtail->b_data + rq->bhtail->b_size == nxt->bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(nxt->bh))
                 total_segments--;
 
         if (total_segments > MAXSGENTRIES)
@@ -1264,7 +1264,7 @@
 	ctlr_info_t *h= q->queuedata; 
 	CommandList_struct *c;
 	int log_unit, start_blk, seg, sect;
-	char *lastdataend;
+	unsigned long lastdataend;
 	struct buffer_head *bh;
 	struct list_head *queue_head = &q->queue_head;
 	struct request *creq;
@@ -1272,10 +1272,15 @@
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
@@ -1323,12 +1328,12 @@
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
@@ -1336,9 +1341,10 @@
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
@@ -1347,9 +1353,8 @@
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
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/cciss.h linux/drivers/block/cciss.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/cciss.h	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cciss.h	Wed Aug 15 09:41:25 2001
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
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/cpqarray.c	Wed Aug 15 09:19:03 2001
+++ linux/drivers/block/cpqarray.c	Wed Aug 15 09:14:26 2001
@@ -367,7 +367,7 @@
 static int cpq_back_merge_fn(request_queue_t *q, struct request *rq,
 			     struct buffer_head *bh, int max_segments)
 {
-	if (rq->bhtail->b_data + rq->bhtail->b_size == bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(bh))
 		return 1;
 	return cpq_new_segment(q, rq, max_segments);
 }
@@ -375,7 +375,7 @@
 static int cpq_front_merge_fn(request_queue_t *q, struct request *rq,
 			     struct buffer_head *bh, int max_segments)
 {
-	if (bh->b_data + bh->b_size == rq->bh->b_data)
+	if (bh_bus(bh) + bh->b_size == bh_bus(rq->bh))
 		return 1;
 	return cpq_new_segment(q, rq, max_segments);
 }
@@ -385,7 +385,7 @@
 {
 	int total_segments = rq->nr_segments + nxt->nr_segments;
 
-	if (rq->bhtail->b_data + rq->bhtail->b_size == nxt->bh->b_data)
+	if (bh_bus(rq->bhtail) + rq->bhtail->b_size == bh_bus(nxt->bh))
 		total_segments--;
 
 	if (total_segments > SG_MAX)
@@ -532,6 +532,7 @@
 		q = BLK_DEFAULT_QUEUE(MAJOR_NR + i);
 		q->queuedata = hba[i];
 		blk_init_queue(q, do_ida_request);
+		blk_queue_bounce_limit(q, BLK_BOUNCE_4G);
 		blk_queue_headactive(q, 0);
 		blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
 		hardsect_size[MAJOR_NR+i] = ida_hardsizes + (i*256);
@@ -923,17 +924,22 @@
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
@@ -973,19 +979,20 @@
 	
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
@@ -994,9 +1001,9 @@
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
@@ -1103,7 +1110,7 @@
 	/* unmap the DMA mapping for all the scatter gather elements */
         for(i=0; i<cmd->req.hdr.sg_cnt; i++)
         {
-                pci_unmap_single(hba[cmd->ctlr]->pci_dev,
+                pci_unmap_page(hba[cmd->ctlr]->pci_dev,
                         cmd->req.sg[i].addr, cmd->req.sg[i].size,
                         (cmd->req.hdr.cmd == IDA_READ) ? PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
         }
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/cpqarray.h linux/drivers/block/cpqarray.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/cpqarray.h	Tue May 22 19:23:16 2001
+++ linux/drivers/block/cpqarray.h	Wed Aug 15 09:41:38 2001
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
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/elevator.c linux/drivers/block/elevator.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/elevator.c	Fri Jul 20 05:59:41 2001
+++ linux/drivers/block/elevator.c	Wed Aug 15 09:14:26 2001
@@ -110,7 +110,6 @@
 			break;
 		} else if (__rq->sector - count == bh->b_rsector) {
 			ret = ELEVATOR_FRONT_MERGE;
-			__rq->elevator_sequence -= count;
 			*req = __rq;
 			break;
 		}
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/ll_rw_blk.c	Wed Aug 15 09:19:03 2001
+++ linux/drivers/block/ll_rw_blk.c	Wed Aug 15 09:14:26 2001
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/bootmem.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -124,6 +125,8 @@
  */
 static int queue_nr_requests, batch_requests;
 
+unsigned long blk_max_low_pfn;
+
 static inline int get_max_sectors(kdev_t dev)
 {
 	if (!max_sectors[MAJOR(dev)])
@@ -131,7 +134,7 @@
 	return max_sectors[MAJOR(dev)][MINOR(dev)];
 }
 
-inline request_queue_t *__blk_get_queue(kdev_t dev)
+inline request_queue_t *blk_get_queue(kdev_t dev)
 {
 	struct blk_dev_struct *bdev = blk_dev + MAJOR(dev);
 
@@ -141,22 +144,6 @@
 		return &blk_dev[MAJOR(dev)].request_queue;
 }
 
-/*
- * NOTE: the device-specific queue() functions
- * have to be atomic!
- */
-request_queue_t *blk_get_queue(kdev_t dev)
-{
-	request_queue_t *ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&io_request_lock,flags);
-	ret = __blk_get_queue(dev);
-	spin_unlock_irqrestore(&io_request_lock,flags);
-
-	return ret;
-}
-
 static int __blk_cleanup_queue(struct list_head *head)
 {
 	struct request *rq;
@@ -261,6 +248,24 @@
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
@@ -273,7 +278,7 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct buffer_head *bh, int max_segments)
 {
-	if (req->bhtail->b_data + req->bhtail->b_size == bh->b_data)
+	if (bh_bus(req->bhtail) + req->bhtail->b_size == bh_bus(bh))
 		return 1;
 	return ll_new_segment(q, req, max_segments);
 }
@@ -281,7 +286,7 @@
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct buffer_head *bh, int max_segments)
 {
-	if (bh->b_data + bh->b_size == req->bh->b_data)
+	if (bh_bus(bh) + bh->b_size == bh_bus(req->bh))
 		return 1;
 	return ll_new_segment(q, req, max_segments);
 }
@@ -291,7 +296,7 @@
 {
 	int total_segments = req->nr_segments + next->nr_segments;
 
-	if (req->bhtail->b_data + req->bhtail->b_size == next->bh->b_data)
+	if (bh_bus(req->bhtail) + req->bhtail->b_size == bh_bus(next->bh))
 		total_segments--;
     
 	if (total_segments > max_segments)
@@ -430,6 +435,8 @@
 	 */
 	q->plug_device_fn 	= generic_plug_device;
 	q->head_active    	= 1;
+
+	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
 }
 
 #define blkdev_free_rq(list) list_entry((list)->next, struct request, table);
@@ -696,9 +703,7 @@
 	 * driver. Create a bounce buffer if the buffer data points into
 	 * high memory - keep the original buffer otherwise.
 	 */
-#if CONFIG_HIGHMEM
-	bh = create_bounce(rw, bh);
-#endif
+	bh = blk_queue_bounce(q, rw, bh);
 
 /* look for a free request. */
 	/*
@@ -743,8 +748,13 @@
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
@@ -794,7 +804,7 @@
 	req->errors = 0;
 	req->hard_sector = req->sector = sector;
 	req->hard_nr_sectors = req->nr_sectors = count;
-	req->current_nr_sectors = count;
+	req->current_nr_sectors = req->hard_cur_sectors = count;
 	req->nr_segments = 1; /* Always 1 for a new request. */
 	req->nr_hw_segments = 1; /* Always 1 for a new request. */
 	req->buffer = bh->b_data;
@@ -1104,6 +1114,7 @@
 			req->nr_sectors = req->hard_nr_sectors;
 
 			req->current_nr_sectors = bh->b_size >> 9;
+			req->hard_cur_sectors = req->current_nr_sectors;
 			if (req->nr_sectors < req->current_nr_sectors) {
 				req->nr_sectors = req->current_nr_sectors;
 				printk("end_request: buffer-list destroyed\n");
@@ -1152,7 +1163,7 @@
 	 */
 	queue_nr_requests = 64;
 	if (total_ram > MB(32))
-		queue_nr_requests = 128;
+		queue_nr_requests = 256;
 
 	/*
 	 * Batch frees according to queue length
@@ -1160,6 +1171,8 @@
 	batch_requests = queue_nr_requests >> 3;
 	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
 
+	blk_max_low_pfn = max_low_pfn;
+
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
 #endif
@@ -1272,10 +1285,11 @@
 EXPORT_SYMBOL(end_that_request_last);
 EXPORT_SYMBOL(blk_init_queue);
 EXPORT_SYMBOL(blk_get_queue);
-EXPORT_SYMBOL(__blk_get_queue);
 EXPORT_SYMBOL(blk_cleanup_queue);
 EXPORT_SYMBOL(blk_queue_headactive);
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
+EXPORT_SYMBOL(blk_queue_bounce_limit);
+EXPORT_SYMBOL(blk_max_low_pfn);
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/block/loop.c linux/drivers/block/loop.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/block/loop.c	Sat Jun 30 01:16:56 2001
+++ linux/drivers/block/loop.c	Wed Aug 15 09:14:26 2001
@@ -453,9 +453,7 @@
 		goto err;
 	}
 
-#if CONFIG_HIGHMEM
-	rbh = create_bounce(rw, rbh);
-#endif
+	rbh = blk_queue_bounce(q, rw, rbh);
 
 	/*
 	 * file backed, queue for loop_thread to handle
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/ide/hpt34x.c	Sun May 20 02:43:06 2001
+++ linux/drivers/ide/hpt34x.c	Wed Aug 15 09:14:26 2001
@@ -425,6 +425,7 @@
 			hwif->autodma = 0;
 
 		hwif->dmaproc = &hpt34x_dmaproc;
+		hwif->highmem = 1;
 	} else {
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/ide/hpt366.c	Thu Jun 28 02:10:55 2001
+++ linux/drivers/ide/hpt366.c	Wed Aug 15 09:14:26 2001
@@ -720,6 +720,7 @@
 			hwif->autodma = 1;
 		else
 			hwif->autodma = 0;
+		hwif->highmem = 1;
 	} else {
 		hwif->autodma = 0;
 		hwif->drives[0].autotune = 1;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/ide/ide-disk.c	Wed Aug 15 09:19:17 2001
+++ linux/drivers/ide/ide-disk.c	Wed Aug 15 09:14:26 2001
@@ -27,9 +27,10 @@
  * Version 1.09		added increment of rq->sector in ide_multwrite
  *			added UDMA 3/4 reporting
  * Version 1.10		request queue changes, Ultra DMA 100
+ * Version 1.11		Highmem I/O support, Jens Axboe <axboe@suse.de>
  */
 
-#define IDEDISK_VERSION	"1.10"
+#define IDEDISK_VERSION	"1.11"
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
@@ -139,7 +140,9 @@
 	byte stat;
 	int i;
 	unsigned int msect, nsect;
+	unsigned long flags;
 	struct request *rq;
+	char *to;
 
 	/* new way for dealing with premature shared PCI interrupts */
 	if (!OK_STAT(stat=GET_STAT(),DATA_READY,BAD_R_STAT)) {
@@ -150,8 +153,8 @@
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
 		return ide_started;
 	}
+
 	msect = drive->mult_count;
-	
 read_next:
 	rq = HWGROUP(drive)->rq;
 	if (msect) {
@@ -160,14 +163,15 @@
 		msect -= nsect;
 	} else
 		nsect = 1;
-	idedisk_input_data(drive, rq->buffer, nsect * SECTOR_WORDS);
+	to = ide_map_buffer(rq, &flags);
+	idedisk_input_data(drive, to, nsect * SECTOR_WORDS);
 #ifdef DEBUG
 	printk("%s:  read: sectors(%ld-%ld), buffer=0x%08lx, remaining=%ld\n",
 		drive->name, rq->sector, rq->sector+nsect-1,
 		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
 #endif
+	ide_unmap_buffer(to, &flags);
 	rq->sector += nsect;
-	rq->buffer += nsect<<9;
 	rq->errors = 0;
 	i = (rq->nr_sectors -= nsect);
 	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
@@ -201,14 +205,16 @@
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
+				unsigned long flags;
+				char *to = ide_map_buffer(rq, &flags);
+				idedisk_output_data (drive, to, SECTOR_WORDS);
+				ide_unmap_buffer(to, &flags);
 				ide_set_handler (drive, &write_intr, WAIT_CMD, NULL);
                                 return ide_started;
 			}
@@ -238,14 +244,14 @@
   	do {
   		char *buffer;
   		int nsect = rq->current_nr_sectors;
- 
+		unsigned long flags;
+
 		if (nsect > mcount)
 			nsect = mcount;
 		mcount -= nsect;
-		buffer = rq->buffer;
 
+		buffer = ide_map_buffer(rq, &flags);
 		rq->sector += nsect;
-		rq->buffer += nsect << 9;
 		rq->nr_sectors -= nsect;
 		rq->current_nr_sectors -= nsect;
 
@@ -259,7 +265,7 @@
 			} else {
 				rq->bh = bh;
 				rq->current_nr_sectors = bh->b_size >> 9;
-				rq->buffer             = bh->b_data;
+				rq->hard_cur_sectors = rq->current_nr_sectors;
 			}
 		}
 
@@ -268,6 +274,7 @@
 		 * re-entering us on the last transfer.
 		 */
 		idedisk_output_data(drive, buffer, nsect<<7);
+		ide_unmap_buffer(buffer, &flags);
 	} while (mcount);
 
         return 0;
@@ -452,8 +459,11 @@
 				return ide_stopped;
 			}
 		} else {
+			unsigned long flags;
+			char *buffer = ide_map_buffer(rq, &flags);
 			ide_set_handler (drive, &write_intr, WAIT_CMD, NULL);
-			idedisk_output_data(drive, rq->buffer, SECTOR_WORDS);
+			idedisk_output_data(drive, buffer, SECTOR_WORDS);
+			ide_unmap_buffer(buffer, &flags);
 		}
 		return ide_started;
 	}
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/ide/ide-dma.c	Wed Aug 15 09:19:17 2001
+++ linux/drivers/ide/ide-dma.c	Wed Aug 15 09:36:47 2001
@@ -230,36 +230,45 @@
 static int ide_build_sglist (ide_hwif_t *hwif, struct request *rq)
 {
 	struct buffer_head *bh;
-	struct scatterlist *sg = hwif->sg_table;
+	struct sg_list *sg = hwif->sg_table;
+	unsigned long lastdataend;
 	int nents = 0;
 
 	if (hwif->sg_dma_active)
 		BUG();
-		
+
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
+		/*
+		 * continue segment from before?
+		 */
+		if (bh_bus(bh) == lastdataend) {
+			sg[nents - 1].length += bh->b_size;
+			lastdataend += bh->b_size;
+		} else {
+			struct sg_list *sge;
+			/*
+			 * start new segment
+			 */
+			if (nents >= PRD_ENTRIES)
+				return 0;
 
-		while ((bh = bh->b_reqnext) != NULL) {
-			if ((virt_addr + size) != (unsigned char *) bh->b_data)
-				break;
-			size += bh->b_size;
+			sge = &sg[nents];
+			sge->page = bh->b_page;
+			sge->length = bh->b_size;
+			sge->offset = bh_offset(bh);
+			lastdataend = bh_bus(bh) + bh->b_size;
+			nents++;
 		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = size;
-		nents++;
-	} while (bh != NULL);
+	} while ((bh = bh->b_reqnext) != NULL);
 
-	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
+	return pci_map_sgl(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
 
 /*
@@ -277,7 +286,7 @@
 #endif
 	unsigned int count = 0;
 	int i;
-	struct scatterlist *sg;
+	struct sg_list *sg;
 
 	HWIF(drive)->sg_nents = i = ide_build_sglist(HWIF(drive), HWGROUP(drive)->rq);
 
@@ -285,7 +294,7 @@
 		return 0;
 
 	sg = HWIF(drive)->sg_table;
-	while (i && sg_dma_len(sg)) {
+	while (i) {
 		u32 cur_addr;
 		u32 cur_len;
 
@@ -299,36 +308,35 @@
 		 */
 
 		while (cur_len) {
-			if (count++ >= PRD_ENTRIES) {
-				printk("%s: DMA table too small\n", drive->name);
-				goto use_pio_instead;
-			} else {
-				u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
-
-				if (bcount > cur_len)
-					bcount = cur_len;
-				*table++ = cpu_to_le32(cur_addr);
-				xcount = bcount & 0xffff;
-				if (is_trm290_chipset)
-					xcount = ((xcount >> 2) - 1) << 16;
-				if (xcount == 0x0000) {
-					/* 
-					 * Most chipsets correctly interpret a length of 0x0000 as 64KB,
-					 * but at least one (e.g. CS5530) misinterprets it as zero (!).
-					 * So here we break the 64KB entry into two 32KB entries instead.
-					 */
-					if (count++ >= PRD_ENTRIES) {
-						printk("%s: DMA table too small\n", drive->name);
-						goto use_pio_instead;
-					}
-					*table++ = cpu_to_le32(0x8000);
-					*table++ = cpu_to_le32(cur_addr + 0x8000);
-					xcount = 0x8000;
-				}
-				*table++ = cpu_to_le32(xcount);
-				cur_addr += bcount;
-				cur_len -= bcount;
+			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
+			
+			if (count++ >= PRD_ENTRIES)
+				BUG();
+
+			if (bcount > cur_len)
+				bcount = cur_len;
+			*table++ = cpu_to_le32(cur_addr);
+			xcount = bcount & 0xffff;
+			if (is_trm290_chipset)
+				xcount = ((xcount >> 2) - 1) << 16;
+			if (xcount == 0x0000) {
+				/* 
+				 * Most chipsets correctly interpret a length
+				 * of 0x0000 as 64KB, but at least one
+				 * (e.g. CS5530) misinterprets it as zero (!).
+				 * So here we break the 64KB entry into two
+				 * 32KB entries instead.
+				 */
+				if (count++ >= PRD_ENTRIES)
+					goto use_pio_instead;
+
+				*table++ = cpu_to_le32(0x8000);
+				*table++ = cpu_to_le32(cur_addr + 0x8000);
+				xcount = 0x8000;
 			}
+			*table++ = cpu_to_le32(xcount);
+			cur_addr += bcount;
+			cur_len -= bcount;
 		}
 
 		sg++;
@@ -342,7 +350,7 @@
 	}
 	printk("%s: empty DMA table?\n", drive->name);
 use_pio_instead:
-	pci_unmap_sg(HWIF(drive)->pci_dev,
+	pci_unmap_sgl(HWIF(drive)->pci_dev,
 		     HWIF(drive)->sg_table,
 		     HWIF(drive)->sg_nents,
 		     HWIF(drive)->sg_dma_direction);
@@ -354,10 +362,10 @@
 void ide_destroy_dmatable (ide_drive_t *drive)
 {
 	struct pci_dev *dev = HWIF(drive)->pci_dev;
-	struct scatterlist *sg = HWIF(drive)->sg_table;
+	struct sg_list *sg = HWIF(drive)->sg_table;
 	int nents = HWIF(drive)->sg_nents;
 
-	pci_unmap_sg(dev, sg, nents, HWIF(drive)->sg_dma_direction);
+	pci_unmap_sgl(dev, sg, nents, HWIF(drive)->sg_dma_direction);
 	HWIF(drive)->sg_dma_active = 0;
 }
 
@@ -512,6 +520,20 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
 
+#ifdef CONFIG_HIGHMEM
+static inline void ide_toggle_bounce(ide_drive_t *drive, int on)
+{
+	unsigned long addr = BLK_BOUNCE_HIGH;
+
+	if (on && drive->media == ide_disk && HWIF(drive)->highmem)
+		addr = BLK_BOUNCE_4G;
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+}
+#else
+#define ide_toggle_bounce(drive, on)
+#endif
+
 /*
  * ide_dmaproc() initiates/aborts DMA read/write operations on a drive.
  *
@@ -534,18 +556,20 @@
 	ide_hwif_t *hwif		= HWIF(drive);
 	unsigned long dma_base		= hwif->dma_base;
 	byte unit			= (drive->select.b.unit & 0x01);
-	unsigned int count, reading	= 0;
+	unsigned int count, reading = 0, set_high = 1;
 	byte dma_stat;
 
 	switch (func) {
 		case ide_dma_off:
 			printk("%s: DMA disabled\n", drive->name);
+			set_high = 0;
 		case ide_dma_off_quietly:
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 		case ide_dma_on:
 			drive->using_dma = (func == ide_dma_on);
 			if (drive->using_dma)
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
+			ide_toggle_bounce(drive, set_high);
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
@@ -681,7 +705,7 @@
 	if (hwif->dmatable_cpu == NULL)
 		goto dma_alloc_failure;
 
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
+	hwif->sg_table = kmalloc(sizeof(struct sg_list) * PRD_ENTRIES,
 				 GFP_KERNEL);
 	if (hwif->sg_table == NULL) {
 		pci_free_consistent(hwif->pci_dev, PRD_ENTRIES * PRD_BYTES,
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/ide/pdc202xx.c	Wed Aug 15 09:19:17 2001
+++ linux/drivers/ide/pdc202xx.c	Wed Aug 15 09:14:26 2001
@@ -891,6 +891,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->dmaproc = &pdc202xx_dmaproc;
+		hwif->highmem = 1;
 		if (!noautodma)
 			hwif->autodma = 1;
 	} else {
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/ide/piix.c linux/drivers/ide/piix.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/ide/piix.c	Wed Aug 15 09:19:17 2001
+++ linux/drivers/ide/piix.c	Wed Aug 15 09:14:26 2001
@@ -521,6 +521,7 @@
 	if (!hwif->dma_base)
 		return;
 
+	hwif->highmem = 1;
 #ifndef CONFIG_BLK_DEV_IDEDMA
 	hwif->autodma = 0;
 #else /* CONFIG_BLK_DEV_IDEDMA */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/aic7xxx/aic7xxx_linux_host.h linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Sat May  5 00:16:28 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Wed Aug 15 09:14:26 2001
@@ -81,7 +81,8 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 1					\
+	use_new_eh_code: 1,					\
+	can_dma_32: 1						\
 }
 
 #endif /* _AIC7XXX_LINUX_HOST_H_ */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/hosts.c linux/drivers/scsi/hosts.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/hosts.c	Thu Jul  5 20:28:17 2001
+++ linux/drivers/scsi/hosts.c	Wed Aug 15 09:14:26 2001
@@ -235,6 +235,7 @@
     retval->cmd_per_lun = tpnt->cmd_per_lun;
     retval->unchecked_isa_dma = tpnt->unchecked_isa_dma;
     retval->use_clustering = tpnt->use_clustering;   
+    retval->can_dma_32 = tpnt->can_dma_32;
 
     retval->select_queue_depths = tpnt->select_queue_depths;
     retval->max_sectors = tpnt->max_sectors;
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/hosts.h linux/drivers/scsi/hosts.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/hosts.h	Fri Jul 20 21:55:46 2001
+++ linux/drivers/scsi/hosts.h	Wed Aug 15 09:41:37 2001
@@ -291,6 +291,8 @@
      */
     unsigned emulated:1;
 
+    unsigned can_dma_32:1;
+
     /*
      * Name of proc directory
      */
@@ -390,6 +392,7 @@
     unsigned in_recovery:1;
     unsigned unchecked_isa_dma:1;
     unsigned use_clustering:1;
+    unsigned can_dma_32:1;
     /*
      * True if this host was loaded as a loadable module
      */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/qlogicfc.h linux/drivers/scsi/qlogicfc.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/qlogicfc.h	Mon Jun 26 21:02:16 2000
+++ linux/drivers/scsi/qlogicfc.h	Wed Aug 15 09:14:26 2001
@@ -100,7 +100,8 @@
 	cmd_per_lun:		QLOGICFC_CMD_PER_LUN, 			   \
         present:                0,                                         \
         unchecked_isa_dma:      0,                                         \
-        use_clustering:         ENABLE_CLUSTERING 			   \
+        use_clustering:         ENABLE_CLUSTERING,			   \
+	can_dma_32:		1					   \
 }
 
 #endif /* _QLOGICFC_H */
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi.c	Fri Jul 20 06:07:04 2001
+++ linux/drivers/scsi/scsi.c	Wed Aug 15 09:14:26 2001
@@ -178,10 +178,13 @@
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
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi.h	Fri Jul 20 21:55:46 2001
+++ linux/drivers/scsi/scsi.h	Wed Aug 15 09:41:37 2001
@@ -391,7 +391,7 @@
 #define CONTIGUOUS_BUFFERS(X,Y) \
 	(virt_to_phys((X)->b_data+(X)->b_size-1)+1==virt_to_phys((Y)->b_data))
 #else
-#define CONTIGUOUS_BUFFERS(X,Y) ((X->b_data+X->b_size) == Y->b_data)
+#define CONTIGUOUS_BUFFERS(X,Y) (bh_bus((X)) + (X)->b_size == bh_bus((Y)))
 #endif
 
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi_lib.c linux/drivers/scsi/scsi_lib.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi_lib.c	Wed Aug 15 09:19:18 2001
+++ linux/drivers/scsi/scsi_lib.c	Wed Aug 15 09:14:26 2001
@@ -388,6 +388,7 @@
 				req->nr_sectors -= nsect;
 
 				req->current_nr_sectors = bh->b_size >> 9;
+				req->hard_cur_sectors = req->current_nr_sectors;
 				if (req->nr_sectors < req->current_nr_sectors) {
 					req->nr_sectors = req->current_nr_sectors;
 					printk("scsi_end_request: buffer-list destroyed\n");
@@ -410,7 +411,6 @@
 
                 q = &SCpnt->device->request_queue;
 
-		req->buffer = bh->b_data;
 		/*
 		 * Bleah.  Leftovers again.  Stick the leftovers in
 		 * the front of the queue, and goose the queue again.
@@ -489,6 +489,8 @@
  */
 static void scsi_release_buffers(Scsi_Cmnd * SCpnt)
 {
+	struct request *req = &SCpnt->request;
+
 	ASSERT_LOCK(&io_request_lock, 0);
 
 	/*
@@ -507,9 +509,8 @@
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
@@ -545,6 +546,7 @@
 	int result = SCpnt->result;
 	int this_count = SCpnt->bufflen >> 9;
 	request_queue_t *q = &SCpnt->device->request_queue;
+	struct request *req = &SCpnt->request;
 
 	/*
 	 * We must do one of several things here:
@@ -574,7 +576,7 @@
 
 		for (i = 0; i < SCpnt->use_sg; i++) {
 			if (sgpnt[i].alt_address) {
-				if (SCpnt->request.cmd == READ) {
+				if (req->cmd == READ) {
 					memcpy(sgpnt[i].alt_address, 
 					       sgpnt[i].address,
 					       sgpnt[i].length);
@@ -584,10 +586,12 @@
 		}
 		scsi_free(SCpnt->buffer, SCpnt->sglist_len);
 	} else {
-		if (SCpnt->buffer != SCpnt->request.buffer) {
-			if (SCpnt->request.cmd == READ) {
-				memcpy(SCpnt->request.buffer, SCpnt->buffer,
-				       SCpnt->bufflen);
+		if (SCpnt->buffer != req->buffer) {
+			if (req->cmd == READ) {
+				unsigned long flags;
+				char *to = bh_kmap_irq(req->bh, &flags);
+				memcpy(to, SCpnt->buffer, SCpnt->bufflen);
+				bh_kunmap_irq(to, &flags);
 			}
 			scsi_free(SCpnt->buffer, SCpnt->bufflen);
 		}
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi_merge.c linux/drivers/scsi/scsi_merge.c
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/scsi_merge.c	Thu Jul  5 20:28:17 2001
+++ linux/drivers/scsi/scsi_merge.c	Wed Aug 15 09:14:26 2001
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
@@ -427,14 +426,11 @@
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
@@ -486,14 +482,12 @@
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
@@ -652,10 +646,8 @@
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
@@ -663,7 +655,7 @@
 		 */
 		if (dma_host
 		    && CONTIGUOUS_BUFFERS(req->bhtail, next->bh)
-		    && virt_to_phys(req->bhtail->b_data) - 1 >= ISA_DMA_THRESHOLD )
+		    && bh_bus(req->bhtail) - 1 >= ISA_DMA_THRESHOLD )
 		{
 			int segment_size = 0;
 			int count = 0;
@@ -808,29 +800,6 @@
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
@@ -847,24 +816,16 @@
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
 
@@ -877,7 +838,7 @@
 		 * simply write the first buffer all by itself.
 		 */
 		printk("Warning - running *really* short on DMA buffers\n");
-		this_count = SCpnt->request.current_nr_sectors;
+		this_count = req->current_nr_sectors;
 		goto single_segment;
 	}
 	/* 
@@ -889,11 +850,9 @@
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
@@ -904,7 +863,7 @@
 				 */
 				if( dma_host ) {
 #ifdef DMA_SEGMENT_SIZE_LIMITED
-					if( virt_to_phys(bh->b_data) - 1 < ISA_DMA_THRESHOLD
+					if (bh_bus(bh) - 1 < ISA_DMA_THRESHOLD
 					    || sgpnt[count - 1].length + bh->b_size <= PAGE_SIZE ) {
 						sgpnt[count - 1].length += bh->b_size;
 						bhprev = bh;
@@ -923,12 +882,12 @@
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
 
@@ -951,6 +910,10 @@
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
@@ -986,7 +949,7 @@
 				}
 				break;
 			}
-			if (SCpnt->request.cmd == WRITE) {
+			if (req->cmd == WRITE) {
 				memcpy(sgpnt[i].address, sgpnt[i].alt_address,
 				       sgpnt[i].length);
 			}
@@ -1031,8 +994,7 @@
 	 * single-block requests if we had hundreds of free sectors.
 	 */
 	if( scsi_dma_free_sectors > 30 ) {
-		for (this_count = 0, bh = SCpnt->request.bh;
-		     bh; bh = bh->b_reqnext) {
+		for (this_count = 0, bh = req->bh; bh; bh = bh->b_reqnext) {
 			if( scsi_dma_free_sectors - this_count < 30 
 			    || this_count == sectors )
 			{
@@ -1045,7 +1007,7 @@
 		/*
 		 * Yow!   Take the absolute minimum here.
 		 */
-		this_count = SCpnt->request.current_nr_sectors;
+		this_count = req->current_nr_sectors;
 	}
 
 	/*
@@ -1058,28 +1020,31 @@
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
+				unsigned long flags;
+				char *buf = bh_kmap_irq(bh, &flags);
+				memcpy(buff, buf, this_count << 9);
+				bh_kunmap_irq(buf, &flags);
+			}
 		}
 	}
 	SCpnt->request_bufflen = this_count << 9;
@@ -1127,14 +1092,6 @@
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
@@ -1166,4 +1123,14 @@
 		q->merge_requests_fn = scsi_merge_requests_fn_dc;
 		SDpnt->scsi_init_io_fn = scsi_init_io_vdc;
 	}
+
+	/*
+	 * now enable highmem I/O, if appropriate
+	 */
+#ifdef CONFIG_HIGHMEM
+	if (SHpnt->can_dma_32 && (SDpnt->type == TYPE_DISK))
+		blk_queue_bounce_limit(q, BLK_BOUNCE_4G);
+	else
+		blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
+#endif
 }
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/drivers/scsi/sym53c8xx.h linux/drivers/scsi/sym53c8xx.h
--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/sym53c8xx.h	Fri Jul 20 21:56:08 2001
+++ linux/drivers/scsi/sym53c8xx.h	Wed Aug 15 09:24:32 2001
@@ -96,7 +96,8 @@
 			this_id:        7,			\
 			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
 			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
-			use_clustering: DISABLE_CLUSTERING} 
+			use_clustering: DISABLE_CLUSTERING,	\
+			can_dma_32:	1}
 
 #else
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/fs/buffer.c linux/fs/buffer.c
--- /opt/kernel/linux-2.4.9-pre4/fs/buffer.c	Wed Aug 15 09:19:18 2001
+++ linux/fs/buffer.c	Wed Aug 15 09:14:26 2001
@@ -1327,13 +1327,11 @@
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
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/asm-i386/kmap_types.h linux/include/asm-i386/kmap_types.h
--- /opt/kernel/linux-2.4.9-pre4/include/asm-i386/kmap_types.h	Thu Apr 12 21:11:39 2001
+++ linux/include/asm-i386/kmap_types.h	Wed Aug 15 09:14:26 2001
@@ -6,6 +6,7 @@
 	KM_BOUNCE_WRITE,
 	KM_SKB_DATA,
 	KM_SKB_DATA_SOFTIRQ,
+	KM_BH_IRQ,
 	KM_TYPE_NR
 };
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.4.9-pre4/include/linux/blkdev.h	Wed Aug 15 09:19:05 2001
+++ linux/include/linux/blkdev.h	Wed Aug 15 09:25:18 2001
@@ -36,7 +36,7 @@
 	unsigned long hard_sector, hard_nr_sectors;
 	unsigned int nr_segments;
 	unsigned int nr_hw_segments;
-	unsigned long current_nr_sectors;
+	unsigned long current_nr_sectors, hard_cur_sectors;
 	void * special;
 	char * buffer;
 	struct completion * waiting;
@@ -110,6 +110,8 @@
 	 */
 	char			head_active;
 
+	struct page		*bounce_limit;
+
 	/*
 	 * Is meant to protect the queue in the future instead of
 	 * io_request_lock
@@ -122,6 +124,27 @@
 	wait_queue_head_t	wait_for_request;
 };
 
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
+
 struct blk_dev_struct {
 	/*
 	 * queue_proc has to be atomic
@@ -149,8 +172,7 @@
 extern void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size);
 extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
 extern void generic_make_request(int rw, struct buffer_head * bh);
-extern request_queue_t *blk_get_queue(kdev_t dev);
-extern inline request_queue_t *__blk_get_queue(kdev_t dev);
+extern inline request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
 
 /*
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/linux/fs.h linux/include/linux/fs.h
--- /opt/kernel/linux-2.4.9-pre4/include/linux/fs.h	Wed Aug 15 09:19:19 2001
+++ linux/include/linux/fs.h	Wed Aug 15 09:25:13 2001
@@ -277,6 +277,8 @@
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
+#define bh_bus(bh)		(page_to_bus((bh)->b_page) + bh_offset((bh)))
+
 extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);
 
 #define touch_buffer(bh)	SetPageReferenced(bh->b_page)
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/linux/highmem.h linux/include/linux/highmem.h
--- /opt/kernel/linux-2.4.9-pre4/include/linux/highmem.h	Fri Jul 20 21:52:18 2001
+++ linux/include/linux/highmem.h	Wed Aug 15 09:25:14 2001
@@ -13,8 +13,7 @@
 /* declarations for linux/mm/highmem.c */
 FASTCALL(unsigned int nr_free_highpages(void));
 
-extern struct buffer_head * create_bounce(int rw, struct buffer_head * bh_orig);
-
+extern struct buffer_head *create_bounce(int rw, struct buffer_head * bh_orig);
 
 static inline char *bh_kmap(struct buffer_head *bh)
 {
@@ -26,6 +25,42 @@
 	kunmap(bh->b_page);
 }
 
+/*
+ * remember to add offset! and never ever reenable interrupts between a
+ * bh_kmap_irq and bh_kunmap_irq!!
+ */
+static inline char *bh_kmap_irq(struct buffer_head *bh, unsigned long *flags)
+{
+	unsigned long addr;
+
+	__save_flags(*flags);
+
+	/*
+	 * could be low
+	 */
+	if (!PageHighMem(bh->b_page))
+		return bh->b_data;
+
+	/*
+	 * it's a highmem page
+	 */
+	__cli();
+	addr = (unsigned long) kmap_atomic(bh->b_page, KM_BH_IRQ);
+
+	if (addr & ~PAGE_MASK)
+		BUG();
+
+	return (char *) addr + bh_offset(bh);
+}
+
+static inline void bh_kunmap_irq(char *buffer, unsigned long *flags)
+{
+	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
+
+	kunmap_atomic((void *) ptr, KM_BH_IRQ);
+	__restore_flags(*flags);
+}
+
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
@@ -37,8 +72,10 @@
 #define kmap_atomic(page,idx)		kmap(page)
 #define kunmap_atomic(page,idx)		kunmap(page)
 
-#define bh_kmap(bh)	((bh)->b_data)
-#define bh_kunmap(bh)	do { } while (0)
+#define bh_kmap(bh)			((bh)->b_data)
+#define bh_kunmap(bh)			do { } while (0)
+#define bh_kmap_irq(bh, flags)		((bh)->b_data)
+#define bh_kunmap_irq(bh, flags)	do { } while (0)
 
 #endif /* CONFIG_HIGHMEM */
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.4.9-pre4/include/linux/ide.h	Wed Aug 15 09:19:19 2001
+++ linux/include/linux/ide.h	Wed Aug 15 09:28:25 2001
@@ -485,7 +485,7 @@
 	ide_dmaproc_t	*dmaproc;	/* dma read/write/abort routine */
 	unsigned int	*dmatable_cpu;	/* dma physical region descriptor table (cpu view) */
 	dma_addr_t	dmatable_dma;	/* dma physical region descriptor table (dma view) */
-	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
+	struct sg_list	*sg_table;	/* Scatter-gather list used to build the above */
 	int sg_nents;			/* Current number of entries in it */
 	int sg_dma_direction;		/* dma transfer direction */
 	int sg_dma_active;		/* is it in use */
@@ -507,6 +507,7 @@
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
+	unsigned	highmem	   : 1; /* can do full 32-bit dma */
 	byte		channel;	/* for dual-port chips: 0=primary, 1=secondary */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	struct pci_dev	*pci_dev;	/* for pci chipsets */
@@ -812,6 +813,21 @@
 	ide_preempt,	/* insert rq in front of current request */
 	ide_end		/* insert rq at end of list, but don't wait for it */
 } ide_action_t;
+
+/*
+ * temporarily mapping a (possible) highmem bio
+ */
+#define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
+
+extern inline void *ide_map_buffer(struct request *rq, unsigned long *flags)
+{
+	return bh_kmap_irq(rq->bh, flags) + ide_rq_offset(rq);
+}
+
+extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
+{
+	bh_kunmap_irq(buffer, flags);
+}
 
 /*
  * This function issues a special IDE device request
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9-pre4/kernel/ksyms.c linux/kernel/ksyms.c
--- /opt/kernel/linux-2.4.9-pre4/kernel/ksyms.c	Wed Aug 15 09:19:19 2001
+++ linux/kernel/ksyms.c	Wed Aug 15 09:14:26 2001
@@ -121,6 +121,8 @@
 EXPORT_SYMBOL(kunmap_high);
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(create_bounce);
+EXPORT_SYMBOL(kmap_prot);
+EXPORT_SYMBOL(kmap_pte);
 #endif
 
 /* filesystem internal functions */

--DSayHWYpDlRfCAAQ--
