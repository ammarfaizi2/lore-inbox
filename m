Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLSKAG>; Tue, 19 Dec 2000 05:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLSJ74>; Tue, 19 Dec 2000 04:59:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:27506 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129752AbQLSJ7l>;
	Tue, 19 Dec 2000 04:59:41 -0500
Date: Tue, 19 Dec 2000 09:30:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test13-pre3] rootfs (3rd attempt) (fwd)
Message-ID: <Pine.LNX.4.21.0012190929050.826-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please ignore this one _only_ if you have received this message
today already -- it is identical to previous one (resending only because
of email problems)

---------- Forwarded message ----------
Date: Tue, 19 Dec 2000 09:25:08 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test13-pre3] rootfs (3rd attempt)

Hi Linus,

The "final" version of yesterday contained two bugs (thanks to Andreas
Dilger for spotting both of them). This version contains 0 bugs and was
very thoroughly tested (including boundary conditions etc.). Basically, it
is absolutely final, really.

the bugs were a) n < 32 should be n <= sizeof(rootfs) and b) the diff
context of the old panic msg was missing (because I hand-edited the patch
instead of remaking it).

Regards,
Tigran

diff -urN -X dontdiff linux/Documentation/kernel-parameters.txt rootfs/Documentation/kernel-parameters.txt
--- linux/Documentation/kernel-parameters.txt	Tue Sep  5 21:51:14 2000
+++ rootfs/Documentation/kernel-parameters.txt	Mon Dec 18 09:04:06 2000
@@ -473,7 +473,10 @@
 
 	ro		[KNL] Mount root device read-only on boot.
 
-	root=		[KNL] root filesystem.
+	root=		[KNL] Mount root filesystem on specified (as hex or "/dev/XXX") device.
+
+	rootfs=		[KNL] Use filesystem type specified (e.g. rootfs=ext2) for root.
+ 
 
 	rw		[KNL] Mount root device read-write on boot.
 
diff -urN -X dontdiff linux/fs/super.c rootfs/fs/super.c
--- linux/fs/super.c	Tue Dec 12 09:25:22 2000
+++ rootfs/fs/super.c	Tue Dec 19 08:16:32 2000
@@ -18,6 +18,7 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
+ *  Added rootfs boot param. used by mount_root(): Tigran Aivazian. Dec 2000.
  */
 
 #include <linux/config.h>
@@ -58,6 +59,12 @@
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
 
+/* this can be set at boot time, e.g. rootfs=ext2 
+ * if set to invalid value or if read_super() fails on the specified
+ * filesystem type then mount_root() will panic
+ */
+static char rootfs[32] __initdata = "";
+
 int nr_super_blocks;
 int max_super_blocks = NR_SUPER;
 LIST_HEAD(super_blocks);
@@ -78,6 +85,17 @@
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
@@ -1579,6 +1597,16 @@
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
@@ -1593,7 +1621,8 @@
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
