Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVCKEPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVCKEPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVCKEI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:08:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:59323 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263176AbVCKEC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:02:58 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 15:02:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6250.909404.121155@berry.gelato.unsw.EDU.AU>
Subject: Microstate accounting, IA64 support
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Microstate Accounting: 
Add suppoort for IA64.


 linux-2.6-ustate/arch/ia64/Kconfig           |   25 +++++++++++++++
 linux-2.6-ustate/arch/ia64/kernel/entry.S    |   44 +++++++++++++++++++++++++++
 linux-2.6-ustate/arch/ia64/kernel/irq_ia64.c |   21 +++++++++++-
 linux-2.6-ustate/arch/ia64/kernel/ivt.S      |    8 +++-
 linux-2.6-ustate/include/asm-ia64/msa.h      |   33 ++++++++++++++++++++
 linux-2.6-ustate/include/asm-ia64/unistd.h   |    1 
 7 files changed, 129 insertions(+), 5 deletions(-)

Index: linux-2.6-ustate/arch/ia64/Kconfig
===================================================================
--- linux-2.6-ustate.orig/arch/ia64/Kconfig	2005-03-10 09:13:01.780632777 +1100
+++ linux-2.6-ustate/arch/ia64/Kconfig	2005-03-10 09:16:14.593655619 +1100
@@ -302,6 +302,31 @@
 	  little bigger and slows down execution a bit, but it is generally
 	  a good idea to turn this on.  If you're unsure, say Y.
 
+config MICROSTATE
+	bool "Microstate accounting"
+	help
+	  This option causes the kernel to keep very accurate track of
+	  how long your threads spend on the runqueues, running, or asleep or
+	  stopped.  It will slow down your kernel.
+	  Times are reported in /proc/pid/msa and through a new msa()
+	  system call.
+choice
+	depends on MICROSTATE
+	prompt "Microstate timing source"
+	default MICROSTATE_ITC
+	help
+	   On IA64 one can use two timeing sources for the microstate
+	   accounting;  the on-chip interval counter, or Linux's
+	   time-of-day clock.  The first is very cheap; the other is
+	   more accurate on SMP systems.
+
+config MICROSTATE_ITC
+	bool "Use on-chip ITC for microstate timing"
+ 
+config MICROSTATE_TOD
+	bool "Use time-of-day clock for microstate timings"
+endchoice
+
 config IA64_PALINFO
 	tristate "/proc/pal support"
 	help
Index: linux-2.6-ustate/include/asm-ia64/msa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ustate/include/asm-ia64/msa.h	2005-03-10 09:16:14.594632174 +1100
@@ -0,0 +1,33 @@
+/************************************************************************
+ * asm-ia64/msa.h
+ *
+ * Provide an architecture-specific clock.
+ */
+
+#ifndef _ASM_IA64_MSA_H
+#define _ASM_IA64_MSA_H
+
+#include <asm/processor.h>
+#include <asm/timex.h>
+#include <asm/smp.h>
+
+
+# if defined(CONFIG_MICROSTATE_ITC)
+#   define MSA_NOW(now)  do { now = (clk_t)get_cycles(); } while (0)
+
+#   define MSA_TO_NSEC(clk) ((1000000000*clk) / cpu_data(smp_processor_id())->itc_freq)
+
+# elif defined(CONFIG_MICROSTATE_TOD)
+static inline void msa_now(clk_t *nsp) {
+	struct timeval tv;
+	do_gettimeofday(&tv);
+	*nsp = tv.tv_sec * 1000000 + tv.tv_usec;
+}
+#   define MSA_NOW(x) msa_now(&x)
+#   define MSA_TO_NSEC(clk) ((clk) * 1000)
+
+# else
+#  include <asm-generic/msa.h>
+# endif
+
+#endif /* _ASM_IA64_MSA_H */
Microstate Accounting: Track time in system calls for IA64

 arch/ia64/kernel/entry.S |   44 ++++++++++++++++++++++++++++++++++++++++++++
 arch/ia64/kernel/ivt.S   |    8 ++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

Index: linux-2.6-ustate/arch/ia64/kernel/entry.S
===================================================================
--- linux-2.6-ustate.orig/arch/ia64/kernel/entry.S	2005-03-10 09:13:01.149778160 +1100
+++ linux-2.6-ustate/arch/ia64/kernel/entry.S	2005-03-10 09:16:15.157128068 +1100
@@ -589,6 +589,46 @@
 .ret4:	br.cond.sptk ia64_leave_kernel
 END(ia64_strace_leave_kernel)
 
+#ifdef CONFIG_MICROSTATE
+/*
+ * preserve input registers,
+ * and r8
+ */
+GLOBAL_ENTRY(invoke_msa_end_syscall)
+	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
+	alloc loc1=ar.pfs,8,4,0,0
+	mov loc0=rp
+	.body
+	;;
+	mov loc2=ret0
+	mov loc3=ret2
+	br.call.sptk.many rp=msa_end_syscall
+1:	mov rp=loc0
+	mov ret0=loc2
+	mov ret2=loc3
+	mov ar.pfs=loc1
+	br.ret.sptk.many rp
+END(invoke_msa_end_syscall)
+/*
+ * Preserves in0-7, and all callee-save registers.
+ */
+GLOBAL_ENTRY(invoke_msa_start_syscall)
+	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
+	alloc loc1=ar.pfs,8,4,0,0
+	mov loc0=rp
+	.body
+	mov loc2=r3
+	mov loc3=r15
+	;;
+	br.call.sptk.many rp=msa_start_syscall
+1:	mov r15=loc3
+	mov r3=loc2
+	mov ar.pfs=loc1
+	mov rp=loc0
+	br.ret.sptk.many rp
+END(invoke_msa_start_syscall)
+#endif /* CONFIG_MICROSTATE */
+
 GLOBAL_ENTRY(ia64_ret_from_clone)
 	PT_REGS_UNWIND_INFO(0)
 {	/*
@@ -671,6 +711,10 @@
  */
 ENTRY(ia64_leave_syscall)
 	PT_REGS_UNWIND_INFO(0)
+#ifdef CONFIG_MICROSTATE
+	br.call.sptk.many rp=invoke_msa_end_syscall
+1:	
+#endif
 	/*
 	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
 	 * user- or fsys-mode, hence we disable interrupts early on.
Index: linux-2.6-ustate/arch/ia64/kernel/ivt.S
===================================================================
--- linux-2.6-ustate.orig/arch/ia64/kernel/ivt.S	2005-03-10 09:13:01.150754715 +1100
+++ linux-2.6-ustate/arch/ia64/kernel/ivt.S	2005-03-10 09:16:15.159081178 +1100
@@ -739,8 +739,12 @@
 	// p10==true means out registers are more than 8 or r15's Nat is true
 (p10)	br.cond.spnt.many ia64_ret_from_syscall
 	;;
-	movl r16=sys_call_table
-
+#ifdef CONFIG_MICROSTATE
+	// at this point, providing we preserve in0-7, r3, r15
+	// we're OK.
+	br.call.sptk.many rp=invoke_msa_start_syscall
+#endif  /* CONFIG_MICROSTATE */
+1:	movl r16=sys_call_table
 	adds r15=-1024,r15			// r15 contains the syscall number---subtract 1024
 	movl r2=ia64_ret_from_syscall
 	;;
Microstate accounting:  Hook in the msa system call for IA64.

 arch/ia64/kernel/entry.S  |    2 +-
 include/asm-ia64/unistd.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-ustate/include/asm-ia64/unistd.h
===================================================================
--- linux-2.6-ustate.orig/include/asm-ia64/unistd.h	2005-03-10 09:13:00.452517795 +1100
+++ linux-2.6-ustate/include/asm-ia64/unistd.h	2005-03-10 09:16:15.738178513 +1100
@@ -263,6 +263,7 @@
 #define __NR_add_key			1271
 #define __NR_request_key		1272
 #define __NR_keyctl			1273
+#define __NR_msa			1274
 
 #ifdef __KERNEL__
 
Index: linux-2.6-ustate/arch/ia64/kernel/entry.S
===================================================================
--- linux-2.6-ustate.orig/arch/ia64/kernel/entry.S	2005-03-10 09:16:15.157128068 +1100
+++ linux-2.6-ustate/arch/ia64/kernel/entry.S	2005-03-10 09:16:15.740131624 +1100
@@ -1621,7 +1621,7 @@
 	data8 sys_add_key
 	data8 sys_request_key
 	data8 sys_keyctl
-	data8 sys_ni_syscall
+	data8 sys_msa
 	data8 sys_ni_syscall			// 1275
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
Microstate accounting:  Account for time in Interrupt handlers, IA64 code.

 arch/ia64/kernel/irq_ia64.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-2.6-ustate/arch/ia64/kernel/irq_ia64.c
===================================================================
--- linux-2.6-ustate.orig/arch/ia64/kernel/irq_ia64.c	2005-03-10 09:12:59.798225857 +1100
+++ linux-2.6-ustate/arch/ia64/kernel/irq_ia64.c	2005-03-10 09:16:16.304580629 +1100
@@ -104,7 +104,7 @@
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
 	unsigned long saved_tpr;
-
+	ia64_vector oldvector;
 #if IRQ_DEBUG
 	{
 		unsigned long bsp, sp;
@@ -143,6 +143,9 @@
 	irq_enter();
 	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
 	ia64_srlz_d();
+
+	msa_start_irq(local_vector_to_irq(vector));
+
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
 			ia64_setreg(_IA64_REG_CR_TPR, vector);
@@ -157,14 +160,28 @@
 			ia64_setreg(_IA64_REG_CR_TPR, saved_tpr);
 		}
 		ia64_eoi();
-		vector = ia64_get_ivr();
+		oldvector = vector;
+		vector = ia64_get_ivr();		
+		msa_continue_irq(local_vector_to_irq(oldvector),
+				 local_vector_to_irq(vector));
 	}
+
+
 	/*
 	 * This must be done *after* the ia64_eoi().  For example, the keyboard softirq
 	 * handler needs to be able to wait for further keyboard interrupts, which can't
 	 * come through until ia64_eoi() has been done.
 	 */
 	irq_exit();
+
+	/*
+	 * This should really be done after the irq_exit, but if new 
+	 * interrupts come in while running the softIRQs, the
+	 * microstate accounting system loses track of what
+	 * state it's meant to return to.
+	 */
+	msa_finish_irq(local_vector_to_irq(vector));
+
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
