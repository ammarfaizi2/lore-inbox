Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUIJHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUIJHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIJHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:31:25 -0400
Received: from asplinux.ru ([195.133.213.194]:11268 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S264531AbUIJHY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:24:29 -0400
Message-ID: <41415955.3070008@sw.ru>
Date: Fri, 10 Sep 2004 11:35:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Yet another 4GB split patch
Content-Type: multipart/mixed;
 boundary="------------000207050006010406010906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207050006010406010906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is another 4GB split patch for kernel 2.4.27.
It adds new configuration option called CONFIG_4GB.

It differs from Ingo Molnar patch in many ways and in architecture,
in way how it handles NMI issues, how it maps code, GDT, LDT and so on.
For compatibility issues it splits address space as 3:4, so user space 
applications do not see any difference in their address spaces.
In recent version of this patch I used slightly modified 
copy_{to/from}_user interface from Ingo, so these patches have something 
in common.

This patch was used in a lot of production systems with very high loads, 
so it's tested very thoroughly. Some issues/problems I found in Ingo 
patch but fixed in my one I'll post here later.

I developed this patch a year ago, but due to copyright issues I was 
unsure to post it here. Now I'm happy to contribute this code back to 
Linux community.

Kirill

--------------000207050006010406010906
Content-Type: text/plain;
 name="diff-arch-4gb-2-port2.4.27"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-arch-4gb-2-port2.4.27"

--- ./fs/namei.c.4gb	2004-08-08 03:26:06.000000000 +0400
+++ ./fs/namei.c	2004-09-09 17:02:09.000000000 +0400
@@ -106,11 +106,12 @@ static inline int do_getname(const char 
 	int retval;
 	unsigned long len = PATH_MAX;
 
-	if ((unsigned long) filename >= TASK_SIZE) {
-		if (!segment_eq(get_fs(), KERNEL_DS))
+	if (!segment_eq(get_fs(), KERNEL_DS)) {
+		if ((unsigned long) filename >= TASK_SIZE)
 			return -EFAULT;
-	} else if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
-		len = TASK_SIZE - (unsigned long) filename;
+		if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
+			len = TASK_SIZE - (unsigned long) filename;
+	}
 
 	retval = strncpy_from_user((char *)page, filename, len);
 	if (retval > 0) {
--- ./kernel/module.c.4gb	2003-08-25 15:44:44.000000000 +0400
+++ ./kernel/module.c	2004-09-09 17:02:09.000000000 +0400
@@ -436,6 +436,13 @@ sys_init_module(const char *name_user, s
 		printk(KERN_ERR "init_module: mod->cleanup out of bounds.\n");
 		goto err2;
 	}
+#ifdef CONFIG_4GB
+	/* indirect_xxx uaccess functions don't generate exception entries */
+	if (mod->ex_table_start || mod->ex_table_end) {
+		printk(KERN_ERR "init_module: not 4GB kernel module\n");
+		goto err2;
+	}
+#endif
 	if (mod->ex_table_start > mod->ex_table_end
 	    || (mod->ex_table_start &&
 		!((unsigned long)mod->ex_table_start >= ((unsigned long)mod + mod->size_of_struct)
--- ./mm/memory.c.4gb	2003-11-28 21:26:21.000000000 +0300
+++ ./mm/memory.c	2004-09-09 17:02:09.000000000 +0400
@@ -402,7 +402,8 @@ void zap_page_range(struct mm_struct *mm
 /*
  * Do a quick page-table lookup for a single page. 
  */
-static struct page * follow_page(struct mm_struct *mm, unsigned long address, int write) 
+struct page * follow_page(struct mm_struct *mm, unsigned long address,
+		int write) 
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -422,6 +423,15 @@ static struct page * follow_page(struct 
 
 	pte = *ptep;
 	if (pte_present(pte)) {
+#ifdef CONFIG_4GB
+		/*
+		 * this condition enables us to omit access_ok() checks in
+		 * indirect_XXX user access routines. i.e. we check here
+		 * (instead of access_ok()) that we try to access user pages.
+		 */
+		if (unlikely(!pte_user(pte)))
+			return 0;
+#endif
 		if (!write ||
 		    (pte_write(pte) && pte_dirty(pte)))
 			return pte_page(pte);
--- ./include/linux/mm.h.4gb	2003-11-28 21:26:21.000000000 +0300
+++ ./include/linux/mm.h	2004-09-09 17:54:39.000000000 +0400
@@ -502,6 +502,8 @@ extern int ptrace_detach(struct task_str
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
 
+struct page * follow_page(struct mm_struct *mm, unsigned long address,
+		int write);
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 
--- ./include/asm-i386/fixmap.h.4gb	2003-08-25 15:44:43.000000000 +0400
+++ ./include/asm-i386/fixmap.h	2004-09-09 17:54:39.000000000 +0400
@@ -18,6 +18,7 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
+#include <asm/page_offset.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -84,6 +85,101 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
+#ifdef CONFIG_4GB
+/*
+ * Global mappings for 4GB split. If you change this, also change
+ * vmlinux.lds.S. This range contains the page aligned idt, gdt, ldt, tss and
+ * exception entry/exit code.
+ *
+ *      user space                                 kernel space
+ * |------------------|     <-    4GB    ->    |------------------|
+ * |       Free       |                        |                  |
+ * |------------------|                        |------------------|
+ * |   default LDT    |                        |   default LDT    |
+ * |------------------|     <- LDT_START ->    |------------------|
+ * |                  |                        |                  |
+ * |------------------|                        |------------------|
+ * |   TSS (global)   |                        |   TSS (global)   |
+ * |------------------|     <- TSS_START ->    |------------------|
+ * |                  |                        |                  |
+ * |------------------|                        |------------------|
+ * |   GDT (global)   |                        |   GDT (global)   |
+ * |------------------|     <- GDT_START ->    |------------------|
+ * |                  |                        |                  |
+ * |------------------|                        |------------------|
+ * |   IDT (global)   |                        |   IDT (global)   |
+ * |------------------|     <- IDT_START ->    |------------------|
+ * |                  |                        |                  |
+ * |------------------|                        |------------------|
+ * |   task_struct    |                        |    task_struct   |
+ * |   cpu #NR_CPUS   |                        |    cpu #NR_CPUS  |
+ * |------------------|                        |------------------|
+ * |      .....       |                        |       .....      |
+ * |------------------|                        |------------------|
+ * |task_struct, cpu#0|                        |task_struct, cpu#0|
+ * |------------------|   <- LOTASK_START ->   |------------------|
+ * |                  |                        |                  |
+ * |------------------|                        |------------------|
+ * | entry/exit code  |                        | entry/exit code  |
+ * | interrupts code  |                        | interrupts code  |
+ * |(section .locore) |                        |(section .locore) |
+ * |------------------|   <- LOCORE_START ->   |------------------|
+ * |                  |                        |                  |
+ * |                  |                        |------------------|
+ * |                  |                        |      FIXMAP,     |
+ * |------------------|   <- TASK_SIZE         |    Normal zone   |
+ * |                  |                        |                  |
+ * |       User       |                        |------------------|
+ * |   Applications   |                        |       Kernel     |
+ * |                  |        PAGE_OFFSET ->  |------------------|
+ * |                  |                        |                  |
+ * |------------------|   <-       0       ->  |------------------|
+ */
+
+/* Range size for exceptions/ints, entry/exit locore code. */
+#define LOCORE_START    (SPLIT_4GB_MAP_START)
+#define LOCORE_SIZE     (7 * PAGE_SIZE)
+
+/*
+ * Start of per thread mapping of task structure and kernel stack.
+ * Must be aligned on a two page boundary so that GET_CURRENT works
+ * For each CPU current task_struct is mapped at
+ *   utask = LOTASK_START+cpu*(THREAD_SIZE+LOTASK_BARRIER)
+ *   where LOTASK_BARRIER is a distance between task structs
+ */
+#define LOTASK_START	((LOCORE_START + LOCORE_SIZE + PAGE_SIZE) & \
+		~(THREAD_SIZE-1))
+#define LOTASK_BARRIER	(THREAD_SIZE)
+#define LOTASK_SIZE	(NR_CPUS*(THREAD_SIZE+LOTASK_BARRIER))
+
+/*
+ * IDT mapping. IDT is mapped onlt once on startup.
+ */
+#define IDT_START	(LOTASK_START + LOTASK_SIZE + PAGE_SIZE)
+#define IDT_SIZE	PAGE_SIZE
+
+/*
+ * GDT mapping. GDT is mapped onlt once on startup.
+ */
+#define GDTM_START	(IDT_START + IDT_SIZE + PAGE_SIZE)
+#define GDT_SIZE	(PAGE_SIZE)	/* 256 entries*8 bytes per entry */
+
+/*
+ * TSS mapping. TSS is mapped only once on startup.
+ * TSS_SIZE = (sizeof(tss)=256)*(NR_CPUS=32) = 32*256=2 pages,
+ * probably it should be calced as L1_CACHE_ALIGN(sizeof(tss_struct))*NR_CPUS
+ */
+#define TSS_START	(GDTM_START + GDT_SIZE + PAGE_SIZE)
+#define TSS_SIZE	(4*PAGE_SIZE)
+
+/*
+ * Optional LDT address for the process (see write_ldt(), default_ldt)
+ */
+#define LDT_START	(TSS_START + TSS_SIZE + PAGE_SIZE)
+#define LDT_SIZE	PAGE_ALIGN(LDT_ENTRIES*LDT_ENTRY_SIZE)
+
+#endif	/* CONFIG_4GB */
+
 extern void __set_fixmap (enum fixed_addresses idx,
 					unsigned long phys, pgprot_t flags);
 
@@ -101,7 +197,12 @@ extern void __set_fixmap (enum fixed_add
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
+#ifdef CONFIG_4GB
+#define FIXADDR_TOP	(SPLIT_4GB_MAP_START - PAGE_SIZE)
+#else
 #define FIXADDR_TOP	(0xffffe000UL)
+#endif
+
 #define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
--- ./include/asm-i386/hw_irq.h.4gb	2003-08-25 15:44:43.000000000 +0400
+++ ./include/asm-i386/hw_irq.h	2004-09-09 17:54:40.000000000 +0400
@@ -95,6 +95,79 @@ extern char _stext, _etext;
 #define __STR(x) #x
 #define STR(x) __STR(x)
 
+#ifdef CONFIG_4GB
+
+/*
+ * LOAD_CURRENT_AND_ESP
+ * loads current stack pointer and pointer to current task_struct
+ *
+ * input:	%esp
+ * output:	%ecx = %esp, %ebx = current
+ * modifies:	%ecx, %ebx
+ */
+#define LOAD_CURRENT_AND_ESP		\
+	"movl %esp, %ecx\n\t"		\
+	"movl $-8192, %ebx\n\t" \
+	"andl %ecx, %ebx\n\t"
+
+/*
+ * LOAD_KERNEL_ESP
+ * loads kernel esp = (esp - user_task_struct) + kernel_task_struct
+ *
+ * input:	%ebx = current, %ecx = %esp
+ * output:	%ebx = new_current, %ecx = %esp = new_esp
+ * modifies:	%ebx, %ecx, %esp
+ */
+#define LOAD_KERNEL_ESP			\
+	"subl %ebx, %ecx\n\t"		\
+	"movl " STR(TASK_THREAD_KTASK) "(%ebx), %ebx\n\t" \
+	"addl %ebx, %ecx\n\t"		\
+	"movl %ecx, %esp\n\t"
+
+/*
+ * LOAD_KPDBR
+ * sets cr3(PDBR) to kernel swapper_pg_dir
+ *
+ * modifies:	%edx, %cr3
+ */
+#define LOAD_KPDBR			\
+	"movl $" SYMBOL_NAME_STR(swapper_pg_dir) "-" STR(__PAGE_OFFSET)	\
+							",%edx\n\t"	\
+	"movl %edx,%cr3\n\t"
+
+/*
+ * SPLIT_4GB_PREAMBLE
+ * switches to kernel space if not already there
+ *
+ * input:
+ * output:	%ebx = kernel_current, %esp = kernel_esp
+ * modifies:	%edx, %ebx, %ecx, %esp, %cr3
+ */
+#define SPLIT_4GB_PREAMBLE		\
+	LOAD_CURRENT_AND_ESP		\
+	"cmpl $" STR(SPLIT_4GB_MAP_START) ", %ecx\n\t" \
+	"jb 1f\n\t"			\
+	LOAD_KPDBR			\
+	LOAD_KERNEL_ESP			\
+	"1:\n\t"
+
+#define SPLIT_4GB_CODE_START \
+	".section .locore,\"ax\""
+
+#define SPLIT_4GB_CODE_END \
+	".previous"
+
+#else /* CONFIG_4GB */
+
+#define SPLIT_4GB_PREAMBLE \
+	""
+#define SPLIT_4GB_CODE_START \
+	""
+#define SPLIT_4GB_CODE_END \
+	""
+
+#endif /* CONFIG_4GB */
+
 #define SAVE_ALL \
 	"cld\n\t" \
 	"pushl %es\n\t" \
@@ -108,7 +181,8 @@ extern char _stext, _etext;
 	"pushl %ebx\n\t" \
 	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
 	"movl %edx,%ds\n\t" \
-	"movl %edx,%es\n\t"
+	"movl %edx,%es\n\t" \
+	SPLIT_4GB_PREAMBLE
 
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
@@ -128,19 +202,22 @@ extern char _stext, _etext;
 asmlinkage void x(void); \
 asmlinkage void call_##x(void); \
 __asm__( \
+SPLIT_4GB_CODE_START \
 "\n"__ALIGN_STR"\n" \
 SYMBOL_NAME_STR(x) ":\n\t" \
 	"pushl $"#v"-256\n\t" \
 	SAVE_ALL \
 	SYMBOL_NAME_STR(call_##x)":\n\t" \
 	"call "SYMBOL_NAME_STR(smp_##x)"\n\t" \
-	"jmp ret_from_intr\n");
+	"jmp ret_from_intr\n\t" \
+SPLIT_4GB_CODE_END);
 
 #define BUILD_SMP_TIMER_INTERRUPT(x,v) XBUILD_SMP_TIMER_INTERRUPT(x,v)
 #define XBUILD_SMP_TIMER_INTERRUPT(x,v) \
 asmlinkage void x(struct pt_regs * regs); \
 asmlinkage void call_##x(void); \
 __asm__( \
+SPLIT_4GB_CODE_START \
 "\n"__ALIGN_STR"\n" \
 SYMBOL_NAME_STR(x) ":\n\t" \
 	"pushl $"#v"-256\n\t" \
@@ -150,17 +227,20 @@ SYMBOL_NAME_STR(x) ":\n\t" \
 	SYMBOL_NAME_STR(call_##x)":\n\t" \
 	"call "SYMBOL_NAME_STR(smp_##x)"\n\t" \
 	"addl $4,%esp\n\t" \
-	"jmp ret_from_intr\n");
+	"jmp ret_from_intr\n\t" \
+SPLIT_4GB_CODE_END);
 
 #define BUILD_COMMON_IRQ() \
 asmlinkage void call_do_IRQ(void); \
 __asm__( \
+SPLIT_4GB_CODE_START \
 	"\n" __ALIGN_STR"\n" \
 	"common_interrupt:\n\t" \
 	SAVE_ALL \
 	SYMBOL_NAME_STR(call_do_IRQ)":\n\t" \
 	"call " SYMBOL_NAME_STR(do_IRQ) "\n\t" \
-	"jmp ret_from_intr\n");
+	"jmp ret_from_intr\n\t" \
+SPLIT_4GB_CODE_END);
 
 /* 
  * subtle. orig_eax is used by the signal code to distinct between
@@ -175,10 +255,12 @@ __asm__( \
 #define BUILD_IRQ(nr) \
 asmlinkage void IRQ_NAME(nr); \
 __asm__( \
+SPLIT_4GB_CODE_START \
 "\n"__ALIGN_STR"\n" \
 SYMBOL_NAME_STR(IRQ) #nr "_interrupt:\n\t" \
 	"pushl $"#nr"-256\n\t" \
-	"jmp common_interrupt");
+	"jmp common_interrupt\n\t" \
+SPLIT_4GB_CODE_END);
 
 extern unsigned long prof_cpu_mask;
 extern unsigned int * prof_buffer;
--- ./include/asm-i386/kmap_types.h.4gb	2003-08-25 15:44:43.000000000 +0400
+++ ./include/asm-i386/kmap_types.h	2004-09-09 17:02:09.000000000 +0400
@@ -7,6 +7,7 @@ enum km_type {
 	KM_SKB_DATA_SOFTIRQ,
 	KM_USER0,
 	KM_USER1,
+	KM_USER_COPY,
 	KM_BH_IRQ,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
--- ./include/asm-i386/mmu_context.h.4gb	2004-02-18 16:36:32.000000000 +0300
+++ ./include/asm-i386/mmu_context.h	2004-09-09 17:54:40.000000000 +0400
@@ -37,8 +37,12 @@ static inline void switch_mm(struct mm_s
 		cpu_tlbstate[cpu].active_mm = next;
 #endif
 		set_bit(cpu, &next->cpu_vm_mask);
+#ifndef CONFIG_4GB
 		/* Re-load page tables */
 		load_cr3(next->pgd);
+#else
+		/* %cr3 is reloaded on returning to user space, see entry.S */
+#endif
 	 	/* load_LDT, if either the previous or next thread
 		 * has a non-default LDT.
 		 */
@@ -54,7 +58,11 @@ static inline void switch_mm(struct mm_s
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
+#ifndef CONFIG_4GB
 			load_cr3(next->pgd);
+#else
+			local_flush_tlb();
+#endif
 			load_LDT(&next->context);
 		}
 	}
--- ./include/asm-i386/page.h.4gb	2002-08-03 04:39:45.000000000 +0400
+++ ./include/asm-i386/page.h	2004-09-09 17:54:39.000000000 +0400
@@ -78,13 +78,18 @@ typedef struct { unsigned long pgprot; }
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
-#define __PAGE_OFFSET		(0xC0000000)
+#include <asm/page_offset.h>
+#define __PAGE_OFFSET          PAGE_OFFSET_RAW
 
 /*
  * This much address space is reserved for vmalloc() and iomap()
  * as well as fixmap mappings.
  */
+#ifndef CONFIG_4GB
 #define __VMALLOC_RESERVE	(128 << 20)
+#else
+#define __VMALLOC_RESERVE	(512 << 20)
+#endif
 
 #ifndef __ASSEMBLY__
 
--- /dev/null	2003-04-26 02:10:32.000000000 +0400
+++ ./include/asm-i386/page_offset.h	2004-09-09 17:54:39.000000000 +0400
@@ -0,0 +1,27 @@
+#ifndef __PAGE_OFFSET_H__
+#define __PAGE_OFFSET_H__
+
+#include <linux/config.h>
+
+#if   defined(CONFIG_1GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#elif defined(CONFIG_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_3GB)
+#define PAGE_OFFSET_RAW 0x40000000
+#elif defined(CONFIG_4GB)
+
+/*
+ * PAGE_OFFSET_RAW can be as low as 32Mb
+ * 4 pgds (32 Mb) are required when PAE pgd is initialized
+ */
+#define PAGE_OFFSET_RAW 0x02000000
+/*
+ * default value 0xffc00000 means the highest pgd in non-PAE kernel
+ * and the last pmd-1 in PAE-enabled kernel
+ */
+#define SPLIT_4GB_MAP_START 0xffc00000
+
+#endif
+
+#endif
--- ./include/asm-i386/pgtable.h.4gb	2002-11-29 02:53:15.000000000 +0300
+++ ./include/asm-i386/pgtable.h	2004-09-09 17:54:39.000000000 +0400
@@ -158,7 +158,14 @@ extern void pgtable_cache_init(void);
  * area for the same reason. ;)
  */
 #define VMALLOC_OFFSET	(8*1024*1024)
-#define VMALLOC_START	(((unsigned long) high_memory + 2*VMALLOC_OFFSET-1) & \
+#ifdef CONFIG_4GB
+/* vmalloc has to be higher than TASK_SIZE for ldt mappings */
+#define __VMALLOC_START (((unsigned long)high_memory > TASK_SIZE) ? \
+		(unsigned long)high_memory : TASK_SIZE)
+#else
+#define __VMALLOC_START ((unsigned long)high_memory)
+#endif
+#define VMALLOC_START	((__VMALLOC_START + 2*VMALLOC_OFFSET-1) & \
 						~(VMALLOC_OFFSET-1))
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
 #if CONFIG_HIGHMEM
@@ -213,9 +220,9 @@ extern void pgtable_cache_init(void);
 	(_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED)
 
 #ifdef CONFIG_X86_PGE
-# define MAKE_GLOBAL(x) __pgprot((x) | _PAGE_GLOBAL)
+# define _MAKE_GLOBAL(x) __pgprot((x) | _PAGE_GLOBAL)
 #else
-# define MAKE_GLOBAL(x)						\
+# define _MAKE_GLOBAL(x)						\
 	({							\
 		pgprot_t __ret;					\
 								\
@@ -227,6 +234,13 @@ extern void pgtable_cache_init(void);
 	})
 #endif
 
+#ifdef CONFIG_4GB
+/* global pages are not allowed when 4Gb kernel/user space split is used */
+#define MAKE_GLOBAL(x) __pgprot(x)
+#else
+#define MAKE_GLOBAL(x) _MAKE_GLOBAL(x)
+#endif
+
 #define PAGE_KERNEL MAKE_GLOBAL(__PAGE_KERNEL)
 #define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
@@ -279,6 +293,7 @@ extern unsigned long pg0[1024];
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
+static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_exec(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
@@ -324,7 +339,7 @@ static inline pte_t pte_modify(pte_t pte
 ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /* to find an entry in a page-table-directory. */
-#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
 #define __pgd_offset(address) pgd_index(address)
 
--- ./include/asm-i386/processor.h.4gb	2004-02-18 16:36:32.000000000 +0300
+++ ./include/asm-i386/processor.h	2004-09-09 17:54:39.000000000 +0400
@@ -259,7 +259,15 @@ extern unsigned int mca_pentium_flag;
 /*
  * User space process size: 3GB (default).
  */
+#ifdef CONFIG_4GB
+/*
+ * For 4gb split we explicitly set task size to 3Gb,
+ * since PAGE_OFFSET means kernel offset here
+ */
+#define TASK_SIZE	(0xC0000000)
+#else
 #define TASK_SIZE	(PAGE_OFFSET)
+#endif
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
@@ -363,6 +371,13 @@ struct thread_struct {
 	unsigned long	esp;
 	unsigned long	fs;
 	unsigned long	gs;
+#ifdef CONFIG_4GB
+	unsigned long	utask;		/* U-space task_struct */
+	unsigned long	ktask;		/* kernel mapped task */
+	unsigned long	reloaddbg;	/* db regs should be reloaded on ret
+					   to user? see do_debug(), entry.S */
+	unsigned long	cr3;		/* user space cr3 value */
+#endif
 /* Hardware debugging registers */
 	unsigned long	debugreg[8];  /* %%db0-7 debug registers */
 /* fault info */
@@ -378,9 +393,18 @@ struct thread_struct {
 	unsigned long	io_bitmap[IO_BITMAP_SIZE+1];
 };
 
+#ifdef CONFIG_4GB
+#define INIT_SPLIT_4GB_THREAD_REGS				\
+	0, (unsigned long)&init_task, 0,			\
+	(unsigned long)&swapper_pg_dir - PAGE_OFFSET, /* cr3 */
+#else
+#define INIT_SPLIT_4GB_THREAD_REGS
+#endif
+
 #define INIT_THREAD  {						\
 	0,							\
 	0, 0, 0, 0, 						\
+	INIT_SPLIT_4GB_THREAD_REGS				\
 	{ [0 ... 7] = 0 },	/* debugging registers */	\
 	0, 0, 0,						\
 	{ { 0, }, },		/* 387 state */			\
--- ./include/asm-i386/string.h.4gb	2001-11-22 22:46:18.000000000 +0300
+++ ./include/asm-i386/string.h	2004-09-09 17:54:39.000000000 +0400
@@ -62,6 +62,34 @@ __asm__ __volatile__(
 return dest;
 }
 
+/*
+ * This is a more generic variant of strncpy_count() suitable for
+ * implementing string-access routines with all sorts of return
+ * code semantics. It's used by arch/i386/mm/usercopy.c.
+ *
+ * strncpy_count returns num of bytes left = (count-strlen(src)), i.e.
+ * count=0, strlen(src)=#,   res=0
+ * count=n, strlen(src)=m<n, res=n-m (0 is not counted, but copied!)
+ * count=n, strlen(src)=n-1, res=1
+ * count=n, strlen(src)=n,   res=0
+ */
+static inline size_t strncpy_count(char * dest,const char *src,size_t count)
+{
+	__asm__ __volatile__(
+	"1:\tdecl %0\n\t"
+	"js 2f\n\t"
+	"lodsb\n\t"
+	"stosb\n\t"
+	"testb %%al,%%al\n\t"
+	"jne 1b\n\t"
+	"2:"
+	"incl %0"
+	: "=c" (count)
+	:"S" (src),"D" (dest),"0" (count) : "memory");
+
+	return count;
+}
+
 #define __HAVE_ARCH_STRCAT
 static inline char * strcat(char * dest,const char * src)
 {
--- ./include/asm-i386/uaccess.h.4gb	2003-06-13 18:51:38.000000000 +0400
+++ ./include/asm-i386/uaccess.h	2004-09-09 17:54:40.000000000 +0400
@@ -24,7 +24,7 @@
 
 
 #define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
-#define USER_DS		MAKE_MM_SEG(PAGE_OFFSET)
+#define USER_DS		MAKE_MM_SEG(TASK_SIZE)
 
 #define get_ds()	(KERNEL_DS)
 #define get_fs()	(current->addr_limit)
@@ -128,6 +128,9 @@ struct exception_table_entry
 /* Returns 0 if exception not found and fixup otherwise.  */
 extern unsigned long search_exception_table(unsigned long);
 
+#ifdef CONFIG_4GB
+void __init extable_init(void);
+#endif
 
 /*
  * These are the main single-value transfer routines.  They automatically
@@ -172,7 +175,7 @@ extern void __get_user_4(void);
  * Returns zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr)							\
+#define direct_get_user(x,ptr)							\
 ({	int __ret_gu,__val_gu;						\
 	switch(sizeof (*(ptr))) {					\
 	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
@@ -208,7 +211,7 @@ extern void __put_user_bad(void);
  *
  * Returns zero on success, or -EFAULT on error.
  */
-#define put_user(x,ptr)							\
+#define direct_put_user(x,ptr)							\
   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 
 
@@ -232,7 +235,7 @@ extern void __put_user_bad(void);
  * Returns zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define __get_user(x,ptr) \
+#define __direct_get_user(x,ptr) \
   __get_user_nocheck((x),(ptr),sizeof(*(ptr)))
 
 
@@ -255,7 +258,7 @@ extern void __put_user_bad(void);
  *
  * Returns zero on success, or -EFAULT on error.
  */
-#define __put_user(x,ptr) \
+#define __direct_put_user(x,ptr) \
   __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 
 #define __put_user_nocheck(x,ptr,size)			\
@@ -708,7 +711,7 @@ __constant_copy_from_user_nocheck(void *
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-#define copy_to_user(to,from,n)				\
+#define direct_copy_to_user(to,from,n)			\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_to_user((to),(from),(n)) :	\
 	 __generic_copy_to_user((to),(from),(n)))
@@ -729,7 +732,7 @@ __constant_copy_from_user_nocheck(void *
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-#define copy_from_user(to,from,n)			\
+#define direct_copy_from_user(to,from,n)		\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_from_user((to),(from),(n)) :	\
 	 __generic_copy_from_user((to),(from),(n)))
@@ -748,7 +751,7 @@ __constant_copy_from_user_nocheck(void *
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-#define __copy_to_user(to,from,n)			\
+#define __direct_copy_to_user(to,from,n)		\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_to_user_nocheck((to),(from),(n)) :	\
 	 __generic_copy_to_user_nocheck((to),(from),(n)))
@@ -770,13 +773,13 @@ __constant_copy_from_user_nocheck(void *
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-#define __copy_from_user(to,from,n)			\
+#define __direct_copy_from_user(to,from,n)		\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_from_user_nocheck((to),(from),(n)) :	\
 	 __generic_copy_from_user_nocheck((to),(from),(n)))
 
-long strncpy_from_user(char *dst, const char *src, long count);
-long __strncpy_from_user(char *dst, const char *src, long count);
+long direct_strncpy_from_user(char *dst, const char *src, long count);
+long __direct_strncpy_from_user(char *dst, const char *src, long count);
 
 /**
  * strlen_user: - Get the size of a string in user space.
@@ -792,10 +795,122 @@ long __strncpy_from_user(char *dst, cons
  * If there is a limit on the length of a valid string, you may wish to
  * consider using strnlen_user() instead.
  */
-#define strlen_user(str) strnlen_user(str, ~0UL >> 1)
+#define direct_strlen_user(str) direct_strnlen_user(str, ~0UL >> 1)
+
+long direct_strnlen_user(const char *str, long n);
+unsigned long direct_clear_user(void *mem, unsigned long len);
+unsigned long __direct_clear_user(void *mem, unsigned long len);
+
+/*
+ * ---------------------------------------------------------------------------
+ * Indirect user copying routines, i.e. functions which follow pagetables
+ * manually to access user memory (e.g. when 4GB split is used)
+ * ---------------------------------------------------------------------------
+ */
+extern int indirect_get_user_size(unsigned int size,
+		void *val, const void *ptr);
+extern int indirect_put_user_size(unsigned int size,
+		const void *val, void *ptr);
+extern int indirect_clear_user_size(unsigned int size, void *ptr);
+extern int indirect_strncpy_from_user_size(unsigned int size, void *val,
+		const void *ptr);
+extern int indirect_strnlen_user_size(unsigned int size, const void *ptr);
+
+/*
+ * GCC 2.96 has stupid bug which forces us to use volatile or barrier below.
+ * without volatile or barrier compiler generates ABSOLUTELY wrong code which
+ * igonores XXX_size function return code, but generates EFAULT :)))
+ * the bug was found in sys_utime()
+ */
+#define indirect_get_user(x,ptr)					\
+({	int __ret_gu, __val_gu;						\
+ 	__typeof__(ptr) __ptr_gu = (ptr);				\
+	__ret_gu = indirect_get_user_size(sizeof(*__ptr_gu),		\
+		&__val_gu, __ptr_gu) ? -EFAULT : 0;			\
+	barrier();							\
+	(x) = (__typeof__(*__ptr_gu))__val_gu;				\
+	__ret_gu;							\
+})
+
+#define indirect_put_user(x,ptr)					\
+({									\
+ 	int __ret_pu;							\
+ 	__typeof__(*(ptr)) *__ptr_pu = (ptr),				\
+		__x_pu = (__typeof__(*(ptr)))(x);			\
+	__ret_pu = indirect_put_user_size(sizeof(*__ptr_pu),		\
+		&__x_pu, __ptr_pu) ? -EFAULT : 0;			\
+	barrier();							\
+	__ret_pu;							\
+})
+
+#define __indirect_get_user(x,ptr) indirect_get_user(x,ptr)
+#define __indirect_put_user(x,ptr) indirect_put_user(x,ptr)
+
+#define indirect_copy_from_user(to,from,n) indirect_get_user_size(n,to,from)
+#define indirect_copy_to_user(to,from,n) indirect_put_user_size(n,from,to)
+
+#define __indirect_copy_from_user indirect_copy_from_user
+#define __indirect_copy_to_user indirect_copy_to_user
+
+#define indirect_strncpy_from_user(dst, src, count) \
+	indirect_strncpy_from_user_size(count, dst, src)
+
+#define indirect_strnlen_user(str, n) indirect_strnlen_user_size(n, str)
+#define indirect_strlen_user(str) indirect_strnlen_user(str, ~0UL >> 1)
+
+#define indirect_clear_user(mem, len) indirect_clear_user_size(len, mem)
+#define __indirect_clear_user indirect_clear_user
+
+/*
+ * Return code and zeroing semantics:
+
+ __clear_user		0			<-> bytes not done
+ clear_user		0			<-> bytes not done
+ __copy_to_user		0			<-> bytes not done
+ copy_to_user		0			<-> bytes not done
+ __copy_from_user	0			<-> bytes not done, zero rest
+ copy_from_user		0			<-> bytes not done, zero rest
+ __get_user		0			<-> -EFAULT
+ get_user		0			<-> -EFAULT
+ __put_user		0			<-> -EFAULT
+ put_user		0			<-> -EFAULT
+ strlen_user		strlen + 1		<-> 0
+ strnlen_user		strlen + 1 (or n+1)	<-> 0
+ strncpy_from_user	strlen (or n)		<-> -EFAULT
+*/
+
+#ifdef CONFIG_4GB
+
+#define __clear_user		__indirect_clear_user
+#define clear_user		  indirect_clear_user
+#define __copy_to_user		__indirect_copy_to_user
+#define copy_to_user		  indirect_copy_to_user
+#define __copy_from_user	__indirect_copy_from_user
+#define copy_from_user	  	indirect_copy_from_user
+#define __get_user		__indirect_get_user
+#define get_user		  indirect_get_user
+#define __put_user		__indirect_put_user
+#define put_user		  indirect_put_user
+#define strlen_user		indirect_strlen_user
+#define strnlen_user		indirect_strnlen_user
+#define strncpy_from_user	indirect_strncpy_from_user
+
+#else /* CONFIG_4GB */
+
+#define __clear_user		__direct_clear_user
+#define clear_user		  direct_clear_user
+#define __copy_to_user		__direct_copy_to_user
+#define copy_to_user		  direct_copy_to_user
+#define __copy_from_user	__direct_copy_from_user
+#define copy_from_user		  direct_copy_from_user
+#define __get_user		__direct_get_user
+#define get_user		  direct_get_user
+#define __put_user		__direct_put_user
+#define put_user		  direct_put_user
+#define strlen_user		direct_strlen_user
+#define strnlen_user		direct_strnlen_user
+#define strncpy_from_user	direct_strncpy_from_user
 
-long strnlen_user(const char *str, long n);
-unsigned long clear_user(void *mem, unsigned long len);
-unsigned long __clear_user(void *mem, unsigned long len);
+#endif /* CONFIG_4GB */
 
 #endif /* __i386_UACCESS_H */
--- ./include/asm-i386/highmem.h.4gb	2004-09-09 18:19:38.000000000 +0400
+++ ./include/asm-i386/highmem.h	2004-09-09 18:19:17.000000000 +0400
@@ -46,7 +46,7 @@ extern void kmap_init(void) __init;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#define PKMAP_BASE (0xff800000UL)
+#define PKMAP_BASE (0xff400000UL)
 #ifdef CONFIG_X86_PAE
 #define LAST_PKMAP 512
 #else
--- ./arch/i386/mm/extable.c.4gb	2001-09-18 00:16:30.000000000 +0400
+++ ./arch/i386/mm/extable.c	2004-09-09 17:02:08.000000000 +0400
@@ -17,13 +17,11 @@ search_one_table(const struct exception_
 {
         while (first <= last) {
 		const struct exception_table_entry *mid;
-		long diff;
 
 		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
+		if (mid->insn == value)
                         return mid->fixup;
-                else if (diff < 0)
+		else if (mid->insn < value)
                         first = mid+1;
                 else
                         last = mid-1;
@@ -60,3 +58,33 @@ search_exception_table(unsigned long add
 	return ret;
 #endif
 }
+
+#ifdef CONFIG_4GB
+void __init extable_init(void)
+{
+	struct exception_table_entry *first =
+		(struct exception_table_entry *)__start___ex_table;
+	struct exception_table_entry *last =
+		(struct exception_table_entry *)__stop___ex_table - 1;
+	struct exception_table_entry *entry;
+	struct exception_table_entry tmp;
+	int chg = 1;
+
+	printk("Sorting kernel __ex_table entries... ");
+
+	/* simple n^2 sort algo */
+	while(chg) {
+		chg = 0;
+		for (entry = first; entry < last; entry++)
+			if (entry->insn > (entry+1)->insn) {
+				/* swap entries */
+				tmp = *entry;
+				*entry = *(entry+1);
+				*(entry+1) = tmp;
+				chg = 1;
+			}
+	}
+
+	printk("done.\n");
+}
+#endif
--- ./arch/i386/mm/fault.c.4gb	2004-08-08 03:26:04.000000000 +0400
+++ ./arch/i386/mm/fault.c	2004-09-10 10:44:51.388617664 +0400
@@ -379,7 +379,13 @@ vmalloc_fault:
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
+#ifdef CONFIG_4GB
+		if (!current->mm)
+			goto no_context;
+		pgd = (pgd_t *)__pa(current->mm->pgd);
+#else
 		asm("movl %%cr3,%0":"=r" (pgd));
+#endif
 		pgd = offset + (pgd_t *)__va(pgd);
 		pgd_k = init_mm.pgd + offset;
 
--- ./arch/i386/mm/init.c.4gb	2004-04-14 17:05:25.000000000 +0400
+++ ./arch/i386/mm/init.c	2004-09-09 17:02:08.000000000 +0400
@@ -37,6 +37,7 @@
 #include <asm/e820.h>
 #include <asm/apic.h>
 #include <asm/tlb.h>
+#include <asm/desc.h>
 
 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
@@ -179,9 +180,18 @@ static void __init fixrange_init (unsign
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
 #if CONFIG_X86_PAE
-		if (pgd_none(*pgd)) {
+		/*
+		 * mainstreem kernel incorrectly checks pgd_none() here,
+		 * which always expands to 0. It's not a problem for
+		 * standart kernel since highest pgd is always created when
+		 * mapping memory and this 'if' is not required at all.
+		 * With 4GB kernel split and little memory (< 3GB)
+		 * the highest pgd can be absent (i.e. point to zero page)
+		 * and we need this 'if' to init it properly	-- dev@sw.ru
+		 */
+		if (pgd_val(*pgd) == __pa(empty_zero_page) + _PAGE_PRESENT) {
 			pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-			set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
+			set_pgd(pgd, __pgd(__pa(pmd) + _PAGE_PRESENT));
 			if (pmd != pmd_offset(pgd, 0))
 				printk("PAE BUG #02!\n");
 		}
@@ -219,7 +229,8 @@ static void __init pagetable_init (void)
 	pgd_base = swapper_pg_dir;
 #if CONFIG_X86_PAE
 	for (i = 0; i < PTRS_PER_PGD; i++)
-		set_pgd(pgd_base + i, __pgd(1 + __pa(empty_zero_page)));
+		set_pgd(pgd_base + i,
+				__pgd(_PAGE_PRESENT + __pa(empty_zero_page)));
 #endif
 	i = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + i;
@@ -230,13 +241,14 @@ static void __init pagetable_init (void)
 			break;
 #if CONFIG_X86_PAE
 		pmd = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-		set_pgd(pgd, __pgd(__pa(pmd) + 0x1));
+		set_pgd(pgd, __pgd(__pa(pmd) + _PAGE_PRESENT));
 #else
 		pmd = (pmd_t *)pgd;
 #endif
 		if (pmd != pmd_offset(pgd, 0))
 			BUG();
 		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
+			pgprot_t prot = PAGE_KERNEL;
 			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
 			if (end && (vaddr >= end))
 				break;
@@ -249,6 +261,9 @@ static void __init pagetable_init (void)
 				/* Make it "global" too if supported */
 				if (cpu_has_pge) {
 					set_in_cr4(X86_CR4_PGE);
+#ifdef CONFIG_4GB
+					if (vaddr >= TASK_SIZE)
+#endif
 					__pe += _PAGE_GLOBAL;
 				}
 				set_pmd(pmd, __pmd(__pe));
@@ -256,12 +271,15 @@ static void __init pagetable_init (void)
 			}
 
 			pte_base = pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-
+#ifdef CONFIG_4GB
+			if (vaddr >= TASK_SIZE)
+				prot = _MAKE_GLOBAL(pgprot_val(PAGE_KERNEL));
+#endif
 			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
 				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
 				if (end && (vaddr >= end))
 					break;
-				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
+				*pte = mk_pte_phys(__pa(vaddr), prot);
 			}
 			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte_base)));
 			if (pte_base != pte_offset(pmd, 0))
@@ -290,6 +308,64 @@ static void __init pagetable_init (void)
 	pkmap_page_table = pte;
 #endif
 
+#ifdef CONFIG_4GB
+	{
+		extern char __locore_lmabegin;
+		extern struct desc_struct idt_table[];
+		unsigned long page, vaddr, idx;
+		pgprot_t prot = PAGE_KERNEL;
+
+		/* map IDT */
+		set_pte_phys(IDT_START, __pa((unsigned long)idt_table),
+				_MAKE_GLOBAL(pgprot_val(prot)));
+
+		/* map in locore code */
+		page = (unsigned long)(&__locore_lmabegin) & PAGE_MASK;
+		vaddr = LOCORE_START;
+		for (idx = 0; idx < (LOCORE_SIZE/PAGE_SIZE); idx++) {
+			set_pte_phys(vaddr, __pa(page),
+					_MAKE_GLOBAL(pgprot_val(prot)));
+			page += PAGE_SIZE;
+			vaddr += PAGE_SIZE;
+		}
+
+		/* map in GDT */
+		page = ((unsigned long)gdt_table) & PAGE_MASK;
+		vaddr = GDTM_START;
+		for (idx = 0; idx < (GDT_SIZE)/PAGE_SIZE; idx++) {
+			set_pte_phys(vaddr, __pa(page),
+					_MAKE_GLOBAL(pgprot_val(prot)));
+			page += PAGE_SIZE;
+			vaddr += PAGE_SIZE;
+		}
+
+		/* map in TSS */
+		page = ((unsigned long)&init_tss) & PAGE_MASK;
+		vaddr = TSS_START;
+		for (idx = 0; idx < (TSS_SIZE)/PAGE_SIZE; idx++) {
+			set_pte_phys(vaddr, __pa(page),
+					_MAKE_GLOBAL(pgprot_val(prot)));
+			page += PAGE_SIZE;
+			vaddr += PAGE_SIZE;
+		}
+
+		/* map in default ldt at LDT_START */
+		set_pte_phys(LDT_START, __pa((unsigned long)&default_ldt),
+				_MAKE_GLOBAL(pgprot_val(prot)));
+
+		local_flush_tlb();
+
+		/* Switch to using the high mapped gdt */
+		gdt = (struct desc_struct *)(GDTM_START + 
+			((unsigned long)gdt_table & (~PAGE_MASK)));
+		__asm__ __volatile__ ("lgdt %0" : : "m" (gdt));
+
+		/* Switch to using the high mapped idt */
+		idt = (struct desc_struct *)IDT_START;
+		__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+	}
+#endif /* CONFIG_4GB */
+
 #if CONFIG_X86_PAE
 	/*
 	 * Add low memory identity-mappings - SMP needs it when
@@ -298,12 +374,35 @@ static void __init pagetable_init (void)
 	 * All user-space mappings are explicitly cleared after
 	 * SMP startup.
 	 */
+#ifdef CONFIG_4GB
+	vaddr = 0;
+
+	while (vaddr < PAGE_OFFSET) {
+		pmd_t *dpmd = pmd_offset(swapper_pg_dir + pgd_index(vaddr),
+					vaddr);
+		pmd_t *spmd = pmd_offset(swapper_pg_dir +
+						pgd_index(vaddr + PAGE_OFFSET),
+					(vaddr + PAGE_OFFSET));
+		set_pmd(dpmd, *spmd);
+		vaddr += PMD_SIZE;
+	}
+#else /* CONFIG_4GB */
 	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
+#endif /* CONFIG_4GB */
 #endif
 }
 
 void __init zap_low_mappings (void)
 {
+#ifdef CONFIG_4GB
+	unsigned long addr = 0;
+
+	while (addr < PAGE_OFFSET) {
+		pmd_t *pmd = pmd_offset(swapper_pg_dir+pgd_index(addr), addr);
+		set_pmd(pmd, __pmd(0));
+		addr += 1<<PMD_SHIFT;
+	}
+#else /* CONFIG_4GB */
 	int i;
 	/*
 	 * Zap initial low-memory mappings.
@@ -317,6 +416,7 @@ void __init zap_low_mappings (void)
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif
+#endif /* CONFIG_4GB */
 	flush_tlb_all();
 }
 
--- ./arch/i386/lib/checksum.S.4gb	2002-11-29 02:53:09.000000000 +0300
+++ ./arch/i386/lib/checksum.S	2004-09-09 17:02:08.000000000 +0400
@@ -251,6 +251,7 @@ csum_partial:
 				
 #endif
 
+#ifndef CONFIG_4GB
 /*
 unsigned int csum_partial_copy_generic (const char *src, char *dst,
 				  int len, int sum, int *src_err_ptr, int *dst_err_ptr)
@@ -494,3 +495,4 @@ DST(	movb %dl, (%edi)         )
 #undef ROUND1		
 		
 #endif
+#endif /* !CONFIG_4GB */
--- ./arch/i386/lib/getuser.S.4gb	1998-01-13 00:42:52.000000000 +0300
+++ ./arch/i386/lib/getuser.S	2004-09-09 17:02:08.000000000 +0400
@@ -9,6 +9,10 @@
  * return value.
  */
 
+#include <linux/config.h>
+
+#ifndef CONFIG_4GB
+
 /*
  * __get_user_X
  *
@@ -71,3 +75,5 @@ bad_get_user:
 	.long 2b,bad_get_user
 	.long 3b,bad_get_user
 .previous
+
+#endif /* !CONFIG_4GB */
--- ./arch/i386/lib/old-checksum.c.4gb	1998-12-27 21:32:09.000000000 +0300
+++ ./arch/i386/lib/old-checksum.c	2004-09-09 17:02:08.000000000 +0400
@@ -2,6 +2,7 @@
  * FIXME: old compatibility stuff, will be removed soon.
  */
 
+#include <linux/config.h>
 #include <net/checksum.h>
 
 unsigned int csum_partial_copy( const char *src, char *dst, int len, int sum)
@@ -16,4 +17,39 @@ unsigned int csum_partial_copy( const ch
 	return sum;
 }
 
+#ifdef CONFIG_4GB
+unsigned int
+csum_partial_copy_generic( const char *src, char *dst, int len, int sum,
+	int *src_err_ptr, int *dst_err_ptr)
+{
+	if ((!src_err_ptr) && (!dst_err_ptr)) {
+		/* csum_partial_copy_nocheck case */
+		sum = csum_partial(src, len, sum);
+		memcpy(dst, src, len);
+		return sum;
+	} else if ((src_err_ptr) && (!dst_err_ptr)) {
+		/* csum_partial_copy_from_user */
+		/* copied from mips code */
+		int missing = copy_from_user(dst, src, len);
+		if (missing) {
+			memset(dst + len - missing, 0, missing);
+			*src_err_ptr = -EFAULT;
+		}
+		return csum_partial(dst, len, sum);
+	} else if ((!src_err_ptr) && (dst_err_ptr)) {
+		/* csum_and_copy_to_user */
+		/* csum_partial_copy_to_user */
+		/* copied from mips code */
+		sum = csum_partial(src, len, sum);
+		if (copy_to_user(dst, src, len))
+			*dst_err_ptr = -EFAULT;
+		return sum;
+	} else {
+		/* csum_partial_copy case */
+		sum = csum_partial(src, len, sum);
+		memcpy(dst, src, len);
+		return sum;
+	}
+}
+#endif /* CONFIG_4GB */
 
--- ./arch/i386/lib/usercopy.c.4gb	2003-06-13 18:51:29.000000000 +0400
+++ ./arch/i386/lib/usercopy.c	2004-09-09 17:08:30.000000000 +0400
@@ -6,8 +6,12 @@
  * Copyright 1997 Linus Torvalds
  */
 #include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
+#include <asm/pgtable.h>
 
 #ifdef CONFIG_X86_USE_3DNOW_AND_WORKS
 
@@ -116,7 +120,7 @@ do {									   \
  * and returns @count.
  */
 long
-__strncpy_from_user(char *dst, const char *src, long count)
+__direct_strncpy_from_user(char *dst, const char *src, long count)
 {
 	long res;
 	__do_strncpy_from_user(dst, src, count, res);
@@ -142,7 +146,7 @@ __strncpy_from_user(char *dst, const cha
  * and returns @count.
  */
 long
-strncpy_from_user(char *dst, const char *src, long count)
+direct_strncpy_from_user(char *dst, const char *src, long count)
 {
 	long res = -EFAULT;
 	if (access_ok(VERIFY_READ, src, 1))
@@ -187,7 +191,7 @@ do {									\
  * On success, this will be zero.
  */
 unsigned long
-clear_user(void *to, unsigned long n)
+direct_clear_user(void *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
 		__do_clear_user(to, n);
@@ -206,7 +210,7 @@ clear_user(void *to, unsigned long n)
  * On success, this will be zero.
  */
 unsigned long
-__clear_user(void *to, unsigned long n)
+__direct_clear_user(void *to, unsigned long n)
 {
 	__do_clear_user(to, n);
 	return n;
@@ -223,7 +227,7 @@ __clear_user(void *to, unsigned long n)
  * On exception, returns 0.
  * If the string is too long, returns a value greater than @n.
  */
-long strnlen_user(const char *s, long n)
+long direct_strnlen_user(const char *s, long n)
 {
 	unsigned long mask = -__addr_ok(s);
 	unsigned long res, tmp;
@@ -252,3 +256,231 @@ long strnlen_user(const char *s, long n)
 		:"cc");
 	return res & mask;
 }
+
+/*
+ * (C) Copyright 2003 Ingo Molnar
+ *
+ * Generic implementation of all the user-VM access functions, without
+ * relying on being able to access the VM directly.
+ * These functions are prefixed with 'indirect'
+ */
+
+/*
+ * Get kernel address of the user page and pin it.
+ */
+static inline struct page *pin_page(unsigned long addr, int write)
+{
+	struct mm_struct *mm = current->mm ? : &init_mm;
+	struct page *page = NULL;
+	int ret;
+
+	spin_lock(&mm->page_table_lock);
+	/*
+	 * Do a quick atomic lookup first - this is the fastpath.
+	 */
+	page = follow_page(mm, addr, write);
+	if (likely(page != NULL)) {	
+		if (!PageReserved(page))
+			page_cache_get(page);
+		spin_unlock(&mm->page_table_lock);
+		return page;
+	}
+
+	/*
+	 * No luck - bad address or need to fault in the page:
+	 */
+	spin_unlock(&mm->page_table_lock);
+
+	down_read(&mm->mmap_sem);
+	ret = get_user_pages(current, mm, addr, 1, write, 0, &page, NULL);
+	up_read(&mm->mmap_sem);
+	if (ret <= 0)
+		return NULL;
+	return page;
+}
+
+static inline void unpin_page(struct page *page)
+{
+	page_cache_release(page);
+}
+
+/*
+ * Access another process' address space.
+ * Source/target buffer must be kernel space, 
+ * Do not walk the page table directly, use get_user_pages
+ */
+static int rw_vm(unsigned long addr, void *buf, int len, int write)
+{
+	if (!len)
+		return 0;
+
+	/* ignore errors, just check how much was sucessfully transfered */
+	while (len) {
+		struct page *page;
+		int bytes, offset;
+		void *maddr;
+
+		page = pin_page(addr, write);
+		if (!page)
+			break;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE-1);
+		if (bytes > PAGE_SIZE-offset)
+			bytes = PAGE_SIZE-offset;
+
+		maddr = kmap_atomic(page, KM_USER_COPY);
+
+#define HANDLE_TYPE(type) \
+	case sizeof(type): *(type *)(maddr+offset) = *(type *)(buf); break;
+
+		if (write) {
+			switch (bytes) {
+			HANDLE_TYPE(char);
+			HANDLE_TYPE(int);
+			HANDLE_TYPE(long long);
+			default:
+				memcpy(maddr + offset, buf, bytes);
+			}
+		} else {
+#undef HANDLE_TYPE
+#define HANDLE_TYPE(type) \
+	case sizeof(type): *(type *)(buf) = *(type *)(maddr+offset); break;
+			switch (bytes) {
+			HANDLE_TYPE(char);
+			HANDLE_TYPE(int);
+			HANDLE_TYPE(long long);
+			default:
+				memcpy(buf, maddr + offset, bytes);
+			}
+#undef HANDLE_TYPE
+		}
+		kunmap_atomic(maddr, KM_USER_COPY);
+		unpin_page(page);
+		len -= bytes;
+		buf += bytes;
+		addr += bytes;
+	}
+
+	return len;
+}
+
+static int str_vm(unsigned long addr, void *buf, int len, int copy)
+{
+	if (!len)
+		return len;
+
+	/* ignore errors, just check how much was sucessfully transfered */
+	while (len) {
+		struct page *page;
+		int bytes, offset, left, copied;
+		char *maddr;
+
+		page = pin_page(addr, copy == 2);
+		if (!page)
+			return -EFAULT;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE-1);
+		if (bytes > PAGE_SIZE-offset)
+			bytes = PAGE_SIZE-offset;
+
+		maddr = kmap_atomic(page, KM_USER_COPY);
+		if (copy == 2) {
+			memset(maddr + offset, 0, bytes);
+			copied = bytes;
+			left = 0;
+		} else if (copy == 1) {
+			/* strncpy_count returns (bytes-strlen(source str)) */
+			left = strncpy_count(buf, maddr + offset, bytes);
+			copied = bytes - left;
+		} else {
+			/* strnlen returns length w/o leading 0 */
+			copied = strnlen(maddr + offset, bytes);
+			left = bytes - copied;
+		}
+		BUG_ON(bytes < 0 || copied < 0);
+		kunmap_atomic(maddr, KM_USER_COPY);
+		unpin_page(page);
+		len -= copied;
+		buf += copied;
+		addr += copied;
+		if (left)
+			break;
+	}
+
+	return len;
+}
+
+/*
+ * Copies memory from userspace (ptr) into kernelspace (val).
+ *
+ * returns # of bytes not copied.
+ */
+int indirect_get_user_size(unsigned int size, void *val, const void *ptr)
+{
+	int ret;
+
+	if (unlikely(segment_eq(get_fs(), KERNEL_DS)))
+		return direct_copy_from_user(val, ptr, size);
+	ret = rw_vm((unsigned long)ptr, val, size, 0);
+	/* Zero the rest */
+	if (ret)
+		memset(val + size - ret, 0, ret);
+	return ret;
+}
+
+/*
+ * Copies memory from kernelspace (val) into userspace (ptr).
+ *
+ * returns # of bytes not copied.
+ */
+int indirect_put_user_size(unsigned int size, const void *val, void *ptr)
+{
+	if (unlikely(segment_eq(get_fs(), KERNEL_DS)))
+		return direct_copy_to_user(ptr, val, size);
+	return rw_vm((unsigned long)ptr, (void *)val, size, 1);
+}
+
+int indirect_strncpy_from_user_size(unsigned int size, void *val,
+		const void *ptr)
+{
+	int copied, left;
+
+	if (unlikely(segment_eq(get_fs(), KERNEL_DS)))
+		return direct_strncpy_from_user(val, ptr, size);
+	left = str_vm((unsigned long)ptr, val, size, 1);
+	if (left < 0)
+		return left;
+	copied = size - left;
+	BUG_ON(copied < 0);
+
+	return copied;
+}
+
+int indirect_strnlen_user_size(unsigned int size, const void *ptr)
+{
+	int copied, left;
+
+	if (unlikely(segment_eq(get_fs(), KERNEL_DS)))
+		return direct_strnlen_user(ptr, size);
+	left = str_vm((unsigned long)ptr, NULL, size, 0);
+	if (left < 0)
+		return 0;
+	copied = size - left + 1;
+	BUG_ON(copied < 0);
+
+	return copied;
+}
+
+int indirect_clear_user_size(unsigned int size, void *ptr)
+{
+	int left;
+
+	if (unlikely(segment_eq(get_fs(), KERNEL_DS)))
+		return direct_clear_user(ptr, size);
+	left = str_vm((unsigned long)ptr, NULL, size, 2);
+	if (left < 0)
+		return size;
+	return left;
+}
--- ./arch/i386/kernel/entry.S.4gb	2003-06-13 18:51:29.000000000 +0400
+++ ./arch/i386/kernel/entry.S	2004-09-09 17:02:08.000000000 +0400
@@ -45,6 +45,9 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/smp.h>
+#include <asm/offset.h>
+#include <asm/page.h>
+#include <asm/desc.h>
 
 EBX		= 0x00
 ECX		= 0x04
@@ -84,6 +87,184 @@ processor	= 52
 ENOSYS = 38
 
 
+#ifdef CONFIG_4GB
+
+/*
+ * The main idea of 4GB split is to switch to kernel context when entering
+ * in kernel, and switch back to user pgdir when returning to user space.
+ *
+ * The main problem here is the fact, that cr3 + esp reloading is not an atomic
+ * operation. This is solved by mapping task struct at the same high addresses
+ * in kernel pgdir as in user pgdir. So that when cr3 is reloaded,
+ * esp still points to valid stack.
+ *
+ * We must be careful here and guarentee that no task switch can occur
+ * in situations when cr3 is reloaded to kernel one, but esp points to
+ * high mapped stack. This guarentee is ret_from_exception function, where
+ * switch can occur only if we are going to return to user mode
+ * (and we couldn't interrupt cr3/esp reload sequence).
+ */
+
+/*
+ * LOAD_USER_ESP
+ * loads user esp = (esp - kernel_task_struct) + user_task_struct
+ *
+ * input:	%esp
+ * output:	%ebx = current, %esp = user stack
+ * modifies:	%ecx, %ebx, %esp
+ */
+#define LOAD_USER_ESP			\
+	movl %esp, %ecx;		\
+	movl $-8192, %ebx;		\
+	andl %ecx, %ebx;		\
+	subl %ebx, %ecx;		\
+	movl TASK_THREAD_UTASK(%ebx),%ebx;\
+	addl %ebx, %ecx;\
+	movl %ecx, %esp;
+
+/*
+ * LOAD_CURRENT_AND_ESP
+ * loads current stack pointer and pointer to current task_struct
+ *
+ * input:	%esp
+ * output:	%ecx = %esp, %ebx = current
+ * modifies:	%ecx, %ebx
+ */
+#define LOAD_CURRENT_AND_ESP		\
+	movl %esp, %ecx;		\
+	movl $-8192, %ebx;		\
+	andl %ecx, %ebx;
+
+/*
+ * LOAD_KERNEL_ESP
+ * loads kernel esp = (esp - user_task_struct) + kernel_task_struct
+ *
+ * input:	%ebx = current, %ecx = %esp = user stack
+ * output:	%ebx = kernel current, %ecx = %esp = kernel stack 
+ * modifies:	%ebx, %ecx, %esp
+ */
+#define LOAD_KERNEL_ESP			\
+	subl %ebx, %ecx;		\
+	movl TASK_THREAD_KTASK(%ebx), %ebx; \
+	addl %ebx, %ecx;		\
+	movl %ecx, %esp;		\
+	/* ebx = current, ecx = %esp */
+
+/*
+ * LOAD_KPDBR
+ * sets cr3(PDBR) to kernel swapper_pg_dir
+ *
+ * modifies:	%edx, %cr3
+ */
+#define LOAD_KPDBR			\
+	movl $swapper_pg_dir-__PAGE_OFFSET,%edx; \
+	movl %edx,%cr3;
+
+/*
+ * LOAD_UPDBR
+ * sets cr3(PDBR) to user pgdir
+ *
+ * input:	%ebx = current
+ * modifies:	%ecx, %cr3
+ */
+#define LOAD_UPDBR			\
+	movl TASK_THREAD_CR3(%ebx), %ecx;\
+	movl %ecx, %cr3;
+
+#define SPLIT_4GB_SAVEREGS		\
+	pushl %ecx;			\
+	pushl %ebx;			\
+	pushl %ds;			\
+	movl $(__KERNEL_DS),%ebx;	\
+	movl %ebx,%ds;
+
+#define SPLIT_4GB_RESTREGS		\
+	popl %ds;			\
+	popl %ebx;			\
+	popl %ecx;
+
+#define LOAD_DEBUGREGS			\
+	cmpl $0, TASK_THREAD_RELOADDBG(%ebx); \
+	jz 2f;				\
+	movl $0, TASK_THREAD_RELOADDBG(%ebx); \
+	movl (TASK_THREAD_DEBUGREG0+7*4)(%ebx), %eax; \
+	movl %eax, %db7;		\
+2:
+
+/*
+ * SPLIT_4GB_PREAMBLE
+ * switches to kernel space if not already there
+ * Note: esp, cr3 reload is not atomic, but their
+ *	reload sequence helps us to handle
+ *	it's interruption properly.
+ *
+ * input:
+ * output:	%ebx = kernel_current, %esp = kernel_esp
+ * modifies:	%edx, %ebx, %ecx, %esp, %cr3
+ */
+#define SPLIT_4GB_PREAMBLE		\
+	LOAD_CURRENT_AND_ESP		\
+	cmpl $SPLIT_4GB_MAP_START, %ecx; \
+	jb 1f;				\
+	LOAD_KPDBR			\
+	LOAD_KERNEL_ESP			\
+1:	/* ebx = current, ecx = %esp */
+
+/*
+ * SPLIT_4GB_EPILOGUE
+ * loads user esp and cr3 if returning to user space
+ * Note: esp, cr3 reload is not atomic, cli is required,
+ * 	but NMI still can happening (see nmi ISR)
+ *
+ * input:
+ * modifies:	%ebx, %ecx, %esp, %cr3
+ */
+#define SPLIT_4GB_EPILOGUE		\
+	/* mix EFLAGS and CS */		\
+	movl EFLAGS(%esp),%ebx;		\
+	movb CS(%esp),%bl;		\
+	/* return to VM86 mode or non-supervisor? */ \
+	testl $(VM_MASK | 3),%ebx;	\
+	jz 1f;				\
+	cli;				\
+	LOAD_USER_ESP			\
+	LOAD_UPDBR			\
+	LOAD_DEBUGREGS			\
+1:
+
+/*
+ * SPLIT_4GB_FIXUP
+ * loads user esp and cr3 when GPF fixup executed.
+ * This can happen only when GPF during RESTORE_ALL
+ * happens. Forces switching to user space.
+ *
+ * modifies:	none
+ */
+#define SPLIT_4GB_FIXUP			\
+	SPLIT_4GB_SAVEREGS		\
+	cli;				\
+	LOAD_USER_ESP			\
+	LOAD_UPDBR			\
+	SPLIT_4GB_RESTREGS
+
+#define FIXUP_SECTION
+#define SPLIT_4GB_FIXUP_SECTION		\
+	.section .fixup,"ax";
+
+#else /* CONFIG_4GB */
+
+#define SPLIT_4GB_PREAMBLE
+#define SPLIT_4GB_EPILOGUE
+#define SPLIT_4GB_SAVEREGS
+#define SPLIT_4GB_RESTREGS
+#define SPLIT_4GB_GPPREAMBLE
+#define SPLIT_4GB_FIXUP
+#define SPLIT_4GB_FIXUP_SECTION
+#define FIXUP_SECTION			\
+	.section .fixup,"ax";
+
+#endif /* CONFIG_4GB */
+
 #define SAVE_ALL \
 	cld; \
 	pushl %es; \
@@ -111,11 +292,14 @@ ENOSYS = 38
 2:	popl %es;	\
 	addl $4,%esp;	\
 3:	iret;		\
-.section .fixup,"ax";	\
-4:	movl $0,(%esp);	\
+FIXUP_SECTION		\
+4:	SPLIT_4GB_FIXUP	\
+	movl $0,(%esp);	\
 	jmp 1b;		\
-5:	movl $0,(%esp);	\
+5:	SPLIT_4GB_FIXUP	\
+	movl $0,(%esp);	\
 	jmp 2b;		\
+SPLIT_4GB_FIXUP_SECTION	\
 6:	pushl %ss;	\
 	popl %ds;	\
 	pushl %ss;	\
@@ -134,6 +318,13 @@ ENOSYS = 38
 	movl $-8192, reg; \
 	andl %esp, reg
 
+#ifdef CONFIG_4GB
+/*
+ * for 4GB split interrupts/exception code is mapped at high addresses
+ */
+.section .locore,"ax"
+#endif
+
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call gates,
 	pushl %eax		# which has to be cleaned up later..
@@ -150,6 +341,7 @@ ENTRY(lcall7)
 	movl %esp,%ebx
 	pushl %ebx
 	andl $-8192,%ebx	# GET_CURRENT
+	SPLIT_4GB_PREAMBLE
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -174,6 +366,7 @@ ENTRY(lcall27)
 	movl %esp,%ebx
 	pushl %ebx
 	andl $-8192,%ebx	# GET_CURRENT
+	SPLIT_4GB_PREAMBLE
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
@@ -202,7 +395,11 @@ ENTRY(ret_from_fork)
 ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
+#ifdef CONFIG_4GB
+	SPLIT_4GB_PREAMBLE		# GET_CURRENT(%ebx) inside
+#else
 	GET_CURRENT(%ebx)
+#endif
 	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
 	jne tracesys
 	cmpl $(NR_syscalls),%eax
@@ -216,6 +413,7 @@ ENTRY(ret_from_sys_call)
 	cmpl $0,sigpending(%ebx)
 	jne signal_return
 restore_all:
+	SPLIT_4GB_EPILOGUE
 	RESTORE_ALL
 
 	ALIGN
@@ -288,13 +486,19 @@ error_code:
 	movl ES(%esp), %edi		# get the function address
 	movl %eax, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
-	movl %esp,%edx
-	pushl %esi			# push the error code
-	pushl %edx			# push the pt_regs pointer
+
 	movl $(__KERNEL_DS),%edx
 	movl %edx,%ds
 	movl %edx,%es
+#ifdef CONFIG_4GB
+	SPLIT_4GB_PREAMBLE		# requires ds, GET_CURRENT(%ebx) inside
+#else
 	GET_CURRENT(%ebx)
+#endif
+
+	movl %esp,%edx
+	pushl %esi			# push the error code
+	pushl %edx			# push the pt_regs pointer
 	call *%edi
 	addl $8,%esp
 	jmp ret_from_exception
@@ -312,7 +516,11 @@ ENTRY(simd_coprocessor_error)
 ENTRY(device_not_available)
 	pushl $-1		# mark this as an int
 	SAVE_ALL
+#ifdef CONFIG_4GB
+	SPLIT_4GB_PREAMBLE		# GET_CURRENT(%ebx) inside
+#else
 	GET_CURRENT(%ebx)
+#endif
 	movl %cr0,%eax
 	testl $0x4,%eax			# EM (math emulation bit)
 	jne device_not_available_emulate
@@ -332,11 +540,41 @@ ENTRY(debug)
 ENTRY(nmi)
 	pushl %eax
 	SAVE_ALL
+
+#ifdef CONFIG_4GB
+/*
+ * NMI can be called when ints are masked and though we can be in kernel
+ * cr3 may still point to user space pgdir (e.g. we only entered the syscall).
+ * So we check esp here which is a flag whether we are totally in kernel or not.
+ * We could omit esp reloading for speedup, but to be unnoticable at all we do
+ * reload both esp and cr3 anyway...
+ */
+	# switch to kernel
+	movl %esp, %edi
+	movl %cr3, %esi
+	SPLIT_4GB_PREAMBLE
+#endif
 	movl %esp,%edx
+
+#if CONFIG_4GB
+	pushl %esi	# cr3
+	pushl %edi	# esp
+#endif
 	pushl $0
 	pushl %edx
 	call SYMBOL_NAME(do_nmi)
 	addl $8,%esp
+
+#ifdef CONFIG_4GB
+	# switch to user
+	popl %eax	# esp
+	popl %ebx	# cr3
+	cmpl $SPLIT_4GB_MAP_START, %eax
+	jb 2f
+	movl %eax, %esp
+	movl %ebx, %cr3
+2:
+#endif
 	RESTORE_ALL
 
 ENTRY(int3)
@@ -402,6 +640,22 @@ ENTRY(spurious_interrupt_bug)
 	pushl $ SYMBOL_NAME(do_spurious_interrupt_bug)
 	jmp error_code
 
+#ifdef CONFIG_4GB
+/* This is the default interrupt "handler" :-) */
+int_msg:
+	.asciz "Unknown interrupt\n"
+	ALIGN
+ENTRY(ignore_int)
+	pushl $0
+	SAVE_ALL
+	SPLIT_4GB_PREAMBLE		# GET_CURRENT(%ebx) inside
+	pushl $int_msg
+	call SYMBOL_NAME(printk)
+	popl %eax
+	SPLIT_4GB_EPILOGUE
+	RESTORE_ALL
+#endif
+
 .data
 ENTRY(sys_call_table)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 0  -  old "setup()" system call*/
--- ./arch/i386/kernel/head.S.4gb	2003-11-28 21:26:19.000000000 +0300
+++ ./arch/i386/kernel/head.S	2004-09-09 17:02:08.000000000 +0400
@@ -323,6 +323,7 @@ ENTRY(stack_start)
 	.long SYMBOL_NAME(init_task_union)+8192
 	.long __KERNEL_DS
 
+#ifndef CONFIG_4GB
 /* This is the default interrupt "handler" :-) */
 int_msg:
 	.asciz "Unknown interrupt\n"
@@ -346,6 +347,7 @@ ignore_int:
 	popl %ecx
 	popl %eax
 	iret
+#endif
 
 /*
  * The interrupt descriptor table has room for 256 idt's,
@@ -421,6 +423,11 @@ ENTRY(_stext)
  */
 .data
 
+#ifdef CONFIG_4GB
+/* align on page boundary to be sure that gdt will fit to one page */
+.section .data.gdt, "aw"
+#endif
+
 ALIGN
 /*
  * This contains typically 140 quadwords, depending on NR_CPUS.
--- ./arch/i386/kernel/i386_ksyms.c.4gb	2004-04-14 17:05:25.000000000 +0400
+++ ./arch/i386/kernel/i386_ksyms.c	2004-09-09 17:02:08.000000000 +0400
@@ -92,21 +92,29 @@ EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);
 
+#ifndef CONFIG_4GB
 EXPORT_SYMBOL_NOVERS(__get_user_1);
 EXPORT_SYMBOL_NOVERS(__get_user_2);
 EXPORT_SYMBOL_NOVERS(__get_user_4);
+#endif
 
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
-EXPORT_SYMBOL(strncpy_from_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(clear_user);
-EXPORT_SYMBOL(__clear_user);
+EXPORT_SYMBOL(direct_strncpy_from_user);
+EXPORT_SYMBOL(__direct_strncpy_from_user);
+EXPORT_SYMBOL(direct_clear_user);
+EXPORT_SYMBOL(__direct_clear_user);
 EXPORT_SYMBOL(__generic_copy_from_user);
 EXPORT_SYMBOL(__generic_copy_to_user);
-EXPORT_SYMBOL(strnlen_user);
+EXPORT_SYMBOL(direct_strnlen_user);
+
+EXPORT_SYMBOL(indirect_get_user_size);
+EXPORT_SYMBOL(indirect_put_user_size);
+EXPORT_SYMBOL(indirect_clear_user_size);
+EXPORT_SYMBOL(indirect_strncpy_from_user_size);
+EXPORT_SYMBOL(indirect_strnlen_user_size);
 
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
--- ./arch/i386/kernel/i387.c.4gb	2003-08-25 15:44:39.000000000 +0400
+++ ./arch/i386/kernel/i387.c	2004-09-09 17:02:08.000000000 +0400
@@ -251,6 +251,7 @@ void set_fpu_mxcsr( struct task_struct *
 static inline int convert_fxsr_to_user( struct _fpstate *buf,
 					struct i387_fxsave_struct *fxsave )
 {
+	struct _fpreg tmp[8];		/* temporary storage */
 	unsigned long env[7];
 	struct _fpreg *to;
 	struct _fpxreg *from;
@@ -267,18 +268,25 @@ static inline int convert_fxsr_to_user( 
 	if ( __copy_to_user( buf, env, 7 * sizeof(unsigned long) ) )
 		return 1;
 
-	to = &buf->_st[0];
+	to = tmp;
 	from = (struct _fpxreg *) &fxsave->st_space[0];
 	for ( i = 0 ; i < 8 ; i++, to++, from++ ) {
-		if ( __copy_to_user( to, from, sizeof(*to) ) )
-			return 1;
+		unsigned long *t = (unsigned long *)to;
+		unsigned long *f = (unsigned long *)from;
+
+		*t = *f;
+		*(t+1) = *(f+1);
+		to->exponent = from->exponent;
 	}
+	if (copy_to_user(buf->_st, tmp, sizeof(tmp)))
+		return 1;
 	return 0;
 }
 
 static inline int convert_fxsr_from_user( struct i387_fxsave_struct *fxsave,
 					  struct _fpstate *buf )
 {
+	struct _fpreg tmp[8];		/* temporary storage */
 	unsigned long env[7];
 	struct _fpxreg *to;
 	struct _fpreg *from;
@@ -286,6 +294,8 @@ static inline int convert_fxsr_from_user
 
 	if ( __copy_from_user( env, buf, 7 * sizeof(long) ) )
 		return 1;
+	if (copy_from_user(tmp, buf->_st, sizeof(struct _fpreg [8])))
+		return 1;
 
 	fxsave->cwd = (unsigned short)(env[0] & 0xffff);
 	fxsave->swd = (unsigned short)(env[1] & 0xffff);
@@ -297,10 +307,14 @@ static inline int convert_fxsr_from_user
 	fxsave->fos = env[6];
 
 	to = (struct _fpxreg *) &fxsave->st_space[0];
-	from = &buf->_st[0];
+	from = tmp;
 	for ( i = 0 ; i < 8 ; i++, to++, from++ ) {
-		if ( __copy_from_user( to, from, sizeof(*from) ) )
-			return 1;
+		unsigned long *t = (unsigned long *)to;
+		unsigned long *f = (unsigned long *)from;
+
+		*t = *f;
+		*(t+1) = *(f+1);
+		to->exponent = from->exponent;
 	}
 	return 0;
 }
--- ./arch/i386/kernel/i8259.c.4gb	2004-08-08 03:26:04.000000000 +0400
+++ ./arch/i386/kernel/i8259.c	2004-09-09 17:02:08.000000000 +0400
@@ -22,6 +22,7 @@
 #include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/apic.h>
+#include <asm/offset.h>
 
 #include <linux/irq.h>
 
--- ./arch/i386/kernel/init_task.c.4gb	2001-09-18 02:29:09.000000000 +0400
+++ ./arch/i386/kernel/init_task.c	2004-09-09 17:02:08.000000000 +0400
@@ -29,5 +29,11 @@ union task_union init_task_union 
  * section. Since TSS's are completely CPU-local, we want them
  * on exact cacheline boundaries, to eliminate cacheline ping-pong.
  */ 
-struct tss_struct init_tss[NR_CPUS] __cacheline_aligned = { [0 ... NR_CPUS-1] = INIT_TSS };
+struct tss_struct init_tss[NR_CPUS] 
+#ifdef CONFIG_4GB
+	__attribute__((__section__(".data.tss")))
+#else
+	__cacheline_aligned
+#endif
+	= { [0 ... NR_CPUS-1] = INIT_TSS };
 
--- ./arch/i386/kernel/ldt.c.4gb	2004-02-18 16:36:30.000000000 +0300
+++ ./arch/i386/kernel/ldt.c	2004-09-09 19:24:15.000000000 +0400
@@ -5,6 +5,7 @@
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
  */
 
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/string.h>
@@ -37,10 +38,14 @@ static int alloc_ldt(mm_context_t *pc, i
 		return 0;
 	oldsize = pc->size;
 	mincount = (mincount+511)&(~511);
+#ifdef CONFIG_4GB
+	newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
+#else
 	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
 		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
 	else
 		newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
+#endif
 
 	if (!newldt)
 		return -ENOMEM;
@@ -62,10 +67,14 @@ static int alloc_ldt(mm_context_t *pc, i
 	}
 	wmb();
 	if (oldsize) {
+#ifdef CONFIG_4GB
+		vfree(oldldt);
+#else
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
 			vfree(oldldt);
 		else
 			kfree(oldldt);
+#endif
 	}
 	return 0;
 }
@@ -110,10 +119,14 @@ int init_new_context(struct task_struct 
 void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context.size) {
+#ifdef CONFIG_4GB
+		vfree(mm->context.ldt);
+#else
 		if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
 			vfree(mm->context.ldt);
 		else
 			kfree(mm->context.ldt);
+#endif
 		mm->context.size = 0;
 	}
 }
--- ./arch/i386/kernel/process.c.4gb	2004-02-18 16:36:30.000000000 +0300
+++ ./arch/i386/kernel/process.c	2004-09-09 17:02:08.000000000 +0400
@@ -302,8 +302,31 @@ void machine_real_restart(unsigned char 
 	   from the kernel segment.  This assumes the kernel segment starts at
 	   virtual address PAGE_OFFSET. */
 
+#ifndef CONFIG_4GB
 	memcpy (swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
 		sizeof (swapper_pg_dir [0]) * KERNEL_PGD_PTRS);
+#else
+	{
+		unsigned long saddr = PAGE_OFFSET, daddr = 0;
+		int pmds = PAGE_OFFSET >> PMD_SHIFT;
+		pgd_t *spgd, *dpgd;
+		pmd_t *spmd, *dpmd;
+
+		while (pmds > 0) {
+			spgd = pgd_offset_k(saddr);
+			spmd = pmd_offset(spgd, saddr);
+			
+			dpgd = pgd_offset_k(daddr);
+			dpmd = pmd_offset(dpgd, daddr);
+			
+			pmd_val(*dpmd) = pmd_val(*spmd);
+
+			saddr += PAGE_SIZE;
+			daddr += PAGE_SIZE;
+			pmds--;
+		}
+	}
+#endif
 
 	/* Make sure the first page is mapped to the start of physical memory.
 	   It is normally not mapped, to trap kernel NULL pointer dereferences. */
@@ -475,6 +498,48 @@ void show_regs(struct pt_regs * regs)
 	show_trace(&regs->esp);
 }
 
+#ifdef CONFIG_4GB
+static inline void map_task_struct(struct task_struct *tsk)
+{
+	struct tss_struct *tss = init_tss + smp_processor_id();
+	unsigned long task_addr;
+	pte_t *pte;
+
+	if (!tsk->mm) {
+		tsk->thread.cr3 = __pa(init_mm.pgd);
+		tsk->thread.utask = (unsigned long)tsk;
+		tsk->thread.esp0 = (unsigned long)tsk + THREAD_SIZE;
+		return;
+	}
+
+	task_addr = LOTASK_START +
+		(THREAD_SIZE + LOTASK_BARRIER)*smp_processor_id();
+
+	/* we map current task struct both to user and kernel contexts here */
+	pte = pte_offset(pmd_offset(pgd_offset_k(task_addr), task_addr),
+			task_addr);
+	set_pte(pte, mk_pte_phys(__pa((unsigned long)(tsk)), PAGE_KERNEL));
+	pte++; /* we know that ptes are on the same page */
+	set_pte(pte, mk_pte_phys(__pa((unsigned long)tsk + PAGE_SIZE),
+				PAGE_KERNEL));
+
+#ifdef CONFIG_X86_INVLPG
+	__flush_tlb_one(task_addr);
+	__flush_tlb_one(task_addr+PAGE_SIZE);
+#else
+	local_flush_tlb();
+#endif
+	if (tsk->thread.saved_esp0)
+		/* VM86 mode */
+		tss->esp0 = tsk->thread.esp0 = task_addr +
+				(tsk->thread.esp0 & (THREAD_SIZE-1));
+	else
+		tss->esp0 = tsk->thread.esp0 = task_addr + THREAD_SIZE;
+	tsk->thread.utask = task_addr;
+	tsk->thread.cr3 = __pa(tsk->mm->pgd);
+}
+#endif
+
 /*
  * Create a kernel thread
  */
@@ -523,6 +588,9 @@ void flush_thread(void)
 	 */
 	clear_fpu(tsk);
 	tsk->used_math = 0;
+#ifdef CONFIG_4GB
+	map_task_struct(current);
+#endif
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -558,7 +626,11 @@ int copy_thread(int nr, unsigned long cl
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
+#ifdef CONFIG_4GB
+	p->thread.ktask = (unsigned long)p;
+#else /* CONFIG_4GB */
 	p->thread.esp0 = (unsigned long) (childregs+1);
+#endif
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 
@@ -650,6 +722,9 @@ void __switch_to(struct task_struct *pre
 				 *next = &next_p->thread;
 	struct tss_struct *tss = init_tss + smp_processor_id();
 
+#ifdef CONFIG_4GB
+	map_task_struct(next_p);
+#endif
 	unlazy_fpu(prev_p);
 
 	/*
@@ -673,6 +748,9 @@ void __switch_to(struct task_struct *pre
 	/*
 	 * Now maybe reload the debug registers
 	 */
+#ifdef CONFIG_4GB
+	next->reloaddbg = 0;
+#endif
 	if (next->debugreg[7]){
 		loaddebug(next, 0);
 		loaddebug(next, 1);
--- ./arch/i386/kernel/ptrace.c.4gb	2002-08-03 04:39:42.000000000 +0400
+++ ./arch/i386/kernel/ptrace.c	2004-09-09 17:02:08.000000000 +0400
@@ -48,7 +48,13 @@ static inline int get_stack_long(struct 
 {
 	unsigned char *stack;
 
+#ifdef CONFIG_4GB
+	/* esp0 points to U-space mapped stack, stack=addr in K-space */
+	stack = (unsigned char *)task +
+		(task->thread.esp0 - task->thread.utask);
+#else
 	stack = (unsigned char *)task->thread.esp0;
+#endif
 	stack += offset;
 	return (*((int *)stack));
 }
@@ -64,7 +70,13 @@ static inline int put_stack_long(struct 
 {
 	unsigned char * stack;
 
+#ifdef CONFIG_4GB
+	/* esp0 points to U-space mapped stack, stack=addr in K-space */
+	stack = (unsigned char *)task +
+		(task->thread.esp0 - task->thread.utask);
+#else
 	stack = (unsigned char *) task->thread.esp0;
+#endif
 	stack += offset;
 	*(unsigned long *) stack = data;
 	return 0;
--- ./arch/i386/kernel/signal.c.4gb	2002-08-03 04:39:42.000000000 +0400
+++ ./arch/i386/kernel/signal.c	2004-09-09 17:02:08.000000000 +0400
@@ -186,25 +186,25 @@ struct rt_sigframe
 };
 
 static int
-restore_sigcontext(struct pt_regs *regs, struct sigcontext *sc, int *peax)
+restore_sigcontext(struct pt_regs *regs, struct sigcontext *__sc, int *peax)
 {
-	unsigned int err = 0;
+	struct sigcontext sc;	/* ~80 bytes of kernel copy of sigcontext */
 
-#define COPY(x)		err |= __get_user(regs->x, &sc->x)
+	if (copy_from_user(&sc, __sc, sizeof(sc)))
+		return -EFAULT;
+
+#define COPY(x)		regs->x = sc.x
 
 #define COPY_SEG(seg)							\
-	{ unsigned short tmp;						\
-	  err |= __get_user(tmp, &sc->seg);				\
+	{ unsigned short tmp = sc.seg;					\
 	  regs->x##seg = tmp; }
 
 #define COPY_SEG_STRICT(seg)						\
-	{ unsigned short tmp;						\
-	  err |= __get_user(tmp, &sc->seg);				\
+	{ unsigned short tmp = sc.seg;					\
 	  regs->x##seg = tmp|3; }
 
 #define GET_SEG(seg)							\
-	{ unsigned short tmp;						\
-	  err |= __get_user(tmp, &sc->seg);				\
+	{ unsigned short tmp = sc.seg;					\
 	  loadsegment(seg,tmp); }
 
 	GET_SEG(gs);
@@ -223,27 +223,23 @@ restore_sigcontext(struct pt_regs *regs,
 	COPY_SEG_STRICT(ss);
 	
 	{
-		unsigned int tmpflags;
-		err |= __get_user(tmpflags, &sc->eflags);
+		unsigned int tmpflags = sc.eflags;
 		regs->eflags = (regs->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
 		regs->orig_eax = -1;		/* disable syscall checks */
 	}
 
 	{
-		struct _fpstate * buf;
-		err |= __get_user(buf, &sc->fpstate);
+		struct _fpstate * buf = sc.fpstate;
 		if (buf) {
 			if (verify_area(VERIFY_READ, buf, sizeof(*buf)))
-				goto badframe;
-			err |= restore_i387(buf);
+				return -EFAULT;
+			if (restore_i387(buf))
+				return -EFAULT;
 		}
 	}
 
-	err |= __get_user(*peax, &sc->eax);
-	return err;
-
-badframe:
-	return 1;
+	*peax = sc.eax;
+	return 0;
 }
 
 asmlinkage int sys_sigreturn(unsigned long __unused)
@@ -316,46 +312,48 @@ badframe:
  */
 
 static int
-setup_sigcontext(struct sigcontext *sc, struct _fpstate *fpstate,
+setup_sigcontext(struct sigcontext *__sc, struct _fpstate *fpstate,
 		 struct pt_regs *regs, unsigned long mask)
 {
-	int tmp, err = 0;
+	int tmp;
+	struct sigcontext sc;	/* ~80 bytes of kernel copy of sigcontext */
 
 	tmp = 0;
 	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
-	err |= __put_user(tmp, (unsigned int *)&sc->gs);
+	*(unsigned int *)&sc.gs = tmp;
 	__asm__("movl %%fs,%0" : "=r"(tmp): "0"(tmp));
-	err |= __put_user(tmp, (unsigned int *)&sc->fs);
+	*(unsigned int *)&sc.fs = tmp;
 
-	err |= __put_user(regs->xes, (unsigned int *)&sc->es);
-	err |= __put_user(regs->xds, (unsigned int *)&sc->ds);
-	err |= __put_user(regs->edi, &sc->edi);
-	err |= __put_user(regs->esi, &sc->esi);
-	err |= __put_user(regs->ebp, &sc->ebp);
-	err |= __put_user(regs->esp, &sc->esp);
-	err |= __put_user(regs->ebx, &sc->ebx);
-	err |= __put_user(regs->edx, &sc->edx);
-	err |= __put_user(regs->ecx, &sc->ecx);
-	err |= __put_user(regs->eax, &sc->eax);
-	err |= __put_user(current->thread.trap_no, &sc->trapno);
-	err |= __put_user(current->thread.error_code, &sc->err);
-	err |= __put_user(regs->eip, &sc->eip);
-	err |= __put_user(regs->xcs, (unsigned int *)&sc->cs);
-	err |= __put_user(regs->eflags, &sc->eflags);
-	err |= __put_user(regs->esp, &sc->esp_at_signal);
-	err |= __put_user(regs->xss, (unsigned int *)&sc->ss);
+	*(unsigned int *)&sc.es = regs->xes;
+	*(unsigned int *)&sc.ds = regs->xds;
+	sc.edi = regs->edi;
+	sc.esi = regs->esi;
+	sc.ebp = regs->ebp;
+	sc.esp = regs->esp;
+	sc.ebx = regs->ebx;
+	sc.edx = regs->edx;
+	sc.ecx = regs->ecx;
+	sc.eax = regs->eax;
+	sc.trapno = current->thread.trap_no;
+	sc.err = current->thread.error_code;
+	sc.eip = regs->eip;
+	*(unsigned int *)&sc.cs = regs->xcs;
+	sc.eflags = regs->eflags;
+	sc.esp_at_signal = regs->esp;
+	*(unsigned int *)&sc.ss = regs->xss;
 
 	tmp = save_i387(fpstate);
 	if (tmp < 0)
-	  err = 1;
-	else
-	  err |= __put_user(tmp ? fpstate : NULL, &sc->fpstate);
+		return 1;
+	sc.fpstate = tmp ? fpstate : NULL;
 
 	/* non-iBCS2 extensions.. */
-	err |= __put_user(mask, &sc->oldmask);
-	err |= __put_user(current->thread.cr2, &sc->cr2);
+	sc.oldmask = mask;
+	sc.cr2 = current->thread.cr2;
 
-	return err;
+	if (copy_to_user(__sc, &sc, sizeof(sc)))
+		return 1;
+	return 0;
 }
 
 /*
--- ./arch/i386/kernel/smpboot.c.4gb	2004-04-14 17:05:25.000000000 +0400
+++ ./arch/i386/kernel/smpboot.c	2004-09-09 17:02:08.000000000 +0400
@@ -46,6 +46,7 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/smpboot.h>
+#include <asm/desc.h>
 
 /* Set if we find a B stepping CPU			*/
 static int smp_b_stepping;
--- ./arch/i386/kernel/smp.c.4gb	2003-06-13 18:51:29.000000000 +0400
+++ ./arch/i386/kernel/smp.c	2004-09-09 17:02:08.000000000 +0400
@@ -309,7 +309,9 @@ static void inline leave_mm (unsigned lo
 {
 	BUG_ON(cpu_tlbstate[cpu].state == TLBSTATE_OK);
 	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+#ifndef CONFIG_4GB
 	load_cr3(swapper_pg_dir);
+#endif
 }
 
 /*
--- ./arch/i386/kernel/traps.c.4gb	2002-11-29 02:53:09.000000000 +0300
+++ ./arch/i386/kernel/traps.c	2004-09-09 17:02:08.000000000 +0400
@@ -54,8 +54,11 @@ asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
 
-struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
-		{ 0, 0 }, { 0, 0 } };
+struct desc_struct default_ldt[]
+#ifdef CONFIG_4GB
+  __attribute__((__section__(".data.ldt")))
+#endif
+  = { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } };
 
 /*
  * The IDT has to be page-aligned to simplify the Pentium
@@ -98,6 +101,9 @@ int kstack_depth_to_print = 24;
 
 extern struct module *module_list;
 extern struct module kernel_module;
+#ifdef CONFIG_4GB
+extern const char __start___locore, __stop___locore;
+#endif
 
 static inline int kernel_text_address(unsigned long addr)
 {
@@ -107,6 +113,11 @@ static inline int kernel_text_address(un
 	if (addr >= (unsigned long) &_stext &&
 	    addr <= (unsigned long) &_etext)
 		return 1;
+#ifdef CONFIG_4GB
+	if (addr >= (unsigned long)&__start___locore &&
+			addr < (unsigned long)&__stop___locore)
+		return 1;
+#endif
 
 	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
 		/* mod_bound tests for addr being inside the vmalloc'ed
@@ -125,6 +136,11 @@ static inline int kernel_text_address(un
 
 static inline int kernel_text_address(unsigned long addr)
 {
+#ifdef CONFIG_4GB
+	if (addr >= (unsigned long)&__start___locore &&
+			addr < (unsigned long)&__stop___locore)
+                return 1;
+#endif
 	return (addr >= (unsigned long) &_stext &&
 		addr <= (unsigned long) &_etext);
 }
@@ -234,7 +250,8 @@ void show_registers(struct pt_regs *regs
 		for(i=0;i<20;i++)
 		{
 			unsigned char c;
-			if(__get_user(c, &((unsigned char*)regs->eip)[i])) {
+			if(__direct_get_user(c,
+					&((unsigned char*)regs->eip)[i])) {
 bad:
 				printk(" Bad EIP value.");
 				break;
@@ -260,14 +277,14 @@ static void handle_BUG(struct pt_regs *r
 
 	if (eip < PAGE_OFFSET)
 		goto no_bug;
-	if (__get_user(ud2, (unsigned short *)eip))
+	if (__direct_get_user(ud2, (unsigned short *)eip))
 		goto no_bug;
 	if (ud2 != 0x0b0f)
 		goto no_bug;
-	if (__get_user(line, (unsigned short *)(eip + 2)))
+	if (__direct_get_user(line, (unsigned short *)(eip + 2)))
 		goto bug;
-	if (__get_user(file, (char **)(eip + 4)) ||
-		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
+	if (__direct_get_user(file, (char **)(eip + 4)) ||
+		(unsigned long)file < PAGE_OFFSET || __direct_get_user(c, file))
 		file = "<bad filename>";
 
 	printk("kernel BUG at %s:%d!\n", file, line);
@@ -533,13 +550,28 @@ asmlinkage void do_debug(struct pt_regs 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
 	/* If the user set TF, it's simplest to clear it right away. */
+#ifndef CONFIG_4GB
 	if ((eip >=PAGE_OFFSET) && (regs->eflags & TF_MASK))
 		goto clear_TF;
+#else
+	if (!user_mode(regs) && (eip >= PAGE_OFFSET) &&
+			(regs->eflags & TF_MASK))
+		goto clear_TF;
+#endif
 
-	/* Mask out spurious debug traps due to lazy DR7 setting */
+	/*
+	 * Mask out spurious debug traps due to lazy DR7 setting or
+	 * due to 4GB address space split
+	 */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
 		if (!tsk->thread.debugreg[7])
 			goto clear_dr7;
+#ifdef CONFIG_4GB
+		if (!user_mode(regs)) {
+			current->thread.reloaddbg = 1;
+			goto clear_dr7;
+		}
+#endif
 	}
 
 	if (regs->eflags & VM_MASK)
@@ -784,9 +816,19 @@ void __init trap_init_f00f_bug(void)
 	 * variable so that updating idt will automatically
 	 * update the idt descriptor..
 	 */
+#ifndef CONFIG_4GB
 	__set_fixmap(FIX_F00F, __pa(&idt_table), PAGE_KERNEL_RO);
 	idt = (struct desc_struct *)__fix_to_virt(FIX_F00F);
+#else
+	pgd_t *pgd = pgd_offset_k(IDT_START);
+	pmd_t *pmd = pmd_offset(pgd, IDT_START);
+	pte_t *pte = pte_offset(pmd, IDT_START);
+
+	pte_wrprotect(*pte);
+	__flush_tlb_all();
 
+	idt = (struct desc_struct *)IDT_START;
+#endif
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 }
 #endif
@@ -854,12 +896,25 @@ __asm__ __volatile__ ("movw %w3,0(%2)\n\
 
 void set_tss_desc(unsigned int n, void *addr)
 {
+#ifdef CONFIG_4GB
+	/* install U-mapped version of this K-mapped tss */
+	_set_tssldt_desc(gdt_table+__TSS(n), (int)(TSS_START +
+		((unsigned long)addr-(unsigned long)&init_tss)), 235, 0x89);
+#else
 	_set_tssldt_desc(gdt_table+__TSS(n), (int)addr, 235, 0x89);
+#endif
 }
 
 void set_ldt_desc(unsigned int n, void *addr, unsigned int size)
 {
+#ifdef CONFIG_4GB
+	/* install U-mapped version of this K-mapped ldt */
+	if (addr == &default_ldt[0])
+		addr = (void*)LDT_START;
 	_set_tssldt_desc(gdt_table+__LDT(n), (int)addr, ((size << 3)-1), 0x82);
+#else /* CONFIG_4GB */
+	_set_tssldt_desc(gdt_table+__LDT(n), (int)addr, ((size << 3)-1), 0x82);
+#endif /* CONFIG_4GB */
 }
 
 #ifdef CONFIG_X86_VISWS_APIC
@@ -986,6 +1041,10 @@ void __init trap_init(void)
 
 	set_system_gate(SYSCALL_VECTOR,&system_call);
 
+#ifdef CONFIG_4GB
+	/* now exception handlers can require fixups table - prepare it */
+	extable_init();
+#endif
 	/*
 	 * default LDT is a single-entry callgate to lcall7 for iBCS
 	 * and a callgate to lcall27 for Solaris/x86 binaries
--- ./arch/i386/kernel/vm86.c.4gb	2003-08-25 15:44:39.000000000 +0400
+++ ./arch/i386/kernel/vm86.c	2004-09-09 17:02:08.000000000 +0400
@@ -30,6 +30,7 @@
  *   
  */
 
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -278,7 +279,12 @@ static void do_sys_vm86(struct kernel_vm
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
 	tss = init_tss + smp_processor_id();
+#ifdef CONFIG_4GB
+	tss->esp0 = tsk->thread.esp0 = tsk->thread.utask +
+		((unsigned long)&info->VM86_TSS_ESP0 & (THREAD_SIZE-1));
+#else /* CONFIG_4GB */
 	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
+#endif /* CONFIG_4GB */
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
--- ./arch/i386/config.in.4gb	2004-02-18 16:36:30.000000000 +0300
+++ ./arch/i386/config.in	2004-09-09 17:02:08.000000000 +0400
@@ -205,6 +205,12 @@ if [ "$CONFIG_EXPERIMENTAL" = "y" ]; the
    tristate 'BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTAL)' CONFIG_EDD
 fi
 
+choice 'Kernel space size (user/kernel virtual space split)' \
+	"1GB    CONFIG_1GB \
+	 2GB    CONFIG_2GB \
+	 3GB    CONFIG_3GB \
+	 4GB    CONFIG_4GB" 1GB
+
 choice 'High Memory Support' \
 	"off    CONFIG_NOHIGHMEM \
 	 4GB    CONFIG_HIGHMEM4G \
--- ./arch/i386/Makefile.4gb	2003-06-13 18:51:29.000000000 +0400
+++ ./arch/i386/Makefile	2004-09-09 17:02:08.000000000 +0400
@@ -106,6 +106,8 @@ SUBDIRS += arch/i386/math-emu
 DRIVERS += arch/i386/math-emu/math.o
 endif
 
+SUBDIRS := $(addprefix arch/i386/, tools) $(SUBDIRS)
+
 arch/i386/kernel: dummy
 	$(MAKE) linuxsubdirs SUBDIRS=arch/i386/kernel
 
@@ -113,9 +115,14 @@ arch/i386/mm: dummy
 	$(MAKE) linuxsubdirs SUBDIRS=arch/i386/mm
 
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+MAKETOOLS = $(MAKE) -C arch/$(ARCH)/tools
 
 vmlinux: arch/i386/vmlinux.lds
 
+arch/i386/vmlinux.lds: arch/i386/vmlinux.lds.S FORCE
+	$(CPP) -C -P -I$(HPATH) \
+		-Ui386 arch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds
+
 FORCE: ;
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
@@ -148,8 +155,11 @@ install: vmlinux
 
 archclean:
 	@$(MAKEBOOT) clean
+	@$(MAKETOOLS) clean
 
 archmrproper:
+	rm -f arch/i386/vmlinux.lds
+	@$(MAKETOOLS) mrproper
 
 archdep:
 	@$(MAKEBOOT) dep
--- /dev/null	2003-04-26 02:10:32.000000000 +0400
+++ ./arch/i386/tools/Makefile	2004-09-09 17:02:08.000000000 +0400
@@ -0,0 +1,25 @@
+# Makefile for i386 kernel build tools.
+#
+TARGET	:= $(TOPDIR)/include/asm-$(ARCH)/offset.h
+
+USE_STANDARD_AS_RULE := true
+
+$(TARGET): offset.h
+	cmp -s $^ $@ || (cp $^ $(TARGET).new && mv $(TARGET).new $(TARGET))
+
+offset.h: offset.o
+	sed -n 's/^@@@//p' $^ | sed 's/\(.*\)\(---\$$\)\(.*\)/\1\3/g' >$@
+
+# it's .s file actually. We use .o extension for using correct .depend rule
+offset.o: offset.c $(TOPDIR)/include/linux/autoconf.h FORCE
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -S $< -o $@
+
+clean:
+	rm -f offset.[hs] $(TARGET).new
+
+mrproper: clean
+	rm -f $(TARGET)
+
+FORCE: ;
+
+include $(TOPDIR)/Rules.make
--- /dev/null	2003-04-26 02:10:32.000000000 +0400
+++ ./arch/i386/tools/offset.c	2004-09-09 17:02:08.000000000 +0400
@@ -0,0 +1,89 @@
+/*
+ * offset.c: Calculate pt_regs and task_struct offsets.
+ *
+ * Copyright (C) 1996 David S. Miller
+ * Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002 Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ *
+ * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.
+ *
+ * Adapted for i386 by dev@sw.ru
+ *
+ */
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+
+#define text(t) __asm__("\n@@@" t)
+#define _offset(type, member) (&(((type *)NULL)->member))
+
+#define offset(string, ptr, member) \
+	__asm__("\n@@@" string "---%0" : : "i" (_offset(ptr, member)))
+#define constant(string, member) \
+	__asm__("\n@@@" string "---%x0" : : "i" (member))
+#define size(string, size) \
+	__asm__("\n@@@" string "---%0" : : "i" (sizeof(size)))
+#define linefeed text("")
+
+text("/* DO NOT TOUCH, AUTOGENERATED BY OFFSET.C */");
+linefeed;
+text("#ifndef _I386_OFFSET_H");
+text("#define _I386_OFFSET_H");
+linefeed;
+
+void output_task_defines(void)
+{
+	text("/* i386 task_struct offsets. */");
+	offset("#define TASK_STATE         ", struct task_struct, state);
+	offset("#define TASK_FLAGS         ", struct task_struct, flags);
+	offset("#define TASK_SIGPENDING    ", struct task_struct, sigpending);
+	offset("#define TASK_ADDRLIMIT     ", struct task_struct, addr_limit);
+	offset("#define TASK_EXEC_DOMAIN   ", struct task_struct, exec_domain);
+	offset("#define TASK_NEED_RESCHED  ", struct task_struct, need_resched);
+	offset("#define TASK_PTRACE        ", struct task_struct, ptrace);
+	offset("#define TASK_MM            ", struct task_struct, mm);
+	offset("#define TASK_PROCESSOR     ", struct task_struct, processor);
+	size(  "#define TASK_STRUCT_SIZE   ", struct task_struct);
+	linefeed;
+}
+
+void output_thread_defines(void)
+{
+	text("/* i386 specific thread_struct offsets. */");
+	offset("#define TASK_THREAD_ESP0  ", struct task_struct, thread.esp0);
+	offset("#define TASK_THREAD_EIP   ", struct task_struct, thread.eip);
+	offset("#define TASK_THREAD_ESP   ", struct task_struct, thread.esp);
+	offset("#define TASK_THREAD_FS    ", struct task_struct, thread.fs);
+	offset("#define TASK_THREAD_GS    ", struct task_struct, thread.gs);
+#ifdef CONFIG_4GB
+	offset("#define TASK_THREAD_CR3   ", struct task_struct, thread.cr3);
+	offset("#define TASK_THREAD_KTASK ", struct task_struct, thread.ktask);
+	offset("#define TASK_THREAD_UTASK ", struct task_struct, thread.utask);
+	offset("#define TASK_THREAD_RELOADDBG ", struct task_struct,
+							thread.reloaddbg);
+#endif
+	offset("#define TASK_THREAD_DEBUGREG0 ", struct task_struct,
+							thread.debugreg);
+	linefeed;
+}
+
+void output_tss_defines(void)
+{
+	text("/* i386 specific tss_struct offsets. */");
+	size(  "#define TSS_STRUCT_SIZE   ", struct tss_struct);
+	linefeed;
+}
+
+void output_mm_defines(void)
+{
+	text("/* Linux mm_struct offsets. */");
+	offset("#define MM_PGD         ", struct mm_struct, pgd);
+	linefeed;
+}
+
+
+text("#endif /* !(_I386_OFFSET_H) */");
--- ./arch/i386/vmlinux.lds.4gb	2002-02-25 22:37:53.000000000 +0300
+++ ./arch/i386/vmlinux.lds	2004-09-10 10:46:20.997994968 +0400
@@ -1,82 +0,0 @@
-/* ld script to make i386 Linux kernel
- * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
- */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
-OUTPUT_ARCH(i386)
-ENTRY(_start)
-SECTIONS
-{
-  . = 0xC0000000 + 0x100000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text)
-	*(.fixup)
-	*(.gnu.warning)
-	} = 0x9090
-
-  _etext = .;			/* End of text section */
-
-  .rodata : { *(.rodata) *(.rodata.*) }
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  .data : {			/* Data */
-	*(.data)
-	CONSTRUCTORS
-	}
-
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : { *(.initcall.init) }
-  __initcall_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  __bss_start = .;		/* BSS */
-  .bss : {
-	*(.bss)
-	}
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.text.exit)
-	*(.data.exit)
-	*(.exitcall.exit)
-	}
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
--- /dev/null	2003-04-26 02:10:32.000000000 +0400
+++ ./arch/i386/vmlinux.lds.S	2004-09-09 17:02:08.000000000 +0400
@@ -0,0 +1,102 @@
+#include <linux/config.h>
+#include <asm-i386/page_offset.h>
+
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+SECTIONS
+{
+  . = PAGE_OFFSET_RAW + 0x100000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x9090
+
+#ifdef CONFIG_4GB
+  __locore_lmabegin = ALIGN(4096);
+  . = SPLIT_4GB_MAP_START;             /* LOCORE_START */
+  __start___locore = .;
+  .locore : AT (__locore_lmabegin) { *(.locore) }
+  __stop___locore = .;
+  . = __locore_lmabegin + SIZEOF(.locore);
+#endif
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : { *(.initcall.init) }
+  __initcall_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+#ifdef CONFIG_4GB
+  . = ALIGN(4096);
+  .data.gdt : { *(.data.gdt) }
+  . = ALIGN(4096);
+  .data.ldt : { *(.data.ldt) }
+  . = ALIGN(4096);
+  .data.tss : { *(.data.tss) }
+#endif
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.text.exit)
+	*(.data.exit)
+	*(.exitcall.exit)
+	}
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}

--------------000207050006010406010906--

