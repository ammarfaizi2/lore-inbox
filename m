Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272607AbTHKOAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272653AbTHKNnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:09 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34443 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272607AbTHKNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:58 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [PATCH] cpu_relax whilst in busy-wait loops.
Message-Id: <E19mCuO-0003dX-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/drm/gamma_dma.c linux-2.5/drivers/char/drm/gamma_dma.c
--- bk-linus/drivers/char/drm/gamma_dma.c	2003-05-31 15:58:40.000000000 +0100
+++ linux-2.5/drivers/char/drm/gamma_dma.c	2003-05-29 14:07:46.000000000 +0100
@@ -44,9 +44,14 @@ static inline void gamma_dma_dispatch(dr
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
 	mb();
-	while ( GAMMA_READ(GAMMA_INFIFOSPACE) < 2);
+	while ( GAMMA_READ(GAMMA_INFIFOSPACE) < 2)
+		cpu_relax();
+
 	GAMMA_WRITE(GAMMA_DMAADDRESS, address);
-	while (GAMMA_READ(GAMMA_GCOMMANDSTATUS) != 4);
+
+	while (GAMMA_READ(GAMMA_GCOMMANDSTATUS) != 4)
+		cpu_relax();
+
 	GAMMA_WRITE(GAMMA_DMACOUNT, length / 4);
 }
 
@@ -54,16 +59,18 @@ void gamma_dma_quiescent_single(drm_devi
 {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
-	while (GAMMA_READ(GAMMA_DMACOUNT));
+	while (GAMMA_READ(GAMMA_DMACOUNT))
+		cpu_relax();
 
-	while (GAMMA_READ(GAMMA_INFIFOSPACE) < 2);
+	while (GAMMA_READ(GAMMA_INFIFOSPACE) < 2)
+		cpu_relax();
 
 	GAMMA_WRITE(GAMMA_FILTERMODE, 1 << 10);
 	GAMMA_WRITE(GAMMA_SYNC, 0);
 
 	do {
 		while (!GAMMA_READ(GAMMA_OUTFIFOWORDS))
-			;
+			cpu_relax();
 	} while (GAMMA_READ(GAMMA_OUTPUTFIFO) != GAMMA_SYNC_TAG);
 }
 
@@ -71,9 +78,11 @@ void gamma_dma_quiescent_dual(drm_device
 {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
-	while (GAMMA_READ(GAMMA_DMACOUNT));
+	while (GAMMA_READ(GAMMA_DMACOUNT))
+		cpu_relax();
 
-	while (GAMMA_READ(GAMMA_INFIFOSPACE) < 3);
+	while (GAMMA_READ(GAMMA_INFIFOSPACE) < 3)
+		cpu_relax();
 
 	GAMMA_WRITE(GAMMA_BROADCASTMASK, 3);
 	GAMMA_WRITE(GAMMA_FILTERMODE, 1 << 10);
@@ -81,12 +90,14 @@ void gamma_dma_quiescent_dual(drm_device
 
 	/* Read from first MX */
 	do {
-		while (!GAMMA_READ(GAMMA_OUTFIFOWORDS));
+		while (!GAMMA_READ(GAMMA_OUTFIFOWORDS))
+			cpu_relax();
 	} while (GAMMA_READ(GAMMA_OUTPUTFIFO) != GAMMA_SYNC_TAG);
 
 	/* Read from second MX */
 	do {
-		while (!GAMMA_READ(GAMMA_OUTFIFOWORDS + 0x10000));
+		while (!GAMMA_READ(GAMMA_OUTFIFOWORDS + 0x10000))
+			cpu_relax();
 	} while (GAMMA_READ(GAMMA_OUTPUTFIFO + 0x10000) != GAMMA_SYNC_TAG);
 }
 
@@ -94,14 +105,15 @@ void gamma_dma_ready(drm_device_t *dev)
 {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
-	while (GAMMA_READ(GAMMA_DMACOUNT));
+	while (GAMMA_READ(GAMMA_DMACOUNT))
+		cpu_relax();
 }
 
 static inline int gamma_dma_is_ready(drm_device_t *dev)
 {
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
-	return(!GAMMA_READ(GAMMA_DMACOUNT));
+	return (!GAMMA_READ(GAMMA_DMACOUNT));
 }
 
 irqreturn_t gamma_dma_service(int irq, void *device, struct pt_regs *regs)
@@ -113,7 +125,9 @@ irqreturn_t gamma_dma_service(int irq, v
 
 	atomic_inc(&dev->counts[6]); /* _DRM_STAT_IRQ */
 
-	while (GAMMA_READ(GAMMA_INFIFOSPACE) < 3);
+	while (GAMMA_READ(GAMMA_INFIFOSPACE) < 3)
+		cpu_relax();
+
 	GAMMA_WRITE(GAMMA_GDELAYTIMER, 0xc350/2); /* 0x05S */
 	GAMMA_WRITE(GAMMA_GCOMMANDINTFLAGS, 8);
 	GAMMA_WRITE(GAMMA_GINTFLAGS, 0x2001);
@@ -824,7 +838,8 @@ void DRM(driver_irq_preinstall)( drm_dev
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
 
-	while(GAMMA_READ(GAMMA_INFIFOSPACE) < 2);
+	while(GAMMA_READ(GAMMA_INFIFOSPACE) < 2)
+		cpu_relax();
 
 	GAMMA_WRITE( GAMMA_GCOMMANDMODE,	0x00000004 );
 	GAMMA_WRITE( GAMMA_GDMACONTROL,		0x00000000 );
@@ -834,7 +849,8 @@ void DRM(driver_irq_postinstall)( drm_de
 	drm_gamma_private_t *dev_priv =
 				(drm_gamma_private_t *)dev->dev_private;
 
-	while(GAMMA_READ(GAMMA_INFIFOSPACE) < 3);
+	while(GAMMA_READ(GAMMA_INFIFOSPACE) < 3)
+		cpu_relax();
 
 	GAMMA_WRITE( GAMMA_GINTENABLE,		0x00002001 );
 	GAMMA_WRITE( GAMMA_COMMANDINTENABLE,	0x00000008 );
@@ -847,7 +863,8 @@ void DRM(driver_irq_uninstall)( drm_devi
 	if (!dev_priv)
 		return;
 
-	while(GAMMA_READ(GAMMA_INFIFOSPACE) < 3);
+	while(GAMMA_READ(GAMMA_INFIFOSPACE) < 3)
+		cpu_relax();
 
 	GAMMA_WRITE( GAMMA_GDELAYTIMER,		0x00000000 );
 	GAMMA_WRITE( GAMMA_COMMANDINTENABLE,	0x00000000 );
