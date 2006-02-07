Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWBGRvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWBGRvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWBGRvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:51:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8635 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932387AbWBGRvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:51:08 -0500
Date: Tue, 7 Feb 2006 09:51:04 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <200602071845.19567.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602070947100.24920@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <200602071023.39222.ak@suse.de> <Pine.LNX.4.62.0602070924140.24741@schroedinger.engr.sgi.com>
 <200602071845.19567.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> > Memory policies are rare and this would be insignificant on any NUMA 
> > system
> 
> It could be a problem on those 32bit NUMA systems with only 1GB of lowmem.
> There are some workloads with lots of VMAs and it's in theory possible
> some application wants to set a lot of policy for them.

But this is still only 4 additional bytes per policy on 32bit NUMA.

> I back then spent some time to make the data structure as small as possible
> and I would hate to destroy it with such thoughtless changes.

Well the ability to set bits for policy controlled allocations may come in 
handy if we want to support memory policy controlling some other aspect 
for page allocation.

> when MPOL_BIND == node_online_map automatically revert to MPOL_PREFERED with empty mask.
> Then on the allocation only set the gfp flag for MPOL_BIND

That would work for MPOL_BIND. How about MPOL_INTERLEAVE with a restricted 
set of nodes? cpusets may cause any policy to have a restricted nodeset.

> > Should the system swap if an MPOL_BIND request does not find enough 
> > memory? Maybe it would be good to not swap, rely on zone_reclaim only and 
> > fail if there is no local memory? 
> 
> Not sure. I guess it depends. Maybe it needs a nodeswappiness sysctl.

Hmm.... Maybe make this a separate post?

> > We could change __GFP_NO_OOM_KILLER to __GFP_CONSTRAINED_ALLOC and then 
> > not invoke kswapd and neither the OOM killer on a constrained allocation.
> 
> That could be a problem if one node is filled with dirty file cache pages,
> no? There needs to be some action to free it. I had a few reports of this case.
> It needs to make at least some effort to wait for these pages and push them out.

zone_reclaim can be configured to write out dirty file cache pages during 
reclaim. So this could be addressed.

> On the other hand I would like to have less swapping for MPOL_BIND by 
> default than the global VM does. I remember
> driving the system in quite severe swap storms when doing early mempolicy
> testing. 

Hmmm.. We could now add some other control bits to the mempolicy gfp 
mask to affect the behavior of the page allocator.

