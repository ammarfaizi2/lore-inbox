Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTDGDyN (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTDGDyN (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:54:13 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:49793 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263253AbTDGDyG (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:54:06 -0400
Date: Mon, 7 Apr 2003 13:03:44 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.66-ac2] PC-9800 sub architecture support (9/9) SCSI
Message-ID: <20030407040344.GI4840@yuzuki.cinet.co.jp>
References: <20030407033627.GA4798@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407033627.GA4798@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.66-ac2. (9/9)

SCSI host adapter support.
 - Override BIOS parameter for PC98.

I rewrite this patch. Function for PC-98 BIOS parameter is called from each
low level drivers. How about this patch. We need PC-98's BIOS parameter to
create bootable partition. Please apply.

Regards,
Osamu Tomita

diff -Nru linux-2.5.66-bk10/drivers/scsi/advansys.h linux98-2.5.66-bk10/drivers/scsi/advansys.h
--- linux-2.5.66-bk10/drivers/scsi/advansys.h	2003-03-25 07:01:48.000000000 +0900
+++ linux98-2.5.66-bk10/drivers/scsi/advansys.h	2003-04-05 18:52:32.000000000 +0900
@@ -71,6 +71,13 @@
  * AdvanSys Host Driver Scsi_Host_Template (struct SHT) from hosts.h.
  */
 #if ASC_LINUX_KERNEL24
+#ifdef CONFIG_X86_PC9800
+extern int pc98_bios_param(struct scsi_device *, struct block_device *,
+				sector_t, int *);
+#define ADVANSYS_BIOSPARAM pc98_bios_param
+#else
+#define ADVANSYS_BIOSPARAM advansys_biosparam
+#endif
 #define ADVANSYS { \
     .proc_name                  = "advansys", \
     .proc_info                  = advansys_proc_info, \
@@ -80,7 +87,7 @@
     .info                       = advansys_info, \
     .queuecommand               = advansys_queuecommand, \
     .eh_bus_reset_handler	= advansys_reset, \
-    .bios_param                 = advansys_biosparam, \
+    .bios_param                 = ADVANSYS_BIOSPARAM, \
     .slave_configure		= advansys_slave_configure, \
     /* \
      * Because the driver may control an ISA adapter 'unchecked_isa_dma' \
diff -Nru linux-2.5.66-bk10/drivers/scsi/aic7xxx/aic7xxx_osm.c linux98-2.5.66-bk10/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.5.66-bk10/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-04-04 22:45:00.000000000 +0900
+++ linux98-2.5.66-bk10/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-04-05 18:56:11.000000000 +0900
@@ -1265,6 +1265,9 @@
 	return SUCCESS;
 }
 
+extern int pc98_bios_param(struct scsi_device *, struct block_device *,
+				sector_t, int *);
+
 Scsi_Host_Template aic7xxx_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= "aic7xxx",
@@ -1275,8 +1278,12 @@
 	.eh_device_reset_handler = ahc_linux_dev_reset,
 	.eh_bus_reset_handler	= ahc_linux_bus_reset,
 #if defined(__i386__)
+#ifdef CONFIG_X86_PC9800
+	.bios_param		= pc98_bios_param,
+#else
 	.bios_param		= ahc_linux_biosparam,
 #endif
+#endif
 	.can_queue		= AHC_MAX_QUEUE,
 	.this_id		= -1,
 	.sg_tablesize		= AHC_NSEG,
diff -Nru linux-2.5.66-bk10/drivers/scsi/sym53c8xx_2/sym53c8xx.h linux98-2.5.66-bk10/drivers/scsi/sym53c8xx_2/sym53c8xx.h
--- linux-2.5.66-bk10/drivers/scsi/sym53c8xx_2/sym53c8xx.h	2003-03-25 07:01:49.000000000 +0900
+++ linux98-2.5.66-bk10/drivers/scsi/sym53c8xx_2/sym53c8xx.h	2003-04-05 18:59:21.000000000 +0900
@@ -105,23 +105,32 @@
 
 #include <scsi/scsicam.h>
 
+#ifdef CONFIG_X86_PC9800
+extern int pc98_bios_param(struct scsi_device *, struct block_device *,
+				sector_t, int *);
+#define SYM53C8XX_BIOSPARAM pc98_bios_param
+#else
+#define SYM53C8XX_BIOSPARAM NULL
+#endif
+
 #define SYM53C8XX {							\
-	name:			"sym53c8xx",				\
-	detect:			sym53c8xx_detect,			\
-	release:		sym53c8xx_release,			\
-	info:			sym53c8xx_info, 			\
-	queuecommand:		sym53c8xx_queue_command,		\
-	slave_configure:	sym53c8xx_slave_configure,		\
-	eh_abort_handler:	sym53c8xx_eh_abort_handler,		\
-	eh_device_reset_handler:sym53c8xx_eh_device_reset_handler,	\
-	eh_bus_reset_handler:	sym53c8xx_eh_bus_reset_handler,		\
-	eh_host_reset_handler:	sym53c8xx_eh_host_reset_handler,	\
-	can_queue:		0,					\
-	this_id:		7,					\
-	sg_tablesize:		0,					\
-	cmd_per_lun:		0,					\
-	use_clustering:		DISABLE_CLUSTERING,			\
-	highmem_io:		1}
+	.name			= "sym53c8xx",				\
+	.detect			= sym53c8xx_detect,			\
+	.release		= sym53c8xx_release,			\
+	.info			= sym53c8xx_info, 			\
+	.queuecommand		= sym53c8xx_queue_command,		\
+	.slave_configure	= sym53c8xx_slave_configure,		\
+	.eh_abort_handler	= sym53c8xx_eh_abort_handler,		\
+	.eh_device_reset_handler = sym53c8xx_eh_device_reset_handler,	\
+	.eh_bus_reset_handler	= sym53c8xx_eh_bus_reset_handler,	\
+	.eh_host_reset_handler	= sym53c8xx_eh_host_reset_handler,	\
+	.bios_param		= SYM53C8XX_BIOSPARAM,			\
+	.can_queue		= 0,					\
+	.this_id		= 7,					\
+	.sg_tablesize		= 0,					\
+	.cmd_per_lun		= 0,					\
+	.use_clustering		= DISABLE_CLUSTERING,			\
+	.highmem_io		= 1}
 
 #endif /* defined(HOSTS_C) || defined(MODULE) */ 
 
