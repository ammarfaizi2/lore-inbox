Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWCIROn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWCIROn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWCIROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:14:43 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:22133 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750847AbWCIROm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:14:42 -0500
Message-ID: <44106393.2050207@openvz.org>
Date: Thu, 09 Mar 2006 20:19:15 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations inside
Content-Type: multipart/mixed;
 boundary="------------030609020105070808080202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609020105070808080202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes illegal __GFP_FS allocation inside ext3
transaction in ext3_symlink().
Such allocation may re-enter ext3 code from
try_to_free_pages. But JBD/ext3 code keeps a pointer to current
journal handle in task_struct and, hence, is not reentrable.

This bug led to "Assertion failure in journal_dirty_metadata()" messages.

http://bugzilla.openvz.org/show_bug.cgi?id=115

Signed-Off-By: Andrey Savochkin <saw@saw.sw.com.sg>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Thanks,
Kirill
P.S. against 2.6.16-rc5

--------------030609020105070808080202
Content-Type: text/plain;
 name="diff-ext3-nofssymlink-20060210"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ext3-nofssymlink-20060210"

--- ./fs/ext2/namei.c.symlnk	2006-03-03 10:51:01.000000000 +0300
+++ ./fs/ext2/namei.c	2006-03-09 19:38:49.000000000 +0300
@@ -185,7 +185,7 @@ static int ext2_symlink (struct inode * 
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 		else
 			inode->i_mapping->a_ops = &ext2_aops;
-		err = page_symlink(inode, symname, l);
+		err = page_symlink(inode, symname, l, GFP_KERNEL);
 		if (err)
 			goto out_fail;
 	} else {
--- ./fs/ext3/namei.c.symlnk	2006-03-03 10:51:01.000000000 +0300
+++ ./fs/ext3/namei.c	2006-03-09 19:38:49.000000000 +0300
@@ -2141,7 +2141,7 @@ retry:
 		 * We have a transaction open.  All is sweetness.  It also sets
 		 * i_size in generic_commit_write().
 		 */
-		err = page_symlink(inode, symname, l);
+		err = page_symlink(inode, symname, l, GFP_NOFS);
 		if (err) {
 			ext3_dec_count(handle, inode);
 			ext3_mark_inode_dirty(handle, inode);
--- ./fs/hfsplus/dir.c.symlnk	2006-03-03 10:51:01.000000000 +0300
+++ ./fs/hfsplus/dir.c	2006-03-09 19:38:49.000000000 +0300
@@ -406,7 +406,7 @@ static int hfsplus_symlink(struct inode 
 	if (!inode)
 		return -ENOSPC;
 
-	res = page_symlink(inode, symname, strlen(symname) + 1);
+	res = page_symlink(inode, symname, strlen(symname) + 1, GFP_KERNEL);
 	if (res) {
 		inode->i_nlink = 0;
 		hfsplus_delete_inode(inode);
--- ./fs/hugetlbfs/inode.c.symlnk	2006-03-03 10:51:01.000000000 +0300
+++ ./fs/hugetlbfs/inode.c	2006-03-09 19:38:49.000000000 +0300
@@ -482,7 +482,7 @@ static int hugetlbfs_symlink(struct inod
 					gid, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
-		error = page_symlink(inode, symname, l);
+		error = page_symlink(inode, symname, l, GFP_KERNEL);
 		if (!error) {
 			d_instantiate(dentry, inode);
 			dget(dentry);
--- ./fs/minix/namei.c.symlnk	2006-01-03 06:21:10.000000000 +0300
+++ ./fs/minix/namei.c	2006-03-09 19:38:49.000000000 +0300
@@ -116,7 +116,7 @@ static int minix_symlink(struct inode * 
 
 	inode->i_mode = S_IFLNK | 0777;
 	minix_set_inode(inode, 0);
-	err = page_symlink(inode, symname, i);
+	err = page_symlink(inode, symname, i, GFP_KERNEL);
 	if (err)
 		goto out_fail;
 
--- ./fs/namei.c.symlnk	2006-03-03 10:51:01.000000000 +0300
+++ ./fs/namei.c	2006-03-09 19:42:09.000000000 +0300
@@ -2613,13 +2613,16 @@ void page_put_link(struct dentry *dentry
 	}
 }
 
-int page_symlink(struct inode *inode, const char *symname, int len)
+int page_symlink(struct inode *inode, const char *symname, int len,
+		gfp_t gfp_mask)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page = grab_cache_page(mapping, 0);
+	struct page *page;
 	int err = -ENOMEM;
 	char *kaddr;
 
+	page = find_or_create_page(mapping, 0,
+			mapping_gfp_mask(mapping) | gfp_mask);
 	if (!page)
 		goto fail;
 	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
--- ./fs/ramfs/inode.c.symlnk	2006-03-03 10:51:01.000000000 +0300
+++ ./fs/ramfs/inode.c	2006-03-09 19:38:49.000000000 +0300
@@ -131,7 +131,7 @@ static int ramfs_symlink(struct inode * 
 	inode = ramfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
-		error = page_symlink(inode, symname, l);
+		error = page_symlink(inode, symname, l, GFP_KERNEL);
 		if (!error) {
 			if (dir->i_mode & S_ISGID)
 				inode->i_gid = dir->i_gid;
--- ./fs/sysv/namei.c.symlnk	2006-01-03 06:21:10.000000000 +0300
+++ ./fs/sysv/namei.c	2006-03-09 19:38:49.000000000 +0300
@@ -114,7 +114,7 @@ static int sysv_symlink(struct inode * d
 		goto out;
 	
 	sysv_set_inode(inode, 0);
-	err = page_symlink(inode, symname, l);
+	err = page_symlink(inode, symname, l, GFP_KERNEL);
 	if (err)
 		goto out_fail;
 
--- ./fs/ufs/namei.c.symlnk	2006-01-03 06:21:10.000000000 +0300
+++ ./fs/ufs/namei.c	2006-03-09 19:38:49.000000000 +0300
@@ -156,7 +156,7 @@ static int ufs_symlink (struct inode * d
 		/* slow symlink */
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ufs_aops;
-		err = page_symlink(inode, symname, l);
+		err = page_symlink(inode, symname, l, GFP_KERNEL);
 		if (err)
 			goto out_fail;
 	} else {
--- ./include/linux/fs.h.symlnk	2006-03-09 16:03:44.000000000 +0300
+++ ./include/linux/fs.h	2006-03-09 19:41:25.000000000 +0300
@@ -1669,7 +1669,8 @@ extern int vfs_follow_link(struct nameid
 extern int page_readlink(struct dentry *, char __user *, int);
 extern void *page_follow_link_light(struct dentry *, struct nameidata *);
 extern void page_put_link(struct dentry *, struct nameidata *, void *);
-extern int page_symlink(struct inode *inode, const char *symname, int len);
+extern int page_symlink(struct inode *inode, const char *symname, int len,
+		gfp_t gfp_mask);
 extern struct inode_operations page_symlink_inode_operations;
 extern int generic_readlink(struct dentry *, char __user *, int);
 extern void generic_fillattr(struct inode *, struct kstat *);

--------------030609020105070808080202--

