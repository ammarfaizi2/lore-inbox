Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUAAU7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAAU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:56:08 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:16218 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264884AbUAAUDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:19 -0500
Date: Thu, 1 Jan 2004 21:03:17 +0100
Message-Id: <200401012003.i01K3Hma031844@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 368] Amiga Gayle E-Matrix 530 IDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Gayle IDE: Add support for the IDE interface on the M-Tech E-Matrix 530
expansion card

--- linux-2.6.0/drivers/ide/Kconfig	2003-10-09 10:02:46.000000000 +0200
+++ linux-m68k-2.6.0/drivers/ide/Kconfig	2003-11-03 22:10:17.000000000 +0100
@@ -886,12 +886,16 @@
 	bool "Amiga Gayle IDE interface support"
 	depends on AMIGA
 	help
-	  This is the IDE driver for the builtin IDE interface on some Amiga
-	  models. It supports both the `A1200 style' (used in A600 and A1200)
-	  and `A4000 style' (used in A4000 and A4000T) of the Gayle IDE
-	  interface. Say Y if you have such an Amiga model and want to use IDE
-	  devices (hard disks, CD-ROM drives, etc.) that are connected to the
-	  builtin IDE interface.
+	  This is the IDE driver for the Amiga Gayle IDE interface. It supports
+	  both the `A1200 style' and `A4000 style' of the Gayle IDE interface,
+	  This includes builtin IDE interfaces on some Amiga models (A600,
+	  A1200, A4000, and A4000T), and IDE interfaces on the Zorro expansion
+	  bus (M-Tech E-Matrix 530 expansion card).
+	  Say Y if you have an Amiga with a Gayle IDE interface and want to use
+	  IDE devices (hard disks, CD-ROM drives, etc.) that are connected to
+	  it.
+	  Note that you also have to enable Zorro bus support if you want to
+	  use Gayle IDE interfaces on the Zorro expansion bus.
 
 config BLK_DEV_IDEDOUBLER
 	bool "Amiga IDE Doubler support (EXPERIMENTAL)"
--- linux-2.6.0/drivers/ide/legacy/gayle.c	2003-04-20 12:28:33.000000000 +0200
+++ linux-m68k-2.6.0/drivers/ide/legacy/gayle.c	2003-11-03 21:54:03.000000000 +0100
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
 	unsigned long base, ctrlport, irqport;
 	ide_ack_intr_t *ack_intr;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
