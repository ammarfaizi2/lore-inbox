Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265811AbUEZVST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUEZVST (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUEZVSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:18:18 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:21143 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265811AbUEZVR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:17:56 -0400
Date: Wed, 26 May 2004 22:17:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.7-rc1-bk] NTFS: 2.1.12 release - patch 1/3
In-Reply-To: <Pine.SOL.4.58.0405262214280.15648@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0405262216460.15648@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0405262214280.15648@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1 in the series. It contains the following ChangeSet:

<aia21@cantab.net> (04/05/17 1.1717.9.1)
   NTFS: Add a new address space operations struct, ntfs_mst_aops, for mst
         protected attributes.  This is because the default ntfs_aops do not
         make sense with mst protected data and were they to write anything to
         such an attribute they would cause data corruption so we provide
         ntfs_mst_aops which does not have any write related operations set.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-05-26 22:10:11 +01:00
+++ b/fs/ntfs/ChangeLog	2004-05-26 22:10:11 +01:00
@@ -25,6 +25,14 @@
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.

+2.1.12 - WIP.
+
+	- Add a new address space operations struct, ntfs_mst_aops, for mst
+	  protected attributes.  This is because the default ntfs_aops do not
+	  make sense with mst protected data and were they to write anything to
+	  such an attribute they would cause data corruption so we provide
+	  ntfs_mst_aops which does not have any write related operations set.
+
 2.1.11 - Driver internal cleanups.

 	- Only build logfile.o if building the driver with read-write support.
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-05-26 22:10:11 +01:00
+++ b/fs/ntfs/Makefile	2004-05-26 22:10:11 +01:00
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.11\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.12-WIP\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-05-26 22:10:11 +01:00
+++ b/fs/ntfs/aops.c	2004-05-26 22:10:11 +01:00
@@ -1788,3 +1788,12 @@
 #endif
 };

+/**
+ * ntfs_mst_aops - general address space operations for mst protecteed inodes
+ *		   and attributes
+ */
+struct address_space_operations ntfs_mst_aops = {
+	.readpage	= ntfs_readpage,	/* Fill page with data. */
+	.sync_page	= block_sync_page,	/* Currently, just unplugs the
+						   disk request queue. */
+};
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-05-26 22:10:11 +01:00
+++ b/fs/ntfs/inode.c	2004-05-26 22:10:11 +01:00
@@ -872,7 +872,7 @@
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_dir_inode_ops;
 		vi->i_fop = &ntfs_dir_ops;
-		vi->i_mapping->a_ops = &ntfs_aops;
+		vi->i_mapping->a_ops = &ntfs_mst_aops;
 	} else {
 		/* It is a file. */
 		reinit_attr_search_ctx(ctx);
@@ -1249,7 +1249,10 @@
 	/* Setup the operations for this attribute inode. */
 	vi->i_op = NULL;
 	vi->i_fop = NULL;
-	vi->i_mapping->a_ops = &ntfs_aops;
+	if (NInoMstProtected(ni))
+		vi->i_mapping->a_ops = &ntfs_mst_aops;
+	else
+		vi->i_mapping->a_ops = &ntfs_aops;

 	if (!NInoCompressed(ni))
 		vi->i_blocks = ni->allocated_size >> 9;
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	2004-05-26 22:10:11 +01:00
+++ b/fs/ntfs/ntfs.h	2004-05-26 22:10:11 +01:00
@@ -62,6 +62,7 @@
 /* The various operations structs defined throughout the driver files. */
 extern struct super_operations ntfs_sops;
 extern struct address_space_operations ntfs_aops;
+extern struct address_space_operations ntfs_mst_aops;
 extern struct address_space_operations ntfs_mft_aops;

 extern struct  file_operations ntfs_file_ops;
