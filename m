Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWJPQBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWJPQBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWJPQBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:01:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:58331 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422684AbWJPQBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:01:07 -0400
Subject: Re: kernel BUG in __cache_alloc_node at
	linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
	 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 16 Oct 2006 11:00:57 -0500
Message-Id: <1161014457.31903.1.camel@farscape>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-13-10 at 15:22 -0700, Christoph Lameter wrote:
> Here is another fall back fix checking if the slab has already been setup 
> for this node. MPOL_INTERLEAVE could redirect the allocation.
> 

with this patch applied, a different error in the same area.. 

freeing bootmem node 0
freeing bootmem node 1
Memory: 530256k/557056k available (5508k kernel code, 30468k reserved,
2224k data, 543k bss, 244k init)
Kernel panic - not syncing: kmem_cache_create(): failed to create slab
`size-32'



> Index: linux-2.6.19-rc1-mm1/mm/slab.c
> ===================================================================
> --- linux-2.6.19-rc1-mm1.orig/mm/slab.c	2006-10-10 21:47:12.949563383 -0500
> +++ linux-2.6.19-rc1-mm1/mm/slab.c	2006-10-13 17:21:31.937863714 -0500
> @@ -3158,12 +3158,15 @@ void *fallback_alloc(struct kmem_cache *
>  	struct zone **z;
>  	void *obj = NULL;
> 
> -	for (z = zonelist->zones; *z && !obj; z++)
> +	for (z = zonelist->zones; *z && !obj; z++) {
> +		int nid = zone_to_nid(*z);
> +
>  		if (zone_idx(*z) <= ZONE_NORMAL &&
> -				cpuset_zone_allowed(*z, flags))
> +				cpuset_zone_allowed(*z, flags) &&
> +				cache->nodelists[nid])
>  			obj = __cache_alloc_node(cache,
> -					flags | __GFP_THISNODE,
> -					zone_to_nid(*z));
> +					flags | __GFP_THISNODE, nid);
> +	}
>  	return obj;
>  }
> 
> 

