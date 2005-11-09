Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbVKIKzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbVKIKzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVKIKzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:55:13 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:47620 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030495AbVKIKzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:55:11 -0500
To: viro@ftp.linux.org.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
In-reply-to: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> (message from Al Viro on
	Tue, 08 Nov 2005 02:01:31 +0000)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
Message-Id: <E1EZnbA-000190-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 11:54:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * mount 'source_mnt' under the destination 'dest_mnt' at
> + * dentry 'dest_dentry'. And propagate that mount to
> + * all the peer and slave mounts of 'dest_mnt'.
> + * Link all the new mounts into a propagation tree headed at
> + * source_mnt. Also link all the new mounts using ->mnt_list
> + * headed at source_mnt's ->mnt_list
> + *
> + * @dest_mnt: destination mount.
> + * @dest_dentry: destination dentry.
> + * @source_mnt: source mount.
> + * @tree_list : list of heads of trees to be attached.
> + */
> +int propagate_mnt(struct vfsmount *dest_mnt, struct dentry *dest_dentry,
> +		    struct vfsmount *source_mnt, struct list_head *tree_list)
> +{
> +	struct vfsmount *m, *child;
> +	int ret = 0;
> +	struct vfsmount *prev_dest_mnt = dest_mnt;
> +	struct vfsmount *prev_src_mnt  = source_mnt;
> +	LIST_HEAD(tmp_list);
> +	LIST_HEAD(umount_list);
> +
> +	for (m = propagation_next(dest_mnt, dest_mnt); m;
> +			m = propagation_next(m, dest_mnt)) {
> +		int type = CL_PROPAGATION;
> +
> +		if (IS_MNT_NEW(m))
> +			continue;
> +
> +		if (IS_MNT_SHARED(m))
> +			type |= CL_MAKE_SHARED;
> +
> +		if (!(child = copy_tree(source_mnt, source_mnt->mnt_root,
> +						type))) {
> +			ret = -ENOMEM;
> +			list_splice(tree_list, tmp_list.prev);
> +			goto out;
> +		}
> +
> +		if (is_subdir(dest_dentry, m->mnt_root)) {

Shouldn't this check go before copy_tree()?  Not much point in copying
the tree if we are sure it won't be used.

> +			mnt_set_mountpoint(m, dest_dentry, child);
> +			list_add_tail(&child->mnt_hash, tree_list);
> +		} else {
> +			/*
> +			 * This can happen if the parent mount was bind mounted
> +			 * on some subdirectory of a shared/slave mount.
> +			 */

I can't grok this comment.  Shouldn't it read something like

  ... if 'm' is a result of a bind from a subdirectory of 'dest_dentry'


Miklos
