Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263669AbUJ3KEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbUJ3KEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 06:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbUJ3KEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 06:04:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6561 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263669AbUJ3KCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 06:02:15 -0400
Date: Sun, 31 Oct 2004 02:33:24 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com, dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [patch 2/3] kprobes :  kprobes ported to x86_64
Message-ID: <20041030210324.GB1266@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041028113208.GA11182@in.ibm.com> <20041028113444.GA5812@in.ibm.com> <20041028113558.GB5812@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028113558.GB5812@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adopted from i386 architecture.

Kprobes:

Helps developers to trap at almost any kernel code address, specifying
a handler routine to be invoked when the breakpoint is hit. Useful
for analysing the Linux kernel by collecting debugging information
non-disruptively. Employs single-stepping out-of-line to avoid probe
misses on SMP and may be especially useful in aiding debugging elusive
races and problems on live systems. More elaborate dynamic tracing
tools can be built over the kprobes interface.

Sample usage:
	To place a probe on __blockdev_direct_IO:
	static int probe_handler(struct kprobe *p, struct pt_regs *)
	{
		... whatever ...
	}
	struct kprobe kp = {
		.addr = __blockdev_direct_IO,
		.pre_handler = probe_handler
	};
	register_kprobe(&kp);

Jprobes:

A special kprobe type which can be placed on function entry points,
and employs a simple mirroring principle to allow seamless access 
to the arguments of a function being probed. The probe handler 
routine should have the same prototype as the function being probed.

The way it works is that when the probe is hit, the breakpoint
handler simply irets to the probe handler's rip while retaining
register and stack state corresponding to the function entry.
After it is done, the probe handler calls jprobe_return() which
traps again to restore processor state and switch back to the
probed function. Linus noted correctly at KS that we need to be 
careful as gcc assumes that the callee owns arguments. We save and
restore enough stack bytes to cover argument space.

Sample Usage:
	static int jip_queue_xmit(struct sk_buff *skb, int ipfragok)
	{
		... whatever ...
		jprobe_return();
		return 0;
	}

	struct jprobe jp = {
		{.addr = (kprobe_opcode_t *) ip_queue_xmit},
		.entry = (kprobe_opcode_t *) jip_queue_xmit
	};
	register_jprobe(&jp);

---
Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---


---

 linux-2.6.9-final-prasanna/arch/x86_64/Kconfig.debug        |   10 
 linux-2.6.9-final-prasanna/arch/x86_64/kernel/Makefile      |    1 
 linux-2.6.9-final-prasanna/arch/x86_64/kernel/kprobes.c     |  481 ++++++++++++
 linux-2.6.9-final-prasanna/arch/x86_64/kernel/traps.c       |   30 
 linux-2.6.9-final-prasanna/arch/x86_64/kernel/x8664_ksyms.c |    2 
 linux-2.6.9-final-prasanna/arch/x86_64/mm/fault.c           |    5 
 linux-2.6.9-final-prasanna/include/asm-x86_64/kdebug.h      |    3 
 linux-2.6.9-final-prasanna/include/asm-x86_64/kprobes.h     |   61 +
 8 files changed, 589 insertions(+), 4 deletions(-)

diff -puN arch/x86_64/Kconfig.debug~kprobes-x86_64-port-2.6.9-final arch/x86_64/Kconfig.debug
--- linux-2.6.9-final/arch/x86_64/Kconfig.debug~kprobes-x86_64-port-2.6.9-final	2004-10-31 02:13:29.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/x86_64/Kconfig.debug	2004-10-31 02:13:29.000000000 +0530
@@ -18,6 +18,16 @@ config INIT_DEBUG
 	  Fill __init and __initdata at the end of boot. This helps debugging
 	  illegal uses of __init and __initdata after initialization.
 
+config KPROBES
+	bool "Kprobes"
+	depends on DEBUG_KERNEL
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
 	depends on DEBUG_KERNEL && PROC_FS
diff -puN /dev/null arch/x86_64/kernel/kprobes.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/x86_64/kernel/kprobes.c	2004-10-31 02:13:29.000000000 +0530
@@ -0,0 +1,481 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  arch/x86_64/kernel/kprobes.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2002-Oct	Created by Vamsi Krishna S <vamsi_krishna@in.ibm.com> Kernel
+ *		Probes initial implementation ( includes contributions from
+ *		Rusty Russell).
+ * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
+ *		interface to access function arguments.
+ * 2004-Oct	Jim Keniston <kenistoj@us.ibm.com> and Prasanna S Panchamukhi
+ *		<prasanna@in.ibm.com> adapted for x86_64
+ */
+
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/preempt.h>
+#include <linux/vmalloc.h>
+
+#include <asm/pgtable.h>
+#include <asm/kdebug.h>
+
+/* kprobe_status settings */
+#define KPROBE_HIT_ACTIVE	0x00000001
+#define KPROBE_HIT_SS		0x00000002
+
+static struct kprobe *current_kprobe;
+static unsigned long kprobe_status, kprobe_old_rflags, kprobe_saved_rflags;
+static struct pt_regs jprobe_saved_regs;
+static long *jprobe_saved_rsp;
+static kprobe_opcode_t *get_insn_slot(void);
+static void free_insn_slot(kprobe_opcode_t *slot);
+void jprobe_return_end(void);
+
+/* copy of the kernel stack at the probe fire time */
+static kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
+
+/*
+ * returns non-zero if opcode modifies the interrupt flag.
+ */
+static inline int is_IF_modifier(kprobe_opcode_t *insn)
+{
+	switch (*insn) {
+	case 0xfa:		/* cli */
+	case 0xfb:		/* sti */
+	case 0xcf:		/* iret/iretd */
+	case 0x9d:		/* popf/popfd */
+		return 1;
+	}
+
+	if (*insn  >= 0x40 && *insn <= 0x4f && *++insn == 0xcf)
+		return 1;
+	return 0;
+}
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	/* insn: must be on special executable page on x86_64. */
+	p->ainsn.insn = get_insn_slot();
+	if (!p->ainsn.insn) {
+		return -ENOMEM;
+	}
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE);
+	return 0;
+}
+
+void arch_remove_kprobe(struct kprobe *p)
+{
+	free_insn_slot(p->ainsn.insn);
+}
+
+static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	*p->addr = p->opcode;
+	regs->rip = (unsigned long)p->addr;
+}
+
+static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->eflags |= TF_MASK;
+	regs->eflags &= ~IF_MASK;
+
+	regs->rip = (unsigned long)p->ainsn.insn;
+}
+
+/*
+ * Interrupts are disabled on entry as trap3 is an interrupt gate and they
+ * remain disabled thorough out this function.
+ */
+int kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p;
+	int ret = 0;
+	kprobe_opcode_t *addr = (kprobe_opcode_t *)(regs->rip - sizeof(kprobe_opcode_t));
+
+	/* We're in an interrupt, but this is clear and BUG()-safe. */
+	preempt_disable();
+
+	/* Check we're not actually recursing */
+	if (kprobe_running()) {
+		/* We *are* holding lock here, so this is safe.
+		   Disarm the probe we just hit, and ignore it. */
+		p = get_kprobe(addr);
+		if (p) {
+			disarm_kprobe(p, regs);
+			ret = 1;
+		} else {
+			p = current_kprobe;
+			if (p->break_handler && p->break_handler(p, regs)) {
+				goto ss_probe;
+			}
+		}
+		/* If it's not ours, can't be delete race, (we hold lock). */
+		goto no_kprobe;
+	}
+
+	lock_kprobes();
+	p = get_kprobe(addr);
+	if (!p) {
+		unlock_kprobes();
+		if (*addr != BREAKPOINT_INSTRUCTION) {
+			/*
+			 * The breakpoint instruction was removed right
+			 * after we hit it.  Another cpu has removed
+			 * either a probepoint or a debugger breakpoint
+			 * at this address.  In either case, no further
+			 * handling of this interrupt is appropriate.
+			 */
+			ret = 1;
+		}
+		/* Not one of ours: let kernel handle it */
+		goto no_kprobe;
+	}
+
+	kprobe_status = KPROBE_HIT_ACTIVE;
+	current_kprobe = p;
+	kprobe_saved_rflags = kprobe_old_rflags
+	    = (regs->eflags & (TF_MASK | IF_MASK));
+	if (is_IF_modifier(p->ainsn.insn))
+		kprobe_saved_rflags &= ~IF_MASK;
+
+	if (p->pre_handler(p, regs)) {
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+	}
+
+      ss_probe:
+	prepare_singlestep(p, regs);
+	kprobe_status = KPROBE_HIT_SS;
+	return 1;
+
+      no_kprobe:
+	preempt_enable_no_resched();
+	return ret;
+}
+
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "int 3"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn.
+ *
+ * This function prepares to return from the post-single-step
+ * interrupt.  We have to fix up the stack as follows:
+ *
+ * 0) Except in the case of absolute or indirect jump or call instructions,
+ * the new rip is relative to the copied instruction.  We need to make
+ * it relative to the original instruction.
+ *
+ * 1) If the single-stepped instruction was pushfl, then the TF and IF
+ * flags are set in the just-pushed eflags, and may need to be cleared.
+ *
+ * 2) If the single-stepped instruction was a call, the return address
+ * that is atop the stack is the address following the copied instruction.
+ * We need to make it the address following the original instruction.
+ */
+static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long *tos = (unsigned long *)regs->rsp;
+	unsigned long next_rip = 0;
+	unsigned long copy_rip = (unsigned long)p->ainsn.insn;
+	unsigned long orig_rip = (unsigned long)p->addr;
+	kprobe_opcode_t *insn = p->ainsn.insn;
+
+	/*skip the REX prefix*/
+	if (*insn >= 0x40 && *insn <= 0x4f)
+		insn++;
+
+	switch (*insn) {
+	case 0x9c:		/* pushfl */
+		*tos &= ~(TF_MASK | IF_MASK);
+		*tos |= kprobe_old_rflags;
+		break;
+	case 0xe8:		/* call relative - Fix return addr */
+		*tos = orig_rip + (*tos - copy_rip);
+		break;
+	case 0xff:
+		if ((*insn & 0x30) == 0x10) {
+			/* call absolute, indirect */
+			/* Fix return addr; rip is correct. */
+			next_rip = regs->rip;
+			*tos = orig_rip + (*tos - copy_rip);
+		} else if (((*insn & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
+			   ((*insn & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
+			/* rip is correct. */
+			next_rip = regs->rip;
+		}
+		break;
+	case 0xea:		/* jmp absolute -- rip is correct */
+		next_rip = regs->rip;
+		break;
+	default:
+		break;
+	}
+
+	regs->eflags &= ~TF_MASK;
+	if (next_rip) {
+		regs->rip = next_rip;
+	} else {
+		regs->rip = orig_rip + (regs->rip - copy_rip);
+	}
+}
+
+/*
+ * Interrupts are disabled on entry as trap1 is an interrupt gate and they
+ * remain disabled thoroughout this function.  And we hold kprobe lock.
+ */
+int post_kprobe_handler(struct pt_regs *regs)
+{
+	if (!kprobe_running())
+		return 0;
+
+	if (current_kprobe->post_handler)
+		current_kprobe->post_handler(current_kprobe, regs, 0);
+
+	resume_execution(current_kprobe, regs);
+	regs->eflags |= kprobe_saved_rflags;
+
+	unlock_kprobes();
+	preempt_enable_no_resched();
+
+	/*
+	 * if somebody else is singlestepping across a probe point, eflags
+	 * will have TF set, in which case, continue the remaining processing
+	 * of do_debug, as if this is not a probe hit.
+	 */
+	if (regs->eflags & TF_MASK)
+		return 0;
+
+	return 1;
+}
+
+/* Interrupts disabled, kprobe_lock held. */
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	if (current_kprobe->fault_handler
+	    && current_kprobe->fault_handler(current_kprobe, regs, trapnr))
+		return 1;
+
+	if (kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(current_kprobe, regs);
+		regs->eflags |= kprobe_old_rflags;
+
+		unlock_kprobes();
+		preempt_enable_no_resched();
+	}
+	return 0;
+}
+
+/*
+ * Wrapper routine for handling exceptions.
+ */
+int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
+			     void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	switch (val) {
+	case DIE_INT3:
+		if (kprobe_handler(args->regs))
+			return NOTIFY_STOP;
+		break;
+	case DIE_DEBUG:
+		if (post_kprobe_handler(args->regs))
+			return NOTIFY_STOP;
+		break;
+	case DIE_GPF:
+		if (kprobe_running() &&
+		    kprobe_fault_handler(args->regs, args->trapnr))
+			return NOTIFY_STOP;
+		break;
+	case DIE_PAGE_FAULT:
+		if (kprobe_running() &&
+		    kprobe_fault_handler(args->regs, args->trapnr))
+			return NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	unsigned long addr;
+
+	jprobe_saved_regs = *regs;
+	jprobe_saved_rsp = (long *) regs->rsp;
+	addr = (unsigned long)jprobe_saved_rsp;
+	/*
+	 * As Linus pointed out, gcc assumes that the callee
+	 * owns the argument space and could overwrite it, e.g.
+	 * tailcall optimization. So, to be absolutely safe
+	 * we also save and restore enough stack bytes to cover
+	 * the argument area.
+	 */
+	memcpy(jprobes_stack, (kprobe_opcode_t *) addr, MIN_STACK_SIZE(addr));
+	regs->eflags &= ~IF_MASK;
+	regs->rip = (unsigned long)(jp->entry);
+	return 1;
+}
+
+void jprobe_return(void)
+{
+	preempt_enable_no_resched();
+	asm volatile ("       xchg   %%rbx,%%rsp     \n"
+		      "       int3			\n"
+		      "       .globl jprobe_return_end	\n"
+		      "       jprobe_return_end:	\n"
+		      "       nop			\n"::"b"
+		      (jprobe_saved_rsp):"memory");
+}
+
+int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	u8 *addr = (u8 *) (regs->rip - 1);
+	unsigned long stack_addr = (unsigned long)jprobe_saved_rsp;
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+
+	if ((addr > (u8 *) jprobe_return) && (addr < (u8 *) jprobe_return_end)) {
+		if ((long *)regs->rsp != jprobe_saved_rsp) {
+			struct pt_regs *saved_regs =
+			    container_of(jprobe_saved_rsp, struct pt_regs, rsp);
+			printk("current rsp %p does not match saved rsp %p\n",
+			       (long *)regs->rsp, jprobe_saved_rsp);
+			printk("Saved registers for jprobe %p\n", jp);
+			show_registers(saved_regs);
+			printk("Current registers\n");
+			show_registers(regs);
+			BUG();
+		}
+		*regs = jprobe_saved_regs;
+		memcpy((kprobe_opcode_t *) stack_addr, jprobes_stack,
+		       MIN_STACK_SIZE(stack_addr));
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * kprobe->ainsn.insn points to the copy of the instruction to be single-stepped.
+ * By default on x86_64, pages we get from kmalloc or vmalloc are not
+ * executable.  Single-stepping an instruction on such a page yields an
+ * oops.  So instead of storing the instruction copies in their respective
+ * kprobe objects, we allocate a page, map it executable, and store all the
+ * instruction copies there.  (We can allocate additional pages if somebody
+ * inserts a huge number of probes.)  Each page can hold up to INSNS_PER_PAGE
+ * instruction slots, each of which is MAX_INSN_SIZE*sizeof(kprobe_opcode_t)
+ * bytes.
+ */
+#define INSNS_PER_PAGE (PAGE_SIZE/(MAX_INSN_SIZE*sizeof(kprobe_opcode_t)))
+struct kprobe_insn_page {
+	struct hlist_node hlist;
+	kprobe_opcode_t *insns;		/* page of instruction slots */
+	char slot_used[INSNS_PER_PAGE];
+	int nused;
+};
+
+static struct hlist_head kprobe_insn_pages;
+
+/**
+ * get_insn_slot() - Find a slot on an executable page for an instruction.
+ * We allocate an executable page if there's no room on existing ones.
+ */
+static kprobe_opcode_t *get_insn_slot(void)
+{
+	struct kprobe_insn_page *kip;
+	struct hlist_node *pos;
+
+	hlist_for_each(pos, &kprobe_insn_pages) {
+		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
+		if (kip->nused < INSNS_PER_PAGE) {
+			int i;
+			for (i = 0; i < INSNS_PER_PAGE; i++) {
+				if (!kip->slot_used[i]) {
+					kip->slot_used[i] = 1;
+					kip->nused++;
+					return kip->insns + (i*MAX_INSN_SIZE);
+				}
+			}
+			/* Surprise!  No unused slots.  Fix kip->nused. */
+			kip->nused = INSNS_PER_PAGE;
+		}
+	}
+
+	/* All out of space.  Need to allocate a new page. Use slot 0.*/
+	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_ATOMIC);
+	if (!kip) {
+		return NULL;
+	}
+	kip->insns = (kprobe_opcode_t*) __vmalloc(PAGE_SIZE,
+		GFP_ATOMIC|__GFP_HIGHMEM, __pgprot(__PAGE_KERNEL_EXEC));
+	if (!kip->insns) {
+		kfree(kip);
+		return NULL;
+	}
+	INIT_HLIST_NODE(&kip->hlist);
+	hlist_add_head(&kip->hlist, &kprobe_insn_pages);
+	memset(kip->slot_used, 0, INSNS_PER_PAGE);
+	kip->slot_used[0] = 1;
+	kip->nused = 1;
+	return kip->insns;
+}
+
+/**
+ * free_insn_slot() - Free instruction slot obtained from get_insn_slot().
+ */
+static void free_insn_slot(kprobe_opcode_t *slot)
+{
+	struct kprobe_insn_page *kip;
+	struct hlist_node *pos;
+
+	hlist_for_each(pos, &kprobe_insn_pages) {
+		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
+		if (kip->insns <= slot
+		    && slot < kip->insns+(INSNS_PER_PAGE*MAX_INSN_SIZE)) {
+			int i = (slot - kip->insns) / MAX_INSN_SIZE;
+			kip->slot_used[i] = 0;
+			kip->nused--;
+			if (kip->nused == 0) {
+				/*
+				 * Page is no longer in use.  Free it unless
+				 * it's the last one.  We keep the last one
+				 * so as not to have to set it up again the
+				 * next time somebody inserts a probe.
+				 */
+				hlist_del(&kip->hlist);
+				if (hlist_empty(&kprobe_insn_pages)) {
+					INIT_HLIST_NODE(&kip->hlist);
+					hlist_add_head(&kip->hlist,
+						&kprobe_insn_pages);
+				} else {
+					vfree(kip->insns);
+					kfree(kip);
+				}
+			}
+			return;
+		}
+	}
+}
diff -puN arch/x86_64/kernel/Makefile~kprobes-x86_64-port-2.6.9-final arch/x86_64/kernel/Makefile
--- linux-2.6.9-final/arch/x86_64/kernel/Makefile~kprobes-x86_64-port-2.6.9-final	2004-10-31 02:13:29.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/x86_64/kernel/Makefile	2004-10-31 02:13:29.000000000 +0530
@@ -25,6 +25,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_prin
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 
diff -puN arch/x86_64/kernel/traps.c~kprobes-x86_64-port-2.6.9-final arch/x86_64/kernel/traps.c
--- linux-2.6.9-final/arch/x86_64/kernel/traps.c~kprobes-x86_64-port-2.6.9-final	2004-10-31 02:13:29.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/x86_64/kernel/traps.c	2004-10-31 02:13:29.000000000 +0530
@@ -46,6 +46,7 @@
 
 #include <linux/irq.h>
 
+
 extern struct gate_struct idt_table[256]; 
 
 asmlinkage void divide_error(void);
@@ -72,6 +73,17 @@ asmlinkage void spurious_interrupt_bug(v
 asmlinkage void call_debug(void);
 
 struct notifier_block *die_chain;
+static spinlock_t die_notifier_lock = SPIN_LOCK_UNLOCKED;
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	int err = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&die_notifier_lock, flags);
+	err = notifier_chain_register(&die_chain, nb);
+	spin_unlock_irqrestore(&die_notifier_lock, flags);
+	return err;
+}
 
 static inline void conditional_sti(struct pt_regs *regs)
 {
@@ -458,7 +470,6 @@ asmlinkage void do_##name(struct pt_regs
 }
 
 DO_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->rip)
-DO_ERROR( 3, SIGTRAP, "int3", int3);
 DO_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->rip)
@@ -601,6 +612,15 @@ asmlinkage void default_do_nmi(struct pt
 	inb(0x71);		/* dummy */
 }
 
+asmlinkage void do_int3(struct pt_regs * regs, long error_code)
+{
+	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP) == NOTIFY_STOP) {
+		return;
+	}
+	do_trap(3, SIGTRAP, "int3", regs, error_code, NULL);
+	return;
+}
+
 /* runs on IST stack. */
 asmlinkage void *do_debug(struct pt_regs * regs, unsigned long error_code)
 {
@@ -630,6 +650,10 @@ asmlinkage void *do_debug(struct pt_regs
 
 	asm("movq %%db6,%0" : "=r" (condition));
 
+	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
+						SIGTRAP) == NOTIFY_STOP) {
+		return regs;
+	}
 	conditional_sti(regs);
 
 	/* Mask out spurious debug traps due to lazy DR7 setting */
@@ -862,8 +886,8 @@ void __init trap_init(void)
 	set_intr_gate(0,&divide_error);
 	set_intr_gate_ist(1,&debug,DEBUG_STACK);
 	set_intr_gate_ist(2,&nmi,NMI_STACK);
-	set_system_gate(3,&int3);	/* int3-5 can be called from all */
-	set_system_gate(4,&overflow);
+	set_intr_gate(3,&int3);
+	set_system_gate(4,&overflow);	/* int4-5 can be called from all */
 	set_system_gate(5,&bounds);
 	set_intr_gate(6,&invalid_op);
 	set_intr_gate(7,&device_not_available);
diff -puN arch/x86_64/kernel/x8664_ksyms.c~kprobes-x86_64-port-2.6.9-final arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.9-final/arch/x86_64/kernel/x8664_ksyms.c~kprobes-x86_64-port-2.6.9-final	2004-10-31 02:13:29.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/x86_64/kernel/x8664_ksyms.c	2004-10-31 02:13:29.000000000 +0530
@@ -32,6 +32,7 @@
 #include <asm/unistd.h>
 #include <asm/delay.h>
 #include <asm/tlbflush.h>
+#include <asm/kdebug.h>
 
 extern spinlock_t rtc_lock;
 
@@ -197,6 +198,7 @@ EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
 
 EXPORT_SYMBOL(die_chain);
+EXPORT_SYMBOL(register_die_notifier);
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_sibling_map);
diff -puN arch/x86_64/mm/fault.c~kprobes-x86_64-port-2.6.9-final arch/x86_64/mm/fault.c
--- linux-2.6.9-final/arch/x86_64/mm/fault.c~kprobes-x86_64-port-2.6.9-final	2004-10-31 02:13:29.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/x86_64/mm/fault.c	2004-10-31 02:13:29.000000000 +0530
@@ -23,6 +23,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/compiler.h>
 #include <linux/module.h>
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -32,6 +33,7 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 #include <asm-generic/sections.h>
+#include <asm/kdebug.h>
 
 void bust_spinlocks(int yes)
 {
@@ -268,6 +270,9 @@ asmlinkage void do_page_fault(struct pt_
 
 	/* get the address */
 	__asm__("movq %%cr2,%0":"=r" (address));
+	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+					SIGSEGV) == NOTIFY_STOP)
+		return;
 
 	if (likely(regs->eflags & X86_EFLAGS_IF))
 		local_irq_enable();
diff -puN include/asm-x86_64/kdebug.h~kprobes-x86_64-port-2.6.9-final include/asm-x86_64/kdebug.h
--- linux-2.6.9-final/include/asm-x86_64/kdebug.h~kprobes-x86_64-port-2.6.9-final	2004-10-31 02:13:29.000000000 +0530
+++ linux-2.6.9-final-prasanna/include/asm-x86_64/kdebug.h	2004-10-31 02:13:29.000000000 +0530
@@ -16,8 +16,8 @@ struct die_args { 
 /* Note - you should never unregister because that can race with NMIs.
    If you really want to do it first unregister - then synchronize_kernel - then free. 
   */
+int register_die_notifier(struct notifier_block *nb);
 extern struct notifier_block *die_chain;
-
 /* Grossly misnamed. */
 enum die_val { 
 	DIE_OOPS = 1,
@@ -32,6 +32,7 @@ enum die_val { 
 	DIE_GPF,
 	DIE_CALL,
 	DIE_NMI_IPI,
+	DIE_PAGE_FAULT,
 }; 
 	
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
diff -puN /dev/null include/asm-x86_64/kprobes.h
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-final-prasanna/include/asm-x86_64/kprobes.h	2004-10-31 02:17:27.000000000 +0530
@@ -0,0 +1,61 @@
+#ifndef _ASM_KPROBES_H
+#define _ASM_KPROBES_H
+/*
+ *  Kernel Probes (KProbes)
+ *  include/asm-x86_64/kprobes.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2002, 2004
+ *
+ * 2004-Oct	Prasanna S Panchamukhi <prasanna@in.ibm.com> and Jim Keniston
+ *		kenistoj@us.ibm.com adopted from i386.
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+struct pt_regs;
+
+typedef u8 kprobe_opcode_t;
+#define BREAKPOINT_INSTRUCTION	0xcc
+#define MAX_INSN_SIZE 15
+#define MAX_STACK_SIZE 64
+#define MIN_STACK_SIZE(ADDR) (((MAX_STACK_SIZE) < \
+	(((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR))) \
+	? (MAX_STACK_SIZE) \
+	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
+
+/* Architecture specific copy of original instruction*/
+struct arch_specific_insn {
+	/* copy of the original instruction */
+	kprobe_opcode_t *insn;
+};
+
+/* trap3/1 are intr gates for kprobes.  So, restore the status of IF,
+ * if necessary, before executing the original int3/1 (trap) handler.
+ */
+static inline void restore_interrupts(struct pt_regs *regs)
+{
+	if (regs->eflags & IF_MASK)
+		local_irq_enable();
+}
+
+extern int post_kprobe_handler(struct pt_regs *regs);
+extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+extern int kprobe_handler(struct pt_regs *regs);
+
+extern int kprobe_exceptions_notify(struct notifier_block *self,
+				    unsigned long val, void *data);
+#endif				/* _ASM_KPROBES_H */

_
-- 

Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
