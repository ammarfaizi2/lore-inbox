Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQLRTCw>; Mon, 18 Dec 2000 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130688AbQLRTCm>; Mon, 18 Dec 2000 14:02:42 -0500
Received: from 213-123-72-131.btconnect.com ([213.123.72.131]:41476 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129927AbQLRTCb>;
	Mon, 18 Dec 2000 14:02:31 -0500
Date: Mon, 18 Dec 2000 18:31:59 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: torvalds@transmeta.com, Andries.Brouwer@cwi.nl,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: [final] Re: [patch-2.4.0-test13-pre3] rootfs (2nd attempt)
In-Reply-To: <200012181823.eBIINRo28087@webber.adilger.net>
Message-ID: <Pine.LNX.4.21.0012181830020.1063-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Andreas Dilger wrote:
> If I could add one thing here (we have had a 2.2 patch like this for testing
> with ext3) - if you specify the rootfstype parameter don't use the "quiet"
> option to read_super, so you know why it couldn't mount a specific filesystem
> as root, and/or print rootfs type in the panic message.

Agree completely.

Here is the hopefully final version. Sorry, Linus, I thought the first
version was final :) Looks like I have missed a couple of very useful
things... Thanks to all who commented!

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
+++ rootfs/fs/super.c	Mon Dec 18 15:03:44 2000
@@ -18,6 +18,7 @@
  *    Torbj�rn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
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
+	if (n > 1 && n < 32)
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
+  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,0);
+			if (sb)
+				goto mount_it;
+		} 
+		/* don't try others if type given explicitly, same behaviour as mount(8) */
+		goto fail;
+	}
 	read_lock(&file_systems_lock);
 	for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
   		if (!(fs_type->fs_flags & FS_REQUIRES_DEV))
@@ -1593,6 +1621,7 @@
 		put_filesystem(fs_type);
 	}
 	read_unlock(&file_systems_lock);
+fail:
 	panic("VFS: Unable to mount root %s on %s", *rootfs ? rootfs : "fs", kdevname(ROOT_DEV));
 
 mount_it:

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
