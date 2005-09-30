Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVI3SqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVI3SqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVI3SqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:46:18 -0400
Received: from hera.kernel.org ([140.211.167.34]:38864 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965062AbVI3SqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:46:17 -0400
Date: Fri, 30 Sep 2005 15:44:04 -0300
From: Marcelo <marcelo.tosatti@cyclades.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [PATCH 3/7] CART - an advanced page replacement policy
Message-ID: <20050930184404.GA16812@xeon.cnet>
References: <20050929180845.910895444@twins> <20050929181622.780879649@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929181622.780879649@twins>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,

On Thu, Sep 29, 2005 at 08:08:48PM +0200, Peter Zijlstra wrote:
> The flesh of the CART implementation. Again comments in the file should be
> clear.

Having per-zone "B1" target accounted at fault-time instead of a global target
strikes me.

The ARC algorithm adjusts the B1 target based on the fact that being-faulted-pages
were removed from the same memory region where such pages will reside.

The per-zone "B1" target as you implement it means that the B1 target accounting
happens for the zone in which the page for the faulting data has been allocated,
_not_ on the zone from which the data has been evicted. Seems quite unfair.

So for example, if a page gets removed from the HighMem zone while in the 
B1 list, and the same data gets faulted in later on a page from the normal
zone, Normal will have its "B1" target erroneously increased.

A global inactive target scaled to the zone size would get rid of that problem.

Another issue is testing: You had some very interesting numbers before, 
how are things now?

> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
>  mm/cart.c                  |  631 +++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 682 insertions(+), 35 deletions(-)
> 
> Index: linux-2.6-git/mm/cart.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6-git/mm/cart.c
> @@ -0,0 +1,639 @@

<snip>

> +#define cart_cT ((zone)->nr_active + (zone)->nr_inactive + (zone)->free_pages)
> +#define cart_cB ((zone)->present_pages)
> +
> +#define T2B(x) (((x) * cart_cB) / cart_cT)
> +#define B2T(x) (((x) * cart_cT) / cart_cB)
> +
> +#define size_T1 ((zone)->nr_active)
> +#define size_T2 ((zone)->nr_inactive)
> +
> +#define list_T1 (&(zone)->active_list)
> +#define list_T2 (&(zone)->inactive_list)
> +
> +#define cart_p ((zone)->nr_p)
> +#define cart_q ((zone)->nr_q)
> +
> +#define size_B1 ((zone)->nr_evicted_active)
> +#define size_B2 ((zone)->nr_evicted_inactive)
> +
> +#define nr_Ns ((zone)->nr_shortterm)
> +#define nr_Nl (size_T1 + size_T2 - nr_Ns)

These defines are not not easy to read inside the code which
uses them, I personally think that "zone->nr_.." explicitly is 
much clearer.
