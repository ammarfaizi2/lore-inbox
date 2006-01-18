Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWARSwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWARSwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWARSwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:52:53 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:1691 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1030278AbWARSwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:52:53 -0500
Date: Wed, 18 Jan 2006 11:52:50 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] ext3: Extends blocksize up to pagesize
Message-ID: <20060118185249.GN4124@schatzie.adilger.int>
Mail-Followup-To: Takashi Sato <sho@tnes.nec.co.jp>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 18, 2006  22:06 +0900, Takashi Sato wrote:
> As a disk tends to get large, a disk storage has had a capacity to
> supply multi-TB.  But now, ext3 can't support more than 8TB filesystem
> when blocksize is 4KB.  That's why I think ext3 needs to be
> more than 8TB.
> 
> Therefore I think filesystem size can increase on architectures
> which has more than 4KB pagesize by extending blocksize to pagesize on
> ext3.  For example, the following is in case of ia64.  (Blocksize have
> already been supported up to pagesize on ext2. Why is the max blocksize
> restricted to 4KB on ext3?)
> 
> Max filesystem size on ia64:
> Original                                   :4096(blocksize) * 2^31 =  8TB
> After modification [pagesize=16KB(default)]:16384(blocksize) * 2^31 = 32TB
> After modification [pagesize=64KB(max)]    :65536(blocksize) * 2^31 = 128TB

Just for others' info - the fill_super change has been tested in the past
by Sonny Rao at IBM also.  e2fsprogs has supported this for a long time
already.

> - ext3_readdir
>   Currently read-ahead 16 sectors when reading a directory, but not
>   if blocksize is more than 8KB.  Then I modified to read-ahead
>   one fs-block if blocksize is more than 8KB.

> @@ -142,7 +142,13 @@ static int ext3_readdir(struct file * fi
>  		if (!offset) {
> -			for (i = 16 >> (EXT3_BLOCK_SIZE_BITS(sb) - 9), num = 0;
> +			int readcnt;
> +			if (sb->s_blocksize > 8192) {
> +				readcnt = sb->s_blocksize >> EXT3_SECTOR_BITS;
> +			} else {
> +				readcnt = 16;
> +			}
> +			for (i = readcnt >> (EXT3_BLOCK_SIZE_BITS(sb) - 9), num = 0;
>  			     i > 0; i--) {
>  				tmp = ext3_getblk (NULL, inode, ++blk, 0, &err);
>  				if (tmp && !buffer_uptodate(tmp) &&

The code doesn't get any more clear with your change.  Using "sectors" as
a readahead unit is kind of pointless in the first place (that isn't your
fault, not sure why it is like that), and 8kB readahead is probably too
small for today's disks.

It would probably make more sense to just change this to be straight forward:
"readcnt = 16 * sb->s_blocksize" or "readcnt = 64 >> EXT3_BLOCK_SIZE_BITS(sb)".

Usually directories are small, so this is a non-issue.  If they are large
you likely want to readahead more anyways, especially since directory blocks
are usually fragmented and more readahead time is better.


Note that this should probably also include an ext2 version of the same
change so that it is still possible to mount such a filesystem as ext2.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

