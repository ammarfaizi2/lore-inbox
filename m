Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVHSUgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVHSUgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVHSUgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:36:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932572AbVHSUgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:36:18 -0400
Date: Fri, 19 Aug 2005 13:35:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Christoph Hellwig <hch@infradead.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <20050819193834.GF29811@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0508191323250.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk>
 <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk>
 <20050819180037.GA5686@infradead.org> <20050819193834.GF29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Al Viro wrote:
> 
> FWIW, I'd rather take page_symlink(), page_symlink_inode_operations,
> page_put_link(), page_follow_link_light(), page_readlink(), page_getlink(),
> generic_readlink() and vfs_readlink() to the same place where these guys
> would live.  They all belong together and none of them has any business
> in fs/namei.c.  Options: fs/libfs.c or separate library since fs/libfs.c
> is getting crowded.  Linus, do you have any objections to that or suggestions
> on filename here?

I'm not sure if this merits a new file or new organization (hey,
fs/lib/xxx might be good in theory). In particular, I had actually been
hoping to release 2.6.13 today, but this seems like a valid thing to hold 
things up for - but not if we're going to re-organize things.

The one thing that strikes me is that we might actually have less pain if
we just changed the calling convention for follow_link/put_link slightly
instead of creating a new library function. The existing "page cache"  
thing really _does_ work very well, and would work fine for NFS and ncpfs
too, if we just allowed an extra cookie to be passed along from
"follow_link()" to "put_link()".

A patch like this (totally untested, and you'd need to update any
filesystems that don't use the regular page_follow_link interface) would
seem to clean up the mess nicely.. The basic change is that follow_link() 
returns a error-pointer cookie instead of just zero or error, and that is 
passed into put_link().

That simple calling convention change solves all problems. It so _happens_ 
that any old binary code also continues to work (the cookie will be zero, 
and put_link will ignore it), so it shouldn't even break any unconverted 
stuff (unless they mix using their own functions _and_ using the helpher 
functions, which is of course possible).

The "shouldn't break nonconverted filesystems" makes me think this is a 
safe change. Comments?

NOTE NOTE NOTE! Let me say again that it's untested. It might not break 
nonconverted filesystems, but it equally well migth break even the 
converted ones ;)

		Linus

----
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
@@ -2345,14 +2348,17 @@ int generic_readlink(struct dentry *dent
 {
 	struct nameidata nd;
 	int res;
+	void *cookie;
+
 	nd.depth = 0;
-	res = dentry->d_inode->i_op->follow_link(dentry, &nd);
-	if (!res) {
+	cookie = dentry->d_inode->i_op->follow_link(dentry, &nd);
+	if (!IS_ERR(cookie)) {
 		res = vfs_readlink(dentry, buffer, buflen, nd_get_link(&nd));
 		if (dentry->d_inode->i_op->put_link)
-			dentry->d_inode->i_op->put_link(dentry, &nd);
+			dentry->d_inode->i_op->put_link(dentry, &nd, cookie);
+		cookie = ERR_PTR(0);
 	}
-	return res;
+	return PTR_ERR(cookie);
 }
 
 int vfs_follow_link(struct nameidata *nd, const char *link)
@@ -2395,23 +2401,19 @@ int page_readlink(struct dentry *dentry,
 	return res;
 }
 
-int page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
+void *page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page;
 	nd_set_link(nd, page_getlink(dentry, &page));
-	return 0;
+	return page;
 }
 
-void page_put_link(struct dentry *dentry, struct nameidata *nd)
+void page_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
 {
 	if (!IS_ERR(nd_get_link(nd))) {
-		struct page *page;
-		page = find_get_page(dentry->d_inode->i_mapping, 0);
-		if (!page)
-			BUG();
+		struct page *page = cookie;
 		kunmap(page);
 		page_cache_release(page);
-		page_cache_release(page);
 	}
 }
 
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
