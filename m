Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBZSi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBZSi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVBZSi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:38:27 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:15767 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261255AbVBZSiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:38:23 -0500
Date: Sat, 26 Feb 2005 19:38:22 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 4/6] Bind Mount Extensions 0.06
Message-ID: <20050226183821.GA2514@mail.13thfloor.at>
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
> What is the value of adding "error"? The current code is more efficient,
> and just as readable.

okay, had a deeper look at this and now I remember
why I added 'error' in the first place (quite some
time ago ;)

basically we need to check for RO in lookup_create()
now to give the same (error) results than a 'normal'
ro mounted filesystem, it is required to do the
dentry lookup and check the dentry->d_inode to return
EEXIST before returning EROFS ...

something like this would be the result:

        if (dentry->d_inode) {
                dput(dentry);
                dentry = ERR_PTR(-EEXIST);
                goto fail;
        }
        if (MNT_IS_RDONLY(nd->mnt)) {
                dput(dentry);
                dentry = ERR_PTR(-EROFS);
                goto fail;
        }

I'm currently looking into moving that check upwards
so that it will happen _after_ the EEXIST one ...

best,
Herbert

> Cheers,
>   Trond
> 
> -- 
> Trond Myklebust <trond.myklebust@fys.uio.no>
