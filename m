Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132977AbRBEOy1>; Mon, 5 Feb 2001 09:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132998AbRBEOyR>; Mon, 5 Feb 2001 09:54:17 -0500
Received: from [62.172.234.2] ([62.172.234.2]:33380 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S132995AbRBEOyJ>;
	Mon, 5 Feb 2001 09:54:09 -0500
Date: Mon, 5 Feb 2001 14:56:20 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.2-pre1] rootfs boot parameter
Message-ID: <Pine.LNX.4.21.0102051453410.1452-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch adds "rootfs" boot parameter which selects the filesystem type
for the root filesystem. Useful (nay, live-saving :) to distinguish
between filesystems which cannot detect damage to their structural
integrity. E.g. ext2 cannot detect if the block device has had another
filesystem made on it if it's superblock is left intact.

Regards,
Tigran

diff -urN -X ../dontdiff linux/Documentation/kernel-parameters.txt rootfs/Documentation/kernel-parameters.txt
--- linux/Documentation/kernel-parameters.txt	Sat Dec 30 19:23:13 2000
+++ rootfs/Documentation/kernel-parameters.txt	Mon Feb  5 13:51:16 2001
@@ -479,7 +479,10 @@
 
 	ro		[KNL] Mount root device read-only on boot.
 
-	root=		[KNL] root filesystem.
+	root=		[KNL] Mount root filesystem on specified (as hex or "/dev/XXX") device.
+
+	rootfs=		[KNL] Use filesystem type specified (e.g. rootfs=ext2) for root.
+ 
 
 	rw		[KNL] Mount root device read-write on boot.
 
diff -urN -X ../dontdiff linux/fs/super.c rootfs/fs/super.c
--- linux/fs/super.c	Tue Jan 16 04:53:11 2001
+++ rootfs/fs/super.c	Mon Feb  5 13:54:08 2001
@@ -18,6 +18,7 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
+ *  Added rootfs boot param. used by mount_root(): Tigran Aivazian. Feb 2001.
  */
 
 #include <linux/config.h>
@@ -59,6 +60,12 @@
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
 
+/* this can be set at boot time, e.g. rootfs=ext2 
+ * if set to an invalid value or if read_super() fails on the specified
+ * filesystem type then mount_root() will panic
+ */
+static char rootfs[32] __initdata = "";
+
 int nr_super_blocks;
 int max_super_blocks = NR_SUPER;
 LIST_HEAD(super_blocks);
@@ -79,6 +86,17 @@
 static struct file_system_type *file_systems;
 static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
 
+static int __init rootfs_setup(char *line)
+{
+	int n = strlen(line) + 1;
+
+	if (n > 1 && n <= sizeof(rootfs))
+		strncpy(rootfs, line, n);
+	return 1;
+}
+
+__setup("rootfs=", rootfs_setup);
+
 /* WARNING: This can be used only if we _already_ own a reference */
 static void get_filesystem(struct file_system_type *fs)
 {
@@ -1577,6 +1595,16 @@
 		goto mount_it;
 	}
 
+	if (*rootfs) {
+		fs_type = get_fs_type(rootfs);
+		if (fs_type) {
+  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
+			if (sb)
+				goto mount_it;
+		} 
+		/* don't try others if type given explicitly, same behaviour as mount(8) */
+		goto fail;
+	}
 	read_lock(&file_systems_lock);
 	for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
   		if (!(fs_type->fs_flags & FS_REQUIRES_DEV))
@@ -1591,7 +1619,8 @@
 		put_filesystem(fs_type);
 	}
 	read_unlock(&file_systems_lock);
-	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
+fail:
+	panic("VFS: Unable to mount root %s on %s", *rootfs ? rootfs : "fs", kdevname(ROOT_DEV));
 
 mount_it:
 	printk ("VFS: Mounted root (%s filesystem)%s.\n",

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
