Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbVLOE6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVLOE6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVLOE6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:58:43 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:37677 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161053AbVLOE6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:58:42 -0500
Date: Thu, 15 Dec 2005 13:58:38 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] fix scsi host_no allocation
Message-ID: <20051215045838.GA11403@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch prevents potential host_no allocation race and
recycle unused host numbers by using idr.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-rc/drivers/scsi/hosts.c.orig	2005-12-14 15:22:11.000000000 +0900
+++ 2.6-rc/drivers/scsi/hosts.c	2005-12-14 16:36:15.000000000 +0900
@@ -31,6 +31,7 @@
 #include <linux/completion.h>
 #include <linux/transport_class.h>
 #include <linux/platform_device.h>
+#include <linux/idr.h>
 
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
@@ -39,9 +40,9 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
-
-static int scsi_host_next_hn;		/* host_no for next new host */
-
+#define MAX_HOST_NO	0xffff
+static DEFINE_IDR(host_no_idr);
+static DEFINE_SPINLOCK(host_no_lock);
 
 static void scsi_host_cls_release(struct class_device *class_dev)
 {
@@ -259,6 +260,10 @@ static void scsi_host_dev_release(struct
 	struct Scsi_Host *shost = dev_to_shost(dev);
 	struct device *parent = dev->parent;
 
+	spin_lock(&host_no_lock);
+	idr_remove(&host_no_idr, shost->host_no);
+	spin_unlock(&host_no_lock);
+
 	if (shost->ehandler)
 		kthread_stop(shost->ehandler);
 	if (shost->work_q)
@@ -290,6 +295,8 @@ struct Scsi_Host *scsi_host_alloc(struct
 	struct Scsi_Host *shost;
 	gfp_t gfp_mask = GFP_KERNEL;
 	int rval;
+	int index;
+	int error;
 
 	if (sht->unchecked_isa_dma && privsize)
 		gfp_mask |= __GFP_DMA;
@@ -322,7 +329,18 @@ struct Scsi_Host *scsi_host_alloc(struct
 
 	init_MUTEX(&shost->scan_mutex);
 
-	shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */
+host_no_retry:
+	if (!idr_pre_get(&host_no_idr, GFP_KERNEL))
+		goto fail_kfree;
+	spin_lock(&host_no_lock);
+	error = idr_get_new(&host_no_idr, NULL, &index);
+	spin_unlock(&host_no_lock);
+	if (error == -EAGAIN)
+		goto host_no_retry;
+	if ((index >= MAX_HOST_NO) || error)
+		goto fail_kfree;
+
+	shost->host_no = index;
 	shost->dma_channel = 0xff;
 
 	/* These three are default values which can be overridden */
