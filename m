Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288977AbSAUAN6>; Sun, 20 Jan 2002 19:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288978AbSAUANs>; Sun, 20 Jan 2002 19:13:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:23850 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288977AbSAUANi>; Sun, 20 Jan 2002 19:13:38 -0500
Date: Mon, 21 Jan 2002 00:15:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: alad@hss.hns.com
cc: linux-kernel@vger.kernel.org
Subject: Re: free_swap_and_cache() doubt
In-Reply-To: <65256B46.004C44FE.00@sandesh.hss.hns.com>
Message-ID: <Pine.LNX.4.21.0201210013001.1153-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002 alad@hss.hns.com wrote:
> I am reading 2.4.16, let us assume following scenario
> 
> swap_map[offset] == 2;
> and page->count == 2; (before function execution)
> vm_swap is full (nr_swap_pages*2 > total_swap_pages);
> 
> first question is the above case possible.

Yes.

> if yes, then
> after execution of this function, we would have page->count == 1, i.e.
> mapped by some process, with good page->index and what we have is, the
> associated swap entry is already freed.
> 
> Am i wrong somewhere ??

The only place you are wrong is in using the word "good" of page->index
at the end, and indeed I think your point is that it's not good.  It is
not good, it is stale, but that's okay because page->mapping has been
set to NULL, and page->index has no meaning without page->mapping.

You'll notice that __free_pages_ok() contains many BUG() hurdles
(including check on page->mapping and redundant check on PageSwapCache)
but doesn't mind if page->index is non-zero.

But thanks for making me look at this function, there
is a bug there and I'll post a patch for it right now...

Hugh

