Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJYVcR>; Fri, 25 Oct 2002 17:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJYVcR>; Fri, 25 Oct 2002 17:32:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:61367 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261609AbSJYVcQ>;
	Fri, 25 Oct 2002 17:32:16 -0400
Message-ID: <3DB9B9D1.D049C730@digeo.com>
Date: Fri, 25 Oct 2002 14:38:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Alexander Viro <viro@math.psu.edu>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i_blkbits inconsistency
References: <Pine.LNX.4.44.0210252158020.1213-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2002 21:38:25.0486 (UTC) FILETIME=[D95E06E0:01C27C6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> Fix premature -EIO from blkdev_get_block: bdget initialize bd_block_size
> consistent with bd_inode->i_blkbits (assigned by new_inode).  Otherwise,
> subsequent set_blocksize can find bd_block_size doesn't need updating,
> and skip updating i_blkbits, leaving them inconsistent.
> 
> --- 2.5.44/fs/block_dev.c       Sat Oct 19 07:14:45 2002
> +++ linux/fs/block_dev.c        Fri Oct 25 21:30:41 2002
> @@ -310,6 +310,7 @@
>                         new_bdev->bd_queue = NULL;
>                         new_bdev->bd_contains = NULL;
>                         new_bdev->bd_inode = inode;
> +                       new_bdev->bd_block_size = (1 << inode->i_blkbits);
>                         new_bdev->bd_part_count = 0;
>                         new_bdev->bd_invalidated = 0;
>                         inode->i_mode = S_IFBLK;

Thanks, sleuth.   Wondering if we can we remove bd_block_size
and simply use (1 << bdev->bd_inode->i_blkbits) everywhere?
