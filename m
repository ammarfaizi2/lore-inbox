Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWJAMm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWJAMm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWJAMmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:42:49 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9871 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932133AbWJAMmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:42:38 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Use own work queue
Date: Sun, 01 Oct 2006 14:42:40 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC layer uses the standard work queue for doing card detection. As
this queue is shared with other crucial subsystems, the effects of a long
(and perhaps buggy) detection can cause the system to be unusable. E.g. the
keyboard stops working while the detection routine is running.

The solution is to add a specific mmc work queue to run the detection code
in. This is similar to how other subsystems handle detection (a full
kernel thread is the most common theme).

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc.c       |    6 +++---
 drivers/mmc/mmc.h       |    4 ++++
 drivers/mmc/mmc_sysfs.c |   35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 5b9caa7..ee8863c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1166,9 +1166,9 @@ static void mmc_setup(struct mmc_host *h
 void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 {
 	if (delay)
-		schedule_delayed_work(&host->detect, delay);
+		mmc_schedule_delayed_work(&host->detect, delay);
 	else
-		schedule_work(&host->detect);
+		mmc_schedule_work(&host->detect);
 }
 
 EXPORT_SYMBOL(mmc_detect_change);
@@ -1311,7 +1311,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
-	flush_scheduled_work();
+	mmc_flush_scheduled_work();
 	mmc_free_host_sysfs(host);
 }
 
diff --git a/drivers/mmc/mmc.h b/drivers/mmc/mmc.h
index 97bae00..cd5e0ab 100644
--- a/drivers/mmc/mmc.h
+++ b/drivers/mmc/mmc.h
@@ -18,4 +18,8 @@ struct mmc_host *mmc_alloc_host_sysfs(in
 int mmc_add_host_sysfs(struct mmc_host *host);
 void mmc_remove_host_sysfs(struct mmc_host *host);
 void mmc_free_host_sysfs(struct mmc_host *host);
+
+int mmc_schedule_work(struct work_struct *work);
+int mmc_schedule_delayed_work(struct work_struct *work, unsigned long delay);
+void mmc_flush_scheduled_work(void);
 #endif
diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index a2a35fd..10cc973 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -13,6 +13,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/workqueue.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -317,10 +318,41 @@ void mmc_free_host_sysfs(struct mmc_host
 	class_device_put(&host->class_dev);
 }
 
+static struct workqueue_struct *workqueue;
+
+/*
+ * Internal function. Schedule work in the MMC work queue.
+ */
+int mmc_schedule_work(struct work_struct *work)
+{
+	return queue_work(workqueue, work);
+}
+
+/*
+ * Internal function. Schedule delayed work in the MMC work queue.
+ */
+int mmc_schedule_delayed_work(struct work_struct *work, unsigned long delay)
+{
+	return queue_delayed_work(workqueue, work, delay);
+}
+
+/*
+ * Internal function. Flush all scheduled work from the MMC work queue.
+ */
+void mmc_flush_scheduled_work(void)
+{
+	flush_workqueue(workqueue);
+}
 
 static int __init mmc_init(void)
 {
-	int ret = bus_register(&mmc_bus_type);
+	int ret;
+
+	workqueue = create_singlethread_workqueue("kmmcd");
+	if (!workqueue)
+		return -ENOMEM;
+
+	ret = bus_register(&mmc_bus_type);
 	if (ret == 0) {
 		ret = class_register(&mmc_host_class);
 		if (ret)
@@ -333,6 +365,7 @@ static void __exit mmc_exit(void)
 {
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
+	destroy_workqueue(workqueue);
 }
 
 module_init(mmc_init);

