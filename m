Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTAXDlZ>; Thu, 23 Jan 2003 22:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbTAXDlZ>; Thu, 23 Jan 2003 22:41:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:40126 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267510AbTAXDlT>;
	Thu, 23 Jan 2003 22:41:19 -0500
Date: Thu, 23 Jan 2003 19:50:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm5
Message-Id: <20030123195044.47c51d39.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 03:50:22.0897 (UTC) FILETIME=[B8C23210:01C2C35B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm5/

.  -mm3 and -mm4 were not announced - they were sync-up patches as we
  worked on the I/O scheduler.

.  -mm5 has the first cut of Nick Piggin's anticipatory I/O scheduler.
  Here's the scoop:

  The problem being addressed here is (mainly) kernel behaviour when there
  is a stream of writeout happening, and someone submits a read.

  In 2.4.x, the disk queues contain up to 30 megabytes of writes (say, one
  seconds's worth).  When a read is submitted the 2.4 I/O scheduler will try
  to insert that at the right place between the writes.  Usually, there is no
  right place and the read is appended to the queue.  That is: it will be
  serviced in one second.

  But the problem with reads is that they are dependent - neither the
  application nor the kernel can submit read #N until read #N-1 has
  completed.  So something as simple as

	cat /usr/src/linux/kernel/*.c > /dev/null

  requires several hundred dependent reads.  And in the presence of a
  streaming write, each and every one of those reads gets stuck at the end of
  the queue, and takes a second to propagate to the head.  The `cat' takes
  hundreds of seconds.

  The celebrated read-latency2 patch recognises the fact that appending a
  read to a tail of writes is dumb, and puts the read near the head of the
  queue of writes.  It provides an improvement of up to 30x.  The deadline
  I/O scheduler in 2.5 does the same thing: if reads are queued up, promote
  them past writes, even if those writes have been waiting longer.


  So far so good, but these fixes are still dumb.  Because we're solving
  the dependent read problem by creating a seek storm.  Every time someone
  submits a read, we stop writing, seek over and service the read, and then
  *immediately* seek back and start servicing writes again.

  But in the common case, the application which submitted a read is about
  to go and submit another one, closeby on-disk to the first.  So whoops, we
  have to seek back to service that one as well.


  So what anticipatory scheduling does is very simple: if an application
  has performed a read, do *nothing at all* for a few milliseconds.  Just
  return to userspace (or to the filesystem) in the expectation that the
  application or filesystem will quickly submit another read which is
  closeby.

  If the application _does_ submit the read then fine - we service that
  quickly.  If it does not submit a read then we lose.  Time out and go back
  to doing writes.

  The end result is a large reduction in seeking - decreased read latency,
  increased read bandwidth and increased write bandwidth.


  The code as-is has rough spots and still needs quite some work.  But it
  appears to be stable.  The test which I have concentrated on is "how long
  does my laptop take to compile util-linux when there is a continuous write
  happening".  On ext2, mounted noatime:

	2.4.20:                 538 seconds
	2.5.59:                 400 seconds
	2.5.59-mm5:             70 seconds
	No streaming write:     48 seconds

  A couple of VFS changes were needed as well.

  More details on anticipatory scheduling may be found at

	http://www.cs.rice.edu/~ssiyer/r/antsched/




Changes since 2.5.59-mm2:


+preempt-locking.patch

 Speed up the smp preempt locking.

+ext2-allocation-failure-fix.patch

 ext2 ENOSPC crash fix

+ext2_new_block-fixes.patch

 ext2 cleanups

+hangcheck-timer.patch

 A form of software watchdog

+slab-irq-fix.patch

 Fix a BUG() in slab when memory exhaustion happens at a bad time.

+sendfile-security-hooks.patch

 Reinstate lost security hooks around sendfile()

+buffer-io-accounting.patch

 Fix IO-wait acounting

+aic79xx-linux-2.5.59-20030122.patch

 aic7xxx driver update

+topology-remove-underbars.patch

 cleanup

+mandlock-oops-fix.patch

 file locking fix

+reiserfs_file_write.patch

 reworked reiserfs write code.

-exit_mmap-fix2.patch

 Dropped

+generic_file_readonly_mmap-fix.patch

 Fix MAP_PRIVATE mmaps for filesystems which don't support ->writepage()

+seq_file-page-defn.patch

 Compile fix

+exit_mmap-fix-ppc64.patch
+exit_mmap-ia64-fix.patch

 Fix the exit_mmap() problem in arch code.

+show_task-fix.patch

 Fix oops in show_task()

+scsi-iothread.patch

 software suspend fix

+numaq-ioapic-fix2.patch

 NUMAQ stuff

+misc.patch

 Random fixes

+writeback-sync-cleanup.patch

 remove some junk from fs-writeback.c

+dont-wait-on-inode.patch

 Fix large delays in the writeback path

+unlink-latency-fix.patch

 Fix large delays in unlink()

+anticipatory_io_scheduling-2_5_59-mm3.patch

 Anticipatory scheduling implementation



All 65 patches:


kgdb.patch

devfs-fix.patch

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

setuid-exec-no-lock_kernel.patch
  remove lock_kernel() from exec of setuid apps

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

fadvise.patch
  implement posix_fadvise64()

ext3-scheduling-storm.patch
  ext3: fix scheduling storm and lockups

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

lockless-current_kernel_time.patch
  Lockless current_kernel_timer()

scheduler-tunables.patch
  scheduler tunables

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

kirq.patch

kirq-up-fix.patch
  Subject: Re: 2.5.59-mm1

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

prune-icache-stats.patch
  add stats for page reclaim via inode freeing

vma-file-merge.patch

mmap-whitespace.patch

read_cache_pages-cleanup.patch
  cleanup in read_cache_pages()

remove-GFP_HIGHIO.patch
  remove __GFP_HIGHIO

quota-lockfix.patch
  quota locking fix

quota-offsem.patch
  quota semaphore fix

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

preempt-locking.patch
  Subject: spinlock efficiency problem [was 2.5.57 IO slowdown with CONFIG_PREEMPT enabled)

wli-11_pgd_ctor.patch
  (undescribed patch)

wli-11_pgd_ctor-update.patch
  pgd_ctor update

stack-overflow-fix.patch
  stack overflow checking fix

ext2-allocation-failure-fix.patch
  Subject: [PATCH] ext2 allocation failures

ext2_new_block-fixes.patch
  ext2_new_block cleanups and fixes

hangcheck-timer.patch
  hangcheck-timer

slab-irq-fix.patch
  slab IRQ fix

Richard_Henderson_for_President.patch
  Subject: [PATCH] Richard Henderson for President!

parenthesise-pgd_index.patch
  Subject: i386 pgd_index() doesn't parenthesize its arg

sendfile-security-hooks.patch
  Subject: [RFC][PATCH] Restore LSM hook calls to sendfile

macro-double-eval-fix.patch
  Subject: Re: i386 pgd_index() doesn't parenthesize its arg

mmzone-parens.patch
  asm-i386/mmzone.h macro paren/eval fixes

blkdev-fixes.patch
  blkdev.h fixes

remove-will_become_orphaned_pgrp.patch
  remove will_become_orphaned_pgrp()

buffer-io-accounting.patch
  correct wait accounting in wait_on_buffer()

aic79xx-linux-2.5.59-20030122.patch
  aic7xxx update

MAX_IO_APICS-ifdef.patch
  MAX_IO_APICS #ifdef'd wrongly

dac960-error-retry.patch
  Subject: [PATCH] linux2.5.56 patch to DAC960 driver for error retry

topology-remove-underbars.patch
  Remove __ from topology macros

mandlock-oops-fix.patch
  ftruncate/truncate oopses with mandatory locking

put_user-warning-fix.patch
  Subject: Re: Linux 2.5.59

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

vmlinux-fix.patch
  vmlinux fix

smalldevfs.patch
  smalldevfs

sound-firmware-load-fix.patch
  soundcore.c referenced non-existent errno variable

generic_file_readonly_mmap-fix.patch
  Fix generic_file_readonly_mmap()

seq_file-page-defn.patch
  Include <asm/page.h> in fs/seq_file.c, as it uses PAGE_SIZE

exit_mmap-fix-ppc64.patch

exit_mmap-ia64-fix.patch
  Fix ia64's 64bit->32bit app switching

show_task-fix.patch
  Subject: [PATCH] 2.5.59: show_task() oops

scsi-iothread.patch
  scsi_eh_* needs to run even during suspend

numaq-ioapic-fix2.patch
  NUMAQ io_apic programming fix

misc.patch
  misc fixes

writeback-sync-cleanup.patch

dont-wait-on-inode.patch

unlink-latency-fix.patch

anticipatory_io_scheduling-2_5_59-mm3.patch
  Subject: [PATCH] 2.5.59-mm3 antic io sched


