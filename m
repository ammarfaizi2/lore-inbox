Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWHPHw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWHPHw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWHPHw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:52:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:5799 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750966AbWHPHw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:52:57 -0400
Date: Wed, 16 Aug 2006 09:52:54 +0200
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
Message-Id: <20060816095254.14ac872c.ak@muc.de>
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. A framework for page allocators and slab allocators

Great. 

Hopefully this will combat the recent surge of new custom 
allocators.

Maybe it would be a good idea to first check if Evgeny's tree allocator
is really that much better as he claims and if any ideas from
that one could be incorporated into the new design?

> 2. Various methods to derive new allocators from old ones
>    (add rcu support, destructors, constructors, dma etc)

I'm surprised that you add that many indirect calls when writing
code for IA64. I remember during SLES kernel testing we found that
gcc's generation of indirect calls on IA64/McKinley seemed to be rather poor --
in particular we got a quite measurable slow down just from the indirect calls
that the LSM layer added to many paths. I hope that's ok.

I'm not arguing against doing this way btw, just a remark.

> 	B. The page slab allocator. This is a simple Pagesize based
> 	   allocator that uses the page allocator directly to manage its
> 	   objects. Doing so avoids all the slab overhead for large
> 	   allocations. The page slab can also slabify any other
> 	   page allocator.

What other ones do we have?
 
> 	C. The NUMA Slab. This allocator is based on the slabifier
> 	   and simply creates one Slabifier per node and manages
> 	   those. This allows a clean separation of NUMA.
> 	   The slabifier stays simple and the NUMA slab can deal
> 	   with the allocation complexities. So system
> 	   without NUMA are not affected by the logic that is
> 	   put in.

I hope the NUMA slab will still perfom well even on non NUMA though.
That will be a common situation on x86-64 (kernels compiled with NUMA,
but running on flat Intel systems)

 
> 1. shrink_slab takes a function to move object. Using that
>    function slabs can be defragmented to ease slab reclaim.

Does that help with the inefficient dcache/icache pruning? 

> - No support for pagese

What does that mean?

> Performance tests with AIM7 on an 8p Itanium machine (4 NUMA nodes)
> (Memory spreading active which means that we do not take advantage of NUMA locality
> in favor of load balancing)

Hmm, i'm not sure how allocator intensive AIM7 is. I guess networking
would be a good test because it is very sensitive to allocator performance.
Perhaps also check with the routing people on netdev -- they seem to be able
to stress the allocator very much.
 
-Andi
