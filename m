Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTIKPjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTIKPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:39:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5114 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261271AbTIKPjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:39:17 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] update ali14xx driver
Date: Thu, 11 Sep 2003 17:41:33 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111741.33893.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update ali14xx driver

- common ali14xx_init() for built-in and module
- do not call findPort() twice
- touch hwifs only if chipset was found and initialized
- release hwif only if hwif->chipset == ide_ali14xx
- when releasing hwif, restore hwif->channel to the default value
- mark exit functions with __exit
- do not use ide_hwifs[] directly
- minor cleanups

 drivers/ide/ide.c            |    4 -
 drivers/ide/legacy/ali14xx.c |  109 ++++++++++++++++---------------------------
 2 files changed, 44 insertions(+), 69 deletions(-)

diff -puN drivers/ide/legacy/ali14xx.c~ide-ali14xx-update drivers/ide/legacy/ali14xx.c
--- linux-2.6.0-test5-bk1/drivers/ide/legacy/ali14xx.c~ide-ali14xx-update	2003-09-11 17:26:34.466617600 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/legacy/ali14xx.c	2003-09-11 17:30:46.720269216 +0200
@@ -198,22 +198,12 @@ static int __init initRegisters (void) {
 	return t;
 }
 
-int __init probe_ali14xx (void)
+static int __init ali14xx_probe(void)
 {
-	/* auto-detect IDE controller port */
-	if (!findPort()) {
-		printk(KERN_ERR "ali14xx: not found.\n");
-		return 1;
-	}
+	ide_hwif_t *hwif, *mate;
 
-	printk(KERN_DEBUG "ali14xx: base= 0x%03x, regOn = 0x%02x.\n", basePort, regOn);
-	ide_hwifs[0].chipset = ide_ali14xx;
-	ide_hwifs[1].chipset = ide_ali14xx;
-	ide_hwifs[0].tuneproc = &ali14xx_tune_drive;
-	ide_hwifs[1].tuneproc = &ali14xx_tune_drive;
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	printk(KERN_DEBUG "ali14xx: base=0x%03x, regOn=0x%02x.\n",
+			  basePort, regOn);
 
 	/* initialize controller registers */
 	if (!initRegisters()) {
@@ -221,74 +211,59 @@ int __init probe_ali14xx (void)
 		return 1;
 	}
 
-	probe_hwif_init(&ide_hwifs[0]);
-	probe_hwif_init(&ide_hwifs[1]);
+	hwif = &ide_hwifs[0];
+	mate = &ide_hwifs[1];
 
-	return 0;
-}
+	hwif->chipset = ide_ali14xx;
+	hwif->tuneproc = &ali14xx_tune_drive;
+	hwif->mate = mate;
+
+	mate->chipset = ide_ali14xx;
+	mate->tuneproc = &ali14xx_tune_drive;
+	mate->mate = hwif;
+	mate->channel = 1;
 
-static void ali14xx_release (void)
-{
-	if (ide_hwifs[0].chipset != ide_ali14xx &&
-	    ide_hwifs[1].chipset != ide_ali14xx)
-		return;
+	probe_hwif_init(hwif);
+	probe_hwif_init(mate);
 
-	ide_hwifs[0].chipset = ide_unknown;
-	ide_hwifs[1].chipset = ide_unknown;
-	ide_hwifs[0].tuneproc = NULL;
-	ide_hwifs[1].tuneproc = NULL;
-	ide_hwifs[0].mate = NULL;
-	ide_hwifs[1].mate = NULL;
+	return 0;
 }
 
-#ifndef MODULE
-/*
- * init_ali14xx:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_ali14xx (void)
+/* Can be called directly from ide.c. */
+int __init ali14xx_init(void)
 {
 	/* auto-detect IDE controller port */
-        if (findPort())
-		if (probe_ali14xx())
-			goto no_detect;
-	return;
-
-no_detect:
+	if (findPort()) {
+		if (ali14xx_probe())
+			return -ENODEV;
+		return 0;
+	}
 	printk(KERN_ERR "ali14xx: not found.\n");
-	ali14xx_release();
+	return -ENODEV;
 }
 
-#else
-
-MODULE_AUTHOR("see local file");
-MODULE_DESCRIPTION("support of ALI 14XX IDE chipsets");
-MODULE_LICENSE("GPL");
-
-static int __init ali14xx_mod_init(void)
+#ifdef MODULE
+static void __exit ali14xx_release_hwif(ide_hwif_t *hwif)
 {
-	/* auto-detect IDE controller port */
-	if (findPort())
-		if (probe_ali14xx()) {
-			ali14xx_release();
-			return -ENODEV;
-		}
+	if (hwif->chipset != ide_ali14xx)
+		return;
 
-	if (ide_hwifs[0].chipset != ide_ali14xx &&
-	    ide_hwifs[1].chipset != ide_ali14xx) {
-		ali14xx_release();
-		return -ENODEV;
-	}
-	return 0;
+	hwif->chipset = ide_unknown;
+	hwif->tuneproc = NULL;
+	hwif->mate = NULL;
+	hwif->channel = 0;
 }
-module_init(ali14xx_mod_init);
 
-static void __exit ali14xx_mod_exit(void)
+static void __exit ali14xx_exit(void)
 {
-	ali14xx_release();
+	ali14xx_release_hwif(&ide_hwifs[0]);
+	ali14xx_release_hwif(&ide_hwifs[1]);
 }
-module_exit(ali14xx_mod_exit);
+
+module_init(ali14xx_init);
+module_exit(ali14xx_exit);
 #endif
 
+MODULE_AUTHOR("see local file");
+MODULE_DESCRIPTION("support of ALI 14XX IDE chipsets");
+MODULE_LICENSE("GPL");
diff -puN drivers/ide/ide.c~ide-ali14xx-update drivers/ide/ide.c
--- linux-2.6.0-test5-bk1/drivers/ide/ide.c~ide-ali14xx-update	2003-09-11 17:26:34.470616992 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/ide.c	2003-09-11 17:26:34.476616080 +0200
@@ -1803,7 +1803,7 @@ static int __initdata probe_pdc4030;
 #endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 static int __initdata probe_ali14xx;
-extern void init_ali14xx(void);
+extern int ali14xx_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 static int __initdata probe_umc8672;
@@ -2597,7 +2597,7 @@ int __init ide_init (void)
 
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
-		init_ali14xx();
+		(void)ali14xx_init();
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 	if (probe_umc8672)

_

