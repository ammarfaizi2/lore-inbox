Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbREPLsU>; Wed, 16 May 2001 07:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261884AbREPLsK>; Wed, 16 May 2001 07:48:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64213 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261882AbREPLr6>;
	Wed, 16 May 2001 07:47:58 -0400
Date: Wed, 16 May 2001 07:47:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] turn device_init() into an initcall
In-Reply-To: <Pine.GSO.4.21.0105151148580.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0105160741130.24199-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Damn.
/me writes a patch
/me tests and finds an obvious typo
/me fixes and diffs fixed (and tested) version
/me sends the original one.

My apologies. Correct patch (taken between clean tree and
result of make distclean on the tree that gave a kernel
that passes all tests) follows. Please, apply it.
							Al

diff -urN S5-pre2/drivers/block/genhd.c linux-test/drivers/block/genhd.c
--- S5-pre2/drivers/block/genhd.c	Mon Sep 18 01:16:35 2000
+++ linux-test/drivers/block/genhd.c	Wed May 16 05:34:24 2001
@@ -31,7 +31,7 @@
 extern int cpqarray_init(void);
 extern void ieee1394_init(void);
 
-void __init device_init(void)
+int __init device_init(void)
 {
 #ifdef CONFIG_PARPORT
 	parport_init();
@@ -64,4 +64,7 @@
 #ifdef CONFIG_VT
 	console_map_init();
 #endif
+	return 0;
 }
+
+__initcall(device_init);
diff -urN S5-pre2/fs/partitions/check.c linux-test/fs/partitions/check.c
--- S5-pre2/fs/partitions/check.c	Mon Feb 26 14:18:34 2001
+++ linux-test/fs/partitions/check.c	Wed May 16 05:34:24 2001
@@ -33,10 +33,7 @@
 #include "ibm.h"
 #include "ultrix.h"
 
-extern void device_init(void);
 extern int *blk_size[];
-extern void rd_load(void);
-extern void initrd_load(void);
 
 struct gendisk *gendisk_head;
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
@@ -438,19 +435,3 @@
 		blk_size[dev->major] = dev->sizes;
 	}
 }
-
-int __init partition_setup(void)
-{
-	device_init();
-
-#ifdef CONFIG_BLK_DEV_RAM
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start && mount_initrd) initrd_load();
-	else
-#endif
-	rd_load();
-#endif
-	return 0;
-}
-
-__initcall(partition_setup);
diff -urN S5-pre2/init/main.c linux-test/init/main.c
--- S5-pre2/init/main.c	Wed May 16 04:25:48 2001
+++ linux-test/init/main.c	Wed May 16 05:35:06 2001
@@ -638,9 +638,6 @@
  */
 static void __init do_basic_setup(void)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
-	int real_root_mountflags;
-#endif
 
 	/*
 	 * Tell the world that we're going to be the grim
@@ -707,13 +704,6 @@
 	/* Networking initialization needs a process context */ 
 	sock_init();
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	real_root_dev = ROOT_DEV;
-	real_root_mountflags = root_mountflags;
-	if (initrd_start && mount_initrd) root_mountflags &= ~MS_RDONLY;
-	else mount_initrd =0;
-#endif
-
 	start_context_thread();
 	do_initcalls();
 
@@ -724,6 +714,34 @@
 #ifdef CONFIG_PCMCIA
 	init_pcmcia_ds();		/* Do this last */
 #endif
+}
+
+extern void rd_load(void);
+extern void initrd_load(void);
+
+/*
+ * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
+ */
+static void prepare_namespace(void)
+{
+#ifdef CONFIG_BLK_DEV_INITRD
+	int real_root_mountflags = ROOT_DEV;
+	real_root_mountflags = root_mountflags;
+	if (!initrd_start)
+		mount_initrd = 0;
+	if (mount_initrd)
+		root_mountflags &= ~MS_RDONLY;
+	real_root_dev = ROOT_DEV;
+#endif
+
+#ifdef CONFIG_BLK_DEV_RAM
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (mount_initrd)
+		initrd_load();
+	else
+#endif
+	rd_load();
+#endif
 
 	/* Mount the root filesystem.. */
 	mount_root();
@@ -755,6 +773,8 @@
 {
 	lock_kernel();
 	do_basic_setup();
+
+	prepare_namespace();
 
 	/*
 	 * Ok, we have completed the initial bootup, and

