Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUIWJYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUIWJYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUIWJYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:24:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:35259 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268340AbUIWJYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:24:19 -0400
Date: Thu, 23 Sep 2004 11:24:16 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@austin.rr.com>
Cc: Andi Kleen <ak@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH 1/2] mm: page cache mempolicy for page cache allocation
Message-ID: <20040923092416.GC6146@wotan.suse.de>
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net> <20040923043246.2132.91877.24290@raybryhome.rayhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923043246.2132.91877.24290@raybryhome.rayhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* policy selection bits are passed from user shifted left by this amount */
> +#define REQUEST_POLICY_SHIFT	16
> +#define REQUEST_POLICY_PAGE     POLICY_PAGE << REQUEST_POLICY_SHIFT
> +#define REQUEST_POLICY_PAGECACHE POLICY_PAGECACHE << REQUEST_POLICY_SHIFT
> +#define REQUEST_POLICY_MASK     (0x3FFF) << REQUEST_POLICY_SHIFT

Please put brackets around the macros. Putting them around numbers
is not needed though @)


> +#define REQUEST_POLICY_DEFAULT  (0x8000) << REQUEST_POLICY_SHIFT
> +
>  /* Flags for get_mem_policy */
>  #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
>  #define MPOL_F_ADDR	(1<<1)	/* look up vma using address */
> @@ -31,6 +54,8 @@
>  #include <linux/slab.h>
>  #include <linux/rbtree.h>
>  #include <asm/semaphore.h>
> +#include <linux/sched.h>
> +#include <asm/current.h>

Why is that needed? I don't see any users for this.  Please avoid this 
if possible, we already have too much include dependency spagetti.


> --- linux-2.6.9-rc2-mm1.orig/include/linux/sched.h	2004-09-16 12:54:41.000000000 -0700
> +++ linux-2.6.9-rc2-mm1/include/linux/sched.h	2004-09-22 08:48:45.000000000 -0700
> @@ -31,6 +31,8 @@
>  #include <linux/pid.h>
>  #include <linux/percpu.h>
>  
> +#include <linux/mempolicy.h>

I also don't see why this should be needed. Please remove.

> +	for(i=0;i<NR_MEM_POLICIES;i++)

There should be more spaces here (similar in other loops) 


>  	int err, pval;
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
> -	struct mempolicy *pol = current->mempolicy;
> +	struct mempolicy *pol = NULL;
> +	int policy_type, request_policy_default;
>  
>  	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
>  		return -EINVAL;
>  	if (nmask != NULL && maxnode < numnodes)
>  		return -EINVAL;
> +
> +	policy_type = (flags & REQUEST_POLICY_MASK) > REQUEST_POLICY_SHIFT;
> +	request_policy_default = (flags & REQUEST_POLICY_DEFAULT);

Why is that not an MPOL_F_* ? 

>  /* Slow path of a mempolicy copy */
>  struct mempolicy *__mpol_copy(struct mempolicy *old)
> @@ -1093,8 +1146,8 @@ void __init numa_policy_init(void)
>  	/* Set interleaving policy for system init. This way not all
>  	   the data structures allocated at system boot end up in node zero. */
>  
> -	if (sys_set_mempolicy(MPOL_INTERLEAVE, nodes_addr(node_online_map),
> -							MAX_NUMNODES) < 0)
> +	if (sys_set_mempolicy(REQUEST_POLICY_PAGE | MPOL_INTERLEAVE, 
> +		nodes_addr(node_online_map), MAX_NUMNODES) < 0)

That's definitely wrong, the boot time interleaving is not for the page
cache but for all allocations. There are not even page cache allocations
that early.

Overall when I look at all the complications you add for the per process
page policy which doesn't even have a demonstrated need I'm not sure
it is really worth it.

>  		printk("numa_policy_init: interleaving failed\n");
>  }
>  
> @@ -1102,5 +1155,5 @@ void __init numa_policy_init(void)
>   * Assumes fs == KERNEL_DS */
>  void numa_default_policy(void)
>  {
> -	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0);
> +	sys_set_mempolicy(REQUEST_POLICY_PAGE | MPOL_DEFAULT, NULL, 0);

Same.

-Andi
