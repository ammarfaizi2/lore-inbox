Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVBBM3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVBBM3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVBBM3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:29:18 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:37076 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262553AbVBBM3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:29:05 -0500
Date: Wed, 02 Feb 2005 21:21:52 +0900 (JST)
Message-Id: <20050202.212152.27799149.taka@valinux.co.jp>
To: clameter@sgi.com
Cc: kenneth.w.chen@intel.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [3/8]: simple numa compatible
 allocator
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.58.0410251828060.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0410251828060.12962@schroedinger.engr.sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,


> Changelog
> 	* Simple NUMA compatible allocation of hugepages in the nearest node
> 
> Index: linux-2.6.9/mm/hugetlb.c
> ===================================================================
> --- linux-2.6.9.orig/mm/hugetlb.c	2004-10-22 13:28:27.000000000 -0700
> +++ linux-2.6.9/mm/hugetlb.c	2004-10-25 16:56:22.000000000 -0700
> @@ -32,14 +32,17 @@
>  {
>  	int nid = numa_node_id();
>  	struct page *page = NULL;
> -
> -	if (list_empty(&hugepage_freelists[nid])) {
> -		for (nid = 0; nid < MAX_NUMNODES; ++nid)
> -			if (!list_empty(&hugepage_freelists[nid]))
> -				break;
> +	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;


I think the previous line should be replaced with

struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists + __GFP_HIGHMEM;

because NODE_DATA(nid)->node_zonelists means a zonelist for __GFP_DMA zones.
__GFP_HIGHMEM would be suitable for hugetlbpages.


> +	struct zone **zones = zonelist->zones;
> +	struct zone *z;
> +	int i;
> +
> +	for(i=0; (z = zones[i])!= NULL; i++) {
> +		nid = z->zone_pgdat->node_id;
> +		if (!list_empty(&hugepage_freelists[nid]))
> +			break;
>  	}
> -	if (nid >= 0 && nid < MAX_NUMNODES &&
> -	    !list_empty(&hugepage_freelists[nid])) {
> +	if (z) {
>  		page = list_entry(hugepage_freelists[nid].next,
>  				  struct page, lru);
>  		list_del(&page->lru);
> 
> -

Thanks,
Hirokazu Takahashi.
