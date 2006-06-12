Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWFLRP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWFLRP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWFLRP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:15:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:11483 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751297AbWFLRPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:15:55 -0400
Date: Mon, 12 Jun 2006 09:15:52 -0400
From: Mike Grundy <grundym@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, systemtap@sources.redhat.com
Subject: [PATCH] kprobes for s390 architecture
Message-ID: <20060612131552.GA6647@localhost.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
	systemtap@sources.redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks -

This patch provides kprobes support for s390 architecture

Thanks
Mike
--

Signed-off-by: Michael Grundy <grundym@us.ibm.com>

 arch/s390/Kconfig              |   14
 arch/s390/kernel/Makefile      |    1
 arch/s390/kernel/entry.S       |    4
 arch/s390/kernel/entry64.S     |   18 +
 arch/s390/kernel/kprobes.c     |  648 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/traps.c       |   42 ++
 arch/s390/kernel/vmlinux.lds.S |    1
 arch/s390/mm/fault.c           |    8
 include/asm-s390/kdebug.h      |   57 +++
 include/asm-s390/kprobes.h     |  208 +++++++++++++
 10 files changed, 995 insertions(+), 6 deletions(-)

diff -urNp linux-2.6.17-rc6/arch/s390/Kconfig linux-2.6.17-rc6-kp390/arch/s390/Kconfig
--- linux-2.6.17-rc6/arch/s390/Kconfig	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/Kconfig	2006-06-12 05:13:05.000000000 -0400
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
diff -urNp linux-2.6.17-rc6/arch/s390/kernel/entry64.S linux-2.6.17-rc6-kp390/arch/s390/kernel/entry64.S
--- linux-2.6.17-rc6/arch/s390/kernel/entry64.S	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/kernel/entry64.S	2006-06-12 05:13:05.000000000 -0400
@@ -478,6 +478,8 @@ pgm_per:
         clc     __LC_PGM_OLD_PSW(16),__LC_SVC_NEW_PSW
         je      pgm_svcper
 # no interesting special case, ignore PER event
+	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
+	jz	kernel_per
 	lmg	%r12,%r15,__LC_SAVE_AREA
 	lpswe   __LC_PGM_OLD_PSW
 
@@ -497,6 +499,8 @@ pgm_no_vtime2:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
 	lg	%r1,__TI_task(%r9)
+	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
+	jz	kernel_per
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
@@ -531,6 +535,20 @@ pgm_no_vtime3:
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	j	sysc_do_svc
 
+#
+# per was called from kernel, must be kprobes
+#
+kernel_per:
+	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
+	lghi	%r8,0x7f
+	ngr	%r8,%r3			 # clear per-event-bit and ilc
+	j	sysc_singlestep
+	lhi	%r0,__LC_PGM_OLD_PSW
+	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
+	la	%r2,SP_PTREGS(%r15)	# address of register-save area
+	larl	%r14,sysc_leave		# load adr. of system ret, no work
+	brcl	15,do_single_step		# branch to do_single_step
+
 /*
  * IO interrupt handler routine
  */
diff -urNp linux-2.6.17-rc6/arch/s390/kernel/entry.S linux-2.6.17-rc6-kp390/arch/s390/kernel/entry.S
--- linux-2.6.17-rc6/arch/s390/kernel/entry.S	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/kernel/entry.S	2006-06-12 05:13:05.000000000 -0400
@@ -456,6 +456,8 @@ pgm_per:
 # ok its one of the special cases, now we need to find out which one
         clc     __LC_PGM_OLD_PSW(8),__LC_SVC_NEW_PSW
         be      BASED(pgm_svcper)
+	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
+	bz	BASED(sysc_singlestep)
 # no interesting special case, ignore PER event
         lm      %r12,%r15,__LC_SAVE_AREA
 	lpsw    0x28
@@ -480,6 +482,8 @@ pgm_no_vtime2:
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
+	tm	__LC_PGM_OLD_PSW+1(%r15),0x01	# kernel per event ?
+	bz	BASED(sysc_singlestep)
 	l	%r3,__LC_PGM_ILC	 # load program interruption code
 	la	%r8,0x7f
 	nr	%r8,%r3                  # clear per-event-bit and ilc
diff -urNp linux-2.6.17-rc6/arch/s390/kernel/kprobes.c linux-2.6.17-rc6-kp390/arch/s390/kernel/kprobes.c
--- linux-2.6.17-rc6/arch/s390/kernel/kprobes.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc6-kp390/arch/s390/kernel/kprobes.c	2006-06-12 08:27:27.000000000 -0400
@@ -0,0 +1,648 @@
+/*
+ *  Kernel Probes (KProbes)
+ *  arch/s390/kernel/kprobes.c
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
+	int ret = 0;
+
+	/* Make sure the probe isn't going on a difficult instruction */
+	if (is_prohibited_opcode((kprobe_opcode_t *) p->addr))
+		ret = -EINVAL;
+
+	/* Use the get_insn_slot() facility for correctness */
+	if (!ret) {
+		p->ainsn.insn = get_insn_slot();
+		if (!p->ainsn.insn) {
+			ret = -ENOMEM;
+		} else {
+			/* this should only happen if you got the slot */
+			memcpy(p->ainsn.insn, p->addr,
+			       MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+			p->ainsn.inst_type =
+			    get_instruction_type(p->ainsn.insn);
+		}
+	}
+	p->opcode = *p->addr;
+	return ret;
+}
+
+int __kprobes is_prohibited_opcode(kprobe_opcode_t *instruction)
+{
+	__u8 opcode[6];
+	int ret = 0;
+
+	memcpy(opcode, instruction, 6 * sizeof(__u8));
+
+	switch (opcode[0]) {
+	case OPCODE_BASSM:
+	case OPCODE_BSM:
+	case OPCODE_DIAG:
+	case OPCODE_EX:
+		ret = -EINVAL;
+		break;
+	case OPCODE_PR:
+		if (opcode[1] == OPCODE_PR)
+			ret = -EINVAL;
+		break;
+	case 0xB2:
+		switch (opcode[1]) {
+		case OPCODE_BSA:
+		case OPCODE_BAKR:
+		case OPCODE_BSG:
+		case OPCODE_PC:
+		case OPCODE_PT:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	}
+	return ret;
+}
+
+/* get_instruction type will return 0 if only the regular offset adjustments
+ * after out of line singlestep are required. If a register needs to be fixed,
+ * bits 16-23 will contain the register number, bits 24-31 contain the length
+ * of the instruction unit. If fixup is only required when the branch is not
+ * taken, bits 0-16 will all be set.
+ */
+int __kprobes get_instruction_type(kprobe_opcode_t * instruction)
+{
+	__u8 opcode[6];
+	int ret = 0;
+
+	memcpy(opcode, instruction, 6 * sizeof(__u8));
+
+	switch (opcode[0]) {
+		/* RR Format - instruction unit length = 2
+		 *  ________ ____ ____
+		 * |Op Code | R1 | R2 |
+		 * |________|_M1_|____|
+		 * 0         8   12  15
+		 */
+	case BALR:	/* PSW addr saved in R1, branch address in R2 */
+		ret = (opcode[1] & 0xf0) + 2;
+		/* Special non branching use of BALR */
+		if ((opcode[1] & 0x0f) == 0)
+			ret &= FIXUP_NOBRANCH;
+		break;
+	case BASR:	/* PSW addr saved in R1, branch address in R2 */
+		ret = (opcode[1] & 0xf0) + 2;
+		/* Special non branching use of BASR */
+		if ((opcode[1] & 0x0f) == 0)
+			ret &= FIXUP_NOBRANCH;
+		break;
+	case BCR:	/* M1 is mask val (condition), branch addr in R2 */
+		ret = FIXUP_NOBRANCH & 2;
+		break;
+	case BCTR:	/* R1 is count down, R2 is branch addr until R1 = 0 */
+		ret = FIXUP_NOBRANCH & 2;
+		break;
+		/* RX Format - instruction unit length = 4
+		 *  ________ ____ ____ ____ ____________
+		 * |Op Code | R1 | X2 | B2 |     D2     |
+		 * |________|_M1_|____|____|____________|
+		 * 0         8   12   16   20          31
+		 */
+	case BAL:	/* PSW addr saved in R1, branch addr D2(X2,B2) */
+		ret = (opcode[1] & 0xf0) + 4;
+		break;
+	case BAS:	/* PSW addr saved in R1, branch addr D2(X2,B2) */
+		ret = (opcode[1] & 0xf0) + 4;
+		break;
+	case BC:	/* M1 is mask val (condition), branch addr D2(X2,B2) */
+		ret = FIXUP_NOBRANCH & 4;
+		break;
+	case BCT:	/* R1 is count down, D2(X2,B2) is branch addr */
+		ret = FIXUP_NOBRANCH & 4;
+		break;
+		/* RI Format - instruction unit length = 4
+		 *  ________ ____ ____ _________________
+		 * |Op Code | R1 |OpCd|       I2        |
+		 * |________|____|____|_________________|
+		 * 0         8   12   16               31
+		 */
+	case 0xA7:	/* first byte (multiple ops have same 1st byte) */
+		if ((opcode[1] & 0x0f) == BRAS) {
+			ret = (opcode[1] & 0xf0) + 4;
+		}
+		break;
+		/* RS Format - instruction unit length = 4
+		 *  ________ ____ ____ ____ ____________
+		 * |Op Code | R1 | R3 | B2 |     D2     |
+		 * |________|____|_M3_|____|____________|
+		 * 0         8   12   16   20          31
+		 */
+	case BXH:
+		ret = FIXUP_NOBRANCH & 4;
+		break;
+	case BXLE:
+		ret = FIXUP_NOBRANCH & 4;
+		break;
+		/* RIL Format - instruction unit length = 6
+		 *  ________ ____ ____ _____________/______________
+		 * |Op Code | R1 |OpCd|            I2              |
+		 * |________|_M1_|____|_____________/______________|
+		 * 0         8   12   16                          47
+		 */
+	case 0xC0:
+		if ((opcode[1] & 0x0f) == BRASL) {
+			ret = (opcode[1] & 0xf0) + 6;
+		} else if ((opcode[1] & 0x0f) == BRCL) {
+			ret = FIXUP_NOBRANCH & 6;
+		}
+		break;
+		/* RSY Format - instruction unit length = 6
+		 *  ________ ____ ____ ____ __/__ ________ ________
+		 * |Op Code | R1 | R3 | B2 | DL2 |  DH2   |Op Code |
+		 * |________|____|_M3_|____|__/__|________|________|
+		 * 0         8   12   16   20    32       40      47
+		 */
+	case 0xEB:
+		if (opcode[5] == BXHG || opcode[5] == BXLEG) {
+			ret = FIXUP_NOBRANCH & 6;
+		}
+		break;
+		/* RXY Format - instruction unit length = 6
+		 *  ________ ____ ____ ____ __/__ ________ ________
+		 * |Op Code | R1 | X2 | B2 | DL2 |  DH2   |Op Code |
+		 * |________|____|____|____|__/__|________|________|
+		 * 0         8   12   16   20    32       40      47
+		 */
+	case 0xE3:
+		if (opcode[5] == BCTG) {
+			ret = FIXUP_NOBRANCH & 6;
+		}
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+void __kprobes arch_arm_kprobe(struct kprobe *p)
+{
+	*p->addr = BREAKPOINT_INSTRUCTION;
+}
+
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
+{
+	*p->addr = p->opcode;
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
+	regs->psw.addr = (unsigned long)p->ainsn.insn;
+
+	/* Just make sure this gets done */
+	regs->psw.addr |= PSW_ADDR_AMODE;
+
+	/* Set up the per control reg info, will pass to lctl */
+	kprobe_per_regs[0].em_instruction_fetch = 1;
+	kprobe_per_regs[0].starting_addr = regs->psw.addr;
+	kprobe_per_regs[0].ending_addr = regs->psw.addr + 4;
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
+				      struct kprobe_ctlblk *kcb)
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
+				      struct pt_regs *regs)
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
+	    ((regs->psw.addr & PSW_ADDR_INSN) - 2);
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
+	int ilen, reg;
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	/* regular fixup, just apply the offset */
+	if (p->ainsn.inst_type == 0)
+		regs->psw.addr = fix_offset((unsigned long)p->addr,
+					    (unsigned long)p->ainsn.insn,
+					    (unsigned long)regs->psw.addr);
+	/* only apply the offset if the branch wasn't taken */
+	else if (p->ainsn.inst_type < 0) {
+		ilen = p->ainsn.inst_type & 0x0f;
+		reg = (p->ainsn.inst_type & 0xf0) >> 4;
+		if ((unsigned long)regs->psw.addr -
+		    (unsigned long)p->ainsn.insn == ilen) {
+			/* reg slot is only nonzero here on basr
+			 * and balr special cases, fixup reg too
+			 */
+			if (reg != 0)
+				regs->gprs[reg] = (unsigned long)p->addr + ilen;
+			regs->psw.addr = (unsigned long)p->addr + ilen;
+		}
+	} else {
+		ilen = p->ainsn.inst_type & 0x0f;
+		reg = (p->ainsn.inst_type & 0xf0) >> 4;
+		regs->gprs[reg] = (unsigned long)p->addr + ilen;
+
+		regs->psw.addr = fix_offset((unsigned long)p->addr,
+					    (unsigned long)p->ainsn.insn,
+					    (unsigned long)regs->psw.addr);
+	}
+
+	/* set amode for 31bit */
+	regs->psw.addr |= PSW_ADDR_AMODE;
+	/* turn off PER mode */
+	regs->psw.mask &= ~PSW_MASK_PER;
+	/* Restore the original per control regs */
+	__ctl_load(kcb->kprobe_saved_ctl, 9, 11);
+	regs->psw.mask |= kcb->kprobe_saved_imask;
+}
+
+/* if this isn't getting any more complicated, turn into macro? */
+unsigned long __kprobes fix_offset(unsigned long orig_addr,
+			 unsigned long offset_start, unsigned long offset)
+{
+	return (orig_addr + (offset - offset_start));
+}
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
+	asm volatile (".long 0x00020000");
+}
+
+void __kprobes jprobe_return_end(void)
+{
+	asm volatile ("bcr 0,0");
+};
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
diff -urNp linux-2.6.17-rc6/arch/s390/kernel/Makefile linux-2.6.17-rc6-kp390/arch/s390/kernel/Makefile
--- linux-2.6.17-rc6/arch/s390/kernel/Makefile	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/kernel/Makefile	2006-06-12 05:13:05.000000000 -0400
@@ -21,6 +21,7 @@ obj-$(CONFIG_COMPAT)		+= compat_linux.o 
 obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 # Kexec part
 S390_KEXEC_OBJS := machine_kexec.o crash.o
diff -urNp linux-2.6.17-rc6/arch/s390/kernel/traps.c linux-2.6.17-rc6-kp390/arch/s390/kernel/traps.c
--- linux-2.6.17-rc6/arch/s390/kernel/traps.c	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/kernel/traps.c	2006-06-12 06:30:24.000000000 -0400
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
diff -urNp linux-2.6.17-rc6/arch/s390/kernel/vmlinux.lds.S linux-2.6.17-rc6-kp390/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6.17-rc6/arch/s390/kernel/vmlinux.lds.S	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/kernel/vmlinux.lds.S	2006-06-12 05:13:05.000000000 -0400
@@ -25,6 +25,7 @@ SECTIONS
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x0700
diff -urNp linux-2.6.17-rc6/arch/s390/mm/fault.c linux-2.6.17-rc6-kp390/arch/s390/mm/fault.c
--- linux-2.6.17-rc6/arch/s390/mm/fault.c	2006-06-05 20:57:02.000000000 -0400
+++ linux-2.6.17-rc6-kp390/arch/s390/mm/fault.c	2006-06-12 05:13:05.000000000 -0400
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
diff -urNp linux-2.6.17-rc6/include/asm-s390/kdebug.h linux-2.6.17-rc6-kp390/include/asm-s390/kdebug.h
--- linux-2.6.17-rc6/include/asm-s390/kdebug.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc6-kp390/include/asm-s390/kdebug.h	2006-06-12 06:27:25.000000000 -0400
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
diff -urNp linux-2.6.17-rc6/include/asm-s390/kprobes.h linux-2.6.17-rc6-kp390/include/asm-s390/kprobes.h
--- linux-2.6.17-rc6/include/asm-s390/kprobes.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc6-kp390/include/asm-s390/kprobes.h	2006-06-12 08:28:13.000000000 -0400
@@ -0,0 +1,208 @@
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
+ * Copyright (C) IBM Corporation, 2002, 2006
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
+#define FIXUP_NOBRANCH 0xFFFF0000
+
+/* These are the s390 opcodes that could be troublesome with probes */
+#define OPCODE_BASSM	0x0C
+#define OPCODE_BSM	0x0B
+#define OPCODE_DIAG	0x83
+#define OPCODE_EX	0x44
+#define OPCODE_PR	0x01
+/* These all have a first byte of 0xB2, second byte defined */
+#define OPCODE_BSA	0x5A
+#define OPCODE_BAKR	0x40
+#define OPCODE_BSG	0x58
+#define OPCODE_PC	0x18
+#define OPCODE_PT	0x28
+
+/* These are the various branch (jump) instructions available on the s390 in
+ * 32 and 64bit mode. Most of the instruction formats are pretty straight
+ * forward, but some have the opcode split in different places.
+ */
+/* RR Format
+*  ________ ____ ____
+* |Op Code | R1 | R2 |
+* |________|_M1_|____|
+* 0         8   12  15
+*/
+#define BALR 	0x05
+#define BASR 	0x0D
+#define BCR  	0x07
+#define BCTR 	0x06
+/* RX Format
+*  ________ ____ ____ ____ ____________
+* |Op Code | R1 | X2 | B2 |     D2     |
+* |________|_M1_|____|____|____________|
+* 0         8   12   16   20          31
+*/
+#define BAL  	0x45
+#define BAS  	0x4D
+#define BC   	0x47
+#define BCT  	0x46
+/* RI Format
+*  ________ ____ ____ _________________
+* |Op Code | R1 |OpCd|       I2        |
+* |________|____|____|_________________|
+* 0         8   12   16               31
+*/
+/* First byte is 0xA7 */
+#define BRC  	0x4
+#define BRAS 	0x5
+#define BRCT 	0x6
+#define BRCTG	0x7
+/* RIE Format
+*  ________ ____ ____ ____/_____ ________ ________
+* |Op Code | R1 | R3 |    I2    |////////|Op Code |
+* |________|____|____|____/_____|________|________|
+* 0         8   12   16         32       40      47
+*/
+/* First byte is 0xEC */
+#define BRXHG	0x44
+#define BRXLG	0x45
+/* RRE Format
+*  _________________ ________ ____ ____
+* |     Op Code     |////////| R1 | R2 |
+* |_________________|________|____|____|
+* 0                 16       24   28  31
+*/
+/* First byte is 0xB9 */
+#define BCTGR	0x46
+/* RS Format
+*  ________ ____ ____ ____ ____________
+* |Op Code | R1 | R3 | B2 |     D2     |
+* |________|____|_M3_|____|____________|
+* 0         8   12   16   20          31
+*/
+#define BXH  	0x86
+#define BXLE 	0x87
+/* RSI Format
+*  ________ ____ ____ _________________
+* |Op Code | R1 | R3 |       I2        |
+* |________|____|____|_________________|
+* 0         8   12   16               31
+*/
+#define BRXH 	0x84
+#define BRXLE	0x85
+/* RIL Format
+*  ________ ____ ____ _____________/______________
+* |Op Code | R1 |OpCd|            I2              |
+* |________|_M1_|____|_____________/______________|
+* 0         8   12   16                          47
+*/
+/* First byte is 0xC0 */
+#define BRASL	0x5
+#define BRCL 	0x4
+/* RSY Format
+*  ________ ____ ____ ____ __/__ ________ ________
+* |Op Code | R1 | R3 | B2 | DL2 |  DH2   |Op Code |
+* |________|____|_M3_|____|__/__|________|________|
+* 0         8   12   16   20    32       40      47
+*/
+/* First byte is 0xEB */
+#define BXHG 	0x44
+#define BXLEG	0x45
+/* RXY Format
+*  ________ ____ ____ ____ __/__ ________ ________
+* |Op Code | R1 | X2 | B2 | DL2 |  DH2   |Op Code |
+* |________|____|____|____|__/__|________|________|
+* 0         8   12   16   20    32       40      47
+*/
+/* First byte is 0xE3 */
+#define BCTG 	0x46
+
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
+
+#define ARCH_SUPPORTS_KRETPROBES
+
+void arch_remove_kprobe(struct kprobe *p);
+void kretprobe_trampoline(void);
+int  is_prohibited_opcode(kprobe_opcode_t *instruction);
+int  get_instruction_type(kprobe_opcode_t *instruction);
+unsigned long fix_offset( unsigned long orig_addr,
+			  unsigned long offset_start,
+			  unsigned long offset);
+
+/* Architecture specific copy of original instruction */
+struct arch_specific_insn {
+	/* copy of original instruction */
+	kprobe_opcode_t *insn;
+	int inst_type;
+};
+
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
+#endif	/* _ASM_S390_KPROBES_H */
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
