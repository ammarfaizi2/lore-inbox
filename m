Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966503AbWKOAEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966503AbWKOAEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966505AbWKOAEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:04:01 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:63455 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S966503AbWKOAEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:04:00 -0500
Date: Tue, 14 Nov 2006 17:03:56 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andre Noll <maan@systemlinux.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061115000356.GA14624@schatzie.adilger.int>
Mail-Followup-To: Andre Noll <maan@systemlinux.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
References: <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de> <20061024202716.GX3509@schatzie.adilger.int> <20061025094418.GA22487@skl-net.de> <20061026093613.GM3509@schatzie.adilger.int> <20061026160241.GB12843@skl-net.de> <20061026180133.GN3509@schatzie.adilger.int> <20061027153414.GA6446@skl-net.de> <20061028142454.GA6182@schatzie.adilger.int> <20061030095558.GB6446@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030095558.GB6446@skl-net.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2006  10:55 +0100, Andre Noll wrote:
> Note that the patch does not address the EXT3_FEATURE_INCOMPAT_META_BG
> case yet. I'll have to look at this in more detail.

See more below...  Basically, the patch looks good enough to submit for
inclusion.  Can you CC it to Andrew on the next iteration.

> +static inline int block_needs_fix(ext3_fsblk_t block,
> +		unsigned long num,
> +		struct ext3_group_desc *gdp,
> +		struct super_block *sb)
> +{
> +	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), block, num))
> +		return 1;
> +	if (in_range(le32_to_cpu(gdp->bg_inode_bitmap), block, num))
> +		return 1;
> +	if (in_range(block, le32_to_cpu(gdp->bg_inode_table),
> +			EXT3_SB(sb)->s_itb_per_group))
> +		return 1;
> +	if (in_range(block + num - 1, le32_to_cpu(gdp->bg_inode_table),
> +			EXT3_SB(sb)->s_itb_per_group))
> +		return 1;

This _should_ probably also include a check for the backup group descriptors
and superblock, but unfortunately the helpers ext3_bg_has_super() and
ext3_bg_num_gdb() are fairly CPU intensive and not something you want to
check for each block that is allocated/freed.  In the future (mballoc) when
we have per-group data structs we can just store a flag per group whether
it has a backup or not instead of recomputing the powers of 3, 5, 7 each time.
Maybe a comment for now to indicate that needs to be fixed in the future?


Also a minor nit - this is actually checking "num" blocks, and it might be
useful in the future so it would be clearer to call it something like
ext3_blocks_are_metadata().

> +static void fix_group(int group, struct super_block *sb)
> +{
> +	int i;
> +	ext3_fsblk_t bit;
> +	unsigned long gdblocks;
> +	struct buffer_head *gdp_bh;
> +	struct ext3_group_desc *gdp = ext3_get_group_desc(sb, group, &gdp_bh);
> +
> +	if (ext3_bg_has_super(sb, group))
> +		ext3_set_bit(0, gdp_bh->b_data);
> +	gdblocks = ext3_bg_num_gdb(sb, group);
> +	for (i = 0, bit = 1; i < gdblocks; i++, bit++)
> +		/* actually a bit more complex for INCOMPAT_META_BG fs */
> +		ext3_set_bit(i, gdp_bh->b_data);

Actually, in newer kernels ext3_bg_num_gdb() includes INCOMPAT_META_BG
support, so that may be enough.


Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

