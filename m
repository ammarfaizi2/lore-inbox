Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbTIKQBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTIKQBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:01:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7809 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261348AbTIKQBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:01:32 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] update umc8672 driver
Date: Thu, 11 Sep 2003 18:03:15 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111803.15761.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update umc8672 driver

- common umc8672_init() for built-in and module
- release hwif only if hwif->chipset == ide_umc8672
- mark exit functions with __exit
- do not use ide_hwifs[] directly
- minor cleanups

 drivers/ide/ide.c            |    4 -
 drivers/ide/legacy/umc8672.c |  106 +++++++++++++++++--------------------------
 2 files changed, 45 insertions(+), 65 deletions(-)

diff -puN drivers/ide/legacy/umc8672.c~ide-umc8672-update drivers/ide/legacy/umc8672.c
--- linux-2.6.0-test5-bk1/drivers/ide/legacy/umc8672.c~ide-umc8672-update	2003-09-10 21:43:06.000000000 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/legacy/umc8672.c	2003-09-11 17:58:24.936182080 +0200
@@ -124,16 +124,16 @@ static void tune_umc (ide_drive_t *drive
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
-int __init probe_umc8672 (void)
+static int __init umc8672_probe(void)
 {
 	unsigned long flags;
+	ide_hwif_t *hwif, *mate;
 
-	local_irq_save(flags);
 	if (!request_region(0x108, 2, "umc8672")) {
-		local_irq_restore(flags);
 		printk(KERN_ERR "umc8672: ports 0x108-0x109 already in use.\n");
 		return 1;
 	}
+	local_irq_save(flags);
 	outb_p(0x5A,0x108); /* enable umc */
 	if (in_umc (0xd5) != 0xa0) {
 		local_irq_restore(flags);
@@ -146,82 +146,62 @@ int __init probe_umc8672 (void)
 	umc_set_speeds (current_speeds);
 	local_irq_restore(flags);
 
-	ide_hwifs[0].chipset = ide_umc8672;
-	ide_hwifs[1].chipset = ide_umc8672;
-	ide_hwifs[0].tuneproc = &tune_umc;
-	ide_hwifs[1].tuneproc = &tune_umc;
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	hwif = &ide_hwifs[0];
+	mate = &ide_hwifs[1];
 
-	probe_hwif_init(&ide_hwifs[0]);
-	probe_hwif_init(&ide_hwifs[1]);
+	hwif->chipset = ide_umc8672;
+	hwif->tuneproc = &tune_umc;
+	hwif->mate = mate;
+
+	mate->chipset = ide_umc8672;
+	mate->tuneproc = &tune_umc;
+	mate->mate = hwif;
+	mate->channel = 1;
+
+	probe_hwif_init(hwif);
+	probe_hwif_init(mate);
 
 	return 0;
 }
 
-static void umc8672_release (void)
+/* Can be called directly from ide.c. */
+int __init umc8672_init(void)
 {
-	unsigned long flags;
+	if (umc8672_probe())
+		return -ENODEV;
+	return 0;
+}
 
-	local_irq_save(flags);
-	if (ide_hwifs[0].chipset != ide_umc8672 &&
-	    ide_hwifs[1].chipset != ide_umc8672) {
-		local_irq_restore(flags);
+#ifdef MODULE
+static void __exit umc8672_release_hwif(ide_hwif_t *hwif)
+{
+	if (hwif->chipset != ide_umc8672)
 		return;
-	}
 
-	ide_hwifs[0].chipset = ide_unknown;
-	ide_hwifs[1].chipset = ide_unknown;	
-	ide_hwifs[0].tuneproc = NULL;
-	ide_hwifs[1].tuneproc = NULL;
-	ide_hwifs[0].mate = NULL;
-	ide_hwifs[1].mate = NULL;
-	ide_hwifs[0].channel = 0;
-	ide_hwifs[1].channel = 0;
-
-	outb_p(0xa5,0x108); /* disable umc */
-
-	release_region(0x108, 2);
-	local_irq_restore(flags);
+	hwif->chipset = ide_unknown;
+	hwif->tuneproc = NULL;
+	hwif->mate = NULL;
+	hwif->channel = 0;
 }
 
-#ifndef MODULE
-/*
- * init_umc8672:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_umc8672 (void)
+static void __exit umc8672_exit(void)
 {
-	if (probe_umc8672())
-		printk(KERN_ERR "init_umc8672: umc8672 controller not found.\n");
-}
+	unsigned long flags;
 
-#else
+	umc8672_release_hwif(&ide_hwifs[0]);
+	umc8672_release_hwif(&ide_hwifs[1]);
 
-MODULE_AUTHOR("Wolfram Podien");
-MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
-MODULE_LICENSE("GPL");
+	local_irq_save(flags);
+	outb_p(0xa5, 0x108);	/* disable umc */
+	local_irq_restore(flags);
 
-static int __init umc8672_mod_init(void)
-{
-	if (probe_umc8672())
-		return -ENODEV;
-	if (ide_hwifs[0].chipset != ide_umc8672 &&
-	    ide_hwifs[1].chipset != ide_umc8672) {
-		umc8672_release();
-		return -ENODEV;
-	}
-	return 0;
+	release_region(0x108, 2);
 }
-module_init(umc8672_mod_init);
 
-static void __exit umc8672_mod_exit(void)
-{
-        umc8672_release();
-}
-module_exit(umc8672_mod_exit);
+module_init(umc8672_init);
+module_exit(umc8672_exit);
 #endif
 
+MODULE_AUTHOR("Wolfram Podien");
+MODULE_DESCRIPTION("Support for UMC 8672 IDE chipset");
+MODULE_LICENSE("GPL");
diff -puN drivers/ide/ide.c~ide-umc8672-update drivers/ide/ide.c
--- linux-2.6.0-test5-bk1/drivers/ide/ide.c~ide-umc8672-update	2003-09-11 17:58:24.933182536 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/ide.c	2003-09-11 17:58:24.938181776 +0200
@@ -1807,7 +1807,7 @@ extern int ali14xx_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 static int __initdata probe_umc8672;
-extern void init_umc8672(void);
+extern int umc8672_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 static int __initdata probe_dtc2278;
@@ -2601,7 +2601,7 @@ int __init ide_init (void)
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 	if (probe_umc8672)
-		init_umc8672();
+		(void)umc8672_init();
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 	if (probe_dtc2278)

_

