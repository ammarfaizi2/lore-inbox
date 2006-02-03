Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWBCBrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWBCBrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBCBrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:47:48 -0500
Received: from fmr18.intel.com ([134.134.136.17]:143 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932357AbWBCBrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:47:46 -0500
Subject: [RFC][PATCH 003 of 3] MD Acceleration: raid5 changes to support
	asynchronous operation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 18:47:45 -0700
Message-Id: <1138931265.6620.11.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces one call to compute_parity with the new
raid5_issue_compute_parity.  To support md_adma a number of routines and
definitions needed to be made available in raid5.h.  In anticipation of
raid6 support the handle_stripe and release_stripe routines were
prefixed with raid5_.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index ac43f98..b45720c 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -106,7 +106,7 @@ config MD_RAID10
 
 config MD_RAID5
 	tristate "RAID-4/RAID-5 mode"
-	depends on BLK_DEV_MD
+	depends on BLK_DEV_MD && ADMA
 	---help---
 	  A RAID-5 set of N drives with a capacity of C MB per drive provides
 	  the capacity of C * (N - 1) MB, and protects against a failure
@@ -129,7 +129,7 @@ config MD_RAID5
 
 config MD_RAID6
 	tristate "RAID-6 mode"
-	depends on BLK_DEV_MD
+	depends on BLK_DEV_MD && ADMA
 	---help---
 	  A RAID-6 set of N drives with a capacity of C MB per drive
 	  provides the capacity of C * (N - 2) MB, and protects
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index d3efedf..9b3e65f 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -25,8 +25,8 @@ obj-$(CONFIG_MD_LINEAR)		+= linear.o
 obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
 obj-$(CONFIG_MD_RAID10)		+= raid10.o
-obj-$(CONFIG_MD_RAID5)		+= raid5.o xor.o
-obj-$(CONFIG_MD_RAID6)		+= raid6.o xor.o
+obj-$(CONFIG_MD_RAID5)		+= raid5.o md_adma.o xor.o
+obj-$(CONFIG_MD_RAID6)		+= raid6.o md_adma.o xor.o
 obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_MD_FAULTY)		+= faulty.o
 obj-$(CONFIG_BLK_DEV_MD)	+= md-mod.o
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 25976bf..56a5068 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -25,31 +25,18 @@
 #include <asm/atomic.h>
 
 #include <linux/raid/bitmap.h>
-
+#include <linux/adma/md_adma.h>
 /*
  * Stripe cache
  */
 
 #define NR_STRIPES		256
-#define STRIPE_SIZE		PAGE_SIZE
 #define STRIPE_SHIFT		(PAGE_SHIFT - 9)
-#define STRIPE_SECTORS		(STRIPE_SIZE>>9)
-#define	IO_THRESHOLD		1
 #define NR_HASH			(PAGE_SIZE / sizeof(struct hlist_head))
 #define HASH_MASK		(NR_HASH - 1)
 
 #define stripe_hash(conf, sect)	(&((conf)->stripe_hashtbl[((sect) >> STRIPE_SHIFT) & HASH_MASK]))
 
-/* bio's attached to a stripe+device for I/O are linked together in bi_sector
- * order without overlap.  There may be several bio's per stripe+device, and
- * a bio could span several devices.
- * When walking this list for a particular stripe+device, we must never proceed
- * beyond a bio that extends past this device, as the next bio might no longer
- * be valid.
- * This macro is used to determine the 'next' bio in the list, given the sector
- * of the current stripe+device
- */
-#define r5_next_bio(bio, sect) ( ( (bio)->bi_sector + ((bio)->bi_size>>9) < sect + STRIPE_SECTORS) ? (bio)->bi_next : NULL)
 /*
  * The following can be used to debug the driver
  */
@@ -101,7 +88,7 @@ static void __release_stripe(raid5_conf_
 		}
 	}
 }
-static void release_stripe(struct stripe_head *sh)
+void raid5_release_stripe(struct stripe_head *sh)
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	unsigned long flags;
@@ -304,7 +291,7 @@ static int grow_one_stripe(raid5_conf_t 
 	atomic_set(&sh->count, 1);
 	atomic_inc(&conf->active_stripes);
 	INIT_LIST_HEAD(&sh->lru);
-	release_stripe(sh);
+	raid5_release_stripe(sh);
 	return 1;
 }
 
@@ -385,7 +372,7 @@ static int raid5_end_read_request(struct
 		/* we can return a buffer if we bypassed the cache or
 		 * if the top buffer is not in highmem.  If there are
 		 * multiple buffers, leave the extra work to
-		 * handle_stripe
+		 * raid5_handle_stripe
 		 */
 		buffer = sh->bh_read[i];
 		if (buffer &&
@@ -448,7 +435,7 @@ static int raid5_end_read_request(struct
 #endif
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
-	release_stripe(sh);
+	raid5_release_stripe(sh);
 	return 0;
 }
 
@@ -909,9 +896,8 @@ static int add_stripe_bio(struct stripe_
 	return 0;
 }
 
-
 /*
- * handle_stripe - do things to a stripe.
+ * raid5_handle_stripe - do things to a stripe.
  *
  * We lock the stripe and then examine the state of various bits
  * to see what needs to be done.
@@ -921,6 +907,7 @@ static int add_stripe_bio(struct stripe_
  *    schedule a read on some buffers
  *    schedule a write of some buffers
  *    return confirmation of parity correctness
+ *    issue async stripe operations (xor, memcpy, memset) TBI
  *
  * Parity calculations are done inside the stripe lock
  * buffers are taken off read_list or write_list, and bh_cache buffers
@@ -928,7 +915,7 @@ static int add_stripe_bio(struct stripe_
  *
  */
  
-static void handle_stripe(struct stripe_head *sh)
+void raid5_handle_stripe(struct stripe_head *sh)
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	int disks = conf->raid_disks;
@@ -937,6 +924,7 @@ static void handle_stripe(struct stripe_
 	int i;
 	int syncing;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
+	int in_write=0, xor=0;
 	int non_overwrite = 0;
 	int failed_num=0;
 	struct r5dev *dev;
@@ -958,8 +946,10 @@ static void handle_stripe(struct stripe_
 		dev = &sh->dev[i];
 		clear_bit(R5_Insync, &dev->flags);
 
-		PRINTK("check %d: state 0x%lx read %p write %p written %p\n",
-			i, dev->flags, dev->toread, dev->towrite, dev->written);
+		PRINTK("check %d: state 0x%lx read %p write %p written %p"
+		       " in_write %p\n",
+			i, dev->flags, dev->toread, dev->towrite, dev->written,
+		        dev->inwrite);
 		/* maybe we can reply to a read */
 		if (test_bit(R5_UPTODATE, &dev->flags) && dev->toread) {
 			struct bio *rbi, *rbi2;
@@ -986,6 +976,7 @@ static void handle_stripe(struct stripe_
 		/* now count some things */
 		if (test_bit(R5_LOCKED, &dev->flags)) locked++;
 		if (test_bit(R5_UPTODATE, &dev->flags)) uptodate++;
+		if (test_bit(R5_InAsyncXor, &dev->flags)) xor++;
 
 		
 		if (dev->toread) to_read++;
@@ -995,6 +986,7 @@ static void handle_stripe(struct stripe_
 				non_overwrite++;
 		}
 		if (dev->written) written++;
+		if (dev->inwrite) in_write++;
 		rdev = rcu_dereference(conf->disks[i].rdev);
 		if (!rdev || !test_bit(In_sync, &rdev->flags)) {
 			/* The ReadError flag will just be confusing now */
@@ -1253,26 +1245,17 @@ static void handle_stripe(struct stripe_
 					}
 				}
 			}
-		/* now if nothing is locked, and if we have enough data, we can start a write request */
-		if (locked == 0 && (rcw == 0 ||rmw == 0) &&
+		/* now if nothing is locked, and if we have enough data, we can start a write request
+		 * note: if an xor calculation is in progress we can still submit the write, as we rely
+		 * on the xor engine to keep the operations in order
+		 */
+		if ((locked == 0 || xor) && (rcw == 0 || rmw == 0) &&
 		    !test_bit(STRIPE_BIT_DELAY, &sh->state)) {
 			PRINTK("Computing parity...\n");
-			compute_parity(sh, rcw==0 ? RECONSTRUCT_WRITE : READ_MODIFY_WRITE);
-			/* now every locked buffer is ready to be written */
-			for (i=disks; i--;)
-				if (test_bit(R5_LOCKED, &sh->dev[i].flags)) {
-					PRINTK("Writing block %d\n", i);
-					locked++;
-					set_bit(R5_Wantwrite, &sh->dev[i].flags);
-					if (!test_bit(R5_Insync, &sh->dev[i].flags)
-					    || (i==sh->pd_idx && failed == 0))
-						set_bit(STRIPE_INSYNC, &sh->state);
-				}
-			if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
-				atomic_dec(&conf->preread_active_stripes);
-				if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
-					md_wakeup_thread(conf->mddev->thread);
-			}
+			locked += raid5_issue_compute_parity(sh, rcw==0 ? RECONSTRUCT_WRITE : READ_MODIFY_WRITE);
+			/* once R5_InAsyncXor is dropped every locked buffer will be 
+			 * ready to be written.  This is handled by the callback: raid5_adma_callback
+			 */
 		}
 	}
 
@@ -1571,14 +1554,14 @@ static int make_request (request_queue_t
 				 * and wait a while
 				 */
 				raid5_unplug_device(mddev->queue);
-				release_stripe(sh);
+				raid5_release_stripe(sh);
 				schedule();
 				goto retry;
 			}
 			finish_wait(&conf->wait_for_overlap, &w);
 			raid5_plug_device(conf);
-			handle_stripe(sh);
-			release_stripe(sh);
+			raid5_handle_stripe(sh);
+			raid5_release_stripe(sh);
 
 		} else {
 			/* cannot get stripe for read-ahead, just give-up */
@@ -1669,8 +1652,8 @@ static sector_t sync_request(mddev_t *md
 	clear_bit(STRIPE_INSYNC, &sh->state);
 	spin_unlock(&sh->lock);
 
-	handle_stripe(sh);
-	release_stripe(sh);
+	raid5_handle_stripe(sh);
+	raid5_release_stripe(sh);
 
 	return STRIPE_SECTORS;
 }
@@ -1725,8 +1708,8 @@ static void raid5d (mddev_t *mddev)
 		spin_unlock_irq(&conf->device_lock);
 		
 		handled++;
-		handle_stripe(sh);
-		release_stripe(sh);
+		raid5_handle_stripe(sh);
+		raid5_release_stripe(sh);
 
 		spin_lock_irq(&conf->device_lock);
 	}
@@ -1918,7 +1901,16 @@ static int run(mddev_t *mddev)
 				mdname(mddev));
 			goto abort;
 		}
+
 	}
+
+	if (!(conf->adma_engine = adma_engine_init())) {
+		printk(KERN_ERR 
+			"raid5: couldn't initialize adma engine for %s\n",
+			mdname(mddev));
+		goto abort;
+	}
+
 	memory = conf->max_nr_stripes * (sizeof(struct stripe_head) +
 		 conf->raid_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 1024;
 	if (grow_stripes(conf, conf->max_nr_stripes)) {
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index 394da82..968f40c 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -3,6 +3,7 @@
 
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
+#include <linux/adma/md_adma.h>
 
 /*
  *
@@ -133,13 +134,14 @@ struct stripe_head {
 	int			pd_idx;			/* parity disk index */
 	unsigned long		state;			/* state flags */
 	atomic_t		count;			/* nr of active thread/requests */
+	atomic_t		xor_count;		/* nr of async adma ops in flight */
 	spinlock_t		lock;
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	struct r5dev {
 		struct bio	req;
 		struct bio_vec	vec;
 		struct page	*page;
-		struct bio	*toread, *towrite, *written;
+		struct bio	*toread, *towrite, *written, *inwrite;
 		sector_t	sector;			/* sector of this page */
 		unsigned long	flags;
 	} dev[1]; /* allocated with extra space depending of RAID geometry */
@@ -155,6 +157,7 @@ struct stripe_head {
 #define	R5_Overlap	7	/* There is a pending overlapping request on this block */
 #define	R5_ReadError	8	/* seen a read error here recently */
 #define	R5_ReWrite	9	/* have tried to over-write the readerror */
+#define 	R5_InAsyncXor	10	/* softens R5_LOCKED to allow queueing additional ops */
 
 /*
  * Write method
@@ -163,6 +166,8 @@ struct stripe_head {
 #define READ_MODIFY_WRITE	2
 /* not a write method, but a compute_parity mode */
 #define	CHECK_PARITY		3
+/* not a write method, but a xor operation recognized by raid5_adma_callback */
+#define COMPUTE_BLOCK		4
 
 /*
  * Stripe state
@@ -215,6 +220,7 @@ struct raid5_private_data {
 	struct list_head	delayed_list; /* stripes that have plugged requests */
 	struct list_head	bitmap_list; /* stripes delaying awaiting bitmap update */
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
+	adma_engine_t		*adma_engine; /* async data operations engine handle */
 
 	char			cache_name[20];
 	kmem_cache_t		*slab_cache; /* for allocating stripes */
@@ -246,6 +252,8 @@ struct raid5_private_data {
 typedef struct raid5_private_data raid5_conf_t;
 
 #define mddev_to_conf(mddev) ((raid5_conf_t *) mddev->private)
+void raid5_handle_stripe(struct stripe_head *sh);
+void raid5_release_stripe(struct stripe_head *sh);
 
 /*
  * Our supported algorithms
@@ -255,4 +263,21 @@ typedef struct raid5_private_data raid5_
 #define ALGORITHM_LEFT_SYMMETRIC	2
 #define ALGORITHM_RIGHT_SYMMETRIC	3
 
+/* Definitions needed by md_adma */
+
+/* bio's attached to a stripe+device for I/O are linked together in bi_sector
+ * order without overlap.  There may be several bio's per stripe+device, and
+ * a bio could span several devices.
+ * When walking this list for a particular stripe+device, we must never proceed
+ * beyond a bio that extends past this device, as the next bio might no longer
+ * be valid.
+ * This macro is used to determine the 'next' bio in the list, given the sector
+ * of the current stripe+device
+ */
+#define r5_next_bio(bio, sect) ( ( (bio)->bi_sector + ((bio)->bi_size>>9) < sect + STRIPE_SECTORS) ? (bio)->bi_next : NULL)
+
+#define IO_THRESHOLD			1
+#define STRIPE_SIZE		PAGE_SIZE
+#define STRIPE_SECTORS		(STRIPE_SIZE>>9)
+
 #endif
diff --git a/drivers/Kconfig b/drivers/Kconfig
index bddf431..c887854 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -68,6 +68,8 @@ source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
 
+source "drivers/adma/Kconfig"
+
 source "drivers/edac/Kconfig"
 
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 619dd96..df547d5 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_ADMA)              += adma/


