Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbTACXrT>; Fri, 3 Jan 2003 18:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267722AbTACXrT>; Fri, 3 Jan 2003 18:47:19 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:50962 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267720AbTACXqb>; Fri, 3 Jan 2003 18:46:31 -0500
Date: Sat, 4 Jan 2003 00:46:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] menuconfig support for top-level config menu dependencies
In-Reply-To: <20030102195024.GC17053@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301032120280.765-100000@spit.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is a first version, which implements the menuconfig keyword and
makes use of at two places. The behaviour of 'make config' is still the
same, but menuconfig and xconfig look a bit different.
Comments welcome.

bye, Roman

diff -ur linux.org/drivers/mtd/Kconfig linux/drivers/mtd/Kconfig
--- linux.org/drivers/mtd/Kconfig	2002-12-16 03:07:48.000000000 +0100
+++ linux/drivers/mtd/Kconfig	2003-01-03 17:46:51.000000000 +0100
@@ -1,8 +1,6 @@
 # $Id: Config.in,v 1.74 2002/04/23 13:52:14 mag Exp $

-menu "Memory Technology Devices (MTD)"
-
-config MTD
+menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
@@ -13,9 +11,10 @@
 	  them. It will also allow you to select individual drivers for
 	  particular hardware and users of MTD devices. If unsure, say N.

+if MTD
+
 config MTD_DEBUG
 	bool "Debugging"
-	depends on MTD
 	help
 	  This turns on low-level debugging for the entire MTD sub-system.
 	  Normally, you should say 'N'.
@@ -29,7 +28,6 @@

 config MTD_PARTITIONS
 	tristate "MTD partitioning support"
-	depends on MTD
 	help
 	  If you have a device which needs to divide its flash chip(s) up
 	  into multiple 'partitions', each of which appears to the user as
@@ -40,15 +38,6 @@
 	  devices. Partitioning on NFTL 'devices' is a different - that's the
 	  'normal' form of partitioning used on a block device.

-config MTD_CONCAT
-	tristate "MTD concatenating support"
-	depends on MTD
-	help
-	  Support for concatenating several MTD devices into a single
-	  (virtual) one. This allows you to have -for example- a JFFS(2)
-	  file system spanning multiple physical flash chips. If unsure,
-	  say 'Y'.
-
 config MTD_REDBOOT_PARTS
 	tristate "RedBoot partition table parsing"
 	depends on MTD_PARTITIONS
@@ -121,12 +110,18 @@
 	  for your particular device. It won't happen automatically. The
 	  'armflash' map driver (CONFIG_MTD_ARMFLASH) does this, for example.

+config MTD_CONCAT
+	tristate "MTD concatenating support"
+	help
+	  Support for concatenating several MTD devices into a single
+	  (virtual) one. This allows you to have -for example- a JFFS(2)
+	  file system spanning multiple physical flash chips. If unsure,
+	  say 'Y'.
+
 comment "User Modules And Translation Layers"
-	depends on MTD

 config MTD_CHAR
 	tristate "Direct char device access to MTD devices"
-	depends on MTD
 	help
 	  This provides a character device for each MTD device present in
 	  the system, allowing the user to read and write directly to the
@@ -135,7 +130,6 @@

 config MTD_BLOCK
 	tristate "Caching block device access to MTD devices"
-	depends on MTD
 	---help---
 	  Although most flash chips have an erase size too large to be useful
 	  as block devices, it is possible to use MTD devices which are based
@@ -157,7 +151,7 @@

 config MTD_BLOCK_RO
 	tristate "Readonly block device access to MTD devices"
-	depends on MTD_BLOCK!=y && MTD
+	depends on MTD_BLOCK!=y
 	help
 	  This allows you to mount read-only file systems (such as cramfs)
 	  from an MTD device, without the overhead (and danger) of the caching
@@ -168,7 +162,6 @@

 config FTL
 	tristate "FTL (Flash Translation Layer) support"
-	depends on MTD
 	---help---
 	  This provides support for the original Flash Translation Layer which
 	  is part of the PCMCIA specification. It uses a kind of pseudo-
@@ -184,7 +177,6 @@

 config NFTL
 	tristate "NFTL (NAND Flash Translation Layer) support"
-	depends on MTD
 	---help---
 	  This provides support for the NAND Flash Translation Layer which is
 	  used on M-Systems' DiskOnChip devices. It uses a kind of pseudo-
@@ -215,5 +207,4 @@

 source "drivers/mtd/nand/Kconfig"

-endmenu
-
+endif
diff -ur linux.org/drivers/mtd/chips/Kconfig linux/drivers/mtd/chips/Kconfig
--- linux.org/drivers/mtd/chips/Kconfig	2002-12-16 03:07:52.000000000 +0100
+++ linux/drivers/mtd/chips/Kconfig	2003-01-03 17:56:05.000000000 +0100
@@ -2,11 +2,9 @@
 # $Id: Config.in,v 1.12 2001/09/23 15:35:21 dwmw2 Exp $

 menu "RAM/ROM/Flash chip drivers"
-	depends on MTD!=n

 config MTD_CFI
 	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
-	depends on MTD
 	help
 	  The Common Flash Interface specification was developed by Intel,
 	  AMD and other flash manufactures that provides a universal method
@@ -18,7 +16,6 @@
 #dep_tristate '  Detect non-CFI Intel-compatible flash chips' CONFIG_MTD_INTELPROBE $CONFIG_MTD
 config MTD_JEDECPROBE
 	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
-	depends on MTD
 	help
 	  This option enables JEDEC-style probing of flash chips which are not
 	  compatible with the Common Flash Interface, but will use the common
@@ -149,21 +146,18 @@

 config MTD_RAM
 	tristate "Support for RAM chips in bus mapping"
-	depends on MTD
 	help
 	  This option enables basic support for RAM chips accessed through
 	  a bus mapping driver.

 config MTD_ROM
 	tristate "Support for ROM chips in bus mapping"
-	depends on MTD
 	help
 	  This option enables basic support for ROM chips accessed through
 	  a bus mapping driver.

 config MTD_ABSENT
 	tristate "Support for absent chips in bus mapping"
-	depends on MTD
 	help
 	  This option enables support for a dummy probing driver used to
 	  allocated placeholder MTD devices on systems that have socketed
@@ -185,7 +179,7 @@

 config MTD_AMDSTD
 	tristate "AMD compatible flash chip support (non-CFI)"
-	depends on MTD && MTD_OBSOLETE_CHIPS
+	depends on MTD_OBSOLETE_CHIPS
 	help
 	  This option enables support for flash chips using AMD-compatible
 	  commands, including some which are not CFI-compatible and hence
@@ -195,7 +189,7 @@

 config MTD_SHARP
 	tristate "pre-CFI Sharp chip support"
-	depends on MTD && MTD_OBSOLETE_CHIPS
+	depends on MTD_OBSOLETE_CHIPS
 	help
 	  This option enables support for flash chips using Sharp-compatible
 	  commands, including some which are not CFI-compatible and hence
@@ -203,7 +197,7 @@

 config MTD_JEDEC
 	tristate "JEDEC device support"
-	depends on MTD && MTD_OBSOLETE_CHIPS
+	depends on MTD_OBSOLETE_CHIPS
 	help
 	  Enable older older JEDEC flash interface devices for self
 	  programming flash.  It is commonly used in older AMD chips.  It is
diff -ur linux.org/drivers/mtd/devices/Kconfig linux/drivers/mtd/devices/Kconfig
--- linux.org/drivers/mtd/devices/Kconfig	2002-12-16 03:07:54.000000000 +0100
+++ linux/drivers/mtd/devices/Kconfig	2003-01-03 17:58:16.000000000 +0100
@@ -2,11 +2,10 @@
 # $Id: Config.in,v 1.5 2001/09/23 15:33:10 dwmw2 Exp $

 menu "Self-contained MTD device drivers"
-	depends on MTD!=n

 config MTD_PMC551
 	tristate "Ramix PMC551 PCI Mezzanine RAM card support"
-	depends on MTD && PCI
+	depends on PCI
 	---help---
 	  This provides a MTD device driver for the Ramix PMC551 RAM PCI card
 	  from Ramix Inc. <http://www.ramix.com/products/memory/pmc551.html>.
@@ -40,7 +39,6 @@

 config MTD_SLRAM
 	tristate "Uncached system RAM"
-	depends on MTD
 	help
 	  If your CPU cannot cache all of the physical memory in your machine,
 	  you can still use it for storage or swap by using this driver to
@@ -48,7 +46,7 @@

 config MTD_LART
 	tristate "28F160xx flash driver for LART"
-	depends on SA1100_LART && MTD
+	depends on SA1100_LART
 	help
 	  This enables the flash driver for LART. Please note that you do
 	  not need any mapping/chip driver for LART. This one does it all
@@ -56,7 +54,6 @@

 config MTD_MTDRAM
 	tristate "Test driver using RAM"
-	depends on MTD
 	help
 	  This enables a test MTD device driver which uses vmalloc() to
 	  provide storage.  You probably want to say 'N' unless you're
@@ -96,7 +93,6 @@

 config MTD_BLKMTD
 	tristate "MTD emulation using block device"
-	depends on MTD
 	help
 	  This driver allows a block device to appear as an MTD. It would
 	  generally be used in the following cases:
@@ -110,14 +106,12 @@

 config MTD_DOC1000
 	tristate "M-Systems Disk-On-Chip 1000"
-	depends on MTD
 	help
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  1000 devices, which are obsolete so you probably want to say 'N'.

 config MTD_DOC2000
 	tristate "M-Systems Disk-On-Chip 2000 and Millennium"
-	depends on MTD
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  2000 and Millennium devices.  Originally designed for the DiskOnChip
@@ -134,7 +128,6 @@

 config MTD_DOC2001
 	tristate "M-Systems Disk-On-Chip Millennium-only alternative driver (see help)"
-	depends on MTD
 	---help---
 	  This provides an alternative MTD device driver for the M-Systems
 	  DiskOnChip Millennium devices.  Use this if you have problems with
diff -ur linux.org/drivers/mtd/maps/Kconfig linux/drivers/mtd/maps/Kconfig
--- linux.org/drivers/mtd/maps/Kconfig	2002-12-16 03:08:23.000000000 +0100
+++ linux/drivers/mtd/maps/Kconfig	2003-01-03 17:57:12.000000000 +0100
@@ -2,7 +2,6 @@
 # $Id: Config.in,v 1.16 2001/09/19 18:28:37 dwmw2 Exp $

 menu "Mapping drivers for chip access"
-	depends on MTD!=n

 config MTD_PHYSMAP
 	tristate "CFI Flash device in physical memory map"
@@ -330,7 +329,7 @@
 # This needs CFI or JEDEC, depending on the cards found.
 config MTD_PCI
 	tristate "PCI MTD driver"
-	depends on MTD && PCI
+	depends on PCI
 	help
 	  Mapping for accessing flash devices on add-in cards like the Intel XScale
 	  IQ80310 card, and the Intel EBSA285 card in blank ROM programming mode
@@ -340,7 +339,7 @@

 config MTD_PCMCIA
 	tristate "PCMCIA MTD driver"
-	depends on MTD && PCMCIA
+	depends on PCMCIA
 	help
 	  Map driver for accessing PCMCIA linear flash memory cards. These
 	  cards are usually around 4-16MiB in size. This does not include
diff -ur linux.org/drivers/parport/Kconfig linux/drivers/parport/Kconfig
--- linux.org/drivers/parport/Kconfig	2002-12-16 03:08:23.000000000 +0100
+++ linux/drivers/parport/Kconfig	2003-01-03 19:07:12.000000000 +0100
@@ -5,9 +5,7 @@
 # Parport configuration.
 #

-menu "Parallel port support"
-
-config PARPORT
+menuconfig PARPORT
 	tristate "Parallel port support"
 	---help---
 	  If you want to use devices connected to your machine's parallel port
@@ -34,9 +32,10 @@

 	  If unsure, say Y.

+if PARPORT
+
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on PARPORT
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
@@ -51,15 +50,9 @@

 	  If unsure, say Y.

-config PARPORT_PC_CML1
-	tristate
-	depends on PARPORT!=n && PARPORT_PC!=n
-	default PARPORT_PC if SERIAL_8250=y
-	default m if SERIAL_8250=m
-
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250!=n && PARPORT_PC_CML1
+	depends on SERIAL_8250 && PARPORT_PC
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module
@@ -88,18 +81,18 @@

 config PARPORT_PC_PCMCIA
 	tristate "Support for PCMCIA management for PC-style ports"
-	depends on PARPORT!=n && HOTPLUG && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
+	depends on PCMCIA && PARPORT_PC
 	help
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.

 config PARPORT_ARC
 	tristate "Archimedes hardware"
-	depends on ARM && PARPORT
+	depends on ARM

 config PARPORT_AMIGA
 	tristate "Amiga builtin port"
-	depends on AMIGA && PARPORT
+	depends on AMIGA
 	help
 	  Say Y here if you need support for the parallel port hardware on
 	  Amiga machines. This code is also available as a module (say M),
@@ -107,7 +100,7 @@

 config PARPORT_MFC3
 	tristate "Multiface III parallel port"
-	depends on AMIGA && ZORRO && PARPORT
+	depends on AMIGA && ZORRO
 	help
 	  Say Y here if you need parallel port support for the MFC3 card.
 	  This code is also available as a module (say M), called
@@ -115,7 +108,7 @@

 config PARPORT_ATARI
 	tristate "Atari hardware"
-	depends on ATARI && PARPORT
+	depends on ATARI
 	help
 	  Say Y here if you need support for the parallel port hardware on
 	  Atari machines. This code is also available as a module (say M),
@@ -128,7 +121,7 @@

 config PARPORT_SUNBPP
 	tristate "Sparc hardware (EXPERIMENTAL)"
-	depends on SBUS && EXPERIMENTAL && PARPORT
+	depends on SBUS && EXPERIMENTAL
 	help
 	  This driver provides support for the bidirectional parallel port
 	  found on many Sun machines. Note that many of the newer Ultras
@@ -138,7 +131,6 @@
 # support for loading any others.  Defeat this if the user is keen.
 config PARPORT_OTHER
 	bool "Support foreign hardware"
-	depends on PARPORT
 	help
 	  Say Y here if you want to be able to load driver modules to support
 	  other non-standard types of parallel ports. This causes a
@@ -146,7 +138,6 @@

 config PARPORT_1284
 	bool "IEEE 1284 transfer modes"
-	depends on PARPORT
 	help
 	  If you have a printer that supports status readback or device ID, or
 	  want to use a device that uses enhanced parallel port transfer modes
@@ -154,5 +145,4 @@
 	  transfer modes. Also say Y if you want device ID information to
 	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.

-endmenu
-
+endif
diff -ur linux.org/scripts/kconfig/expr.h linux/scripts/kconfig/expr.h
--- linux.org/scripts/kconfig/expr.h	2002-12-16 03:08:11.000000000 +0100
+++ linux/scripts/kconfig/expr.h	2003-01-03 19:08:27.000000000 +0100
@@ -155,9 +155,11 @@
 #define for_all_properties(sym, st, tok) \
 	for (st = sym->prop; st; st = st->next) \
 		if (st->type == (tok))
-#define for_all_prompts(sym, st) for_all_properties(sym, st, P_PROMPT)
 #define for_all_defaults(sym, st) for_all_properties(sym, st, P_DEFAULT)
 #define for_all_choices(sym, st) for_all_properties(sym, st, P_CHOICE)
+#define for_all_prompts(sym, st) \
+	for (st = sym->prop; st; st = st->next) \
+		if (st->text)

 struct menu {
 	struct menu *next;
diff -ur linux.org/scripts/kconfig/lex.zconf.c_shipped linux/scripts/kconfig/lex.zconf.c_shipped
--- linux.org/scripts/kconfig/lex.zconf.c_shipped	2002-12-16 03:08:19.000000000 +0100
+++ linux/scripts/kconfig/lex.zconf.c_shipped	2003-01-03 19:08:27.000000000 +0100
@@ -853,10 +853,10 @@
     },

     {
-       11,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,
-      -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,
-      -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,  -76,
-      -76,  -76,  -76,  -76,  -76,  -76,  -76
+       11,   77,  -76,  -76,   77,   77,   77,   77,   77,   77,
+       77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
+       77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
+       77,   77,   77,   77,   77,   77,   77
     },

     {
@@ -1180,7 +1180,7 @@

     {
        11, -120, -120, -120, -120, -120, -120, -120, -120, -120,
-     -120, -120, -120,   57, -120, -120,   57,   57,   57,   57,
+     -120, -120, -120,   57, -120, -120,   57,   57,  137,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -120
     },
@@ -1188,7 +1188,7 @@
     {
        11, -121, -121, -121, -121, -121, -121, -121, -121, -121,
      -121, -121, -121,   57, -121, -121,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,  137,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,  138,   57,
        57,   57,   57,   57,   57,   57, -121
     },

@@ -1196,20 +1196,20 @@
        11, -122, -122, -122, -122, -122, -122, -122, -122, -122,
      -122, -122, -122,   57, -122, -122,   57,   57,   57,   57,

-       57,   57,   57,   57,   57,   57,   57,   57,   57,  138,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,  139,
        57,   57,   57,   57,   57,   57, -122
     },

     {
        11, -123, -123, -123, -123, -123, -123, -123, -123, -123,
      -123, -123, -123,   57, -123, -123,   57,   57,   57,   57,
-       57,   57,   57,   57,  139,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,  140,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -123
     },

     {
        11, -124, -124, -124, -124, -124, -124, -124, -124, -124,
-     -124, -124, -124,   57, -124, -124,   57,   57,  140,   57,
+     -124, -124, -124,   57, -124, -124,   57,   57,  141,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -124

@@ -1218,7 +1218,7 @@
     {
        11, -125, -125, -125, -125, -125, -125, -125, -125, -125,
      -125, -125, -125,   57, -125, -125,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,  141,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,  142,   57,   57,
        57,   57,   57,   57,   57,   57, -125
     },

@@ -1226,12 +1226,12 @@
        11, -126, -126, -126, -126, -126, -126, -126, -126, -126,
      -126, -126, -126,   57, -126, -126,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,  142,   57,   57, -126
+       57,   57,   57,  143,   57,   57, -126
     },

     {
        11, -127, -127, -127, -127, -127, -127, -127, -127, -127,
-     -127, -127, -127,   57, -127, -127,  143,   57,   57,   57,
+     -127, -127, -127,   57, -127, -127,  144,   57,   57,   57,

        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -127
@@ -1240,14 +1240,14 @@
     {
        11, -128, -128, -128, -128, -128, -128, -128, -128, -128,
      -128, -128, -128,   57, -128, -128,   57,   57,   57,   57,
-      144,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+      145,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -128
     },

     {
        11, -129, -129, -129, -129, -129, -129, -129, -129, -129,
      -129, -129, -129,   57, -129, -129,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,  145,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,  146,   57,   57,
        57,   57,   57,   57,   57,   57, -129

     },
@@ -1255,20 +1255,20 @@
     {
        11, -130, -130, -130, -130, -130, -130, -130, -130, -130,
      -130, -130, -130,   57, -130, -130,   57,   57,   57,   57,
-       57,   57,  146,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,  147,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -130
     },

     {
        11, -131, -131, -131, -131, -131, -131, -131, -131, -131,
      -131, -131, -131,   57, -131, -131,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,  147,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,  148,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -131
     },

     {
        11, -132, -132, -132, -132, -132, -132, -132, -132, -132,
-     -132, -132, -132,   57, -132, -132,   57,   57,   57,  148,
+     -132, -132, -132,   57, -132, -132,   57,   57,   57,  149,

        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -132
@@ -1277,7 +1277,7 @@
     {
        11, -133, -133, -133, -133, -133, -133, -133, -133, -133,
      -133, -133, -133,   57, -133, -133,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,  149,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,  150,   57,
        57,   57,   57,   57,   57,   57, -133
     },

@@ -1292,14 +1292,14 @@
     {
        11, -135, -135, -135, -135, -135, -135, -135, -135, -135,
      -135, -135, -135,   57, -135, -135,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,  150,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,  151,   57,   57,
        57,   57,   57,   57,   57,   57, -135
     },

     {
        11, -136, -136, -136, -136, -136, -136, -136, -136, -136,
      -136, -136, -136,   57, -136, -136,   57,   57,   57,   57,
-      151,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+      152,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -136
     },

@@ -1307,58 +1307,58 @@
        11, -137, -137, -137, -137, -137, -137, -137, -137, -137,
      -137, -137, -137,   57, -137, -137,   57,   57,   57,   57,

-       57,   57,   57,   57,   57,   57,   57,  152,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,  153,   57,
        57,   57,   57,   57,   57,   57, -137
     },

     {
        11, -138, -138, -138, -138, -138, -138, -138, -138, -138,
      -138, -138, -138,   57, -138, -138,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,  153,   57,   57, -138
+       57,   57,   57,   57,   57,   57,   57,  154,   57,   57,
+       57,   57,   57,   57,   57,   57, -138
     },

     {
        11, -139, -139, -139, -139, -139, -139, -139, -139, -139,
      -139, -139, -139,   57, -139, -139,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,  154,   57,   57,   57,   57, -139
+       57,   57,   57,  155,   57,   57, -139

     },

     {
        11, -140, -140, -140, -140, -140, -140, -140, -140, -140,
      -140, -140, -140,   57, -140, -140,   57,   57,   57,   57,
-      155,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57, -140
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,  156,   57,   57,   57,   57, -140
     },

     {
        11, -141, -141, -141, -141, -141, -141, -141, -141, -141,
      -141, -141, -141,   57, -141, -141,   57,   57,   57,   57,
-       57,   57,  156,   57,   57,   57,   57,   57,   57,   57,
+      157,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -141
     },

     {
        11, -142, -142, -142, -142, -142, -142, -142, -142, -142,
-     -142, -142, -142,   57, -142, -142,  157,   57,   57,   57,
+     -142, -142, -142,   57, -142, -142,   57,   57,   57,   57,

-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,  158,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -142
     },

     {
        11, -143, -143, -143, -143, -143, -143, -143, -143, -143,
-     -143, -143, -143,   57, -143, -143,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,  158,   57,   57,
+     -143, -143, -143,   57, -143, -143,  159,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -143
     },

     {
        11, -144, -144, -144, -144, -144, -144, -144, -144, -144,
      -144, -144, -144,   57, -144, -144,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,  160,   57,   57,
        57,   57,   57,   57,   57,   57, -144

     },
@@ -1367,14 +1367,14 @@
        11, -145, -145, -145, -145, -145, -145, -145, -145, -145,
      -145, -145, -145,   57, -145, -145,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,  159,   57,   57, -145
+       57,   57,   57,   57,   57,   57, -145
     },

     {
        11, -146, -146, -146, -146, -146, -146, -146, -146, -146,
      -146, -146, -146,   57, -146, -146,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57, -146
+       57,   57,   57,  161,   57,   57, -146
     },

     {
@@ -1382,57 +1382,57 @@
      -147, -147, -147,   57, -147, -147,   57,   57,   57,   57,

        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,  160,   57,   57, -147
+       57,   57,   57,   57,   57,   57, -147
     },

     {
        11, -148, -148, -148, -148, -148, -148, -148, -148, -148,
      -148, -148, -148,   57, -148, -148,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,  161,   57,   57,   57, -148
+       57,   57,   57,  162,   57,   57, -148
     },

     {
        11, -149, -149, -149, -149, -149, -149, -149, -149, -149,
      -149, -149, -149,   57, -149, -149,   57,   57,   57,   57,
-       57,   57,   57,   57,  162,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57, -149
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,  163,   57,   57,   57, -149

     },

     {
        11, -150, -150, -150, -150, -150, -150, -150, -150, -150,
      -150, -150, -150,   57, -150, -150,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,  163,   57, -150
+       57,   57,   57,   57,  164,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -150
     },

     {
        11, -151, -151, -151, -151, -151, -151, -151, -151, -151,
      -151, -151, -151,   57, -151, -151,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,  164,   57,   57,
-       57,   57,   57,   57,   57,   57, -151
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,  165,   57, -151
     },

     {
        11, -152, -152, -152, -152, -152, -152, -152, -152, -152,
-     -152, -152, -152,   57, -152, -152,  165,   57,   57,   57,
+     -152, -152, -152,   57, -152, -152,   57,   57,   57,   57,

-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,  166,   57,   57,
        57,   57,   57,   57,   57,   57, -152
     },

     {
        11, -153, -153, -153, -153, -153, -153, -153, -153, -153,
      -153, -153, -153,   57, -153, -153,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,  167,   57,   57,
        57,   57,   57,   57,   57,   57, -153
     },

     {
        11, -154, -154, -154, -154, -154, -154, -154, -154, -154,
-     -154, -154, -154,   57, -154, -154,   57,   57,   57,   57,
-      166,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+     -154, -154, -154,   57, -154, -154,  168,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -154

     },
@@ -1447,7 +1447,7 @@
     {
        11, -156, -156, -156, -156, -156, -156, -156, -156, -156,
      -156, -156, -156,   57, -156, -156,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+      169,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -156
     },

@@ -1456,7 +1456,7 @@
      -157, -157, -157,   57, -157, -157,   57,   57,   57,   57,

        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,  167,   57,   57, -157
+       57,   57,   57,   57,   57,   57, -157
     },

     {
@@ -1470,7 +1470,7 @@
        11, -159, -159, -159, -159, -159, -159, -159, -159, -159,
      -159, -159, -159,   57, -159, -159,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57, -159
+       57,   57,   57,  170,   57,   57, -159

     },

@@ -1490,7 +1490,7 @@

     {
        11, -162, -162, -162, -162, -162, -162, -162, -162, -162,
-     -162, -162, -162,   57, -162, -162,   57,   57,  168,   57,
+     -162, -162, -162,   57, -162, -162,   57,   57,   57,   57,

        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -162
@@ -1505,16 +1505,16 @@

     {
        11, -164, -164, -164, -164, -164, -164, -164, -164, -164,
-     -164, -164, -164,   57, -164, -164,   57,   57,   57,   57,
+     -164, -164, -164,   57, -164, -164,   57,   57,  171,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,  169,   57, -164
+       57,   57,   57,   57,   57,   57, -164

     },

     {
        11, -165, -165, -165, -165, -165, -165, -165, -165, -165,
      -165, -165, -165,   57, -165, -165,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,  170,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -165
     },

@@ -1522,21 +1522,21 @@
        11, -166, -166, -166, -166, -166, -166, -166, -166, -166,
      -166, -166, -166,   57, -166, -166,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,  171,   57,   57,   57, -166
+       57,   57,   57,   57,  172,   57, -166
     },

     {
        11, -167, -167, -167, -167, -167, -167, -167, -167, -167,
      -167, -167, -167,   57, -167, -167,   57,   57,   57,   57,

-      172,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,  173,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -167
     },

     {
        11, -168, -168, -168, -168, -168, -168, -168, -168, -168,
      -168, -168, -168,   57, -168, -168,   57,   57,   57,   57,
-      173,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,  174,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -168
     },

@@ -1544,21 +1544,21 @@
        11, -169, -169, -169, -169, -169, -169, -169, -169, -169,
      -169, -169, -169,   57, -169, -169,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57, -169
+       57,   57,  175,   57,   57,   57, -169

     },

     {
        11, -170, -170, -170, -170, -170, -170, -170, -170, -170,
      -170, -170, -170,   57, -170, -170,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+      176,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -170
     },

     {
        11, -171, -171, -171, -171, -171, -171, -171, -171, -171,
      -171, -171, -171,   57, -171, -171,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+      177,   57,   57,   57,   57,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -171
     },

@@ -1573,10 +1573,55 @@
     {
        11, -173, -173, -173, -173, -173, -173, -173, -173, -173,
      -173, -173, -173,   57, -173, -173,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,  178,   57,   57,   57,   57,   57,
        57,   57,   57,   57,   57,   57, -173
     },

+    {
+       11, -174, -174, -174, -174, -174, -174, -174, -174, -174,
+     -174, -174, -174,   57, -174, -174,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -174
+
+    },
+
+    {
+       11, -175, -175, -175, -175, -175, -175, -175, -175, -175,
+     -175, -175, -175,   57, -175, -175,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -175
+    },
+
+    {
+       11, -176, -176, -176, -176, -176, -176, -176, -176, -176,
+     -176, -176, -176,   57, -176, -176,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -176
+    },
+
+    {
+       11, -177, -177, -177, -177, -177, -177, -177, -177, -177,
+     -177, -177, -177,   57, -177, -177,   57,   57,   57,   57,
+
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -177
+    },
+
+    {
+       11, -178, -178, -178, -178, -178, -178, -178, -178, -178,
+     -178, -178, -178,   57, -178, -178,   57,   57,   57,   57,
+       57,   57,  179,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -178
+    },
+
+    {
+       11, -179, -179, -179, -179, -179, -179, -179, -179, -179,
+     -179, -179, -179,   57, -179, -179,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
+       57,   57,   57,   57,   57,   57, -179
+
+    },
+
     } ;


@@ -1595,29 +1640,29 @@
 	*yy_cp = '\0'; \
 	yy_c_buf_p = yy_cp;

-#define YY_NUM_RULES 56
-#define YY_END_OF_BUFFER 57
-static yyconst short int yy_accept[174] =
+#define YY_NUM_RULES 57
+#define YY_END_OF_BUFFER 58
+static yyconst short int yy_accept[180] =
     {   0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-       57,    5,    4,    3,    2,   29,   30,   28,   28,   28,
-       28,   28,   28,   28,   28,   28,   28,   28,   28,   28,
-       55,   52,   54,   47,   51,   50,   49,   45,   41,   35,
-       40,   45,   33,   34,   43,   43,   36,   45,   43,   43,
-       45,    4,    3,    2,    2,    1,   28,   28,   28,   28,
-       28,   28,   28,   15,   28,   28,   28,   28,   28,   28,
-       28,   28,   28,   55,   52,   54,   53,   47,   46,   49,
-       48,   37,   31,   43,   43,   44,   38,   39,   32,   28,
-       28,   28,   28,   28,   28,   28,   28,   26,   25,   28,
-
-       28,   28,   28,   28,   28,   28,   28,   42,   23,   28,
-       28,   28,   28,   28,   28,   28,   28,   14,   28,    7,
-       28,   28,   28,   28,   28,   28,   28,   28,   28,   28,
-       28,   28,   28,   16,   28,   28,   28,   28,   28,   28,
-       28,   28,   28,   10,   28,   13,   28,   28,   28,   28,
-       28,   28,   21,   28,    9,   27,   28,   24,   12,   20,
-       17,   28,    8,   28,   28,   28,   28,   28,    6,   19,
-       18,   22,   11
+       58,    5,    4,    3,    2,   30,   31,   29,   29,   29,
+       29,   29,   29,   29,   29,   29,   29,   29,   29,   29,
+       56,   53,   55,   48,   52,   51,   50,   46,   42,   36,
+       41,   46,   34,   35,   44,   44,   37,   46,   44,   44,
+       46,    4,    3,    2,    2,    1,   29,   29,   29,   29,
+       29,   29,   29,   16,   29,   29,   29,   29,   29,   29,
+       29,   29,   29,   56,   53,   55,   54,   48,   47,   50,
+       49,   38,   32,   44,   44,   45,   39,   40,   33,   29,
+       29,   29,   29,   29,   29,   29,   29,   27,   26,   29,
+
+       29,   29,   29,   29,   29,   29,   29,   43,   24,   29,
+       29,   29,   29,   29,   29,   29,   29,   15,   29,    7,
+       29,   29,   29,   29,   29,   29,   29,   29,   29,   29,
+       29,   29,   29,   17,   29,   29,   29,   29,   29,   29,
+       29,   29,   29,   29,   10,   29,   13,   29,   29,   29,
+       29,   29,   29,   29,   22,   29,    9,   28,   29,   25,
+       12,   21,   18,   29,    8,   29,   29,   29,   29,   29,
+       29,    6,   29,   20,   19,   23,   11,   29,   14
     } ;

 static yyconst int yy_ec[256] =
@@ -1993,43 +2038,43 @@
 	YY_BREAK
 case 14:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_HELP;
+BEGIN(PARAM); return T_MENUCONFIG;
 	YY_BREAK
 case 15:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_IF;
+BEGIN(PARAM); return T_HELP;
 	YY_BREAK
 case 16:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_ENDIF;
+BEGIN(PARAM); return T_IF;
 	YY_BREAK
 case 17:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_DEPENDS;
+BEGIN(PARAM); return T_ENDIF;
 	YY_BREAK
 case 18:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_REQUIRES;
+BEGIN(PARAM); return T_DEPENDS;
 	YY_BREAK
 case 19:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_OPTIONAL;
+BEGIN(PARAM); return T_REQUIRES;
 	YY_BREAK
 case 20:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_DEFAULT;
+BEGIN(PARAM); return T_OPTIONAL;
 	YY_BREAK
 case 21:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_PROMPT;
+BEGIN(PARAM); return T_DEFAULT;
 	YY_BREAK
 case 22:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_TRISTATE;
+BEGIN(PARAM); return T_PROMPT;
 	YY_BREAK
 case 23:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_BOOLEAN;
+BEGIN(PARAM); return T_TRISTATE;
 	YY_BREAK
 case 24:
 YY_RULE_SETUP
@@ -2037,71 +2082,75 @@
 	YY_BREAK
 case 25:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_INT;
+BEGIN(PARAM); return T_BOOLEAN;
 	YY_BREAK
 case 26:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_HEX;
+BEGIN(PARAM); return T_INT;
 	YY_BREAK
 case 27:
 YY_RULE_SETUP
-BEGIN(PARAM); return T_STRING;
+BEGIN(PARAM); return T_HEX;
 	YY_BREAK
 case 28:
 YY_RULE_SETUP
+BEGIN(PARAM); return T_STRING;
+	YY_BREAK
+case 29:
+YY_RULE_SETUP
 {
 		alloc_string(yytext, yyleng);
 		zconflval.string = text;
 		return T_WORD;
 	}
 	YY_BREAK
-case 29:
+case 30:
 YY_RULE_SETUP

 	YY_BREAK
-case 30:
+case 31:
 YY_RULE_SETUP
 current_file->lineno++; BEGIN(INITIAL);
 	YY_BREAK


-case 31:
+case 32:
 YY_RULE_SETUP
 return T_AND;
 	YY_BREAK
-case 32:
+case 33:
 YY_RULE_SETUP
 return T_OR;
 	YY_BREAK
-case 33:
+case 34:
 YY_RULE_SETUP
 return T_OPEN_PAREN;
 	YY_BREAK
-case 34:
+case 35:
 YY_RULE_SETUP
 return T_CLOSE_PAREN;
 	YY_BREAK
-case 35:
+case 36:
 YY_RULE_SETUP
 return T_NOT;
 	YY_BREAK
-case 36:
+case 37:
 YY_RULE_SETUP
 return T_EQUAL;
 	YY_BREAK
-case 37:
+case 38:
 YY_RULE_SETUP
 return T_UNEQUAL;
 	YY_BREAK
-case 38:
+case 39:
 YY_RULE_SETUP
 return T_IF;
 	YY_BREAK
-case 39:
+case 40:
 YY_RULE_SETUP
 return T_ON;
 	YY_BREAK
-case 40:
+case 41:
 YY_RULE_SETUP
 {
 		str = yytext[0];
@@ -2109,15 +2158,15 @@
 		BEGIN(STRING);
 	}
 	YY_BREAK
-case 41:
+case 42:
 YY_RULE_SETUP
 BEGIN(INITIAL); current_file->lineno++; return T_EOL;
 	YY_BREAK
-case 42:
+case 43:
 YY_RULE_SETUP
 /* ignore */
 	YY_BREAK
-case 43:
+case 44:
 YY_RULE_SETUP
 {
 		alloc_string(yytext, yyleng);
@@ -2125,11 +2174,11 @@
 		return T_WORD;
 	}
 	YY_BREAK
-case 44:
+case 45:
 YY_RULE_SETUP
 current_file->lineno++;
 	YY_BREAK
-case 45:
+case 46:
 YY_RULE_SETUP

 	YY_BREAK
@@ -2140,7 +2189,7 @@
 	YY_BREAK


-case 46:
+case 47:
 *yy_cp = yy_hold_char; /* undo effects of setting up yytext */
 yy_c_buf_p = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up yytext again */
@@ -2151,13 +2200,13 @@
 		return T_WORD_QUOTE;
 	}
 	YY_BREAK
-case 47:
+case 48:
 YY_RULE_SETUP
 {
 		append_string(yytext, yyleng);
 	}
 	YY_BREAK
-case 48:
+case 49:
 *yy_cp = yy_hold_char; /* undo effects of setting up yytext */
 yy_c_buf_p = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up yytext again */
@@ -2168,13 +2217,13 @@
 		return T_WORD_QUOTE;
 	}
 	YY_BREAK
-case 49:
+case 50:
 YY_RULE_SETUP
 {
 		append_string(yytext + 1, yyleng - 1);
 	}
 	YY_BREAK
-case 50:
+case 51:
 YY_RULE_SETUP
 {
 		if (str == yytext[0]) {
@@ -2185,7 +2234,7 @@
 			append_string(yytext, 1);
 	}
 	YY_BREAK
-case 51:
+case 52:
 YY_RULE_SETUP
 {
 		printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
@@ -2201,7 +2250,7 @@
 	YY_BREAK


-case 52:
+case 53:
 YY_RULE_SETUP
 {
 		ts = 0;
@@ -2227,9 +2276,9 @@

 	}
 	YY_BREAK
-case 53:
+case 54:
 *yy_cp = yy_hold_char; /* undo effects of setting up yytext */
-yy_c_buf_p = yy_cp = yy_bp + 1;
+yy_c_buf_p = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up yytext again */
 YY_RULE_SETUP
 {
@@ -2238,14 +2287,14 @@
 		return T_HELPTEXT;
 	}
 	YY_BREAK
-case 54:
+case 55:
 YY_RULE_SETUP
 {
 		current_file->lineno++;
 		append_string("\n", 1);
 	}
 	YY_BREAK
-case 55:
+case 56:
 YY_RULE_SETUP
 {
 		append_string(yytext, yyleng);
@@ -2271,7 +2320,7 @@
 	yyterminate();
 }
 	YY_BREAK
-case 56:
+case 57:
 YY_RULE_SETUP
 YY_FATAL_ERROR( "flex scanner jammed" );
 	YY_BREAK
diff -ur linux.org/scripts/kconfig/mconf.c linux/scripts/kconfig/mconf.c
--- linux.org/scripts/kconfig/mconf.c	2002-12-16 03:07:50.000000000 +0100
+++ linux/scripts/kconfig/mconf.c	2003-01-03 19:08:27.000000000 +0100
@@ -303,7 +303,7 @@
 						menu->data ? "-->" : "++>",
 						indent + 1, ' ', prompt);
 				} else {
-					if (menu->parent != &rootmenu)
+					//if (menu->parent != &rootmenu)
 						cprint1("   %*c", indent + 1, ' ');
 					cprint1("%s  --->", prompt);
 				}
@@ -373,6 +373,11 @@
 		}
 		cprint_done();
 	} else {
+		if (menu == current_menu) {
+			cprint(":%p", menu);
+			cprint("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
+			goto conf_childs;
+		}
 		child_count++;
 		val = sym_get_tristate_value(sym);
 		if (sym_is_choice_value(sym) && val == yes) {
@@ -407,6 +412,11 @@
 		}
 		cprint1("%*c%s%s", indent + 1, ' ', menu_get_prompt(menu),
 			sym_has_value(sym) ? "" : " (NEW)");
+		if (menu->prompt->type == P_MENU) {
+			cprint1("  --->");
+			cprint_done();
+			return;
+		}
 		cprint_done();
 	}

@@ -445,9 +455,9 @@
 			cprint(":");
 			cprint("--- ");
 			cprint("L");
-			cprint("Load an Alternate Configuration File");
+			cprint("    Load an Alternate Configuration File");
 			cprint("S");
-			cprint("Save Configuration to an Alternate File");
+			cprint("    Save Configuration to an Alternate File");
 		}
 		stat = exec_conf();
 		if (stat < 0)
@@ -484,6 +494,8 @@
 			case 't':
 				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
 					conf_choice(submenu);
+				else if (submenu->prompt->type == P_MENU)
+					conf(submenu);
 				break;
 			case 's':
 				conf_string(submenu);
diff -ur linux.org/scripts/kconfig/zconf.l linux/scripts/kconfig/zconf.l
--- linux.org/scripts/kconfig/zconf.l	2002-12-16 03:08:13.000000000 +0100
+++ linux/scripts/kconfig/zconf.l	2003-01-03 19:08:27.000000000 +0100
@@ -96,6 +96,7 @@
 	"endchoice"		BEGIN(PARAM); return T_ENDCHOICE;
 	"comment"		BEGIN(PARAM); return T_COMMENT;
 	"config"		BEGIN(PARAM); return T_CONFIG;
+	"menuconfig"		BEGIN(PARAM); return T_MENUCONFIG;
 	"help"			BEGIN(PARAM); return T_HELP;
 	"if"			BEGIN(PARAM); return T_IF;
 	"endif"			BEGIN(PARAM); return T_ENDIF;
@@ -208,7 +209,7 @@
 		}

 	}
-	\n/[^ \t\n] {
+	[ \t]*\n/[^ \t\n] {
 		current_file->lineno++;
 		zconf_endhelp();
 		return T_HELPTEXT;
diff -ur linux.org/scripts/kconfig/zconf.tab.c_shipped linux/scripts/kconfig/zconf.tab.c_shipped
--- linux.org/scripts/kconfig/zconf.tab.c_shipped	2002-12-16 03:07:52.000000000 +0100
+++ linux/scripts/kconfig/zconf.tab.c_shipped	2003-01-03 19:08:27.000000000 +0100
@@ -67,32 +67,33 @@
      T_ENDCHOICE = 263,
      T_COMMENT = 264,
      T_CONFIG = 265,
-     T_HELP = 266,
-     T_HELPTEXT = 267,
-     T_IF = 268,
-     T_ENDIF = 269,
-     T_DEPENDS = 270,
-     T_REQUIRES = 271,
-     T_OPTIONAL = 272,
-     T_PROMPT = 273,
-     T_DEFAULT = 274,
-     T_TRISTATE = 275,
-     T_BOOLEAN = 276,
-     T_STRING = 277,
-     T_INT = 278,
-     T_HEX = 279,
-     T_WORD = 280,
-     T_WORD_QUOTE = 281,
-     T_UNEQUAL = 282,
-     T_EOF = 283,
-     T_EOL = 284,
-     T_CLOSE_PAREN = 285,
-     T_OPEN_PAREN = 286,
-     T_ON = 287,
-     T_OR = 288,
-     T_AND = 289,
-     T_EQUAL = 290,
-     T_NOT = 291
+     T_MENUCONFIG = 266,
+     T_HELP = 267,
+     T_HELPTEXT = 268,
+     T_IF = 269,
+     T_ENDIF = 270,
+     T_DEPENDS = 271,
+     T_REQUIRES = 272,
+     T_OPTIONAL = 273,
+     T_PROMPT = 274,
+     T_DEFAULT = 275,
+     T_TRISTATE = 276,
+     T_BOOLEAN = 277,
+     T_STRING = 278,
+     T_INT = 279,
+     T_HEX = 280,
+     T_WORD = 281,
+     T_WORD_QUOTE = 282,
+     T_UNEQUAL = 283,
+     T_EOF = 284,
+     T_EOL = 285,
+     T_CLOSE_PAREN = 286,
+     T_OPEN_PAREN = 287,
+     T_ON = 288,
+     T_OR = 289,
+     T_AND = 290,
+     T_EQUAL = 291,
+     T_NOT = 292
    };
 #endif
 #define T_MAINMENU 258
@@ -103,32 +104,33 @@
 #define T_ENDCHOICE 263
 #define T_COMMENT 264
 #define T_CONFIG 265
-#define T_HELP 266
-#define T_HELPTEXT 267
-#define T_IF 268
-#define T_ENDIF 269
-#define T_DEPENDS 270
-#define T_REQUIRES 271
-#define T_OPTIONAL 272
-#define T_PROMPT 273
-#define T_DEFAULT 274
-#define T_TRISTATE 275
-#define T_BOOLEAN 276
-#define T_STRING 277
-#define T_INT 278
-#define T_HEX 279
-#define T_WORD 280
-#define T_WORD_QUOTE 281
-#define T_UNEQUAL 282
-#define T_EOF 283
-#define T_EOL 284
-#define T_CLOSE_PAREN 285
-#define T_OPEN_PAREN 286
-#define T_ON 287
-#define T_OR 288
-#define T_AND 289
-#define T_EQUAL 290
-#define T_NOT 291
+#define T_MENUCONFIG 266
+#define T_HELP 267
+#define T_HELPTEXT 268
+#define T_IF 269
+#define T_ENDIF 270
+#define T_DEPENDS 271
+#define T_REQUIRES 272
+#define T_OPTIONAL 273
+#define T_PROMPT 274
+#define T_DEFAULT 275
+#define T_TRISTATE 276
+#define T_BOOLEAN 277
+#define T_STRING 278
+#define T_INT 279
+#define T_HEX 280
+#define T_WORD 281
+#define T_WORD_QUOTE 282
+#define T_UNEQUAL 283
+#define T_EOF 284
+#define T_EOL 285
+#define T_CLOSE_PAREN 286
+#define T_OPEN_PAREN 287
+#define T_ON 288
+#define T_OR 289
+#define T_AND 290
+#define T_EQUAL 291
+#define T_NOT 292



@@ -187,7 +189,7 @@
 	struct menu *menu;
 } yystype;
 /* Line 193 of /usr/share/bison/yacc.c.  */
-#line 191 "zconf.tab.c"
+#line 193 "zconf.tab.c"
 # define YYSTYPE yystype
 # define YYSTYPE_IS_TRIVIAL 1
 #endif
@@ -211,7 +213,7 @@


 /* Line 213 of /usr/share/bison/yacc.c.  */
-#line 215 "zconf.tab.c"
+#line 217 "zconf.tab.c"

 #if ! defined (yyoverflow) || YYERROR_VERBOSE

@@ -309,20 +311,20 @@

 /* YYFINAL -- State number of the termination state. */
 #define YYFINAL  2
-#define YYLAST   154
+#define YYLAST   160

 /* YYNTOKENS -- Number of terminals. */
-#define YYNTOKENS  37
+#define YYNTOKENS  38
 /* YYNNTS -- Number of nonterminals. */
-#define YYNNTS  39
+#define YYNNTS  41
 /* YYNRULES -- Number of rules. */
-#define YYNRULES  96
+#define YYNRULES  99
 /* YYNRULES -- Number of states. */
-#define YYNSTATES  146
+#define YYNSTATES  152

 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   291
+#define YYMAXUTOK   292

 #define YYTRANSLATE(X) \
   ((unsigned)(X) <= YYMAXUTOK ? yytranslate[X] : YYUNDEFTOK)
@@ -359,7 +361,7 @@
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
       25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35,    36
+      35,    36,    37
 };

 #if YYDEBUG
@@ -368,63 +370,64 @@
 static const unsigned short yyprhs[] =
 {
        0,     0,     3,     4,     7,     9,    11,    13,    17,    19,
-      21,    23,    26,    28,    30,    32,    34,    36,    39,    43,
-      44,    48,    52,    55,    58,    61,    64,    67,    70,    73,
-      77,    81,    83,    87,    89,    94,    97,    98,   102,   106,
-     109,   112,   116,   118,   122,   123,   126,   129,   131,   137,
-     141,   142,   145,   148,   151,   154,   158,   160,   165,   168,
-     169,   172,   175,   178,   182,   185,   188,   191,   195,   198,
-     201,   202,   206,   209,   213,   216,   219,   220,   222,   226,
-     228,   230,   232,   234,   236,   238,   240,   241,   244,   246,
-     250,   254,   258,   261,   265,   269,   271
+      21,    23,    26,    28,    30,    32,    34,    36,    38,    41,
+      45,    48,    52,    53,    57,    61,    64,    67,    70,    73,
+      76,    79,    82,    86,    90,    92,    96,    98,   103,   106,
+     107,   111,   115,   118,   121,   125,   127,   131,   132,   135,
+     138,   140,   146,   150,   151,   154,   157,   160,   163,   167,
+     169,   174,   177,   178,   181,   184,   187,   191,   194,   197,
+     200,   204,   207,   210,   211,   215,   218,   222,   225,   228,
+     229,   231,   235,   237,   239,   241,   243,   245,   247,   249,
+     250,   253,   255,   259,   263,   267,   270,   274,   278,   280
 };

 /* YYRHS -- A `-1'-separated list of the rules' RHS. */
 static const yysigned_char yyrhs[] =
 {
-      38,     0,    -1,    -1,    38,    39,    -1,    40,    -1,    48,
-      -1,    59,    -1,     3,    70,    72,    -1,     5,    -1,    14,
-      -1,     8,    -1,     1,    72,    -1,    54,    -1,    64,    -1,
-      42,    -1,    62,    -1,    72,    -1,    10,    25,    -1,    41,
-      29,    43,    -1,    -1,    43,    44,    29,    -1,    43,    68,
-      29,    -1,    43,    66,    -1,    43,    29,    -1,    20,    69,
-      -1,    21,    69,    -1,    23,    69,    -1,    24,    69,    -1,
-      22,    69,    -1,    18,    70,    73,    -1,    19,    75,    73,
-      -1,     7,    -1,    45,    29,    49,    -1,    71,    -1,    46,
-      51,    47,    29,    -1,    46,    51,    -1,    -1,    49,    50,
-      29,    -1,    49,    68,    29,    -1,    49,    66,    -1,    49,
-      29,    -1,    18,    70,    73,    -1,    17,    -1,    19,    75,
-      73,    -1,    -1,    51,    40,    -1,    13,    74,    -1,    71,
-      -1,    52,    29,    55,    53,    29,    -1,    52,    29,    55,
-      -1,    -1,    55,    40,    -1,    55,    59,    -1,    55,    48,
-      -1,     4,    70,    -1,    56,    29,    67,    -1,    71,    -1,
-      57,    60,    58,    29,    -1,    57,    60,    -1,    -1,    60,
-      40,    -1,    60,    59,    -1,    60,    48,    -1,    60,     1,
-      29,    -1,     6,    70,    -1,    61,    29,    -1,     9,    70,
-      -1,    63,    29,    67,    -1,    11,    29,    -1,    65,    12,
-      -1,    -1,    67,    68,    29,    -1,    67,    29,    -1,    15,
-      32,    74,    -1,    15,    74,    -1,    16,    74,    -1,    -1,
-      70,    -1,    70,    13,    74,    -1,    25,    -1,    26,    -1,
-       5,    -1,     8,    -1,    14,    -1,    29,    -1,    28,    -1,
-      -1,    13,    74,    -1,    75,    -1,    75,    35,    75,    -1,
-      75,    27,    75,    -1,    31,    74,    30,    -1,    36,    74,
-      -1,    74,    33,    74,    -1,    74,    34,    74,    -1,    25,
-      -1,    26,    -1
+      39,     0,    -1,    -1,    39,    40,    -1,    41,    -1,    51,
+      -1,    62,    -1,     3,    73,    75,    -1,     5,    -1,    15,
+      -1,     8,    -1,     1,    75,    -1,    57,    -1,    67,    -1,
+      43,    -1,    45,    -1,    65,    -1,    75,    -1,    10,    26,
+      -1,    42,    30,    46,    -1,    11,    26,    -1,    44,    30,
+      46,    -1,    -1,    46,    47,    30,    -1,    46,    71,    30,
+      -1,    46,    69,    -1,    46,    30,    -1,    21,    72,    -1,
+      22,    72,    -1,    24,    72,    -1,    25,    72,    -1,    23,
+      72,    -1,    19,    73,    76,    -1,    20,    78,    76,    -1,
+       7,    -1,    48,    30,    52,    -1,    74,    -1,    49,    54,
+      50,    30,    -1,    49,    54,    -1,    -1,    52,    53,    30,
+      -1,    52,    71,    30,    -1,    52,    69,    -1,    52,    30,
+      -1,    19,    73,    76,    -1,    18,    -1,    20,    78,    76,
+      -1,    -1,    54,    41,    -1,    14,    77,    -1,    74,    -1,
+      55,    30,    58,    56,    30,    -1,    55,    30,    58,    -1,
+      -1,    58,    41,    -1,    58,    62,    -1,    58,    51,    -1,
+       4,    73,    -1,    59,    30,    70,    -1,    74,    -1,    60,
+      63,    61,    30,    -1,    60,    63,    -1,    -1,    63,    41,
+      -1,    63,    62,    -1,    63,    51,    -1,    63,     1,    30,
+      -1,     6,    73,    -1,    64,    30,    -1,     9,    73,    -1,
+      66,    30,    70,    -1,    12,    30,    -1,    68,    13,    -1,
+      -1,    70,    71,    30,    -1,    70,    30,    -1,    16,    33,
+      77,    -1,    16,    77,    -1,    17,    77,    -1,    -1,    73,
+      -1,    73,    14,    77,    -1,    26,    -1,    27,    -1,     5,
+      -1,     8,    -1,    15,    -1,    30,    -1,    29,    -1,    -1,
+      14,    77,    -1,    78,    -1,    78,    36,    78,    -1,    78,
+      28,    78,    -1,    32,    77,    31,    -1,    37,    77,    -1,
+      77,    34,    77,    -1,    77,    35,    77,    -1,    26,    -1,
+      27,    -1
 };

 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const unsigned short yyrline[] =
 {
-       0,    89,    89,    90,    93,    94,    95,    96,    97,    98,
-      99,   100,   103,   105,   106,   107,   108,   114,   122,   128,
-     130,   131,   132,   133,   136,   142,   148,   154,   160,   166,
-     172,   180,   189,   195,   203,   205,   211,   213,   214,   215,
-     216,   219,   225,   231,   237,   239,   244,   253,   261,   263,
-     269,   271,   272,   273,   278,   285,   291,   299,   301,   307,
-     309,   310,   311,   312,   315,   321,   328,   335,   342,   348,
-     355,   356,   357,   360,   365,   370,   378,   380,   384,   389,
-     390,   393,   394,   395,   398,   399,   401,   402,   405,   406,
-     407,   408,   409,   410,   411,   414,   415
+       0,    90,    90,    91,    94,    95,    96,    97,    98,    99,
+     100,   101,   104,   106,   107,   108,   109,   110,   116,   124,
+     130,   138,   148,   150,   151,   152,   153,   156,   162,   168,
+     174,   180,   186,   192,   200,   209,   215,   223,   225,   231,
+     233,   234,   235,   236,   239,   245,   251,   257,   259,   264,
+     273,   281,   283,   289,   291,   292,   293,   298,   305,   311,
+     319,   321,   327,   329,   330,   331,   332,   335,   341,   348,
+     355,   362,   368,   375,   376,   377,   380,   385,   390,   398,
+     400,   404,   409,   410,   413,   414,   415,   418,   419,   421,
+     422,   425,   426,   427,   428,   429,   430,   431,   434,   435
 };
 #endif

@@ -435,19 +438,19 @@
 {
   "$end", "error", "$undefined", "T_MAINMENU", "T_MENU", "T_ENDMENU",
   "T_SOURCE", "T_CHOICE", "T_ENDCHOICE", "T_COMMENT", "T_CONFIG",
-  "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS", "T_REQUIRES",
-  "T_OPTIONAL", "T_PROMPT", "T_DEFAULT", "T_TRISTATE", "T_BOOLEAN",
-  "T_STRING", "T_INT", "T_HEX", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL",
-  "T_EOF", "T_EOL", "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_ON", "T_OR",
-  "T_AND", "T_EQUAL", "T_NOT", "$accept", "input", "block",
+  "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
+  "T_REQUIRES", "T_OPTIONAL", "T_PROMPT", "T_DEFAULT", "T_TRISTATE",
+  "T_BOOLEAN", "T_STRING", "T_INT", "T_HEX", "T_WORD", "T_WORD_QUOTE",
+  "T_UNEQUAL", "T_EOF", "T_EOL", "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_ON",
+  "T_OR", "T_AND", "T_EQUAL", "T_NOT", "$accept", "input", "block",
   "common_block", "config_entry_start", "config_stmt",
-  "config_option_list", "config_option", "choice", "choice_entry",
-  "choice_end", "choice_stmt", "choice_option_list", "choice_option",
-  "choice_block", "if", "if_end", "if_stmt", "if_block", "menu",
-  "menu_entry", "menu_end", "menu_stmt", "menu_block", "source",
-  "source_stmt", "comment", "comment_stmt", "help_start", "help",
-  "depends_list", "depends", "prompt_stmt_opt", "prompt", "end",
-  "nl_or_eof", "if_expr", "expr", "symbol", 0
+  "menuconfig_entry_start", "menuconfig_stmt", "config_option_list",
+  "config_option", "choice", "choice_entry", "choice_end", "choice_stmt",
+  "choice_option_list", "choice_option", "choice_block", "if", "if_end",
+  "if_stmt", "if_block", "menu", "menu_entry", "menu_end", "menu_stmt",
+  "menu_block", "source", "source_stmt", "comment", "comment_stmt",
+  "help_start", "help", "depends_list", "depends", "prompt_stmt_opt",
+  "prompt", "end", "nl_or_eof", "if_expr", "expr", "symbol", 0
 };
 #endif

@@ -459,38 +462,38 @@
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290,   291
+     285,   286,   287,   288,   289,   290,   291,   292
 };
 # endif

 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const unsigned char yyr1[] =
 {
-       0,    37,    38,    38,    39,    39,    39,    39,    39,    39,
-      39,    39,    40,    40,    40,    40,    40,    41,    42,    43,
-      43,    43,    43,    43,    44,    44,    44,    44,    44,    44,
-      44,    45,    46,    47,    48,    48,    49,    49,    49,    49,
-      49,    50,    50,    50,    51,    51,    52,    53,    54,    54,
-      55,    55,    55,    55,    56,    57,    58,    59,    59,    60,
-      60,    60,    60,    60,    61,    62,    63,    64,    65,    66,
-      67,    67,    67,    68,    68,    68,    69,    69,    69,    70,
-      70,    71,    71,    71,    72,    72,    73,    73,    74,    74,
-      74,    74,    74,    74,    74,    75,    75
+       0,    38,    39,    39,    40,    40,    40,    40,    40,    40,
+      40,    40,    41,    41,    41,    41,    41,    41,    42,    43,
+      44,    45,    46,    46,    46,    46,    46,    47,    47,    47,
+      47,    47,    47,    47,    48,    49,    50,    51,    51,    52,
+      52,    52,    52,    52,    53,    53,    53,    54,    54,    55,
+      56,    57,    57,    58,    58,    58,    58,    59,    60,    61,
+      62,    62,    63,    63,    63,    63,    63,    64,    65,    66,
+      67,    68,    69,    70,    70,    70,    71,    71,    71,    72,
+      72,    72,    73,    73,    74,    74,    74,    75,    75,    76,
+      76,    77,    77,    77,    77,    77,    77,    77,    78,    78
 };

 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
 static const unsigned char yyr2[] =
 {
        0,     2,     0,     2,     1,     1,     1,     3,     1,     1,
-       1,     2,     1,     1,     1,     1,     1,     2,     3,     0,
-       3,     3,     2,     2,     2,     2,     2,     2,     2,     3,
-       3,     1,     3,     1,     4,     2,     0,     3,     3,     2,
-       2,     3,     1,     3,     0,     2,     2,     1,     5,     3,
-       0,     2,     2,     2,     2,     3,     1,     4,     2,     0,
-       2,     2,     2,     3,     2,     2,     2,     3,     2,     2,
-       0,     3,     2,     3,     2,     2,     0,     1,     3,     1,
-       1,     1,     1,     1,     1,     1,     0,     2,     1,     3,
-       3,     3,     2,     3,     3,     1,     1
+       1,     2,     1,     1,     1,     1,     1,     1,     2,     3,
+       2,     3,     0,     3,     3,     2,     2,     2,     2,     2,
+       2,     2,     3,     3,     1,     3,     1,     4,     2,     0,
+       3,     3,     2,     2,     3,     1,     3,     0,     2,     2,
+       1,     5,     3,     0,     2,     2,     2,     2,     3,     1,
+       4,     2,     0,     2,     2,     2,     3,     2,     2,     2,
+       3,     2,     2,     0,     3,     2,     3,     2,     2,     0,
+       1,     3,     1,     1,     1,     1,     1,     1,     1,     0,
+       2,     1,     3,     3,     3,     2,     3,     3,     1,     1
 };

 /* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
@@ -498,127 +501,134 @@
    means the default is an error.  */
 static const unsigned char yydefact[] =
 {
-       2,     0,     1,     0,     0,     0,     8,     0,    31,    10,
-       0,     0,     0,     9,    85,    84,     3,     4,     0,    14,
-       0,    44,     5,     0,    12,     0,    59,     6,     0,    15,
-       0,    13,    16,    11,    79,    80,     0,    54,    64,    66,
-      17,    95,    96,     0,     0,    46,    88,    19,    36,    35,
-      50,    70,     0,    65,    70,     7,     0,    92,     0,     0,
-       0,     0,    18,    32,    81,    82,    83,    45,     0,    33,
-      49,    55,     0,    60,    62,     0,    61,    56,    67,    91,
-      93,    94,    90,    89,     0,     0,     0,     0,     0,    76,
-      76,    76,    76,    76,    23,     0,     0,    22,     0,    42,
-       0,     0,    40,     0,    39,     0,    34,    51,    53,     0,
-      52,    47,    72,     0,    63,    57,    68,     0,    74,    75,
-      86,    86,    24,    77,    25,    28,    26,    27,    20,    69,
-      21,    86,    86,    37,    38,    48,    71,    73,     0,    29,
-      30,     0,    41,    43,    87,    78
+       2,     0,     1,     0,     0,     0,     8,     0,    34,    10,
+       0,     0,     0,     0,     9,    88,    87,     3,     4,     0,
+      14,     0,    15,     0,    47,     5,     0,    12,     0,    62,
+       6,     0,    16,     0,    13,    17,    11,    82,    83,     0,
+      57,    67,    69,    18,    20,    98,    99,     0,     0,    49,
+      91,    22,    22,    39,    38,    53,    73,     0,    68,    73,
+       7,     0,    95,     0,     0,     0,     0,    19,    21,    35,
+      84,    85,    86,    48,     0,    36,    52,    58,     0,    63,
+      65,     0,    64,    59,    70,    94,    96,    97,    93,    92,
+       0,     0,     0,     0,     0,    79,    79,    79,    79,    79,
+      26,     0,     0,    25,     0,    45,     0,     0,    43,     0,
+      42,     0,    37,    54,    56,     0,    55,    50,    75,     0,
+      66,    60,    71,     0,    77,    78,    89,    89,    27,    80,
+      28,    31,    29,    30,    23,    72,    24,    89,    89,    40,
+      41,    51,    74,    76,     0,    32,    33,     0,    44,    46,
+      90,    81
 };

 /* YYDEFGOTO[NTERM-NUM]. */
 static const short yydefgoto[] =
 {
-      -1,     1,    16,    17,    18,    19,    62,    95,    20,    21,
-      68,    22,    63,   103,    49,    23,   109,    24,    70,    25,
-      26,    75,    27,    52,    28,    29,    30,    31,    96,    97,
-      71,   113,   122,   123,    69,    32,   139,    45,    46
+      -1,     1,    17,    18,    19,    20,    21,    22,    67,   101,
+      23,    24,    74,    25,    69,   109,    54,    26,   115,    27,
+      76,    28,    29,    81,    30,    57,    31,    32,    33,    34,
+     102,   103,    77,   104,   128,   129,    75,    35,   145,    49,
+      50
 };

 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -120
+#define YYPACT_NINF -121
 static const short yypact[] =
 {
-    -120,    17,  -120,    32,    71,    71,  -120,    71,  -120,  -120,
-      71,    11,    99,  -120,  -120,  -120,  -120,  -120,    12,  -120,
-      22,  -120,  -120,    35,  -120,    52,  -120,  -120,    56,  -120,
-      60,  -120,  -120,  -120,  -120,  -120,    32,  -120,  -120,  -120,
-    -120,  -120,  -120,    99,    99,    83,    38,  -120,  -120,    74,
-    -120,  -120,    49,  -120,  -120,  -120,    98,  -120,    99,    99,
-     101,   101,    89,   104,  -120,  -120,  -120,  -120,    65,  -120,
-      62,    77,    72,  -120,  -120,    85,  -120,  -120,    77,  -120,
-      95,  -120,  -120,  -120,   105,     8,    99,    71,   101,    71,
-      71,    71,    71,    71,  -120,   113,   131,  -120,   115,  -120,
-      71,   101,  -120,   116,  -120,   117,  -120,  -120,  -120,   118,
-    -120,  -120,  -120,   119,  -120,  -120,  -120,    99,    83,    83,
-     136,   136,  -120,   137,  -120,  -120,  -120,  -120,  -120,  -120,
-    -120,   136,   136,  -120,  -120,  -120,  -120,    83,    99,  -120,
-    -120,    99,  -120,  -120,    83,    83
+    -121,    25,  -121,   -18,   -11,   -11,  -121,   -11,  -121,  -121,
+     -11,    21,    27,   112,  -121,  -121,  -121,  -121,  -121,    51,
+    -121,    54,  -121,    57,  -121,  -121,    58,  -121,    62,  -121,
+    -121,    80,  -121,    96,  -121,  -121,  -121,  -121,  -121,   -18,
+    -121,  -121,  -121,  -121,  -121,  -121,  -121,   112,   112,    17,
+      77,  -121,  -121,  -121,    85,  -121,  -121,    56,  -121,  -121,
+    -121,   -21,  -121,   112,   112,    42,    42,   100,   100,   115,
+    -121,  -121,  -121,  -121,    98,  -121,    68,    28,    99,  -121,
+    -121,   111,  -121,  -121,    28,  -121,   105,  -121,  -121,  -121,
+     116,   110,   112,   -11,    42,   -11,   -11,   -11,   -11,   -11,
+    -121,   118,   137,  -121,   121,  -121,   -11,    42,  -121,   122,
+    -121,   123,  -121,  -121,  -121,   124,  -121,  -121,  -121,   125,
+    -121,  -121,  -121,   112,    17,    17,   142,   142,  -121,   143,
+    -121,  -121,  -121,  -121,  -121,  -121,  -121,   142,   142,  -121,
+    -121,  -121,  -121,    17,   112,  -121,  -121,   112,  -121,  -121,
+      17,    17
 };

 /* YYPGOTO[NTERM-NUM].  */
 static const yysigned_char yypgoto[] =
 {
-    -120,  -120,  -120,   -38,  -120,  -120,  -120,  -120,  -120,  -120,
-    -120,   -42,  -120,  -120,  -120,  -120,  -120,  -120,  -120,  -120,
-    -120,  -120,   -33,  -120,  -120,  -120,  -120,  -120,  -120,    88,
-     100,    78,    46,    -1,   -23,     2,  -119,   -43,   -53
+    -121,  -121,  -121,   -35,  -121,  -121,  -121,  -121,   106,  -121,
+    -121,  -121,  -121,   -34,  -121,  -121,  -121,  -121,  -121,  -121,
+    -121,  -121,  -121,  -121,   -33,  -121,  -121,  -121,  -121,  -121,
+    -121,    90,   101,    34,    10,    -4,   -30,    -1,  -120,   -43,
+     -57
 };

 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
    positive, shift that token.  If negative, reduce the rule which
    number is the opposite.  If zero, do what YYDEFACT says.
    If YYTABLE_NINF, parse error.  */
-#define YYTABLE_NINF -59
+#define YYTABLE_NINF -62
 static const short yytable[] =
 {
-      56,    57,   140,    36,    37,    33,    38,    82,    83,    39,
-      74,    67,   142,   143,    73,    80,    81,     2,     3,    76,
-       4,     5,     6,     7,     8,     9,    10,    11,   108,    77,
-      12,    13,   107,    41,    42,   121,    40,   110,    55,    43,
-     117,    47,   118,   119,    44,    14,    15,   111,   132,   -58,
-      72,    48,   -58,     5,    64,     7,     8,    65,    10,    11,
-      14,    15,    12,    66,    50,    60,     5,    64,     7,     8,
-      65,    10,    11,    61,   137,    12,    66,    14,    15,    64,
-       7,    51,    65,    10,    11,    53,   120,    12,    66,    54,
-      14,    15,    85,    86,   106,   144,    34,    35,   145,   131,
-      84,   114,    14,    15,    85,    86,   112,    87,    88,    89,
-      90,    91,    92,    93,   115,    84,    58,    59,    94,    85,
-      86,    99,   100,   101,    41,    42,    41,    42,    79,    59,
-      43,    58,    59,   102,   116,    44,   124,   125,   126,   127,
-      98,   105,   128,   129,   130,   133,   134,   135,   136,   138,
-     141,   104,     0,     0,    78
+      39,    40,    36,    41,    61,    62,    42,   146,    88,    89,
+      85,    15,    16,    63,    64,    37,    38,   148,   149,    73,
+      86,    87,    79,    80,    82,     2,     3,    83,     4,     5,
+       6,     7,     8,     9,    10,    11,    12,   127,    60,    13,
+      14,   113,   114,   116,    91,    92,   117,    43,   124,   125,
+     138,    63,    64,    44,    15,    16,   -61,    78,   118,   -61,
+       5,    70,     7,     8,    71,    10,    11,    12,    45,    46,
+      13,    72,     5,    70,     7,     8,    71,    10,    11,    12,
+     143,    51,    13,    72,    52,    15,    16,    53,    55,   126,
+      70,     7,    56,    71,    10,    11,    12,    15,    16,    13,
+      72,   150,   137,   111,   151,    65,   130,   131,   132,   133,
+      58,   119,    90,    66,    15,    16,    91,    92,   119,    93,
+      94,    95,    96,    97,    98,    99,    59,    90,   112,   120,
+     100,    91,    92,   105,   106,   107,    45,    46,    45,    46,
+      64,   121,    47,   123,    47,   108,   122,    48,   134,    48,
+     135,   136,   139,   140,   141,   142,   144,   147,    68,   110,
+      84
 };

-static const short yycheck[] =
+static const unsigned char yycheck[] =
 {
-      43,    44,   121,     4,     5,     3,     7,    60,    61,    10,
-      52,    49,   131,   132,    52,    58,    59,     0,     1,    52,
-       3,     4,     5,     6,     7,     8,     9,    10,    70,    52,
-      13,    14,    70,    25,    26,    88,    25,    70,    36,    31,
-      32,    29,    85,    86,    36,    28,    29,    70,   101,     0,
-       1,    29,     3,     4,     5,     6,     7,     8,     9,    10,
-      28,    29,    13,    14,    29,    27,     4,     5,     6,     7,
-       8,     9,    10,    35,   117,    13,    14,    28,    29,     5,
-       6,    29,     8,     9,    10,    29,    87,    13,    14,    29,
-      28,    29,    15,    16,    29,   138,    25,    26,   141,   100,
-      11,    29,    28,    29,    15,    16,    29,    18,    19,    20,
-      21,    22,    23,    24,    29,    11,    33,    34,    29,    15,
-      16,    17,    18,    19,    25,    26,    25,    26,    30,    34,
-      31,    33,    34,    29,    29,    36,    90,    91,    92,    93,
-      62,    63,    29,    12,    29,    29,    29,    29,    29,    13,
-      13,    63,    -1,    -1,    54
+       4,     5,     3,     7,    47,    48,    10,   127,    65,    66,
+      31,    29,    30,    34,    35,    26,    27,   137,   138,    54,
+      63,    64,    57,    57,    57,     0,     1,    57,     3,     4,
+       5,     6,     7,     8,     9,    10,    11,    94,    39,    14,
+      15,    76,    76,    76,    16,    17,    76,    26,    91,    92,
+     107,    34,    35,    26,    29,    30,     0,     1,    30,     3,
+       4,     5,     6,     7,     8,     9,    10,    11,    26,    27,
+      14,    15,     4,     5,     6,     7,     8,     9,    10,    11,
+     123,    30,    14,    15,    30,    29,    30,    30,    30,    93,
+       5,     6,    30,     8,     9,    10,    11,    29,    30,    14,
+      15,   144,   106,    69,   147,    28,    96,    97,    98,    99,
+      30,    77,    12,    36,    29,    30,    16,    17,    84,    19,
+      20,    21,    22,    23,    24,    25,    30,    12,    30,    30,
+      30,    16,    17,    18,    19,    20,    26,    27,    26,    27,
+      35,    30,    32,    33,    32,    30,    30,    37,    30,    37,
+      13,    30,    30,    30,    30,    30,    14,    14,    52,    69,
+      59
 };

 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const unsigned char yystos[] =
 {
-       0,    38,     0,     1,     3,     4,     5,     6,     7,     8,
-       9,    10,    13,    14,    28,    29,    39,    40,    41,    42,
-      45,    46,    48,    52,    54,    56,    57,    59,    61,    62,
-      63,    64,    72,    72,    25,    26,    70,    70,    70,    70,
-      25,    25,    26,    31,    36,    74,    75,    29,    29,    51,
-      29,    29,    60,    29,    29,    72,    74,    74,    33,    34,
-      27,    35,    43,    49,     5,     8,    14,    40,    47,    71,
-      55,    67,     1,    40,    48,    58,    59,    71,    67,    30,
-      74,    74,    75,    75,    11,    15,    16,    18,    19,    20,
-      21,    22,    23,    24,    29,    44,    65,    66,    68,    17,
-      18,    19,    29,    50,    66,    68,    29,    40,    48,    53,
-      59,    71,    29,    68,    29,    29,    29,    32,    74,    74,
-      70,    75,    69,    70,    69,    69,    69,    69,    29,    12,
-      29,    70,    75,    29,    29,    29,    29,    74,    13,    73,
-      73,    13,    73,    73,    74,    74
+       0,    39,     0,     1,     3,     4,     5,     6,     7,     8,
+       9,    10,    11,    14,    15,    29,    30,    40,    41,    42,
+      43,    44,    45,    48,    49,    51,    55,    57,    59,    60,
+      62,    64,    65,    66,    67,    75,    75,    26,    27,    73,
+      73,    73,    73,    26,    26,    26,    27,    32,    37,    77,
+      78,    30,    30,    30,    54,    30,    30,    63,    30,    30,
+      75,    77,    77,    34,    35,    28,    36,    46,    46,    52,
+       5,     8,    15,    41,    50,    74,    58,    70,     1,    41,
+      51,    61,    62,    74,    70,    31,    77,    77,    78,    78,
+      12,    16,    17,    19,    20,    21,    22,    23,    24,    25,
+      30,    47,    68,    69,    71,    18,    19,    20,    30,    53,
+      69,    71,    30,    41,    51,    56,    62,    74,    30,    71,
+      30,    30,    30,    33,    77,    77,    73,    78,    72,    73,
+      72,    72,    72,    72,    30,    13,    30,    73,    78,    30,
+      30,    30,    30,    77,    14,    76,    76,    14,    76,    76,
+      77,    77
 };

 #if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
@@ -1184,7 +1194,7 @@
     { zconfprint("syntax error"); yyerrok; }
     break;

-  case 17:
+  case 18:
     {
 	struct symbol *sym = sym_lookup(yyvsp[0].string, 0);
 	sym->flags |= SYMBOL_OPTIONAL;
@@ -1193,67 +1203,87 @@
 }
     break;

-  case 18:
+  case 19:
     {
 	menu_end_entry();
 	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 23:
+  case 20:
+    {
+	struct symbol *sym = sym_lookup(yyvsp[0].string, 0);
+	sym->flags |= SYMBOL_OPTIONAL;
+	menu_add_entry(sym);
+	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), yyvsp[0].string);
+}
+    break;
+
+  case 21:
+    {
+	if (current_entry->prompt)
+		current_entry->prompt->type = P_MENU;
+	else
+		zconfprint("warning: menuconfig statement without prompt");
+	menu_end_entry();
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+}
+    break;
+
+  case 26:
     { }
     break;

-  case 24:
+  case 27:
     {
 	menu_set_type(S_TRISTATE);
 	printd(DEBUG_PARSE, "%s:%d:tristate\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 25:
+  case 28:
     {
 	menu_set_type(S_BOOLEAN);
 	printd(DEBUG_PARSE, "%s:%d:boolean\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 26:
+  case 29:
     {
 	menu_set_type(S_INT);
 	printd(DEBUG_PARSE, "%s:%d:int\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 27:
+  case 30:
     {
 	menu_set_type(S_HEX);
 	printd(DEBUG_PARSE, "%s:%d:hex\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 28:
+  case 31:
     {
 	menu_set_type(S_STRING);
 	printd(DEBUG_PARSE, "%s:%d:string\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 29:
+  case 32:
     {
 	menu_add_prop(P_PROMPT, yyvsp[-1].string, NULL, yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 30:
+  case 33:
     {
 	menu_add_prop(P_DEFAULT, NULL, yyvsp[-1].symbol, yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:default\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 31:
+  case 34:
     {
 	struct symbol *sym = sym_lookup(NULL, 0);
 	sym->flags |= SYMBOL_CHOICE;
@@ -1263,14 +1293,14 @@
 }
     break;

-  case 32:
+  case 35:
     {
 	menu_end_entry();
 	menu_add_menu();
 }
     break;

-  case 33:
+  case 36:
     {
 	if (zconf_endtoken(yyvsp[0].token, T_CHOICE, T_ENDCHOICE)) {
 		menu_end_menu();
@@ -1279,35 +1309,35 @@
 }
     break;

-  case 35:
+  case 38:
     {
 	printf("%s:%d: missing 'endchoice' for this 'choice' statement\n", current_menu->file->name, current_menu->lineno);
 	zconfnerrs++;
 }
     break;

-  case 41:
+  case 44:
     {
 	menu_add_prop(P_PROMPT, yyvsp[-1].string, NULL, yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 42:
+  case 45:
     {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
 	printd(DEBUG_PARSE, "%s:%d:optional\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 43:
+  case 46:
     {
 	menu_add_prop(P_DEFAULT, NULL, yyvsp[-1].symbol, yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:default\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 46:
+  case 49:
     {
 	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
 	menu_add_entry(NULL);
@@ -1317,7 +1347,7 @@
 }
     break;

-  case 47:
+  case 50:
     {
 	if (zconf_endtoken(yyvsp[0].token, T_IF, T_ENDIF)) {
 		menu_end_menu();
@@ -1326,14 +1356,14 @@
 }
     break;

-  case 49:
+  case 52:
     {
 	printf("%s:%d: missing 'endif' for this 'if' statement\n", current_menu->file->name, current_menu->lineno);
 	zconfnerrs++;
 }
     break;

-  case 54:
+  case 57:
     {
 	menu_add_entry(NULL);
 	menu_add_prop(P_MENU, yyvsp[0].string, NULL, NULL);
@@ -1341,14 +1371,14 @@
 }
     break;

-  case 55:
+  case 58:
     {
 	menu_end_entry();
 	menu_add_menu();
 }
     break;

-  case 56:
+  case 59:
     {
 	if (zconf_endtoken(yyvsp[0].token, T_MENU, T_ENDMENU)) {
 		menu_end_menu();
@@ -1357,31 +1387,31 @@
 }
     break;

-  case 58:
+  case 61:
     {
 	printf("%s:%d: missing 'endmenu' for this 'menu' statement\n", current_menu->file->name, current_menu->lineno);
 	zconfnerrs++;
 }
     break;

-  case 63:
+  case 66:
     { zconfprint("invalid menu option"); yyerrok; }
     break;

-  case 64:
+  case 67:
     {
 	yyval.string = yyvsp[0].string;
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), yyvsp[0].string);
 }
     break;

-  case 65:
+  case 68:
     {
 	zconf_nextfile(yyvsp[-1].string);
 }
     break;

-  case 66:
+  case 69:
     {
 	menu_add_entry(NULL);
 	menu_add_prop(P_COMMENT, yyvsp[0].string, NULL, NULL);
@@ -1389,115 +1419,115 @@
 }
     break;

-  case 67:
+  case 70:
     {
 	menu_end_entry();
 }
     break;

-  case 68:
+  case 71:
     {
 	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
 	zconf_starthelp();
 }
     break;

-  case 69:
+  case 72:
     {
 	current_entry->sym->help = yyvsp[0].string;
 }
     break;

-  case 72:
+  case 75:
     { }
     break;

-  case 73:
+  case 76:
     {
 	menu_add_dep(yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 74:
+  case 77:
     {
 	menu_add_dep(yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:depends\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 75:
+  case 78:
     {
 	menu_add_dep(yyvsp[0].expr);
 	printd(DEBUG_PARSE, "%s:%d:requires\n", zconf_curname(), zconf_lineno());
 }
     break;

-  case 77:
+  case 80:
     {
 	menu_add_prop(P_PROMPT, yyvsp[0].string, NULL, NULL);
 }
     break;

-  case 78:
+  case 81:
     {
 	menu_add_prop(P_PROMPT, yyvsp[-2].string, NULL, yyvsp[0].expr);
 }
     break;

-  case 81:
+  case 84:
     { yyval.token = T_ENDMENU; }
     break;

-  case 82:
+  case 85:
     { yyval.token = T_ENDCHOICE; }
     break;

-  case 83:
+  case 86:
     { yyval.token = T_ENDIF; }
     break;

-  case 86:
+  case 89:
     { yyval.expr = NULL; }
     break;

-  case 87:
+  case 90:
     { yyval.expr = yyvsp[0].expr; }
     break;

-  case 88:
+  case 91:
     { yyval.expr = expr_alloc_symbol(yyvsp[0].symbol); }
     break;

-  case 89:
+  case 92:
     { yyval.expr = expr_alloc_comp(E_EQUAL, yyvsp[-2].symbol, yyvsp[0].symbol); }
     break;

-  case 90:
+  case 93:
     { yyval.expr = expr_alloc_comp(E_UNEQUAL, yyvsp[-2].symbol, yyvsp[0].symbol); }
     break;

-  case 91:
+  case 94:
     { yyval.expr = yyvsp[-1].expr; }
     break;

-  case 92:
+  case 95:
     { yyval.expr = expr_alloc_one(E_NOT, yyvsp[0].expr); }
     break;

-  case 93:
+  case 96:
     { yyval.expr = expr_alloc_two(E_OR, yyvsp[-2].expr, yyvsp[0].expr); }
     break;

-  case 94:
+  case 97:
     { yyval.expr = expr_alloc_two(E_AND, yyvsp[-2].expr, yyvsp[0].expr); }
     break;

-  case 95:
+  case 98:
     { yyval.symbol = sym_lookup(yyvsp[0].string, 0); free(yyvsp[0].string); }
     break;

-  case 96:
+  case 99:
     { yyval.symbol = sym_lookup(yyvsp[0].string, 1); free(yyvsp[0].string); }
     break;

@@ -1505,7 +1535,7 @@
     }

 /* Line 1016 of /usr/share/bison/yacc.c.  */
-#line 1509 "zconf.tab.c"
+#line 1539 "zconf.tab.c"

   yyvsp -= yylen;
   yyssp -= yylen;
diff -ur linux.org/scripts/kconfig/zconf.y linux/scripts/kconfig/zconf.y
--- linux.org/scripts/kconfig/zconf.y	2002-12-16 03:08:18.000000000 +0100
+++ linux/scripts/kconfig/zconf.y	2003-01-03 19:08:27.000000000 +0100
@@ -27,7 +27,7 @@

 #define YYERROR_VERBOSE
 %}
-%expect 36
+%expect 40

 %union
 {
@@ -46,6 +46,7 @@
 %token T_ENDCHOICE
 %token T_COMMENT
 %token T_CONFIG
+%token T_MENUCONFIG
 %token T_HELP
 %token <string> T_HELPTEXT
 %token T_IF
@@ -104,12 +105,13 @@
 	  if_stmt
 	| comment_stmt
 	| config_stmt
+	| menuconfig_stmt
 	| source_stmt
 	| nl_or_eof
 ;


-/* config entry */
+/* config/menuconfig entry */

 config_entry_start: T_CONFIG T_WORD
 {
@@ -125,6 +127,24 @@
 	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
 };

+menuconfig_entry_start: T_MENUCONFIG T_WORD
+{
+	struct symbol *sym = sym_lookup($2, 0);
+	sym->flags |= SYMBOL_OPTIONAL;
+	menu_add_entry(sym);
+	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), $2);
+};
+
+menuconfig_stmt: menuconfig_entry_start T_EOL config_option_list
+{
+	if (current_entry->prompt)
+		current_entry->prompt->type = P_MENU;
+	else
+		zconfprint("warning: menuconfig statement without prompt");
+	menu_end_entry();
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+};
+
 config_option_list:
 	  /* empty */
 	| config_option_list config_option T_EOL


