Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281781AbRKZP0W>; Mon, 26 Nov 2001 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281766AbRKZP0J>; Mon, 26 Nov 2001 10:26:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47839 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281771AbRKZPYv>;
	Mon, 26 Nov 2001 10:24:51 -0500
Date: Mon, 26 Nov 2001 18:22:25 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <87elml4ssx.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Nov 2001, Momchil Velikov wrote:

> Hi,
>
> This patch:
>
>         - replaces the global page cache hash table with a per mapping
>           splay tree;
>
>         - eliminates the ``pagecache_lock'', instead ``i_shared_lock''
>           is used so serialize access during insertion/deletion
>           into/from the tree;
>
> The goals of the patch are to:
>
>         - to improve scalability (via the elimination of the global
>           lock);
>
>         - reduce the memory/cache footprint (via to the
>           ``page_hash_table'' elimination);
>
> The patch is against 2.4.16-pre1. Comments are welcome.

are you aware of the following patch? (written by David Miller and me.)

  http://people.redhat.com/mingo/smp-pagecache-patches/pagecache-2.4.10-A3

it gets rid of the pagecache lock without introducing a tree.

while reducing memory footprint is a goal we want to achieve, the
pagecache hash is such a critical piece of data structure that we want
O(1)-type search properties, not a tree. The pagetable hash takes up 0.2%
of RAM currently. (but we could cut the size of the hash in half i think,
it's a bit over-sized currently - it has as many entries.)

The problem with the tree is that if we have a big, eg. 16 GB pagecache,
then even assuming a perfectly balanced tree, it takes more than 20
iterations to find the page in the tree.  (which also means 20 cachelines
touched per tree node we pass.) Such an overhead (both algorithmic and
cache-footprint overhead) is absolutely out of question - and it will only
get worse with more RAM, which isnt a good property.

hashes on the other hand are simple and fast, and we can always balance
performance against cache footprint and hash-table memory usage. This is
one reason why we keept the pagetable hash in our patch.

	Ingo

