Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSHKVpP>; Sun, 11 Aug 2002 17:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSHKVpP>; Sun, 11 Aug 2002 17:45:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20919 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318383AbSHKVpH>;
	Sun, 11 Aug 2002 17:45:07 -0400
Date: Sun, 11 Aug 2002 23:46:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: [patch] tls-2.5.31-C3
In-Reply-To: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208112326580.29560-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1987160651-1029102361=:29560"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1987160651-1029102361=:29560
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch cleans up the TLS code and it introduces a number of
new capabilities as well:

- move the TLS space to the first 12 GDT descriptors - kernel descriptors
  come afterwards.

- make USER CS and DS just another TLS entry, which happen to have a
  default value that matches the current segments. It's done in a way
  that does not result in extra context-switch overhead.

- make segment 0040 available to Wine, allow the setting of 16-bit
  segments. Allow full flexibility of all the safe segment variants.

- sys_set_thread_area(&info) can be both for a specific GDT entry, but it
  can also trigger an 'allocation' of a yet unused TLS entry, by using
  an ->entry_number of -1. It's recommended for userspace code to use the
  -1 value, to make sure different libraries can nest properly.

- sys_get_thread_area(&info) can be used to read TLS entries into the same
  userspace descriptor format as sys_set_thread_area() does. The new
  syscalls are now actually relatively clean, and the TLS area can be
  extended seemlessly.

- move KERNEL CS, DS, TSS and LDT to the same cacheline.

- clean up all the kernel descriptors to be more or less easily
  modified/reordered from segment.h only, with minimal dependencies.

- move the GDT/TLS definitions to asm-i386/segment.h, to make it easier to
  include the constants into assembly code and lowlevel include files.

an open issue: the context-switch code uses an optimized variant of TLS
loading - only the truly affected portions of the GDT get rewritten. But
i'm not 100% convinced this is the right way - i kept the TLS in the same
format as the GDT, so we could as well just write 96 bytes
unconditionally. That's smaller a single cacheline on modern CPUs. Doing
this would greatly simplify the code. I've mainly done this current
optimization to show that it can be done in a relatively straightforward
way, but that i dont think it's worth it. Especially since the TLS area is
3 32-byte cachelines, it should easily trigger all the memcpy fastpaths in
various CPUs. So i'd suggest to keep the tls_bytes variables only, and
thus non-TLS code would see only a single branch in the context-switch
path.

another issue: i've not gone the whole way of unifying LDT and TLS support
- we've already got compatibility code in the LDT interfaces and changing
LDTs via the TLS syscalls would only make the situation even more messy.  
Nevertheless there are some new synergies between the LDT and TSS code,
which resulted in some ldt.c code reduction.

i've attached a new version of tls.c that tests the new TLS syscall
variants and shows off some of the new capabilities. TLS support works
just fine on 2.5.31 + this patch, on SMP and UP as well.

Comments?

	Ingo

--- linux/drivers/pnp/pnpbios_core.c.orig	Sun Aug 11 17:01:17 2002
+++ linux/drivers/pnp/pnpbios_core.c	Sun Aug 11 23:28:44 2002
@@ -90,7 +90,8 @@
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
 /* The PnP BIOS entries in the GDT */
-#define PNP_GDT    (0x0060)
+#define PNP_GDT    (GDT_ENTRY_PNPBIOS_BASE * 8)
+
 #define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
 #define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
 #define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
--- linux/arch/i386/kernel/cpu/common.c.orig	Sun Aug 11 17:01:06 2002
+++ linux/arch/i386/kernel/cpu/common.c	Sun Aug 11 23:28:44 2002
@@ -423,6 +423,7 @@
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = init_tss + cpu;
+	struct thread_struct *thread = &current->thread;
 
 	if (test_and_set_bit(cpu, &cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -447,9 +448,14 @@
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
+	clear_TLS(thread);
 
 	__asm__ __volatile__("lgdt %0": "=m" (cpu_gdt_descr[cpu]));
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
@@ -468,9 +474,9 @@
 		BUG();
 	enter_lazy_tlb(&init_mm, current, cpu);
 
-	t->esp0 = current->thread.esp0;
+	t->esp0 = thread->esp0;
 	set_tss_desc(cpu,t);
-	cpu_gdt_table[cpu][TSS_ENTRY].b &= 0xfffffdff;
+	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
--- linux/arch/i386/kernel/entry.S.orig	Sun Aug 11 17:01:07 2002
+++ linux/arch/i386/kernel/entry.S	Sun Aug 11 23:28:44 2002
@@ -753,6 +753,7 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_get_thread_area
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/arch/i386/kernel/head.S.orig	Sun Aug 11 17:01:06 2002
+++ linux/arch/i386/kernel/head.S	Sun Aug 11 23:28:44 2002
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
@@ -412,34 +407,44 @@
 
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
+	.quad 0x00cffa000000ffff	/* 0x0b user 4GB code at 0x00000000 */
+	.quad 0x00cff2000000ffff	/* 0x13 user 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x1b TLS entry 3 */
+	.quad 0x0000000000000000	/* ... */
+	.quad 0x0000000000000000
+	.quad 0x0000000000000000
+	.quad 0x0000000000000000
+	.quad 0x0000000000000000
+	.quad 0x0000000000000000
+	.quad 0x0000000000000000	/* ... */
+	.quad 0x0000000000000000	/* 0x5b TLS entry 11 */
+
+	.quad 0x00cf9a000000ffff	/* 0x60 kernel 4GB code at 0x00000000 */
+	.quad 0x00cf92000000ffff	/* 0x68 kernel 4GB data at 0x00000000 */
+	.quad 0x0000000000000000	/* 0x70 TSS descriptor */
+	.quad 0x0000000000000000	/* 0x78 LDT descriptor */
+
 	/*
 	 * The APM segments have byte granularity and their bases
 	 * and limits are set at run time.
 	 */
-	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
-	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
-	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
-	.quad 0x0040920000000000	/* 0x58 APM DS    data */
+	.quad 0x0040920000000000	/* 0x80 APM set up for bad BIOS's */
+	.quad 0x00409a0000000000	/* 0x88 APM CS    code */
+	.quad 0x00009a0000000000	/* 0x90 APM CS 16 code (16 bit) */
+	.quad 0x0040920000000000	/* 0x98 APM DS    data */
 	/* Segments used for calling PnP BIOS */
-	.quad 0x00c09a0000000000	/* 0x60 32-bit code */
-	.quad 0x00809a0000000000	/* 0x68 16-bit code */
-	.quad 0x0080920000000000	/* 0x70 16-bit data */
-	.quad 0x0080920000000000	/* 0x78 16-bit data */
-	.quad 0x0080920000000000	/* 0x80 16-bit data */
-	.quad 0x0000000000000000	/* 0x88 not used */
-	.quad 0x0000000000000000	/* 0x90 not used */
-	.quad 0x0000000000000000	/* 0x98 not used */
+	.quad 0x00c09a0000000000	/* 0xa0 32-bit code */
+	.quad 0x00809a0000000000	/* 0xa8 16-bit code */
+	.quad 0x0080920000000000	/* 0xb0 16-bit data */
+	.quad 0x0080920000000000	/* 0xb8 16-bit data */
+	.quad 0x0080920000000000	/* 0xc0 16-bit data */
+	.quad 0x0000000000000000	/* 0xc8 not used */
+	.quad 0x0000000000000000	/* 0xd0 not used */
+	.quad 0x0000000000000000	/* 0xd8 not used */
 
 #if CONFIG_SMP
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
--- linux/arch/i386/kernel/process.c.orig	Sun Aug 11 17:01:08 2002
+++ linux/arch/i386/kernel/process.c	Sun Aug 11 23:28:44 2002
@@ -681,11 +681,9 @@
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
-	 *
-	 * NOTE: it's faster to do the two stores unconditionally
-	 * than to branch away.
 	 */
-	load_TLS_desc(next, cpu);
+	if (prev->nr_tls_bytes || next->nr_tls_bytes)
+		load_TLS(prev, next, cpu);
 
 	/*
 	 * Save away %fs and %gs. No need to save %es and %ds, as
@@ -834,35 +832,168 @@
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
+	for (idx = GDT_ENTRY_TLS_MIN; idx <= GDT_ENTRY_TLS_MAX; idx++)
+		if (desc_empty(t->tls_array + idx))
+			return idx;
+	return -ESRCH;
+}
+
+static inline int first_tls(struct desc_struct *array)
+{
+	struct desc_struct *default_array = init_task.thread.tls_array;
+	int idx;
+
+	for (idx = GDT_ENTRY_TLS_MIN; idx <= GDT_ENTRY_TLS_MAX; idx++)
+		if (!desc_equal(array + idx, default_array + idx))
+			return idx;
+
+	return 0;
+}
+
+static inline int last_tls(struct desc_struct *array)
+{
+	struct desc_struct *default_array = init_task.thread.tls_array;
+	int idx;
+
+	for (idx = GDT_ENTRY_TLS_MAX; idx >= GDT_ENTRY_TLS_MIN; idx--)
+		if (!desc_equal(array + idx, default_array + idx))
+			return idx;
+
+	return 0;
+}
+
+#define CHECK_TLS_IDX(idx)						\
+do {									\
+	if ((idx) < GDT_ENTRY_TLS_MIN || (idx) > GDT_ENTRY_TLS_MAX)	\
+		BUG();							\
+} while (0)
+
+/*
+ * Set a given TLS descriptor:
+ */
+asmlinkage int sys_set_thread_area(struct modify_ldt_ldt_s *u_info)
+{
+	struct thread_struct *t = &current->thread;
+	struct modify_ldt_ldt_s info;
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
+	desc = t->tls_array + idx;
 
 	/*
 	 * We must not get preempted while modifying the TLS.
 	 */
 	cpu = get_cpu();
 
-        t->tls_desc.a = ((base & 0x0000ffff) << 16) | 0xffff;
+	if (LDT_empty(&info)) {
+		desc->a = 0;
+		desc->b = 0;
+	} else {
+		desc->a = LDT_entry_a(&info);
+		desc->b = LDT_entry_b(&info);
+	}
+
+	t->first_tls_byte = first_tls(t->tls_array) * 8;
+	t->last_tls_byte = (last_tls(t->tls_array) + 1) * 8;
 
-        t->tls_desc.b = (base & 0xff000000) | ((base & 0x00ff0000) >> 16) |
-				0xf0000 | (writable << 9) | (1 << 15) |
-					(1 << 22) | (1 << 23) | 0x7000;
+	if (t->first_tls_byte || t->last_tls_byte) {
+		CHECK_TLS_IDX(t->first_tls_byte/8);
+		CHECK_TLS_IDX(t->last_tls_byte/8-1);
+		t->nr_tls_bytes = t->last_tls_byte - t->first_tls_byte;
+		if (t->nr_tls_bytes < 0)
+			BUG();
+		if (t->nr_tls_bytes > GDT_ENTRY_TLS_ENTRIES * 8)
+			BUG();
+	} else {
+		/*
+		 * If a thread has no TLS then invert the first/last
+		 * range so that if we switch from (or to) a TLS-using
+		 * thread then it will be the thread's TLS area that
+		 * will be copied into the GDT.
+		 */
+		t->nr_tls_bytes = 0;
+		t->first_tls_byte = 0;
+		t->last_tls_byte = (GDT_ENTRY_TLS_MAX + 1) * 8;
+	}
+
+	load_TLS(t, t, cpu);
 
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
+asmlinkage int sys_get_thread_area(struct modify_ldt_ldt_s *u_info)
+{
+	struct modify_ldt_ldt_s info;
+	struct desc_struct *desc;
+	int idx;
+
+	if (get_user(idx, &u_info->entry_number))
+		return -EFAULT;
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+		return -EINVAL;
+
+	desc = current->thread.tls_array + idx;
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
 
--- linux/arch/i386/kernel/suspend.c.orig	Sun Aug 11 17:01:06 2002
+++ linux/arch/i386/kernel/suspend.c	Sun Aug 11 23:28:44 2002
@@ -207,7 +207,7 @@
 	struct tss_struct * t = init_tss + cpu;
 
 	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
-        cpu_gdt_table[cpu][TSS_ENTRY].b &= 0xfffffdff;
+        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
 	load_LDT(&current->mm->context);	/* This does lldt */
--- linux/arch/i386/kernel/ldt.c.orig	Sun Aug 11 17:01:04 2002
+++ linux/arch/i386/kernel/ldt.c	Sun Aug 11 23:28:44 2002
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
--- linux/arch/i386/boot/setup.S.orig	Sun Jun  9 07:26:32 2002
+++ linux/arch/i386/boot/setup.S	Sun Aug 11 23:28:44 2002
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
--- linux/include/linux/apm_bios.h.orig	Sun Jun  9 07:30:24 2002
+++ linux/include/linux/apm_bios.h	Sun Aug 11 23:28:44 2002
@@ -21,8 +21,8 @@
 
 #ifdef __KERNEL__
 
-#define APM_40		0x40
-#define APM_CS		(APM_40 + 8)
+#define APM_40		(GDT_ENTRY_APMBIOS_BASE * 8)
+#define APM_CS		(APM_BASE + 8)
 #define APM_CS_16	(APM_CS + 8)
 #define APM_DS		(APM_CS_16 + 8)
 
--- linux/include/asm-i386/desc.h.orig	Sun Aug 11 17:01:07 2002
+++ linux/include/asm-i386/desc.h	Sun Aug 11 23:28:44 2002
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
@@ -78,21 +40,52 @@
 
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
 
-static inline void load_TLS_desc(struct thread_struct *t, unsigned int cpu)
+static inline void clear_TLS(struct thread_struct *t)
 {
-	cpu_gdt_table[cpu][TLS_ENTRY] = t->tls_desc;
+	t->nr_tls_bytes = 0;
+	t->first_tls_byte = 0;
+	t->last_tls_byte = (GDT_ENTRY_TLS_MAX + 1) * 8;
+}
+
+static inline void load_TLS(struct thread_struct *prev, struct thread_struct *next, unsigned int cpu)
+{
+	int first_byte = min(prev->first_tls_byte, next->first_tls_byte);
+	int last_byte = max(prev->last_tls_byte, next->last_tls_byte);
+
+	memcpy((char *)(cpu_gdt_table[cpu]) + first_byte, (char *)next->tls_array + first_byte, last_byte - first_byte);
 }
 
 static inline void clear_LDT(void)
--- linux/include/asm-i386/processor.h.orig	Sun Aug 11 17:01:07 2002
+++ linux/include/asm-i386/processor.h	Sun Aug 11 23:28:44 2002
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
@@ -376,8 +381,16 @@
 	unsigned long		v86flags, v86mask, v86mode, saved_esp0;
 /* IO permissions */
 	unsigned long	*ts_io_bitmap;
-/* TLS cached descriptor */
-	struct desc_struct tls_desc;
+
+	/*
+	 * cached TLS descriptors.
+	 *
+	 * The offset calculation is needed to not copy the whole TLS
+	 * into the local GDT all the time.
+	 * We count offsets in bytes to reduce context-switch overhead.
+	 */
+	int nr_tls_bytes, first_tls_byte, last_tls_byte;
+	struct desc_struct tls_array[GDT_ENTRY_TLS_MAX + 1];
 };
 
 #define INIT_THREAD  {						\
@@ -401,7 +414,7 @@
 	0,0,0,0, /* esp,ebp,esi,edi */				\
 	0,0,0,0,0,0, /* es,cs,ss */				\
 	0,0,0,0,0,0, /* ds,fs,gs */				\
-	LDT_ENTRY,0, /* ldt */					\
+	GDT_ENTRY_LDT,0, /* ldt */					\
 	0, INVALID_IO_BITMAP_OFFSET, /* tace, bitmap */		\
 	{~0, } /* ioperm */					\
 }
--- linux/include/asm-i386/segment.h.orig	Sun Jun  9 07:28:19 2002
+++ linux/include/asm-i386/segment.h	Sun Aug 11 23:28:44 2002
@@ -1,10 +1,84 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
-#define __KERNEL_CS	0x10
-#define __KERNEL_DS	0x18
+/*
+ * The layout of the per-CPU GDT under Linux:
+ *
+ *   0 - null
+ *
+ *  ------- start of TLS (Thread-Local Storage) segments:
+ *
+ *   1 - TLS segment #1			[ default user CS ]
+ *   2 - TLS segment #2			[ default user DS ]
+ *   3 - TLS segment #3			[ glibc's TLS segment ]
+ *   4 - TLS segment #4			[ Wine's %fs Win32 segment ]
+ *   5 - TLS segment #5
+ *   6 - TLS segment #6
+ *   7 - TLS segment #7
+ *   8 - TLS segment #8			[ segment 0040 used by Wine ]
+ *   9 - TLS segment #9
+ *  10 - TLS segment #9
+ *  11 - TLS segment #9
+ *
+ *  ------- start of kernel segments, on a full cacheline:
+ *
+ *  12 - kernel code segment		<==== new cacheline
+ *  13 - kernel data segment
+ *  14 - TSS
+ *  15 - LDT
+ *
+ *  ------- these are the less performance-sensitive segments:
+ *
+ *  16 - APM BIOS support
+ *  17 - APM BIOS support
+ *  18 - APM BIOS support
+ *  19 - APM BIOS support 
+ *  20 - PNPBIOS support (16->32 gate)
+ *  21 - PNPBIOS support
+ *  22 - PNPBIOS support
+ *  23 - PNPBIOS support
+ *  24 - PNPBIOS support
+ *  25 - reserved
+ *  26 - reserved
+ *  27 - reserved
+ */
+#define GDT_ENTRY_TLS_ENTRIES	11
+#define GDT_ENTRY_TLS_MIN	1
+#define GDT_ENTRY_TLS_MAX 	(GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
-#define __USER_CS	0x23
-#define __USER_DS	0x2B
+#define GDT_ENTRY_DEFAULT_USER_CS	(GDT_ENTRY_TLS_MIN + 0)
+#define __USER_CS (GDT_ENTRY_DEFAULT_USER_CS * 8 + 3)
+
+#define GDT_ENTRY_DEFAULT_USER_DS	(GDT_ENTRY_TLS_MIN + 1)
+#define __USER_DS (GDT_ENTRY_DEFAULT_USER_DS * 8 + 3)
+
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
+#define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 4)
+#define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 8)
+
+/*
+ * The GDT has 25 entries but we pad it to cacheline boundary:
+ */
+#define GDT_ENTRIES 28
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
--- linux/include/asm-i386/unistd.h.orig	Sun Aug 11 17:01:07 2002
+++ linux/include/asm-i386/unistd.h	Sun Aug 11 23:28:44 2002
@@ -248,6 +248,7 @@
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
 #define __NR_set_thread_area	243
+#define __NR_get_thread_area	244
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 

--8323328-1987160651-1029102361=:29560
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tls.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208112346010.29560@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="tls.c"

I2luY2x1ZGUgPGFzbS9sZHQuaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2lu
Y2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPg0KI2luY2x1ZGUgPHNpZ25hbC5oPg0K
I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2lu
Y2x1ZGUgPHB0aHJlYWQuaD4NCiNpbmNsdWRlIDxhc20vc2lnY29udGV4dC5o
Pg0KI2luY2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPg0KDQovKg0KICogVExTIGZ1
bmN0aW9uYWxpdHkgdGVzdGluZyB1dGlsaXR5Lg0KICovDQoNCiNkZWZpbmUg
X19OUl9zZXRfdGhyZWFkX2FyZWEgMjQzDQpfc3lzY2FsbDEoaW50LCBzZXRf
dGhyZWFkX2FyZWEsIHN0cnVjdCBtb2RpZnlfbGR0X2xkdF9zICosIGluZm8p
DQoNCiNkZWZpbmUgX19OUl9nZXRfdGhyZWFkX2FyZWEgMjQ0DQpfc3lzY2Fs
bDEoaW50LCBnZXRfdGhyZWFkX2FyZWEsIHN0cnVjdCBtb2RpZnlfbGR0X2xk
dF9zICosIGluZm8pDQoNCnN0YXRpYyBpbmxpbmUgdm9pZCBpbml0c2VnIChp
bnQgc2VnKQ0Kew0KCWFzbSAoIm1vdiAldzAsJSVmcyIgOiA6ICJyIiAoc2Vn
KSk7DQp9DQoNCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgY2hhciBfX3JlYWRz
ZWcgKHVuc2lnbmVkIG9mZnNldCkNCnsNCgl1bnNpZ25lZCBjaGFyIHJlczsN
Cg0KCWFzbSAoImZzOyBtb3ZiICglMSksJSVhbCIgOiAiPWEiIChyZXMpIDog
InIiIChvZmZzZXQpKTsNCg0KCXJldHVybiByZXM7DQp9DQoNCnN0YXRpYyBp
bmxpbmUgdm9pZCBfX3dyaXRlc2VnICh1bnNpZ25lZCBvZmZzZXQsIHVuc2ln
bmVkIGNoYXIgYikNCnsNCglhc20gKCJmczsgbW92YiAlYjEsKCUwKSIgOiA6
ICJyIiAob2Zmc2V0KSwgInIiIChiKSk7DQp9DQoNCnN0YXRpYyB2b2lkIHJl
YWRzZWcgKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjKQ0Kew0KCSooY2hh
ciAqKWRzdCA9IF9fcmVhZHNlZygodW5zaWduZWQgaW50KXNyYyk7DQp9DQoN
CnN0YXRpYyB2b2lkIHdyaXRlc2VnICh2b2lkICpkc3QsIHVuc2lnbmVkIGNo
YXIgdmFsdWUpDQp7DQoJX193cml0ZXNlZygodW5zaWduZWQgaW50KWRzdCwg
dmFsdWUpOw0KfQ0KDQp1bnNpZ25lZCBjaGFyIHByZV9kYXRhCQlbNDA5Nl0g
PSB7IFsgMCAuLi4gNDA5NSBdID0gMzMgfTsNCnVuc2lnbmVkIGNoYXIgZGF0
YQkJWzQwOTZdID0geyBbIDAgLi4uIDQwOTUgXSA9IDQ0IH07DQp1bnNpZ25l
ZCBjaGFyIHBvc3RfZGF0YQkJWzQwOTZdID0geyBbIDAgLi4uIDQwOTUgXSA9
IDU1IH07DQoNCnN0YXRpYyB2b2lkIHByaW50X2luZm8gKHN0cnVjdCBtb2Rp
ZnlfbGR0X2xkdF9zICppbmZvKQ0Kew0KCXByaW50ZigiaW5mbyAlcDpcbiIs
IGluZm8pOw0KDQojZGVmaW5lIFAoZikgcHJpbnRmKCIuLi4iI2YiOiAlZC5c
biIsIGluZm8tPiMjZikNCg0KCVAoZW50cnlfbnVtYmVyKTsNCglQKGJhc2Vf
YWRkcik7DQoJUChsaW1pdCk7DQoJUChzZWdfMzJiaXQpOw0KCVAoY29udGVu
dHMpOw0KCVAocmVhZF9leGVjX29ubHkpOw0KCVAobGltaXRfaW5fcGFnZXMp
Ow0KCVAoc2VnX25vdF9wcmVzZW50KTsNCglQKHVzZWFibGUpOw0KDQp9DQoN
CmludCBtYWluICh2b2lkKQ0Kew0KCWludCBpLCBpZHgsIHNlZywgcmV0Ow0K
CXVuc2lnbmVkIGludCBiYXNlOw0KCXVuc2lnbmVkIGNoYXIgcmVzdWx0Ow0K
CXN0cnVjdCBtb2RpZnlfbGR0X2xkdF9zIGluZm8sIGluZm8yOw0KDQoJbWVt
c2V0KCZpbmZvLCAwLCBzaXplb2YoaW5mbykpOw0KCW1lbXNldCgmaW5mbzIs
IDAsIHNpemVvZihpbmZvMikpOw0KDQoJaW5mby5lbnRyeV9udW1iZXIgPSAt
MTsNCglpbmZvLmJhc2VfYWRkciA9IDA7DQoJaW5mby5saW1pdCA9IDB4ZmZm
ZmY7DQoJaW5mby5zZWdfMzJiaXQgPSAxOw0KCWluZm8uY29udGVudHMgPSBN
T0RJRllfTERUX0NPTlRFTlRTX0RBVEE7DQoJaW5mby5yZWFkX2V4ZWNfb25s
eSA9IDA7DQoJaW5mby5saW1pdF9pbl9wYWdlcyA9IDE7DQoJaW5mby5zZWdf
bm90X3ByZXNlbnQgPSAwOw0KDQoJZGF0YVswXSA9IDEyMzsNCglkYXRhWzQw
OTZdID0gMjEwOw0KDQoJYmFzZSA9IDA7IGluZm8uYmFzZV9hZGRyID0gYmFz
ZTsNCglwcmludGYoIlxuZG9pbmcgc2V0X3RocmVhZF9hcmVhKCUwOHgpOlxu
IiwgYmFzZSk7DQoJcmV0ID0gc2V0X3RocmVhZF9hcmVhKCZpbmZvKTsNCglp
ZiAocmV0IDwgMCkgew0KCQlwcmludGYoInJldDogJWQsIFRFU1QgRkFJTEVE
IVxuIiwgcmV0KTsNCgkJZXhpdCgxKTsNCgl9DQoNCglpZHggPSBpbmZvLmVu
dHJ5X251bWJlcjsgc2VnID0gaWR4ICogOCArIDM7DQoJcHJpbnRmKCJnb3Qg
aWR4OiAlZCAoc2VsOiAlMDJ4KVxuIiwgaWR4LCBzZWcpOw0KDQoJaW5pdHNl
ZyhzZWcpOw0KDQoJcHJpbnRmKCJcbnJlYWRpbmcgJXAgYnl0ZSBvZiBbMHgl
MDh4XSBUTFM6XG4iLCAmZGF0YSwgYmFzZSk7DQoNCglyZWFkc2VnICgmcmVz
dWx0LCAmZGF0YSk7DQoJaWYgKHJlc3VsdCA9PSAxMjMpDQoJCXByaW50Zigi
PT09PT4gJWQgLS0tIFRFU1QgUEFTU0VELlxuXG4iLCByZXN1bHQpOw0KCWVs
c2UNCgkJcHJpbnRmKCI9PT09PiAlZCAtLS0gVEVTVCBGQUlMVVJFIVxuXG4i
LCByZXN1bHQpOw0KDQoNCglpbmZvLmVudHJ5X251bWJlciA9IC0xOw0KCWJh
c2UgPSAodW5zaWduZWQgaW50KSZkYXRhOyBpbmZvLmJhc2VfYWRkciA9IGJh
c2U7DQoJcHJpbnRmKCJcbmRvaW5nIHNldF90aHJlYWRfYXJlYSglMDh4KTpc
biIsIGJhc2UpOw0KCXJldCA9IHNldF90aHJlYWRfYXJlYSgmaW5mbyk7DQoJ
aWYgKHJldCA8IDApIHsNCgkJcHJpbnRmKCJyZXQ6ICVkLCBURVNUIEZBSUxF
RCFcbiIsIHJldCk7DQoJCWV4aXQoMSk7DQoJfQ0KDQoJaWR4ID0gaW5mby5l
bnRyeV9udW1iZXI7IHNlZyA9IGlkeCAqIDggKyAzOw0KCXByaW50ZigiZ290
IGlkeDogJWQgKHNlbDogJTAyeClcbiIsIGlkeCwgc2VnKTsNCg0KCWluaXRz
ZWcoc2VnKTsNCg0KCXByaW50ZigiXG5yZWFkaW5nICVwIGJ5dGUgb2YgWzB4
JTA4eF0gVExTOlxuIiwgJmRhdGEsIGJhc2UpOw0KDQoJcmVhZHNlZyAoJnJl
c3VsdCwgMCk7DQoJaWYgKHJlc3VsdCA9PSAxMjMpDQoJCXByaW50ZigiPT09
PT4gJWQgLS0tIFRFU1QgUEFTU0VELlxuXG4iLCByZXN1bHQpOw0KCWVsc2UN
CgkJcHJpbnRmKCI9PT09PiAlZCAtLS0gVEVTVCBGQUlMVVJFIVxuXG4iLCBy
ZXN1bHQpOw0KDQoJcHJpbnRmKCJcbnJlYWRpbmcgVExTIGlkeCAlZCdzIGRl
c2NyaXB0b3IuXG4iLCBpZHgpOw0KCWluZm8yLmVudHJ5X251bWJlciA9IGlk
eDsNCglyZXQgPSBnZXRfdGhyZWFkX2FyZWEoJmluZm8yKTsNCglpZiAocmV0
IDwgMCkgew0KCQlwcmludGYoInJldDogJWQsIFRFU1QgRkFJTEVEIVxuIiwg
cmV0KTsNCgkJZXhpdCgxKTsNCgl9DQoJaWYgKG1lbWNtcCgmaW5mbywgJmlu
Zm8yLCBzaXplb2YoaW5mbykpKSB7DQoJCXByaW50ZigiaHVoLCBpbmZvICE9
IGluZm8yPyAoJWQpXG4iLA0KCQkJbWVtY21wKCZpbmZvLCAmaW5mbzIsIHNp
emVvZihpbmZvKSkpOw0KCQlwcmludF9pbmZvKCZpbmZvKTsNCgkJcHJpbnRf
aW5mbygmaW5mbzIpOw0KCX0gZWxzZQ0KCQlwcmludGYoImluZm8gPT0gaW5m
bzIgLSBURVNUIFBBU1NFRC5cbiIpOw0KDQoJcHJpbnRmKCJcbmNsZWFyaW5n
IFRMUyBpZHggJWQncyBkZXNjcmlwdG9yLlxuIiwgaWR4KTsNCg0KCWluZm8u
ZW50cnlfbnVtYmVyID0gaWR4Ow0KCWluZm8uYmFzZV9hZGRyID0gMDsNCglp
bmZvLmxpbWl0ID0gMDsNCglpbmZvLnNlZ18zMmJpdCA9IDA7DQoJaW5mby5j
b250ZW50cyA9IDA7DQoJaW5mby5yZWFkX2V4ZWNfb25seSA9IDE7DQoJaW5m
by5saW1pdF9pbl9wYWdlcyA9IDA7DQoJaW5mby5zZWdfbm90X3ByZXNlbnQg
PSAxOw0KDQoJcmV0ID0gc2V0X3RocmVhZF9hcmVhKCZpbmZvKTsNCglpZiAo
cmV0IDwgMCkgew0KCQlwcmludGYoInJldDogJWQsIFRFU1QgRkFJTEVEIVxu
IiwgcmV0KTsNCgkJZXhpdCgxKTsNCgl9DQoJcHJpbnRmKCJURVNUIFBBU1NF
RC5cbiIpOw0KDQoJYmFzZSA9ICh1bnNpZ25lZCBpbnQpICZkYXRhOw0KDQoJ
cHJpbnRmKCJcbnJlLWFsbG9jYXRpbmcgVExTIGlkeCAlZCdzIGRlc2NyaXB0
b3IuXG4iLCBpZHgpOw0KDQoJZm9yIChpID0gMDsgaSA8IDI7IGkrKykgew0K
CQlpbmZvLmVudHJ5X251bWJlciA9IC0xOw0KCQlpbmZvLmJhc2VfYWRkciA9
IGJhc2U7DQoJCWluZm8ubGltaXQgPSAweGZmZmZmOw0KCQlpbmZvLnNlZ18z
MmJpdCA9IDE7DQoJCWluZm8uY29udGVudHMgPSBNT0RJRllfTERUX0NPTlRF
TlRTX0RBVEE7DQoJCWluZm8ucmVhZF9leGVjX29ubHkgPSAwOw0KCQlpbmZv
LmxpbWl0X2luX3BhZ2VzID0gMTsNCgkJaW5mby5zZWdfbm90X3ByZXNlbnQg
PSAwOw0KDQoJCXJldCA9IHNldF90aHJlYWRfYXJlYSgmaW5mbyk7DQoJCWlm
IChyZXQgPCAwKSB7DQoJCQlwcmludGYoInJldDogJWQsIFRFU1QgRkFJTEVE
IVxuIiwgcmV0KTsNCgkJCWV4aXQoMSk7DQoJCX0NCgkJaWYgKCFpICYmIChp
ZHggIT0gaW5mby5lbnRyeV9udW1iZXIpKSB7DQoJCQlwcmludGYoImlkeCAl
ZCAhPSBlbnRyeV9udW1iZXIgJWQhIFRFU1QgRkFJTEVEIVxuIiwNCgkJCQlp
ZHgsIGluZm8uZW50cnlfbnVtYmVyKTsNCgkJCWV4aXQoMSk7DQoJCX0NCgkJ
aWR4ID0gaW5mby5lbnRyeV9udW1iZXI7IHNlZyA9IGlkeCAqIDggKyAzOw0K
CQlwcmludGYoImdvdCBpZHg6ICVkIChzZWw6ICUwMngpXG4iLCBpZHgsIHNl
Zyk7DQoJCXNsZWVwKDEpOw0KDQoJCWluaXRzZWcoc2VnKTsNCgl9DQoNCglw
cmludGYoIlRFU1QgUEFTU0VELlxuXG4iKTsNCg0KCXByaW50Zigid3JpdGlu
ZyBsYXN0IGJ5dGUgb2YgNDA5NyBieXRlIFsweCUwOHhdIFRMUzpcbiIsIGJh
c2UpOw0KCXdyaXRlc2VnICgodm9pZCAqKTQwOTYsIDIzNCk7DQoJcmVhZHNl
ZyAoJnJlc3VsdCwgKHZvaWQgKik0MDk2KTsNCglpZiAocmVzdWx0ID09IDIz
NCkNCgkJcHJpbnRmKCI9PT09PiAlZCAtLS0gVEVTVCBQQVNTRUQuXG4iLCBy
ZXN1bHQpOw0KCWVsc2UNCgkJcHJpbnRmKCI9PT09PiAlZCAtLS0gVEVTVCBG
QUlMVVJFIS5cbiIsIHJlc3VsdCk7DQoNCglwcmludGYoIndyaXRpbmcgcmVh
ZC1vbmx5IHNlZ21lbnQgWzB4JTA4eF0gKHNob3VsZCBjb3JlZHVtcCk6XG4i
LCBiYXNlKTsNCglpbmZvLmVudHJ5X251bWJlciA9IC0xOw0KCWluZm8ucmVh
ZF9leGVjX29ubHkgPSAxOw0KCWJhc2UgPSAodW5zaWduZWQgaW50KSZkYXRh
OyBpbmZvLmJhc2VfYWRkciA9IGJhc2U7DQoJcmV0ID0gc2V0X3RocmVhZF9h
cmVhKCZpbmZvKTsNCglpZiAocmV0IDwgMCkgew0KCQlwcmludGYoInJldDog
JWQsIFRFU1QgRkFJTEVEIVxuIiwgcmV0KTsNCgkJZXhpdCgxKTsNCgl9DQoN
CglpZHggPSBpbmZvLmVudHJ5X251bWJlcjsgc2VnID0gaWR4ICogOCArIDM7
DQoJcHJpbnRmKCJnb3QgaWR4OiAlZCAoc2VsOiAlMDJ4KVxuIiwgaWR4LCBz
ZWcpOw0KDQoJaW5pdHNlZyhzZWcpOw0KCXdyaXRlc2VnICgodm9pZCAqKTQw
OTYsIDIzNCk7DQoJcHJpbnRmKCI9PT09PiAlZCAtLS0gVEVTVCBGQUlMVVJF
IS5cbiIsIHJlc3VsdCk7DQoNCglyZXR1cm4gMDsNCn0NCg==
--8323328-1987160651-1029102361=:29560--
