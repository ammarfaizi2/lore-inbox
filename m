Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWFTVvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWFTVvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWFTVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:51:05 -0400
Received: from hera.kernel.org ([140.211.167.34]:28894 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750798AbWFTVvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:51:04 -0400
Date: Mon, 19 Jun 2006 20:45:06 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060619234506.GA2763@dmt>
References: <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu> <20060619220405.GA16251@dmt> <20060619230007.GA6471@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619230007.GA6471@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:00:07AM +0200, Willy Tarreau wrote:
> On Mon, Jun 19, 2006 at 07:04:05PM -0300, Marcelo Tosatti wrote:
> 
> > Think this is the right thing to do, except that it must be guaranteed
> > that the inode struct won't be freed in the meantime, need to grab a
> > reference to it.
> 
> OK, I believe it will be right this time. I took inspiration from your
> precedent patch to sys_unlink().
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 42cce98..374b767 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1478,12 +1478,16 @@ exit:
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
> +	atomic_inc(&inode->i_count);
> +	double_down(&dir->i_zombie, &inode->i_zombie);
> +
>  	error = -EPERM;
>  	if (dir->i_op && dir->i_op->unlink) {
>  		DQUOT_INIT(dir);
> @@ -1495,7 +1499,9 @@ int vfs_unlink(struct inode *dir, struct
>  			unlock_kernel();
>  		}
>  	}
> -	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
> +	double_up(&dir->i_zombie, &inode->i_zombie);
> +	iput(inode);
> +
>  	if (!error) {
>  		d_delete(dentry);
>  		inode_dir_notify(dir, DN_DELETE);

Yeah thats better.

> BTW, I might be wrong because my knowledge in this area is rather poor, but
> I now believe that your previously proposed fix below indeed is not needed
> at all :


> 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 42cce98..69da199 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1509,6 +1511,7 @@ asmlinkage long sys_unlink(const char * 
> >  	char * name;
> >  	struct dentry *dentry;
> >  	struct nameidata nd;
> > +	struct inode *inode = NULL;
> >  
> >  	name = getname(pathname);
> >  	if(IS_ERR(name))
> > @@ -1527,11 +1530,16 @@ asmlinkage long sys_unlink(const char * 
> >  		/* Why not before? Because we want correct error value */
> >  		if (nd.last.name[nd.last.len])
> >  			goto slashes;
> 
> ---- from here ----
> 
> 
> > +		inode = dentry->d_inode;
> > +		if (inode)
> > +			atomic_inc(&inode->i_count);
> >  		error = vfs_unlink(nd.dentry->d_inode, dentry);
> >  	exit2:
> >  		dput(dentry);
> >  	}
> >  	up(&nd.dentry->d_inode->i_sem);
> > +	if (inode)
> > +		iput(inode);
> 
> ---- to here ----
> 
> I believe that nd.dentry->d_inode cannot vanish because it is protected by the
> down(->i_sem) before and the up(->i_sem) after. Am I right or am I missing
> something important ?

Indeed it can't, but dentry->d_inode will be set to NULL by
nfs_unlink->nfs_safe_remove->d_delete. Thus the problem.

