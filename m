Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264195AbTDJVuV (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTDJVuV (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:50:21 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:50437 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id S264195AbTDJVuR convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:50:17 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] ALSA: some missing pnp_unregister_card_driver
Date: Fri, 11 Apr 2003 00:01:43 +0200
User-Agent: KMail/1.4.3
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304110001.43136.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jaroslav

this patch fixes some missing pnp_unregister_card_driver. w/o it a second modprobe
causes a crash in kobject_add when the first modprobe failed...
(tested only with opl3sa2...it didn't see my chip, modprobe opl3sa2 (the working oss
one) -> boom, same for 2x modprobe snd-opl3sa2)

against 2.5.67-bk.

rgds
-daniel

===== sound/isa/als100.c 1.13 vs edited =====
--- 1.13/sound/isa/als100.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/isa/als100.c	Thu Apr 10 22:43:27 2003
@@ -329,7 +329,10 @@
 	cards += pnp_register_card_driver(&als100_pnpc_driver);
 #ifdef MODULE
 	if (!cards)
+	{
+		pnp_unregister_card_driver(&als100_pnpc_driver);
 		snd_printk(KERN_ERR "no ALS100 based soundcards found\n");
+	}
 #endif
 	return cards ? 0 : -ENODEV;
 }
===== sound/isa/azt2320.c 1.10 vs edited =====
--- 1.10/sound/isa/azt2320.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/isa/azt2320.c	Thu Apr 10 22:49:35 2003
@@ -366,7 +366,10 @@
 	cards += pnp_register_card_driver(&azt2320_pnpc_driver);
 #ifdef MODULE
 	if (!cards)
+	{
+		pnp_unregister_card_driver(&azt2320_pnpc_driver);
 		snd_printk(KERN_ERR "no AZT2320 based soundcards found\n");
+	}
 #endif
 	return cards ? 0 : -ENODEV;
 }
===== sound/isa/cmi8330.c 1.14 vs edited =====
--- 1.14/sound/isa/cmi8330.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/isa/cmi8330.c	Thu Apr 10 22:50:17 2003
@@ -613,6 +613,9 @@
 #endif
 
 	if (!cards) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&cmi8330_pnpc_driver);
+#endif
 #ifdef MODULE
 		snd_printk(KERN_ERR "CMI8330 not found or device busy\n");
 #endif
===== sound/isa/es18xx.c 1.16 vs edited =====
--- 1.16/sound/isa/es18xx.c	Thu Apr 10 15:38:19 2003
+++ edited/sound/isa/es18xx.c	Thu Apr 10 22:51:33 2003
@@ -2243,6 +2243,9 @@
 	cards += pnp_register_card_driver(&es18xx_pnpc_driver);
 #endif
 	if(!cards) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&es18xx_pnpc_driver);
+#endif
 #ifdef MODULE
 		snd_printk(KERN_ERR "ESS AudioDrive ES18xx soundcard not found or device busy\n");
 #endif
===== sound/isa/opl3sa2.c 1.16 vs edited =====
--- 1.16/sound/isa/opl3sa2.c	Thu Apr 10 12:28:12 2003
+++ edited/sound/isa/opl3sa2.c	Thu Apr 10 22:26:51 2003
@@ -894,6 +894,9 @@
 #ifdef MODULE
 		snd_printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&opl3sa2_pnpc_driver);
+#endif
 		return -ENODEV;
 	}
 	return 0;
===== sound/isa/ad1816a/ad1816a.c 1.8 vs edited =====
--- 1.8/sound/isa/ad1816a/ad1816a.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/isa/ad1816a/ad1816a.c	Thu Apr 10 22:45:11 2003
@@ -308,7 +308,10 @@
 	cards += pnp_register_card_driver(&ad1816a_pnpc_driver);
 #ifdef MODULE
 	if (!cards)
+	{
+		pnp_unregister_card_driver(&ad1816a_pnpc_driver);
 		printk(KERN_ERR "no AD1816A based soundcards found.\n");
+	}
 #endif	/* MODULE */
 	return cards ? 0 : -ENODEV;
 }
===== sound/isa/cs423x/cs4236.c 1.14 vs edited =====
--- 1.14/sound/isa/cs423x/cs4236.c	Thu Apr 10 12:28:11 2003
+++ edited/sound/isa/cs423x/cs4236.c	Thu Apr 10 22:51:00 2003
@@ -590,6 +590,9 @@
 	cards += pnp_register_card_driver(&cs423x_pnpc_driver);
 #endif
 	if (!cards) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&cs423x_pnpc_driver);
+#endif
 #ifdef MODULE
 		printk(KERN_ERR IDENT " soundcard not found or device busy\n");
 #endif
===== sound/isa/opti9xx/opti92x-ad1848.c 1.13 vs edited =====
--- 1.13/sound/isa/opti9xx/opti92x-ad1848.c	Thu Apr 10 12:28:12 2003
+++ edited/sound/isa/opti9xx/opti92x-ad1848.c	Thu Apr 10 22:55:45 2003
@@ -2202,6 +2202,9 @@
 
 	cards = pnp_register_card_driver(&opti9xx_pnpc_driver);
 	if (cards == 0 && (error = snd_card_opti9xx_probe(NULL, NULL)) < 0) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&opti9xx_pnpc_driver);
+#endif
 #ifdef MODULE
 #ifdef OPTi93X
 		printk(KERN_ERR "no OPTi 82C93x soundcard found\n");
===== sound/isa/sb/es968.c 1.12 vs edited =====
--- 1.12/sound/isa/sb/es968.c	Thu Apr 10 12:28:12 2003
+++ edited/sound/isa/sb/es968.c	Thu Apr 10 22:57:36 2003
@@ -224,10 +224,13 @@
 static int __init alsa_card_es968_init(void)
 {
 	int res = pnp_register_card_driver(&es968_pnpc_driver);
-#ifdef MODULE
 	if (res == 0)
+	{
+		pnp_unregister_card_driver(&es968_pnpc_driver);
+#ifdef MODULE
 		snd_printk(KERN_ERR "no ES968 based soundcards found\n");
 #endif
+	}
 	return res < 0 ? res : 0;
 }
 
===== sound/isa/sb/sb16.c 1.15 vs edited =====
--- 1.15/sound/isa/sb/sb16.c	Thu Apr 10 12:28:12 2003
+++ edited/sound/isa/sb/sb16.c	Thu Apr 10 22:58:19 2003
@@ -625,6 +625,9 @@
 #endif
 
 	if (!cards) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&sb16_pnpc_driver);
+#endif
 #ifdef MODULE
 		snd_printk(KERN_ERR "Sound Blaster 16 soundcard not found or device busy\n");
 #ifdef SNDRV_SBAWE_EMU8000
===== sound/isa/wavefront/wavefront.c 1.11 vs edited =====
--- 1.11/sound/isa/wavefront/wavefront.c	Thu Apr 10 12:28:12 2003
+++ edited/sound/isa/wavefront/wavefront.c	Thu Apr 10 22:59:20 2003
@@ -709,6 +709,9 @@
 	cards += pnp_register_card_driver(&wavefront_pnpc_driver);
 #endif
 	if (!cards) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&wavefront_pnpc_driver);
+#endif
 #ifdef MODULE
 		printk (KERN_ERR "No WaveFront cards found or devices busy\n");
 #endif
@@ -721,7 +724,9 @@
 {
 	int idx;
 
+#ifdef CONFIG_PNP
 	pnp_unregister_card_driver(&wavefront_pnpc_driver);
+#endif
 	for (idx = 0; idx < SNDRV_CARDS; idx++)
 		snd_card_free(snd_wavefront_legacy[idx]);
 }





