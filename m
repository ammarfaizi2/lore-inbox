Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVBWWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVBWWvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVBWWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:49:59 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:4569 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261656AbVBWWsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:48:02 -0500
Date: Wed, 23 Feb 2005 23:48:01 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/6] Bind Mount Extensions 0.06
Message-ID: <20050223224801.GB10778@mail.13thfloor.at>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121233.GE3682@mail.13thfloor.at> <1109083537.9839.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109083537.9839.18.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 09:45:37AM -0500, Trond Myklebust wrote:
> ty den 22.02.2005 Klokka 13:12 (+0100) skreiv Herbert Poetzl:
> 
> > diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/namei.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/namei.c
> > --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/namei.c	2005-02-13 17:16:55 +0100
> > +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/namei.c	2005-02-19 06:31:50 +0100
> > @@ -1168,6 +1168,24 @@ static inline int may_create(struct inod
> >  	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
> >  }
> >  
> > +static inline int mnt_may_create(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
> > +       if (child->d_inode)
> > +               return -EEXIST;
> > +       if (IS_DEADDIR(dir))
> > +               return -ENOENT;
> > +       if (MNT_IS_RDONLY(mnt))
> > +               return -EROFS;
> > +       return 0;
> > +}
> > +
> > +static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
> > +       if (!child->d_inode)
> > +               return -ENOENT;
> > +       if (MNT_IS_RDONLY(mnt))
> > +               return -EROFS;
> > +       return 0;
> > +}
> 
> Most of these checks are redundant, since they are already being done
> elsewhere in the code.
> child->d_inode is, for instance checked in may_delete() and in
> may_create.

well, but mnt_may_create() for example is called from 
lookup_create() which in turn is (for example) called
from sys_mknod() which doesn't call may_delete() or
may_create() ... did I miss something?

> IS_DEADDIR is also checked in may_create.

ditto ...

> >  /* 
> >   * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
> >   * reasons.
> > @@ -1518,23 +1536,28 @@ do_link:
> >  struct dentry *lookup_create(struct nameidata *nd, int is_dir)
> >  {
> >  	struct dentry *dentry;
> > +	int error;
> >  
> >  	down(&nd->dentry->d_inode->i_sem);
> > -	dentry = ERR_PTR(-EEXIST);
> > +	error = -EEXIST;
> >  	if (nd->last_type != LAST_NORM)
> > -		goto fail;
> > +		goto out;
> >  	nd->flags &= ~LOOKUP_PARENT;
> >  	dentry = lookup_hash(&nd->last, nd->dentry);
> >  	if (IS_ERR(dentry))
> > +		goto ret;
> > +	error = mnt_may_create(nd->mnt, nd->dentry->d_inode, dentry);
> > +	if (error)
> >  		goto fail;
> > +	error = -ENOENT;
> >  	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
> > -		goto enoent;
> > +		goto fail;
> > +ret:
> >  	return dentry;
> > -enoent:
> > -	dput(dentry);
> > -	dentry = ERR_PTR(-ENOENT);
> >  fail:
> > -	return dentry;
> > +	dput(dentry);
> > +out:
> > +	return ERR_PTR(error);
> >  }
> 
> What is the value of adding "error"? 
> The current code is more efficient, and just as readable.

hmm, a compile test resulted in almost
identical code, but maybe I did miss some
aspect of the efficiency ...

anyway, thanks for the feedback,
Herbert

> Cheers,
>   Trond
> 
> -- 
> Trond Myklebust <trond.myklebust@fys.uio.no>
