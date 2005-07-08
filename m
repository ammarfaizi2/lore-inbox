Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVGHX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVGHX3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVGHX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:29:10 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:25481 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261549AbVGHX1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:27:24 -0400
To: Bob Picco <bob.picco@hp.com>
Cc: linux-mm@kvack.org, manfred@colorfullife.com, alex.williamson@hp.com,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Early kmalloc/kfree
References: <20050708203807.GG27544@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Jul 2005 00:35:13 +0200
In-Reply-To: <20050708203807.GG27544@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p73zmsxncym.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco <bob.picco@hp.com> writes:

> We have a requirement on IA64 to run the ACPI interpreter in the setup_arch
> function before paging_init examines the maximum DMA physical address which
> is limited by the IOMMU.  One obstacle is the use of kmalloc/kfree by
> ACPI.  Using the bootmem allocator is unacceptable because > 20Mb of memory
> is wastefully allocated.  As an alternative, I investigated what
> would be required to optionally make the slab allocator available early in
> boot and work in an almost seamless way.
> 
> The patch below is a solution for early kmalloc/kfree.  An architecture which 
> requires kmalloc/kfree use before kmem_cache_init has normally completed can 
> perform the initialization as early as pfn_to_page is a valid operation.  Like 
> the bootmem allocator this point in execution is well known.  An arch that
> requires early kmalloc/kfree chooses the CONFIG_EARLY_KMALLOC option and
> must call kmem_cache_init at the appropriate place in setup_arch.
> 
> The known deficiencies of this solution are similar to the bootmem allocator.
> The placement of the call to kmem_cache_init requires arch dependent code
> knowlege and possibly manipulation of arch dependent code for enablement. 
> kmalloc/kmfree can't be called between when mem_init calls bootmem to free 
> pages and the second call to kmem_cache_init made from start_kernel. A NUMA 
> deficiency, like bootmem allocator, exists for CPU only nodes.  The NUMA node 
> distance information isn't interrogated by bootmem allocator for memory less 
> nodes.
> 
> The slab API hasn't been modified.  All hot code paths are untouched by
> this patch.  The patch has been tested on a 2 CPU SMP box, two node NUMA
> simulated machine with and without memory less nodes. All testing has
> been done on ia64 but nothing prevents other architectures from using the
> patch.
> 
> Manfred provided valuable early review feedback.

I think that is a really really bad idea.   slab is already complex enough
and adding scary hacks like this will probably make it collapse
under its own weight at some point.

And the ACPI interpreter is big enough and has other kernel
interactions that when you start like this you'll probably end with
adding more and more and more such early hacks all over the kernel
longer term. e.g. what happens when the AML creates mutexes and
the interpreter wants to schedule? Or use PCI config space accesses? 
Or something else in the osl layer?  Your early AML might not need
this right now, but longer term someone will write some that 
needs it.

It's better to just not go down that slippery path.

I think you need to solve this in some other way.

-Andi
