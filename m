Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVEYSTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVEYSTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVEYSTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:19:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54424 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262320AbVEYSFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:05:07 -0400
Message-ID: <4294BE45.3000502@austin.ibm.com>
Date: Wed, 25 May 2005 13:04:53 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 11
References: <20050522200507.6ED7AECFC@skynet.csn.ul.ie>
In-Reply-To: <20050522200507.6ED7AECFC@skynet.csn.ul.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Changelog since V10
> 
> o Important - All allocation types now use per-cpu caches like the standard
>   allocator. Older versions may have trouble with large numbers of processors

Do you have a new set of benchmarks we could see?  The ones you had for 
v10 were pretty useful.

> o Removed all the additional buddy allocator statistic code

Is there a separate patch for the statistic code or is it no longer 
being maintained?

> +/*
> + * Shared per-cpu lists would cause fragmentation over time
> + * The pcpu_list is to keep kernel and userrclm allocations
> + * apart while still allowing all allocation types to have
> + * per-cpu lists
> + */

Why are kernel nonreclaimable and kernel reclaimable joined here?  I'm 
not saying you are wrong, I'm just ignorant and need some education.

> +struct pcpu_list {
> +	int count;
> +	struct list_head list;
> +} ____cacheline_aligned_in_smp;
> +
>  struct per_cpu_pages {
> -	int count;		/* number of pages in the list */
> +	struct pcpu_list pcpu_list[2]; /* 0: kernel 1: user */
>  	int low;		/* low watermark, refill needed */
>  	int high;		/* high watermark, emptying needed */
>  	int batch;		/* chunk size for buddy add/remove */
> -	struct list_head list;	/* the list of pages */
>  };
>  

Instead of defining 0 and 1 in a comment why not use a #define?

 > +			pcp->pcpu_list[0].count = 0;
 > +			pcp->pcpu_list[1].count = 0;

The #define would make code like this look more readable.

