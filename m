Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131682AbQLRPxh>; Mon, 18 Dec 2000 10:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131663AbQLRPxT>; Mon, 18 Dec 2000 10:53:19 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:51204 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130770AbQLRPxN>; Mon, 18 Dec 2000 10:53:13 -0500
Date: Mon, 18 Dec 2000 09:22:19 -0600
To: Andries.Brouwer@cwi.nl
Cc: tigran@veritas.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
Message-ID: <20001218092219.H3199@cadcamlab.org>
In-Reply-To: <UTC200012181417.PAA167011.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200012181417.PAA167011.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Dec 18, 2000 at 03:17:10PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Andries Brouwer]
> (i) I prefer "rootfstype". Indeed, "rootfs" is ambiguous.
> It gives some property of the root filesystem, but which?

> (ii) It is a bad idea to arbitrarily select "ext2".

> (iii) [...] Thus, if the boot option rootfstype is given, I prefer a
> boot failure over a kernel attempt to try all filesystems it knows

Agreed on all counts.

Peter

--- test13pre3+rootfs/fs/super.c~	Mon Dec 18 09:06:47 2000
+++ test13pre3+rootfs/fs/super.c	Mon Dec 18 09:18:02 2000
@@ -18,7 +18,7 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
- *  Added rootfs boot param. used by mount_root(): Tigran Aivazian. Dec 2000.
+ *  Added rootfstype boot param. used by mount_root(): Tigran Aivazian. Dec 2000.
  */
 
 #include <linux/config.h>
@@ -59,11 +59,11 @@
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
 
-/* this can be set at boot time, e.g. rootfs=ext2 
+/* this can be set at boot time, e.g. rootfstype=ext2 
  * if set to invalid value or if read_super() fails on the specified
  * filesystem type then mount_root() will go through all registered filesystems.
  */
-static char rootfs[128] __initdata = "ext2";
+static char rootfstype[32] __initdata = "";
 
 int nr_super_blocks;
 int max_super_blocks = NR_SUPER;
@@ -90,11 +90,11 @@
 	int n = strlen(line) + 1;
 
 	if (n > 1 && n < 128)
-		strncpy(rootfs, line, n);
+		strncpy(rootfstype, line, n);
 	return 1;
 }
 
-__setup("rootfs=", rootfs_setup);
+__setup("rootfstype=", rootfs_setup);
 
 /* WARNING: This can be used only if we _already_ own a reference */
 static void get_filesystem(struct file_system_type *fs)
@@ -1479,7 +1479,7 @@
 
 void __init mount_root(void)
 {
-	struct file_system_type * fs_type;
+	struct file_system_type * fs_type = NULL;
 	struct super_block * sb;
 	struct vfsmount *vfsmnt;
 	struct block_device *bdev = NULL;
@@ -1597,11 +1597,15 @@
 		goto mount_it;
 	}
 
-	fs_type = get_fs_type(rootfs);
-	if (fs_type) {
-  		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
-		if (sb)
-			goto mount_it;
+	if (*rootfstype) {
+		fs_type = get_fs_type(rootfstype);
+		if (fs_type) {
+  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
+			if (sb)
+				goto mount_it;
+		}
+		/* do NOT try all filesystems - user explicitly wanted this one */
+		goto fail;
 	}
 	read_lock(&file_systems_lock);
 	for (fs_type = file_systems ; fs_type ; fs_type = fs_type->next) {
@@ -1617,6 +1621,7 @@
 		put_filesystem(fs_type);
 	}
 	read_unlock(&file_systems_lock);
+fail:
 	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
 
 mount_it:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
