Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263696AbTCUSP7>; Fri, 21 Mar 2003 13:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263693AbTCUSPW>; Fri, 21 Mar 2003 13:15:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44419
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263696AbTCUSNa>; Fri, 21 Mar 2003 13:13:30 -0500
Date: Fri, 21 Mar 2003 19:28:45 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211928.h2LJSjWS025795@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: module for legacy PC9800 ide
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/pc9800.c linux-2.5.65-ac2/drivers/ide/legacy/pc9800.c
--- linux-2.5.65/drivers/ide/legacy/pc9800.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/drivers/ide/legacy/pc9800.c	2003-03-14 01:19:31.000000000 +0000
@@ -0,0 +1,80 @@
+/*
+ *  ide_pc9800.c
+ *
+ *  Copyright (C) 1997-2000  Linux/98 project,
+ *			     Kyoto University Microcomputer Club.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+#define PC9800_IDE_BANKSELECT	0x432
+
+#undef PC9800_IDE_DEBUG
+
+static void pc9800_select(ide_drive_t *drive)
+{
+#ifdef PC9800_IDE_DEBUG
+	byte old;
+
+	/* Too noisy: */
+	/* printk(KERN_DEBUG "pc9800_select(%s)\n", drive->name); */
+
+	outb(0x80, PC9800_IDE_BANKSELECT);
+	old = inb(PC9800_IDE_BANKSELECT);
+	if (old != HWIF(drive)->index)
+		printk(KERN_DEBUG "ide-pc9800: switching bank #%d -> #%d\n",
+			old, HWIF(drive)->index);
+#endif
+	outb(HWIF(drive)->index, PC9800_IDE_BANKSELECT);
+}
+
+void __init ide_probe_for_pc9800(void)
+{
+	u8 saved_bank;
+
+	if (!PC9800_9821_P() /* || !PC9821_IDEIF_DOUBLE_P() */)
+		return;
+
+	if (!request_region(PC9800_IDE_BANKSELECT, 1, "ide0/1 bank")) {
+		printk(KERN_ERR
+			"ide: bank select port (%#x) is already occupied!\n",
+			PC9800_IDE_BANKSELECT);
+		return;
+	}
+
+	/* Do actual probing. */
+	if ((saved_bank = inb(PC9800_IDE_BANKSELECT)) == (u8) ~0
+	    || (outb(saved_bank ^ 1, PC9800_IDE_BANKSELECT),
+		/* Next outb is dummy for reading status. */
+		outb(0x80, PC9800_IDE_BANKSELECT),
+		inb(PC9800_IDE_BANKSELECT) != (saved_bank ^ 1))) {
+		printk(KERN_INFO
+			"ide: pc9800 type bank selecting port not found\n");
+		release_region(PC9800_IDE_BANKSELECT, 1);
+		return;
+	}
+
+	/* Restore original value, just in case. */
+	outb(saved_bank, PC9800_IDE_BANKSELECT);
+
+	/* These ports are probably used by IDE I/F.  */
+	request_region(0x430, 1, "ide");
+	request_region(0x435, 1, "ide");
+
+	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET] == HD_DATA &&
+	    ide_hwifs[1].io_ports[IDE_DATA_OFFSET] == HD_DATA) {
+		ide_hwifs[0].chipset = ide_pc9800;
+		ide_hwifs[0].mate = &ide_hwifs[1];
+		ide_hwifs[0].selectproc = pc9800_select;
+		ide_hwifs[1].chipset = ide_pc9800;
+		ide_hwifs[1].mate = &ide_hwifs[0];
+		ide_hwifs[1].selectproc = pc9800_select;
+	}
+}
