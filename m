Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUIYNo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUIYNo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUIYNo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:44:59 -0400
Received: from secure.isolservers.com ([66.98.204.49]:60368 "EHLO
	secure.isolservers.com") by vger.kernel.org with ESMTP
	id S269324AbUIYNoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 09:44:54 -0400
Subject: Re: strange behavior creating and deleting files
From: Mpourtounis Dimitris <db@wless.gr>
To: Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409241915420.3336-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0409241915420.3336-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1096119879.4080.3.camel@WLESS>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 25 Sep 2004 16:44:39 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 21:40, Hugh Dickins wrote:
> On Fri, 24 Sep 2004, Mpourtounis Dimitris wrote:
> > 
> > there seems to be a strange behaviour in the way my system creates and
> > deletes files, as long as memory allocation is concerned.
> > 
> > running a simple script that continuously creates and deletes files on
> > tmpfs filesystem, a got the following results:
> > 
> > files created		free memory on system 
> > -------------		---------------------
> > 0			48180
> > +6000			47936
> > +6000			47372
> > +6000			47372
> > +6000			47936
> > +6000			47936
> > +6000			47936
> > +6000			47936		(seems stable)
> > +9000			46976		(what on earth?)
> > +30000			45084
> > +80000			45084		(again stable)
> > +70000			39156		(not again...:( )
> > 
> > and sometime in the morning 25000 MB free RAM, and my system running too
> > slow
> > 
> > I am sure these are a lot a files and under normal conditions, there
> > will never be made and deleted so many.
> > 
> > It is that misbehavior of being stable for a long time and then again
> > allocating memory that concerns me.
> 
> I'll admit that I don't _fully_ understand it either.  Another user
> noticed related behaviour a couple of months ago, below is the patch
> which I hope you find fixes yours too.  An equivalent fix (to fs/libfs.c)
> went into 2.6.9-rc1-bk1, I'd been waiting for it to get more 2.6 exposure
> (lest unwanted side-effects appeared) before sending Marcelo the 2.4 fix.
> If it works well for you, let me know and I'll send it in for 2.4.28...
> 
I seems to work fine. Having created-deleted about 50000 files there is
no leak. Hope it continues that way.
Great job, thanks !

DB

> A tmpfs user reported increasingly slow directory reads when repeatedly
> creating and unlinking in a mkstemp-like way.  The negative dentries
> accumulate alarmingly (until memory pressure finally frees them), and
> are just a hindrance to any in-memory filesystem.  shmem_lookup set
> d_op to arrange for negative dentries to be deleted immediately.
> 
> (But I failed to discover how it is that on-disk filesystems seem to
> keep their negative dentries within manageable bounds: this effect was
> gross with tmpfs or ramfs, but no problem at all with extN or reiser.)
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> --- 2.4.26/mm/shmem.c	2003-11-28 18:26:21.000000000 +0000
> +++ linux/mm/shmem.c	2004-07-30 12:48:31.324978800 +0100
> @@ -1161,13 +1161,27 @@ static int shmem_statfs(struct super_blo
>  }
>  
>  /*
> + * Retaining negative dentries for an in-memory filesystem just wastes
> + * memory and lookup time: arrange for them to be deleted immediately.
> + */
> +static int shmem_delete_dentry(struct dentry *dentry)
> +{
> +	return 1;
> +}
> +
> +/*
>   * Lookup the data. This is trivial - if the dentry didn't already
> - * exist, we know it is negative.
> + * exist, we know it is negative.  Set d_op to delete negative dentries.
>   */
>  static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry)
>  {
> +	static struct dentry_operations shmem_dentry_operations = {
> +		.d_delete = shmem_delete_dentry,
> +	};
> +
>  	if (dentry->d_name.len > NAME_MAX)
>  		return ERR_PTR(-ENAMETOOLONG);
> +	dentry->d_op = &shmem_dentry_operations;
>  	d_add(dentry, NULL);
>  	return NULL;
>  }

