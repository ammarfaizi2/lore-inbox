Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSCTQtO>; Wed, 20 Mar 2002 11:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311830AbSCTQtE>; Wed, 20 Mar 2002 11:49:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7456 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311829AbSCTQsz>; Wed, 20 Mar 2002 11:48:55 -0500
Date: Wed, 20 Mar 2002 17:39:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <20020320173959.F4268@dualathlon.random>
In-Reply-To: <257350410.1016612071@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 08:14:31AM -0800, Martin J. Bligh wrote:
> I don't believe that kmap_high is really O(N) on the size of the pool.

It is O(N), that's the worst case. Of course assuming that the number of
entries in the pool is N and that it is variable, for us it is variable
at compile time.

> Looking at the code for map_new_virtual, note that we start at where
> we left off before: last_pkmap_nr = (last_pkmap_nr + 1) & LAST_PKMAP_MASK;
> So we don't scan the whole array every time - we just walk through it
> one step (on most instances, assuming most of pool is short term use). 

and if we didn't find anything we call flush_all_zero_pkmaps that does a
whole O(N) scan on the pool to try to release the entries that aren't
pinned and then we try again. In short if we increase the pool size, we
linearly increase the time we spend on it (actually more than linearly
because we'll run out of l1/l2/l3 while the pool size increases)

> If you could give me a patch to do that, I'd be happy to try it out.

I will do that in the next -aa. I've quite a lot of stuff pending
(including Andrew split of my VM fixes to merge).

> I added this change on top of the pool shrinkage (i.e. we're still at 128)
> resulting in:
> 
> 3.4%  4.1%  1.4us(1377us)   31us(1462us)(0.19%)    692386 95.9%  4.1%
>     0%  kmap_lock_cacheline
> 2.9%  4.4%  2.4us(1377us)   39us(1333us)(0.13%)    346193 95.6%  4.4%
>     0%    kmap_high+0x34
> 
> Much better ;-) And compile times are much better ... hard to say

Good.

> exactly how much, due to some other complications that I won't
> delve into ....

then just for curiousity you can try to write a program doing:

	open a file
	while 1:
		read 1 byte of it
		lseek back to the start of the file

and run 16 copies simultanously and the kmap_lock_cacheline should raise
again similar to previous levels (no matter if it's the same file or
not). You'll also hit the pagecache_lock in such a workload of course
(like you're also hitting the lru_lock during the kernel compiles for
the lru_cache_add of the anonymous ram).

The only brainer problem with the total removal of the persistent kmaps
are the copy-users, what's your idea about it? (and of course I'm not
going to change that anyways in 2.4, it's not a showstopper)

Andrea
