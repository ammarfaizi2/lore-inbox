Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTLKF3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLKF3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:29:38 -0500
Received: from holomorphy.com ([199.26.172.102]:24292 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263766AbTLKF3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:29:32 -0500
Date: Wed, 10 Dec 2003 21:29:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net
Subject: 2.6.0-test11-wli-2
Message-ID: <20031211052929.GN19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Successfully tested on a Thinkpad T21 and 32GB NUMA-Q. Any feedback
regarding performance would be very helpful. Desktop users should
notice top(1) is faster, kernel hackers that kernel compiles are faster,
and highmem users should see much less per-process lowmem overhead
(but nothing truly radical like pgcl or 4/4).

This release features 4KB stack fixes for task_pt_regs(), and is vastly
cleaned up compared to the test8 release. It also features the wchan
and major/minor fault accounting fixes. I still need to fold the
anobjrmap fixes into the original patches and find some alternative way
for smbfs and ncpfs to do whatever d_validate() was doing for them (they
won't compile until I do; for now, they depend on CONFIG_BROKEN). I
also need to find a coherent way to incorporate the cleanups for pte
caching suggested by akpm without bloating the pte cache on small boxen.

It's also worth noting that the patches "originally due" to someone
were just plucked off of the list by me (in some cases, they just first
implemented of the idea), so be sure to ascribe all the credit to
them, and all the bugs to me. I wasn't sure of a complete (or even
partial) list of those to credit for top-down vma allocation, hence
"various", though it was jejb who described the glibc workaround.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.6.0-test11/patch-2.6.0-test11-wli-2.gz

336 files changed, 4668 insertions(+), 3054 deletions(-)


-- wli

 1:	highpmd
		-- originally due to aa as part of pte-highmem
		-- from scratch implementation based on 2.6 highpte
		Shove middle level pagetables into highmem PAE process
		scalability, for a lowmem savings of 20KB/process. This
		is a large fraction of the per-process lowmem overhead.

 2:	O(1) buffered_rmqueue()
		Make zone->lock hold time independent of batch counts
		with a revised page allocator algorithm.

 3:	i386 pte caching
		Highpte-compatible implementation of leaf pagetable
		node caching. Should eliminate pte_alloc_one() from
		profiles as well as conserve cache.

 4:	O(lg(n)) proc_pid_readdir()/proc_task_readdir()
		Make /proc/ task enumeration scalable by organizing
		lists as rbtrees for O(lg(n)) list seeks. To see how
		effective this is, try doing the following:
		(a) start up top(1)
		(b) for n in `seq 1 1024`; do sleep 60; done
		... and watch -wli whale on mainline with vastly
		reduced cpu consumption.

 5:	O(1) proc_pid_statm()
		-- originally due to bcrl
		proc_pid_statm() involves a vma list walk for every
		process on the system. This patch keeps count of the
		statistics instead for extreme process scalability:
		as they're integers, no per-process locks are required.

 6:	kmap_atomic() microoptimizations
		Trivial microoptimization that have been in RHAS for years.

 7:	compile-time mapping->page_lock type selection
		Use rwlocks for mapping->page_lock on larger systems for
		greater concurrency. Nice improvement for SDET.

 8:	4KB i386 stacks
		-- originally due to bcrl
		Even more PAE process scalability: cut per-process lowmem
		overhead from kernel stacks in half.

 9:	objrmap
		-- originally due to dmc/mbligh
		Teach the VM about how to use accounting done for file-
		backed mmap() to avoid creating some pte_chains.

10:	RCU mapping->i_shared_lock
		Yes, the first VM RCU patch.
		mapping->i_shared_sem was a contention point with some
		catastrophic contention overheads. This goes all the way
		and RCU's it.

11:	anobjrmap, phase 1
		-- originally due to hugh
		Prepare the VM to change how some of the fields of struct
		page are interpreted.

12:	anobjrmap, phase 2
		-- originally due to hugh
		Remove pte_chains and temporarily disable swapout.

13:	anobjrmap, phase 3
		-- originally due to hugh
		Set up new accounting structures for anonymous pages to
		perform PTE shootdowns in an analogous way to file-backed.

14:	anobjrmap, phase 4
		-- originally due to hugh
		Teach the VM how to handle remap_file_pages() and mremap()
		and reinstate paging of anonymous memory.

15:	anobjrmap, phase 5
		-- originally due to hugh
		Micro-optimize the new rmap functions.

	11-15 are also known as "full object-based rmap" or "anonobjrmap"
	11-15 mean pte_chains are *NEVER* created, *EVER*, except for two
	rare instances:
		(1) remap_file_pages()
		(2) a rare (nonfatal) race during an in-flight mremap()
			that causes pages to appear at two virtual
			addresses simultaneously.

16:	RCU anon->lock
		This RCU's the new anobjrmap accounting structures
		analogous to mapping->i_mmap and mapping->i_shared_lock.
		VM RCU patch #2.

17:	convert copy_strings() to use kmap_atomic() instead of kmap()
		Kill off one more instance of the sleeping kmap() and
		so rip out one more acquisition of the global kmap_lock
		and potential global TLB flush.

18:	increase page allocator batch counts
		O(1) buffered_rmqueue() makes the algorithm scale with
		large batches. This jacks up the batch sizes to exploit
		that newfound scalability.

19:	node-local i386 per_cpu areas
		Bootmem allocation of per_cpu areas implies lowmem
		allocation, which furthermore implies they're all
		trapped on node 0. This patch utilizes the in-mainline
		arch code hook to perform the necessary remapping so
		that the per_cpu area belonging to a cpu is node-local.

20:	CONFIG_MMAP_TOPDOWN, top-down vma allocation
		-- various prior implementations
		This compacts i386 virtualspace for reduced pagetable
		space usage as well as enabling larger heaps and mmap()'s.
		2.9GB mmap()'s and heaps are feasible in a 3:1 split.

21:	anobjrmap fixes
		Fix some bogons in the anobjrmap code.

22:	increase static vfs hashtable and VM array sizes
		Certain hashtables in the VM and vfs are statically
		sized and worse yet microscopic. This jacks up their
		sizes substantially for increased performance with
		little code or space impact.

23:	intermezzo 4KB stack fixes
		-- due to muli
		This fixes obscene stack usage by the intermezzo fs.

24:	/proc/ BKL gunk plus page wait hashtable sizing adjustment
		This nukes some unnecessary BKL acquisitions in /proc/
		code and increases page wait hashtable size for better
		waitqueue hashing scalability.

25:	invalidate_inodes() speedup
		-- originally due to Kirill Korotaev
		This makes umount(8) less of a catastrophe, particularly
		in automount setups typical with academic NFS setups.

26:	fix the anobjrmap fix and adjust page_alloc.c inlining
		Minor tweaks for the page allocator, and another
		anobjrmap bugfix.

27:	remove ->valid_addr_bitmap, kern_addr_valid(), and d_validate()
		The pgdat->valid_addr_bitmap is unused everywhere. This
		removes it and so likely saves a small amount of lowmem,
		and nukes d_validate() as collateral damage. If you
		realize what d_validate() does, you'll see why. (It tries
		to "validate" some random address grabbed off the wire
		or some other random place as a dcache entry.)

28:	fix wchan accounting
		Scheduling internals are still reported as blocking
		points by get_wchan(); this uses an ELF section to mark
		scheduling internals in a better way than current.

29:	fix major/minor fault accounting
		The major and minor fault statistics reported by
		getrusage(2) are completely bogus; this patch corrects
		the kernel's accounting so they are meaningful.

30:	remove mm->swap_address
		Remove an unused field of the process address space
		structure.

31:	4KB stack fixes
		Fix an oops and oops reporting.

32:	patch-2.6.0-test11-bk8
		Linus' current bk snapshot, featuring various
		critical bugfixes for tmpfs, mmap(), and others.

33:	EXTRAVERSION
		Let people know this kernel is -wli.
