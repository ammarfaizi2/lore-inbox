Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSHOO2T>; Thu, 15 Aug 2002 10:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSHOO2T>; Thu, 15 Aug 2002 10:28:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:10766 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S317012AbSHOO2S>; Thu, 15 Aug 2002 10:28:18 -0400
Date: Thu, 15 Aug 2002 15:32:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: j-nomura@ce.jp.nec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18(19) swapcache oops
In-Reply-To: <20020815.213929.846960657.nomura@hpc.bs1.fc.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0208151515420.1610-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002 j-nomura@ce.jp.nec.com wrote:
> 
> I'm using 2.4.18 kernel and suspect there are swapcache race. 
> I looked into 2.4.19 patch but could not find the fix to it.

I see a benign race but no oops.

> In the situation such as:
>   - two processes (process A and B) sharing memory space
>   - one of the pages in the space has been swapped out and
>     not remained in swapcache
>   - process A runs on cpu0, process B runs on cpu1
> 
> when process A reads the address corresponding to the page,
> page fault occurs and the cpu0 reads swapped-out page into memory,
> calls add_to_page_cache_unique() to add it to swapcache and then
> calls lru_cache_add() to add it to lru list.
> 
> If process B reads the same address at that time, cpu1 calls
> do_swap_page() and lookup_swap_cache() may succeed before cpu0
> calls lru_cache_add() and cpu1 will set the page active by
> following mark_page_accessed().

I agree that B may get to mark_page_accessed before A gets to
lru_cache_add, but B will just SetPageReferenced.  If there's a
similar process C racing on the page too, its mark_page_accessed
would call activate_page, but that will see !PageLRU and do nothing.

> lru_cache_add() checks if the page is active and if it is active,
> it calls BUG().

It cannot be made PageActive until after lru_cache_add has set PageLRU.

Hugh

