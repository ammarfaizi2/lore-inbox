Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVAZXnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVAZXnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAZXmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:42:02 -0500
Received: from news.suse.de ([195.135.220.2]:34794 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261674AbVAZSce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:32:34 -0500
Subject: Re: 2.6.11-rc2/ext3 quota allocation bug on error path ...
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Jan Kara <jack@suse.cz>
In-Reply-To: <20050122155044.GA4573@mail.13thfloor.at>
References: <20050122155044.GA4573@mail.13thfloor.at>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106764346.13004.232.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 Jan 2005 19:32:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2005-01-22 at 16:50, Herbert Poetzl wrote:
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

looks good. Can this please be added?

THanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

