Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTA0HBJ>; Mon, 27 Jan 2003 02:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTA0HBJ>; Mon, 27 Jan 2003 02:01:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:10909 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266886AbTA0HBD>;
	Mon, 27 Jan 2003 02:01:03 -0500
Date: Sun, 26 Jan 2003 23:10:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm6
Message-Id: <20030126231015.6ad982e4.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2003 07:10:13.0717 (UTC) FILETIME=[23156050:01C2C5D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm6/

. Some rework and restructuring of the anticipatory scheduling code.

  The reported slowdown in RAID1 rebuild _may_ have been fixed.  At least,
  it doesn't happen for me with this patchset.

. The request aliasing problem hasn't been fixed yet, so this kernel (and
  2.5.59) will still fail under heavy direct-IO load.

. The mysterious "machine hangs late in boot" problem has been narrowed
  down thanks to some great work by Andres Salomon.  The machine is stuck
  waiting on I/O completion when performing the initial lookup for
  /sbin/devfs_helper:

	Thread 11 (Thread 10):
	 #0  io_schedule () at include/asm/atomic.h:122
	 #1  0xc014cd0a in __wait_on_buffer (bh=0xd3fe45b0) at fs/buffer.c:132
	 #2  0xc014dfa6 in __bread_slow (bh=0xd3fe45b0)
	     at include/linux/buffer_head.h:260
	 #3  0xc014e1c8 in __bread (bdev=0x0, block=0, size=0) at fs/buffer.c:1385
	 #4  0xc0181774 in ext3_get_inode_loc (inode=0xd3d697bc, iloc=0xd3d13ce0)
	     at include/linux/buffer_head.h:235
	 #5  0xc0181841 in ext3_read_inode (inode=0xd3d697bc) at fs/ext3/inode.c:2205
	 #6  0xc0183db4 in ext3_lookup (dir=0x0, dentry=0xd3d4cae0)
	     at include/linux/fs.h:1199
	 #7  0xc01585fb in real_lookup (parent=0xd3d4cce0, name=0xd3d13d94, flags=0)
	     at fs/namei.c:372
	 #8  0xc0158849 in do_lookup (nd=0xd3d4cae0, name=0xd3d13d94, path=0xd3d13d84,
	     cached_path=0xd3d13d8c, flags=-1071144428) at fs/namei.c:537
	 #9  0xc01589ef in link_path_walk (name=0x0, nd=0xd3d13dc8) at fs/namei.c:651
	 #10 0xc01558c1 in open_exec (name=0x0) at fs/exec.c:454
	 #11 0xc0156200 in do_execve (filename=0xd3d6d000 "/sbin/devfs_helper",
	     argv=0xc133bd08, envp=0xd3d13dc8, regs=0x0) at fs/exec.c:1032
	 #12 0xc0107e0d in sys_execve (regs=
	       {ebx = -1071125472, ecx = -1053573880, edx = -1071125308, esi =
	 -740448672, edi = 0, ebp = -741261356, eax = 11, xds = -1072562053,

  Which _looks_ like a request queueing problem, but Andres says it goes
  away when devfs is disabled in config.  So I've dropped the smalldevfs
  patch for now - would be appreciated if devfs users could retest this
  patch, with CONFIG_DEVFS=y.

. There appears to be a CPU utilisation problem with
  reiserfs_file_write.patch - but it doesn't oops or corrupt data so I've
  left that in for now while Oleg scratches his head over that one.


Changes since 2.5.59-mm5:

-devfs-fix.patch

 This might have caused interactions with Adam's patch (which isn't here
 anyway), so leave it out.

+sync-fix.patch

 Fix rare data loss problem with ext2 and heavy use of sync()

+direct-io-ENOSPC-fix.patch

 Fix inode accounting error which occurs when an O_DIRECT write hits ENOSPC.

+frlock-xtime.patch
+frlock-xtime-i386.patch
+frlock-xtime-ia64.patch
+frlock-xtime-other.patch

 An alternative version of the lockless gettimeofday() patch.  Needs testing
 on other architectures.

+inode-accounting-race-fix.patch

 Fix SMP race in i_blocks/i_bytes accounting.

-lockless-current_kernel_time.patch

 Replaced by the frlock version.

+agp-warning-fix.patch

 Fix a warning

+slab-poisoning-fix.patch

 Slab debug fix

+modversions.patch

 Resurrect module versioning support

+pcmcia_timer_init.patch

 Timer initialisation fixes

+no_space_in_slabnames.patch

 /proc/slabinfo sanity

+epoll-update.patch

 Latest from Davide (I think.  May be latest-but-one)

+hash-warnings.patch

 Compile warnings.

+discarded-section-fix.patch

 Build fix

-smalldevfs.patch

 Might be causing the boot hangs

+atyfb-compile-fix.patch

 Build fix

+floppy-locking-fix.patch

 Floppy forgot to take queue_lock

+lost-tick.patch

 Kep time going forward when someone disables interrupts for ages

-exit_mmap-fix-ppc64.patch
-exit_mmap-ia64-fix.patch
+exit_mmap-fix-47.patch

 Yet another take on the TASK_SIZE fix for exit_mmap()

 anticipatory_io_scheduling-2_5_59-mm3.patch
+ant-cleanup.patch
+antsched-update-1.patch

 Anticipatory scheduler changes



All 82 patches:

kgdb.patch

sync-fix.patch
  Fix data loss problem due to sys_sync

direct-io-ENOSPC-fix.patch
  direct-IO: fix i_size handling on ENOSPC

frlock-xtime.patch
  fast reader locks for gettimeofday() and friends

frlock-xtime-i386.patch

frlock-xtime-ia64.patch

frlock-xtime-other.patch

inode-accounting-race-fix.patch
  Fix inode size accounting race

vmlinux-fix.patch
  vmlinux fix

maestro-fix.patch
  Compile fix in sound/oss/maestro.c

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

scheduler-tunables.patch
  scheduler tunables

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

kirq.patch

kirq-up-fix.patch
  Subject: Re: 2.5.59-mm1

agp-warning-fix.patch
  fix agp compile warning

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

slab-poisoning-fix.patch
  slab poison checking fix

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

modversions.patch
  Subject: [PATCH] new modversions

pcmcia_timer_init.patch
  pcmcia timer initialisation fixes

no_space_in_slabnames.patch
  remove spaces from slab names

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

epoll-update.patch
  epoll timeout and syscall return types ...

topology-remove-underbars.patch
  Remove __ from topology macros

mandlock-oops-fix.patch
  ftruncate/truncate oopses with mandatory locking

put_user-warning-fix.patch
  Subject: Re: Linux 2.5.59

hash-warnings.patch
  fix #warning's

discarded-section-fix.patch
  Subject: [PATCH] discarded section errors (2.5.59)

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

atyfb-compile-fix.patch
  atyfb compilation fix

floppy-locking-fix.patch
  floppy locking fix

lost-tick.patch
  Lost tick compensation

sound-firmware-load-fix.patch
  soundcore.c referenced non-existent errno variable

generic_file_readonly_mmap-fix.patch
  Fix generic_file_readonly_mmap()

seq_file-page-defn.patch
  Include <asm/page.h> in fs/seq_file.c, as it uses PAGE_SIZE

exit_mmap-fix-47.patch

show_task-fix.patch
  Subject: [PATCH] 2.5.59: show_task() oops

scsi-iothread.patch
  scsi_eh_* needs to run even during suspend

numaq-ioapic-fix2.patch
  NUMAQ io_apic programming fix

misc.patch
  misc fixes

writeback-sync-cleanup.patch
  Remove unneeded code in fs/fs-writeback.c

dont-wait-on-inode.patch
  Fix latencies during writeback

unlink-latency-fix.patch
  fix i_sem contention in sys_unlink()

anticipatory_io_scheduling-2_5_59-mm3.patch
  Subject: [PATCH] 2.5.59-mm3 antic io sched

ant-cleanup.patch

antsched-update-1.patch
  Subject: [PATCH] 2.5.59-snap2 updates


