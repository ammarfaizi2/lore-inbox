Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUIXIGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUIXIGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268538AbUIXIGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:06:38 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:31969 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S268537AbUIXIC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:02:56 -0400
Date: Fri, 24 Sep 2004 01:02:44 -0700
Message-Id: <200409240802.i8O82ics013407@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Fcc: ~/Mail/linus
Subject: [PATCH] make rlimit settings per-process instead of per-thread
X-Shopping-List: (1) Despondent compliant Johnny Carson wigs
   (2) Fastidious snore malnutrition
   (3) Gallant digressions
   (4) Respectable climate cows
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX specifies that the limit settings provided by getrlimit/setrlimit are
shared by the whole process, not specific to individual threads.  This
patch changes the behavior of those calls to comply with POSIX.  

I've moved the struct rlimit array from task_struct to signal_struct, as it
has the correct sharing properties.  (This reduces kernel memory usage per
thread in multithreaded processes by around 100/200 bytes for 32/64
machines respectively.)  I took a fairly minimal approach to the locking
issues with the newly shared struct rlimit array.  It turns out that all
the code that is checking limits really just needs to look at one word at a
time (one rlim_cur field, usually).  It's only the few places like
getrlimit itself (and fork), that require atomicity in accessing a whole
struct rlimit, so I just used a spin lock for them and no locking for most
of the checks.  If it turns out that readers of struct rlimit need more
atomicity where they are now cheap, or less overhead where they are now
atomic (e.g. fork), then seqcount is certainly the right thing to use for
them instead of readers using the spin lock.  Though it's in signal_struct,
I didn't use siglock since the access to rlimits never needs to disable
irqs and doesn't overlap with other siglock uses.  Instead of adding
something new, I overloaded task_lock(task->group_leader) for this; it is
used for other things that are not likely to happen simultaneously with
limit tweaking.  To me that seems preferable to adding a word, but it would
be trivial (and arguably cleaner) to add a separate lock for these users
(or e.g. just use seqlock, which adds two words but is optimal for readers).

Most of the changes here are just the trivial s/->rlim/->signal->rlim/. 

I stumbled across what must be a long-standing bug, in reparent_to_init.
It does:
	memcpy(current->rlim, init_task.rlim, sizeof(*(current->rlim)));
when surely it was intended to be:
	memcpy(current->rlim, init_task.rlim, sizeof(current->rlim));
As rlim is an array, the * in the sizeof expression gets the size of the
first element, so this just changes the first limit (RLIMIT_CPU).  This is
for kernel threads, where it's clear that resetting all the rlimits is what
you want.  With that fixed, the setting of RLIMIT_FSIZE in nfsd is
superfluous since it will now already have been reset to RLIM_INFINITY.

The other subtlety is removing:
	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
in exit_notify, which was to avoid a race signalling during self-reaping
exit.  As the limit is now shared, a dying thread should not change it for
others.  Instead, I avoid that race by checking current->state before the
RLIMIT_CPU check.  (Adding one new conditional in that path is now required
one way or another, since if not for this check there would also be a new
race with self-reaping exit later on clearing current->signal that would
have to be checked for.)

The one loose end left by this patch is with process accounting.
do_acct_process temporarily resets the RLIMIT_FSIZE limit while writing the
accounting record.  I left this as it was, but it is now changing a limit
that might be shared by other threads still running.  I left this in a
dubious state because it seems to me that processing accounting may already
be more generally a dubious state when it comes to NPTL threads.  I would
think you would want one record per process, with aggregate data about all
threads that ever lived in it, not a separate record for each thread.  
I don't use process accounting myself, but if anyone is interested in
testing it out I could provide a patch to change it this way.

One final note, this is not 100% to POSIX compliance in regards to rlimits.
POSIX specifies that RLIMIT_CPU refers to a whole process in aggregate, not
to each individual thread.  I will provide patches later on to achieve that
change, assuming this patch goes in first.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/arch/i386/mm/mmap.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/i386/mm/mmap.c,v
retrieving revision 1.3
diff -b -p -u -r1.3 mmap.c
--- linux-2.6/arch/i386/mm/mmap.c 24 Aug 2004 18:12:13 -0000 1.3
+++ linux-2.6/arch/i386/mm/mmap.c 24 Sep 2004 05:46:26 -0000
@@ -37,7 +37,7 @@
 
 static inline unsigned long mmap_base(struct mm_struct *mm)
 {
-	unsigned long gap = current->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
@@ -59,7 +59,7 @@ void arch_pick_mmap_layout(struct mm_str
 	 */
 	if (sysctl_legacy_va_layout ||
 			(current->personality & ADDR_COMPAT_LAYOUT) ||
-			current->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY) {
+			current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY) {
 		mm->mmap_base = TASK_UNMAPPED_BASE;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 		mm->unmap_area = arch_unmap_area;
Index: linux-2.6/arch/ia64/kernel/perfmon.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/ia64/kernel/perfmon.c,v
retrieving revision 1.56
diff -b -p -u -r1.56 perfmon.c
--- linux-2.6/arch/ia64/kernel/perfmon.c 3 Sep 2004 16:26:43 -0000 1.56
+++ linux-2.6/arch/ia64/kernel/perfmon.c 24 Sep 2004 05:46:26 -0000
@@ -2283,10 +2283,10 @@ pfm_smpl_buffer_alloc(struct task_struct
 	 * XXX: may have to refine this test
 	 * Check against address space limit.
 	 *
-	 * if ((mm->total_vm << PAGE_SHIFT) + len> task->rlim[RLIMIT_AS].rlim_cur)
+	 * if ((mm->total_vm << PAGE_SHIFT) + len> task->signal->rlim[RLIMIT_AS].rlim_cur)
 	 * 	return -ENOMEM;
 	 */
-	if (size > task->rlim[RLIMIT_MEMLOCK].rlim_cur) return -EAGAIN;
+	if (size > task->signal->rlim[RLIMIT_MEMLOCK].rlim_cur) return -EAGAIN;
 
 	/*
 	 * We do the easy to undo allocations first.
Index: linux-2.6/arch/ia64/kernel/sys_ia64.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/ia64/kernel/sys_ia64.c,v
retrieving revision 1.26
diff -b -p -u -r1.26 sys_ia64.c
--- linux-2.6/arch/ia64/kernel/sys_ia64.c 13 Apr 2004 01:50:49 -0000 1.26
+++ linux-2.6/arch/ia64/kernel/sys_ia64.c 24 Sep 2004 05:46:26 -0000
@@ -138,7 +138,7 @@ ia64_brk (unsigned long brk)
 		goto out;
 
 	/* Check against rlimit.. */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
 		goto out;
 
Index: linux-2.6/arch/ia64/mm/fault.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/ia64/mm/fault.c,v
retrieving revision 1.20
diff -b -p -u -r1.20 fault.c
--- linux-2.6/arch/ia64/mm/fault.c 8 Sep 2004 14:48:45 -0000 1.20
+++ linux-2.6/arch/ia64/mm/fault.c 24 Sep 2004 05:46:26 -0000
@@ -32,8 +32,8 @@ expand_backing_store (struct vm_area_str
 	unsigned long grow;
 
 	grow = PAGE_SIZE >> PAGE_SHIFT;
-	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur
-	    || (((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur))
+	if (address - vma->vm_start > current->signal->rlim[RLIMIT_STACK].rlim_cur
+	    || (((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->signal->rlim[RLIMIT_AS].rlim_cur))
 		return -ENOMEM;
 	vma->vm_end += PAGE_SIZE;
 	vma->vm_mm->total_vm += grow;
Index: linux-2.6/arch/ia64/mm/init.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/ia64/mm/init.c,v
retrieving revision 1.51
diff -b -p -u -r1.51 init.c
--- linux-2.6/arch/ia64/mm/init.c 22 Sep 2004 04:16:22 -0000 1.51
+++ linux-2.6/arch/ia64/mm/init.c 24 Sep 2004 05:46:26 -0000
@@ -98,7 +98,7 @@ update_mmu_cache (struct vm_area_struct 
 inline void
 ia64_set_rbs_bot (void)
 {
-	unsigned long stack_size = current->rlim[RLIMIT_STACK].rlim_max & -16;
+	unsigned long stack_size = current->signal->rlim[RLIMIT_STACK].rlim_max & -16;
 
 	if (stack_size > MAX_USER_STACK_SIZE)
 		stack_size = MAX_USER_STACK_SIZE;
Index: linux-2.6/arch/mips/kernel/irixelf.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/mips/kernel/irixelf.c,v
retrieving revision 1.12
diff -b -p -u -r1.12 irixelf.c
--- linux-2.6/arch/mips/kernel/irixelf.c 10 May 2004 20:52:56 -0000 1.12
+++ linux-2.6/arch/mips/kernel/irixelf.c 24 Sep 2004 05:46:27 -0000
@@ -1055,7 +1055,7 @@ static int irix_core_dump(long signr, st
 	struct vm_area_struct *vma;
 	struct elfhdr elf;
 	off_t offset = 0, dataoff;
-	int limit = current->rlim[RLIMIT_CORE].rlim_cur;
+	int limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
 	int numnote = 4;
 	struct memelfnote notes[4];
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
Index: linux-2.6/arch/mips/kernel/sysirix.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/mips/kernel/sysirix.c,v
retrieving revision 1.28
diff -b -p -u -r1.28 sysirix.c
--- linux-2.6/arch/mips/kernel/sysirix.c 31 Aug 2004 17:35:38 -0000 1.28
+++ linux-2.6/arch/mips/kernel/sysirix.c 24 Sep 2004 05:46:27 -0000
@@ -128,16 +128,21 @@ asmlinkage int irix_prctl(struct pt_regs
 		if (value > RLIM_INFINITY)
 			value = RLIM_INFINITY;
 		if (capable(CAP_SYS_ADMIN)) {
-			current->rlim[RLIMIT_STACK].rlim_max =
-				current->rlim[RLIMIT_STACK].rlim_cur = value;
+			task_lock(current->group_leader);
+			current->signal->rlim[RLIMIT_STACK].rlim_max =
+				current->signal->rlim[RLIMIT_STACK].rlim_cur = value;
+			task_unlock(current->group_leader);
 			error = value;
 			break;
 		}
-		if (value > current->rlim[RLIMIT_STACK].rlim_max) {
+		task_lock(current->group_leader);
+		if (value > current->signal->rlim[RLIMIT_STACK].rlim_max) {
 			error = -EINVAL;
+			task_unlock(current->group_leader);
 			break;
 		}
-		current->rlim[RLIMIT_STACK].rlim_cur = value;
+		current->signal->rlim[RLIMIT_STACK].rlim_cur = value;
+		task_unlock(current->group_leader);
 		error = value;
 		break;
 	}
@@ -145,7 +150,7 @@ asmlinkage int irix_prctl(struct pt_regs
 	case PR_GETSTACKSIZE:
 		printk("irix_prctl[%s:%d]: Wants PR_GETSTACKSIZE\n",
 		       current->comm, current->pid);
-		error = current->rlim[RLIMIT_STACK].rlim_cur;
+		error = current->signal->rlim[RLIMIT_STACK].rlim_cur;
 		break;
 
 	case PR_MAXPPROCS:
@@ -558,7 +563,7 @@ asmlinkage int irix_brk(unsigned long br
 	/*
 	 * Check against rlimit and stack..
 	 */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (brk - mm->end_code > rlim) {
@@ -2132,7 +2137,7 @@ asmlinkage int irix_ulimit(int cmd, int 
 		retval = -EINVAL;
 		goto out;
 #endif
-		retval = current->rlim[RLIMIT_NOFILE].rlim_cur;
+		retval = current->signal->rlim[RLIMIT_NOFILE].rlim_cur;
 		goto out;
 
 	case 5:
Index: linux-2.6/arch/ppc64/mm/mmap.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/ppc64/mm/mmap.c,v
retrieving revision 1.2
diff -b -p -u -r1.2 mmap.c
--- linux-2.6/arch/ppc64/mm/mmap.c 24 Aug 2004 18:12:38 -0000 1.2
+++ linux-2.6/arch/ppc64/mm/mmap.c 24 Sep 2004 05:46:27 -0000
@@ -37,7 +37,7 @@
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
@@ -58,7 +58,7 @@ static inline int mmap_is_legacy(void)
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
 
-	if (current->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY)
+	if (current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY)
 		return 1;
 
 	return sysctl_legacy_va_layout;
Index: linux-2.6/arch/s390/mm/mmap.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/s390/mm/mmap.c,v
retrieving revision 1.2
diff -b -p -u -r1.2 mmap.c
--- linux-2.6/arch/s390/mm/mmap.c 24 Aug 2004 18:12:26 -0000 1.2
+++ linux-2.6/arch/s390/mm/mmap.c 24 Sep 2004 05:46:27 -0000
@@ -37,7 +37,7 @@
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
@@ -58,7 +58,7 @@ static inline int mmap_is_legacy(void)
 #endif
 	return sysctl_legacy_va_layout ||
 	    (current->personality & ADDR_COMPAT_LAYOUT) ||
-	    current->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY;
+	    current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY;
 }
 
 /*
Index: linux-2.6/arch/sparc/kernel/sys_sunos.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/sparc/kernel/sys_sunos.c,v
retrieving revision 1.34
diff -b -p -u -r1.34 sys_sunos.c
--- linux-2.6/arch/sparc/kernel/sys_sunos.c 13 Jul 2004 18:02:45 -0000 1.34
+++ linux-2.6/arch/sparc/kernel/sys_sunos.c 24 Sep 2004 05:46:27 -0000
@@ -178,7 +178,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * Check against rlimit and stack..
 	 */
 	retval = -ENOMEM;
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (brk - current->mm->end_code > rlim)
Index: linux-2.6/arch/sparc64/kernel/binfmt_aout32.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/sparc64/kernel/binfmt_aout32.c,v
retrieving revision 1.13
diff -b -p -u -r1.13 binfmt_aout32.c
--- linux-2.6/arch/sparc64/kernel/binfmt_aout32.c 27 Jul 2004 04:01:08 -0000 1.13
+++ linux-2.6/arch/sparc64/kernel/binfmt_aout32.c 24 Sep 2004 05:46:27 -0000
@@ -102,12 +102,12 @@ static int aout32_core_dump(long signr, 
 /* If the size of the dump file exceeds the rlimit, then see what would happen
    if we wrote the stack, but not the data area.  */
 	if ((dump.u_dsize+dump.u_ssize) >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_dsize = 0;
 
 /* Make sure we have enough room to write the stack and data areas. */
 	if ((dump.u_ssize) >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_ssize = 0;
 
 /* make sure we actually have a data and stack area to dump */
@@ -218,7 +218,7 @@ static int load_aout32_binary(struct lin
 	 * size limits imposed on them by creating programs with large
 	 * arrays in the data or bss.
 	 */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (ex.a_data + ex.a_bss > rlim)
Index: linux-2.6/arch/sparc64/kernel/sys_sunos32.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/sparc64/kernel/sys_sunos32.c,v
retrieving revision 1.45
diff -b -p -u -r1.45 sys_sunos32.c
--- linux-2.6/arch/sparc64/kernel/sys_sunos32.c 13 Jul 2004 18:02:33 -0000 1.45
+++ linux-2.6/arch/sparc64/kernel/sys_sunos32.c 24 Sep 2004 05:46:27 -0000
@@ -142,7 +142,7 @@ asmlinkage int sunos_brk(u32 baddr)
 	}
 	/* Check against rlimit and stack.. */
 	retval = -ENOMEM;
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (brk - current->mm->end_code > rlim)
Index: linux-2.6/arch/sparc64/solaris/fs.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/sparc64/solaris/fs.c,v
retrieving revision 1.21
diff -b -p -u -r1.21 fs.c
--- linux-2.6/arch/sparc64/solaris/fs.c 27 Jul 2004 04:00:57 -0000 1.21
+++ linux-2.6/arch/sparc64/solaris/fs.c 24 Sep 2004 05:46:27 -0000
@@ -600,23 +600,23 @@ asmlinkage int solaris_ulimit(int cmd, i
 {
 	switch (cmd) {
 	case 1: /* UL_GETFSIZE - in 512B chunks */
-		return current->rlim[RLIMIT_FSIZE].rlim_cur >> 9;
+		return current->signal->rlim[RLIMIT_FSIZE].rlim_cur >> 9;
 	case 2: /* UL_SETFSIZE */
 		if ((unsigned long)val > (LONG_MAX>>9)) return -ERANGE;
 		val <<= 9;
-		lock_kernel();
-		if (val > current->rlim[RLIMIT_FSIZE].rlim_max) {
+		task_lock(current->group_leader);
+		if (val > current->signal->rlim[RLIMIT_FSIZE].rlim_max) {
 			if (!capable(CAP_SYS_RESOURCE)) {
-				unlock_kernel();
+				task_unlock(current->group_leader);
 				return -EPERM;
 			}
-			current->rlim[RLIMIT_FSIZE].rlim_max = val;
+			current->signal->rlim[RLIMIT_FSIZE].rlim_max = val;
 		}
-		current->rlim[RLIMIT_FSIZE].rlim_cur = val;
-		unlock_kernel();
+		current->signal->rlim[RLIMIT_FSIZE].rlim_cur = val;
+		task_unlock(current->group_leader);
 		return 0;
 	case 3: /* UL_GMEMLIM */
-		return current->rlim[RLIMIT_DATA].rlim_cur;
+		return current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	case 4: /* UL_GDESLIM */
 		return NR_OPEN;
 	}
Index: linux-2.6/arch/x86_64/ia32/ia32_aout.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/ia32/ia32_aout.c,v
retrieving revision 1.5
diff -b -p -u -r1.5 ia32_aout.c
--- linux-2.6/arch/x86_64/ia32/ia32_aout.c 14 Jul 2004 16:37:27 -0000 1.5
+++ linux-2.6/arch/x86_64/ia32/ia32_aout.c 24 Sep 2004 05:46:27 -0000
@@ -168,12 +168,12 @@ static int aout_core_dump(long signr, st
 /* If the size of the dump file exceeds the rlimit, then see what would happen
    if we wrote the stack, but not the data area.  */
 	if ((dump.u_dsize+dump.u_ssize+1) * PAGE_SIZE >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_dsize = 0;
 
 /* Make sure we have enough room to write the stack and data areas. */
 	if ((dump.u_ssize+1) * PAGE_SIZE >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_ssize = 0;
 
 /* make sure we actually have a data and stack area to dump */
@@ -281,7 +281,7 @@ static int load_aout_binary(struct linux
 	 * size limits imposed on them by creating programs with large
 	 * arrays in the data or bss.
 	 */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (ex.a_data + ex.a_bss > rlim)
Index: linux-2.6/fs/binfmt_aout.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/binfmt_aout.c,v
retrieving revision 1.25
diff -b -p -u -r1.25 binfmt_aout.c
--- linux-2.6/fs/binfmt_aout.c 24 Aug 2004 18:11:50 -0000 1.25
+++ linux-2.6/fs/binfmt_aout.c 24 Sep 2004 05:46:27 -0000
@@ -118,22 +118,22 @@ static int aout_core_dump(long signr, st
    if we wrote the stack, but not the data area.  */
 #ifdef __sparc__
 	if ((dump.u_dsize+dump.u_ssize) >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_dsize = 0;
 #else
 	if ((dump.u_dsize+dump.u_ssize+1) * PAGE_SIZE >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_dsize = 0;
 #endif
 
 /* Make sure we have enough room to write the stack and data areas. */
 #ifdef __sparc__
 	if ((dump.u_ssize) >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_ssize = 0;
 #else
 	if ((dump.u_ssize+1) * PAGE_SIZE >
-	    current->rlim[RLIMIT_CORE].rlim_cur)
+	    current->signal->rlim[RLIMIT_CORE].rlim_cur)
 		dump.u_ssize = 0;
 #endif
 
@@ -278,7 +278,7 @@ static int load_aout_binary(struct linux
 	 * size limits imposed on them by creating programs with large
 	 * arrays in the data or bss.
 	 */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (ex.a_data + ex.a_bss > rlim)
Index: linux-2.6/fs/binfmt_elf.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/binfmt_elf.c,v
retrieving revision 1.89
diff -b -p -u -r1.89 binfmt_elf.c
--- linux-2.6/fs/binfmt_elf.c 23 Sep 2004 01:24:06 -0000 1.89
+++ linux-2.6/fs/binfmt_elf.c 24 Sep 2004 05:46:27 -0000
@@ -1314,7 +1314,7 @@ static int elf_core_dump(long signr, str
 	struct vm_area_struct *vma;
 	struct elfhdr *elf = NULL;
 	off_t offset = 0, dataoff;
-	unsigned long limit = current->rlim[RLIMIT_CORE].rlim_cur;
+	unsigned long limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
 	int numnote;
 	struct memelfnote *notes = NULL;
 	struct elf_prstatus *prstatus = NULL;	/* NT_PRSTATUS */
Index: linux-2.6/fs/binfmt_flat.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/binfmt_flat.c,v
retrieving revision 1.11
diff -b -p -u -r1.11 binfmt_flat.c
--- linux-2.6/fs/binfmt_flat.c 18 Jun 2004 14:53:57 -0000 1.11
+++ linux-2.6/fs/binfmt_flat.c 24 Sep 2004 05:46:27 -0000
@@ -486,7 +486,7 @@ static int load_flat_file(struct linux_b
 	 * size limits imposed on them by creating programs with large
 	 * arrays in the data or bss.
 	 */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
 	if (data_len + bss_len > rlim)
Index: linux-2.6/fs/buffer.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/buffer.c,v
retrieving revision 1.250
diff -b -p -u -r1.250 buffer.c
--- linux-2.6/fs/buffer.c 9 Sep 2004 23:09:55 -0000 1.250
+++ linux-2.6/fs/buffer.c 24 Sep 2004 05:46:27 -0000
@@ -2232,7 +2232,7 @@ int generic_cont_expand(struct inode *in
 	int err;
 
 	err = -EFBIG;
-        limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+        limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	if (limit != RLIM_INFINITY && size > (loff_t)limit) {
 		send_sig(SIGXFSZ, current, 0);
 		goto out;
Index: linux-2.6/fs/exec.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/exec.c,v
retrieving revision 1.140
diff -b -p -u -r1.140 exec.c
--- linux-2.6/fs/exec.c 17 Sep 2004 18:55:43 -0000 1.140
+++ linux-2.6/fs/exec.c 24 Sep 2004 05:46:27 -0000
@@ -377,7 +377,7 @@ int setup_arg_pages(struct linux_binprm 
 	bprm->p = PAGE_SIZE * i - offset;
 
 	/* Limit stack size to 1GB */
-	stack_base = current->rlim[RLIMIT_STACK].rlim_max;
+	stack_base = current->signal->rlim[RLIMIT_STACK].rlim_max;
 	if (stack_base > (1 << 30))
 		stack_base = 1 << 30;
 	stack_base = PAGE_ALIGN(STACK_TOP - stack_base);
@@ -1393,7 +1393,7 @@ int do_coredump(long signr, int exit_cod
 	current->signal->group_exit_code = exit_code;
 	coredump_wait(mm);
 
-	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
+	if (current->signal->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail_unlock;
 
 	/*
Index: linux-2.6/fs/fcntl.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/fcntl.c,v
retrieving revision 1.41
diff -b -p -u -r1.41 fcntl.c
--- linux-2.6/fs/fcntl.c 2 Sep 2004 21:42:48 -0000 1.41
+++ linux-2.6/fs/fcntl.c 24 Sep 2004 05:46:27 -0000
@@ -86,7 +86,7 @@ static int locate_fd(struct files_struct
 	int error;
 
 	error = -EINVAL;
-	if (orig_start >= current->rlim[RLIMIT_NOFILE].rlim_cur)
+	if (orig_start >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
 
 repeat:
@@ -105,7 +105,7 @@ repeat:
 	}
 	
 	error = -EMFILE;
-	if (newfd >= current->rlim[RLIMIT_NOFILE].rlim_cur)
+	if (newfd >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
 
 	error = expand_files(files, newfd);
@@ -161,7 +161,7 @@ asmlinkage long sys_dup2(unsigned int ol
 	if (newfd == oldfd)
 		goto out_unlock;
 	err = -EBADF;
-	if (newfd >= current->rlim[RLIMIT_NOFILE].rlim_cur)
+	if (newfd >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out_unlock;
 	get_file(file);			/* We are now finished with oldfd */
 
Index: linux-2.6/fs/open.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/open.c,v
retrieving revision 1.71
diff -b -p -u -r1.71 open.c
--- linux-2.6/fs/open.c 8 Aug 2004 01:54:18 -0000 1.71
+++ linux-2.6/fs/open.c 24 Sep 2004 05:46:27 -0000
@@ -852,7 +852,7 @@ repeat:
 	 * N.B. For clone tasks sharing a files structure, this test
 	 * will limit the total number of files that can be opened.
 	 */
-	if (fd >= current->rlim[RLIMIT_NOFILE].rlim_cur)
+	if (fd >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
 
 	/* Do we need to expand the fdset array? */
Index: linux-2.6/fs/nfs/direct.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/nfs/direct.c,v
retrieving revision 1.17
diff -b -p -u -r1.17 direct.c
--- linux-2.6/fs/nfs/direct.c 24 Aug 2004 04:56:25 -0000 1.17
+++ linux-2.6/fs/nfs/direct.c 24 Sep 2004 05:46:27 -0000
@@ -545,7 +545,7 @@ nfs_file_direct_write(struct kiocb *iocb
 {
 	ssize_t retval = -EINVAL;
 	loff_t *ppos = &iocb->ki_pos;
-	unsigned long limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	unsigned long limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	struct file *file = iocb->ki_filp;
 	struct nfs_open_context *ctx =
 			(struct nfs_open_context *) file->private_data;
Index: linux-2.6/fs/nfsd/nfssvc.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/nfsd/nfssvc.c,v
retrieving revision 1.43
diff -b -p -u -r1.43 nfssvc.c
--- linux-2.6/fs/nfsd/nfssvc.c 8 Sep 2004 14:51:40 -0000 1.43
+++ linux-2.6/fs/nfsd/nfssvc.c 24 Sep 2004 05:46:27 -0000
@@ -180,7 +180,6 @@ nfsd(struct svc_rqst *rqstp)
 	/* Lock module and set up kernel thread */
 	lock_kernel();
 	daemonize("nfsd");
-	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 
 	/* After daemonize() this kernel thread shares current->fs
 	 * with the init process. We need to create files with a
Index: linux-2.6/fs/proc/array.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/proc/array.c,v
retrieving revision 1.69
diff -b -p -u -r1.69 array.c
--- linux-2.6/fs/proc/array.c 8 Sep 2004 14:48:58 -0000 1.69
+++ linux-2.6/fs/proc/array.c 24 Sep 2004 05:46:27 -0000
@@ -313,6 +313,7 @@ int proc_pid_stat(struct task_struct *ta
 	struct mm_struct *mm;
 	unsigned long long start_time;
 	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
+	unsigned long rsslim = 0;
 	char tcomm[sizeof(task->comm)];
 
 	state = *get_task_state(task);
@@ -347,6 +348,7 @@ int proc_pid_stat(struct task_struct *ta
 		cmaj_flt = task->signal->cmaj_flt;
 		cutime = task->signal->cutime;
 		cstime = task->signal->cstime;
+		rsslim = task->signal->rlim[RLIMIT_RSS].rlim_cur;
 	}
 	read_unlock(&tasklist_lock);
 
@@ -389,7 +391,7 @@ int proc_pid_stat(struct task_struct *ta
 		start_time,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
-		task->rlim[RLIMIT_RSS].rlim_cur,
+	        rsslim,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
 		mm ? mm->start_stack : 0,
Index: linux-2.6/include/linux/init_task.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/init_task.h,v
retrieving revision 1.32
diff -b -p -u -r1.32 init_task.h
--- linux-2.6/include/linux/init_task.h 30 Jun 2004 22:52:08 -0000 1.32
+++ linux-2.6/include/linux/init_task.h 24 Sep 2004 05:46:27 -0000
@@ -50,6 +50,7 @@
 		.list = LIST_HEAD_INIT(sig.shared_pending.list),	\
 		.signal =  {{0}}}, \
 	.posix_timers	 = LIST_HEAD_INIT(sig.posix_timers),		\
+	.rlim		= INIT_RLIMITS,					\
 }
 
 #define INIT_SIGHAND(sighand) {	\
@@ -96,7 +97,6 @@ extern struct group_info init_groups;
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
 	.keep_capabilities = 0,						\
-	.rlim		= INIT_RLIMITS,					\
 	.user		= INIT_USER,					\
 	.comm		= "swapper",					\
 	.thread		= INIT_THREAD,					\
Index: linux-2.6/include/linux/mm.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/mm.h,v
retrieving revision 1.190
diff -b -p -u -r1.190 mm.h
--- linux-2.6/include/linux/mm.h 3 Sep 2004 17:20:35 -0000 1.190
+++ linux-2.6/include/linux/mm.h 24 Sep 2004 05:46:27 -0000
@@ -540,7 +540,7 @@ static inline int can_do_mlock(void)
 {
 	if (capable(CAP_IPC_LOCK))
 		return 1;
-	if (current->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
+	if (current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
 		return 1;
 	return 0;
 }
Index: linux-2.6/include/linux/sched.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/sched.h,v
retrieving revision 1.272
diff -b -p -u -r1.272 sched.h
--- linux-2.6/include/linux/sched.h 13 Sep 2004 21:05:18 -0000 1.272
+++ linux-2.6/include/linux/sched.h 24 Sep 2004 05:46:27 -0000
@@ -312,6 +312,17 @@ struct signal_struct {
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
+
+	/*
+	 * We don't bother to synchronize most readers of this at all,
+	 * because there is no reader checking a limit that actually needs
+	 * to get both rlim_cur and rlim_max atomically, and either one
+	 * alone is a single word that can safely be read normally.
+	 * getrlimit/setrlimit use task_lock(current->group_leader) to
+	 * protect this instead of the siglock, because they really
+	 * have no need to disable irqs.
+	 */
+	struct rlimit rlim[RLIM_NLIMITS];
 };
 
 /*
@@ -518,8 +529,6 @@ struct task_struct {
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
 	unsigned keep_capabilities:1;
 	struct user_struct *user;
-/* limits */
-	struct rlimit rlim[RLIM_NLIMITS];
 	unsigned short used_math;
 	char comm[16];
 /* file system info */
Index: linux-2.6/include/linux/security.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/security.h,v
retrieving revision 1.32
diff -b -p -u -r1.32 security.h
--- linux-2.6/include/linux/security.h 18 Jun 2004 18:53:07 -0000 1.32
+++ linux-2.6/include/linux/security.h 24 Sep 2004 05:46:27 -0000
@@ -582,7 +582,7 @@ struct swap_info_struct;
  * @task_setrlimit:
  *	Check permission before setting the resource limits of the current
  *	process for @resource to @new_rlim.  The old resource limit values can
- *	be examined by dereferencing (current->rlim + resource).
+ *	be examined by dereferencing (current->signal->rlim + resource).
  *	@resource contains the resource whose limit is being set.
  *	@new_rlim contains the new limits for @resource.
  *	Return 0 if permission is granted.
Index: linux-2.6/ipc/mqueue.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/ipc/mqueue.c,v
retrieving revision 1.18
diff -b -p -u -r1.18 mqueue.c
--- linux-2.6/ipc/mqueue.c 23 Aug 2004 20:05:01 -0000 1.18
+++ linux-2.6/ipc/mqueue.c 24 Sep 2004 05:46:27 -0000
@@ -145,7 +145,7 @@ static struct inode *mqueue_get_inode(st
 			spin_lock(&mq_lock);
 			if (u->mq_bytes + mq_bytes < u->mq_bytes ||
 		 	    u->mq_bytes + mq_bytes >
-			    p->rlim[RLIMIT_MSGQUEUE].rlim_cur) {
+			    p->signal->rlim[RLIMIT_MSGQUEUE].rlim_cur) {
 				spin_unlock(&mq_lock);
 				goto out_inode;
 			}
Index: linux-2.6/kernel/acct.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/acct.c,v
retrieving revision 1.34
diff -b -p -u -r1.34 acct.c
--- linux-2.6/kernel/acct.c 2 Aug 2004 17:09:36 -0000 1.34
+++ linux-2.6/kernel/acct.c 24 Sep 2004 05:46:27 -0000
@@ -480,11 +480,11 @@ static void do_acct_process(long exitcod
 	/*
  	 * Accounting records are not subject to resource limits.
  	 */
-	flim = current->rlim[RLIMIT_FSIZE].rlim_cur;
-	current->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	file->f_op->write(file, (char *)&ac,
 			       sizeof(acct_t), &file->f_pos);
-	current->rlim[RLIMIT_FSIZE].rlim_cur = flim;
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
 	set_fs(fs);
 }
 
Index: linux-2.6/kernel/exit.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/exit.c,v
retrieving revision 1.154
diff -b -p -u -r1.154 exit.c
--- linux-2.6/kernel/exit.c 21 Sep 2004 14:15:21 -0000 1.154
+++ linux-2.6/kernel/exit.c 24 Sep 2004 06:41:46 -0000
@@ -237,7 +237,8 @@ void reparent_to_init(void)
 	/* rt_priority? */
 	/* signals? */
 	security_task_reparent_to_init(current);
-	memcpy(current->rlim, init_task.rlim, sizeof(*(current->rlim)));
+	memcpy(current->signal->rlim, init_task.signal->rlim,
+	       sizeof(current->signal->rlim));
 	atomic_inc(&(INIT_USER->__count));
 	switch_uid(INIT_USER);
 
@@ -761,7 +762,6 @@ static void exit_notify(struct task_stru
 	 */
 	tsk->it_virt_value = 0;
 	tsk->it_prof_value = 0;
-	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
 
 	write_unlock_irq(&tasklist_lock);
 
Index: linux-2.6/kernel/fork.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/fork.c,v
retrieving revision 1.216
diff -b -p -u -r1.216 fork.c
--- linux-2.6/kernel/fork.c 23 Sep 2004 01:21:19 -0000 1.216
+++ linux-2.6/kernel/fork.c 24 Sep 2004 06:37:31 -0000
@@ -249,8 +249,8 @@ void __init fork_init(unsigned long memp
 	if(max_threads < 20)
 		max_threads = 20;
 
-	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
-	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+	init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
+	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 }
 
 static struct task_struct *dup_task_struct(struct task_struct *orig)
@@ -872,6 +872,10 @@ static inline int copy_signal(unsigned l
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
 
+	task_lock(current->group_leader);
+	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
+	task_unlock(current->group_leader);
+
 	return 0;
 }
 
@@ -941,7 +945,7 @@ static task_t *copy_process(unsigned lon
 
 	retval = -EAGAIN;
 	if (atomic_read(&p->user->processes) >=
-			p->rlim[RLIMIT_NPROC].rlim_cur) {
+			p->signal->rlim[RLIMIT_NPROC].rlim_cur) {
 		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE) &&
 				p->user != &root_user)
 			goto bad_fork_free;
Index: linux-2.6/kernel/signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/signal.c,v
retrieving revision 1.139
diff -b -p -u -r1.139 signal.c
--- linux-2.6/kernel/signal.c 16 Sep 2004 14:12:54 -0000 1.139
+++ linux-2.6/kernel/signal.c 24 Sep 2004 05:46:27 -0000
@@ -269,7 +269,7 @@ static struct sigqueue *__sigqueue_alloc
 	struct sigqueue *q = NULL;
 
 	if (atomic_read(&current->user->sigpending) <
-			current->rlim[RLIMIT_SIGPENDING].rlim_cur)
+			current->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
 		INIT_LIST_HEAD(&q->list);
@@ -764,7 +764,7 @@ static int send_signal(int sig, struct s
 	   pass on the info struct.  */
 
 	if (atomic_read(&t->user->sigpending) <
-			t->rlim[RLIMIT_SIGPENDING].rlim_cur)
+			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 
 	if (q) {
Index: linux-2.6/kernel/sys.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/sys.c,v
retrieving revision 1.92
diff -b -p -u -r1.92 sys.c
--- linux-2.6/kernel/sys.c 14 Sep 2004 14:48:01 -0000 1.92
+++ linux-2.6/kernel/sys.c 24 Sep 2004 06:35:25 -0000
@@ -649,7 +649,7 @@ static int set_user(uid_t new_ruid, int 
 		return -EAGAIN;
 
 	if (atomic_read(&new_user->processes) >=
-				current->rlim[RLIMIT_NPROC].rlim_cur &&
+				current->signal->rlim[RLIMIT_NPROC].rlim_cur &&
 			new_user != &root_user) {
 		free_uid(new_user);
 		return -EAGAIN;
@@ -1496,9 +1496,13 @@ asmlinkage long sys_getrlimit(unsigned i
 {
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
-	else
-		return copy_to_user(rlim, current->rlim + resource, sizeof(*rlim))
-			? -EFAULT : 0;
+	else {
+		struct rlimit value;
+		task_lock(current->group_leader);
+		value = current->signal->rlim[resource];
+		task_unlock(current->group_leader);
+		return copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
+	}
 }
 
 #ifdef __ARCH_WANT_SYS_OLD_GETRLIMIT
@@ -1513,7 +1517,9 @@ asmlinkage long sys_old_getrlimit(unsign
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
 
-	memcpy(&x, current->rlim + resource, sizeof(*rlim));
+	task_lock(current->group_leader);
+	x = current->signal->rlim[resource];
+	task_unlock(current->group_leader);
 	if(x.rlim_cur > 0x7FFFFFFF)
 		x.rlim_cur = 0x7FFFFFFF;
 	if(x.rlim_max > 0x7FFFFFFF)
@@ -1534,21 +1540,20 @@ asmlinkage long sys_setrlimit(unsigned i
 		return -EFAULT;
        if (new_rlim.rlim_cur > new_rlim.rlim_max)
                return -EINVAL;
-	old_rlim = current->rlim + resource;
-	if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
-	     (new_rlim.rlim_max > old_rlim->rlim_max)) &&
+	old_rlim = current->signal->rlim + resource;
+	if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
 	    !capable(CAP_SYS_RESOURCE))
 		return -EPERM;
-	if (resource == RLIMIT_NOFILE) {
-		if (new_rlim.rlim_cur > NR_OPEN || new_rlim.rlim_max > NR_OPEN)
+	if (resource == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
 			return -EPERM;
-	}
 
 	retval = security_task_setrlimit(resource, &new_rlim);
 	if (retval)
 		return retval;
 
+	task_lock(current->group_leader);
 	*old_rlim = new_rlim;
+	task_unlock(current->group_leader);
 	return 0;
 }
 
Index: linux-2.6/kernel/timer.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/timer.c,v
retrieving revision 1.94
diff -b -p -u -r1.94 timer.c
--- linux-2.6/kernel/timer.c 17 Sep 2004 19:15:53 -0000 1.94
+++ linux-2.6/kernel/timer.c 24 Sep 2004 05:46:27 -0000
@@ -804,12 +804,13 @@ static inline void do_process_times(stru
 
 	psecs = (p->utime += user);
 	psecs += (p->stime += system);
-	if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_cur) {
+	if (!unlikely(p->state & (TASK_DEAD|TASK_ZOMBIE)) &&
+	    psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_cur) {
 		/* Send SIGXCPU every second.. */
 		if (!(psecs % HZ))
 			send_sig(SIGXCPU, p, 1);
 		/* and SIGKILL when we go over max.. */
-		if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_max)
+		if (psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_max)
 			send_sig(SIGKILL, p, 1);
 	}
 }
Index: linux-2.6/mm/filemap.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/filemap.c,v
retrieving revision 1.270
diff -b -p -u -r1.270 filemap.c
--- linux-2.6/mm/filemap.c 11 Sep 2004 15:50:36 -0000 1.270
+++ linux-2.6/mm/filemap.c 24 Sep 2004 05:46:27 -0000
@@ -1804,7 +1804,7 @@ filemap_set_next_iovec(const struct iove
 inline int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk)
 {
 	struct inode *inode = file->f_mapping->host;
-	unsigned long limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	unsigned long limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 
         if (unlikely(*pos < 0))
                 return -EINVAL;
Index: linux-2.6/mm/memory.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/memory.c,v
retrieving revision 1.182
diff -b -p -u -r1.182 memory.c
--- linux-2.6/mm/memory.c 2 Sep 2004 21:39:16 -0000 1.182
+++ linux-2.6/mm/memory.c 24 Sep 2004 05:46:27 -0000
@@ -1236,7 +1236,7 @@ int vmtruncate(struct inode * inode, lof
 	goto out_truncate;
 
 do_expand:
-	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	if (limit != RLIM_INFINITY && offset > limit)
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
Index: linux-2.6/mm/mlock.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/mlock.c,v
retrieving revision 1.10
diff -b -p -u -r1.10 mlock.c
--- linux-2.6/mm/mlock.c 23 Aug 2004 20:06:46 -0000 1.10
+++ linux-2.6/mm/mlock.c 24 Sep 2004 05:46:27 -0000
@@ -114,7 +114,7 @@ asmlinkage long sys_mlock(unsigned long 
 	locked = len >> PAGE_SHIFT;
 	locked += current->mm->locked_vm;
 
-	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
 
 	/* check against resource limits */
@@ -173,7 +173,7 @@ asmlinkage long sys_mlockall(int flags)
 	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
 		goto out;
 
-	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
 
 	ret = -ENOMEM;
@@ -207,7 +207,7 @@ int user_shm_lock(size_t size, struct us
 
 	spin_lock(&shmlock_user_lock);
 	locked = size >> PAGE_SHIFT;
-	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 	lock_limit >>= PAGE_SHIFT;
 	if (locked + user->locked_shm > lock_limit && !capable(CAP_IPC_LOCK))
 		goto out;
Index: linux-2.6/mm/mmap.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/mmap.c,v
retrieving revision 1.145
diff -b -p -u -r1.145 mmap.c
--- linux-2.6/mm/mmap.c 3 Sep 2004 17:22:55 -0000 1.145
+++ linux-2.6/mm/mmap.c 24 Sep 2004 05:46:27 -0000
@@ -136,7 +136,7 @@ asmlinkage unsigned long sys_brk(unsigne
 	}
 
 	/* Check against rlimit.. */
-	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
+	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
 		goto out;
 
@@ -831,7 +831,7 @@ unsigned long do_mmap_pgoff(struct file 
 	if (vm_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
 		locked = mm->locked_vm << PAGE_SHIFT;
-		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
@@ -903,7 +903,7 @@ munmap_back:
 
 	/* Check against address space limit. */
 	if ((mm->total_vm << PAGE_SHIFT) + len
-	    > current->rlim[RLIMIT_AS].rlim_cur)
+	    > current->signal->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
 	if (accountable && (!(flags & MAP_NORESERVE) ||
@@ -1348,9 +1348,9 @@ int expand_stack(struct vm_area_struct *
 		return -ENOMEM;
 	}
 	
-	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (address - vma->vm_start > current->signal->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
-			current->rlim[RLIMIT_AS].rlim_cur) {
+			current->signal->rlim[RLIMIT_AS].rlim_cur) {
 		anon_vma_unlock(vma);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
@@ -1410,9 +1410,9 @@ int expand_stack(struct vm_area_struct *
 		return -ENOMEM;
 	}
 	
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+	if (vma->vm_end - address > current->signal->rlim[RLIMIT_STACK].rlim_cur ||
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
-			current->rlim[RLIMIT_AS].rlim_cur) {
+			current->signal->rlim[RLIMIT_AS].rlim_cur) {
 		anon_vma_unlock(vma);
 		vm_unacct_memory(grow);
 		return -ENOMEM;
@@ -1758,7 +1758,7 @@ unsigned long do_brk(unsigned long addr,
 	if (mm->def_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
 		locked = mm->locked_vm << PAGE_SHIFT;
-		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
@@ -1777,7 +1777,7 @@ unsigned long do_brk(unsigned long addr,
 
 	/* Check against address space limits *after* clearing old maps... */
 	if ((mm->total_vm << PAGE_SHIFT) + len
-	    > current->rlim[RLIMIT_AS].rlim_cur)
+	    > current->signal->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
 	if (mm->map_count > sysctl_max_map_count)
Index: linux-2.6/mm/mremap.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/mremap.c,v
retrieving revision 1.56
diff -b -p -u -r1.56 mremap.c
--- linux-2.6/mm/mremap.c 27 Aug 2004 17:36:15 -0000 1.56
+++ linux-2.6/mm/mremap.c 24 Sep 2004 05:46:27 -0000
@@ -327,7 +327,7 @@ unsigned long do_mremap(unsigned long ad
 	if (vma->vm_flags & VM_LOCKED) {
 		unsigned long locked, lock_limit;
 		locked = current->mm->locked_vm << PAGE_SHIFT;
-		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += new_len - old_len;
 		ret = -EAGAIN;
 		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
@@ -335,7 +335,7 @@ unsigned long do_mremap(unsigned long ad
 	}
 	ret = -ENOMEM;
 	if ((current->mm->total_vm << PAGE_SHIFT) + (new_len - old_len)
-	    > current->rlim[RLIMIT_AS].rlim_cur)
+	    > current->signal->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
 
 	if (vma->vm_flags & VM_ACCOUNT) {
Index: linux-2.6/mm/nommu.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/nommu.c,v
retrieving revision 1.16
diff -b -p -u -r1.16 nommu.c
--- linux-2.6/mm/nommu.c 4 Jul 2004 19:01:12 -0000 1.16
+++ linux-2.6/mm/nommu.c 24 Sep 2004 05:46:27 -0000
@@ -57,7 +57,7 @@ int vmtruncate(struct inode *inode, loff
 	goto out_truncate;
 
 do_expand:
-	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	if (limit != RLIM_INFINITY && offset > limit)
 		goto out_sig;
 	if (offset > inode->i_sb->s_maxbytes)
Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/security/selinux/hooks.c,v
retrieving revision 1.61
diff -b -p -u -r1.61 hooks.c
--- linux-2.6/security/selinux/hooks.c 24 Aug 2004 19:43:49 -0000 1.61
+++ linux-2.6/security/selinux/hooks.c 24 Sep 2004 05:46:27 -0000
@@ -1909,8 +1909,8 @@ static void selinux_bprm_apply_creds(str
 				  PROCESS__RLIMITINH, NULL, NULL);
 		if (rc) {
 			for (i = 0; i < RLIM_NLIMITS; i++) {
-				rlim = current->rlim + i;
-				initrlim = init_task.rlim+i;
+				rlim = current->signal->rlim + i;
+				initrlim = init_task.signal->rlim+i;
 				rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
 			}
 		}
@@ -2689,7 +2689,7 @@ static int selinux_task_setnice(struct t
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
-	struct rlimit *old_rlim = current->rlim + resource;
+	struct rlimit *old_rlim = current->signal->rlim + resource;
 	int rc;
 
 	rc = secondary_ops->task_setrlimit(resource, new_rlim);
