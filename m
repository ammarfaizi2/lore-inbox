Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTIKPqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTIKPqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:46:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15612 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261291AbTIKPqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:46:48 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] update dtc2278 driver
Date: Thu, 11 Sep 2003 17:48:21 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111748.21506.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update dtc2278 driver

- common dtc2278_init() for built-in and module
- touch hwifs only if hwif->chipset == ide_unknown for both ports,
  so we don't thrash already used hwifs when loading module
- release hwif only if hwif->chipset == ide_dtc2278
- mark exit functions with __exit
- do not use ide_hwifs[] directly
- minor cleanups

 drivers/ide/ide.c            |    4 -
 drivers/ide/legacy/dtc2278.c |  109 +++++++++++++++++++------------------------
 2 files changed, 52 insertions(+), 61 deletions(-)

diff -puN drivers/ide/legacy/dtc2278.c~ide-dtc2278-update drivers/ide/legacy/dtc2278.c
--- linux-2.6.0-test5-bk1/drivers/ide/legacy/dtc2278.c~ide-dtc2278-update	2003-09-10 21:43:06.000000000 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/legacy/dtc2278.c	2003-09-11 17:42:47.337718712 +0200
@@ -95,9 +95,16 @@ static void tune_dtc2278 (ide_drive_t *d
 	HWIF(drive)->drives[!drive->select.b.unit].io_32bit = 1;
 }
 
-void __init probe_dtc2278 (void)
+static int __init probe_dtc2278(void)
 {
 	unsigned long flags;
+	ide_hwif_t *hwif, *mate;
+
+	hwif = &ide_hwifs[0];
+	mate = &ide_hwifs[1];
+
+	if (hwif->chipset != ide_unknown || mate->chipset != ide_unknown)
+		return 1;
 
 	local_irq_save(flags);
 	/*
@@ -117,76 +124,60 @@ void __init probe_dtc2278 (void)
 #endif
 	local_irq_restore(flags);
 
-	ide_hwifs[0].serialized = 1;
-	ide_hwifs[1].serialized = 1;
-	ide_hwifs[0].chipset = ide_dtc2278;
-	ide_hwifs[1].chipset = ide_dtc2278;
-	ide_hwifs[0].tuneproc = &tune_dtc2278;
-	ide_hwifs[0].drives[0].no_unmask = 1;
-	ide_hwifs[0].drives[1].no_unmask = 1;
-	ide_hwifs[1].drives[0].no_unmask = 1;
-	ide_hwifs[1].drives[1].no_unmask = 1;
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	hwif->serialized = 1;
+	hwif->chipset = ide_dtc2278;
+	hwif->tuneproc = &tune_dtc2278;
+	hwif->drives[0].no_unmask = 1;
+	hwif->drives[1].no_unmask = 1;
+	hwif->mate = mate;
+
+	mate->serialized = 1;
+	mate->chipset = ide_dtc2278;
+	mate->drives[0].no_unmask = 1;
+	mate->drives[1].no_unmask = 1;
+	mate->mate = hwif;
+	mate->channel = 1;
+
+	probe_hwif_init(hwif);
+	probe_hwif_init(mate);
 
-	probe_hwif_init(&ide_hwifs[0]);
-	probe_hwif_init(&ide_hwifs[1]);
+	return 0;
 }
 
-static void dtc2278_release (void)
+/* Can be called directly from ide.c. */
+int __init dtc2278_init(void)
 {
-	if (ide_hwifs[0].chipset != ide_dtc2278 &&
-	    ide_hwifs[1].chipset != ide_dtc2278)
+	if (probe_dtc2278()) {
+		printk(KERN_ERR "dtc2278: ide interfaces already in use!\n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+#ifdef MODULE
+static void __exit dtc2278_release_hwif(ide_hwif_t *hwif)
+{
+	if (hwif->chipset != ide_dtc2278)
 		return;
 
-	ide_hwifs[0].serialized = 0;
-	ide_hwifs[1].serialized = 0;
-	ide_hwifs[0].chipset = ide_unknown;
-	ide_hwifs[1].chipset = ide_unknown;
-	ide_hwifs[0].tuneproc = NULL;
-	ide_hwifs[0].drives[0].no_unmask = 0;
-	ide_hwifs[0].drives[1].no_unmask = 0;
-	ide_hwifs[1].drives[0].no_unmask = 0;
-	ide_hwifs[1].drives[1].no_unmask = 0;
-	ide_hwifs[0].mate = NULL;
-	ide_hwifs[1].mate = NULL;
+	hwif->serialized = 0;
+	hwif->chipset = ide_unknown;
+	hwif->tuneproc = NULL;
+	hwif->drives[0].no_unmask = 0;
+	hwif->drives[1].no_unmask = 0;
+	hwif->mate = NULL;
 }
 
-#ifndef MODULE
-/*
- * init_dtc2278:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_dtc2278 (void)
+static void __exit dtc2278_exit(void)
 {
-	probe_dtc2278();
+	dtc2278_release_hwif(&ide_hwifs[0]);
+	dtc2278_release_hwif(&ide_hwifs[1]);
 }
 
-#else
+module_init(dtc2278_init);
+module_exit(dtc2278_exit);
+#endif
 
 MODULE_AUTHOR("See Local File");
 MODULE_DESCRIPTION("support of DTC-2278 VLB IDE chipsets");
 MODULE_LICENSE("GPL");
-
-static int __init dtc2278_mod_init(void)
-{
-	probe_dtc2278();
-	if (ide_hwifs[0].chipset != ide_dtc2278 &&
-	    ide_hwifs[1].chipset != ide_dtc2278) {
-		dtc2278_release();
-		return -ENODEV;
-	}
-	return 0;
-}
-module_init(dtc2278_mod_init);
-
-static void __exit dtc2278_mod_exit(void)
-{
-	dtc2278_release();
-}
-module_exit(dtc2278_mod_exit);
-#endif
-
diff -puN drivers/ide/ide.c~ide-dtc2278-update drivers/ide/ide.c
--- linux-2.6.0-test5-bk1/drivers/ide/ide.c~ide-dtc2278-update	2003-09-11 17:42:47.333719320 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/ide.c	2003-09-11 17:42:47.339718408 +0200
@@ -1811,7 +1811,7 @@ extern void init_umc8672(void);
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 static int __initdata probe_dtc2278;
-extern void init_dtc2278(void);
+extern int dtc2278_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 static int __initdata probe_ht6560b;
@@ -2605,7 +2605,7 @@ int __init ide_init (void)
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 	if (probe_dtc2278)
-		init_dtc2278();
+		(void)dtc2278_init();
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 	if (probe_ht6560b)

_

