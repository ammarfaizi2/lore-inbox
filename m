Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422980AbWJZJgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWJZJgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422976AbWJZJgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:36:16 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:25249 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1422966AbWJZJgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:36:15 -0400
Date: Thu, 26 Oct 2006 03:36:13 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andre Noll <maan@systemlinux.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061026093613.GM3509@schatzie.adilger.int>
Mail-Followup-To: Andre Noll <maan@systemlinux.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
References: <20061023144556.GY22487@skl-net.de> <20061023164416.GM3509@schatzie.adilger.int> <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de> <20061024202716.GX3509@schatzie.adilger.int> <20061025094418.GA22487@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025094418.GA22487@skl-net.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 25, 2006  11:44 +0200, Andre Noll wrote:
> Are you saying that ext3_set_bit() should simply be called with
> "ret_block" as its first argument? If yes, that is what the revised
> patch below does.

You might need to call ext3_set_bit_atomic() (as claim_block() does,
not sure.

> @@ -1372,12 +1370,21 @@ allocated:
>  	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
>  		      EXT3_SB(sb)->s_itb_per_group) ||
>  	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
> +		      EXT3_SB(sb)->s_itb_per_group)) {
> +		ext3_error(sb, __FUNCTION__,
>  			    "Allocating block in system zone - "
>  			    "blocks from "E3FSBLK", length %lu",
>  			     ret_block, num);
> +		/* Note: This will potentially use up one of the handle's
> +		 * buffer credits.  Normally we have way too many credits,
> +		 * so that is OK.  In _very_ rare cases it might not be OK.
> +		 * We will trigger an assertion if we run out of credits,
> +		 * and we will have to do a full fsck of the filesystem -
> +		 * better than randomly corrupting filesystem metadata.
> +		 */
> +		ext3_set_bit(ret_block, gdp_bh->b_data);
> +		goto repeat;
> +	}

The other issue is that you need to potentially set "num" bits in the
bitmap here, if those all overlap metadata.  In fact, it might just
make more sense at this stage to walk all of the bits in the bitmaps,
the inode table and the backup superblock and group descriptor to see
if they need fixing also.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

