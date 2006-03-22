Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWCVSGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWCVSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWCVSGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:06:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38084 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932251AbWCVSGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:06:15 -0500
Date: Wed, 22 Mar 2006 10:05:56 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, haveblue@us.ibm.com, mingo@elte.hu,
       clameter@sgi.com
Subject: Re: [PATCH] Cpuset: alloc_pages_node overrides cpuset constraints
Message-Id: <20060322100556.8e2010a6.pj@sgi.com>
In-Reply-To: <200603221733.51726.ak@suse.de>
References: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
	<200603221733.51726.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Faster would be if (gfp_mask & (__GFP_NOCPUSET|__GFP_HARDWALL)) { /* sort them out */ } 

Yup - good point.  However ...

Note that I am already off the fast path here, having peeled off the
interrupt and node inside cpuset cases above.  After these checks for
__GFP_NOCPUSET or __GFP_HARDWALL, only the rare case of having to
look outside a cpuset with no free memory for essential kernel memory
remains.

Look at this entire routine:

int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
{
        int node;                       /* node that zone z is on */
        const struct cpuset *cs;        /* current cpuset ancestors */
        int allowed;	                /* is allocation in zone z allowed? */

        if (in_interrupt())
                return 1;
        node = z->zone_pgdat->node_id;
        if (node_isset(node, current->mems_allowed))
                return 1;
        if (gfp_mask & __GFP_NOCPUSET)
                return 1;
        if (gfp_mask & __GFP_HARDWALL)  /* If hardwall request, stop here */
                return 0;

        if (current->flags & PF_EXITING) /* Let dying task have memory */
                return 1;

        /* Not hardwall and node outside mems_allowed: scan up cpusets */
        mutex_lock(&callback_mutex);

        task_lock(current);
        cs = nearest_exclusive_ancestor(current->cpuset);
        task_unlock(current);

        allowed = node_isset(node, cs->mems_allowed);
        mutex_unlock(&callback_mutex);
        return allowed;
}

Notice that if neither of the __GFP_NOCPUSET or __GFP_HARDWALL flag
tests fire, then the code hits a mutex, spinlock and subroutine call.

Also notice that the __GFP_NOCPUSET case is the most important case of
those at or below that check.  Any alloc_pages_node, zmalloc_node or
kmalloc_node call that requires a node outside the cpuset hits that
case.  Only tasks that have used up all the available memory in their
cpuset commonly get past here, to the __GFP_HARDWALL case, which is not
a case worth optimizing at the expense of more important code paths.

So ... actually ... I suspect that doing:

        if (gfp_mask & __GFP_NOCPUSET)
                return 1;
        if (gfp_mask & __GFP_HARDWALL)
                return 0;

is faster than doing:

	if (gfp_mask & (__GFP_NOCPUSET|__GFP_HARDWALL)) {
		if (gfp_mask & __GFP_NOCPUSET)
			return 1;
		if (gfp_mask & __GFP_HARDWALL)
			return 0;
	}

because the first of these two gets to the relatively more important
case of __GFP_NOCPUSET faster.

Too bad the patch didn't show a little more context.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
