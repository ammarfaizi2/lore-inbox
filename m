Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUHMANo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUHMANo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268905AbUHMANo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:13:44 -0400
Received: from holomorphy.com ([207.189.100.168]:20879 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268904AbUHMANk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:13:40 -0400
Date: Thu, 12 Aug 2004 17:13:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <20040813001331.GR11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, steiner@sgi.com
References: <200408121646.50740.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408121646.50740.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 04:46:50PM -0700, Jesse Barnes wrote:
> +struct page *alloc_page_round_robin(unsigned int gfp_mask)
> +{
> +	return alloc_pages_node(__get_cpu_var(next_rr_node)++ % numnodes,
> +				gfp_mask, 0);
> +}
> +

Interesting. This may attempt to allocate from offlined nodes, assuming
one adds on sufficient hotplug bits atop mainline and/or -mm. The
following almost does it hotplug-safe except that it needs to enter the
allocator with preemption disabled and drop the preempt_count
internally to it.

static struct page *alloc_page_round_robin(unsigned gfp_mask)
{
	int nid, next_nid, *rr_node = &__get_cpu_var(next_rr_node);

	nid = *rr_node;
	next_nid = next_node(nid, node_online_map);
	if (next_nid >= MAX_NR_NODES)
		*rr_node = first_node(node_online_map);
	else
		*rr_node = next_nid;
	return alloc_pages_node(nid, gfp_mask, 0);
}

I suspect we are better off punting this in the direction of hotplug
people than trying to address it ourselves. I think we should go with
this now, as the node hotplug bits are yet to hit the tree.


-- wli
