Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbUAAURG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUAAUOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:14:47 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:5934 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264874AbUAAUJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:09:57 -0500
Date: Thu, 1 Jan 2004 21:02:01 +0100
Message-Id: <200401012002.i01K21pa031811@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 364] Mac ADB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ADB: Disable the ADB clock code when CONFIG_ADB is not selected (from Matthias
Urlichs).

--- linux-2.6.0/arch/m68k/mac/misc.c	2003-01-02 12:53:57.000000000 +0100
+++ linux-m68k-2.6.0/arch/m68k/mac/misc.c	2003-11-03 20:49:30.000000000 +0100
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
@@ -356,7 +358,11 @@
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
@@ -374,7 +380,11 @@
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
@@ -580,12 +590,16 @@
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
