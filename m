Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSHEAa3>; Sun, 4 Aug 2002 20:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSHEAa3>; Sun, 4 Aug 2002 20:30:29 -0400
Received: from dsl-213-023-043-097.arcor-ip.net ([213.23.43.97]:41602 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317570AbSHEAa2>;
	Sun, 4 Aug 2002 20:30:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Mon, 5 Aug 2002 02:35:27 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <3D4DB9E4.E785184E@zip.com.au>
In-Reply-To: <3D4DB9E4.E785184E@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17bVqJ-0000ca-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 01:33, Andrew Morton wrote:
> OK, I warmed the code up a bit and did some more measurement.
> Your locking patch has improved things significantly.  And
> we're now getting hurt by all the cache misses walking the
> pte chains.

Well that's a relief.  I was beginning to believe that your 4 way has some 
sort of built-in anti-optimization circuit.

Are you still seeing no improvement on four way smp?

> ...And it's all really in __page_remove_rmap, kmem_cache_alloc/free.
> 
> If we convert the pte_chain structure to
> 
> struct pte_chain {
> 	struct pte_chain *next;
> 	pte_t *ptes[L1_CACHE_BYTES - 4];
> };
> 
> and take care to keep them compacted we shall reduce the overhead
> of both __page_remove_rmap and the slab functions by up to 7, 15
> or 31-fold, depending on the L1 size.  page_referenced() wins as well.
> 
> Plus we almost halve the memory consumption of the pte_chains
> in the high sharing case.  And if we have to kmap these suckers
> we reduce the frequency of that by 7x,15x,31x,etc.
> 
> I'll code it tomorrow.

Sounds good.  There is still some tuning to be done on the rmap lock 
batching, to distribute the locks better and set anon page->indexes more 
intelligently.  I expect this to be good for another percent or two, nothing 
really exciting.

-- 
Daniel
