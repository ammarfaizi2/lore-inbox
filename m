Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWATQ20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWATQ20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWATQ20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:28:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35202 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751053AbWATQ2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:28:25 -0500
Date: Fri, 20 Jan 2006 08:28:16 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andy Whitcroft <apw@shadowen.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zone_reclaim cpus_empty needs a real variable
In-Reply-To: <20060120135845.GA8040@shadowen.org>
Message-ID: <Pine.LNX.4.62.0601200826150.17531@schroedinger.engr.sgi.com>
References: <20060120031555.7b6d65b7.akpm@osdl.org> <20060120135845.GA8040@shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Andy Whitcroft wrote:

> zone_reclaim cpus_empty needs a real variable

Maybe we also need to add a new variable for

zone->zone_pgdat->node_id 

Its used multiple times 

> 
> On some architectures cpus_empty() attempts to take the address
> of the mask.  Consequently we must store the result of the
> node_to_cpumask() before applying it.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> ---
>  vmscan.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> diff -upN reference/mm/vmscan.c current/mm/vmscan.c
> --- reference/mm/vmscan.c
> +++ current/mm/vmscan.c
> @@ -1836,18 +1836,21 @@ int zone_reclaim(struct zone *zone, gfp_
>  	struct task_struct *p = current;
>  	struct reclaim_state reclaim_state;
>  	struct scan_control sc;
> +	cpumask_t mask;
>  
>  	if (time_before(jiffies,
>  		zone->last_unsuccessful_zone_reclaim + ZONE_RECLAIM_INTERVAL))
>  			return 0;
>  
>  	if (!(gfp_mask & __GFP_WAIT) ||
> -		(!cpus_empty(node_to_cpumask(zone->zone_pgdat->node_id)) &&
> -			 zone->zone_pgdat->node_id != numa_node_id()) ||
>  		zone->all_unreclaimable ||
>  		atomic_read(&zone->reclaim_in_progress) > 0)
>  			return 0;
>  
> +	mask = node_to_cpumask(zone->zone_pgdat->node_id);
> +	if (!cpus_empty(mask) && zone->zone_pgdat->node_id != numa_node_id())
> +		return 0;
> +
>  	sc.may_writepage = 0;
>  	sc.may_swap = 0;
>  	sc.nr_scanned = 0;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
