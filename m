Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWADLmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWADLmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWADLmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:42:07 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:55709 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751741AbWADLmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:42:06 -0500
Message-ID: <43BBB487.8030704@cosmosbay.com>
Date: Wed, 04 Jan 2006 12:41:59 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org> <200601041215.36627.ak@suse.de> <43BBAF37.3060108@cosmosbay.com> <200601041222.09304.ak@suse.de>
In-Reply-To: <200601041222.09304.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 04 Jan 2006 12:42:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> 
> Total data of all objects together. That's because caches always get their
> own pages and cannot share them with other caches.

OK for this part.

> The overhead of the kmem_cache_t by itself is negligible.

This seems a common misconception among kernel devs (even the best ones Andi :) )

On SMP (and/or NUMA) machines : overhead of kmem_cache_t is *big*

See enable_cpucache in mm/slab.c for 'limit' determination :

         if (cachep->objsize > 131072)
                 limit = 1;
         else if (cachep->objsize > PAGE_SIZE)
                 limit = 8;
         else if (cachep->objsize > 1024)
                 limit = 24;
         else if (cachep->objsize > 256)
                 limit = 54;
         else
                 limit = 120;

On a 64 bits machines, 120*sizeof(void*) = 120*8 = 960

So for small objects (<= 256 bytes), you end with a sizeof(array_cache) = 1024 
bytes per cpu

If 16 CPUS : 16*1024 = 16 Kbytes + all other kmem_cache structures : (If you 
have a lot of Memory Nodes, then it can be *very* big too).

If you know that no more than 100 objects are used in 99% of setups, then a 
dedicated cache is overkill, even locking 100 pages because of extreme 
fragmentation is better.

Probability that a *lot* of tasks are created at once and killed at once is 
close to 0 during a machine lifetime.


Maybe we can introduce an ultra basic memory allocator for such objects 
(without CPU caches, node caches), so that the memory overhead is small. 
Hitting a spinlock at thread creation/deletion time is not that time critical.

Eric
