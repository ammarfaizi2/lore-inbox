Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUAWS35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUAWS35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:29:57 -0500
Received: from CPE0080c6f0a1ca-CM014280009361.cpe.net.cable.rogers.com ([24.157.199.55]:12804
	"EHLO stargazer") by vger.kernel.org with ESMTP id S266630AbUAWS3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:29:48 -0500
Date: Fri, 23 Jan 2004 13:32:45 -0500
From: Glenn Wurster <gwurster@scs.carleton.ca>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, andre@linux-ide.org
Subject: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Message-ID: <20040123183245.GB853@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brief Synopsis:

IDE initialization on non-DMA controllers causes OOPS during boot
due to dereference of null function pointers.

Description:

This patch fixes an issue where null function pointers associated with
DMA are called during initialization of IDE hard drive controllers
(causing a kernel OOPS on boot).  The problem only occurs on
controllers which do not support DMA.  It has been tested successfuly
against a non-DMA IDE controller on x86.

I am not subscribed, so please CC me on any followup e-mails.

Glenn.

diff -Naur linux-2.4.24/drivers/ide/ide-dma.c linux-2.4.24-patched/drivers/ide/ide-dma.c
--- linux-2.4.24/drivers/ide/ide-dma.c	2003-08-25 11:44:41.000000000 +0000
+++ linux-2.4.24-patched/drivers/ide/ide-dma.c	2004-01-23 03:23:08.000000000 +0000
@@ -566,6 +566,33 @@
 }
 
 /**
+ *  __ide_dma_no_op  - Empty DMA function.
+ *
+ *  Empty DMA function for controllers that do not support DMA.
+ */
+
+int __ide_dma_no_op (void)
+{
+	return 0;
+}
+
+EXPORT_SYMBOL(__ide_dma_no_op);
+
+/**
+ *  __ide_dma_unsupported - Warning function for DMA operation.
+ *
+ *  Warning function for DMA operation on unsupported hardware.
+ */
+
+int __ide_dma_unsupported (ide_hwif_t *hwif)
+{
+	printk(KERN_WARNING "DMA not supported by %s\n", hwif->name );
+	return 1;
+}
+
+EXPORT_SYMBOL(__ide_dma_unsupported);
+
+/**
  *	__ide_dma_host_off	-	Generic DMA kill
  *	@drive: drive to control
  *
@@ -1214,3 +1241,17 @@
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
+
+/*
+ * For IDE interfaces that do not support DMA, we still need to
+ * initialize some pointers to dummy functions during initialization.
+ */
+void default_hwif_dmaops (ide_hwif_t *hwif)
+{
+	hwif->ide_dma_on = __ide_dma_unsupported;
+	hwif->ide_dma_off_quietly = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+	hwif->ide_dma_host_off = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+	hwif->ide_dma_host_on = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+}
+
+EXPORT_SYMBOL_GPL(default_hwif_dmaops);
diff -Naur linux-2.4.24/drivers/ide/ide.c linux-2.4.24-patched/drivers/ide/ide.c
--- linux-2.4.24/drivers/ide/ide.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.24-patched/drivers/ide/ide.c	2004-01-23 03:32:24.000000000 +0000
@@ -251,6 +251,7 @@
 	hwif->sata = 0;			/* assume PATA */
 
 	default_hwif_iops(hwif);
+	default_hwif_dmaops(hwif);
 	default_hwif_transport(hwif);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
diff -Naur linux-2.4.24/include/linux/ide.h linux-2.4.24-patched/include/linux/ide.h
--- linux-2.4.24/include/linux/ide.h	2003-11-28 18:26:21.000000000 +0000
+++ linux-2.4.24-patched/include/linux/ide.h	2004-01-23 03:24:08.000000000 +0000
@@ -1691,8 +1691,12 @@
 extern void ide_destroy_dmatable(ide_drive_t *);
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
+extern void default_hwif_dmaops(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
+extern void ide_setup_dma_off(ide_hwif_t *);
 
+extern int __ide_dma_no_op(void);
+extern int __ide_dma_unsupported(ide_hwif_t *);
 extern int __ide_dma_host_off(ide_drive_t *);
 extern int __ide_dma_off_quietly(ide_drive_t *);
 extern int __ide_dma_off(ide_drive_t *);
@@ -1712,6 +1716,7 @@
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #else
+static inline void default_hwif_dmaops(ide_hwif_t *x) {;}
 static inline void ide_setup_dma(ide_hwif_t *x, unsigned long y, unsigned int z) {;}
 static inline void ide_release_dma(ide_hwif_t *x) {;}
 #endif
