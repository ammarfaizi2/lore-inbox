Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSJOMy6>; Tue, 15 Oct 2002 08:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSJOMy6>; Tue, 15 Oct 2002 08:54:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47834 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262708AbSJOMyy>;
	Tue, 15 Oct 2002 08:54:54 -0400
Date: Tue, 15 Oct 2002 15:11:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Saurabh Desai <sdesai@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       NPT library mailing list <phil-list@redhat.com>
Subject: [patch] mmap-speedup-2.5.42-C3
Message-ID: <Pine.LNX.4.44.0210151438440.10496-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) adds three new, threading related
improvements to the VM.

the first one is an mmap inefficiency that was reported by Saurabh Desai.  
The test_str02 NPTL test-utility does the following: it tests the maximum
number of threads by creating a new thread, which thread creates a new
thread itself, etc. It basically creates thousands of parallel threads,
which means thousands of thread stacks.

NPTL uses mmap() to allocate new default thread stacks - and POSIX
requires us to install a 'guard page' as well, which is done via
mprotect(PROT_NONE) on the first page of the stack. This means that tons
of NPTL threads means 2* tons of vmas per MM, all allocated in a forward
fashion starting at the virtual address of 1 GB (TASK_UNMAPPED_BASE).

Saurabh reported a slowdown after the first couple of thousands of
threads, which i can reproduce as well. The reason for this slowdown is
the get_unmapped_area() implementation, which tries to achieve the most
compact virtual memory allocation, by searching for the vma at
TASK_UNMAPPED_BASE, and then linearly searching for a hole. With thousands
of linearly allocated vmas this is an increasingly painful thing to do ...

obviously, high-performance threaded applications will create stacks
without the guard page, which triggers the anon-vma merging code so we end
up with one large vma, not tons of small vmas.

it's also possible for userspace to be smarter by setting aside a stack
space and keeping a bitmap of allocated stacks and using MAP_FIXED (this
also enables it to do the guard page not via mprotect() but by keeping the
stacks apart by 1 page - ie. half the number of vmas) - but this also
decreases flexibility.

So i think that the default behavior nevertheless makes sense as well, so
IMO we should optimize it in the kernel.

there are various solutions to this problem, none of which solve the
problem in a 100% sufficient way, so i went for the simplest approach: i
added code to cache the 'last known hole' address in mm->free_area_cache,
which is used as a hint to get_unmapped_area().

this fixed the test_str02 testcase wonderfully, thread creation
performance for this testcase is O(1) again, but this simpler solution
obviously has a number of weak spots, and the (unlikely but possible)
worst-case is quite close to the current situation. In any case, this
approach does not sacrifice the perfect VM compactness out mmap()  
implementation achieves, so it's a performance optimization with no
externally visible consequences.

The most generic and still perfectly-compact VM allocation solution would
be to have a vma tree for the 'inverse virtual memory space', ie. a tree
of free virtual memory ranges, which could be searched and iterated like
the space of allocated vmas. I think we could do this by extending vmas,
but the drawback is larger vmas. This does not save us from having to scan
vmas linearly still, because the size constraint is still present, but at
least most of the anon-mmap activities are constant sized. (both malloc()
and the thread-stack allocator uses mostly fixed sizes.)

plus the patch improves the OOM-kill mechanism with two new items,
triggered by test_str02 as well:

- performance optimization: do not kill threads in the same thread group
  as the OOM-ing thread. (it's still necessery to scan over every thread
  though, as it's possible to have CLONE_VM threads in a different thread
  group - we do not want those to escape the OOM-kill.)

- to not let newly created child threads slip out of the group-kill. Note
  that the 2.4 kernel's OOM handler has the same problem, and it could be
  the reason why forkbombs occasionally slip out of the OOM kill.

the patch was tested on x86 SMP and UP. Saurabh, can you confirm that this
patch fixes the performance problem you saw in test_str02?

	Ingo

--- linux/include/linux/sched.h.orig	2002-10-15 12:51:21.000000000 +0200
+++ linux/include/linux/sched.h	2002-10-15 13:55:24.000000000 +0200
@@ -183,6 +183,7 @@
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
+	unsigned long free_area_cache;		/* first hole */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
--- linux/include/linux/init_task.h.orig	2002-10-15 13:08:15.000000000 +0200
+++ linux/include/linux/init_task.h	2002-10-15 13:57:57.000000000 +0200
@@ -41,6 +41,7 @@
 	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
+	.free_area_cache= TASK_UNMAPPED_BASE,			\
 }
 
 #define INIT_SIGNALS(sig) {	\
--- linux/include/asm-i386/processor.h.orig	2002-10-15 14:30:14.000000000 +0200
+++ linux/include/asm-i386/processor.h	2002-10-15 14:30:25.000000000 +0200
@@ -270,7 +270,7 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
--- linux/kernel/fork.c.orig	2002-10-15 12:52:07.000000000 +0200
+++ linux/kernel/fork.c	2002-10-15 14:18:53.000000000 +0200
@@ -215,6 +215,7 @@
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
 	mm->mmap_cache = NULL;
+	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->map_count = 0;
 	mm->rss = 0;
 	mm->cpu_vm_mask = 0;
@@ -308,6 +309,8 @@
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
+	mm->free_area_cache = TASK_UNMAPPED_BASE;
+
 	mm->pgd = pgd_alloc(mm);
 	if (mm->pgd)
 		return mm;
@@ -863,6 +866,14 @@
 
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
+	/*
+	 * Check for pending SIGKILL! The new thread should not be allowed
+	 * to slip out of an OOM kill. (or normal SIGKILL.)
+	 */
+	if (sigismember(&current->pending.signal, SIGKILL)) {
+		write_unlock_irq(&tasklist_lock);
+		goto bad_fork_cleanup_namespace;
+	}
 
 	/* CLONE_PARENT re-uses the old parent */
 	if (clone_flags & CLONE_PARENT)
--- linux/mm/mmap.c.orig	2002-10-15 12:53:32.000000000 +0200
+++ linux/mm/mmap.c	2002-10-15 14:11:22.000000000 +0200
@@ -633,24 +633,33 @@
 #ifndef HAVE_ARCH_UNMAPPED_AREA
 static inline unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	int found_hole = 0;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
-		vma = find_vma(current->mm, addr);
+		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
+	addr = mm->free_area_cache;
 
-	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
 		if (TASK_SIZE - len < addr)
 			return -ENOMEM;
+		/*
+		 * Record the first available hole.
+		 */
+		if (!found_hole && (!vma || addr < vma->vm_start)) {
+			mm->free_area_cache = addr;
+			found_hole = 1;
+		}
 		if (!vma || addr + len <= vma->vm_start)
 			return addr;
 		addr = vma->vm_end;
@@ -941,6 +950,12 @@
 	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
 	if (area->vm_flags & VM_LOCKED)
 		area->vm_mm->locked_vm -= len >> PAGE_SHIFT;
+	/*
+	 * Is this a new hole at the lowest possible address?
+	 */
+	if (area->vm_start >= TASK_UNMAPPED_BASE &&
+				area->vm_start < area->vm_mm->free_area_cache)
+	      area->vm_mm->free_area_cache = area->vm_start;
 
 	remove_shared_vm_struct(area);
 
--- linux/mm/oom_kill.c.orig	2002-10-15 13:59:43.000000000 +0200
+++ linux/mm/oom_kill.c	2002-10-15 14:00:05.000000000 +0200
@@ -175,9 +175,13 @@
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");
 
-	/* kill all processes that share the ->mm (i.e. all threads) */
+	oom_kill_task(p);
+	/*
+	 * kill all processes that share the ->mm (i.e. all threads),
+	 * but are in a different thread group
+	 */
 	do_each_thread(g, q)
-		if (q->mm == p->mm)
+		if (q->mm == p->mm && q->tgid != p->tgid)
 			oom_kill_task(q);
 	while_each_thread(g, q);
 

