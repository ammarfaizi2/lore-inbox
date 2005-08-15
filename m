Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVHOW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVHOW7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVHOW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:59:30 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:60420 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932188AbVHOW7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:59:21 -0400
Date: Mon, 15 Aug 2005 15:59:39 -0700
From: zach@vmware.com
Message-Id: <200508152259.j7FMxdh2005320@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
X-OriginalArrivalTime: 15 Aug 2005 22:59:19.0304 (UTC) FILETIME=[F7E1A080:01C5A1EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the LDT a desc_struct pointer, since this is what it actually is.
There is code which relies on the fact that LDTs are allocated in page
chunks, and it is both cleaner and more convenient to keep the rather
poorly named "size" variable from the LDT in terms of LDT pages.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/mmu.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mmu.h	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mmu.h	2005-08-15 11:19:49.000000000 -0700
@@ -9,9 +9,9 @@
  * cpu_vm_mask is used to optimize ldt flushing.
  */
 typedef struct { 
-	int size;
 	struct semaphore sem;
-	void *ldt;
+	struct desc_struct *ldt;
+	int ldt_pages;
 } mm_context_t;
 
 #endif
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-15 11:19:49.000000000 -0700
@@ -6,6 +6,9 @@
 
 #define CPU_16BIT_STACK_SIZE 1024
 
+/* The number of LDT entries per page */
+#define LDT_ENTRIES_PER_PAGE (PAGE_SIZE / LDT_ENTRY_SIZE)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/preempt.h>
@@ -30,7 +33,7 @@
 static inline unsigned long get_desc_base(struct desc_struct *desc)
 {
 	unsigned long base;
-	base = ((desc->a >> 16)  & 0x0000ffff) |
+	base = (desc->a >> 16) |
 		((desc->b << 16) & 0x00ff0000) |
 		(desc->b & 0xff000000);
 	return base;
@@ -171,7 +174,7 @@
 static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
 {
 	void *segments = pc->ldt;
-	int count = pc->size;
+	int count = pc->ldt_pages * LDT_ENTRIES_PER_PAGE;
 
 	if (likely(!count)) {
 		segments = &default_ldt[0];
Index: linux-2.6.13/include/asm-i386/mmu_context.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mmu_context.h	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mmu_context.h	2005-08-15 11:19:49.000000000 -0700
@@ -19,7 +19,7 @@
 	memset(&mm->context, 0, sizeof(mm->context));
 	init_MUTEX(&mm->context.sem);
 	old_mm = current->mm;
-	if (old_mm && unlikely(old_mm->context.size > 0)) {
+	if (old_mm && unlikely(old_mm->context.ldt)) {
 		retval = copy_ldt(&mm->context, &old_mm->context);
 	}
 	if (retval == 0)
@@ -32,7 +32,7 @@
  */
 static inline void destroy_context(struct mm_struct *mm)
 {
-	if (unlikely(mm->context.size))
+	if (unlikely(mm->context.ldt))
 		destroy_ldt(mm);
 	del_lazy_mm(mm);
 }
Index: linux-2.6.13/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/mach_desc.h	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/mach_desc.h	2005-08-15 11:19:49.000000000 -0700
@@ -62,11 +62,10 @@
 	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
-static inline int write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+static inline int write_ldt_entry(struct desc_struct *ldt, int entry, __u32 entry_a, __u32 entry_b)
 {
-	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
-	*lp = entry_a;
-	*(lp+1) = entry_b;
+	ldt[entry].a = entry_a;
+	ldt[entry].b = entry_b;
 	return 0;
 }
 
Index: linux-2.6.13/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ptrace.c	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ptrace.c	2005-08-15 11:19:49.000000000 -0700
@@ -164,18 +164,20 @@
 	 * and APM bios ones we just ignore here.
 	 */
 	if (segment_from_ldt(seg)) {
-		u32 *desc;
+		mm_context_t *context;
+		struct desc_struct *desc;
 		unsigned long base;
 
-		down(&child->mm->context.sem);
-		desc = child->mm->context.ldt + (seg & ~7);
-		base = (desc[0] >> 16) | ((desc[1] & 0xff) << 16) | (desc[1] & 0xff000000);
+		context = &child->mm->context;
+		down(&context->sem);
+		desc = &context->ldt[segment_index(seg)];
+		base = get_desc_base(desc);
 
 		/* 16-bit code segment? */
-		if (!((desc[1] >> 22) & 1))
+		if (!get_desc_32bit(desc))
 			addr &= 0xffff;
 		addr += base;
-		up(&child->mm->context.sem);
+		up(&context->sem);
 	}
 	return addr;
 }
Index: linux-2.6.13/arch/i386/kernel/ldt.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/ldt.c	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/ldt.c	2005-08-15 11:19:49.000000000 -0700
@@ -28,28 +28,27 @@
 }
 #endif
 
-static inline int alloc_ldt(mm_context_t *pc, const int oldsize, int mincount, const int reload)
+static inline int alloc_ldt(mm_context_t *pc, const int old_pages, int new_pages, const int reload)
 {
-	void *oldldt;
-	void *newldt;
+	struct desc_struct *oldldt;
+	struct desc_struct *newldt;
 
-	mincount = (mincount+511)&(~511);
-	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
-		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
+	if (new_pages > 1)
+		newldt = vmalloc(new_pages*PAGE_SIZE);
 	else
-		newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
+		newldt = kmalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!newldt)
 		return -ENOMEM;
 
-	if (oldsize)
-		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
+	if (old_pages)
+		memcpy(newldt, pc->ldt, old_pages*PAGE_SIZE);
 	oldldt = pc->ldt;
 	if (reload)
-		memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, (mincount-oldsize)*LDT_ENTRY_SIZE);
+		memset(newldt+old_pages*LDT_ENTRIES_PER_PAGE, 0, (new_pages-old_pages)*PAGE_SIZE);
 	pc->ldt = newldt;
 	wmb();
-	pc->size = mincount;
+	pc->ldt_pages = new_pages;
 	wmb();
 
 	/*
@@ -60,20 +59,20 @@
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
-		SetPagesLDT(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / PAGE_SIZE);
+		SetPagesLDT(pc->ldt, pc->ldt_pages);
 		load_LDT(pc);
 		mask = cpumask_of_cpu(smp_processor_id());
 		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
-		SetPagesLDT(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / PAGE_SIZE);
+		SetPagesLDT(pc->ldt, pc->ldt_pages);
 		load_LDT(pc);
 #endif
 	}
-	if (oldsize) {
-		ClearPagesLDT(oldldt, (oldsize * LDT_ENTRY_SIZE) / PAGE_SIZE);
-		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
+	if (old_pages) {
+		ClearPagesLDT(oldldt, old_pages);
+		if (old_pages > 1)
 			vfree(oldldt);
 		else
 			kfree(oldldt);
@@ -86,10 +85,10 @@
 	int err;
 
 	down(&old->sem);
-	err = alloc_ldt(new, 0, old->size, 0);
+	err = alloc_ldt(new, 0, old->ldt_pages, 0);
 	if (!err) {
-		memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
-		SetPagesLDT(new->ldt, (new->size * LDT_ENTRY_SIZE) / PAGE_SIZE);
+		memcpy(new->ldt, old->ldt, old->ldt_pages*PAGE_SIZE);
+		SetPagesLDT(new->ldt, new->ldt_pages);
 	}
 	up(&old->sem);
 	return err;
@@ -97,14 +96,16 @@
 
 void destroy_ldt(struct mm_struct *mm)
 {
+	int pages = mm->context.ldt_pages;
+
 	if (mm == current->active_mm)
 		clear_LDT();
-	ClearPagesLDT(mm->context.ldt, (mm->context.size * LDT_ENTRY_SIZE) / PAGE_SIZE);
-	if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
+	ClearPagesLDT(mm->context.ldt, pages);
+	if (pages > 1)
 		vfree(mm->context.ldt);
 	else
 		kfree(mm->context.ldt);
-	mm->context.size = 0;
+	mm->context.ldt_pages = 0;
 }
 
 static int read_ldt(void __user * ptr, unsigned long bytecount)
@@ -113,13 +114,13 @@
 	unsigned long size;
 	struct mm_struct * mm = current->mm;
 
-	if (!mm->context.size)
+	if (!mm->context.ldt_pages)
 		return 0;
 	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
 		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 
 	down(&mm->context.sem);
-	size = mm->context.size*LDT_ENTRY_SIZE;
+	size = mm->context.ldt_pages*PAGE_SIZE;
 	if (size > bytecount)
 		size = bytecount;
 
@@ -166,6 +167,7 @@
 	__u32 entry_1, entry_2;
 	int error;
 	struct user_desc ldt_info;
+	int page_number;
 
 	error = -EINVAL;
 	if (bytecount != sizeof(ldt_info))
@@ -184,10 +186,11 @@
 			goto out;
 	}
 
+	page_number = ldt_info.entry_number / LDT_ENTRIES_PER_PAGE;
 	down(&mm->context.sem);
-	if (ldt_info.entry_number >= mm->context.size) {
-		error = alloc_ldt(&current->mm->context, mm->context.size,
-					ldt_info.entry_number+1, 1);
+	if (page_number >= mm->context.ldt_pages) {
+		error = alloc_ldt(&current->mm->context, mm->context.ldt_pages,
+					page_number+1, 1);
 		if (error < 0)
 			goto out_unlock;
 	}
Index: linux-2.6.13/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/kprobes.c	2005-08-15 11:16:59.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/kprobes.c	2005-08-15 11:19:49.000000000 -0700
@@ -164,8 +164,7 @@
 	 */
 	if (segment_from_ldt(regs->xcs) && (current->mm)) {
 		struct desc_struct *desc;
-		desc = (struct desc_struct *) ((char *) current->mm->context.ldt +
-						 (segment_index(regs->xcs) * 8));
+		desc = &current->mm->context.ldt[segment_index(regs->xcs)];
 		addr = (kprobe_opcode_t *) (get_desc_base(desc) + regs->eip -
 						sizeof(kprobe_opcode_t));
 	} else {
