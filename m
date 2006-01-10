Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWAJSKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWAJSKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJSKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:10:49 -0500
Received: from fmr24.intel.com ([143.183.121.16]:3047 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932451AbWAJSKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:10:48 -0500
Date: Tue, 10 Jan 2006 10:10:32 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       anil.s.keshavamurthy@intel.com, Jim Keniston <jkenisto@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Systemtap <systemtap@sources.redhat.com>
Subject: [PATCH]Kprobes-Race in recovery of reentrant probe
Message-ID: <20060110101032.A11768@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Kprobes - Race in recovery of reentrant probes

There is window where a probe gets removed right after the
probe is hit on some different cpu. In this case probe handlers
can't find a matching probe instance related to break address.
In this case we need to read the original instruction at break
address to see if that is not a break/int3 instruction 
and recover safely.

Previous code had a bug where we were not checking for the above
race in case of reentrant probes and the below patch fixes this
race.

The below patch has been tested on IA64, Powerpc, x86_64.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-----------------------------------------------------------------
 arch/i386/kernel/kprobes.c    |   13 +++++++++++++
 arch/ia64/kernel/kprobes.c    |    7 +++++++
 arch/powerpc/kernel/kprobes.c |   12 ++++++++++++
 arch/sparc64/kernel/kprobes.c |    8 ++++++++
 arch/x86_64/kernel/kprobes.c  |    9 +++++++++
 5 files changed, 49 insertions(+)

Index: linux-2.6.15-mm1/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.15-mm1/arch/i386/kernel/kprobes.c
@@ -188,6 +188,19 @@ static int __kprobes kprobe_handler(stru
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
 		} else {
+			if (regs->eflags & VM_MASK) {
+			/* We are in virtual-8086 mode. Return 0 */
+				goto no_kprobe;
+			}
+			if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+				regs->eip -= sizeof(kprobe_opcode_t);
+				ret = 1;
+				goto no_kprobe;
+			}
 			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
Index: linux-2.6.15-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.15-mm1/arch/ia64/kernel/kprobes.c
@@ -638,6 +638,13 @@ static int __kprobes pre_kprobes_handler
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
 			}
+		} else if (!is_ia64_break_inst(regs)) {
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
+			goto no_kprobe;
 		} else {
 			/* Not our break */
 			goto no_kprobe;
Index: linux-2.6.15-mm1/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.15-mm1/arch/powerpc/kernel/kprobes.c
@@ -179,6 +179,18 @@ static inline int kprobe_handler(struct 
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
 		} else {
+			if (*addr != BREAKPOINT_INSTRUCTION) {
+				/* If trap variant, then it belongs not to us */
+				kprobe_opcode_t cur_insn = *addr;
+				if (is_trap(cur_insn))
+		       			goto no_kprobe;
+				/* The breakpoint instruction was removed by
+				 * another cpu right after we hit, no further
+				 * handling of this interrupt is appropriate
+				 */
+				ret = 1;
+				goto no_kprobe;
+			}
 			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
Index: linux-2.6.15-mm1/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/arch/sparc64/kernel/kprobes.c
+++ linux-2.6.15-mm1/arch/sparc64/kernel/kprobes.c
@@ -135,6 +135,14 @@ static int __kprobes kprobe_handler(stru
 			prepare_singlestep(p, regs, kcb);
 			return 1;
 		} else {
+			if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+				ret = 1;
+				goto no_kprobe;
+			}
 			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs))
 				goto ss_probe;
Index: linux-2.6.15-mm1/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-mm1.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.15-mm1/arch/x86_64/kernel/kprobes.c
@@ -334,6 +334,15 @@ int __kprobes kprobe_handler(struct pt_r
 				return 1;
 			}
 		} else {
+			if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+				regs->rip = (unsigned long)addr;
+				ret = 1;
+				goto no_kprobe;
+			}
 			p = __get_cpu_var(current_kprobe);
 			if (p->break_handler && p->break_handler(p, regs)) {
 				goto ss_probe;
