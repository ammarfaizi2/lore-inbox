Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTIKPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTIKPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:24:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44021 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261414AbTIKPYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:24:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] update pdc4030 driver
Date: Thu, 11 Sep 2003 17:26:06 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111726.06447.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update pdc4030 driver

- common pdc4030_init() for built-in and module
- kill init_pdc4030() and enable_promise_support flag (no longer needed)
- minor cleanups

 drivers/ide/ide.c            |   10 +----
 drivers/ide/legacy/pdc4030.c |   85 +++++++------------------------------------
 2 files changed, 18 insertions(+), 77 deletions(-)

diff -puN drivers/ide/ide.c~ide-pdc4030-update drivers/ide/ide.c
--- linux-2.6.0-test5-bk1/drivers/ide/ide.c~ide-pdc4030-update	2003-09-11 17:13:21.998091128 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/ide.c	2003-09-11 17:13:22.008089608 +0200
@@ -1800,7 +1800,6 @@ static int __init match_parm (char *s, c
 
 #ifdef CONFIG_BLK_DEV_PDC4030
 static int __initdata probe_pdc4030;
-extern void init_pdc4030(void);
 #endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 static int __initdata probe_ali14xx;
@@ -2238,8 +2237,9 @@ static void __init probe_for_hwifs (void
 #endif /* CONFIG_BLK_DEV_CMD640 */
 #ifdef CONFIG_BLK_DEV_PDC4030
 	{
-		extern int ide_probe_for_pdc4030(void);
-		(void) ide_probe_for_pdc4030();
+		extern int pdc4030_init(void);
+		if (probe_pdc4030)
+			(void)pdc4030_init();
 	}
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 #ifdef CONFIG_BLK_DEV_IDE_PMAC
@@ -2595,10 +2595,6 @@ int __init ide_init (void)
 
 	init_ide_data();
 
-#ifdef CONFIG_BLK_DEV_PDC4030
-	if (probe_pdc4030)
-		init_pdc4030();
-#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
 		init_ali14xx();
diff -puN drivers/ide/legacy/pdc4030.c~ide-pdc4030-update drivers/ide/legacy/pdc4030.c
--- linux-2.6.0-test5-bk1/drivers/ide/legacy/pdc4030.c~ide-pdc4030-update	2003-09-11 17:13:22.001090672 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/legacy/pdc4030.c	2003-09-11 17:16:27.650867616 +0200
@@ -147,8 +147,6 @@ int pdc4030_identify(ide_drive_t *drive)
 	return pdc4030_cmd(drive, PROMISE_IDENTIFY);
 }
 
-int enable_promise_support;
-
 /*
  * setup_pdc4030()
  * Completes the setup of a Promise DC4030 controller card, once found.
@@ -296,33 +294,28 @@ int __init detect_pdc4030(ide_hwif_t *hw
 	}
 }
 
-
-int __init ide_probe_for_pdc4030(void)
+int __init pdc4030_init(void)
 {
 	unsigned int	index;
 	ide_hwif_t	*hwif;
 
-#ifndef MODULE
-	if (enable_promise_support == 0)
-		return;
-#endif
-
 	for (index = 0; index < MAX_HWIFS; index++) {
 		hwif = &ide_hwifs[index];
 		if (hwif->chipset == ide_unknown && detect_pdc4030(hwif)) {
 #ifndef MODULE
 			setup_pdc4030(hwif);
 #else
-			return setup_pdc4030(hwif);
+			if (!setup_pdc4030(hwif))
+				return -ENODEV;
+			return 0;
 #endif
 		}
 	}
-#ifdef MODULE
-	return 0;
-#endif
+	return -ENODEV;
 }
 
-static void __exit release_pdc4030(ide_hwif_t *hwif, ide_hwif_t *mate)
+#ifdef MODULE
+static void __exit pdc4030_release_hwif(ide_hwif_t *hwif)
 {
 	hwif->chipset = ide_unknown;
 	hwif->selectproc = NULL;
@@ -333,72 +326,24 @@ static void __exit release_pdc4030(ide_h
 	hwif->drives[1].keep_settings = 0;
 	hwif->drives[0].noprobe = 0;
 	hwif->drives[1].noprobe = 0;
-
-	if (mate != NULL) {
-		mate->chipset = ide_unknown;
-		mate->selectproc = NULL;
-		mate->serialized = 0;
-		mate->drives[0].io_32bit = 0;
-		mate->drives[1].io_32bit = 0;
-		mate->drives[0].keep_settings = 0;
-		mate->drives[1].keep_settings = 0;
-		mate->drives[0].noprobe = 0;
-		mate->drives[1].noprobe = 0;
-	}
 }
 
-#ifndef MODULE
-/*
- * init_pdc4030:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_pdc4030(void)
+static void __exit pdc4030_exit(void)
 {
-	enable_promise_support = 1;
+	unsigned int index;
+
+	for (index = 0; index < MAX_HWIFS; index++)
+		pdc4030_release_hwif(&ide_hwifs[index]);
 }
 
-#else
+module_init(pdc4030_init);
+module_exit(pdc4030_exit);
+#endif
 
 MODULE_AUTHOR("Peter Denison");
 MODULE_DESCRIPTION("Support of Promise 4030 VLB series IDE chipsets");
 MODULE_LICENSE("GPL");
 
-static int __init pdc4030_mod_init(void)
-{
-	if (enable_promise_support == 0)
-		enable_promise_support = 1;
-
-	if (!ide_probe_for_pdc4030())
-		return -ENODEV;
-        return 0;
-}
-module_init(pdc4030_mod_init);
-
-static void __exit pdc4030_mod_exit(void)
-{
-	unsigned int    index;
-	ide_hwif_t      *hwif;
-
-	if (enable_promise_support == 0)
-		return;
- 
-	for (index = 0; index < MAX_HWIFS; index++) {
-		hwif = &ide_hwifs[index];
-		if (hwif->chipset == ide_pdc4030) {
-			ide_hwif_t *mate = &ide_hwifs[hwif->index+1];
-			if (mate->chipset == ide_pdc4030)
-				release_pdc4030(hwif, mate);
-			else
-				release_pdc4030(hwif, NULL);
-                }
-        }
-	enable_promise_support = 0;
-}
-module_exit(pdc4030_mod_exit);
-#endif
-
 /*
  * promise_read_intr() is the handler for disk read/multread interrupts
  */

_

