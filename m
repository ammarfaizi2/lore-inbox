Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUEaWPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUEaWPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264818AbUEaWPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:15:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:48573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264815AbUEaWPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:15:44 -0400
Date: Mon, 31 May 2004 15:15:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: loop/highmem related 2.4.26 lockup
Message-Id: <20040531151505.54f18f4a.akpm@osdl.org>
In-Reply-To: <20040531143915.GA20653@logos.cnet>
References: <20040531143915.GA20653@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Proc;  loop2
>  >>EIP; e5d145c0 <END_OF_CODE+2597a348/????>   <=====
>  Trace; c0189ec8 <journal_alloc_journal_head+18/80>
>  Trace; c0189fa2 <journal_add_journal_head+52/140>
>  Trace; c0107b92 <__down+82/d0>
>  Trace; c0107d2c <__down_failed+8/c>
>  Trace; c01845fe <.text.lock.transaction+4/246>
>  Trace; c018204a <new_handle+4a/70>
>  Trace; c0182114 <journal_start+a4/c0>
>  Trace; c017bc3c <ext3_writepage_trans_blocks+1c/a0>
>  Trace; c01795ec <ext3_prepare_write+24c/260>
>  Trace; c013349e <find_or_create_page+5e/150>
>  Trace; c01d6f84 <lo_send+124/2e0>
>  Trace; c01d7408 <do_bh_filebacked+b8/c0>
>  Trace; c01d7b84 <loop_thread+224/250>
>  Trace; c0109172 <ret_from_fork+6/20>
>  Trace; c01d7960 <loop_thread+0/250>
>  Trace; c010740e <arch_kernel_thread+2e/40>
>  Trace; c01d7960 <loop_thread+0/250>

You've run out of memory and the loop thread is looping in
journal_alloc_journal_head(), waiting for memory to come free.

Meanwhile, kswapd and bdflush are blocked waiting for I/O which requires
loop thread services to complete.  Deadlock.

A proper fix for this might be fairly complex.  A kludgey fix like the
below might work though.

diff -puN fs/jbd/journal.c~a fs/jbd/journal.c
--- 24/fs/jbd/journal.c~a	2004-05-31 15:12:47.479649360 -0700
+++ 24-akpm/fs/jbd/journal.c	2004-05-31 15:13:15.908327544 -0700
@@ -1728,6 +1728,9 @@ static struct journal_head *journal_allo
 		while (ret == 0) {
 			yield();
 			ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
+			if (!ret)
+				ret = kmem_cache_alloc(journal_head_cache,
+							GFP_ATOMIC);
 		}
 	}
 	return ret;
_

