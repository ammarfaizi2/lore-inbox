Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTJ2GIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 01:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJ2GIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 01:08:01 -0500
Received: from [217.73.128.98] ([217.73.128.98]:51078 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261892AbTJ2GH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 01:07:59 -0500
Date: Tue, 28 Oct 2003 22:27:20 +0200
Message-Id: <200310282027.h9SKRKZ9015445@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
To: linux-kernel@vger.kernel.org, lkml-031028@amos.mailshell.com
References: <20031028154920.1905.qmail@mailshell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml-031028@amos.mailshell.com wrote:

lamc> I have a single-filesystem 76Gb ResierFs filesystem. (reports as
lamc> "ReiserFS 3.6").
lamc> First time I boot the 2.6.0 kernel I got the message quoted above,
lamc> The message repated twice in a row. Both instance seem itentical to
lamc> me. The message with the stack trace is copied as-is from the
lamc> output of dmesg below:
lamc> buffer layer error at fs/buffer.c:431
lamc> block=16, b_blocknr=64
lamc> b_state=0x00000019, b_size=1024

Hm, this looks *very* strange to me.
Basically what happened is we (VFS) tried to look up a page that holds
block number 16 for the fs device, but the end result was page
that contained block number 64.
This looked a lot like if we have already changed device's block size,
but old buffers were not invalidated. So our 16th block of 4k size
resulted in a page containing 64th block of 1k size.
To verify this you can apply this simple patch below and see if
returned block size was different from current block size.
As of how this might have happened, I have not idea, but certainly
this have nothing to do with reiserfs itself.


===== fs/buffer.c 1.215 vs edited =====
--- 1.215/fs/buffer.c	Tue Sep 30 04:12:02 2003
+++ edited/fs/buffer.c	Tue Oct 28 21:26:23 2003
@@ -432,6 +432,7 @@
 	printk("block=%llu, b_blocknr=%llu\n",
 		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
 	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
+	printk("device blocksize: %d\n", 1<<bd_inode->i_blkbits);
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);

Bye,
    Oleg
