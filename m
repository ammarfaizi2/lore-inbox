Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRECBVx>; Wed, 2 May 2001 21:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRECBVm>; Wed, 2 May 2001 21:21:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9391 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130768AbRECBVf>;
	Wed, 2 May 2001 21:21:35 -0400
Date: Wed, 2 May 2001 21:21:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] turn device_init() into an initcall
Message-ID: <Pine.GSO.4.21.0105022110220.13750-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch below turns device_init() into initcall. Current tree
calls it from fs/partitions/check.c::partitions_setup() - definitely
odd place for that stuff.

	Another thing done by partition_setup() is {init,}rd_load(). I.e.
setting the contents of /dev/ram0 from initrd or floppies. That beast
should be done after _all_ drivers' initialization, indeed - it belongs with
mount_root()/mount_devfs()/etc. I took it to main/init.c - that way
it's guaranteed to be called after all drivers initialization code and
that's where we do the rest of late-boot stuff. partition_setup() is gone
now.

	Patch is against 2.4.5-pre1. Please, apply.
								Al

diff -urN S5-pre1/drivers/block/genhd.c S5-pre1-device_init/drivers/block/genhd.c
--- S5-pre1/drivers/block/genhd.c	Fri Feb 16 18:37:04 2001
+++ S5-pre1-device_init/drivers/block/genhd.c	Wed May  2 21:09:30 2001
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
diff -urN S5-pre1/fs/partitions/check.c S5-pre1-device_init/fs/partitions/check.c
--- S5-pre1/fs/partitions/check.c	Thu Feb 22 06:45:26 2001
+++ S5-pre1-device_init/fs/partitions/check.c	Wed May  2 21:09:30 2001
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
diff -urN S5-pre1/init/main.c S5-pre1-device_init/init/main.c
--- S5-pre1/init/main.c	Wed May  2 11:16:38 2001
+++ S5-pre1-device_init/init/main.c	Wed May  2 21:09:30 2001
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
 
@@ -724,6 +714,33 @@
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
@@ -755,6 +772,8 @@
 {
 	lock_kernel();
 	do_basic_setup();
+
+	prepare_namespace();
 
 	/*
 	 * Ok, we have completed the initial bootup, and

