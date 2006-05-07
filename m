Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWEGMCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWEGMCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEGMCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:02:07 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:51636
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751045AbWEGMCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:02:06 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 13:36:06 2006
Message-Id: <20060507113606.265064000@pc1>
References: <20060507113513.418451000@pc1>
Date: Sun, 07 May 2006 13:35:19 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, mbuesch@freenet.de,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: [patch 6/6] New Generic HW RNG
Content-Disposition: inline; filename=bcm43xx-hw-random.patch
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add bcm43xx H/W RNG support.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/net/wireless/bcm43xx/Kconfig
===================================================================
--- hwrng.orig/drivers/net/wireless/bcm43xx/Kconfig	2006-05-07 01:53:13.000000000 +0200
+++ hwrng/drivers/net/wireless/bcm43xx/Kconfig	2006-05-07 01:58:41.000000000 +0200
@@ -2,6 +2,7 @@
 	tristate "Broadcom BCM43xx wireless support"
 	depends on PCI && IEEE80211 && IEEE80211_SOFTMAC && NET_RADIO && EXPERIMENTAL
 	select FW_LOADER
+	select HW_RANDOM
 	---help---
 	  This is an experimental driver for the Broadcom 43xx wireless chip,
 	  found in the Apple Airport Extreme and various other devices.
Index: hwrng/drivers/net/wireless/bcm43xx/bcm43xx.h
===================================================================
--- hwrng.orig/drivers/net/wireless/bcm43xx/bcm43xx.h	2006-05-07 01:53:13.000000000 +0200
+++ hwrng/drivers/net/wireless/bcm43xx/bcm43xx.h	2006-05-07 01:58:41.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef BCM43xx_H_
 #define BCM43xx_H_
 
+#include <linux/hw_random.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -82,6 +83,7 @@
 #define BCM43xx_MMIO_TSF_1		0x634 /* core rev < 3 only */
 #define BCM43xx_MMIO_TSF_2		0x636 /* core rev < 3 only */
 #define BCM43xx_MMIO_TSF_3		0x638 /* core rev < 3 only */
+#define BCM43xx_MMIO_RNG		0x65A
 #define BCM43xx_MMIO_POWERUP_DELAY	0x6A8
 
 /* SPROM offsets. */
@@ -741,6 +743,9 @@
 	const struct firmware *initvals0;
 	const struct firmware *initvals1;
 
+	/* Random Number Generator. */
+	struct hwrng rng;
+
 	/* Debugging stuff follows. */
 #ifdef CONFIG_BCM43XX_DEBUG
 	struct bcm43xx_dfsentry *dfsentry;
Index: hwrng/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- hwrng.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-05-07 01:53:13.000000000 +0200
+++ hwrng/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-05-07 01:58:41.000000000 +0200
@@ -3144,6 +3144,37 @@
 	bcm43xx_clear_keys(bcm);
 }
 
+static int bcm43xx_rng_read(struct hwrng *rng, u32 *data)
+{
+	struct bcm43xx_private *bcm = (struct bcm43xx_private *)rng->priv;
+	unsigned long flags;
+
+	bcm43xx_lock(bcm, flags);
+	*data = bcm43xx_read16(bcm, BCM43xx_MMIO_RNG);
+	bcm43xx_unlock(bcm, flags);
+
+	return (sizeof(u16));
+}
+
+static void bcm43xx_rng_exit(struct bcm43xx_private *bcm)
+{
+	hwrng_unregister(&bcm->rng);
+}
+
+static int bcm43xx_rng_init(struct bcm43xx_private *bcm)
+{
+	int err;
+
+	bcm->rng.name = KBUILD_MODNAME;
+	bcm->rng.data_read = bcm43xx_rng_read;
+	bcm->rng.priv = (unsigned long)bcm;
+	err = hwrng_register(&bcm->rng);
+	if (err)
+		printk(KERN_ERR PFX "RNG init failed\n");
+
+	return err;
+}
+
 /* This is the opposite of bcm43xx_init_board() */
 static void bcm43xx_free_board(struct bcm43xx_private *bcm)
 {
@@ -3159,6 +3190,7 @@
 	bcm->shutting_down = 1;
 	bcm43xx_unlock(bcm, flags);
 
+	bcm43xx_rng_exit(bcm);
 	for (i = 0; i < BCM43xx_MAX_80211_CORES; i++) {
 		if (!bcm->core_80211[i].available)
 			continue;
@@ -3240,6 +3272,9 @@
 		bcm43xx_switch_core(bcm, &bcm->core_80211[0]);
 		bcm43xx_mac_enable(bcm);
 	}
+	err = bcm43xx_rng_init(bcm);
+	if (err)
+		goto err_80211_unwind;
 	bcm43xx_macfilter_clear(bcm, BCM43xx_MACFILTER_ASSOC);
 	bcm43xx_macfilter_set(bcm, BCM43xx_MACFILTER_SELF, (u8 *)(bcm->net_dev->dev_addr));
 	dprintk(KERN_INFO PFX "80211 cores initialized\n");

--

