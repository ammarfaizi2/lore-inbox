Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUGGNCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUGGNCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUGGNAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:00:42 -0400
Received: from linuxhacker.ru ([217.76.32.60]:7127 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265102AbUGGMtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:42 -0400
Date: Wed, 7 Jul 2004 15:47:33 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [5/9] Lustre VFS patches for 2.6
Message-ID: <20040707124733.GA25943@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exports

 fs/jbd/journal.c   |    1 +
 fs/super.c         |    2 ++
 include/linux/fs.h |    1 +
 include/linux/mm.h |    3 +++
 mm/truncate.c      |    4 +++-
 5 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.6/fs/jbd/journal.c
===================================================================
--- linux-2.6.6.orig/fs/jbd/journal.c	2004-05-26 20:25:49.000000000 +0300
+++ linux-2.6.6/fs/jbd/journal.c	2004-05-27 21:08:52.686693408 +0300
@@ -71,6 +71,7 @@
 EXPORT_SYMBOL(journal_errno);
 EXPORT_SYMBOL(journal_ack_err);
 EXPORT_SYMBOL(journal_clear_err);
+EXPORT_SYMBOL(log_start_commit);
 EXPORT_SYMBOL(log_wait_commit);
 EXPORT_SYMBOL(journal_start_commit);
 EXPORT_SYMBOL(journal_wipe);
Index: linux-2.6.6/fs/super.c
===================================================================
--- linux-2.6.6.orig/fs/super.c	2004-05-26 20:25:43.000000000 +0300
+++ linux-2.6.6/fs/super.c	2004-05-27 21:08:52.718688544 +0300
@@ -788,6 +788,8 @@
 	return (struct vfsmount *)sb;
 }
 
+EXPORT_SYMBOL(do_kern_mount);
+
 struct vfsmount *kern_mount(struct file_system_type *type)
 {
 	return do_kern_mount(type->name, 0, type->name, NULL);
Index: linux-2.6.6/include/linux/mm.h
===================================================================
--- linux-2.6.6.orig/include/linux/mm.h	2004-05-26 20:26:11.000000000 +0300
+++ linux-2.6.6/include/linux/mm.h	2004-05-27 21:08:52.735685960 +0300
@@ -589,6 +589,9 @@
 	return 0;
 }
 
+/* truncate.c */
+extern void truncate_complete_page(struct address_space *mapping,struct page *);
+
 /* filemap.c */
 extern unsigned long page_unuse(struct page *);
 extern void truncate_inode_pages(struct address_space *, loff_t);
Index: linux-2.6.6/include/linux/fs.h
===================================================================
--- linux-2.6.6.orig/include/linux/fs.h	2004-05-27 21:08:45.986711960 +0300
+++ linux-2.6.6/include/linux/fs.h	2004-05-27 21:08:52.738685504 +0300
@@ -1137,6 +1137,7 @@
 extern int unregister_filesystem(struct file_system_type *);
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount(struct vfsmount *);
+struct vfsmount *do_kern_mount(const char *type, int flags, const char *name, void *data);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
Index: linux-2.6.6/mm/truncate.c
===================================================================
--- linux-2.6.6.orig/mm/truncate.c	2004-05-26 20:26:14.000000000 +0300
+++ linux-2.6.6/mm/truncate.c	2004-05-27 21:08:52.750683680 +0300
@@ -42,7 +42,7 @@
  * its lock, b) when a concurrent invalidate_inode_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
  */
-static void
+void
 truncate_complete_page(struct address_space *mapping, struct page *page)
 {
 	if (page->mapping != mapping)
@@ -58,6 +58,8 @@
 	page_cache_release(page);	/* pagecache ref */
 }
 
+EXPORT_SYMBOL(truncate_complete_page);
+
 /*
  * This is for invalidate_inode_pages().  That function can be called at
  * any time, and is not supposed to throw away dirty pages.  But pages can

