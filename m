Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWCTHVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWCTHVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCTHVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:21:20 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:41351 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932180AbWCTHVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:21:19 -0500
Date: Mon, 20 Mar 2006 00:20:37 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] [PATCH 1/4] ext2/3: Extends the max file size(ext2 in kernel)
Message-ID: <20060320072037.GD30801@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20060318220130sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318220130sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 18, 2006  22:01 +0900, sho@tnes.nec.co.jp wrote:
> The unit of ext2/ext3_inode.i_blocks is sector(512B) and the variable
> size is 4bytes, so it limits the max file size to 2TB.  
> I found that i_blocks is always counted with rounding up to the file
> system block size and does not have fractions.  So we can change the
> unit of ext2/ext3_inode.i_blocks from sector to block size.
> This change extends the maximum file size as below.
> 
>   - Add new compatible flag "EXT2_FEATURE_INCOMPAT_LARGE_BLOCK".
>     It indicates that the file size is extended.
> 
>   - If the flag is set in the super block, ext2_inode.i_blocks is
>     translated into the number of sectors and set to i_blocks of VFS
>     inode.  And, if not, ext2_inode.i_blocks is passed to i_blocks
>     of VFS inode as it is.
> 
>   - If the flag is set, the limit of the max file size defined in
>     ext2_max_size() is set to block size * 2G-1(2^31-1).

Instead of breaking all filesystems that need to create large files,
the patch should instead set "i_flags | EXT2_LARGEBLK_FL" only on inodes
that are larger than 2TB and use "blocksize" i_blocks on those files.

This preserves compatibility with existing filesystems and doesn't
impose any breakage opon an existing filesystem for anyone who wants
to use this feature.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

