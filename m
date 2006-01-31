Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWAaApk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWAaApk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWAaApk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:45:40 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:59914 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965049AbWAaApj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:45:39 -0500
Subject: [git patch review 2/4] IB/srp: Semaphore to mutex conversion
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 31 Jan 2006 00:45:32 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1138668332064-f9cb54cbde95165a@cisco.com>
In-Reply-To: <1138668332064-a06b57921710eb35@cisco.com>
X-OriginalArrivalTime: 31 Jan 2006 00:45:35.0976 (UTC) FILETIME=[A6128E80:01C625FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert srp_host->target_mutex from a semaphore to a mutex.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/srp/ib_srp.c |   14 +++++++-------
 drivers/infiniband/ulp/srp/ib_srp.h |    5 ++---
 2 files changed, 9 insertions(+), 10 deletions(-)

8e9e5f4f5eb1d44ddabfd1ddea4ca4e4244a9ffb
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 31207e6..2d2d4ac 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -357,9 +357,9 @@ static void srp_remove_work(void *target
 	target->state = SRP_TARGET_REMOVED;
 	spin_unlock_irq(target->scsi_host->host_lock);
 
-	down(&target->srp_host->target_mutex);
+	mutex_lock(&target->srp_host->target_mutex);
 	list_del(&target->list);
-	up(&target->srp_host->target_mutex);
+	mutex_unlock(&target->srp_host->target_mutex);
 
 	scsi_remove_host(target->scsi_host);
 	ib_destroy_cm_id(target->cm_id);
@@ -1254,9 +1254,9 @@ static int srp_add_target(struct srp_hos
 	if (scsi_add_host(target->scsi_host, host->dev->dma_device))
 		return -ENODEV;
 
-	down(&host->target_mutex);
+	mutex_lock(&host->target_mutex);
 	list_add_tail(&target->list, &host->target_list);
-	up(&host->target_mutex);
+	mutex_unlock(&host->target_mutex);
 
 	target->state = SRP_TARGET_LIVE;
 
@@ -1525,7 +1525,7 @@ static struct srp_host *srp_add_port(str
 		return NULL;
 
 	INIT_LIST_HEAD(&host->target_list);
-	init_MUTEX(&host->target_mutex);
+	mutex_init(&host->target_mutex);
 	init_completion(&host->released);
 	host->dev  = device;
 	host->port = port;
@@ -1626,7 +1626,7 @@ static void srp_remove_one(struct ib_dev
 		 * Mark all target ports as removed, so we stop queueing
 		 * commands and don't try to reconnect.
 		 */
-		down(&host->target_mutex);
+		mutex_lock(&host->target_mutex);
 		list_for_each_entry_safe(target, tmp_target,
 					 &host->target_list, list) {
 			spin_lock_irqsave(target->scsi_host->host_lock, flags);
@@ -1634,7 +1634,7 @@ static void srp_remove_one(struct ib_dev
 				target->state = SRP_TARGET_REMOVED;
 			spin_unlock_irqrestore(target->scsi_host->host_lock, flags);
 		}
-		up(&host->target_mutex);
+		mutex_unlock(&host->target_mutex);
 
 		/*
 		 * Wait for any reconnection tasks that may have
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index b564f18..4e7727d 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -37,8 +37,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
@@ -85,7 +84,7 @@ struct srp_host {
 	struct ib_mr	       *mr;
 	struct class_device	class_dev;
 	struct list_head	target_list;
-	struct semaphore        target_mutex;
+	struct mutex            target_mutex;
 	struct completion	released;
 	struct list_head	list;
 };
-- 
1.1.3
