Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282009AbRKZSeN>; Mon, 26 Nov 2001 13:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282018AbRKZScr>; Mon, 26 Nov 2001 13:32:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56032 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282013AbRKZSb7>;
	Mon, 26 Nov 2001 13:31:59 -0500
Date: Mon, 26 Nov 2001 21:29:39 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <20011126131641.A13955@redhat.com>
Message-ID: <Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Benjamin LaHaise wrote:

> First off, if we take a look at why the page cache lock is being
> contended a few obvious problems pop out immediately:
>
> 	1. potentially long hash chains are walked with the page cache
> 	   lock held for the entire duration of the operation

this is a misunderstanding of the problem. The reason why the
pagecache_lock is a performance problem is *not* contention, the reason is
*not* the length of chains, or any other reason you listed. The problem is
SMP cacheline invalidation costs, due to using the same cacheline from
multiple CPUs. Thus the spreading out of locking gives good SMP cacheline
usage properties.

[ yes, we (well, mostly I) have analyzed such workloads where the
pagecache_lock starts being a problem. ]

the current hash table is pretty compressed, and the chains are short and
good - 1-2 entries in 95% of the cases even with all RAM being in the
pagecache, for a wide range of workloads. [in Anton's test we hit the
limit of the buddy allocator - this problem can be solved either via
bootmem allocation or via the memarea allocator i wrote.]

by using a binary tree we increase cache footprint visibly. Even assuming
the best case (access patters goes linearly in not too big files), the
cache footprint is 1.5*nr_accessed_pages cachelines (statistically). Via
the hash, it's nr_accessed_pages+nr_accessed_hash_cachelines, which is
lower, because in the stock kernel, nr_hash_cachelines is nr_pages/8, with
our patch it's nr_pages/4. So we have an almost 50% difference in cache
footprint - and this was the best-case!

so i'm not against removing (or improving) the hash [our patch in fact
just left the hash alone], but the patch presented is not a win IMO.

	Ingo

