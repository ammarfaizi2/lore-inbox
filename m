Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSBGLvV>; Thu, 7 Feb 2002 06:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287307AbSBGLvM>; Thu, 7 Feb 2002 06:51:12 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:49552 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S287493AbSBGLu6>; Thu, 7 Feb 2002 06:50:58 -0500
Date: Thu, 7 Feb 2002 11:52:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C6227B7.37BFA2EC@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202071104420.964-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Andrew Morton wrote:
> 
> I feel that presence on the lru list should contribute to
> page->count.  It seems a bit weird and kludgy that this
> is not so.

You're right, and that's the way page->buffers is treated.
But I've been growing rather tired of !!page->buffers all
over the place, and was wondering in the reverse direction,
whether we need to include page->buffers in page->count.

I'm now inclined to argue that holds which are obvious from
the page structure itself need not be included in the count:
whatever makes the totality of code simplest i.e. minimize
the number of special tests: no point in taking !!page->buffers
out of assorted places if even more places or hotpaths then
need additionally to check for page->buffers.

> If we were to do this then would this not fix networking's
> problem?  The skb free wouldn't release the page - it would
> be left on the LRU with ->count == 1 and kswapd would reap it.

Leaving kswapd to reap it is an excellent idea.

> (Says me, hoping that Hugh will code it :))

Thanks for the vote of confidence.  But adding PageLRU into
page->count is not work I could confidently thrust upon Marcelo
at this stage of 2.4.18, too many tricky tests to update (and he
has more sense than to take it).  However, I think we can do it
more simply and safely than that.

shrink_cache already allows for the case of !page_count(page).
I think we should revert to the way Linus and 2.4.17 had it,
page_cache_release doing the lru_cache_del for the common case,
and remove Ben's lru_cache_del from __free_pages_ok; but if
PageLRU is found there, it's not a BUG(), just a page that
can't be reclaimable until shrink_cache gets to delru it.

This I'll try coding up and testing today.  Don't worry, despite
comments above, I won't be changing how page->buffers is counted!

Hugh

