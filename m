Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSFQGvz>; Mon, 17 Jun 2002 02:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSFQGva>; Mon, 17 Jun 2002 02:51:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316797AbSFQGtA>;
	Mon, 17 Jun 2002 02:49:00 -0400
Message-ID: <3D0D874D.5464CAC8@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [patch 13/19] take bio.h out of highmem.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



highmem.h includes bio.h, so just about every compilation unit in the
kernel gets to process bio.h.

The patch moves the BIO-related functions out of highmem.h and into
bio-related headers.  The nested include is removed and all files which
need to include bio.h now do so.



--- 2.5.22/fs/bio.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/fs/bio.c	Sun Jun 16 22:50:19 2002
@@ -17,6 +17,7 @@
  *
  */
 #include <linux/mm.h>
+#include <linux/bio.h>
 #include <linux/blk.h>
 #include <linux/slab.h>
 #include <linux/iobuf.h>
--- 2.5.22/include/linux/highmem.h~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/highmem.h	Sun Jun 16 22:50:19 2002
@@ -2,7 +2,6 @@
 #define _LINUX_HIGHMEM_H
 
 #include <linux/config.h>
-#include <linux/bio.h>
 #include <linux/fs.h>
 #include <asm/cacheflush.h>
 
@@ -15,45 +14,8 @@ extern struct page *highmem_start_page;
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 
-extern void create_bounce(unsigned long pfn, int gfp, struct bio **bio_orig);
 extern void check_highmem_ptes(void);
 
-/*
- * remember to add offset! and never ever reenable interrupts between a
- * bio_kmap_irq and bio_kunmap_irq!!
- */
-static inline char *bio_kmap_irq(struct bio *bio, unsigned long *flags)
-{
-	unsigned long addr;
-
-	__save_flags(*flags);
-
-	/*
-	 * could be low
-	 */
-	if (!PageHighMem(bio_page(bio)))
-		return bio_data(bio);
-
-	/*
-	 * it's a highmem page
-	 */
-	__cli();
-	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
-
-	if (addr & ~PAGE_MASK)
-		BUG();
-
-	return (char *) addr + bio_offset(bio);
-}
-
-static inline void bio_kunmap_irq(char *buffer, unsigned long *flags)
-{
-	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
-
-	kunmap_atomic((void *) ptr, KM_BIO_SRC_IRQ);
-	__restore_flags(*flags);
-}
-
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
@@ -65,12 +27,6 @@ static inline void *kmap(struct page *pa
 #define kmap_atomic(page,idx)		kmap(page)
 #define kunmap_atomic(page,idx)		kunmap(page)
 
-#define bh_kmap(bh)	((bh)->b_data)
-#define bh_kunmap(bh)	do { } while (0)
-
-#define bio_kmap_irq(bio, flags)	(bio_data(bio))
-#define bio_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
-
 #endif /* CONFIG_HIGHMEM */
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
--- 2.5.22/include/linux/bio.h~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/bio.h	Sun Jun 16 22:50:19 2002
@@ -21,6 +21,8 @@
 #define __LINUX_BIO_H
 
 #include <linux/kdev_t.h>
+#include <linux/highmem.h>
+
 /* Platforms may set this to teach the BIO layer about IOMMU hardware. */
 #include <asm/io.h>
 #ifndef BIO_VMERGE_BOUNDARY
@@ -47,9 +49,6 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
 
-/*
- * weee, c forward decl...
- */
 struct bio;
 typedef void (bio_end_io_t) (struct bio *);
 typedef void (bio_destructor_t) (struct bio *);
@@ -206,4 +205,49 @@ extern inline void bio_init(struct bio *
 
 extern int bio_ioctl(kdev_t, unsigned int, unsigned long);
 
+#ifdef CONFIG_HIGHMEM
+/*
+ * remember to add offset! and never ever reenable interrupts between a
+ * bio_kmap_irq and bio_kunmap_irq!!
+ *
+ * This function MUST be inlined - it plays with the CPU interrupt flags.
+ * Hence the `extern inline'.
+ */
+extern inline char *bio_kmap_irq(struct bio *bio, unsigned long *flags)
+{
+	unsigned long addr;
+
+	__save_flags(*flags);
+
+	/*
+	 * could be low
+	 */
+	if (!PageHighMem(bio_page(bio)))
+		return bio_data(bio);
+
+	/*
+	 * it's a highmem page
+	 */
+	__cli();
+	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
+
+	if (addr & ~PAGE_MASK)
+		BUG();
+
+	return (char *) addr + bio_offset(bio);
+}
+
+extern inline void bio_kunmap_irq(char *buffer, unsigned long *flags)
+{
+	unsigned long ptr = (unsigned long) buffer & PAGE_MASK;
+
+	kunmap_atomic((void *) ptr, KM_BIO_SRC_IRQ);
+	__restore_flags(*flags);
+}
+
+#else
+#define bio_kmap_irq(bio, flags)	(bio_data(bio))
+#define bio_kunmap_irq(buf, flags)	do { *(flags) = 0; } while (0)
+#endif
+
 #endif /* __LINUX_BIO_H */
--- 2.5.22/include/linux/buffer_head.h~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/buffer_head.h	Sun Jun 16 23:22:45 2002
@@ -106,12 +106,7 @@ BUFFER_FNS(Async_Read, async_read)
 BUFFER_FNS(Async_Write, async_write)
 BUFFER_FNS(Boundary, boundary)
 
-/*
- * FIXME: this is used only by bh_kmap, which is used only by RAID5.
- * Move all that stuff into raid5.c
- */
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
-
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)
 
 /* If we *know* page->private refers to buffer_heads */
--- 2.5.22/include/linux/blkdev.h~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/blkdev.h	Sun Jun 16 22:50:19 2002
@@ -246,12 +246,7 @@ extern unsigned long blk_max_low_pfn, bl
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
 extern int init_emergency_isa_pool(void);
-extern void create_bounce(unsigned long pfn, int gfp, struct bio **bio_orig);
-
-extern inline void blk_queue_bounce(request_queue_t *q, struct bio **bio)
-{
-	create_bounce(q->bounce_pfn, q->bounce_gfp, bio);
-}
+void blk_queue_bounce(request_queue_t *q, struct bio **bio);
 
 #define rq_for_each_bio(bio, rq)	\
 	if ((rq->bio))			\
--- 2.5.22/kernel/ksyms.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/kernel/ksyms.c	Sun Jun 16 23:22:44 2002
@@ -120,7 +120,7 @@ EXPORT_SYMBOL(vmtruncate);
 EXPORT_SYMBOL(find_vma);
 EXPORT_SYMBOL(get_unmapped_area);
 EXPORT_SYMBOL(init_mm);
-EXPORT_SYMBOL(create_bounce);
+EXPORT_SYMBOL(blk_queue_bounce);
 #ifdef CONFIG_HIGHMEM
 EXPORT_SYMBOL(kmap_high);
 EXPORT_SYMBOL(kunmap_high);
--- 2.5.22/mm/highmem.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/mm/highmem.c	Sun Jun 16 22:50:19 2002
@@ -17,6 +17,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/bio.h>
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
 #include <linux/blkdev.h>
@@ -347,13 +348,15 @@ static void bounce_end_io_read_isa(struc
 	return __bounce_end_io_read(bio, isa_page_pool);
 }
 
-void create_bounce(unsigned long pfn, int gfp, struct bio **bio_orig)
+void blk_queue_bounce(request_queue_t *q, struct bio **bio_orig)
 {
 	struct page *page;
 	struct bio *bio = NULL;
 	int i, rw = bio_data_dir(*bio_orig), bio_gfp;
 	struct bio_vec *to, *from;
 	mempool_t *pool;
+	unsigned long pfn = q->bounce_pfn;
+	int gfp = q->bounce_gfp;
 
 	BUG_ON((*bio_orig)->bi_idx);
 
--- 2.5.22/drivers/block/elevator.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/elevator.c	Sun Jun 16 22:50:19 2002
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
+#include <linux/bio.h>
 #include <linux/blk.h>
 #include <linux/config.h>
 #include <linux/module.h>
--- 2.5.22/drivers/block/ll_rw_blk.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/ll_rw_blk.c	Sun Jun 16 22:50:19 2002
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/config.h>
+#include <linux/bio.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/init.h>
--- 2.5.22/drivers/block/floppy.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/floppy.c	Sun Jun 16 22:50:19 2002
@@ -165,6 +165,7 @@ static int print_unex=1;
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/bio.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/delay.h>
--- 2.5.22/drivers/block/loop.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/loop.c	Sun Jun 16 22:50:19 2002
@@ -60,6 +60,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/bio.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/major.h>
--- 2.5.22/include/linux/ide.h~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/ide.h	Sun Jun 16 22:50:19 2002
@@ -15,6 +15,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/bio.h>
 #include <asm/byteorder.h>
 #include <asm/hdreg.h>
 
--- 2.5.22/drivers/block/rd.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/rd.c	Sun Jun 16 22:50:19 2002
@@ -45,6 +45,8 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <asm/atomic.h>
+#include <linux/bio.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
--- 2.5.22/drivers/md/linear.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/linear.c	Sun Jun 16 22:50:19 2002
@@ -20,7 +20,7 @@
 
 #include <linux/raid/md.h>
 #include <linux/slab.h>
-
+#include <linux/bio.h>
 #include <linux/raid/linear.h>
 
 #define MAJOR_NR MD_MAJOR
--- 2.5.22/drivers/md/raid0.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/raid0.c	Sun Jun 16 22:50:19 2002
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/raid/raid0.h>
+#include <linux/bio.h>
 
 #define MAJOR_NR MD_MAJOR
 #define MD_DRIVER
--- 2.5.22/drivers/md/md.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/md.c	Sun Jun 16 22:50:19 2002
@@ -33,6 +33,7 @@
 #include <linux/linkage.h>
 #include <linux/raid/md.h>
 #include <linux/sysctl.h>
+#include <linux/bio.h>
 #include <linux/raid/xor.h>
 #include <linux/devfs_fs_kernel.h>
 
--- 2.5.22/drivers/scsi/scsi_lib.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/scsi/scsi_lib.c	Sun Jun 16 22:50:19 2002
@@ -23,6 +23,7 @@
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/bio.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/stat.h>
--- 2.5.22/drivers/scsi/sd.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/scsi/sd.c	Sun Jun 16 22:50:19 2002
@@ -36,6 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/bio.h>
 #include <linux/string.h>
 #include <linux/hdreg.h>
 #include <linux/errno.h>
--- 2.5.22/drivers/block/cpqarray.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/cpqarray.c	Sun Jun 16 22:50:19 2002
@@ -24,6 +24,7 @@
 #include <linux/version.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/bio.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
--- 2.5.22/drivers/block/DAC960.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/DAC960.c	Sun Jun 16 22:50:19 2002
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/blk.h>
 #include <linux/blkdev.h>
+#include <linux/bio.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/genhd.h>
--- 2.5.22/drivers/block/cciss.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/cciss.c	Sun Jun 16 22:50:19 2002
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/major.h>
 #include <linux/fs.h>
+#include <linux/bio.h>
 #include <linux/blkpg.h>
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
--- 2.5.22/drivers/block/umem.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/umem.c	Sun Jun 16 22:50:19 2002
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/bio.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
--- 2.5.22/drivers/block/nbd.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/block/nbd.c	Sun Jun 16 22:50:19 2002
@@ -39,6 +39,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/bio.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
 #include <linux/file.h>
--- 2.5.22/drivers/md/raid1.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/raid1.c	Sun Jun 16 22:50:19 2002
@@ -23,6 +23,7 @@
  */
 
 #include <linux/raid/raid1.h>
+#include <linux/bio.h>
 
 #define MAJOR_NR MD_MAJOR
 #define MD_DRIVER
--- 2.5.22/drivers/md/raid5.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/raid5.c	Sun Jun 16 22:50:19 2002
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/raid/raid5.h>
+#include <linux/bio.h>
 #include <asm/bitops.h>
 #include <asm/atomic.h>
 
--- 2.5.22/drivers/md/lvm.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/lvm.c	Sun Jun 16 22:50:19 2002
@@ -209,6 +209,7 @@
 #include <linux/hdreg.h>
 #include <linux/stat.h>
 #include <linux/fs.h>
+#include <linux/bio.h>
 #include <linux/proc_fs.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
--- 2.5.22/drivers/md/multipath.c~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/drivers/md/multipath.c	Sun Jun 16 22:50:19 2002
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/raid/multipath.h>
+#include <linux/bio.h>
 #include <linux/buffer_head.h>
 #include <asm/atomic.h>
 
--- 2.5.22/include/linux/raid/raid5.h~cleanup-highmem-no-bio	Sun Jun 16 22:50:19 2002
+++ 2.5.22-akpm/include/linux/raid/raid5.h	Sun Jun 16 22:50:19 2002
@@ -3,6 +3,7 @@
 
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
+#include <linux/bio.h>
 
 /*
  *
--- 2.5.22/fs/jfs/jfs_logmgr.c~cleanup-highmem-no-bio	Sun Jun 16 22:58:59 2002
+++ 2.5.22-akpm/fs/jfs/jfs_logmgr.c	Sun Jun 16 22:59:02 2002
@@ -65,6 +65,7 @@
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/buffer_head.h>		/* for sync_blockdev() */
+#include <linux/bio.h>
 #include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_metapage.h"
--- 2.5.22/drivers/scsi/cpqfcTSinit.c~cleanup-highmem-no-bio	Sun Jun 16 23:04:57 2002
+++ 2.5.22-akpm/drivers/scsi/cpqfcTSinit.c	Sun Jun 16 23:05:06 2002
@@ -39,6 +39,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/init.h>
 #include <linux/ioport.h>  // request_region() prototype
 #include <linux/vmalloc.h> // ioremap()
 //#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,7)
--- 2.5.22/drivers/scsi/sr.c~cleanup-highmem-no-bio	Sun Jun 16 23:06:44 2002
+++ 2.5.22-akpm/drivers/scsi/sr.c	Sun Jun 16 23:06:53 2002
@@ -39,6 +39,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/bio.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/cdrom.h>

-
