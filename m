Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSFHT4U>; Sat, 8 Jun 2002 15:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSFHT4T>; Sat, 8 Jun 2002 15:56:19 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:7432 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317439AbSFHT4Q>;
	Sat, 8 Jun 2002 15:56:16 -0400
From: kuebelr@email.uc.edu
Date: Sat, 8 Jun 2002 15:56:10 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] do_mounts.c - compiler warning, comments, cramfs
Message-Id: <20020608195610.GA21632@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tweaks a few things in do_mounts.c:

-change_floppy() is defined but not used if neither CONFIG_BLK_DEV_RAM
	or CONFIG_BLK_DEV_FD are defined
-since the gzip code is already in the kernel, why not do away w/ the
	BUILD_CRAMDISK stuff and always support compressed images
-one incorrect comment changed
-one repeated NOTE removed

If no one yells at me for this, I will submit it to the patch monkey.

Rob.

--- linux-clean/init/do_mounts.c	Fri Jun  7 23:42:15 2002
+++ linux-dirty/init/do_mounts.c	Sat Jun  8 15:38:52 2002
@@ -16,8 +16,6 @@
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
 
-#define BUILD_CRAMDISK
-
 extern int get_filesystem_list(char * buf);
 
 asmlinkage long sys_mount(char *dev_name, char *dir_name, char *type,
@@ -378,6 +376,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
+#if defined(CONFIG_BLK_DEV_FD) || defined(CONFIG_BLK_DEV_RAM)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;
@@ -405,6 +404,7 @@
 		close(fd);
 	}
 }
+#endif /* CONFIG_BLK_DEV_FD || CONFIG_BLK_DEV_RAM */
 
 #ifdef CONFIG_BLK_DEV_RAM
 
@@ -466,7 +466,7 @@
 	read(fd, buf, size);
 
 	/*
-	 * If it matches the gzip magic numbers, return -1
+	 * If it matches the gzip magic numbers, return 0
 	 */
 	if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {
 		printk(KERN_NOTICE
@@ -548,19 +548,13 @@
 		goto done;
 
 	if (nblocks == 0) {
-#ifdef BUILD_CRAMDISK
 		if (crd_load(in_fd, out_fd) == 0)
 			goto successful_load;
-#else
-		printk(KERN_NOTICE
-		       "RAMDISK: Kernel does not support compressed "
-		       "RAM disk images\n");
-#endif
 		goto done;
 	}
 
 	/*
-	 * NOTE NOTE: nblocks suppose that the blocksize is BLOCK_SIZE, so
+	 * NOTE: nblocks suppose that the blocksize is BLOCK_SIZE, so
 	 * rd_load_image will work only with filesystem BLOCK_SIZE wide!
 	 * So make sure to use 1k blocksize while generating ext2fs
 	 * ramdisk-images.
@@ -860,7 +854,7 @@
 	mount_devfs_fs ();
 }
 
-#ifdef BUILD_CRAMDISK
+#ifdef CONFIG_BLK_DEV_RAM
 
 /*
  * gzip declarations
@@ -1005,4 +999,4 @@
 	return result;
 }
 
-#endif  /* BUILD_CRAMDISK */
+#endif /* CONFIG_BLK_DEV_RAM */
