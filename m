Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbUKJOx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUKJOx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbUKJOxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:53:02 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:46721 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261910AbUKJNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:19 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 15/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmb-0006QU-2V@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:09 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 15/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/01 1.2026.53.1)
   NTFS: Make several functions and variables static.  (Adrian Bunk)
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:12 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:12 +00:00
@@ -56,6 +56,11 @@
 	  ntfs_prepare_write().
 	- Remove unused function fs/ntfs/runlist.c::ntfs_rl_merge().  (Adrian
 	  Bunk)
+	- Fix stupid bug in fs/ntfs/attrib.c::ntfs_attr_find() that resulted in
+	  a NULL pointer dereference in the error code path when a corrupt
+	  attribute was found.  (Thanks to Domen Puncer for the bug report.)
+	- Add MODULE_VERSION() to fs/ntfs/super.c.
+	- Make several functions and variables static.  (Adrian Bunk)
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:45:12 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:45:12 +00:00
@@ -348,10 +348,8 @@
  * for it to be read in before we can do the copy.
  *
  * Return 0 on success and -errno on error.
- *
- * WARNING: Do not make this function static! It is used by mft.c!
  */
-int ntfs_readpage(struct file *file, struct page *page)
+static int ntfs_readpage(struct file *file, struct page *page)
 {
 	s64 attr_pos;
 	ntfs_inode *ni, *base_ni;
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-11-10 13:45:12 +00:00
+++ b/fs/ntfs/inode.c	2004-11-10 13:45:12 +00:00
@@ -352,7 +352,7 @@
 	return NULL;
 }
 
-void ntfs_destroy_extent_inode(ntfs_inode *ni)
+static void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
 	BUG_ON(ni->page);
@@ -2133,7 +2133,7 @@
 	}
 }
 
-void __ntfs_clear_inode(ntfs_inode *ni)
+static void __ntfs_clear_inode(ntfs_inode *ni)
 {
 	/* Free all alocated memory. */
 	down_write(&ni->runlist.lock);
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	2004-11-10 13:45:12 +00:00
+++ b/fs/ntfs/ntfs.h	2004-11-10 13:45:12 +00:00
@@ -53,7 +53,6 @@
 extern kmem_cache_t *ntfs_index_ctx_cache;
 
 /* The various operations structs defined throughout the driver files. */
-extern struct super_operations ntfs_sops;
 extern struct address_space_operations ntfs_aops;
 extern struct address_space_operations ntfs_mst_aops;
 
@@ -86,8 +85,6 @@
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
-extern ntfschar *default_upcase;
-extern unsigned long ntfs_nr_upcase_users;
 extern struct semaphore ntfs_lock;
 
 typedef struct {
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-11-10 13:45:12 +00:00
+++ b/fs/ntfs/super.c	2004-11-10 13:45:12 +00:00
@@ -44,6 +44,10 @@
 /* Number of mounted file systems which have compression enabled. */
 static unsigned long ntfs_nr_compression_users;
 
+/* A global default upcase table and a corresponding reference count. */
+static ntfschar *default_upcase = NULL;
+static unsigned long ntfs_nr_upcase_users = 0;
+
 /* Error constants/strings used in inode.c::ntfs_show_options(). */
 typedef enum {
 	/* One of these must be present, default is ON_ERRORS_CONTINUE. */
@@ -2175,7 +2179,7 @@
 /**
  * The complete super operations.
  */
-struct super_operations ntfs_sops = {
+static struct super_operations ntfs_sops = {
 	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
 	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
 	.put_inode	= ntfs_put_inode,	  /* VFS: Called just before
@@ -2592,10 +2596,6 @@
  */
 kmem_cache_t *ntfs_attr_ctx_cache;
 kmem_cache_t *ntfs_index_ctx_cache;
-
-/* A global default upcase table and a corresponding reference count. */
-ntfschar *default_upcase = NULL;
-unsigned long ntfs_nr_upcase_users = 0;
 
 /* Driver wide semaphore. */
 DECLARE_MUTEX(ntfs_lock);
