Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVANJif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVANJif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVANJif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:38:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34702 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261930AbVANJh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:37:58 -0500
Date: Fri, 14 Jan 2005 15:28:27 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-ID: <20050114095827.GA3832@in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com> <1105669487.7311.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105669487.7311.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:24:47PM +1100, Rusty Russell wrote:
> On Thu, 2005-01-13 at 14:04 +0530, Ravikiran G Thirumalai wrote:
> > ...
> > 
> > The following patch re-implements the linux dynamic percpu memory allocator
> > so that:
> > 1. Percpu memory dereference is faster 
> > 	- One less memory reference compared to existing simple alloc_percpu
> > 	- As fast as with static percpu areas, one mem ref less actually.
> 
> Hmm, for me one point of a good dynamic per-cpu implementation is that
> the same per_cpu_offset be used as for the static per-cpu variables.
> This means that architectures can put it in a register.  

The allocator I have posted can be easily fixed for that.  In fact, I had a
version which used per_cpu_offset.  My earlier experiments proved that
pointer arithmetic is  marginally faster than the per_cpu_offset
based version.  Also, why waste a register if we can achieve same dereference
speeds without using a register?  But as I said, we can modify the allocator I
posted to use per_cpu_offset.


> It also has
> different properties than slab, because tiny allocations will be more
> common (ie. one counter).


As regards tiny allocations, many existing users of alloc_percpu are
structures which are aggregations of many counters -- like the mib statistics,
disk_stats etc.  So IMHO, dynamic percpu allocator should work well for
both small and large objects.  I have done some user space measurements
with my version and the allocator behaves well with both small and random sized
objects.

The advantages of my implementation as I see it is:
1. Independent of slab/kmalloc
2. Doesn't need arches to do their own node local allocation -- generic
   version does that.
3. Space efficient -- about 98% utilization achieved in userspace tests
4. Allocates pages for cpu_possible cpus only

disadvantage:
1. Uses vmalloc area and hence additional tlb foot print -- but is there a
   better  way to keep node local allocations, simple pointer arithmetic
   and page allocations for cpu_possible cpus only

Thanks,
Kiran
