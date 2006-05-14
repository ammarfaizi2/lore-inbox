Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWENQFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWENQFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWENQE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:04:58 -0400
Received: from [63.81.120.158] ([63.81.120.158]:18388 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750820AbWENQE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:04:58 -0400
Date: Sun, 14 May 2006 09:04:50 -0700
Message-Id: <200605141604.k4EG4oQ1005635@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] free_pgtables deadlock 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is a fix for this deadlock .

What's happening is task 2 holds the i_mmap_lock from unmap_region(), then
it enters zap_page_range() where it tried to acquire the locked 
mmu_gathers percpu .

While task 1) holds the mmu_gathers percpu lock from unmap_region() and
then tried to aquire i_mmap_lock inside unlink_file_vma() .

It looks like it's possible to drop the mmu_gathers prior to calling
unlink_file_vma() , but it's only done if there's more than one vma .

This deadlock was seen by Deepak Saxena on an ARM Versatile board.

============================================
[ BUG: circular locking deadlock detected! ]
--------------------------------------------
doio/14636 is deadlocking current task doio/14637


1) doio/14637 is trying to acquire this lock:
 [c74b32f8] {&inode->i_data.i_mmap_lock}
. ->owner: c272cdc2
. held by:              doio:14636 [c272cdc0, 116]
.. acquired at:               unmap_mapping_range+0xe4/0x2c4
.. trying at:                 0x11111111

2) doio/14636 is blocked on this lock:
 [c021c970] {arch/arm/mm/init.c:31}
. ->owner: c272d242
. held by:              doio:14637 [c272d240, 116]
.. acquired at:               unmap_region+0x3c/0x15c

doio/14636's [blocked] stackdump:

[<c01deb00>] (__schedule+0x0/0x6b8) from [<c01df308>] (schedule+0xb8/0x100)
[<c01df250>] (schedule+0x0/0x100) from [<c01e08bc>]
(rt_lock_slowlock+0x178/0x22
4)
 r4 = C021C970
[<c01e0744>] (rt_lock_slowlock+0x0/0x224) from [<c01e0bdc>]
(__lock_text_start+0
x14/0x18)
[<c01e0bc8>] (__lock_text_start+0x0/0x18) from [<c0069df0>]
(zap_page_range+0x38
/0x114)
[<c0069db8>] (zap_page_range+0x0/0x114) from [<c006abe0>]
(unmap_mapping_range_v
ma+0x70/0xe8)
[<c006ab70>] (unmap_mapping_range_vma+0x0/0xe8) from [<c006ae80>]
(unmap_mapping
_range+0x228/0x2c4)
 r7 = C6411B74  r6 = C74B32E8  r5 = C74B3294  r4 = C74B32F8
[<c006ac5c>] (unmap_mapping_range+0x4/0x2c4) from [<c00c5994>]
(nfs_sync_mapping
+0x3c/0x78)
[<c00c5958>] (nfs_sync_mapping+0x0/0x78) from [<c00c5164>]
(do_setlk+0x44/0xec)
 r4 = C1993084
[<c00c5120>] (do_setlk+0x0/0xec) from [<c00c5364>] (nfs_lock+0x158/0x16c)
[<c00c520c>] (nfs_lock+0x0/0x16c) from [<c0094120>]
(fcntl_setlk+0x170/0x2cc)
 r9 = C74B3160  r8 = C752F480  r7 = C1993084  r6 = FFFFFFEA
 r5 = FFFFFFF7  r4 = BEAB1558
[<c0093fb0>] (fcntl_setlk+0x0/0x2cc) from [<c008fb90>]
(do_fcntl+0x294/0x2f4)
[<c008f8fc>] (do_fcntl+0x0/0x2f4) from [<c008fcbc>] (sys_fcntl64+0x7c/0x90)
 r8 = 00000003  r7 = BEAB1558  r6 = C752F480  r5 = 00000007
 r4 = FFFFFFF7
[<c008fc40>] (sys_fcntl64+0x0/0x90) from [<c001fec0>]
(ret_fast_syscall+0x0/0x2c
)
 r8 = C0020064  r7 = 000000DD  r6 = BEAB1558  r5 = 4001EE10
 r4 = 0003B3F8

doio/14637's [current] stackdump:

[<c00243c4>] (dump_stack+0x0/0x24) from [<c0053aac>]
(debug_rt_mutex_print_deadl
ock+0x150/0x194)
[<c005395c>] (debug_rt_mutex_print_deadlock+0x0/0x194) from [<c01e08b8>]
(rt_loc
k_slowlock+0x174/0x224)
 r8 = 00000000  r7 = C006CC0C  r6 = 00000000  r5 = C3EA2000
 r4 = C74B32F8
[<c01e0744>] (rt_lock_slowlock+0x0/0x224) from [<c01e0bdc>]
(__lock_text_start+0
x14/0x18)
[<c01e0bc8>] (__lock_text_start+0x0/0x18) from [<c006cc0c>]
(unlink_file_vma+0x2
c/0x48)
[<c006cbe0>] (unlink_file_vma+0x0/0x48) from [<c0068fb0>]
(free_pgtables+0xc4/0x
170)
 r7 = C6411B74  r6 = 00000000  r5 = C6411B74  r4 = C0268FC0
[<c0068eec>] (free_pgtables+0x0/0x170) from [<c006dd50>]
(unmap_region+0xd4/0x15
c)
[<c006dc7c>] (unmap_region+0x0/0x15c) from [<c006e098>]
(do_munmap+0x1b0/0x224)
[<c006dee8>] (do_munmap+0x0/0x224) from [<c006e834>] (sys_munmap+0x40/0x54)
[<c006e7f4>] (sys_munmap+0x0/0x54) from [<c001fec0>]
(ret_fast_syscall+0x0/0x2c)
 r7 = 0000005B  r6 = 00013538  r5 = 4001EE10  r4 = 0003B3F8
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------


----------------------
| showing all tasks: |
----------------------
S            init:    1 [c03e7b40, 116] (not blocked)
S posix_cpu_timer:    2 [c03e76c0,   0] (not blocked)
S  softirq-high/0:    3 [c03e7240,  98] (not blocked)
S softirq-timer/0:    4 [c03e6dc0,  98] (not blocked)
S softirq-net-tx/:    5 [c03e6940,  98] (not blocked)
S softirq-net-rx/:    6 [c03e64c0,  98] (not blocked)
S softirq-block/0:    7 [c03e6040,  98] (not blocked)
S softirq-tasklet:    8 [c03fdb60,  98] (not blocked)
S      watchdog/0:    9 [c03fd6e0,   0] (not blocked)
S       desched/0:   10 [c03fd260, 105] (not blocked)
S        events/0:   11 [c03fcde0,  98] (not blocked)
S         khelper:   12 [c03fc960, 111] (not blocked)
S         kthread:   13 [c03fc4e0, 111] (not blocked)
S       kblockd/0:   40 [c7c35b40, 114] (not blocked)
S         pdflush:   64 [c7c4c4e0, 115] (not blocked)
S         pdflush:   65 [c7c4c960, 115] (not blocked)
S           aio/0:   67 [c7c4d260, 113] (not blocked)
S         kswapd0:   66 [c7c4cde0, 115] (not blocked)
S         kseriod:  172 [c7c344c0, 110] (not blocked)
S          IRQ 25:  199 [c7c356c0,  50] (not blocked)
S       mtdblockd:  201 [c7d35b40, 125] (not blocked)
S          IRQ 35:  210 [c7d356c0,  51] (not blocked)
S       kpsmoused:  211 [c7d35240, 112] (not blocked)
S          IRQ 36:  213 [c7c34940,  52] (not blocked)
S        rpciod/0:  215 [c7c4d6e0, 110] (not blocked)
S          IRQ 12:  216 [c7c4c060,  53] (not blocked)
S           udevd:  230 [c741f260, 111] (not blocked)
S         portmap:  406 [c7c4db60, 115] (not blocked)
S       rpc.statd:  451 [c741fb60, 118] (not blocked)
S           inetd:  463 [c741e960, 118] (not blocked)
S           mvltd:  467 [c741e4e0, 116] (not blocked)
S           mvltd:  468 [c741ede0, 119] (not blocked)
S           mvltd:  470 [c741e060, 119] (not blocked)
S           mvltd:  471 [c741f6e0, 119] (not blocked)
S           mvltd:  472 [c7d344c0, 119] (not blocked)
S           mvltd:  473 [c7d34dc0, 119] (not blocked)
S            bash:  477 [c7d34040, 117] (not blocked)
S  runalltests.sh:10051 [c7c35240, 116] (not blocked)
S          runltp:10063 [c7c34dc0, 116] (not blocked)
S             pan:10165 [c19dade0, 117] (not blocked)
S         syslogd:14245 [c19dbb60, 115] (not blocked)
S           klogd:14253 [c19db260, 115] (not blocked)
S              sh:14621 [c272c4c0, 119] (not blocked)
S          rwtest:14622 [c272d6c0, 116] (not blocked)
S          rwtest:14633 [c272c940, 119] (not blocked)
S            doio:14634 [c272c040, 118] (not blocked)
?           iogen:14635 [c272db40, 116] (not blocked)
D            doio:14636 [c272cdc0, 116] blocked on: [c021c970]
{arch/arm/mm/init
.c:31}
. ->owner: c272d242
. held by:              doio:14637 [c272d240, 117]
.. acquired at:               unmap_region+0x3c/0x15c
D            doio:14637 [c272d240, 117] blocked on: [c74b32f8]
{&inode->i_data.i
_mmap_lock}
. ->owner: c272cdc2
. held by:              doio:14636 [c272cdc0, 116]
.. acquired at:               unmap_mapping_range+0xe4/0x2c4

-----------------------------------------
| showing all locks held in the system: |
-----------------------------------------
=============================================

[ turning off deadlock detection.Please report this trace. ]



Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/mm/memory.c
===================================================================
--- linux-2.6.16.orig/mm/memory.c
+++ linux-2.6.16/mm/memory.c
@@ -281,7 +281,9 @@ void free_pgtables(struct mmu_gather **t
 
 	if (!vma)	/* Sometimes when exiting after an oops */
 		return;
+#ifndef CONFIG_PREEMPT_RT
 	if (vma->vm_next)
+#endif
 		tlb_finish_mmu(*tlb, tlb_start_addr(*tlb), tlb_end_addr(*tlb));
 	/*
 	 * Hide vma from rmap and vmtruncate before freeeing pgtables,
@@ -292,7 +294,9 @@ void free_pgtables(struct mmu_gather **t
 		unlink_file_vma(unlink);
 		unlink = unlink->vm_next;
 	}
+#ifndef CONFIG_PREEMPT_RT
 	if (vma->vm_next)
+#endif
 		*tlb = tlb_gather_mmu(vma->vm_mm, fullmm);
 #endif
 	while (vma) {
