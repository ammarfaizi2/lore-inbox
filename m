Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSASWAe>; Sat, 19 Jan 2002 17:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287537AbSASV7Z>; Sat, 19 Jan 2002 16:59:25 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:56324 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287535AbSASV7K>;
	Sat, 19 Jan 2002 16:59:10 -0500
Date: Sat, 19 Jan 2002 16:59:08 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Andre's IDE Patch (6/7)
Message-ID: <Pine.LNX.4.33.0201191504430.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sixth of seven patches against 2.4.18-pre4, beginning the breakup
of Andre Hedrick's IDE patch into smaller chunks.

Description of patch 6:
This patch touches two files, fs/partitions/Makefile and
fs/partitions/msdos.c.  This was compile tested but not booted.  The Makefile
is simply patched to add msdos.o to the export-objs list, while msdos.c is
changed to work when IDE is modularized.

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre3/fs/partitions/Makefile linux-2.4.18-pre3-ide-rr/fs/partitions/Makefile
--- linux-2.4.18-pre3/fs/partitions/Makefile	Thu Jul 26 19:30:04 2001
+++ linux-2.4.18-pre3-ide-rr/fs/partitions/Makefile	Mon Jan 14 18:28:53 2002
@@ -9,7 +9,7 @@

 O_TARGET := partitions.o

-export-objs := check.o ibm.o
+export-objs := check.o ibm.o msdos.o

 obj-y := check.o

diff -ruN linux-2.4.18-pre3/fs/partitions/msdos.c linux-2.4.18-pre3-ide-rr/fs/partitions/msdos.c
--- linux-2.4.18-pre3/fs/partitions/msdos.c	Thu Oct 11 11:07:07 2001
+++ linux-2.4.18-pre3-ide-rr/fs/partitions/msdos.c	Mon Jan 14 18:28:53 2002
@@ -29,7 +29,13 @@

 #ifdef CONFIG_BLK_DEV_IDE
 #include <linux/ide.h>	/* IDE xlate */
-#endif /* CONFIG_BLK_DEV_IDE */
+#elif defined(CONFIG_BLK_DEV_IDE_MODULE)
+#include <linux/module.h>
+
+int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
+EXPORT_SYMBOL(ide_xlate_1024_hook);
+#define ide_xlate_1024 ide_xlate_1024_hook
+#endif

 #include <asm/system.h>

@@ -468,7 +474,7 @@
  */
 static int handle_ide_mess(struct block_device *bdev)
 {
-#ifdef CONFIG_BLK_DEV_IDE
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 	Sector sect;
 	unsigned char *data;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
@@ -476,6 +482,10 @@
 	int heads = 0;
 	struct partition *p;
 	int i;
+#ifdef CONFIG_BLK_DEV_IDE_MODULE
+	if (!ide_xlate_1024)
+		return 1;
+#endif
 	/*
 	 * The i386 partition handling programs very often
 	 * make partitions end on cylinder boundaries.
@@ -537,7 +547,7 @@
 	/* Flush the cache */
 	invalidate_bdev(bdev, 1);
 	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
-#endif /* CONFIG_BLK_DEV_IDE */
+#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
 	return 1;
 }





