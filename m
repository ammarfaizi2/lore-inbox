Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTADI21>; Sat, 4 Jan 2003 03:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbTADI21>; Sat, 4 Jan 2003 03:28:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:34723 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266527AbTADI2W>;
	Sat, 4 Jan 2003 03:28:22 -0500
Message-ID: <3E169D1F.684A35EC@digeo.com>
Date: Sat, 04 Jan 2003 00:36:47 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: linux-kernel@vger.kernel.org, Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [PATCH] fix CONFIG_DEVFS=y root=<number>
References: <200301040801.h0481cf00212@sullivan.realtime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2003 08:36:47.0620 (UTC) FILETIME=[6B63D440:01C2B3CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller wrote:
> 
> Based on a patch by Adam J. Richter <adam@yggdrasil.com> [1], this fixes
> the problem since 2.5.47 with mounting a devfs=y system with root=<number>
> 
> sys_get_dents64 returns -EINVAL if there is not space for an entry, so
> we need to activate the loop code to expand the buffer.
> 

Yes, I agree.

argh, why did you make me look at that code.  I really shouldn't
do this, but I can't help myself!

How does this look?




Patch from Milton Miller <miltonm@bga.com>

There's some init-time code which is supposed to read a devfs directory by
expanding the bufer until the whole directory fits.  But the logic is wrong
and it only works if the whole directory fits into 512 bytes.

So fix that up, and also clean up some coding in there, and rationalise the
duplicated definition of linux_dirent64.



 fs/readdir.c           |   12 +-----------
 include/linux/dirent.h |   13 +++++++++++++
 init/do_mounts.c       |   29 +++++++++++++++++------------
 3 files changed, 31 insertions(+), 23 deletions(-)

--- 25/init/do_mounts.c~devfs-mount-fix	Sat Jan  4 00:19:53 2003
+++ 25-akpm/init/do_mounts.c	Sat Jan  4 00:33:39 2003
@@ -13,6 +13,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/mount.h>
+#include <linux/dirent.h>
 #include <linux/security.h>
 
 #include <linux/nfs_fs.h>
@@ -324,22 +325,32 @@ static int __init mount_nfs_root(void)
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
+		n = sys_getdents64(fd, p + n, len - bytes);
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
@@ -349,7 +360,7 @@ static void * __init read_dir(char *path
 	if (fd < 0)
 		return NULL;
 
-	for (size = 1<<9; size < (1<<18); size <<= 1) {
+	for (size = 1 << 9; size <= (1 << MAX_ORDER); size <<= 1) {
 		void *p = kmalloc(size, GFP_KERNEL);
 		int n;
 		if (!p)
@@ -361,6 +372,8 @@ static void * __init read_dir(char *path
 			return p;
 		}
 		kfree(p);
+		if (n == -EINVAL)
+			continue;	/* Try a larger buffer */
 		if (n < 0)
 			break;
 	}
@@ -369,14 +382,6 @@ static void * __init read_dir(char *path
 }
 #endif
 
-struct linux_dirent64 {
-	u64		d_ino;
-	s64		d_off;
-	unsigned short	d_reclen;
-	unsigned char	d_type;
-	char		d_name[0];
-};
-
 static int __init find_in_devfs(char *path, dev_t dev)
 {
 #ifdef CONFIG_DEVFS_FS
--- 25/include/linux/dirent.h~devfs-mount-fix	Sat Jan  4 00:20:21 2003
+++ 25-akpm/include/linux/dirent.h	Sat Jan  4 00:20:56 2003
@@ -16,4 +16,17 @@ struct dirent64 {
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
--- 25/fs/readdir.c~devfs-mount-fix	Sat Jan  4 00:21:11 2003
+++ 25-akpm/fs/readdir.c	Sat Jan  4 00:28:08 2003
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/dirent.h>
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
@@ -194,17 +195,6 @@ out:
 	return error;
 }
 
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
-
 #define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
 
 struct getdents_callback64 {

_
