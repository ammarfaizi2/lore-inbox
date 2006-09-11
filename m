Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWIKXXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWIKXXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWIKXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:23:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:34868 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965104AbWIKXSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128869294:sNHT281988931"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 02/19] raid5: move write operations to a workqueue
Date: Mon, 11 Sep 2006 16:17:46 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231746.4737.82707.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Enable handle_stripe5 to pass off write operations to
raid5_do_soft_blocks_ops (which can be run as a workqueue).  The operations
moved are reconstruct-writes and read-modify-writes formerly handled by
compute_parity5.

Changelog:
* moved raid5_do_soft_block_ops changes into a separate patch
* changed handle_write_operations5 to only initiate write operations, which
prevents new writes from being requested while the current one is in flight
* all blocks undergoing a write are now marked locked and !uptodate at the
beginning of the write operation
* blocks undergoing a read-modify-write need a request flag to distinguish
them from blocks that are locked for reading. Reconstruct-writes still use
the R5_LOCKED bit to select blocks for the operation
* integrated the work queue Kconfig option

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/Kconfig         |   21 +++++
 drivers/md/raid5.c         |  192 ++++++++++++++++++++++++++++++++++++++------
 include/linux/raid/raid5.h |    3 +
 3 files changed, 190 insertions(+), 26 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index bf869ed..2a16b3b 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -162,6 +162,27 @@ config MD_RAID5_RESHAPE
 	  There should be enough spares already present to make the new
 	  array workable.
 
+config MD_RAID456_WORKQUEUE
+	depends on MD_RAID456
+	bool "Offload raid work to a workqueue from raid5d"
+	---help---
+	  This option enables raid work (block copy and xor operations)
+	  to run in a workqueue.  If your platform has a high context
+	  switch penalty say N.  If you are using hardware offload or
+	  are running on an SMP platform say Y.
+
+	  If unsure say, Y.
+
+config MD_RAID456_WORKQUEUE_MULTITHREAD
+	depends on MD_RAID456_WORKQUEUE && SMP
+	bool "Enable multi-threaded raid processing"
+	default y
+	---help---
+	  This option controls whether the raid workqueue will be multi-
+	  threaded or single threaded.
+
+	  If unsure say, Y.
+
 config MD_MULTIPATH
 	tristate "Multipath I/O support"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8fde62b..e39d248 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -222,6 +222,8 @@ static void init_stripe(struct stripe_he
 
 	BUG_ON(atomic_read(&sh->count) != 0);
 	BUG_ON(test_bit(STRIPE_HANDLE, &sh->state));
+	BUG_ON(sh->ops.state);
+	BUG_ON(sh->ops.pending);
 	
 	CHECK_DEVLOCK();
 	PRINTK("init_stripe called, stripe %llu\n", 
@@ -331,6 +333,9 @@ static int grow_one_stripe(raid5_conf_t 
 	memset(sh, 0, sizeof(*sh) + (conf->raid_disks-1)*sizeof(struct r5dev));
 	sh->raid_conf = conf;
 	spin_lock_init(&sh->lock);
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
+	INIT_WORK(&sh->ops.work, conf->do_block_ops, sh);
+	#endif
 
 	if (grow_buffers(sh, conf->raid_disks)) {
 		shrink_buffers(sh, conf->raid_disks);
@@ -1266,7 +1271,72 @@ static void compute_block_2(struct strip
 	}
 }
 
+static int handle_write_operations5(struct stripe_head *sh, int rcw)
+{
+	int i, pd_idx = sh->pd_idx, disks = sh->disks;
+	int locked=0;
+
+	if (rcw == 0) {
+		/* skip the drain operation on an expand */
+		if (test_bit(STRIPE_OP_RCW_Expand, &sh->ops.state)) {
+			set_bit(STRIPE_OP_RCW, &sh->state);
+			set_bit(STRIPE_OP_RCW_Parity, &sh->ops.state);
+			for (i=disks ; i-- ;) {
+				set_bit(R5_LOCKED, &sh->dev[i].flags);
+				locked++;
+			}
+		} else { /* enter stage 1 of reconstruct write operation */
+			set_bit(STRIPE_OP_RCW, &sh->state);
+			set_bit(STRIPE_OP_RCW_Drain, &sh->ops.state);
+			for (i=disks ; i-- ;) {
+				struct r5dev *dev = &sh->dev[i];
+
+				if (dev->towrite) {
+					set_bit(R5_LOCKED, &dev->flags);
+					clear_bit(R5_UPTODATE, &dev->flags);
+					locked++;
+				}
+			}
+		}
+	} else {
+		/* enter stage 1 of read modify write operation */
+		BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
+
+		set_bit(STRIPE_OP_RMW, &sh->state);
+		set_bit(STRIPE_OP_RMW_ParityPre, &sh->ops.state);
+		for (i=disks ; i-- ;) {
+			struct r5dev *dev = &sh->dev[i];
+			if (i==pd_idx)
+				continue;
+
+			/* For a read-modify write there may be blocks that are
+			 * locked for reading while others are ready to be written
+			 * so we distinguish these blocks by the RMWReq bit
+			 */
+			if (dev->towrite &&
+			    test_bit(R5_UPTODATE, &dev->flags)) {
+				set_bit(R5_RMWReq, &dev->flags);
+				set_bit(R5_LOCKED, &dev->flags);
+				clear_bit(R5_UPTODATE, &dev->flags);
+				locked++;
+			}
+		}
+	}
+
+	/* keep the parity disk locked while asynchronous operations
+	 * are in flight
+	 */
+	set_bit(R5_LOCKED, &sh->dev[pd_idx].flags);
+	clear_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
+	locked++;
+	sh->ops.pending++;
 
+	PRINTK("%s: stripe %llu locked: %d op_state: %lx\n",
+		__FUNCTION__, (unsigned long long)sh->sector,
+		locked, sh->ops.state);
+
+	return locked;
+}
 
 /*
  * Each stripe/dev can have one or more bion attached.
@@ -1664,7 +1734,6 @@ static void raid5_do_soft_block_ops(void
  *    schedule a write of some buffers
  *    return confirmation of parity correctness
  *
- * Parity calculations are done inside the stripe lock
  * buffers are taken off read_list or write_list, and bh_cache buffers
  * get BH_Lock set before the stripe lock is released.
  *
@@ -1679,13 +1748,13 @@ static void handle_stripe5(struct stripe
 	int i;
 	int syncing, expanding, expanded;
 	int locked=0, uptodate=0, to_read=0, to_write=0, failed=0, written=0;
-	int non_overwrite = 0;
+	int non_overwrite=0, write_complete=0;
 	int failed_num=0;
 	struct r5dev *dev;
 
-	PRINTK("handling stripe %llu, cnt=%d, pd_idx=%d\n",
-		(unsigned long long)sh->sector, atomic_read(&sh->count),
-		sh->pd_idx);
+	PRINTK("handling stripe %llu, state=%#lx cnt=%d, pd_idx=%d\n",
+	       (unsigned long long)sh->sector, sh->state, atomic_read(&sh->count),
+	       sh->pd_idx);
 
 	spin_lock(&sh->lock);
 	clear_bit(STRIPE_HANDLE, &sh->state);
@@ -1926,8 +1995,56 @@ #endif
 		set_bit(STRIPE_HANDLE, &sh->state);
 	}
 
-	/* now to consider writing and what else, if anything should be read */
-	if (to_write) {
+	/* Now we check to see if any write operations have recently
+	 * completed
+	 */
+	if (test_bit(STRIPE_OP_RCW, &sh->state) &&
+		test_bit(STRIPE_OP_RCW_Done, &sh->ops.state)) {
+		clear_bit(STRIPE_OP_RCW, &sh->state);
+		clear_bit(STRIPE_OP_RCW_Done, &sh->ops.state);
+		write_complete++;
+	}
+
+	if (test_bit(STRIPE_OP_RMW, &sh->state) &&
+		test_bit(STRIPE_OP_RMW_Done, &sh->ops.state)) {
+		clear_bit(STRIPE_OP_RMW, &sh->state);
+		clear_bit(STRIPE_OP_RMW_Done, &sh->ops.state);
+		BUG_ON(++write_complete > 1);
+		for (i=disks; i--;)
+			clear_bit(R5_RMWReq, &sh->dev[i].flags);
+	}
+
+	/* All the 'written' buffers and the parity block are ready to be
+	 * written back to disk
+	 */
+	if (write_complete) {
+		BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[sh->pd_idx].flags));
+		for (i=disks; i--;) {
+			dev = &sh->dev[i];
+			if (test_bit(R5_LOCKED, &dev->flags) &&
+				(i == sh->pd_idx || dev->written)) {
+				PRINTK("Writing block %d\n", i);
+				set_bit(R5_Wantwrite, &dev->flags);
+				if (!test_bit(R5_Insync, &dev->flags)
+				    || (i==sh->pd_idx && failed == 0))
+					set_bit(STRIPE_INSYNC, &sh->state);
+			}
+		}
+		if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
+			atomic_dec(&conf->preread_active_stripes);
+			if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
+				md_wakeup_thread(conf->mddev->thread);
+		}
+	}
+
+	/* 1/ Now to consider new write requests and what else, if anything should be read
+	 * 2/ Check operations clobber the parity block so do not start new writes while
+	 *    a check is in flight
+	 * 3/ Write operations do not stack
+	 */
+	if (to_write && !test_bit(STRIPE_OP_RCW, &sh->state) &&
+		!test_bit(STRIPE_OP_RMW, &sh->state) &&
+		!test_bit(STRIPE_OP_CHECK, &sh->state)) {
 		int rmw=0, rcw=0;
 		for (i=disks ; i--;) {
 			/* would I have to read this buffer for read_modify_write */
@@ -2000,25 +2117,8 @@ #endif
 			}
 		/* now if nothing is locked, and if we have enough data, we can start a write request */
 		if (locked == 0 && (rcw == 0 ||rmw == 0) &&
-		    !test_bit(STRIPE_BIT_DELAY, &sh->state)) {
-			PRINTK("Computing parity...\n");
-			compute_parity5(sh, rcw==0 ? RECONSTRUCT_WRITE : READ_MODIFY_WRITE);
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
-		}
+		    !test_bit(STRIPE_BIT_DELAY, &sh->state))
+			locked += handle_write_operations5(sh, rcw);
 	}
 
 	/* maybe we need to check and possibly fix the parity for this stripe
@@ -2150,8 +2250,17 @@ #endif
 			}
 	}
 
+	queue_raid_work(sh);
+
 	spin_unlock(&sh->lock);
 
+	#ifndef CONFIG_MD_RAID456_WORKQUEUE
+	while (test_bit(STRIPE_OP_QUEUED, &sh->state)) {
+		PRINTK("run do_block_ops\n");
+		conf->do_block_ops(sh);
+	}
+	#endif
+
 	while ((bi=return_bi)) {
 		int bytes = bi->bi_size;
 
@@ -3439,6 +3548,30 @@ static int run(mddev_t *mddev)
 		if (!conf->spare_page)
 			goto abort;
 	}
+
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
+	sprintf(conf->workqueue_name, "%s_raid5_ops",
+		mddev->gendisk->disk_name);
+
+	#ifdef CONFIG_MD_RAID456_MULTITHREAD
+	if ((conf->block_ops_queue = create_workqueue(conf->workqueue_name))
+				     == NULL)
+		goto abort;
+	#else
+	if ((conf->block_ops_queue = create_singlethread_workqueue(
+					conf->workqueue_name)) == NULL)
+		goto abort;
+	#endif
+	#endif
+
+	/* To Do:
+	 * 1/ Offload to asynchronous copy / xor engines
+	 * 2/ Automated selection of optimal do_block_ops
+	 *	routine similar to the xor template selection
+	 */
+	conf->do_block_ops = raid5_do_soft_block_ops;
+
+
 	spin_lock_init(&conf->device_lock);
 	init_waitqueue_head(&conf->wait_for_stripe);
 	init_waitqueue_head(&conf->wait_for_overlap);
@@ -3598,6 +3731,10 @@ abort:
 		safe_put_page(conf->spare_page);
 		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
+		#ifdef CONFIG_MD_RAID456_WORKQUEUE
+		if (conf->do_block_ops)
+			destroy_workqueue(conf->block_ops_queue);
+		#endif
 		kfree(conf);
 	}
 	mddev->private = NULL;
@@ -3618,6 +3755,9 @@ static int stop(mddev_t *mddev)
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
 	kfree(conf->disks);
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
+	destroy_workqueue(conf->block_ops_queue);
+	#endif
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index c8a315b..31ae55c 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -3,6 +3,7 @@ #define _RAID5_H
 
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
+#include <linux/workqueue.h>
 
 /*
  *
@@ -333,6 +334,7 @@ struct raid5_private_data {
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
 
 	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
+
 	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	struct workqueue_struct *block_ops_queue;
 	#endif
@@ -376,6 +378,7 @@ struct raid5_private_data {
 typedef struct raid5_private_data raid5_conf_t;
 
 #define mddev_to_conf(mddev) ((raid5_conf_t *) mddev->private)
+
 /* must be called under the stripe lock */
 static inline void queue_raid_work(struct stripe_head *sh)
 {
