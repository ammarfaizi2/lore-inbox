Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTIKPzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbTIKPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:55:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13311 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261315AbTIKPzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:55:31 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] update qd65xx driver
Date: Thu, 11 Sep 2003 17:57:35 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309111757.35582.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] update qd65xx driver

- common qd65xx_init() for built-in and module
- release hwif only if hwif->chipset == ide_qd65xx
- mark exit functions with __exit
- do not use ide_hwifs[] directly
- minor cleanups

 drivers/ide/ide.c           |    4 -
 drivers/ide/legacy/qd65xx.c |   98 +++++++++++++++++++++-----------------------
 2 files changed, 50 insertions(+), 52 deletions(-)

diff -puN drivers/ide/legacy/qd65xx.c~ide-qd65xx-update drivers/ide/legacy/qd65xx.c
--- linux-2.6.0-test5-bk1/drivers/ide/legacy/qd65xx.c~ide-qd65xx-update	2003-09-11 17:52:52.125776952 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/legacy/qd65xx.c	2003-09-11 17:52:52.132775888 +0200
@@ -338,12 +338,12 @@ static int __init qd_testreg(int port)
  * called to setup an ata channel : adjusts attributes & links for tuning
  */
 
-void __init qd_setup (int unit, int base, int config, unsigned int data0, unsigned int data1, void (*tuneproc) (ide_drive_t *, u8 pio))
+static void __init qd_setup(ide_hwif_t *hwif, int base, int config,
+			    unsigned int data0, unsigned int data1,
+			    void (*tuneproc) (ide_drive_t *, u8 pio))
 {
-	ide_hwif_t *hwif = &ide_hwifs[unit];
-
 	hwif->chipset = ide_qd65xx;
-	hwif->channel = unit;
+	hwif->channel = hwif->index;
 	hwif->select_data = base;
 	hwif->config_data = config;
 	hwif->drives[0].drive_data = data0;
@@ -354,19 +354,20 @@ void __init qd_setup (int unit, int base
 	probe_hwif_init(hwif);
 }
 
+#ifdef MODULE
 /*
  * qd_unsetup:
  *
  * called to unsetup an ata channel : back to default values, unlinks tuning
  */
-static void __exit qd_unsetup (int unit)
+static void __exit qd_unsetup(ide_hwif_t *hwif)
 {
-	ide_hwif_t *hwif = &ide_hwifs[unit];
 	u8 config = hwif->config_data;
 	int base = hwif->select_data;
 	void *tuneproc = (void *) hwif->tuneproc;
 
-	if (!(hwif->chipset == ide_qd65xx)) return;
+	if (hwif->chipset != ide_qd65xx)
+		return;
 
 	printk(KERN_NOTICE "%s: back to defaults\n", hwif->name);
 
@@ -381,13 +382,14 @@ static void __exit qd_unsetup (int unit)
 			qd_write_reg(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 			qd_write_reg(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
 		} else {
-			qd_write_reg(unit?QD6580_DEF_DATA2:QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+			qd_write_reg(hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
 		}
 	} else {
 		printk(KERN_WARNING "Unknown qd65xx tuning fonction !\n");
 		printk(KERN_WARNING "keeping settings !\n");
 	}
 }
+#endif
 
 /*
  * qd_probe:
@@ -396,8 +398,9 @@ static void __exit qd_unsetup (int unit)
  * return 1 if another qd may be probed
  */
 
-int __init qd_probe (int base)
+static int __init qd_probe(int base)
 {
+	ide_hwif_t *hwif;
 	u8 config;
 	u8 unit;
 
@@ -414,9 +417,8 @@ int __init qd_probe (int base)
 
 		/* qd6500 found */
 
-		printk(KERN_NOTICE "%s: qd6500 at %#x\n",
-			ide_hwifs[unit].name, base);
-		
+		hwif = &ide_hwifs[unit];
+		printk(KERN_NOTICE "%s: qd6500 at %#x\n", hwif->name, base);
 		printk(KERN_DEBUG "qd6500: config=%#x, ID3=%u\n",
 			config, QD_ID3);
 		
@@ -425,8 +427,8 @@ int __init qd_probe (int base)
 			return 1;
 		}
 
-		qd_setup(unit, base, config, QD6500_DEF_DATA,
-			QD6500_DEF_DATA, &qd6500_tune_drive);
+		qd_setup(hwif, base, config, QD6500_DEF_DATA, QD6500_DEF_DATA,
+			 &qd6500_tune_drive);
 		return 1;
 	}
 
@@ -448,25 +450,31 @@ int __init qd_probe (int base)
 
 		if (control & QD_CONTR_SEC_DISABLED) {
 			/* secondary disabled */
+
+			hwif = &ide_hwifs[unit];
 			printk(KERN_INFO "%s: qd6580: single IDE board\n",
-					ide_hwifs[unit].name);
-			qd_setup(unit, base, config | (control << 8),
-				QD6580_DEF_DATA, QD6580_DEF_DATA2,
-				&qd6580_tune_drive);
+					 hwif->name);
+			qd_setup(hwif, base, config | (control << 8),
+				 QD6580_DEF_DATA, QD6580_DEF_DATA2,
+				 &qd6580_tune_drive);
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
 			return 1;
 		} else {
+			ide_hwif_t *mate;
+
+			hwif = &ide_hwifs[0];
+			mate = &ide_hwifs[1];
 			/* secondary enabled */
 			printk(KERN_INFO "%s&%s: qd6580: dual IDE board\n",
-					ide_hwifs[0].name,ide_hwifs[1].name);
+					hwif->name, mate->name);
 
-			qd_setup(0, base, config | (control << 8),
-				QD6580_DEF_DATA, QD6580_DEF_DATA,
-				&qd6580_tune_drive);
-			qd_setup(1, base, config | (control << 8),
-				QD6580_DEF_DATA2, QD6580_DEF_DATA2,
-				&qd6580_tune_drive);
+			qd_setup(hwif, base, config | (control << 8),
+				 QD6580_DEF_DATA, QD6580_DEF_DATA,
+				 &qd6580_tune_drive);
+			qd_setup(mate, base, config | (control << 8),
+				 QD6580_DEF_DATA2, QD6580_DEF_DATA2,
+				 &qd6580_tune_drive);
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
 			return 0; /* no other qd65xx possible */
@@ -476,38 +484,28 @@ int __init qd_probe (int base)
 	return 1;
 }
 
-#ifndef MODULE
-/*
- * init_qd65xx:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_qd65xx (void)
-{
-	if (qd_probe(0x30)) qd_probe(0xb0);
-}
-
-#else
-
-MODULE_AUTHOR("Samuel Thibault");
-MODULE_DESCRIPTION("support of qd65xx vlb ide chipset");
-MODULE_LICENSE("GPL");
-
-static int __init qd65xx_mod_init(void)
+/* Can be called directly from ide.c. */
+int __init qd65xx_init(void)
 {
-	if (qd_probe(0x30)) qd_probe(0xb0);
+	if (qd_probe(0x30))
+		qd_probe(0xb0);
 	if (ide_hwifs[0].chipset != ide_qd65xx &&
 	    ide_hwifs[1].chipset != ide_qd65xx)
 		return -ENODEV;
 	return 0;
 }
-module_init(qd65xx_mod_init);
 
-static void __exit qd65xx_mod_exit(void)
+#ifdef MODULE
+static void __exit qd65xx_exit(void)
 {
-	qd_unsetup(0);
-	qd_unsetup(1);
+	qd_unsetup(&ide_hwifs[0]);
+	qd_unsetup(&ide_hwifs[1]);
 }
-module_exit(qd65xx_mod_exit);
+
+module_init(qd65xx_init);
+module_exit(qd65xx_exit);
 #endif
+
+MODULE_AUTHOR("Samuel Thibault");
+MODULE_DESCRIPTION("support of qd65xx vlb ide chipset");
+MODULE_LICENSE("GPL");
diff -puN drivers/ide/ide.c~ide-qd65xx-update drivers/ide/ide.c
--- linux-2.6.0-test5-bk1/drivers/ide/ide.c~ide-qd65xx-update	2003-09-11 17:52:52.128776496 +0200
+++ linux-2.6.0-test5-bk1-root/drivers/ide/ide.c	2003-09-11 17:52:52.134775584 +0200
@@ -1819,7 +1819,7 @@ extern int ht6560b_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 static int __initdata probe_qd65xx;
-extern void init_qd65xx(void);
+extern int qd65xx_init(void);
 #endif
 
 static int __initdata is_chipset_set[MAX_HWIFS];
@@ -2613,7 +2613,7 @@ int __init ide_init (void)
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 	if (probe_qd65xx)
-		init_qd65xx();
+		(void)qd65xx_init();
 #endif
 
 	initializing = 1;

_

