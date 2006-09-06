Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWIFNk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWIFNk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWIFNjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:39:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:61685 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750932AbWIFNif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:35 -0400
Message-Id: <20060906133956.068570000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:48 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 18/21] scsi: propagate the swapdev hook into the scsi stack
Content-Disposition: inline; filename=scsi_swapdev.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow scsi devices to receive the swapdev notification.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: James E.J. Bottomley <James.Bottomley@SteelEye.com>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/scsi/sd.c        |   13 +++++++++++++
 include/scsi/scsi_host.h |    7 +++++++
 2 files changed, 20 insertions(+)

Index: linux-2.6/drivers/scsi/sd.c
===================================================================
--- linux-2.6.orig/drivers/scsi/sd.c
+++ linux-2.6/drivers/scsi/sd.c
@@ -892,6 +892,18 @@ static long sd_compat_ioctl(struct file 
 }
 #endif
 
+static int sd_swapdev(struct gendisk *disk, int enable)
+{
+	int error = 0;
+	struct scsi_disk *sdkp = scsi_disk(disk);
+	struct scsi_device *sdp = sdkp->device;
+
+	if (sdp->host->hostt->swapdev)
+		error = sdp->host->hostt->swapdev(sdp, enable);
+
+	return error;
+}
+
 static struct block_device_operations sd_fops = {
 	.owner			= THIS_MODULE,
 	.open			= sd_open,
@@ -903,6 +915,7 @@ static struct block_device_operations sd
 #endif
 	.media_changed		= sd_media_changed,
 	.revalidate_disk	= sd_revalidate_disk,
+	.swapdev		= sd_swapdev,
 };
 
 /**
Index: linux-2.6/include/scsi/scsi_host.h
===================================================================
--- linux-2.6.orig/include/scsi/scsi_host.h
+++ linux-2.6/include/scsi/scsi_host.h
@@ -288,6 +288,13 @@ struct scsi_host_template {
 	int (*suspend)(struct scsi_device *, pm_message_t state);
 
 	/*
+	 * Notify that this device is used for swapping.
+	 *
+	 * Status: OPTIONAL
+	 */
+	int (*swapdev)(struct scsi_device *, int enable);
+
+	/*
 	 * Name of proc directory
 	 */
 	char *proc_name;

--
