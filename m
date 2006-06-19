Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWFSWHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWFSWHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWFSWHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:07:43 -0400
Received: from hera.kernel.org ([140.211.167.34]:41443 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964945AbWFSWHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:07:42 -0400
Date: Mon, 19 Jun 2006 19:04:05 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060619220405.GA16251@dmt>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619080651.GA3273@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Willy,

On Mon, Jun 19, 2006 at 10:06:51AM +0200, Willy Tarreau wrote:
> Hi Grant,
> 
> OK, it does *really* crash in vfs_unlink(), during the double_up on
> dentry->inode-i_zombie (dentry->inode = NULL).
> 
> I suggest the following fix, I hope that it is correct and is not subject
> to any race condition :
> 
> --- ./fs/namei.c.orig	2006-06-19 09:39:52.000000000 +0200
> +++ ./fs/namei.c	2006-06-19 09:51:09.000000000 +0200
> @@ -1478,12 +1478,14 @@
>  int vfs_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	int error;
> +	struct inode *inode;
>  
>  	error = may_delete(dir, dentry, 0);
>  	if (error)
>  		return error;
>  
> -	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
> +	inode = dentry->d_inode;
> +	double_down(&dir->i_zombie, &inode->i_zombie);
>  	error = -EPERM;
>  	if (dir->i_op && dir->i_op->unlink) {
>  		DQUOT_INIT(dir);
> @@ -1495,7 +1497,7 @@
>  			unlock_kernel();
>  		}
>  	}
> -	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
> +	double_up(&dir->i_zombie, &inode->i_zombie);
>  	if (!error) {
>  		d_delete(dentry);
>  		inode_dir_notify(dir, DN_DELETE);
> 
> I think it will *not* oops anymore with this fix, but I'd like someone to
> review it to ensure that it is valid.

Think this is the right thing to do, except that it must be guaranteed
that the inode struct won't be freed in the meantime, need to grab a
reference to it.

Thanks!

-- 

v2.4.33-pre introduced a fix for lack of synchronization between
link/unlink which requires vfs_unlink to grab i_zombie of both the
victim and its parent with double_down().

Problem is that NFS client deletes the victim dentry on ->unlink,
resulting in a NULL dereference when vfs_unlink() tries to up
dentry->d_inode->i_zombie.

Keep a copy of the inode pointer, incrementing its reference counter, to
fix the situation.

diff --git a/fs/namei.c b/fs/namei.c
index 42cce98..69da199 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1478,12 +1478,14 @@ exit:
 int vfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
+	struct inode *inode;
 
 	error = may_delete(dir, dentry, 0);
 	if (error)
 		return error;
 
-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	inode = dentry->d_inode;
+	double_down(&dir->i_zombie, &inode->i_zombie);
 	error = -EPERM;
 	if (dir->i_op && dir->i_op->unlink) {
 		DQUOT_INIT(dir);
@@ -1495,7 +1497,7 @@ int vfs_unlink(struct inode *dir, struct
 			unlock_kernel();
 		}
 	}
-	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	double_up(&dir->i_zombie, &inode->i_zombie);
 	if (!error) {
 		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);
@@ -1509,6 +1511,7 @@ asmlinkage long sys_unlink(const char * 
 	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
+	struct inode *inode = NULL;
 
 	name = getname(pathname);
 	if(IS_ERR(name))
@@ -1527,11 +1530,16 @@ asmlinkage long sys_unlink(const char * 
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		inode = dentry->d_inode;
+		if (inode)
+			atomic_inc(&inode->i_count);
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
 	exit2:
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
+	if (inode)
+		iput(inode);
 exit1:
 	path_release(&nd);
 exit:
