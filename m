Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270748AbRH1Li4>; Tue, 28 Aug 2001 07:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270787AbRH1Lih>; Tue, 28 Aug 2001 07:38:37 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:16659 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S270748AbRH1Lic>; Tue, 28 Aug 2001 07:38:32 -0400
Date: Tue, 28 Aug 2001 13:41:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
Message-ID: <20010828134141.M642@suse.de>
In-Reply-To: <20010827123700.B1092@suse.de> <m3itf85vlr.fsf@linux.local> <20010828125520.L642@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <20010828125520.L642@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 28 2001, Jens Axboe wrote:
> On Tue, Aug 28 2001, Christoph Rohland wrote:
> > Hi Jens,
> > 
> > I tested both #11 and #13 on my 8GB machine with sym53c8xx. The
> > initialization of a SAP DB database takes 20 minutes with 2.4.9 and
> > with 2.4.9+b13 it took nearly 2.5 hours :-(
> 
> DaveM hinted that it's probably the bounce test failing, so it's
> bouncing all the time. That would explain the much worse performance.
> Could you try with this incremental patch on top of b13 for 2.4.9? I
> still want to see the boot detection info, btw.
> 
> THanks!

Ok found the bug -- SCSI was accidentally using blk_seg_merge_ok when it
just wanted to test if we were crossing a 4GB physical address boundary
or not. Doh! Attached incremental patch should fix the SCSI performance
issue. I'm testing right now...

-- 
Jens Axboe


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=block-highmem-all-13-any-2

diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- /opt/kernel/linux-2.4.9/arch/i386/kernel/setup.c	Wed Jul 11 18:31:44 2001
+++ linux/arch/i386/kernel/setup.c	Mon Aug 27 15:03:14 2001
@@ -152,6 +152,8 @@
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
 
+unsigned long max_pfn;
+
 /*
  * This is set up by the setup-routine at boot-time
  */
@@ -768,7 +770,7 @@
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long bootmap_size, low_mem_size;
-	unsigned long start_pfn, max_pfn, max_low_pfn;
+	unsigned long start_pfn, max_low_pfn;
 	int i;
 
 #ifdef CONFIG_VISWS
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.4.9/drivers/block/ll_rw_blk.c	Tue Aug 28 12:51:56 2001
+++ linux/drivers/block/ll_rw_blk.c	Tue Aug 28 13:26:33 2001
@@ -125,7 +125,7 @@
  */
 static int queue_nr_requests, batch_requests;
 
-unsigned long blk_max_low_pfn;
+unsigned long blk_max_low_pfn, blk_max_pfn;
 
 static inline int get_max_sectors(kdev_t dev)
 {
@@ -292,8 +292,7 @@
 	if (!BH_CONTIG(bh, nxt))
 		return 0;
 
-	if ((bh_phys(bh) | 0xffffffff) ==
-	    ((bh_phys(nxt) + nxt->b_size - 1) | 0xffffffff))
+	if (BH_PHYS_4G(bh, nxt))
 		return 1;
 
 	return 0;
@@ -1207,6 +1206,7 @@
 	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
 
 	blk_max_low_pfn = max_low_pfn;
+	blk_max_pfn = max_pfn;
 
 #ifdef CONFIG_AMIGA_Z2RAM
 	z2_init();
@@ -1328,4 +1328,5 @@
 EXPORT_SYMBOL(generic_unplug_device);
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 EXPORT_SYMBOL(blk_max_low_pfn);
+EXPORT_SYMBOL(blk_max_pfn);
 EXPORT_SYMBOL(blk_seg_merge_ok);
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9/drivers/scsi/scsi_merge.c linux/drivers/scsi/scsi_merge.c
--- /opt/kernel/linux-2.4.9/drivers/scsi/scsi_merge.c	Tue Aug 28 12:51:56 2001
+++ linux/drivers/scsi/scsi_merge.c	Tue Aug 28 13:35:07 2001
@@ -417,7 +417,7 @@
 
 	if ((req->nr_sectors + (bh->b_size >> 9)) > SHpnt->max_sectors)
 		return 0;
-	else if (!blk_seg_merge_ok(q, req->bhtail, bh))
+	else if (!BH_PHYS_4G(req->bhtail, bh))
 		return 0;
 
 	if (use_clustering) {
@@ -475,7 +475,7 @@
 
 	if ((req->nr_sectors + (bh->b_size >> 9)) > SHpnt->max_sectors)
 		return 0;
-	else if (!blk_seg_merge_ok(q, bh, req->bh))
+	else if (!BH_PHYS_4G(bh, req->bh))
 		return 0;
 
 	if (use_clustering) {
@@ -610,7 +610,7 @@
 	SDpnt = (Scsi_Device *) q->queuedata;
 	SHpnt = SDpnt->host;
 
-	if (!blk_seg_merge_ok(q, req->bhtail, next->bh))
+	if (!BH_PHYS_4G(req->bhtail, next->bh))
 		return 0;
 
 #ifdef DMA_CHUNK_SIZE
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.4.9/include/linux/blkdev.h	Tue Aug 28 12:51:56 2001
+++ linux/include/linux/blkdev.h	Tue Aug 28 13:27:42 2001
@@ -126,10 +126,10 @@
 	wait_queue_head_t	wait_for_request;
 };
 
-extern unsigned long blk_max_low_pfn;
+extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
 #define BLK_BOUNCE_HIGH		(blk_max_low_pfn * PAGE_SIZE)
-#define BLK_BOUNCE_ANY		(~(unsigned long long) 0)
+#define BLK_BOUNCE_ANY		(blk_max_pfn * PAGE_SIZE)
 
 extern void blk_queue_bounce_limit(request_queue_t *, dma64_addr_t);
 
@@ -150,6 +150,7 @@
 #define bh_phys(bh)		(page_to_phys((bh)->b_page) + bh_offset((bh)))
 
 #define BH_CONTIG(b1, b2)	(bh_phys((b1)) + (b1)->b_size == bh_phys((b2)))
+#define BH_PHYS_4G(b1, b2)	((bh_phys((b1)) | 0xffffffff) == ((bh_phys((b2)) + (b2)->b_size - 1) | 0xffffffff))
 
 struct blk_dev_struct {
 	/*
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.9/include/linux/bootmem.h linux/include/linux/bootmem.h
--- /opt/kernel/linux-2.4.9/include/linux/bootmem.h	Wed Aug 15 23:22:13 2001
+++ linux/include/linux/bootmem.h	Mon Aug 27 14:53:47 2001
@@ -18,6 +18,11 @@
 extern unsigned long min_low_pfn;
 
 /*
+ * highest page
+ */
+extern unsigned long max_pfn;
+
+/*
  * node_bootmem_map is a map pointer - the bits represent all physical 
  * memory pages (including holes) on the node.
  */

--7gGkHNMELEOhSGF6--
