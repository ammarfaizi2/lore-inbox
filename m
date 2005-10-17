Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVJQEqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVJQEqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 00:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVJQEqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 00:46:11 -0400
Received: from havoc.gtf.org ([69.61.125.42]:58572 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932174AbVJQEqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 00:46:10 -0400
Date: Mon, 17 Oct 2005 00:46:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
Subject: [PATCH] libata: fix broken Kconfig setup
Message-ID: <20051017044606.GA1266@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch described in commit faa725332f39329288f52b7f872ffda866ba5b09
>   [PATCH] SCSI_SATA has to be a tristate

causes the PCI quirk in drivers/pci/quirk.c (quirk_intel_ide_combined)
to disappear, unless CONFIG_SCSI_SATA==y.  This, in turn, causes all
manner of booting and interaction problems between the IDE driver and
libata.

CONFIG_SCSI_SATA is truly a boolean option, not a tristate.
Since the Kconfig dependencies are insufficient to describe this (2.4
had dep_mbool), we need to resort to 'if'.

This fix is twofold:
1) Fix IDE/libata conflict by ensuring that CONFIG_SCSI_SATA symbol
   always exists (rather than bothering with CONFIG_SCSI_SATA_MODULE).
2) Restore CONFIG_SCSI_SATA's rightful boolean status, and employ
   'if' to obtain the proper menu behavior.

Please apply, so that people cursed with PATA/SATA "combined mode"
can have a working configuration again.


diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -437,7 +437,7 @@ config SCSI_IN2000
 source "drivers/scsi/megaraid/Kconfig.megaraid"
 
 config SCSI_SATA
-	tristate "Serial ATA (SATA) support"
+	bool "Serial ATA (SATA) support"
 	depends on SCSI
 	help
 	  This driver family supports Serial ATA host controllers
@@ -445,9 +445,11 @@ config SCSI_SATA
 
 	  If unsure, say N.
 
+if SCSI_SATA
+
 config SCSI_SATA_AHCI
 	tristate "AHCI SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for AHCI Serial ATA.
 
@@ -455,7 +457,7 @@ config SCSI_SATA_AHCI
 
 config SCSI_SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Broadcom/Serverworks/Apple K2
 	  SATA support.
@@ -464,7 +466,7 @@ config SCSI_SATA_SVW
 
 config SCSI_ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for ICH5 Serial ATA.
 	  If PATA support was enabled previously, this enables
@@ -474,7 +476,7 @@ config SCSI_ATA_PIIX
 
 config SCSI_SATA_MV
 	tristate "Marvell SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] chips.
@@ -483,7 +485,7 @@ config SCSI_SATA_MV
 
 config SCSI_SATA_NV
 	tristate "NVIDIA SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for NVIDIA Serial ATA.
 
@@ -491,7 +493,7 @@ config SCSI_SATA_NV
 
 config SCSI_SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Promise Serial ATA TX2/TX4.
 
@@ -499,7 +501,7 @@ config SCSI_SATA_PROMISE
 
 config SCSI_SATA_QSTOR
 	tristate "Pacific Digital SATA QStor support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Pacific Digital Serial ATA QStor.
 
@@ -507,7 +509,7 @@ config SCSI_SATA_QSTOR
 
 config SCSI_SATA_SX4
 	tristate "Promise SATA SX4 support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
@@ -515,7 +517,7 @@ config SCSI_SATA_SX4
 
 config SCSI_SATA_SIL
 	tristate "Silicon Image SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
@@ -523,7 +525,7 @@ config SCSI_SATA_SIL
 
 config SCSI_SATA_SIS
 	tristate "SiS 964/180 SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for SiS Serial ATA 964/180.
 
@@ -531,7 +533,7 @@ config SCSI_SATA_SIS
 
 config SCSI_SATA_ULI
 	tristate "ULi Electronics SATA support"
-	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	depends on SCSI && PCI && EXPERIMENTAL
 	help
 	  This option enables support for ULi Electronics SATA.
 
@@ -539,7 +541,7 @@ config SCSI_SATA_ULI
 
 config SCSI_SATA_VIA
 	tristate "VIA SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for VIA Serial ATA.
 
@@ -547,12 +549,14 @@ config SCSI_SATA_VIA
 
 config SCSI_SATA_VITESSE
 	tristate "VITESSE VSC-7174 SATA support"
-	depends on SCSI_SATA && PCI
+	depends on SCSI && PCI
 	help
 	  This option enables support for Vitesse VSC7174 Serial ATA.
 
 	  If unsure, say N.
 
+endif	# if SCSI_SATA
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
