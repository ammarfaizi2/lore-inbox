Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263827AbTCUT1M>; Fri, 21 Mar 2003 14:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263778AbTCUT0G>; Fri, 21 Mar 2003 14:26:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50308
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263793AbTCUTYj>; Fri, 21 Mar 2003 14:24:39 -0500
Date: Fri, 21 Mar 2003 20:39:54 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212039.h2LKdsAf026419@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: FOr efficient non posted I/O people need to know the target
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-iops.c linux-2.5.65-ac2/drivers/ide/ide-iops.c
--- linux-2.5.65/drivers/ide/ide-iops.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-iops.c	2003-03-07 18:43:58.000000000 +0000
@@ -1,13 +1,12 @@
 /*
- * linux/drivers/ide/ide-iops.c	Version 0.33	April 11, 2002
+ * linux/drivers/ide/ide-iops.c	Version 0.37	Mar 05, 2003
  *
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
- *
+ *  Copyright (C) 2003		Red Hat <alan@redhat.com>
  *
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -63,6 +62,10 @@
 {
 }
 
+static void ide_unplugged_outbsync (ide_drive_t *drive, u8 addr, unsigned long port)
+{
+}
+
 static void ide_unplugged_outw (u16 val, unsigned long port)
 {
 }
@@ -82,7 +85,7 @@
 void unplugged_hwif_iops (ide_hwif_t *hwif)
 {
 	hwif->OUTB	= ide_unplugged_outb;
-	hwif->OUTBSYNC	= ide_unplugged_outb;
+	hwif->OUTBSYNC	= ide_unplugged_outbsync;
 	hwif->OUTW	= ide_unplugged_outw;
 	hwif->OUTL	= ide_unplugged_outl;
 	hwif->OUTSW	= ide_unplugged_outsw;
@@ -130,6 +133,11 @@
 	outb(val, port);
 }
 
+static void ide_outbsync (ide_drive_t *drive, u8 addr, unsigned long port)
+{
+	outb(addr, port);
+}
+
 static void ide_outw (u16 val, unsigned long port)
 {
 	outw(val, port);
@@ -153,7 +161,7 @@
 void default_hwif_iops (ide_hwif_t *hwif)
 {
 	hwif->OUTB	= ide_outb;
-	hwif->OUTBSYNC	= ide_outb;
+	hwif->OUTBSYNC	= ide_outbsync;
 	hwif->OUTW	= ide_outw;
 	hwif->OUTL	= ide_outl;
 	hwif->OUTSW	= ide_outsw;
@@ -201,6 +209,11 @@
 	writeb(value, port);
 }
 
+static void ide_mm_outbsync (ide_drive_t *drive, u8 value, unsigned long port)
+{
+	writeb(value, port);	
+}
+
 static void ide_mm_outw (u16 value, unsigned long port)
 {
 	writew(value, port);
@@ -226,7 +239,7 @@
 	hwif->OUTB	= ide_mm_outb;
 	/* Most systems will need to override OUTBSYNC, alas however
 	   this one is controller specific! */
-	hwif->OUTBSYNC	= ide_mm_outb;
+	hwif->OUTBSYNC	= ide_mm_outbsync;
 	hwif->OUTW	= ide_mm_outw;
 	hwif->OUTL	= ide_mm_outl;
 	hwif->OUTSW	= ide_mm_outsw;
