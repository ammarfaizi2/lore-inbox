Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbTLGXAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 18:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbTLGXAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 18:00:24 -0500
Received: from CPE0080c6f0a1ca-CM014280009361.cpe.net.cable.rogers.com ([24.157.199.55]:5380
	"EHLO stargazer") by vger.kernel.org with ESMTP id S264562AbTLGW77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 17:59:59 -0500
Date: Sun, 7 Dec 2003 18:00:49 -0500
From: Glenn Wurster <gwurster@scs.carleton.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-dma.c, kernel 2.4.23
Message-ID: <20031207230049.GA1079@desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Greetings.

Attached is a small patch to fix a serious Oops bug in the IDE/DMA
drivers.  It has been written against 2.4.23.  The problem stems from
a null function pointer which is called during configuration of the
IDE controller.  The function pointer is NULL iff DMA is not available
for the drive, so the problem will not be seen on DMA capable IDE
controllers.

I am not subscribed, so please CC me on any followup e-mails.  If you
need more information or wish changes to the patch, you can contact me
directly.  Furthermore, if another patch to fix the same problem has
already been discussed, I would be glad to test it if someone forwards
me a copy.

I can be reached at gwurster@scs.carleton.ca

The patch has been tested against both systems I own, both x86.  One
with a DMA capable IDE controller, the other one (which caused the
oops) without.

Glenn Wurster

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=README

Glenn Wurster (gwurster@scs.carleton.ca)
Avoid NULL function pointer reference on IDE controllers without DMA support.

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dma.patch"

diff -Naur linux-2.4.23/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.4.23/drivers/ide/ide-dma.c	Mon Aug 25 11:44:41 2003
+++ linux/drivers/ide/ide-dma.c	Sun Dec  7 04:21:33 2003
@@ -566,6 +566,20 @@
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
+
+/**
  *	__ide_dma_host_off	-	Generic DMA kill
  *	@drive: drive to control
  *
@@ -1214,3 +1228,19 @@
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
+
+/*
+ * For IDE interfaces that do not support DMA, we still need to
+ * initialize some pointers to dummy functions.
+ */
+void ide_setup_no_dma (ide_hwif_t *hwif)
+{
+	if (!hwif->ide_dma_off_quietly)
+		hwif->ide_dma_off_quietly = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+	if (!hwif->ide_dma_host_off)
+		hwif->ide_dma_host_off = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+	if (!hwif->ide_dma_host_on)
+		hwif->ide_dma_host_on = (int (*)(ide_drive_t *))&__ide_dma_no_op;
+}
+
+EXPORT_SYMBOL_GPL(ide_setup_no_dma);
diff -Naur linux-2.4.23/drivers/ide/setup-pci.c linux/drivers/ide/setup-pci.c
--- linux-2.4.23/drivers/ide/setup-pci.c	Mon Aug 25 11:44:41 2003
+++ linux/drivers/ide/setup-pci.c	Fri Dec  5 07:10:50 2003
@@ -507,6 +507,7 @@
 		} else {
 			printk(KERN_INFO "%s: %s Bus-Master DMA disabled "
 				"(BIOS)\n", hwif->name, d->name);
+			ide_setup_no_dma(hwif);
 		}
 	}
 }
diff -Naur linux-2.4.23/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.4.23/include/linux/ide.h	Fri Nov 28 18:26:21 2003
+++ linux/include/linux/ide.h	Fri Dec  5 06:43:46 2003
@@ -1692,7 +1692,10 @@
 extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
+extern void ide_setup_no_dma(ide_hwif_t *);
+extern void ide_setup_dma_off(ide_hwif_t *);
 
+extern int __ide_dma_no_op(void);
 extern int __ide_dma_host_off(ide_drive_t *);
 extern int __ide_dma_off_quietly(ide_drive_t *);
 extern int __ide_dma_off(ide_drive_t *);
@@ -1713,6 +1716,7 @@
 extern int __ide_dma_timeout(ide_drive_t *);
 #else
 static inline void ide_setup_dma(ide_hwif_t *x, unsigned long y, unsigned int z) {;}
+static inline void ide_setup_no_dma(ide_hwif_t *x) {;}
 static inline void ide_release_dma(ide_hwif_t *x) {;}
 #endif
 

--BXVAT5kNtrzKuDFl--
