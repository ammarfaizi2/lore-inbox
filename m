Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945952AbWGOAig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945952AbWGOAig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945940AbWGOAh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:37:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37641 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945946AbWGOAhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:37:11 -0400
Date: Sat, 15 Jul 2006 02:37:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] saa7134: rename dmasound_{init,exit}
Message-ID: <20060715003710.GO3633@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two different exports with the same name are not a good idea:

$ grep -r EXPORT_SYMBOL\(dmasound_init\) *
drivers/media/video/saa7134/saa7134-core.c:EXPORT_SYMBOL(dmasound_init);
sound/oss/dmasound/dmasound_core.c:EXPORT_SYMBOL(dmasound_init);
$ 

This patch renames the saa7134 dmasound_{init,exit} to 
saa7134_dmasound_{init,exit}.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Jul 2006

 drivers/media/video/saa7134/saa7134-alsa.c |   10 +++++-----
 drivers/media/video/saa7134/saa7134-core.c |   16 ++++++++--------
 drivers/media/video/saa7134/saa7134-oss.c  |   10 +++++-----
 drivers/media/video/saa7134/saa7134.h      |    4 ++--
 4 files changed, 20 insertions(+), 20 deletions(-)

--- linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134.h.old	2006-07-11 14:31:50.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134.h	2006-07-11 14:32:35.000000000 +0200
@@ -586,8 +586,8 @@
 
 int saa7134_set_dmabits(struct saa7134_dev *dev);
 
-extern int (*dmasound_init)(struct saa7134_dev *dev);
-extern int (*dmasound_exit)(struct saa7134_dev *dev);
+extern int (*saa7134_dmasound_init)(struct saa7134_dev *dev);
+extern int (*saa7134_dmasound_exit)(struct saa7134_dev *dev);
 
 
 /* ----------------------------------------------------------- */
--- linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134-core.c.old	2006-07-11 14:32:39.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134-core.c	2006-07-11 14:32:50.000000000 +0200
@@ -95,8 +95,8 @@
 static LIST_HEAD(mops_list);
 static unsigned int saa7134_devcount;
 
-int (*dmasound_init)(struct saa7134_dev *dev);
-int (*dmasound_exit)(struct saa7134_dev *dev);
+int (*saa7134_dmasound_init)(struct saa7134_dev *dev);
+int (*saa7134_dmasound_exit)(struct saa7134_dev *dev);
 
 #define dprintk(fmt, arg...)	if (core_debug) \
 	printk(KERN_DEBUG "%s/core: " fmt, dev->name , ## arg)
@@ -1008,8 +1008,8 @@
 	/* check for signal */
 	saa7134_irq_video_intl(dev);
 
-	if (dmasound_init && !dev->dmasound.priv_data) {
-		dmasound_init(dev);
+	if (saa7134_dmasound_init && !dev->dmasound.priv_data) {
+		saa7134_dmasound_init(dev);
 	}
 
 	return 0;
@@ -1036,8 +1036,8 @@
 	struct saa7134_mpeg_ops *mops;
 
 	/* Release DMA sound modules if present */
-	if (dmasound_exit && dev->dmasound.priv_data) {
-		dmasound_exit(dev);
+	if (saa7134_dmasound_exit && dev->dmasound.priv_data) {
+		saa7134_dmasound_exit(dev);
 	}
 
 	/* debugging ... */
@@ -1169,8 +1169,8 @@
 
 /* ----------------- for the DMA sound modules --------------- */
 
-EXPORT_SYMBOL(dmasound_init);
-EXPORT_SYMBOL(dmasound_exit);
+EXPORT_SYMBOL(saa7134_dmasound_init);
+EXPORT_SYMBOL(saa7134_dmasound_exit);
 EXPORT_SYMBOL(saa7134_pgtable_free);
 EXPORT_SYMBOL(saa7134_pgtable_build);
 EXPORT_SYMBOL(saa7134_pgtable_alloc);
--- linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134-alsa.c.old	2006-07-11 14:33:01.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134-alsa.c	2006-07-11 14:33:11.000000000 +0200
@@ -997,9 +997,9 @@
 	struct saa7134_dev *dev = NULL;
 	struct list_head *list;
 
-	if (!dmasound_init && !dmasound_exit) {
-		dmasound_init = alsa_device_init;
-		dmasound_exit = alsa_device_exit;
+	if (!saa7134_dmasound_init && !saa7134_dmasound_exit) {
+		saa7134_dmasound_init = alsa_device_init;
+		saa7134_dmasound_exit = alsa_device_exit;
 	} else {
 		printk(KERN_WARNING "saa7134 ALSA: can't load, DMA sound handler already assigned (probably to OSS)\n");
 		return -EBUSY;
@@ -1036,8 +1036,8 @@
 		snd_card_free(snd_saa7134_cards[idx]);
 	}
 
-	dmasound_init = NULL;
-	dmasound_exit = NULL;
+	saa7134_dmasound_init = NULL;
+	saa7134_dmasound_exit = NULL;
 	printk(KERN_INFO "saa7134 ALSA driver for DMA sound unloaded\n");
 
 	return;
--- linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134-oss.c.old	2006-07-11 14:33:23.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/media/video/saa7134/saa7134-oss.c	2006-07-11 14:33:33.000000000 +0200
@@ -993,9 +993,9 @@
 	struct saa7134_dev *dev = NULL;
 	struct list_head *list;
 
-	if (!dmasound_init && !dmasound_exit) {
-		dmasound_init = oss_device_init;
-		dmasound_exit = oss_device_exit;
+	if (!saa7134_dmasound_init && !saa7134_dmasound_exit) {
+		saa7134_dmasound_init = oss_device_init;
+		saa7134_dmasound_exit = oss_device_exit;
 	} else {
 		printk(KERN_WARNING "saa7134 OSS: can't load, DMA sound handler already assigned (probably to ALSA)\n");
 		return -EBUSY;
@@ -1037,8 +1037,8 @@
 
 	}
 
-	dmasound_init = NULL;
-	dmasound_exit = NULL;
+	saa7134_dmasound_init = NULL;
+	saa7134_dmasound_exit = NULL;
 
 	printk(KERN_INFO "saa7134 OSS driver for DMA sound unloaded\n");
 

