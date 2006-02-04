Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWBDXwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWBDXwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWBDXvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:51:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946154AbWBDXvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:51:39 -0500
Date: Sat, 4 Feb 2006 15:50:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 4/5] cpuset memory spread slab cache optimizations
Message-Id: <20060204155038.3191a8c0.akpm@osdl.org>
In-Reply-To: <20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  @@ -2703,20 +2704,9 @@ static inline void *____cache_alloc(stru
>   	struct array_cache *ac;
>   
>   #ifdef CONFIG_NUMA
>  -	if (unlikely(current->mempolicy && !in_interrupt())) {
>  -		int nid = slab_node(current->mempolicy);
>  -
>  -		if (nid != numa_node_id())
>  -			return __cache_alloc_node(cachep, flags, nid);
>  -	}
>  -	if (unlikely(cpuset_mem_spread_check() &&
>  -					(cachep->flags & SLAB_MEM_SPREAD) &&
>  -					!in_interrupt())) {
>  -		int nid = cpuset_mem_spread_node();
>  -
>  -		if (nid != numa_node_id())
>  -			return __cache_alloc_node(cachep, flags, nid);
>  -	}
>  +	if (unlikely(current->flags & (PF_MEM_SPREAD|PF_MEMPOLICY)))
>  +		if ((objp = alternate_node_alloc(cachep, flags)) != NULL)
>  +			return objp;
>   #endif
>   
>   	check_irq_off();
>  @@ -2751,6 +2741,25 @@ __cache_alloc(struct kmem_cache *cachep,
>   
>   #ifdef CONFIG_NUMA
>   /*
>  + * Try allocating on another node if PF_MEM_SPREAD or PF_MEMPOLICY.
>  + */
>  +static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
>  +{
>  +	int nid_alloc, nid_here;
>  +
>  +	if (in_interrupt())
>  +		return NULL;
>  +	nid_alloc = nid_here = numa_node_id();
>  +	if (cpuset_mem_spread_check() && (cachep->flags & SLAB_MEM_SPREAD))
>  +		nid_alloc = cpuset_mem_spread_node();
>  +	else if (current->mempolicy)
>  +		nid_alloc = slab_node(current->mempolicy);
>  +	if (nid_alloc != nid_here)
>  +		return __cache_alloc_node(cachep, flags, nid_alloc);
>  +	return NULL;
>  +}
>  +

Why not move the PF_MEM_SPREAD|PF_MEMPOLICY test into
alternate_node_alloc(), inline the whole thing and nuke the #ifdef in
__cache_alloc()?

We're adding even more goop into the NUMA __cache_alloc() fastpath.  This bad.
