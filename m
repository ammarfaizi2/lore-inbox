Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTLGVnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTLGVnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:43:10 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:35158 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264539AbTLGUzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:47 -0500
Date: Sun, 7 Dec 2003 21:51:30 +0100
Message-Id: <200312072051.hB7KpUw7000777@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 141] Amiga NCR53c710 SCSI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga NCR53c710: Coalesce all Amiga NCR53c710 SCSI host adapters configuration
options into one config option, as suggested by Matthew Wilcox.

--- linux-2.4.23/Documentation/Configure.help	2003-11-11 10:03:58.000000000 +0100
+++ linux-m68k-2.4.23/Documentation/Configure.help	2003-11-12 11:42:27.000000000 +0100
@@ -1526,12 +1526,6 @@
   Say Y if you have an IDE doubler.  The driver is enabled at kernel
   runtime using the "ide=doubler" kernel boot parameter.
 
-WarpEngine SCSI support
-CONFIG_WARPENGINE_SCSI
-  Support for MacroSystem Development's WarpEngine Amiga SCSI-2
-  controller. Info at
-  <http://www.lysator.liu.se/amiga/ar/guide/ar310.guide?FEATURE5>.
-
 Builtin PowerMac IDE support
 CONFIG_BLK_DEV_IDE_PMAC
   This driver provides support for the built-in IDE controller on
@@ -23033,15 +23027,22 @@
   "ser_a2232.o". If you want to do this, answer M here and read
   "<file:Documentation/modules.txt>".
 
-A4000T SCSI support
-CONFIG_A4000T_SCSI
-  Support for the NCR53C710 SCSI controller on the Amiga 4000T.
-
-A4091 SCSI support
-CONFIG_A4091_SCSI
-  Support for the NCR53C710 chip on the Amiga 4091 Z3 SCSI2 controller
-  (1993).  Very obscure -- the 4091 was part of an Amiga 4000 upgrade
-  plan at the time the Amiga business was sold to DKB.
+Amiga NCR53c710 SCSI support
+CONFIG_SCSI_AMIGA7XX
+  Support for various NCR53c710-based SCSI controllers on the Amiga.
+  This includes:
+    - the builtin SCSI controller on the Amiga 4000T,
+    - the Amiga 4091 Zorro III SCSI-2 controller,
+    - the MacroSystem Development's WarpEngine Amiga SCSI-2 controller
+      (info at
+       <http://www.lysator.liu.se/amiga/ar/guide/ar310.guide?FEATURE5>),
+    - the SCSI controller on the Phase5 Blizzard PowerUP 603e+
+      accelerator card for the Amiga 1200,
+    - the SCSI controller on the GVP Turbo 040/060 accelerator.
+  Note that all of the above SCSI controllers, except for the builtin
+  SCSI controller on the Amiga 4000T, reside on the Zorro expansion
+  bus, so you also have to enable Zorro bus support if you want to use
+  them.
 
 Atari support
 CONFIG_ATARI
@@ -23386,11 +23387,6 @@
   1260 accelerator, and the optional SCSI module, say Y. Otherwise,
   say N.
 
-Blizzard PowerUP 603e+ SCSI support
-CONFIG_BLZ603EPLUS_SCSI
-  If you have an Amiga 1200 with a Phase5 Blizzard PowerUP 603e+
-  accelerator, say Y. Otherwise, say N.
-
 Fastlane SCSI support
 CONFIG_FASTLANE_SCSI
   If you have the Phase5 Fastlane Z3 SCSI controller, or plan to use
--- linux-2.4.23/arch/m68k/config.in	2003-08-31 10:42:53.000000000 +0200
+++ linux-m68k-2.4.23/arch/m68k/config.in	2003-11-03 21:13:02.000000000 +0100
@@ -234,7 +234,7 @@
    if [ "$CONFIG_AMIGA" = "y" ]; then
       dep_tristate 'A3000 WD33C93A support' CONFIG_A3000_SCSI $CONFIG_SCSI
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 bool 'A4000T SCSI support (EXPERIMENTAL)' CONFIG_A4000T_SCSI
+	 bool 'Amiga NCR53c710 SCSI support (EXPERIMENTAL)' CONFIG_SCSI_AMIGA7XX
       fi
    fi
    if [ "$CONFIG_ZORRO" = "y" ]; then
@@ -246,12 +246,8 @@
       dep_tristate 'Blizzard 1230IV/1260 SCSI support' CONFIG_BLZ1230_SCSI $CONFIG_SCSI
       dep_tristate 'Fastlane SCSI support' CONFIG_FASTLANE_SCSI $CONFIG_SCSI
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 bool 'A4091 SCSI support (EXPERIMENTAL)' CONFIG_A4091_SCSI
-	 bool 'WarpEngine SCSI support (EXPERIMENTAL)' CONFIG_WARPENGINE_SCSI
-	 bool 'Blizzard PowerUP 603e+ SCSI (EXPERIMENTAL)' CONFIG_BLZ603EPLUS_SCSI
 	 dep_tristate 'BSC Oktagon SCSI support (EXPERIMENTAL)' CONFIG_OKTAGON_SCSI $CONFIG_SCSI
 #	 bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
-#	 bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
       fi
    fi
    if [ "$CONFIG_ATARI" = "y" ]; then
--- linux-2.4.23/drivers/scsi/Config.in	2003-10-10 12:14:17.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/Config.in	2003-11-03 21:07:54.000000000 +0100
@@ -237,7 +237,7 @@
 if [ "$CONFIG_AMIGA" = "y" ]; then
    dep_tristate 'A3000 WD33C93A support' CONFIG_A3000_SCSI $CONFIG_SCSI
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-      bool 'A4000T SCSI support (EXPERIMENTAL)' CONFIG_A4000T_SCSI
+      bool 'Amiga NCR53c710 SCSI support (EXPERIMENTAL)' CONFIG_SCSI_AMIGA7XX
    fi
 fi
 if [ "$CONFIG_ZORRO" = "y" ]; then
@@ -249,12 +249,8 @@
    dep_tristate 'Blizzard 1230IV/1260 SCSI support' CONFIG_BLZ1230_SCSI $CONFIG_SCSI
    dep_tristate 'Fastlane SCSI support' CONFIG_FASTLANE_SCSI $CONFIG_SCSI
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-      bool 'A4091 SCSI support (EXPERIMENTAL)' CONFIG_A4091_SCSI
-      bool 'WarpEngine SCSI support (EXPERIMENTAL)' CONFIG_WARPENGINE_SCSI
-      bool 'Blizzard PowerUP 603e+ SCSI (EXPERIMENTAL)' CONFIG_BLZ603EPLUS_SCSI
       dep_tristate 'BSC Oktagon SCSI support (EXPERIMENTAL)' CONFIG_OKTAGON_SCSI $CONFIG_SCSI
 #      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
-#      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
    fi
 fi
 
--- linux-2.4.23/drivers/scsi/Makefile	2003-10-10 12:14:17.000000000 +0200
+++ linux-m68k-2.4.23/drivers/scsi/Makefile	2003-11-03 21:08:34.000000000 +0100
@@ -33,10 +33,7 @@
 
 obj-$(CONFIG_SCSI)		+= scsi_mod.o
 
-obj-$(CONFIG_A4000T_SCSI)	+= amiga7xx.o	53c7xx.o
-obj-$(CONFIG_A4091_SCSI)	+= amiga7xx.o	53c7xx.o
-obj-$(CONFIG_BLZ603EPLUS_SCSI)	+= amiga7xx.o	53c7xx.o
-obj-$(CONFIG_WARPENGINE_SCSI)	+= amiga7xx.o	53c7xx.o
+obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o
 obj-$(CONFIG_GVP11_SCSI)	+= gvp11.o	wd33c93.o
--- linux-2.4.23/drivers/scsi/amiga7xx.c	2003-11-03 22:46:01.000000000 +0100
+++ linux-m68k-2.4.23/drivers/scsi/amiga7xx.c	2003-11-03 21:41:22.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * Detection routine for the NCR53c710 based Amiga SCSI Controllers for Linux.
- *  		Amiga MacroSystemUS WarpEngine SCSI controller.
+ *		Amiga MacroSystemUS WarpEngine SCSI controller.
  *		Amiga Technologies A4000T SCSI controller.
  *		Amiga Technologies/DKB A4091 SCSI controller.
  *
@@ -14,13 +14,13 @@
 #include <linux/version.h>
 #include <linux/config.h>
 #include <linux/zorro.h>
+#include <linux/stat.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
-
 #include <asm/irq.h>
 
 #include "scsi.h"
@@ -28,104 +28,83 @@
 #include "53c7xx.h"
 #include "amiga7xx.h"
 
-#include<linux/stat.h>
-
 
-int __init amiga7xx_detect(Scsi_Host_Template *tpnt)
+static int amiga7xx_register_one(Scsi_Host_Template *tpnt,
+				 unsigned long address)
 {
-    static unsigned char called = 0;
-    int num = 0, clock;
     long long options;
-    struct zorro_dev *z = NULL;
-    unsigned long address;
+    int clock;
 
-    if (called || !MACH_IS_AMIGA)
+    if (!request_mem_region(address, 0x1000, "ncr53c710"))
 	return 0;
 
-    tpnt->proc_name = "Amiga7xx";
+    address = (unsigned long)z_ioremap(address, 0x1000);
+    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 | OPTION_INTFLY |
+	      OPTION_SYNCHRONOUS | OPTION_ALWAYS_SYNCHRONOUS |
+	      OPTION_DISCONNECT;
+    clock = 50000000;	/* 50 MHz SCSI Clock */
+    ncr53c7xx_init(tpnt, 0, 710, address, 0, IRQ_AMIGA_PORTS, DMA_NONE,
+		   options, clock);
+    return 1;
+}
 
-#ifdef CONFIG_A4000T_SCSI
-    if (AMIGAHW_PRESENT(A4000_SCSI)) {
-	address = 0xdd0040;
-	if (request_mem_region(address, 0x1000, "ncr53c710")) { 
-	    address = ZTWO_VADDR(address);
-	    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 |
-		      OPTION_INTFLY | OPTION_SYNCHRONOUS |
-		      OPTION_ALWAYS_SYNCHRONOUS | OPTION_DISCONNECT;
-	    clock = 50000000;	/* 50MHz SCSI Clock */
-	    ncr53c7xx_init(tpnt, 0, 710, address, 0, IRQ_AMIGA_PORTS, DMA_NONE,
-			   options, clock);
-	    num++;
-	}
-    }
-#endif
+
+#ifdef CONFIG_ZORRO
+
+static struct {
+    zorro_id id;
+    unsigned long offset;
+    int absolute;	/* offset is absolute address */
+} amiga7xx_table[] = {
+    { .id = ZORRO_PROD_PHASE5_BLIZZARD_603E_PLUS, .offset = 0xf40000,
+      .absolute = 1 },
+    { .id = ZORRO_PROD_MACROSYSTEMS_WARP_ENGINE_40xx, .offset = 0x40000 },
+    { .id = ZORRO_PROD_CBM_A4091_1, .offset = 0x800000 },
+    { .id = ZORRO_PROD_CBM_A4091_2, .offset = 0x800000 },
+    { .id = ZORRO_PROD_GVP_GFORCE_040_060, .offset = 0x40000 },
+    { 0 }
+};
+
+static int __init amiga7xx_zorro_detect(Scsi_Host_Template *tpnt)
+{
+    int num = 0, i;
+    struct zorro_dev *z = NULL;
+    unsigned long address;
 
     while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-	unsigned long address = z->resource.start;
-	unsigned long size = z->resource.end-z->resource.start+1;
-	switch (z->id) {
-#ifdef CONFIG_BLZ603EPLUS_SCSI
-	    case ZORRO_PROD_PHASE5_BLIZZARD_603E_PLUS:
-		address = 0xf40000;
-		if (request_mem_region(address, 0x1000, "ncr53c710")) {
-		    address = ZTWO_VADDR(address);
-		    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 |
-			      OPTION_INTFLY | OPTION_SYNCHRONOUS | 
-			      OPTION_ALWAYS_SYNCHRONOUS | OPTION_DISCONNECT;
-		    clock = 50000000;	/* 50MHz SCSI Clock */
-		    ncr53c7xx_init(tpnt, 0, 710, address, 0, IRQ_AMIGA_PORTS,
-				   DMA_NONE, options, clock);
-		    num++;
-		}
+	for (i = 0; amiga7xx_table[i].id; i++)
+	    if (z->id == amiga7xx_table[i].id)
 		break;
-#endif
+	if (!amiga7xx_table[i].id)
+	    continue;
+	if (amiga7xx_table[i].absolute)
+	    address = amiga7xx_table[i].offset;
+	else
+	    address = z->resource.start + amiga7xx_table[i].offset;
+	num += amiga7xx_register_one(tpnt, address);
+    }
+    return num;
+}
 
-#ifdef CONFIG_WARPENGINE_SCSI
-    	    case ZORRO_PROD_MACROSYSTEMS_WARP_ENGINE_40xx:
-		if (request_mem_region(address+0x40000, 0x1000, "ncr53c710")) {
-		    address = (unsigned long)z_ioremap(address, size);
-		    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 |
-			      OPTION_INTFLY | OPTION_SYNCHRONOUS |
-			      OPTION_ALWAYS_SYNCHRONOUS | OPTION_DISCONNECT;
-		    clock = 50000000;	/* 50MHz SCSI Clock */
-		    ncr53c7xx_init(tpnt, 0, 710, address+0x40000, 0,
-				   IRQ_AMIGA_PORTS, DMA_NONE, options, clock);
-		    num++;
-		}
-		break;
-#endif
+#endif /* CONFIG_ZORRO */
 
-#ifdef CONFIG_A4091_SCSI
-	    case ZORRO_PROD_CBM_A4091_1:
-	    case ZORRO_PROD_CBM_A4091_2:
-		if (request_mem_region(address+0x800000, 0x1000, "ncr53c710")) {
-		    address = (unsigned long)z_ioremap(address, size);
-		    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 |
-			      OPTION_INTFLY | OPTION_SYNCHRONOUS |
-			      OPTION_ALWAYS_SYNCHRONOUS | OPTION_DISCONNECT;
-		    clock = 50000000;	/* 50MHz SCSI Clock */
-		    ncr53c7xx_init(tpnt, 0, 710, address+0x800000, 0,
-				   IRQ_AMIGA_PORTS, DMA_NONE, options, clock);
-		    num++;
-		}
-		break;
-#endif
 
-#ifdef CONFIG_GVP_TURBO_SCSI
-    	    case ZORRO_PROD_GVP_GFORCE_040_060:
-		if (request_mem_region(address+0x40000, 0x1000, "ncr53c710")) {
-		    address = ZTWO_VADDR(address);
-		    options = OPTION_MEMORY_MAPPED | OPTION_DEBUG_TEST1 |
-			      OPTION_INTFLY | OPTION_SYNCHRONOUS |
-			      OPTION_ALWAYS_SYNCHRONOUS | OPTION_DISCONNECT;
-		    clock = 50000000;	/* 50MHz SCSI Clock */
-		    ncr53c7xx_init(tpnt, 0, 710, address+0x40000, 0,
-				   IRQ_AMIGA_PORTS, DMA_NONE, options, clock);
-		    num++;
-		}
+int __init amiga7xx_detect(Scsi_Host_Template *tpnt)
+{
+    static unsigned char called = 0;
+    int num = 0;
+
+    if (called || !MACH_IS_AMIGA)
+	return 0;
+
+    tpnt->proc_name = "Amiga7xx";
+
+    if (AMIGAHW_PRESENT(A4000_SCSI))
+	num += amiga7xx_register_one(tpnt, 0xdd0040);
+
+#ifdef CONFIG_ZORRO
+    num += amiga7xx_zorro_detect(tpnt);
 #endif
-	}
-    }
 
     called = 1;
     return num;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
