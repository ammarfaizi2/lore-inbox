Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263735AbTCUTVz>; Fri, 21 Mar 2003 14:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263762AbTCUTUn>; Fri, 21 Mar 2003 14:20:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48004
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263735AbTCUTU3>; Fri, 21 Mar 2003 14:20:29 -0500
Date: Fri, 21 Mar 2003 20:35:45 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212035.h2LKZjsb026401@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ide-default driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the first of a set of changes to make DRIVER(drive)!=NULL an
invariant

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-default.c linux-2.5.65-ac2/drivers/ide/ide-default.c
--- linux-2.5.65/drivers/ide/ide-default.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac2/drivers/ide/ide-default.c	2003-03-07 23:01:51.000000000 +0000
@@ -0,0 +1,71 @@
+/*
+ *	ide-default		-	Driver for unbound ide devices
+ *
+ *	This provides a clean way to bind a device to default operations
+ *	by having an actual driver class that rather than special casing
+ *	"no driver" all over the IDE code
+ *
+ *	Copyright (C) 2003, Red Hat <alan@redhat.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/major.h>
+#include <linux/errno.h>
+#include <linux/genhd.h>
+#include <linux/slab.h>
+#include <linux/cdrom.h>
+#include <linux/ide.h>
+
+#include <asm/byteorder.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/unaligned.h>
+#include <asm/bitops.h>
+
+#define IDEDEFAULT_VERSION	"0.9.newide"
+/*
+ *	Driver initialization.
+ */
+
+static int idedefault_attach(ide_drive_t *drive);
+
+/*
+ *	IDE subdriver functions, registered with ide.c
+ *
+ *	idedefault *must* support DMA because it will be
+ *	attached before the other drivers are loaded and
+ *	we don't want to lose the DMA status at probe
+ *	time.
+ */
+
+ide_driver_t idedefault_driver = {
+	.name		=	"ide-default",
+	.version	=	IDEDEFAULT_VERSION,
+	.attach		=	idedefault_attach,
+	.supports_dma	=	1,
+	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
+};
+
+static int idedefault_attach (ide_drive_t *drive)
+{
+	if (ide_register_subdriver(drive,
+			&idedefault_driver, IDE_SUBDRIVER_VERSION)) {
+		printk(KERN_ERR "ide-default: %s: Failed to register the "
+			"driver with ide.c\n", drive->name);
+		return 1;
+	}
+	return 0;
+}
+
+MODULE_DESCRIPTION("IDE Default Driver");
+
+MODULE_LICENSE("GPL");
