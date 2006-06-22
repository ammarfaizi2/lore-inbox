Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWFVBid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWFVBid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWFVBid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:38:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:55234 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030486AbWFVBic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:38:32 -0400
Date: Wed, 21 Jun 2006 18:38:33 -0700
From: Mike Grundy <grundym@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060622013833.GA1648@dyn9047017076.beaverton.ibm.com>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com
References: <20060612131552.GA6647@localhost.localdomain> <1150141217.5495.72.camel@localhost> <20060621042804.GA20300@localhost.localdomain> <1150907920.8295.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150907920.8295.10.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin - New patch, has the smp_call_function for the instruction 
replacement and the alignment check Jan suggested. Also put in the lpsw, lpswe
and larl checks. A few other clean ups included. Happy reading...

Thanks
Mike

 arch/s390/Kconfig              |   14
 arch/s390/kernel/Makefile      |    1
 arch/s390/kernel/entry.S       |   15 +
 arch/s390/kernel/entry64.S     |   15 +
 arch/s390/kernel/kprobes.c     |  587 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/traps.c       |   42 ++
 arch/s390/kernel/vmlinux.lds.S |    1
 arch/s390/mm/fault.c           |    8
 include/asm-s390/kdebug.h      |   57 +++
 include/asm-s390/kprobes.h     |  107 +++++++
 10 files changed, 841 insertions(+), 6 deletions(-)


diff -urNp linux-2.6.17.1/arch/s390/Kconfig linux-2.6.17.1-kp390/arch/s390/Kconfig
--- linux-2.6.17.1/arch/s390/Kconfig	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/Kconfig	2006-06-21 13:43:06.000000000 -0700
@@ -474,8 +474,22 @@ source "drivers/net/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+	depends on EXPERIMENTAL
+
 source "arch/s390/oprofile/Kconfig"
 
+config KPROBES
+	bool "Kprobes (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && MODULES
+	help
+	  Kprobes allows you to trap at almost any kernel address and
+	  execute a callback function.  register_kprobe() establishes
+	  a probepoint and specifies the callback.  Kprobes is useful
+	  for kernel debugging, non-intrusive instrumentation and testing.
+	  If in doubt, say "N".
+endmenu
+
 source "arch/s390/Kconfig.debug"
 
 source "security/Kconfig"
diff -urNp linux-2.6.17.1/arch/s390/kernel/entry64.S linux-2.6.17.1-kp390/arch/s390/kernel/entry64.S
--- linux-2.6.17.1/arch/s390/kernel/entry64.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/kernel/entry64.S	2006-06-21 18:29:33.000000000 -0700
@@ -497,6 +497,8 @@ pgm_no_vtime2:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	lg	%r1,__TI_task(%r9)
+	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
+	jz	kernel_per
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
@@ -531,6 +533,19 @@ pgm_no_vtime3:
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	j	sysc_do_svc
 
+#
+# per was called from kernel, must be kprobes
+#
+kernel_per:
+	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
+	lghi	%r8,0x7f
+	ngr	%r8,%r3			 # clear per-event-bit and ilc
+	lhi	%r0,__LC_PGM_OLD_PSW
+	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
+	la	%r2,SP_PTREGS(%r15)	# address of register-save area
+	larl	%r14,sysc_leave		# load adr. of system ret, no work
+	brcl	15,do_single_step	# branch to do_single_step
+
 /*
  * IO interrupt handler routine
  */
diff -urNp linux-2.6.17.1/arch/s390/kernel/entry.S linux-2.6.17.1-kp390/arch/s390/kernel/entry.S
--- linux-2.6.17.1/arch/s390/kernel/entry.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/kernel/entry.S	2006-06-21 13:43:06.000000000 -0700
@@ -480,6 +480,8 @@ pgm_no_vtime2:
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
+	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
+	bz	kernel_per
 	l	%r3,__LC_PGM_ILC	 # load program interruption code
 	la	%r8,0x7f
 	nr	%r8,%r3                  # clear per-event-bit and ilc
@@ -510,6 +512,19 @@ pgm_no_vtime3:
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	b	BASED(sysc_do_svc)
 
+#
+# per was called from kernel, must be kprobes
+#
+kernel_per:
+	l	%r3,__LC_PGM_ILC	# load program interruption code
+	la	%r8,0x7f
+	nr	%r8,%r3			# clear per-event-bit and ilc
+	mvi	SP_TRAP+1(%r15),0x28	# set trap indication to pgm check
+	la	%r2,SP_PTREGS(%r15)	# address of register-save area
+	l	%r1,BASED(.Lhandle_per)	# load adr. of per handler
+	la	%r14,BASED(sysc_leave)	# load adr. of system return
+	br	%r1			# branch to do_single_step
+
 /*
  * IO interrupt handler routine
  */
diff -urNp linux-2.6.17.1/arch/s390/kernel/kprobes.c linux-2.6.17.1-kp390/arch/s390/kernel/kprobes.c
--- linux-2.6.17.1/arch/s390/kernel/kprobes.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1-kp390/arch/s390/kernel/kprobes.c	2006-06-21 15:31:41.000000000 -0700
@@ -0,0 +1,587 @@
+/*
+ *  Kernel Probes (KProbes)
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
+ * Copyright (C) IBM Corporation, 2002, 2006
+ *
+ * s390 port, used ppc64 as template. Mike Grundy <grundym@us.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/preempt.h>
+#include <asm/cacheflush.h>
+#include <asm/kdebug.h>
+#include <asm/sections.h>
+
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
+{
+	/* Make sure the probe isn't going on a difficult instruction */
+	if (is_prohibited_opcode((kprobe_opcode_t *) p->addr))
+		return -EINVAL;
+
+	if ((unsigned long)p->addr & 0x01) {
+		printk("Attempt to register kprobe at an unaligned address\n");
+		return -EINVAL;
+		}
+
+	/* Use the get_insn_slot() facility for correctness */
+	if (!(p->ainsn.insn = get_insn_slot()))
+		return -ENOMEM;
+
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	get_instruction_type(&p->ainsn);
+	p->opcode = *p->addr;
+	return 0;
+}
+
+int __kprobes is_prohibited_opcode(kprobe_opcode_t *instruction)
+{
+	switch (*(__u8 *) instruction) {
+	case 0x0c:      /* bassm */
+	case 0x0b:      /* bsm   */
+	case 0x83:      /* diag  */
+	case 0x44:      /* ex    */
+		return -EINVAL;
+	}
+	switch (*(__u16 *) instruction) {
+	case 0x0101:    /* pr    */
+	case 0xb25a:    /* bsa   */
+	case 0xb240:    /* bakr  */
+	case 0xb258:    /* bsg   */
+	case 0xb218:    /* pc    */
+	case 0xb228:    /* pt    */
+		return -EINVAL;
+	}
+	return 0;
+}
+
+void __kprobes get_instruction_type(struct arch_specific_insn *ainsn)
+{
+	/* default fixup method */
+	ainsn->fixup = FIXUP_PSW_NORMAL;
+
+	/* save r1 operand */
+	ainsn->reg = *(__u8 *) (ainsn->insn + 1) & 0xf0;
+
+	/* save the instruction length (pop 5-5) in bytes */
+	switch (*(__u8 *) (ainsn->insn) >> 4) {
+	case 0:
+		ainsn->ilen = 2;
+		break;
+	case 1:
+	case 2:
+		ainsn->ilen = 4;
+		break;
+	case 3:
+		ainsn->ilen = 6;
+		break;
+	}
+
+	switch (*(__u8 *) ainsn->insn) {
+	case 0x05:	/* balr	*/
+	case 0x0d:	/* basr */
+		ainsn->fixup = FIXUP_RETURN_REGISTER;
+		/* if r2 = 0, no branch will be taken */
+		if ((*(__u8 *) (ainsn->insn + 1) & 0x0f) == 0)
+			ainsn->fixup |= FIXUP_BRANCH_NOT_TAKEN;
+		break;
+	case 0x06:	/* bctr	*/
+	case 0x07:	/* bcr	*/
+		ainsn->fixup = FIXUP_BRANCH_NOT_TAKEN;
+		break;
+	case 0x45:	/* bal	*/
+	case 0x4d:	/* bas	*/
+		ainsn->fixup = FIXUP_RETURN_REGISTER;
+		break;
+	case 0x47:	/* bc	*/
+	case 0x46:	/* bct	*/
+	case 0x86:	/* bxh	*/
+	case 0x87:	/* bxle	*/
+		ainsn->fixup = FIXUP_BRANCH_NOT_TAKEN;
+		break;
+	case 0x82:	/* lpsw	*/
+		ainsn->fixup = FIXUP_NOT_REQUIRED;
+		break;
+	case 0xb2:	/* lpswe */
+		if (*(__u8 *) (ainsn->insn + 1) == 0xb2) {
+			ainsn->fixup = FIXUP_NOT_REQUIRED;
+		}
+		break;
+	case 0xa7:	/* bras	*/
+		if ((*(__u8 *) (ainsn->insn + 1) & 0x0f) == 0x05) {
+			ainsn->fixup = FIXUP_RETURN_REGISTER;
+		}
+		break;
+	case 0xc0:
+		if ((*(__u8 *) (ainsn->insn + 1) & 0x0f) == 0x00 ||    /*larl */
+			(*(__u8 *) (ainsn->insn + 1) & 0x0f) == 0x05){ /*brasl*/
+			ainsn->fixup = FIXUP_RETURN_REGISTER;
+		}
+		break;
+	case 0xeb:
+		if (*(__u8 *) (ainsn->insn + 5) == 0x44 ||	/* bxhg  */
+			*(__u8 *) (ainsn->insn + 5) == 0x45) {	/* bxleg */
+			ainsn->fixup = FIXUP_BRANCH_NOT_TAKEN;
+		}
+		break;
+	case 0xe3:	/* bctg	*/
+		if (*(__u8 *) (ainsn->insn + 5) == 0x46) {
+			ainsn->fixup = FIXUP_BRANCH_NOT_TAKEN;
+		}
+		break;
+	}
+}
+
+void smp_replace_instruction(void *info)
+{
+	struct ins_replace_args *parms;
+	parms = (struct ins_replace_args *) info;
+	*parms->addr = parms->insn;
+}
+
+void __kprobes arch_arm_kprobe(struct kprobe *p)
+{
+	struct ins_replace_args parms;
+	parms.addr = p->addr;
+	parms.insn = BREAKPOINT_INSTRUCTION;
+
+	preempt_disable();
+	smp_call_function(smp_replace_instruction, &parms, 0, 1);
+	preempt_enable();
+}
+
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
+{
+	struct ins_replace_args parms;
+	parms.addr = p->addr;
+	parms.insn = p->opcode;
+
+	preempt_disable();
+	smp_call_function(smp_replace_instruction, &parms, 0, 1);
+	preempt_enable();
+}
+
+void __kprobes arch_remove_kprobe(struct kprobe *p)
+{
+	mutex_lock(&kprobe_mutex);
+	free_insn_slot(p->ainsn.insn);
+	mutex_unlock(&kprobe_mutex);
+}
+
+static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+{
+	per_cr_bits kprobe_per_regs[1];
+
+	memset(kprobe_per_regs, 0, sizeof(per_cr_bits));
+	regs->psw.addr = (unsigned long)p->ainsn.insn | PSW_ADDR_AMODE;
+
+	/* Set up the per control reg info, will pass to lctl */
+	kprobe_per_regs[0].em_instruction_fetch = 1;
+	kprobe_per_regs[0].starting_addr = (unsigned long)p->ainsn.insn;
+	kprobe_per_regs[0].ending_addr = (unsigned long)p->ainsn.insn + 1;
+
+	/* Set the PER control regs, turns on single step for this address */
+	__ctl_load(kprobe_per_regs, 9, 11);
+	regs->psw.mask |= PSW_MASK_PER;
+	regs->psw.mask &= ~(PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK);
+}
+
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.kprobe_saved_imask = kcb->kprobe_saved_imask;
+	memcpy(kcb->prev_kprobe.kprobe_saved_ctl, kcb->kprobe_saved_ctl,
+	       sizeof(kcb->kprobe_saved_ctl));
+}
+
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_saved_imask = kcb->prev_kprobe.kprobe_saved_imask;
+	memcpy(kcb->kprobe_saved_ctl, kcb->prev_kprobe.kprobe_saved_ctl,
+	       sizeof(kcb->kprobe_saved_ctl));
+}
+
+static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+						struct kprobe_ctlblk *kcb)
+{
+	__get_cpu_var(current_kprobe) = p;
+	/* Save the interrupt and per flags */
+	kcb->kprobe_saved_imask = regs->psw.mask &
+	    (PSW_MASK_PER | PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK);
+	/* Save the control regs that govern PER */
+	__ctl_store(kcb->kprobe_saved_ctl, 9, 11);
+}
+
+/* Called with kretprobe_lock held */
+void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
+					struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri;
+
+	if ((ri = get_free_rp_inst(rp)) != NULL) {
+		ri->rp = rp;
+		ri->task = current;
+		ri->ret_addr = (kprobe_opcode_t *) regs->gprs[14];
+
+		/* Replace the return addr with trampoline addr */
+		regs->gprs[14] = (unsigned long)&kretprobe_trampoline;
+
+		add_rp_inst(ri);
+	} else {
+		rp->nmissed++;
+	}
+}
+
+static int __kprobes kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p;
+	int ret = 0;
+	unsigned long *addr = (unsigned long *)
+		((regs->psw.addr & PSW_ADDR_INSN) - 2);
+	struct kprobe_ctlblk *kcb;
+
+	/*
+	 * We don't want to be preempted for the entire
+	 * duration of kprobe processing
+	 */
+	preempt_disable();
+	kcb = get_kprobe_ctlblk();
+
+	/* Check we're not actually recursing */
+	if (kprobe_running()) {
+		p = get_kprobe(addr);
+		if (p) {
+			if (kcb->kprobe_status == KPROBE_HIT_SS &&
+			    *p->ainsn.insn == BREAKPOINT_INSTRUCTION) {
+				regs->psw.mask &= ~PSW_MASK_PER;
+				regs->psw.mask |= kcb->kprobe_saved_imask;
+				goto no_kprobe;
+			}
+			/* We have reentered the kprobe_handler(), since
+			 * another probe was hit while within the handler.
+			 * We here save the original kprobes variables and
+			 * just single step on the instruction of the new probe
+			 * without calling any user handlers.
+			 */
+			save_previous_kprobe(kcb);
+			set_current_kprobe(p, regs, kcb);
+			kprobes_inc_nmissed_count(p);
+			prepare_singlestep(p, regs);
+			kcb->kprobe_status = KPROBE_REENTER;
+			return 1;
+		} else {
+			p = __get_cpu_var(current_kprobe);
+			if (p->break_handler && p->break_handler(p, regs)) {
+				goto ss_probe;
+			}
+		}
+		goto no_kprobe;
+	}
+
+	p = get_kprobe(addr);
+	if (!p) {
+		if (*addr != BREAKPOINT_INSTRUCTION) {
+			/*
+			 * The breakpoint instruction was removed right
+			 * after we hit it.  Another cpu has removed
+			 * either a probepoint or a debugger breakpoint
+			 * at this address.  In either case, no further
+			 * handling of this interrupt is appropriate.
+			 *
+			 */
+			ret = 1;
+		}
+		/* Not one of ours: let kernel handle it */
+		goto no_kprobe;
+	}
+
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+	set_current_kprobe(p, regs, kcb);
+	if (p->pre_handler && p->pre_handler(p, regs))
+		/* handler has already set things up, so skip ss setup */
+		return 1;
+
+	ss_probe:
+	prepare_singlestep(p, regs);
+	kcb->kprobe_status = KPROBE_HIT_SS;
+	return 1;
+
+	no_kprobe:
+	preempt_enable_no_resched();
+	return ret;
+}
+
+/*
+ * Function return probe trampoline:
+ * 	- init_kprobes() establishes a probepoint here
+ * 	- When the probed function returns, this probe
+ * 		causes the handlers to fire
+ */
+void kretprobe_trampoline_holder(void)
+{
+	asm volatile (".global kretprobe_trampoline\n"
+		      "kretprobe_trampoline:\n" "bcr 0,0\n");
+}
+
+/*
+ * Called when the probe at kretprobe trampoline is hit
+ */
+int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kretprobe_instance *ri = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node, *tmp;
+	unsigned long flags, orig_ret_address = 0;
+	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
+
+	spin_lock_irqsave(&kretprobe_lock, flags);
+	head = kretprobe_inst_table_head(current);
+
+	/*
+	 * It is possible to have multiple instances associated with a given
+	 * task either because an multiple functions in the call path
+	 * have a return probe installed on them, and/or more then one return
+	 * return probe was registered for a target function.
+	 *
+	 * We can handle this because:
+	 *     - instances are always inserted at the head of the list
+	 *     - when multiple return probes are registered for the same
+	 *       function, the first instance's ret_addr will point to the
+	 *       real return address, and all the rest will point to
+	 *       kretprobe_trampoline
+	 */
+	hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
+		if (ri->task != current)
+			/* another task is sharing our hash bucket */
+			continue;
+
+		if (ri->rp && ri->rp->handler)
+			ri->rp->handler(ri, regs);
+
+		orig_ret_address = (unsigned long)ri->ret_addr;
+		recycle_rp_inst(ri);
+
+		if (orig_ret_address != trampoline_address) {
+			/*
+			 * This is the real return address. Any other
+			 * instances associated with this task are for
+			 * other calls deeper on the call stack
+			 */
+			break;
+		}
+	}
+	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
+	regs->psw.addr = orig_ret_address | PSW_ADDR_AMODE;
+
+	reset_current_kprobe();
+	spin_unlock_irqrestore(&kretprobe_lock, flags);
+	preempt_enable_no_resched();
+
+	/*
+	 * By returning a non-zero value, we are telling
+	 * kprobe_handler() that we don't want the post_handler
+	 * to run (and have re-enabled preemption)
+	 */
+	return 1;
+}
+
+/*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "breakpoint"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn.
+ */
+static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	regs->psw.addr &= PSW_ADDR_INSN;
+
+	if (p->ainsn.fixup & FIXUP_PSW_NORMAL)
+		regs->psw.addr = (unsigned long)p->addr +
+				((unsigned long)regs->psw.addr -
+				 (unsigned long)p->ainsn.insn);
+
+	if (p->ainsn.fixup & FIXUP_BRANCH_NOT_TAKEN)
+		if ((unsigned long)regs->psw.addr -
+		    (unsigned long)p->ainsn.insn == p->ainsn.ilen)
+			regs->psw.addr = (unsigned long)p->addr + p->ainsn.ilen;
+
+	if (p->ainsn.fixup & FIXUP_RETURN_REGISTER)
+		regs->gprs[p->ainsn.reg] = (unsigned long)p->addr +
+						(regs->gprs[p->ainsn.reg] -
+						(unsigned long)p->ainsn.insn);
+
+	regs->psw.addr |= PSW_ADDR_AMODE;
+	/* turn off PER mode */
+	regs->psw.mask &= ~PSW_MASK_PER;
+	/* Restore the original per control regs */
+	__ctl_load(kcb->kprobe_saved_ctl, 9, 11);
+	regs->psw.mask |= kcb->kprobe_saved_imask;
+}
+
+static int __kprobes post_kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (!cur)
+		return 0;
+
+	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
+	}
+
+	resume_execution(cur, regs);
+
+	/*Restore back the original saved kprobes variables and continue. */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		goto out;
+	}
+	reset_current_kprobe();
+	out:
+	preempt_enable_no_resched();
+
+	/*
+	 * if somebody else is singlestepping across a probe point, psw mask
+	 * will have PER set, in which case, continue the remaining processing
+	 * of do_single_step, as if this is not a probe hit.
+	 */
+	if (regs->psw.mask & PSW_MASK_PER) {
+		return 0;
+	}
+
+	return 1;
+}
+
+static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
+		return 1;
+
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		resume_execution(cur, regs);
+		regs->psw.mask |= kcb->kprobe_saved_imask;
+
+		reset_current_kprobe();
+		preempt_enable_no_resched();
+	}
+	return 0;
+}
+
+/*
+ * Wrapper routine to for handling exceptions.
+ */
+int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	switch (val) {
+	case DIE_BPT:
+		if (kprobe_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+	case DIE_SSTEP:
+		if (post_kprobe_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+	case DIE_TRAP:
+	case DIE_PAGE_FAULT:
+		/* kprobe_running() needs smp_processor_id() */
+		preempt_disable();
+		if (kprobe_running() &&
+		    kprobe_fault_handler(args->regs, args->trapnr))
+			ret = NOTIFY_STOP;
+		preempt_enable();
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	unsigned long addr;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
+
+	/* setup return addr to the jprobe handler routine */
+	regs->psw.addr = (unsigned long)(jp->entry) | PSW_ADDR_AMODE;
+
+	/* r14 is the function return address */
+	kcb->jprobe_saved_r14 = (unsigned long)regs->gprs[14];
+	/* r15 is the stack pointer */
+	kcb->jprobe_saved_r15 = (unsigned long)regs->gprs[15];
+	addr = (unsigned long)kcb->jprobe_saved_r15;
+
+	memcpy(kcb->jprobes_stack, (kprobe_opcode_t *) addr,
+	       MIN_STACK_SIZE(addr));
+	return 1;
+}
+
+void __kprobes jprobe_return(void)
+{
+	asm volatile (".word 0x0002");
+}
+
+void __kprobes jprobe_return_end(void)
+{
+	asm volatile ("bcr 0,0");
+}
+
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long stack_addr = (unsigned long)(kcb->jprobe_saved_r15);
+
+	/* Put the regs back */
+	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
+	/* put the stack back */
+	memcpy((kprobe_opcode_t *) stack_addr, kcb->jprobes_stack,
+	       MIN_STACK_SIZE(stack_addr));
+	preempt_enable_no_resched();
+	return 1;
+}
+
+static struct kprobe trampoline_p = {
+	.addr = (kprobe_opcode_t *) & kretprobe_trampoline,
+	.pre_handler = trampoline_probe_handler
+};
+
+int __init arch_init_kprobes(void)
+{
+	return register_kprobe(&trampoline_p);
+}
diff -urNp linux-2.6.17.1/arch/s390/kernel/Makefile linux-2.6.17.1-kp390/arch/s390/kernel/Makefile
--- linux-2.6.17.1/arch/s390/kernel/Makefile	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/kernel/Makefile	2006-06-21 13:43:06.000000000 -0700
@@ -21,6 +21,7 @@ obj-$(CONFIG_COMPAT)		+= compat_linux.o 
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 # Kexec part
 S390_KEXEC_OBJS := machine_kexec.o crash.o
diff -urNp linux-2.6.17.1/arch/s390/kernel/traps.c linux-2.6.17.1-kp390/arch/s390/kernel/traps.c
--- linux-2.6.17.1/arch/s390/kernel/traps.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/kernel/traps.c	2006-06-21 13:43:06.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/reboot.h>
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -40,6 +41,7 @@
 #include <asm/s390_ext.h>
 #include <asm/lowcore.h>
 #include <asm/debug.h>
+#include <asm/kdebug.h>
 
 /* Called from entry.S only */
 extern void handle_per_exception(struct pt_regs *regs);
@@ -75,6 +77,20 @@ static int kstack_depth_to_print = 12;
 static int kstack_depth_to_print = 20;
 #endif /* CONFIG_64BIT */
 
+ATOMIC_NOTIFIER_HEAD(s390die_chain);
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&s390die_chain, nb);
+}
+EXPORT_SYMBOL(register_die_notifier);
+
+int unregister_die_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&s390die_chain, nb);
+}
+EXPORT_SYMBOL(unregister_die_notifier);
+
 /*
  * For show_trace we have tree different stack to consider:
  *   - the panic stack which is used if the kernel stack has overflown
@@ -308,8 +324,9 @@ report_user_fault(long interruption_code
 #endif
 }
 
-static void inline do_trap(long interruption_code, int signr, char *str,
-                           struct pt_regs *regs, siginfo_t *info)
+static void __kprobes inline do_trap(long interruption_code, int signr,
+					char *str, struct pt_regs *regs,
+					siginfo_t *info)
 {
 	/*
 	 * We got all needed information from the lowcore and can
@@ -318,6 +335,10 @@ static void inline do_trap(long interrup
         if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
+	if (notify_die(DIE_TRAP, str, regs, interruption_code,
+				interruption_code, signr) == NOTIFY_STOP)
+		return;
+
         if (regs->psw.mask & PSW_MASK_PSTATE) {
                 struct task_struct *tsk = current;
 
@@ -339,8 +360,12 @@ static inline void *get_check_address(st
 	return (void *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
 }
 
-void do_single_step(struct pt_regs *regs)
+void __kprobes do_single_step(struct pt_regs *regs)
 {
+	if (notify_die(DIE_SSTEP, "sstep", regs, 0, 0,
+					SIGTRAP) == NOTIFY_STOP){
+		return;
+	}
 	if ((current->ptrace & PT_PTRACED) != 0)
 		force_sig(SIGTRAP, current);
 }
@@ -466,8 +491,15 @@ asmlinkage void illegal_op(struct pt_reg
 #endif
 		} else
 			signal = SIGILL;
-	} else
-		signal = SIGILL;
+	} else {
+		/*
+		 * If we get an illegal op in kernel mode, send it through the
+		 * kprobes notifier. If kprobes doesn't pick it up, SIGILL
+		 */
+		if (notify_die(DIE_BPT, "bpt", regs, interruption_code,
+					3, SIGTRAP) != NOTIFY_STOP)
+			signal = SIGILL;
+	}
 
 #ifdef CONFIG_MATHEMU
         if (signal == SIGFPE)
diff -urNp linux-2.6.17.1/arch/s390/kernel/vmlinux.lds.S linux-2.6.17.1-kp390/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6.17.1/arch/s390/kernel/vmlinux.lds.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/kernel/vmlinux.lds.S	2006-06-21 13:43:06.000000000 -0700
@@ -25,6 +25,7 @@ SECTIONS
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
diff -urNp linux-2.6.17.1/arch/s390/mm/fault.c linux-2.6.17.1-kp390/arch/s390/mm/fault.c
--- linux-2.6.17.1/arch/s390/mm/fault.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-kp390/arch/s390/mm/fault.c	2006-06-21 13:43:06.000000000 -0700
@@ -26,10 +26,12 @@
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/hardirq.h>
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
+#include <asm/kdebug.h>
 
 #ifndef CONFIG_64BIT
 #define __FAIL_ADDR_MASK 0x7ffff000
@@ -160,7 +162,7 @@ static void do_sigsegv(struct pt_regs *r
  *   11       Page translation     ->  Not present       (nullification)
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
-static inline void
+static inline void __kprobes
 do_exception(struct pt_regs *regs, unsigned long error_code, int is_protection)
 {
         struct task_struct *tsk;
@@ -174,6 +176,10 @@ do_exception(struct pt_regs *regs, unsig
         tsk = current;
         mm = tsk->mm;
 	
+	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+					SIGSEGV) == NOTIFY_STOP)
+		return;
+
 	/* 
          * Check for low-address protection.  This needs to be treated
 	 * as a special case because the translation exception code 
diff -urNp linux-2.6.17.1/include/asm-s390/kdebug.h linux-2.6.17.1-kp390/include/asm-s390/kdebug.h
--- linux-2.6.17.1/include/asm-s390/kdebug.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1-kp390/include/asm-s390/kdebug.h	2006-06-21 13:43:06.000000000 -0700
@@ -0,0 +1,57 @@
+#ifndef _S390_KDEBUG_H
+#define _S390_KDEBUG_H 1
+
+/*
+ * Feb 2006 Ported to s390 <grundym@us.ibm.com>
+ */
+#include <linux/notifier.h>
+
+struct pt_regs;
+
+struct die_args {
+	struct pt_regs *regs;
+	const char *str;
+	long err;
+	int trapnr;
+	int signr;
+};
+
+/* Note - you should never unregister because that can race with NMIs.
+ * If you really want to do it first unregister - then synchronize_sched
+ *  - then free.
+ */
+extern int register_die_notifier(struct notifier_block *);
+extern int unregister_die_notifier(struct notifier_block *);
+extern struct atomic_notifier_head s390die_chain;
+
+
+enum die_val {
+	DIE_OOPS = 1,
+	DIE_BPT,
+	DIE_SSTEP,
+	DIE_PANIC,
+	DIE_NMI,
+	DIE_DIE,
+	DIE_NMIWATCHDOG,
+	DIE_KERNELDEBUG,
+	DIE_TRAP,
+	DIE_GPF,
+	DIE_CALL,
+	DIE_NMI_IPI,
+	DIE_PAGE_FAULT,
+};
+
+static inline int notify_die(enum die_val val, const char *str,
+			struct pt_regs *regs, long err, int trap, int sig)
+{
+	struct die_args args = {
+		.regs = regs,
+		.str = str,
+		.err = err,
+		.trapnr = trap,
+		.signr = sig
+	};
+	return atomic_notifier_call_chain(&s390die_chain, val, &args);
+}
+
+#endif
diff -urNp linux-2.6.17.1/include/asm-s390/kprobes.h linux-2.6.17.1-kp390/include/asm-s390/kprobes.h
--- linux-2.6.17.1/include/asm-s390/kprobes.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1-kp390/include/asm-s390/kprobes.h	2006-06-21 13:48:19.000000000 -0700
@@ -0,0 +1,107 @@
+#ifndef _ASM_S390_KPROBES_H
+#define _ASM_S390_KPROBES_H
+/*
+ *  Kernel Probes (KProbes)
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
+ *		Probes initial implementation ( includes suggestions from
+ *		Rusty Russell).
+ * 2004-Nov	Modified for PPC64 by Ananth N Mavinakayanahalli
+ *		<ananth@in.ibm.com>
+ * 2005-Dec	Used as a template for s390 by Mike Grundy
+ * 		<grundym@us.ibm.com>
+ */
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/percpu.h>
+
+#define  __ARCH_WANT_KPROBES_INSN_SLOT
+struct pt_regs;
+struct kprobe;
+
+typedef u16 kprobe_opcode_t;
+#define BREAKPOINT_INSTRUCTION	0x0002
+
+/* Maximum instruction size is 3 (16bit) halfwords: */
+#define MAX_INSN_SIZE		0x0003
+#define MAX_STACK_SIZE 		64
+#define MIN_STACK_SIZE(ADDR) (((MAX_STACK_SIZE) < \
+	(((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR))) \
+	? (MAX_STACK_SIZE) \
+	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
+
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
+
+#define ARCH_SUPPORTS_KRETPROBES
+
+#define FIXUP_PSW_NORMAL 	0x08
+#define FIXUP_BRANCH_NOT_TAKEN	0x04
+#define FIXUP_RETURN_REGISTER	0x02
+#define FIXUP_NOT_REQUIRED	0x01
+
+/* Architecture specific copy of original instruction */
+struct arch_specific_insn {
+	/* copy of original instruction */
+	kprobe_opcode_t *insn;
+	int fixup;
+	int ilen;
+	int reg;
+};
+
+struct ins_replace_args {
+	kprobe_opcode_t insn;
+	kprobe_opcode_t *addr;
+};
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+	unsigned long saved_psw;
+	unsigned long kprobe_saved_imask;
+	unsigned long kprobe_saved_ctl[3];
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_saved_imask;
+	unsigned long kprobe_saved_ctl[3];
+	struct pt_regs jprobe_saved_regs;
+	unsigned long jprobe_saved_r14;
+	unsigned long jprobe_saved_r15;
+	struct prev_kprobe prev_kprobe;
+	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
+};
+
+void arch_remove_kprobe(struct kprobe *p);
+void kretprobe_trampoline(void);
+int  is_prohibited_opcode(kprobe_opcode_t *instruction);
+void  get_instruction_type(struct arch_specific_insn *ainsn);
+#endif	/* _ASM_S390_KPROBES_H */
+
+#ifdef CONFIG_KPROBES
+
+extern int kprobe_exceptions_notify(struct notifier_block *self,
+				    unsigned long val, void *data);
+#else	/* !CONFIG_KPROBES */
+static inline int kprobe_exceptions_notify(struct notifier_block *self,
+					   unsigned long val, void *data)
+{
+	return 0;
+}
+#endif
