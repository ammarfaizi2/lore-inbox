Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282176AbRLQSvs>; Mon, 17 Dec 2001 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282187AbRLQSvk>; Mon, 17 Dec 2001 13:51:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25827 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282176AbRLQSva>;
	Mon, 17 Dec 2001 13:51:30 -0500
Date: Mon, 17 Dec 2001 13:51:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Martin A. Brooks" <martin@jtrix.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.5.1 compile error
In-Reply-To: <1008583978.6860.8.camel@unhygienix>
Message-ID: <Pine.GSO.4.21.0112171345040.3992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Next bunch of cleanups should fix the problem (bogus
ifdefs in blk.h - hell knows where they came from).

	Contents: bunch of __setup() and corresponding variables
moved from rd.c to do_mounts.c.  #includes in both trimmed down.

This stuff (rd_doload, rd_prompt, rd_image_start) used to be needed
in rd.c, but now all relevant code is in do_mounts.c.

Please, apply.

diff -urN C1-pre11-floppy/arch/ppc/kernel/m8xx_setup.c C1-pre11-misc/arch/ppc/kernel/m8xx_setup.c
--- C1-pre11-floppy/arch/ppc/kernel/m8xx_setup.c	Fri Nov 16 13:10:08 2001
+++ C1-pre11-misc/arch/ppc/kernel/m8xx_setup.c	Sun Dec 16 15:11:46 2001
@@ -55,12 +55,6 @@
 
 extern void m8xx_ide_init(void);
 
-#ifdef CONFIG_BLK_DEV_RAM
-extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
-extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
-extern int rd_image_start;	/* starting block # of image */
-#endif
-
 extern unsigned long find_available_memory(void);
 extern void m8xx_cpm_reset(uint);
 
diff -urN C1-pre11-floppy/arch/ppc/kernel/prep_setup.c C1-pre11-misc/arch/ppc/kernel/prep_setup.c
--- C1-pre11-floppy/arch/ppc/kernel/prep_setup.c	Fri Nov 16 13:10:08 2001
+++ C1-pre11-misc/arch/ppc/kernel/prep_setup.c	Sun Dec 16 15:11:46 2001
@@ -111,12 +111,6 @@
 extern int probingmem;
 extern unsigned long loops_per_jiffy;
 
-#ifdef CONFIG_BLK_DEV_RAM
-extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
-extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
-extern int rd_image_start;	/* starting block # of image */
-#endif
-
 #ifdef CONFIG_SOUND_MODULE
 EXPORT_SYMBOL(ppc_cs4232_dma);
 EXPORT_SYMBOL(ppc_cs4232_dma2);
diff -urN C1-pre11-floppy/drivers/block/rd.c C1-pre11-misc/drivers/block/rd.c
--- C1-pre11-floppy/drivers/block/rd.c	Thu Dec 13 02:56:10 2001
+++ C1-pre11-misc/drivers/block/rd.c	Sun Dec 16 15:11:46 2001
@@ -43,26 +43,12 @@
  */
 
 #include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/hdreg.h>
 #include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
 #include <linux/slab.h>
-#include <linux/ioctl.h>
-#include <linux/fd.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
-#include <linux/smp_lock.h>
-
-#include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/byteorder.h>
-
-extern void wait_for_keypress(void);
 
 /*
  * 35 has been officially registered as the RAMDISK major number, but
@@ -79,6 +65,8 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 static int initrd_users;
 static spinlock_t initrd_users_lock = SPIN_LOCK_UNLOCKED;
+unsigned long initrd_start, initrd_end;
+int initrd_below_start_ok;
 #endif
 
 /* Various static variables go here.  Most are used only in the RAM disk code.
@@ -111,70 +99,6 @@
  */
 int rd_blocksize = BLOCK_SIZE;			/* blocksize of the RAM disks */
 
-#ifndef MODULE
-
-int rd_doload;			/* 1 = load RAM disk, 0 = don't load */
-int rd_prompt = 1;		/* 1 = prompt for RAM disk, 0 = don't prompt */
-int rd_image_start;		/* starting block # of image */
-#ifdef CONFIG_BLK_DEV_INITRD
-unsigned long initrd_start, initrd_end;
-int mount_initrd = 1;		/* zero if initrd should not be mounted */
-int initrd_below_start_ok;
-
-static int __init no_initrd(char *str)
-{
-	mount_initrd = 0;
-	return 1;
-}
-
-__setup("noinitrd", no_initrd);
-
-#endif
-
-static int __init ramdisk_start_setup(char *str)
-{
-	rd_image_start = simple_strtol(str,NULL,0);
-	return 1;
-}
-
-static int __init load_ramdisk(char *str)
-{
-	rd_doload = simple_strtol(str,NULL,0) & 3;
-	return 1;
-}
-
-static int __init prompt_ramdisk(char *str)
-{
-	rd_prompt = simple_strtol(str,NULL,0) & 1;
-	return 1;
-}
-
-static int __init ramdisk_size(char *str)
-{
-	rd_size = simple_strtol(str,NULL,0);
-	return 1;
-}
-
-static int __init ramdisk_size2(char *str)
-{
-	return ramdisk_size(str);
-}
-
-static int __init ramdisk_blocksize(char *str)
-{
-	rd_blocksize = simple_strtol(str,NULL,0);
-	return 1;
-}
-
-__setup("ramdisk_start=", ramdisk_start_setup);
-__setup("load_ramdisk=", load_ramdisk);
-__setup("prompt_ramdisk=", prompt_ramdisk);
-__setup("ramdisk=", ramdisk_size);
-__setup("ramdisk_size=", ramdisk_size2);
-__setup("ramdisk_blocksize=", ramdisk_blocksize);
-
-#endif
-
 /*
  * Copyright (C) 2000 Linus Torvalds.
  *               2000 Transmeta Corp.
@@ -492,7 +416,7 @@
 }
 
 /* This is the registration and initialization section of the RAM disk driver */
-int __init rd_init (void)
+static int __init rd_init (void)
 {
 	int		i;
 
@@ -548,7 +472,28 @@
 module_init(rd_init);
 module_exit(rd_cleanup);
 
-/* loadable module support */
+/* options - nonmodular */
+#ifndef MODULE
+static int __init ramdisk_size(char *str)
+{
+	rd_size = simple_strtol(str,NULL,0);
+	return 1;
+}
+static int __init ramdisk_size2(char *str)	/* kludge */
+{
+	return ramdisk_size(str);
+}
+static int __init ramdisk_blocksize(char *str)
+{
+	rd_blocksize = simple_strtol(str,NULL,0);
+	return 1;
+}
+__setup("ramdisk=", ramdisk_size);
+__setup("ramdisk_size=", ramdisk_size2);
+__setup("ramdisk_blocksize=", ramdisk_blocksize);
+#endif
+
+/* options - modular */
 MODULE_PARM     (rd_size, "1i");
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 MODULE_PARM     (rd_blocksize, "i");
diff -urN C1-pre11-floppy/include/linux/blk.h C1-pre11-misc/include/linux/blk.h
--- C1-pre11-floppy/include/linux/blk.h	Thu Dec 13 02:56:16 2001
+++ C1-pre11-misc/include/linux/blk.h	Sun Dec 16 15:11:46 2001
@@ -20,7 +20,6 @@
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
 extern unsigned long initrd_start,initrd_end;
-extern int mount_initrd; /* zero if initrd should not be mounted */
 extern int initrd_below_start_ok; /* 1 if it is not an error if initrd_start < memory_start */
 extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
 extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
diff -urN C1-pre11-floppy/init/do_mounts.c C1-pre11-misc/init/do_mounts.c
--- C1-pre11-floppy/init/do_mounts.c	Sun Dec 16 15:28:19 2001
+++ C1-pre11-misc/init/do_mounts.c	Sun Dec 16 15:28:32 2001
@@ -3,12 +3,8 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/unistd.h>
-#include <linux/string.h>
 #include <linux/ctype.h>
-#include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <linux/blk.h>
-#include <linux/tty.h>
 #include <linux/fd.h>
 
 #include <linux/nfs_fs.h>
@@ -18,8 +14,6 @@
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
 
-#include <asm/uaccess.h>
-
 #define BUILD_CRAMDISK
 
 extern int get_filesystem_list(char * buf);
@@ -38,12 +32,21 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
-#endif
-#ifdef CONFIG_BLK_DEV_RAM
-extern int rd_doload;
+static int __initdata mount_initrd = 1;
+
+static int __init no_initrd(char *str)
+{
+	mount_initrd = 0;
+	return 1;
+}
+
+__setup("noinitrd", no_initrd);
 #else
-static int rd_doload = 0;
+static int __initdata mount_initrd = 0;
 #endif
+
+int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
+
 int root_mountflags = MS_RDONLY | MS_VERBOSE;
 static char root_device_name[64];
 
@@ -52,6 +55,13 @@
 
 static int do_devfs = 0;
 
+static int __init load_ramdisk(char *str)
+{
+	rd_doload = simple_strtol(str,NULL,0) & 3;
+	return 1;
+}
+__setup("load_ramdisk=", load_ramdisk);
+
 static int __init readonly(char *str)
 {
 	if (*str)
@@ -371,6 +381,24 @@
 
 #ifdef CONFIG_BLK_DEV_RAM
 
+int __initdata rd_prompt = 1;	/* 1 = prompt for RAM disk, 0 = don't prompt */
+
+static int __init prompt_ramdisk(char *str)
+{
+	rd_prompt = simple_strtol(str,NULL,0) & 1;
+	return 1;
+}
+__setup("prompt_ramdisk=", prompt_ramdisk);
+
+int __initdata rd_image_start;		/* starting block # of image */
+
+static int __init ramdisk_start_setup(char *str)
+{
+	rd_image_start = simple_strtol(str,NULL,0);
+	return 1;
+}
+__setup("ramdisk_start=", ramdisk_start_setup);
+
 static int __init crd_load(int in_fd, int out_fd);
 
 /*
@@ -588,7 +616,6 @@
 static int __init rd_load_disk(int n)
 {
 #ifdef CONFIG_BLK_DEV_RAM
-	extern int rd_prompt;
 	if (rd_prompt)
 		change_floppy("root floppy disk to be loaded into RAM disk");
 	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n), NULL);
@@ -715,13 +742,10 @@
  */
 void prepare_namespace(void)
 {
-	int do_initrd = 0;
 	int is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (!initrd_start)
 		mount_initrd = 0;
-	if (mount_initrd)
-		do_initrd = 1;
 	real_root_dev = ROOT_DEV;
 #endif
 	sys_mkdir("/dev", 0700);
@@ -732,7 +756,7 @@
 #endif
 
 	create_dev("/dev/root", ROOT_DEV, NULL);
-	if (do_initrd) {
+	if (mount_initrd) {
 		if (initrd_load() && ROOT_DEV != MKDEV(RAMDISK_MAJOR, 0)) {
 			handle_initrd();
 			goto out;

