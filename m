Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbVHSXOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbVHSXOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbVHSXOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:14:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30375 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932746AbVHSXOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:14:42 -0400
Date: Sat, 20 Aug 2005 00:17:39 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819231738.GK29811@parcelfarce.linux.theplanet.co.uk>
References: <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org> <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org> <20050819231542.GJ29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819231542.GJ29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 12:15:42AM +0100, Al Viro wrote:
> 
> That looks OK except for
> 	* jffs2 is b0rken (see patch in another mail)
> 	* afs, autofs4, befs, devfs, freevxfs, jffs2, jfs, ncpfs, procfs,
> smbfs, sysvfs, ufs, xfs - prototype change for ->follow_link()
> 	* befs, smbfs, xfs - same for ->put_link()
> 	* ncpfs fix is actually missing here
> 
> Prototype changes are covered by patch below (incremental on top of your +
> jffs2 fix upthread).  No ncpfs changes - these will go separately, assuming
> you haven't done them yet; just a plain janitor stuff.


Gaack...  And here's the patch itself - sorry.

diff -urN RC13-rc6-git10-base/fs/afs/mntpt.c current/fs/afs/mntpt.c
--- RC13-rc6-git10-base/fs/afs/mntpt.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/afs/mntpt.c	2005-08-19 19:02:48.000000000 -0400
@@ -30,7 +30,7 @@
 				       struct dentry *dentry,
 				       struct nameidata *nd);
 static int afs_mntpt_open(struct inode *inode, struct file *file);
-static int afs_mntpt_follow_link(struct dentry *dentry, struct nameidata *nd);
+static void *afs_mntpt_follow_link(struct dentry *dentry, struct nameidata *nd);
 
 struct file_operations afs_mntpt_file_operations = {
 	.open		= afs_mntpt_open,
@@ -233,7 +233,7 @@
 /*
  * follow a link from a mountpoint directory, thus causing it to be mounted
  */
-static int afs_mntpt_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *afs_mntpt_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct vfsmount *newmnt;
 	struct dentry *old_dentry;
@@ -249,7 +249,7 @@
 	newmnt = afs_mntpt_do_automount(dentry);
 	if (IS_ERR(newmnt)) {
 		path_release(nd);
-		return PTR_ERR(newmnt);
+		return (void *)newmnt;
 	}
 
 	old_dentry = nd->dentry;
@@ -267,7 +267,7 @@
 	}
 
 	kleave(" = %d", err);
-	return err;
+	return ERR_PTR(err);
 } /* end afs_mntpt_follow_link() */
 
 /*****************************************************************************/
diff -urN RC13-rc6-git10-base/fs/autofs4/symlink.c current/fs/autofs4/symlink.c
--- RC13-rc6-git10-base/fs/autofs4/symlink.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/autofs4/symlink.c	2005-08-19 19:03:11.000000000 -0400
@@ -12,11 +12,11 @@
 
 #include "autofs_i.h"
 
-static int autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	nd_set_link(nd, (char *)ino->u.symlink);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations autofs4_symlink_inode_operations = {
diff -urN RC13-rc6-git10-base/fs/befs/linuxvfs.c current/fs/befs/linuxvfs.c
--- RC13-rc6-git10-base/fs/befs/linuxvfs.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/befs/linuxvfs.c	2005-08-19 19:03:52.000000000 -0400
@@ -41,8 +41,8 @@
 static void befs_destroy_inode(struct inode *inode);
 static int befs_init_inodecache(void);
 static void befs_destroy_inodecache(void);
-static int befs_follow_link(struct dentry *, struct nameidata *);
-static void befs_put_link(struct dentry *, struct nameidata *);
+static void *befs_follow_link(struct dentry *, struct nameidata *);
+static void befs_put_link(struct dentry *, struct nameidata *, void *);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
@@ -487,10 +487,10 @@
 	}
 
 	nd_set_link(nd, link);
-	return 0;
+	return NULL;
 }
 
-static void befs_put_link(struct dentry *dentry, struct nameidata *nd)
+static void befs_put_link(struct dentry *dentry, struct nameidata *nd, void *p)
 {
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);
 	if (befs_ino->i_flags & BEFS_LONG_SYMLINK) {
diff -urN RC13-rc6-git10-base/fs/devfs/base.c current/fs/devfs/base.c
--- RC13-rc6-git10-base/fs/devfs/base.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/devfs/base.c	2005-08-19 19:04:17.000000000 -0400
@@ -2491,11 +2491,11 @@
 	return 0;
 }				/*  End Function devfs_mknod  */
 
-static int devfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *devfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct devfs_entry *p = get_devfs_entry_from_vfs_inode(dentry->d_inode);
 	nd_set_link(nd, p ? p->u.symlink.linkname : ERR_PTR(-ENODEV));
-	return 0;
+	return NULL;
 }				/*  End Function devfs_follow_link  */
 
 static struct inode_operations devfs_iops = {
diff -urN RC13-rc6-git10-base/fs/freevxfs/vxfs_immed.c current/fs/freevxfs/vxfs_immed.c
--- RC13-rc6-git10-base/fs/freevxfs/vxfs_immed.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/freevxfs/vxfs_immed.c	2005-08-19 19:04:41.000000000 -0400
@@ -38,7 +38,7 @@
 #include "vxfs_inode.h"
 
 
-static int	vxfs_immed_follow_link(struct dentry *, struct nameidata *);
+static void *	vxfs_immed_follow_link(struct dentry *, struct nameidata *);
 
 static int	vxfs_immed_readpage(struct file *, struct page *);
 
@@ -77,7 +77,7 @@
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);
 	nd_set_link(np, vip->vii_immed.vi_immed);
-	return 0;
+	return NULL;
 }
 
 /**
diff -urN RC13-rc6-git10-base/fs/jffs2/symlink.c current/fs/jffs2/symlink.c
--- RC13-rc6-git10-base/fs/jffs2/symlink.c	2005-08-19 19:01:07.000000000 -0400
+++ current/fs/jffs2/symlink.c	2005-08-19 19:05:10.000000000 -0400
@@ -18,7 +18,7 @@
 #include <linux/namei.h>
 #include "nodelist.h"
 
-static int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd);
+static void *jffs2_follow_link(struct dentry *dentry, struct nameidata *nd);
 
 struct inode_operations jffs2_symlink_inode_operations =
 {	
@@ -27,7 +27,7 @@
 	.setattr =	jffs2_setattr
 };
 
-static int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *jffs2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(dentry->d_inode);
 	char *p = (char *)f->dents;
@@ -60,6 +60,6 @@
 	 * since the only way that may cause f->dents to be changed is iput() operation.
 	 * But VFS will not use f->dents after iput() has been called.
 	 */
-	return 0;
+	return NULL;
 }
 
diff -urN RC13-rc6-git10-base/fs/jfs/symlink.c current/fs/jfs/symlink.c
--- RC13-rc6-git10-base/fs/jfs/symlink.c	2005-08-10 10:37:52.000000000 -0400
+++ current/fs/jfs/symlink.c	2005-08-19 19:05:27.000000000 -0400
@@ -22,11 +22,11 @@
 #include "jfs_inode.h"
 #include "jfs_xattr.h"
 
-static int jfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *jfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s = JFS_IP(dentry->d_inode)->i_inline;
 	nd_set_link(nd, s);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations jfs_symlink_inode_operations = {
diff -urN RC13-rc6-git10-base/fs/proc/base.c current/fs/proc/base.c
--- RC13-rc6-git10-base/fs/proc/base.c	2005-08-10 10:37:52.000000000 -0400
+++ current/fs/proc/base.c	2005-08-19 19:06:23.000000000 -0400
@@ -890,7 +890,7 @@
 };
 #endif /* CONFIG_SECCOMP */
 
-static int proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = -EACCES;
@@ -907,7 +907,7 @@
 	error = PROC_I(inode)->op.proc_get_link(inode, &nd->dentry, &nd->mnt);
 	nd->last_type = LAST_BIND;
 out:
-	return error;
+	return ERR_PTR(error);
 }
 
 static int do_proc_readlink(struct dentry *dentry, struct vfsmount *mnt,
@@ -1692,11 +1692,11 @@
 	return vfs_readlink(dentry,buffer,buflen,tmp);
 }
 
-static int proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char tmp[30];
 	sprintf(tmp, "%d", current->tgid);
-	return vfs_follow_link(nd,tmp);
+	return ERR_PTR(vfs_follow_link(nd,tmp));
 }	
 
 static struct inode_operations proc_self_inode_operations = {
diff -urN RC13-rc6-git10-base/fs/proc/generic.c current/fs/proc/generic.c
--- RC13-rc6-git10-base/fs/proc/generic.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/proc/generic.c	2005-08-19 19:06:37.000000000 -0400
@@ -329,10 +329,10 @@
 	spin_unlock(&proc_inum_lock);
 }
 
-static int proc_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *proc_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	nd_set_link(nd, PDE(dentry->d_inode)->data);
-	return 0;
+	return NULL;
 }
 
 static struct inode_operations proc_link_inode_operations = {
diff -urN RC13-rc6-git10-base/fs/smbfs/symlink.c current/fs/smbfs/symlink.c
--- RC13-rc6-git10-base/fs/smbfs/symlink.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/smbfs/symlink.c	2005-08-19 19:07:16.000000000 -0400
@@ -34,7 +34,7 @@
 	return smb_proc_symlink(server_from_dentry(dentry), dentry, oldname);
 }
 
-static int smb_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *smb_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *link = __getname();
 	DEBUG1("followlink of %s/%s\n", DENTRY_PATH(dentry));
@@ -52,10 +52,10 @@
 		}
 	}
 	nd_set_link(nd, link);
-	return 0;
+	return NULL;
 }
 
-static void smb_put_link(struct dentry *dentry, struct nameidata *nd)
+static void smb_put_link(struct dentry *dentry, struct nameidata *nd, void *p)
 {
 	char *s = nd_get_link(nd);
 	if (!IS_ERR(s))
diff -urN RC13-rc6-git10-base/fs/sysv/symlink.c current/fs/sysv/symlink.c
--- RC13-rc6-git10-base/fs/sysv/symlink.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/sysv/symlink.c	2005-08-19 19:08:21.000000000 -0400
@@ -8,10 +8,10 @@
 #include "sysv.h"
 #include <linux/namei.h>
 
-static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	nd_set_link(nd, (char *)SYSV_I(dentry->d_inode)->i_data);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations sysv_fast_symlink_inode_operations = {
diff -urN RC13-rc6-git10-base/fs/ufs/symlink.c current/fs/ufs/symlink.c
--- RC13-rc6-git10-base/fs/ufs/symlink.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/ufs/symlink.c	2005-08-19 19:08:40.000000000 -0400
@@ -29,11 +29,11 @@
 #include <linux/namei.h>
 #include <linux/ufs_fs.h>
 
-static int ufs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void *ufs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct ufs_inode_info *p = UFS_I(dentry->d_inode);
 	nd_set_link(nd, (char*)p->i_u1.i_symlink);
-	return 0;
+	return NULL;
 }
 
 struct inode_operations ufs_fast_symlink_inode_operations = {
diff -urN RC13-rc6-git10-base/fs/xfs/linux-2.6/xfs_iops.c current/fs/xfs/linux-2.6/xfs_iops.c
--- RC13-rc6-git10-base/fs/xfs/linux-2.6/xfs_iops.c	2005-06-17 15:48:29.000000000 -0400
+++ current/fs/xfs/linux-2.6/xfs_iops.c	2005-08-19 19:07:59.000000000 -0400
@@ -374,7 +374,7 @@
  * we need to be very careful about how much stack we use.
  * uio is kmalloced for this reason...
  */
-STATIC int
+STATIC void *
 linvfs_follow_link(
 	struct dentry		*dentry,
 	struct nameidata	*nd)
@@ -391,14 +391,14 @@
 	link = (char *)kmalloc(MAXNAMELEN+1, GFP_KERNEL);
 	if (!link) {
 		nd_set_link(nd, ERR_PTR(-ENOMEM));
-		return 0;
+		return NULL;
 	}
 
 	uio = (uio_t *)kmalloc(sizeof(uio_t), GFP_KERNEL);
 	if (!uio) {
 		kfree(link);
 		nd_set_link(nd, ERR_PTR(-ENOMEM));
-		return 0;
+		return NULL;
 	}
 
 	vp = LINVFS_GET_VP(dentry->d_inode);
@@ -422,10 +422,10 @@
 	kfree(uio);
 
 	nd_set_link(nd, link);
-	return 0;
+	return NULL;
 }
 
-static void linvfs_put_link(struct dentry *dentry, struct nameidata *nd)
+static void linvfs_put_link(struct dentry *dentry, struct nameidata *nd, void *p)
 {
 	char *s = nd_get_link(nd);
 	if (!IS_ERR(s))
