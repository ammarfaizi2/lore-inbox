Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWIMXfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWIMXfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWIMXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 19:35:50 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:14046 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1751079AbWIMXft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 19:35:49 -0400
Date: Wed, 13 Sep 2006 16:37:41 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
Message-ID: <20060913233741.GB4359@localhost.localdomain>
References: <20060912144518.GA4653@localhost.localdomain> <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com> <20060912195246.GA4039@localhost.localdomain> <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com> <20060913221435.GA4359@localhost.localdomain> <Pine.LNX.4.64.0609131517370.20316@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609131517370.20316@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 03:28:01PM -0700, Christoph Lameter wrote:
> I wish first of all that the description would accurately describe the 
> problem.

Well, I thought the subject itself described the problem in one line :), I
guess I should be more verbose?  OK.

> 
> On Wed, 13 Sep 2006, Ravikiran G Thirumalai wrote:
> 
> 
> > +/* Allocate object from the array cache of the executing cpu */
> 
> I am not sure what this adds.

Comments :). Well the idea was to describe the difference between 
__cache_alloc and ____cache_alloc, I mean, these are two similar sounding
functions with extra underscores.  OK, maybe I was being too verbose here?

> 
> > +/* 
> > + * Allocate object from the appropriate node as per mempolicy/cpuset
> > + * constraints
> > + */
> 
> We only do this under certain conditions. The main purpose of this 
> function is to allocate an object without having specified a node.

Yes, the conditions being cpuset constraints or a mempolicy being in place.
Again, since objects can be allocated off other nodes under certain
conditions, I thought it was good to document it...

> 
> >  	unsigned long save_flags;
> >  	void *objp;
> > -
> >  	cache_alloc_debugcheck_before(cachep, flags);
> > -
> >  	local_irq_save(save_flags);
> 
> Extra material.

OK

> 
> > +
> > +#ifdef CONFIG_NUMA
> > +	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
> > +		objp = alternate_node_alloc(cachep, flags);
> > +		if (objp != NULL) {
> > +			local_irq_restore(save_flags);
> > +			prefetchw(objp);
> > +			return objp;
> > +		}
> > +	}
> > +#endif
> > +
> 
> Ok.
> 
> > @@ -3303,9 +3309,10 @@ void *kmem_cache_alloc_node(struct kmem_
> >  	cache_alloc_debugcheck_before(cachep, flags);
> >  	local_irq_save(save_flags);
> >  
> > -	if (nodeid == -1 || nodeid == numa_node_id() ||
> > -			!cachep->nodelists[nodeid])
> > +	if (nodeid == numa_node_id())
> >  		ptr = ____cache_alloc(cachep, flags);
> > +	else if (nodeid == -1 || !cachep->nodelists[nodeid])
> > +		ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
> >  	else
> 
> We are still allocating according to policy if nodeid == -1 or if we have 
> an invalid node? I thought we agreed that kmalloc_node should never 
> obey memory policies?
> 
> Simply move the #ifdef CONFIG_NUMA block as we agreed last night. And fix 
> the description to specify under what conditions kmalloc_node will obey 
> memory policies.

This is the case when we are requesting an object from a non existent
node/invalid node.  So we have 2 choices, either to spread the allocations 
as per the cpuset constraints (the same treatment as kmalloc), or to 
allocate from the requesting node, either ways we are not strictly 
confirming to the user's choice of node (which we cannot).  I cannot see 
major advantage or disadvantage either ways, so I chose to keep the policy
in current mainline code -- spread according to the policy set.

