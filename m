Return-Path: <linux-kernel-owner+w=401wt.eu-S1751192AbWLOGw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWLOGw7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWLOGwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:52:39 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47538 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbWLOGwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:52:32 -0500
Date: Thu, 14 Dec 2006 22:52:30 -0800
Message-Id: <200612150652.kBF6qUpF025532@zach-dev.vmware.com>
Subject: [PATCH 5/6] VMI backend for paravirt-ops
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 15 Dec 2006 06:52:30.0526 (UTC) FILETIME=[9720CDE0:01C72015]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly straightforward implementation of VMI backend for paravirt-ops.

Subject: VMI backend for paravirt-ops
Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r d8711b11c1eb arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/Kconfig	Tue Dec 12 13:51:13 2006 -0800
@@ -192,6 +192,15 @@ config PARAVIRT
 	  under a hypervisor, improving performance significantly.
 	  However, when run without a hypervisor the kernel is
 	  theoretically slower.  If in doubt, say N.
+
+config VMI
+	bool "VMI Paravirt-ops support"
+	depends on PARAVIRT
+	default y
+	help
+	  VMI provides a paravirtualized interface to multiple hypervisors
+	  include VMware ESX server and Xen by connecting to a ROM module
+	  provided by the hypervisor.
 
 config ACPI_SRAT
 	bool
diff -r d8711b11c1eb arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/kernel/Makefile	Tue Dec 12 13:51:13 2006 -0800
@@ -39,6 +39,8 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_prin
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
+
+obj-$(CONFIG_VMI)		+= vmi.o
 
 # Make sure this is linked after any other paravirt_ops structs: see head.S
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
diff -r d8711b11c1eb arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/kernel/head.S	Tue Dec 12 13:51:13 2006 -0800
@@ -360,7 +360,7 @@ 1:	movb $1,X86_HARD_MATH
  * cpu_gdt_table and boot_pda; for secondary CPUs, these will be
  * that CPU's GDT and PDA.
  */
-setup_pda:
+ENTRY(setup_pda)
 	/* get the PDA pointer */
 	movl start_pda, %eax
 
diff -r d8711b11c1eb arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/kernel/io_apic.c	Tue Dec 12 13:51:13 2006 -0800
@@ -1914,7 +1914,7 @@ static void __init setup_ioapic_ids_from
 static void __init setup_ioapic_ids_from_mpc(void) { }
 #endif
 
-static int no_timer_check __initdata;
+int no_timer_check __initdata;
 
 static int __init notimercheck(char *s)
 {
diff -r d8711b11c1eb arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/kernel/setup.c	Tue Dec 12 13:51:13 2006 -0800
@@ -60,6 +60,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/vmi.h>
 #include <setup_arch.h>
 #include <bios_ebda.h>
 
@@ -581,6 +582,14 @@ void __init setup_arch(char **cmdline_p)
 
 	max_low_pfn = setup_memory();
 
+#ifdef CONFIG_VMI
+	/*
+	 * Must be after max_low_pfn is determined, and before kernel
+	 * pagetables are setup.
+	 */
+	vmi_init();
+#endif
+
 	/*
 	 * NOTE: before this point _nobody_ is allowed to allocate
 	 * any memory using the bootmem allocator.  Although the
diff -r d8711b11c1eb arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/kernel/smpboot.c	Tue Dec 12 13:51:13 2006 -0800
@@ -63,6 +63,7 @@
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
 #include <smpboot_hooks.h>
+#include <asm/vmi.h>
 
 /* Set if we find a B stepping CPU */
 static int __devinitdata smp_b_stepping;
@@ -547,6 +548,9 @@ static void __devinit start_secondary(vo
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
+#ifdef CONFIG_VMI
+	vmi_bringup();
+#endif
 	secondary_cpu_init();
 	preempt_disable();
 	smp_callin();
diff -r d8711b11c1eb arch/i386/mm/pgtable.c
--- a/arch/i386/mm/pgtable.c	Tue Dec 12 13:51:06 2006 -0800
+++ b/arch/i386/mm/pgtable.c	Tue Dec 12 13:51:13 2006 -0800
@@ -171,6 +171,8 @@ void reserve_top_address(unsigned long r
 void reserve_top_address(unsigned long reserve)
 {
 	BUG_ON(fixmaps > 0);
+	printk(KERN_INFO "Reserving virtual address space above 0x%08x\n",
+	       (int)-reserve);
 #ifdef CONFIG_COMPAT_VDSO
 	BUG_ON(reserve != 0);
 #else
diff -r d8711b11c1eb include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Tue Dec 12 13:51:06 2006 -0800
+++ b/include/asm-i386/timer.h	Tue Dec 12 13:51:13 2006 -0800
@@ -8,6 +8,7 @@ void setup_pit_timer(void);
 /* Modifiers for buggy PIT handling */
 extern int pit_latch_buggy;
 extern int timer_ack;
+extern int no_timer_check;
 extern int recalibrate_cpu_khz(void);
 
 #endif
diff -r d8711b11c1eb arch/i386/kernel/vmi.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/kernel/vmi.c	Tue Dec 12 13:51:13 2006 -0800
@@ -0,0 +1,901 @@
+/*
+ * VMI specific paravirt-ops implementation
+ *
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/license.h>
+#include <linux/cpu.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <asm/vmi.h>
+#include <asm/io.h>
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+#include <asm/apic.h>
+#include <asm/processor.h>
+#include <asm/timer.h>
+
+/* Convenient for calling VMI functions indirectly in the ROM */
+typedef u32 __attribute__((regparm(1))) (VROMFUNC)(void);
+typedef u64 __attribute__((regparm(2))) (VROMLONGFUNC)(int);
+
+#define call_vrom_func(rom,func) \
+   (((VROMFUNC *)(rom->func))())
+
+#define call_vrom_long_func(rom,func,arg) \
+   (((VROMLONGFUNC *)(rom->func)) (arg))
+
+static struct vrom_header *vmi_rom;
+static int license_gplok;
+static int disable_nodelay;
+static int disable_pge;
+static int disable_pse;
+static int disable_sep;
+static int disable_tsc;
+static int disable_mtrr;
+
+/* Cached VMI operations */
+struct {
+	void (fastcall *cpuid)(void /* non-c */);
+	void (fastcall *_set_ldt)(u32 selector);
+	void (fastcall *set_tr)(u32 selector);
+	void (fastcall *set_kernel_stack)(u32 selector, u32 esp0);
+	void (fastcall *allocate_page)(u32, u32, u32, u32, u32);
+	void (fastcall *release_page)(u32, u32);
+	void (fastcall *set_pte)(pte_t, pte_t *, unsigned);
+	void (fastcall *update_pte)(pte_t *, unsigned);
+	void (fastcall *set_linear_mapping)(int, u32, u32, u32);
+	void (fastcall *flush_tlb)(int);
+	void (fastcall *set_initial_ap_state)(int, int);
+} vmi_ops;
+ 
+/* XXX move this to alternative.h */
+extern struct paravirt_patch __start_parainstructions[],
+	__stop_parainstructions[];
+
+/*
+ * VMI patching routines.
+ */
+#define MNEM_CALL 0xe8
+#define MNEM_JMP  0xe9
+#define MNEM_RET  0xc3
+
+static char irq_save_disable_callout[] = {
+	MNEM_CALL, 0, 0, 0, 0,
+	MNEM_CALL, 0, 0, 0, 0,
+	MNEM_RET
+};
+#define IRQ_PATCH_INT_MASK 0
+#define IRQ_PATCH_DISABLE  5
+
+static inline void patch_offset(unsigned char *eip, unsigned char *dest)
+{
+        *(unsigned long *)(eip+1) = dest-eip-5;
+}
+
+static unsigned patch_internal(int call, unsigned len, void *insns)
+{
+	u64 reloc;
+	struct vmi_relocation_info *const rel = (struct vmi_relocation_info *)&reloc;
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,	call);
+	switch(rel->type) {
+		case VMI_RELOCATION_CALL_REL:
+			BUG_ON(len < 5);
+			*(char *)insns = MNEM_CALL;
+			patch_offset(insns, rel->eip);
+			return 5;
+
+		case VMI_RELOCATION_JUMP_REL:
+			BUG_ON(len < 5);
+			*(char *)insns = MNEM_JMP;
+			patch_offset(insns, rel->eip);
+			return 5;
+
+		case VMI_RELOCATION_NOP:
+			/* obliterate the whole thing */
+			return 0;
+
+		case VMI_RELOCATION_NONE:
+			/* leave native code in place */
+			break;
+
+		default:
+			BUG();
+	}
+	return len;
+}
+
+/*
+ * Apply patch if appropriate, return length of new instruction
+ * sequence.  The callee does nop padding for us.
+ */
+static unsigned vmi_patch(u8 type, u16 clobbers, void *insns, unsigned len)
+{
+	switch (type) {
+		case PARAVIRT_IRQ_DISABLE:
+			return patch_internal(VMI_CALL_DisableInterrupts, len, insns);
+		case PARAVIRT_IRQ_ENABLE:
+			return patch_internal(VMI_CALL_EnableInterrupts, len, insns);
+		case PARAVIRT_RESTORE_FLAGS:
+			return patch_internal(VMI_CALL_SetInterruptMask, len, insns);
+		case PARAVIRT_SAVE_FLAGS:
+			return patch_internal(VMI_CALL_GetInterruptMask, len, insns);
+        	case PARAVIRT_SAVE_FLAGS_IRQ_DISABLE:
+			if (len >= 10) {
+				patch_internal(VMI_CALL_GetInterruptMask, len, insns);
+				patch_internal(VMI_CALL_DisableInterrupts, len-5, insns+5);
+				return 10;
+			} else {
+				/*
+				 * You bastards didn't leave enough room to
+				 * patch save_flags_irq_disable inline.  Patch
+				 * to a helper
+				 */
+				BUG_ON(len < 5);
+				*(char *)insns = MNEM_CALL;
+				patch_offset(insns, irq_save_disable_callout);
+				return 5;
+			}
+		case PARAVIRT_INTERRUPT_RETURN:
+			return patch_internal(VMI_CALL_IRET, len, insns);
+		case PARAVIRT_STI_SYSEXIT:
+			return patch_internal(VMI_CALL_SYSEXIT, len, insns);
+		default:
+			break;
+	}
+	return len;
+}
+
+/* CPUID has non-C semantics, and paravirt-ops API doesn't match hardware ISA */
+static fastcall void vmi_cpuid(unsigned int *eax, unsigned int *ebx,
+                               unsigned int *ecx, unsigned int *edx)
+{
+	int override = 0;
+	if (*eax == 1)
+		override = 1;
+        asm volatile ("call *%6"
+                      : "=a" (*eax),
+                        "=b" (*ebx),
+                        "=c" (*ecx),
+                        "=d" (*edx)
+                      : "0" (*eax), "2" (*ecx), "r" (vmi_ops.cpuid));
+	if (override) {
+		if (disable_pse)
+			*edx &= ~X86_FEATURE_PSE;
+		if (disable_pge)
+			*edx &= ~X86_FEATURE_PGE;
+		if (disable_sep)
+			*edx &= ~X86_FEATURE_SEP;
+		if (disable_tsc)
+			*edx &= ~X86_FEATURE_TSC;
+		if (disable_mtrr)
+			*edx &= ~X86_FEATURE_MTRR;
+	}
+}
+
+static inline void vmi_maybe_load_tls(struct desc_struct *gdt, int nr, struct desc_struct *new)
+{
+	if (gdt[nr].a != new->a || gdt[nr].b != new->b)
+		write_gdt_entry(gdt, nr, new->a, new->b);
+}
+
+static fastcall void vmi_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+	vmi_maybe_load_tls(gdt, GDT_ENTRY_TLS_MIN + 0, &t->tls_array[0]);
+	vmi_maybe_load_tls(gdt, GDT_ENTRY_TLS_MIN + 1, &t->tls_array[1]);
+	vmi_maybe_load_tls(gdt, GDT_ENTRY_TLS_MIN + 2, &t->tls_array[2]);
+}
+
+static fastcall void vmi_set_ldt(const void *addr, unsigned entries)
+{
+	unsigned cpu = smp_processor_id();
+	u32 low, high;
+
+	pack_descriptor(&low, &high, (unsigned long)addr,
+			entries * sizeof(struct desc_struct) - 1,
+			DESCTYPE_LDT, 0);
+	write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, high);
+	vmi_ops._set_ldt(entries ? GDT_ENTRY_LDT*sizeof(struct desc_struct) : 0);
+}
+
+static fastcall void vmi_set_tr(void)
+{
+	vmi_ops.set_tr(GDT_ENTRY_TSS*sizeof(struct desc_struct));
+}
+
+static fastcall void vmi_load_esp0(struct tss_struct *tss,
+				   struct thread_struct *thread)
+{
+	tss->esp0 = thread->esp0;
+
+	/* This can only happen when SEP is enabled, no need to test "SEP"arately */
+	if (unlikely(tss->ss1 != thread->sysenter_cs)) {
+		tss->ss1 = thread->sysenter_cs;
+		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
+	}
+	vmi_ops.set_kernel_stack(__KERNEL_DS, tss->esp0);
+}
+
+static fastcall void vmi_flush_tlb_user(void)
+{
+	vmi_ops.flush_tlb(VMI_FLUSH_TLB);
+}
+
+static fastcall void vmi_flush_tlb_kernel(void)
+{
+	vmi_ops.flush_tlb(VMI_FLUSH_TLB | VMI_FLUSH_GLOBAL);
+}
+
+/* Stub to do nothing at all; used for delays and unimplemented calls */
+static void vmi_nop(void)
+{
+}
+
+  
+#ifdef CONFIG_DEBUG_PAGE_TYPE
+
+#ifdef CONFIG_X86_PAE
+#define MAX_BOOT_PTS (2048+4+1)
+#else
+#define MAX_BOOT_PTS (1024+1)
+#endif
+
+/*
+ * During boot, mem_map is not yet available in paging_init, so stash
+ * all the boot page allocations here.
+ */
+static struct {
+	u32 pfn;
+	int type;
+} boot_page_allocations[MAX_BOOT_PTS];
+static int num_boot_page_allocations;
+static int boot_allocations_applied;
+
+void vmi_apply_boot_page_allocations(void)
+{
+	int i;
+	BUG_ON(!mem_map);
+	for (i = 0; i < num_boot_page_allocations; i++) {
+		struct page *page = pfn_to_page(boot_page_allocations[i].pfn);
+		page->type = boot_page_allocations[i].type;
+		page->type = boot_page_allocations[i].type &
+				~(VMI_PAGE_ZEROED | VMI_PAGE_CLONE);
+	}
+	boot_allocations_applied = 1;
+}
+
+static void record_page_type(u32 pfn, int type)
+{
+	BUG_ON(num_boot_page_allocations >= MAX_BOOT_PTS);
+	boot_page_allocations[num_boot_page_allocations].pfn = pfn;
+	boot_page_allocations[num_boot_page_allocations].type = type;
+	num_boot_page_allocations++;
+}
+
+static void check_zeroed_page(u32 pfn, int type, struct page *page)
+{
+	u32 *ptr;
+	int i;
+	int limit = PAGE_SIZE / sizeof(int);
+
+	if (page_address(page))
+		ptr = (u32 *)page_address(page);
+	else
+		ptr = (u32 *)__va(pfn << PAGE_SHIFT);
+	/*
+	 * When cloning the root in non-PAE mode, only the userspace
+	 * pdes need to be zeroed.
+	 */
+	if (type & VMI_PAGE_CLONE)
+		limit = USER_PTRS_PER_PGD;
+	for (i = 0; i < limit; i++)
+		BUG_ON(ptr[i]);
+}
+
+/*
+ * We stash the page type into struct page so we can verify the page
+ * types are used properly.
+ */
+static void vmi_set_page_type(u32 pfn, int type)
+{
+	/* PAE can have multiple roots per page - don't track */
+	if (PTRS_PER_PMD > 1 && (type & VMI_PAGE_PDP))
+		return;
+
+	if (boot_allocations_applied) {
+		struct page *page = pfn_to_page(pfn);
+		if (type != VMI_PAGE_NORMAL)
+			BUG_ON(page->type);
+		else
+			BUG_ON(page->type == VMI_PAGE_NORMAL);
+		page->type = type & ~(VMI_PAGE_ZEROED | VMI_PAGE_CLONE);
+		if (type & VMI_PAGE_ZEROED)
+			check_zeroed_page(pfn, type, page);
+	} else {
+		record_page_type(pfn, type);
+	}
+}
+
+static void vmi_check_page_type(u32 pfn, int type)
+{
+	/* PAE can have multiple roots per page - skip checks */
+	if (PTRS_PER_PMD > 1 && (type & VMI_PAGE_PDP))
+		return;
+
+	type &= ~(VMI_PAGE_ZEROED | VMI_PAGE_CLONE);
+	if (boot_allocations_applied) {
+		struct page *page = pfn_to_page(pfn);
+		BUG_ON((page->type ^ type) & VMI_PAGE_PAE);
+		BUG_ON(type == VMI_PAGE_NORMAL && page->type);
+		BUG_ON((type & page->type) == 0);
+	}
+}
+#else
+#define vmi_set_page_type(p,t) do { } while (0)
+#define vmi_check_page_type(p,t) do { } while (0)
+#endif
+
+static fastcall void vmi_allocate_pt(u32 pfn)
+{
+	vmi_set_page_type(pfn, VMI_PAGE_L1);
+	vmi_ops.allocate_page(pfn, VMI_PAGE_L1, 0, 0, 0);
+}
+
+static fastcall void vmi_allocate_pd(u32 pfn)
+{
+ 	/*
+	 * This call comes in very early, before mem_map is setup.
+	 * It is called only for swapper_pg_dir, which already has
+	 * data on it.
+	 */
+ 	vmi_set_page_type(pfn, VMI_PAGE_L2);
+	vmi_ops.allocate_page(pfn, VMI_PAGE_L2, 0, 0, 0);
+}
+
+static fastcall void vmi_allocate_pd_clone(u32 pfn, u32 clonepfn, u32 start, u32 count)
+{
+ 	vmi_set_page_type(pfn, VMI_PAGE_L2 | VMI_PAGE_CLONE);
+	vmi_check_page_type(clonepfn, VMI_PAGE_L2);
+	vmi_ops.allocate_page(pfn, VMI_PAGE_L2 | VMI_PAGE_CLONE, clonepfn, start, count);
+}
+
+static fastcall void vmi_release_pt(u32 pfn)
+{
+	vmi_ops.release_page(pfn, VMI_PAGE_L1);
+	vmi_set_page_type(pfn, VMI_PAGE_NORMAL);
+}
+
+static fastcall void vmi_release_pd(u32 pfn)
+{
+	vmi_ops.release_page(pfn, VMI_PAGE_L2);
+	vmi_set_page_type(pfn, VMI_PAGE_NORMAL);
+}
+
+/*
+ * Helper macros for MMU update flags.  We can defer updates until a flush
+ * or page invalidation only if the update is to the current address space
+ * (otherwise, there is no flush).  We must check against init_mm, since
+ * this could be a kernel update, which usually passes init_mm, although
+ * sometimes this check can be skipped if we know the particular function
+ * is only called on user mode PTEs.  We could change the kernel to pass
+ * current->active_mm here, but in particular, I was unsure if changing
+ * mm/highmem.c to do this would still be correct on other architectures.
+ */
+#define is_current_as(mm, mustbeuser) ((mm) == current->active_mm ||    \
+                                       (!mustbeuser && (mm) == &init_mm))
+#define vmi_flags_addr(mm, addr, level, user)                           \
+        ((level) | (is_current_as(mm, user) ?                           \
+                (VMI_PAGE_CURRENT_AS | ((addr) & VMI_PAGE_VA_MASK)) : 0))
+#define vmi_flags_addr_defer(mm, addr, level, user)                     \
+        ((level) | (is_current_as(mm, user) ?                           \
+                (VMI_PAGE_DEFER | VMI_PAGE_CURRENT_AS | ((addr) & VMI_PAGE_VA_MASK)) : 0))
+
+static fastcall void vmi_update_pte(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);
+	vmi_ops.update_pte(ptep, vmi_flags_addr(mm, addr, VMI_PAGE_PT, 0));
+}
+
+static fastcall void vmi_update_pte_defer(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);
+	vmi_ops.update_pte(ptep, vmi_flags_addr_defer(mm, addr, VMI_PAGE_PT, 0));
+}
+
+static fastcall void vmi_set_pte(pte_t *ptep, pte_t pte)
+{
+	/* XXX because of set_pmd_pte, this can be called on PT or PD layers */
+	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE | VMI_PAGE_PD);
+	vmi_ops.set_pte(pte, ptep, VMI_PAGE_PT);
+}
+
+static fastcall void vmi_set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)
+{
+	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);
+	vmi_ops.set_pte(pte, ptep, vmi_flags_addr(mm, addr, VMI_PAGE_PT, 0));
+}
+
+static fastcall void vmi_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+#ifdef CONFIG_X86_PAE
+	const pte_t pte = { pmdval.pmd, pmdval.pmd >> 32 };
+	vmi_check_page_type(__pa(pmdp) >> PAGE_SHIFT, VMI_PAGE_PMD);
+#else
+	const pte_t pte = { pmdval.pud.pgd.pgd };
+	vmi_check_page_type(__pa(pmdp) >> PAGE_SHIFT, VMI_PAGE_PGD);
+#endif
+	vmi_ops.set_pte(pte, (pte_t *)pmdp, VMI_PAGE_PD);
+}
+
+#ifdef CONFIG_X86_PAE
+
+static fastcall void vmi_set_pte_atomic(pte_t *ptep, pte_t pteval)
+{
+	/* 
+	 * XXX This is called from set_pmd_pte, but at both PT
+	 * and PD layers so the VMI_PAGE_PT flag is wrong.  But
+	 * it is only called for large page mapping changes,
+	 * the Xen backend, doesn't support large pages, and the
+	 * ESX backend doesn't depend on the flag.
+	 */
+	set_64bit((unsigned long long *)ptep,pte_val(pteval));
+	vmi_ops.update_pte(ptep, VMI_PAGE_PT);
+}
+
+static fastcall void vmi_set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);
+	vmi_ops.set_pte(pte, ptep, vmi_flags_addr_defer(mm, addr, VMI_PAGE_PT, 1));
+}
+
+static fastcall void vmi_set_pud(pud_t *pudp, pud_t pudval)
+{
+	/* Um, eww */
+	const pte_t pte = { pudval.pgd.pgd, pudval.pgd.pgd >> 32 };
+	vmi_check_page_type(__pa(pudp) >> PAGE_SHIFT, VMI_PAGE_PGD);
+	vmi_ops.set_pte(pte, (pte_t *)pudp, VMI_PAGE_PDP);
+}
+
+static fastcall void vmi_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	const pte_t pte = { 0 };
+	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);
+	vmi_ops.set_pte(pte, ptep, vmi_flags_addr(mm, addr, VMI_PAGE_PT, 0));
+}
+
+fastcall void vmi_pmd_clear(pmd_t *pmd)
+{
+	const pte_t pte = { 0 };
+	vmi_check_page_type(__pa(pmd) >> PAGE_SHIFT, VMI_PAGE_PMD);
+	vmi_ops.set_pte(pte, (pte_t *)pmd, VMI_PAGE_PD);
+}
+#endif
+
+#ifdef CONFIG_SMP
+struct vmi_ap_state ap;
+extern void setup_pda(void);
+
+static fastcall void __init /* XXX cpu hotplug */
+vmi_startup_ipi_hook(int phys_apicid, unsigned long start_eip,
+		     unsigned long start_esp)
+{
+	/* Default everything to zero.  This is fine for most GPRs. */
+	memset(&ap, 0, sizeof(struct vmi_ap_state));
+
+	ap.gdtr_limit = GDT_SIZE - 1;
+	ap.gdtr_base = (unsigned long) get_cpu_gdt_table(phys_apicid);
+	
+	ap.idtr_limit = IDT_ENTRIES * 8 - 1;
+	ap.idtr_base = (unsigned long) idt_table;
+
+	ap.ldtr = 0;
+	
+	ap.cs = __KERNEL_CS;
+	ap.eip = (unsigned long) start_eip;
+	ap.ss = __KERNEL_DS;
+	ap.esp = (unsigned long) start_esp;
+	
+	ap.ds = __USER_DS;
+	ap.es = __USER_DS;
+	ap.fs = 0;
+	ap.gs = __KERNEL_PDA;
+	
+	ap.eflags = 0;
+
+	setup_pda();
+	
+#ifdef CONFIG_X86_PAE
+	/* efer should match BSP efer. */
+	if (cpu_has_nx) {
+		unsigned l, h;
+		rdmsr(MSR_EFER, l, h);
+		ap.efer = (unsigned long long) h << 32 | l;
+	}
+#endif
+
+	ap.cr3 = __pa(swapper_pg_dir);
+	/* Protected mode, paging, AM, WP, NE, MP. */
+	ap.cr0 = 0x80050023;
+	ap.cr4 = mmu_cr4_features;
+	vmi_ops.set_initial_ap_state(__pa(&ap), phys_apicid);
+}
+#endif
+
+static inline int __init check_vmi_rom(struct vrom_header *rom)
+{
+	struct pci_header *pci;
+	struct pnp_header *pnp;
+	const char *manufacturer = "UNKNOWN";
+	const char *product = "UNKNOWN";
+	const char *license = "unspecified";
+
+	if (rom->rom_signature != 0xaa55)
+		return 0;
+	if (rom->vrom_signature != VMI_SIGNATURE)
+		return 0;
+	if (rom->api_version_maj != VMI_API_REV_MAJOR ||
+	    rom->api_version_min+1 < VMI_API_REV_MINOR+1) {
+		printk(KERN_WARNING "VMI: Found mismatched rom version %d.%d\n",
+				rom->api_version_maj,
+				rom->api_version_min);
+		return 0;
+	}
+
+	/*
+	 * Relying on the VMI_SIGNATURE field is not 100% safe, so check
+	 * the PCI header and device type to make sure this is really a
+	 * VMI device.
+	 */
+	if (!rom->pci_header_offs) {
+		printk(KERN_WARNING "VMI: ROM does not contain PCI header.\n");
+		return 0;
+	}
+
+	pci = (struct pci_header *)((char *)rom+rom->pci_header_offs);
+	if (pci->vendorID != PCI_VENDOR_ID_VMWARE ||
+	    pci->deviceID != PCI_DEVICE_ID_VMWARE_VMI) {
+		/* Allow it to run... anyways, but warn */
+		printk(KERN_WARNING "VMI: ROM from unknown manufacturer\n");
+	}
+
+	if (rom->pnp_header_offs) {
+		pnp = (struct pnp_header *)((char *)rom+rom->pnp_header_offs);
+		if (pnp->manufacturer_offset)
+			manufacturer = (const char *)rom+pnp->manufacturer_offset;
+		if (pnp->product_offset)
+			product = (const char *)rom+pnp->product_offset;
+	}
+
+	if (rom->license_offs)
+		license = (char *)rom+rom->license_offs;
+
+	printk(KERN_INFO "VMI: Found %s %s, API version %d.%d, ROM version %d.%d\n",
+		manufacturer, product,
+		rom->api_version_maj, rom->api_version_min,
+		pci->rom_version_maj, pci->rom_version_min);
+
+        license_gplok = license_is_gpl_compatible(license);
+        if (!license_gplok) {
+                printk(KERN_WARNING "VMI: ROM license '%s' taints kernel... "
+		       "inlining disabled\n",
+                       license);
+                add_taint(TAINT_PROPRIETARY_MODULE);
+        }
+	return 1;
+}
+
+/*
+ * Probe for the VMI option ROM
+ */
+static inline int __init probe_vmi_rom(void)
+{
+	unsigned long base;
+
+	/* VMI ROM is in option ROM area, check signature */
+	for (base = 0xC0000; base < 0xE0000; base += 2048) {
+		struct vrom_header *romstart;
+		romstart = (struct vrom_header *)isa_bus_to_virt(base);
+		if (check_vmi_rom(romstart)) {
+			vmi_rom = romstart;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * VMI setup common to all processors
+ */
+void vmi_bringup(void)
+{
+ 	/* We must establish the lowmem mapping for MMU ops to work */
+	vmi_ops.set_linear_mapping(0, __PAGE_OFFSET, max_low_pfn, 0);
+}
+
+/*
+ * Return a pointer to the VMI function or a NOP stub
+ */
+static void *vmi_get_function(int vmicall)
+{
+	u64 reloc;
+	const struct vmi_relocation_info *rel = (struct vmi_relocation_info *)&reloc;
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,	vmicall);
+	BUG_ON(rel->type == VMI_RELOCATION_JUMP_REL);
+	if (rel->type == VMI_RELOCATION_CALL_REL)
+		return (void *)rel->eip;	
+	else
+		return (void *)vmi_nop;
+}
+
+/*
+ * Helper macro for making the VMI paravirt-ops fill code readable.
+ * For unimplemented operations, fall back to default.
+ */
+#define para_fill(opname, vmicall)				\
+do {								\
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,		\
+				    VMI_CALL_##vmicall);	\
+	if (rel->type != VMI_RELOCATION_NONE) {			\
+		BUG_ON(rel->type != VMI_RELOCATION_CALL_REL);	\
+		paravirt_ops.opname = (void *)rel->eip;		\
+	}							\
+} while (0)
+
+/*
+ * Activate the VMI interface and switch into paravirtualized mode
+ */
+static inline int __init activate_vmi(void)
+{
+	short kernel_cs;
+	u64 reloc;
+	const struct vmi_relocation_info *rel = (struct vmi_relocation_info *)&reloc;
+
+	if (call_vrom_func(vmi_rom, vmi_init) != 0) {
+		printk(KERN_ERR "VMI ROM failed to initialize!");
+		return 0;
+	}
+	savesegment(cs, kernel_cs);
+
+	paravirt_ops.paravirt_enabled = 1;
+	paravirt_ops.kernel_rpl = kernel_cs & SEGMENT_RPL_MASK;
+
+	paravirt_ops.patch = vmi_patch;
+	paravirt_ops.name = "vmi";
+
+	/*
+	 * Many of these operations are ABI compatible with VMI.
+	 * This means we can fill in the paravirt-ops with direct
+	 * pointers into the VMI ROM.  If the calling convention for
+	 * these operations changes, this code needs to be updated.
+	 * 
+	 * Exceptions
+	 *  CPUID paravirt-op uses pointers, not the native ISA
+	 *  halt has no VMI equivalent; all VMI halts are "safe"
+	 *  no MSR support yet - just trap and emulate.  VMI uses the
+	 *    same ABI as the native ISA, but Linux wants exceptions
+	 *    from bogus MSR read / write handled
+	 *  rdpmc is not yet used in Linux
+	 */
+
+	/* CPUID is special, so very special */
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,	VMI_CALL_CPUID);
+	if (rel->type != VMI_RELOCATION_NONE) {
+		BUG_ON(rel->type != VMI_RELOCATION_CALL_REL);
+		vmi_ops.cpuid = (void *)rel->eip;
+		paravirt_ops.cpuid = vmi_cpuid;
+	}
+
+	para_fill(clts, CLTS);
+	para_fill(get_debugreg, GetDR);
+	para_fill(set_debugreg, SetDR);
+	para_fill(read_cr0, GetCR0);
+	para_fill(read_cr2, GetCR2);
+	para_fill(read_cr3, GetCR3);
+	para_fill(read_cr4, GetCR4);
+	para_fill(write_cr0, SetCR0);
+	para_fill(write_cr2, SetCR2);
+	para_fill(write_cr3, SetCR3);
+	para_fill(write_cr4, SetCR4);
+	para_fill(save_fl, GetInterruptMask);
+	para_fill(restore_fl, SetInterruptMask);
+	para_fill(irq_disable, DisableInterrupts);
+	para_fill(irq_enable, EnableInterrupts);
+	/* irq_save_disable !!! sheer pain */
+	patch_offset(&irq_save_disable_callout[IRQ_PATCH_INT_MASK],
+		     (char *)paravirt_ops.save_fl);
+	patch_offset(&irq_save_disable_callout[IRQ_PATCH_DISABLE],
+		     (char *)paravirt_ops.irq_disable);
+	para_fill(safe_halt, Halt);
+	para_fill(wbinvd, WBINVD);
+	/* paravirt_ops.read_msr = vmi_rdmsr */
+	/* paravirt_ops.write_msr = vmi_wrmsr */
+	para_fill(read_tsc, RDTSC);
+	/* paravirt_ops.rdpmc = vmi_rdpmc */
+
+	/* TR interface doesn't pass TR value */
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,	VMI_CALL_SetTR);
+	if (rel->type != VMI_RELOCATION_NONE) {
+		BUG_ON(rel->type != VMI_RELOCATION_CALL_REL);
+		vmi_ops.set_tr = (void *)rel->eip;
+		paravirt_ops.load_tr_desc = vmi_set_tr;
+	}
+
+	/* LDT is special, too */
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,	VMI_CALL_SetLDT);
+	if (rel->type != VMI_RELOCATION_NONE) {
+		BUG_ON(rel->type != VMI_RELOCATION_CALL_REL);
+		vmi_ops._set_ldt = (void *)rel->eip;
+		paravirt_ops.set_ldt = vmi_set_ldt;
+	}
+
+	para_fill(load_gdt, SetGDT);
+	para_fill(load_idt, SetIDT);
+	para_fill(store_gdt, GetGDT);
+	para_fill(store_idt, GetIDT);
+	para_fill(store_tr, GetTR);
+	paravirt_ops.load_tls = vmi_load_tls;
+	para_fill(write_ldt_entry, WriteLDTEntry);
+	para_fill(write_gdt_entry, WriteGDTEntry);
+	para_fill(write_idt_entry, WriteIDTEntry);
+	reloc = call_vrom_long_func(vmi_rom, get_reloc,
+				    VMI_CALL_UpdateKernelStack);
+	if (rel->type != VMI_RELOCATION_NONE) {
+		BUG_ON(rel->type != VMI_RELOCATION_CALL_REL);
+		vmi_ops.set_kernel_stack = (void *)rel->eip;
+		paravirt_ops.load_esp0 = vmi_load_esp0;
+	}
+
+	para_fill(set_iopl_mask, SetIOPLMask);
+	paravirt_ops.io_delay = (void *)vmi_nop;
+	if (!disable_nodelay) {
+		paravirt_ops.const_udelay = (void *)vmi_nop;
+	}
+
+	para_fill(set_lazy_mode, SetLazyMode);
+
+	reloc = call_vrom_long_func(vmi_rom, get_reloc, VMI_CALL_FlushTLB);
+	if (rel->type != VMI_RELOCATION_NONE) {
+		vmi_ops.flush_tlb = (void *)rel->eip;
+		paravirt_ops.flush_tlb_user = vmi_flush_tlb_user;
+		paravirt_ops.flush_tlb_kernel = vmi_flush_tlb_kernel;
+	}
+	para_fill(flush_tlb_single, InvalPage);
+
+	/*
+	 * Until a standard flag format can be agreed on, we need to
+	 * implement these as wrappers in Linux.  Get the VMI ROM
+	 * function pointers for the two backend calls.
+	 */
+#ifdef CONFIG_X86_PAE
+	vmi_ops.set_pte = vmi_get_function(VMI_CALL_SetPxELong);
+	vmi_ops.update_pte = vmi_get_function(VMI_CALL_UpdatePxELong);
+#else
+	vmi_ops.set_pte = vmi_get_function(VMI_CALL_SetPxE);
+	vmi_ops.update_pte = vmi_get_function(VMI_CALL_UpdatePxE);
+#endif
+	vmi_ops.set_linear_mapping = vmi_get_function(VMI_CALL_SetLinearMapping);
+	vmi_ops.allocate_page = vmi_get_function(VMI_CALL_AllocatePage);
+	vmi_ops.release_page = vmi_get_function(VMI_CALL_ReleasePage);
+
+	paravirt_ops.alloc_pt = vmi_allocate_pt;
+	paravirt_ops.alloc_pd = vmi_allocate_pd;
+	paravirt_ops.alloc_pd_clone = vmi_allocate_pd_clone;
+	paravirt_ops.release_pt = vmi_release_pt;
+	paravirt_ops.release_pd = vmi_release_pd;
+	paravirt_ops.set_pte = vmi_set_pte;
+	paravirt_ops.set_pte_at = vmi_set_pte_at;
+	paravirt_ops.set_pmd = vmi_set_pmd;
+	paravirt_ops.pte_update = vmi_update_pte;
+	paravirt_ops.pte_update_defer = vmi_update_pte_defer;
+#ifdef CONFIG_X86_PAE
+	paravirt_ops.set_pte_atomic = vmi_set_pte_atomic;
+	paravirt_ops.set_pte_present = vmi_set_pte_present;
+	paravirt_ops.set_pud = vmi_set_pud;
+	paravirt_ops.pte_clear = vmi_pte_clear;
+	paravirt_ops.pmd_clear = vmi_pmd_clear;
+#endif
+	/*
+	 * These MUST always be patched.  Don't support indirect jumps
+	 * through these operations, as the VMI interface may use either
+	 * a jump or a call to get to these operations, depending on
+	 * the backend.  They are performance critical anyway, so requiring
+	 * a patch is not a big problem.
+	 */
+	paravirt_ops.irq_enable_sysexit = (void *)0xfeedbab0;
+	paravirt_ops.iret = (void *)0xbadbab0;
+
+#ifdef CONFIG_SMP
+	paravirt_ops.startup_ipi_hook = vmi_startup_ipi_hook;
+	vmi_ops.set_initial_ap_state = vmi_get_function(VMI_CALL_SetInitialAPState);
+#endif
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	paravirt_ops.apic_read = vmi_get_function(VMI_CALL_APICRead);
+	paravirt_ops.apic_write = vmi_get_function(VMI_CALL_APICWrite);
+	paravirt_ops.apic_write_atomic = vmi_get_function(VMI_CALL_APICWrite);
+#endif
+
+	/*
+	 * Alternative instruction rewriting doesn't happen soon enough
+	 * to convert VMI_IRET to a call instead of a jump; so we have
+	 * to do this before IRQs get reenabled.  Fortunately, it is
+	 * idempotent.
+	 */
+	apply_paravirt(__start_parainstructions, __stop_parainstructions);
+
+	vmi_bringup();
+	
+	return 1;
+}
+
+#undef para_fill
+
+void __init vmi_init(void)
+{
+	unsigned long flags;
+
+	if (!vmi_rom)
+		probe_vmi_rom();
+	else
+		check_vmi_rom(vmi_rom);
+
+	/* In case probing for or validating the ROM failed, basil */
+	if (!vmi_rom)
+		return;
+
+	reserve_top_address(-vmi_rom->virtual_top);
+
+	local_irq_save(flags);
+	activate_vmi();
+	no_timer_check = 1;
+	local_irq_restore(flags & X86_EFLAGS_IF);
+}
+
+static int __init parse_vmi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "disable_nodelay"))
+		disable_nodelay = 1;
+	else if (!strcmp(arg, "disable_pge")) {
+		clear_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability);
+		disable_pge = 1;
+	} else if (!strcmp(arg, "disable_pse")) {
+		clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
+		disable_pse = 1;
+	} else if (!strcmp(arg, "disable_sep")) {
+		clear_bit(X86_FEATURE_SEP, boot_cpu_data.x86_capability);
+		disable_sep = 1;
+	} else if (!strcmp(arg, "disable_tsc")) {
+		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
+		disable_tsc = 1;
+	} else if (!strcmp(arg, "disable_mtrr")) {
+		clear_bit(X86_FEATURE_MTRR, boot_cpu_data.x86_capability);
+		disable_mtrr = 1;
+	}
+	return 0;
+}
+
+early_param("vmi", parse_vmi);
diff -r d8711b11c1eb include/asm-i386/vmi.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/vmi.h	Tue Dec 12 13:51:13 2006 -0800
@@ -0,0 +1,262 @@
+/*
+ * VMI interface definition
+ *
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Maintained by: Zachary Amsden zach@vmware.com
+ *
+ */
+#include <linux/types.h>
+
+/*
+ *---------------------------------------------------------------------
+ *
+ *  VMI Option ROM API
+ *
+ *---------------------------------------------------------------------
+ */
+#define VMI_SIGNATURE 0x696d5663   /* "cVmi" */
+
+#define PCI_VENDOR_ID_VMWARE            0x15AD
+#define PCI_DEVICE_ID_VMWARE_VMI        0x0801
+
+/*
+ * We use two version numbers for compatibility, with the major
+ * number signifying interface breakages, and the minor number
+ * interface extensions.
+ */
+#define VMI_API_REV_MAJOR       3
+#define VMI_API_REV_MINOR       0
+
+#define VMI_CALL_CPUID			0
+#define VMI_CALL_WRMSR			1
+#define VMI_CALL_RDMSR			2
+#define VMI_CALL_SetGDT			3
+#define VMI_CALL_SetLDT			4
+#define VMI_CALL_SetIDT			5
+#define VMI_CALL_SetTR			6
+#define VMI_CALL_GetGDT			7
+#define VMI_CALL_GetLDT			8
+#define VMI_CALL_GetIDT			9
+#define VMI_CALL_GetTR			10
+#define VMI_CALL_WriteGDTEntry		11
+#define VMI_CALL_WriteLDTEntry		12
+#define VMI_CALL_WriteIDTEntry		13
+#define VMI_CALL_UpdateKernelStack	14
+#define VMI_CALL_SetCR0			15
+#define VMI_CALL_SetCR2			16
+#define VMI_CALL_SetCR3			17
+#define VMI_CALL_SetCR4			18
+#define VMI_CALL_GetCR0			19
+#define VMI_CALL_GetCR2			20
+#define VMI_CALL_GetCR3			21
+#define VMI_CALL_GetCR4			22
+#define VMI_CALL_WBINVD			23
+#define VMI_CALL_SetDR			24
+#define VMI_CALL_GetDR			25
+#define VMI_CALL_RDPMC			26
+#define VMI_CALL_RDTSC			27
+#define VMI_CALL_CLTS			28
+#define VMI_CALL_EnableInterrupts	29
+#define VMI_CALL_DisableInterrupts	30
+#define VMI_CALL_GetInterruptMask	31
+#define VMI_CALL_SetInterruptMask	32
+#define VMI_CALL_IRET			33
+#define VMI_CALL_SYSEXIT		34
+#define VMI_CALL_Halt			35
+#define VMI_CALL_Reboot			36
+#define VMI_CALL_Shutdown		37
+#define VMI_CALL_SetPxE			38
+#define VMI_CALL_SetPxELong		39
+#define VMI_CALL_UpdatePxE		40
+#define VMI_CALL_UpdatePxELong		41
+#define VMI_CALL_MachineToPhysical	42
+#define VMI_CALL_PhysicalToMachine	43
+#define VMI_CALL_AllocatePage		44
+#define VMI_CALL_ReleasePage		45
+#define VMI_CALL_InvalPage		46
+#define VMI_CALL_FlushTLB		47
+#define VMI_CALL_SetLinearMapping	48
+  
+#define VMI_CALL_SetIOPLMask		61
+#define VMI_CALL_SetInitialAPState	62
+#define VMI_CALL_APICWrite		63
+#define VMI_CALL_APICRead		64
+#define VMI_CALL_SetLazyMode		73
+
+/*
+ *---------------------------------------------------------------------
+ *
+ * MMU operation flags
+ *
+ *---------------------------------------------------------------------
+ */
+
+/* Flags used by VMI_{Allocate|Release}Page call */
+#define VMI_PAGE_PAE             0x10  /* Allocate PAE shadow */
+#define VMI_PAGE_CLONE           0x20  /* Clone from another shadow */
+#define VMI_PAGE_ZEROED          0x40  /* Page is pre-zeroed */
+
+
+/* Flags shared by Allocate|Release Page and PTE updates */
+#define VMI_PAGE_PT              0x01
+#define VMI_PAGE_PD              0x02
+#define VMI_PAGE_PDP             0x04
+#define VMI_PAGE_PML4            0x08
+
+#define VMI_PAGE_NORMAL          0x00 /* for debugging */
+
+/* Flags used by PTE updates */
+#define VMI_PAGE_CURRENT_AS      0x10 /* implies VMI_PAGE_VA_MASK is valid */
+#define VMI_PAGE_DEFER           0x20 /* may queue update until TLB inval */
+#define VMI_PAGE_VA_MASK         0xfffff000
+
+#ifdef CONFIG_X86_PAE
+#define VMI_PAGE_L1		(VMI_PAGE_PT | VMI_PAGE_PAE | VMI_PAGE_ZEROED)
+#define VMI_PAGE_L2		(VMI_PAGE_PD | VMI_PAGE_PAE | VMI_PAGE_ZEROED)
+#else
+#define VMI_PAGE_L1		(VMI_PAGE_PT | VMI_PAGE_ZEROED)
+#define VMI_PAGE_L2		(VMI_PAGE_PD | VMI_PAGE_ZEROED)
+#endif
+
+/* Flags used by VMI_FlushTLB call */
+#define VMI_FLUSH_TLB            0x01
+#define VMI_FLUSH_GLOBAL         0x02
+
+/*
+ *---------------------------------------------------------------------
+ *
+ *  VMI relocation definitions for ROM call get_reloc
+ *
+ *---------------------------------------------------------------------
+ */
+
+/* VMI Relocation types */
+#define VMI_RELOCATION_NONE     0
+#define VMI_RELOCATION_CALL_REL 1
+#define VMI_RELOCATION_JUMP_REL 2
+#define VMI_RELOCATION_NOP	3
+
+#ifndef __ASSEMBLY__
+struct vmi_relocation_info {
+        unsigned char           *eip;
+        unsigned char           type;
+        unsigned char           reserved[3];
+};
+#endif
+
+
+/*
+ *---------------------------------------------------------------------
+ *
+ *  Generic ROM structures and definitions
+ *
+ *---------------------------------------------------------------------
+ */
+
+#ifndef __ASSEMBLY__
+
+struct vrom_header {
+	u16     rom_signature;  // option ROM signature
+	u8      rom_length;     // ROM length in 512 byte chunks
+	u8      rom_entry[4];   // 16-bit code entry point
+	u8      rom_pad0;       // 4-byte align pad
+	u32     vrom_signature; // VROM identification signature
+	u8      api_version_min;// Minor version of API
+	u8      api_version_maj;// Major version of API
+	u8      jump_slots;     // Number of jump slots
+	u8      reserved1;      // Reserved for expansion
+	u32     virtual_top;    // Hypervisor virtual address start
+	u16     reserved2;      // Reserved for expansion
+	u16	license_offs;	// Offset to License string
+	u16     pci_header_offs;// Offset to PCI OPROM header
+	u16     pnp_header_offs;// Offset to PnP OPROM header
+	u32     rom_pad3;       // PnP reserverd / VMI reserved
+	u8      reserved[96];   // Reserved for headers
+	char    vmi_init[8];    // VMI_Init jump point
+	char    get_reloc[8];   // VMI_GetRelocationInfo jump point
+} __attribute__((packed));
+
+struct pnp_header {
+        char sig[4];
+        char rev;
+        char size;
+        short next;
+        short res;
+        long devID;
+        unsigned short manufacturer_offset;
+        unsigned short product_offset;
+} __attribute__((packed));
+
+struct pci_header {
+        char sig[4];
+        short vendorID;
+        short deviceID;
+        short vpdData;
+        short size;
+        char rev;
+        char class;
+        char subclass;
+        char interface;
+        short chunks;
+        char rom_version_min;
+        char rom_version_maj;
+        char codetype;
+        char lastRom;
+        short reserved;
+} __attribute__((packed));
+
+/* Function prototypes for bootstrapping */
+extern void vmi_init(void);
+extern void vmi_bringup(void);
+extern void vmi_apply_boot_page_allocations(void);
+
+/* State needed to start an application processor in an SMP system. */
+struct vmi_ap_state {
+	u32 cr0;
+	u32 cr2;
+	u32 cr3;
+	u32 cr4;
+
+	u64 efer;
+
+	u32 eip;
+	u32 eflags;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u32 esp;
+	u32 ebp;
+	u32 esi;
+	u32 edi;
+	u16 cs;
+	u16 ss;
+	u16 ds;
+	u16 es;
+	u16 fs;
+	u16 gs;
+	u16 ldtr;
+
+	u16 gdtr_limit;
+	u32 gdtr_base;
+	u32 idtr_base;
+	u16 idtr_limit;
+};
+
+#endif
