Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292324AbSBYVwe>; Mon, 25 Feb 2002 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292321AbSBYVwU>; Mon, 25 Feb 2002 16:52:20 -0500
Received: from mail2.ameuro.de ([62.208.90.8]:36046 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S292320AbSBYVv6>;
	Mon, 25 Feb 2002 16:51:58 -0500
Date: Mon, 25 Feb 2002 22:51:23 +0100
From: Anders Larsen <anders@alarsen.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] qnx4fs (against kernel 2.4.18)
Message-ID: <20020225225123.A2198@errol.alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below replaces the check for the QNX boot-sector signature
by a check for another signature in the superblock (the (invariant)
name of the root dir) - this allows us to mount partitions created
with QNX 6.1 (that don't have the boot-sector signature we used to
check for) without breaking QNX 4 functionality.

I've also updated Configure.help to reflect the fact that QNX6 uses
the same file-system as QNX4 and have removed the EXPERIMENTAL tag
from the read-only part (apart from a complete system hang in 2.4.8/9
there have been no severe bugs reported since 2.4.0, so I think that
move is appropriate now).

The patch doesn't touch any code outside the qnx4 file-system.

Cheers
  Anders (maintainer)

>>> patch against 2.4.18 >>>
diff -u --new-file --recursive linux-2.4.18/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.18/Documentation/Configure.help	Wed Jan 30 21:10:47 2002
+++ linux/Documentation/Configure.help	Wed Jan 30 21:23:58 2002
@@ -14674,10 +14674,12 @@
 
 QNX4 file system support (read only)
 CONFIG_QNX4FS_FS
-  This is the file system used by the operating system QNX 4. Say Y if
-  you intend to mount QNX hard disks or floppies. Unless you say Y to
-  "QNX4FS read-write support" below, you will only be able to read
-  these file systems.
+  This is the file system used by the real-time operating systems
+  QNX 4 and QNX 6 (the latter is also called QNX RTP).
+  Further information is available at <http://www.qnx.com/>.
+  Say Y if you intend to mount QNX hard disks or floppies.
+  Unless you say Y to "QNX4FS read-write support" below, you will
+  only be able to read these file systems.
 
   This file system support is also available as a module ( = code
   which can be inserted in and removed from the running kernel
@@ -14691,6 +14693,9 @@
 QNX4FS write support (DANGEROUS)
 CONFIG_QNX4FS_RW
   Say Y if you want to test write support for QNX4 file systems.
+
+  It's currently broken, so for now:
+  answer N.
 
 Kernel automounter support
 CONFIG_AUTOFS_FS
diff -u --new-file --recursive linux-2.4.18/fs/Config.in linux/fs/Config.in
--- linux-2.4.18/fs/Config.in	Wed Jan 30 21:10:50 2002
+++ linux/fs/Config.in	Wed Jan 30 21:03:50 2002
@@ -71,7 +71,7 @@
 # breaks.
 dep_bool '/dev/pts file system for Unix98 PTYs' CONFIG_DEVPTS_FS $CONFIG_UNIX98_PTYS
 
-dep_tristate 'QNX4 file system support (read only) (EXPERIMENTAL)' CONFIG_QNX4FS_FS $CONFIG_EXPERIMENTAL
+tristate 'QNX4 file system support (read only)' CONFIG_QNX4FS_FS
 dep_mbool '  QNX4FS write support (DANGEROUS)' CONFIG_QNX4FS_RW $CONFIG_QNX4FS_FS $CONFIG_EXPERIMENTAL
 
 tristate 'ROM file system support' CONFIG_ROMFS_FS
diff -u --new-file --recursive linux-2.4.18/fs/qnx4/BUGS linux/fs/qnx4/BUGS
--- linux-2.4.18/fs/qnx4/BUGS	Thu Dec 23 02:38:27 1999
+++ linux/fs/qnx4/BUGS	Thu Jan  1 01:00:00 1970
@@ -1,30 +0,0 @@
-Last update: 1999-12-23
-
-- Fragmented files and directories were incorrectly handled.
-  Fixed 1999-12-23, Anders.
-
-- readdir sometimes returned the same dir entry more than once.
-  Fixed 1999-12-13, Anders.
-
-- File names with a length of exactly 16 chars were handled incorrectly.
-  Fixed 1999-12-11, Anders.
-
-- Files in a subdir can't be accessed, I think that the inode information
-  is not correctly copied at some point. Solved 06-06-1998, Richard.
-  
-- At some point the mounted device can't be unmounted. I think that somewhere
-  in the code a buffer is not given free.
-
-- Make the '..' entry work, I give it a great chance that the above bug
-  (not given free) has something to do with this one, after a 'ls -l'
-  the mounted device can't be unmounted and that's where the '..' entry
-  is accessed.
-  Seems to be solved 21-06-1998, Frank.
-
-- File read function not correct, after the first block it goes beserk.
-  Solved 21-06-1998, Frank.
-
-- This fs will not work if not built as a module.
-  Solved 25-06-1998, Frank.
-
-- Write/truncate/delete functions don't update the bitmap.
diff -u --new-file --recursive linux-2.4.18/fs/qnx4/TODO linux/fs/qnx4/TODO
--- linux-2.4.18/fs/qnx4/TODO	Thu Dec 23 02:38:27 1999
+++ linux/fs/qnx4/TODO	Thu Jan  1 01:00:00 1970
@@ -1,30 +0,0 @@
-Name       : QNX4 TODO list
-Last update: 1999-12-23
-
-    - Writing is still unsupported (it may compile, but it certainly won't
-      bring you any joy).
-
-    - qnx4_checkroot (inode.c), currently there's a look for the '/' in
-      the root direntry, if so then the current mounted device is a qnx4
-      partition. This has to be rewritten with a look for 'QNX4' in the
-      bootblock, it seems to me the savest way to ensure that the mounted
-      device is in fact a QNX4 partition.
-      Done 20-06-1998, Frank. But some disks (like QNX install floppies)
-      don't have 'QNX4' in their bootblock.
-      
-    - Bitmap functions. To find out the free space, largest free block, etc.
-      Partly done (RO), Richard, 05/06/1998. Optimized 20-06-1998, Frank.
-    
-    - Complete write, unlink and truncate functions : the bitmap should be
-updated.
-
-    - Porting to linux 2.1.99+ with dcache support. 20-06-1998, Frank.
-    
-    - Don't rewrite the file_read function : use the generic_file_read hook,
-      and write readpage instead. Done on 21-06-1998, Frank.
-
-    - Write dinit and dcheck.
-
-    - Solving the bugs.
-    
-    - Use le32_to_cpu and vice-versa for portability.
diff -u --new-file --recursive linux-2.4.18/fs/qnx4/inode.c linux/fs/qnx4/inode.c
--- linux-2.4.18/fs/qnx4/inode.c	Wed Jan 30 21:10:50 2002
+++ linux/fs/qnx4/inode.c	Wed Jan 30 21:01:18 2002
@@ -351,25 +351,18 @@
 	s->s_blocksize = QNX4_BLOCK_SIZE;
 	s->s_blocksize_bits = QNX4_BLOCK_SIZE_BITS;
 
-	/* Check the boot signature. Since the qnx4 code is
+	/* Check the superblock signature. Since the qnx4 code is
 	   dangerous, we should leave as quickly as possible
 	   if we don't belong here... */
-	bh = sb_bread(s, 0);
+	bh = sb_bread(s, 1);
 	if (!bh) {
-		printk("qnx4: unable to read the boot sector\n");
+		printk("qnx4: unable to read the superblock\n");
 		goto outnobh;
 	}
-	if ( memcmp( (char*)bh->b_data + 4, "QNX4FS", 6 ) ) {
+	if ( le32_to_cpu( *(__u32*)bh->b_data ) != QNX4_SUPER_MAGIC ) {
 		if (!silent)
-			printk("qnx4: wrong fsid in boot sector.\n");
+			printk("qnx4: wrong fsid in superblock sector.\n");
 		goto out;
-	}
-	brelse(bh);
-
-	bh = sb_bread(s, 1);
-	if (!bh) {
-		printk("qnx4: unable to read the superblock\n");
-		goto outnobh;
 	}
 	s->s_op = &qnx4_sops;
 	s->s_magic = QNX4_SUPER_MAGIC;

<<< end of patch <<<
