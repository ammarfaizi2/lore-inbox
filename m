Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWJFFhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWJFFhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWJFFf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:35:56 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:18358 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932201AbWJFFfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:35:37 -0400
Subject: [PATCH 3/9] sound/oss/msnd_pinnacle.c: ioremap balanced with
	iounmap
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:08:57 +0530
Message-Id: <1160113137.19143.140.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 msnd_pinnacle.c |   10 ++++++++++
 1 files changed, 10 insertions(+)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/sound/oss/msnd_pinnacle.c linux-2.6.19-rc1/sound/oss/msnd_pinnacle.c
--- linux-2.6.19-rc1-orig/sound/oss/msnd_pinnacle.c	2006-09-21 10:15:52.000000000 +0530
+++ linux-2.6.19-rc1/sound/oss/msnd_pinnacle.c	2006-10-05 17:23:26.000000000 +0530
@@ -1441,6 +1441,8 @@ static int __init attach_multisound(void
 
 static void __exit unload_multisound(void)
 {
+	iounmap(dev.base);
+	dev.base = NULL;
 	release_region(dev.io, dev.numio);
 	free_irq(dev.irq, &dev);
 	unregister_sound_mixer(dev.mixer_minor);
@@ -1884,12 +1886,16 @@ static int __init msnd_init(void)
 	printk(KERN_INFO LOGNAME ": %u byte audio FIFOs (x2)\n", dev.fifosize);
 	if ((err = msnd_fifo_alloc(&dev.DAPF, dev.fifosize)) < 0) {
 		printk(KERN_ERR LOGNAME ": Couldn't allocate write FIFO\n");
+		iounmap(dev.base);
+		dev.base = NULL;
 		return err;
 	}
 
 	if ((err = msnd_fifo_alloc(&dev.DARF, dev.fifosize)) < 0) {
 		printk(KERN_ERR LOGNAME ": Couldn't allocate read FIFO\n");
 		msnd_fifo_free(&dev.DAPF);
+		iounmap(dev.base);
+		dev.base = NULL;
 		return err;
 	}
 
@@ -1897,6 +1903,8 @@ static int __init msnd_init(void)
 		printk(KERN_ERR LOGNAME ": Probe failed\n");
 		msnd_fifo_free(&dev.DAPF);
 		msnd_fifo_free(&dev.DARF);
+		iounmap(dev.base);
+		dev.base = NULL;
 		return err;
 	}
 
@@ -1904,6 +1912,8 @@ static int __init msnd_init(void)
 		printk(KERN_ERR LOGNAME ": Attach failed\n");
 		msnd_fifo_free(&dev.DAPF);
 		msnd_fifo_free(&dev.DARF);
+		iounmap(dev.base);
+		dev.base = NULL;
 		return err;
 	}
 


