Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUFVUBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUFVUBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUFVTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:33:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16027 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265484AbUFVTYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:24:01 -0400
To: torvalds@osdl.org
Subject: [PATCH] (7/9) symlink patchkit (against -bk current)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1Bcqs8-0003xg-RH@www.linux.org.uk>
From: viro@www.linux.org.uk
Date: Tue, 22 Jun 2004 20:23:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        shm switched (it almost belongs to SL3, but it does some extra
stuff after the link traversal).

diff -urN RC7-bk5-xfs/mm/shmem.c RC7-bk5-shm/mm/shmem.c
--- RC7-bk5-xfs/mm/shmem.c	Wed Jun 16 10:26:30 2004
+++ RC7-bk5-shm/mm/shmem.c	Tue Jun 22 15:13:11 2004
@@ -40,6 +40,7 @@
 #include <linux/security.h>
 #include <linux/swapops.h>
 #include <linux/mempolicy.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/pgtable.h>
@@ -1676,51 +1677,45 @@
 	return 0;
 }
 
-static int shmem_readlink_inline(struct dentry *dentry, char __user *buffer, int buflen)
-{
-	return vfs_readlink(dentry, buffer, buflen, (const char *)SHMEM_I(dentry->d_inode));
-}
-
 static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
 {
-	return vfs_follow_link(nd, (const char *)SHMEM_I(dentry->d_inode));
+	nd_set_link(nd, (char *)SHMEM_I(dentry->d_inode));
+	return 0;
 }
 
-static int shmem_readlink(struct dentry *dentry, char __user *buffer, int buflen)
+static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page = NULL;
 	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ, NULL);
-	if (res)
-		return res;
-	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
-	kunmap(page);
-	mark_page_accessed(page);
-	page_cache_release(page);
-	return res;
+	nd_set_link(nd, res ? ERR_PTR(res) : kmap(page));
+	return 0;
 }
 
-static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void shmem_put_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct page *page = NULL;
-	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ, NULL);
-	if (res)
-		return res;
-	res = vfs_follow_link(nd, kmap(page));
-	kunmap(page);
-	mark_page_accessed(page);
-	page_cache_release(page);
-	return res;
+	if (!IS_ERR(nd_get_link(nd))) {
+		struct page *page;
+
+		page = find_get_page(dentry->d_inode->i_mapping, 0);
+		if (!page)
+			BUG();
+		kunmap(page);
+		mark_page_accessed(page);
+		page_cache_release(page);
+		page_cache_release(page);
+	}
 }
 
 static struct inode_operations shmem_symlink_inline_operations = {
-	.readlink	= shmem_readlink_inline,
+	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link_inline,
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
 	.truncate	= shmem_truncate,
-	.readlink	= shmem_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link,
+	.put_link	= shmem_put_link,
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
