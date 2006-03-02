Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWCBKsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWCBKsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWCBKsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:48:20 -0500
Received: from cantor.suse.de ([195.135.220.2]:3018 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750772AbWCBKsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:48:20 -0500
Date: Thu, 2 Mar 2006 11:48:18 +0100
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060302104818.GE31712@hasse.suse.de>
References: <17414.38749.886125.282255@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17414.38749.886125.282255@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, Neil Brown wrote:

>   This requires:
>   - Breaking dentry_iput into 2 pieces, one that happens while the
>     dcache locks are held, and one that happens unlocked.
>   - Also, dput needs a variant which can be called with the spinlocks
>     held.
>   - This also requires a suitable comment in the code.
> 
>     It is possible that the dentry_iput call in dput might need to be
>     split into the locked/unlocked portions as well.  That would
>     require collecting a list of inodes and dentries to be freed once
>     the lock is dropped, which would be ugly.
>     An alternative might be to skip the tail recursion when
>     dput_locked was called as I *think* it is just an optimisation.
> 
> 
>  The following patch addressed the first three points.
> 
> Comments?  Please :-?
> 

This looks very much like a fixed version of my patch from
http://lkml.org/lkml/2006/1/20/303. Therfore, in general I'm fine with it ;)

Comments below !

> +void dput_locked(struct dentry *dentry)
> +{
> +	if (!dentry)
> +		return;
> +	if (!atomic_dec_and_test(&dentry->d_count)) {
> + 		spin_unlock(&dentry->d_lock);
> + 		spin_unlock(&dcache_lock);
> +		return;
> +	}
> +	__dput_locked(dentry);
> +}
> +

A comment like in dentry_iput() would be fine here:
 * Called with dcache_lock and per dentry lock held, drops both.

>  static inline void prune_one_dentry(struct dentry * dentry)
>  {
>  	struct dentry * parent;
> +	struct inode * ino;
>  
>  	__d_drop(dentry);
>  	list_del(&dentry->d_u.d_child);
>  	dentry_stat.nr_dentry--;	/* For d_free, below */
> -	dentry_iput(dentry);
> +	ino = dentry_iput_locked(dentry);
>  	parent = dentry->d_parent;
> -	d_free(dentry);
>  	if (parent != dentry)
> -		dput(parent);
> +		dput_locked(parent);
> +	else {
> +		spin_unlock(&dentry->d_lock);
> +		spin_unlock(&dcache_lock);
> +	}
> +	dentry_iput_unlocked(dentry, ino);
> +	d_free(dentry);
> +
>  	spin_lock(&dcache_lock);
>  }
>  

You missed getting the parent dentry's lock before calling dput_locked().

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
