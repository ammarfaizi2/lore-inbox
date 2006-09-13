Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWIMW2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWIMW2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWIMW2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:28:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35750 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751229AbWIMW2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:28:14 -0400
Date: Wed, 13 Sep 2006 15:28:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
In-Reply-To: <20060913221435.GA4359@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609131517370.20316@schroedinger.engr.sgi.com>
References: <20060912144518.GA4653@localhost.localdomain>
 <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com>
 <20060912195246.GA4039@localhost.localdomain>
 <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com>
 <20060913221435.GA4359@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wish first of all that the description would accurately describe the 
problem.

On Wed, 13 Sep 2006, Ravikiran G Thirumalai wrote:


> +/* Allocate object from the array cache of the executing cpu */

I am not sure what this adds.

> +/* 
> + * Allocate object from the appropriate node as per mempolicy/cpuset
> + * constraints
> + */

We only do this under certain conditions. The main purpose of this 
function is to allocate an object without having specified a node.

>  	unsigned long save_flags;
>  	void *objp;
> -
>  	cache_alloc_debugcheck_before(cachep, flags);
> -
>  	local_irq_save(save_flags);

Extra material.

> +
> +#ifdef CONFIG_NUMA
> +	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
> +		objp = alternate_node_alloc(cachep, flags);
> +		if (objp != NULL) {
> +			local_irq_restore(save_flags);
> +			prefetchw(objp);
> +			return objp;
> +		}
> +	}
> +#endif
> +

Ok.

> @@ -3303,9 +3309,10 @@ void *kmem_cache_alloc_node(struct kmem_
>  	cache_alloc_debugcheck_before(cachep, flags);
>  	local_irq_save(save_flags);
>  
> -	if (nodeid == -1 || nodeid == numa_node_id() ||
> -			!cachep->nodelists[nodeid])
> +	if (nodeid == numa_node_id())
>  		ptr = ____cache_alloc(cachep, flags);
> +	else if (nodeid == -1 || !cachep->nodelists[nodeid])
> +		ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
>  	else

We are still allocating according to policy if nodeid == -1 or if we have 
an invalid node? I thought we agreed that kmalloc_node should never 
obey memory policies?

Simply move the #ifdef CONFIG_NUMA block as we agreed last night. And fix 
the description to specify under what conditions kmalloc_node will obey 
memory policies.
