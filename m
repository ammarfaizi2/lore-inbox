Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVC0JQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVC0JQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 04:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVC0JQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 04:16:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40852 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261493AbVC0JQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 04:16:15 -0500
Date: Sun, 27 Mar 2005 01:14:43 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: torvalds@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1] cpusets special case GFP_ATOMIC allocs
Message-Id: <20050327011443.68605853.pj@engr.sgi.com>
In-Reply-To: <424659D9.9000705@yahoo.com.au>
References: <20050327065222.25762.37675.sendpatchset@sam.engr.sgi.com>
	<424659D9.9000705@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Kernel should not panic if a GFP_ATOMIC allocation fails.
> Where is this happening?

I didn't actually see any such panics occur.  This patch came from
reading code, not any actual crash seen so far.  The closest thing to a
real world event that I saw was a network connection that got dropped
once, on a system we had under severe memory distress, and _if_ the
allocating task had been in a cpuset (which it wasn't, in this instance)
it would likely have dropped the connection even sooner, on a failed
GFP_ATOMIC.

But in any case, since there were other special cases in __alloc_pages()
for ATOMIC (!wait or can_try_harder) requests, it seemed like an
unsurprising tradeoff to special case this one too.

Even if the following apparent panics for a failed ATOMIC allocation are
not relevant (perhaps they are all init routines, and so don't apply to
a normally running system), it seemed to me that the kernel would be
under increased stress and start dropping things, such as the network
connection I saw dropped, if ATOMIC's failed.  I did not want some
ordinary user task, in their own small cpuset, to be able to damage the
kernel behaviour for the rest of the system, at least not that easily.

At least for our (SGI) users, cpusets are of greatest interest for page
allocations backing user address space, and they expect that the kernel
will do whatever it needs to do, in order to stay healthy, including
taking some (so long as its not too much) memory off each node in the
system.  My understanding was that GFP_ATOMIC allocations were more or
less always done for pages backing kernel address space, so letting them
steal from outside the cpuset under memory stress seems fine by me.

====

The following places were found, simply grep'ing for failed GFP_ATOMIC
allocation requests followed by a panic:

==

arch/ppc64/kernel/eeh.c:        event = kmalloc(sizeof(*event), GFP_ATOMIC);
arch/ppc64/kernel/eeh.c-        if (event == NULL) {
arch/ppc64/kernel/eeh.c-                eeh_panic(dev, reset_state);

==

arch/ppc64/kernel/iommu.c:      tbl->it_map = (unsigned long *)__get_free_pages(GFP_ATOMIC, get_order(sz));
arch/ppc64/kernel/iommu.c-      if (!tbl->it_map)
arch/ppc64/kernel/iommu.c-              panic("iommu_init_table: Can't allocate %ld bytes\n",sz);

==

arch/ppc64/mm/init.c:           kcore_mem = kmalloc(sizeof(struct kcore_list), GFP_ATOMIC);
arch/ppc64/mm/init.c-           if (!kcore_mem)
arch/ppc64/mm/init.c-                   panic("mem_init: kmalloc failed\n");

==

arch/sparc64/kernel/ebus.c:     mem = kmalloc(size, GFP_ATOMIC);
arch/sparc64/kernel/ebus.c-     if (!mem)
arch/sparc64/kernel/ebus.c-             panic("ebus_alloc: out of memory");

==

arch/v850/kernel/rte_mb_a_pci.c:                block = kmalloc (block_size, GFP_ATOMIC);
arch/v850/kernel/rte_mb_a_pci.c-                if (! block)
arch/v850/kernel/rte_mb_a_pci.c-                        panic ("free_mb_sram: can't allocate free-list entry");

==

arch/x86_64/kernel/setup64.c-           pda->irqstackptr = (char *)
arch/x86_64/kernel/setup64.c:                   __get_free_pages(GFP_ATOMIC, IRQSTACK_ORDER);
arch/x86_64/kernel/setup64.c-           if (!pda->irqstackptr)
arch/x86_64/kernel/setup64.c-                   panic("cannot allocate irqstack for cpu %d", cpu);

==

drivers/nubus/nubus.c-  /* Actually we should probably panic if this fails */
drivers/nubus/nubus.c:  if ((dev = kmalloc(sizeof(*dev), GFP_ATOMIC)) == NULL)
drivers/nubus/nubus.c-          return NULL;

==

fs/dquot.c:     dquot_hash = (struct hlist_head *)__get_free_pages(GFP_ATOMIC, order);
fs/dquot.c-     if (!dquot_hash)
fs/dquot.c-             panic("Cannot create dquot hash table");

==

sound/core/init.c:              s_f_ops = kmalloc(sizeof(struct snd_shutdown_f_ops), GFP_ATOMIC);
sound/core/init.c-              if (s_f_ops == NULL)
sound/core/init.c-                      panic("Atomic allocation failed for snd_shutdown_f_ops!");


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
