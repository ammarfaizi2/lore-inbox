Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264961AbSJPJaG>; Wed, 16 Oct 2002 05:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSJPJaF>; Wed, 16 Oct 2002 05:30:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38620 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264961AbSJPJaD>;
	Wed, 16 Oct 2002 05:30:03 -0400
Date: Wed, 16 Oct 2002 11:47:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Jakub Jelinek <jakub@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
In-Reply-To: <m3u1jmpwty.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0210161144220.22365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Oct 2002, Andi Kleen wrote:

> You can argue against it, but it doesn't change the fact that
> get_unmapped_area is a significant user of CPU on a KDE startup. [...]

i dont think anyone argued against anything - i'm trying to understand
KDE's vma layout, and i dont think it's "wrong" in any way. It uses a
reasonable layout, and the kernel should really be able to handle mmap()
mappings when there are 100+ already existing mappings. Would you mind to
check KDE under 2.5.43 with the attached patch, does it change the
get_unmapped_area() cost?

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
 

