Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSKOIBO>; Fri, 15 Nov 2002 03:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKOIBO>; Fri, 15 Nov 2002 03:01:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:49393 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265667AbSKOIBK>;
	Fri, 15 Nov 2002 03:01:10 -0500
Message-ID: <3DD4AB5D.C0EB0F1B@digeo.com>
Date: Fri, 15 Nov 2002 00:07:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.47-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 08:07:58.0536 (UTC) FILETIME=[1C1F0C80:01C28C7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.47/2.5.47-mm3/


. A new kgdb stub from George Anzinger.  It is significantly
  stronger than the old one, especially on SMP systems.  There are some
  notes from George in the patch itself, as well as numerous
  documentation files.

  You'll need to disable the serial 16550 driver in kernel config -
  it doesn't play right.  (Make sure you read George's notes!)

. An updated rbtree-scheduler patch from Jens.  This seems to be
  working well now.

The huge queues which we've been experimenting with have continued to
pull the VM's pants down, and the last vestiges of the 2.4 page
allocator throttling had to go.

The page allocator will now never throttle a process by making it wait
on IO completion against a particular page or buffer.  This has always
caused high latencies, and with the big queues, it could cause ninety
second latencies for the allocation of a single page.

The page allocator will now never throttle a process (except for the
caller of write(2)) by making it sleep on request queues.  This is
fundamentally unmanageable because not only can the size of the queue
vary by a lot, but there can be a lot of queues in the machine.  So
kill it.


. The busy-wait failure which occurred when more than 40% of memory
  was placed under writeout has been fixed.

. The ->vm_writeback address_space_operation has been removed.  The
  idea behind this was to allow the filesystem to perform writearound
  around the particular page.  But it had a couple of problems
  (described in the patch body).

  So it has been removed, and we're back to page-at-a-time writepage
  calls in page reclaim.

. As a consequence of going back to writepage in the VM, it is no
  longer compulsory that dirty pages be on the address_space's
  ->dirty_pages list.  So the AIO-for-direct-io patch can now dirty
  pages from interrupt context.  So the patches which made the
  mapping->page_lock and mapping->private_lock irq-safe have been
  dropped.

. The removal of the last wait_on_page_writeback() in page reclaim
  has significantly reduced system latency under heavy swapout loads.

. The big queues have somewhat worsened throughput with swapstormy tests.
  Having such large amounts of physical memory under writeout for such
  long periods gives the VM much less memory to play with at any point
  in time.  Needs work.  I suspect the queues are just too darn big for
  desktop-class machines.  We do not intend to leave them this large.

. Several tweaks here to increase the efficiency of page reclaim. 
  Under really heavy benchmarky loads the VM is now reclaiming 25% of
  scanned pages, rather than 10%.  Which sounds bad, but actually
  isn't.

  Most of this gain came from interrupt-time motion of written-back
  pages.  When IO completes, if the page appears to still be
  reclaimable, move it to the tail of the inactive list for immediate
  reclaim.

. And a hugetlbpage update.



Changes since 2.5.47-mm2:

-timers-net.patch

 Merged

-kgdb.patch

 Out with the old

+kgdb-ga.patch

 In with the new

+kgdb-reboot.patch

 Remote reboot via kgdb

-bttv-timer.patch

 Merged into `misc'

-irq-save-vm-locks.patch
-irq-safe-private-lock.patch

 No longer needed.

+misc.patch

 Misc.

+htlb-combined-2.patch

 Bill's stuff

+htlb-fixes.patch

 Rohit's stuff

+slab-no-BUG.patch

 Replace some gratuitous BUGs in slab with useful messages

+congestion-wait.patch

 Fix the big-queue busy-wait problem.

+back-to-writepage.patch

 Remove vm_writeback, use writepage.

-swapcache-throttle.patch

 wait_on_page() is a disaster.

+simplified-vm-throttling.patch

 Always throttle via blk_congestion_wait().  It is a low-latency and
 controllable way of slowing page allocators to the rate at which the
 IO system can retire writes.

+page-reclaim-motion.patch

 Move reclaimable pages at interrupt-time.

+handle-fail-writepage.patch

 Handle unwriteable pages at the VM level.

+activate-unreleaseable-pages.patch

 Move pinned-via-buffers pages onto the active list.



All patches:


linus.patch
  cset-1.823-to-1.856.txt.gz

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-reboot.patch
  ADd a `reboot' command to kgdb

rcu-stats.patch
  RCU statistics reporting

genksyms-fix.patch
  modversions fix for exporting per-cpu data

buffer-debug.patch
  buffer.c debugging

mbcache-cleanup.patch
  mbcache: add gfp_mask parameter to free() callback, cleanups

rmap-flush-cache-page.patch
  flush_cache_page while pte valid

swap-get_page-page-unlock.patch
  unlock_page when get_swap_bio fails

swap-writepages-swizzled.patch
  Subject: [PATCH] swap writepages swizzled

misc.patch
  timer fixes

htlb-combined-2.patch
  hugetlb cleanups

htlb-fixes.patch
  more hugetlb fixes

slab-no-BUG.patch
  improved slab error diagnostics

congestion-wait.patch
  Fix busy-wait with writeback to large queues

back-to-writepage.patch
  Remove mapping->vm_writeback

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

aio-direct-io.patch
  AIO support for raw/O_DIRECT

inlines-net.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

reiserfs-readpages-fix.patch

remove-inode-buffers.patch
  try to remove buffer_heads from to-be-reaped inodes

resurrect-incremental-min.patch
  strengthen the `incremental min' logic in the page allocator

unfreeable-zones.patch
  VM: handle zones which are full of unreclaimable pages

mpage-kmap.patch
  kmap->kmap_atomic in mpage.c

nobh.patch
  no-buffer-head ext2 option

inode-reclaim-balancing.patch
  better inode reclaim balancing

simplified-vm-throttling.patch
  Remove the final per-page throttling site in the VM

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

page-reclaim-motion.patch
  Move reclaimable pages to the tail ofthe inactive list on IO completion

handle-fail-writepage.patch
  Special-case fail_writepage() in page reclaim

activate-unreleaseable-pages.patch
  Move unreleasable pages onto the active list

rbtree-iosched.patch
  rbtree-based IO scheduler

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

kmap-atomic-nfs.patch
  Subject: Re: [RFC] use kmap_atomic in the NFS client

dcache_rcu.patch
  Use RCU for dcache

shpte-ng.patch
  pagetable sharing for ia32
