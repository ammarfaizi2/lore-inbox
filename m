Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUFMXjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUFMXjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUFMXjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 19:39:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28292 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261347AbUFMXjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 19:39:36 -0400
Date: Sun, 13 Jun 2004 20:38:26 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: loop/highmem related 2.4.26 lockup
Message-ID: <20040613233826.GA5222@logos.cnet>
References: <20040531143915.GA20653@logos.cnet> <20040531151505.54f18f4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531151505.54f18f4a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 03:15:05PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > Proc;  loop2
> >  >>EIP; e5d145c0 <END_OF_CODE+2597a348/????>   <=====
> >  Trace; c0189ec8 <journal_alloc_journal_head+18/80>
> >  Trace; c0189fa2 <journal_add_journal_head+52/140>
> >  Trace; c0107b92 <__down+82/d0>
> >  Trace; c0107d2c <__down_failed+8/c>
> >  Trace; c01845fe <.text.lock.transaction+4/246>
> >  Trace; c018204a <new_handle+4a/70>
> >  Trace; c0182114 <journal_start+a4/c0>
> >  Trace; c017bc3c <ext3_writepage_trans_blocks+1c/a0>
> >  Trace; c01795ec <ext3_prepare_write+24c/260>
> >  Trace; c013349e <find_or_create_page+5e/150>
> >  Trace; c01d6f84 <lo_send+124/2e0>
> >  Trace; c01d7408 <do_bh_filebacked+b8/c0>
> >  Trace; c01d7b84 <loop_thread+224/250>
> >  Trace; c0109172 <ret_from_fork+6/20>
> >  Trace; c01d7960 <loop_thread+0/250>
> >  Trace; c010740e <arch_kernel_thread+2e/40>
> >  Trace; c01d7960 <loop_thread+0/250>
> 
> You've run out of memory and the loop thread is looping in
> journal_alloc_journal_head(), waiting for memory to come free.
> 
> Meanwhile, kswapd and bdflush are blocked waiting for I/O which requires
> loop thread services to complete.  Deadlock.
> 
> A proper fix for this might be fairly complex.  A kludgey fix like the
> below might work though.

This didnt seem to make it yet. We applied, and it locked up again after
a few days. I'll get you the traces tomorrow.

I'm running v2.6.7-rc3 on a similar SMP buildbox (with similar heavy 
loop usage). Thanks anyway.

> diff -puN fs/jbd/journal.c~a fs/jbd/journal.c
> --- 24/fs/jbd/journal.c~a	2004-05-31 15:12:47.479649360 -0700
> +++ 24-akpm/fs/jbd/journal.c	2004-05-31 15:13:15.908327544 -0700
> @@ -1728,6 +1728,9 @@ static struct journal_head *journal_allo
>  		while (ret == 0) {
>  			yield();
>  			ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
> +			if (!ret)
> +				ret = kmem_cache_alloc(journal_head_cache,
> +							GFP_ATOMIC);
>  		}
>  	}
>  	return ret;
> _
