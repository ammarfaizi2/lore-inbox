Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTLGU6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTLGU5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:57:51 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:51754 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264531AbTLGUzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:38 -0500
Date: Sun, 7 Dec 2003 21:51:23 +0100
Message-Id: <200312072051.hB7KpN7U000729@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 133] Mac ADB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ADB: Disable the ADB clock code when CONFIG_ADB is not selected (from Matthias
Urlichs in 2.6.0).

--- linux-2.4.23/arch/m68k/mac/misc.c	2002-09-13 10:15:02.000000000 +0200
+++ linux-m68k-2.4.23/arch/m68k/mac/misc.c	2003-11-03 20:48:53.000000000 +0100
@@ -39,6 +39,7 @@
 extern struct mac_booter_data mac_bi_data;
 static void (*rom_reset)(void);
 
+#ifdef CONFIG_ADB
 /*
  * Return the current time as the number of seconds since January 1, 1904.
  */
@@ -103,6 +104,7 @@
 			(offset >> 8) & 0xFF, offset & 0xFF,
 			data);
 }
+#endif /* CONFIG_ADB */
 
 /*
  * VIA PRAM/RTC access routines
@@ -357,7 +359,11 @@
 	    macintosh_config->adb_type == MAC_ADB_PB1 ||
 	    macintosh_config->adb_type == MAC_ADB_PB2 ||
 	    macintosh_config->adb_type == MAC_ADB_CUDA) {
+#ifdef CONFIG_ADB
 		func = adb_read_pram;
+#else
+		return;
+#endif
 	} else {
 		func = via_read_pram;
 	}
@@ -375,7 +381,11 @@
 	    macintosh_config->adb_type == MAC_ADB_PB1 ||
 	    macintosh_config->adb_type == MAC_ADB_PB2 ||
 	    macintosh_config->adb_type == MAC_ADB_CUDA) {
+#ifdef CONFIG_ADB
 		func = adb_write_pram;
+#else
+		return;
+#endif
 	} else {
 		func = via_write_pram;
 	}
@@ -602,12 +612,16 @@
 	if (!op) { /* read */
 		if (macintosh_config->adb_type == MAC_ADB_II) {
 			now = via_read_time();
-		} else if ((macintosh_config->adb_type == MAC_ADB_IISI) ||
+		} else
+#ifdef CONFIG_ADB
+		if ((macintosh_config->adb_type == MAC_ADB_IISI) ||
 			   (macintosh_config->adb_type == MAC_ADB_PB1) ||
 			   (macintosh_config->adb_type == MAC_ADB_PB2) ||
 			   (macintosh_config->adb_type == MAC_ADB_CUDA)) {
 			now = adb_read_time();
-		} else if (macintosh_config->adb_type == MAC_ADB_IOP) {
+		} else
+#endif
+		if (macintosh_config->adb_type == MAC_ADB_IOP) {
 			now = via_read_time();
 		} else {
 			now = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
