Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSIEEgC>; Thu, 5 Sep 2002 00:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSIEEgC>; Thu, 5 Sep 2002 00:36:02 -0400
Received: from dsl-213-023-038-092.arcor-ip.net ([213.23.38.92]:54435 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316792AbSIEEgB>;
	Thu, 5 Sep 2002 00:36:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RFC] Alternative raceless page free
Date: Thu, 5 Sep 2002 06:42:12 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
References: <3D644C70.6D100EA5@zip.com.au> <akdq8h$fqn$1@penguin.transmeta.com> <E17kunE-0003IO-00@starship>
In-Reply-To: <E17kunE-0003IO-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17moT6-00064X-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For completeness, I implemented the atomic_dec_and_test version of raceless 
page freeing suggested by Manfred Spraul.  The atomic_dec_and_test approach 
eliminates the free race by ensuring that when a page's count drops to zero 
the lru list lock is taken atomically, leaving no window where the page can 
also be found and manipulated on the lru list.[1]  Both this and the 
extra-lru-count version are supported in the linked patch:

   http://people.nl.linux.org/~phillips/patches/lru.race-2.4.19-2

The atomic_dec_and_test version is slightly simpler, but was actually more 
work to implement because of the need to locate and eliminate all uses of 
page_cache_release where the lru lock is known to be held, as these will 
deadlock.  That had the side effect of eliminating a number of ifdefs vs the 
lru count version, and rooting out some hidden redundancy.

The patch exposes __free_pages_ok, which must called directly by the 
atomic_dec_and_lock variant.  In the process it got a less confusing name - 
recover_pages.  (The incumbent name is confusing because all other 'free' 
variants in addition manipulate the page count.)

It's a close call which version is faster.  I suspect the atomic_dec_and_lock 
version will not scale quite as well because of the bus-locked cmpxchg on the
page count (optimized version; unoptimized version always takes the spinlock) 
but neither version really lacks in the speed department.

I have a slight preference for the extra-lru-count version, because of the 
trylock in page_cache_release.  This means that nobody will have to spin when 
shrink_cache is active.  Instead, freed pages that collide with the lru lock 
can just be left on the lru list to be picked up efficiently later.  The 
trylock also allows the lru lock to be acquired speculatively from interrupt 
context, without a requirement that lru lock holders disable interrupts.  
Both versions are provably correct, modulo implementation gaffs.

The linked patch defaults to atomic_dec_and_lock version.  To change to
the extra count version, define LRU_PLUS_CACHE as 2 instead of 1.

Christian, can you please run this one through your race detector?

[1] As a corollary, pages with zero count can never be found on the lru list, 
so that is treated as a bug.  

-- 
Daniel
