Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268191AbTBXGuW>; Mon, 24 Feb 2003 01:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268194AbTBXGuW>; Mon, 24 Feb 2003 01:50:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:43681 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268191AbTBXGuH>;
	Mon, 24 Feb 2003 01:50:07 -0500
Date: Sun, 23 Feb 2003 23:00:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.62-mm3
Message-Id: <20030223230023.365782f3.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2003 07:00:12.0286 (UTC) FILETIME=[602B49E0:01C2DBD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm3/


. Included Dave McCracken's "Object-based RMAP" patch.

  What this dopey name actually means is that when page reclaim tries to
  unmap a file-backed page it walks the VMAs attached to the address_space
  and the pagetables attached thereto.  So there is no need for pte_chains
  for these pages.

  The patch is simple, but potentially has search complexity problems with
  weird workloads which have high sharing levels.  Allegedly.  Work is
  ongoing.

. Several more anticipatory scheduler tweaks.  This has been an exercise
  in hunting down situations in which the scheduler does the wrong thing, and
  plugging those up.

  The only known problem at this time is a ~20% falloff in threaded
  OLTP-style database activity.  This is really complex, involving
  interactions between reads, O_SYNC writes and i_sem contention.

  The problem will recede to less than 10% when we retune the anticipation
  timer (it is currently set too high just so we can discover these things). 

  But we do not see a sane way of fixing this for real.  At present it will
  need to be manually tuned away with

	echo 0 > /sys/block/hdXX/antic_expire

  Later, we will probably have to perform this disabling automatically.

. There are some performance fixes which will help OLTP-style workloads
  which are using regular old files through the pagecache.  It seems to be
  running maybe 60-70% faster than 2.4.x now, but it varies.

. A few performance patches to reduce the amount of work we do in
  update_atime() and __mark_inode_dirty() should pull back some of the
  regressions which have been observed in there.




Changes since 2.5.62-mm3:

+mm.patch

 Update EXTRAVERSION

-anton-1.patch
-ppc64-timer-fix.patch
-ppc-entry-build-fix.patch
-ppc64-time-warning-fix.patch

 Merged

+user-times-jiffies-wrap-fix.patch

 Jiffy wrapping fix for process time accounting

+slab-batchcount-limit-fix.patch

 Fix the fix for excessive interrupts-off time in debug-enabled slab.

+use-find_get_page.patch

 Cleanup

+irda-interruptible-sleep.patch

 Don't let kIrDAd contribute to load average.
 
+as-hz-1000-fix.patch
+as-tidy-up-rename.patch
+as-update-1.patch
+as-break-anticipation-on-write.patch
+as-break-if-readahead.patch
+as-notice-exit.patch

 Anticipatory scheduler work

+readahead-shrink-to-zero.patch

 Allow readahead to adapt to zero.

+objrmap-2.5.62-5.patch

 VMA-based page unmapping

+kill-bogus-wakeup-messge.patch

 Fix swsusp vs pdflush problem

+dont-sync-with-stopped-pdflush.patch

 swsusp fix

+oprofile-up-fix.patch

 Fix oprofile for uniprocessors

+update_atime-speedup.patch
+ext2-update_atime_speedup.patch
+ext3-update_atime_speedup.patch

 Speed up uddate_atime() and __mark_inode_dirty()

+UPDATE_ATIME-to-update_atime.patch

 Rename UPDATE_ATIME() to update_atime()

+irq-balance-disable-fix.patch

 Fix the disabling of kird

+oom-killer-dont-spin-on-same-task.patch

 Fix the oom-killer

+add-missing-global_flush_tlb-calls.patch

 Add some global TLB flushes around change_page_attr()

+ext3-O_SYNC-speedup.patch

 Speed up ext3 O_SYNC writes

+remove-MAX_BLKDEV-from-genhd.patch

 Clear out some legacy stuff.





All 73 patches

linus.patch
  Latest from Linus

mm.patch
  add -mmN to EXTRAVERSION

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-e100-fix.patch
  fix e100 for big-endian machines

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Subject: 64bit exec

sym-do-160.patch
  make the SYM driver do 160 MB/sec

kgdb.patch

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

deadline-dispatching-fix.patch
  deadline IO scheduler dispatching fix

nfs-unstable-pages.patch
  "unstable" page accounting for NFS.

initial-jiffies.patch
  make jiffies wrap 5 min after boot

user-times-jiffies-wrap-fix.patch
  Fix user time accounting's handling of jiffies wrap

reiserfs_file_write-4.patch
  ReiserFS CPU efficient large writes for  2.5

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

lockd-lockup-fix.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

nfs-sendfile.patch
  Implement sendfile() for NFS

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

put_page-speedup.patch
  hugetlb put_page speedup

linux-isp.patch

isp-update-1.patch

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

slab-batchcount-limit-fix.patch
  Fix slab batchcount limiting code

crc32-speedup-2.patch
  Subject: [PATCH]  crc32 improvements for 2.5, more optimizations

aic-makefile-fix.patch
  aicasm Makefile fix

atm_dev_sem.patch
  convert atm_dev_lock from spinlock to semaphore

flush-tlb-all-2.patch
  flush_tlb_all preempt safety for voyager and x86_64

linux-2.5.62-early_ioremap_A0.patch
  Early ioremap support for ia32

linux-2.5.62-x440disco_A0.patch
  x440 SRAT parsing

use-find_get_page.patch
  use find_get_page() in do_generic_mapping_read()

irda-interruptible-sleep.patch
  Make kIrDAd us interruptible sleep

dget-BUG.patch
  Check for zero d_count in dget()

sysfs-dget-fix.patch
  sysfs dget() fix

disk-accounting-fix.patch
  SARD accounting fix

hugh-inode-pruning-race-fix.patch
  Fix race between umount and iprune

as-iosched.patch
  anticipatory I/O scheduler

as-comments-and-tweaks.patch
  antsched: commentary and

as-hz-1000-fix.patch
  Fix anticipatory scheduler for HZ=100

as-tidy-up-rename.patch
  tidy up AS rename

as-update-1.patch
  AS update

as-break-anticipation-on-write.patch
  AS break on write

as-break-if-readahead.patch
  detect overlapping reads and writes

as-notice-exit.patch
  stop anticipation if a task exits

readahead-shrink-to-zero.patch
  Allow VFS readahead to fall to zero

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

smalldevfs-dcache_rcu-fix.patch
  Subject: Re: 2.5.61-mm1

objrmap-2.5.62-5.patch
  object-based rmap

kill-bogus-wakeup-messge.patch
  swsusp: kill bogus wakeup warning

dont-sync-with-stopped-pdflush.patch
  swsusp: don't sync with stopped pdflush

oprofile-up-fix.patch
  fix oprofile on UP (lockless sync)

update_atime-speedup.patch
  speed up update_atime()

ext2-update_atime_speedup.patch
  Use one_sec_update_atime in ext2

ext3-update_atime_speedup.patch
  Use one_sec_update_atime in ext2

UPDATE_ATIME-to-update_atime.patch
  Rename UPDATE_ATIME to update_atime

irq-balance-disable-fix.patch
  fix IRQ balancing disable controls

oom-killer-dont-spin-on-same-task.patch
  don't let OOM killer kill same process repeatedly

add-missing-global_flush_tlb-calls.patch
  add some missing gloabl_flush_tlb() calls

ext3-O_SYNC-speedup.patch
  ext3: speed up O_SYNC writes

remove-MAX_BLKDEV-from-genhd.patch
  remove MAX_BLKDEV from genhd.c



