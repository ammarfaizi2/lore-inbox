Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLRMZZ>; Mon, 18 Dec 2000 07:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbQLRMZP>; Mon, 18 Dec 2000 07:25:15 -0500
Received: from 62-6-231-82.btconnect.com ([62.6.231.82]:8452 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129450AbQLRMZE>;
	Mon, 18 Dec 2000 07:25:04 -0500
Date: Mon, 18 Dec 2000 11:56:47 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test13-pre3] rootfs boot param. support
In-Reply-To: <Pine.LNX.4.21.0012111102480.801-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012181150060.840-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

In November last year I wrote support for a new boot parameter called
"rootfs" implementing functionality similar to  UnixWare7, i.e. being
able to specify the filesystem type to try first in mount_root() and if
this fails then go on to the usual loop over all registered filesystems.

At the time it was of pure academical interest (i.e. generally useful to
everybody) but now I realized that it is actually quite critical, i.e.
there exist filesystems (e.g. ext2) which are not able to detect their
structural integrity beyond simple damage to the superblock. So, as a
result, I have kernel panics because it successfully mounts the garbage as
a valid ext2 filesystem simply because the real filesystem on the block
device happens to use the location of the block containing superblock
different than ext2.

Therefore, please consider this tiny patch, tested against
2.4.0-test13-pre3.

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
+++ rootfs/fs/super.c	Mon Dec 18 10:03:31 2000
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
+ * filesystem type then mount_root() will go through all registered filesystems.
+ */
+static char rootfs[128] __initdata = "ext2";
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
+	if (n > 1 && n < 128)
+		strncpy(rootfs, line, n);
+	return 1;
+}
+
+__setup("rootfs=", rootfs_setup);
+
 /* WARNING: This can be used only if we _already_ own a reference */
 static void get_filesystem(struct file_system_type *fs)
 {
@@ -1579,6 +1597,12 @@
 		goto mount_it;
 	}
 
+	fs_type = get_fs_type(rootfs);
+	if (fs_type) {
+  		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
+		if (sb)
+			goto mount_it;
+	}
 	read_lock(&file_systems_lock);
 	for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
   		if (!(fs_type->fs_flags & FS_REQUIRES_DEV))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
