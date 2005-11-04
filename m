Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbVKDM5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbVKDM5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVKDM5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:57:12 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:41098 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932735AbVKDM5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:57:10 -0500
Date: Fri, 4 Nov 2005 13:57:05 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andreas Herrmann <aherrman@de.ibm.com>
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104125705.GB12476@osiris.boeblingen.de.ibm.com>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com> <20051104114818.GG7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104114818.GG7992@ftp.linux.org.uk>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a resubmit of Andreas' patch that reduces stackframe usage in
> > do_mount. Problem is that without this patch we get a kernel stack
> > overflow if we run with 4k stacks (s390 31 bit mode).
> > See original stack back trace below and Andreas' patch and analysis
> > here:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html
> 
> NAK.  Rationale: too ugly.

Ok, since I can only guess what you don't like: here is an updated patch
that probably addresses a few things.
If you don't like this one too, could you please explain what should be
changed?

Thanks,
Heiko
---

 fs/namespace.c |   79 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2fa9fdf..c14fbfc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -619,25 +619,30 @@ out_unlock:
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
-	struct nameidata old_nd;
+	struct nameidata *old_nd;
 	struct vfsmount *mnt = NULL;
 	int err = mount_is_safe(nd);
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
+
+	old_nd = kmalloc(sizeof(*old_nd), GFP_KERNEL);
+	if (!old_nd)
+		return -ENOMEM;
+
+	err = path_lookup(old_name, LOOKUP_FOLLOW, old_nd);
 	if (err)
-		return err;
+		goto out;
 
 	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
+	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd->mnt))) {
 		err = -ENOMEM;
 		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+			mnt = copy_tree(old_nd->mnt, old_nd->dentry);
 		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+			mnt = clone_mnt(old_nd->mnt, old_nd->dentry);
 	}
 
 	if (mnt) {
@@ -656,7 +661,9 @@ static int do_loopback(struct nameidata 
 	}
 
 	up_write(&current->namespace->sem);
-	path_release(&old_nd);
+	path_release(old_nd);
+out:
+	kfree(old_nd);
 	return err;
 }
 
@@ -693,22 +700,28 @@ static int do_remount(struct nameidata *
 
 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
-	struct nameidata old_nd, parent_nd;
+	struct {
+		struct nameidata old_nd, parent_nd;
+	} *loc;
 	struct vfsmount *p;
 	int err = 0;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
+	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+	if (!loc)
+		return -ENOMEM;
+
+	err = path_lookup(old_name, LOOKUP_FOLLOW, &loc->old_nd);
 	if (err)
-		return err;
+		goto path_out;
 
 	down_write(&current->namespace->sem);
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
 		;
 	err = -EINVAL;
-	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
+	if (!check_mnt(nd->mnt) || !check_mnt(loc->old_nd.mnt))
 		goto out;
 
 	err = -ENOENT;
@@ -721,28 +734,28 @@ static int do_move_mount(struct nameidat
 		goto out2;
 
 	err = -EINVAL;
-	if (old_nd.dentry != old_nd.mnt->mnt_root)
+	if (loc->old_nd.dentry != loc->old_nd.mnt->mnt_root)
 		goto out2;
 
-	if (old_nd.mnt == old_nd.mnt->mnt_parent)
+	if (loc->old_nd.mnt == loc->old_nd.mnt->mnt_parent)
 		goto out2;
 
 	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
+	      S_ISDIR(loc->old_nd.dentry->d_inode->i_mode))
 		goto out2;
 
 	err = -ELOOP;
 	for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
-		if (p == old_nd.mnt)
+		if (p == loc->old_nd.mnt)
 			goto out2;
 	err = 0;
 
-	detach_mnt(old_nd.mnt, &parent_nd);
-	attach_mnt(old_nd.mnt, nd);
+	detach_mnt(loc->old_nd.mnt, &loc->parent_nd);
+	attach_mnt(loc->old_nd.mnt, nd);
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
-	list_del_init(&old_nd.mnt->mnt_expire);
+	list_del_init(&loc->old_nd.mnt->mnt_expire);
 out2:
 	spin_unlock(&vfsmount_lock);
 out1:
@@ -750,8 +763,10 @@ out1:
 out:
 	up_write(&current->namespace->sem);
 	if (!err)
-		path_release(&parent_nd);
-	path_release(&old_nd);
+		path_release(&loc->parent_nd);
+	path_release(&loc->old_nd);
+path_out:
+	kfree(loc);
 	return err;
 }
 
@@ -1014,7 +1029,7 @@ int copy_mount_options(const void __user
 long do_mount(char * dev_name, char * dir_name, char *type_page,
 		  unsigned long flags, void *data_page)
 {
-	struct nameidata nd;
+	struct nameidata *nd;
 	int retval = 0;
 	int mnt_flags = 0;
 
@@ -1041,27 +1056,33 @@ long do_mount(char * dev_name, char * di
 		mnt_flags |= MNT_NOEXEC;
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
 
+	nd = kmalloc(sizeof(*nd), GFP_KERNEL);
+	if (!nd)
+		return -ENOMEM;
+
 	/* ... and get the mountpoint */
-	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW, nd);
 	if (retval)
-		return retval;
+		goto path_out;
 
-	retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page);
+	retval = security_sb_mount(dev_name, nd, type_page, flags, data_page);
 	if (retval)
 		goto dput_out;
 
 	if (flags & MS_REMOUNT)
-		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
+		retval = do_remount(nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(nd, dev_name, flags & MS_REC);
 	else if (flags & MS_MOVE)
-		retval = do_move_mount(&nd, dev_name);
+		retval = do_move_mount(nd, dev_name);
 	else
-		retval = do_new_mount(&nd, type_page, flags, mnt_flags,
+		retval = do_new_mount(nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
 dput_out:
-	path_release(&nd);
+	path_release(nd);
+path_out:
+	kfree(nd);
 	return retval;
 }
 
