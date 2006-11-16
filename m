Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031135AbWKPJFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031135AbWKPJFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031136AbWKPJFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:05:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32403 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1031137AbWKPJFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:05:09 -0500
Subject: Re: Boot failure with ext2 and initrds
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061114113120.d4c22b02.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 16 Nov 2006 01:05:01 -0800
Message-Id: <1163667901.4310.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 11:31 -0800, Andrew Morton wrote:
> On Tue, 14 Nov 2006 19:11:22 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > On Tue, 14 Nov 2006, Mel Gorman wrote:
> > > 2.6.19-rc5-mm2
> > > 
> > > Am seeing errors with systems using ext2. First machine is a plan old x86
> > > using initramfs. Console output looks like;
> > > ...
> > > Configuring network interfaces...BUG: soft lockup detected on CPU#3!
> > > ...
> > >  [<c01b3b80>] ext2_try_to_allocate+0xdb/0x152
> > >  [<c01b3e72>] ext2_try_to_allocate_with_rsv+0x4b/0x1b2
> > > 
> > > I've not investigated yet what patches might be at fault.
> > 
> > I expect you'll find it's
> > ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch
> > which gets stuck in a loop there for me too: back it out and all seems fine.
> > 
> > It's not obvious which part of the patch is to blame: mostly it's
> > cleanup, but a few variables do change size: I'm currently narrowing
> > down to where a fix is needed.
> > 
> 
> Doing s/-Wall/-W/ tends to shake out bugs in this stuff.
> 
> The below might help.
> 
> Sorry, I tested this well, then the cleanup patch was merged and I didn't
> get onto retesting :(
> 
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  fs/ext2/balloc.c |   33 +++++++++++++++------------------
>  1 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff -puN fs/ext2/balloc.c~ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3-fix fs/ext2/balloc.c
> --- a/fs/ext2/balloc.c~ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3-fix
> +++ a/fs/ext2/balloc.c
> @@ -1155,9 +1155,10 @@ int ext2_new_blocks(struct inode *inode,

This is different from ext3.  Shouldn't the return value from
ext2_new_blocks() a ext2_fsblk_t type?

ext2_alloc_blocks() already thinks that ext2_new_blocks return unsigned
block number.


>  	struct buffer_head *gdp_bh;
>  	int group_no;
>  	int goal_group;
> +	ext2_grpblk_t grp_target_blk;	/* blockgroup relative goal block */
> +	ext2_grpblk_t grp_alloc_blk;	/* blockgroup-relative allocated block*/
>  	ext2_fsblk_t ret_block;		/* filesyetem-wide allocated block */
>  	int bgi;			/* blockgroup iteration index */
> -	int target_block;
>  	int performed_allocation = 0;
>  	ext2_grpblk_t free_blocks;	/* number of free blocks in a group */
>  	struct super_block *sb;
> @@ -1230,14 +1231,15 @@ retry_alloc:
>  		my_rsv = NULL;
> 
>  	if (free_blocks > 0) {
> -		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
> +		grp_target_blk = ((goal - le32_to_cpu(es->s_first_data_block)) %
>  				EXT2_BLOCKS_PER_GROUP(sb));
>  		bitmap_bh = read_block_bitmap(sb, group_no);
>  		if (!bitmap_bh)
>  			goto io_error;
> -		ret_block = ext2_try_to_allocate_with_rsv(sb, group_no,
> -					bitmap_bh, ret_block, my_rsv, &num);
> -		if (ret_block >= 0)
> +		grp_alloc_blk = ext2_try_to_allocate_with_rsv(sb, group_no,
> +					bitmap_bh, grp_target_blk,
> +					my_rsv, &num);
> +		if (grp_alloc_blk >= 0)
>  			goto allocated;
>  	}
> 
> @@ -1273,9 +1275,9 @@ retry_alloc:
>  		/*
>  		 * try to allocate block(s) from this group, without a goal(-1).
>  		 */
> -		ret_block = ext2_try_to_allocate_with_rsv(sb, group_no,
> +		grp_alloc_blk = ext2_try_to_allocate_with_rsv(sb, group_no,
>  					bitmap_bh, -1, my_rsv, &num);
> -		if (ret_block >= 0)
> +		if (grp_alloc_blk >= 0)
>  			goto allocated;
>  	}
>  	/*
> @@ -1299,25 +1301,20 @@ allocated:
>  	ext2_debug("using block group %d(%d)\n",
>  			group_no, gdp->bg_free_blocks_count);
> 
> -	target_block = ret_block + group_no * EXT2_BLOCKS_PER_GROUP(sb)
> -				+ le32_to_cpu(es->s_first_data_block);
> +	ret_block = grp_alloc_blk + ext2_group_first_block_no(sb, group_no);
> 
> -	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), target_block, num) ||
> -	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), target_block, num) ||
> -	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
> +	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), ret_block, num) ||
> +	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), ret_block, num) ||
> +	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
>  		      EXT2_SB(sb)->s_itb_per_group) ||
> -	    in_range(target_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
> +	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
>  		      EXT2_SB(sb)->s_itb_per_group))
>  		ext2_error(sb, "ext2_new_blocks",
>  			    "Allocating block in system zone - "
> -			    "blocks from %u, length %lu", target_block, num);
> +			    "blocks from %u, length %lu", ret_block, num);
> 
>  	performed_allocation = 1;
> 
> -
> -	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
> -	ret_block = target_block;
> -
>  	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
>  		ext2_error(sb, "ext2_new_blocks",
>  			    "block("E2FSBLK") >= blocks count(%d) - "
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

