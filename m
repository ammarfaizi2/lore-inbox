Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRPnR>; Mon, 18 Dec 2000 10:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLRPnG>; Mon, 18 Dec 2000 10:43:06 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:47364 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129260AbQLRPmw> convert rfc822-to-8bit; Mon, 18 Dec 2000 10:42:52 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <14910.10581.542721.76419@wire.cadcamlab.org>
Date: Mon, 18 Dec 2000 09:12:21 -0600 (CST)
To: Tigran Aivazian <tigran@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
In-Reply-To: <20001218064513.G3199@cadcamlab.org>
	<Pine.LNX.4.21.0012181323410.840-100000@penguin.homenet>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tigran Aivazian]
> no, because it would cause a "spurious" call to get_fs_type("") which
> we don't want to happen (by default i.e. -- if user _really_ wants it
> that is ok). The default of "ext2" is fine.

I still disagree -- super.c is no place to dictate the default root
filesystem.  And I agree with Andries that 'rootfs=' is confusing.

Peter

--- 2.4.0test13pre3+rootfs/fs/super.c~	Mon Dec 18 09:06:47 2000
+++ 2.4.0test13pre3+rootfs/fs/super.c	Mon Dec 18 09:09:48 2000
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
@@ -1597,7 +1597,8 @@
 		goto mount_it;
 	}
 
-	fs_type = get_fs_type(rootfs);
+	if (*rootfstype)
+		fs_type = get_fs_type(rootfstype);
 	if (fs_type) {
   		sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
 		if (sb)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
