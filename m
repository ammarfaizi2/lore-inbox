Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWF2VJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWF2VJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWF2VJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:09:50 -0400
Received: from mga03.intel.com ([143.182.124.21]:6587 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932647AbWF2VJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:09:47 -0400
X-IronPort-AV: i="4.06,193,1149490800"; 
   d="scan'208"; a="59399325:sNHT6929598137"
Subject: Re: [PATCH 000 of 006] raid5: Offload RAID operations to a
	workqueue
From: Dan Williams <dan.j.williams@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
In-Reply-To: <0C7297FA1D2D244A9C7F6959C0BF1E52298255@azsmsx413>
References: <0C7297FA1D2D244A9C7F6959C0BF1E52298255@azsmsx413>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 14:08:42 -0700
Message-Id: <1151615322.5038.20.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> since using work queues involve more context switches than doing things
> inline... have you measured the performance impact of your changes? If
> so... was there any impact that you could measure, and how big was that?
> 
> Greetings,
>     Arjan van de Ven

Good point.  Especially on ARM extra context switching can be very
expensive.  In general more testing (and testers for that matter) is
needed.  To facilitate the determination of whether a multi-threaded
work queue is better/worse than an in context implementation here is a
patch that makes this configurable.

Thanks,

Dan


[PATCH] raid5: Configuration options to allow raid ops to run in raid5d context

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 drivers/md/Kconfig         |   21 +++++++++++++++++++++
 drivers/md/raid5.c         |   25 +++++++++++++++++++++++++
 include/linux/raid/raid5.h |    6 ++++++
 3 files changed, 52 insertions(+)

Index: linux-2.6-raid/drivers/md/Kconfig
===================================================================
--- linux-2.6-raid.orig/drivers/md/Kconfig	2006-06-29 11:40:02.000000000 -0700
+++ linux-2.6-raid/drivers/md/Kconfig	2006-06-29 13:43:03.000000000 -0700
@@ -162,6 +162,27 @@
 	  There should be enough spares already present to make the new
 	  array workable.
 
+config MD_RAID456_WORKQUEUE
+	depends on MD_RAID456
+	bool "Offload raid work to a workqueue from raid5d"
+	---help---
+	  This option enables raid work (block copy and xor operations)
+	  to run in a workqueue.  However this may come at the expense of
+	  extra context switching.  Single processor systems may benefit
+	  from keeping the work within the raid5d context.
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
Index: linux-2.6-raid/drivers/md/raid5.c
===================================================================
--- linux-2.6-raid.orig/drivers/md/raid5.c	2006-06-29 13:42:57.000000000 -0700
+++ linux-2.6-raid/drivers/md/raid5.c	2006-06-29 13:43:03.000000000 -0700
@@ -305,7 +305,9 @@
 	memset(sh, 0, sizeof(*sh) + (conf->raid_disks-1)*sizeof(struct r5dev));
 	sh->raid_conf = conf;
 	spin_lock_init(&sh->lock);
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	INIT_WORK(&sh->ops.work, conf->do_block_ops, sh);
+	#endif
 
 	if (grow_buffers(sh, conf->raid_disks)) {
 		shrink_buffers(sh, conf->raid_disks);
@@ -1352,8 +1354,10 @@
 {
 	if (!test_bit(STRIPE_OP_QUEUED, &sh->state) && sh->ops.pending) {
 		set_bit(STRIPE_OP_QUEUED, &sh->state);
+		#ifdef CONFIG_MD_RAID456_WORKQUEUE
 		atomic_inc(&sh->count);
 		queue_work(sh->raid_conf->block_ops_queue, &sh->ops.work);
+		#endif
 	}
 }
 
@@ -1614,7 +1618,9 @@
 	queue_raid_work(sh);
 	spin_unlock(&sh->lock);
 
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	release_stripe(sh);
+	#endif
 }
 
 /*
@@ -2182,6 +2188,13 @@
 
 	spin_unlock(&sh->lock);
 
+	#ifndef CONFIG_MD_RAID456_WORKQUEUE
+	while (test_bit(STRIPE_OP_QUEUED, &sh->state)) {
+		PRINTK("run do_block_ops\n", __FUNCTION__);
+		conf->do_block_ops(sh);
+	}
+	#endif
+
 	while ((bi=return_bi)) {
 		int bytes = bi->bi_size;
 
@@ -3480,12 +3493,20 @@
 			goto abort;
 	}
 
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	sprintf(conf->workqueue_name, "%s_raid5_ops",
 		mddev->gendisk->disk_name);
 
+	#ifdef CONFIG_MD_RAID456_MULTITHREAD
 	if ((conf->block_ops_queue = create_workqueue(conf->workqueue_name))
 				     == NULL)
 		goto abort;
+	#else
+	if ((conf->block_ops_queue = __create_workqueue(conf->workqueue_name, 1))
+				     == NULL)
+		goto abort;
+	#endif
+	#endif
 
 	/* To Do:
 	 * 1/ Offload to asynchronous copy / xor engines
@@ -3656,8 +3677,10 @@
 		safe_put_page(conf->spare_page);
 		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
+		#ifdef CONFIG_MD_RAID456_WORKQUEUE
 		if (conf->do_block_ops)
 			destroy_workqueue(conf->block_ops_queue);
+		#endif
 		kfree(conf);
 	}
 	mddev->private = NULL;
@@ -3678,7 +3701,9 @@
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
 	kfree(conf->disks);
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	destroy_workqueue(conf->block_ops_queue);
+	#endif
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;
Index: linux-2.6-raid/include/linux/raid/raid5.h
===================================================================
--- linux-2.6-raid.orig/include/linux/raid/raid5.h	2006-06-29 11:53:35.000000000 -0700
+++ linux-2.6-raid/include/linux/raid/raid5.h	2006-06-29 13:43:03.000000000 -0700
@@ -149,7 +149,9 @@
 	struct stripe_operations {
 		int			pending;	/* number of operations requested */
 		unsigned long		state;		/* state of block operations */
+		#ifdef CONFIG_MD_RAID456_WORKQUEUE
 		struct work_struct	work;		/* work queue descriptor */
+		#endif
 		#ifdef CONFIG_DMA_ENGINE
 		u32 			dma_result;	/* storage for dma engine results */
 		dma_cookie_t		dma_cookie;	/* last issued dma operation */
@@ -298,7 +300,9 @@
 
 	atomic_t		reshape_stripes; /* stripes with pending writes for reshape */
 
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	struct workqueue_struct *block_ops_queue;
+	#endif
 	void (*do_block_ops)(void *);
 
 	/* unfortunately we need two cache names as we temporarily have
@@ -306,7 +310,9 @@
 	 */
 	int			active_name;
 	char			cache_name[2][20];
+	#ifdef CONFIG_MD_RAID456_WORKQUEUE
 	char			workqueue_name[20];
+	#endif
 	kmem_cache_t		*slab_cache; /* for allocating stripes */
 
 	int			seq_flush, seq_write;
