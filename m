Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKRDGR>; Sun, 17 Nov 2002 22:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSKRDGR>; Sun, 17 Nov 2002 22:06:17 -0500
Received: from polomer.sinet.sk ([62.169.169.8]:60687 "EHLO polomer.sinet.sk")
	by vger.kernel.org with ESMTP id <S261339AbSKRDGP>;
	Sun, 17 Nov 2002 22:06:15 -0500
From: Peter Kundrat <kundrat@kundrat.sk>
Date: Mon, 18 Nov 2002 04:12:15 +0100
To: quinlan@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [BUG][PATCH] files on readonly filesystems could be truncated (patch for cramfs)
Message-ID: <20021118031215.GA14047@napri.sk>
Mail-Followup-To: kundrat, quinlan@transmeta.com, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch solves the 2 problems:
1) cramfs is not marked readonly and it is possible to
   truncate files on it. This part is obvious and trivial.
2) Even setting MS_RDONLY in cramfs_read_super is not enough,
   since remount -wno remount still makes it possible (the same
   seems to be valid for all readonly filesystems).
   I solved it implementing super_operations.remount_fs.
   Is it a desired way of solving the problem ? If so,
   i could do the same for the others as well (isofs, romfs).

Although patch was diffed against 2.4.3, it still applies (at least
against 2.4.20-rc1).  Bug is present in 2.4 as well as in 2.5.

        Regards,

                        pkx


-- 
Peter Kundrat
peter@kundrat.sk

diff -ur -x *~ -x *.o -x .* Linux-2.4.3.orig/fs/cramfs/inode.c Linux-2.4.3.isdn.kgdb/fs/cramfs/inode.c
--- Linux-2.4.3.orig/fs/cramfs/inode.c	Fri Apr  6 08:09:07 2001
+++ Linux-2.4.3.isdn.kgdb/fs/cramfs/inode.c	Tue May 15 12:56:32 2001
@@ -192,6 +192,8 @@
 		goto out;
 	}
 
+	sb->s_flags |= MS_RDONLY;
+
 	/* Set it all up.. */
 	sb->s_op	= &cramfs_ops;
 	sb->s_root 	= d_alloc_root(get_cramfs_inode(sb, &super.root));
@@ -212,6 +214,14 @@
 	return 0;
 }
 
+static int cramfs_remount (struct super_block * sb, int * flags, char * data)
+{
+	if (*flags & MS_RDONLY) 
+		return 0;
+	else
+		return -EROFS;
+}
+
 /*
  * Read a cramfs directory entry.
  */
@@ -358,6 +368,7 @@
 
 static struct super_operations cramfs_ops = {
 	statfs:		cramfs_statfs,
+	remount_fs:	cramfs_remount,
 };
 
 static DECLARE_FSTYPE_DEV(cramfs_fs_type, "cramfs", cramfs_read_super);
