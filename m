Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSFPUmY>; Sun, 16 Jun 2002 16:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSFPUmX>; Sun, 16 Jun 2002 16:42:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56287 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316545AbSFPUmO>;
	Sun, 16 Jun 2002 16:42:14 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 22:41:43 +0200 (MEST)
Message-Id: <UTC200206162041.g5GKfhn13251.aeb@smtp.cwi.nl>
To: viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you want to try - by all means, go ahead,
> I'll be glad to see the current situation improved.

OK, let me attempt something in the style as sketched earlier today.
There are two stages: Step One is changing follow_link in all
filesystems to not call vfs_follow_link but to return immediately
so that the caller can call vfs_follow_link and release resources.

Somewhat boring work. The patch is below.
I do not doubt that you'll find all typos, so I did not try
to compile and test.

Yes, so the question was how to communicate between filesystem
and namei.c about what resources have to be freed.
I considered (i) calling the filesystem with a preallocated page,
(ii) requiring a page, (iii) requiring page or kmalloc,
(iv) letting the filesystem supply a callback.

Since I am lazy and (iii) was easiest, I did (iii).
That is also reasonable: in almost all cases it really is a page,
and a flag can signal otherwise.

The communication between filesystems and namei.c uses
char **link and page **page and two bits in nd->flags.
The filesystem gets char **link and page **page.
Its job is to fill *link with the string, but in case
it did the complete follow_link itself (as happens under /proc)
it sets the DONE flag.
Now namei.c will release page when it is nonzero, and will free
link when the filesystem tells that that is needed in the KFREE flag.

What is wrong? You will tell me, but what I disliked while doing
this was the name prepare_follow_link. Too long. A second time
I might pick get_link or so.

The result of Step One is that the loop no longer touches all
filesystems but lives entirely in namei.c. So, the second patch,
that only changes namei.c can change the recursion into iteration.
Maybe tomorrow or the day after.

Andries

diff -r -u linux-2.5.21x/linux/Documentation/filesystems/Locking linux-2.5.21w/linux/Documentation/filesystems/Locking
--- linux-2.5.21x/linux/Documentation/filesystems/Locking	Sun Jun  9 07:28:48 2002
+++ linux-2.5.21w/linux/Documentation/filesystems/Locking	Sun Jun 16 22:03:21 2002
@@ -39,7 +39,8 @@
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char *,int);
-	int (*follow_link) (struct dentry *, struct nameidata *);
+	int (*prepare_follow_link) (struct dentry *, struct nameidata *,
+			const char **, struct page **);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int);
 	int (*setattr) (struct dentry *, struct iattr *);
@@ -62,7 +63,7 @@
 rmdir:		no	yes (both)	(see below)
 rename:		no	yes (all)	(see below)
 readlink:	no	no
-follow_link:	no	no
+prepare_follow_link:	no	no
 truncate:	no	yes		(see below)
 setattr:	no	yes
 permission:	yes	no
diff -r -u linux-2.5.21x/linux/Documentation/filesystems/porting linux-2.5.21w/linux/Documentation/filesystems/porting
--- linux-2.5.21x/linux/Documentation/filesystems/porting	Sun Jun  9 07:28:29 2002
+++ linux-2.5.21w/linux/Documentation/filesystems/porting	Sun Jun 16 22:03:21 2002
@@ -196,7 +196,7 @@
 [mandatory]
 
 ->revalidate() is gone.  If your filesystem had it - provide ->getattr()
-and let it call whatever you had as ->revlidate() + (for symlinks that
+and let it call whatever you had as ->revalidate() + (for symlinks that
 had ->revalidate()) add calls in ->follow_link()/->readlink().
 
 ---
diff -r -u linux-2.5.21x/linux/fs/affs/symlink.c linux-2.5.21w/linux/fs/affs/symlink.c
--- linux-2.5.21x/linux/fs/affs/symlink.c	Sun Jun  9 07:27:47 2002
+++ linux-2.5.21w/linux/fs/affs/symlink.c	Sun Jun 16 22:03:21 2002
@@ -82,7 +82,7 @@
 };
 
 struct inode_operations affs_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	setattr:	affs_notify_change,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
+	setattr:		affs_notify_change,
 };
diff -r -u linux-2.5.21x/linux/fs/autofs/symlink.c linux-2.5.21w/linux/fs/autofs/symlink.c
--- linux-2.5.21x/linux/fs/autofs/symlink.c	Sun Jun  9 07:28:14 2002
+++ linux-2.5.21w/linux/fs/autofs/symlink.c	Sun Jun 16 22:03:21 2002
@@ -18,13 +18,15 @@
 	return vfs_readlink(dentry, buffer, buflen, s);
 }
 
-static int autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+autofs_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			   const char **llink, struct page **ppage)
 {
-	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
-	return vfs_follow_link(nd, s);
+	*llink =((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
+	return 0;
 }
 
 struct inode_operations autofs_symlink_inode_operations = {
-	readlink:	autofs_readlink,
-	follow_link:	autofs_follow_link
+	readlink:		autofs_readlink,
+	prepare_follow_link:	autofs_prepare_follow_link
 };
diff -r -u linux-2.5.21x/linux/fs/autofs4/symlink.c linux-2.5.21w/linux/fs/autofs4/symlink.c
--- linux-2.5.21x/linux/fs/autofs4/symlink.c	Sun Jun  9 07:30:37 2002
+++ linux-2.5.21w/linux/fs/autofs4/symlink.c	Sun Jun 16 22:03:21 2002
@@ -19,14 +19,17 @@
 	return vfs_readlink(dentry, buffer, buflen, ino->u.symlink);
 }
 
-static int autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+autofs4_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			    const char **llink, struct page **ppage)
 {
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
-	return vfs_follow_link(nd, ino->u.symlink);
+	*llink = ino->u.symlink;
+	return 0;
 }
 
 struct inode_operations autofs4_symlink_inode_operations = {
-	readlink:	autofs4_readlink,
-	follow_link:	autofs4_follow_link
+	readlink:		autofs4_readlink,
+	prepare_follow_link:	autofs4_prepare_follow_link
 };
diff -r -u linux-2.5.21x/linux/fs/bad_inode.c linux-2.5.21w/linux/fs/bad_inode.c
--- linux-2.5.21x/linux/fs/bad_inode.c	Sun Jun  9 07:27:47 2002
+++ linux-2.5.21w/linux/fs/bad_inode.c	Sun Jun 16 22:03:21 2002
@@ -16,9 +16,12 @@
  * so that a bad root inode can at least be unmounted. To do this
  * we must dput() the base and return the dentry with a dget().
  */
-static int bad_follow_link(struct dentry *dent, struct nameidata *nd)
+static int
+bad_prepare_follow_link(struct dentry *dent, struct nameidata *nd,
+			const char **llink, struct page **ppage)
 {
-	return vfs_follow_link(nd, ERR_PTR(-EIO));
+	*llink = ERR_PTR(-EIO);
+	return 0;
 }
 
 static int return_EIO(void)
@@ -57,7 +60,7 @@
 	mknod:		EIO_ERROR,
 	rename:		EIO_ERROR,
 	readlink:	EIO_ERROR,
-	follow_link:	bad_follow_link,
+	prepare_follow_link:	bad_prepare_follow_link,
 	truncate:	EIO_ERROR,
 	permission:	EIO_ERROR,
 	getattr:	EIO_ERROR,
diff -r -u linux-2.5.21x/linux/fs/coda/cnode.c linux-2.5.21w/linux/fs/coda/cnode.c
--- linux-2.5.21x/linux/fs/coda/cnode.c	Sun Jun  9 07:28:02 2002
+++ linux-2.5.21w/linux/fs/coda/cnode.c	Sun Jun 16 22:03:21 2002
@@ -26,9 +26,9 @@
 }
 
 static struct inode_operations coda_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	setattr:	coda_setattr,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
+	setattr:		coda_setattr,
 };
 
 /* cnode.c */
diff -r -u linux-2.5.21x/linux/fs/coda/symlink.c linux-2.5.21w/linux/fs/coda/symlink.c
--- linux-2.5.21x/linux/fs/coda/symlink.c	Sun Jun  9 07:28:04 2002
+++ linux-2.5.21w/linux/fs/coda/symlink.c	Sun Jun 16 22:03:21 2002
@@ -32,7 +32,7 @@
 
 	lock_kernel();
 	cii = ITOC(inode);
-	coda_vfs_stat.follow_link++;
+	coda_vfs_stat.prepare_follow_link++;
 
 	error = venus_readlink(inode->i_sb, &cii->c_fid, p, &len);
 	unlock_kernel();
diff -r -u linux-2.5.21x/linux/fs/devfs/base.c linux-2.5.21w/linux/fs/devfs/base.c
--- linux-2.5.21x/linux/fs/devfs/base.c	Sun Jun  9 07:27:42 2002
+++ linux-2.5.21w/linux/fs/devfs/base.c	Sun Jun 16 22:03:21 2002
@@ -3210,16 +3210,19 @@
     return err;
 }   /*  End Function devfs_readlink  */
 
-static int devfs_follow_link (struct dentry *dentry, struct nameidata *nd)
+static int
+devfs_prepare_follow_link (struct dentry *dentry, struct nameidata *nd,
+			   const char **llink, struct page **ppage)
 {
     int err;
     struct devfs_entry *de;
 
     de = get_devfs_entry_from_vfs_inode (dentry->d_inode);
-    if (!de) return -ENODEV;
-    err = vfs_follow_link (nd, de->u.symlink.linkname);
-    return err;
-}   /*  End Function devfs_follow_link  */
+    if (!de)
+	return -ENODEV;
+    *llink = de->u.symlink.linkname;
+    return 0;
+}   /*  End Function devfs_prepare_follow_link  */
 
 static struct inode_operations devfs_iops =
 {
@@ -3239,9 +3242,9 @@
 
 static struct inode_operations devfs_symlink_iops =
 {
-    readlink:       devfs_readlink,
-    follow_link:    devfs_follow_link,
-    setattr:        devfs_notify_change,
+    readlink:	            devfs_readlink,
+    prepare_follow_link:    devfs_prepare_follow_link,
+    setattr:                devfs_notify_change,
 };
 
 static int devfs_fill_super (struct super_block *sb, void *data, int silent)
diff -r -u linux-2.5.21x/linux/fs/ext2/symlink.c linux-2.5.21w/linux/fs/ext2/symlink.c
--- linux-2.5.21x/linux/fs/ext2/symlink.c	Sun Jun  9 07:28:06 2002
+++ linux-2.5.21w/linux/fs/ext2/symlink.c	Sun Jun 16 22:03:21 2002
@@ -25,13 +25,16 @@
 	return vfs_readlink(dentry, buffer, buflen, (char *)ei->i_data);
 }
 
-static int ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+ext2_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			 const char **llink, struct page **ppage)
 {
 	struct ext2_inode_info *ei = EXT2_I(dentry->d_inode);
-	return vfs_follow_link(nd, (char *)ei->i_data);
+	*llink = (char *) ei->i_data;
+	return 0;
 }
 
 struct inode_operations ext2_fast_symlink_inode_operations = {
-	readlink:	ext2_readlink,
-	follow_link:	ext2_follow_link,
+	readlink:		ext2_readlink,
+	prepare_follow_link:	ext2_prepare_follow_link,
 };
diff -r -u linux-2.5.21x/linux/fs/ext3/symlink.c linux-2.5.21w/linux/fs/ext3/symlink.c
--- linux-2.5.21x/linux/fs/ext3/symlink.c	Sun Jun  9 07:30:22 2002
+++ linux-2.5.21w/linux/fs/ext3/symlink.c	Sun Jun 16 22:03:21 2002
@@ -27,13 +27,17 @@
 	return vfs_readlink(dentry, buffer, buflen, (char*)ei->i_data);
 }
 
-static int ext3_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+ext3_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			 const char **llink, struct page **ppage)
 {
 	struct ext3_inode_info *ei = EXT3_I(dentry->d_inode);
-	return vfs_follow_link(nd, (char*)ei->i_data);
+
+	*llink = (char*) ei->i_data;
+	return 0;
 }
 
 struct inode_operations ext3_fast_symlink_inode_operations = {
-	readlink:	ext3_readlink,		/* BKL not held.  Don't need */
-	follow_link:	ext3_follow_link,	/* BKL not held.  Don't need */
+	readlink:		ext3_readlink,		  /* BKL not held */
+	prepare_follow_link:	ext3_prepare_follow_link, /* BKL not held */
 };
diff -r -u linux-2.5.21x/linux/fs/freevxfs/vxfs_immed.c linux-2.5.21w/linux/fs/freevxfs/vxfs_immed.c
--- linux-2.5.21x/linux/fs/freevxfs/vxfs_immed.c	Sun Jun  9 07:27:22 2002
+++ linux-2.5.21w/linux/fs/freevxfs/vxfs_immed.c	Sun Jun 16 22:03:21 2002
@@ -40,19 +40,20 @@
 
 
 static int	vxfs_immed_readlink(struct dentry *, char *, int);
-static int	vxfs_immed_follow_link(struct dentry *, struct nameidata *);
-
+static int	vxfs_immed_prepare_follow_link(
+			struct dentry *, struct nameidata *,
+			const char **llink, struct page **ppage);
 static int	vxfs_immed_readpage(struct file *, struct page *);
 
 /*
  * Inode operations for immed symlinks.
  *
- * Unliked all other operations we do not go through the pagecache,
+ * Unlike all other operations we do not go through the pagecache,
  * but do all work directly on the inode.
  */
 struct inode_operations vxfs_immed_symlink_iops = {
-	.readlink =		vxfs_immed_readlink,
-	.follow_link =		vxfs_immed_follow_link,
+	.readlink =			vxfs_immed_readlink,
+	.prepare_follow_link =		vxfs_immed_prepare_follow_link,
 };
 
 /*
@@ -85,23 +86,27 @@
 }
 
 /**
- * vxfs_immed_follow_link - follow immed symlink
+ * vxfs_immed_prepare_follow_link - find link contents
  * @dp:		dentry for the link
  * @np:		pathname lookup data for the current path walk
+ * @llink:	store pointer to link contents here
+ * @ppage:	in case a temp page was used, store it here
  *
  * Description:
- *   vxfs_immed_follow_link restarts the pathname lookup with
- *   the data obtained from @dp.
+ *   vxfs_immed_prepare_follow_link retrieves the contents of a
+ *   symlink, for use by vfs_follow_link().
  *
  * Returns:
  *   Zero on success, else a negative error code.
  */
 static int
-vxfs_immed_follow_link(struct dentry *dp, struct nameidata *np)
+vxfs_immed_prepare_follow_link(struct dentry *dp, struct nameidata *np,
+			       const char **llink, struct page **ppage)
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);
 
-	return (vfs_follow_link(np, vip->vii_immed.vi_immed));
+	*llink = vip->vii_immed.vi_immed;
+	return 0;
 }
 
 /**
diff -r -u linux-2.5.21x/linux/fs/jffs2/symlink.c linux-2.5.21w/linux/fs/jffs2/symlink.c
--- linux-2.5.21x/linux/fs/jffs2/symlink.c	Sun Jun  9 07:26:25 2002
+++ linux-2.5.21w/linux/fs/jffs2/symlink.c	Sun Jun 16 22:03:21 2002
@@ -42,13 +42,14 @@
 #include "nodelist.h"
 
 int jffs2_readlink(struct dentry *dentry, char *buffer, int buflen);
-int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd);
+int jffs2_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			      const char **llink, struct page **ppage);
 
 struct inode_operations jffs2_symlink_inode_operations =
 {	
-	readlink:	jffs2_readlink,
-	follow_link:	jffs2_follow_link,
-	setattr:	jffs2_setattr
+	readlink:		jffs2_readlink,
+	prepare_follow_link:	jffs2_prepare_follow_link,
+	setattr:		jffs2_setattr
 };
 
 int jffs2_readlink(struct dentry *dentry, char *buffer, int buflen)
@@ -56,7 +57,8 @@
 	unsigned char *kbuf;
 	int ret;
 
-	kbuf = jffs2_getlink(JFFS2_SB_INFO(dentry->d_inode->i_sb), JFFS2_INODE_INFO(dentry->d_inode));
+	kbuf = jffs2_getlink(JFFS2_SB_INFO(dentry->d_inode->i_sb),
+			     JFFS2_INODE_INFO(dentry->d_inode));
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
@@ -65,17 +67,21 @@
 	return ret;
 }
 
-int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd)
+int jffs2_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			      const char **llink, struct page **ppage)
 {
 	unsigned char *buf;
 	int ret;
 
-	buf = jffs2_getlink(JFFS2_SB_INFO(dentry->d_inode->i_sb), JFFS2_INODE_INFO(dentry->d_inode));
+	buf = jffs2_getlink(JFFS2_SB_INFO(dentry->d_inode->i_sb),
+			    JFFS2_INODE_INFO(dentry->d_inode));
 
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = vfs_follow_link(nd, buf);
-	kfree(buf);
-	return ret;
+	/* free buf when done */
+	nd->flags |= LOOKUP_KFREE_NEEDED;
+
+	*llink = buf;
+	return 0;
 }
diff -r -u linux-2.5.21x/linux/fs/jffs2/wbuf.c linux-2.5.21w/linux/fs/jffs2/wbuf.c
--- linux-2.5.21x/linux/fs/jffs2/wbuf.c	Sun Jun  9 07:28:14 2002
+++ linux-2.5.21w/linux/fs/jffs2/wbuf.c	Sun Jun 16 22:03:21 2002
@@ -367,7 +367,7 @@
 		 * We have the raw data without ECC correction in the buffer, maybe 
 		 * we are lucky and all data or parts are correct. We check the node.
 		 * If data are corrupted node check will sort it out.
-		 * We keep this block, it will fail on write or erase and the we
+		 * We keep this block, it will fail on write or erase and then we
 		 * mark it bad. Or should we do that now? But we should give him a chance.
 		 * Maybe we had a system crash or power loss before the ecc write or  
 		 * a erase was completed.
diff -r -u linux-2.5.21x/linux/fs/jfs/symlink.c linux-2.5.21w/linux/fs/jfs/symlink.c
--- linux-2.5.21x/linux/fs/jfs/symlink.c	Sun Jun  9 07:30:01 2002
+++ linux-2.5.21w/linux/fs/jfs/symlink.c	Sun Jun 16 22:03:21 2002
@@ -20,20 +20,22 @@
 #include "jfs_incore.h"
 
 static int jfs_readlink(struct dentry *, char *buffer, int buflen);
-static int jfs_follow_link(struct dentry *dentry, struct nameidata *nd);
+static int jfs_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+				   const char **llink, struct page **ppage);
 
 /*
  * symlinks can't do much...
  */
 struct inode_operations jfs_symlink_inode_operations = {
-	readlink:	jfs_readlink,
-	follow_link:	jfs_follow_link,
+	readlink:		jfs_readlink,
+	prepare_follow_link:	jfs_prepare_follow_link,
 };
 
-static int jfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int jfs_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+				   const char **llink, struct page **ppage)
 {
-	char *s = JFS_IP(dentry->d_inode)->i_inline;
-	return vfs_follow_link(nd, s);
+	*llink = JFS_IP(dentry->d_inode)->i_inline;
+	return 0;
 }
 
 static int jfs_readlink(struct dentry *dentry, char *buffer, int buflen)
diff -r -u linux-2.5.21x/linux/fs/minix/inode.c linux-2.5.21w/linux/fs/minix/inode.c
--- linux-2.5.21x/linux/fs/minix/inode.c	Sun Jun  9 07:30:19 2002
+++ linux-2.5.21w/linux/fs/minix/inode.c	Sun Jun 16 22:03:21 2002
@@ -342,9 +342,9 @@
 };
 
 static struct inode_operations minix_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	getattr:	minix_getattr,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
+	getattr:		minix_getattr,
 };
 
 void minix_set_inode(struct inode *inode, dev_t rdev)
diff -r -u linux-2.5.21x/linux/fs/namei.c linux-2.5.21w/linux/fs/namei.c
--- linux-2.5.21x/linux/fs/namei.c	Sun Jun  9 07:28:50 2002
+++ linux-2.5.21w/linux/fs/namei.c	Sun Jun 16 22:03:21 2002
@@ -384,6 +384,38 @@
 	return result;
 }
 
+static inline int
+__vfs_follow_link(struct nameidata *nd, const char *link);
+
+static inline int
+do_follow_link_nocount(struct dentry *dentry, struct nameidata *nd)
+{
+	const char *link = NULL;
+	struct page *page = NULL;
+	int err;
+
+	UPDATE_ATIME(dentry->d_inode);
+	err = dentry->d_inode->i_op->prepare_follow_link(dentry, nd,
+							 &link, &page);
+
+	/* do actual follow_link() unless the prepare already did all */
+	if (nd->flags & LOOKUP_FOLLOW_DONE)
+		nd->flags &= ~LOOKUP_FOLLOW_DONE;
+	else if (err == 0)
+		err = __vfs_follow_link(nd, link);
+
+	/* free resources used by the filesystem: link or page */
+	if (nd->flags & LOOKUP_KFREE_NEEDED) {
+		nd->flags &= ~LOOKUP_KFREE_NEEDED;
+		kfree (link);
+	} else if (page) {
+		kunmap(page);
+		page_cache_release(page);
+	}
+
+	return err;
+}
+
 /*
  * This limits recursive symlink follows to 8, while
  * limiting consecutive symlinks to 40.
@@ -394,6 +426,7 @@
 static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	int err;
+
 	if (current->link_count >= 5)
 		goto loop;
 	if (current->total_link_count >= 40)
@@ -402,10 +435,12 @@
 		current->state = TASK_RUNNING;
 		schedule();
 	}
+
 	current->link_count++;
 	current->total_link_count++;
-	UPDATE_ATIME(dentry->d_inode);
-	err = dentry->d_inode->i_op->follow_link(dentry, nd);
+
+	err = do_follow_link_nocount(dentry, nd);
+
 	current->link_count--;
 	return err;
 loop:
@@ -648,7 +683,7 @@
 		if (!inode->i_op)
 			break;
 
-		if (inode->i_op->follow_link) {
+		if (inode->i_op->prepare_follow_link) {
 			mntget(next.mnt);
 			dget_locked(next.dentry);
 			unlock_nd(nd);
@@ -703,7 +738,8 @@
 		follow_mount(&next.mnt, &next.dentry);
 		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
-		    && inode && inode->i_op && inode->i_op->follow_link) {
+		    && inode && inode->i_op
+		    && inode->i_op->prepare_follow_link) {
 			mntget(next.mnt);
 			dget_locked(next.dentry);
 			unlock_nd(nd);
@@ -767,8 +803,8 @@
 	if (!nd->dentry->d_inode || S_ISDIR(nd->dentry->d_inode->i_mode)) {
 		struct nameidata nd_root;
 		/*
-		 * NAME was not found in alternate root or it's a directory.  Try to find
-		 * it in the normal root:
+		 * NAME was not found in alternate root or it's a directory.
+		 * Try to find it in the normal root:
 		 */
 		nd_root.last_type = LAST_ROOT;
 		nd_root.flags = nd->flags;
@@ -871,8 +907,7 @@
 		spin_lock(&dcache_lock);
 		nd->mnt = current->fs->rootmnt;
 		nd->dentry = current->fs->root;
-	}
-	else{
+	} else {
 		spin_lock(&dcache_lock);
 		nd->mnt = current->fs->pwdmnt;
 		nd->dentry = current->fs->pwd;
@@ -1303,7 +1338,8 @@
 	error = -ENOENT;
 	if (!dentry->d_inode)
 		goto exit_dput;
-	if (dentry->d_inode->i_op && dentry->d_inode->i_op->follow_link)
+	if (dentry->d_inode->i_op &&
+	    dentry->d_inode->i_op->prepare_follow_link)
 		goto do_link;
 
 	dput(nd->dentry);
@@ -1337,8 +1373,8 @@
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
-	UPDATE_ATIME(dentry->d_inode);
-	error = dentry->d_inode->i_op->follow_link(dentry, nd);
+	error = do_follow_link_nocount(dentry, nd);
+
 	dput(dentry);
 	if (error)
 		return error;
@@ -2065,8 +2101,9 @@
 	}
 	lock_nd(nd);
 	res = link_path_walk(link, nd);
+
 out:
-	if (current->link_count || res || nd->last_type!=LAST_NORM)
+	if (current->link_count || res || nd->last_type != LAST_NORM)
 		return res;
 	/*
 	 * If it is an iterative symlinks resolution in open_namei() we
@@ -2084,18 +2121,13 @@
 	return PTR_ERR(link);
 }
 
-int vfs_follow_link(struct nameidata *nd, const char *link)
-{
-	return __vfs_follow_link(nd, link);
-}
-
 /* get the link contents into pagecache */
 static char *page_getlink(struct dentry * dentry, struct page **ppage)
 {
 	struct page * page;
 	struct address_space *mapping = dentry->d_inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
-				NULL);
+	page = read_cache_page(mapping, 0,
+			       (filler_t *) mapping->a_ops->readpage, NULL);
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page_locked(page);
@@ -2124,16 +2156,11 @@
 	return res;
 }
 
-int page_follow_link(struct dentry *dentry, struct nameidata *nd)
+int page_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			     const char **llink, struct page **ppage)
 {
-	struct page *page = NULL;
-	char *s = page_getlink(dentry, &page);
-	int res = __vfs_follow_link(nd, s);
-	if (page) {
-		kunmap(page);
-		page_cache_release(page);
-	}
-	return res;
+	*llink = page_getlink(dentry, ppage);
+	return 0;
 }
 
 int page_symlink(struct inode *inode, const char *symname, int len)
@@ -2177,6 +2204,6 @@
 }
 
 struct inode_operations page_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
 };
diff -r -u linux-2.5.21x/linux/fs/namespace.c linux-2.5.21w/linux/fs/namespace.c
--- linux-2.5.21x/linux/fs/namespace.c	Sun Jun  9 07:30:41 2002
+++ linux-2.5.21w/linux/fs/namespace.c	Sun Jun 16 22:03:21 2002
@@ -363,7 +363,7 @@
 	struct nameidata nd;
 	int retval;
 
-	retval = __user_walk(name, LOOKUP_FOLLOW, &nd);
+	retval = user_path_walk(name, &nd);
 	if (retval)
 		goto out;
 	retval = -EINVAL;
@@ -908,14 +908,14 @@
 
 	lock_kernel();
 
-	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
+	error = user_path_walk_dir(new_root, &new_nd);
 	if (error)
 		goto out0;
 	error = -EINVAL;
 	if (!check_mnt(new_nd.mnt))
 		goto out1;
 
-	error = __user_walk(put_old, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
+	error = user_path_walk_dir(put_old, &old_nd);
 	if (error)
 		goto out1;
 
diff -r -u linux-2.5.21x/linux/fs/ncpfs/inode.c linux-2.5.21w/linux/fs/ncpfs/inode.c
--- linux-2.5.21x/linux/fs/ncpfs/inode.c	Sun Jun  9 07:30:03 2002
+++ linux-2.5.21w/linux/fs/ncpfs/inode.c	Sun Jun 16 22:03:21 2002
@@ -244,9 +244,9 @@
 }
 
 static struct inode_operations ncp_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	setattr:	ncp_notify_change,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
+	setattr:		ncp_notify_change,
 };
 
 /*
diff -r -u linux-2.5.21x/linux/fs/nfs/symlink.c linux-2.5.21w/linux/fs/nfs/symlink.c
--- linux-2.5.21x/linux/fs/nfs/symlink.c	Sun Jun  9 07:26:23 2002
+++ linux-2.5.21w/linux/fs/nfs/symlink.c	Sun Jun 16 22:03:21 2002
@@ -59,7 +59,7 @@
 	if (page)
 		goto read_failed;
 	page = read_cache_page(&inode->i_data, 0,
-				(filler_t *)nfs_symlink_filler, inode);
+			       (filler_t *) nfs_symlink_filler, inode);
 	if (IS_ERR(page))
 		goto read_failed;
 	if (!PageUptodate(page))
@@ -87,24 +87,19 @@
 	return res;
 }
 
-static int nfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int nfs_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+				   const char **llink, struct page **ppage)
 {
-	struct inode *inode = dentry->d_inode;
-	struct page *page = NULL;
-	int res = vfs_follow_link(nd, nfs_getlink(inode,&page));
-	if (page) {
-		kunmap(page);
-		page_cache_release(page);
-	}
-	return res;
+	*llink = nfs_getlink(dentry->d_inode, ppage);
+	return 0;
 }
 
 /*
  * symlinks can't do much...
  */
 struct inode_operations nfs_symlink_inode_operations = {
-	readlink:	nfs_readlink,
-	follow_link:	nfs_follow_link,
-	getattr:	nfs_getattr,
-	setattr:	nfs_setattr,
+	readlink:		nfs_readlink,
+	prepare_follow_link:	nfs_prepare_follow_link,
+	getattr:		nfs_getattr,
+	setattr:		nfs_setattr,
 };
diff -r -u linux-2.5.21x/linux/fs/open.c linux-2.5.21w/linux/fs/open.c
--- linux-2.5.21x/linux/fs/open.c	Sun Jun  9 07:26:54 2002
+++ linux-2.5.21w/linux/fs/open.c	Sun Jun 16 22:03:21 2002
@@ -373,7 +373,7 @@
 	struct nameidata nd;
 	int error;
 
-	error = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
+	error = user_path_walk_dir(filename, &nd);
 	if (error)
 		goto out;
 
diff -r -u linux-2.5.21x/linux/fs/proc/base.c linux-2.5.21w/linux/fs/proc/base.c
--- linux-2.5.21x/linux/fs/proc/base.c	Sun Jun  9 07:26:58 2002
+++ linux-2.5.21w/linux/fs/proc/base.c	Sun Jun 16 22:03:21 2002
@@ -525,7 +525,9 @@
 	permission:	proc_permission,
 };
 
-static int proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+proc_pid_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			     const char **llink, struct page **ppage)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EACCES;
@@ -542,6 +544,7 @@
 	error = PROC_I(inode)->op.proc_get_link(inode, &nd->dentry, &nd->mnt);
 	nd->last_type = LAST_BIND;
 out:
+	nd->flags |= LOOKUP_FOLLOW_DONE; /* no vfs_follow_link() required */
 	return error;
 }
 
@@ -594,8 +597,8 @@
 }
 
 static struct inode_operations proc_pid_link_inode_operations = {
-	readlink:	proc_pid_readlink,
-	follow_link:	proc_pid_follow_link
+	readlink:		proc_pid_readlink,
+	prepare_follow_link:	proc_pid_prepare_follow_link
 };
 
 #define NUMBUF 10
@@ -1057,16 +1060,25 @@
 	return vfs_readlink(dentry,buffer,buflen,tmp);
 }
 
-static int proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
-{
-	char tmp[30];
+static int
+proc_self_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			      const char **llink, struct page **ppage)
+{
+	char *tmp = kmalloc(30, GFP_USER);
+	if (tmp == NULL) {
+		path_release(nd);
+		return -ENOMEM;
+	}
+
+	nd->flags |= LOOKUP_KFREE_NEEDED;
 	sprintf(tmp, "%d", current->pid);
-	return vfs_follow_link(nd,tmp);
+	*llink = tmp;
+	return 0;
 }	
 
 static struct inode_operations proc_self_inode_operations = {
-	readlink:	proc_self_readlink,
-	follow_link:	proc_self_follow_link,
+	readlink:		proc_self_readlink,
+	prepare_follow_link:	proc_self_prepare_follow_link,
 };
 
 /* SMP-safe */
diff -r -u linux-2.5.21x/linux/fs/proc/generic.c linux-2.5.21w/linux/fs/proc/generic.c
--- linux-2.5.21x/linux/fs/proc/generic.c	Sun Jun  9 07:31:31 2002
+++ linux-2.5.21w/linux/fs/proc/generic.c	Sun Jun 16 22:03:21 2002
@@ -223,15 +223,17 @@
 	return vfs_readlink(dentry, buffer, buflen, s);
 }
 
-static int proc_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+proc_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			 const char **llink, struct page **ppage)
 {
-	char *s=PDE(dentry->d_inode)->data;
-	return vfs_follow_link(nd, s);
+	*llink = PDE(dentry->d_inode)->data;
+	return 0;
 }
 
 static struct inode_operations proc_link_inode_operations = {
-	readlink:	proc_readlink,
-	follow_link:	proc_follow_link,
+	readlink:		proc_readlink,
+	prepare_follow_link:	proc_prepare_follow_link,
 };
 
 /*
diff -r -u linux-2.5.21x/linux/fs/sysv/inode.c linux-2.5.21w/linux/fs/sysv/inode.c
--- linux-2.5.21x/linux/fs/sysv/inode.c	Sun Jun  9 07:26:33 2002
+++ linux-2.5.21w/linux/fs/sysv/inode.c	Sun Jun 16 22:03:21 2002
@@ -131,9 +131,9 @@
 }
 
 static struct inode_operations sysv_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	getattr:	sysv_getattr,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
+	getattr:		sysv_getattr,
 };
 
 void sysv_set_inode(struct inode *inode, dev_t rdev)
diff -r -u linux-2.5.21x/linux/fs/sysv/symlink.c linux-2.5.21w/linux/fs/sysv/symlink.c
--- linux-2.5.21x/linux/fs/sysv/symlink.c	Sun Jun  9 07:31:18 2002
+++ linux-2.5.21w/linux/fs/sysv/symlink.c	Sun Jun 16 22:03:21 2002
@@ -13,13 +13,15 @@
 	return vfs_readlink(dentry, buffer, buflen, s);
 }
 
-static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+sysv_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			 const char **llink, struct page **ppage)
 {
-	char *s = (char *)SYSV_I(dentry->d_inode)->i_data;
-	return vfs_follow_link(nd, s);
+	*llink = (char *) SYSV_I(dentry->d_inode)->i_data;
+	return 0;
 }
 
 struct inode_operations sysv_fast_symlink_inode_operations = {
-	readlink:	sysv_readlink,
-	follow_link:	sysv_follow_link,
+	readlink:		sysv_readlink,
+	prepare_follow_link:	sysv_prepare_follow_link,
 };
diff -r -u linux-2.5.21x/linux/fs/ufs/symlink.c linux-2.5.21w/linux/fs/ufs/symlink.c
--- linux-2.5.21x/linux/fs/ufs/symlink.c	Sun Jun  9 07:28:03 2002
+++ linux-2.5.21w/linux/fs/ufs/symlink.c	Sun Jun 16 22:03:21 2002
@@ -34,13 +34,15 @@
 	return vfs_readlink(dentry, buffer, buflen, (char*)p->i_u1.i_symlink);
 }
 
-static int ufs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int ufs_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+				   const char **llink, struct page **ppage)
 {
 	struct ufs_inode_info *p = UFS_I(dentry->d_inode);
-	return vfs_follow_link(nd, (char*)p->i_u1.i_symlink);
+	*llink = (char *) p->i_u1.i_symlink;
+	return 0;
 }
 
 struct inode_operations ufs_fast_symlink_inode_operations = {
-	readlink:	ufs_readlink,
-	follow_link:	ufs_follow_link,
+	readlink:		ufs_readlink,
+	prepare_follow_link:	ufs_prepare_follow_link,
 };
diff -r -u linux-2.5.21x/linux/fs/umsdos/inode.c linux-2.5.21w/linux/fs/umsdos/inode.c
--- linux-2.5.21x/linux/fs/umsdos/inode.c	Sun Jun  9 07:27:26 2002
+++ linux-2.5.21w/linux/fs/umsdos/inode.c	Sun Jun 16 22:03:21 2002
@@ -113,9 +113,9 @@
 };
 
 static struct inode_operations umsdos_symlink_inode_operations = {
-	readlink:	page_readlink,
-	follow_link:	page_follow_link,
-	setattr:	UMSDOS_notify_change,
+	readlink:		page_readlink,
+	prepare_follow_link:	page_prepare_follow_link,
+	setattr:		UMSDOS_notify_change,
 };
 
 /*
diff -r -u linux-2.5.21x/linux/include/linux/coda_proc.h linux-2.5.21w/linux/include/linux/coda_proc.h
--- linux-2.5.21x/linux/include/linux/coda_proc.h	Sun Jun  9 07:26:36 2002
+++ linux-2.5.21w/linux/include/linux/coda_proc.h	Sun Jun 16 22:03:21 2002
@@ -56,8 +56,8 @@
 	int rename;
 	int permission;
 
-	/* symlink operatoins*/
-	int follow_link;
+	/* symlink operations*/
+	int prepare_follow_link;
 	int readlink;
 };
 
diff -r -u linux-2.5.21x/linux/include/linux/fs.h linux-2.5.21w/linux/include/linux/fs.h
--- linux-2.5.21x/linux/include/linux/fs.h	Sun Jun  9 07:28:14 2002
+++ linux-2.5.21w/linux/include/linux/fs.h	Sun Jun 16 22:03:21 2002
@@ -771,7 +771,8 @@
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
 	int (*readlink) (struct dentry *, char *,int);
-	int (*follow_link) (struct dentry *, struct nameidata *);
+	int (*prepare_follow_link) (struct dentry *, struct nameidata *,
+				    const char **, struct page **);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int);
 	int (*setattr) (struct dentry *, struct iattr *);
@@ -1242,9 +1243,9 @@
 extern struct file_operations generic_ro_fops;
 
 extern int vfs_readlink(struct dentry *, char *, int, const char *);
-extern int vfs_follow_link(struct nameidata *, const char *);
 extern int page_readlink(struct dentry *, char *, int);
-extern int page_follow_link(struct dentry *, struct nameidata *);
+extern int page_prepare_follow_link(struct dentry *, struct nameidata *,
+				    const char **, struct page **);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern struct inode_operations page_symlink_inode_operations;
 extern void generic_fillattr(struct inode *, struct kstat *);
diff -r -u linux-2.5.21x/linux/include/linux/namei.h linux-2.5.21w/linux/include/linux/namei.h
--- linux-2.5.21x/linux/include/linux/namei.h	Sun Jun  9 07:28:48 2002
+++ linux-2.5.21w/linux/include/linux/namei.h	Sun Jun 16 22:03:21 2002
@@ -33,13 +33,16 @@
 #define LOOKUP_CONTINUE		 4
 #define LOOKUP_PARENT		16
 #define LOOKUP_NOALT		32
-
+#define LOOKUP_FOLLOW_DONE	64
+#define LOOKUP_KFREE_NEEDED	128
 
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
-#define user_path_walk(name,nd) \
-	__user_walk(name, LOOKUP_FOLLOW, nd)
 #define user_path_walk_link(name,nd) \
 	__user_walk(name, 0, nd)
+#define user_path_walk(name,nd) \
+	__user_walk(name, LOOKUP_FOLLOW, nd)
+#define user_path_walk_dir(name,nd) \
+	__user_walk(name, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, nd)
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
diff -r -u linux-2.5.21x/linux/kernel/ksyms.c linux-2.5.21w/linux/kernel/ksyms.c
--- linux-2.5.21x/linux/kernel/ksyms.c	Sun Jun  9 07:26:33 2002
+++ linux-2.5.21w/linux/kernel/ksyms.c	Sun Jun 16 22:03:21 2002
@@ -272,9 +272,8 @@
 EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(vfs_readlink);
-EXPORT_SYMBOL(vfs_follow_link);
 EXPORT_SYMBOL(page_readlink);
-EXPORT_SYMBOL(page_follow_link);
+EXPORT_SYMBOL(page_prepare_follow_link);
 EXPORT_SYMBOL(page_symlink_inode_operations);
 EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(vfs_readdir);
diff -r -u linux-2.5.21x/linux/mm/shmem.c linux-2.5.21w/linux/mm/shmem.c
--- linux-2.5.21x/linux/mm/shmem.c	Sun Jun  9 07:29:25 2002
+++ linux-2.5.21w/linux/mm/shmem.c	Sun Jun 16 22:03:21 2002
@@ -1205,9 +1205,12 @@
 	return vfs_readlink(dentry,buffer,buflen, (const char *)SHMEM_I(dentry->d_inode));
 }
 
-static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
+static int
+shmem_prepare_follow_link_inline(struct dentry *dentry, struct nameidata *nd,
+				 const char **llink, struct page **ppage)
 {
-	return vfs_follow_link(nd, (const char *)SHMEM_I(dentry->d_inode));
+	*llink = (const char *) SHMEM_I(dentry->d_inode);
+	return 0;
 }
 
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
@@ -1224,28 +1227,26 @@
 	return res;
 }
 
-static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
+static int
+shmem_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			  const char **llink, struct page **ppage)
 {
-	struct page * page;
-	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	int res = shmem_getpage(dentry->d_inode, 0, ppage);
 	if (res)
 		return res;
-
-	res = vfs_follow_link(nd, kmap(page));
-	kunmap(page);
-	page_cache_release(page);
-	return res;
+	*llink = kmap(*ppage);
+	return 0;
 }
 
 static struct inode_operations shmem_symlink_inline_operations = {
-	readlink:	shmem_readlink_inline,
-	follow_link:	shmem_follow_link_inline,
+	readlink:		shmem_readlink_inline,
+	prepare_follow_link:	shmem_prepare_follow_link_inline,
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
-	truncate:	shmem_truncate,
-	readlink:	shmem_readlink,
-	follow_link:	shmem_follow_link,
+	truncate:		shmem_truncate,
+	readlink:		shmem_readlink,
+	prepare_follow_link:	shmem_prepare_follow_link,
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long * blocks, unsigned long *inodes)
diff -r -u linux-2.5.21x/linux/sound/core/info.c linux-2.5.21w/linux/sound/core/info.c
--- linux-2.5.21x/linux/sound/core/info.c	Sun Jun  9 07:29:22 2002
+++ linux-2.5.21w/linux/sound/core/info.c	Sun Jun 16 22:03:21 2002
@@ -560,53 +560,22 @@
 				  char *buffer, int buflen)
 {
         char *s = PDE(dentry->d_inode)->data;
-#ifndef LINUX_2_2
+
 	return vfs_readlink(dentry, buffer, buflen, s);
-#else
-	int len;
-	
-	if (s == NULL)
-		return -EIO;
-	len = strlen(s);
-	if (len > buflen)
-		len = buflen;
-	if (copy_to_user(buffer, s, len))
-		return -EFAULT;
-	return len;
-#endif
 }
 
-#ifndef LINUX_2_2
-static int snd_info_card_followlink(struct dentry *dentry,
-				    struct nameidata *nd)
-{
-        char *s = PDE(dentry->d_inode)->data;
-        return vfs_follow_link(nd, s);
-}
-#else
-static struct dentry *snd_info_card_followlink(struct dentry *dentry,
-					       struct dentry *base,
-					       unsigned int follow)
+static int
+snd_info_card_prepare_followlink(struct dentry *dentry, struct nameidata *nd,
+				 const char **llink, struct page **ppage)
 {
-	char *s = PDE(dentry->d_inode)->data;
-	return lookup_dentry(s, base, follow);
+        *llink = PDE(dentry->d_inode)->data;
+        return 0;
 }
-#endif
-
-#ifdef LINUX_2_2
-static struct file_operations snd_info_card_link_operations =
-{
-	NULL
-};
-#endif
 
 struct inode_operations snd_info_card_link_inode_operations =
 {
-#ifdef LINUX_2_2
-	default_file_ops:	&snd_info_card_link_operations,
-#endif
 	readlink:		snd_info_card_readlink,
-	follow_link:		snd_info_card_followlink,
+	prepare_follow_link:	snd_info_card_prepare_followlink,
 };
 
 struct proc_dir_entry *snd_create_proc_entry(const char *name, mode_t mode,

