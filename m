Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319563AbSH3NbG>; Fri, 30 Aug 2002 09:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319564AbSH3NbG>; Fri, 30 Aug 2002 09:31:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21941 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319563AbSH3NbE>;
	Fri, 30 Aug 2002 09:31:04 -0400
Date: Fri, 30 Aug 2002 15:38:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ldt-fix-2.5.32-A3
Message-ID: <Pine.LNX.4.44.0208301504060.28402-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is an updated version of the LDT fixes. It fixes the following kinds
of problems:

 - fix a possible gcc optimization causing a race causing the loading of a
   corrupt LDT descriptor upon context switch. [this fix got simplified
   over previous versions.]

 - remove an unconditional OOM printk, and there's no need to set ->size
   in the OOM path.

 - fix preemption bugs, load_LDT()/clear_LDT() was not preemption-safe,
   when it was used outside of spinlocks.

the context-switch race is the following. 'LDT modification' is the
following operation: the seg->ldt pointer is modified, then seg->size is
modified. In theory gcc is free to reschedule the two modifications, and
first modify ->size, then ->ldt. Thus if this modification is not
synchronized with context-switches, another thread might see a temporary
state of the new ->size [which was increased], but still the old pointer.
Ie.:

	CPU0				CPU1

	pc->size = newsize;
					load_LDT(); // (oldptr, newsize)
	pc->ldt = newptr;

the corrupt LDT is loaded until the SMP cross-call is sent, leaving the
window open for many usecs.

the fix is to put a wmb() after ->ldt modifications. [this is also in
preparation of not-write-ordered SMP x86 designs.]

i have tested the patch on 2.5.32-BK, SMP and UP as well.

	Ingo

--- linux/arch/i386/kernel/ldt.c.orig	Fri Aug 30 08:57:38 2002
+++ linux/arch/i386/kernel/ldt.c	Fri Aug 30 15:30:34 2002
@@ -49,17 +49,20 @@
 		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
 	oldldt = pc->ldt;
 	memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
-	wmb();
 	pc->ldt = newldt;
+	wmb();
 	pc->size = mincount;
+	wmb();
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
--- linux/include/asm-i386/mmu.h.orig	Sun Jun  9 07:30:36 2002
+++ linux/include/asm-i386/mmu.h	Fri Aug 30 15:29:57 2002
@@ -10,7 +10,7 @@
 typedef struct { 
 	int size;
 	struct semaphore sem;
-	void *	ldt;
+	void *ldt;
 } mm_context_t;
 
 #endif
--- linux/include/asm-i386/desc.h.orig	Fri Aug 30 08:57:40 2002
+++ linux/include/asm-i386/desc.h	Fri Aug 30 15:28:27 2002
@@ -86,14 +86,17 @@
 
 static inline void clear_LDT(void)
 {
-	set_ldt_desc(smp_processor_id(), &default_ldt[0], 5);
+	int cpu = get_cpu();
+
+	set_ldt_desc(cpu, &default_ldt[0], 5);
 	load_LDT_desc();
+	put_cpu();
 }
 
 /*
  * load one particular LDT into the current CPU
  */
-static inline void load_LDT (mm_context_t *pc)
+static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
 {
 	void *segments = pc->ldt;
 	int count = pc->size;
@@ -103,8 +106,15 @@
 		count = 5;
 	}
 		
-	set_ldt_desc(smp_processor_id(), segments, count);
+	set_ldt_desc(cpu, segments, count);
 	load_LDT_desc();
+}
+
+static inline void load_LDT(mm_context_t *pc)
+{
+	int cpu = get_cpu();
+	load_LDT_nolock(pc, cpu);
+	put_cpu();
 }
 
 #endif /* !__ASSEMBLY__ */
--- linux/include/asm-i386/mmu_context.h.orig	Fri Aug 30 08:57:31 2002
+++ linux/include/asm-i386/mmu_context.h	Fri Aug 30 15:32:20 2002
@@ -44,7 +44,7 @@
 		 * load the LDT, if the LDT is different:
 		 */
 		if (unlikely(prev->context.ldt != next->context.ldt))
-			load_LDT(&next->context);
+			load_LDT_nolock(&next->context, cpu);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -56,7 +56,7 @@
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
 			load_cr3(next->pgd);
-			load_LDT(&next->context);
+			load_LDT_nolock(&next->context, cpu);
 		}
 	}
 #endif

