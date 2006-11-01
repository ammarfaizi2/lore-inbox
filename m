Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946597AbWKAK2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946597AbWKAK2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946756AbWKAK2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:28:19 -0500
Received: from ozlabs.org ([203.10.76.45]:49858 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946597AbWKAK2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:28:18 -0500
Subject: [PATCH 2/7] paravirtualization: Patch inline replacements for
	common paravirt operations.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:28:13 +1100
Message-Id: <1162376894.23462.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the most called ops, by several orders of magnitude,
are the interrupt manipulation ops.  These are obvious candidates for
patching, so mark them up and create infrastructure for it.

The method used is that the ops structure has a patch function, which
is called for each place which needs to be patched: this returns a
number of instructions (the rest are NOP-padded).

Usually we can spare a register (%eax) for the binary patched code to
use, but in a couple of critical places in entry.S we can't: we make
the clobbers explicit at the call site, and manually clobber the
allowed registers in debug mode as an extra check.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Zachary Amsden <zach@vmware.com>

===================================================================
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -123,6 +123,20 @@ static unsigned char** find_nop_table(vo
 
 #endif /* CONFIG_X86_64 */
 
+static void nop_out(void *insns, unsigned int len)
+{
+	unsigned char **noptable = find_nop_table();
+
+	while (len > 0) {
+		unsigned int noplen = len;
+		if (noplen > ASM_NOP_MAX)
+			noplen = ASM_NOP_MAX;
+		memcpy(insns, noptable[noplen], noplen);
+		insns += noplen;
+		len -= noplen;
+	}
+}
+
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern struct alt_instr __smp_alt_instructions[], __smp_alt_instructions_end[];
 extern u8 *__smp_locks[], *__smp_locks_end[];
@@ -137,10 +151,9 @@ extern u8 __smp_alt_begin[], __smp_alt_e
 
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
-	unsigned char **noptable = find_nop_table();
 	struct alt_instr *a;
 	u8 *instr;
-	int diff, i, k;
+	int diff;
 
 	DPRINTK("%s: alt table %p -> %p\n", __FUNCTION__, start, end);
 	for (a = start; a < end; a++) {
@@ -158,13 +171,7 @@ void apply_alternatives(struct alt_instr
 #endif
 		memcpy(instr, a->replacement, a->replacementlen);
 		diff = a->instrlen - a->replacementlen;
-		/* Pad the rest with nops */
-		for (i = a->replacementlen; diff > 0; diff -= k, i += k) {
-			k = diff;
-			if (k > ASM_NOP_MAX)
-				k = ASM_NOP_MAX;
-			memcpy(a->instr + i, noptable[k], k);
-		}
+		nop_out(instr + a->replacementlen, diff);
 	}
 }
 
@@ -208,7 +215,6 @@ static void alternatives_smp_lock(u8 **s
 
 static void alternatives_smp_unlock(u8 **start, u8 **end, u8 *text, u8 *text_end)
 {
-	unsigned char **noptable = find_nop_table();
 	u8 **ptr;
 
 	for (ptr = start; ptr < end; ptr++) {
@@ -216,7 +222,7 @@ static void alternatives_smp_unlock(u8 *
 			continue;
 		if (*ptr > text_end)
 			continue;
-		**ptr = noptable[1][0];
+		nop_out(*ptr, 1);
 	};
 }
 
@@ -341,6 +347,43 @@ void alternatives_smp_switch(int smp)
 }
 
 #endif
+
+#ifdef CONFIG_PARAVIRT
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
+{
+	struct paravirt_patch *p;
+	int i;
+
+	for (p = start; p < end; p++) {
+		unsigned int used;
+
+		used = paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
+					  p->len);
+#ifdef CONFIG_DEBUG_KERNEL
+		/* Deliberately clobber regs using "not %reg" to find bugs. */
+		for (i = 0; i < 3; i++) {
+			if (p->len - used >= 2 && (p->clobbers & (1 << i))) {
+				memcpy(p->instr + used, "\xf7\xd0", 2);
+				p->instr[used+1] |= i;
+				used += 2;
+			}
+		}
+#endif
+		/* Pad the rest with nops */
+		nop_out(p->instr + used, p->len - used);
+	}
+
+	/* Sync to be conservative, in case we patched following instructions */
+	sync_core();
+}
+extern struct paravirt_patch __start_parainstructions[],
+	__stop_parainstructions[];
+#else
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
+{
+}
+extern struct paravirt_patch *__start_parainstructions, *__stop_parainstructions;
+#endif	/* CONFIG_PARAVIRT */
 
 void __init alternative_instructions(void)
 {
@@ -389,5 +432,6 @@ void __init alternative_instructions(voi
 		alternatives_smp_switch(0);
 	}
 #endif
+ 	apply_paravirt(__start_parainstructions, __stop_parainstructions);
 	local_irq_restore(flags);
 }
===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -53,6 +53,19 @@
 #include <asm/dwarf2.h>
 #include "irq_vectors.h"
 
+/*
+ * We use macros for low-level operations which need to be overridden
+ * for paravirtualization.  The following will never clobber any registers:
+ *   INTERRUPT_RETURN (aka. "iret")
+ *   GET_CR0_INTO_EAX (aka. "movl %cr0, %eax")
+ *   ENABLE_INTERRUPTS_SYSEXIT (aka "sti; sysexit").
+ *
+ * For DISABLE_INTERRUPTS/ENABLE_INTERRUPTS (aka "cli"/"sti"), you must
+ * specify what registers can be overwritten (CLBR_NONE, CLBR_EAX/EDX/ECX/ANY).
+ * Allowing a register to be clobbered can shrink the paravirt replacement
+ * enough to patch inline, increasing performance.
+ */
+
 #define nr_syscalls ((syscall_table_size)/4)
 
 CF_MASK		= 0x00000001
@@ -63,9 +76,9 @@ VM_MASK		= 0x00020000
 VM_MASK		= 0x00020000
 
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
+#define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
-#define preempt_stop
+#define preempt_stop(clobbers)
 #define resume_kernel		restore_nocheck
 #endif
 
@@ -226,7 +239,7 @@ ENTRY(ret_from_fork)
 	ALIGN
 	RING0_PTREGS_FRAME
 ret_from_exception:
-	preempt_stop
+	preempt_stop(CLBR_ANY)
 ret_from_intr:
 	GET_THREAD_INFO(%ebp)
 check_userspace:
@@ -237,7 +250,7 @@ check_userspace:
 	jb resume_kernel		# not returning to v8086 or userspace
 
 ENTRY(resume_userspace)
- 	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
+ 	DISABLE_INTERRUPTS(CLBR_ANY)	# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -248,7 +261,7 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	DISABLE_INTERRUPTS
+	DISABLE_INTERRUPTS(CLBR_ANY)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -277,7 +290,7 @@ sysenter_past_esp:
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	ENABLE_INTERRUPTS
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushl $(__USER_DS)
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ss, 0*/
@@ -322,7 +335,7 @@ 1:	movl (%ebp),%ebp
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,PT_EAX(%esp)
-	DISABLE_INTERRUPTS
+	DISABLE_INTERRUPTS(CLBR_ECX|CLBR_EDX)
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -364,7 +377,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,PT_EAX(%esp)		# store the return value
 syscall_exit:
-	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS(CLBR_ANY)	# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -393,7 +406,7 @@ 1:	INTERRUPT_RETURN
 .section .fixup,"ax"
 iret_exc:
 	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
@@ -436,7 +449,7 @@ ldt_ss:
 	CFI_ADJUST_CFA_OFFSET 4
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
-	DISABLE_INTERRUPTS
+	DISABLE_INTERRUPTS(CLBR_EAX)
 	TRACE_IRQS_OFF
 	lss (%esp), %esp
 	CFI_ADJUST_CFA_OFFSET -8
@@ -451,7 +464,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS(CLBR_ANY)	# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -507,7 +520,7 @@ syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS(CLBR_ANY)	# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -691,7 +704,7 @@ ENTRY(device_not_available)
 	GET_CR0_INTO_EAX
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate
-	preempt_stop
+	preempt_stop(CLBR_ANY)
 	call math_state_restore
 	jmp ret_from_exception
 device_not_available_emulate:
===================================================================
--- a/arch/i386/kernel/module.c
+++ b/arch/i386/kernel/module.c
@@ -109,7 +109,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL;
+	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
+		*para = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) { 
@@ -119,6 +120,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			alt = s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
 			locks= s;
+		if (!strcmp(".parainstructions", secstrings + s->sh_name))
+			para = s;
 	}
 
 	if (alt) {
@@ -133,6 +136,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 					    lseg, lseg + locks->sh_size,
 					    tseg, tseg + text->sh_size);
 	}
+	if (para) {
+		void *pseg = (void *)para->sh_addr;
+		apply_paravirt(pseg, pseg + para->sh_size);
+	}
 
 	return module_bug_finalize(hdr, sechdrs, me);
 }
===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -38,6 +38,49 @@ static void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
 	       paravirt_ops.name);
+}
+
+/* Simple instruction patching code. */
+#define DEF_NATIVE(name, code)					\
+	extern const char start_##name[], end_##name[];		\
+	asm("start_" #name ": " code "; end_" #name ":")
+DEF_NATIVE(cli, "cli");
+DEF_NATIVE(sti, "sti");
+DEF_NATIVE(popf, "push %eax; popf");
+DEF_NATIVE(pushf, "pushf; pop %eax");
+DEF_NATIVE(pushf_cli, "pushf; pop %eax; cli");
+DEF_NATIVE(iret, "iret");
+DEF_NATIVE(sti_sysexit, "sti; sysexit");
+
+static const struct native_insns
+{
+	const char *start, *end;
+} native_insns[] = {
+	[PARAVIRT_IRQ_DISABLE] = { start_cli, end_cli },
+	[PARAVIRT_IRQ_ENABLE] = { start_sti, end_sti },
+	[PARAVIRT_RESTORE_FLAGS] = { start_popf, end_popf },
+	[PARAVIRT_SAVE_FLAGS] = { start_pushf, end_pushf },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] = { start_pushf_cli, end_pushf_cli },
+	[PARAVIRT_INTERRUPT_RETURN] = { start_iret, end_iret },
+	[PARAVIRT_STI_SYSEXIT] = { start_sti_sysexit, end_sti_sysexit },
+};
+
+static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned len)
+{
+	unsigned int insn_len;
+
+	/* Don't touch it if we don't have a replacement */
+	if (type >= ARRAY_SIZE(native_insns) || !native_insns[type].start)
+		return len;
+
+	insn_len = native_insns[type].end - native_insns[type].start;
+
+	/* Similarly if we can't fit replacement. */
+	if (len < insn_len)
+		return len;
+
+	memcpy(insns, native_insns[type].start, insn_len);
+	return insn_len;
 }
 
 static fastcall unsigned long native_get_debugreg(int regno)
@@ -344,6 +387,7 @@ struct paravirt_ops paravirt_ops = {
 	.paravirt_enabled = 0,
 	.kernel_rpl = 0,
 
+ 	.patch = native_patch,
 	.banner = default_banner,
 	.arch_setup = native_nop,
 	.memory_setup = machine_specific_memory_setup,
===================================================================
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -154,6 +154,12 @@ SECTIONS
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
   }
+  . = ALIGN(4);
+  __start_parainstructions = .;
+  .parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
+	*(.parainstructions)
+  }
+  __stop_parainstructions = .;
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
===================================================================
--- a/include/asm-i386/alternative.h
+++ b/include/asm-i386/alternative.h
@@ -118,4 +118,7 @@ static inline void alternatives_smp_swit
 #define LOCK_PREFIX ""
 #endif
 
+struct paravirt_patch;
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
+
 #endif /* _I386_ALTERNATIVE_H */
===================================================================
--- a/include/asm-i386/irqflags.h
+++ b/include/asm-i386/irqflags.h
@@ -79,8 +79,8 @@ static inline unsigned long __raw_local_
 }
 
 #else
-#define DISABLE_INTERRUPTS		cli
-#define ENABLE_INTERRUPTS		sti
+#define DISABLE_INTERRUPTS(clobbers)	cli
+#define ENABLE_INTERRUPTS(clobbers)	sti
 #define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
 #define INTERRUPT_RETURN		iret
 #define GET_CR0_INTO_EAX		movl %cr0, %eax
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -3,8 +3,26 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 #include <linux/linkage.h>
+#include <linux/stringify.h>
 
 #ifdef CONFIG_PARAVIRT
+/* These are the most performance critical ops, so we want to be able to patch
+ * callers */
+#define PARAVIRT_IRQ_DISABLE 0
+#define PARAVIRT_IRQ_ENABLE 1
+#define PARAVIRT_RESTORE_FLAGS 2
+#define PARAVIRT_SAVE_FLAGS 3
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
+#define PARAVIRT_INTERRUPT_RETURN 5
+#define PARAVIRT_STI_SYSEXIT 6
+
+/* Bitmask of what can be clobbered: usually at least eax. */
+#define CLBR_NONE 0x0
+#define CLBR_EAX 0x1
+#define CLBR_ECX 0x2
+#define CLBR_EDX 0x4
+#define CLBR_ANY 0x7
+
 #ifndef __ASSEMBLY__
 struct thread_struct;
 struct Xgt_desc_struct;
@@ -14,6 +32,15 @@ struct paravirt_ops
 	unsigned int kernel_rpl;
  	int paravirt_enabled;
 	const char *name;
+
+	/*
+	 * Patch may replace one of the defined code sequences with arbitrary
+	 * code, subject to the same register constraints.  This generally
+	 * means the code is not free to clobber any registers other than EAX.
+	 * The patch function should return the number of bytes of code
+	 * generated, as we nop pad the rest in generic code.
+	 */
+	unsigned (*patch)(u8 type, u16 clobber, void *firstinsn, unsigned len);
 
 	void (*arch_setup)(void);
 	char *(*memory_setup)(void);
@@ -151,35 +178,6 @@ static inline void __cpuid(unsigned int 
 #define read_cr4() paravirt_ops.read_cr4()
 #define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
 #define write_cr4(x) paravirt_ops.write_cr4(x)
-
-static inline unsigned long __raw_local_save_flags(void)
-{
-	return paravirt_ops.save_fl();
-}
-
-static inline void raw_local_irq_restore(unsigned long flags)
-{
-	return paravirt_ops.restore_fl(flags);
-}
-
-static inline void raw_local_irq_disable(void)
-{
-	paravirt_ops.irq_disable();
-}
-
-static inline void raw_local_irq_enable(void)
-{
-	paravirt_ops.irq_enable();
-}
-
-static inline unsigned long __raw_local_irq_save(void)
-{
-	unsigned long flags = paravirt_ops.save_fl();
-
-	paravirt_ops.irq_disable();
-
-	return flags;
-}
 
 static inline void raw_safe_halt(void)
 {
@@ -272,15 +270,130 @@ static inline void slow_down_io(void) {
 #endif
 }
 
-#define CLI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax"
-#define STI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax"
+/* These all sit in the .parainstructions section to tell us what to patch. */
+struct paravirt_patch {
+	u8 *instr; 		/* original instructions */
+	u8 instrtype;		/* type of this instruction */
+	u8 len;			/* length of original instruction */
+	u16 clobbers;		/* what registers you may clobber */
+};
+
+#define paravirt_alt(insn_string, typenum, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	"  .long 771b\n"				\
+	"  .byte " __stringify(typenum) "\n"		\
+	"  .byte 772b-771b\n"				\
+	"  .short " __stringify(clobber) "\n"		\
+	".popsection"
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%1;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
+			     : "=a"(f): "m"(paravirt_ops.save_fl)
+			     : "memory", "cc");
+	return f;
+}
+
+static inline void raw_local_irq_restore(unsigned long f)
+{
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%1;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
+			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
+			     : "memory", "cc");
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%0;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
+			     : : "m" (paravirt_ops.irq_disable)
+			     : "memory", "eax", "cc");
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%0;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
+			     : : "m" (paravirt_ops.irq_enable)
+			     : "memory", "eax", "cc");
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%1; pushl %%eax;"
+					   "call *%2; popl %%eax;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
+					  CLBR_NONE)
+			     : "=a"(f)
+			     : "m" (paravirt_ops.save_fl),
+			       "m" (paravirt_ops.irq_disable)
+			     : "memory", "cc");
+	return f;
+}
+
+#define CLI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
+		     "call *paravirt_ops+PARAVIRT_irq_disable;"		\
+		     "popl %edx; popl %ecx",				\
+		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
+
+#define STI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
+		     "call *paravirt_ops+PARAVIRT_irq_enable;"		\
+		     "popl %edx; popl %ecx",				\
+		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
+#define CLI_STI_CLOBBERS , "%eax"
+
 #else  /* __ASSEMBLY__ */
-
-#define INTERRUPT_RETURN	jmp *%cs:paravirt_ops+PARAVIRT_iret
-#define DISABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax
-#define ENABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *%cs:paravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax
-#define ENABLE_INTERRUPTS_SYSEXIT	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit
-#define GET_CR0_INTO_EAX	call *paravirt_ops+PARAVIRT_read_cr0
+  
+#define PARA_PATCH(ptype, clobbers, ops)	\
+771:;						\
+	ops;					\
+772:;						\
+	.pushsection .parainstructions,"a";	\
+	 .long 771b;				\
+	 .byte ptype;				\
+	 .byte 772b-771b;			\
+	 .short clobbers;			\
+	.popsection
+
+#define INTERRUPT_RETURN				\
+	PARA_PATCH(PARAVIRT_INTERRUPT_RETURN, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_iret)
+
+#define DISABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_DISABLE, clobbers,	\
+	pushl %ecx; pushl %edx;				\
+	call *paravirt_ops+PARAVIRT_irq_disable;	\
+	popl %edx; popl %ecx)				\
+
+#define ENABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_ENABLE, clobbers,	\
+	pushl %ecx; pushl %edx;				\
+	call *%cs:paravirt_ops+PARAVIRT_irq_enable;	\
+	popl %edx; popl %ecx)
+
+#define ENABLE_INTERRUPTS_SYSEXIT			\
+	PARA_PATCH(PARAVIRT_STI_SYSEXIT, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit)
+
+#define GET_CR0_INTO_EAX			\
+	call *paravirt_ops+PARAVIRT_read_cr0
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT */
 #endif	/* __ASM_PARAVIRT_H */
===================================================================
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -12,6 +12,7 @@
 #else
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
+#define CLI_STI_CLOBBERS
 #endif /* CONFIG_PARAVIRT */
 
 /*
@@ -75,7 +76,9 @@ static inline void __raw_spin_lock_flags
 		"jg 1b\n\t"
 		"jmp 4b\n"
 		"5:\n\t"
-		: "+m" (lock->slock) : "r" (flags) : "memory");
+		: "+m" (lock->slock)
+		: "r" (flags)
+		: "memory" CLI_STI_CLOBBERS);
 }
 #endif
 


