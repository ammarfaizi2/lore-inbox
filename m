Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263825AbTCUSzE>; Fri, 21 Mar 2003 13:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263810AbTCUSy0>; Fri, 21 Mar 2003 13:54:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29316
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263809AbTCUSwK>; Fri, 21 Mar 2003 13:52:10 -0500
Date: Fri, 21 Mar 2003 20:07:26 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212007.h2LK7Q1q026254@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix up opti92x-ad1848
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/isa/opti9xx/opti92x-ad1848.c linux-2.5.65-ac2/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-2.5.65/sound/isa/opti9xx/opti92x-ad1848.c	2003-02-10 18:38:00.000000000 +0000
+++ linux-2.5.65-ac2/sound/isa/opti9xx/opti92x-ad1848.c	2003-03-06 23:59:15.000000000 +0000
@@ -326,11 +326,11 @@
 static long snd_legacy_find_free_ioport(long *port_table, long size)
 {
 	while (*port_table != -1) {
-		if (!check_region(*port_table, size))
+		if (request_region(*port_table, size, "opti92x-ad1848"))
 			return *port_table;
 		port_table++;
 	}
-	return -1;
+	return SNDRV_AUTO_PORT;
 }
 
 static int __init snd_opti9xx_init(opti9xx_t *chip, unsigned short hardware)
@@ -1914,6 +1914,10 @@
 #ifdef __ISAPNP__
 		snd_card_opti9xx_deactivate(chip);
 #endif	/* __ISAPNP__ */
+		if (chip->wss_base != SNDRV_AUTO_PORT)
+			release_region(chip->wss_base, 4);
+		if (chip->mpu_port != SNDRV_AUTO_PORT)
+			release_region(chip->mpu_port, 2);
 		if (chip->res_mc_base) {
 			release_resource(chip->res_mc_base);
 			kfree_nocheck(chip->res_mc_base);
@@ -1959,6 +1963,16 @@
 	card->private_free = snd_card_opti9xx_free;
 	chip = (opti9xx_t *)card->private_data;
 
+	chip->wss_base = port;
+	chip->fm_port = fm_port;
+	chip->mpu_port = mpu_port;
+	chip->irq = irq;
+	chip->mpu_irq = mpu_irq;
+	chip->dma1 = dma1;
+#if defined(CS4231) || defined(OPTi93X)
+	chip->dma2 = dma2;
+#endif
+
 #ifdef __ISAPNP__
 	if (isapnp && (hw = snd_card_opti9xx_isapnp(chip)) > 0) {
 		switch (hw) {
@@ -1997,28 +2011,18 @@
 		return -ENOMEM;
 	}
 
-	chip->wss_base = port;
-	chip->fm_port = fm_port;
-	chip->mpu_port = mpu_port;
-	chip->irq = irq;
-	chip->mpu_irq = mpu_irq;
-	chip->dma1 = dma1;
-#if defined(CS4231) || defined(OPTi93X)
-	chip->dma2 = dma2;
-#endif
-
 #ifdef __ISAPNP__
 	if (!isapnp) {
 #endif
 	if (chip->wss_base == SNDRV_AUTO_PORT) {
-		if ((chip->wss_base = snd_legacy_find_free_ioport(possible_ports, 4)) < 0) {
+		if ((chip->wss_base = snd_legacy_find_free_ioport(possible_ports, 4)) == SNDRV_AUTO_PORT) {
 			snd_card_free(card);
 			snd_printk("unable to find a free WSS port\n");
 			return -EBUSY;
 		}
 	}
 	if (chip->mpu_port == SNDRV_AUTO_PORT) {
-		if ((chip->mpu_port = snd_legacy_find_free_ioport(possible_mpu_ports, 2)) < 0) {
+		if ((chip->mpu_port = snd_legacy_find_free_ioport(possible_mpu_ports, 2)) == SNDRV_AUTO_PORT) {
 			snd_card_free(card);
 			snd_printk("unable to find a free MPU401 port\n");
 			return -EBUSY;
