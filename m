Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268348AbUIWJdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268348AbUIWJdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUIWJdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:33:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:38850 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268348AbUIWJdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:33:42 -0400
Date: Thu, 23 Sep 2004 11:29:54 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@austin.rr.com>
Cc: Andi Kleen <ak@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ray Bryant <raybry@sgi.com>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 2/2] mm: eliminate node 0 bias in MPOL_INTERLEAVE
Message-ID: <20040923092954.GA4836@wotan.suse.de>
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net> <20040923043256.2132.93167.33080@raybryhome.rayhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923043256.2132.93167.33080@raybryhome.rayhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 11:32:45PM -0500, Ray Bryant wrote:
> Each of these cases potentially breaks the (assumed) invariant of

I would prefer to keep the invariant.

> +++ linux-2.6.9-rc2-mm1/mm/mempolicy.c	2004-09-21 17:44:58.000000000 -0700
> @@ -435,7 +435,7 @@ asmlinkage long sys_set_mempolicy(int re
>  		default_policy[policy] = new;
>  	}
>  	if (new && new->policy == MPOL_INTERLEAVE)
> -		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
> +		current->il_next = current->pid % MAX_NUMNODES;

Please do the find_next/find_first bit here in the slow path. 

Another useful change may be to check if il_next points to a node
that is in the current interleaving mask. If yes don't change it.
This way skew when interleaving policy is set often could be avoided.

>  	return 0;
>  }
>  
> @@ -714,6 +714,11 @@ static unsigned interleave_nodes(struct 
>  
>  	nid = me->il_next;
>  	BUG_ON(nid >= MAX_NUMNODES);
> +	if (!test_bit(nid, policy->v.nodes)) {
> +		nid = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
> +		if (nid >= MAX_NUMNODES)
> +			nid = find_first_bit(policy->v.nodes, MAX_NUMNODES);
> +	}

And remove it here.

>  	next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
>  	if (next >= MAX_NUMNODES)
>  		next = find_first_bit(policy->v.nodes, MAX_NUMNODES);
> Index: linux-2.6.9-rc2-mm1/kernel/fork.c
> ===================================================================
> --- linux-2.6.9-rc2-mm1.orig/kernel/fork.c	2004-09-21 16:24:49.000000000 -0700
> +++ linux-2.6.9-rc2-mm1/kernel/fork.c	2004-09-21 17:41:12.000000000 -0700
> @@ -873,6 +873,8 @@ static task_t *copy_process(unsigned lon
>  			goto bad_fork_cleanup;
>  		}
>  	}
> +	/* randomize placement of first page across nodes */
> +	p->il_next = p->pid % MAX_NUMNODES;

Same here.

-Andi
