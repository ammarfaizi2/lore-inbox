Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTE2IQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 04:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTE2IQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 04:16:05 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:27816 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262000AbTE2IPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 04:15:52 -0400
Date: Thu, 29 May 2003 01:29:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm2
Message-Id: <20030529012914.2c315dad.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 08:29:09.0495 (UTC) FILETIME=[60394070:01C325BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm2/


. A couple more locking mistakes in ext3 have been fixed.


. There is some code here to make ext3's journalled-data mode work again.

  2.4's data=journal code has horrid hacks to cope with MAP_SHARED pages. 
  These did not survive the changes in the 2.5 writeback protocols.

  What I have done here is to actually properly journal these pages rather
  than treating them as ordered-mode data.  This made things start to work
  again, and journalled data mode appears to be solid.

  It has only been tested with blocksize == PAGE_CACHE_SIZE, and is
  probably buggy with smaller blocks at this time.


. There is a patch here which makes a fairly fundamental change to the way
  in which the kernel handles O_SYNC writes.

  Traditionally Linux has held the inode semaphore while waiting for the
  I/O to complete.  And it writes _all_ the file's dirty data, regardless of
  how much data the write() caller wrote.

  The patch here arranges for the O_SYNC writer to only write the pages
  which he actually dirtied.  And it moves the waiting for I/O completion
  outside the inode semaphore, so other writers can get in and submit their
  I/O.

  All this is designed to speed up the situation where multiple processes
  or threads are submitting O_SYNC writes to the same file.  Databases.  It
  speeds things up because the various writers can get more data into the
  disk queueing code, so it can optimise the seek distances.

  A few simple O_SYNC-based tests showed speedups from 15% to 400%,
  depending upon the access patterns and the number of writing threads.  The
  more threads the better.

  If the application uses fsync() this change will provide no benefit.

  This patch halves WimMark throughput.  That is quite nonsensical.

  Needs lots of testing.



Changes since 2.5.70-mm1:


 linus.patch

 Latest -bk

+coda-typo-fix.patch

 coda BUGfix

+pccardd-suspend-fix.patch

 swsusp fix

+resume-oops-fix.patch

 another swsusp fix

+common-ioctl32.patch
+ioctl32-cleanup-sparc64.patch
+ioctl32-cleanup-x86_64.patch

 Consolidation of 32-bit ioctl compat code

+export-mmu_cr4_features.patch

 export a missing symbol for DRM

+visws-irq-update.patch

 visws fixes

+lru_cache_add-check.patch

 debug check

+fb-image-depth-fix.patch

 framebuffer fix

+zoran_procfs-copy-user-fix.patch

 don't do memcpy() on user pointers.

-ext3-journalled-data-assertion-fix.patch

 merged into other patches

+write_one_page-cleanup.patch

 minor cleanups

+deadline-hash-removal-fix.patch

 deadline elevator fix

+as-hash-removal-fix.patch

 anticipatory scheduler fix

+as-jumbo-patch-for-scsi.patch

 Lots of changes to address interoperation between the anticipatory
 scheduler and tagged-command-queueing disks.  I wasn't supposed to release
 this one yet.  Oh well.

+cfq-hash-removal-fix.patch

 CFQ scheduler fix

+blk-invert-watermarks.patch

 cleanup relative to per-queue-nr_requests.patch

+print-build-options-on-oops.patch

 Print a line in the oops output which tells whether CONFIG_PREEMPT,
 CONFIG_SMP or CONFIG_DEBUG_PAGEALLOC are enabled.  Might save the odd email
 iteration.

-slab-scribble-negative.patch

 Dropped, lost interest,

-journal_dirty_metadata-speedup.patch

 moved around

+ext3-concurrent-block-inode-allocation-fix.patch

 ext3 inode allocator race fix

+ext3-010-fix-journalled-data.patch

 resurrect ext3 data=journal

+ext3-020-journal_dirty_metadata-speedup.patch

 small speedup to a fastpath.

-lockfree-lookup_mnt.patch

 Dropped.  Just about all the speedup came from the simpler
 vfsmount_lock.patch, so we'll run with that.

+writev-retval-fix.patch

 Fix writev behaviour when some segments generate EFAULT.

+O_SYNC-speedup.patch

 Move O_SYNC and IS_SYNC waits outside inode->i_sem.

+isdn-typo-fix.patch

 Fix some isdn bug.




All 150 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

coda-typo-fix.patch
  fix typo in coda

sysenter-nmi-fix-2.patch
  fix bad pointer access in nmi

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kmalloc_percpu-interface-change.patch
  kmalloc_percpu: interface change.

kmalloc_percpu-interface-change-warning-fix.patch
  nail a warning

DEFINE_PERCPU-in-modules.patch
  per-cpu support inside modules (minimal)

slab-magazine-layer.patch
  magazine layer for slab

slabinfo-rework.patch
  new statistics for slab

aio-random-cleanups.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

pccardd-suspend-fix.patch
  Fix suspend with pccardd running

resume-oops-fix.patch
  fix oops on resume from apm bios initiated suspend

common-ioctl32.patch
  From: Pavel Machek <pavel@suse.cz>
  Subject: Re: must-fix list, v5

ioctl32-cleanup-sparc64.patch
  ioctl32 cleanup: sparc64

ioctl32-cleanup-x86_64.patch
  ioctl32 cleanup: sparc64

export-mmu_cr4_features.patch
  export mmu_cr4_features to modules

visws-irq-update.patch
  [VISWS] irqreturn_t conversion

lru_cache_add-check.patch
  lru_cache_add debug check

fb-image-depth-fix.patch
  fbdev image depth fix

zoran_procfs-copy-user-fix.patch
  zoran user-pointer fix

buffer-debug.patch
  buffer.c debugging

irq_balance-fix-2.patch
  irq balance logic fix

VM_RESERVED-check.patch
  VM_RESERVED check

rcu-stats.patch
  RCU statistics reporting

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

i2o-leak-comment.patch
  i2o memleak comment

raid5-use-right-dev-fix.patch
  raid5 fix

linux-isp.patch

isp-update-1.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

write_one_page-cleanup.patch
  write_one_page() fixlets

deadline-hash-removal-fix.patch
  DEADLINE: hash removal fix

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-proc-read-write.patch
  AS: pgbench improvement

as-discrete-read-fifo-batches.patch
  AS: discrete read fifo batches

as-sync-async.patch
  AS sync/async batches

as-hash-removal-fix.patch
  AS: hash removal fix

as-jumbo-patch-for-scsi.patch
  AS jumbo patch (for SCSI and TCQ)

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2
  CFQ: update to rq-dyn API

cfq-hash-removal-fix.patch
  CFQ: hash removal fix

per-queue-nr_requests.patch
  per queue nr_requests

blk-invert-watermarks.patch
  blk_congestion_wait threshold cleanup

unmap-page-debugging.patch
  unmap unused pages for debugging

CONFIG_DEBUG_PAGEALLOC-extras.patch
  From: Manfred Spraul <manfred@colorfullife.com>
  Subject: DEBUG_PAGEALLOC

print-build-options-on-oops.patch
  print a few config options on oops

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sound-irq-hack.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

unlink-speedup-speedup.patch
  speedp the unlink speedup

time-interpolation-infrastructure.patch
  improved core support for time-interpolation

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

reinstate-task-freeing-hack-for-ia64.patch
  reinstate lame task_struct (non)-refcounting hack/fix

remove-fcntl-check.patch
  Remove unneeded fcntl check

ext3-no-bkl.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-inode-allocation-fix.patch
  fix ext3 inode allocator race

jbd-010-b_committed_data-race-fix.patch
  Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd

jbd-020-locking-schema.patch
  plan JBD locking schema

jbd-030-remove-splice_lock.patch
  remove jh_splice_lock

jbd-040-journal_add_journal_head-locking.patch
  fine-grain journal_add_journal_head locking

jbd-045-rename-journal_unlock_journal_head.patch
  rename journal_unlock_journal_head to journal_put_journal_head

jbd-050-b_frozen_data-locking.patch
  Finish protection of journal_head.b_frozen_data

jbd-060-b_committed_data-locking.patch

jbd-070-b_transaction-locking.patch
  implement b_transaction locking rules

jbd-080-b_next_transaction-locking.patch
  Implement b_next_transaction locking rules

jbd-090-b_tnext-locking.patch
  b_tnext locking

jbd-100-remove-journal_datalist_lock.patch
  remove journal_datalist_lock

jbd-110-t_nr_buffers-locking.patch
  t_nr_buffers locking

jbd-120-t_updates-locking.patch
  t_updates locking

jbd-130-t_outstanding_credits-locking.patch
  implement t_outstanding_credits locking

jbd-140-t_jcb-locking.patch
  implement t_jcb locking

jbd-150-j_barrier_count-locking.patch
  implement j_barrier_count locking

jbd-160-j_running_transaction-locking.patch
  implement j_running_transaction locking

jbd-170-j_committing_transaction-locking.patch
  implement j_committing_transaction locking

jbd-180-j_checkpoint_transactions.patch
  implement j_checkpoint_transactions locking

jbd-190-j_head-locking.patch
  implement journal->j_head locking

jbd-200-j_tail-locking.patch
  implement journal->j_tail locking

jbd-210-j_free-locking.patch
  implement journal->j_free locking

jbd-220-j_commit_sequence-locking.patch
  implement journal->j_commit_sequence locking

jbd-230-j_commit_request-locking.patch
  implement j_commit_request locking

jbd-240-dual-revoke-tables.patch
  implement dual revoke tables.

jbd-250-remove-sleep_on.patch
  remove remaining sleep_on()s

jbd-300-remove-lock_kernel-journal_c.patch
  remove lock_kernel() calls from journal.c

jbd-310-remove-lock_kernel-transaction_c.patch
  remove lock_kernel calls from transaction.c

jbd-400-remove-lock_journal-checkpoint_c.patch
  remove lock_journal calls from checkpoint.c

jbd-410-remove-lock_journal-commit_c.patch
  remove lock_journal() from commit.c

jbd-420-remove-lock_journal-journal_c.patch
  remove lock_journal() calls from journal.c

jbd-430-remove-lock_journal-transaction_c.patch
  remove lock_journal() calls from transaction.c

jbd-440-remove-lock_journal.patch
  remove lock_journal()

jbd-510-h_credits-fix.patch
  journal_release_buffer: handle credits fix

jbd-520-journal_unmap_buffer-race.patch
  journal_unmap_buffer race fix

jbd-530-walk_page_buffers-race-fix.patch
  ext3_writepage race fix

jbd-540-journal_try_to_free_buffers-race-fix.patch
  buffer freeing non-race comment

jbd-550-locking-checks.patch
  add some locking assertions

jbd-560-transaction-leak-fix.patch
  transaction leak and race fix

jbd-570-transaction-state-locking.patch
  additional transaction shutdown locking

ext3-010-fix-journalled-data.patch
  Remove incorrect assertion from ext3

ext3-020-journal_dirty_metadata-speedup.patch

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

unregister_netdev-cleanup.patch

aio-01-retry.patch
  AIO: Core retry infrastructure

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-05-fs_write-fix.patch

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

aio-poll.patch
  aio_poll
  aio-poll: don't put extern decls in .c!

64-bit-pci_alloc_consistent.patch
  support 64 bit pci_alloc_consistent

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

proc-kcore-rework.patch
  /proc/kcore fixes

syncppp-locking-fix.patch
  syncppp locking fix

s390-dirty-bit-cleaning.patch
  dirty bit clearing on s390.

min_free_kbytes.patch
  /proc/sys/vm/min_free_kbytes

svcsock-use-after-free-fix.patch
  svsock use-after-free fix

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

writev-retval-fix.patch
  Fix writev when a segment generates EFAULT

O_SYNC-speedup.patch
  speed up O_SYNC writes

isdn-typo-fix.patch
  Fixes trivial error in drivers/isdn/hardware/eicon/divamnt.c



