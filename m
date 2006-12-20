Return-Path: <linux-kernel-owner+w=401wt.eu-S964969AbWLTKny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWLTKny (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWLTKnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:43:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58622 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964969AbWLTKnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:43:53 -0500
Date: Wed, 20 Dec 2006 11:43:51 +0100
From: Jan Kara <jack@suse.cz>
To: Suzuki <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       amit <amitarora@in.ibm.com>
Subject: Re: [RFC] [PATCH] Fix kmalloc flags used in ext3 with an active journal handle
Message-ID: <20061220104351.GA2431@atrey.karlin.mff.cuni.cz>
References: <458898B4.5010805@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458898B4.5010805@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> The attached patch converts the GFP mask for kmallocs within ext3 to 
> GFP_NOFS whenever they are called with an active journal handle.
> 
<snip>
> * Fix the kmalloc flags used from within ext3, when we have an active journal handle
> 
> 	If we do a kmalloc with GFP_KERNEL on system running low on memory, with an active journal handle, we might end up in cleaning up the fs cache flushing dirty inodes for some other filesystem. This would cause hitting a J_ASSERT() in :
> 
> handle_t *journal_start(journal_t *journal, int nblocks)
> {
> 	handle_t *handle = journal_current_handle();
> 	int err;
> [...]
> 
> 	if (handle) {
> 		J_ASSERT(handle->h_transaction->t_journal == journal);
  As I've looked at your trace your analysis seems to be correct and the
patch is fine too. It's just sad that we have to do GFP_NOFS allocation
at so many places... You can add:
  Signed-off-by: Jan Kara <jack@suse.cz>

<snip>
> Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
> 
> Index: linux-2.6.20-rc1/fs/ext3/xattr.c
> ===================================================================
> --- linux-2.6.20-rc1.orig/fs/ext3/xattr.c	2006-12-13 17:14:23.000000000 -0800
> +++ linux-2.6.20-rc1/fs/ext3/xattr.c	2006-12-19 11:41:35.000000000 -0800
> @@ -718,7 +718,7 @@
>  				ce = NULL;
>  			}
>  			ea_bdebug(bs->bh, "cloning");
> -			s->base = kmalloc(bs->bh->b_size, GFP_KERNEL);
> +			s->base = kmalloc(bs->bh->b_size, GFP_NOFS);
>  			error = -ENOMEM;
>  			if (s->base == NULL)
>  				goto cleanup;
> @@ -730,7 +730,7 @@
>  		}
>  	} else {
>  		/* Allocate a buffer where we construct the new block. */
> -		s->base = kmalloc(sb->s_blocksize, GFP_KERNEL);
> +		s->base = kmalloc(sb->s_blocksize, GFP_NOFS);
>  		/* assert(header == s->base) */
>  		error = -ENOMEM;
>  		if (s->base == NULL)
> Index: linux-2.6.20-rc1/fs/ext3/resize.c
> ===================================================================
> --- linux-2.6.20-rc1.orig/fs/ext3/resize.c	2006-12-13 17:14:23.000000000 -0800
> +++ linux-2.6.20-rc1/fs/ext3/resize.c	2006-12-19 11:42:39.000000000 -0800
> @@ -440,7 +440,7 @@
>  		goto exit_dindj;
>  
>  	n_group_desc = kmalloc((gdb_num + 1) * sizeof(struct buffer_head *),
> -			GFP_KERNEL);
> +			GFP_NOFS);
>  	if (!n_group_desc) {
>  		err = -ENOMEM;
>  		ext3_warning (sb, __FUNCTION__,
> @@ -524,7 +524,7 @@
>  	int res, i;
>  	int err;
>  
> -	primary = kmalloc(reserved_gdb * sizeof(*primary), GFP_KERNEL);
> +	primary = kmalloc(reserved_gdb * sizeof(*primary), GFP_NOFS);
>  	if (!primary)
>  		return -ENOMEM;
>  
> Index: linux-2.6.20-rc1/fs/ext3/acl.c
> ===================================================================
> --- linux-2.6.20-rc1.orig/fs/ext3/acl.c	2006-12-13 17:14:23.000000000 -0800
> +++ linux-2.6.20-rc1/fs/ext3/acl.c	2006-12-19 11:45:35.000000000 -0800
> @@ -37,7 +37,7 @@
>  		return ERR_PTR(-EINVAL);
>  	if (count == 0)
>  		return NULL;
> -	acl = posix_acl_alloc(count, GFP_KERNEL);
> +	acl = posix_acl_alloc(count, GFP_NOFS);
>  	if (!acl)
>  		return ERR_PTR(-ENOMEM);
>  	for (n=0; n < count; n++) {
> @@ -91,7 +91,7 @@
>  
>  	*size = ext3_acl_size(acl->a_count);
>  	ext_acl = kmalloc(sizeof(ext3_acl_header) + acl->a_count *
> -			sizeof(ext3_acl_entry), GFP_KERNEL);
> +			sizeof(ext3_acl_entry), GFP_NOFS);
>  	if (!ext_acl)
>  		return ERR_PTR(-ENOMEM);
>  	ext_acl->a_version = cpu_to_le32(EXT3_ACL_VERSION);
> @@ -187,7 +187,7 @@
>  	}
>  	retval = ext3_xattr_get(inode, name_index, "", NULL, 0);
>  	if (retval > 0) {
> -		value = kmalloc(retval, GFP_KERNEL);
> +		value = kmalloc(retval, GFP_NOFS);
>  		if (!value)
>  			return ERR_PTR(-ENOMEM);
>  		retval = ext3_xattr_get(inode, name_index, "", value, retval);
> @@ -335,7 +335,7 @@
>  			if (error)
>  				goto cleanup;
>  		}
> -		clone = posix_acl_clone(acl, GFP_KERNEL);
> +		clone = posix_acl_clone(acl, GFP_NOFS);
>  		error = -ENOMEM;
>  		if (!clone)
>  			goto cleanup;

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
