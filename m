Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVAXKO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVAXKO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVAXKO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:14:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18367 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261315AbVAXKOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:14:54 -0500
Date: Mon, 24 Jan 2005 11:14:54 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: 2.6.11-rc2/ext3 quota allocation bug on error path ...
Message-ID: <20050124101453.GA25398@atrey.karlin.mff.cuni.cz>
References: <20050122155044.GA4573@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122155044.GA4573@mail.13thfloor.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> looking at ext3_xattr_block_set() [fs/ext3/xattr.c] ...
> I see that 
> 
>                                 error = -EDQUOT;
>                                 if (DQUOT_ALLOC_BLOCK(inode, 1))
>                                         goto cleanup;
> 
> allocates a quota block, but right after that several
> error echecks happen ...
> 
>                                 if (error)
>                                         goto cleanup;
> 
> and I don't see any DQUOT_FREE_BLOCK() in the errorpath
> 
> cleanup:
>         if (ce)
>                 mb_cache_entry_release(ce);
>         brelse(new_bh); 
>         if (!(bs->bh && s->base == bs->bh->b_data))
>                 kfree(s->base);
> 
>         return error;
> 
> I'd suggest the attached fix (agains 2.6.11-rc2), comments?
  Yes, the patch looks right. Please apply it, Andrew. BTW ext2 needs a
similar fix - will submit in the next mail.

								Honza


> --- ./fs/ext3/xattr.c.orig	2005-01-22 15:07:50 +0100
> +++ ./fs/ext3/xattr.c		2005-01-22 16:45:09 +0100
> @@ -773,7 +773,7 @@ inserted:
>  				error = ext3_journal_get_write_access(handle,
>  								      new_bh);
>  				if (error)
> -					goto cleanup;
> +					goto cleanup_dquot;
>  				lock_buffer(new_bh);
>  				BHDR(new_bh)->h_refcount = cpu_to_le32(1 +
>  					le32_to_cpu(BHDR(new_bh)->h_refcount));
> @@ -783,7 +783,7 @@ inserted:
>  				error = ext3_journal_dirty_metadata(handle,
>  								    new_bh);
>  				if (error)
> -					goto cleanup;
> +					goto cleanup_dquot;
>  			}
>  			mb_cache_entry_release(ce);
>  			ce = NULL;
> @@ -844,6 +844,10 @@ cleanup:
>  
>  	return error;
>  
> +cleanup_dquot:
> +	DQUOT_FREE_BLOCK(inode, 1);
> +	goto cleanup;
> +
>  bad_block:
>  	ext3_error(inode->i_sb, __FUNCTION__,
>  		   "inode %ld: bad block %d", inode->i_ino,
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
