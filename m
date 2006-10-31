Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423560AbWJaQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423560AbWJaQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423559AbWJaQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:28:29 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:52611 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1423549AbWJaQ22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:28:28 -0500
Date: Tue, 31 Oct 2006 09:28:25 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Holden Karau <holdenk@xandros.com>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, holden@pigscanfly.ca,
       holden.karau@gmail.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Message-ID: <20061031162825.GD26964@parisc-linux.org>
References: <454765AC.1050905@xandros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454765AC.1050905@xandros.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 10:03:08AM -0500, Holden Karau wrote:
> @@ -343,52 +344,65 @@ int fat_ent_read(struct inode *inode, st
>  	return ops->ent_get(fatent);
>  }
>  
> -/* FIXME: We can write the blocks as more big chunk. */
> -static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
> -			  int nr_bhs)
> +
> +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> +			       int nr_bhs , int wait)
>  {
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> -	struct buffer_head *c_bh;
> +	struct buffer_head *c_bh[nr_bhs*(sbi->fats)];
>  	int err, n, copy;
>  
> +	/* Always wait if mounted -o sync */
> +	if (sb->s_flags & MS_SYNCHRONOUS ) 
> +		wait = 1;
>  	err = 0;
>  	for (copy = 1; copy < sbi->fats; copy++) {
>  		sector_t backup_fat = sbi->fat_length * copy;
> -
> -		for (n = 0; n < nr_bhs; n++) {
> -			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> -			if (!c_bh) {
> +		for (n = 0 ; n < nr_bhs ;  n++ ) {
> +			c_bh[(copy-1)*nr_bhs+n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
> +			if (!c_bh[(copy-1)*nr_bhs+n]) {
> +				printk(KERN_CRIT "fat: out of memory while copying backup fat. possible data loss\n");

I don't like that at all.

>  				err = -ENOMEM;
>  				goto error;
>  			}
> -			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
> -			set_buffer_uptodate(c_bh);
> -			mark_buffer_dirty(c_bh);
> -			if (sb->s_flags & MS_SYNCHRONOUS)
> -				err = sync_dirty_buffer(c_bh);
> -			brelse(c_bh);
> -			if (err)
> -				goto error;
> +		memcpy(c_bh[(copy-1)*nr_bhs+n]->b_data, bhs[n]->b_data, sb->s_blocksize);
> +		set_buffer_uptodate(c_bh[(copy-1)*nr_bhs+n]);
> +		mark_buffer_dirty(c_bh[(copy-1)*nr_bhs+n]);
>  		}
>  	}
> +
> +	if (wait) {
> +		for (n = 0 ; n < nr_bhs ; n++) {
> +			printk("copying to %d to  %d\n" ,n,  nr_bhs*(sbi->fats-1)+n);

Is this the right version of the patch?  The printk should never be left in.
Plus, as far as I can tell, that whole loop is actually just memcpy().
