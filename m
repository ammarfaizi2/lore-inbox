Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTILIwn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 04:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTILIwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 04:52:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61337 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261297AbTILIwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 04:52:40 -0400
Date: Fri, 12 Sep 2003 14:29:21 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
Message-ID: <20030912085921.GB1128@llm08.in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F60A08A.7040504@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 06:19:22PM +0200, Manfred Spraul wrote:
> ... 
> But there are problems with the current implementation:
> - some drivers/archs are too difficult to fix. James Bottomley asked me 
> to add a switch for archs that cannot transfer to pci_dma completely. 
> Basically guarantee that all cachelines that are touched by an object 
> are exclusive to the object. Left over bytes must not be used, they 
> could be overwritten randomly by the hardware.
> - Russell King onced asked me for the ability for 1024 byte aligned 
> objects. IIRC ARM needs that for it's page tables.
> - If I understand you correctly you want to avoid false sharing of the 
> per-cpu buffers that back alloc_percpu, correct?

Correct.  We were assuming kmalloc always returns cacheline aligned
objects and kinda assumed that cachelines touched by the object
are exclusive to that object.  With SLAB_HWCACHE_ALIGN not being 
always honoured, this assumption turned out to be false.

> I have two concerns:
> - what about users that compile a kernel for a pIII and then run it on a 
> p4? L1_CACHE_BYTES is 32 bytes, but the real cache line size is 128 bytes.

If the target cpu is chosen properly during compile time, L1_CACHE_BYTES
is set accordingly (CONFIG_X86_L1_CACHE_SHIFT on x86) so this should
not be an issue right?
 
> - what about NUMA systems? IMHO the per-cpu buffers should definitively 
> be from the nearest node to the target cpu. Unfortunately slab has no 
> concept of nodes right now. There was a patch, but it's quite intrusive 
> and never fine-tuned. Thus we must either ignore NUMA, or alloc-percpu 
> would have to use it's own allocator. And: Which cacheline size is 
> relevant for NUMA? Is L1==L2==Ln_CACHE_BYTES on all archs?

I am working on a simplistic allocator for alloc_percpu which
1. Minimises cache footprint (simple pointer arithmetic to get to each cpus 
   version
2. Does numa aware allocation
3. Does not fragment
4. Is simple and extends simple pointer arithmetic to get to cpus offsets

I wouldn't be using the slab at all because using slabs would mean using
NR_CPUs pointers and one extra dereference which is bad as we had found out
earlier.  But I guess slab will have to do node local allocations for
other applications.

> 
> IMHO the right solution is
> - remove SLAB_MUST_HWCACHE_ALIGN and SLAB_HWCACHE_ALIGN. The API is 
> broken. Align everything always to L1_CACHE_BYTES.
> - rename the "offset" parameter to "align", and use that to support 
> explicit alignment on a byte boundary. I have a patch somewhere, it's 
> not very large.

You mean color slabs to L1_CACHE_BYTES and align objects to "align" 
parameter? sounds great.  I wonder why that wasn't done in the first
place even Bonwick's paper talks of passing align parameter and calculating
colour offset based on wastage etc.  Maybe calculating colour offset
in terms of slab wastage can reduce fragmentation instead of hard coding
it to L1_CACHE_BYTES (when you think of large cachelines and small objects)?	

> - alloc_percpu should set align to the real cache line size from cpu_data.
> - add a minimal NUMA support: a very inefficient 
> "kmem_cache_alloc_forcpu(cachep, flags, target_cpu)". Not that difficult 
> if I sacrifice performance [no lockless per-cpu buffers, etc.]

As I said, place holder for NR_CPUS will cause performance problems, so
IMHO staying away from slab for alloc_percpu is best.

Thanks,
Kiran

