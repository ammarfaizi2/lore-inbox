Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWFSXEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWFSXEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWFSXEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:04:13 -0400
Received: from 1wt.eu ([62.212.114.60]:1545 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S964971AbWFSXEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:04:13 -0400
Date: Tue, 20 Jun 2006 01:00:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060619230007.GA6471@1wt.eu>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu> <20060619220405.GA16251@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619220405.GA16251@dmt>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:04:05PM -0300, Marcelo Tosatti wrote:

> Think this is the right thing to do, except that it must be guaranteed
> that the inode struct won't be freed in the meantime, need to grab a
> reference to it.

OK, I believe it will be right this time. I took inspiration from your
precedent patch to sys_unlink().

diff --git a/fs/namei.c b/fs/namei.c
index 42cce98..374b767 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1478,12 +1478,16 @@ exit:
 int vfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
+	struct inode *inode;
 
 	error = may_delete(dir, dentry, 0);
 	if (error)
 		return error;
 
-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	inode = dentry->d_inode;
+	atomic_inc(&inode->i_count);
+	double_down(&dir->i_zombie, &inode->i_zombie);
+
 	error = -EPERM;
 	if (dir->i_op && dir->i_op->unlink) {
 		DQUOT_INIT(dir);
@@ -1495,7 +1499,9 @@ int vfs_unlink(struct inode *dir, struct
 			unlock_kernel();
 		}
 	}
-	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	double_up(&dir->i_zombie, &inode->i_zombie);
+	iput(inode);
+
 	if (!error) {
 		d_delete(dentry);
 		inode_dir_notify(dir, DN_DELETE);

BTW, I might be wrong because my knowledge in this area is rather poor, but
I now believe that your previously proposed fix below indeed is not needed
at all :

> diff --git a/fs/namei.c b/fs/namei.c
> index 42cce98..69da199 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1509,6 +1511,7 @@ asmlinkage long sys_unlink(const char * 
>  	char * name;
>  	struct dentry *dentry;
>  	struct nameidata nd;
> +	struct inode *inode = NULL;
>  
>  	name = getname(pathname);
>  	if(IS_ERR(name))
> @@ -1527,11 +1530,16 @@ asmlinkage long sys_unlink(const char * 
>  		/* Why not before? Because we want correct error value */
>  		if (nd.last.name[nd.last.len])
>  			goto slashes;

---- from here ----


> +		inode = dentry->d_inode;
> +		if (inode)
> +			atomic_inc(&inode->i_count);
>  		error = vfs_unlink(nd.dentry->d_inode, dentry);
>  	exit2:
>  		dput(dentry);
>  	}
>  	up(&nd.dentry->d_inode->i_sem);
> +	if (inode)
> +		iput(inode);

---- to here ----

I believe that nd.dentry->d_inode cannot vanish because it is protected by the
down(->i_sem) before and the up(->i_sem) after. Am I right or am I missing
something important ?

>  exit1:
>  	path_release(&nd);
>  exit:

Thanks,
Willy

