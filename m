Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWGJQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWGJQXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWGJQXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:23:52 -0400
Received: from ihug-mail.icp-qv1-irony6.iinet.net.au ([203.59.1.224]:39448
	"EHLO mail-ihug.icp-qv1-irony6.iinet.net.au") by vger.kernel.org
	with ESMTP id S1422677AbWGJQXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:23:50 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,225,1149436800"; 
   d="scan'208"; a="371355394:sNHT18625944"
Subject: Re: [autofs] Re: [PATCH] autofs4 needs to force fail return
	revalidate
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, autofs@linux.kernel.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060710032429.15192c9c.akpm@osdl.org>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
	 <20060620233941.49ba2223.akpm@osdl.org>
	 <Pine.LNX.4.64.0606231159540.2904@raven.themaw.net>
	 <20060710032429.15192c9c.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 00:23:47 +0800
Message-Id: <1152548627.1853.19.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 03:24 -0700, Andrew Morton wrote:
> btw, this patch is presently in a not-going-anywhere state because Al
> expressed some reservations.  But then it all went quiet?

Ya. Thought that might be the case.
This is in a sensitive place in the VFS.

Al, please your swift and sure guidance would be appreciated.

> 
> 
> From: Ian Kent <raven@themaw.net>
> 
> For a long time now I have had a problem with not being able to return a
> lookup failure on an existsing directory.  In autofs this corresponds to a
> mount failure on a autofs managed mount entry that is browsable (and so the
> mount point directory exists).
> 
> While this problem has been present for a long time I've avoided resolving
> it because it was not very visible.  But now that autofs v5 has "mount and
> expire on demand" of nested multiple mounts, such as is found when mounting
> an export list from a server, solving the problem cannot be avoided any
> longer.
> 
> I've tried very hard to find a way to do this entirely within the autofs4
> module but have not been able to find a satisfactory way to achieve it.
> 
> So, I need to propose a change to the VFS.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  fs/autofs4/root.c |   38 ++++++++++++++++++++++++++-------
>  fs/namei.c        |   50 ++++++++++++++++++++++++++++++--------------
>  linux/dcache.h    |    0 
>  3 files changed, 65 insertions(+), 23 deletions(-)
> 
> diff -puN fs/autofs4/root.c~autofs4-needs-to-force-fail-return-revalidate fs/autofs4/root.c
> --- a/fs/autofs4/root.c~autofs4-needs-to-force-fail-return-revalidate
> +++ a/fs/autofs4/root.c
> @@ -137,7 +137,9 @@ static int autofs4_dir_open(struct inode
>  		nd.flags = LOOKUP_DIRECTORY;
>  		ret = (dentry->d_op->d_revalidate)(dentry, &nd);
>  
> -		if (!ret) {
> +		if (ret <= 0) {
> +			if (ret < 0)
> +				status = ret;
>  			dcache_dir_close(inode, file);
>  			goto out;
>  		}
> @@ -400,13 +402,23 @@ static int autofs4_revalidate(struct den
>  	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
>  	int oz_mode = autofs4_oz_mode(sbi);
>  	int flags = nd ? nd->flags : 0;
> -	int status = 0;
> +	int status = 1;
>  
>  	/* Pending dentry */
>  	if (autofs4_ispending(dentry)) {
> -		if (!oz_mode)
> -			status = try_to_fill_dentry(dentry, flags);
> -		return !status;
> +		/* The daemon never causes a mount to trigger */
> +		if (oz_mode)
> +			return 1;
> +
> +		/*
> +		 * A zero status is success otherwise we have a
> +		 * negative error code.
> +		 */
> +		status = try_to_fill_dentry(dentry, flags);
> +		if (status == 0)
> +				return 1;
> +
> +		return status;
>  	}
>  
>  	/* Negative dentry.. invalidate if "old" */
> @@ -421,9 +433,19 @@ static int autofs4_revalidate(struct den
>  		DPRINTK("dentry=%p %.*s, emptydir",
>  			 dentry, dentry->d_name.len, dentry->d_name.name);
>  		spin_unlock(&dcache_lock);
> -		if (!oz_mode)
> -			status = try_to_fill_dentry(dentry, flags);
> -		return !status;
> +		/* The daemon never causes a mount to trigger */
> +		if (oz_mode)
> +			return 1;
> +
> +		/*
> +		 * A zero status is success otherwise we have a
> +		 * negative error code.
> +		 */
> +		status = try_to_fill_dentry(dentry, flags);
> +		if (status == 0)
> +			return 1;
> +
> +		return status;
>  	}
>  	spin_unlock(&dcache_lock);
>  
> diff -puN fs/namei.c~autofs4-needs-to-force-fail-return-revalidate fs/namei.c
> --- a/fs/namei.c~autofs4-needs-to-force-fail-return-revalidate
> +++ a/fs/namei.c
> @@ -365,6 +365,30 @@ void release_open_intent(struct nameidat
>  		fput(nd->intent.open.file);
>  }
>  
> +static inline struct dentry *
> +do_revalidate(struct dentry *dentry, struct nameidata *nd)
> +{
> +	int status = dentry->d_op->d_revalidate(dentry, nd);
> +	if (unlikely(status <= 0)) {
> +		/*
> +		 * The dentry failed validation.
> +		 * If d_revalidate returned 0 attempt to invalidate
> +		 * the dentry otherwise d_revalidate is asking us
> +		 * to return a fail status.
> +		 */
> +		if (!status) {
> +			if (!d_invalidate(dentry)) {
> +				dput(dentry);
> +				dentry = NULL;
> +			}
> +		} else {
> +			dput(dentry);
> +			dentry = ERR_PTR(status);
> +		}
> +	}
> +	return dentry;
> +}
> +
>  /*
>   * Internal lookup() using the new generic dcache.
>   * SMP-safe
> @@ -379,12 +403,9 @@ static struct dentry * cached_lookup(str
>  	if (!dentry)
>  		dentry = d_lookup(parent, name);
>  
> -	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
> -		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
> -			dput(dentry);
> -			dentry = NULL;
> -		}
> -	}
> +	if (dentry && dentry->d_op && dentry->d_op->d_revalidate)
> +		dentry = do_revalidate(dentry, nd);
> +
>  	return dentry;
>  }
>  
> @@ -477,10 +498,9 @@ static struct dentry * real_lookup(struc
>  	 */
>  	mutex_unlock(&dir->i_mutex);
>  	if (result->d_op && result->d_op->d_revalidate) {
> -		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
> -			dput(result);
> +		result = do_revalidate(result, nd);
> +		if (!result)
>  			result = ERR_PTR(-ENOENT);
> -		}
>  	}
>  	return result;
>  }
> @@ -760,12 +780,12 @@ need_lookup:
>  	goto done;
>  
>  need_revalidate:
> -	if (dentry->d_op->d_revalidate(dentry, nd))
> -		goto done;
> -	if (d_invalidate(dentry))
> -		goto done;
> -	dput(dentry);
> -	goto need_lookup;
> +	dentry = do_revalidate(dentry, nd);
> +	if (!dentry)
> +		goto need_lookup;
> +	if (IS_ERR(dentry))
> +		goto fail;
> +	goto done;
>  
>  fail:
>  	return PTR_ERR(dentry);
> diff -puN include/linux/dcache.h~autofs4-needs-to-force-fail-return-revalidate include/linux/dcache.h
> _
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
