Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUDVAfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUDVAfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 20:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbUDVAfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 20:35:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40626 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263307AbUDVAfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 20:35:25 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Wed, 21 Apr 2004 22:19:24 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404212219.24622.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is unsafe thing to do (no locking, no reference counting etc).
Just remove module_exit() as it was done for IDE PCI drivers.

 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/ali14xx.c |   18 ---------
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/dtc2278.c |   20 ----------
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/ht6560b.c |   24 ------------
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/pdc4030.c |   22 -----------
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/qd65xx.c  |   11 +----
 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/umc8672.c |   26 --------------
 6 files changed, 2 insertions(+), 119 deletions(-)

diff -puN drivers/ide/legacy/ali14xx.c~ide_legacy_mods drivers/ide/legacy/ali14xx.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/ali14xx.c~ide_legacy_mods	2004-04-21 17:51:19.499226456 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/ali14xx.c	2004-04-21 17:51:19.531221592 +0200
@@ -243,25 +243,7 @@ int __init ali14xx_init(void)
 }
 
 #ifdef MODULE
-static void __exit ali14xx_release_hwif(ide_hwif_t *hwif)
-{
-	if (hwif->chipset != ide_ali14xx)
-		return;
-
-	hwif->chipset = ide_unknown;
-	hwif->tuneproc = NULL;
-	hwif->mate = NULL;
-	hwif->channel = 0;
-}
-
-static void __exit ali14xx_exit(void)
-{
-	ali14xx_release_hwif(&ide_hwifs[0]);
-	ali14xx_release_hwif(&ide_hwifs[1]);
-}
-
 module_init(ali14xx_init);
-module_exit(ali14xx_exit);
 #endif
 
 MODULE_AUTHOR("see local file");
diff -puN drivers/ide/legacy/dtc2278.c~ide_legacy_mods drivers/ide/legacy/dtc2278.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/dtc2278.c~ide_legacy_mods	2004-04-21 17:51:19.503225848 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/dtc2278.c	2004-04-21 17:51:19.559217336 +0200
@@ -155,27 +155,7 @@ int __init dtc2278_init(void)
 }
 
 #ifdef MODULE
-static void __exit dtc2278_release_hwif(ide_hwif_t *hwif)
-{
-	if (hwif->chipset != ide_dtc2278)
-		return;
-
-	hwif->serialized = 0;
-	hwif->chipset = ide_unknown;
-	hwif->tuneproc = NULL;
-	hwif->drives[0].no_unmask = 0;
-	hwif->drives[1].no_unmask = 0;
-	hwif->mate = NULL;
-}
-
-static void __exit dtc2278_exit(void)
-{
-	dtc2278_release_hwif(&ide_hwifs[0]);
-	dtc2278_release_hwif(&ide_hwifs[1]);
-}
-
 module_init(dtc2278_init);
-module_exit(dtc2278_exit);
 #endif
 
 MODULE_AUTHOR("See Local File");
diff -puN drivers/ide/legacy/ht6560b.c~ide_legacy_mods drivers/ide/legacy/ht6560b.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/ht6560b.c~ide_legacy_mods	2004-04-21 17:51:19.506225392 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/ht6560b.c	2004-04-21 17:51:19.589212776 +0200
@@ -360,31 +360,7 @@ release_region:
 }
 
 #ifdef MODULE
-static void __exit ht6560b_release_hwif(ide_hwif_t *hwif)
-{
-	if (hwif->chipset != ide_ht6560b)
-		return;
-
-	hwif->chipset = ide_unknown;
-	hwif->tuneproc = NULL;
-	hwif->selectproc = NULL;
-	hwif->serialized = 0;
-	hwif->mate = NULL;
-	hwif->channel = 0;
-
-	hwif->drives[0].drive_data = 0;
-	hwif->drives[1].drive_data = 0;
-}
-
-static void __exit ht6560b_exit(void)
-{
-	ht6560b_release_hwif(&ide_hwifs[0]);
-	ht6560b_release_hwif(&ide_hwifs[1]);
-	release_region(HT_CONFIG_PORT, 1);
-}
-
 module_init(ht6560b_init);
-module_exit(ht6560b_exit);
 #endif
 
 MODULE_AUTHOR("See Local File");
diff -puN drivers/ide/legacy/pdc4030.c~ide_legacy_mods drivers/ide/legacy/pdc4030.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/pdc4030.c~ide_legacy_mods	2004-04-21 17:51:19.511224632 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/pdc4030.c	2004-04-21 17:51:19.597211560 +0200
@@ -312,29 +312,7 @@ int __init pdc4030_init(void)
 }
 
 #ifdef MODULE
-static void __exit pdc4030_release_hwif(ide_hwif_t *hwif)
-{
-	hwif->chipset = ide_unknown;
-	hwif->selectproc = NULL;
-	hwif->serialized = 0;
-	hwif->drives[0].io_32bit = 0;
-	hwif->drives[1].io_32bit = 0;
-	hwif->drives[0].keep_settings = 0;
-	hwif->drives[1].keep_settings = 0;
-	hwif->drives[0].noprobe = 0;
-	hwif->drives[1].noprobe = 0;
-}
-
-static void __exit pdc4030_exit(void)
-{
-	unsigned int index;
-
-	for (index = 0; index < MAX_HWIFS; index++)
-		pdc4030_release_hwif(&ide_hwifs[index]);
-}
-
 module_init(pdc4030_init);
-module_exit(pdc4030_exit);
 #endif
 
 MODULE_AUTHOR("Peter Denison");
diff -puN drivers/ide/legacy/qd65xx.c~ide_legacy_mods drivers/ide/legacy/qd65xx.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/qd65xx.c~ide_legacy_mods	2004-04-21 17:51:19.515224024 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/qd65xx.c	2004-04-21 18:20:32.992654936 +0200
@@ -354,12 +354,12 @@ static void __init qd_setup(ide_hwif_t *
 	probe_hwif_init(hwif);
 }
 
-#ifdef MODULE
 /*
  * qd_unsetup:
  *
  * called to unsetup an ata channel : back to default values, unlinks tuning
  */
+/*
 static void __exit qd_unsetup(ide_hwif_t *hwif)
 {
 	u8 config = hwif->config_data;
@@ -389,7 +389,7 @@ static void __exit qd_unsetup(ide_hwif_t
 		printk(KERN_WARNING "keeping settings !\n");
 	}
 }
-#endif
+*/
 
 /*
  * qd_probe:
@@ -496,14 +496,7 @@ int __init qd65xx_init(void)
 }
 
 #ifdef MODULE
-static void __exit qd65xx_exit(void)
-{
-	qd_unsetup(&ide_hwifs[0]);
-	qd_unsetup(&ide_hwifs[1]);
-}
-
 module_init(qd65xx_init);
-module_exit(qd65xx_exit);
 #endif
 
 MODULE_AUTHOR("Samuel Thibault");
diff -puN drivers/ide/legacy/umc8672.c~ide_legacy_mods drivers/ide/legacy/umc8672.c
--- linux-2.6.6-rc1-bk5/drivers/ide/legacy/umc8672.c~ide_legacy_mods	2004-04-21 17:51:19.519223416 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/legacy/umc8672.c	2004-04-21 17:51:19.600211104 +0200
@@ -173,33 +173,7 @@ int __init umc8672_init(void)
 }
 
 #ifdef MODULE
-static void __exit umc8672_release_hwif(ide_hwif_t *hwif)
-{
-	if (hwif->chipset != ide_umc8672)
-		return;
-
-	hwif->chipset = ide_unknown;
-	hwif->tuneproc = NULL;
-	hwif->mate = NULL;
-	hwif->channel = 0;
-}
-
-static void __exit umc8672_exit(void)
-{
-	unsigned long flags;
-
-	umc8672_release_hwif(&ide_hwifs[0]);
-	umc8672_release_hwif(&ide_hwifs[1]);
-
-	local_irq_save(flags);
-	outb_p(0xa5, 0x108);	/* disable umc */
-	local_irq_restore(flags);
-
-	release_region(0x108, 2);
-}
-
 module_init(umc8672_init);
-module_exit(umc8672_exit);
 #endif
 
 MODULE_AUTHOR("Wolfram Podien");

_

