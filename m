Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752323AbWJ1OZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbWJ1OZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 10:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWJ1OZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 10:25:04 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:62371 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1752074AbWJ1OZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 10:25:01 -0400
Date: Sat, 28 Oct 2006 22:24:54 +0800
From: Andreas Dilger <adilger@clusterfs.com>
To: Andre Noll <maan@systemlinux.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: ext3: bogus i_mode errors with 2.6.18.1
Message-ID: <20061028142454.GA6182@schatzie.adilger.int>
Mail-Followup-To: Andre Noll <maan@systemlinux.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
References: <20061023144556.GY22487@skl-net.de> <20061023164416.GM3509@schatzie.adilger.int> <20061023200242.GA5015@schatzie.adilger.int> <20061024091449.GZ22487@skl-net.de> <20061024202716.GX3509@schatzie.adilger.int> <20061025094418.GA22487@skl-net.de> <20061026093613.GM3509@schatzie.adilger.int> <20061026160241.GB12843@skl-net.de> <20061026180133.GN3509@schatzie.adilger.int> <20061027153414.GA6446@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027153414.GA6446@skl-net.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27, 2006  17:34 +0200, Andre Noll wrote:
> On 12:01, Andreas Dilger wrote:
> > Well, since we know at least one bit needs fixing and results in the block
> > being written to disk then setting the bits for all of the other metadata
> > blocks in this group has no extra IO cost (only a tiny amount of CPU).
> > Re-setting the bits if they are already set is not harmful.
> 
> I.e, something like
> 
>         int i;
>         ext3_fsblk_t bit;
>         unsigned long gdblocks = EXT3_SB(sb)->s_gdb_count;
> 
>         for (i = 0, bit = 1; i < gdblocks; i++, bit++)
>                 ext3_set_bit(bit, gdp_bh->b_data);
> 
> Is that correct?

Well, it needs to also handle backup superblock, bitmaps, inode table:

	if (ext3_bg_has_super())
		ext3_set_bit(0, gdp_bh->b_data);
	gdblocks = ext3_bg_num_gdb(sb, group);
	for (i = 0, bit = 1; i < gdblocks; i++, bit++)
		/* actually a bit more complex for INCOMPAT_META_BG fs */
		ext3_set_bit(i, gdp_bh->b_data);
	ext3_set_bit(gdp->bg_inode_bitmap % EXT3_BLOCKS_PER_GROUP(sb), ...);
	ext3_set_bit(gdp->bg_block_bitmap % EXT3_BLOCKS_PER_GROUP(sb), ...);
	for (i = 0, bit = gdp->bg_inode_table % EXT3_BLOCKS_PER_GROUP(sb);
	     i < EXT3_SB(sb)->s_itb_per_group; i++, bit++)
		ext3_set_bit(i, gdp_bh->b_data);
		
(or something close to this).

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

