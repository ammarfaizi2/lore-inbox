Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUKNISk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUKNISk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 03:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUKNISj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 03:18:39 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:35528 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261258AbUKNIS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 03:18:27 -0500
Message-ID: <419714B8.3030804@colorfullife.com>
Date: Sun, 14 Nov 2004 09:18:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] __init in mm/slab.c
References: <E1CTDXF-0006mU-00@bkwatch.colorfullife.com>
In-Reply-To: <E1CTDXF-0006mU-00@bkwatch.colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From the bk commit log:

>ChangeSet 1.2132, 2004/11/13 20:59:55-08:00, Andries.Brouwer@cwi.nl
>
>	[PATCH] __init in mm/slab.c
>	
>	The below removes an __initdata
>	(for initarray_generic that is referenced in non-init code).
>  
>
I think the patch is wrong and should be reverted: initarray_generic is 
referenced, but never used:

> if (g_cpucache_up == NONE) {
>         /* Note: the first kmem_cache_create must create
>          * the cache that's used by kmalloc(24), otherwise
>          * the creation of further caches will BUG().
>          */
>         cachep->array[smp_processor_id()] = &initarray_generic.cache;
>         g_cpucache_up = PARTIAL;
> } else {
>         cachep->array[smp_processor_id()] = kmalloc(sizeof(struct 
> arraycache_init),GFP_KERNEL);
> }

g_cpucache_up is NONE during bootstrap and FULL after boot. Thus the 
initarray is never accessed after boot.

Andries, why did you propose this change? Does the current code trigger 
an automatic test?

--
    Manfred
