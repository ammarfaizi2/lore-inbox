Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSLLRXk>; Thu, 12 Dec 2002 12:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLLRXk>; Thu, 12 Dec 2002 12:23:40 -0500
Received: from holomorphy.com ([66.224.33.161]:19111 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264857AbSLLRXg>;
	Thu, 12 Dec 2002 12:23:36 -0500
Date: Thu, 12 Dec 2002 09:30:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.51-bk1-wli-1
Message-ID: <20021212173049.GM20686@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganized the patches, fixed some bugs, and so on. Available from:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.51-bk1-wli-1/

Notable events:
	(1) bugfix for unconditionally setting nr_ioapics = 2
		reported by Zwane Mwaikambo
	(2) bugfix for misaligned order > 0 frees in NUMA-Q highpage init.
	(3) dropped manfred's slab changes; they're no longer needed
	(4) no preallocation of pmd's in the pgd ctor; they exhibited
		extremely poor fragmentation characteristics when
		that was done. Just slab allocate pmd's in pgd_alloc().

I never really commented on the theme of the tree. It's basically a
bunch of things that are obvious to me how to do and a place to dump
patches that don't really fit into other trees (e.g. -mm), though I
think some of the NUMA-Q stuff might eventually get thrown over the
wall in the direction of -mjb. =) Sound bite: misc patches from wli.

The net effect is that some odd bootstrapping, wait table hashing,
memory initialization, and tasklist scan removal patches landed here.
Other stuff will crop up as I poke around the tree.


01_driverfs_oops
	fix for still-broken driverfs memblk and node registration.
	I suspect this might hit mainline soon.

02_numaq_io
	Workaround for PCI bridges on different PCI segments
	with clashing bus numbers until it's fixed (by me). Drop
	IO-APIC's and PCI buses off node 0 onto the floor. Bugfix
	to set nr_ioapics only if (clustered_apic_mode) and take
	min(2, nr_ioapics) to avoid elevating nr_ioapics. Some
	NUMA-Q PCI code may appear soon to replace this...

03_do_sak
	Remove tasklist iteration from __do_SAK(); it's simply trying
	to kill off tasks in a given session; use for_each_task_pid().

04_proc_super
	proc_fill_super() is iterating over the tasklist because there
	is no count of processes (only threads). Use a process counter.

05_cap_set_pg
	cap_set_pg() is iterating over the tasklist in search of tasks
	within a process group; use for_each_task_pid().

06_vm86
	vm86 wants to clean up references to tasks. Do so by cleaning
	up stale references in release_thread(), not by GC that walks
	the tasklist comparing (possibly reused) task_struct pointers.
	This was originally part of a bugfix in -dj only half of which
	made it to mainline.

07_uml_get_task
	UML's get_task() is looking for a task with a given pid; use
	find_task_by_pid() instead of walking the tasklist.

08_numaq_mem_map
	Free higher-order pages in NUMA-Q highmem mem_map initialization
	instead of freeing order 0 pages at a time. New bugfix here that
	fixes some improperly-aligned frees. There's an irritated nested
	min() duplicate const warning.

09_numaq_pgdat
	Allocate pgdats from node-local memory on NUMA-Q

10_has_stopped_jobs
	Remove the unused has_stopped_jobs() from kernel/exit.c
	and rename __has_stopped_jobs() to has_stopped_jobs().

11_inode_wait
	Increase the too-small inode wait table's size.

12_pgd_ctor
	Use slab ctor's for pgd's and pmd's on PAE i386 boxen.
	One of the primary benefits is that pmd's are actually
	accounted (via /proc/slabinfo) so their lowmem consumption
	is directly visible.
