Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756594AbWKVTFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbWKVTFO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbWKVTFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:05:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756594AbWKVTFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:05:10 -0500
Date: Wed, 22 Nov 2006 19:05:06 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Jonathan E Brassow <jbrassow@redhat.com>
Subject: [PATCH 10/11] dm: log: rename complete_resync_work
Message-ID: <20061122190506.GA6993@agk.surrey.redhat.com>
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

The complete_resync_work function only provides the ability to change an
out-of-sync region to in-sync.  This patch enhances the function to allow
us to change the status from in-sync to out-of-sync as well, something
that is needed when a mirror write to one of the devices or an initial
resync on a given region fails.

Signed-off-by: Jonathan E Brassow <jbrassow@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc6/drivers/md/dm-log.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-log.c	2006-11-22 17:26:44.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-log.c	2006-11-22 17:27:01.000000000 +0000
@@ -549,16 +549,19 @@ static int core_get_resync_work(struct d
 	return 1;
 }
 
-static void core_complete_resync_work(struct dirty_log *log, region_t region,
-				      int success)
+static void core_set_region_sync(struct dirty_log *log, region_t region,
+				 int in_sync)
 {
 	struct log_c *lc = (struct log_c *) log->context;
 
 	log_clear_bit(lc, lc->recovering_bits, region);
-	if (success) {
+	if (in_sync) {
 		log_set_bit(lc, lc->sync_bits, region);
                 lc->sync_count++;
-        }
+        } else if (log_test_bit(lc->sync_bits, region)) {
+		lc->sync_count--;
+		log_clear_bit(lc, lc->sync_bits, region);
+	}
 }
 
 static region_t core_get_sync_count(struct dirty_log *log)
@@ -625,7 +628,7 @@ static struct dirty_log_type _core_type 
 	.mark_region = core_mark_region,
 	.clear_region = core_clear_region,
 	.get_resync_work = core_get_resync_work,
-	.complete_resync_work = core_complete_resync_work,
+	.set_region_sync = core_set_region_sync,
 	.get_sync_count = core_get_sync_count,
 	.status = core_status,
 };
@@ -644,7 +647,7 @@ static struct dirty_log_type _disk_type 
 	.mark_region = core_mark_region,
 	.clear_region = core_clear_region,
 	.get_resync_work = core_get_resync_work,
-	.complete_resync_work = core_complete_resync_work,
+	.set_region_sync = core_set_region_sync,
 	.get_sync_count = core_get_sync_count,
 	.status = disk_status,
 };
Index: linux-2.6.19-rc6/drivers/md/dm-log.h
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-log.h	2006-11-22 17:26:44.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-log.h	2006-11-22 17:27:01.000000000 +0000
@@ -90,12 +90,12 @@ struct dirty_log_type {
 	int (*get_resync_work)(struct dirty_log *log, region_t *region);
 
 	/*
-	 * This notifies the log that the resync of an area has
-	 * been completed.  The log should then mark this region
-	 * as CLEAN.
+	 * This notifies the log that the resync status of a region
+	 * has changed.  It also clears the region from the recovering
+	 * list (if present).
 	 */
-	void (*complete_resync_work)(struct dirty_log *log,
-				     region_t region, int success);
+	void (*set_region_sync)(struct dirty_log *log,
+				region_t region, int in_sync);
 
         /*
 	 * Returns the number of regions that are in sync.
Index: linux-2.6.19-rc6/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-raid1.c	2006-11-22 17:26:58.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-raid1.c	2006-11-22 17:27:01.000000000 +0000
@@ -344,6 +344,17 @@ static void dispatch_bios(struct mirror_
 	}
 }
 
+static void complete_resync_work(struct region *reg, int success)
+{
+	struct region_hash *rh = reg->rh;
+
+	rh->log->type->set_region_sync(rh->log, reg->key, success);
+	dispatch_bios(rh->ms, &reg->delayed_bios);
+	if (atomic_dec_and_test(&rh->recovery_in_flight))
+		wake_up_all(&_kmirrord_recovery_stopped);
+	up(&rh->recovery_count);
+}
+
 static void rh_update_states(struct region_hash *rh)
 {
 	struct region *reg, *next;
@@ -383,11 +394,7 @@ static void rh_update_states(struct regi
 	 */
 	list_for_each_entry_safe (reg, next, &recovered, list) {
 		rh->log->type->clear_region(rh->log, reg->key);
-		rh->log->type->complete_resync_work(rh->log, reg->key, 1);
-		dispatch_bios(rh->ms, &reg->delayed_bios);
-		if (atomic_dec_and_test(&rh->recovery_in_flight))
-			wake_up_all(&_kmirrord_recovery_stopped);
-		up(&rh->recovery_count);
+		complete_resync_work(reg, 1);
 		mempool_free(reg, rh->region_pool);
 	}
 
