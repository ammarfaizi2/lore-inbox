Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281893AbRLOEnz>; Fri, 14 Dec 2001 23:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281912AbRLOEno>; Fri, 14 Dec 2001 23:43:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35480 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281893AbRLOEnf>;
	Fri, 14 Dec 2001 23:43:35 -0500
Date: Sat, 15 Dec 2001 07:41:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
In-Reply-To: <20011214172728.B26535@redhat.com>
Message-ID: <Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Dec 2001, Benjamin LaHaise wrote:

> Btw, wouldn't reservation result in the same effect as these mempools
> for significantly less code?

exactly what kind of SLAB based reservation system do you have in mind?
(what interface, how would it work, etc.) Take a look at how bio.c,
highmem.c and raid1.c uses the mempool mechanizm, the main properties of
mempool cannot be expressed via SLAB reservation:

 - mempool allows the use of non-SLAB allocators as the underlying
   allocator. (eg. the highmem.c mempool uses the page allocator to alloc
   lowmem pages. raid1.c uses 4 allocators: kmalloc(), page_alloc(),
   bio_alloc() and mempool_alloc() of a different pool.)

 - mempool_alloc(), if called from a process context, never fails. This
   simplifies lowlevel IO code (which often must not fail) visibly.

 - mempool allows the pooling of arbitrarily complex memory buffers, not
   just a single SLAB buffer. (eg. the raid1.c resync pool uses a
   combination of alloc_mempool(), bio_alloc() and multiple page_alloc()
   buffers. This is also a performance enhancement for raid1.c.)

 - mempool handles allocation in a more deadlock-avoidance-aware way than
   a normal allocator would do:

        - first it ->alloc()'s atomically
        - then it tries to take from the pool if the pool is at least
          half full
        - then it ->alloc()'s non-atomically
        - then it takes from the pool if it's non-empty
        - then it waits for pool elements to be freed

   this makes for five different levels of allocation, ordered for
   performance and blocking-avoidance, while still kicking the VM and
   trying as hard as possible if there is a resource squeeze. In the
   normal case we never touch the mempool spinlocks, we just call
   ->alloc() and if the core allocator does per-CPU caching then we'll
   have the exact same high level of scalability as the underlying
   allocator.

 - mempool adds reservation without increasing the complexity of the
   underlying allocators.

	Ingo

