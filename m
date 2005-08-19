Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVHSR7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVHSR7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVHSR7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:59:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11487 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S965021AbVHSR7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:59:22 -0400
Date: Fri, 19 Aug 2005 19:02:18 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 05:53:32PM +0100, Al Viro wrote:
> I'm taking NFS helpers to libfs.c and switching ncpfs to them.  IMO that's
> better than copying the damn thing and other network filesystems might have
> the same needs eventually...

[something like this - completely untested]

* stray_page_get_link(inode, filler) - returns ERR_PTR(error) or pointer
to symlink body.  Said symlink body sits in a page at offset equal to
offsetof(page, struct stray_page_link).  filler() is expected to put it
at such offset. Page is cached.

* stray_page_put_link() - ->put_link() suitable for links obtained from
stray_page_get_link().  Unlike the usual pagecache-based variants, this
sucker does _not_ rely on page staying cached.

* nfs and ncpfs switched to the helpers above.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC14-rc6-git10-base/fs/libfs.c current/fs/libfs.c
--- RC13-rc6-git10-base/fs/libfs.c	2005-08-10 10:37:52.000000000 -0400
+++ current/fs/libfs.c	2005-08-19 13:29:39.000000000 -0400
@@ -7,6 +7,7 @@
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/namei.h>
 #include <asm/uaccess.h>
 
 int simple_getattr(struct vfsmount *mnt, struct dentry *dentry,
@@ -616,6 +617,42 @@
 	return ret;
 }
 
+char *stray_page_get_link(struct inode *inode, int (*filler)(struct inode *, struct page *))
+{
+	struct stray_page_symlink *p;
+	struct page *page;
+
+	page = read_cache_page(&inode->i_data, 0, (filler_t *)filler, inode);
+	if (IS_ERR(page))
+		goto read_failed;
+	if (!PageUptodate(page))
+		goto getlink_read_error;
+	p = kmap(page);
+	p->page = page;
+	return p->body;
+
+getlink_read_error:
+	page_cache_release(page);
+	page = ERR_PTR(-EIO);
+read_failed:
+	return (char *)page;	/* error */
+}
+
+void stray_page_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = nd_get_link(nd);
+	if (!IS_ERR(s)) {
+		struct stray_page_symlink *p;
+		struct page *page;
+
+		p = container_of(s, struct stray_page_symlink, body[0]);
+		page = p->page;
+
+		kunmap(page);
+		page_cache_release(page);
+	}
+}
+
 EXPORT_SYMBOL(dcache_dir_close);
 EXPORT_SYMBOL(dcache_dir_lseek);
 EXPORT_SYMBOL(dcache_dir_open);
@@ -648,3 +685,5 @@
 EXPORT_SYMBOL_GPL(simple_attr_close);
 EXPORT_SYMBOL_GPL(simple_attr_read);
 EXPORT_SYMBOL_GPL(simple_attr_write);
+EXPORT_SYMBOL(stray_page_get_link);
+EXPORT_SYMBOL(stray_page_put_link);
diff -urN RC13-rc6-git10-base/fs/ncpfs/inode.c current/fs/ncpfs/inode.c
--- RC13-rc6-git10-base/fs/ncpfs/inode.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/ncpfs/inode.c	2005-08-19 13:12:01.000000000 -0400
@@ -104,7 +104,7 @@
 
 extern struct dentry_operations ncp_root_dentry_operations;
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
-extern struct address_space_operations ncp_symlink_aops;
+extern int ncp_follow_link(struct dentry *dentry, struct nameidata *nd);
 extern int ncp_symlink(struct inode*, struct dentry*, const char*);
 #endif
 
@@ -233,8 +233,8 @@
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
 static struct inode_operations ncp_symlink_inode_operations = {
 	.readlink	= generic_readlink,
-	.follow_link	= page_follow_link_light,
-	.put_link	= page_put_link,
+	.follow_link	= ncp_follow_link,
+	.put_link	= stray_page_put_link,
 	.setattr	= ncp_notify_change,
 };
 #endif
@@ -272,7 +272,6 @@
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
 		} else if (S_ISLNK(inode->i_mode)) {
 			inode->i_op = &ncp_symlink_inode_operations;
-			inode->i_data.a_ops = &ncp_symlink_aops;
 #endif
 		} else {
 			make_bad_inode(inode);
diff -urN RC13-rc6-git10-base/fs/ncpfs/symlink.c current/fs/ncpfs/symlink.c
--- RC13-rc6-git10-base/fs/ncpfs/symlink.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/ncpfs/symlink.c	2005-08-19 13:26:26.000000000 -0400
@@ -30,6 +30,7 @@
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/stat.h>
+#include <linux/namei.h>
 #include "ncplib_kernel.h"
 
 
@@ -41,9 +42,8 @@
 
 /* ----- read a symbolic link ------------------------------------------ */
 
-static int ncp_symlink_readpage(struct file *file, struct page *page)
+static int symlink_filler(struct inode *inode, struct page *page)
 {
-	struct inode *inode = page->mapping->host;
 	int error, length, len;
 	char *link, *rawlink;
 	char *buf = kmap(page);
@@ -77,6 +77,7 @@
 	}
 
 	len = NCP_MAX_SYMLINK_SIZE;
+	buf += offsetof(struct stray_page_symlink, body);
 	error = ncp_vol2io(NCP_SERVER(inode), buf, &len, link, length, 0);
 	kfree(rawlink);
 	if (error)
@@ -96,13 +97,12 @@
 	return error;
 }
 
-/*
- * symlinks can't do much...
- */
-struct address_space_operations ncp_symlink_aops = {
-	.readpage	= ncp_symlink_readpage,
-};
-	
+int ncp_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	nd_set_link(nd, stray_page_get_link(dentry->d_inode, symlink_filler));
+	return 0;
+}
+
 /* ----- create a new symbolic link -------------------------------------- */
  
 int ncp_symlink(struct inode *dir, struct dentry *dentry, const char *symname) {
diff -urN RC13-rc6-git10-base/fs/nfs/symlink.c current/fs/nfs/symlink.c
--- RC13-rc6-git10-base/fs/nfs/symlink.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/nfs/symlink.c	2005-08-19 13:04:44.000000000 -0400
@@ -41,7 +41,7 @@
 
 static int nfs_symlink_filler(struct inode *inode, struct page *page)
 {
-	const unsigned int pgbase = offsetof(struct nfs_symlink, body);
+	const unsigned int pgbase = offsetof(struct stray_page_symlink, body);
 	const unsigned int pglen = PAGE_SIZE - pgbase;
 	int error;
 
@@ -63,46 +63,11 @@
 static int nfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
-	struct page *page;
-	struct nfs_symlink *p;
-	void *err = ERR_PTR(nfs_revalidate_inode(NFS_SERVER(inode), inode));
-	if (err)
-		goto read_failed;
-	page = read_cache_page(&inode->i_data, 0,
-				(filler_t *)nfs_symlink_filler, inode);
-	if (IS_ERR(page)) {
-		err = page;
-		goto read_failed;
-	}
-	if (!PageUptodate(page)) {
-		err = ERR_PTR(-EIO);
-		goto getlink_read_error;
-	}
-	p = kmap(page);
-	p->page = page;
-	nd_set_link(nd, p->body);
+	char *p = ERR_PTR(nfs_revalidate_inode(NFS_SERVER(inode), inode));
+	if (!p)
+		p = stray_page_get_link(inode, nfs_symlink_filler);
+	nd_set_link(nd, p);
 	return 0;
-
-getlink_read_error:
-	page_cache_release(page);
-read_failed:
-	nd_set_link(nd, err);
-	return 0;
-}
-
-static void nfs_put_link(struct dentry *dentry, struct nameidata *nd)
-{
-	char *s = nd_get_link(nd);
-	if (!IS_ERR(s)) {
-		struct nfs_symlink *p;
-		struct page *page;
-
-		p = container_of(s, struct nfs_symlink, body[0]);
-		page = p->page;
-
-		kunmap(page);
-		page_cache_release(page);
-	}
 }
 
 /*
@@ -111,7 +76,7 @@
 struct inode_operations nfs_symlink_inode_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= nfs_follow_link,
-	.put_link	= nfs_put_link,
+	.put_link	= stray_page_put_link,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
 };
diff -urN RC13-rc6-git10-base/include/linux/fs.h current/include/linux/fs.h
--- RC13-rc6-git10-base/include/linux/fs.h	2005-08-10 10:37:54.000000000 -0400
+++ current/include/linux/fs.h	2005-08-19 13:26:55.000000000 -0400
@@ -1614,6 +1614,13 @@
 loff_t inode_get_bytes(struct inode *inode);
 void inode_set_bytes(struct inode *inode, loff_t bytes);
 
+struct stray_page_symlink {
+	struct page *page;
+	char body[0];
+};
+char *stray_page_get_link(struct inode *inode, int (*filler)(struct inode *, struct page *));
+void stray_page_put_link(struct dentry *dentry, struct nameidata *nd);
+
 extern int vfs_readdir(struct file *, filldir_t, void *);
 
 extern int vfs_stat(char __user *, struct kstat *);
