Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUBWVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUBWVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:04:58 -0500
Received: from mail.convergence.de ([212.84.236.4]:42474 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261259AbUBWVEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:04:54 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 2/9] Update saa7146 driver core
In-Reply-To: <10775702813893@convergence.de>
Message-Id: <10775702813454@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:04:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] saa7146: fix timeout bug on AMD64 in saa7146_wait_for_debi_done()
- [DVB] saa7146: release resources for video overlay properly, don't (incorrectly) rely on VIDIOC_OVERLAY(0)
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/common/saa7146_core.c linux-2.6.3.p/drivers/media/common/saa7146_core.c
--- xx-linux-2.6.3/drivers/media/common/saa7146_core.c	2004-02-23 12:34:26.000000000 +0100
+++ linux-2.6.3.p/drivers/media/common/saa7146_core.c	2004-02-23 12:52:31.000000000 +0100
@@ -69,14 +69,14 @@
 /* This DEBI code is based on the saa7146 Stradis driver by Nathan Laredo */
 int saa7146_wait_for_debi_done(struct saa7146_dev *dev)
 {
-	int start;
+	unsigned long start;
 
 	/* wait for registers to be programmed */
 	start = jiffies;
 	while (1) {
                 if (saa7146_read(dev, MC2) & 2)
                         break;
-		if (jiffies-start > HZ/20) {
+		if (time_after(jiffies, start + HZ/20)) {
 			DEB_S(("timed out while waiting for registers getting programmed\n"));
 			return -ETIMEDOUT;
 		}
@@ -88,7 +88,7 @@
 		if (!(saa7146_read(dev, PSR) & SPCI_DEBI_S))
 			break;
 		saa7146_read(dev, MC2);
-		if (jiffies-start > HZ/4) {
+		if (time_after(jiffies, start + HZ/4)) {
 			DEB_S(("timed out while waiting for transfer completion\n"));
 			return -ETIMEDOUT;
 		}
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/common/saa7146_video.c linux-2.6.3.p/drivers/media/common/saa7146_video.c
--- xx-linux-2.6.3/drivers/media/common/saa7146_video.c	2004-02-23 12:34:26.000000000 +0100
+++ linux-2.6.3.p/drivers/media/common/saa7146_video.c	2004-02-02 21:13:12.000000000 +0100
@@ -1413,6 +1419,7 @@
 			spin_lock_irqsave(&dev->slock,flags);
 			saa7146_stop_preview(fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
+			saa7146_res_free(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
 		}
 	}
 	


