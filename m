Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUCOT3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUCOT2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:28:14 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:12252 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262726AbUCOT1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:25 -0500
Date: Mon, 15 Mar 2004 19:27:06 GMT
Message-Id: <200403151927.i2FJR6hc015694@delerium.codemonkey.org.uk>
From: davej@redhat.com
To: linux-kernel@vger.kernel.org
Subject: [ALSA][3/6] Fix lots of oopses in card probing routines.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a *really* silly one.  The various probing routines in these
drivers can return -ENODEV, -ENOMEM etc.. so when we do something like

cards += probe_routine()

In some situations we can end up with -13 sound cards, and other
such nonsense. Result : lots of fun oopses.

These are all the drivers I picked up with a simple grep, there may
be more, but hopefully I got them all..

		Dave


--- linux-2.6.4/sound/isa/gus/gusextreme.c~	2004-03-15 16:59:22.000000000 +0000
+++ linux-2.6.4/sound/isa/gus/gusextreme.c	2004-03-15 17:02:16.000000000 +0000
@@ -352,7 +352,7 @@
 static int __init alsa_card_gusextreme_init(void)
 {
 	static unsigned long possible_ports[] = {0x220, 0x240, 0x260, -1};
-	int dev, cards;
+	int dev, cards, i;
 
 	for (dev = cards = 0; dev < SNDRV_CARDS && enable[dev] > 0; dev++) {
 		if (port[dev] == SNDRV_AUTO_PORT)
@@ -360,7 +360,10 @@
 		if (snd_gusextreme_probe(dev) >= 0)
 			cards++;
 	}
-	cards += snd_legacy_auto_probe(possible_ports, snd_gusextreme_legacy_auto_probe);
+	i = snd_legacy_auto_probe(possible_ports, snd_gusextreme_legacy_auto_probe);
+	if (i > 0)
+		cards += i;
+
 	if (!cards) {
 #ifdef MODULE
 		printk(KERN_ERR "GUS Extreme soundcard not found or device busy\n");

--- linux-2.6.4/sound/isa/sb/sb8.c~	2004-03-15 17:52:44.000000000 +0000
+++ linux-2.6.4/sound/isa/sb/sb8.c	2004-03-15 17:53:19.000000000 +0000
@@ -199,7 +199,7 @@
 static int __init alsa_card_sb8_init(void)
 {
 	static unsigned long possible_ports[] = {0x220, 0x240, 0x260, -1};
-	int dev, cards;
+	int dev, cards, i;
 
 	for (dev = cards = 0; dev < SNDRV_CARDS && enable[dev]; dev++) {
 		if (port[dev] == SNDRV_AUTO_PORT)
@@ -207,7 +207,10 @@
 		if (snd_sb8_probe(dev) >= 0)
 			cards++;
 	}
-	cards += snd_legacy_auto_probe(possible_ports, snd_card_sb8_legacy_auto_probe);
+	i = snd_legacy_auto_probe(possible_ports, snd_card_sb8_legacy_auto_probe);
+	if (i > 0)
+		cards += i;
+
 	if (!cards) {
 #ifdef MODULE
 		snd_printk(KERN_ERR "Sound Blaster soundcard not found or device busy\n");
--- linux-2.6.4/sound/isa/sb/sb16.c~	2004-03-15 17:53:23.000000000 +0000
+++ linux-2.6.4/sound/isa/sb/sb16.c	2004-03-15 17:54:29.000000000 +0000
@@ -629,7 +629,7 @@
 
 static int __init alsa_card_sb16_init(void)
 {
-	int dev, cards = 0;
+	int dev, cards = 0, i;
 	static unsigned long possible_ports[] = {0x220, 0x240, 0x260, 0x280, -1};
 
 	/* legacy non-auto cards at first */
@@ -649,10 +649,15 @@
 #endif
 	}
 	/* legacy auto configured cards */
-	cards += snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_port);
+	i = snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_port);
+	if (i > 0)
+		cards += i;
+
 #ifdef CONFIG_PNP
 	/* PnP cards at last */
-	cards += pnp_register_card_driver(&sb16_pnpc_driver);
+	i = pnp_register_card_driver(&sb16_pnpc_driver);
+	if (i >0)
+		cards += i;
 #endif
 
 	if (!cards) {
--- linux-2.6.4/sound/isa/gus/interwave.c~	2004-03-15 17:54:33.000000000 +0000
+++ linux-2.6.4/sound/isa/gus/interwave.c	2004-03-15 17:55:20.000000000 +0000
@@ -929,7 +929,7 @@
 
 static int __init alsa_card_interwave_init(void)
 {
-	int cards = 0;
+	int cards = 0, i;
 	static long possible_ports[] = {0x210, 0x220, 0x230, 0x240, 0x250, 0x260, -1};
 	int dev;
 
@@ -949,10 +949,14 @@
 #endif
 	}
 	/* legacy auto configured cards */
-	cards += snd_legacy_auto_probe(possible_ports, snd_interwave_probe_legacy_port);
+	i = snd_legacy_auto_probe(possible_ports, snd_interwave_probe_legacy_port);
+	if (i > 0)
+		cards += i;
 #ifdef CONFIG_PNP
-        /* ISA PnP cards */
-        cards += pnp_register_card_driver(&interwave_pnpc_driver);
+	/* ISA PnP cards */
+	i = pnp_register_card_driver(&interwave_pnpc_driver);
+	if (i > 0)
+		cards += i;
 #endif
 
 	if (!cards) {
--- linux-2.6.4/sound/isa/gus/gusclassic.c~	2004-03-15 17:55:25.000000000 +0000
+++ linux-2.6.4/sound/isa/gus/gusclassic.c	2004-03-15 17:55:42.000000000 +0000
@@ -238,7 +238,7 @@
 static int __init alsa_card_gusclassic_init(void)
 {
 	static unsigned long possible_ports[] = {0x220, 0x230, 0x240, 0x250, 0x260, -1};
-	int dev, cards;
+	int dev, cards, i;
 
 	for (dev = cards = 0; dev < SNDRV_CARDS && enable[dev]; dev++) {
 		if (port[dev] == SNDRV_AUTO_PORT)
@@ -246,7 +246,10 @@
 		if (snd_gusclassic_probe(dev) >= 0)
 			cards++;
 	}
-	cards += snd_legacy_auto_probe(possible_ports, snd_gusclassic_legacy_auto_probe);
+	i = snd_legacy_auto_probe(possible_ports, snd_gusclassic_legacy_auto_probe);
+	if (i > 0)
+		cards += i;
+
 	if (!cards) {
 #ifdef MODULE
 		printk(KERN_ERR "GUS Classic soundcard not found or device busy\n");
--- linux-2.6.4/sound/isa/gus/gusmax.c~	2004-03-15 17:55:47.000000000 +0000
+++ linux-2.6.4/sound/isa/gus/gusmax.c	2004-03-15 17:56:05.000000000 +0000
@@ -378,7 +378,7 @@
 static int __init alsa_card_gusmax_init(void)
 {
 	static unsigned long possible_ports[] = {0x220, 0x230, 0x240, 0x250, 0x260, -1};
-	int dev, cards;
+	int dev, cards, i;
 
 	for (dev = cards = 0; dev < SNDRV_CARDS && enable[dev] > 0; dev++) {
 		if (port[dev] == SNDRV_AUTO_PORT)
@@ -386,7 +386,10 @@
 		if (snd_gusmax_probe(dev) >= 0)
 			cards++;
 	}
-	cards += snd_legacy_auto_probe(possible_ports, snd_gusmax_legacy_auto_probe);
+	i = snd_legacy_auto_probe(possible_ports, snd_gusmax_legacy_auto_probe);
+	if (i > 0)
+		cards += i;
+
 	if (!cards) {
 #ifdef MODULE
 		printk(KERN_ERR "GUS MAX soundcard not found or device busy\n");
--- linux-2.6.4/sound/isa/es18xx.c~	2004-03-15 17:56:09.000000000 +0000
+++ linux-2.6.4/sound/isa/es18xx.c	2004-03-15 17:56:37.000000000 +0000
@@ -2232,7 +2232,7 @@
 static int __init alsa_card_es18xx_init(void)
 {
 	static unsigned long possible_ports[] = {0x220, 0x240, 0x260, 0x280, -1};
-	int dev, cards = 0;
+	int dev, cards = 0, i;
 
 	/* legacy non-auto cards at first */
 	for (dev = 0; dev < SNDRV_CARDS; dev++) {
@@ -2246,10 +2246,16 @@
 			cards++;
 	}
 	/* legacy auto configured cards */
-	cards += snd_legacy_auto_probe(possible_ports, snd_audiodrive_probe_legacy_port);
+	i = snd_legacy_auto_probe(possible_ports, snd_audiodrive_probe_legacy_port);
+	if (i > 0)
+		cards += i;
+
 #ifdef CONFIG_PNP
 	/* ISA PnP cards at last */
-	cards += pnp_register_card_driver(&es18xx_pnpc_driver);
+	i = pnp_register_card_driver(&es18xx_pnpc_driver);
+	if (i > 0)
+		cards += i;
+
 #endif
 	if(!cards) {
 #ifdef CONFIG_PNP
--- linux-2.6.4/sound/isa/es1688/es1688.c~	2004-03-15 17:56:42.000000000 +0000
+++ linux-2.6.4/sound/isa/es1688/es1688.c	2004-03-15 17:56:57.000000000 +0000
@@ -182,7 +182,7 @@
 static int __init alsa_card_es1688_init(void)
 {
 	static unsigned long possible_ports[] = {0x220, 0x240, 0x260, -1};
-	int dev, cards = 0;
+	int dev, cards = 0, i;
 
 	for (dev = cards = 0; dev < SNDRV_CARDS && enable[dev]; dev++) {
 		if (port[dev] == SNDRV_AUTO_PORT)
@@ -190,7 +190,10 @@
 		if (snd_audiodrive_probe(dev) >= 0)
 			cards++;
 	}
-	cards += snd_legacy_auto_probe(possible_ports, snd_audiodrive_legacy_auto_probe);
+	i = snd_legacy_auto_probe(possible_ports, snd_audiodrive_legacy_auto_probe);
+	if (i > 0)
+		cards += i;
+
 	if (!cards) {
 #ifdef MODULE
 		printk(KERN_ERR "ESS AudioDrive ES1688 soundcard not found or device busy\n");
