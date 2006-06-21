Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWFUNMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWFUNMs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWFUNMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:12:48 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:64773 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751575AbWFUNMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:12:47 -0400
Date: Wed, 21 Jun 2006 21:07:12 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
In-Reply-To: <20060620233941.49ba2223.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606212052380.14481@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060620233941.49ba2223.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Andrew Morton wrote:

> On Wed, 21 Jun 2006 14:18:15 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
> > 
> > Hi Andrew,
> > 
> > I didn't get any adverse (or other feedback) for this patch after posting
> > an RFC to LKML so here it is.
> > 
> > For a long time now I have had a problem with not being able to return a 
> > lookup failure on an existsing directory. In autofs this corresponds to a 
> > mount failure on a autofs managed mount entry that is browsable (and so 
> > the mount point directory exists).
> > 
> > While this problem has been present for a long time I've avoided resolving 
> > it because it was not very visible. But now that autofs v5 has "mount and 
> > expire on demand" of nested multiple mounts, such as is found when 
> > mounting an export list from a server, solving the problem cannot be 
> > avoided any longer.
> > 
> > I've tried very hard to find a way to do this entirely within the 
> > autofs4 module but have not been able to find a satisfactory way to 
> > achieve it.
> > 
> > So, I need to propose a change to the VFS.
> > 
> > --- linux-2.6.17/fs/namei.c.dcache-revalidate-return-fail	2006-06-19 13:26:27.000000000 +0800
> > +++ linux-2.6.17/fs/namei.c	2006-06-19 13:31:31.000000000 +0800
> > @@ -380,9 +380,24 @@ static struct dentry * cached_lookup(str
> >  		dentry = d_lookup(parent, name);
> >  
> >  	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
> > -		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
> > -			dput(dentry);
> > -			dentry = NULL;
> > +		if (!dentry->d_op->d_revalidate(dentry, nd)) {
> > +			if (!d_invalidate(dentry)) {
> > +				dput(dentry);
> > +				return NULL;
> > +			}
> > +			/*
> > +			 * As well as the normal validation, check if we need
> > +			 * to force a fail on a valid dentry (autofs4 browsable
> > +			 * mounts).
> > +			 */
> > +			spin_lock(&dentry->d_lock);
> > +			if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
> > +				dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
> > +				spin_unlock(&dentry->d_lock);
> > +				dput(dentry);
> > +				return ERR_PTR(-ENOENT);
> > +			}
> > +			spin_unlock(&dentry->d_lock);
> >  		}
> >  	}
> >  	return dentry;
> > @@ -477,9 +492,24 @@ static struct dentry * real_lookup(struc
> >  	 */
> >  	mutex_unlock(&dir->i_mutex);
> >  	if (result->d_op && result->d_op->d_revalidate) {
> > -		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
> > -			dput(result);
> > -			result = ERR_PTR(-ENOENT);
> > +		if (!result->d_op->d_revalidate(result, nd)) {
> > +			if (!d_invalidate(result)) {
> > +				dput(result);
> > +				return ERR_PTR(-ENOENT);
> > +			}
> > +			/*
> > +		 	* d_revalidate failed but the dentry is still valid so
> > +			* check if we need to force a fail on the dentry (autofs4
> > +			* browsable mounts).
> > +		 	*/
> > +			spin_lock(&result->d_lock);
> > +		    	if (result->d_flags & DCACHE_REVAL_FORCE_FAIL) {
> > +				result->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
> > +				spin_unlock(&result->d_lock);
> > +				dput(result);
> > +				return ERR_PTR(-ENOENT);
> > +			}
> > +			spin_unlock(&result->d_lock);
> >  		}
> >  	}
> >  	return result;
> > @@ -762,8 +792,21 @@ need_lookup:
> >  need_revalidate:
> >  	if (dentry->d_op->d_revalidate(dentry, nd))
> >  		goto done;
> > -	if (d_invalidate(dentry))
> > +	if (d_invalidate(dentry)) {
> > +		/*
> > +		 * d_revalidate failed but the dentry is still valid so check
> > +		 * if we need to return a fail (autofs4 browsable mounts).
> > +		 */
> > +		spin_lock(&dentry->d_lock);
> > +		if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
> > +			dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
> > +			spin_unlock(&dentry->d_lock);
> > +			dput(dentry);
> > +			return -ENOENT;
> > +		}
> > +		spin_unlock(&dentry->d_lock);
> >  		goto done;
> > +	}
> 
> All these are basically the same.  Could you look at creating a common
> function, please?

Yep, I'll do that.
Jeff suggested that when he saw it.

> 
> Also, I don't know how frequently that code path is executed (presumably
> infrequently) but would the semantics permit us to do:
> 
> 	if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
> 		spin_lock(&dentry->d_lock);
> 		if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
> 			dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
> 			spin_unlock(&dentry->d_lock);
> 			dput(dentry);
> 			return -ENOENT;
> 		}
> 		spin_unlock(&dentry->d_lock);
> 	}
> 
> to avoid taking the lock sometimes?

Should be infrequently.
I always balk at leaving things outside a lock but we test again so that 
should be fine. Will do.

> 
> And we should have an unlikely() in there to tell the compiler to put the
> code somewhere less likely to chew up CPU cache.

Yep.

> 
> 
> Also, did you consider broadening the ->d_revalidate() semantics?  It
> appears that all implementations return 0 or 1.  You could teach the VFS to
> also recognise and act upon a -ve return value, and do this trickery within
> the autofs d_revalidate(), perhaps?

I did but decided against it because that would change a long standing 
behaviour. Someone would surely get caught.

I could scan the tree and make the approiate changes.

Anyone else care to offer an opinion?

Ian

