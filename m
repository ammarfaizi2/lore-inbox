Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288327AbSAHU64>; Tue, 8 Jan 2002 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288353AbSAHU6v>; Tue, 8 Jan 2002 15:58:51 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:12815 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S288334AbSAHU5N>; Tue, 8 Jan 2002 15:57:13 -0500
Date: Tue, 8 Jan 2002 15:56:51 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: binfmt_misc module gets stuck
Message-ID: <Pine.LNX.4.43.0201081531180.1744-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alexander!

I'm using Linux 2.4.18pre2 on i686.  I compiled binfmt_misc as module.  I
can load it using modprobe but I cannot unload it.

I wrote some debugging code tracking how the use counter changes.  It 
turns out that the call to kern_mount() in init_misc_binfmt() increases 
the counter when the module is loaded.  kern_umount() is called when the 
module is unloaded, but this code cannot be executed before the use count 
becomes 0, which requires calling kern_umount().

I understand that kern_mount() is supposed to mount the filesystem.  On
the other hand, I scanned the LKML archives and found that
/proc/sys/fs/binfmt_misc is supposed to be mounted from the userspace - it 
is no longer mounted by the kernel itself.

I believe that kern_mount() and kern_umount() are remnants from the time
when the binfmt_misc filesystem was mounted automatically by the kernel.  
Removing them preserves all functionality (I did check it) while allows
unloading binfmt_misc if and only if the binfmt_misc filesystem is not
used for any mounts.

Here's the patch against 2.4.18pre2.

================================
--- linux.orig/fs/binfmt_misc.c
+++ linux/fs/binfmt_misc.c
@@ -693,16 +693,9 @@ static int __init init_misc_binfmt(void)
 {
 	int err = register_filesystem(&bm_fs_type);
 	if (!err) {
-		bm_mnt = kern_mount(&bm_fs_type);
-		err = PTR_ERR(bm_mnt);
-		if (IS_ERR(bm_mnt))
+		err = register_binfmt(&misc_format);
+		if (err) {
 			unregister_filesystem(&bm_fs_type);
-		else {
-			err = register_binfmt(&misc_format);
-			if (err) {
-				unregister_filesystem(&bm_fs_type);
-				kern_umount(bm_mnt);
-			}
 		}
 	}
 	return err;
@@ -712,7 +705,6 @@ static void __exit exit_misc_binfmt(void
 {
 	unregister_binfmt(&misc_format);
 	unregister_filesystem(&bm_fs_type);
-	kern_umount(bm_mnt);
 }
 
 EXPORT_NO_SYMBOLS;
================================

P.S. Similar patch should probaly be applied to fs/devpts/inode.c as well.

-- 
Regards,
Pavel Roskin

