Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752452AbWJ0VBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbWJ0VBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWJ0VBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:01:32 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50115 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1752446AbWJ0VBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:01:31 -0400
Date: Fri, 27 Oct 2006 17:01:11 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Holden Karau <holden@pigscanfly.ca>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       holdenk@xandros.com, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, holden.karau@gmail.com
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes in fat_mirror_bhs [really unmangled]
Message-ID: <20061027210110.GA22059@filer.fsl.cs.sunysb.edu>
References: <4540A32E.5050602@pigscanfly.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540A32E.5050602@pigscanfly.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of these may overlap with what others suggested.

On Thu, Oct 26, 2006 at 07:59:42AM -0400, Holden Karau wrote:
...
> --- a/fs/fat/fatent.c	2006-09-19 23:42:06.000000000 -0400
> +++ b/fs/fat/fatent.c	2006-10-25 19:14:14.000000000 -0400
...
> -/* FIXME: We can write the blocks as more big chunk. */
>  static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> -			  int nr_bhs)
> +			  int nr_bhs ) {
> +  return fat_mirror_bhs_optw(sb , bhs , nr_bhs, 0);
> +}

Coding style... (brackets and indentation)

> +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> +			       int nr_bhs , int wait)
>  {
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> -	struct buffer_head *c_bh;
> +	struct buffer_head *c_bh[nr_bhs];
>  	int err, n, copy;
>  
> +	/* Always wait if mounted -o sync */
> +	if (sb->s_flags & MS_SYNCHRONOUS ) {
> +	  wait = 1;
> +	}

Ditto (indentation).

>  	err = 0;
> +	err = fat_sync_bhs_optw( bhs  , nr_bhs , wait);
> +	if (err)
> +	  goto error;
>  	for (copy = 1; copy < sbi->fats; copy++) {
>  		sector_t backup_fat = sbi->fat_length * copy;
> -
>  		for (n = 0; n < nr_bhs; n++) {
> -			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> -			if (!c_bh) {
> +	    c_bh[n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> +	    if (!c_bh[n]) {
>  				err = -ENOMEM;
>  				goto error;
>  			}
> -			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
> -			set_buffer_uptodate(c_bh);
> -			mark_buffer_dirty(c_bh);
> -			if (sb->s_flags & MS_SYNCHRONOUS)
> -				err = sync_dirty_buffer(c_bh);
> -			brelse(c_bh);
> +	    set_buffer_uptodate(c_bh[n]);
> +	    mark_buffer_dirty(c_bh[n]);
> +	    memcpy(c_bh[n]->b_data, bhs[n]->b_data, sb->s_blocksize);
> +	  }
> +	  err = fat_sync_bhs_optw( c_bh  , nr_bhs , wait );
> +	  for (n = 0; n < nr_bhs; n++ ) {
> +	    brelse(c_bh[n]);
> +	  }
>  			if (err)
>  				goto error;
>  		}
> -	}
>  error:
>  	return err;
>  }

Ditto.

> @@ -505,9 +513,9 @@ out:
>  	fatent_brelse(&fatent);
>  	if (!err) {
>  		if (inode_needs_sync(inode))
> -			err = fat_sync_bhs(bhs, nr_bhs);
> -		if (!err)
> -			err = fat_mirror_bhs(sb, bhs, nr_bhs);
> +		  err = fat_mirror_bhs_optw(sb , bhs, nr_bhs , 1);
> +		else
> +		  err = fat_mirror_bhs_optw(sb, bhs, nr_bhs , 0 );

Ditto.

> --- a/fs/fat/misc.c	2006-09-19 23:42:06.000000000 -0400
> +++ b/fs/fat/misc.c	2006-10-25 18:54:27.000000000 -0400
> @@ -194,11 +194,17 @@ void fat_date_unix2dos(int unix_date, __
>  
>  EXPORT_SYMBOL_GPL(fat_date_unix2dos);
>  
> -int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
> +
> +int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs ) {
> +  return fat_sync_bhs_optw(bhs , nr_bhs , 1);
> +}

Indentation & bracket placement.

> +int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs ,int wait)
>  {
>  	int i, err = 0;
>  
>  	ll_rw_block(SWRITE, nr_bhs, bhs);
> +	if (wait) {
>  	for (i = 0; i < nr_bhs; i++) {
>  		wait_on_buffer(bhs[i]);
>  		if (buffer_eopnotsupp(bhs[i])) {
> @@ -207,6 +213,7 @@ int fat_sync_bhs(struct buffer_head **bh
>  		} else if (!err && !buffer_uptodate(bhs[i]))
>  			err = -EIO;
>  	}
> +	}
 
Indentation.
 
Josef "Jeff" Sipek.

-- 
Mankind invented the atomic bomb, but no mouse would ever construct a
mousetrap.
		- Albert Einstein
