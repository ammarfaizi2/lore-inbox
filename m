Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSFAIld>; Sat, 1 Jun 2002 04:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316995AbSFAIkS>; Sat, 1 Jun 2002 04:40:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48906 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314433AbSFAIjP>;
	Sat, 1 Jun 2002 04:39:15 -0400
Message-ID: <3CF888FB.7C14A184@zip.com.au>
Date: Sat, 01 Jun 2002 01:42:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/16] rename block_symlink() to page_symlink()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



block_symlink() is not a "block" function at all.  It is a pure
pagecache/address_space function.  Seeing driverfs calling it was
the last straw.

The patch renames it to `page_symlink()' and moves it into fs/namei.c


=====================================

--- 2.5.19/fs/buffer.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/buffer.c	Sat Jun  1 01:18:10 2002
@@ -2327,46 +2327,6 @@ int brw_page(int rw, struct page *page,
 	return 0;
 }
 
-int block_symlink(struct inode *inode, const char *symname, int len)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct page *page = grab_cache_page(mapping, 0);
-	int err = -ENOMEM;
-	char *kaddr;
-
-	if (!page)
-		goto fail;
-	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
-	if (err)
-		goto fail_map;
-	kaddr = page_address(page);
-	memcpy(kaddr, symname, len-1);
-	mapping->a_ops->commit_write(NULL, page, 0, len-1);
-	/*
-	 * Notice that we are _not_ going to block here - end of page is
-	 * unmapped, so this will only try to map the rest of page, see
-	 * that it is unmapped (typically even will not look into inode -
-	 * ->i_size will be enough for everything) and zero it out.
-	 * OTOH it's obviously correct and should make the page up-to-date.
-	 */
-	if (!PageUptodate(page)) {
-		err = mapping->a_ops->readpage(NULL, page);
-		wait_on_page_locked(page);
-	} else {
-		unlock_page(page);
-	}
-	page_cache_release(page);
-	if (err < 0)
-		goto fail;
-	mark_inode_dirty(inode);
-	return 0;
-fail_map:
-	unlock_page(page);
-	page_cache_release(page);
-fail:
-	return err;
-}
-
 /*
  * Sanity checks for try_to_free_buffers.
  */
--- 2.5.19/fs/driverfs/inode.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/driverfs/inode.c	Sat Jun  1 01:18:10 2002
@@ -171,7 +171,7 @@ static int driverfs_symlink(struct inode
 	inode = driverfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
-		error = block_symlink(inode, symname, l);
+		error = page_symlink(inode, symname, l);
 		if (!error) {
 			d_instantiate(dentry, inode);
 			dget(dentry);
--- 2.5.19/fs/ext2/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ext2/namei.c	Sat Jun  1 01:18:10 2002
@@ -31,7 +31,6 @@
 
 #include "ext2.h"
 #include <linux/pagemap.h>
-#include <linux/buffer_head.h>		/* for block_symlink() */
 
 /*
  * Couple of helper functions - make the code slightly cleaner.
@@ -165,7 +164,7 @@ static int ext2_symlink (struct inode * 
 		/* slow symlink */
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ext2_aops;
-		err = block_symlink(inode, symname, l);
+		err = page_symlink(inode, symname, l);
 		if (err)
 			goto out_fail;
 	} else {
--- 2.5.19/fs/ext3/inode.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ext3/inode.c	Sat Jun  1 01:18:10 2002
@@ -1092,7 +1092,7 @@ static int commit_write_fn(handle_t *han
 
 /*
  * We need to pick up the new inode size which generic_commit_write gave us
- * `file' can be NULL - eg, when called from block_symlink().
+ * `file' can be NULL - eg, when called from page_symlink().
  *
  * ext3 never places buffers on inode->i_mapping->private_list.  metadata
  * buffers are managed internally.
--- 2.5.19/fs/ext3/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ext3/namei.c	Sat Jun  1 01:18:10 2002
@@ -987,11 +987,11 @@ static int ext3_symlink (struct inode * 
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ext3_aops;
 		/*
-		 * block_symlink() calls back into ext3_prepare/commit_write.
+		 * page_symlink() calls into ext3_prepare/commit_write.
 		 * We have a transaction open.  All is sweetness.  It also sets
 		 * i_size in generic_commit_write().
 		 */
-		err = block_symlink(inode, symname, l);
+		err = page_symlink(inode, symname, l);
 		if (err)
 			goto out_no_entry;
 	} else {
--- 2.5.19/fs/minix/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/minix/namei.c	Sat Jun  1 01:18:10 2002
@@ -4,7 +4,6 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
-#include <linux/buffer_head.h>	/* for block_symlink() */
 #include "minix.h"
 
 static inline void inc_count(struct inode *inode)
@@ -111,7 +110,7 @@ static int minix_symlink(struct inode * 
 
 	inode->i_mode = S_IFLNK | 0777;
 	minix_set_inode(inode, 0);
-	err = block_symlink(inode, symname, i);
+	err = page_symlink(inode, symname, i);
 	if (err)
 		goto out_fail;
 
--- 2.5.19/fs/ramfs/inode.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ramfs/inode.c	Sat Jun  1 01:18:10 2002
@@ -29,7 +29,6 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/buffer_head.h>		/* for block_symlink() */
 
 #include <asm/uaccess.h>
 
@@ -235,7 +234,7 @@ static int ramfs_symlink(struct inode * 
 	inode = ramfs_get_inode(dir->i_sb, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
-		error = block_symlink(inode, symname, l);
+		error = page_symlink(inode, symname, l);
 		if (!error) {
 			d_instantiate(dentry, inode);
 			dget(dentry);
--- 2.5.19/fs/sysv/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/sysv/namei.c	Sat Jun  1 01:18:10 2002
@@ -117,7 +117,7 @@ static int sysv_symlink(struct inode * d
 		goto out;
 	
 	sysv_set_inode(inode, 0);
-	err = block_symlink(inode, symname, l);
+	err = page_symlink(inode, symname, l);
 	if (err)
 		goto out_fail;
 
--- 2.5.19/fs/ufs/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/ufs/namei.c	Sat Jun  1 01:18:10 2002
@@ -143,7 +143,7 @@ static int ufs_symlink (struct inode * d
 		/* slow symlink */
 		inode->i_op = &page_symlink_inode_operations;
 		inode->i_mapping->a_ops = &ufs_aops;
-		err = block_symlink(inode, symname, l);
+		err = page_symlink(inode, symname, l);
 		if (err)
 			goto out_fail;
 	} else {
--- 2.5.19/fs/umsdos/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/umsdos/namei.c	Sat Jun  1 01:18:10 2002
@@ -499,7 +499,7 @@ static int umsdos_symlink_x (struct inod
 	}
 
 	len = strlen (symname) + 1;
-	ret = block_symlink(dentry->d_inode, symname, len);
+	ret = page_symlink(dentry->d_inode, symname, len);
 	if (ret < 0)
 		goto out_unlink;
 out:
--- 2.5.19/include/linux/buffer_head.h~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/include/linux/buffer_head.h	Sat Jun  1 01:18:10 2002
@@ -192,7 +192,6 @@ void FASTCALL(unlock_buffer(struct buffe
  */
 int try_to_release_page(struct page * page, int gfp_mask);
 int block_flushpage(struct page *page, unsigned long offset);
-int block_symlink(struct inode *, const char *, int);
 int block_write_full_page(struct page*, get_block_t*);
 int block_read_full_page(struct page*, get_block_t*);
 int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
--- 2.5.19/kernel/ksyms.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/kernel/ksyms.c	Sat Jun  1 01:18:10 2002
@@ -277,7 +277,7 @@ EXPORT_SYMBOL(vfs_follow_link);
 EXPORT_SYMBOL(page_readlink);
 EXPORT_SYMBOL(page_follow_link);
 EXPORT_SYMBOL(page_symlink_inode_operations);
-EXPORT_SYMBOL(block_symlink);
+EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(vfs_readdir);
 EXPORT_SYMBOL(__get_lease);
 EXPORT_SYMBOL(lease_get_mtime);
--- 2.5.19/fs/namei.c~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/fs/namei.c	Sat Jun  1 01:18:10 2002
@@ -2136,6 +2136,46 @@ int page_follow_link(struct dentry *dent
 	return res;
 }
 
+int page_symlink(struct inode *inode, const char *symname, int len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page = grab_cache_page(mapping, 0);
+	int err = -ENOMEM;
+	char *kaddr;
+
+	if (!page)
+		goto fail;
+	err = mapping->a_ops->prepare_write(NULL, page, 0, len-1);
+	if (err)
+		goto fail_map;
+	kaddr = page_address(page);
+	memcpy(kaddr, symname, len-1);
+	mapping->a_ops->commit_write(NULL, page, 0, len-1);
+	/*
+	 * Notice that we are _not_ going to block here - end of page is
+	 * unmapped, so this will only try to map the rest of page, see
+	 * that it is unmapped (typically even will not look into inode -
+	 * ->i_size will be enough for everything) and zero it out.
+	 * OTOH it's obviously correct and should make the page up-to-date.
+	 */
+	if (!PageUptodate(page)) {
+		err = mapping->a_ops->readpage(NULL, page);
+		wait_on_page_locked(page);
+	} else {
+		unlock_page(page);
+	}
+	page_cache_release(page);
+	if (err < 0)
+		goto fail;
+	mark_inode_dirty(inode);
+	return 0;
+fail_map:
+	unlock_page(page);
+	page_cache_release(page);
+fail:
+	return err;
+}
+
 struct inode_operations page_symlink_inode_operations = {
 	readlink:	page_readlink,
 	follow_link:	page_follow_link,
--- 2.5.19/include/linux/fs.h~block_symlink	Sat Jun  1 01:18:10 2002
+++ 2.5.19-akpm/include/linux/fs.h	Sat Jun  1 01:18:10 2002
@@ -1246,6 +1246,7 @@ extern int vfs_readlink(struct dentry *,
 extern int vfs_follow_link(struct nameidata *, const char *);
 extern int page_readlink(struct dentry *, char *, int);
 extern int page_follow_link(struct dentry *, struct nameidata *);
+extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern struct inode_operations page_symlink_inode_operations;
 extern void generic_fillattr(struct inode *, struct kstat *);
 

-
