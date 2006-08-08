Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWHHTWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWHHTWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHHTWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:22:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:7091 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964982AbWHHTWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:22:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 8 Aug 2006 21:21:05 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/4] video1394: add poll file operation support
To: linux-kernel@vger.kernel.org
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
Message-ID: <tkrat.d621130a6a44b56c@s5r6.in-berlin.de>
References: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Tue, 01 Aug 2006 19:00:31 -0400
From: David Moore <dcm@acm.org>
Subject: [PATCH] video1394: add poll file operation support

This patch adds support for the poll file operation to the video1394
driver.

Signed-off-by: David Moore <dcm@acm.org>
---
Index: linux/drivers/ieee1394/video1394.c
===================================================================
--- linux.orig/drivers/ieee1394/video1394.c	2006-08-02 18:23:28.000000000 +0200
+++ linux/drivers/ieee1394/video1394.c	2006-08-02 18:23:42.000000000 +0200
@@ -1181,7 +1181,8 @@ static int video1394_mmap(struct file *f
 
 	lock_kernel();
 	if (ctx->current_ctx == NULL) {
-		PRINT(KERN_ERR, ctx->ohci->host->id, "Current iso context not set");
+		PRINT(KERN_ERR, ctx->ohci->host->id,
+				"Current iso context not set");
 	} else
 		res = dma_region_mmap(&ctx->current_ctx->dma, file, vma);
 	unlock_kernel();
@@ -1189,6 +1190,40 @@ static int video1394_mmap(struct file *f
 	return res;
 }
 
+static unsigned int video1394_poll(struct file *file, poll_table *pt)
+{
+	struct file_ctx *ctx;
+	unsigned int mask = 0;
+	unsigned long flags;
+	struct dma_iso_ctx *d;
+	int i;
+
+	lock_kernel();
+	ctx = file->private_data;
+	d = ctx->current_ctx;
+	if (d == NULL) {
+		PRINT(KERN_ERR, ctx->ohci->host->id,
+				"Current iso context not set");
+		mask = POLLERR;
+		goto done;
+	}
+
+	poll_wait(file, &d->waitq, pt);
+
+	spin_lock_irqsave(&d->lock, flags);
+	for (i = 0; i < d->num_desc; i++) {
+		if (d->buffer_status[i] == VIDEO1394_BUFFER_READY) {
+			mask |= POLLIN | POLLRDNORM;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&d->lock, flags);
+done:
+	unlock_kernel();
+
+	return mask;
+}
+
 static int video1394_open(struct inode *inode, struct file *file)
 {
 	int i = ieee1394_file_to_instance(file);
@@ -1257,6 +1292,7 @@ static struct file_operations video1394_
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = video1394_compat_ioctl,
 #endif
+	.poll =		video1394_poll,
 	.mmap =		video1394_mmap,
 	.open =		video1394_open,
 	.release =	video1394_release

