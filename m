Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031325AbWK3UNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031325AbWK3UNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031342AbWK3ULh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:11:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:9089 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1031343AbWK3ULR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:11:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="171251638:sNHT48712076"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 05/12] md: workqueue for raid5 operations
Date: Thu, 30 Nov 2006 13:10:25 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201025.21313.69191.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Each raid5 device gets its own queue, and each stripe has its own
work_struct.  The goal is to have a free running raid5d thread, i.e. reduce
the time the stripe lock is held by removing bulk memory operations, and
removing the sleeping path in generic_make_request.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/md/raid5.c         |   37 +++++++++++++++++++++++++++++++++----
 include/linux/raid/raid5.h |    6 ++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 232f525..c2312d1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -126,6 +126,7 @@ static void __release_stripe(raid5_conf_
 			}
 			md_wakeup_thread(conf->mddev->thread);
 		} else {
+			BUG_ON(sh->ops.pending);
 			if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
 				atomic_dec(&conf->preread_active_stripes);
 				if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD)
@@ -324,6 +325,15 @@ static struct stripe_head *get_active_st
 	return sh;
 }
 
+static inline void issue_raid_ops(struct stripe_head *sh)
+{
+	raid5_conf_t *conf = sh->raid_conf;
+
+	atomic_inc(&sh->count);
+	conf->workqueue_stripes++;
+	queue_work(sh->raid_conf->workqueue, &sh->ops.work);
+}
+
 static int
 raid5_end_read_request(struct bio * bi, unsigned int bytes_done, int error);
 static int
@@ -868,6 +878,10 @@ static void raid5_run_ops(void *stripe_h
 	} else if (sh->ops.count < 0)
 		BUG();
 
+	/* we kick off work to the engines in batches */
+	if (--(conf->workqueue_stripes) == 0)
+		async_tx_issue_pending_all();
+
 	spin_unlock(&sh->lock);
 
 	set_bit(STRIPE_HANDLE, &sh->state);
@@ -883,6 +897,7 @@ static int grow_one_stripe(raid5_conf_t 
 	memset(sh, 0, sizeof(*sh) + (conf->raid_disks-1)*sizeof(struct r5dev));
 	sh->raid_conf = conf;
 	spin_lock_init(&sh->lock);
+	INIT_WORK(&sh->ops.work, raid5_run_ops, sh);
 
 	if (grow_buffers(sh, conf->raid_disks)) {
 		shrink_buffers(sh, conf->raid_disks);
@@ -1923,7 +1938,6 @@ static int stripe_to_pdidx(sector_t stri
  *    schedule a write of some buffers
  *    return confirmation of parity correctness
  *
- * Parity calculations are done inside the stripe lock
  * buffers are taken off read_list or write_list, and bh_cache buffers
  * get BH_Lock set before the stripe lock is released.
  *
@@ -1942,9 +1956,9 @@ static void handle_stripe5(struct stripe
 	int failed_num=0;
 	struct r5dev *dev;
 
-	PRINTK("handling stripe %llu, cnt=%d, pd_idx=%d\n",
-		(unsigned long long)sh->sector, atomic_read(&sh->count),
-		sh->pd_idx);
+	PRINTK("handling stripe %llu, state=%#lx cnt=%d, pd_idx=%d ops=%lx:%lx:%lx\n",
+	       (unsigned long long)sh->sector, sh->state, atomic_read(&sh->count),
+	       sh->pd_idx, sh->ops.pending, sh->ops.ack, sh->ops.complete);
 
 	spin_lock(&sh->lock);
 	clear_bit(STRIPE_HANDLE, &sh->state);
@@ -2409,6 +2423,10 @@ #endif
 			}
 	}
 
+	if (sh->ops.count && !test_and_set_bit(STRIPE_OPSQUEUE_ACTIVE, &sh->state)) {
+		issue_raid_ops(sh);
+	}
+
 	spin_unlock(&sh->lock);
 
 	while ((bi=return_bi)) {
@@ -3717,6 +3735,13 @@ static int run(mddev_t *mddev)
 		if (!conf->spare_page)
 			goto abort;
 	}
+
+	sprintf(conf->workqueue_name, "%s_raid5_ops",
+		mddev->gendisk->disk_name);
+
+	if ((conf->workqueue = create_workqueue(conf->workqueue_name)) == NULL)
+		goto abort;
+
 	spin_lock_init(&conf->device_lock);
 	init_waitqueue_head(&conf->wait_for_stripe);
 	init_waitqueue_head(&conf->wait_for_overlap);
@@ -3726,6 +3751,7 @@ static int run(mddev_t *mddev)
 	INIT_LIST_HEAD(&conf->inactive_list);
 	atomic_set(&conf->active_stripes, 0);
 	atomic_set(&conf->preread_active_stripes, 0);
+	conf->workqueue_stripes = 0;
 
 	PRINTK("raid5: run(%s) called.\n", mdname(mddev));
 
@@ -3879,6 +3905,8 @@ abort:
 		safe_put_page(conf->spare_page);
 		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
+		if (conf->workqueue)
+			destroy_workqueue(conf->workqueue);
 		kfree(conf);
 	}
 	mddev->private = NULL;
@@ -3899,6 +3927,7 @@ static int stop(mddev_t *mddev)
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
 	kfree(conf->disks);
+	destroy_workqueue(conf->workqueue);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
diff --git a/include/linux/raid/raid5.h b/include/linux/raid/raid5.h
index a1c3f85..c77154a 100644
--- a/include/linux/raid/raid5.h
+++ b/include/linux/raid/raid5.h
@@ -3,6 +3,7 @@ #define _RAID5_H
 
 #include <linux/raid/md.h>
 #include <linux/raid/xor.h>
+#include <linux/workqueue.h>
 
 /*
  *
@@ -170,6 +171,7 @@ struct stripe_head {
 		unsigned long	   pending;  /* pending operations (set for request->issue->complete) */
 		unsigned long	   ack;	     /* submitted operations (set for issue->complete */
 		unsigned long	   complete; /* completed operations flags (set for complete) */
+		struct work_struct work;     /* move ops from request to issue to complete */
 		int		   target;   /* STRIPE_OP_COMPUTE_BLK target */
 		int		   count;    /* workqueue runs when this is non-zero */
 		u32		   zero_sum_result;
@@ -289,11 +291,15 @@ struct raid5_private_data {
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
 
 	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
+
+	struct workqueue_struct *workqueue;
+	int			workqueue_stripes; /* stripes awaiting raid5_run_ops service */
 	/* unfortunately we need two cache names as we temporarily have
 	 * two caches.
 	 */
 	int			active_name;
 	char			cache_name[2][20];
+	char			workqueue_name[20];
 	kmem_cache_t		*slab_cache; /* for allocating stripes */
 
 	int			seq_flush, seq_write;
