Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317669AbSGUJBp>; Sun, 21 Jul 2002 05:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317671AbSGUJBp>; Sun, 21 Jul 2002 05:01:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6614 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317669AbSGUJBn>;
	Sun, 21 Jul 2002 05:01:43 -0400
Date: Sun, 21 Jul 2002 11:03:44 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] context-switching & LDT fixes, 2.5.27
In-Reply-To: <Pine.LNX.4.44.0207211041130.3168-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207211103280.3486-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here's the full patch against 2.5.27:

diff -rNu linux-2.5.27-vanilla/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-2.5.27-vanilla/arch/i386/kernel/cpu/common.c	Sun Jul 21 11:01:25 2002
+++ linux/arch/i386/kernel/cpu/common.c	Sun Jul 21 10:32:02 2002
@@ -454,7 +454,7 @@
 	 */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
-	if(current->mm)
+	if (current->mm)
 		BUG();
 	enter_lazy_tlb(&init_mm, current, nr);
 
diff -rNu linux-2.5.27-vanilla/arch/i386/kernel/ldt.c linux/arch/i386/kernel/ldt.c
--- linux-2.5.27-vanilla/arch/i386/kernel/ldt.c	Sun Jun  9 07:27:36 2002
+++ linux/arch/i386/kernel/ldt.c	Sun Jul 21 10:58:21 2002
@@ -49,17 +49,20 @@
 		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
 	oldldt = pc->ldt;
 	memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
-	wmb();
+	spin_lock_irq(&pc->lock);
 	pc->ldt = newldt;
 	pc->size = mincount;
+	spin_unlock_irq(&pc->lock);
+
 	if (reload) {
 		load_LDT(pc);
 #ifdef CONFIG_SMP
-		if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
+		preempt_disable();
+		if (current->mm->cpu_vm_mask != (1 << smp_processor_id()))
 			smp_call_function(flush_ldt, 0, 1, 1);
+		preempt_enable();
 #endif
 	}
-	wmb();
 	if (oldsize) {
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
 			vfree(oldldt);
@@ -72,11 +75,8 @@
 static inline int copy_ldt(mm_context_t *new, mm_context_t *old)
 {
 	int err = alloc_ldt(new, old->size, 0);
-	if (err < 0) {
-		printk(KERN_WARNING "ldt allocation failed\n");
-		new->size = 0;
+	if (err < 0)
 		return err;
-	}
 	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
 	return 0;
 }
@@ -91,6 +91,7 @@
 	int retval = 0;
 
 	init_MUTEX(&mm->context.sem);
+	spin_lock_init(&mm->context.lock);
 	mm->context.size = 0;
 	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
diff -rNu linux-2.5.27-vanilla/include/asm-i386/desc.h linux/include/asm-i386/desc.h
--- linux-2.5.27-vanilla/include/asm-i386/desc.h	Sun Jun  9 07:26:24 2002
+++ linux/include/asm-i386/desc.h	Sun Jul 21 10:30:57 2002
@@ -82,17 +82,18 @@
 
 static inline void clear_LDT(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = get_cpu();
+
 	set_ldt_desc(cpu, &default_ldt[0], 5);
 	__load_LDT(cpu);
+	put_cpu();
 }
 
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT (mm_context_t *pc)
+static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
 {
-	int cpu = smp_processor_id();
 	void *segments = pc->ldt;
 	int count = pc->size;
 
@@ -103,6 +104,13 @@
 		
 	set_ldt_desc(cpu, segments, count);
 	__load_LDT(cpu);
+}
+
+static inline void load_LDT (mm_context_t *pc)
+{
+	spin_lock_irq(&pc->lock);
+	load_LDT_nolock(pc, smp_processor_id());
+	spin_unlock_irq(&pc->lock);
 }
 
 #endif /* !__ASSEMBLY__ */
diff -rNu linux-2.5.27-vanilla/include/asm-i386/mmu.h linux/include/asm-i386/mmu.h
--- linux-2.5.27-vanilla/include/asm-i386/mmu.h	Sun Jun  9 07:30:36 2002
+++ linux/include/asm-i386/mmu.h	Sun Jul 21 10:49:00 2002
@@ -6,11 +6,16 @@
  * we put the segment information here.
  *
  * cpu_vm_mask is used to optimize ldt flushing.
+ *
+ * The spinlock is used to protect context switches
+ * against inconsistent values of ->ldt and ->size.
  */
 typedef struct { 
-	int size;
 	struct semaphore sem;
-	void *	ldt;
+	spinlock_t lock;
+	void *ldt;
+	int size;
 } mm_context_t;
 
+#define INIT_CONTEXT { lock: SPIN_LOCK_UNLOCKED }
 #endif
diff -rNu linux-2.5.27-vanilla/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux-2.5.27-vanilla/include/asm-i386/mmu_context.h	Sun Jun  9 07:26:26 2002
+++ linux/include/asm-i386/mmu_context.h	Sun Jul 21 10:50:54 2002
@@ -40,23 +40,28 @@
 		/* Re-load page tables */
 		load_cr3(next->pgd);
 
-		/* load_LDT, if either the previous or next thread
+		/* load LDT, if either the previous or next thread
 		 * has a non-default LDT.
 		 */
-		if (next->context.size+prev->context.size)
-			load_LDT(&next->context);
+		if (next->context.size + prev->context.size) {
+			_raw_spin_lock(&next->context.lock);
+			load_LDT_nolock(&next->context, cpu);
+			_raw_spin_unlock(&next->context.lock);
+		}
 	}
 #ifdef CONFIG_SMP
 	else {
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		if(cpu_tlbstate[cpu].active_mm != next)
+		if (cpu_tlbstate[cpu].active_mm != next)
 			BUG();
-		if(!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
+		if (!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
 			load_cr3(next->pgd);
-			load_LDT(&next->context);
+			_raw_spin_lock(&next->context.lock);
+			load_LDT_nolock(&next->context, cpu);
+			_raw_spin_unlock(&next->context.lock);
 		}
 	}
 #endif
diff -rNu linux-2.5.27-vanilla/include/linux/init_task.h linux/include/linux/init_task.h
--- linux-2.5.27-vanilla/include/linux/init_task.h	Sun Jun  9 07:27:21 2002
+++ linux/include/linux/init_task.h	Sun Jul 21 11:04:46 2002
@@ -18,6 +18,10 @@
 	fd_array:	{ NULL, } 			\
 }
 
+#ifndef INIT_CONTEXT
+# define INIT_CONTEXT { }
+#endif
+
 #define INIT_MM(name) \
 {			 				\
 	mm_rb:		RB_ROOT,			\
@@ -27,6 +31,7 @@
 	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
+	context:	INIT_CONTEXT,			\
 }
 
 #define INIT_SIGNALS {	\

