Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUAQMOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 07:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAQMOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 07:14:09 -0500
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:60945 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S265959AbUAQMOA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 07:14:00 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] modular IDE for 2.6.1 ugly but working fix
Date: Sat, 17 Jan 2004 13:13:52 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AcSCAn5OFEQengB"
Message-Id: <200401171313.52545.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AcSCAn5OFEQengB
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here it goes - modular 2.6 IDE - I know it's ugly (and I don't know whether=
 it=20
will work with cmd640 chipset) but it's working for me and several other=20
people.

=2D-=20
Witold Kr=EAcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net

--Boundary-00=_AcSCAn5OFEQengB
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="linux-2.6.1-modular_ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.1-modular_ide.patch"

diff -urN --exclude-from=zf linux-2.6.1/drivers/block/ll_rw_blk.c linux-2.6.1-ziew/drivers/block/ll_rw_blk.c
--- linux-2.6.1/drivers/block/ll_rw_blk.c	2004-01-17 13:02:01.084322656 +0100
+++ linux-2.6.1-ziew/drivers/block/ll_rw_blk.c	2004-01-15 18:14:33.000000000 +0100
@@ -145,7 +145,7 @@
 	q->activity_fn = fn;
 	q->activity_data = data;
 }
-
+EXPORT_SYMBOL(blk_queue_activity_fn);
 /**
  * blk_queue_prep_rq - set a prepare_request function for queue
  * @q:		queue
diff -urN --exclude-from=zf linux-2.6.1/drivers/ide/ide-probe.c linux-2.6.1-ziew/drivers/ide/ide-probe.c
--- linux-2.6.1/drivers/ide/ide-probe.c	2004-01-09 07:59:44.000000000 +0100
+++ linux-2.6.1-ziew/drivers/ide/ide-probe.c	2004-01-15 18:10:37.000000000 +0100
@@ -1354,21 +1354,5 @@
 	return 0;
 }
 
-#ifdef MODULE
-int init_module (void)
-{
-	unsigned int index;
-	
-	for (index = 0; index < MAX_HWIFS; ++index)
-		ide_unregister(index);
-	ideprobe_init();
-	create_proc_ide_interfaces();
-	return 0;
-}
 
-void cleanup_module (void)
-{
-	ide_probe = NULL;
-}
-MODULE_LICENSE("GPL");
-#endif /* MODULE */
+EXPORT_SYMBOL(ideprobe_init);
diff -urN --exclude-from=zf linux-2.6.1/drivers/ide/ide-probe-mod.c linux-2.6.1-ziew/drivers/ide/ide-probe-mod.c
--- linux-2.6.1/drivers/ide/ide-probe-mod.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.1-ziew/drivers/ide/ide-probe-mod.c	2004-01-15 18:07:42.000000000 +0100
@@ -0,0 +1,42 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/major.h>
+#include <linux/errno.h>
+#include <linux/genhd.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+#include <linux/kmod.h>
+
+#include <asm/byteorder.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+extern int ideprobe_init (void);
+#ifdef MODULE
+int init_module (void)
+{
+	unsigned int index;
+	
+	for (index = 0; index < MAX_HWIFS; ++index)
+		ide_unregister(index);
+	ideprobe_init();
+	create_proc_ide_interfaces();
+	return 0;
+}
+
+void cleanup_module (void)
+{
+	ide_probe = NULL;
+}
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
diff -urN --exclude-from=zf linux-2.6.1/drivers/ide/Makefile linux-2.6.1-ziew/drivers/ide/Makefile
--- linux-2.6.1/drivers/ide/Makefile	2004-01-09 07:59:34.000000000 +0100
+++ linux-2.6.1-ziew/drivers/ide/Makefile	2004-01-17 12:41:59.000000000 +0100
@@ -12,19 +12,26 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-mod.o 
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
 
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
-obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+= ide-tcq.o
-obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
+
+ide-mod-y				+= ide.o ide-io.o ide-iops.o ide-taskfile.o ide-lib.o ide-default.o ide-probe.o 
+ide-mod-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
+ide-mod-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
+ide-mod-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
+ide-mod-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-mod-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
+ide-mod-$(CONFIG_PROC_FS)		+= ide-proc.o
+endif
+
+ifeq ($(CONFIG_BLK_DEV_IDE),m)
+ide-mod-$(CONFIG_PROC_FS)		+= ide-proc.o
 endif
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
diff -urN --exclude-from=zf linux-2.6.1/drivers/ide/pci/Makefile linux-2.6.1-ziew/drivers/ide/pci/Makefile
--- linux-2.6.1/drivers/ide/pci/Makefile	2004-01-09 07:59:10.000000000 +0100
+++ linux-2.6.1-ziew/drivers/ide/pci/Makefile	2004-01-15 18:11:38.000000000 +0100
@@ -4,7 +4,6 @@
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
-obj-$(CONFIG_BLK_DEV_CMD640)		+= cmd640.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o

--Boundary-00=_AcSCAn5OFEQengB--
