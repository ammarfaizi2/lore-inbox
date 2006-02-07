Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWBGR3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWBGR3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWBGR3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:29:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64136 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750855AbWBGR3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:29:06 -0500
Date: Tue, 7 Feb 2006 09:29:01 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <200602071023.39222.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602070924140.24741@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <20060206145922.3eb3c404.pj@sgi.com> <Pine.LNX.4.62.0602061745480.20189@schroedinger.engr.sgi.com>
 <200602071023.39222.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> On Tuesday 07 February 2006 02:55, Christoph Lameter wrote:
> > I just tried to oom a process that has restricted its mem allocation to 
> > node 0 using a memory policy. Instead of an OOM the system began to swap 
> > on node zero. The swapping is restricted to the zones passed to 
> > __alloc_pages. It was thus swapping node zero alone.
> 
> Thanks for doing that work. It's needed imho and was on my todo list.

This is talking not about the text above but about what comes later right? 
The OOM behavior for a constrained allocation with no swap?

> > +	gfp_t gfp_flags;	/* flags ORed into gfp_flags for each allocation */
> 
> I don't think it's a good idea to add it to the struct mempolicy. I've tried to
> make it as memory efficient as possibile and it would be a waste to add such
> a mostly unused field. Better to pass that information around in some other way.

Memory policies are rare and this would be insignificant on any NUMA 
system. 

> (in the worst case it could be a upper bit in policy, but I would prefer
> function arguments I think) 

An upper bit in policy would require special processing in hot code paths. 
The current implementation can simply OR in a value that is in a cacheline 
already in the data cache.

I'd rather keep it separate.

Function arguments? Add function pointer to mempolicy for allocation?

Then there is the other issue:

Should the system swap if an MPOL_BIND request does not find enough 
memory? Maybe it would be good to not swap, rely on zone_reclaim only and 
fail if there is no local memory? 

We could change __GFP_NO_OOM_KILLER to __GFP_CONSTRAINED_ALLOC and then 
not invoke kswapd and neither the OOM killer on a constrained allocation.

