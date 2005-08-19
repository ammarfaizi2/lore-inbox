Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbVHSWGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVHSWGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbVHSWGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:06:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbVHSWGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:06:08 -0400
Date: Fri, 19 Aug 2005 15:04:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
> 
> Yes, sure.  I have applied your patch to our 2.6.11.4 tree (with the one 
> liner change I emailed you just now) and have kicked off a compile.

Actually, hold on. The original patch had another problem: it returned an
uninitialized "page" pointer when page_getlink() failed.

This one should have that fixed, and has converted a few other 
filesystems. Most of them trivially, but I took the opportunity to just 
simplify NFS while I was at it, since it now has no reason to need to save 
off the "struct page *" any more.

It's still not tested, but at least I've looked at it a bit more ;)

		Linus

---
diff --git a/fs/autofs/symlink.c b/fs/autofs/symlink.c
--- a/fs/autofs/symlink.c
+++ b/fs/autofs/symlink.c
@@ -12,11 +12,12 @@
 
 #include "autofs_i.h"
 
-static int autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
+/* Nothing to release.. */
+static void *autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
 	nd_set_link(nd, s);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations autofs_symlink_inode_operations = {
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -83,8 +83,8 @@ extern int cifs_dir_notify(struct file *
 extern struct dentry_operations cifs_dentry_ops;
 
 /* Functions related to symlinks */
-extern int cifs_follow_link(struct dentry *direntry, struct nameidata *nd);
-extern void cifs_put_link(struct dentry *direntry, struct nameidata *nd);
+extern void *cifs_follow_link(struct dentry *direntry, struct nameidata *nd);
+extern void cifs_put_link(struct dentry *direntry, struct nameidata *nd, void *);
 extern int cifs_readlink(struct dentry *direntry, char __user *buffer, 
 			 int buflen);
 extern int cifs_symlink(struct inode *inode, struct dentry *direntry,
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -92,7 +92,7 @@ cifs_hl_exit:
 	return rc;
 }
 
-int
+void *
 cifs_follow_link(struct dentry *direntry, struct nameidata *nd)
 {
 	struct inode *inode = direntry->d_inode;
@@ -148,7 +148,7 @@ out:
 out_no_free:
 	FreeXid(xid);
 	nd_set_link(nd, target_path);
-	return 0;
+	return NULL;	/* No cookie */
 }
 
 int
@@ -330,7 +330,7 @@ cifs_readlink(struct dentry *direntry, c
 	return rc;
 }
 
-void cifs_put_link(struct dentry *direntry, struct nameidata *nd)
+void cifs_put_link(struct dentry *direntry, struct nameidata *nd, void *cookie)
 {
 	char *p = nd_get_link(nd);
 	if (!IS_ERR(p))
diff --git a/fs/ext2/symlink.c b/fs/ext2/symlink.c
--- a/fs/ext2/symlink.c
+++ b/fs/ext2/symlink.c
@@ -21,11 +21,11 @@
 #include "xattr.h"
 #include <linux/namei.h>
 
-static int ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct ext2_inode_info *ei = EXT2_I(dentry->d_inode);
 	nd_set_link(nd, (char *)ei->i_data);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations ext2_symlink_inode_operations = {
diff --git a/fs/ext3/symlink.c b/fs/ext3/symlink.c
--- a/fs/ext3/symlink.c
+++ b/fs/ext3/symlink.c
@@ -23,11 +23,11 @@
 #include <linux/namei.h>
 #include "xattr.h"
 
-static int ext3_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void * ext3_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct ext3_inode_info *ei = EXT3_I(dentry->d_inode);
 	nd_set_link(nd, (char*)ei->i_data);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations ext3_symlink_inode_operations = {
diff --git a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -501,6 +501,7 @@ struct path {
 static inline int __do_follow_link(struct path *path, struct nameidata *nd)
 {
 	int error;
+	void *cookie;
 	struct dentry *dentry = path->dentry;
 
 	touch_atime(path->mnt, dentry);
@@ -508,13 +509,15 @@ static inline int __do_follow_link(struc
 
 	if (path->mnt == nd->mnt)
 		mntget(path->mnt);
-	error = dentry->d_inode->i_op->follow_link(dentry, nd);
-	if (!error) {
+	cookie = dentry->d_inode->i_op->follow_link(dentry, nd);
+	error = PTR_ERR(cookie);
+	if (!IS_ERR(cookie)) {
 		char *s = nd_get_link(nd);
+		error = 0;
 		if (s)
 			error = __vfs_follow_link(nd, s);
 		if (dentry->d_inode->i_op->put_link)
-			dentry->d_inode->i_op->put_link(dentry, nd);
+			dentry->d_inode->i_op->put_link(dentry, nd, cookie);
 	}
 	dput(dentry);
 	mntput(path->mnt);
@@ -2344,15 +2347,17 @@ out:
 int generic_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct nameidata nd;
-	int res;
+	void *cookie;
+
 	nd.depth = 0;
-	res = dentry->d_inode->i_op->follow_link(dentry, &nd);
-	if (!res) {
-		res = vfs_readlink(dentry, buffer, buflen, nd_get_link(&nd));
+	cookie = dentry->d_inode->i_op->follow_link(dentry, &nd);
+	if (!IS_ERR(cookie)) {
+		int res = vfs_readlink(dentry, buffer, buflen, nd_get_link(&nd));
 		if (dentry->d_inode->i_op->put_link)
-			dentry->d_inode->i_op->put_link(dentry, &nd);
+			dentry->d_inode->i_op->put_link(dentry, &nd, cookie);
+		cookie = ERR_PTR(res);
 	}
-	return res;
+	return PTR_ERR(cookie);
 }
 
 int vfs_follow_link(struct nameidata *nd, const char *link)
@@ -2395,23 +2400,20 @@ int page_readlink(struct dentry *dentry,
 	return res;
 }
 
-int page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
+void *page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
 {
-	struct page *page;
+	struct page *page = NULL;
 	nd_set_link(nd, page_getlink(dentry, &page));
-	return 0;
+	return page;
 }
 
-void page_put_link(struct dentry *dentry, struct nameidata *nd)
+void page_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
 {
-	if (!IS_ERR(nd_get_link(nd))) {
-		struct page *page;
-		page = find_get_page(dentry->d_inode->i_mapping, 0);
-		if (!page)
-			BUG();
+	struct page *page = cookie;
+
+	if (page) {
 		kunmap(page);
 		page_cache_release(page);
-		page_cache_release(page);
 	}
 }
 
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -27,26 +27,14 @@
 
 /* Symlink caching in the page cache is even more simplistic
  * and straight-forward than readdir caching.
- *
- * At the beginning of the page we store pointer to struct page in question,
- * simplifying nfs_put_link() (if inode got invalidated we can't find the page
- * to be freed via pagecache lookup).
- * The NUL-terminated string follows immediately thereafter.
  */
 
-struct nfs_symlink {
-	struct page *page;
-	char body[0];
-};
-
 static int nfs_symlink_filler(struct inode *inode, struct page *page)
 {
-	const unsigned int pgbase = offsetof(struct nfs_symlink, body);
-	const unsigned int pglen = PAGE_SIZE - pgbase;
 	int error;
 
 	lock_kernel();
-	error = NFS_PROTO(inode)->readlink(inode, page, pgbase, pglen);
+	error = NFS_PROTO(inode)->readlink(inode, page, 0, PAGE_SIZE);
 	unlock_kernel();
 	if (error < 0)
 		goto error;
@@ -60,11 +48,10 @@ error:
 	return -EIO;
 }
 
-static int nfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *nfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
 	struct page *page;
-	struct nfs_symlink *p;
 	void *err = ERR_PTR(nfs_revalidate_inode(NFS_SERVER(inode), inode));
 	if (err)
 		goto read_failed;
@@ -78,28 +65,20 @@ static int nfs_follow_link(struct dentry
 		err = ERR_PTR(-EIO);
 		goto getlink_read_error;
 	}
-	p = kmap(page);
-	p->page = page;
-	nd_set_link(nd, p->body);
-	return 0;
+	nd_set_link(nd, kmap(page));
+	return page;
 
 getlink_read_error:
 	page_cache_release(page);
 read_failed:
 	nd_set_link(nd, err);
-	return 0;
+	return NULL;
 }
 
-static void nfs_put_link(struct dentry *dentry, struct nameidata *nd)
+static void nfs_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
 {
-	char *s = nd_get_link(nd);
-	if (!IS_ERR(s)) {
-		struct nfs_symlink *p;
-		struct page *page;
-
-		p = container_of(s, struct nfs_symlink, body[0]);
-		page = p->page;
-
+	if (cookie) {
+		struct page *page = cookie;
 		kunmap(page);
 		page_cache_release(page);
 	}
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -151,17 +151,17 @@ static int sysfs_getlink(struct dentry *
 
 }
 
-static int sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *sysfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int error = -ENOMEM;
 	unsigned long page = get_zeroed_page(GFP_KERNEL);
 	if (page)
 		error = sysfs_getlink(dentry, (char *) page); 
 	nd_set_link(nd, error ? ERR_PTR(error) : (char *)page);
-	return 0;
+	return NULL;
 }
 
-static void sysfs_put_link(struct dentry *dentry, struct nameidata *nd)
+static void sysfs_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
 {
 	char *page = nd_get_link(nd);
 	if (!IS_ERR(page))
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -993,8 +993,8 @@ struct inode_operations {
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char __user *,int);
-	int (*follow_link) (struct dentry *, struct nameidata *);
-	void (*put_link) (struct dentry *, struct nameidata *);
+	void * (*follow_link) (struct dentry *, struct nameidata *);
+	void (*put_link) (struct dentry *, struct nameidata *, void *);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int, struct nameidata *);
 	int (*setattr) (struct dentry *, struct iattr *);
@@ -1602,8 +1602,8 @@ extern struct file_operations generic_ro
 extern int vfs_readlink(struct dentry *, char __user *, int, const char *);
 extern int vfs_follow_link(struct nameidata *, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);
-extern int page_follow_link_light(struct dentry *, struct nameidata *);
-extern void page_put_link(struct dentry *, struct nameidata *);
+extern void *page_follow_link_light(struct dentry *, struct nameidata *);
+extern void page_put_link(struct dentry *, struct nameidata *, void *);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern struct inode_operations page_symlink_inode_operations;
 extern int generic_readlink(struct dentry *, char __user *, int);
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1773,32 +1773,27 @@ static int shmem_symlink(struct inode *d
 	return 0;
 }
 
-static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
+static void *shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
 {
 	nd_set_link(nd, (char *)SHMEM_I(dentry->d_inode));
-	return 0;
+	return NULL;
 }
 
-static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page = NULL;
 	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ, NULL);
 	nd_set_link(nd, res ? ERR_PTR(res) : kmap(page));
-	return 0;
+	return page;
 }
 
-static void shmem_put_link(struct dentry *dentry, struct nameidata *nd)
+static void shmem_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
 {
 	if (!IS_ERR(nd_get_link(nd))) {
-		struct page *page;
-
-		page = find_get_page(dentry->d_inode->i_mapping, 0);
-		if (!page)
-			BUG();
+		struct page *page = cookie;
 		kunmap(page);
 		mark_page_accessed(page);
 		page_cache_release(page);
-		page_cache_release(page);
 	}
 }
 
