Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSHLQBF>; Mon, 12 Aug 2002 12:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318742AbSHLQBF>; Mon, 12 Aug 2002 12:01:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11704 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318735AbSHLQAz>;
	Mon, 12 Aug 2002 12:00:55 -0400
Date: Mon, 12 Aug 2002 20:03:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>, Christoph Hellwig <hch@infradead.org>
Subject: [patch] tls-2.5.31-D9
In-Reply-To: <Pine.LNX.4.44.0208121939260.22188-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208121943110.22761-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


okay, here is YAGL. (Yet Another GDT Layout)

3 TLS entries, 9 cycles copying and no branches in the context-switch
path. The patch also adds Christoph's suggestion and renames
modify_ldt_ldt_s (yuck!) to user_desc.

(all patches i posted were test-compiled and test-booted against
2.5.31-vanilla.)

	Ingo

--- linux/drivers/pnp/pnpbios_core.c.orig	Mon Aug 12 17:51:27 2002
+++ linux/drivers/pnp/pnpbios_core.c	Mon Aug 12 17:56:27 2002
@@ -90,7 +90,8 @@
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
 /* The PnP BIOS entries in the GDT */
-#define PNP_GDT    (0x0060)
+#define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
+
 #define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
 #define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
 #define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
--- linux/arch/i386/kernel/cpu/common.c.orig	Mon Aug 12 17:56:01 2002
+++ linux/arch/i386/kernel/cpu/common.c	Mon Aug 12 17:56:27 2002
@@ -423,6 +423,7 @@
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = init_tss + cpu;
+	struct thread_struct *thread = &current->thread;
 
 	if (test_and_set_bit(cpu, &cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -447,9 +448,13 @@
 	 */
 	if (cpu) {
 		memcpy(cpu_gdt_table[cpu], cpu_gdt_table[0], GDT_SIZE);
-		cpu_gdt_descr[cpu].size = GDT_SIZE;
+		cpu_gdt_descr[cpu].size = GDT_SIZE - 1;
 		cpu_gdt_descr[cpu].address = (unsigned long)cpu_gdt_table[cpu];
 	}
+	/*
+	 * Set up the per-thread TLS descriptor cache:
+	 */
+	memcpy(thread->tls_array, cpu_gdt_table[cpu], GDT_ENTRY_TLS_MAX * 8);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
@@ -468,9 +473,9 @@
 		BUG();
 	enter_lazy_tlb(&init_mm, current, cpu);
 
-	t->esp0 = current->thread.esp0;
+	t->esp0 = thread->esp0;
 	set_tss_desc(cpu,t);
-	cpu_gdt_table[cpu][TSS_ENTRY].b &= 0xfffffdff;
+	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
--- linux/arch/i386/kernel/entry.S.orig	Mon Aug 12 17:56:02 2002
+++ linux/arch/i386/kernel/entry.S	Mon Aug 12 17:56:27 2002
@@ -753,6 +753,7 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_get_thread_area
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/arch/i386/kernel/head.S.orig	Mon Aug 12 17:56:02 2002
+++ linux/arch/i386/kernel/head.S	Mon Aug 12 17:56:27 2002
@@ -239,12 +239,7 @@
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
-#ifdef CONFIG_SMP
-	movl $(__KERNEL_DS), %eax
-	movl %eax,%ss		# Reload the stack pointer (segment only)
-#else
-	lss stack_start,%esp	# Load processor stack
-#endif
+	movl %eax,%ss
 	xorl %eax,%eax
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
@@ -412,34 +407,40 @@
 
 ALIGN
 /*
- * The Global Descriptor Table contains 20 quadwords, per-CPU.
+ * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
-	.quad 0x0000000000000000	/* TLS descriptor */
-	.quad 0x00cf9a000000ffff	/* 0x10 kernel 4GB code at 0x00000000 */
-	.quad 0x00cf92000000ffff	/* 0x18 kernel 4GB data at 0x00000000 */
-	.quad 0x00cffa000000ffff	/* 0x23 user   4GB code at 0x00000000 */
-	.quad 0x00cff2000000ffff	/* 0x2b user   4GB data at 0x00000000 */
-	.quad 0x0000000000000000	/* TSS descriptor */
-	.quad 0x0000000000000000	/* LDT descriptor */
+	.quad 0x0000000000000000	/* 0x0b reserved */
+	.quad 0x0000000000000000	/* 0x13 reserved */
+	.quad 0x0000000000000000	/* 0x1b reserved */
+	.quad 0x00cffa000000ffff	/* 0x23 user 4GB code at 0x00000000 */
+	.quad 0x00cff2000000ffff	/* 0x2b user 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
+	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
+	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
+	.quad 0x0000000000000000	/* 0x4b reserved */
+	.quad 0x0000000000000000	/* 0x53 reserved */
+	.quad 0x0000000000000000	/* 0x5b reserved */
+
+	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x70 TSS descriptor */
+	.quad 0x0000000000000000	/* 0x78 LDT descriptor */
+
+	/* Segments used for calling PnP BIOS */
+	.quad 0x00c09a0000000000	/* 0x80 32-bit code */
+	.quad 0x00809a0000000000	/* 0x88 16-bit code */
+	.quad 0x0080920000000000	/* 0x90 16-bit data */
+	.quad 0x0080920000000000	/* 0x98 16-bit data */
+	.quad 0x0080920000000000	/* 0xa0 16-bit data */
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * and limits are set at run time.
 	 */
-	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
-	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
-	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
-	.quad 0x0040920000000000	/* 0x58 APM DS    data */
-	/* Segments used for calling PnP BIOS */
-	.quad 0x00c09a0000000000	/* 0x60 32-bit code */
-	.quad 0x00809a0000000000	/* 0x68 16-bit code */
-	.quad 0x0080920000000000	/* 0x70 16-bit data */
-	.quad 0x0080920000000000	/* 0x78 16-bit data */
-	.quad 0x0080920000000000	/* 0x80 16-bit data */
-	.quad 0x0000000000000000	/* 0x88 not used */
-	.quad 0x0000000000000000	/* 0x90 not used */
-	.quad 0x0000000000000000	/* 0x98 not used */
+	.quad 0x00409a0000000000	/* 0xa8 APM CS    code */
+	.quad 0x00009a0000000000	/* 0xb0 APM CS 16 code (16 bit) */
+	.quad 0x0040920000000000	/* 0xb8 APM DS    data */
 
 #if CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
--- linux/arch/i386/kernel/process.c.orig	Mon Aug 12 17:56:02 2002
+++ linux/arch/i386/kernel/process.c	Mon Aug 12 17:56:27 2002
@@ -681,11 +681,8 @@
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
-	 *
-	 * NOTE: it's faster to do the two stores unconditionally
-	 * than to branch away.
 	 */
-	load_TLS_desc(next, cpu);
+	load_TLS(next, cpu);
 
 	/*
 	 * Save away %fs and %gs. No need to save %es and %ds, as
@@ -834,35 +831,114 @@
 #undef first_sched
 
 /*
- * Set the Thread-Local Storage area:
+ * sys_alloc_thread_area: get a yet unused TLS descriptor index.
  */
-asmlinkage int sys_set_thread_area(unsigned long base, unsigned long flags)
+static int get_free_idx(void)
 {
 	struct thread_struct *t = &current->thread;
-	int writable = 0;
-	int cpu;
+	int idx;
 
-	/* do not allow unused flags */
-	if (flags & ~TLS_FLAGS_MASK)
+	for (idx = 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
+		if (desc_empty(t->tls_array + idx))
+			return idx + GDT_ENTRY_TLS_MIN;
+	return -ESRCH;
+}
+
+/*
+ * Set a given TLS descriptor:
+ */
+asmlinkage int sys_set_thread_area(struct user_desc *u_info)
+{
+	struct thread_struct *t = &current->thread;
+	struct user_desc info;
+	struct desc_struct *desc;
+	int cpu, idx;
+
+	if (copy_from_user(&info, u_info, sizeof(info)))
+		return -EFAULT;
+	idx = info.entry_number;
+
+	/*
+	 * index -1 means the kernel should try to find and
+	 * allocate an empty descriptor:
+	 */
+	if (idx == -1) {
+		idx = get_free_idx();
+		if (idx < 0)
+			return idx;
+		if (put_user(idx, &u_info->entry_number))
+			return -EFAULT;
+	}
+
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
-	if (flags & TLS_FLAG_WRITABLE)
-		writable = 1;
+	desc = t->tls_array + idx - GDT_ENTRY_TLS_MIN;
 
 	/*
 	 * We must not get preempted while modifying the TLS.
 	 */
 	cpu = get_cpu();
 
-        t->tls_desc.a = ((base & 0x0000ffff) << 16) | 0xffff;
-
-        t->tls_desc.b = (base & 0xff000000) | ((base & 0x00ff0000) >> 16) |
-				0xf0000 | (writable << 9) | (1 << 15) |
-					(1 << 22) | (1 << 23) | 0x7000;
+	if (LDT_empty(&info)) {
+		desc->a = 0;
+		desc->b = 0;
+	} else {
+		desc->a = LDT_entry_a(&info);
+		desc->b = LDT_entry_b(&info);
+	}
+	load_TLS(t, cpu);
 
-	load_TLS_desc(t, cpu);
 	put_cpu();
 
-	return TLS_ENTRY*8 + 3;
+	return 0;
+}
+
+/*
+ * Get the current Thread-Local Storage area:
+ */
+
+#define GET_BASE(desc) ( \
+	(((desc)->a >> 16) & 0x0000ffff) | \
+	(((desc)->b << 16) & 0x00ff0000) | \
+	( (desc)->b        & 0xff000000)   )
+
+#define GET_LIMIT(desc) ( \
+	((desc)->a & 0x0ffff) | \
+	 ((desc)->b & 0xf0000) )
+	
+#define GET_32BIT(desc)		(((desc)->b >> 23) & 1)
+#define GET_CONTENTS(desc)	(((desc)->b >> 10) & 3)
+#define GET_WRITABLE(desc)	(((desc)->b >>  9) & 1)
+#define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)
+#define GET_PRESENT(desc)	(((desc)->b >> 15) & 1)
+#define GET_USEABLE(desc)	(((desc)->b >> 20) & 1)
+
+asmlinkage int sys_get_thread_area(struct user_desc *u_info)
+{
+	struct user_desc info;
+	struct desc_struct *desc;
+	int idx;
+
+	if (get_user(idx, &u_info->entry_number))
+		return -EFAULT;
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+		return -EINVAL;
+
+	desc = current->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
+
+	info.entry_number = idx;
+	info.base_addr = GET_BASE(desc);
+	info.limit = GET_LIMIT(desc);
+	info.seg_32bit = GET_32BIT(desc);
+	info.contents = GET_CONTENTS(desc);
+	info.read_exec_only = !GET_WRITABLE(desc);
+	info.limit_in_pages = GET_LIMIT_PAGES(desc);
+	info.seg_not_present = !GET_PRESENT(desc);
+	info.useable = GET_USEABLE(desc);
+
+	if (copy_to_user(u_info, &info, sizeof(info)))
+		return -EFAULT;
+	return 0;
 }
 
--- linux/arch/i386/kernel/suspend.c.orig	Mon Aug 12 17:56:02 2002
+++ linux/arch/i386/kernel/suspend.c	Mon Aug 12 17:56:27 2002
@@ -207,7 +207,7 @@
 	struct tss_struct * t = init_tss + cpu;
 
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
-        cpu_gdt_table[cpu][TSS_ENTRY].b &= 0xfffffdff;
+        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
 	load_LDT(&current->mm->context);	/* This does lldt */
--- linux/arch/i386/kernel/ldt.c.orig	Mon Aug 12 17:56:02 2002
+++ linux/arch/i386/kernel/ldt.c	Mon Aug 12 17:56:27 2002
@@ -170,7 +170,7 @@
 	struct mm_struct * mm = current->mm;
 	__u32 entry_1, entry_2, *lp;
 	int error;
-	struct modify_ldt_ldt_s ldt_info;
+	struct user_desc ldt_info;
 
 	error = -EINVAL;
 	if (bytecount != sizeof(ldt_info))
@@ -200,32 +200,17 @@
 
    	/* Allow LDTs to be cleared by the user. */
    	if (ldt_info.base_addr == 0 && ldt_info.limit == 0) {
-		if (oldmode ||
-		    (ldt_info.contents == 0		&&
-		     ldt_info.read_exec_only == 1	&&
-		     ldt_info.seg_32bit == 0		&&
-		     ldt_info.limit_in_pages == 0	&&
-		     ldt_info.seg_not_present == 1	&&
-		     ldt_info.useable == 0 )) {
+		if (oldmode || LDT_empty(&ldt_info)) {
 			entry_1 = 0;
 			entry_2 = 0;
 			goto install;
 		}
 	}
 
-	entry_1 = ((ldt_info.base_addr & 0x0000ffff) << 16) |
-		  (ldt_info.limit & 0x0ffff);
-	entry_2 = (ldt_info.base_addr & 0xff000000) |
-		  ((ldt_info.base_addr & 0x00ff0000) >> 16) |
-		  (ldt_info.limit & 0xf0000) |
-		  ((ldt_info.read_exec_only ^ 1) << 9) |
-		  (ldt_info.contents << 10) |
-		  ((ldt_info.seg_not_present ^ 1) << 15) |
-		  (ldt_info.seg_32bit << 22) |
-		  (ldt_info.limit_in_pages << 23) |
-		  0x7000;
-	if (!oldmode)
-		entry_2 |= (ldt_info.useable << 20);
+	entry_1 = LDT_entry_a(&ldt_info);
+	entry_2 = LDT_entry_b(&ldt_info);
+	if (oldmode)
+		entry_2 &= ~(1 << 20);
 
 	/* Install the new entry ...  */
 install:
--- linux/arch/i386/boot/setup.S.orig	Mon Aug 12 17:51:32 2002
+++ linux/arch/i386/boot/setup.S	Mon Aug 12 17:56:27 2002
@@ -1005,9 +1005,14 @@
 	ret
 
 # Descriptor tables
+#
+# NOTE: if you think the GDT is large, you can make it smaller by just
+# defining the KERNEL_CS and KERNEL_DS entries and shifting the gdt
+# address down by GDT_ENTRY_KERNEL_CS*8. This puts bogus entries into
+# the GDT, but those wont be used so it's not a problem.
+#
 gdt:
-	.word	0, 0, 0, 0			# dummy
-	.word	0, 0, 0, 0			# unused
+	.fill GDT_ENTRY_KERNEL_CS,8,0
 
 	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
 	.word	0				# base address = 0
--- linux/include/linux/apm_bios.h.orig	Mon Aug 12 17:51:39 2002
+++ linux/include/linux/apm_bios.h	Mon Aug 12 17:56:27 2002
@@ -21,8 +21,8 @@
 
 #ifdef __KERNEL__
 
-#define APM_40		0x40
-#define APM_CS		(APM_40 + 8)
+#define APM_40		(GDT_ENTRY_APMBIOS_BASE * 8)
+#define APM_CS		(APM_BASE + 8)
 #define APM_CS_16	(APM_CS + 8)
 #define APM_DS		(APM_CS_16 + 8)
 
--- linux/include/asm-i386/desc.h.orig	Mon Aug 12 17:56:15 2002
+++ linux/include/asm-i386/desc.h	Mon Aug 12 17:56:27 2002
@@ -2,50 +2,12 @@
 #define __ARCH_DESC_H
 
 #include <asm/ldt.h>
-
-/*
- * The layout of the per-CPU GDT under Linux:
- *
- *   0 - null
- *   1 - Thread-Local Storage (TLS) segment
- *   2 - kernel code segment
- *   3 - kernel data segment
- *   4 - user code segment		<==== new cacheline
- *   5 - user data segment
- *   6 - TSS
- *   7 - LDT
- *   8 - APM BIOS support		<==== new cacheline
- *   9 - APM BIOS support
- *  10 - APM BIOS support
- *  11 - APM BIOS support
- *  12 - PNPBIOS support		<==== new cacheline
- *  13 - PNPBIOS support
- *  14 - PNPBIOS support
- *  15 - PNPBIOS support
- *  16 - PNPBIOS support		<==== new cacheline
- *  17 - not used
- *  18 - not used
- *  19 - not used
- */
-#define TLS_ENTRY 1
-#define TSS_ENTRY 6
-#define LDT_ENTRY 7
-/*
- * The interrupt descriptor table has room for 256 idt's,
- * the global descriptor table is dependent on the number
- * of tasks we can have..
- *
- * We pad the GDT to cacheline boundary.
- */
-#define IDT_ENTRIES 256
-#define GDT_ENTRIES 20
+#include <asm/segment.h>
 
 #ifndef __ASSEMBLY__
 
 #include <asm/mmu.h>
 
-#define GDT_SIZE (GDT_ENTRIES*sizeof(struct desc_struct))
-
 extern struct desc_struct cpu_gdt_table[NR_CPUS][GDT_ENTRIES];
 
 struct Xgt_desc_struct {
@@ -55,8 +17,8 @@
 
 extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
 
-#define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (TSS_ENTRY<<3))
-#define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (LDT_ENTRY<<3))
+#define load_TR_desc() __asm__ __volatile__("ltr %%ax"::"a" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() __asm__ __volatile__("lldt %%ax"::"a" (GDT_ENTRY_LDT*8))
 
 /*
  * This is the ldt that every process will get unless we need
@@ -78,21 +40,48 @@
 
 static inline void set_tss_desc(unsigned int cpu, void *addr)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][TSS_ENTRY], (int)addr, 235, 0x89);
+	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (int)addr, 235, 0x89);
 }
 
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
 {
-	_set_tssldt_desc(&cpu_gdt_table[cpu][LDT_ENTRY], (int)addr, ((size << 3)-1), 0x82);
+	_set_tssldt_desc(&cpu_gdt_table[cpu][GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
-#define TLS_FLAGS_MASK			0x00000001
+#define LDT_entry_a(info) \
+	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
-#define TLS_FLAG_WRITABLE		0x00000001
+#define LDT_entry_b(info) \
+	(((info)->base_addr & 0xff000000) | \
+	(((info)->base_addr & 0x00ff0000) >> 16) | \
+	((info)->limit & 0xf0000) | \
+	(((info)->read_exec_only ^ 1) << 9) | \
+	((info)->contents << 10) | \
+	(((info)->seg_not_present ^ 1) << 15) | \
+	((info)->seg_32bit << 22) | \
+	((info)->limit_in_pages << 23) | \
+	((info)->useable << 20) | \
+	0x7000)
+
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
+
+#if TLS_SIZE != 24
+# error update this code.
+#endif
 
-static inline void load_TLS_desc(struct thread_struct *t, unsigned int cpu)
+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
-	cpu_gdt_table[cpu][TLS_ENTRY] = t->tls_desc;
+#define C(i) cpu_gdt_table[cpu][GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+	C(0); C(1); C(2);
+#undef C
 }
 
 static inline void clear_LDT(void)
--- linux/include/asm-i386/processor.h.orig	Mon Aug 12 17:56:16 2002
+++ linux/include/asm-i386/processor.h	Mon Aug 12 17:56:27 2002
@@ -22,6 +22,11 @@
 	unsigned long a,b;
 };
 
+#define desc_empty(desc) \
+		(!((desc)->a + (desc)->b))
+
+#define desc_equal(desc1, desc2) \
+		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
@@ -359,6 +364,8 @@
 };
 
 struct thread_struct {
+/* cached TLS descriptors. */
+	struct desc_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
 	unsigned long	esp0;
 	unsigned long	eip;
 	unsigned long	esp;
@@ -376,11 +383,10 @@
 	unsigned long		v86flags, v86mask, v86mode, saved_esp0;
 /* IO permissions */
 	unsigned long	*ts_io_bitmap;
-/* TLS cached descriptor */
-	struct desc_struct tls_desc;
 };
 
 #define INIT_THREAD  {						\
+	{ { 0, 0 } , },						\
 	0,							\
 	0, 0, 0, 0, 						\
 	{ [0 ... 7] = 0 },	/* debugging registers */	\
@@ -401,7 +407,7 @@
 	0,0,0,0, /* esp,ebp,esi,edi */				\
 	0,0,0,0,0,0, /* es,cs,ss */				\
 	0,0,0,0,0,0, /* ds,fs,gs */				\
-	LDT_ENTRY,0, /* ldt */					\
+	GDT_ENTRY_LDT,0, /* ldt */					\
 	0, INVALID_IO_BITMAP_OFFSET, /* tace, bitmap */		\
 	{~0, } /* ioperm */					\
 }
--- linux/include/asm-i386/segment.h.orig	Mon Aug 12 17:56:16 2002
+++ linux/include/asm-i386/segment.h	Mon Aug 12 17:56:27 2002
@@ -1,10 +1,79 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
-#define __KERNEL_CS	0x10
-#define __KERNEL_DS	0x18
+/*
+ * The layout of the per-CPU GDT under Linux:
+ *
+ *   0 - null
+ *   1 - reserved
+ *   2 - reserved
+ *   3 - reserved
+ *
+ *   4 - default user CS		<==== new cacheline
+ *   5 - default user DS
+ *
+ *  ------- start of TLS (Thread-Local Storage) segments:
+ *
+ *   6 - TLS segment #1			[ glibc's TLS segment ]
+ *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
+ *   8 - TLS segment #3
+ *   9 - reserved
+ *  10 - reserved
+ *  11 - reserved
+ *
+ *  ------- start of kernel segments:
+ *
+ *  12 - kernel code segment		<==== new cacheline
+ *  13 - kernel data segment
+ *  14 - TSS
+ *  15 - LDT
+ *  16 - PNPBIOS support (16->32 gate)
+ *  17 - PNPBIOS support
+ *  18 - PNPBIOS support
+ *  19 - PNPBIOS support
+ *  20 - PNPBIOS support
+ *  21 - APM BIOS support
+ *  22 - APM BIOS support
+ *  23 - APM BIOS support 
+ */
+#define GDT_ENTRY_TLS_ENTRIES	3
+#define GDT_ENTRY_TLS_MIN	6
+#define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
-#define __USER_CS	0x23
-#define __USER_DS	0x2B
+#define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
+
+#define GDT_ENTRY_DEFAULT_USER_CS	4
+#define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
+
+#define GDT_ENTRY_DEFAULT_USER_DS	5
+#define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
+
+#define GDT_ENTRY_KERNEL_BASE	12
+
+#define GDT_ENTRY_KERNEL_CS		(GDT_ENTRY_KERNEL_BASE + 0)
+#define __KERNEL_CS (GDT_ENTRY_KERNEL_CS * 8)
+
+#define GDT_ENTRY_KERNEL_DS		(GDT_ENTRY_KERNEL_BASE + 1)
+#define __KERNEL_DS (GDT_ENTRY_KERNEL_DS * 8)
+
+#define GDT_ENTRY_TSS			(GDT_ENTRY_KERNEL_BASE + 2)
+#define GDT_ENTRY_LDT			(GDT_ENTRY_KERNEL_BASE + 3)
+
+#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 4)
+#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 9)
+
+/*
+ * The GDT has 21 entries but we pad it to cacheline boundary:
+ */
+#define GDT_ENTRIES 24
+
+#define GDT_SIZE (GDT_ENTRIES * 8)
+
+/*
+ * The interrupt descriptor table has room for 256 idt's,
+ * the global descriptor table is dependent on the number
+ * of tasks we can have..
+ */
+#define IDT_ENTRIES 256
 
 #endif
--- linux/include/asm-i386/unistd.h.orig	Mon Aug 12 17:56:16 2002
+++ linux/include/asm-i386/unistd.h	Mon Aug 12 17:56:27 2002
@@ -248,6 +248,7 @@
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
 #define __NR_set_thread_area	243
+#define __NR_get_thread_area	244
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- linux/include/asm-i386/ldt.h.orig	Mon Aug 12 17:56:16 2002
+++ linux/include/asm-i386/ldt.h	Mon Aug 12 17:56:27 2002
@@ -12,7 +12,7 @@
 #define LDT_ENTRY_SIZE	8
 
 #ifndef __ASSEMBLY__
-struct modify_ldt_ldt_s {
+struct user_desc {
 	unsigned int  entry_number;
 	unsigned long base_addr;
 	unsigned int  limit;

