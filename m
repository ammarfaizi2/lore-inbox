Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319019AbSIDCs5>; Tue, 3 Sep 2002 22:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319021AbSIDCs4>; Tue, 3 Sep 2002 22:48:56 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:15838 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319019AbSIDCs4>; Tue, 3 Sep 2002 22:48:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
Subject: Re: 2.5.33-mm1
Date: Tue, 3 Sep 2002 22:51:54 -0400
User-Agent: KMail/1.4.3
To: William Lee Irwin III <wli@holomorphy.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209032251.54795.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 3, 2002 09:13 pm, Andrew Morton wrote:
> ext3_inode_cache     959   2430    448  264  270    1
>
> That's 264 pages in use, 270 total.  If there's a persistent gap between
> these then there is a problem - could well be that slablru is not locating
> the pages which were liberated by the pruning sufficiently quickly.

Sufficiently quickly is a relative thing.  It could also be that by the time
the pages are reclaimed another <n> have been cleaned.  IMO its no worst
than have freeable pages on lru from any other source.  If we get close to
oom we will call kmem_cache_reap, otherwise we let the lru find the pages.

> Calling kmem_cache_reap() after running the pruners will fix that up.

more specificly kmem_cache_reap will clean the one cache with the most
free pages...

>What on earth is going on with kmem_cache_reap?  Am I missing
>something, or is that thing 700% overdesigned?  Why not just
>free the darn pages in kmem_cache_free_one()?  Maybe hang onto
>a few pages for cache warmth, but heck.

This might be as simple as we can see the free pages in slabs.  We
cannot see other freeable pages in the lru.  This makes slabs seem
like a problem - just because we can see it.

On the other hand we could setup to call __kmem_cache_shrink_locked
after pruning a cache - as it is now this will use page_cache_release
to free the pages...  Need to be careful coding this though.

Andrew, you stated that we need to consider dcache and icache pages
as very important ones.  I submit that this is what slablru is doing.
It is keeping more of these objects around than the previous design,
which is what you wanted to see happen.

Still working on a good reply to your design suggestion/questions?

Ed

-------------------------------------------------------

