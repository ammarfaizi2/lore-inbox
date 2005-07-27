Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVG0TQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVG0TQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVG0TOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:14:36 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:33038 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261688AbVG0TOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:14:03 -0400
To: linuxram@us.ibm.com
CC: mathurav@us.ibm.com, mike@waychison.com, janak@us.ibm.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20050725225908.031752000@localhost> (message from Ram Pai on
	Mon, 25 Jul 2005 15:44:20 -0700)
Subject: Re: [PATCH 3/7] shared subtree
References: <20050725224417.501066000@localhost> <20050725225908.031752000@localhost>
Message-Id: <E1DxrL8-0001kG-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Jul 2005 21:13:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -54,7 +55,7 @@ static inline unsigned long hash(struct 
>  
>  struct vfsmount *alloc_vfsmnt(const char *name)
>  {
> -	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
> +	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
>  	if (mnt) {
>  		memset(mnt, 0, sizeof(struct vfsmount));
>  		atomic_set(&mnt->mnt_count,1);

Please make whitespace changes a separate patch.

> @@ -128,11 +162,71 @@ static void attach_mnt(struct vfsmount *
>  {
>  	mnt->mnt_parent = mntget(nd->mnt);
>  	mnt->mnt_mountpoint = dget(nd->dentry);
> -	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
> +	mnt->mnt_namespace = nd->mnt->mnt_namespace;
> +	list_add_tail(&mnt->mnt_hash,
> +			mount_hashtable+hash(nd->mnt, nd->dentry));
>  	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
>  	nd->dentry->d_mounted++;
>  }

Why list_add_tail()?  This changes user visible behavior, and seems
unnecessary.

> +static void attach_prepare_mnt(struct vfsmount *mnt, struct nameidata *nd)
> +{
> +	mnt->mnt_parent = mntget(nd->mnt);
> +	mnt->mnt_mountpoint = dget(nd->dentry);
> +	nd->dentry->d_mounted++;
> +}
> +
> +

You shouldn't add unnecessary newlines.  There are a lot of these,
please audit all your patches.

> +void do_attach_commit_mnt(struct vfsmount *mnt)
> +{
> +	struct vfsmount *parent = mnt->mnt_parent;
> +	BUG_ON(parent==mnt);

	BUG_ON(parent == mnt);

> +	if(list_empty(&mnt->mnt_hash))

	if (list_empty(&mnt->mnt_hash))

> +		list_add_tail(&mnt->mnt_hash,
> +			mount_hashtable+hash(parent, mnt->mnt_mountpoint));
> +	if(list_empty(&mnt->mnt_child))
> +		list_add_tail(&mnt->mnt_child, &parent->mnt_mounts);
> +	mnt->mnt_namespace = parent->mnt_namespace;
> +	list_add_tail(&mnt->mnt_list, &mnt->mnt_namespace->list);
> +}

Etc.  Maybe you should run Lindent on your changes, but be careful not
to change existing code, even if Lindent would do that!

> @@ -191,7 +270,7 @@ static void *m_start(struct seq_file *m,
>  	struct list_head *p;
>  	loff_t l = *pos;
>  
> -	down_read(&n->sem);
> +	down_read(&namespace_sem);
>  	list_for_each(p, &n->list)
>  		if (!l--)
>  			return list_entry(p, struct vfsmount, mnt_list);

This should be a separate patch.  You can just take the one from the
detached trees patch-series.

> +/*
> + * abort the operations done in attach_recursive_mnt(). run through the mount
> + * tree, till vfsmount 'last' and undo the changes.  Ensure that all the mounts
> + * in the tree are all back in the mnt_list headed at 'source_mnt'.
> + * NOTE: This function is closely tied to the logic in
> + * 'attach_recursive_mnt()'
> + */
> +static void abort_attach_recursive_mnt(struct vfsmount *source_mnt, struct
> +		vfsmount *last, struct list_head *head) { struct vfsmount *p =
> +	source_mnt, *m; struct vfspnode *src_pnode;

If you want to do proper error handling, instead of doing rollback, it
seems better to first do anything that can fail (allocations), then do
the actual attaching, which cannot fail.  It isn't nice to have
transient states on failure.

> + /*
> + * This operation is equivalent of mount --bind dir dir
> + * create a new mount at the dentry, and unmount all child mounts
> + * mounted on top of dentries below 'dentry', and mount them
> + * under the new mount.
> +  */
> +struct vfsmount *do_make_mounted(struct vfsmount *mnt, struct dentry *dentry)

Why is this needed?  I thought we agreed, that this can be removed.

Miklos
