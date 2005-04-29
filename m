Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVD2T7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVD2T7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVD2T7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:59:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17637 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262920AbVD2T7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:59:06 -0400
Date: Fri, 29 Apr 2005 12:59:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/3] Page Fault Scalability V20: Overview
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the scalability issues that arise in Linux if
more than 4 processors generate page faults to populate memory
simultaneously. One example where this occurs is during the startup
phase of large scale applications. These typically start by forking
multiple threads that then concurrently initialize memory in order
to reduce the time needed. However, concurrent memory initialization
does only work as expected for Linux if more than 4 threads are
started. For more than 8 processors the performance begins to drop
until we reach single thread performance at 16-32 cpus. Performance
drops exponentially for configurations of higher cpu counts.

Without this patch these application may seem to freeze for long times
due to contention around the page_table_lock. These modifications
allow the page fault handler for anonymous faults scale linearly
(verified for up to 64 cpus).

Changelog:

V19->V20
 - Adapted to use set_pte_at and conform to the other pte api changes.
   This also required a change to pte_cmpxchg and pte_xchg.
 - Use atomic64_t if available for counters to allow more than 8TB memory.
 - Enable ATOMIC_TABLE_OPS via Kconfig for SMP configurations with
   suitable processors under IA32, X86_64 and IA64.
 - Drop rss patch which was already accepted.

Charts with performance data and a short description is available at
http://oss.sgi.com/projects/page_fault_performance/atomic-ptes.pdf

The basic approach in this patch set is the same as used in SGI's 2.4.X
based kernels which have been in production use by SGI in ProPack 3
for a long time. More information may be found at
http://oss.sgi.com/projects/page_fault_performance .

The patch set is currently composed of 3 patches:

1/3: Avoid spurious page faults

	ptes are currently sporadically set to zero for synchronization
	with the MMU which may cause spurious page faults. This patch
	uses ptep_xchg and ptep_cmpxchg to avoid clearing ptes and
	therefore also spurious page faults.

	The patch introduces CONFIG_ATOMIC_TABLE_OPS that is enabled
	if the hardware is able to support atomic operations and if
	a SMP kernel is being configured. A Kconfig update for i386,
	x86_64 and ia64 has been provided. On i386 this options is
	restricted to CPUs better than a 486 and non PAE mode (that
	way all the cmpxchg issues on old i386 CPUS and the problems
	with 64bit atomic operations on recent i386 CPUS are avoided).

	If CONFIG_ATOMIC_TABLE_OPS is not set then ptep_xchg and
	ptep_xcmpxchg are realized by falling back to clearing a pte
	before updating it.

	The patch does not change the use of mm->page_table_lock and
	the only performance improvement is the replacement of
	xchg-with-zero-and-then-write-new-pte-value with an xchg with
	the new value for SMP on some architectures if
	CONFIG_ATOMIC_TABLE_OPS is configured. It should not do anything
	major to VM operations.

2/3: Drop the first use of the page_table_lock in handle_mm_fault

	The patch introduces two new functions:

	page_table_atomic_start(mm), page_table_atomic_stop(mm)

	that fall back to the use of the page_table_lock if
	CONFIG_ATOMIC_TABLE_OPS is not defined.

	If CONFIG_ATOMIC_TABLE_OPS is defined those functions may
	be used to prep the CPU for atomic table ops (i386 in PAE mode
	may f.e. get the MMX register ready for 64bit atomic ops) but
	these are currently empty by default.

	Two operations may then be performed on the page table without
	acquiring the page table lock:

	a) updating access bits in pte
	b) anonymous read faults installed a mapping to the zero page.

	All counters are still protected with the page_table_lock thus
	avoiding any issues there.

	Some additional statistics are added to /proc/meminfo to
	give some statistics. This includes counting spurious faults
	with no effect.

3/3: Drop the use of the page_table_lock in do_anonymous_page

	The second acquisition of the page_table_lock is removed
	from do_anonymous_page and allows the anonymous
	write fault to be possible without the page_table_lock.

	The macros for manipulating rss and anon_rss in include/linux/sched.h
	are changed if CONFIG_ATOMIC_TABLE_OPS is set to use atomic
	operations for rss and anon_rss (safest solution for now, other
	solutions may easily be implemented by changing those macros).
	A 64 bit atomic type will be used if available.

	This patch typically yield significant increases in page fault
	performance for threaded applications on SMP systems. A nice
	color chart can be see at
	http://oss.sgi.com/projects/page_fault_performance/atomic-ptes.pdf


