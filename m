Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSL3UUE>; Mon, 30 Dec 2002 15:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSL3UUD>; Mon, 30 Dec 2002 15:20:03 -0500
Received: from ra.abo.fi ([130.232.213.1]:44704 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S265830AbSL3UUC>;
	Mon, 30 Dec 2002 15:20:02 -0500
Date: Mon, 30 Dec 2002 22:28:24 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.5] opti92x-ad1848 one check_region fixup
In-Reply-To: <Pine.LNX.4.44.0212302140130.30703-100000@tuxedo.abo.fi>
Message-ID: <Pine.LNX.4.44.0212302222530.30703-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initializes the variables (the chip->xxx stuff) before calling 
anything else. snd_legacy_find_free_ioport() uses request_region now, 
so remember to release regions in the private freeing routine 
snd_card_opti9xx_free().

Note how I changed it to return SNDRV_AUTO_PORT instead of -1, I'm 
not sure if they are guaranteed to be the same, so I changed it 
instead explicitely.

No other snd_legacy_find_free_ioport users in this file or elsewhere 
in the kernel.

#
# create_patch: opti_1-2002-12-30-A.patch
# Date: Mon Dec 30 22:21:50 EET 2002
#
diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude opti_original-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c opti_1-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c
--- opti_original-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c	Mon Dec 30 20:00:42 2002
+++ opti_1-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c	Mon Dec 30 20:19:47 2002
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
@@ -1911,6 +1911,10 @@
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
@@ -1956,6 +1960,16 @@
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
@@ -1994,28 +2008,18 @@
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

