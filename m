Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSL2Ao1>; Sat, 28 Dec 2002 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSL2Ao1>; Sat, 28 Dec 2002 19:44:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:21479 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265628AbSL2AoT>;
	Sat, 28 Dec 2002 19:44:19 -0500
Message-ID: <3E0E4744.8EE126ED@digeo.com>
Date: Sat, 28 Dec 2002 16:52:20 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.53-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 00:52:30.0743 (UTC) FILETIME=[90EB3A70:01C2AED4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.53/2.5.53-mm2/

Mainly stability work:

. If pte_chain_alloc() fails to allocate GFP_ATOMIC memory, the kernel
  oopses.  This is a long-standing rmap problem.  Present also in the 2.4
  rmap patches and, as far as I know, production Red Hat kernels.

  So it is clearly a very rare problem but it is not acceptable to have
  an unchecked kmalloc in the core of the 2.5 VM.

  The approach which I took was to change the page_add_rmap() API to
  require the caller to pass in a preallocated pte_chain.  And change
  all callers to allocate their pte_chains with GFP_KERNEL.

  This change is fairly ugly, but every other hare-brained scheme I
  could come up with had holes.  This one adds maybe 20 instructions
  to pagefaults and works...

  The swapoff path has not yet been converted - this can still oops.

  The locking isn't quite right yet, if shared pagetables are enabled.

. If radix_tree_insert() fails to allocate GFP_ATOMIC memory, a system call
  will return -ENOMEM, resulting in application failure.

  This was fixed by implementing a reservation API within the slab allocator.
  Before taking locks the caller of radix_tree_insert will ask slab to preallocate
  sufficient objects in this CPU's slab head array to guarantee that the
  allocation of up to seven (on ia32) radix_tree_nodes cannot fail.

  This permitted the removal of the radix tree mempool.  That's a 130 kbyte
  saving.  (260k on 64-bit).

. Some aggressive pruning of various system-wide memory reserve settings:

  - The page reservation limits in the page allocator have been reduced
    from ~256 pages per zone to ~4 pages per zone.

  - The preallocation levels in the slab head arrays (which were ridiculously
    large) have been reduced from 32k-128k to, typically, a single page.

  - The per-cpu-pages head arrays in the page allocator have been reduced
    from ~64 pages to 2 pages.

  The net effect of these changes is to remove almost all of the kernel's
  reserved memory buffers.  Instead of maintaining several megabytes of
  free memory the kernel will only maintain some tens of kilobytes.

  And guess what?   Everything still works.

  I won't be submitting these changes - they are here for robustness testing.
  But it certainly does indicate that the settings of these thresholds need
  to be reviewed.  And that there don't appear to be any low-on-memory deadlocks
  in the VM (with ext2, at least..)

. An updated dcache_rcu patch which should fix a rename-related race which
  Al Viro noted.




Changes since 2.5.53-mm1:

+linus.patch

 Latest -BK

+aic-bounce.patch

 aic7xxx highmem IO fix

+misc.patch

 triviata

+devfs-fix.patch

 A partial fix for a CONFIG_DEVFS=y boot problem

+copy_page_range-cleanup.patch

 Small cleanups, partly to ease the maintenance of the shared pagetable
 diff.

+pte_chain_alloc-fix.patch

 Infrastructure for handling pte_chain_alloc() failures.

+page_add_rmap-rework.patch

 Handle pte_chain_alloc() failures.

 shpte-ng.patch

 Lots of changes to handle pte_chain_alloc() failures.

+slab-preallocation.patch

 Add an API to slab to reserve objects in the per-CPU head arrays.

+slab-export-tuning.patch

 Export the slab head-array tuning functions.

+rat-preallocation.patch

 Add a reservation API to the radix_tree code.

+use-rat-preallocation.patch

 Use the reservation API to avoid radix_tree allocation failures.

+teeny-mem-limits.patch

 Remove most of the page allocator page reserves.

+smaller-head-arrays.patch

 Remove most of the slab memory reserves.

+remove-hugetlb-syscalls.patch

 Remove the hugetlb system calls.  hugetlbfs is suitable.





All 72 patches:

linus.patch
  cset-1.951-to-1.1030.txt.gz

kgdb.patch

aic-bounce.patch

rcf.patch
  run-child-first after fork

ga2.patch
  don't call console drivers on non-online CPUs

misc.patch
  misc fixes

devfs-fix.patch

dio-return-partial-result.patch

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

deferred-bio-dirtying.patch
  bio dirtying infrastructure

aio-direct-io.patch
  AIO support for raw/O_DIRECT

aio-dio-debug.patch

dio-reduce-context-switch-rate.patch
  Reduced wakeup rate in direct-io code

cputimes_stat.patch
  Retore per-cpu time accounting, with a config option

reduce-random-context-switch-rate.patch
  Reduce context switch rate due to the random driver

inlines-net.patch

rbtree-iosched.patch
  rbtree-based IO scheduler

deadsched-fix.patch
  deadline scheduler fix

quota-smp-locks.patch
  Subject: [PATCH] Quota SMP locks

copy_page_range-cleanup.patch
  copy_page_range: minor cleanup

pte_chain_alloc-fix.patch

page_add_rmap-rework.patch

shpte-ng.patch
  pagetable sharing for ia32

slab-preallocation.patch

slab-export-tuning.patch

rat-preallocation.patch

use-rat-preallocation.patch

teeny-mem-limits.patch

smaller-head-arrays.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

pentium-II.patch
  Pentium-II support bits

rcu-stats.patch
  RCU statistics reporting

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

ext3-fsync-speedup.patch
  Clean up ext3_sync_file()

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

scheduler-tunables.patch
  scheduler tunables

dio-always-kmalloc.patch
  direct-io: dynamically allocate struct dio

file-nr-doc-fix.patch
  Docs: fix explanation of file-nr

set_page_dirty_lock.patch
  fix set_page_dirty vs truncate&free races

remove-memshared.patch
  Remove /proc/meminfo:MemShared

bin2bcd.patch
  BIN_TO_BCD consolidation

log_buf_size.patch
  move LOG_BUF_SIZE to header/config

semtimedop-update.patch
  Enable semtimedop for ia64 32-bit emulation.

drain_local_pages.patch
  add drain_local_pages() for CONFIG_SOFTWARE_SUSPEND

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

kmalloc_percpu.patch
  kmalloc_percpu -- stripped down version

config_page_offset.patch
  Configurable kenrel/user memory split

config_hz.patch
  CONFIGurable HZ

dont-aligns-vmas.patch
  Don't cacheline-align vm_area_struct

remove-swappable.patch
  remove task_struct.swappable

remove-hugetlb-syscalls.patch
  Subject: [hugetlb] remove hugetlb syscalls

wli-01_numaq_io.patch
  (undescribed patch)

wli-02_do_sak.patch
  (undescribed patch)

wli-03_proc_super.patch
  (undescribed patch)

wli-06_uml_get_task.patch
  (undescribed patch)

wli-07_numaq_mem_map.patch
  (undescribed patch)

wli-08_numaq_pgdat.patch
  (undescribed patch)

wli-09_has_stopped_jobs.patch
  (undescribed patch)

wli-10_inode_wait.patch
  (undescribed patch)

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-12_pidhash_size.patch
  (undescribed patch)

wli-13_rmap_nrpte.patch
  (undescribed patch)

dcache_rcu-2.patch
  dcache_rcu-2-2.5.51.patch

dcache_rcu-3.patch
  dcache_rcu-3-2.5.51.patch

page-walk-api.patch

page-walk-scsi.patch

page-walk-api-update.patch
  pagewalk API update

gup-check-valid.patch
  valid page test in get_user_pages()
