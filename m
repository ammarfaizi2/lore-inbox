Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbTIKQTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbTIKQTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:19:54 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:40082 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261361AbTIKQTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:19:50 -0400
Message-ID: <3F60A08A.7040504@colorfullife.com>
Date: Thu, 11 Sep 2003 18:19:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com>
In-Reply-To: <20030911110853.GB3700@llm08.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:

>Hi Andrew, Manfred
>Looks like SLAB_HWCACHE_ALIGN does not guarantee cacheline alignment
>and SLAB_MUST_HWCACHE_ALIGN is not at all recognised by the slab code.
>(Right now, SLAB_MUST_HWCACHE_ALIGN caches are aligned to sizeof (void *)!!)
>  
>
Correct.
SLAB_HWCACHE_ALIGN is a hint, which is always honoured except with 
debugging turned on. Which debugging of, it's equivalent to 
MUST_HWCACHE_ALIGN. The reason why debugging turns it of is to break 
drivers that use kmalloc+virt_to_phys instead of pci_pool. IMHO that's a 
good cause, thus I would like to leave that unchanged.

SLAB_MUST_HWCACHE_ALIGN guarantees alignment to the smaller of the L1 
cache line size and the object size. I was added for PAE support: the 
3rd level page tables must be 32-byte aligned. It's only intended for 
the PAE buffers. Noone else is supposed to use that, i.e. the right 
change for the pte cache and the task cache is s/_MUST_//.

But there are problems with the current implementation:
- some drivers/archs are too difficult to fix. James Bottomley asked me 
to add a switch for archs that cannot transfer to pci_dma completely. 
Basically guarantee that all cachelines that are touched by an object 
are exclusive to the object. Left over bytes must not be used, they 
could be overwritten randomly by the hardware.
- Russell King onced asked me for the ability for 1024 byte aligned 
objects. IIRC ARM needs that for it's page tables.
- If I understand you correctly you want to avoid false sharing of the 
per-cpu buffers that back alloc_percpu, correct?
I have two concerns:
- what about users that compile a kernel for a pIII and then run it on a 
p4? L1_CACHE_BYTES is 32 bytes, but the real cache line size is 128 bytes.
- what about NUMA systems? IMHO the per-cpu buffers should definitively 
be from the nearest node to the target cpu. Unfortunately slab has no 
concept of nodes right now. There was a patch, but it's quite intrusive 
and never fine-tuned. Thus we must either ignore NUMA, or alloc-percpu 
would have to use it's own allocator. And: Which cacheline size is 
relevant for NUMA? Is L1==L2==Ln_CACHE_BYTES on all archs?

IMHO the right solution is
- remove SLAB_MUST_HWCACHE_ALIGN and SLAB_HWCACHE_ALIGN. The API is 
broken. Align everything always to L1_CACHE_BYTES.
- rename the "offset" parameter to "align", and use that to support 
explicit alignment on a byte boundary. I have a patch somewhere, it's 
not very large.
- alloc_percpu should set align to the real cache line size from cpu_data.
- add a minimal NUMA support: a very inefficient 
"kmem_cache_alloc_forcpu(cachep, flags, target_cpu)". Not that difficult 
if I sacrifice performance [no lockless per-cpu buffers, etc.]

What do you think? Possible now, or too intrusive before 2.6.0? The 
align patch is not much larger than the patch Ravikiran attached. The 
minimal numa patch wouldn't contain any core changes either.

--
    Manfred

