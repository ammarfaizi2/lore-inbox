Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272161AbTG2VFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272142AbTG2VFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:05:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:9965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272130AbTG2VCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:02:02 -0400
Date: Tue, 29 Jul 2003 13:50:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yaroslav Halchenko <yoh@onerussian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-Id: <20030729135025.335de3a0.akpm@osdl.org>
In-Reply-To: <20030729153114.GA30071@washoe.rutgers.edu>
References: <20030729153114.GA30071@washoe.rutgers.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> Buffer I/O error on device hda2, logical block 3861502
> Buffer I/O error on device hda2, logical block 3861504
> Buffer I/O error on device hda2, logical block 3861506

Odd.

> dmesg bears also signs about 
> buffer layer error at fs/buffer.c:416
> Call Trace:
>  [<c0154f30>] __find_get_block_slow+0x80/0xe0
>  [<c0155f51>] __find_get_block+0x91/0xf0

Yes, this mystery has been floating about for some time.

What filesystem types are in use?

Are you using some sort of initrd setup?

Could you please run with this patch, send the traces?

diff -puN fs/buffer.c~buffer-debug fs/buffer.c
--- 25/fs/buffer.c~buffer-debug	Tue Jul 29 12:11:59 2003
+++ 25-akpm/fs/buffer.c	Tue Jul 29 13:48:48 2003
@@ -163,6 +163,7 @@ static void buffer_io_error(struct buffe
 	printk(KERN_ERR "Buffer I/O error on device %s, logical block %Lu\n",
 			bdevname(bh->b_bdev, b),
 			(unsigned long long)bh->b_blocknr);
+	dump_stack();
 }
 
 /*
@@ -414,6 +415,9 @@ __find_get_block_slow(struct block_devic
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

