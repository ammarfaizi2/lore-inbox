Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVEKIsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVEKIsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVEKIsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:48:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261929AbVEKIsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:48:20 -0400
Date: Wed, 11 May 2005 09:48:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511084818.GA24495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@gmail.com,
	smfrench@austin.rr.com
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 04:31:35PM +0200, Miklos Szeredi wrote:
> This (lightly tested) patch against 2.6.12-rc* adds some
> infrastructure and basic functionality for unprivileged mount/umount
> system calls.

Thanks for doing this.

> Details:
> 
>   - new mnt_owner field in struct vfsmount
>   - if mnt_owner is NULL, it's a privileged mount
>   - global limit on unprivileged mounts in  /proc/sys/fs/mount-max

I think the name should be different.  user-mount-max?

Acutally the accounting in your patch is a little odd, we account for
all mounts, and after mount-max is reached user mounts are denied.
Shouldn't we account only for user mounts?

>   - per user limit of mounts in rlimit
>   - allow umount for the owner (except force flag)
>   - allow unprivileged bind mount to files/directories writable by owner
>   - add nosuid,nodev flags to unprivileged mounts
> 
> Next step would be to add some policy for new mounts.  I'm thinking of
> either something static: e.g. FS_SAFE flag for "safe" filesystems, or
> a more configurable approach through sysfs or something.
> 
> Comments?

> --- a6d962c4f559f3644678574a66310084fd13d130/fs/namespace.c  (mode:100644 sha1:3b93e5d750ebf8452ea1264251c5b55cc89f48f8)
> +++ uncommitted/fs/namespace.c  (mode:100644)
> @@ -42,7 +42,7 @@
>  static struct list_head *mount_hashtable;
>  static int hash_mask, hash_bits;
>  static kmem_cache_t *mnt_cache; 
> -
> +struct mounts_stat_struct mounts_stat;
>  static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)

minor nipick - please keep a empty line before the function here.
Also I wonder whether we should have struct mounts_stat_struct at all,
just having two variables seems a lot saner to me.

> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!capable(CAP_SYS_ADMIN) && (nd.mnt->mnt_owner != current->user ||
> +					(flags & MNT_FORCE)))
>  		goto dput_and_out;

although it won't have different results I'd reorder this to make reading
more easy:

	if ((nd.mnt->mnt_owner != current->user || (flags & MNT_FORCE)) &&
	    !capable(CAP_SYS_ADMIN))

> -static int mount_is_safe(struct nameidata *nd)
> +static struct user_struct *mount_is_safe(struct nameidata *nd)
>  {
>  	if (capable(CAP_SYS_ADMIN))
> -		return 0;
> -	return -EPERM;
> -#ifdef notyet
> -	if (S_ISLNK(nd->dentry->d_inode->i_mode))
> -		return -EPERM;
> +		return NULL;
> +
> +	if (!S_ISDIR(nd->dentry->d_inode->i_mode) &&
> +	    !S_ISREG(nd->dentry->d_inode->i_mode))
> +		return ERR_PTR(-EPERM);
>  	if (nd->dentry->d_inode->i_mode & S_ISVTX) {
> -		if (current->uid != nd->dentry->d_inode->i_uid)
> -			return -EPERM;
> +		if (current->fsuid != nd->dentry->d_inode->i_uid)
> +			return ERR_PTR(-EPERM);
>  	}
>  	if (permission(nd->dentry->d_inode, MAY_WRITE, nd))
> -		return -EPERM;
> -	return 0;
> -#endif
> +		return ERR_PTR(-EPERM);
> +	return current->user;

Currently we do allow bind mounts over every type of file for the super
user.  I think we should keep allowing that.  Also I think this function
wants a really big comment explaining all the rules for user mounts.

