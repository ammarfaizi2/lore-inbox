Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVLNIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVLNIGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLNIGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:06:49 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:24265 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751119AbVLNIGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:06:49 -0500
Message-ID: <439FD295.7070102@cosmosbay.com>
Date: Wed, 14 Dec 2005 09:06:45 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>	<439D39A8.1020806@cosmosbay.com>	<20051212020211.1394bc17.pj@sgi.com>	<20051212021247.388385da.akpm@osdl.org>	<20051213075345.c39f335d.pj@sgi.com>	<439EF75D.50206@cosmosbay.com>	<Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>	<439F0B43.4080500@cosmosbay.com>	<20051213130350.464a3054.pj@sgi.com>	<439F3F6E.6010701@cosmosbay.com> <20051213142346.ccd3081a.pj@sgi.com>
In-Reply-To: <20051213142346.ccd3081a.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson a écrit :
> Eric wrote:
> 
>>struct kmem_cache  itself will be about 512*8 + some bytes
>>then for each cpu a 'struct array_cache' will be allocated (count 128 bytes 
> 
> 
> Hmmm ... 'struct array_cache' looks to be about 6 integer words,
> so if that is the main per-CPU cost, the minimal cost of a slab
> cache (once created, before use) is about 24 bytes per cpu.

Nope, because struct array_cache includes a variable length table of pointers 
to hold a cache of available objects per cpu. The 'limit' (the number of 
pointer in this cache) depends on the object size.

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



Let's take an example :

grep dentry /proc/slabinfo

dentry_cache      157113 425289    224   17    1 : tunables  120   60    8 : 
slabdata  25017  25017      0


'limit' is the number following 'tunable' : 120

On a 64 bits machines, 120*sizeof(void*) = 120*8 = 960

So for small objects (<= 256 bytes), you end with a sizeof(arracy_cache) = 
1024 bytes per cpu

If 512 CPUS : 512*1024 = 512 Kbytes + all other kmem_cache structures : (If 
you have a lot of Memory Nodes, then it can be very big too)

If you know that no more than 100 objects are used in 99% of setups, then a 
dedicated cache is overkill.

> 
> But whether its 24 or 128 bytes per cpu, that's a heavier weight
> hammer than is needed here.
> 
> Time for me to learn more about rcu.
> 
> Thanks for raising this issue.
> 

You are welcome.

Eric
