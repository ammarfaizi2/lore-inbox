Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266594AbUBLU7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUBLU5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:57:41 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:58426 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266594AbUBLU5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:57:05 -0500
Date: Thu, 12 Feb 2004 14:57:03 -0600
From: shaggy@austin.ibm.com
Message-Id: <200402122057.i1CKv3tt006265@kleikamp.dyn.webahead.ibm.com>
To: akpm@osdl.org
Subject: [PATCH] JFS: sane file name handling (1 of 2)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/11 13:35:46-06:00 shaggy@austin.ibm.com 
#   JFS: get_UCSname does not need nls_tab argument
#   
#   This is a minor code cleanup.  get_UCSname can get nls_tab by
#   following the dentry to the superblock.  This makes the calling code
#   simpler and prettier.
# 
diff -Nru a/fs/jfs/jfs_unicode.c b/fs/jfs/jfs_unicode.c
--- a/fs/jfs/jfs_unicode.c	Thu Feb 12 14:43:25 2004
+++ b/fs/jfs/jfs_unicode.c	Thu Feb 12 14:43:25 2004
@@ -18,7 +18,7 @@
 
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include "jfs_types.h"
+#include "jfs_incore.h"
 #include "jfs_filsys.h"
 #include "jfs_unicode.h"
 #include "jfs_debug.h"
@@ -82,9 +82,9 @@
  * FUNCTION:	Allocate and translate to unicode string
  *
  */
-int get_UCSname(struct component_name * uniName, struct dentry *dentry,
-		struct nls_table *nls_tab)
+int get_UCSname(struct component_name * uniName, struct dentry *dentry)
 {
+	struct nls_table *nls_tab = JFS_SBI(dentry->d_sb)->nls_tab;
 	int length = dentry->d_name.len;
 
 	if (length > JFS_NAME_MAX)
diff -Nru a/fs/jfs/jfs_unicode.h b/fs/jfs/jfs_unicode.h
--- a/fs/jfs/jfs_unicode.h	Thu Feb 12 14:43:25 2004
+++ b/fs/jfs/jfs_unicode.h	Thu Feb 12 14:43:25 2004
@@ -30,8 +30,7 @@
 
 extern signed char UniUpperTable[512];
 extern UNICASERANGE UniUpperRange[];
-extern int get_UCSname(struct component_name *, struct dentry *,
-		       struct nls_table *);
+extern int get_UCSname(struct component_name *, struct dentry *);
 extern int jfs_strfromUCS_le(char *, const wchar_t *, int, struct nls_table *);
 
 #define free_UCSname(COMP) kfree((COMP)->name)
diff -Nru a/fs/jfs/namei.c b/fs/jfs/namei.c
--- a/fs/jfs/namei.c	Thu Feb 12 14:43:25 2004
+++ b/fs/jfs/namei.c	Thu Feb 12 14:43:25 2004
@@ -78,7 +78,7 @@
 	 * search parent directory for entry/freespace
 	 * (dtSearch() returns parent directory page pinned)
 	 */
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(dip->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&dname, dentry)))
 		goto out1;
 
 	/*
@@ -204,7 +204,7 @@
 	 * search parent directory for entry/freespace
 	 * (dtSearch() returns parent directory page pinned)
 	 */
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(dip->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&dname, dentry)))
 		goto out1;
 
 	/*
@@ -332,7 +332,7 @@
 		goto out;
 	}
 
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(dip->i_sb)->nls_tab))) {
+	if ((rc = get_UCSname(&dname, dentry))) {
 		goto out;
 	}
 
@@ -451,7 +451,7 @@
 
 	jfs_info("jfs_unlink: dip:0x%p name:%s", dip, dentry->d_name.name);
 
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(dip->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&dname, dentry)))
 		goto out;
 
 	IWRITE_LOCK(ip);
@@ -786,7 +786,7 @@
 	/*
 	 * scan parent directory for entry/freespace
 	 */
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(ip->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&dname, dentry)))
 		goto out;
 
 	if ((rc = dtSearch(dir, &dname, &ino, &btstack, JFS_CREATE)))
@@ -866,7 +866,7 @@
 	 * (dtSearch() returns parent directory page pinned)
 	 */
 
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(dip->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&dname, dentry)))
 		goto out1;
 
 	/*
@@ -1069,12 +1069,10 @@
 	old_ip = old_dentry->d_inode;
 	new_ip = new_dentry->d_inode;
 
-	if ((rc = get_UCSname(&old_dname, old_dentry,
-			      JFS_SBI(old_dir->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&old_dname, old_dentry)))
 		goto out1;
 
-	if ((rc = get_UCSname(&new_dname, new_dentry,
-			      JFS_SBI(old_dir->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&new_dname, new_dentry)))
 		goto out2;
 
 	/*
@@ -1329,7 +1327,7 @@
 
 	jfs_info("jfs_mknod: %s", dentry->d_name.name);
 
-	if ((rc = get_UCSname(&dname, dentry, JFS_SBI(dir->i_sb)->nls_tab)))
+	if ((rc = get_UCSname(&dname, dentry)))
 		goto out;
 
 	ip = ialloc(dir, mode);
@@ -1411,8 +1409,7 @@
 	else if (strcmp(name, "..") == 0)
 		inum = PARENT(dip);
 	else {
-		if ((rc =
-		     get_UCSname(&key, dentry, JFS_SBI(dip->i_sb)->nls_tab)))
+		if ((rc = get_UCSname(&key, dentry)))
 			return ERR_PTR(rc);
 		rc = dtSearch(dip, &key, &inum, &btstack, JFS_LOOKUP);
 		free_UCSname(&key);
