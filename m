Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVCBDtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVCBDtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 22:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCBDtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 22:49:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62925 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262156AbVCBDtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 22:49:03 -0500
Date: Tue, 1 Mar 2005 19:49:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Page fault scalability patch V18: Overview
Message-ID: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any chance that this patchset could go into mm now? This has been
discussed since last August....

Changelog:

V17->V18 Rediff against 2.6.11-rc5-bk4
V16->V17 Do not increment page_count in do_wp_page. Performance data
	posted.
V15->V16 of this patch: Redesign to allow full backback
	for architectures that do not supporting atomic operations.

An introduction to what this patch does and a patch archive can be found on
http://oss.sgi.com/projects/page_fault_performance. The archive also has the
result of various performance tests (LMBench, Microbenchmark and
kernel compiles).

The basic approach in this patchset is the same as used in SGI's 2.4.X
based kernels which have been in production use in ProPack 3 for a long time.

The patchset is composed of 4 patches (and was tested against 2.6.11-rc5-bk4):

1/4: ptep_cmpxchg and ptep_xchg to avoid intermittent zeroing of ptes

	The current way of synchronizing with the CPU or arch specific
	interrupts updating page table entries is to first set a pte
	to zero before writing a new value. This patch uses ptep_xchg
	and ptep_cmpxchg to avoid writing the zero for certain
	configurations.

	The patch introduces CONFIG_ATOMIC_TABLE_OPS that may be
	enabled as a experimental feature during kernel configuration
	if the hardware is able to support atomic operations and if
	an SMP kernel is being configured. A Kconfig update for i386,
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

2/4: Macros for mm counter manipulation

	There are various approaches to handling mm counters if the
	page_table_lock is no longer acquired. This patch defines
	macros in include/linux/sched.h to handle these counters and
	makes sure that these macros are used throughout the kernel
	to access and manipulate rss and anon_rss. There should be
	no change to the generated code as a result of this patch.

3/4: Drop the first use of the page_table_lock in handle_mm_fault

	The patch introduces two new functions:

	page_table_atomic_start(mm), page_table_atomic_stop(mm)

	that fall back to the use of the page_table_lock if
	CONFIG_ATOMIC_TABLE_OPS is not defined.

	If CONFIG_ATOMIC_TABLE_OPS is defined those functions may
	be used to prep the CPU for atomic table ops (i386 in PAE mode
	may f.e. get the MMX register ready for 64bit atomic ops) but
	are simply empty by default.

	Two operations may then be performed on the page table without
	acquiring the page table lock:

	a) updating access bits in pte
	b) anonymous read faults installed a mapping to the zero page.

	All counters are still protected with the page_table_lock thus
	avoiding any issues there.

	Some additional statistics are added to /proc/meminfo to
	give some statistics. Also counts spurious faults with no
	effect. There is a surprisingly high number of those on ia64
	(used to populate the cpu caches with the pte??)

4/4: Drop the use of the page_table_lock in do_anonymous_page

	The second acquisition of the page_table_lock is removed
	from do_anonymous_page and allows the anonymous
	write fault to be possible without the page_table_lock.

	The macros for manipulating rss and anon_rss in include/linux/sched.h
	are changed if CONFIG_ATOMIC_TABLE_OPS is set to use atomic
	operations for rss and anon_rss (safest solution for now, other
	solutions may easily be implemented by changing those macros).

	This patch typically yield significant increases in page fault
	performance for threaded applications on SMP systems.


