Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTLGVVX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTLGU4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:56:32 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:42031 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264534AbTLGUzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:40 -0500
Date: Sun, 7 Dec 2003 21:51:26 +0100
Message-Id: <200312072051.hB7KpQmX000747@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 136] Amiga Gayle E-Matrix 530 IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Gayle IDE: Add support for the IDE interface on the M-Tech E-Matrix 530
expansion card

--- linux-2.4.23/Documentation/Configure.help	2003-10-30 14:06:08.000000000 +0100
+++ linux-m68k-2.4.23/Documentation/Configure.help	2003-11-03 22:10:12.000000000 +0100
@@ -1485,12 +1485,15 @@
 
 Amiga Gayle IDE interface support
 CONFIG_BLK_DEV_GAYLE
-  This is the IDE driver for the builtin IDE interface on some Amiga
-  models. It supports both the `A1200 style' (used in A600 and A1200)
-  and `A4000 style' (used in A4000 and A4000T) of the Gayle IDE
-  interface. Say Y if you have such an Amiga model and want to use IDE
-  devices (hard disks, CD-ROM drives, etc.) that are connected to the
-  builtin IDE interface.
+  This is the IDE driver for the Amiga Gayle IDE interface. It supports
+  both the `A1200 style' and `A4000 style' of the Gayle IDE interface,
+  This includes builtin IDE interfaces on some Amiga models (A600,
+  A1200, A4000, and A4000T), and IDE interfaces on the Zorro expansion
+  bus (M-Tech E-Matrix 530 expansion card).
+  Say Y if you have an Amiga with a Gayle IDE interface and want to use
+  IDE devices (hard disks, CD-ROM drives, etc.) that are connected to it.
+  Note that you also have to enable Zorro bus support if you want to
+  use Gayle IDE interfaces on the Zorro expansion bus.
 
 Falcon IDE interface support
 CONFIG_BLK_DEV_FALCON_IDE
--- linux-2.4.23/drivers/ide/legacy/gayle.c	2003-05-09 11:02:33.000000000 +0200
+++ linux-m68k-2.4.23/drivers/ide/legacy/gayle.c	2003-11-02 13:49:18.000000000 +0100
@@ -29,7 +29,7 @@
      */
 
 #define GAYLE_BASE_4000	0xdd2020	/* A4000/A4000T */
-#define GAYLE_BASE_1200	0xda0000	/* A1200/A600 */
+#define GAYLE_BASE_1200	0xda0000	/* A1200/A600 and E-Matrix 530 */
 
     /*
      *  Offsets from one of the above bases
@@ -118,9 +118,17 @@
     if (!MACH_IS_AMIGA)
 	return;
 
-    if (!(a4000 = AMIGAHW_PRESENT(A4000_IDE)) && !AMIGAHW_PRESENT(A1200_IDE))
-	return;
+    if ((a4000 = AMIGAHW_PRESENT(A4000_IDE)) || AMIGAHW_PRESENT(A1200_IDE))
+	goto found;
+
+#ifdef CONFIG_ZORRO
+    if (zorro_find_device(ZORRO_PROD_MTEC_VIPER_MK_V_E_MATRIX_530_SCSI_IDE,
+			  NULL))
+	goto found;
+#endif
+    return;
 
+found:
     for (i = 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
 	ide_ioreg_t base, ctrlport, irqport;
 	ide_ack_intr_t *ack_intr;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
