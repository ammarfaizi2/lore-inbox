Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTFTSZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTFTSZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:25:48 -0400
Received: from holomorphy.com ([66.224.33.161]:4793 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264126AbTFTSZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:25:42 -0400
Date: Fri, 20 Jun 2003 11:39:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72-wli-1
Message-ID: <20030620183939.GU20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.72/linux-2.5.72-wli-1.bz2

I've decided to outright slurp up various people's code that has uses
in various places for this release, as opposed to pounding out original
material. This went smoothly apart from a minor bug in one of them that
slipped through someone's audit.

This release should feature truly stupendous i386 PAE resource
scalability with respect to task counts. I did a bit of benchmarking
to find some things to do, and observed very little lowmem pressure
with elevated process counts while collecting profiles etc. The
benchmark loads tested were not feasible on mainline.

I'd be much obliged if someone either less terrified of lawyers or
with a benchmark that cares and whose results are easily publicable
could run this through the mill.

Quantitatively, stacks and pagetables on PAE eat a grand total of 4KB
of lowmem per process with all this applied. Not per thread. Per
process. (Unthreaded process, obviously tack threads onto a process and
it's 4KB/thread atop that, since I've not put stacks into highmem yet).
Resource scalability gains are also reaped from dmc+mbligh's objrmap.

Mainline eats 20KB per process and 8KB per additional thread worth of
lowmem for stacks and pagetables. So modulo mm_structs, vma's, filp's,
and other miscellania, this quintuples process capacity. Plus whatever
gains come from objrmap.


Changes since 2.5.71-bk2-wli-1:

+ pgd_ctor fix
	Pointer arithmetic goes wrong unless page_address()'s result is
	casted to pgd_t *. So cast it and fix AGP bad pmd bugs.

+ remap_page_range() vs. highpmd fix
	fix a one-off in remap_page_range() pmd_unmap()'ing things

+ mremap() vs. highpmd fix
	simplify logic and fix brokenness

+ inline vm_account()
	Benchmarks said this was better to inline, despite looking large.

+ inline pte_chain_alloc()
	This didn't require any substantial layering violation, and
	benchmarks said this was good to inline.

+ partially re-inline i386 kmap*() functions
	Between an incidental highpmd bit that called kmap_atomic() for
	all PTE things and the lowmem_page_address() microoptimization,
	it turned out to be better to inline the bits that check for
	lowmem, falling back to highmem helpers as needed.

+ O(1) task_mem()
	It was trivial to extend VM accounting to take care of all the
	stats task_mem() wanted. Also rip out the ->mmap_sem
	acquisitions, since they do no better wrt. producing reliable
	statistics than without and measurable efficiency improvements
	can be gained by sampling the statistics racily (this includes
	pushing taking mm->mmap_sem into task_vsize(), if necessary).
	We're just fishing integers out of the mm_struct here, and no
	longer touching vma's.

+ NR_CPUS -adaptive mapping->page_lock
	This wants to be a spinlock on smaller systems and an rwlock
	on larger systems. #ifdef on NR_CPUS and wrap accesses to
	make this adaptive for NR_CPUS.

+ RCU vfsmount
	Originally by Maneesh Soni and Dipankar Sarma. Minor /proc/
	bugfix brewed up simultaneously by everyone, including myself.
	This is actually a series of 2 patches.

+ irqstacks, 4KB stacks, and mcount-based stack overflow checking
	Originally by Ben LaHaise and Dave Hansen. Slightly debugged.
	This is actually a series of 4 patches.

+ objrmap
	Originally by Dave McCracken and Martin Bligh. Adapted to
	highpmd by yours truly.

+ jack up batchcount
	O(1) buffered_rmqueue() won't burn cpu doing larger batches.
	So let it.

All 25 patches:

O(1) rmqueue_bulk()
	Implement deferred coalescing with lists-of-lists -structured
	order 0 deferred queues so buffered_rmqueue() is O(1) expected time.

lowmem_page_address() microoptimization
	Use page_to_pfn() to inherit its arch-specific microoptimizations.

highpmd
	Shove pmd's into highmem, by brute foce.

Trivial /proc/ BKL removals
	Kill off some blatantly unnecessary BKL grabbing in /proc/

i386 pagetable cache
	Resurrect the i386 pagetable cache, but safely this time.

pgd_ctor
	Use slab ctors for i386 pgd's, and be safe with AGP and highpmd.

O(1) proc_pid_readdir()
	Originally due to Manfred Spraul; figures out its position from
	a small pid hashtable rearrangement.

O(1) proc_pid_statm()
	Originally due to Ben LaHaise; keeps count of the various
	proc_pid_statm() counters whenever twiddling ptes.

pgd_ctor fix
	Pointer arithmetic goes wrong unless page_address()'s result is
	casted to pgd_t *.

remap_page_range() vs. highpmd fix
	make remap_page_range() pmd_unmap() the right thing

mremap() vs. highpmd fix
	simplify logic and fix brokenness

inline vm_account()
	This turned out to be better to inline, despite looking largeish.

inline pte_chain_alloc()
	This didn't require any substantial layering violation, and sped
	things up slightly.

partially re-inline i386 kmap*() functions
	between an incidental highpmd bit that called kmap_atomic() for
	all PTE things and the lowmem_page_address() microoptimization,
	it turned out to be better to inline the bits that check for
	lowmem

O(1) task_mem()
	It was trivial to extend VM accounting to take care of all the
	stats task_mem() wanted. Also rip out some of the ->mmap_sem
	acquisitions, since they do no better wrt. producing reliable
	statistics than without and measurable efficiency improvements
	can be gained by sampling the statistics racily (this includes
	pushing taking mm->mmap_sem into task_vsize(), if necessary).

NR_CPUS -adaptive mapping->page_lock
	This wants to be a spinlock on smaller systems and an rwlock
	on larger systems. #ifdef on NR_CPUS and wrap accesses to
	make this adaptive for NR_CPUS.

RCU vfsmount
	Originally by Maneesh Soni and Dipankar Sarma. Minor /proc/
	bugfix brewed up simultaneously by everyone, including myself.
	This is actually a series of 2.

irqstacks, 4KB stacks, and mcount-based stack overflow checking
	Originally by Ben LaHaise with ongoing maintenance and
	contributions by Dave Hansen. Slightly debugged.
	This is actually a series of 4.

objrmap
	Originally by Dave McCracken and Martin Bligh. Adapted to
	highpmd by yours truly.

jack up batchcount
	O(1) buffered_rmqueue() won't burn cpu doing larger batches.
	So let it.


-- wli
