Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288339AbSAHU5Q>; Tue, 8 Jan 2002 15:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288327AbSAHU5K>; Tue, 8 Jan 2002 15:57:10 -0500
Received: from mail.missioncriticallinux.com ([208.51.139.18]:51214 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S288334AbSAHU45>; Tue, 8 Jan 2002 15:56:57 -0500
Message-ID: <3C3B5D1B.45CBF593@mclinux.com>
Date: Tue, 08 Jan 2002 15:56:59 -0500
From: Dave Anderson <anderson@mclinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.5-15smp2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: anderson@mclinux.com, blinn@mclinux.com
Subject: [BUG][PATCH] 2.4.* mlockall(MCL_FUTURE) is broken -- child inherits 
 VM_LOCKED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.*, mlockall(MCL_FUTURE) is erroneously inherited by child processes
across fork() and exec():

 1. across a fork(), the inherited memory is not locked, but any new memory
    allocations by the child will be VM_LOCKED.
 2. across a subsequent exec(), *all* of the exec'd program's memory except
    for its stack pages will be VM_LOCKED.

The problem is:

 1.  if MCL_FUTURE, mm->def_flags gets set to VM_LOCKED in do_mlockall().
 2.  mm->def_flags is not cleared during subsequent forks and execs.
 3   mm->def_flags, with the leftover VM_LOCKED flag set, is subsequently
     utilized in calc_vm_flags() when called by do_brk() to extend the
     address space of a forked process, and by do_mmap_pgoff() when
     building the non-stack address space of an exec'd process.

The proposed patch puts the fix in mm_init(), which seems to be the most
appropriate place since it's called by copy_mm(), and by mm_alloc() on behalf
of exec_mmap():


# diff -u linux/kernel/fork.c linux-2.4.17/kernel/fork.c
--- linux/kernel/fork.c Tue Jan  8 15:11:13 2002
+++ linux-2.4.17/kernel/fork.c  Tue Jan  8 15:12:26 2002
@@ -219,6 +219,7 @@
        init_rwsem(&mm->mmap_sem);
        mm->page_table_lock = SPIN_LOCK_UNLOCKED;
        mm->pgd = pgd_alloc(mm);
+       mm->def_flags = 0;
        if (mm->pgd)
                return mm;
        free_mm(mm);


Note that it worked OK in 2.2 because mm->def_flags was explicitly cleared in
mm_alloc(), which was called by both copy_mm() and exec_mmap().  But things
were shuffled around a bit in 2.4, and it must have gotten lost in the
translation...

Dave Anderson

==============================================================================
  David Anderson                             anderson@mclinux.com
  Mission Critical Linux, Inc.               http://www.mclinux.com
  100 Foot of John St.                       Work: 978-606-0225
  Lowell, MA 01852                           Fax: 978-446-9470
==============================================================================

