Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282053AbRKZSoo>; Mon, 26 Nov 2001 13:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282039AbRKZSnn>; Mon, 26 Nov 2001 13:43:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61152 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282042AbRKZSnR>;
	Mon, 26 Nov 2001 13:43:17 -0500
Date: Mon, 26 Nov 2001 21:40:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <20011126131641.A13955@redhat.com>
Message-ID: <Pine.LNX.4.33.0111262133140.17709-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Benjamin LaHaise wrote:

> 	1. potentially long hash chains are walked with the page cache
> 	   lock held for the entire duration of the operation

not the case.

> 	2. multiple cache lines are touched while holding the page cache
> 	   lock

not the case because the problem with the pagecache_lock was its bouncing
between CPUs, not processes waiting on it.

> 	3. sequential lookups involve reaquiring the page cache lock

the granularity of the pagecache directly influences the number of
accesses to the pagecache locking mechanizm. Neither patch solves this,
the number of lock operations does not change - but the lock data
structures are spread out more.

i think it's a separate (and just as interesting) issue to decrease the
granularity of the pagecache - this not only decreases locking (and other
iteration) costs, it also decreases the size of the hash (or whatever
other data structure is used).

> 	4. the page cache hash is too large, virtually assuring that
> 	   lookups will cause a cache miss

this does not appear to be the case (see my other replies). Even if the
hash table is big and assuming the worst-case (we miss on every hash table
access), mem_map is *way* bigger in the cache because it has a much less
compressed format. The compression ratio between mem_map[] and the hash
table is 1:8 in the stock kernel, 1:4 with the page buckets patch.

	Ingo

