Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbULTSHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbULTSHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbULTSHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:07:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3545 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261599AbULTSGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:06:13 -0500
Date: Mon, 20 Dec 2004 23:50:57 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
Message-ID: <20041220182057.GA16859@in.ibm.com>
References: <41C35DD6.1050804@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C35DD6.1050804@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 11:29:42PM +0100, Manfred Spraul wrote:
> >
> Probably the right approach. slab should use per-cpu for it's internal 
> head arrays, but I've never converted the slab code due to 
> chicken-and-egg problems and due to the additional pointer dereference.
> 
> >+ * Allocator is slow -- expected to be called during module/subsytem
> >+ * init. alloc_percpu can block.
> > 
> >
> How slow is slow?

Haven't measured it, but the allocator is not designed for speed.
Once the block to be alloced from is identified, the allocator builds 
and sorts a map of objects in ascending order so that we allocate 
from the smallest chunk.  Goal is to enhance memory/cacheline utlization 
and reduce fragmentation rather than speed. It is not expected that
the allocator  will be used from the fastpath.

> I think the block subsystem uses alloc_percpu for some statistics 
> counters, i.e. one alloc during creation of a new disk. The slab 
> implementation was really slow and that caused problems with LVM (or 
> something like that) stress tests.

Hmmm..I knew from some experiments earlier that access to per cpu versions
of memory was slow with the slab based implementation -- which this patch
addresses, but I didn't know allocs themselves were slow...
Creation of a disk should not be a fast path no?
 
> 
> >+	/* Map pages for each cpu by splitting vm_struct for each cpu */
> >+	for (i = 0; i < NR_CPUS; i++) {
> >+		if (cpu_possible(i)) {
> >+			tmppage = &blkp->pages[i*cpu_pages];
> >+			tmp.addr = area->addr + i * PCPU_BLKSIZE;
> >+			/* map_vm_area assumes a guard page of size 
> >PAGE_SIZE */
> >+			tmp.size = PCPU_BLKSIZE + PAGE_SIZE; 
> >+			if (map_vm_area(&tmp, PAGE_KERNEL, &tmppage))
> >+				goto fail_map;
> > 
> >
> That means no large pte entries for the per-cpu allocations, right?
> I think that's a bad idea for non-numa systems. What about a fallback to 
> simple getfreepages() for non-numa systems?

Can we have large pte entries with PAGE_SIZEd pages?  

> >+ * This allocator is slow as we assume allocs to come
> >+ * by during boot/module init.
> >+ * Should not be called from interrupt context 
> > 
> >
> "Must not" - it contains down() and thus can sleep.
> 

:D Yes will replace 'should not' with 'must not' in my next iteration.

Thanks for the comments and feedback.

Kiran
