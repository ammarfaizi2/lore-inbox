Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270546AbSISInJ>; Thu, 19 Sep 2002 04:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270558AbSISInJ>; Thu, 19 Sep 2002 04:43:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S270546AbSISInG>;
	Thu, 19 Sep 2002 04:43:06 -0400
Date: Thu, 19 Sep 2002 10:47:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Current 2.5-BK tree dies on boot!
Message-ID: <20020919084754.GC936@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18 2002, Anton Altaparmakov wrote:
> This is without preempt. I tried both with and without SMP, with and without
> large TLB pages, with and without pte highmem, all die in the same place.

You have highmem, and bouncing does not get correctly enabled on the ide
drives. This, in combination with broken bouncing (woops), will probably
make it die fairly quickly.

I attach two patches, one fixes the bouncing, the other fixes IDE bounce
enable.

-- 
Jens Axboe


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-high-2

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.583   -> 1.584  
#	 include/linux/ide.h	1.16    -> 1.17   
#	drivers/ide/ide-dma.c	1.3     -> 1.4    
#	drivers/ide/ide-probe.c	1.12    -> 1.13   
#	drivers/ide/ide-lib.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	axboe@burns.home.kernel.dk	1.584
# ide_toggle_bounce() was called prior to init'ing the block queue,
# which then reset the bounce_pfn back to BLK_BOUNCE_HIGH. Make
# ide_toggle_bounce() an ide-lib helper, and call it when setting up
# the queue as well.
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Thu Sep 19 09:17:30 2002
+++ b/drivers/ide/ide-dma.c	Thu Sep 19 09:17:30 2002
@@ -445,20 +445,6 @@
 	return 0;
 }
 
-static void ide_toggle_bounce(ide_drive_t *drive, int on)
-{
-	u64 addr = BLK_BOUNCE_HIGH;	/* dma64_addr_t */
-
-	if (on && drive->media == ide_disk) {
-		if (!PCI_DMA_BUS_IS_PHYS)
-			addr = BLK_BOUNCE_ANY;
-		else
-			addr = HWIF(drive)->pci_dev->dma_mask;
-	}
-
-	blk_queue_bounce_limit(&drive->queue, addr);
-}
-
 int __ide_dma_host_off (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c	Thu Sep 19 09:17:30 2002
+++ b/drivers/ide/ide-lib.c	Thu Sep 19 09:17:30 2002
@@ -386,3 +386,19 @@
 }
 
 EXPORT_SYMBOL_GPL(ide_get_best_pio_mode);
+
+void ide_toggle_bounce(ide_drive_t *drive, int on)
+{
+	u64 addr = BLK_BOUNCE_HIGH;	/* dma64_addr_t */
+
+	if (on && drive->media == ide_disk) {
+		if (!PCI_DMA_BUS_IS_PHYS)
+			addr = BLK_BOUNCE_ANY;
+		else
+			addr = HWIF(drive)->pci_dev->dma_mask;
+	}
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+}
+
+EXPORT_SYMBOL(ide_toggle_bounce);
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Thu Sep 19 09:17:30 2002
+++ b/drivers/ide/ide-probe.c	Thu Sep 19 09:17:30 2002
@@ -778,6 +778,8 @@
 
 	/* This is a driver limit and could be eliminated. */
 	blk_queue_max_phys_segments(q, PRD_ENTRIES);
+
+	ide_toggle_bounce(drive, 1);
 }
 
 /*
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Thu Sep 19 09:17:30 2002
+++ b/include/linux/ide.h	Thu Sep 19 09:17:30 2002
@@ -1753,6 +1753,7 @@
 extern u8 ide_rate_filter(u8 mode, u8 speed); 
 extern int ide_dma_enable(ide_drive_t *drive);
 extern char *ide_xfer_verbose(u8 xfer_rate);
+extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 
 extern spinlock_t ide_lock;
 

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bounce-end_io-2

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.582   -> 1.583  
#	        mm/highmem.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/19	axboe@burns.home.kernel.dk	1.583
# clean up highmem bounce end_io handling
# --------------------------------------------
#
diff -Nru a/mm/highmem.c b/mm/highmem.c
--- a/mm/highmem.c	Thu Sep 19 08:15:17 2002
+++ b/mm/highmem.c	Thu Sep 19 08:15:17 2002
@@ -291,16 +291,12 @@
 	}
 }
 
-static inline int bounce_end_io(struct bio *bio, unsigned int bytes_done,
-				int error, mempool_t *pool)
+static void bounce_end_io(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig = bio->bi_private;
 	struct bio_vec *bvec, *org_vec;
 	int i;
 
-	if (bio->bi_size)
-		return 1;
-
 	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
 		goto out_eio;
 
@@ -318,43 +314,54 @@
 	}
 
 out_eio:
-	bio_endio(bio_orig, bytes_done, error);
+	bio_endio(bio_orig, bio_orig->bi_size, 0);
 	bio_put(bio);
-	return 0;
 }
 
-static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done,
-			       int error)
+static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done,int err)
 {
-	return bounce_end_io(bio, bytes_done, error, page_pool);
+	if (bio->bi_size)
+		return 1;
+
+	bounce_end_io(bio, page_pool);
+	return 0;
 }
 
-static int bounce_end_io_write_isa(struct bio *bio, unsigned int bytes_done,
-				   int error)
+static int bounce_end_io_write_isa(struct bio *bio, unsigned int bytes_done, int err)
 {
-	return bounce_end_io(bio, bytes_done, error, isa_page_pool);
+	if (bio->bi_size)
+		return 1;
+
+	bounce_end_io(bio, isa_page_pool);
+	return 0;
 }
 
-static inline int __bounce_end_io_read(struct bio *bio, unsigned int done,
-				       int error, mempool_t *pool)
+static inline void __bounce_end_io_read(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig = bio->bi_private;
 
 	if (test_bit(BIO_UPTODATE, &bio->bi_flags))
 		copy_to_high_bio_irq(bio_orig, bio);
 
-	return bounce_end_io(bio, done, error, pool);
+	bounce_end_io(bio, pool);
 }
 
 static int bounce_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
 {
-	return __bounce_end_io_read(bio, bytes_done, err, page_pool);
+	if (bio->bi_size)
+		return 1;
+
+	__bounce_end_io_read(bio, page_pool);
+	return 0;
 }
 
-static int bounce_end_io_read_isa(struct bio *bio, unsigned int bytes_done,
-				  int err)
+static int bounce_end_io_read_isa(struct bio *bio, unsigned int bytes_done, int err)
 {
-	return __bounce_end_io_read(bio, bytes_done, err, isa_page_pool);
+	if (bio->bi_size)
+		return 1;
+
+	__bounce_end_io_read(bio, isa_page_pool);
+	return 0;
 }
 
 void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)

--jho1yZJdad60DJr+--
