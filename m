Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316422AbSETW1O>; Mon, 20 May 2002 18:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316423AbSETW1N>; Mon, 20 May 2002 18:27:13 -0400
Received: from imladris.infradead.org ([194.205.184.45]:40965 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316422AbSETW1M>; Mon, 20 May 2002 18:27:12 -0400
Date: Mon, 20 May 2002 23:27:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bfs header move around + warning fix
Message-ID: <20020520232708.A16768@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that bfs no more is included in the big unions in fs.h it makes
sense to move the contents of bfs_fs_i.h and bfs_fs_sb.h to a bfs-private
location.  I've created fs/bfs/bfs.h for that, also merging in bfs_defs.h.

In addition I've changes si_imap to and unsigned long pointer as the bitops
now use that type explicitly.

--- a/fs/bfs/bfs_defs.h	Tue May 21 00:51:18 2002
+++ /dev/null	Thu Dec 13 11:34:58 2001
@@ -1,3 +0,0 @@
-#define printf(format, args...) \
-	printk(KERN_ERR "BFS-fs: %s(): " format, __FUNCTION__, ## args)
-
--- /dev/null	Thu Dec 13 11:34:58 2001
+++ b/fs/bfs/bfs.h	Tue May 21 01:14:18 2002
@@ -0,0 +1,60 @@
+/*
+ *	fs/bfs/bfs.h
+ *	Copyright (C) 1999 Tigran Aivazian <tigran@veritas.com>
+ */
+#ifndef _FS_BFS_BFS_H
+#define _FS_BFS_BFS_H
+
+#include <linux/bfs_fs.h>
+
+/*
+ * BFS file system in-core superblock info
+ */
+struct bfs_sb_info {
+	unsigned long si_blocks;
+	unsigned long si_freeb;
+	unsigned long si_freei;
+	unsigned long si_lf_ioff;
+	unsigned long si_lf_sblk;
+	unsigned long si_lf_eblk;
+	unsigned long si_lasti;
+	unsigned long * si_imap;
+	struct buffer_head * si_sbh;		/* buffer header w/superblock */
+	struct bfs_super_block * si_bfs_sb;	/* superblock in si_sbh->b_data */
+};
+
+/*
+ * BFS file system in-core inode info
+ */
+struct bfs_inode_info {
+	unsigned long i_dsk_ino; /* inode number from the disk, can be 0 */
+	unsigned long i_sblock;
+	unsigned long i_eblock;
+	struct inode vfs_inode;
+};
+
+static inline struct bfs_sb_info *BFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
+static inline struct bfs_inode_info *BFS_I(struct inode *inode)
+{
+	return list_entry(inode, struct bfs_inode_info, vfs_inode);
+}
+
+
+#define printf(format, args...) \
+	printk(KERN_ERR "BFS-fs: %s(): " format, __FUNCTION__, ## args)
+
+
+/* file.c */
+extern struct inode_operations bfs_file_inops;
+extern struct file_operations bfs_file_operations;
+extern struct address_space_operations bfs_aops;
+
+/* dir.c */
+extern struct inode_operations bfs_dir_inops;
+extern struct file_operations bfs_dir_operations;
+
+#endif /* _FS_BFS_BFS_H */
--- a/fs/bfs/dir.c	Mon May 20 15:34:46 2002
+++ b/fs/bfs/dir.c	Tue May 21 01:13:12 2002
@@ -6,10 +6,9 @@
 
 #include <linux/time.h>
 #include <linux/string.h>
-#include <linux/bfs_fs.h>
+#include <linux/fs.h>
 #include <linux/smp_lock.h>
-
-#include "bfs_defs.h"
+#include "bfs.h"
 
 #undef DEBUG
 
--- a/fs/bfs/file.c	Mon May 20 15:34:48 2002
+++ b/fs/bfs/file.c	Tue May 21 01:12:35 2002
@@ -5,9 +5,9 @@
  */
 
 #include <linux/fs.h>
-#include <linux/bfs_fs.h>
+#include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include "bfs_defs.h"
+#include "bfs.h"
 
 #undef DEBUG
 
--- a/fs/bfs/inode.c	Mon May 20 15:34:50 2002
+++ b/fs/bfs/inode.c	Tue May 21 01:12:51 2002
@@ -9,12 +9,10 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/bfs_fs.h>
+#include <linux/fs.h>
 #include <linux/smp_lock.h>
-
 #include <asm/uaccess.h>
-
-#include "bfs_defs.h"
+#include "bfs.h"
 
 MODULE_AUTHOR("Tigran A. Aivazian <tigran@veritas.com>");
 MODULE_DESCRIPTION("SCO UnixWare BFS filesystem for Linux");
--- a/include/linux/bfs_fs.h	Sun Mar 17 12:23:52 2002
+++ b/include/linux/bfs_fs.h	Tue May 21 01:10:35 2002
@@ -6,9 +6,6 @@
 #ifndef _LINUX_BFS_FS_H
 #define _LINUX_BFS_FS_H
 
-#include <linux/bfs_fs_i.h>
-#include <linux/bfs_fs_sb.h>
-
 #define BFS_BSIZE_BITS		9
 #define BFS_BSIZE		(1<<BFS_BSIZE_BITS)
 
@@ -79,26 +76,4 @@
 #define BFS_UNCLEAN(bfs_sb, sb)	\
 	((bfs_sb->s_from != -1) && (bfs_sb->s_to != -1) && !(sb->s_flags & MS_RDONLY))
 
-#ifdef __KERNEL__
-
-/* file.c */
-extern struct inode_operations bfs_file_inops;
-extern struct file_operations bfs_file_operations;
-extern struct address_space_operations bfs_aops;
-
-/* dir.c */
-extern struct inode_operations bfs_dir_inops;
-extern struct file_operations bfs_dir_operations;
-
-static inline struct bfs_sb_info *BFS_SB(struct super_block *sb)
-{
-	return sb->u.generic_sbp;
-}
-
-static inline struct bfs_inode_info *BFS_I(struct inode *inode)
-{
-	return list_entry(inode, struct bfs_inode_info, vfs_inode);
-}
-
-#endif /* __KERNEL__ */
 #endif	/* _LINUX_BFS_FS_H */
--- b/include/linux/bfs_fs_i.h	Tue May 21 00:41:23 2002
+++ /dev/null	Thu Dec 13 11:34:58 2001
@@ -1,21 +0,0 @@
-/*
- *	include/linux/bfs_fs_i.h
- *	Copyright (C) 1999 Tigran Aivazian <tigran@veritas.com>
- */
-
-#ifndef _LINUX_BFS_FS_I
-#define _LINUX_BFS_FS_I
-
-#include <linux/fs.h>
-
-/*
- * BFS file system in-core inode info
- */
-struct bfs_inode_info {
-	unsigned long i_dsk_ino; /* inode number from the disk, can be 0 */
-	unsigned long i_sblock;
-	unsigned long i_eblock;
-	struct inode vfs_inode;
-};
-
-#endif	/* _LINUX_BFS_FS_I */
--- a/include/linux/bfs_fs_sb.h	Tue May 21 00:10:32 2002
+++ /dev/null	Thu Dec 13 11:34:58 2001
@@ -1,25 +0,0 @@
-/*
- *	include/linux/bfs_fs_sb.h
- *	Copyright (C) 1999 Tigran Aivazian <tigran@veritas.com>
- */
-
-#ifndef _LINUX_BFS_FS_SB
-#define _LINUX_BFS_FS_SB
-
-/*
- * BFS file system in-core superblock info
- */
-struct bfs_sb_info {
-	unsigned long si_blocks;
-	unsigned long si_freeb;
-	unsigned long si_freei;
-	unsigned long si_lf_ioff;
-	unsigned long si_lf_sblk;
-	unsigned long si_lf_eblk;
-	unsigned long si_lasti;
-	char * si_imap;
-	struct buffer_head * si_sbh;		/* buffer header w/superblock */
-	struct bfs_super_block * si_bfs_sb;	/* superblock in si_sbh->b_data */
-};
-
-#endif	/* _LINUX_BFS_FS_SB */
