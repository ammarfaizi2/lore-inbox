Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWADL6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWADL6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWADL6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:58:47 -0500
Received: from ns.suse.de ([195.135.220.2]:27534 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751766AbWADL6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:58:46 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
Date: Wed, 4 Jan 2006 12:58:38 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20051108185349.6e86cec3.akpm@osdl.org> <200601041222.09304.ak@suse.de> <43BBB487.8030704@cosmosbay.com>
In-Reply-To: <43BBB487.8030704@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041258.38408.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 12:41, Eric Dumazet wrote:

> > The overhead of the kmem_cache_t by itself is negligible.
> 
> This seems a common misconception among kernel devs (even the best ones Andi :) )

It used to be true at least at some point :/

> 
> On SMP (and/or NUMA) machines : overhead of kmem_cache_t is *big*
> 
> See enable_cpucache in mm/slab.c for 'limit' determination :
> 
>          if (cachep->objsize > 131072)
>                  limit = 1;
>          else if (cachep->objsize > PAGE_SIZE)
>                  limit = 8;
>          else if (cachep->objsize > 1024)
>                  limit = 24;
>          else if (cachep->objsize > 256)
>                  limit = 54;
>          else
>                  limit = 120;
> 
> On a 64 bits machines, 120*sizeof(void*) = 120*8 = 960
> 
> So for small objects (<= 256 bytes), you end with a sizeof(array_cache) = 1024 
> bytes per cpu

Hmm - in theory it could be tuned down for SMT siblings which really don't
care about sharing because they have shared caches. But I don't know
how many complications that would add to the slab code.

> 
> If 16 CPUS : 16*1024 = 16 Kbytes + all other kmem_cache structures : (If you 
> have a lot of Memory Nodes, then it can be *very* big too).
> 
> If you know that no more than 100 objects are used in 99% of setups, then a 
> dedicated cache is overkill, even locking 100 pages because of extreme 
> fragmentation is better.

A system with 16 memory nodes should have more than 100 processes, but ok.

> 
> Maybe we can introduce an ultra basic memory allocator for such objects 
> (without CPU caches, node caches), so that the memory overhead is small. 
> Hitting a spinlock at thread creation/deletion time is not that time critical.

Might be a good idea yes. There used to a "simp" allocator long ago for this,
but it was removed because it had other issues. But this was before even slab
got the per cpu/node support.

-Andi
 
