Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422921AbWAMUTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422921AbWAMUTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWAMUTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:19:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50599 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422921AbWAMUTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:19:19 -0500
Date: Fri, 13 Jan 2006 12:16:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: mel@csn.ul.ie (Mel Gorman)
Cc: lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] BUG: gfp_zone() not mapping zone modifiers correctly
 and bad ordering of fallback lists
Message-Id: <20060113121652.114941a3.akpm@osdl.org>
In-Reply-To: <20060113155026.GA4811@skynet.ie>
References: <20060113155026.GA4811@skynet.ie>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mel@csn.ul.ie (Mel Gorman) wrote:
>
> Hi Andrew,
> 
> This patch is divided into two parts and addresses a bug in how zone
> fallback lists are calculated and how __GFP_* zone modifiers are mapped to
> their equivilant ZONE_* type. It applies to 2.6.15-mm3 and has been tested
> on x86 and ppc64. It has been reported by Yasunori Goto that it boots on
> ia64. Details as follows;

This stuff is nasty.  It'd be nice to split the patch into two (always)
(please).

> build_zonelists() attempts to be smart, and uses highest_zone() so that it
> doesn't attempt to call build_zonelists_node() for empty zones.  However,
> build_zonelists_node() is smart enough to do the right thing by itself and
> build_zonelists() already has the zone index that highest_zone() is meant
> to provide. So, remove the unnecessary function highest_zone().

Dave, Andy: could you please have a think about the fallback list thing?

> The helper function gfp_zone() assumes that the bits used in the zone modifier
> of a GFP flag maps directory on to their ZONE_* equivalent and just applies a
> mask. However, the bits do not map directly and the wrong fallback lists can
> be used. If unluckly, the system can go OOM when plenty of suitable memory
> is available. This patch redefines the __GFP_ zone modifier flags to allow
> a simple mapping to their equivilant ZONE_ type.

Linus, you had a look at this a few weeks ago and I think you had
objections to the gfp-modifiers-are-bitmasks approach?

> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.15-mm3-clean/include/linux/gfp.h linux-2.6.15-mm3-001_fallbacks/include/linux/gfp.h
> --- linux-2.6.15-mm3-clean/include/linux/gfp.h	2006-01-11 14:24:18.000000000 +0000
> +++ linux-2.6.15-mm3-001_fallbacks/include/linux/gfp.h	2006-01-13 09:18:09.000000000 +0000
> @@ -11,15 +11,19 @@ struct vm_area_struct;
>  /*
>   * GFP bitmasks..
>   */
> -/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
> -#define __GFP_DMA	((__force gfp_t)0x01u)
> -#define __GFP_HIGHMEM	((__force gfp_t)0x02u)
> +/*
> + * Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) 
> + * The values here are mapped to their equivilant ZONE_* type by gfp_zone
> + * which makes assumptions on the value of these bits.
> + */
> +#define __GFP_DMA	((__force gfp_t)0x02u)
> +#define __GFP_HIGHMEM	((__force gfp_t)0x01u)
>  #ifdef CONFIG_DMA_IS_DMA32
> -#define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
> +#define __GFP_DMA32	((__force gfp_t)0x02u)	/* ZONE_DMA is ZONE_DMA32 */
>  #elif BITS_PER_LONG < 64
> -#define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
> +#define __GFP_DMA32	((__force gfp_t)0x00u)	/* ZONE_NORMAL is ZONE_DMA32 */
>  #else
> -#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
> +#define __GFP_DMA32	((__force gfp_t)0x03u)	/* Has own ZONE_DMA32 */
>  #endif
>  
>  /*
> @@ -75,10 +79,15 @@ struct vm_area_struct;
>  #define GFP_DMA32	__GFP_DMA32
>  
>  
> +/**
> + * GFP zone modifiers need to be mapped to their equivilant ZONE_ value defined
> + * in linux/mmzone.h to determine what fallback list should be used for the
> + * allocation.
> + */
>  static inline int gfp_zone(gfp_t gfp)
>  {
> -	int zone = GFP_ZONEMASK & (__force int) gfp;
> -	BUG_ON(zone >= GFP_ZONETYPES);
> +	int zone = ((__force int) gfp & GFP_ZONEMASK) ^ 0x2;
> +	BUG_ON(zone >= MAX_NR_ZONES);
>  	return zone;
>  }
>  
> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.15-mm3-clean/mm/page_alloc.c linux-2.6.15-mm3-001_fallbacks/mm/page_alloc.c
> --- linux-2.6.15-mm3-clean/mm/page_alloc.c	2006-01-11 14:24:18.000000000 +0000
> +++ linux-2.6.15-mm3-001_fallbacks/mm/page_alloc.c	2006-01-13 09:10:17.000000000 +0000
> @@ -1577,18 +1577,6 @@ static int __init build_zonelists_node(p
>  	return nr_zones;
>  }
>  
> -static inline int highest_zone(int zone_bits)
> -{
> -	int res = ZONE_NORMAL;
> -	if (zone_bits & (__force int)__GFP_HIGHMEM)
> -		res = ZONE_HIGHMEM;
> -	if (zone_bits & (__force int)__GFP_DMA32)
> -		res = ZONE_DMA32;
> -	if (zone_bits & (__force int)__GFP_DMA)
> -		res = ZONE_DMA;
> -	return res;
> -}
> -
>  #ifdef CONFIG_NUMA
>  #define MAX_NODE_LOAD (num_online_nodes())
>  static int __initdata node_load[MAX_NUMNODES];
> @@ -1690,13 +1678,11 @@ static void __init build_zonelists(pg_da
>  			node_load[node] += load;
>  		prev_node = node;
>  		load--;
> -		for (i = 0; i < GFP_ZONETYPES; i++) {
> +		for (i = 0; i < MAX_NR_ZONES; i++) {
>  			zonelist = pgdat->node_zonelists + i;
>  			for (j = 0; zonelist->zones[j] != NULL; j++);
>  
> -			k = highest_zone(i);
> -
> -	 		j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
> +	 		j = build_zonelists_node(NODE_DATA(node), zonelist, j, i);
>  			zonelist->zones[j] = NULL;
>  		}
>  	}
> @@ -1706,17 +1692,16 @@ static void __init build_zonelists(pg_da
>  
>  static void __init build_zonelists(pg_data_t *pgdat)
>  {
> -	int i, j, k, node, local_node;
> +	int i, j, node, local_node;
>  
>  	local_node = pgdat->node_id;
> -	for (i = 0; i < GFP_ZONETYPES; i++) {
> +	for (i = 0; i < MAX_NR_ZONES; i++) {
>  		struct zonelist *zonelist;
>  
>  		zonelist = pgdat->node_zonelists + i;
>  
>  		j = 0;
> -		k = highest_zone(i);
> - 		j = build_zonelists_node(pgdat, zonelist, j, k);
> + 		j = build_zonelists_node(pgdat, zonelist, j, i);
>   		/*
>   		 * Now we build the zonelist so that it contains the zones
>   		 * of all the other nodes.
> @@ -1728,12 +1713,12 @@ static void __init build_zonelists(pg_da
>  		for (node = local_node + 1; node < MAX_NUMNODES; node++) {
>  			if (!node_online(node))
>  				continue;
> -			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
> +			j = build_zonelists_node(NODE_DATA(node), zonelist, j, i);
>  		}
>  		for (node = 0; node < local_node; node++) {
>  			if (!node_online(node))
>  				continue;
> -			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
> +			j = build_zonelists_node(NODE_DATA(node), zonelist, j, i);
>  		}
>  
>  		zonelist->zones[j] = NULL;
