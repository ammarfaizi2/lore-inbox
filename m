Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTLICFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 21:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLICFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 21:05:33 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:51225 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262369AbTLICFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 21:05:30 -0500
Date: Tue, 9 Dec 2003 13:03:22 +1100
From: Nathan Scott <nathans@sgi.com>
To: pinotj@club-internet.fr
Cc: torvalds@osdl.org, hch@lst.de, neilb@cse.unsw.edu.au,
       manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031209020322.GA1798@frodo>
References: <mnet2.1070931455.23402.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnet2.1070931455.23402.pinotj@club-internet.fr>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 01:57:35AM +0100, pinotj@club-internet.fr wrote:
> Results about testing on test11 this week-end.

thanks.

>   ---
>   ld: page allocation failure. order:0, mode:0x8d0
>   Unable to handle kernel NULL pointer dereference at virtual address 00000074
>   c01d4cbd
>   *pde = 00000000
>   Oops: 0002 [#1]
>   CPU:    0
>   EIP:    0060:[_xfs_trans_alloc+149/160]    Not tainted
>   EIP:    0060:[<c01d4cbd>]    Not tainted
>   ---

Ah, yes, I know what this is (and can reproduce it) and I don't
have a fix as yet.  This is an unrelated problem - basically,
we are doing kmem_cache_alloc with __GFP_NOFAIL set within XFS,
but the allocations are failing and returning NULL (but we are
assuming they will not).

You (and I) are hitting this more frequently now because Linus'
patch bypasses the slab allocator and is more expensive in terms
of memory used.  However, I have heard of one person who hit this
"in the wild" too, so its something we will need to address.

[ Christoph, is this failure expected?  I think you/Steve made
some changes there to use __GFP_NOFAIL and assume it wont fail?
(in 2.4 we do memory allocations differently to better handle
failures, but that code was removed...) ]

> 
>  B. With Ext3 (and without XFS)
> 
>   1. no patch
>   same as I.A.1
>   2. patch-xfs & patch-slab
>   Compilations looked good but I got a lot of errors in my logs:
> 
>   ---
>   kernel: ld: page allocation failure. order:0, mode:0x50
>   last message repeated 31 times
>   klogd: page allocation failure. order:0, mode:0x50
>   last message repeated 63 times
>   kswapd0: page allocation failure. order:0, mode:0x50
>   ENOMEM in journal_alloc_journal_head, retrying.
>   ion failure. order:0, mode:0x50
>   kswapd0: page allocation failure. order:0, mode:0x50
>   last message repeated 291 times

I expect that this is a similar issue to the above, but from
ext2/3's point of view.

> 
> Tests in I. confirm that it's not an XFS-only problem but seems to
> affect page allocation for fs in general.
> I hope these oops will be clearer to you. I still have no problem with test9.

FWIW and IIRC, we didn't push any XFS changes (nothing major
anyway, that I could foresee causing this) on to Linus in
between -test9 and -test11.

cheers.

-- 
Nathan
