Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVIUDy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVIUDy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVIUDy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:54:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51882 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750991AbVIUDy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:54:59 -0400
Date: Wed, 21 Sep 2005 04:54:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>,
       Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] HPPFS: fix nameidata handling
Message-ID: <20050921035455.GY7992@ftp.linux.org.uk>
References: <20050918141009.31461.43507.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918141009.31461.43507.stgit@zion.home.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 04:10:09PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> In follow_link, we call the underlying method with the same nameidata we got -
> it will then call path_release() and then dput()/mntput() on hppfs dentries /
> vfsmount rather than his own, which could be problematic (I'm not really sure,
> however).
> 
> This issue exists potentially also for other methods getting nameidata. Fix
> this.
> 
> However, I couldn't make a lot of sense of the reference counting used in
> namei.c. So I'm uncertain whether this patch makes sense. Al, please have a
> critical eye toward this one. Especially, proc_pid_follow_link calls
> path_release itself. Which makes me wonder a lot.
 
> +	sav_mnt = nd->mnt;
> +
> +	nd->dentry = dget(proc_dentry);
> +	nd->mnt = mntget(proc_submnt);
> +	ret = (*d_revalidate)(proc_dentry, nd);
> +	path_release(nd);

Don't bother with that, procfs doesn't and will not care anyway.  It _is_
legal to pass NULL as nd, so you've actually introduced breakage here.
Just pass NULL and be done with that.

> +		sav_dentry = nd->dentry;
> +		sav_mnt = nd->mnt;
> +
> +		nd->dentry = dget(proc_dentry);
> +		nd->mnt = mntget(proc_submnt);
>  		new = (*parent->d_inode->i_op->lookup)(parent->d_inode,
> -						       proc_dentry, NULL);
> +						       proc_dentry, nd);
> +		path_release(nd);
> +
> +		nd->dentry = sav_dentry;
> +		nd->mnt = sav_mnt;
>  		if(new){
>  			dput(proc_dentry);
>  			proc_dentry = new;

Ditto.

> @@ -213,11 +240,20 @@ static struct dentry *hppfs_lookup(struc
>  	} else {
>  		up(&parent->d_inode->i_sem);
>  		if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate) {
> -			if (!proc_dentry->d_op->d_revalidate(proc_dentry, NULL) &&
> +			sav_dentry = nd->dentry;
> +			sav_mnt = nd->mnt;
> +
> +			nd->dentry = dget(proc_dentry);
> +			nd->mnt = mntget(proc_submnt);
> +			if (!proc_dentry->d_op->d_revalidate(proc_dentry, nd) &&
>  					!d_invalidate(proc_dentry)) {
>  				dput(proc_dentry);
>  				proc_dentry = ERR_PTR(-ENOENT);
>  			}
> +			path_release(nd);
> +
> +			nd->dentry = sav_dentry;
> +			nd->mnt = sav_mnt;
>  		}
>  	}

Shouldn't be there at all (use lookup_one_len() instead of open-coding it)

> @@ -248,16 +284,32 @@ static struct dentry *hppfs_lookup(struc
>  
>  static int hppfs_permission(struct inode *inode, int mask, struct nameidata *nd)
>  {
> +	struct dentry *sav_dentry;
> +	struct vfsmount *sav_mnt;
> +
>  	struct inode *proc_inode;
> +	struct dentry *proc_dentry;
>  	int (*permission) (struct inode *, int, struct nameidata *);
> +	int ret;
>  
> -	proc_inode = HPPFS_I(inode)->proc_dentry->d_inode;
> +	proc_dentry = HPPFS_I(inode)->proc_dentry;
> +	proc_inode = proc_dentry->d_inode;
>  	permission = proc_inode->i_op->permission;
>  
>  	if (permission == NULL)
>  		return generic_permission(inode, mask, NULL);
>  
> -	return (*permission)(proc_inode, mask, nd);
> +	sav_dentry = nd->dentry;
> +	sav_mnt = nd->mnt;
> +
> +	nd->dentry = dget(proc_dentry);
> +	nd->mnt = mntget(proc_submnt);
> +	ret = (*permission)(proc_inode, mask, nd);
> +	path_release(nd);
> +
> +	nd->dentry = sav_dentry;
> +	nd->mnt = sav_mnt;
> +	return ret;
>  }

Same note about NULL.

>  static struct inode_operations hppfs_file_iops = {
> @@ -794,6 +846,9 @@ static int hppfs_readlink(struct dentry 
>  
>  static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
>  {
> +	struct dentry *sav_dentry;
> +	struct vfsmount *sav_mnt;
> +
>  	struct dentry *proc_dentry;
>  	void * (*follow_link)(struct dentry *, struct nameidata *);
>  	void *ret;
> @@ -808,7 +863,18 @@ static void* hppfs_follow_link(struct de
>  	if (follow_link == NULL)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> +	/* We have a reference on this already - so it won't go.*/
> +	sav_dentry = nd->dentry;
> +	sav_mnt = nd->mnt;
> +
> +	nd->dentry = dget(proc_dentry);
> +	nd->mnt = mntget(proc_submnt);
>  	ret = follow_link(proc_dentry, nd);
> +	/* XXX: would this be done normally when calling follow_link or not? */
> +	path_release(nd);
> +
> +	nd->dentry = sav_dentry;
> +	nd->mnt = sav_mnt;


And this is absolutely bogus.  The whole point of ->follow_link() is to
move where your nameidata points to.  So no, you do _not_ want to flip
nameidata, you do not want to drop it and you certainly do not want
to flip it back.  Just call the underlying one.
