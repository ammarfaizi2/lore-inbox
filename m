Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274304AbRITEh0>; Thu, 20 Sep 2001 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRITEhX>; Thu, 20 Sep 2001 00:37:23 -0400
Received: from [195.223.140.107] ([195.223.140.107]:4346 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274304AbRITEhJ>;
	Thu, 20 Sep 2001 00:37:09 -0400
Date: Thu, 20 Sep 2001 06:37:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920063700.O720@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random> <006c01c14137$95c580c0$010411ac@local> <20010920040702.J720@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <20010920040702.J720@athlon.random>; from andrea@suse.de on Thu, Sep 20, 2001 at 04:07:02AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 20, 2001 at 04:07:02AM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 19, 2001 at 08:19:09PM +0200, Manfred Spraul wrote:
> > > if we go generic then I strongly recommend my version of the generic
> > > semaphores is _much_ faster (and cleaner) than this one (it even
> > allows
> > > more than 2^31 concurrent readers on 64 bit archs ;).
> > >
> > Andrea,
> > 
> > implementing recursive semaphores is trivial, but do you have any idea
> > how to fix the latency problem?
> 
> yes, one solution to the latency problem without writing the
> ugly code would be simply to add a per-process counter to pass to a
> modified rwsem api, then to hide the trickery in a mm_down_read macro.
> such way it will be recursive _and_ fair.

ok, here it is attached a rwsem patch (now with the fast path inlined :)
of my version of the rwsem-spinlock semaphores (as only option all over
the ports). It's against pre12 (it is not inlined in the email since
it's not readable anyways)

and below you find (this time inlined) an incremental patch to be
applied on top of the attachment that implements the read recursive and
at the same time fair rw semaphores. This should close all the problems.

But keep in mind the rwsem by default are _fair_, so you cannot do read
recursion unless you use the recursive version and you pass a
rw_sem_recursor to it.

diff -urN rwsem/arch/alpha/mm/fault.c rwsem-recurisve/arch/alpha/mm/fault.c
--- rwsem/arch/alpha/mm/fault.c	Thu Sep 20 01:43:26 2001
+++ rwsem-recurisve/arch/alpha/mm/fault.c	Thu Sep 20 06:31:37 2001
@@ -113,7 +113,7 @@
 		goto vmalloc_fault;
 #endif
 
-	down_read(&mm->mmap_sem);
+	down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -147,7 +147,7 @@
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, cause > 0);
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 
 	if (fault < 0)
 		goto out_of_memory;
@@ -161,7 +161,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 
 	if (user_mode(regs)) {
 		force_sig(SIGSEGV, current);
@@ -198,7 +198,7 @@
 	if (current->pid == 1) {
 		current->policy |= SCHED_YIELD;
 		schedule();
-		down_read(&mm->mmap_sem);
+		down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 		goto survive;
 	}
 	printk(KERN_ALERT "VM: killing process %s(%d)\n",
diff -urN rwsem/arch/i386/mm/fault.c rwsem-recurisve/arch/i386/mm/fault.c
--- rwsem/arch/i386/mm/fault.c	Thu Sep 20 01:43:27 2001
+++ rwsem-recurisve/arch/i386/mm/fault.c	Thu Sep 20 06:31:53 2001
@@ -191,7 +191,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -265,7 +265,7 @@
 		if (bit < 32)
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	return;
 
 /*
@@ -273,7 +273,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
@@ -341,11 +341,11 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	if (tsk->pid == 1) {
 		tsk->policy |= SCHED_YIELD;
 		schedule();
-		down_read(&mm->mmap_sem);
+		down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 		goto survive;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
@@ -354,7 +354,7 @@
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -urN rwsem/arch/ia64/mm/fault.c rwsem-recurisve/arch/ia64/mm/fault.c
--- rwsem/arch/ia64/mm/fault.c	Tue May  1 19:35:18 2001
+++ rwsem-recurisve/arch/ia64/mm/fault.c	Thu Sep 20 06:04:45 2001
@@ -60,7 +60,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 
 	vma = find_vma_prev(mm, address, &prev_vma);
 	if (!vma)
@@ -112,7 +112,7 @@
 	      default:
 		goto out_of_memory;
 	}
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	return;
 
   check_expansion:
@@ -135,7 +135,7 @@
 	goto good_area;
 
   bad_area:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	if (isr & IA64_ISR_SP) {
 		/*
 		 * This fault was due to a speculative load set the "ed" bit in the psr to
@@ -184,7 +184,7 @@
 	return;
 
   out_of_memory:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
diff -urN rwsem/arch/ppc/mm/fault.c rwsem-recurisve/arch/ppc/mm/fault.c
--- rwsem/arch/ppc/mm/fault.c	Wed Jul  4 04:03:45 2001
+++ rwsem-recurisve/arch/ppc/mm/fault.c	Thu Sep 20 06:10:09 2001
@@ -103,7 +103,7 @@
 		bad_page_fault(regs, address, SIGSEGV);
 		return;
 	}
-	down_read(&mm->mmap_sem);
+	down_read(&mm->mmap_sem, &current->mm_recursor);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -163,7 +163,7 @@
                 goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	/*
 	 * keep track of tlb+htab misses that are good addrs but
 	 * just need pte's created via handle_mm_fault()
@@ -173,7 +173,7 @@
 	return;
 
 bad_area:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	pte_errors++;	
 
 	/* User mode accesses cause a SIGSEGV */
@@ -194,7 +194,7 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
@@ -202,7 +202,7 @@
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
diff -urN rwsem/fs/exec.c rwsem-recurisve/fs/exec.c
--- rwsem/fs/exec.c	Thu Sep 20 01:44:06 2001
+++ rwsem-recurisve/fs/exec.c	Thu Sep 20 06:31:06 2001
@@ -969,9 +969,9 @@
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
 
-	down_read(&current->mm->mmap_sem);
+	down_read_recursive(&current->mm->mmap_sem, &current->mm_recursor);
 	retval = binfmt->core_dump(signr, regs, file);
-	up_read(&current->mm->mmap_sem);
+	up_read_recursive(&current->mm->mmap_sem, &current->mm_recursor);
 
 close_fail:
 	filp_close(file, NULL);
diff -urN rwsem/fs/proc/array.c rwsem-recurisve/fs/proc/array.c
--- rwsem/fs/proc/array.c	Sat Aug 11 08:04:22 2001
+++ rwsem-recurisve/fs/proc/array.c	Thu Sep 20 06:22:35 2001
@@ -577,7 +577,10 @@
 	column = *ppos & (MAPS_LINE_LENGTH-1);
 
 	/* quickly go to line lineno */
-	down_read(&mm->mmap_sem);
+	if (task == current)
+		down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
+	else
+		down_read(&mm->mmap_sem);
 	for (map = mm->mmap, i = 0; map && (i < lineno); map = map->vm_next, i++)
 		continue;
 
@@ -658,7 +661,10 @@
 		if (volatile_task)
 			break;
 	}
-	up_read(&mm->mmap_sem);
+	if (task == current)
+		up_read_recursive(&mm->mmap_sem, &current->mm_recursor);
+	else
+		up_read(&mm->mmap_sem);
 
 	/* encode f_pos */
 	*ppos = (lineno << MAPS_LINE_SHIFT) + column;
diff -urN rwsem/include/linux/rwsem.h rwsem-recurisve/include/linux/rwsem.h
--- rwsem/include/linux/rwsem.h	Thu Sep 20 05:08:56 2001
+++ rwsem-recurisve/include/linux/rwsem.h	Thu Sep 20 06:25:49 2001
@@ -18,6 +18,11 @@
 #endif
 };
 
+struct rw_sem_recursor
+{
+	int counter;
+};
+
 #if RWSEM_DEBUG
 #define __SEM_DEBUG_INIT(name) \
 	, (long)&(name).__magic
@@ -42,6 +47,7 @@
 	__SEM_DEBUG_INIT(name)			\
 }
 #define RWSEM_INITIALIZER(name) __RWSEM_INITIALIZER(name, 0)
+#define RWSEM_RECURSOR_INITIALIZER ((struct rw_sem_recursor) { 0, })
 
 #define __DECLARE_RWSEM(name, count) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name, count)
@@ -112,6 +118,34 @@
 	spin_lock(&sem->lock);
 	sem->count -= RWSEM_WRITE_BIAS;
 	if (unlikely(sem->count))
+		rwsem_wake(sem);
+	spin_unlock(&sem->lock);
+}
+
+static inline void down_read_recursive(struct rw_semaphore *sem,
+				       struct rw_sem_recursor * recursor)
+{
+	int count, counter;
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count += RWSEM_READ_BIAS;
+	counter = recursor->counter++;
+	if (unlikely(count < 0 && !counter && !(count & RWSEM_READ_MASK)))
+		rwsem_down_failed(sem, RWSEM_READ_BLOCKING_BIAS);
+	spin_unlock(&sem->lock);
+}
+
+static inline void up_read_recursive(struct rw_semaphore *sem,
+				     struct rw_sem_recursor * recursor)
+{
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	sem->count -= RWSEM_READ_BIAS;
+	recursor->counter--;
+	if (unlikely(sem->count < 0 && !(sem->count & RWSEM_READ_MASK)))
 		rwsem_wake(sem);
 	spin_unlock(&sem->lock);
 }
diff -urN rwsem/include/linux/sched.h rwsem-recurisve/include/linux/sched.h
--- rwsem/include/linux/sched.h	Thu Sep 20 05:09:07 2001
+++ rwsem-recurisve/include/linux/sched.h	Thu Sep 20 06:25:50 2001
@@ -315,6 +315,7 @@
 
 	struct task_struct *next_task, *prev_task;
 	struct mm_struct *active_mm;
+	struct rw_sem_recursor mm_recursor;
 	struct list_head local_pages;
 	unsigned int allocation_order, nr_local_pages;
 
@@ -460,6 +461,7 @@
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
+    mm_recursor:	RWSEM_RECURSOR_INITIALIZER,			\
     cpus_allowed:	-1,						\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     next_task:		&tsk,						\

Andrea

--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=00_rwsem-fair-20

diff -urN 2.4.10pre12/arch/alpha/config.in rwsem/arch/alpha/config.in
--- 2.4.10pre12/arch/alpha/config.in	Thu Aug 16 22:03:22 2001
+++ rwsem/arch/alpha/config.in	Thu Sep 20 03:02:18 2001
@@ -5,8 +5,6 @@
 
 define_bool CONFIG_ALPHA y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_name "Kernel configuration of Linux for Alpha machines"
 
diff -urN 2.4.10pre12/arch/arm/config.in rwsem/arch/arm/config.in
--- 2.4.10pre12/arch/arm/config.in	Thu Aug 16 22:03:22 2001
+++ rwsem/arch/arm/config.in	Thu Sep 20 03:02:22 2001
@@ -9,8 +9,6 @@
 define_bool CONFIG_SBUS n
 define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 
 mainmenu_option next_comment
diff -urN 2.4.10pre12/arch/cris/config.in rwsem/arch/cris/config.in
--- 2.4.10pre12/arch/cris/config.in	Sat Aug 11 08:03:53 2001
+++ rwsem/arch/cris/config.in	Thu Sep 20 03:02:32 2001
@@ -5,8 +5,6 @@
 mainmenu_name "Linux/CRIS Kernel Configuration"
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN 2.4.10pre12/arch/i386/config.in rwsem/arch/i386/config.in
--- 2.4.10pre12/arch/i386/config.in	Thu Sep 20 01:43:26 2001
+++ rwsem/arch/i386/config.in	Thu Sep 20 03:02:39 2001
@@ -50,8 +50,6 @@
    define_bool CONFIG_X86_CMPXCHG n
    define_bool CONFIG_X86_XADD n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -59,8 +57,6 @@
    define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
diff -urN 2.4.10pre12/arch/ia64/config.in rwsem/arch/ia64/config.in
--- 2.4.10pre12/arch/ia64/config.in	Sat Aug 11 08:03:54 2001
+++ rwsem/arch/ia64/config.in	Thu Sep 20 03:02:44 2001
@@ -23,8 +23,6 @@
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
 define_bool CONFIG_SBUS n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   define_bool CONFIG_ACPI y
diff -urN 2.4.10pre12/arch/m68k/config.in rwsem/arch/m68k/config.in
--- 2.4.10pre12/arch/m68k/config.in	Wed Jul  4 04:03:45 2001
+++ rwsem/arch/m68k/config.in	Thu Sep 20 03:02:48 2001
@@ -4,8 +4,6 @@
 #
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux/68k Kernel Configuration"
 
diff -urN 2.4.10pre12/arch/mips/config.in rwsem/arch/mips/config.in
--- 2.4.10pre12/arch/mips/config.in	Thu Sep 20 01:43:27 2001
+++ rwsem/arch/mips/config.in	Thu Sep 20 03:02:52 2001
@@ -68,8 +68,6 @@
    fi
 bool 'Support for Alchemy Semi PB1000 board' CONFIG_MIPS_PB1000
 
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 #
 # Select some configuration options automatically for certain systems.
diff -urN 2.4.10pre12/arch/mips64/config.in rwsem/arch/mips64/config.in
--- 2.4.10pre12/arch/mips64/config.in	Thu Sep 20 01:43:30 2001
+++ rwsem/arch/mips64/config.in	Thu Sep 20 03:03:02 2001
@@ -27,9 +27,6 @@
 fi
 endmenu
 
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
-
 #
 # Select some configuration options automatically based on user selections
 #
diff -urN 2.4.10pre12/arch/parisc/config.in rwsem/arch/parisc/config.in
--- 2.4.10pre12/arch/parisc/config.in	Tue May  1 19:35:20 2001
+++ rwsem/arch/parisc/config.in	Thu Sep 20 03:03:06 2001
@@ -7,8 +7,6 @@
 
 define_bool CONFIG_PARISC y
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN 2.4.10pre12/arch/ppc/config.in rwsem/arch/ppc/config.in
--- 2.4.10pre12/arch/ppc/config.in	Thu Sep 20 01:43:31 2001
+++ rwsem/arch/ppc/config.in	Thu Sep 20 03:03:10 2001
@@ -4,8 +4,6 @@
 # see Documentation/kbuild/config-language.txt.
 #
 define_bool CONFIG_UID16 n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 
 mainmenu_name "Linux/PowerPC Kernel Configuration"
 
diff -urN 2.4.10pre12/arch/s390/config.in rwsem/arch/s390/config.in
--- 2.4.10pre12/arch/s390/config.in	Sat Aug 11 08:03:56 2001
+++ rwsem/arch/s390/config.in	Thu Sep 20 03:03:13 2001
@@ -7,8 +7,6 @@
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -urN 2.4.10pre12/arch/s390x/config.in rwsem/arch/s390x/config.in
--- 2.4.10pre12/arch/s390x/config.in	Sat Aug 11 08:04:00 2001
+++ rwsem/arch/s390x/config.in	Thu Sep 20 03:03:17 2001
@@ -6,8 +6,6 @@
 define_bool CONFIG_ISA n
 define_bool CONFIG_EISA n
 define_bool CONFIG_MCA n
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -urN 2.4.10pre12/arch/sh/config.in rwsem/arch/sh/config.in
--- 2.4.10pre12/arch/sh/config.in	Thu Sep 20 01:43:33 2001
+++ rwsem/arch/sh/config.in	Thu Sep 20 03:03:20 2001
@@ -7,8 +7,6 @@
 define_bool CONFIG_SUPERH y
 
 define_bool CONFIG_UID16 y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
diff -urN 2.4.10pre12/arch/sparc/config.in rwsem/arch/sparc/config.in
--- 2.4.10pre12/arch/sparc/config.in	Wed Jul  4 04:03:45 2001
+++ rwsem/arch/sparc/config.in	Thu Sep 20 03:03:23 2001
@@ -48,8 +48,6 @@
 define_bool CONFIG_SUN_CONSOLE y
 define_bool CONFIG_SUN_AUXIO y
 define_bool CONFIG_SUN_IO y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 
 bool 'Support for SUN4 machines (disables SUN4[CDM] support)' CONFIG_SUN4
 if [ "$CONFIG_SUN4" != "y" ]; then
diff -urN 2.4.10pre12/arch/sparc64/config.in rwsem/arch/sparc64/config.in
--- 2.4.10pre12/arch/sparc64/config.in	Thu Aug 16 22:03:25 2001
+++ rwsem/arch/sparc64/config.in	Thu Sep 20 03:03:27 2001
@@ -33,8 +33,6 @@
 
 # Global things across all Sun machines.
 define_bool CONFIG_HAVE_DEC_LOCK y
-define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_ISA n
 define_bool CONFIG_ISAPNP n
 define_bool CONFIG_EISA n
diff -urN 2.4.10pre12/include/asm-alpha/rwsem.h rwsem/include/asm-alpha/rwsem.h
--- 2.4.10pre12/include/asm-alpha/rwsem.h	Sat Jul 21 00:04:29 2001
+++ rwsem/include/asm-alpha/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,208 +0,0 @@
-#ifndef _ALPHA_RWSEM_H
-#define _ALPHA_RWSEM_H
-
-/*
- * Written by Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 2001.
- * Based on asm-alpha/semaphore.h and asm-i386/rwsem.h
- */
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-#include <asm/compiler.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	long			count;
-#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
-#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count += RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(oldcount < 0, 0))
-		rwsem_down_read_failed(sem);
-}
-
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count += RWSEM_ACTIVE_WRITE_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	mb\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(oldcount, 0))
-		rwsem_down_write_failed(sem);
-}
-
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	long oldcount;
-#ifndef	CONFIG_SMP
-	oldcount = sem->count;
-	sem->count -= RWSEM_ACTIVE_READ_BIAS;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (oldcount), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_READ_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(oldcount < 0, 0)) 
-		if ((int)oldcount - RWSEM_ACTIVE_READ_BIAS == 0)
-			rwsem_wake(sem);
-}
-
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	long count;
-#ifndef	CONFIG_SMP
-	sem->count -= RWSEM_ACTIVE_WRITE_BIAS;
-	count = sem->count;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"	mb\n"
-	"1:	ldq_l	%0,%1\n"
-	"	subq	%0,%3,%2\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	"	subq	%0,%3,%0\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (count), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (RWSEM_ACTIVE_WRITE_BIAS), "m" (sem->count) : "memory");
-#endif
-	if (__builtin_expect(count, 0))
-		if ((int)count == 0)
-			rwsem_wake(sem);
-}
-
-static inline void rwsem_atomic_add(long val, struct rw_semaphore *sem)
-{
-#ifndef	CONFIG_SMP
-	sem->count += val;
-#else
-	long temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq	%0,%2,%0\n"
-	"	stq_c	%0,%1\n"
-	"	beq	%0,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (temp), "=m" (sem->count)
-	:"Ir" (val), "m" (sem->count));
-#endif
-}
-
-static inline long rwsem_atomic_update(long val, struct rw_semaphore *sem)
-{
-#ifndef	CONFIG_SMP
-	sem->count += val;
-	return sem->count;
-#else
-	long ret, temp;
-	__asm__ __volatile__(
-	"1:	ldq_l	%0,%1\n"
-	"	addq 	%0,%3,%2\n"
-	"	addq	%0,%3,%0\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	:"=&r" (ret), "=m" (sem->count), "=&r" (temp)
-	:"Ir" (val), "m" (sem->count));
-
-	return ret;
-#endif
-}
-
-#endif /* __KERNEL__ */
-#endif /* _ALPHA_RWSEM_H */
diff -urN 2.4.10pre12/include/asm-i386/rwsem.h rwsem/include/asm-i386/rwsem.h
--- 2.4.10pre12/include/asm-i386/rwsem.h	Fri Aug 17 05:02:27 2001
+++ rwsem/include/asm-i386/rwsem.h	Thu Jan  1 01:00:00 1970
@@ -1,226 +0,0 @@
-/* rwsem.h: R/W semaphores implemented using XADD/CMPXCHG for i486+
- *
- * Written by David Howells (dhowells@redhat.com).
- *
- * Derived from asm-i386/semaphore.h
- *
- *
- * The MSW of the count is the negated number of active writers and waiting
- * lockers, and the LSW is the total number of active locks
- *
- * The lock count is initialized to 0 (no active and no waiting lockers).
- *
- * When a writer subtracts WRITE_BIAS, it'll get 0xffff0001 for the case of an
- * uncontended lock. This can be determined because XADD returns the old value.
- * Readers increment by 1 and see a positive value when uncontended, negative
- * if there are writers (and maybe) readers waiting (in which case it goes to
- * sleep).
- *
- * The value of WAITING_BIAS supports up to 32766 waiting processes. This can
- * be extended to 65534 by manually checking the whole MSW rather than relying
- * on the S flag.
- *
- * The value of ACTIVE_BIAS supports up to 65535 active processes.
- *
- * This should be totally fair - if anything is waiting, a process that wants a
- * lock will go to the back of the queue. When the currently active lock is
- * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
- * front, then they'll all be woken up, but no other readers will be.
- */
-
-#ifndef _I386_RWSEM_H
-#define _I386_RWSEM_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include asm/rwsem.h directly, use linux/rwsem.h instead
-#endif
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/spinlock.h>
-
-struct rwsem_waiter;
-
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
-
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * lock for reading
- */
-static inline void __down_read(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-		"  js        2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  pushl     %%edx\n\t"
-		"  call      rwsem_down_read_failed\n\t"
-		"  popl      %%edx\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous"
-		"# ending down_read\n\t"
-		: "+m"(sem->count)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * lock for writing
- */
-static inline void __down_write(struct rw_semaphore *sem)
-{
-	int tmp;
-
-	tmp = RWSEM_ACTIVE_WRITE_BIAS;
-	__asm__ __volatile__(
-		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
-		"  testl     %0,%0\n\t" /* was the count 0 before? */
-		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_down_write_failed\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending down_write"
-		: "+d"(tmp), "+m"(sem->count)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * unlock after reading
- */
-static inline void __up_read(struct rw_semaphore *sem)
-{
-	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
-	__asm__ __volatile__(
-		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
-		"  jnz       1b\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_read\n"
-		: "+m"(sem->count), "+d"(tmp)
-		: "a"(sem)
-		: "memory", "cc");
-}
-
-/*
- * unlock after writing
- */
-static inline void __up_write(struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-		"# beginning __up_write\n\t"
-		"  movl      %2,%%edx\n\t"
-LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
-		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
-		"  jnz       1b\n\t" /* jump back if not */
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		".previous\n"
-		"# ending __up_write\n"
-		: "+m"(sem->count)
-		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)
-		: "memory", "cc", "edx");
-}
-
-/*
- * implement atomic add functionality
- */
-static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
-{
-	__asm__ __volatile__(
-LOCK_PREFIX	"addl %1,%0"
-		:"=m"(sem->count)
-		:"ir"(delta), "m"(sem->count));
-}
-
-/*
- * implement exchange and add functionality
- */
-static inline int rwsem_atomic_update(int delta, struct rw_semaphore *sem)
-{
-	int tmp = delta;
-
-	__asm__ __volatile__(
-LOCK_PREFIX	"xadd %0,(%2)"
-		: "+r"(tmp), "=m"(sem->count)
-		: "r"(sem), "m"(sem->count)
-		: "memory");
-
-	return tmp+delta;
-}
-
-#endif /* __KERNEL__ */
-#endif /* _I386_RWSEM_H */
diff -urN 2.4.10pre12/include/linux/rwsem-spinlock.h rwsem/include/linux/rwsem-spinlock.h
--- 2.4.10pre12/include/linux/rwsem-spinlock.h	Wed Aug 29 15:05:24 2001
+++ rwsem/include/linux/rwsem-spinlock.h	Thu Jan  1 01:00:00 1970
@@ -1,62 +0,0 @@
-/* rwsem-spinlock.h: fallback C implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-
-#ifndef _LINUX_RWSEM_SPINLOCK_H
-#define _LINUX_RWSEM_SPINLOCK_H
-
-#ifndef _LINUX_RWSEM_H
-#error please dont include linux/rwsem-spinlock.h directly, use linux/rwsem.h instead
-#endif
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-struct rwsem_waiter;
-
-/*
- * the rw-semaphore definition
- * - if activity is 0 then there are no active readers or writers
- * - if activity is +ve then that is the number of active readers
- * - if activity is -1 then there is one active writer
- * - if wait_list is not empty, then there are processes waiting for the semaphore
- */
-struct rw_semaphore {
-	__s32			activity;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
-
-extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
-extern void FASTCALL(__down_read(struct rw_semaphore *sem));
-extern void FASTCALL(__down_write(struct rw_semaphore *sem));
-extern void FASTCALL(__up_read(struct rw_semaphore *sem));
-extern void FASTCALL(__up_write(struct rw_semaphore *sem));
-
-#endif /* __KERNEL__ */
-#endif /* _LINUX_RWSEM_SPINLOCK_H */
diff -urN 2.4.10pre12/include/linux/rwsem.h rwsem/include/linux/rwsem.h
--- 2.4.10pre12/include/linux/rwsem.h	Wed Aug 29 15:05:24 2001
+++ rwsem/include/linux/rwsem.h	Thu Sep 20 05:08:56 2001
@@ -1,80 +1,120 @@
-/* rwsem.h: R/W semaphores, public interface
- *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from asm-i386/semaphore.h
- */
-
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
-#include <linux/linkage.h>
-
-#define RWSEM_DEBUG 0
-
 #ifdef __KERNEL__
 
-#include <linux/config.h>
-#include <linux/types.h>
+#include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <asm/system.h>
-#include <asm/atomic.h>
 
-struct rw_semaphore;
-
-#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
-#include <linux/rwsem-spinlock.h> /* use a generic implementation */
-#else
-#include <asm/rwsem.h> /* use an arch-specific implementation */
+struct rw_semaphore
+{
+	spinlock_t lock;
+	long count;
+#define RWSEM_READ_BIAS 1
+#define RWSEM_WRITE_BIAS (~(~0UL >> (BITS_PER_LONG>>1)))
+	struct list_head wait;
+#if RWSEM_DEBUG
+	long __magic;
 #endif
+};
 
-#ifndef rwsemtrace
 #if RWSEM_DEBUG
-extern void FASTCALL(rwsemtrace(struct rw_semaphore *sem, const char *str));
+#define __SEM_DEBUG_INIT(name) \
+	, (long)&(name).__magic
+#define RWSEM_MAGIC(x)							\
+	do {								\
+		if ((x) != (long)&(x)) {				\
+			printk("rwsem bad magic %lx (should be %lx), ",	\
+				(long)x, (long)&(x));			\
+			BUG();						\
+		}							\
+	} while (0)
 #else
-#define rwsemtrace(SEM,FMT)
+#define __SEM_DEBUG_INIT(name)
+#define CHECK_MAGIC(x)
 #endif
+
+#define __RWSEM_INITIALIZER(name, count)	\
+{						\
+	SPIN_LOCK_UNLOCKED,			\
+	(count),				\
+	LIST_HEAD_INIT((name).wait)		\
+	__SEM_DEBUG_INIT(name)			\
+}
+#define RWSEM_INITIALIZER(name) __RWSEM_INITIALIZER(name, 0)
+
+#define __DECLARE_RWSEM(name, count) \
+	struct rw_semaphore name = __RWSEM_INITIALIZER(name, count)
+#define DECLARE_RWSEM(name) __DECLARE_RWSEM(name, 0)
+#define DECLARE_RWSEM_READ_LOCKED(name) __DECLARE_RWSEM(name, RWSEM_READ_BIAS)
+#define DECLARE_RWSEM_WRITE_LOCKED(name) __DECLARE_RWSEM(name, RWSEM_WRITE_BIAS)
+
+#define RWSEM_READ_BLOCKING_BIAS (RWSEM_WRITE_BIAS-RWSEM_READ_BIAS)
+#define RWSEM_WRITE_BLOCKING_BIAS (0)
+
+#define RWSEM_READ_MASK (~RWSEM_WRITE_BIAS)
+#define RWSEM_WRITE_MASK (RWSEM_WRITE_BIAS)
+
+extern void FASTCALL(rwsem_down_failed(struct rw_semaphore *, long));
+extern void FASTCALL(rwsem_wake(struct rw_semaphore *));
+
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	spin_lock_init(&sem->lock);
+	sem->count = 0;
+	INIT_LIST_HEAD(&sem->wait);
+#if RWSEM_DEBUG
+	sem->__magic = (long)&sem->__magic;
 #endif
+}
 
-/*
- * lock for reading
- */
 static inline void down_read(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering down_read");
-	__down_read(sem);
-	rwsemtrace(sem,"Leaving down_read");
+	int count;
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count += RWSEM_READ_BIAS;
+	if (unlikely(count < 0))
+		rwsem_down_failed(sem, RWSEM_READ_BLOCKING_BIAS);
+	spin_unlock(&sem->lock);
 }
 
-/*
- * lock for writing
- */
 static inline void down_write(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering down_write");
-	__down_write(sem);
-	rwsemtrace(sem,"Leaving down_write");
+	long count;
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	count = sem->count;
+	sem->count += RWSEM_WRITE_BIAS;
+	if (unlikely(count))
+		rwsem_down_failed(sem, RWSEM_WRITE_BLOCKING_BIAS);
+	spin_unlock(&sem->lock);
 }
 
-/*
- * release a read lock
- */
 static inline void up_read(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering up_read");
-	__up_read(sem);
-	rwsemtrace(sem,"Leaving up_read");
+	CHECK_MAGIC(sem->__magic);
+
+	spin_lock(&sem->lock);
+	sem->count -= RWSEM_READ_BIAS;
+	if (unlikely(sem->count < 0 && !(sem->count & RWSEM_READ_MASK)))
+		rwsem_wake(sem);
+	spin_unlock(&sem->lock);
 }
 
-/*
- * release a write lock
- */
 static inline void up_write(struct rw_semaphore *sem)
 {
-	rwsemtrace(sem,"Entering up_write");
-	__up_write(sem);
-	rwsemtrace(sem,"Leaving up_write");
-}
+	CHECK_MAGIC(sem->__magic);
 
+	spin_lock(&sem->lock);
+	sem->count -= RWSEM_WRITE_BIAS;
+	if (unlikely(sem->count))
+		rwsem_wake(sem);
+	spin_unlock(&sem->lock);
+}
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_H */
diff -urN 2.4.10pre12/include/linux/sched.h rwsem/include/linux/sched.h
--- 2.4.10pre12/include/linux/sched.h	Thu Sep 20 01:44:18 2001
+++ rwsem/include/linux/sched.h	Thu Sep 20 05:09:07 2001
@@ -239,7 +239,7 @@
 	pgd:		swapper_pg_dir, 		\
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
-	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
+	mmap_sem:	RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
 }
diff -urN 2.4.10pre12/lib/Makefile rwsem/lib/Makefile
--- 2.4.10pre12/lib/Makefile	Thu Sep 20 01:44:19 2001
+++ rwsem/lib/Makefile	Thu Sep 20 04:38:44 2001
@@ -8,12 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o dec_and_lock.o rwsem.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
-
-obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
-obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o rwsem.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
diff -urN 2.4.10pre12/lib/rwsem-spinlock.c rwsem/lib/rwsem-spinlock.c
--- 2.4.10pre12/lib/rwsem-spinlock.c	Tue May  1 19:35:33 2001
+++ rwsem/lib/rwsem-spinlock.c	Thu Jan  1 01:00:00 1970
@@ -1,239 +0,0 @@
-/* rwsem-spinlock.c: R/W semaphores: contention handling functions for generic spinlock
- *                                   implementation
- *
- * Copyright (c) 2001   David Howells (dhowells@redhat.com).
- * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
- * - Derived also from comments by Linus
- */
-#include <linux/rwsem.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-struct rwsem_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	unsigned int		flags;
-#define RWSEM_WAITING_FOR_READ	0x00000001
-#define RWSEM_WAITING_FOR_WRITE	0x00000002
-};
-
-#if RWSEM_DEBUG
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
-{
-	if (sem->debug)
-		printk("[%d] %s({%d,%d})\n",
-		       current->pid,str,sem->activity,list_empty(&sem->wait_list)?0:1);
-}
-#endif
-
-/*
- * initialise the semaphore
- */
-void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->activity = 0;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
-
-/*
- * handle the lock being released whilst there are processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active count' _reached_ zero
- *   - the 'waiting count' is non-zero
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having flags zeroised
- */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-	int woken;
-
-	rwsemtrace(sem,"Entering __rwsem_do_wake");
-
-	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-
-	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - we leave the 'waiting count' incremented to signify potential contention
-	 */
-	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
-		sem->activity = -1;
-		list_del(&waiter->list);
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-		goto out;
-	}
-
-	/* grant an infinite number of read locks to the readers at the front of the queue */
-	woken = 0;
-	do {
-		list_del(&waiter->list);
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-		woken++;
-		if (list_empty(&sem->wait_list))
-			break;
-		waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-	} while (waiter->flags&RWSEM_WAITING_FOR_READ);
-
-	sem->activity += woken;
-
- out:
-	rwsemtrace(sem,"Leaving __rwsem_do_wake");
-	return sem;
-}
-
-/*
- * wake a single writer
- */
-static inline struct rw_semaphore *__rwsem_wake_one_writer(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-
-	sem->activity = -1;
-
-	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-	list_del(&waiter->list);
-
-	waiter->flags = 0;
-	wake_up_process(waiter->task);
-	return sem;
-}
-
-/*
- * get a read lock on the semaphore
- */
-void __down_read(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-	struct task_struct *tsk;
-
-	rwsemtrace(sem,"Entering __down_read");
-
-	spin_lock(&sem->wait_lock);
-
-	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity++;
-		spin_unlock(&sem->wait_lock);
-		goto out;
-	}
-
-	tsk = current;
-	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-
-	list_add_tail(&waiter.list,&sem->wait_list);
-
-	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.flags)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
- out:
-	rwsemtrace(sem,"Leaving __down_read");
-}
-
-/*
- * get a write lock on the semaphore
- * - note that we increment the waiting count anyway to indicate an exclusive lock
- */
-void __down_write(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-	struct task_struct *tsk;
-
-	rwsemtrace(sem,"Entering __down_write");
-
-	spin_lock(&sem->wait_lock);
-
-	if (sem->activity==0 && list_empty(&sem->wait_list)) {
-		/* granted */
-		sem->activity = -1;
-		spin_unlock(&sem->wait_lock);
-		goto out;
-	}
-
-	tsk = current;
-	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	waiter.task = tsk;
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-
-	list_add_tail(&waiter.list,&sem->wait_list);
-
-	/* we don't need to touch the semaphore struct anymore */
-	spin_unlock(&sem->wait_lock);
-
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter.flags)
-			break;
-		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
- out:
-	rwsemtrace(sem,"Leaving __down_write");
-}
-
-/*
- * release a read lock on the semaphore
- */
-void __up_read(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering __up_read");
-
-	spin_lock(&sem->wait_lock);
-
-	if (--sem->activity==0 && !list_empty(&sem->wait_list))
-		sem = __rwsem_wake_one_writer(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving __up_read");
-}
-
-/*
- * release a write lock on the semaphore
- */
-void __up_write(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering __up_write");
-
-	spin_lock(&sem->wait_lock);
-
-	sem->activity = 0;
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving __up_write");
-}
-
-EXPORT_SYMBOL(init_rwsem);
-EXPORT_SYMBOL(__down_read);
-EXPORT_SYMBOL(__down_write);
-EXPORT_SYMBOL(__up_read);
-EXPORT_SYMBOL(__up_write);
-#if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
-#endif
diff -urN 2.4.10pre12/lib/rwsem.c rwsem/lib/rwsem.c
--- 2.4.10pre12/lib/rwsem.c	Sat Jul 21 00:04:34 2001
+++ rwsem/lib/rwsem.c	Thu Sep 20 05:27:06 2001
@@ -1,210 +1,63 @@
-/* rwsem.c: R/W semaphores: contention handling functions
- *
- * Written by David Howells (dhowells@redhat.com).
- * Derived from arch/i386/kernel/semaphore.c
+/*
+ *  rw_semaphores generic spinlock version
+ *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
  */
-#include <linux/rwsem.h>
+
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <asm/semaphore.h>
 
-struct rwsem_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	unsigned int		flags;
-#define RWSEM_WAITING_FOR_READ	0x00000001
-#define RWSEM_WAITING_FOR_WRITE	0x00000002
+struct rwsem_wait_queue {
+	unsigned long retire;
+	struct task_struct * task;
+	struct list_head task_list;
 };
 
-#if RWSEM_DEBUG
-#undef rwsemtrace
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
-{
-	printk("sem=%p\n",sem);
-	printk("(sem)=%08lx\n",sem->count);
-	if (sem->debug)
-		printk("[%d] %s({%08lx})\n",current->pid,str,sem->count);
-}
-#endif
-
-/*
- * handle the lock being released whilst there are processes blocked on it that can now run
- * - if we come here, then:
- *   - the 'active part' of the count (&0x0000ffff) reached zero but has been re-incremented
- *   - the 'waiting part' of the count (&0xffff0000) is negative (and will still be so)
- *   - there must be someone on the queue
- * - the spinlock must be held by the caller
- * - woken process blocks are discarded from the list after having flags zeroised
- */
-static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter *waiter;
-	struct list_head *next;
-	signed long oldcount;
-	int woken, loop;
-
-	rwsemtrace(sem,"Entering __rwsem_do_wake");
-
-	/* only wake someone up if we can transition the active part of the count from 0 -> 1 */
- try_again:
-	oldcount = rwsem_atomic_update(RWSEM_ACTIVE_BIAS,sem) - RWSEM_ACTIVE_BIAS;
-	if (oldcount & RWSEM_ACTIVE_MASK)
-		goto undo;
-
-	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
-
-	/* try to grant a single write lock if there's a writer at the front of the queue
-	 * - note we leave the 'active part' of the count incremented by 1 and the waiting part
-	 *   incremented by 0x00010000
-	 */
-	if (!(waiter->flags & RWSEM_WAITING_FOR_WRITE))
-		goto readers_only;
-
-	list_del(&waiter->list);
-	waiter->flags = 0;
-	wake_up_process(waiter->task);
-	goto out;
-
-	/* grant an infinite number of read locks to the readers at the front of the queue
-	 * - note we increment the 'active part' of the count by the number of readers (less one
-	 *   for the activity decrement we've already done) before waking any processes up
-	 */
- readers_only:
-	woken = 0;
-	do {
-		woken++;
-
-		if (waiter->list.next==&sem->wait_list)
-			break;
-
-		waiter = list_entry(waiter->list.next,struct rwsem_waiter,list);
-
-	} while (waiter->flags & RWSEM_WAITING_FOR_READ);
-
-	loop = woken;
-	woken *= RWSEM_ACTIVE_BIAS-RWSEM_WAITING_BIAS;
-	woken -= RWSEM_ACTIVE_BIAS;
-	rwsem_atomic_add(woken,sem);
-
-	next = sem->wait_list.next;
-	for (; loop>0; loop--) {
-		waiter = list_entry(next,struct rwsem_waiter,list);
-		next = waiter->list.next;
-		waiter->flags = 0;
-		wake_up_process(waiter->task);
-	}
-
-	sem->wait_list.next = next;
-	next->prev = &sem->wait_list;
-
- out:
-	rwsemtrace(sem,"Leaving __rwsem_do_wake");
-	return sem;
-
-	/* undo the change to count, but check for a transition 1->0 */
- undo:
-	if (rwsem_atomic_update(-RWSEM_ACTIVE_BIAS,sem)!=0)
-		goto out;
-	goto try_again;
-}
-
-/*
- * wait for a lock to be granted
- */
-static inline struct rw_semaphore *rwsem_down_failed_common(struct rw_semaphore *sem,
-								 struct rwsem_waiter *waiter,
-								 signed long adjustment)
+void rwsem_down_failed(struct rw_semaphore *sem, long retire)
 {
 	struct task_struct *tsk = current;
-	signed long count;
-
-	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
-
-	/* set up my own style of waitqueue */
-	spin_lock(&sem->wait_lock);
-	waiter->task = tsk;
-
-	list_add_tail(&waiter->list,&sem->wait_list);
-
-	/* note that we're now waiting on the lock, but no longer actively read-locking */
-	count = rwsem_atomic_update(adjustment,sem);
-
-	/* if there are no longer active locks, wake the front queued process(es) up
-	 * - it might even be this process, since the waker takes a more active part
-	 */
-	if (!(count & RWSEM_ACTIVE_MASK))
-		sem = __rwsem_do_wake(sem);
+	struct rwsem_wait_queue wait;
 
-	spin_unlock(&sem->wait_lock);
+	sem->count += retire;
+	wait.retire = retire;
+	wait.task = tsk;
+	INIT_LIST_HEAD(&wait.task_list);
+	list_add(&wait.task_list, &sem->wait);
 
-	/* wait to be given the lock */
-	for (;;) {
-		if (!waiter->flags)
-			break;
+	do {
+		__set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&sem->lock);
 		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-	}
-
-	tsk->state = TASK_RUNNING;
-
-	return sem;
-}
-
-/*
- * wait for the read lock to be granted
- */
-struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	struct rwsem_waiter waiter;
-
-	rwsemtrace(sem,"Entering rwsem_down_read_failed");
-
-	waiter.flags = RWSEM_WAITING_FOR_READ;
-	rwsem_down_failed_common(sem,&waiter,RWSEM_WAITING_BIAS-RWSEM_ACTIVE_BIAS);
-
-	rwsemtrace(sem,"Leaving rwsem_down_read_failed");
-	return sem;
+		spin_lock(&sem->lock);
+	} while(wait.task_list.next);
 }
 
-/*
- * wait for the write lock to be granted
- */
-struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem)
+void rwsem_wake(struct rw_semaphore *sem)
 {
-	struct rwsem_waiter waiter;
+	struct list_head * entry, * head = &sem->wait;
+	int last = 0;
 
-	rwsemtrace(sem,"Entering rwsem_down_write_failed");
+	while ((entry = head->prev) != head) {
+		struct rwsem_wait_queue * wait;
 
-	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-	rwsem_down_failed_common(sem,&waiter,-RWSEM_ACTIVE_BIAS);
-
-	rwsemtrace(sem,"Leaving rwsem_down_write_failed");
-	return sem;
-}
+		wait = list_entry(entry, struct rwsem_wait_queue, task_list);
 
-/*
- * handle waking up a waiter on the semaphore
- * - up_read has decremented the active part of the count if we come here
- */
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering rwsem_wake");
+		if (wait->retire == RWSEM_WRITE_BLOCKING_BIAS) {
+			if (sem->count & RWSEM_READ_MASK)
+				break;
+			last = 1;
+		}
 
-	spin_lock(&sem->wait_lock);
-
-	/* do nothing if list empty */
-	if (!list_empty(&sem->wait_list))
-		sem = __rwsem_do_wake(sem);
-
-	spin_unlock(&sem->wait_lock);
-
-	rwsemtrace(sem,"Leaving rwsem_wake");
-
-	return sem;
+		/* convert write lock into read lock when read become active */
+		sem->count -= wait->retire;
+		list_del(entry);
+		entry->next = NULL;
+		wake_up_process(wait->task);
+			
+		if (last)
+			break;
+	}
 }
 
-EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_wake);
-#if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
-#endif
+EXPORT_SYMBOL(rwsem_down_failed);
+EXPORT_SYMBOL(rwsem_wake);

--aT9PWwzfKXlsBJM1--
