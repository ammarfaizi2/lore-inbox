Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWKGScv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWKGScv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbWKGScv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:32:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754255AbWKGSct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:32:49 -0500
Date: Tue, 7 Nov 2006 18:32:43 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Jonathan E Brassow <jbrassow@redhat.com>
Subject: [PATCH 2.6.19 4/5] dm: raid1: fix waiting for io on suspend
Message-ID: <20061107183243.GF6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Jonathan E Brassow <jbrassow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan E Brassow <jbrassow@redhat.com>

All device-mapper targets must complete outstanding I/O before suspending.  The
mirror target generates I/O in its recovery phase and fails to wait for it.  It
needs to be tracked so we can ensure that it has completed before we suspend.

Signed-off-by: Jonathan E Brassow <jbrassow@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc4/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.19-rc4.orig/drivers/md/dm-raid1.c	2006-11-07 17:06:23.000000000 +0000
+++ linux-2.6.19-rc4/drivers/md/dm-raid1.c	2006-11-07 17:25:42.000000000 +0000
@@ -24,6 +24,7 @@
 
 static struct workqueue_struct *_kmirrord_wq;
 static struct work_struct _kmirrord_work;
+DECLARE_WAIT_QUEUE_HEAD(_kmirrord_recovery_stopped);
 
 static inline void wake(void)
 {
@@ -83,6 +84,7 @@ struct region_hash {
 	struct list_head *buckets;
 
 	spinlock_t region_lock;
+	atomic_t recovery_in_flight;
 	struct semaphore recovery_count;
 	struct list_head clean_regions;
 	struct list_head quiesced_regions;
@@ -191,6 +193,7 @@ static int rh_init(struct region_hash *r
 
 	spin_lock_init(&rh->region_lock);
 	sema_init(&rh->recovery_count, 0);
+	atomic_set(&rh->recovery_in_flight, 0);
 	INIT_LIST_HEAD(&rh->clean_regions);
 	INIT_LIST_HEAD(&rh->quiesced_regions);
 	INIT_LIST_HEAD(&rh->recovered_regions);
@@ -382,6 +385,8 @@ static void rh_update_states(struct regi
 		rh->log->type->clear_region(rh->log, reg->key);
 		rh->log->type->complete_resync_work(rh->log, reg->key, 1);
 		dispatch_bios(rh->ms, &reg->delayed_bios);
+		if (atomic_dec_and_test(&rh->recovery_in_flight))
+			wake_up_all(&_kmirrord_recovery_stopped);
 		up(&rh->recovery_count);
 		mempool_free(reg, rh->region_pool);
 	}
@@ -502,11 +507,21 @@ static int __rh_recovery_prepare(struct 
 
 static void rh_recovery_prepare(struct region_hash *rh)
 {
-	while (!down_trylock(&rh->recovery_count))
+	/* Extra reference to avoid race with rh_stop_recovery */
+	atomic_inc(&rh->recovery_in_flight);
+
+	while (!down_trylock(&rh->recovery_count)) {
+		atomic_inc(&rh->recovery_in_flight);
 		if (__rh_recovery_prepare(rh) <= 0) {
+			atomic_dec(&rh->recovery_in_flight);
 			up(&rh->recovery_count);
 			break;
 		}
+	}
+
+	/* Drop the extra reference */
+	if (atomic_dec_and_test(&rh->recovery_in_flight))
+		wake_up_all(&_kmirrord_recovery_stopped);
 }
 
 /*
@@ -1177,6 +1192,11 @@ static void mirror_postsuspend(struct dm
 	struct dirty_log *log = ms->rh.log;
 
 	rh_stop_recovery(&ms->rh);
+
+	/* Wait for all I/O we generated to complete */
+	wait_event(_kmirrord_recovery_stopped,
+		   !atomic_read(&ms->rh.recovery_in_flight));
+
 	if (log->type->suspend && log->type->suspend(log))
 		/* FIXME: need better error handling */
 		DMWARN("log suspend failed");
