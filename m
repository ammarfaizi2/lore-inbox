Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTAEHi1>; Sun, 5 Jan 2003 02:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTAEHi1>; Sun, 5 Jan 2003 02:38:27 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:31236 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S263366AbTAEHiV>; Sun, 5 Jan 2003 02:38:21 -0500
Date: Sun, 5 Jan 2003 01:46:54 -0600 (CST)
Message-Id: <200301050746.h057ksR40850@sullivan.realtime.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix CONFIG_DEVFS=y root=<number>
From: Milton Miller <miltonm@bga.com>
In-Reply-To: <3E169D1F.684A35EC@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init/do_mounts.c: In function `do_read_dir':
init/do_mounts.c:335: warning: `n' might be used uninitialized in this function

and it loops trying to intrepret the directory listing :(

After some searching, I realized the directory contents read in were garbage,
looked at that code closer, and found the cause of the problem:  

 	for (bytes = 0; bytes < len; bytes += n) {
-		n = sys_getdents64(fd, p + n, len - bytes);
+		n = sys_getdents64(fd, p + bytes, len - bytes);


updated patch below:

# Patch from Milton Miller <miltonm@bga.com> 
# Based on discovery work by Adam J. Richter <adam@yggdrasil.com>
# Cleanups by Andrew Morton (akpm@digeo.com)
# 
# There's some init-time code which is supposed to read a devfs directory by
# expanding the bufer until the whole directory fits. But the logic is wrong
# and it only works if the whole directory fits into 512 bytes.
# 
# So fix that up, and also clean up some coding in there, and rationalise the
# duplicated definition of linux_dirent64. 
# --------------------------------------------
#
diff -Nru a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c	Sun Jan  5 01:35:40 2003
+++ b/fs/readdir.c	Sun Jan  5 01:35:40 2003
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/dirent.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
@@ -193,17 +194,6 @@
 out:
 	return error;
 }
-
-/*
- * And even better one including d_type field and 64bit d_ino and d_off.
- */
-struct linux_dirent64 {
-	u64		d_ino;
-	s64		d_off;
-	unsigned short	d_reclen;
-	unsigned char	d_type;
-	char		d_name[0];
-};
 
 #define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
 
diff -Nru a/include/linux/dirent.h b/include/linux/dirent.h
--- a/include/linux/dirent.h	Sun Jan  5 01:35:40 2003
+++ b/include/linux/dirent.h	Sun Jan  5 01:35:40 2003
@@ -16,4 +16,17 @@
 	char		d_name[256];
 };
 
+#ifdef __KERNEL__
+
+struct linux_dirent64 {
+	u64		d_ino;
+	s64		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
+#endif	/* __KERNEL__ */
+
+
 #endif
diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Sun Jan  5 01:35:40 2003
+++ b/init/do_mounts.c	Sun Jan  5 01:35:40 2003
@@ -13,6 +13,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/mount.h>
+#include <linux/dirent.h>
 #include <linux/security.h>
 
 #include <linux/nfs_fs.h>
@@ -324,22 +325,32 @@
 #endif
 
 #ifdef CONFIG_DEVFS_FS
+
+/*
+ * If the dir will fit in *buf, return its length.  If it won't fit, return
+ * zero.  Return -ve on error.
+ */
 static int __init do_read_dir(int fd, void *buf, int len)
 {
 	long bytes, n;
 	char *p = buf;
 	lseek(fd, 0, 0);
 
-	for (bytes = 0, p = buf; bytes < len; bytes += n, p+=n) {
-		n = sys_getdents64(fd, p, len - bytes);
+	for (bytes = 0; bytes < len; bytes += n) {
+		n = sys_getdents64(fd, p + bytes, len - bytes);
 		if (n < 0)
-			return -1;
+			return n;
 		if (n == 0)
 			return bytes;
 	}
 	return 0;
 }
 
+/*
+ * Try to read all of a directory.  Returns the contents at *p, which
+ * is kmalloced memory.  Returns the number of bytes read at *len.  Returns
+ * NULL on error.
+ */
 static void * __init read_dir(char *path, int *len)
 {
 	int size;
@@ -349,7 +360,7 @@
 	if (fd < 0)
 		return NULL;
 
-	for (size = 1<<9; size < (1<<18); size <<= 1) {
+	for (size = 1 << 9; size <= (1 << MAX_ORDER); size <<= 1) {
 		void *p = kmalloc(size, GFP_KERNEL);
 		int n;
 		if (!p)
@@ -361,6 +372,8 @@
 			return p;
 		}
 		kfree(p);
+		if (n == -EINVAL)
+			continue;	/* Try a larger buffer */
 		if (n < 0)
 			break;
 	}
@@ -368,14 +381,6 @@
 	return NULL;
 }
 #endif
-
-struct linux_dirent64 {
-	u64		d_ino;
-	s64		d_off;
-	unsigned short	d_reclen;
-	unsigned char	d_type;
-	char		d_name[0];
-};
 
 static int __init find_in_devfs(char *path, dev_t dev)
 {
