Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSGVTxf>; Mon, 22 Jul 2002 15:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317783AbSGVTxf>; Mon, 22 Jul 2002 15:53:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53903 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317782AbSGVTxd>;
	Mon, 22 Jul 2002 15:53:33 -0400
Date: Mon, 22 Jul 2002 21:55:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] context-switching & LDT fixes, 2.5.27
Message-ID: <Pine.LNX.4.44.0207222154320.25175-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch [against current BK tree] fixes a number of x86 LDT
related SMP bugs in the context-switching code:

 - update mm->context atomically wrt. context-switching. The segment 
   semaphore alone is not enough, since the context-switching code does
   not use it. Without this fix a thread on another CPU might see an
   inconsistent ->count or ->ldt value, causing either to load the default
   5-entry LDT descriptor with an incorrect size, or loading a non-default
   LDT descriptor.

 - copy_ldt() must not printk on an allocation error - it's relatively
   easy to trigger this message.

 - copy_ldt() does not have to set new->size to 0 - it's 0 already in 
   this codepath.

 - introduce load_LDT_nolock to have maximum performance in the
   context-switch codepath, which path is IRQ and preempt-locked already.

 - fix preempt bugs in clean_LDT() and alloc_ldt().

non-x86 architectures should not be affected by this patch. x86 SMP and UP
kernels compile, boot & work just fine.

	Ingo

diff -rNu linux-orig/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-orig/arch/i386/kernel/cpu/common.c	Mon Jul 22 21:04:49 2002
+++ linux/arch/i386/kernel/cpu/common.c	Mon Jul 22 21:55:09 2002
@@ -454,7 +454,7 @@
 	 */
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
-	if(current->mm)
+	if (current->mm)
 		BUG();
 	enter_lazy_tlb(&init_mm, current, nr);
 
diff -rNu linux-orig/arch/i386/kernel/ldt.c linux/arch/i386/kernel/ldt.c
--- linux-orig/arch/i386/kernel/ldt.c	Mon Jul 22 21:04:49 2002
+++ linux/arch/i386/kernel/ldt.c	Mon Jul 22 21:55:09 2002
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
diff -rNu linux-orig/include/asm-i386/desc.h linux/include/asm-i386/desc.h
--- linux-orig/include/asm-i386/desc.h	Mon Jul 22 21:04:49 2002
+++ linux/include/asm-i386/desc.h	Mon Jul 22 21:55:09 2002
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
diff -rNu linux-orig/include/asm-i386/mmu.h linux/include/asm-i386/mmu.h
--- linux-orig/include/asm-i386/mmu.h	Mon Jul 22 21:04:49 2002
+++ linux/include/asm-i386/mmu.h	Mon Jul 22 21:55:09 2002
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
diff -rNu linux-orig/include/asm-i386/mmu_context.h linux/include/asm-i386/mmu_context.h
--- linux-orig/include/asm-i386/mmu_context.h	Mon Jul 22 21:04:49 2002
+++ linux/include/asm-i386/mmu_context.h	Mon Jul 22 21:55:09 2002
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
diff -rNu linux-orig/include/linux/init_task.h linux/include/linux/init_task.h
--- linux-orig/include/linux/init_task.h	Mon Jul 22 21:04:49 2002
+++ linux/include/linux/init_task.h	Mon Jul 22 21:55:09 2002
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
@@ -27,6 +31,8 @@
 	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
+	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
+	context:	INIT_CONTEXT,			\
 }
 
 #define INIT_SIGNALS {	\

