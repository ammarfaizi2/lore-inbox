Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967191AbWKYVZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967191AbWKYVZO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967199AbWKYVZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:25:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:18883 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S967191AbWKYVZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:25:12 -0500
X-Originating-Ip: 72.57.81.197
Date: Sat, 25 Nov 2006 16:22:00 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MPT:  make all Fusion MPT sub-choices singly selectable
In-Reply-To: <20061125121210.52c66f55.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0611251617590.25621@localhost.localdomain>
References: <Pine.LNX.4.64.0611250627200.20370@localhost.localdomain>
 <20061125121210.52c66f55.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.985, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_40 -0.18)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  based on randy's earlier email, here's an updated model for a patch
that adds a couple selectors to the Device Drivers menu, one for a
boolean MPT, and the other for a tristate MTD.  it *seems* to work.
(one improvement that *could* be made would be to also edit the MTD
sub-Kconfig files and remove their "depends on MTD" clauses since they
wouldn't be necessary anymore.  but it might be safer to leave those
alone just in case someone decides to source those files from
elsewhere some day.)

  again ... thoughts?

rday

diff --git a/drivers/message/fusion/Kconfig b/drivers/message/fusion/Kconfig
index ea31d84..0e4045c 100644
--- a/drivers/message/fusion/Kconfig
+++ b/drivers/message/fusion/Kconfig
@@ -1,14 +1,12 @@
-
-menu "Fusion MPT device support"
-
-config FUSION
-	bool
+menuconfig FUSION
+	bool "Fusion MPT device support"
 	default n

+if FUSION
+
 config FUSION_SPI
 	tristate "Fusion MPT ScsiHost drivers for SPI"
 	depends on PCI && SCSI
-	select FUSION
 	select SCSI_SPI_ATTRS
 	---help---
 	  SCSI HOST support for a parallel SCSI host adapters.
@@ -23,7 +21,6 @@ config FUSION_SPI
 config FUSION_FC
 	tristate "Fusion MPT ScsiHost drivers for FC"
 	depends on PCI && SCSI
-	select FUSION
 	select SCSI_FC_ATTRS
 	---help---
 	  SCSI HOST support for a Fiber Channel host adapters.
@@ -40,7 +37,6 @@ config FUSION_FC
 config FUSION_SAS
 	tristate "Fusion MPT ScsiHost drivers for SAS"
 	depends on PCI && SCSI
- 	select FUSION
 	select SCSI_SAS_ATTRS
 	---help---
 	  SCSI HOST support for a SAS host adapters.
@@ -54,7 +50,6 @@ config FUSION_SAS

 config FUSION_MAX_SGE
 	int "Maximum number of scatter gather entries (16 - 128)"
-	depends on FUSION
 	default "128"
 	range 16 128
 	help
@@ -100,4 +95,4 @@ config FUSION_LAN

 	  If unsure whether you really want or need this, say N.

-endmenu
+endif
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index a304b34..dab619b 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,9 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $

-menu "Memory Technology Devices (MTD)"
-
-config MTD
-	tristate "Memory Technology Device (MTD) support"
+menuconfig MTD
+	tristate "Memory Technology Devices (MTD)"
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
@@ -13,9 +11,10 @@ config MTD
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
@@ -29,7 +28,6 @@ config MTD_DEBUG_VERBOSE

 config MTD_CONCAT
 	tristate "MTD concatenating support"
-	depends on MTD
 	help
 	  Support for concatenating several MTD devices into a single
 	  (virtual) one. This allows you to have -for example- a JFFS(2)
@@ -38,7 +36,6 @@ config MTD_CONCAT

 config MTD_PARTITIONS
 	bool "MTD partitioning support"
-	depends on MTD
 	help
 	  If you have a device which needs to divide its flash chip(s) up
 	  into multiple 'partitions', each of which appears to the user as
@@ -153,11 +150,9 @@ config MTD_AFS_PARTS
 	  'armflash' map driver (CONFIG_MTD_ARMFLASH) does this, for example.

 comment "User Modules And Translation Layers"
-	depends on MTD

 config MTD_CHAR
 	tristate "Direct char device access to MTD devices"
-	depends on MTD
 	help
 	  This provides a character device for each MTD device present in
 	  the system, allowing the user to read and write directly to the
@@ -166,7 +161,7 @@ config MTD_CHAR

 config MTD_BLOCK
 	tristate "Caching block device access to MTD devices"
-	depends on MTD && BLOCK
+	depends on BLOCK
 	---help---
 	  Although most flash chips have an erase size too large to be useful
 	  as block devices, it is possible to use MTD devices which are based
@@ -199,7 +194,7 @@ config MTD_BLOCK_RO

 config FTL
 	tristate "FTL (Flash Translation Layer) support"
-	depends on MTD && BLOCK
+	depends on BLOCK
 	---help---
 	  This provides support for the original Flash Translation Layer which
 	  is part of the PCMCIA specification. It uses a kind of pseudo-
@@ -215,7 +210,7 @@ config FTL

 config NFTL
 	tristate "NFTL (NAND Flash Translation Layer) support"
-	depends on MTD && BLOCK
+	depends on BLOCK
 	---help---
 	  This provides support for the NAND Flash Translation Layer which is
 	  used on M-Systems' DiskOnChip devices. It uses a kind of pseudo-
@@ -238,7 +233,7 @@ config NFTL_RW

 config INFTL
 	tristate "INFTL (Inverse NAND Flash Translation Layer) support"
-	depends on MTD && BLOCK
+	depends on BLOCK
 	---help---
 	  This provides support for the Inverse NAND Flash Translation
 	  Layer which is used on M-Systems' newer DiskOnChip devices. It
@@ -255,7 +250,7 @@ config INFTL

 config RFD_FTL
         tristate "Resident Flash Disk (Flash Translation Layer) support"
-	depends on MTD && BLOCK
+	depends on BLOCK
 	---help---
 	  This provides support for the flash translation layer known
 	  as the Resident Flash Disk (RFD), as used by the Embedded BIOS
@@ -265,7 +260,6 @@ config RFD_FTL

 config SSFDC
 	tristate "NAND SSFDC (SmartMedia) read only translation layer"
-	depends on MTD
 	default n
 	help
 	  This enables read only access to SmartMedia formatted NAND
@@ -281,5 +275,5 @@ source "drivers/mtd/nand/Kconfig"

 source "drivers/mtd/onenand/Kconfig"

-endmenu
+endif

