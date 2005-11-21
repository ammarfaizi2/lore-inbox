Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVKUP66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVKUP66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKUP66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:58:58 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:9649 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S932342AbVKUP65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:58:57 -0500
Message-ID: <4381EE9D.1000506@cosmosbay.com>
Date: Mon, 21 Nov 2005 16:58:21 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       christoph@lameter.com
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 21 Nov 2005 16:58:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg a écrit :
> This patch gets rid of one if-else statement by moving current node allocation
> check at the beginning of kmem_cache_alloc_node().
> 

Are you sure this is valid ?
What about preemption ?
The "if (nodeid == numa_node_id())" check was done with IRQ off, and you want 
do do it with IRQ on.

> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> 
>  slab.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 7f80ec3..a05bbfe 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2881,7 +2881,7 @@ void *kmem_cache_alloc_node(kmem_cache_t
>  	unsigned long save_flags;
>  	void *ptr;
>  
> -	if (nodeid == -1)
> +	if (nodeid == -1 || nodeid == numa_node_id())

<Imagine preemption here, and thread migrated to another NUMA node.>

>  		return __cache_alloc(cachep, flags);
>  
>  	if (unlikely(!cachep->nodelists[nodeid])) {
> @@ -2892,10 +2892,7 @@ void *kmem_cache_alloc_node(kmem_cache_t
>  
>  	cache_alloc_debugcheck_before(cachep, flags);
>  	local_irq_save(save_flags);
> -	if (nodeid == numa_node_id())
> -		ptr = ____cache_alloc(cachep, flags);
> -	else
> -		ptr = __cache_alloc_node(cachep, flags, nodeid);
> +	ptr = __cache_alloc_node(cachep, flags, nodeid);
>  	local_irq_restore(save_flags);
>  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
>  

