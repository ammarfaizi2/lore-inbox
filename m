Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266911AbTGGJJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbTGGJJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:09:54 -0400
Received: from holomorphy.com ([66.224.33.161]:9110 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266911AbTGGJJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:09:45 -0400
Date: Mon, 7 Jul 2003 02:25:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74-wli-1
Message-ID: <20030707092542.GD1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.74/2.5.74-wli-1.bz2

Various tidbits of new material. As usual, obscene amounts of NIH'ing.
I won't claim it's bug-free, but I will claim some modicum of speed.

Insert something humorous here about sharp, bleeding edges cutting the
unwary. The vfs locking changes here are in need of various kinds of
shaking down, stress testing, and review beyond what I've done thus far.


All 36 patches:
cpumask_t
	Extended cpu bitmaps for NR_CPUS > BITS_PER_LONG.

highpmd
	Shove pmd's into highmem by brute force.

O(1) buffered_rmqueue()
	page_alloc.c rewrite for O(1) bulk transfers to/from per-cpu
	lists. Some of this thing's performance problems were
	corrected by the node-local per_cpu areas; I'm not entirely
	sure what's going on here but it seems as if cachelines totally
	unrelated to the algorithm are exploding wrt. modification cost.
	It's encouraging to see that the algorithm's internals aren't
	behaving like utter shite but discouraging to have no clue of
	what's going wrong with it. I should at least be able to say
	_why_ it sucks before throwing away something that doesn't
	examine 95% of its input 95% of the time to keep something that
	does examine 100% of its input 100% of the time...

lowmem_page_address() micro-optimization
	Use page_to_pfn() instead of open-coding the discontig case.

trivial /proc/ BKL removals
	A couple lock_kernel()'s were outright silly.

i386 pagetable cacheing
	Piggyback on tlb.h stuff to cache pmd's and pte's, even when in
	highmem. New and improved with a shootdown method for kswapd.

pgd_ctor
	Use slab preconstruction for i386 pgd's.

O(1) proc_pid_readdir()
	NIH'd from Manfred Spraul; walks the hashtable for fast seeks

O(1) proc_pid_statm()
	NIH'd from Ben LaHaise; keeps count of proc_pid_statm()'s stats.

vfsmount_lock
	NIH'd from Maneesh Soni and Dipankar Sarma; uses a separate
	lock for vfsmounts

vfsmount RCU
	NIH'd from Maneesh Soni and Dipankar Sarma; RCU's vfsmount_lock

mnt_move_lock
	NIH'd from Maneesh Soni; uses a seqlock for ->mnt_parent

i386 kmap_atomic() micro-optimizations
	Check pte_same() etc. and nop out kunmap_atomic() when possible.

adaptive mapping->page_lock
	Use rwlocks when NR_CPUS > 8. NR_CPUS > 8 loves it.

4KB stacks, part 1
	NIH'd from Ben LaHaise and Dave Hansen
	s/8192/THREAD_SIZE/ cleanups

4KB stacks, part 2
	NIH'd from Ben LaHaise and Dave Hansen
	Switch to irq stacks in interrupts.

4KB stacks, part 3
	NIH'd from Ben LaHaise and Dave Hansen
	mcount-based stack overflow checking

4KB stacks, part 4
	NIH'd from Ben LaHaise and Dave Hansen
	Switch THREAD_SIZE on a config option.

partial objrmap
	NIH'd from Martin Bligh and Dave McCracken
	Walk ->i_mmap{,shared} for ptov resolution on file-backed pages.

i_mmap RCU
	Use RCU rwlocking to replace mapping->i_shared_sem.

anobjrmap, part 1
	NIH'd from Hugh Dickins
	Core VM cleanups of some kind.

anobjrmap, part 2
	NIH'd from Hugh Dickins
	Prep things to let anonymous pages use ->mapping for other things.

anobjrmap, part 3
	NIH'd from Hugh Dickins
	Wipe pte_chains off the face of the earth.

anobjrmap, part 4
	NIH'd from Hugh Dickins (and mutated in various ways)
	Make a struct anon to look up anon pages with.

anobjrmap, part 5
	NIH'd from Hugh Dickins
	Reinvent pte_chains from scratch, totally different algorithm.
	(Part 6 was partially dropped and partially folded into others.)

anon->lock RCU
	Entirely analogous to ->i_mmap RCU for struct anons.

fs/exec.c sleeping kmap() removals
	highmem.c TLB shootdowns are murder on SMP.
	If only readdir() were so easy to fix...

miscellaneous micro-optimizations
	inode_change_ok() BKL removal (from other trees)
	push down ->mmap_sem to where O(1) proc_pid_statm() can avoid it
	generic_file_llseek() for ramfs (from other trees)
	nuke some extraneous crap in page_alloc.c and jack up batches

i386 per_cpu
	Shove i386 per_cpu data into node-local memory via virtual
	remapping and other disgusting hacks. For some weird reason
	it shook up cacheline colors or some other horrifically
	unpredictable factor enough to help that silly O(1)
	buffered_rmqueue() thing. Also possible node-locality gains.

cpumask_t bugfixes
	From recent -mm discussions.

CONFIG_MMAP_TOPDOWN
	Top-down vma allocation; unfortunately various versions of glibc
	hate this and all versions of NPTL and/or LinuxThreads do too...

files_struct RCU
	NIH'd from Maneesh Soni and Dipankar Sarma
	RCU locking for fd tables

redundant current removals
	I don't trust gcc to stop recomputing current on every call.

fs_struct RCU
	RCU locking for pwd's, altroots, etc.

less rmap_lock()'ing
	Untangle page->mapcount and page->chain so ->mapcount can be
	found without having to take a bitwise spinlock per page.
	copy_page_range() never does the bitwise spinlocking at all.
	zap_page_range() only does it for pages the unmapper was the
	last to unmap. Hefty SMP speedup of a certain unmentionable
	benchmark. Unfortunately increases sizeof(struct page).

kill files_lock
	Use a split list to hold struct files so as not to pound
	files_lock like a wild monkey. Even heftier SMP speedup
	of the same unmentionable benchmark...


-- wli
