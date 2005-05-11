Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVEKKVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVEKKVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEKKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:21:18 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:27145 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261950AbVEKKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:20:34 -0400
To: hch@infradead.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, smfrench@austin.rr.com
In-reply-to: <20050511084818.GA24495@infradead.org> (message from Christoph
	Hellwig on Wed, 11 May 2005 09:48:18 +0100)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <20050511084818.GA24495@infradead.org>
Message-Id: <E1DVoK2-0001bS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 12:20:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Details:
> > 
> >   - new mnt_owner field in struct vfsmount
> >   - if mnt_owner is NULL, it's a privileged mount
> >   - global limit on unprivileged mounts in  /proc/sys/fs/mount-max
> 
> I think the name should be different.  user-mount-max?
> 
> Acutally the accounting in your patch is a little odd, we account for
> all mounts, and after mount-max is reached user mounts are denied.
> Shouldn't we account only for user mounts?

It's done similarly to files-max.  I'm not particularly attached to
either view.

> > --- a6d962c4f559f3644678574a66310084fd13d130/fs/namespace.c  (mode:100644 sha1:3b93e5d750ebf8452ea1264251c5b55cc89f48f8)
> > +++ uncommitted/fs/namespace.c  (mode:100644)
> > @@ -42,7 +42,7 @@
> >  static struct list_head *mount_hashtable;
> >  static int hash_mask, hash_bits;
> >  static kmem_cache_t *mnt_cache; 
> > -
> > +struct mounts_stat_struct mounts_stat;
> >  static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
> 
> minor nipick - please keep a empty line before the function here.
> Also I wonder whether we should have struct mounts_stat_struct at all,
> just having two variables seems a lot saner to me.

OK.  Again I was just copying files_stat_struct. 

> > -	if (!capable(CAP_SYS_ADMIN))
> > +	if (!capable(CAP_SYS_ADMIN) && (nd.mnt->mnt_owner != current->user ||
> > +					(flags & MNT_FORCE)))
> >  		goto dput_and_out;
> 
> although it won't have different results I'd reorder this to make reading
> more easy:
> 
> 	if ((nd.mnt->mnt_owner != current->user || (flags & MNT_FORCE)) &&
> 	    !capable(CAP_SYS_ADMIN))

OK.

> > -static int mount_is_safe(struct nameidata *nd)
> > +static struct user_struct *mount_is_safe(struct nameidata *nd)
> >  {
> >  	if (capable(CAP_SYS_ADMIN))
> > -		return 0;
> > -	return -EPERM;
> > -#ifdef notyet
> > -	if (S_ISLNK(nd->dentry->d_inode->i_mode))
> > -		return -EPERM;
> > +		return NULL;
> > +
> > +	if (!S_ISDIR(nd->dentry->d_inode->i_mode) &&
> > +	    !S_ISREG(nd->dentry->d_inode->i_mode))
> > +		return ERR_PTR(-EPERM);
> >  	if (nd->dentry->d_inode->i_mode & S_ISVTX) {
> > -		if (current->uid != nd->dentry->d_inode->i_uid)
> > -			return -EPERM;
> > +		if (current->fsuid != nd->dentry->d_inode->i_uid)
> > +			return ERR_PTR(-EPERM);
> >  	}
> >  	if (permission(nd->dentry->d_inode, MAY_WRITE, nd))
> > -		return -EPERM;
> > -	return 0;
> > -#endif
> > +		return ERR_PTR(-EPERM);
> > +	return current->user;
> 
> Currently we do allow bind mounts over every type of file for the super
> user.  I think we should keep allowing that.

Yep.  I didn't change that check (first two lines of function), so it
should work as it used to.

>  Also I think this function wants a really big comment explaining
> all the rules for user mounts.

OK.

Thanks for the comments,
Miklos
