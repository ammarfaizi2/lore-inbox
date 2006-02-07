Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWBGRpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWBGRpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWBGRpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:45:42 -0500
Received: from ns1.suse.de ([195.135.220.2]:25783 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932263AbWBGRpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:45:41 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: OOM behavior in constrained memory situations
Date: Tue, 7 Feb 2006 18:45:19 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <200602071023.39222.ak@suse.de> <Pine.LNX.4.62.0602070924140.24741@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070924140.24741@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071845.19567.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 18:29, Christoph Lameter wrote:
> On Tue, 7 Feb 2006, Andi Kleen wrote:
> 
> > On Tuesday 07 February 2006 02:55, Christoph Lameter wrote:
> > > I just tried to oom a process that has restricted its mem allocation to 
> > > node 0 using a memory policy. Instead of an OOM the system began to swap 
> > > on node zero. The swapping is restricted to the zones passed to 
> > > __alloc_pages. It was thus swapping node zero alone.
> > 
> > Thanks for doing that work. It's needed imho and was on my todo list.
> 
> This is talking not about the text above but about what comes later right? 
> The OOM behavior for a constrained allocation with no swap?
> 
> > > +	gfp_t gfp_flags;	/* flags ORed into gfp_flags for each allocation */
> > 
> > I don't think it's a good idea to add it to the struct mempolicy. I've tried to
> > make it as memory efficient as possibile and it would be a waste to add such
> > a mostly unused field. Better to pass that information around in some other way.
> 
> Memory policies are rare and this would be insignificant on any NUMA 
> system

It could be a problem on those 32bit NUMA systems with only 1GB of lowmem.
There are some workloads with lots of VMAs and it's in theory possible
some application wants to set a lot of policy for them.

I back then spent some time to make the data structure as small as possible
and I would hate to destroy it with such thoughtless changes.


> 
> > (in the worst case it could be a upper bit in policy, but I would prefer
> > function arguments I think) 
> 
> An upper bit in policy would require special processing in hot code paths. 
> The current implementation can simply OR in a value that is in a cacheline 
> already in the data cache.
> 
> I'd rather keep it separate.
> 
> Function arguments? Add function pointer to mempolicy for allocation?

I was more thinking: 

when MPOL_BIND == node_online_map automatically revert to MPOL_PREFERED with empty mask.
Then on the allocation only set the gfp flag for MPOL_BIND

Ok there might be small trouble with node hotplug, but that could be probably
ignored for now.

> Then there is the other issue:
> 
> Should the system swap if an MPOL_BIND request does not find enough 
> memory? Maybe it would be good to not swap, rely on zone_reclaim only and 
> fail if there is no local memory? 

Not sure. I guess it depends. Maybe it needs a nodeswappiness sysctl.

> 
> We could change __GFP_NO_OOM_KILLER to __GFP_CONSTRAINED_ALLOC and then 
> not invoke kswapd and neither the OOM killer on a constrained allocation.

That could be a problem if one node is filled with dirty file cache pages,
no? There needs to be some action to free it. I had a few reports of this case.
It needs to make at least some effort to wait for these pages and push them out.

On the other hand I would like to have less swapping for MPOL_BIND by 
default than the global VM does. I remember
driving the system in quite severe swap storms when doing early mempolicy
testing. 

-Andi
