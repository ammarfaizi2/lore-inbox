Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWANGqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWANGqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWANGqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:46:08 -0500
Received: from xenotime.net ([66.160.160.81]:19605 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932773AbWANGqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:46:07 -0500
Date: Fri, 13 Jan 2006 22:42:52 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-Id: <20060113224252.38d8890f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add ata_acpi in Makefile and Kconfig.
Add ACPI obj_handle.
Add ata_acpi.c to libata kernel-doc template file.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 Documentation/DocBook/libata.tmpl |    6 ++++++
 drivers/scsi/Kconfig              |    5 +++++
 drivers/scsi/Makefile             |    3 +++
 include/linux/libata.h            |    6 ++++++
 4 files changed, 20 insertions(+)

--- linux-2615-g9.orig/drivers/scsi/Makefile
+++ linux-2615-g9/drivers/scsi/Makefile
@@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
 libata-objs	:= libata-core.o libata-scsi.o
+ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
+  libata-objs	+= libata-acpi.o
+endif
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
--- linux-2615-g9.orig/drivers/scsi/Kconfig
+++ linux-2615-g9/drivers/scsi/Kconfig
@@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
 	default y
 
+config SCSI_SATA_ACPI
+	bool
+	depends on SCSI_SATA && ACPI
+	default y
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API
--- linux-2615-g9.orig/include/linux/libata.h
+++ linux-2615-g9/include/linux/libata.h
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <linux/ata.h>
 #include <linux/workqueue.h>
+#include <acpi/acpi.h>
 
 /*
  * compile-time options
@@ -315,6 +316,11 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+#ifdef CONFIG_SCSI_SATA_ACPI
+	/* ACPI objects info */
+	acpi_handle		obj_handle;
+#endif
 };
 
 struct ata_port {
--- linux-2615-g9.orig/Documentation/DocBook/libata.tmpl
+++ linux-2615-g9/Documentation/DocBook/libata.tmpl
@@ -787,6 +787,12 @@ and other resources, etc.
 !Idrivers/scsi/libata-scsi.c
   </chapter>
 
+  <chapter id="libataAcpi">
+     <title>libata ACPI interfaces/methods</title>
+!Edrivers/scsi/ata_acpi.c
+!Idrivers/scsi/ata_acpi.c
+  </chapter>
+
   <chapter id="ataExceptions">
      <title>ATA errors &amp; exceptions</title>
 


---
