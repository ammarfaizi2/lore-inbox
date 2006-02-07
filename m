Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWBGUIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWBGUIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWBGUIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:08:45 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:16307 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965009AbWBGUIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:08:44 -0500
Subject: [SCSI] fix wrong context bugs in SCSI
From: James Bottomley <James.Bottomley@SteelEye.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 14:08:42 -0600
Message-Id: <1139342922.6065.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second half of the execute_process_context() API addition:
an actual user

James

--

[SCSI] fix wrong context bugs in SCSI

There's a bug in releasing scsi_device where the release function
actually frees the block queue.  However, the block queue release
calls flush_work(), which requires process context (the scsi_device
structure may release from irq context).  Update the release function
to invoke via the execute_in_process_context() API.

Also clean up the scsi_target structure releasing via this API.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

Index: BUILD-2.6/drivers/scsi/scsi_scan.c
===================================================================
--- BUILD-2.6.orig/drivers/scsi/scsi_scan.c	2006-02-07 09:23:44.000000000 -0600
+++ BUILD-2.6/drivers/scsi/scsi_scan.c	2006-02-07 11:35:46.000000000 -0600
@@ -385,19 +385,12 @@
 	return found_target;
 }
 
-struct work_queue_wrapper {
-	struct work_struct	work;
-	struct scsi_target	*starget;
-};
-
-static void scsi_target_reap_work(void *data) {
-	struct work_queue_wrapper *wqw = (struct work_queue_wrapper *)data;
-	struct scsi_target *starget = wqw->starget;
+static void scsi_target_reap_usercontext(void *data)
+{
+	struct scsi_target *starget = data;
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	unsigned long flags;
 
-	kfree(wqw);
-
 	spin_lock_irqsave(shost->host_lock, flags);
 
 	if (--starget->reap_ref == 0 && list_empty(&starget->devices)) {
@@ -426,18 +419,7 @@
  */
 void scsi_target_reap(struct scsi_target *starget)
 {
-	struct work_queue_wrapper *wqw = 
-		kzalloc(sizeof(struct work_queue_wrapper), GFP_ATOMIC);
-
-	if (!wqw) {
-		starget_printk(KERN_ERR, starget,
-			       "Failed to allocate memory in scsi_reap_target()\n");
-		return;
-	}
-
-	INIT_WORK(&wqw->work, scsi_target_reap_work, wqw);
-	wqw->starget = starget;
-	schedule_work(&wqw->work);
+	execute_in_process_context(scsi_target_reap_usercontext, starget);
 }
 
 /**
Index: BUILD-2.6/drivers/scsi/scsi_sysfs.c
===================================================================
--- BUILD-2.6.orig/drivers/scsi/scsi_sysfs.c	2006-02-07 09:23:44.000000000 -0600
+++ BUILD-2.6/drivers/scsi/scsi_sysfs.c	2006-02-07 11:35:08.000000000 -0600
@@ -217,8 +217,9 @@
 	put_device(&sdev->sdev_gendev);
 }
 
-static void scsi_device_dev_release(struct device *dev)
+static void scsi_device_dev_release_usercontext(void *data)
 {
+	struct device *dev = data;
 	struct scsi_device *sdev;
 	struct device *parent;
 	struct scsi_target *starget;
@@ -237,6 +238,7 @@
 
 	if (sdev->request_queue) {
 		sdev->request_queue->queuedata = NULL;
+		/* user context needed to free queue */
 		scsi_free_queue(sdev->request_queue);
 		/* temporary expedient, try to catch use of queue lock
 		 * after free of sdev */
@@ -252,6 +254,11 @@
 		put_device(parent);
 }
 
+static void scsi_device_dev_release(struct device *dev)
+{
+	execute_in_process_context(scsi_device_dev_release_usercontext,	dev);
+}
+
 static struct class sdev_class = {
 	.name		= "scsi_device",
 	.release	= scsi_device_cls_release,


