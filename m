Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTINHgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 03:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTINHgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 03:36:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61640 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262323AbTINHgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 03:36:20 -0400
Date: Sun, 14 Sep 2003 13:39:42 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
Message-ID: <20030914080942.GA9302@in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com> <20030912085921.GB1128@llm08.in.ibm.com> <3F6378B0.8040606@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6378B0.8040606@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 10:06:08PM +0200, Manfred Spraul wrote:
> Ravikiran G Thirumalai wrote:
> > ... 
> >
> Interesting. Slab internally uses lots of large per-cpu arrays. 
> Alltogether something like around 40 kB/cpu. Right now implemented with 
> NR_CPUs pointers. In the long run I'll try to switch to your allocator.
> 
> But back to the patch that started this thread: Do you still need the 
> ability to set an explicit alignment for slab allocations? If yes, then 
> I'd polish my patch, double check all kmem_cache_create callers and then 
> send the patch to akpm. 

No, even the arbitrary aligned patch might not fix the current brokenness
of alloc_percpu, because then we would have to change kmalloc caches
(malloc_sizes[]) to explicity align objects on cacheline boundaries
even for small objects.  And that would be a major change at this stage.
Having different alloc_percpu caches for differnt objects is probably not
such a good thing right now -- this is if we tolerate the extra dereference.
So. IMO, going ahead with a new allocator is a good choice for alloc_percpu.

> Otherwise I'd wait - the patch is not a bugfix.

That said, the reason I see arbitray align patch for 2.6 is:

1. SLAB_MUST_HWCACHELINE_ALIGN is broken.  If I understand the code right,
   it will result in BYTES_PER_WORD alignment.  This means there can be false
   sharing between two task_structs depending on the slab calculations
   and there is an atomic_t at the beginning of the task_struct.
   This has to be fixed.
2. The fix should not change the way kmalloc caches currently work, i.e
   by sharing cachelines for small objects.  Later benchmarks might 
   prove that it might not be good to share cachelines for kmalloc, but 
   for now we don't know.
3. IMHO its not right that SLAB_HWCACHE_ALIGN is taken as a hint and not
   as a directive.  It is misleading.  I don't like the fact that the
   allocator can reduce the alignment. IMHO, alignment decisions should be left
   to the user.  
4. There are already requirements from users for arbitrary alignment as you'd
   mentioned in earlier mails in this thread. I guess such requirements will
   go up as 2.6 matures, so it is a good idea to provide alignment upto 
   PAGE alignment.

The patch I posted earlier takes care of 1 & 2, but arbitraty alignment takes
care of all 4, and as you mentioned the patch is small enough.  If interface
change is a concern for 2.6, then IMHO the interface is broken anyways...who
uses offset parameter to specify coloring offsets????  IMHO, Slab 
offset colour should be slab calculation based and if needed arch based.
added to that SLAB_HWCACHE_ALIGN name itself is broken anyways.   Clearly
we should not wait for 2.7 for these fixes, if so now is the good time
right?  This is just my opinion.  It is left to akpm and you to decide....


Thanks,
Kiran
