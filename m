Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTJ1WNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTJ1WNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:13:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:26800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbTJ1WNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:13:09 -0500
Date: Tue, 28 Oct 2003 14:13:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: lkml-031028@amos.mailshell.com
Cc: linux-kernel@vger.kernel.org, vs@thebsh.namesys.com,
       Hans Reiser <reiser@namesys.com>
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at
 fs/buffer.c:431"
Message-Id: <20031028141329.13443875.akpm@osdl.org>
In-Reply-To: <20031028154920.1905.qmail@mailshell.com>
References: <20031028154920.1905.qmail@mailshell.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml-031028@amos.mailshell.com wrote:
>
> [1.] One line summary of the problem:
> 
> First time boot of 2.6.0test9 on a resierfs disk gives the error above.
> (buffer layer error at fs/buffer.c:431)
> 
> ...
>
> block=16, b_blocknr=64
> b_state=0x00000019, b_size=1024
> buffer layer error at fs/buffer.c:431

ah-hah.

> Call Trace:
>   [<c014f2b5>] __find_get_block_slow+0x85/0x120
>   [<c01070c9>] kernel_thread_helper+0x5/0xc
>   [<c010970c>] dump_stack+0x1c/0x20
>   [<c0150283>] __find_get_block+0x83/0xe0
>   [<c014fec3>] __getblk_slow+0x23/0xf0
>   [<c015032f>] __getblk+0x4f/0x60
>   [<c01503bf>] __bread+0x1f/0x40
>   [<c01a2132>] read_super_block+0x82/0x210
>   [<c01a2d95>] reiserfs_fill_super+0x555/0x5a0
>   [<c01d69b7>] snprintf+0x27/0x30
>   [<c017bce2>] disk_name+0x62/0xb0
>   [<c0154bc5>] sb_set_blocksize+0x25/0x60
>   [<c0154594>] get_sb_bdev+0x124/0x160
>   [<c01a2e4f>] get_super_block+0x2f/0x60
>   [<c01a2840>] reiserfs_fill_super+0x0/0x5a0
>   [<c01547ff>] do_kern_mount+0x5f/0xe0
>   [<c01695c8>] do_add_mount+0x78/0x150
>   [<c01698b4>] do_mount+0x124/0x170
>   [<c0169720>] copy_mount_options+0x80/0xf0
>   [<c0169c6f>] sys_mount+0xbf/0x140
>   [<c0462b9f>] do_mount_root+0x2f/0xa0
>   [<c0462c64>] mount_block_root+0x54/0x120
>   [<c0462d8e>] mount_root+0x5e/0x70
>   [<c0462dbd>] prepare_namespace+0x1d/0xe0
>   [<c01050d2>] init+0x32/0x160
>   [<c01050a0>] init+0x0/0x160
>   [<c01070c9>] kernel_thread_helper+0x5/0xc

I've been waiting a year for someone who can reproduce this.

The filesystem is trying to read the 4k block at offset 16*4k.

But someone had previously read the 1k block at offset 64*1k.  It is an
alias of the 4k read.

We _should_ have shot down the four 1k-sized buffer_heads which are
attached to the offset=16 pagecache page before trying to read it with 4k
blocksize.

But for some reason, that page still has the 1k-sized buffer_heads.

This means that somehow, somewhere, we failed to successfully run
set_blocksize() against that disk.

Are you using initrd?

Could you please add this patch, and send the new dmesg output?


 25-akpm/fs/block_dev.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff -puN fs/block_dev.c~a fs/block_dev.c
--- 25/fs/block_dev.c~a	Tue Oct 28 14:11:20 2003
+++ 25-akpm/fs/block_dev.c	Tue Oct 28 14:11:24 2003
@@ -50,17 +50,26 @@ int set_blocksize(struct block_device *b
 {
 	int oldsize;
 
+	printk("%s: size=%d\n", __FUNCTION__, size);
+
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || (size & (size-1)))
+	if (size > PAGE_SIZE || size < 512 || (size & (size-1))) {
+		printk("%s: EINVAL 1\n", __FUNCTION__);
 		return -EINVAL;
+	}
 
 	/* Size cannot be smaller than the size supported by the device */
-	if (size < bdev_hardsect_size(bdev))
+	if (size < bdev_hardsect_size(bdev)) {
+		printk("%s: %d < %d\n", __FUNCTION__, size,
+					bdev_hardsect_size(bdev));
 		return -EINVAL;
+	}
 
 	oldsize = bdev->bd_block_size;
-	if (oldsize == size)
+	if (oldsize == size) {
+		printk("%s: %d OK\n", __FUNCTION__, size);
 		return 0;
+	}
 
 	/* Ok, we're actually changing the blocksize.. */
 	sync_blockdev(bdev);

_

