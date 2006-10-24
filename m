Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWJXU1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWJXU1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWJXU1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:27:20 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:16267 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030438AbWJXU1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:27:19 -0400
Date: Tue, 24 Oct 2006 14:27:16 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andre Noll <maan@systemlinux.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061024202716.GX3509@schatzie.adilger.int>
Mail-Followup-To: Andre Noll <maan@systemlinux.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
References: <20061023144556.GY22487@skl-net.de> <20061023164416.GM3509@schatzie.adilger.int> <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024091449.GZ22487@skl-net.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 24, 2006  11:14 +0200, Andre Noll wrote:
> On 14:02, Andreas Dilger wrote:
> Something like the this? (only compile tested). And no, I do _not_ know,
> what I'm doing ;)

Don't worry, everyone starts out not knowing what they are doing.
The ext3_free_blocks() part looks OK from a cursory review.

> @@ -1372,12 +1370,24 @@ allocated:
>  	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
>  		      EXT3_SB(sb)->s_itb_per_group) ||
>  	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
> +		      EXT3_SB(sb)->s_itb_per_group)) {
> +		int j;
> +		ext3_error(sb, __FUNCTION__,
>  			    "Allocating block in system zone - "
>  			    "blocks from "E3FSBLK", length %lu",
>  			     ret_block, num);
> -
> +		/* Note: This will potentially use up one of the handle's
> +		 * buffer credits.  Normally we have way too many credits,
> +		 * so that is OK.  In _very_ rare cases it might not be OK.
> +		 * We will trigger an assertion if we run out of credits,
> +		 * and we will have to do a full fsck of the filesystem -
> +		 * better than randomly corrupting filesystem metadata.
> +		 */
> +		j = find_next_usable_block(-1, gdp, EXT3_BLOCKS_PER_GROUP(sb));

I'm not sure why the "find_next_usable_block()" part is in here?  At this
point we KNOW that ret_block is not a block we should be allocating, yet
it is marked free in the bitmap.  So we should just mark the block(s) in-use
in the bitmap and look for a different block(s).

> +		if (j >= 0)
> +			ext3_set_bit(j, gdp_bh->b_data);

Note that we need to loop over "num" blocks and set any bits that should
be set, as is done in the ext3_free_blocks() code.  This function has
changed since 2.4 in that it can now potentially allocate multiple blocks.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

