Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTIKPur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTIKPur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:50:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30717 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261322AbTIKPuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:50:39 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] update ht6560b driver
Date: Thu, 11 Sep 2003 17:52:31 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111752.31505.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update ht6560b driver

- common ht6560b_init() for built-in and module
- release hwif only if hwif->chipset == ide_ht6560b
- when releasing hwif, restore hwif->channel to the default value
- mark exit functions with __exit
- do not use ide_hwifs[] directly
- minor cleanups

 drivers/ide/ide.c            |    4 -
 drivers/ide/legacy/ht6560b.c |  115 ++++++++++++++++++-------------------------
 2 files changed, 52 insertions(+), 67 deletions(-)

diff -puN drivers/ide/legacy/ht6560b.c~ide-ht6560b-update drivers/ide/legacy/ht6560b.c
--- linux-2.6.0-test5-bk1/drivers/ide/legacy/ht6560b.c~ide-ht6560b-update	2003-09-11 17:48:41.991803096 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/legacy/ht6560b.c	2003-09-11 17:48:41.998802032 +0200
@@ -304,35 +304,16 @@ static void tune_ht6560b (ide_drive_t *d
 #endif
 }
 
-void ht6560b_release (void)
-{
-	if (ide_hwifs[0].chipset != ide_ht6560b &&
-	    ide_hwifs[1].chipset != ide_ht6560b)
-                return;
-
-	ide_hwifs[0].chipset = ide_unknown;
-	ide_hwifs[1].chipset = ide_unknown;
-	ide_hwifs[0].tuneproc = NULL;
-	ide_hwifs[1].tuneproc = NULL;
-	ide_hwifs[0].selectproc = NULL;
-	ide_hwifs[1].selectproc = NULL;
-	ide_hwifs[0].serialized = 0;
-	ide_hwifs[1].serialized = 0;
-	ide_hwifs[0].mate = NULL;
-	ide_hwifs[1].mate = NULL;
-
-	ide_hwifs[0].drives[0].drive_data = 0;
-	ide_hwifs[0].drives[1].drive_data = 0;
-	ide_hwifs[1].drives[0].drive_data = 0;
-	ide_hwifs[1].drives[1].drive_data = 0;
-	release_region(HT_CONFIG_PORT, 1);
-}
-
-static int __init ht6560b_mod_init(void)
+/* Can be called directly from ide.c. */
+int __init ht6560b_init(void)
 {
+	ide_hwif_t *hwif, *mate;
 	int t;
 
-	if (!request_region(HT_CONFIG_PORT, 1, ide_hwifs[0].name)) {
+	hwif = &ide_hwifs[0];
+	mate = &ide_hwifs[1];
+
+	if (!request_region(HT_CONFIG_PORT, 1, hwif->name)) {
 		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
 			__FUNCTION__);
 		return -ENODEV;
@@ -343,39 +324,33 @@ static int __init ht6560b_mod_init(void)
 		goto release_region;
 	}
 
-	ide_hwifs[0].chipset = ide_ht6560b;
-	ide_hwifs[1].chipset = ide_ht6560b;
-	ide_hwifs[0].selectproc = &ht6560b_selectproc;
-	ide_hwifs[1].selectproc = &ht6560b_selectproc;
-	ide_hwifs[0].tuneproc = &tune_ht6560b;
-	ide_hwifs[1].tuneproc = &tune_ht6560b;
-	ide_hwifs[0].serialized = 1;  /* is this needed? */
-	ide_hwifs[1].serialized = 1;  /* is this needed? */
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	hwif->chipset = ide_ht6560b;
+	hwif->selectproc = &ht6560b_selectproc;
+	hwif->tuneproc = &tune_ht6560b;
+	hwif->serialized = 1;	/* is this needed? */
+	hwif->mate = mate;
+
+	mate->chipset = ide_ht6560b;
+	mate->selectproc = &ht6560b_selectproc;
+	mate->tuneproc = &tune_ht6560b;
+	mate->serialized = 1;	/* is this needed? */
+	mate->mate = hwif;
+	mate->channel = 1;
 
 	/*
 	 * Setting default configurations for drives
 	 */
 	t = (HT_CONFIG_DEFAULT << 8);
 	t |= HT_TIMING_DEFAULT;
-	ide_hwifs[0].drives[0].drive_data = t;
-	ide_hwifs[0].drives[1].drive_data = t;
-	t |= (HT_SECONDARY_IF << 8);
-	ide_hwifs[1].drives[0].drive_data = t;
-	ide_hwifs[1].drives[1].drive_data = t;
+	hwif->drives[0].drive_data = t;
+	hwif->drives[1].drive_data = t;
 
-	probe_hwif_init(&ide_hwifs[0]);
-	probe_hwif_init(&ide_hwifs[1]);
+	t |= (HT_SECONDARY_IF << 8);
+	mate->drives[0].drive_data = t;
+	mate->drives[1].drive_data = t;
 
-#ifdef MODULE
-	if (ide_hwifs[0].chipset != ide_ht6560b &&
-	    ide_hwifs[1].chipset != ide_ht6560b) {
-		ht6560b_release();
-		return -ENODEV;
-	}
-#endif
+	probe_hwif_init(hwif);
+	probe_hwif_init(mate);
 
 	return 0;
 
@@ -384,24 +359,34 @@ release_region:
 	return -ENODEV;
 }
 
-MODULE_AUTHOR("See Local File");
-MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
-MODULE_LICENSE("GPL");
-
 #ifdef MODULE
-static void __exit ht6560b_mod_exit(void)
+static void __exit ht6560b_release_hwif(ide_hwif_t *hwif)
 {
-        ht6560b_release();
+	if (hwif->chipset != ide_ht6560b)
+		return;
+
+	hwif->chipset = ide_unknown;
+	hwif->tuneproc = NULL;
+	hwif->selectproc = NULL;
+	hwif->serialized = 0;
+	hwif->mate = NULL;
+	hwif->channel = 0;
+
+	hwif->drives[0].drive_data = 0;
+	hwif->drives[1].drive_data = 0;
 }
 
-module_init(ht6560b_mod_init);
-module_exit(ht6560b_mod_exit);
-#else
-/*
- * called by ide.c when parsing command line
- */
-void __init init_ht6560b (void)
+static void __exit ht6560b_exit(void)
 {
-	ht6560b_mod_init();	/* ignore return value */
+	ht6560b_release_hwif(&ide_hwifs[0]);
+	ht6560b_release_hwif(&ide_hwifs[1]);
+	release_region(HT_CONFIG_PORT, 1);
 }
+
+module_init(ht6560b_init);
+module_exit(ht6560b_exit);
 #endif
+
+MODULE_AUTHOR("See Local File");
+MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
+MODULE_LICENSE("GPL");
diff -puN drivers/ide/ide.c~ide-ht6560b-update drivers/ide/ide.c
--- linux-2.6.0-test5-bk1/drivers/ide/ide.c~ide-ht6560b-update	2003-09-11 17:48:41.994802640 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/ide.c	2003-09-11 17:48:42.000801728 +0200
@@ -1815,7 +1815,7 @@ extern int dtc2278_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 static int __initdata probe_ht6560b;
-extern void init_ht6560b(void);
+extern int ht6560b_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 static int __initdata probe_qd65xx;
@@ -2609,7 +2609,7 @@ int __init ide_init (void)
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
 	if (probe_ht6560b)
-		init_ht6560b();
+		(void)ht6560b_init();
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 	if (probe_qd65xx)

_

