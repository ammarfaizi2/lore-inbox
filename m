Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWFCTPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWFCTPF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWFCTPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 15:15:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:64579 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751181AbWFCTPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 15:15:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=tZ66bqnrYC4uYpaRuumSAZBzmkh08/8/ChMl0kE+geJ6N852Qxepmme2Bz73pfzAhgy4VCtPSkbO3fie7+wQNUUHVPQpoa3+qdREsctuZkgKt3AyYSi/zyx7BXNhVO9LTPJcMHOcllVvDJzM3aWw6sBwKOHTu2Q04SP365QiKVw=
Date: Sat, 3 Jun 2006 23:15:58 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Florin Malita <fmalita@gmail.com>
Cc: mark.fasheh@oracle.com, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ocfs2: dereference before NULL check in ocfs2_direct_IO_get_blocks()
Message-ID: <20060603191558.GA7268@martell.zuzino.mipt.ru>
References: <4481AC0F.6040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4481AC0F.6040805@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 11:34:39AM -0400, Florin Malita wrote:
> 'bh_result' & 'inode' are explicitly checked against NULL so they
> shouldn't be dereferenced prior to that.
>
> Coverity ID: 1273, 1274.

> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -559,13 +559,14 @@ static int ocfs2_direct_IO_get_blocks(st
>  	u64 p_blkno;
>  	int contig_blocks;
>  	unsigned char blocksize_bits;
> -	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
> +	unsigned long max_blocks;
>  
>  	if (!inode || !bh_result) {
>  		mlog(ML_ERROR, "inode or bh_result is null\n");
>  		return -EIO;
>  	}
>  
> +	max_blocks = bh_result->b_size >> inode->i_blkbits;
>  	blocksize_bits = inode->i_sb->s_blocksize_bits;

AFAICS, the patch is BS, as usual with this type of patches.

Can "inode" and "bh_result" be NULL here? I bet they can't.

1. The sole purpose of ocfs2_direct_IO_get_blocks() is to be given to
   blockdev_direct_IO_no_locking() at fs/ocfs2/aops.c:662

	Can blockdev_direct_IO_no_locking() call it with first or third
	arg being NULL?

2. blockdev_direct_IO_no_locking() is static inline wrapper
   include/linux/fs.h:1687

   	Can __blockdev_direct_IO() call it's "get_block" arg with first
	or third arg being NULL?

3. Aiee, __blockdev_direct_IO() is normal function (fs/direct-io.c:1179)
   and it gives damn "get_block" arg to direct_io_worker() at
   fs/direct-io.c:1276

4. direct_io_worker() initializes ->get_block method of "dio" structure
   and then does something my tiny mind fails to understand. All I can
   see it doesn't call nor change method later.

   Where is ->get_block called?

5. That what grep(1) is for. One place

	fs/direct-io.c:553:             ret = (*dio->get_block)(dio->inode, fs_startblk,
	fs/direct-io.c-554-                                             map_bh, create);

   Now time to press PageUp. We're seeking for dereferences of
   "dio->inode" and "map_bh" above.

6. Both are immediately out of question:

   536			map_bh->b_size = fs_count << dio->inode->i_blkbits;
			^^^^^^			     ^^^^^^^^^^
			so it can't be NULL		ditto
   537
   538			create = dio->rw == WRITE;
   539			if (dio->lock_type == DIO_LOCKING) {
   540				if (dio->block_in_file < (i_size_read(dio->inode) >>
   541								dio->blkbits))
   542					create = 0;
   543			} else if (dio->lock_type == DIO_NO_LOCKING) {
   544				create = 0;
   545			}
   546
   547			/*
   548			 * For writes inside i_size we forbid block creations: only
   549			 * overwrites are permitted.  We fall back to buffered writes
   550			 * at a higher level for inside-i_size block-instantiating
   551			 * writes.
   552			 */
   553			ret = (*dio->get_block)(dio->inode, fs_startblk,
				^^^^^^^^^^^^^^	^^^^^^^^^^
				offending call	offending arg
   554							map_bh, create);
							^^^^^^
							offending arg

