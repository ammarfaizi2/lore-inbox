Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSKKAqm>; Sun, 10 Nov 2002 19:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSKKAql>; Sun, 10 Nov 2002 19:46:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:61639 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265275AbSKKAqj>;
	Sun, 10 Nov 2002 19:46:39 -0500
Message-ID: <3DCEFF7A.F7534A72@digeo.com>
Date: Sun, 10 Nov 2002 16:53:14 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Diehl <lists@mdiehl.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: buffer layer error at fs/buffer.c:399
References: <Pine.LNX.4.44.0211101839380.1451-100000@notebook.home.mdiehl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 00:53:14.0606 (UTC) FILETIME=[B73C30E0:01C2891C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Diehl wrote:
> 
> Hi,
> 
> shortly after upgrading 2.5.45->2.5.46 I got this while cp'ing some
> regular file. Source and destination was both in rootfs, which is ext2.
> It's not exactly reproducible, however apparently triggered by files
> larger than about 500KB - at least I got a few with those but never from
> smaller one.
> 
> Despite this error/warning(?) the requested file was successfully copied
> (and diffed). A forced fsck on / didn't find any corruption. And it seems
> it doesn't occur if the target file exists, i.e. it's overwritten.
> 
> Kernel is 2.5.46 SMP running on UP box. The new extended attributes were
> not enabled for ext2.
> 
> Martin
> 
> -------------------
> 
> * this one was triggered by "cp file1 file2" (cwd=/root)
> 
> buffer layer error at fs/buffer.c:399
> Pass this trace through ksymoops for reporting
> Call Trace:
>  [<c0151db6>] __find_get_block_slow+0xe6/0x150
>  [<c0152ec6>] __find_get_block+0xd6/0xf0
>  [<c0153277>] unmap_underlying_metadata+0x17/0x50

This means that we had pagecache floating about which has buffers,
but those buffers had unexpected block numbers.  Possibly something
went wrong during an earlier invalidation of the device during the
mount process.  Do you remember if a fsck happened during that bootup?

Is there anything unusual about your setup?  Using initrd?  Is the
rootfs backed by a normal old disk?

Could I please see a `dumpe2fs -h' of that device?

Please, run with this patch and see if if happens again, thanks.


--- 25/fs/buffer.c~buffer-debug	Sun Nov 10 16:47:31 2002
+++ 25-akpm/fs/buffer.c	Sun Nov 10 16:49:59 2002
@@ -397,6 +397,9 @@ __find_get_block_slow(struct block_devic
 		bh = bh->b_this_page;
 	} while (bh != head);
 	buffer_error();
+	printk("block=%llu, b_blocknr=%llu\n",
+		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
+	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);

_
