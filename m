Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbREZRdo>; Sat, 26 May 2001 13:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbREZRdZ>; Sat, 26 May 2001 13:33:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27676 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261401AbREZRdO>; Sat, 26 May 2001 13:33:14 -0400
Date: Sat, 26 May 2001 19:33:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5aa1
Message-ID: <20010526193310.A1834@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I merged Rik's three liner fix to alloc_pages for GFP_BUFFER, plus my
other fix in create_buffers wait_event and a bit bigger reserved pool of
async bh. I'd suggest to test if this makes the highmem deadlock to go
away.

Detailed description of 2.4.5aa1 follows.

---------------------------------------------------------------------------
00_alpha-illegal-irq-1

	Be verbose for MAX_ILLEGAL_IRQS times if an invalid irq number
	is getting run.

	(debugging)

00_boot-serial-console-1

	Allows the serial console to work anytime during boot. It may have side
	effects but certainly nothing relevant and the current situation was
	annoying enough.

	(nice to have)

00_create_buffers-deadlock-1

	Fix tasks possibly deadlocking in wait_event because the unused_list
	isn't refilled at I/O completion anymore with the 2.4
	pagecache(/swapcache) design.

	(recommended)

00_eepro100-64bit-1

	Fixes a 64bit bug that was generating false positives and memory
	corruption.

	(recommended)

00_eepro100-alpha-1

	Possibly fix the eepro100 transmitter hang on alpha by doing atomic PIO
	updates to avoid the clear_suspend to be lost.
	
	(recommended)

00_gfp_buffer-alloc-pages-deadlock-1

	Fix from Rik that avoids GFP_BUFFER to deadlock inside alloc_pages().

	This is by no means a definitive fix for the VM deadlocks during oom,
	all other __GFP_IO allocations can still dealdock inside alloc_pages()
	like before. But it is a first step in the right direction I think.

	Please try to beat 2.4.5aa1 hard and see if you can reproduce deadlocks
	with highmem.

	(recommended)

00_cachelinealigned-in-smp-1

	Moves the pagecache_lock and the VM pagemap_lru_lock in two
	different L1 cachelines to avoid contention, mostly useful on
	the alpha where the spinlocks uses load locked store
	conditional loops (and we don't want to loop).

	(nice to have)

00_copy-user-lat-2

	Put the rechedule points into copy-user calls, with lots of
	cache large read/writes could otherwise _never_ reschedule
	once until they returns to userspace.

	(recommended)

00_cpus_allowed-1

	Fixes a bug in the cpu affinity in-kernel API, bug was fatal
	for ksoftirqd.

	(recommended)

00_double-buffer-pass-1

	Avoids looping two times for no good reason into the lru lists
	of the buffer cache (the double loop was an unreliable hack
	from the prehistory that survided 'till today).

	(nice to have)

00_exception-table-1

	Avoids a compilation warning when compiling without modules.

	(very minor thing)

00_highmem-deadlock-3

	Fixes an highmem deadlock using a reserved pool for the bounce
	buffers.

	(recommended)

00_highmem-debug-1

	Allows people with x86 machines with less than 1G of ram to
	test the highmem code.

	(debugging)

00_ia32-bootmem-corruption-1

	Fixes the x86 boot stage to finish initializing all the
	reserved memory before starting allocating memory.

	(recommended)

00_ipv6-null-oops-1

	Fixes null pointer oops.

	(recommended)

00_jens-loop-noop-nobounce-1

	Skips the bounces with the null transfer function.

	(nice to have)

00_ksoftirqd-4

	Avoids 1/HZ latency for the softirq if the softirq is marked
	again pending when do_softirq() finished and the machine is
	otherwise idle, it also fixes the case of a softirq re-marking
	itself runnable by delegating to the scheduler the balance of
	the softirq load like if it would be an normal task.

	(nice to have)

00_kupdate-large-interval-1

	Allows to set large interval for the kupdate runs, this is
	useful on the laptops, instead of sigstopping ksoftirqd it's
	nicer to set a large interval for example of the order of one
	hour (do that at your own risk of course, doing that is not
	recommended unless you know what you're doing).

	(nice to have)

00_lvm-0.9.1_beta7-4

	Updates to the lvmbeta7 with fixes for the lv hardsectsize
	estimantion based on the max hardsectsize of the underlying
	pv, plus it has some other tons of fixes and it is a must have
	for the 64bit archs as the IOP silenty changed for those
	platforms.

	(recommended)

00_max_readahead-1

	Increases the max_readahead to allow the blkdev to read with
	512k scsi commands when possible.

	(nice to have)

00_msync-fb0-1

	Fixes oopses while running msync on a region of virtual memory
	that maps to reserved memory.

	(recommended)

00_nfs-corruption-3

	Production fix for the nfs map_shared fs data
	corruption. Other design solutions are discussed and the long
	term fix might be different but all the other approches are
	more invasive and risky, while this one is obviously right and 
	the most approriate for production.

	(recommended)

00_numa-sched-6

	Implements a basic numa scheduler with a per node runqueue
	that boosts the perforormance on numa boxes. It also enables
	and somewhere fixes the last_idle heuristic in the smp
	scheduler.

	The numa part doesn't impose any runtime overhead when
	CONFIG_NUMA_SCHED is not set.

	(nice to have)

00_o_direct-7

	Implements O_DIRECT zerocopy direct I/O in a filesystem
	indipendent fascion, currently it's only available on ext2,
	but it will be easy to let the other of fs to take advantage
	of it too.

	Defines KERNEL_HAS_O_DIRECT so filesystems out of the
	kernel can conditionally define the direct_IO callback to get the
	O_DIRECT support. Just a one line noop difference.

	(nice to have)

00_pagetable-fast-2

	Enables the usage of the per-cpu quicklists for the pte/pgd to
	optimize the cache affinity and footprint.

	(nice to have)

00_peekurgdata-1

	Allows MSG_PEEK to work on the urgent (aka out of band)
	receive queue as well, needed for tux.

	(nice to have)

00_rwsem-13

	Alternate implementation for the rwsem, the x86 asm version is
	simpler in the slow path and it provides a faster up_write
	fast path, the C-spinlock version is much faster too.

	ppc and alpha needs to be updated to use asm optimizations.

	(nice to have)

00_xircom-serial-1

	Merged a fix posted on l-k that makes xircom integrated modem to work
	fine (without this artificial delay during initialization it really
	doesn't work).

	(nice to have)

00_sched-yield-1

	Fixes a bug in sched_yield, where SCHED_YIELD needs to be
	cleared after a schedule() if no other task was runnable,
	otherwise the next schedule() would inherit the SCHED_YIELD
	behaviour even if a SCHED_YIELD wasn't requested anymore.

	(nice to have)

00_show_regs-1

	Makes SYSRQ+P more verbose.

	(debugging)

00_slab-lists-1

	Rewrites the slab cache handling for partial and completly
	free slab objects, always provides LIFO behaviour from all
	the lists to reduce the cache misses, while previously the
	completly free slab objects were reallocated with a less
	optimal FIFO policy. It also cleanups the code.

	(nice to have)

00_softirq-SMP-fixes-3

	Fixes an SMP race in the softirq code on archs like the alpha
	where the atomic_t and bitop operations aren't memory barriers
	as well.

	(recommended)

00_sync-page-1

	Avoids suprious unplug of the tq_disk task queue while waiting
	I/O completion.

	(nice to have)

00_timer_t-2

	Defines the timer_t type in one single place.

	(nice to have)

00_waitqueue-2

	Setups the not yet visible waitqueue flags outside the
	critical section.

	(nice to have)

00_x86-systable-1

	Fills the end of the syscall table automatically, it is off by
	one without this patch.

	(nice to have)

00_xircom-tulip-cb-arjanv-2

	No need of ifconfig eth0 promisc on the xircom card with this
	driver.

	(nice to have)

10_no-virtual-1

	Avoids wasting tons of memory if highmem is not selected (like
	in all the 64bit ports).

	(nice to have)

10_parent-timeslice-7

	Fixes a scheduler unfairness generated by the parent-timeslice
	logic.

	(recommended)

10_read_ahead-2

	Setups readahead for lvm [global, hacking around read/write
	callbacks is broken] and drops sensless limits.

	(recommended)

20_share-timeslice-2

	Reschedule the child first but share the timeslice with the
	parent (I never triggered a single userspace bug with this
	correct patch)

	(nice to have)

The below patches aren't included by default but they can be applied incrementally
if tux is needed. TUX patches are been developed by Ingo Molnar.

30_atomic-alloc-1

	Defines a PF_ATOMICALLOC that won't sleep watiting memory to
	become available.

	(needed by tux)

30_atomic-lookup-1

	Implements an O_ATOMICLOOKUP flag to avoid entering the
	filesystem code that could wait for I/O in open, open will
	return -EWOULDBLOCKIO if the lookup wasn't doable in dcache.

	(needed by tux for the asynchronous vfs lookups)

30_net-exports-1

	Exports some networking function so that tux can be compiled
	as module,  and splits the sock_map_file functionality away
	from sock_map_fd.

	(needed by tux)

30_pagecache-atomic-1

	Defines a do_generic_file_read_atomic that implements
	nonblocking reads from cache, if information wasn't in cache
	the descriptor error flag is set to -EWOULDBLOCKIO.

	(needed by tux to implement asynchronous read I/O)

30_tux-2

	tux core.

	(nice to have)

30_tux-data-1

	Adds a tux_data private pointer to the sock structure.

	(needed by tux)

30_tux-dprintk-1

	Defines tux_Dprintk.

	(needed by tux)

30_tux-exports-1

	Exports to modules the in-kernel syscalls.

	(needed by tux)

30_tux-kstat-2

	Defines additional kstats for tux.

30_tux-process-1

	Defines per-process callbacks for tux.

30_tux-syscall-1

	Implements the tux-syscall, it's the one executed by the
	userspace tux program to fire up, shutdown and control the tux
	kernel threads.

	(needed by tux)

30_tux-sysctl-2

	Defines the symbolic names for the tux sysctl.

	(needed by tux)

30_tux-vfs-1

	Adds a per-dentry tux private data.

	(needed by tux)

31_tux-logger-1

	Aligns correctly the tux logentry for 8 byte cachelines too.

---------------------------------------------------------------------------

The 2.4.5aa1 patch is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa1.bz2

As usual all the separate patches are in:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa1/

and they can be applyed in `ls` order to generate the 2.4.5aa1.bz2
kernel.

Have fun.

Andrea
