Return-Path: <linux-kernel-owner+w=401wt.eu-S1422821AbXAMXMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbXAMXMK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbXAMXLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:11:46 -0500
Received: from gw.goop.org ([64.81.55.164]:59915 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030536AbXAMXLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:11:07 -0500
Message-Id: <20070113014648.636003392@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:54 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chris@sous-sol.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [patch 15/20] XEN-paravirt: Xen: core paravirt guest changes
Content-Disposition: inline; filename=xen-core.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core of the Xen implementation of the paravirt_ops
interface.  It consists of the following parts:

* Boot

The kernel provides Xen with a Xen-specific entrypoint.  This
entrypoint simply saves away the Xen boot-info structure pointer
(initially in %esi), and jumps to the common paravirt entrypoint.
This will do the normal paravirt probe; in the Xen case, the probe
simply looks for a non-NULL xen start_info pointer.

The xen_start_kernel() function does the functional equivalent of
head.S, and sets up the basic kernel environment before calling
start_kernel().  This is simpler than the native case because the
hypervisor has already started the kernel with a pagetable setup and
paging enabled.  A number of CPU feature checks are redundant because
Xen's minimum CPU requirements are higher than a native Linux boot.

Having called start_kernel(), the bulk of the Xen backends
interactions with the rest of the kernel are via the various
paravirt_ops entrypoints.

* Memory management

This Xen guest code only implements direct pagetables (rather than
shadow pagetables), so the guest is responsible for creating a
suitable pagetable which can be directly used by the CPU.

This places a few constraints on how the initial pagetable is
constructed vs native boots.  In particular, if PAE is enabled, then
Xen does not allow the guest to share the kernel PMD between multiple
processes (since Xen has its own per-pagetable mappings in this page
as well).

Also, Xen requires all pagetable pages to be mapped read-only in all
pagetables.  To achieve this, all processes share the kernelk pte
pages; this way marking a kernel page read-only in one process will be
automatically reflected in all other processes.

Since in this mode, all pagetable entries contains machine frame
numbers (MFNs), all pagetable updates/reads must translate PFNs
to/from MFNs.  This is not complex, but there are rather a lot of
little hook functions to perform this translation.

The Xen guest also implements late-pin/early-unpin for pagetables.
This means that when creating a new pagetable (on fork or exec), as
much setup is done as possible while the pages are just normal RW
pages, and when pulling down a pagetable on exit, the pages are make
RW before updating all the entries.  This allows these operations to
be peformed with as little hypervisor interaction as possible.

* Context switches

The Xen guest implements batched hypercalls, so that context switches
can be done with a single hypercall.  A typical context switch will
update the kernel stack pointer, and then write the 3 TLS GDT entries;
some context switches will also need to do an LDT update.

* Interrupts

Xen implements interrupts with general event channels.  The Xen guest
code maps these onto dynamically-allocated IRQs.  When Xen wishes to
raise an event, it makes a callback into the kernel code.  This takes
event number, maps it into an IRQ and then feeds it into the top of
the normal interrupt delivery path.

* Time

The hypervisor maintains a nanosecond timebase.  This is exposed to
guests via the tsc; the guests can use the tsc to extrapolate the
current nanosecond timebase without having to make a hypercall.  This
is exposed to the kernel timecode as a clocksource.

The guest also sets up a periodic timer event to drive the jiffies
tick timebase.  The timer tick is turned off while everything is idle,
and replaced with a tick scheduled for the next timeout (if any).

* SMP

This code is UP-only at present, though almost everything here is
already SMP-safe.  All it really lacks is the means to start/stop new
vcpus.


Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ian Pratt <ian.pratt@xensource.com>
Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>

---
 arch/i386/Makefile                  |    3 
 arch/i386/kernel/cpu/common.c       |    3 
 arch/i386/kernel/entry.S            |   77 +++
 arch/i386/kernel/head.S             |   12 
 arch/i386/kernel/paravirt.c         |   48 +-
 arch/i386/kernel/vmlinux.lds.S      |    1 
 arch/i386/mm/pgtable.c              |    1 
 arch/i386/paravirt-xen/Makefile     |    2 
 arch/i386/paravirt-xen/enlighten.c  |  805 +++++++++++++++++++++++++++++++++++
 arch/i386/paravirt-xen/events.c     |  473 ++++++++++++++++++++
 arch/i386/paravirt-xen/events.h     |   28 +
 arch/i386/paravirt-xen/features.c   |   29 +
 arch/i386/paravirt-xen/memory.c     |   50 ++
 arch/i386/paravirt-xen/mmu.c        |  375 ++++++++++++++++
 arch/i386/paravirt-xen/mmu.h        |   51 ++
 arch/i386/paravirt-xen/multicalls.c |   62 ++
 arch/i386/paravirt-xen/multicalls.h |   13 
 arch/i386/paravirt-xen/setup.c      |   96 ++++
 arch/i386/paravirt-xen/time.c       |  446 +++++++++++++++++++
 arch/i386/paravirt-xen/xen-head.S   |   29 +
 arch/i386/paravirt-xen/xen-ops.h    |   20 
 arch/i386/paravirt-xen/xen-page.h   |  175 +++++++
 include/asm-i386/hypercall.h        |   21 
 include/asm-i386/irq.h              |    1 
 include/asm-i386/paravirt.h         |   42 +
 include/asm-i386/pda.h              |   11 
 include/xen/features.h              |   26 +
 27 files changed, 2871 insertions(+), 29 deletions(-)

===================================================================
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -93,6 +93,9 @@ mcore-$(CONFIG_X86_ES7000)	:= mach-defau
 mcore-$(CONFIG_X86_ES7000)	:= mach-default
 core-$(CONFIG_X86_ES7000)	:= arch/i386/mach-es7000/
 
+# Xen paravirtualization support
+core-$(CONFIG_XEN)		+= arch/i386/paravirt-xen/
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -19,6 +19,7 @@
 #include <mach_apic.h>
 #endif
 #include <asm/pda.h>
+#include <asm/paravirt.h>
 
 #include "cpu.h"
 
@@ -707,6 +708,8 @@ __cpuinit int init_gdt(int cpu, struct t
 	pda->cpu_number = cpu;
 	pda->pcurrent = idle;
 
+	paravirt_init_pda(pda, cpu);
+
 	return 1;
 }
 
===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -997,6 +997,83 @@ ENTRY(kernel_thread_helper)
 	CFI_ENDPROC
 ENDPROC(kernel_thread_helper)
 
+#ifdef CONFIG_XEN
+/* Xen only supports sysenter/sysexit in ring0 guests,
+   and only if it the guest asks for it.  So for now,
+   this should never be used. */
+ENTRY(xen_sti_sysexit)
+	CFI_STARTPROC
+	ud2
+	CFI_ENDPROC
+	
+ENTRY(xen_hypervisor_callback)
+	CFI_STARTPROC
+	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
+	SAVE_ALL
+	mov %esp, %eax
+	call xen_evtchn_do_upcall
+	jmp  ret_from_intr
+	CFI_ENDPROC
+	
+# Hypervisor uses this for application faults while it executes.
+# We get here for two reasons:
+#  1. Fault while reloading DS, ES, FS or GS
+#  2. Fault while executing IRET
+# Category 1 we fix up by reattempting the load, and zeroing the segment
+# register if the load fails.
+# Category 2 we fix up by jumping to do_iret_error. We cannot use the
+# normal Linux return path in this case because if we use the IRET hypercall
+# to pop the stack frame we end up in an infinite loop of failsafe callbacks.
+# We distinguish between categories by maintaining a status value in EAX.
+ENTRY(xen_failsafe_callback)
+	CFI_STARTPROC
+	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
+	movl $1,%eax
+1:	mov 4(%esp),%ds
+2:	mov 8(%esp),%es
+3:	mov 12(%esp),%fs
+4:	mov 16(%esp),%gs
+	testl %eax,%eax
+	popl %eax
+	CFI_ADJUST_CFA_OFFSET -4
+	jz 5f
+	addl $16,%esp		# EAX != 0 => Category 2 (Bad IRET)
+	CFI_ADJUST_CFA_OFFSET -16
+	jmp iret_exc
+5:	addl $16,%esp		# EAX == 0 => Category 1 (Bad segment)
+	CFI_ADJUST_CFA_OFFSET -16
+	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
+	SAVE_ALL
+	jmp ret_from_exception
+	CFI_ENDPROC
+	
+.section .fixup,"ax"
+6:	xorl %eax,%eax
+	movl %eax,4(%esp)
+	jmp 1b
+7:	xorl %eax,%eax
+	movl %eax,8(%esp)
+	jmp 2b
+8:	xorl %eax,%eax
+	movl %eax,12(%esp)
+	jmp 3b
+9:	xorl %eax,%eax
+	movl %eax,16(%esp)
+	jmp 4b
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,6b
+	.long 2b,7b
+	.long 3b,8b
+	.long 4b,9b
+.previous
+		
+#endif	/* CONFIG_XEN */
+	
 .section .rodata,"a"
 #include "syscall_table.S"
 
===================================================================
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -530,6 +530,10 @@ 1:
 	jmp	1b
 #endif
 
+#ifdef CONFIG_XEN
+#include "../paravirt-xen/xen-head.S"
+#endif
+	
 /*
  * Real beginning of normal "text" segment
  */
@@ -539,7 +543,7 @@ ENTRY(_stext)
 /*
  * BSS section
  */
-.section ".bss.page_aligned","w"
+.section ".bss.page_aligned"
 ENTRY(swapper_pg_dir)
 	.fill 1024,4,0
 ENTRY(empty_zero_page)
@@ -609,7 +613,8 @@ ENTRY(boot_gdt_table)
 /*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
-	.align L1_CACHE_BYTES
+	.section ".data.page_aligned"
+	.align PAGE_SIZE_asm
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */
@@ -658,3 +663,6 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* 0xf0 - unused */
 	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
 
+	/* Be sure this is zeroed to avoid false validations in Xen */
+	.fill PAGE_SIZE_asm / 8 - GDT_ENTRIES,8,0
+	.previous
===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -146,55 +146,55 @@ void init_IRQ(void)
 	paravirt_ops.init_IRQ();
 }
 
-static fastcall void native_clts(void)
+fastcall void native_clts(void)
 {
 	asm volatile ("clts");
 }
 
-static fastcall unsigned long native_read_cr0(void)
+fastcall unsigned long native_read_cr0(void)
 {
 	unsigned long val;
 	asm volatile("movl %%cr0,%0\n\t" :"=r" (val));
 	return val;
 }
 
-static fastcall void native_write_cr0(unsigned long val)
+fastcall void native_write_cr0(unsigned long val)
 {
 	asm volatile("movl %0,%%cr0": :"r" (val));
 }
 
-static fastcall unsigned long native_read_cr2(void)
+fastcall unsigned long native_read_cr2(void)
 {
 	unsigned long val;
 	asm volatile("movl %%cr2,%0\n\t" :"=r" (val));
 	return val;
 }
 
-static fastcall void native_write_cr2(unsigned long val)
+fastcall void native_write_cr2(unsigned long val)
 {
 	asm volatile("movl %0,%%cr2": :"r" (val));
 }
 
-static fastcall unsigned long native_read_cr3(void)
+fastcall unsigned long native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("movl %%cr3,%0\n\t" :"=r" (val));
 	return val;
 }
 
-static fastcall void native_write_cr3(unsigned long val)
+fastcall void native_write_cr3(unsigned long val)
 {
 	asm volatile("movl %0,%%cr3": :"r" (val));
 }
 
-static fastcall unsigned long native_read_cr4(void)
+fastcall unsigned long native_read_cr4(void)
 {
 	unsigned long val;
 	asm volatile("movl %%cr4,%0\n\t" :"=r" (val));
 	return val;
 }
 
-static fastcall unsigned long native_read_cr4_safe(void)
+fastcall unsigned long native_read_cr4_safe(void)
 {
 	unsigned long val;
 	/* This could fault if %cr4 does not exist */
@@ -207,7 +207,7 @@ static fastcall unsigned long native_rea
 	return val;
 }
 
-static fastcall void native_write_cr4(unsigned long val)
+fastcall void native_write_cr4(unsigned long val)
 {
 	asm volatile("movl %0,%%cr4": :"r" (val));
 }
@@ -246,12 +246,12 @@ static fastcall void native_halt(void)
 	asm volatile("hlt": : :"memory");
 }
 
-static fastcall void native_wbinvd(void)
+fastcall void native_wbinvd(void)
 {
 	asm volatile("wbinvd": : :"memory");
 }
 
-static fastcall unsigned long long native_read_msr(unsigned int msr, int *err)
+fastcall unsigned long long native_read_msr(unsigned int msr, int *err)
 {
 	unsigned long long val;
 
@@ -270,7 +270,7 @@ static fastcall unsigned long long nativ
 	return val;
 }
 
-static fastcall int native_write_msr(unsigned int msr, unsigned long long val)
+fastcall int native_write_msr(unsigned int msr, unsigned long long val)
 {
 	int err;
 	asm volatile("2: wrmsr ; xorl %0,%0\n"
@@ -288,14 +288,14 @@ static fastcall int native_write_msr(uns
 	return err;
 }
 
-static fastcall unsigned long long native_read_tsc(void)
+fastcall unsigned long long native_read_tsc(void)
 {
 	unsigned long long val;
 	asm volatile("rdtsc" : "=A" (val));
 	return val;
 }
 
-static fastcall unsigned long long native_read_pmc(void)
+fastcall unsigned long long native_read_pmc(void)
 {
 	unsigned long long val;
 	asm volatile("rdpmc" : "=A" (val));
@@ -317,17 +317,17 @@ static fastcall void native_load_idt(con
 	asm volatile("lidt %0"::"m" (*dtr));
 }
 
-static fastcall void native_store_gdt(struct Xgt_desc_struct *dtr)
+fastcall void native_store_gdt(struct Xgt_desc_struct *dtr)
 {
 	asm ("sgdt %0":"=m" (*dtr));
 }
 
-static fastcall void native_store_idt(struct Xgt_desc_struct *dtr)
+fastcall void native_store_idt(struct Xgt_desc_struct *dtr)
 {
 	asm ("sidt %0":"=m" (*dtr));
 }
 
-static fastcall unsigned long native_store_tr(void)
+fastcall unsigned long native_store_tr(void)
 {
 	unsigned long tr;
 	asm ("str %0":"=r" (tr));
@@ -336,9 +336,9 @@ static fastcall unsigned long native_sto
 
 static fastcall void native_load_tls(struct thread_struct *t, unsigned int cpu)
 {
-#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
-	C(0); C(1); C(2);
-#undef C
+	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 0] = t->tls_array[0];
+	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 1] = t->tls_array[1];
+	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 2] = t->tls_array[2];
 }
 
 static inline void native_write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
@@ -348,17 +348,17 @@ static inline void native_write_dt_entry
 	lp[1] = entry_high;
 }
 
-static fastcall void native_write_ldt_entry(void *dt, int entrynum, u32 low, u32 high)
+fastcall void native_write_ldt_entry(void *dt, int entrynum, u32 low, u32 high)
 {
 	native_write_dt_entry(dt, entrynum, low, high);
 }
 
-static fastcall void native_write_gdt_entry(void *dt, int entrynum, u32 low, u32 high)
+fastcall void native_write_gdt_entry(void *dt, int entrynum, u32 low, u32 high)
 {
 	native_write_dt_entry(dt, entrynum, low, high);
 }
 
-static fastcall void native_write_idt_entry(void *dt, int entrynum, u32 low, u32 high)
+fastcall void native_write_idt_entry(void *dt, int entrynum, u32 low, u32 high)
 {
 	native_write_dt_entry(dt, entrynum, low, high);
 }
===================================================================
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -100,6 +100,7 @@ SECTIONS
 
   . = ALIGN(4096);
   .data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
+	*(.data.page_aligned)
 	*(.data.idt)
   }
 
===================================================================
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -267,6 +267,7 @@ static void pgd_ctor(pgd_t *pgd)
 					swapper_pg_dir + USER_PTRS_PER_PGD,
 					KERNEL_PGD_PTRS);
 		} else {
+			memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 			spin_lock_irqsave(&pgd_lock, flags);
 			pgd_list_add(pgd);
 			spin_unlock_irqrestore(&pgd_lock, flags);
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/Makefile
@@ -0,0 +1,2 @@
+obj-y		:= enlighten.o setup.o events.o memory.o time.o \
+			features.o mmu.o multicalls.o
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/enlighten.c
@@ -0,0 +1,805 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/preempt.h>
+#include <linux/percpu.h>
+#include <linux/delay.h>
+#include <linux/start_kernel.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+
+#include <xen/interface/xen.h>
+#include <xen/features.h>
+
+#include <asm/paravirt.h>
+#include <asm/page.h>
+#include <asm/hypercall.h>
+#include <asm/hypervisor.h>
+#include <asm/fixmap.h>
+#include <asm/processor.h>
+#include <asm/setup.h>
+#include <asm/desc.h>
+#include <asm/pgtable.h>
+
+#include "xen-ops.h"
+#include "xen-page.h"
+#include "mmu.h"
+#include "multicalls.h"
+
+extern struct Xgt_desc_struct cpu_gdt_descr;
+extern struct i386_pda boot_pda;
+extern unsigned long init_pg_tables_end;
+
+static DEFINE_PER_CPU(unsigned, lazy_mode);
+
+/* Code defined in entry.S (not a function) */
+extern const char xen_sti_sysexit[];
+
+struct start_info *xen_start_info;
+
+static unsigned xen_patch(u8 type, u16 clobber, void *firstinsn, unsigned len)
+{
+	/* Xen will require relocations to patch calls and jmps, and
+	   perhaps chunks of inline code */
+	return len;
+}
+
+static void __init xen_banner(void)
+{
+	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
+	       paravirt_ops.name);
+	printk(KERN_INFO "Hypervisor signature: %s\n", xen_start_info->magic);
+}
+
+static void xen_init_pda(struct i386_pda *pda, int cpu)
+{
+	/* Don't re-init boot CPU; we do it once very early in boot,
+	   and then then cpu_init tries to do it again. If so, just
+	   reuse the stuff we already set up. */
+	if (cpu == 0 && pda != &boot_pda) {
+		BUG_ON(boot_pda.xen.vcpu == NULL);
+		pda->xen = boot_pda.xen;
+		return;
+	}
+
+	pda->xen.vcpu = &HYPERVISOR_shared_info->vcpu_info[cpu];
+	pda->xen.cr3 = 0;
+}
+
+static fastcall void xen_cpuid(unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	unsigned maskedx = ~0;
+	if (*eax == 1)
+		maskedx = ~(1 << X86_FEATURE_APIC);
+
+	asm(XEN_EMULATE_PREFIX "cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx));
+	*edx &= maskedx;
+}
+
+static fastcall void xen_set_debugreg(int reg, unsigned long val)
+{
+	HYPERVISOR_set_debugreg(reg, val);
+}
+
+static fastcall unsigned long xen_get_debugreg(int reg)
+{
+	return HYPERVISOR_get_debugreg(reg);
+}
+
+static fastcall unsigned long xen_save_fl(void)
+{
+	struct vcpu_info *vcpu;
+	unsigned long flags;
+
+	preempt_disable();
+	vcpu = read_pda(xen.vcpu);
+	/* flag has opposite sense of mask */
+	flags = !vcpu->evtchn_upcall_mask;
+	preempt_enable();
+
+	/* convert to IF type flag 
+	   -0 -> 0x00000000
+	   -1 -> 0xffffffff
+	*/
+	return (-flags) & X86_EFLAGS_IF;
+}
+
+static fastcall void xen_restore_fl(unsigned long flags)
+{
+	struct vcpu_info *vcpu;
+
+	preempt_disable();
+
+	/* convert from IF type flag */
+	flags = !(flags & X86_EFLAGS_IF);
+	vcpu = read_pda(xen.vcpu);
+	vcpu->evtchn_upcall_mask = flags;
+	if (flags == 0) {
+		barrier(); /* unmask then check (avoid races) */
+		if (unlikely(vcpu->evtchn_upcall_pending))
+			force_evtchn_callback();
+		preempt_enable();
+	} else
+		preempt_enable_no_resched();
+}
+
+static fastcall void xen_irq_disable(void)
+{
+	struct vcpu_info *vcpu;
+	preempt_disable();
+	vcpu = read_pda(xen.vcpu);
+	vcpu->evtchn_upcall_mask = 1;
+	preempt_enable_no_resched();
+}
+
+static fastcall void xen_irq_enable(void)
+{
+	struct vcpu_info *vcpu;
+
+	preempt_disable();
+	vcpu = read_pda(xen.vcpu);
+	vcpu->evtchn_upcall_mask = 0;
+	barrier(); /* unmask then check (avoid races) */
+	if (unlikely(vcpu->evtchn_upcall_pending))
+		force_evtchn_callback();
+	preempt_enable();
+}
+
+static fastcall void xen_safe_halt(void)
+{
+	stop_hz_timer();
+	/* Blocking includes an implicit local_irq_enable(). */
+	if (HYPERVISOR_sched_op(SCHEDOP_block, 0) != 0)
+		BUG();
+	start_hz_timer();
+}
+
+static fastcall void xen_halt(void)
+{
+#if 0
+	if (irqs_disabled())
+		HYPERVISOR_vcpu_op(VCPUOP_down, smp_processor_id(), NULL);
+#endif
+}
+
+static void xen_set_lazy_mode(int mode)
+{
+	unsigned *lazy = &get_cpu_var(lazy_mode);
+
+	if (xen_mc_flush())
+		BUG();
+
+	*lazy = mode;
+
+	put_cpu_var(lazy_mode);
+}
+
+static unsigned xen_get_lazy_mode(void)
+{
+	unsigned ret = get_cpu_var(lazy_mode);
+	put_cpu_var(lazy_mode);
+
+	return ret;
+}
+
+static fastcall void xen_load_tr_desc(void)
+{
+	/* do nothing */
+}
+
+static fastcall unsigned long xen_store_tr(void)
+{
+	return 0;
+}
+
+static fastcall void xen_set_ldt(const void *addr, unsigned entries)
+{
+	struct mmuext_op *op;
+	struct multicall_space mcs = xen_mc_entry(sizeof(*op));
+
+	op = mcs.args;
+	op->cmd = MMUEXT_SET_LDT;
+	op->arg1.linear_addr = (unsigned long)addr;
+	if (addr)
+		/* ldt my be vmalloced, use arbitrary_virt_to_machine */
+		op->arg1.linear_addr = arbitrary_virt_to_machine((unsigned long)addr).maddr;
+	op->arg2.nr_ents = entries;
+
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU)
+		xen_mc_flush();
+}
+
+static fastcall void xen_load_gdt(const struct Xgt_desc_struct *dtr)
+{
+        unsigned long va;
+        int f;
+	unsigned size = dtr->size + 1;
+	unsigned long frames[16];
+
+	BUG_ON(size > 16*PAGE_SIZE);
+
+        for (va = dtr->address, f = 0;
+             va < dtr->address + size;
+             va += PAGE_SIZE, f++) {
+                frames[f] = virt_to_mfn(va);
+		make_lowmem_page_readonly((void *)va);
+        }
+
+	/* This is used very early, so we can't rely on per-cpu data
+	   being set up, so no multicalls */
+	if (HYPERVISOR_set_gdt(frames, size/8))
+		BUG();
+}
+
+static void load_TLS_descriptor(struct thread_struct *t,
+				unsigned int cpu, unsigned int i)
+{
+	xmaddr_t maddr = virt_to_machine(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN+i]);
+	struct multicall_space mc = xen_mc_entry(0);
+
+	MULTI_update_descriptor(mc.mc, maddr.maddr, t->tls_array[i]);
+}
+
+static fastcall void xen_load_tls(struct thread_struct *t, unsigned int cpu)
+{
+	load_TLS_descriptor(t, cpu, 0);
+	load_TLS_descriptor(t, cpu, 1);
+	load_TLS_descriptor(t, cpu, 2);
+
+	if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU && xen_mc_flush())
+		BUG();
+}
+
+static fastcall void xen_write_ldt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+        unsigned long lp = (unsigned long)dt + entrynum * 8;
+        xmaddr_t mach_lp = virt_to_machine(lp);
+	u64 entry = (u64)high << 32 | low;
+
+	xen_mc_flush();
+        if (HYPERVISOR_update_descriptor(mach_lp.maddr, entry))
+		BUG();
+}
+
+static int cvt_gate_to_trap(int vector, u32 low, u32 high, struct trap_info *info)
+{
+	u8 type, dpl;
+
+	type = (high >> 8) & 0x1f;
+	dpl = (high >> 13) & 3;
+
+	if (type != 0xf && type != 0xe)
+		return 0;
+
+	info->vector = vector;
+	info->address = (high & 0xffff0000) | (low & 0x0000ffff);
+	info->cs = low >> 16;
+	info->flags = dpl;
+	/* interrupt gates clear IF */
+	if (type == 0xe)
+		info->flags |= 4;
+
+	return 1;
+}
+
+#if 0
+static void unpack_desc(u32 low, u32 high,
+			unsigned long *base, unsigned long *limit,
+			unsigned char *type, unsigned char *flags)
+{
+	*base = (high & 0xff000000) | ((high << 16) & 0x00ff0000) | ((low >> 16) & 0xffff);
+	*limit = (high & 0x000f0000) | (low & 0xffff);
+	*type = (high >> 8) & 0xff;
+	*flags = (high >> 20) & 0xf;
+}
+#endif
+
+/* Locations of each CPU's IDT */
+static DEFINE_PER_CPU(struct Xgt_desc_struct, idt_desc);
+
+/* Set an IDT entry.  If the entry is part of the current IDT, then
+   also update Xen. */
+static fastcall void xen_write_idt_entry(void *dt, int entrynum, u32 low, u32 high)
+{
+
+	int cpu = smp_processor_id();
+	unsigned long p = (unsigned long)dt + entrynum * 8;
+	unsigned long start = per_cpu(idt_desc, cpu).address;
+	unsigned long end = start + per_cpu(idt_desc, cpu).size + 1;
+
+	xen_mc_flush();
+
+	native_write_idt_entry(dt, entrynum, low, high);
+
+	if (p >= start && (p + 8) <= end) {
+		struct trap_info info[2];
+
+		info[1].address = 0;
+
+		if (cvt_gate_to_trap(entrynum, low, high, &info[0]))
+			if (HYPERVISOR_set_trap_table(info))
+				BUG();
+	}
+}
+
+/* Load a new IDT into Xen.  In principle this can be per-CPU, so we
+   hold a spinlock to protect the static traps[] array (static because
+   it avoids allocation, and saves stack space). */
+static fastcall void xen_load_idt(const struct Xgt_desc_struct *desc)
+{
+	static DEFINE_SPINLOCK(lock);
+	static struct trap_info traps[257];
+
+	int cpu = smp_processor_id();
+	unsigned in, out, count;
+
+	per_cpu(idt_desc, cpu) = *desc;
+	
+	count = desc->size / 8;
+	BUG_ON(count > 256);
+
+	spin_lock(&lock);
+	for(in = out = 0; in < count; in++) {
+		const u32 *entry = (u32 *)(desc->address + in * 8);
+
+		if (cvt_gate_to_trap(in, entry[0], entry[1], &traps[out]))
+			out++;
+	}
+	traps[out].address = 0;
+
+	xen_mc_flush();
+	if (HYPERVISOR_set_trap_table(traps))
+		BUG();
+
+	spin_unlock(&lock);
+}
+
+/* Write a GDT descriptor entry.  Ignore LDT descriptors, since
+   they're handled differently. */
+static fastcall void xen_write_gdt_entry(void *dt, int entry, u32 low, u32 high)
+{
+	switch ((high >> 8) & 0xff) {
+	case DESCTYPE_LDT:
+	case DESCTYPE_TSS:
+		/* ignore */
+		break;
+
+	default:
+		xen_mc_flush();
+		if (HYPERVISOR_update_descriptor(virt_to_machine(dt + entry*8).maddr,
+						 (u64)high << 32 | low))
+			BUG();
+	}
+}
+
+static fastcall void xen_load_esp0(struct tss_struct *tss,
+				   struct thread_struct *thread)
+{
+	if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU) {
+		if (HYPERVISOR_stack_switch(__KERNEL_DS, thread->esp0))
+			BUG();
+	} else {
+		struct multicall_space mcs = xen_mc_entry(0);
+		MULTI_stack_switch(mcs.mc, __KERNEL_DS, thread->esp0);
+	}
+}
+
+static fastcall void xen_set_iopl_mask(unsigned mask)
+{
+#if 0
+	struct physdev_set_iopl set_iopl;
+
+	/* Force the change at ring 0. */
+	set_iopl.iopl = (mask == 0) ? 1 : (mask >> 12) & 3;
+	HYPERVISOR_physdev_op(PHYSDEVOP_set_iopl, &set_iopl);
+#endif
+}
+
+static fastcall void xen_io_delay(void)
+{
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+static fastcall void xen_apic_write(unsigned long reg, unsigned long v)
+{
+}
+
+static fastcall void xen_apic_write_atomic(unsigned long reg, unsigned long v)
+{
+}
+
+static fastcall unsigned long xen_apic_read(unsigned long reg)
+{
+	return 0;
+}
+#endif
+
+static fastcall void xen_flush_tlb(void)
+{
+	struct mmuext_op *op;
+	struct multicall_space mcs = xen_mc_entry(sizeof(*op));
+
+	op = mcs.args;
+	op->cmd = MMUEXT_TLB_FLUSH_LOCAL;
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU && xen_mc_flush())
+		BUG();
+}
+
+static fastcall void xen_flush_tlb_global(void)
+{
+	struct mmuext_op *op;
+	struct multicall_space mcs = xen_mc_entry(sizeof(*op));
+
+	op = mcs.args;
+	op->cmd = MMUEXT_TLB_FLUSH_ALL;
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU && xen_mc_flush())
+		BUG();
+}
+
+static fastcall void xen_flush_tlb_single(u32 addr)
+{
+	struct mmuext_op *op;
+	struct multicall_space mcs = xen_mc_entry(sizeof(*op));
+
+	op = mcs.args;
+	op->cmd = MMUEXT_INVLPG_LOCAL;
+	op->arg1.linear_addr = addr & PAGE_MASK;
+	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+	if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU && xen_mc_flush())
+		BUG();
+}
+
+static fastcall unsigned long xen_read_cr2(void)
+{
+	return read_pda(xen.vcpu)->arch.cr2;
+}
+
+static fastcall void xen_write_cr4(unsigned long cr4)
+{
+	/* never allow TSC to be disabled */
+	native_write_cr4(cr4 & ~X86_CR4_TSD);
+}
+
+/*
+ * Page-directory addresses above 4GB do not fit into architectural %cr3.
+ * When accessing %cr3, or equivalent field in vcpu_guest_context, guests
+ * must use the following accessor macros to pack/unpack valid MFNs.
+ */
+#define xen_pfn_to_cr3(pfn) (((unsigned)(pfn) << 12) | ((unsigned)(pfn) >> 20))
+#define xen_cr3_to_pfn(cr3) (((unsigned)(cr3) >> 12) | ((unsigned)(cr3) << 20))
+
+static fastcall unsigned long xen_read_cr3(void)
+{
+	return read_pda(xen.cr3);
+}
+
+static fastcall void xen_write_cr3(unsigned long cr3)
+{
+	if (cr3 == read_pda(xen.cr3)) {
+		/* just a simple tlb flush */
+		xen_flush_tlb();
+		return;
+	}
+
+	write_pda(xen.cr3, cr3);
+
+
+	{
+		struct mmuext_op *op;
+		struct multicall_space mcs = xen_mc_entry(sizeof(*op));
+		unsigned long mfn = pfn_to_mfn(PFN_DOWN(cr3));
+
+		op = mcs.args;
+		op->cmd = MMUEXT_NEW_BASEPTR;
+		op->arg1.mfn = mfn;
+
+		MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+		if (xen_get_lazy_mode() != PARAVIRT_LAZY_CPU && xen_mc_flush())
+			BUG();
+	}
+}
+
+static fastcall void xen_alloc_pt(u32 pfn)
+{
+	/* XXX pfn isn't necessarily a lowmem page */
+	make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
+}
+
+static fastcall void xen_alloc_pd(u32 pfn)
+{
+	make_lowmem_page_readonly(__va(PFN_PHYS(pfn)));
+}
+
+static fastcall void xen_release_pd(u32 pfn)
+{
+	make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
+	/* make sure next person to allocate this page gets a clean
+	   pmd */
+	clear_page(__va(PFN_PHYS(pfn)));
+}
+
+static fastcall void xen_release_pt(u32 pfn)
+{
+	make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
+}
+
+static fastcall void xen_alloc_pd_clone(u32 pfn, u32 clonepfn,
+					u32 start, u32 count)
+{
+	xen_alloc_pd(pfn);
+}
+
+static __init void xen_pagetable_setup_start(pgd_t *base)
+{
+	pgd_t *xen_pgd = (pgd_t *)xen_start_info->pt_base;
+
+	init_mm.pgd = base;
+
+	/* copy top-level of Xen-supplied pagetable into place.  For
+	   !PAE we can use this as-is, but for PAE it is a stand-in
+	   while we copy the pmd pages. */
+	memcpy(base, xen_pgd, PTRS_PER_PGD * sizeof(pgd_t));
+
+	if (PTRS_PER_PMD > 1) {
+		int i;
+
+		/* For PAE, need to allocate new pmds, rather than
+		   share Xen's, since Xen doesn't like pmd's being
+		   shared between address spaces, even though in this
+		   case they're effectively the same address space. */
+		for(i = 0; i < PTRS_PER_PGD; i++) {
+			if (pgd_val_ma(xen_pgd[i]) & _PAGE_PRESENT) {
+				pmd_t *pmd = (pmd_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+
+				memcpy(pmd, (void *)pgd_page_vaddr(xen_pgd[i]),
+				       PAGE_SIZE);
+
+				xen_alloc_pd(PFN_DOWN(__pa(pmd)));
+
+				set_pgd(&base[i], __pgd(1 + __pa(pmd)));
+			} else
+				pgd_clear(&base[i]);
+		}
+	}
+
+	/* make sure the zero_page is mapped RO so we
+	   can use it in pagetables */
+	make_lowmem_page_readonly(empty_zero_page);
+	make_lowmem_page_readonly(base);
+
+	/* Switch to new pagetable.  This is done before
+	   pagetable_init has done anything so that the new pages
+	   added to the table can be prepared properly for Xen.  */
+	printk("about to switch to new pagetable %p...\n", base);
+	xen_write_cr3(__pa(base));
+	printk("done\n");
+}
+
+static __init void xen_pagetable_setup_done(pgd_t *base)
+{
+	/* init_mm has a new pagetable set up - make sure the GDT page
+	   is still read-only in the new pagetable */
+	xen_load_gdt(&cpu_gdt_descr);
+
+	if (!xen_feature(XENFEAT_writable_page_tables)) {
+		/* Create a mapping for the shared info page.
+		   Should be set_fixmap(), but shared_info is a machine
+		   address with no corresponding pseudo-phys address. */
+		set_pte_mfn(fix_to_virt(FIX_PARAVIRT),
+			    PFN_DOWN(xen_start_info->shared_info),
+			    PAGE_KERNEL);
+		
+		HYPERVISOR_shared_info =
+			(struct shared_info *)fix_to_virt(FIX_PARAVIRT);
+	} else
+		HYPERVISOR_shared_info =
+			(struct shared_info *)__va(xen_start_info->shared_info);
+
+	xen_pgd_pin(base);
+
+	write_pda(xen.vcpu, &HYPERVISOR_shared_info->vcpu_info[smp_processor_id()]);
+}
+
+static const struct paravirt_ops xen_paravirt_ops __initdata = {
+	.paravirt_enabled = 1,
+	.shared_kernel_pmd = 0,
+	.pgd_alignment = PAGE_SIZE,
+
+	.name = "Xen",
+	.banner = xen_banner,
+
+	.patch = xen_patch,
+
+	.memory_setup = xen_memory_setup,
+	.arch_setup = xen_arch_setup,
+	.init_IRQ = xen_init_IRQ,
+	.time_init = xen_time_init,
+	.init_pda = xen_init_pda,
+
+	.cpuid = xen_cpuid,
+
+	.set_debugreg = xen_set_debugreg,
+	.get_debugreg = xen_get_debugreg,
+
+	.clts = native_clts,
+
+	.read_cr0 = native_read_cr0,
+	.write_cr0 = native_write_cr0,
+
+	.read_cr2 = xen_read_cr2,
+	.write_cr2 = native_write_cr2,
+
+	.read_cr3 = xen_read_cr3,
+	.write_cr3 = xen_write_cr3,
+
+	.read_cr4 = native_read_cr4,
+	.read_cr4_safe = native_read_cr4_safe,
+	.write_cr4 = xen_write_cr4,
+
+	.save_fl = xen_save_fl,
+	.restore_fl = xen_restore_fl,
+	.irq_disable = xen_irq_disable,
+	.irq_enable = xen_irq_enable,
+	.safe_halt = xen_safe_halt,
+	.halt = xen_halt,
+	.wbinvd = native_wbinvd,
+
+	.read_msr = native_read_msr,
+	.write_msr = native_write_msr,
+	.read_tsc = native_read_tsc,
+	.read_pmc = native_read_pmc,
+
+	.iret = (void (fastcall *)(void))&hypercall_page[__HYPERVISOR_iret],
+	.irq_enable_sysexit = (void (fastcall *)(void))xen_sti_sysexit,
+
+	.load_tr_desc = xen_load_tr_desc,
+	.set_ldt = xen_set_ldt,
+	.load_gdt = xen_load_gdt,
+	.load_idt = xen_load_idt,
+	.load_tls = xen_load_tls,
+
+	.store_gdt = native_store_gdt,
+	.store_idt = native_store_idt,
+	.store_tr = xen_store_tr,
+
+	.write_ldt_entry = xen_write_ldt_entry,
+	.write_gdt_entry = xen_write_gdt_entry,
+	.write_idt_entry = xen_write_idt_entry,
+	.load_esp0 = xen_load_esp0,
+
+	.set_iopl_mask = xen_set_iopl_mask,
+	.io_delay = xen_io_delay,
+	.const_udelay = __const_udelay,
+	.set_wallclock = xen_set_wallclock,
+	.get_wallclock = xen_get_wallclock,
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	.apic_write = xen_apic_write,
+	.apic_write_atomic = xen_apic_write_atomic,
+	.apic_read = xen_apic_read,
+#endif
+
+	.flush_tlb_user = xen_flush_tlb,
+	.flush_tlb_kernel = xen_flush_tlb_global,
+	.flush_tlb_single = xen_flush_tlb_single,
+
+	.pte_update = (void *)native_nop,
+	.pte_update_defer = (void *)native_nop,
+
+	.pagetable_setup_start = xen_pagetable_setup_start,
+	.pagetable_setup_done = xen_pagetable_setup_done,
+	.activate_mm = xen_activate_mm,
+	.dup_mmap = xen_dup_mmap,
+	.exit_mmap = xen_exit_mmap,
+
+	.set_pte = xen_set_pte,
+	.set_pte_at = xen_set_pte_at,
+	.set_pmd = xen_set_pmd,
+
+	.alloc_pt = xen_alloc_pt,
+	.alloc_pd = xen_alloc_pd,
+	.alloc_pd_clone = xen_alloc_pd_clone,
+	.release_pd = xen_release_pd,
+	.release_pt = xen_release_pt,
+
+	.pte_val = xen_pte_val,
+	.pmd_val = xen_pmd_val,
+	.pgd_val = xen_pgd_val,
+
+	.make_pte = xen_make_pte,
+	.make_pmd = xen_make_pmd,
+	.make_pgd = xen_make_pgd,
+
+	.ptep_get_and_clear = xen_ptep_get_and_clear,
+
+#ifdef CONFIG_X86_PAE
+	.set_pte_atomic = xen_set_pte,
+	.set_pte_present = xen_set_pte_at,
+	.set_pud = xen_set_pud,
+	.pte_clear = xen_pte_clear,
+	.pmd_clear = xen_pmd_clear,
+#endif	/* PAE */
+
+	.set_lazy_mode = xen_set_lazy_mode,
+	.startup_ipi_hook = (void *)native_nop,
+};
+
+/* First C function to be called on Xen boot */
+static asmlinkage void __init xen_start_kernel(void)
+{
+	u32 low, high;
+	pgd_t *pgd;
+
+	if (!xen_start_info)
+		return;
+
+	BUG_ON(memcmp(xen_start_info->magic, "xen-3.0", 7) != 0);
+
+	/* Install Xen paravirt ops */
+	paravirt_ops = xen_paravirt_ops;
+
+	xen_setup_features();
+
+	/* Get mfn list */
+	if (!xen_feature(XENFEAT_auto_translated_physmap))
+		phys_to_machine_mapping = (unsigned long *)xen_start_info->mfn_list;
+
+	pgd = (pgd_t *)xen_start_info->pt_base;
+
+	init_pg_tables_end = __pa(pgd) + xen_start_info->nr_pt_frames*PAGE_SIZE;
+
+	/* set up the boot-time gdt and segments */
+	init_mm.pgd = pgd; /* use the Xen pagetables to start */
+
+	xen_load_gdt(&cpu_gdt_descr);
+
+	/* set up PDA descriptor */
+	pack_descriptor(&low, &high, (unsigned)&boot_pda, sizeof(boot_pda)-1,
+			0x80 | DESCTYPE_S | 0x02, 0);
+
+	/* Use hypercall directly, because xen_write_gdt_entry can't
+	 * be used until batched multicalls work. */
+	if (HYPERVISOR_update_descriptor(virt_to_machine(cpu_gdt_table +
+							 GDT_ENTRY_PDA).maddr,
+					 (u64)high << 32 | low))
+		BUG();
+
+	/* set up %fs and init Xen parts of the PDA */
+	asm volatile("mov %0, %%fs" : : "r" (__KERNEL_PDA) : "memory");
+	xen_init_pda(&boot_pda, 0);
+	boot_pda.xen.cr3 = __pa(pgd);
+
+	paravirt_ops.kernel_rpl = xen_feature(XENFEAT_supervisor_mode_kernel) ? 0 : 1;
+
+	/* set the limit of our address space */
+	reserve_top_address(-HYPERVISOR_VIRT_START + 2 * PAGE_SIZE);
+
+	/* set up basic CPUID stuff */
+	cpu_detect(&new_cpu_data);
+	new_cpu_data.hard_math = 1;
+	identify_cpu(&new_cpu_data);
+
+	/* Poke various useful things into boot_params */
+	LOADER_TYPE = (9 << 4) | 0;
+	INITRD_START = xen_start_info->mod_start ? __pa(xen_start_info->mod_start) : 0;
+	INITRD_SIZE = xen_start_info->mod_len;
+
+	/* Start the world */
+	start_kernel();
+}
+
+paravirt_probe(xen_start_kernel);
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/events.c
@@ -0,0 +1,473 @@
+#include <linux/linkage.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include <asm/ptrace.h>
+#include <asm/irq.h>
+#include <asm/sync_bitops.h>
+#include <asm/hypercall.h>
+
+#include <xen/interface/xen.h>
+#include <xen/interface/event_channel.h>
+
+#include "xen-ops.h"
+#include "events.h"
+
+/*
+ * This lock protects updates to the following mapping and reference-count
+ * arrays. The lock does not need to be acquired to read the mapping tables.
+ */
+static DEFINE_SPINLOCK(irq_mapping_update_lock);
+
+/* IRQ <-> VIRQ mapping. */
+DEFINE_PER_CPU(int, virq_to_irq[NR_VIRQS]) = {[0 ... NR_VIRQS-1] = -1};
+
+/* Packed IRQ information: binding type, sub-type index, and event channel. */
+static u32 irq_info[NR_IRQS];
+
+/* Binding types. */
+enum { IRQT_UNBOUND, IRQT_PIRQ, IRQT_VIRQ, IRQT_IPI, IRQT_EVTCHN };
+
+/* Convenient shorthand for packed representation of an unbound IRQ. */
+#define IRQ_UNBOUND	mk_irq_info(IRQT_UNBOUND, 0, 0)
+
+static int evtchn_to_irq[NR_EVENT_CHANNELS] = {
+	[0 ... NR_EVENT_CHANNELS-1] = -1
+};
+static unsigned long cpu_evtchn_mask[NR_CPUS][NR_EVENT_CHANNELS/BITS_PER_LONG];
+static u8 cpu_evtchn[NR_EVENT_CHANNELS];
+
+/* Reference counts for bindings to IRQs. */
+static int irq_bindcount[NR_IRQS];
+
+/* Xen will never allocate port zero for any purpose. */
+#define VALID_EVTCHN(chn)	((chn) != 0)
+
+/*
+ * Force a proper event-channel callback from Xen after clearing the
+ * callback mask. We do this in a very simple manner, by making a call
+ * down into Xen. The pending flag will be checked by Xen on return.
+ */
+void force_evtchn_callback(void)
+{
+	(void)HYPERVISOR_xen_version(0, NULL);
+}
+EXPORT_SYMBOL_GPL(force_evtchn_callback);
+
+static struct irq_chip xen_dynamic_chip;
+
+/* Constructor for packed IRQ information. */
+static inline u32 mk_irq_info(u32 type, u32 index, u32 evtchn)
+{
+	return ((type << 24) | (index << 16) | evtchn);
+}
+
+/*
+ * Accessors for packed IRQ information.
+ */
+static inline unsigned int evtchn_from_irq(int irq)
+{
+	return (u16)(irq_info[irq]);
+}
+
+static inline unsigned int index_from_irq(int irq)
+{
+	return (u8)(irq_info[irq] >> 16);
+}
+
+static inline unsigned int type_from_irq(int irq)
+{
+	return (u8)(irq_info[irq] >> 24);
+}
+
+static inline unsigned long active_evtchns(unsigned int cpu,
+					   struct shared_info *sh,
+					   unsigned int idx)
+{
+	return (sh->evtchn_pending[idx] &
+		cpu_evtchn_mask[cpu][idx] &
+		~sh->evtchn_mask[idx]);
+}
+
+static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
+{
+	int irq = evtchn_to_irq[chn];
+
+	BUG_ON(irq == -1);
+	set_native_irq_info(irq, cpumask_of_cpu(cpu));
+
+	__clear_bit(chn, (unsigned long *)cpu_evtchn_mask[cpu_evtchn[chn]]);
+	__set_bit(chn, (unsigned long *)cpu_evtchn_mask[cpu]);
+
+	cpu_evtchn[chn] = cpu;
+}
+
+static void init_evtchn_cpu_bindings(void)
+{
+	int i;
+
+	/* By default all event channels notify CPU#0. */
+	for (i = 0; i < NR_IRQS; i++)
+		set_native_irq_info(i, cpumask_of_cpu(0));
+
+	memset(cpu_evtchn, 0, sizeof(cpu_evtchn));
+	memset(cpu_evtchn_mask[0], ~0, sizeof(cpu_evtchn_mask[0]));
+}
+
+static inline unsigned int cpu_from_evtchn(unsigned int evtchn)
+{
+	return cpu_evtchn[evtchn];
+}
+
+static inline void clear_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	sync_clear_bit(port, &s->evtchn_pending[0]);
+}
+
+static inline void set_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	sync_set_bit(port, &s->evtchn_pending[0]);
+}
+
+
+/**
+ * notify_remote_via_irq - send event to remote end of event channel via irq
+ * @irq: irq of event channel to send event to
+ *
+ * Unlike notify_remote_via_evtchn(), this is safe to use across
+ * save/restore. Notifications on a broken connection are silently
+ * dropped.
+ */
+void notify_remote_via_irq(int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		notify_remote_via_evtchn(evtchn);
+}
+EXPORT_SYMBOL_GPL(notify_remote_via_irq);
+
+void mask_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	sync_set_bit(port, &s->evtchn_mask[0]);
+}
+EXPORT_SYMBOL_GPL(mask_evtchn);
+
+void unmask_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	unsigned int cpu = smp_processor_id();
+	struct vcpu_info *vcpu_info = read_pda(xen.vcpu);
+
+	BUG_ON(!irqs_disabled());
+
+	/* Slow path (hypercall) if this is a non-local port. */
+	if (unlikely(cpu != cpu_from_evtchn(port))) {
+		struct evtchn_unmask unmask = { .port = port };
+		(void)HYPERVISOR_event_channel_op(EVTCHNOP_unmask, &unmask);
+		return;
+	}
+
+	sync_clear_bit(port, &s->evtchn_mask[0]);
+
+	/*
+	 * The following is basically the equivalent of 'hw_resend_irq'. Just
+	 * like a real IO-APIC we 'lose the interrupt edge' if the channel is
+	 * masked.
+	 */
+	if (sync_test_bit(port, &s->evtchn_pending[0]) &&
+	    !sync_test_and_set_bit(port / BITS_PER_LONG,
+				   &vcpu_info->evtchn_pending_sel))
+		vcpu_info->evtchn_upcall_pending = 1;
+}
+EXPORT_SYMBOL_GPL(unmask_evtchn);
+
+static int find_unbound_irq(void)
+{
+	int irq;
+
+	/* Only allocate from dynirq range */
+	for (irq = 0; irq < NR_IRQS; irq++)
+		if (irq_bindcount[irq] == 0)
+			break;
+
+	if (irq == NR_IRQS)
+		panic("No available IRQ to bind to: increase NR_IRQS!\n");
+
+	return irq;
+}
+
+static int bind_evtchn_to_irq(unsigned int evtchn)
+{
+	int irq;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	irq = evtchn_to_irq[evtchn];
+
+	if (irq == -1) {
+		irq = find_unbound_irq();
+
+		dynamic_irq_init(irq);
+		set_irq_chip_and_handler(irq, &xen_dynamic_chip, handle_level_irq);
+
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_EVTCHN, 0, evtchn);
+	}
+
+	irq_bindcount[irq]++;
+
+	spin_unlock(&irq_mapping_update_lock);
+
+	return irq;
+}
+
+static int bind_virq_to_irq(unsigned int virq, unsigned int cpu)
+{
+	struct evtchn_bind_virq bind_virq;
+	int evtchn, irq;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	irq = per_cpu(virq_to_irq, cpu)[virq];
+
+	if (irq == -1) {
+		bind_virq.virq = virq;
+		bind_virq.vcpu = cpu;
+		if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_virq,
+						&bind_virq) != 0)
+			BUG();
+		evtchn = bind_virq.port;
+
+		irq = find_unbound_irq();
+
+		dynamic_irq_init(irq);
+		set_irq_chip_and_handler(irq, &xen_dynamic_chip, handle_level_irq);
+
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_VIRQ, virq, evtchn);
+
+		per_cpu(virq_to_irq, cpu)[virq] = irq;
+
+		bind_evtchn_to_cpu(evtchn, cpu);
+	}
+
+	irq_bindcount[irq]++;
+
+	spin_unlock(&irq_mapping_update_lock);
+
+	return irq;
+}
+
+static void unbind_from_irq(unsigned int irq)
+{
+	struct evtchn_close close;
+	int evtchn = evtchn_from_irq(irq);
+
+	spin_lock(&irq_mapping_update_lock);
+
+	if (VALID_EVTCHN(evtchn) && (--irq_bindcount[irq] == 0)) {
+		close.port = evtchn;
+		if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
+			BUG();
+
+		switch (type_from_irq(irq)) {
+		case IRQT_VIRQ:
+			per_cpu(virq_to_irq, cpu_from_evtchn(evtchn))
+				[index_from_irq(irq)] = -1;
+			break;
+		default:
+			break;
+		}
+
+		/* Closed ports are implicitly re-bound to VCPU0. */
+		bind_evtchn_to_cpu(evtchn, 0);
+
+		evtchn_to_irq[evtchn] = -1;
+		irq_info[irq] = IRQ_UNBOUND;
+
+		dynamic_irq_init(irq);
+	}
+
+	spin_unlock(&irq_mapping_update_lock);
+}
+
+int bind_evtchn_to_irqhandler(unsigned int evtchn,
+			      irqreturn_t (*handler)(int, void *),
+			      unsigned long irqflags, const char *devname, void *dev_id)
+{
+	unsigned int irq;
+	int retval;
+
+	irq = bind_evtchn_to_irq(evtchn);
+	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval != 0) {
+		unbind_from_irq(irq);
+		return retval;
+	}
+
+	return irq;
+}
+EXPORT_SYMBOL_GPL(bind_evtchn_to_irqhandler);
+
+int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
+			    irqreturn_t (*handler)(int, void *),
+			    unsigned long irqflags, const char *devname, void *dev_id)
+{
+	unsigned int irq;
+	int retval;
+
+	irq = bind_virq_to_irq(virq, cpu);
+	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval != 0) {
+		unbind_from_irq(irq);
+		return retval;
+	}
+
+	return irq;
+}
+EXPORT_SYMBOL_GPL(bind_virq_to_irqhandler);
+
+void unbind_from_irqhandler(unsigned int irq, void *dev_id)
+{
+	free_irq(irq, dev_id);
+	unbind_from_irq(irq);
+}
+EXPORT_SYMBOL_GPL(unbind_from_irqhandler);
+
+/*
+  Search the CPUs pending events bitmasks.  For each one found, map
+  the event number to an irq, and feed it into do_IRQ() for
+  handling.
+
+  Xen uses a two-level bitmap to speed searching.  The first level is
+  a bitset of words which contain pending event bits.  The second
+  level is a bitset of pending events themselves.
+*/
+asmlinkage fastcall void xen_evtchn_do_upcall(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	struct shared_info *s = HYPERVISOR_shared_info;
+	struct vcpu_info *vcpu_info = read_pda(xen.vcpu);
+	unsigned long pending_words;
+
+	vcpu_info->evtchn_upcall_pending = 0;
+
+	/* NB. No need for a barrier here -- XCHG is a barrier on x86. */
+	pending_words = xchg(&vcpu_info->evtchn_pending_sel, 0);
+	while (pending_words != 0) {
+		unsigned long pending_bits;
+		int word_idx = __ffs(pending_words);
+		pending_words &= ~(1UL << word_idx);
+
+		while ((pending_bits = active_evtchns(cpu, s, word_idx)) != 0) {
+			int bit_idx = __ffs(pending_bits);
+			int port = (word_idx * BITS_PER_LONG) + bit_idx;
+			int irq = evtchn_to_irq[port];
+
+			if (irq != -1) {
+				regs->orig_eax = ~irq;
+				do_IRQ(regs);
+			}
+		}
+	}
+}
+
+/* Rebind an evtchn so that it gets delivered to a specific cpu */
+static void rebind_irq_to_cpu(unsigned irq, unsigned tcpu)
+{
+	struct evtchn_bind_vcpu bind_vcpu;
+	int evtchn = evtchn_from_irq(irq);
+
+	if (!VALID_EVTCHN(evtchn))
+		return;
+
+	/* Send future instances of this interrupt to other vcpu. */
+	bind_vcpu.port = evtchn;
+	bind_vcpu.vcpu = tcpu;
+
+	/*
+	 * If this fails, it usually just indicates that we're dealing with a 
+	 * virq or IPI channel, which don't actually need to be rebound. Ignore
+	 * it, but don't do the xenlinux-level rebind in that case.
+	 */
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
+		bind_evtchn_to_cpu(evtchn, tcpu);
+}
+
+
+static void set_affinity_irq(unsigned irq, cpumask_t dest)
+{
+	unsigned tcpu = first_cpu(dest);
+	rebind_irq_to_cpu(irq, tcpu);
+}
+
+static void enable_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		unmask_evtchn(evtchn);
+}
+
+static void disable_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		mask_evtchn(evtchn);
+}
+
+static void ack_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	move_native_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		clear_evtchn(evtchn);
+}
+
+static int retrigger_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+	int ret = 0;
+
+	if (VALID_EVTCHN(evtchn)) {
+		set_evtchn(evtchn);
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static struct irq_chip xen_dynamic_chip __read_mostly = {
+	.name		= "xen-virq",
+	.mask		= disable_dynirq,
+	.unmask		= enable_dynirq,
+	.ack		= ack_dynirq,
+	.set_affinity	= set_affinity_irq,
+	.retrigger	= retrigger_dynirq,
+};
+
+void __init xen_init_IRQ(void)
+{
+	int i;
+
+	init_evtchn_cpu_bindings();
+
+	/* No event channels are 'live' right now. */
+	for (i = 0; i < NR_EVENT_CHANNELS; i++)
+		mask_evtchn(i);
+
+	/* Dynamic IRQ space is currently unbound. Zero the refcnts. */
+	for (i = 0; i < NR_IRQS; i++)
+		irq_bindcount[i] = 0;
+
+	irq_ctx_init(smp_processor_id());
+}
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/events.h
@@ -0,0 +1,28 @@
+#ifndef _XEN_EVENTS_H
+#define _XEN_EVENTS_H
+
+#include <linux/irq.h>
+
+int bind_evtchn_to_irqhandler(unsigned int evtchn,
+			      irqreturn_t (*handler)(int, void *),
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id);
+int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
+			    irqreturn_t (*handler)(int, void *),
+			    unsigned long irqflags, const char *devname, void *dev_id);
+
+/*
+ * Common unbind function for all event sources. Takes IRQ to unbind from.
+ * Automatically closes the underlying event channel (even for bindings
+ * made with bind_evtchn_to_irqhandler()).
+ */
+void unbind_from_irqhandler(unsigned int irq, void *dev_id);
+
+static inline void notify_remote_via_evtchn(int port)
+{
+	struct evtchn_send send = { .port = port };
+	(void)HYPERVISOR_event_channel_op(EVTCHNOP_send, &send);
+}
+
+extern void notify_remote_via_irq(int irq);
+#endif	/* _XEN_EVENTS_H */
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/features.c
@@ -0,0 +1,29 @@
+/******************************************************************************
+ * features.c
+ *
+ * Xen feature flags.
+ *
+ * Copyright (c) 2006, Ian Campbell, XenSource Inc.
+ */
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/module.h>
+#include <asm/hypervisor.h>
+#include <xen/features.h>
+
+u8 xen_features[XENFEAT_NR_SUBMAPS * 32] __read_mostly;
+EXPORT_SYMBOL_GPL(xen_features);
+
+void xen_setup_features(void)
+{
+	struct xen_feature_info fi;
+	int i, j;
+
+	for (i = 0; i < XENFEAT_NR_SUBMAPS; i++) {
+		fi.submap_idx = i;
+		if (HYPERVISOR_xen_version(XENVER_get_features, &fi) < 0)
+			break;
+		for (j=0; j<32; j++)
+			xen_features[i*32+j] = !!(fi.submap & 1<<j);
+	}
+}
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/memory.c
@@ -0,0 +1,50 @@
+#include <asm/desc.h>
+#include <asm/hypervisor.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#include "xen-page.h"
+
+xmaddr_t arbitrary_virt_to_machine(unsigned long address)
+{
+	pte_t *pte = lookup_address(address);
+	unsigned offset = address & PAGE_MASK;
+
+	BUG_ON(pte == NULL);
+
+	return XMADDR((pte_mfn(*pte) << PAGE_SHIFT) + offset);
+}
+
+void make_lowmem_page_readonly(void *vaddr)
+{
+	pte_t *pte, ptev;
+	unsigned long address = (unsigned long)vaddr;
+
+	pte = lookup_address(address);
+	BUG_ON(pte == NULL);
+
+	ptev = pte_wrprotect(*pte);
+
+	if (xen_feature(XENFEAT_writable_page_tables))
+		*pte = ptev;
+	else
+		if(HYPERVISOR_update_va_mapping(address, ptev, 0))
+			BUG();
+}
+
+void make_lowmem_page_readwrite(void *vaddr)
+{
+	pte_t *pte, ptev;
+	unsigned long address = (unsigned long)vaddr;
+
+	pte = lookup_address(address);
+	BUG_ON(pte == NULL);
+
+	ptev = pte_mkwrite(*pte);
+
+	if (xen_feature(XENFEAT_writable_page_tables))
+		*pte = ptev;
+	else
+		if(HYPERVISOR_update_va_mapping(address, ptev, 0))
+			BUG();
+}
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/mmu.c
@@ -0,0 +1,375 @@
+//#include <linux/bug.h>
+#include <asm/bug.h>
+
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
+
+#include <asm/hypercall.h>
+#include <asm/paravirt.h>
+
+#include <xen/interface/xen.h>
+
+#include "xen-page.h"
+
+fastcall void xen_set_pte(pte_t *ptep, pte_t pte)
+{
+#if 1
+	struct mmu_update u;
+
+	u.ptr = virt_to_machine(ptep).maddr;
+	u.val = pte_val_ma(pte);
+	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
+		BUG();
+#else
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+#endif
+}
+
+fastcall void xen_set_pmd(pmd_t *ptr, pmd_t val)
+{
+	struct mmu_update u;
+
+	u.ptr = virt_to_machine(ptr).maddr;
+	u.val = pmd_val_ma(val);
+	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
+		BUG();
+}
+
+#ifdef CONFIG_X86_PAE
+fastcall void xen_set_pud(pmd_t *ptr, pud_t val)
+{
+	struct mmu_update u;
+
+	u.ptr = virt_to_machine(ptr).maddr;
+	u.val = pud_val_ma(val);
+	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
+		BUG();
+}
+#endif
+
+/*
+ * Associate a virtual page frame with a given physical page frame 
+ * and protection flags for that frame.
+ */ 
+void set_pte_mfn(unsigned long vaddr, unsigned long mfn, pgprot_t flags)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = swapper_pg_dir + pgd_index(vaddr);
+	if (pgd_none(*pgd)) {
+		BUG();
+		return;
+	}
+	pud = pud_offset(pgd, vaddr);
+	if (pud_none(*pud)) {
+		BUG();
+		return;
+	}
+	pmd = pmd_offset(pud, vaddr);
+	if (pmd_none(*pmd)) {
+		BUG();
+		return;
+	}
+	pte = pte_offset_kernel(pmd, vaddr);
+	/* <mfn,flags> stored as-is, to permit clearing entries */
+	xen_set_pte(pte, mfn_pte(mfn, flags));
+
+	/*
+	 * It's enough to flush this one mapping.
+	 * (PGE mappings get flushed as well)
+	 */
+	__flush_tlb_one(vaddr);
+}
+
+void fastcall xen_set_pte_at(struct mm_struct *mm, u32 addr,
+			     pte_t *ptep, pte_t pteval)
+{
+	if ((mm != current->mm && mm != &init_mm) ||
+	    HYPERVISOR_update_va_mapping(addr, pteval, 0) != 0)
+		xen_set_pte(ptep, pteval);
+}
+
+void fastcall xen_pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+}
+
+void fastcall xen_pte_update_defer(struct mm_struct *mm, u32 addr, pte_t *ptep)
+{
+}
+
+#ifdef CONFIG_X86_PAE
+void fastcall xen_set_pte_atomic(pte_t *ptep, pte_t pte)
+{
+	set_64bit((u64 *)ptep, pte_val_ma(pte));
+}
+
+void fastcall xen_pte_clear(struct mm_struct *mm, u32 addr,pte_t *ptep)
+{
+#if 1
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = 0;	
+#else
+	set_64bit((u64 *)ptep, 0);
+#endif
+}
+
+void fastcall xen_pmd_clear(pmd_t *pmdp)
+{
+	xen_set_pmd(pmdp, __pmd(0));
+}
+
+fastcall unsigned long long xen_pte_val(pte_t pte)
+{
+	unsigned long long ret = 0;
+
+	if (pte.pte_low) {
+		ret = ((unsigned long long)pte.pte_high << 32) | pte.pte_low;
+		ret = machine_to_phys(XMADDR(ret)).paddr | 1;
+	}
+
+	return ret;
+}
+
+fastcall unsigned long long xen_pmd_val(pmd_t pmd)
+{
+	unsigned long long ret = pmd.pmd;
+	if (ret)
+		ret = machine_to_phys(XMADDR(ret)).paddr | 1;
+	return ret;
+}
+
+fastcall unsigned long long xen_pgd_val(pgd_t pgd)
+{
+	unsigned long long ret = pgd.pgd;
+	if (ret)
+		ret = machine_to_phys(XMADDR(ret)).paddr | 1;
+	return ret;
+}
+
+fastcall pte_t xen_make_pte(unsigned long long pte)
+{
+	if (pte & 1)
+		pte = phys_to_machine(XPADDR(pte)).maddr;
+
+	return (pte_t){ pte, pte >> 32 };
+}
+
+fastcall pmd_t xen_make_pmd(unsigned long long pmd)
+{
+	if (pmd & 1)
+		pmd = phys_to_machine(XPADDR(pmd)).maddr;
+
+	return (pmd_t){ pmd };
+}
+
+fastcall pgd_t xen_make_pgd(unsigned long long pgd)
+{
+	if (pgd & _PAGE_PRESENT)
+		pgd = phys_to_machine(XPADDR(pgd)).maddr;
+
+	return (pgd_t){ pgd };
+}
+
+fastcall pte_t xen_ptep_get_and_clear(pte_t *ptep)
+{
+	pte_t res;
+
+	/* xchg acts as a barrier before the setting of the high bits */
+	res.pte_low = xchg(&ptep->pte_low, 0);
+	res.pte_high = ptep->pte_high;
+	ptep->pte_high = 0;
+
+	return res;
+}
+#else  /* !PAE */
+fastcall unsigned long xen_pte_val(pte_t pte)
+{
+	unsigned long ret = pte.pte_low;
+
+	if (ret & _PAGE_PRESENT)
+		ret = machine_to_phys(XMADDR(ret)).paddr;
+
+	return ret;
+}
+
+fastcall unsigned long xen_pmd_val(pmd_t pmd)
+{
+	BUG();
+	return 0;
+}
+
+fastcall unsigned long xen_pgd_val(pgd_t pgd)
+{
+	unsigned long ret = pgd.pgd;
+	if (ret)
+		ret = machine_to_phys(XMADDR(ret)).paddr | 1;
+	return ret;
+}
+
+fastcall pte_t xen_make_pte(unsigned long pte)
+{
+	if (pte & _PAGE_PRESENT)
+		pte = phys_to_machine(XPADDR(pte)).maddr;
+
+	return (pte_t){ pte };
+}
+
+fastcall pmd_t xen_make_pmd(unsigned long pmd)
+{
+	BUG();
+	return __pmd(0);
+}
+
+fastcall pgd_t xen_make_pgd(unsigned long pgd)
+{
+	if (pgd & _PAGE_PRESENT)
+		pgd = phys_to_machine(XPADDR(pgd)).maddr;
+
+	return (pgd_t){ pgd };
+}
+
+fastcall pte_t xen_ptep_get_and_clear(pte_t *ptep)
+{
+	return __pte_ma(xchg(&(ptep)->pte_low, 0));
+}
+#endif	/* CONFIG_X86_PAE */
+
+
+
+static void pgd_walk_set_prot(void *pt, pgprot_t flags)
+{
+	unsigned long pfn = PFN_DOWN(__pa(pt));
+
+	if (HYPERVISOR_update_va_mapping((unsigned long)pt,
+					 pfn_pte(pfn, flags), 0) < 0)
+		BUG();
+}
+
+static void pgd_walk(pgd_t *pgd_base, pgprot_t flags)
+{
+	pgd_t *pgd = pgd_base;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int    g, u, m;
+
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return;
+
+	for (g = 0; g < USER_PTRS_PER_PGD; g++, pgd++) {
+		if (pgd_none(*pgd))
+			continue;
+		pud = pud_offset(pgd, 0);
+
+		if (PTRS_PER_PUD > 1) /* not folded */
+			pgd_walk_set_prot(pud,flags);
+
+		for (u = 0; u < PTRS_PER_PUD; u++, pud++) {
+			if (pud_none(*pud))
+				continue;
+			pmd = pmd_offset(pud, 0);
+
+			if (PTRS_PER_PMD > 1) /* not folded */
+				pgd_walk_set_prot(pmd,flags);
+
+			for (m = 0; m < PTRS_PER_PMD; m++, pmd++) {
+				if (pmd_none(*pmd))
+					continue;
+
+				/* This can get called before mem_map
+				   is set up, so we assume nothing is
+				   highmem at that point. */
+				if (mem_map == NULL ||
+				    !PageHighMem(pmd_page(*pmd))) {
+					pte = pte_offset_kernel(pmd,0);
+					pgd_walk_set_prot(pte,flags);
+				}
+			}
+		}
+	}
+
+	if (HYPERVISOR_update_va_mapping((unsigned long)pgd_base,
+					 pfn_pte(PFN_DOWN(__pa(pgd_base)),
+						 flags),
+					 UVMF_TLB_FLUSH) < 0)
+		BUG();
+}
+
+
+/* This is called just after a mm has been duplicated from its parent,
+   but it has not been used yet.  We need to make sure that its
+   pagetable is all read-only, and can be pinned. The pagetable itself
+   needs to map itself as RO; it doesn't matter what the state its in
+   with respect to any other pagetable. */
+void xen_pgd_pin(pgd_t *pgd)
+{
+	struct mmuext_op op;
+
+	pgd_walk(pgd, PAGE_KERNEL_RO);
+
+#if defined(CONFIG_X86_PAE)
+	op.cmd = MMUEXT_PIN_L3_TABLE;
+#else
+	op.cmd = MMUEXT_PIN_L2_TABLE;
+#endif
+	op.arg1.mfn = pfn_to_mfn(PFN_DOWN(__pa(pgd)));
+	if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0)
+		BUG();
+}
+
+/* Release a pagetables pages back as normal RW */
+void xen_pgd_unpin(pgd_t *pgd)
+{
+	struct mmuext_op op;
+
+	op.cmd = MMUEXT_UNPIN_TABLE;
+	op.arg1.mfn = pfn_to_mfn(PFN_DOWN(__pa(pgd)));
+
+	if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0)
+		BUG();
+
+	pgd_walk(pgd, PAGE_KERNEL);
+}
+
+
+fastcall void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
+{
+	xen_pgd_pin(next->pgd);
+}
+
+fastcall void xen_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	xen_pgd_pin(mm->pgd);	
+}
+
+fastcall void xen_exit_mmap(struct mm_struct *mm)
+{
+	struct task_struct *tsk = current;
+
+	task_lock(tsk);
+
+	/*
+	 * We aggressively remove defunct pgd from cr3. We execute unmap_vmas()
+	 * *much* faster this way, as no tlb flushes means bigger wrpt batches.
+	 */
+	if (tsk->active_mm == mm) {
+		tsk->active_mm = &init_mm;
+		atomic_inc(&init_mm.mm_count);
+
+		switch_mm(mm, &init_mm, tsk);
+
+		atomic_dec(&mm->mm_count);
+		BUG_ON(atomic_read(&mm->mm_count) == 0);
+	}
+
+	task_unlock(tsk);
+
+	xen_pgd_unpin(mm->pgd);
+}
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/mmu.h
@@ -0,0 +1,51 @@
+#ifndef _XEN_MMU_H
+
+#include <linux/linkage.h>
+#include <asm/page.h>
+
+void set_pte_mfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
+
+void fastcall xen_set_pte(pte_t *ptep, pte_t pteval);
+void fastcall xen_set_pte_at(struct mm_struct *mm, u32 addr,
+			     pte_t *ptep, pte_t pteval);
+void fastcall xen_set_pmd(pmd_t *pmdp, pmd_t pmdval);
+void fastcall xen_pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep);
+void fastcall xen_pte_update_defer(struct mm_struct *mm, u32 addr, pte_t *ptep);
+
+fastcall void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next);
+fastcall void xen_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm);
+fastcall void xen_exit_mmap(struct mm_struct *mm);
+
+fastcall pte_t xen_ptep_get_and_clear(pte_t *ptep);
+
+void xen_pgd_pin(pgd_t *pgd);
+void xen_pgd_unpin(pgd_t *pgd);
+
+#ifdef CONFIG_X86_PAE
+fastcall unsigned long long xen_pte_val(pte_t);
+fastcall unsigned long long xen_pmd_val(pmd_t);
+fastcall unsigned long long xen_pgd_val(pgd_t);
+
+fastcall pte_t xen_make_pte(unsigned long long);
+fastcall pmd_t xen_make_pmd(unsigned long long);
+fastcall pgd_t xen_make_pgd(unsigned long long);
+
+fastcall void xen_set_pte_at(struct mm_struct *mm, u32 addr,
+			     pte_t *ptep, pte_t pteval);
+fastcall void xen_set_pte_atomic(pte_t *ptep, pte_t pte);
+fastcall void xen_set_pud(pud_t *ptr, pud_t val);
+fastcall void xen_pte_clear(struct mm_struct *mm, u32 addr,pte_t *ptep);
+fastcall void xen_pmd_clear(pmd_t *pmdp);
+
+
+#else
+fastcall unsigned long xen_pte_val(pte_t);
+fastcall unsigned long xen_pmd_val(pmd_t);
+fastcall unsigned long xen_pgd_val(pgd_t);
+
+fastcall pte_t xen_make_pte(unsigned long);
+fastcall pmd_t xen_make_pmd(unsigned long);
+fastcall pgd_t xen_make_pgd(unsigned long);
+#endif
+
+#endif	/* _XEN_MMU_H */
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/multicalls.c
@@ -0,0 +1,62 @@
+#include <linux/percpu.h>
+
+#include <asm/hypercall.h>
+
+#include "multicalls.h"
+
+#define MC_BATCH	8
+#define MC_ARGS		(MC_BATCH * 32 / sizeof(u64))
+
+struct mc_buffer {
+	struct multicall_entry entries[MC_BATCH];
+	u64 args[MC_ARGS];
+	unsigned mcidx, argidx;
+};
+
+static DEFINE_PER_CPU(struct mc_buffer, mc_buffer);
+
+int xen_mc_flush(void)
+{
+	struct mc_buffer *b = &get_cpu_var(mc_buffer);
+	int ret = 0;
+
+	if (b->mcidx) {
+		int i;
+
+		if (HYPERVISOR_multicall(b->entries, b->mcidx) != 0)
+			BUG();
+		for(i = 0; i < b->mcidx; i++)
+			if (b->entries[i].result < 0)
+				ret++;
+		b->mcidx = 0;
+		b->argidx = 0;
+	} else
+		BUG_ON(b->argidx != 0);
+
+	put_cpu_var(mc_buffer);
+
+	return ret;
+}
+
+struct multicall_space xen_mc_entry(size_t args)
+{
+	struct mc_buffer *b = &get_cpu_var(mc_buffer);
+	struct multicall_space ret;
+	unsigned argspace = (args + sizeof(u64) - 1) / sizeof(u64);
+
+	BUG_ON(argspace > MC_ARGS);
+
+	if (b->mcidx == MC_BATCH ||
+	    (b->argidx + argspace) > MC_ARGS)
+		if (xen_mc_flush())
+			BUG();
+
+	ret.mc = &b->entries[b->mcidx];
+	b->mcidx++;
+	ret.args = &b->args[b->argidx];
+	b->argidx += argspace;
+
+	put_cpu_var(mc_buffer);
+
+	return ret;
+}
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/multicalls.h
@@ -0,0 +1,13 @@
+#ifndef _XEN_MULTICALLS_H
+#define _XEN_MULTICALLS_H
+
+struct multicall_space
+{
+	struct multicall_entry *mc;
+	void *args;
+};
+
+struct multicall_space xen_mc_entry(size_t args);
+int xen_mc_flush(void);
+
+#endif /* _XEN_MULTICALLS_H */
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/setup.c
@@ -0,0 +1,96 @@
+/*
+ *	Machine specific setup for xen
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+
+#include <asm/e820.h>
+#include <asm/setup.h>
+#include <asm/hypervisor.h>
+#include <asm/hypercall.h>
+#include <asm/pda.h>
+
+#include <xen/interface/physdev.h>
+#include <xen/features.h>
+
+/* These are code, but not functions.  Defined in entry.S */
+extern const char xen_hypervisor_callback[];
+extern const char xen_failsafe_callback[];
+
+static __initdata struct shared_info init_shared;
+
+/*
+ * Point at some empty memory to start with. We map the real shared_info
+ * page as soon as fixmap is up and running.
+ */
+struct shared_info *HYPERVISOR_shared_info = &init_shared;
+EXPORT_SYMBOL(HYPERVISOR_shared_info);
+
+unsigned long *phys_to_machine_mapping;
+unsigned long *pfn_to_mfn_frame_list_list, *pfn_to_mfn_frame_list[16];
+EXPORT_SYMBOL(phys_to_machine_mapping);
+
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ **/
+
+char * __init xen_memory_setup(void)
+{
+	unsigned long max_pfn = xen_start_info->nr_pages;
+
+	e820.nr_map = 0;
+	add_memory_region(0, PFN_PHYS(max_pfn), E820_RAM);
+
+	return "Xen";
+}
+
+void xen_idle(void)
+{
+	local_irq_disable();
+
+	if (need_resched())
+		local_irq_enable();
+	else {
+		current_thread_info()->status &= ~TS_POLLING;
+		smp_mb__after_clear_bit();
+		safe_halt();
+		current_thread_info()->status |= TS_POLLING;
+	}
+}
+
+void __init xen_arch_setup(void)
+{
+	struct physdevop_set_iopl set_iopl;
+	int rc;
+
+	HYPERVISOR_vm_assist(VMASST_CMD_enable, VMASST_TYPE_4gb_segments);
+	HYPERVISOR_vm_assist(VMASST_CMD_enable, VMASST_TYPE_writable_pagetables);
+
+	if (!xen_feature(XENFEAT_auto_translated_physmap))
+		HYPERVISOR_vm_assist(VMASST_CMD_enable, VMASST_TYPE_pae_extended_cr3);
+
+	HYPERVISOR_set_callbacks(__KERNEL_CS, (unsigned long)xen_hypervisor_callback,
+				 __KERNEL_CS, (unsigned long)xen_failsafe_callback);
+
+	set_iopl.iopl = 1;
+	rc = HYPERVISOR_physdev_op(PHYSDEVOP_SET_IOPL, &set_iopl);
+	if (rc != 0)
+		printk(KERN_INFO "physdev_op failed %d\n", rc);
+
+#ifdef CONFIG_ACPI
+	if (!(xen_start_info->flags & SIF_INITDOMAIN)) {
+		printk(KERN_INFO "ACPI in unprivileged domain disabled\n");
+		acpi_disabled = 1;
+		acpi_ht = 0;
+	}
+#endif
+
+	memcpy(saved_command_line, xen_start_info->cmd_line,
+	       MAX_GUEST_CMDLINE > COMMAND_LINE_SIZE ?
+	       COMMAND_LINE_SIZE : MAX_GUEST_CMDLINE);
+
+	pm_idle = xen_idle;
+
+	vdso_enabled = 1;	/* enable by default */
+}
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/time.c
@@ -0,0 +1,446 @@
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/clocksource.h>
+
+#include <asm/hypercall.h>
+#include <asm/arch_hooks.h>
+
+#include <xen/interface/xen.h>
+#include <xen/interface/vcpu.h>
+
+#include "xen-ops.h"
+#include "events.h"
+
+#define XEN_SHIFT 22
+
+/* Permitted clock jitter, in nsecs, beyond which a warning will be printed. */
+static unsigned long permitted_clock_jitter = 10000000UL; /* 10ms */
+static int __init __permitted_clock_jitter(char *str)
+{
+	permitted_clock_jitter = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("permitted_clock_jitter=", __permitted_clock_jitter);
+
+
+/* These are perodically updated in shared_info, and then copied here. */
+struct shadow_time_info {
+	u64 tsc_timestamp;     /* TSC at last update of time vals.  */
+	u64 system_timestamp;  /* Time, in nanosecs, since boot.    */
+	u32 tsc_to_nsec_mul;
+	int tsc_shift;
+	u32 version;
+};
+
+static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);
+
+/* Keep track of last time we did processing/updating of jiffies and xtime. */
+static u64 processed_system_time;   /* System time (ns) at last processing. */
+static DEFINE_PER_CPU(u64, processed_system_time);
+
+/* How much CPU time was spent blocked and how much was 'stolen'? */
+static DEFINE_PER_CPU(u64, processed_stolen_time);
+static DEFINE_PER_CPU(u64, processed_blocked_time);
+
+/* Current runstate of each CPU (updated automatically by the hypervisor). */
+static DEFINE_PER_CPU(struct vcpu_runstate_info, runstate);
+
+/* Must be signed, as it's compared with s64 quantities which can be -ve. */
+#define NS_PER_TICK (1000000000LL/HZ)
+
+/*
+ * Reads a consistent set of time-base values from Xen, into a shadow data
+ * area.
+ */
+static void get_time_values_from_xen(void)
+{
+	struct vcpu_time_info   *src;
+	struct shadow_time_info *dst;
+
+	src = &read_pda(xen.vcpu)->time;
+	dst = &get_cpu_var(shadow_time);
+
+	do {
+		dst->version = src->version;
+		rmb();
+		dst->tsc_timestamp     = src->tsc_timestamp;
+		dst->system_timestamp  = src->system_time;
+		dst->tsc_to_nsec_mul   = src->tsc_to_system_mul;
+		dst->tsc_shift         = src->tsc_shift;
+		rmb();
+	} while ((src->version & 1) | (dst->version ^ src->version));
+
+	put_cpu_var(shadow_time);
+}
+
+static inline int time_values_up_to_date(void)
+{
+	struct vcpu_time_info   *src;
+	unsigned dstversion;
+
+	src = &read_pda(xen.vcpu)->time;
+	dstversion = get_cpu_var(shadow_time).version;
+	put_cpu_var(shadow_time);
+
+	rmb();
+	return (dstversion == src->version);
+}
+
+/*
+ * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
+ * yielding a 64-bit result.
+ */
+static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
+{
+	u64 product;
+#ifdef __i386__
+	u32 tmp1, tmp2;
+#endif
+
+	if (shift < 0)
+		delta >>= -shift;
+	else
+		delta <<= shift;
+
+#ifdef __i386__
+	__asm__ (
+		"mul  %5       ; "
+		"mov  %4,%%eax ; "
+		"mov  %%edx,%4 ; "
+		"mul  %5       ; "
+		"xor  %5,%5    ; "
+		"add  %4,%%eax ; "
+		"adc  %5,%%edx ; "
+		: "=A" (product), "=r" (tmp1), "=r" (tmp2)
+		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
+#elif __x86_64__
+	__asm__ (
+		"mul %%rdx ; shrd $32,%%rdx,%%rax"
+		: "=a" (product) : "0" (delta), "d" ((u64)mul_frac) );
+#else
+#error implement me!
+#endif
+
+	return product;
+}
+
+static u64 get_nsec_offset(struct shadow_time_info *shadow)
+{
+	u64 now, delta;
+	rdtscll(now);
+	delta = now - shadow->tsc_timestamp;
+	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
+}
+
+
+static void xen_timer_interrupt_hook(void)
+{
+	s64 delta, delta_cpu, stolen, blocked;
+	u64 sched_time;
+	int i, cpu = smp_processor_id();
+	unsigned long ticks;
+	struct shadow_time_info *shadow = &__get_cpu_var(shadow_time);
+	struct vcpu_runstate_info *runstate = &__get_cpu_var(runstate);
+
+	do {
+		get_time_values_from_xen();
+
+		/* Obtain a consistent snapshot of elapsed wallclock cycles. */
+		delta = delta_cpu =
+			shadow->system_timestamp + get_nsec_offset(shadow);
+		if (0)
+			printk("tsc_timestamp=%llu system_timestamp=%llu tsc_to_nsec=%u tsc_shift=%d, version=%u, delta=%lld processed_system_time=%lld\n",
+			       shadow->tsc_timestamp, shadow->system_timestamp,
+			       shadow->tsc_to_nsec_mul, shadow->tsc_shift,
+			       shadow->version, delta, processed_system_time);
+
+		delta     -= processed_system_time;
+		delta_cpu -= __get_cpu_var(processed_system_time);
+
+		/*
+		 * Obtain a consistent snapshot of stolen/blocked cycles. We
+		 * can use state_entry_time to detect if we get preempted here.
+		 */
+		do {
+			sched_time = runstate->state_entry_time;
+			barrier();
+			stolen = runstate->time[RUNSTATE_runnable] +
+				runstate->time[RUNSTATE_offline] -
+				__get_cpu_var(processed_stolen_time);
+			blocked = runstate->time[RUNSTATE_blocked] -
+				__get_cpu_var(processed_blocked_time);
+			barrier();
+		} while (sched_time != runstate->state_entry_time);
+	} while (!time_values_up_to_date());
+
+	if ((unlikely(delta < -(s64)permitted_clock_jitter) ||
+	     unlikely(delta_cpu < -(s64)permitted_clock_jitter))
+	    && printk_ratelimit()) {
+		printk("Timer ISR/%d: Time went backwards: "
+		       "delta=%lld delta_cpu=%lld shadow=%lld "
+		       "off=%lld processed=%lld cpu_processed=%lld\n",
+		       cpu, delta, delta_cpu, shadow->system_timestamp,
+		       (s64)get_nsec_offset(shadow),
+		       processed_system_time,
+		       __get_cpu_var(processed_system_time));
+		for (i = 0; i < num_online_cpus(); i++)
+			printk(" %d: %lld\n", i,
+			       per_cpu(processed_system_time, i));
+	}
+
+	/* System-wide jiffy work. */
+	ticks = 0;
+	while(delta > NS_PER_TICK) {
+		delta -= NS_PER_TICK;
+		processed_system_time += NS_PER_TICK;
+		ticks++;
+	}
+	do_timer(ticks);
+
+	/*
+	 * Account stolen ticks.
+	 * HACK: Passing NULL to account_steal_time()
+	 * ensures that the ticks are accounted as stolen.
+	 */
+	if ((stolen > 0) && (delta_cpu > 0)) {
+		delta_cpu -= stolen;
+		if (unlikely(delta_cpu < 0))
+			stolen += delta_cpu; /* clamp local-time progress */
+		do_div(stolen, NS_PER_TICK);
+		__get_cpu_var(processed_stolen_time) += stolen * NS_PER_TICK;
+		__get_cpu_var(processed_system_time) += stolen * NS_PER_TICK;
+		account_steal_time(NULL, (cputime_t)stolen);
+	}
+
+	/*
+	 * Account blocked ticks.
+	 * HACK: Passing idle_task to account_steal_time()
+	 * ensures that the ticks are accounted as idle/wait.
+	 */
+	if ((blocked > 0) && (delta_cpu > 0)) {
+		delta_cpu -= blocked;
+		if (unlikely(delta_cpu < 0))
+			blocked += delta_cpu; /* clamp local-time progress */
+		do_div(blocked, NS_PER_TICK);
+		__get_cpu_var(processed_blocked_time) += blocked * NS_PER_TICK;
+		__get_cpu_var(processed_system_time)  += blocked * NS_PER_TICK;
+		account_steal_time(idle_task(cpu), (cputime_t)blocked);
+	}
+
+	update_process_times(user_mode_vm(get_irq_regs()));
+}
+
+static cycle_t xen_clocksource_read(void)
+{
+	struct shadow_time_info *shadow = &get_cpu_var(shadow_time);
+	cycle_t ret;
+
+	get_time_values_from_xen();
+
+	ret = shadow->system_timestamp + get_nsec_offset(shadow);
+
+	put_cpu_var(shadow_time);
+
+	return ret;
+}
+
+static void xen_read_wallclock(struct timespec *ts)
+{
+	const struct shared_info *s = HYPERVISOR_shared_info;
+	u32 version;
+	u64 delta;
+	struct timespec now;
+
+	/* get wallclock at system boot */
+	do {
+		version = s->wc_version;
+		rmb();
+		now.tv_sec  = s->wc_sec;
+		now.tv_nsec = s->wc_nsec;
+		rmb();
+	} while ((s->wc_version & 1) | (version ^ s->wc_version));
+
+	delta = xen_clocksource_read();	/* time since system boot */
+	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
+
+	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
+	now.tv_sec = delta;
+
+	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
+}
+
+unsigned long xen_get_wallclock(void)
+{
+	struct timespec ts;
+
+	xen_read_wallclock(&ts);
+
+	return ts.tv_sec;
+}
+
+int xen_set_wallclock(unsigned long now)
+{
+	/* do nothing for domU */
+	return -1;
+}
+
+static void init_cpu_khz(void)
+{
+	u64 __cpu_khz = 1000000ULL << 32;
+	struct vcpu_time_info *info;
+	info = &HYPERVISOR_shared_info->vcpu_info[0].time;
+	do_div(__cpu_khz, info->tsc_to_system_mul);
+	if (info->tsc_shift < 0)
+		cpu_khz = __cpu_khz << -info->tsc_shift;
+	else
+		cpu_khz = __cpu_khz >> info->tsc_shift;
+}
+
+static struct clocksource xen_clocksource = {
+	.name = "xen",
+	.rating = 400,
+	.read = xen_clocksource_read,
+	.mask = ~0,
+	.mult = 1<<XEN_SHIFT,		/* time directly in nanoseconds */
+	.shift = XEN_SHIFT,
+	.is_continuous = 1
+};
+
+static void init_missing_ticks_accounting(int cpu)
+{
+	struct vcpu_register_runstate_memory_area area;
+	struct vcpu_runstate_info *runstate = &per_cpu(runstate, cpu);
+
+	memset(runstate, 0, sizeof(*runstate));
+
+	area.addr.v = runstate;
+	HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area, cpu, &area);
+
+	per_cpu(processed_blocked_time, cpu) =
+		runstate->time[RUNSTATE_blocked];
+	per_cpu(processed_stolen_time, cpu) =
+		runstate->time[RUNSTATE_runnable] +
+		runstate->time[RUNSTATE_offline];
+}
+
+static irqreturn_t xen_timer_interrupt(int irq, void *dev_id)
+{
+	/*
+	 * Here we are in the timer irq handler. We just have irqs locally
+	 * disabled but we don't know if the timer_bh is running on the other
+	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
+	 * the irq version of write_lock because as just said we have irq
+	 * locally disabled. -arca
+	 */
+	write_seqlock(&xtime_lock);
+
+	xen_timer_interrupt_hook();
+
+	write_sequnlock(&xtime_lock);
+
+	return IRQ_HANDLED;
+}
+
+static void setup_cpu0_timer_irq(void)
+{
+	printk(KERN_DEBUG "installing Xen timer for CPU 0\n");
+
+	bind_virq_to_irqhandler(
+		VIRQ_TIMER,
+		0,
+		xen_timer_interrupt,
+		SA_INTERRUPT,
+		"timer0",
+		NULL);
+}
+
+__init void xen_time_init(void)
+{
+	get_time_values_from_xen();
+
+	processed_system_time = per_cpu(shadow_time, 0).system_timestamp;
+	per_cpu(processed_system_time, 0) = processed_system_time;
+
+	init_cpu_khz();
+	printk(KERN_INFO "Xen reported: %u.%03u MHz processor.\n",
+	       cpu_khz / 1000, cpu_khz % 1000);
+
+	setup_cpu0_timer_irq();
+
+	init_missing_ticks_accounting(0);
+
+	clocksource_register(&xen_clocksource);
+
+	/* Set initial system time with full resolution */
+	xen_read_wallclock(&xtime);
+	set_normalized_timespec(&wall_to_monotonic,
+				-xtime.tv_sec, -xtime.tv_nsec);
+
+	tsc_disable = 0;
+}
+
+/* Convert jiffies to system time. */
+static u64 jiffies_to_st(unsigned long j)
+{
+	unsigned long seq;
+	long delta;
+	u64 st;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		delta = j - jiffies;
+		if (delta < 1) {
+			/* Triggers in some wrap-around cases, but that's okay:
+			 * we just end up with a shorter timeout. */
+			st = processed_system_time + NS_PER_TICK;
+		} else if (((unsigned long)delta >> (BITS_PER_LONG-3)) != 0) {
+			/* Very long timeout means there is no pending timer.
+			 * We indicate this to Xen by passing zero timeout. */
+			st = 0;
+		} else {
+			st = processed_system_time + delta * (u64)NS_PER_TICK;
+		}
+	} while (read_seqretry(&xtime_lock, seq));
+
+	return st;
+}
+
+/*
+ * stop_hz_timer / start_hz_timer - enter/exit 'tickless mode' on an idle cpu
+ * These functions are based on implementations from arch/s390/kernel/time.c
+ */
+void stop_hz_timer(void)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long j;
+
+	cpu_set(cpu, nohz_cpu_mask);
+
+	/* 
+	 * See matching smp_mb in rcu_start_batch in rcupdate.c.  These mbs 
+	 * ensure that if __rcu_pending (nested in rcu_needs_cpu) fetches a
+	 * value of rcp->cur that matches rdp->quiescbatch and allows us to
+	 * stop the hz timer then the cpumasks created for subsequent values
+	 * of cur in rcu_start_batch are guaranteed to pick up the updated
+	 * nohz_cpu_mask and so will not depend on this cpu.
+	 */
+
+	smp_mb();
+
+	/* Leave ourselves in tick mode if rcu or softirq or timer pending. */
+	if (rcu_needs_cpu(cpu) || local_softirq_pending() ||
+	    (j = next_timer_interrupt(), time_before_eq(j, jiffies))) {
+		cpu_clear(cpu, nohz_cpu_mask);
+		j = jiffies + 1;
+	}
+
+	if (HYPERVISOR_set_timer_op(jiffies_to_st(j)) != 0)
+		BUG();
+}
+
+void start_hz_timer(void)
+{
+	cpu_clear(smp_processor_id(), nohz_cpu_mask);
+}
+
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/xen-head.S
@@ -0,0 +1,29 @@
+/* Xen-specific pieces of head.S, intended to be included in the right
+	place in head.S */
+
+#include <linux/elfnote.h>
+#include <asm/boot.h>
+#include <xen/interface/elfnote.h>
+
+ENTRY(startup_xen)
+	movl %esi,xen_start_info
+	jmp startup_paravirt
+	
+.pushsection ".bss.page_aligned"
+ENTRY(hypercall_page)
+	.skip 0x1000
+.popsection
+
+	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz, "linux")
+	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz, "2.6")
+	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz, "xen-3.0")
+	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      .long,  __PAGE_OFFSET)
+	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          .long,  startup_xen)
+	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, .long,  hypercall_page)
+	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,       .asciz, "!writable_page_tables|pae_pgdir_above_4gb")
+#ifdef CONFIG_X86_PAE
+	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz, "yes")
+#else
+	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz, "no")
+#endif
+	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz, "generic")
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/xen-ops.h
@@ -0,0 +1,20 @@
+#ifndef XEN_OPS_H
+#define XEN_OPS_H
+
+#include <linux/init.h>
+
+extern struct start_info *xen_start_info;
+extern struct shared_info *HYPERVISOR_shared_info;
+
+char * __init xen_memory_setup(void);
+void __init xen_arch_setup(void);
+void __init xen_init_IRQ(void);
+
+void __init xen_time_init(void);
+unsigned long xen_get_wallclock(void);
+int xen_set_wallclock(unsigned long time);
+
+void stop_hz_timer(void);
+void start_hz_timer(void);
+
+#endif /* XEN_OPS_H */
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/xen-page.h
@@ -0,0 +1,175 @@
+#ifndef __XEN_PAGE_H
+#define __XEN_PAGE_H
+
+#include <linux/pfn.h>
+
+#include <asm/uaccess.h>
+
+#include <xen/features.h>
+
+#ifdef CONFIG_X86_PAE
+/* Xen machine address */
+typedef struct xmaddr {
+	unsigned long long maddr;
+} xmaddr_t;
+
+/* Xen pseudo-physical address */
+typedef struct xpaddr {
+	unsigned long long paddr;
+} xpaddr_t;
+#else
+/* Xen machine address */
+typedef struct xmaddr {
+	unsigned long maddr;
+} xmaddr_t;
+
+/* Xen pseudo-physical address */
+typedef struct xpaddr {
+	unsigned long paddr;
+} xpaddr_t;
+#endif
+
+#define XMADDR(x)	((xmaddr_t) { .maddr = (x) })
+#define XPADDR(x)	((xpaddr_t) { .paddr = (x) })
+
+/**** MACHINE <-> PHYSICAL CONVERSION MACROS ****/
+#define INVALID_P2M_ENTRY	(~0UL)
+#define FOREIGN_FRAME_BIT	(1UL<<31)
+#define FOREIGN_FRAME(m)	((m) | FOREIGN_FRAME_BIT)
+
+extern unsigned long *phys_to_machine_mapping;
+
+static inline unsigned long pfn_to_mfn(unsigned long pfn)
+{
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return pfn;
+
+	return phys_to_machine_mapping[(unsigned int)(pfn)] &
+		~FOREIGN_FRAME_BIT;
+}
+
+static inline int phys_to_machine_mapping_valid(unsigned long pfn)
+{
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return 1;
+
+	return (phys_to_machine_mapping[pfn] != INVALID_P2M_ENTRY);
+}
+
+static inline unsigned long mfn_to_pfn(unsigned long mfn)
+{
+	unsigned long pfn;
+
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return mfn;
+
+#if 0
+	if (unlikely((mfn >> machine_to_phys_order) != 0))
+		return max_mapnr;
+#endif
+
+	pfn = 0;
+	/*
+	 * The array access can fail (e.g., device space beyond end of RAM).
+	 * In such cases it doesn't matter what we return (we return garbage),
+	 * but we must handle the fault without crashing!
+	 */
+	__get_user(pfn, &machine_to_phys_mapping[mfn]);
+
+	return pfn;
+}
+
+static inline xmaddr_t phys_to_machine(xpaddr_t phys)
+{
+	unsigned offset = phys.paddr & ~PAGE_MASK;
+	return XMADDR(PFN_PHYS(pfn_to_mfn(PFN_DOWN(phys.paddr))) | offset);
+}
+
+static inline xpaddr_t machine_to_phys(xmaddr_t machine)
+{
+	unsigned offset = machine.maddr & ~PAGE_MASK;
+	return XPADDR(PFN_PHYS(mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
+}
+
+/*
+ * We detect special mappings in one of two ways:
+ *  1. If the MFN is an I/O page then Xen will set the m2p entry
+ *     to be outside our maximum possible pseudophys range.
+ *  2. If the MFN belongs to a different domain then we will certainly
+ *     not have MFN in our p2m table. Conversely, if the page is ours,
+ *     then we'll have p2m(m2p(MFN))==MFN.
+ * If we detect a special mapping then it doesn't have a 'struct page'.
+ * We force !pfn_valid() by returning an out-of-range pointer.
+ *
+ * NB. These checks require that, for any MFN that is not in our reservation,
+ * there is no PFN such that p2m(PFN) == MFN. Otherwise we can get confused if
+ * we are foreign-mapping the MFN, and the other domain as m2p(MFN) == PFN.
+ * Yikes! Various places must poke in INVALID_P2M_ENTRY for safety.
+ *
+ * NB2. When deliberately mapping foreign pages into the p2m table, you *must*
+ *      use FOREIGN_FRAME(). This will cause pte_pfn() to choke on it, as we
+ *      require. In all the cases we care about, the FOREIGN_FRAME bit is
+ *      masked (e.g., pfn_to_mfn()) so behaviour there is correct.
+ */
+static inline unsigned long mfn_to_local_pfn(unsigned long mfn)
+{
+	extern unsigned long max_mapnr;
+	unsigned long pfn = mfn_to_pfn(mfn);
+	if ((pfn < max_mapnr)
+	    && !xen_feature(XENFEAT_auto_translated_physmap)
+	    && (phys_to_machine_mapping[pfn] != mfn))
+		return max_mapnr; /* force !pfn_valid() */
+	return pfn;
+}
+
+static inline void set_phys_to_machine(unsigned long pfn, unsigned long mfn)
+{
+	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+		BUG_ON(pfn != mfn && mfn != INVALID_P2M_ENTRY);
+		return;
+	}
+	phys_to_machine_mapping[pfn] = mfn;
+}
+
+/* VIRT <-> MACHINE conversion */
+#define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
+#define virt_to_mfn(v)		(pfn_to_mfn(PFN_DOWN(__pa(v))))
+#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
+
+#ifdef CONFIG_X86_PAE
+#define pte_mfn(_pte) (((_pte).pte_low >> PAGE_SHIFT) |\
+                       (((_pte).pte_high & 0xfff) << (32-PAGE_SHIFT)))
+
+static inline pte_t mfn_pte(unsigned long page_nr, pgprot_t pgprot)
+{
+	pte_t pte;
+
+	pte.pte_high = (page_nr >> (32 - PAGE_SHIFT)) | (pgprot_val(pgprot) >> 32);
+	pte.pte_high &= (__supported_pte_mask >> 32);
+	pte.pte_low = ((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+	pte.pte_low &= __supported_pte_mask;
+
+	return pte;
+}
+
+static inline unsigned long long pte_val_ma(pte_t x)
+{
+	return ((unsigned long long)x.pte_high << 32) | x.pte_low;
+}
+#define pmd_val_ma(v) ((v).pmd)
+#define pud_val_ma(v) ((v).pgd.pgd)
+#else  /* !X86_PAE */
+#define pte_mfn(_pte) ((_pte).pte_low >> PAGE_SHIFT)
+#define mfn_pte(pfn, prot)	__pte_ma(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pte_val_ma(x)	((x).pte_low)
+#define pmd_val_ma(v)	((v).pud.pgd.pgd)
+#endif	/* CONFIG_X86_PAE */
+#define pgd_val_ma(x)	((x).pgd)
+
+#define __pte_ma(x)	((pte_t) { (x) } )
+
+xmaddr_t arbitrary_virt_to_machine(unsigned long address);
+void make_lowmem_page_readonly(void *vaddr);
+void make_lowmem_page_readwrite(void *vaddr);
+
+#endif /* __XEN_PAGE_H */
===================================================================
--- a/include/asm-i386/hypercall.h
+++ b/include/asm-i386/hypercall.h
@@ -39,9 +39,6 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
 #include <xen/interface/physdev.h>
-
-#define __STR(x) #x
-#define STR(x) __STR(x)
 
 extern struct { char _entry[32]; } hypercall_page[];
 
@@ -413,4 +410,22 @@ MULTI_mmuext_op(struct multicall_entry *
 	mcl->args[2] = (unsigned long)success_count;
 	mcl->args[3] = domid;
 }
+
+static inline void
+MULTI_set_gdt(struct multicall_entry *mcl, unsigned long *frames, int entries)
+{
+	mcl->op = __HYPERVISOR_set_gdt;
+	mcl->args[0] = (unsigned long)frames;
+	mcl->args[1] = entries;
+}
+
+static inline void
+MULTI_stack_switch(struct multicall_entry *mcl, 
+		   unsigned long ss, unsigned long esp)
+{
+	mcl->op = __HYPERVISOR_stack_switch;
+	mcl->args[0] = ss;
+	mcl->args[1] = esp;
+}
+
 #endif /* __HYPERCALL_H__ */
===================================================================
--- a/include/asm-i386/irq.h
+++ b/include/asm-i386/irq.h
@@ -41,6 +41,7 @@ extern void fixup_irqs(cpumask_t map);
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+fastcall unsigned int do_IRQ(struct pt_regs *regs);
 void init_IRQ(void);
 void __init native_init_IRQ(void);
 
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -31,6 +31,7 @@ struct Xgt_desc_struct;
 struct Xgt_desc_struct;
 struct tss_struct;
 struct mm_struct;
+struct i386_pda;
 struct paravirt_ops
 {
  	int paravirt_enabled;
@@ -53,6 +54,7 @@ struct paravirt_ops
 	void (*arch_setup)(void);
 	char *(*memory_setup)(void);
 	void (*init_IRQ)(void);
+	void (*init_pda)(struct i386_pda *, int cpu);
 
 	void (*pagetable_setup_start)(pgd_t *pgd_base);
 	void (*pagetable_setup_done)(pgd_t *pgd_base);
@@ -200,6 +202,30 @@ extern struct paravirt_ops paravirt_ops;
 
 void native_pagetable_setup_start(pgd_t *pgd);
 
+/* Non-paravirtualized implementations of various operations for
+   back-ends which don't need their own version. */
+fastcall void native_clts(void);
+
+fastcall unsigned long native_read_cr0(void);
+fastcall void native_write_cr0(unsigned long val);
+
+fastcall unsigned long native_read_cr2(void);
+fastcall void native_write_cr2(unsigned long val);
+
+fastcall unsigned long native_read_cr3(void);
+fastcall void native_write_cr3(unsigned long val);
+
+fastcall unsigned long native_read_cr4(void);
+fastcall unsigned long native_read_cr4_safe(void);
+fastcall void native_write_cr4(unsigned long val);
+
+fastcall void native_wbinvd(void);
+
+fastcall unsigned long long native_read_msr(unsigned int msr, int *err);
+fastcall int native_write_msr(unsigned int msr, unsigned long long val);
+fastcall unsigned long long native_read_tsc(void);
+fastcall unsigned long long native_read_pmc(void);
+
 #ifdef CONFIG_X86_PAE
 fastcall unsigned long long native_pte_val(pte_t);
 fastcall unsigned long long native_pmd_val(pmd_t);
@@ -402,6 +428,19 @@ static inline void paravirt_exit_mmap(st
 {
 	paravirt_ops.exit_mmap(mm);
 }
+
+static inline void paravirt_init_pda(struct i386_pda *pda, int cpu)
+{
+	if (paravirt_ops.init_pda)
+		(*paravirt_ops.init_pda)(pda, cpu);
+}
+
+fastcall void native_write_ldt_entry(void *dt, int entrynum, u32 low, u32 high);
+fastcall void native_write_gdt_entry(void *dt, int entrynum, u32 low, u32 high);
+fastcall void native_write_idt_entry(void *dt, int entrynum, u32 low, u32 high);
+fastcall void native_store_gdt(struct Xgt_desc_struct *dtr);
+fastcall void native_store_idt(struct Xgt_desc_struct *dtr);
+fastcall unsigned long native_store_tr(void);
 
 #define __flush_tlb() paravirt_ops.flush_tlb_user()
 #define __flush_tlb_global() paravirt_ops.flush_tlb_kernel()
@@ -696,5 +735,8 @@ static inline void paravirt_exit_mmap(st
 {
 }
 
+static inline void paravirt_init_pda(struct i386_pda *pda, int cpu)
+{
+}
 #endif /* CONFIG_PARAVIRT */
 #endif	/* __ASM_PARAVIRT_H */
===================================================================
--- a/include/asm-i386/pda.h
+++ b/include/asm-i386/pda.h
@@ -16,6 +16,17 @@ struct i386_pda
 	int cpu_number;
 	struct task_struct *pcurrent;	/* current process */
 	struct pt_regs *irq_regs;
+
+#ifdef CONFIG_PARAVIRT
+	union {
+#ifdef CONFIG_XEN
+		struct {
+			struct vcpu_info *vcpu;
+			unsigned long cr3;
+		} xen;
+#endif	/* CONFIG_XEN */
+	};
+#endif	/* CONFIG_PARAVIRT */
 };
 
 extern struct i386_pda *_cpu_pda[];
===================================================================
--- /dev/null
+++ b/include/xen/features.h
@@ -0,0 +1,26 @@
+/******************************************************************************
+ * features.h
+ *
+ * Query the features reported by Xen.
+ *
+ * Copyright (c) 2006, Ian Campbell
+ */
+
+#ifndef __XEN_FEATURES_H__
+#define __XEN_FEATURES_H__
+
+#include <xen/interface/features.h>
+
+void xen_setup_features(void);
+
+extern u8 xen_features[XENFEAT_NR_SUBMAPS * 32];
+
+static inline int xen_feature(int flag)
+{
+	switch(flag) {
+	}
+
+	return xen_features[flag];
+}
+
+#endif /* __ASM_XEN_FEATURES_H__ */

-- 

