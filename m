Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282003AbRKZSTB>; Mon, 26 Nov 2001 13:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281996AbRKZSSG>; Mon, 26 Nov 2001 13:18:06 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:41784 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282003AbRKZSQn>; Mon, 26 Nov 2001 13:16:43 -0500
Date: Mon, 26 Nov 2001 13:16:42 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Momchil Velikov <velco@fadata.bg>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
Message-ID: <20011126131641.A13955@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain> <87vgfxqwd3.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87vgfxqwd3.fsf@fadata.bg>; from velco@fadata.bg on Mon, Nov 26, 2001 at 07:23:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 07:23:52PM +0200, Momchil Velikov wrote:
...
> Ingo> The problem with the tree is that if we have a big, eg. 16 GB pagecache,
> Ingo> then even assuming a perfectly balanced tree, it takes more than 20
> Ingo> iterations to find the page in the tree.  (which also means 20 cachelines
> Ingo> touched per tree node we pass.) Such an overhead (both algorithmic and
> Ingo> cache-footprint overhead) is absolutely out of question - and it will only
> Ingo> get worse with more RAM, which isnt a good property.
> 
> The tree is per mapping, not a single one.  Now, with 16GB cached in a
> single mapping, it'd perform poorly, indeed (though probably not 20).
...

I've looked at both splay trees and the page lock patch by Ingo & Dave, and 
personally I disagree with both approaches as they fail to address some of 
the very common cases that are actually causing the underlying problem.

First off, if we take a look at why the page cache lock is being contended 
a few obvious problems pop out immediately:

	1. potentially long hash chains are walked with the page cache
	   lock held for the entire duration of the operation
	2. multiple cache lines are touched while holding the page cache 
	   lock
	3. sequential lookups involve reaquiring the page cache lock
	4. the page cache hash is too large, virtually assuring that 
	   lookups will cause a cache miss

Neither proposed patch addresses all of these problems to the degree that 
I think is possible and would like to attempt.  What I've got in mind is 
a hybrid hash + lock + b*tree scheme, where the lock is per-bucket.  With 
that in place, each bucket would be treated like the top of a b*tree 
(I might have the name wrong, someone please correct me if what I'm 
describing has a different name), where a number of {index, page} pairs 
are stored, plus pointers to the next level of tree.  The whole thing 
would be sized at 1 cacheline per bucket and hold around 5-6 page pointers 
per bucket (64 byte cacheline size).  The lock would be a rw lock to 
allow simultaneous readers (the most common operation).

This directly helps with #1 by allowing us to avoid pulling in extra 
cache lines during the initial lookup phase since the page index # 
is already in the cache line we've retrieved (we may need a pointer 
to the address space, but the hash function can be chosen to make 
such collisions irrelevant) as well as reducing the number of cache 
lines accessed during a lookup.  Since a tree is used for the worst 
case, the length of a chain is reduced, with a very low likelyhood 
of ever exceeding 2 levels (remember, we're working on buckets in 
each level of the tree, not individual page cache entries).  Item 3 
is addressed by improving cache locality for sequential lookups.  
Item 4 can be addressed by changing the hash function to cause some 
grouping for address spaces.

I haven't coded up this idea yet, but I'll get moving on it.  If we're 
going to change the locking again, I'd like to go all the way and do 
it Right.  To this end I'd like to see some appropriate benchmarks made 
to look at the behaviour of the proposed changes under sequential access 
patterns as well as random.  Thoughts?

		-ben
-- 
Fish.
