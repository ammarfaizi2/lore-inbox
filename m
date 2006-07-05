Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWGERz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWGERz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWGERz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:55:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51094 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964939AbWGERzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:55:10 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch [try #2]
Date: Wed, 05 Jul 2006 18:54:52 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060705175452.12594.10993.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060705175440.12594.43069.stgit@warthog.cambridge.redhat.com>
References: <20060705175440.12594.43069.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Introduce the use of asm-offsets into the FRV architecture.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/asm-offsets.c |  116 ++++++++++++++++++++++++++++++
 arch/frv/kernel/break.S       |   34 +++++----
 arch/frv/kernel/debug-stub.c  |   13 ++-
 arch/frv/kernel/entry.S       |    1 
 arch/frv/kernel/gdb-stub.c    |  159 +++++++++++++++++++++++------------------
 arch/frv/kernel/head.S        |    1 
 arch/frv/kernel/process.c     |    3 +
 arch/frv/kernel/switch_to.S   |    3 +
 arch/frv/kernel/traps.c       |   25 +++---
 include/asm-frv/gdb-stub.h    |   22 ++++++
 include/asm-frv/ptrace.h      |   12 +--
 include/asm-frv/registers.h   |   97 ++++++++++---------------
 include/asm-frv/thread_info.h |   24 +-----
 13 files changed, 313 insertions(+), 197 deletions(-)

diff --git a/arch/frv/kernel/asm-offsets.c b/arch/frv/kernel/asm-offsets.c
index 9e26311..fbb19fc 100644
--- a/arch/frv/kernel/asm-offsets.c
+++ b/arch/frv/kernel/asm-offsets.c
@@ -1 +1,115 @@
-/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/personality.h>
+#include <asm/registers.h>
+#include <asm/ucontext.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+#include <asm/gdb-stub.h>
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define DEF_PTREG(sym, reg) \
+        asm volatile("\n->" #sym " %0 offsetof(struct pt_regs, " #reg ")" \
+		     : : "i" (offsetof(struct pt_regs, reg)))
+
+#define DEF_IREG(sym, reg) \
+        asm volatile("\n->" #sym " %0 offsetof(struct user_context, " #reg ")" \
+		     : : "i" (offsetof(struct user_context, reg)))
+
+#define DEF_FREG(sym, reg) \
+        asm volatile("\n->" #sym " %0 offsetof(struct user_context, " #reg ")" \
+		     : : "i" (offsetof(struct user_context, reg)))
+
+#define DEF_0REG(sym, reg) \
+        asm volatile("\n->" #sym " %0 offsetof(struct frv_frame0, " #reg ")" \
+		     : : "i" (offsetof(struct frv_frame0, reg)))
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+	/* offsets into the thread_info structure */
+	OFFSET(TI_TASK,			thread_info, task);
+	OFFSET(TI_EXEC_DOMAIN,		thread_info, exec_domain);
+	OFFSET(TI_FLAGS,		thread_info, flags);
+	OFFSET(TI_STATUS,		thread_info, status);
+	OFFSET(TI_CPU,			thread_info, cpu);
+	OFFSET(TI_PREEMPT_COUNT,	thread_info, preempt_count);
+	OFFSET(TI_ADDR_LIMIT,		thread_info, addr_limit);
+	OFFSET(TI_RESTART_BLOCK,	thread_info, restart_block);
+	BLANK();
+
+	/* offsets into register file storage */
+	DEF_PTREG(REG_PSR,		psr);
+	DEF_PTREG(REG_ISR,		isr);
+	DEF_PTREG(REG_CCR,		ccr);
+	DEF_PTREG(REG_CCCR,		cccr);
+	DEF_PTREG(REG_LR,		lr);
+	DEF_PTREG(REG_LCR,		lcr);
+	DEF_PTREG(REG_PC,		pc);
+	DEF_PTREG(REG__STATUS,		__status);
+	DEF_PTREG(REG_SYSCALLNO,	syscallno);
+	DEF_PTREG(REG_ORIG_GR8,		orig_gr8);
+	DEF_PTREG(REG_GNER0,		gner0);
+	DEF_PTREG(REG_GNER1,		gner1);
+	DEF_PTREG(REG_IACC0,		iacc0);
+	DEF_PTREG(REG_TBR,		tbr);
+	DEF_PTREG(REG_GR0,		tbr);
+	DEFINE(REG__END,		sizeof(struct pt_regs));
+	BLANK();
+
+	DEF_0REG(REG_DCR,		debug.dcr);
+	DEF_0REG(REG_IBAR0,		debug.ibar[0]);
+	DEF_0REG(REG_DBAR0,		debug.dbar[0]);
+	DEF_0REG(REG_DBDR00,		debug.dbdr[0][0]);
+	DEF_0REG(REG_DBMR00,		debug.dbmr[0][0]);
+	BLANK();
+
+	DEF_IREG(__INT_GR0,		i.gr[0]);
+	DEF_FREG(__USER_FPMEDIA,	f);
+	DEF_FREG(__FPMEDIA_FR0,		f.fr[0]);
+	DEF_FREG(__FPMEDIA_FNER0,	f.fner[0]);
+	DEF_FREG(__FPMEDIA_MSR0,	f.msr[0]);
+	DEF_FREG(__FPMEDIA_ACC0,	f.acc[0]);
+	DEF_FREG(__FPMEDIA_ACCG0,	f.accg[0]);
+	DEF_FREG(__FPMEDIA_FSR0,	f.fsr[0]);
+	BLANK();
+
+	DEFINE(NR_PT_REGS,		sizeof(struct pt_regs) / 4);
+	DEFINE(NR_USER_INT_REGS,	sizeof(struct user_int_regs) / 4);
+	DEFINE(NR_USER_FPMEDIA_REGS,	sizeof(struct user_fpmedia_regs) / 4);
+	DEFINE(NR_USER_CONTEXT,		sizeof(struct user_context) / 4);
+	DEFINE(FRV_FRAME0_SIZE,		sizeof(struct frv_frame0));
+	BLANK();
+
+	/* offsets into thread_struct */
+	OFFSET(__THREAD_FRAME,		thread_struct, frame);
+	OFFSET(__THREAD_CURR,		thread_struct, curr);
+	OFFSET(__THREAD_SP,		thread_struct, sp);
+	OFFSET(__THREAD_FP,		thread_struct, fp);
+	OFFSET(__THREAD_LR,		thread_struct, lr);
+	OFFSET(__THREAD_PC,		thread_struct, pc);
+	OFFSET(__THREAD_GR16,		thread_struct, gr[0]);
+	OFFSET(__THREAD_SCHED_LR,	thread_struct, sched_lr);
+	OFFSET(__THREAD_FRAME0,		thread_struct, frame0);
+	OFFSET(__THREAD_USER,		thread_struct, user);
+	BLANK();
+
+	/* offsets into frv_debug_status */
+	OFFSET(DEBUG_BPSR,		frv_debug_status, bpsr);
+	OFFSET(DEBUG_DCR,		frv_debug_status, dcr);
+	OFFSET(DEBUG_BRR,		frv_debug_status, brr);
+	OFFSET(DEBUG_NMAR,		frv_debug_status, nmar);
+	BLANK();
+}
diff --git a/arch/frv/kernel/break.S b/arch/frv/kernel/break.S
index ea161f0..dac4a5f 100644
--- a/arch/frv/kernel/break.S
+++ b/arch/frv/kernel/break.S
@@ -9,11 +9,11 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/sys.h>
 #include <linux/linkage.h>
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/ptrace.h>
+#include <asm/thread_info.h>
 #include <asm/spr-regs.h>
 
 #include <asm/errno.h>
@@ -23,13 +23,11 @@ # the break handler has its own stack
 #
 	.section	.bss.stack
 	.globl		__break_user_context
-	.balign		8192
+	.balign		THREAD_SIZE
 __break_stack:
-	.space		(8192 - (USER_CONTEXT_SIZE + REG__DEBUG_XTRA)) & ~7
-__break_stack_tos:
-	.space		REG__DEBUG_XTRA
-__break_user_context:
-	.space		USER_CONTEXT_SIZE
+	.space		THREAD_SIZE - FRV_FRAME0_SIZE
+__break_frame_0:
+	.space		FRV_FRAME0_SIZE
 
 #
 # miscellaneous variables
@@ -74,8 +72,8 @@ #ifdef CONFIG_MMU
 #endif
 	LEDS		0x1001,gr31
 
-	sethi.p		%hi(__break_user_context),gr31
-	setlo		%lo(__break_user_context),gr31
+	sethi.p		%hi(__break_frame_0),gr31
+	setlo		%lo(__break_frame_0),gr31
 
 	stdi		gr2,@(gr31,#REG_GR(2))
 	movsg		ccr,gr3
@@ -585,8 +583,8 @@ __break_continue:
 	# set up the kernel stack pointer
 	sti		sp,@(gr31,#REG_SP)
 
-	sethi.p		%hi(__break_stack_tos),sp
-	setlo		%lo(__break_stack_tos),sp
+	sethi.p		%hi(__break_frame_0),sp
+	setlo		%lo(__break_frame_0),sp
 
 	# finish building the exception frame
 	stdi		gr4 ,@(gr31,#REG_GR(4))
@@ -651,9 +649,12 @@ #endif
 	movsg		nmar,gr5
 	movsg		dcr,gr6
 
-	stdi		gr4 ,@(gr31,#REG_BRR)
-	sti		gr19,@(gr31,#REG_BPSR)
-	sti.p		gr6 ,@(gr31,#REG_DCR)
+	sethi.p		%hi(__debug_status),gr7
+	setlo		%lo(__debug_status),gr7
+
+	stdi		gr4 ,@(gr7,#DEBUG_BRR)
+	sti		gr19,@(gr7,#DEBUG_BPSR)
+	sti.p		gr6 ,@(gr7,#DEBUG_DCR)
 
 	# trap exceptions during break handling and disable h/w breakpoints/watchpoints
 	sethi		%hi(DCR_EBE),gr5
@@ -698,7 +699,10 @@ #endif
 	lddi		@(gr31,#REG_PSR) ,gr22
 	ldi		@(gr31,#REG_PC)  ,gr21
 	ldi		@(gr31,#REG_TBR) ,gr20
-	ldi.p		@(gr31,#REG_DCR) ,gr6
+
+	sethi.p		%hi(__debug_status),gr6
+	setlo		%lo(__debug_status),gr6
+	ldi.p		@(gr6,#DEBUG_DCR) ,gr6
 
 	andi		gr22,#PSR_S,gr19		/* rebuild BPSR */
 	andi.p		gr22,#PSR_ET,gr5
diff --git a/arch/frv/kernel/debug-stub.c b/arch/frv/kernel/debug-stub.c
index 4761cc4..2f6c60c 100644
--- a/arch/frv/kernel/debug-stub.c
+++ b/arch/frv/kernel/debug-stub.c
@@ -39,10 +39,9 @@ do {						\
 	gdbstub_do_rx();			\
 } while(!FLOWCTL_QUERY(LINE))
 
-static void __init debug_stub_init(void);
+struct frv_debug_status __debug_status;
 
-extern asmlinkage void __break_hijack_kernel_event(void);
-extern asmlinkage void __break_hijack_kernel_event_breaks_here(void);
+static void __init debug_stub_init(void);
 
 /*****************************************************************************/
 /*
@@ -67,7 +66,7 @@ asmlinkage void debug_stub(void)
 		__set_HSR(0, hsr0 & ~HSR0_ETMD);
 
 	/* disable single stepping */
-	__debug_regs->dcr &= ~DCR_SE;
+	__debug_status.dcr &= ~DCR_SE;
 
 	/* kernel mode can propose an exception be handled in debug mode by jumping to a special
 	 * location */
@@ -76,8 +75,8 @@ asmlinkage void debug_stub(void)
 		 * the top kernel context */
 		*__debug_frame = *__frame;
 		__frame = __debug_frame->next_frame;
-		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
-		__debug_regs->brr |= BRR_EB;
+		__debug_status.brr = (__debug_frame->tbr & TBR_TT) << 12;
+		__debug_status.brr |= BRR_EB;
 	}
 
 	if (__debug_frame->pc == (unsigned long) __debug_bug_trap + 4) {
@@ -124,7 +123,7 @@ static void __init debug_stub_init(void)
 		__debug_frame->pc = (unsigned long) start_kernel;
 
 	/* enable the debug events we want to trap */
-	__debug_regs->dcr = DCR_EBE;
+	__debug_status.dcr = DCR_EBE;
 
 #ifdef CONFIG_GDBSTUB
 	gdbstub_init();
diff --git a/arch/frv/kernel/entry.S b/arch/frv/kernel/entry.S
index 2a1ff1f..940ac30 100644
--- a/arch/frv/kernel/entry.S
+++ b/arch/frv/kernel/entry.S
@@ -27,7 +27,6 @@
  *
  */
 
-#include <linux/sys.h>
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/setup.h>
diff --git a/arch/frv/kernel/gdb-stub.c b/arch/frv/kernel/gdb-stub.c
index 508601f..9550f37 100644
--- a/arch/frv/kernel/gdb-stub.c
+++ b/arch/frv/kernel/gdb-stub.c
@@ -124,6 +124,7 @@ #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/nmi.h>
 
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/gdb-stub.h>
@@ -136,7 +137,6 @@ extern void debug_to_serial(const char *
 extern void gdbstub_console_write(struct console *co, const char *p, unsigned n);
 
 extern volatile uint32_t __break_error_detect[3]; /* ESFR1, ESR15, EAR15 */
-extern struct user_context __break_user_context;
 
 struct __debug_amr {
 	unsigned long L, P;
@@ -926,6 +926,7 @@ #endif
 		if (!(__debug_regs->dcr & DCR_IBE0)) {
 			//gdbstub_printk("set h/w break 0: %08lx\n", addr);
 			__debug_regs->dcr |= DCR_IBE0;
+			__debug_regs->ibar[0] = addr;
 			asm volatile("movgs %0,ibar0" : : "r"(addr));
 			return 0;
 		}
@@ -933,6 +934,7 @@ #endif
 		if (!(__debug_regs->dcr & DCR_IBE1)) {
 			//gdbstub_printk("set h/w break 1: %08lx\n", addr);
 			__debug_regs->dcr |= DCR_IBE1;
+			__debug_regs->ibar[1] = addr;
 			asm volatile("movgs %0,ibar1" : : "r"(addr));
 			return 0;
 		}
@@ -940,6 +942,7 @@ #endif
 		if (!(__debug_regs->dcr & DCR_IBE2)) {
 			//gdbstub_printk("set h/w break 2: %08lx\n", addr);
 			__debug_regs->dcr |= DCR_IBE2;
+			__debug_regs->ibar[2] = addr;
 			asm volatile("movgs %0,ibar2" : : "r"(addr));
 			return 0;
 		}
@@ -947,6 +950,7 @@ #endif
 		if (!(__debug_regs->dcr & DCR_IBE3)) {
 			//gdbstub_printk("set h/w break 3: %08lx\n", addr);
 			__debug_regs->dcr |= DCR_IBE3;
+			__debug_regs->ibar[3] = addr;
 			asm volatile("movgs %0,ibar3" : : "r"(addr));
 			return 0;
 		}
@@ -971,7 +975,14 @@ #endif
 		if (!(__debug_regs->dcr & (DCR_DRBE0|DCR_DWBE0))) {
 			//gdbstub_printk("set h/w watchpoint 0 type %ld: %08lx\n", type, addr);
 			tmp = type==2 ? DCR_DWBE0 : type==3 ? DCR_DRBE0 : DCR_DRBE0|DCR_DWBE0;
+
 			__debug_regs->dcr |= tmp;
+			__debug_regs->dbar[0] = addr;
+			__debug_regs->dbmr[0][0] = dbmr.mask0;
+			__debug_regs->dbmr[0][1] = dbmr.mask1;
+			__debug_regs->dbdr[0][0] = 0;
+			__debug_regs->dbdr[0][1] = 0;
+
 			asm volatile("	movgs	%0,dbar0	\n"
 				     "	movgs	%1,dbmr00	\n"
 				     "	movgs	%2,dbmr01	\n"
@@ -984,7 +995,14 @@ #endif
 		if (!(__debug_regs->dcr & (DCR_DRBE1|DCR_DWBE1))) {
 			//gdbstub_printk("set h/w watchpoint 1 type %ld: %08lx\n", type, addr);
 			tmp = type==2 ? DCR_DWBE1 : type==3 ? DCR_DRBE1 : DCR_DRBE1|DCR_DWBE1;
+
 			__debug_regs->dcr |= tmp;
+			__debug_regs->dbar[1] = addr;
+			__debug_regs->dbmr[1][0] = dbmr.mask0;
+			__debug_regs->dbmr[1][1] = dbmr.mask1;
+			__debug_regs->dbdr[1][0] = 0;
+			__debug_regs->dbdr[1][1] = 0;
+
 			asm volatile("	movgs	%0,dbar1	\n"
 				     "	movgs	%1,dbmr10	\n"
 				     "	movgs	%2,dbmr11	\n"
@@ -1047,6 +1065,7 @@ #define __get_ibar(X) ({ unsigned long x
 		if (__debug_regs->dcr & DCR_IBE0 && __get_ibar(0) == addr) {
 			//gdbstub_printk("clear h/w break 0: %08lx\n", addr);
 			__debug_regs->dcr &= ~DCR_IBE0;
+			__debug_regs->ibar[0] = 0;
 			asm volatile("movgs gr0,ibar0");
 			return 0;
 		}
@@ -1054,6 +1073,7 @@ #define __get_ibar(X) ({ unsigned long x
 		if (__debug_regs->dcr & DCR_IBE1 && __get_ibar(1) == addr) {
 			//gdbstub_printk("clear h/w break 1: %08lx\n", addr);
 			__debug_regs->dcr &= ~DCR_IBE1;
+			__debug_regs->ibar[1] = 0;
 			asm volatile("movgs gr0,ibar1");
 			return 0;
 		}
@@ -1061,6 +1081,7 @@ #define __get_ibar(X) ({ unsigned long x
 		if (__debug_regs->dcr & DCR_IBE2 && __get_ibar(2) == addr) {
 			//gdbstub_printk("clear h/w break 2: %08lx\n", addr);
 			__debug_regs->dcr &= ~DCR_IBE2;
+			__debug_regs->ibar[2] = 0;
 			asm volatile("movgs gr0,ibar2");
 			return 0;
 		}
@@ -1068,6 +1089,7 @@ #define __get_ibar(X) ({ unsigned long x
 		if (__debug_regs->dcr & DCR_IBE3 && __get_ibar(3) == addr) {
 			//gdbstub_printk("clear h/w break 3: %08lx\n", addr);
 			__debug_regs->dcr &= ~DCR_IBE3;
+			__debug_regs->ibar[3] = 0;
 			asm volatile("movgs gr0,ibar3");
 			return 0;
 		}
@@ -1104,6 +1126,12 @@ #define __get_dbmr1(X) ({ unsigned long 
 
 		//gdbstub_printk("clear h/w watchpoint 0 type %ld: %08lx\n", type, addr);
 		__debug_regs->dcr &= ~(DCR_DRBE0|DCR_DWBE0);
+		__debug_regs->dbar[0] = 0;
+		__debug_regs->dbmr[0][0] = 0;
+		__debug_regs->dbmr[0][1] = 0;
+		__debug_regs->dbdr[0][0] = 0;
+		__debug_regs->dbdr[0][1] = 0;
+
 		asm volatile("	movgs	gr0,dbar0	\n"
 			     "	movgs	gr0,dbmr00	\n"
 			     "	movgs	gr0,dbmr01	\n"
@@ -1123,6 +1151,12 @@ #define __get_dbmr1(X) ({ unsigned long 
 
 		//gdbstub_printk("clear h/w watchpoint 1 type %ld: %08lx\n", type, addr);
 		__debug_regs->dcr &= ~(DCR_DRBE1|DCR_DWBE1);
+		__debug_regs->dbar[1] = 0;
+		__debug_regs->dbmr[1][0] = 0;
+		__debug_regs->dbmr[1][1] = 0;
+		__debug_regs->dbdr[1][0] = 0;
+		__debug_regs->dbdr[1][1] = 0;
+
 		asm volatile("	movgs	gr0,dbar1	\n"
 			     "	movgs	gr0,dbmr10	\n"
 			     "	movgs	gr0,dbmr11	\n"
@@ -1163,7 +1197,7 @@ static void gdbstub_check_breakpoint(voi
  */
 static void __attribute__((unused)) gdbstub_show_regs(void)
 {
-	uint32_t *reg;
+	unsigned long *reg;
 	int loop;
 
 	gdbstub_printk("\n");
@@ -1172,11 +1206,11 @@ static void __attribute__((unused)) gdbs
 		       __debug_frame,
 		       __debug_frame->psr & PSR_S ? "kernel" : "user");
 
-	reg = (uint32_t *) __debug_frame;
-	for (loop = 0; loop < REG__END; loop++) {
-		printk("%s %08x", regnames[loop + 0], reg[loop + 0]);
+	reg = (unsigned long *) __debug_frame;
+	for (loop = 0; loop < NR_PT_REGS; loop++) {
+		printk("%s %08lx", regnames[loop + 0], reg[loop + 0]);
 
-		if (loop == REG__END - 1 || loop % 5 == 4)
+		if (loop == NR_PT_REGS - 1 || loop % 5 == 4)
 			printk("\n");
 		else
 			printk(" | ");
@@ -1191,13 +1225,8 @@ static void __attribute__((unused)) gdbs
  */
 static void __attribute__((unused)) gdbstub_dump_debugregs(void)
 {
-	unsigned long x;
-
-	x = __debug_regs->dcr;
-	gdbstub_printk("DCR    %08lx  ", x);
-
-	x = __debug_regs->brr;
-	gdbstub_printk("BRR %08lx\n", x);
+	gdbstub_printk("DCR    %08lx  ", __debug_status.dcr);
+	gdbstub_printk("BRR    %08lx\n", __debug_status.brr);
 
 	gdbstub_printk("IBAR0  %08lx  ", __get_ibar(0));
 	gdbstub_printk("IBAR1  %08lx  ", __get_ibar(1));
@@ -1360,7 +1389,7 @@ #else
 #endif
 	}
 
-	save_user_regs(&__break_user_context);
+	save_user_regs(&__debug_frame0->uc);
 
 #if 0
 	gdbstub_printk("--> gdbstub() %08x %p %08x %08x\n",
@@ -1389,8 +1418,8 @@ #endif
 		__debug_frame->psr &= ~PSR_S;
 		if (__debug_frame->psr & PSR_PS)
 			__debug_frame->psr |= PSR_S;
-		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
-		__debug_regs->brr |= BRR_EB;
+		__debug_status.brr = (__debug_frame->tbr & TBR_TT) << 12;
+		__debug_status.brr |= BRR_EB;
 		sigval = SIGINT;
 	}
 
@@ -1404,15 +1433,15 @@ #endif
 		__debug_frame->psr &= ~PSR_S;
 		if (__debug_frame->psr & PSR_PS)
 			__debug_frame->psr |= PSR_S;
-		__debug_regs->brr = (__debug_frame->tbr & TBR_TT) << 12;
-		__debug_regs->brr |= BRR_EB;
+		__debug_status.brr = (__debug_frame->tbr & TBR_TT) << 12;
+		__debug_status.brr |= BRR_EB;
 		sigval = SIGXCPU;
 	}
 
 	LEDS(0x5002);
 
 	/* after a BREAK insn, the PC lands on the far side of it */
-	if (__debug_regs->brr & BRR_SB)
+	if (__debug_status.brr & BRR_SB)
 		gdbstub_check_breakpoint();
 
 	LEDS(0x5003);
@@ -1431,7 +1460,7 @@ #endif
 	}
 
 	if (!sigval)
-		sigval = gdbstub_compute_signal(__debug_regs->brr);
+		sigval = gdbstub_compute_signal(__debug_status.brr);
 
 	LEDS(0x5004);
 
@@ -1441,7 +1470,7 @@ #endif
 	if (sigval != SIGINT && sigval != SIGTRAP && sigval != SIGILL) {
 		static const char title[] = "Break ";
 		static const char crlf[] = "\r\n";
-		unsigned long brr = __debug_regs->brr;
+		unsigned long brr = __debug_status.brr;
 		char hx;
 
 		ptr = output_buffer;
@@ -1565,28 +1594,24 @@ #endif
 			ptr = mem2hex(&zero, ptr, 4, 0);
 
 			for (loop = 1; loop <= 27; loop++)
-				ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(loop),
-					      ptr, 4, 0);
+				ptr = mem2hex(&__debug_user_context->i.gr[loop], ptr, 4, 0);
 			temp = (unsigned long) __frame;
 			ptr = mem2hex(&temp, ptr, 4, 0);
-			ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(29), ptr, 4, 0);
-			ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(30), ptr, 4, 0);
+			ptr = mem2hex(&__debug_user_context->i.gr[29], ptr, 4, 0);
+			ptr = mem2hex(&__debug_user_context->i.gr[30], ptr, 4, 0);
 #ifdef CONFIG_MMU
-			ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(31), ptr, 4, 0);
+			ptr = mem2hex(&__debug_user_context->i.gr[31], ptr, 4, 0);
 #else
 			temp = (unsigned long) __debug_frame;
 			ptr = mem2hex(&temp, ptr, 4, 0);
 #endif
 
 			for (loop = 32; loop <= 63; loop++)
-				ptr = mem2hex((unsigned long *)__debug_frame + REG_GR(loop),
-					      ptr, 4, 0);
+				ptr = mem2hex(&__debug_user_context->i.gr[loop], ptr, 4, 0);
 
 			/* deal with FR0-FR63 */
 			for (loop = 0; loop <= 63; loop++)
-				ptr = mem2hex((unsigned long *)&__break_user_context +
-					      __FPMEDIA_FR(loop),
-					      ptr, 4, 0);
+				ptr = mem2hex(&__debug_user_context->f.fr[loop], ptr, 4, 0);
 
 			/* deal with special registers */
 			ptr = mem2hex(&__debug_frame->pc,    ptr, 4, 0);
@@ -1597,7 +1622,7 @@ #endif
 			ptr = mem2hex(&zero, ptr, 4, 0);
 			ptr = mem2hex(&zero, ptr, 4, 0);
 			ptr = mem2hex(&__debug_frame->tbr,   ptr, 4, 0);
-			ptr = mem2hex(&__debug_regs->brr ,   ptr, 4, 0);
+			ptr = mem2hex(&__debug_status.brr ,   ptr, 4, 0);
 
 			asm volatile("movsg dbar0,%0" : "=r"(dbar));
 			ptr = mem2hex(&dbar, ptr, 4, 0);
@@ -1622,21 +1647,21 @@ #endif
 
 			ptr = mem2hex(&__debug_frame->iacc0, ptr, 8, 0);
 
-			ptr = mem2hex(&__break_user_context.f.fsr[0], ptr, 4, 0);
+			ptr = mem2hex(&__debug_user_context->f.fsr[0], ptr, 4, 0);
 
 			for (loop = 0; loop <= 7; loop++)
-				ptr = mem2hex(&__break_user_context.f.acc[loop], ptr, 4, 0);
+				ptr = mem2hex(&__debug_user_context->f.acc[loop], ptr, 4, 0);
 
-			ptr = mem2hex(&__break_user_context.f.accg, ptr, 8, 0);
+			ptr = mem2hex(&__debug_user_context->f.accg, ptr, 8, 0);
 
 			for (loop = 0; loop <= 1; loop++)
-				ptr = mem2hex(&__break_user_context.f.msr[loop], ptr, 4, 0);
+				ptr = mem2hex(&__debug_user_context->f.msr[loop], ptr, 4, 0);
 
 			ptr = mem2hex(&__debug_frame->gner0, ptr, 4, 0);
 			ptr = mem2hex(&__debug_frame->gner1, ptr, 4, 0);
 
-			ptr = mem2hex(&__break_user_context.f.fner[0], ptr, 4, 0);
-			ptr = mem2hex(&__break_user_context.f.fner[1], ptr, 4, 0);
+			ptr = mem2hex(&__debug_user_context->f.fner[0], ptr, 4, 0);
+			ptr = mem2hex(&__debug_user_context->f.fner[1], ptr, 4, 0);
 
 			break;
 
@@ -1648,8 +1673,7 @@ #endif
 			ptr = hex2mem(ptr, &temp, 4);
 
 			for (loop = 1; loop <= 27; loop++)
-				ptr = hex2mem(ptr, (unsigned long *)__debug_frame + REG_GR(loop),
-					      4);
+				ptr = hex2mem(ptr, &__debug_user_context->i.gr[loop], 4);
 
 			ptr = hex2mem(ptr, &temp, 4);
 			__frame = (struct pt_regs *) temp;
@@ -1662,14 +1686,11 @@ #else
 #endif
 
 			for (loop = 32; loop <= 63; loop++)
-				ptr = hex2mem(ptr, (unsigned long *)__debug_frame + REG_GR(loop),
-					      4);
+				ptr = hex2mem(ptr, &__debug_user_context->i.gr[loop], 4);
 
 			/* deal with FR0-FR63 */
 			for (loop = 0; loop <= 63; loop++)
-				ptr = mem2hex((unsigned long *)&__break_user_context +
-					      __FPMEDIA_FR(loop),
-					      ptr, 4, 0);
+				ptr = mem2hex(&__debug_user_context->f.fr[loop], ptr, 4, 0);
 
 			/* deal with special registers */
 			ptr = hex2mem(ptr, &__debug_frame->pc,  4);
@@ -1694,21 +1715,21 @@ #endif
 
 			ptr = hex2mem(ptr, &__debug_frame->iacc0, 8);
 
-			ptr = hex2mem(ptr, &__break_user_context.f.fsr[0], 4);
+			ptr = hex2mem(ptr, &__debug_user_context->f.fsr[0], 4);
 
 			for (loop = 0; loop <= 7; loop++)
-				ptr = hex2mem(ptr, &__break_user_context.f.acc[loop], 4);
+				ptr = hex2mem(ptr, &__debug_user_context->f.acc[loop], 4);
 
-			ptr = hex2mem(ptr, &__break_user_context.f.accg, 8);
+			ptr = hex2mem(ptr, &__debug_user_context->f.accg, 8);
 
 			for (loop = 0; loop <= 1; loop++)
-				ptr = hex2mem(ptr, &__break_user_context.f.msr[loop], 4);
+				ptr = hex2mem(ptr, &__debug_user_context->f.msr[loop], 4);
 
 			ptr = hex2mem(ptr, &__debug_frame->gner0, 4);
 			ptr = hex2mem(ptr, &__debug_frame->gner1, 4);
 
-			ptr = hex2mem(ptr, &__break_user_context.f.fner[0], 4);
-			ptr = hex2mem(ptr, &__break_user_context.f.fner[1], 4);
+			ptr = hex2mem(ptr, &__debug_user_context->f.fner[0], 4);
+			ptr = hex2mem(ptr, &__debug_user_context->f.fner[1], 4);
 
 			gdbstub_strcpy(output_buffer,"OK");
 			break;
@@ -1769,52 +1790,52 @@ #endif
 			case GDB_REG_GR(0):
 				break;
 			case GDB_REG_GR(1) ... GDB_REG_GR(63):
-				__break_user_context.i.gr[addr - GDB_REG_GR(0)] = temp;
+				__debug_user_context->i.gr[addr - GDB_REG_GR(0)] = temp;
 				break;
 			case GDB_REG_FR(0) ... GDB_REG_FR(63):
-				__break_user_context.f.fr[addr - GDB_REG_FR(0)] = temp;
+				__debug_user_context->f.fr[addr - GDB_REG_FR(0)] = temp;
 				break;
 			case GDB_REG_PC:
-				__break_user_context.i.pc = temp;
+				__debug_user_context->i.pc = temp;
 				break;
 			case GDB_REG_PSR:
-				__break_user_context.i.psr = temp;
+				__debug_user_context->i.psr = temp;
 				break;
 			case GDB_REG_CCR:
-				__break_user_context.i.ccr = temp;
+				__debug_user_context->i.ccr = temp;
 				break;
 			case GDB_REG_CCCR:
-				__break_user_context.i.cccr = temp;
+				__debug_user_context->i.cccr = temp;
 				break;
 			case GDB_REG_BRR:
-				__debug_regs->brr = temp;
+				__debug_status.brr = temp;
 				break;
 			case GDB_REG_LR:
-				__break_user_context.i.lr = temp;
+				__debug_user_context->i.lr = temp;
 				break;
 			case GDB_REG_LCR:
-				__break_user_context.i.lcr = temp;
+				__debug_user_context->i.lcr = temp;
 				break;
 			case GDB_REG_FSR0:
-				__break_user_context.f.fsr[0] = temp;
+				__debug_user_context->f.fsr[0] = temp;
 				break;
 			case GDB_REG_ACC(0) ... GDB_REG_ACC(7):
-				__break_user_context.f.acc[addr - GDB_REG_ACC(0)] = temp;
+				__debug_user_context->f.acc[addr - GDB_REG_ACC(0)] = temp;
 				break;
 			case GDB_REG_ACCG(0):
-				*(uint32_t *) &__break_user_context.f.accg[0] = temp;
+				*(uint32_t *) &__debug_user_context->f.accg[0] = temp;
 				break;
 			case GDB_REG_ACCG(4):
-				*(uint32_t *) &__break_user_context.f.accg[4] = temp;
+				*(uint32_t *) &__debug_user_context->f.accg[4] = temp;
 				break;
 			case GDB_REG_MSR(0) ... GDB_REG_MSR(1):
-				__break_user_context.f.msr[addr - GDB_REG_MSR(0)] = temp;
+				__debug_user_context->f.msr[addr - GDB_REG_MSR(0)] = temp;
 				break;
 			case GDB_REG_GNER(0) ... GDB_REG_GNER(1):
-				__break_user_context.i.gner[addr - GDB_REG_GNER(0)] = temp;
+				__debug_user_context->i.gner[addr - GDB_REG_GNER(0)] = temp;
 				break;
 			case GDB_REG_FNER(0) ... GDB_REG_FNER(1):
-				__break_user_context.f.fner[addr - GDB_REG_FNER(0)] = temp;
+				__debug_user_context->f.fner[addr - GDB_REG_FNER(0)] = temp;
 				break;
 			default:
 				temp2 = 0;
@@ -1850,6 +1871,7 @@ #endif
 			/* step to next instruction */
 		case 's':
 			__debug_regs->dcr |= DCR_SE;
+			__debug_status.dcr |= DCR_SE;
 			goto done;
 
 			/* set baud rate (bBB) */
@@ -1934,7 +1956,7 @@ #endif
 	}
 
  done:
-	restore_user_regs(&__break_user_context);
+	restore_user_regs(&__debug_frame0->uc);
 
 	//gdbstub_dump_debugregs();
 	//gdbstub_printk("<-- gdbstub() %08x\n", __debug_frame->pc);
@@ -1966,7 +1988,6 @@ #ifdef CONFIG_GDBSTUB_IMMEDIATE
 #endif
 
 	gdbstub_printk("%s", gdbstub_banner);
-	gdbstub_printk("DCR: %x\n", __debug_regs->dcr);
 
 	gdbstub_io_init();
 
diff --git a/arch/frv/kernel/head.S b/arch/frv/kernel/head.S
index 47c990a..fecf751 100644
--- a/arch/frv/kernel/head.S
+++ b/arch/frv/kernel/head.S
@@ -11,6 +11,7 @@
 
 #include <linux/threads.h>
 #include <linux/linkage.h>
+#include <asm/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 #include <asm/spr-regs.h>
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index f0c767a..515a5ce 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -26,6 +26,7 @@ #include <linux/elf.h>
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 
+#include <asm/asm-offsets.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/setup.h>
@@ -207,7 +208,7 @@ int copy_thread(int nr, unsigned long cl
 
 	regs0 = __kernel_frame0_ptr;
 	childregs0 = (struct pt_regs *)
-		(task_stack_page(p) + THREAD_SIZE - USER_CONTEXT_SIZE);
+		(task_stack_page(p) + THREAD_SIZE - FRV_FRAME0_SIZE);
 	childregs = childregs0;
 
 	/* set up the userspace frame (the only place that the USP is stored) */
diff --git a/arch/frv/kernel/switch_to.S b/arch/frv/kernel/switch_to.S
index 9e5a583..b5275fa 100644
--- a/arch/frv/kernel/switch_to.S
+++ b/arch/frv/kernel/switch_to.S
@@ -11,6 +11,7 @@ # as published by the Free Software Foun
 # 2 of the License, or (at your option) any later version.
 #
 ###############################################################################
+
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/processor.h>
@@ -30,7 +31,7 @@ #include <asm/spr-regs.h>
 	# address of frame 0 (userspace) on current kernel stack
 	.globl		__kernel_frame0_ptr
 __kernel_frame0_ptr:
-	.long		init_thread_union + THREAD_SIZE - USER_CONTEXT_SIZE
+	.long		init_thread_union + THREAD_SIZE - FRV_FRAME0_SIZE
 
 	# address of current task
 	.globl		__kernel_current_task
diff --git a/arch/frv/kernel/traps.c b/arch/frv/kernel/traps.c
index 98ce362..2e6098c 100644
--- a/arch/frv/kernel/traps.c
+++ b/arch/frv/kernel/traps.c
@@ -20,6 +20,7 @@ #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <asm/asm-offsets.h>
 #include <asm/setup.h>
 #include <asm/fpu.h>
 #include <asm/system.h>
@@ -279,20 +280,20 @@ static const char *regnames[] = {
 
 void show_regs(struct pt_regs *regs)
 {
-	uint32_t *reg;
+	unsigned long *reg;
 	int loop;
 
 	printk("\n");
 
-	printk("Frame: @%08x [%s]\n",
-	       (uint32_t) regs,
+	printk("Frame: @%08lx [%s]\n",
+	       (unsigned long) regs,
 	       regs->psr & PSR_S ? "kernel" : "user");
 
-	reg = (uint32_t *) regs;
-	for (loop = 0; loop < REG__END; loop++) {
-		printk("%s %08x", regnames[loop + 0], reg[loop + 0]);
+	reg = (unsigned long *) regs;
+	for (loop = 0; loop < NR_PT_REGS; loop++) {
+		printk("%s %08lx", regnames[loop + 0], reg[loop + 0]);
 
-		if (loop == REG__END - 1 || loop % 5 == 4)
+		if (loop == NR_PT_REGS - 1 || loop % 5 == 4)
 			printk("\n");
 		else
 			printk(" | ");
@@ -328,7 +329,7 @@ void die_if_kernel(const char *str, ...)
  */
 static void show_backtrace_regs(struct pt_regs *frame)
 {
-	uint32_t *reg;
+	unsigned long *reg;
 	int loop;
 
 	/* print the registers for this frame */
@@ -336,11 +337,11 @@ static void show_backtrace_regs(struct p
 	       frame->psr & PSR_S ? "Kernel Mode" : "User Mode",
 	       frame);
 
-	reg = (uint32_t *) frame;
-	for (loop = 0; loop < REG__END; loop++) {
-		printk("%s %08x", regnames[loop + 0], reg[loop + 0]);
+	reg = (unsigned long *) frame;
+	for (loop = 0; loop < NR_PT_REGS; loop++) {
+		printk("%s %08lx", regnames[loop + 0], reg[loop + 0]);
 
-		if (loop == REG__END - 1 || loop % 5 == 4)
+		if (loop == NR_PT_REGS - 1 || loop % 5 == 4)
 			printk("\n");
 		else
 			printk(" | ");
diff --git a/include/asm-frv/gdb-stub.h b/include/asm-frv/gdb-stub.h
index c58479a..24f9738 100644
--- a/include/asm-frv/gdb-stub.h
+++ b/include/asm-frv/gdb-stub.h
@@ -89,6 +89,7 @@ extern void gdbstub_do_rx(void);
 
 extern asmlinkage void __debug_stub_init_break(void);
 extern asmlinkage void __break_hijack_kernel_event(void);
+extern asmlinkage void __break_hijack_kernel_event_breaks_here(void);
 extern asmlinkage void start_kernel(void);
 
 extern asmlinkage void gdbstub_rx_handler(void);
@@ -114,5 +115,26 @@ #else
 #define gdbstub_proto(FMT,...) ({ 0; })
 #endif
 
+/*
+ * we dedicate GR31 to keeping a pointer to the gdbstub exception frame
+ * - gr31 is destroyed on entry to the gdbstub if !MMU
+ * - gr31 is saved in scr3 on entry to the gdbstub if in !MMU
+ */
+register struct frv_frame0 *__debug_frame0 asm("gr31");
+
+#define __debug_frame		(&__debug_frame0->regs)
+#define __debug_user_context	(&__debug_frame0->uc)
+#define __debug_regs		(&__debug_frame0->debug)
+#define __debug_reg(X)		((unsigned long *) ((unsigned long) &__debug_frame0 + (X)))
+
+struct frv_debug_status {
+	unsigned long		bpsr;
+	unsigned long		dcr;
+	unsigned long		brr;
+	unsigned long		nmar;
+};
+
+extern struct frv_debug_status __debug_status;
+
 #endif /* _LANGUAGE_ASSEMBLY */
 #endif /* __ASM_GDB_STUB_H */
diff --git a/include/asm-frv/ptrace.h b/include/asm-frv/ptrace.h
index b2cce07..7ff5251 100644
--- a/include/asm-frv/ptrace.h
+++ b/include/asm-frv/ptrace.h
@@ -62,18 +62,10 @@ #define PTRACE_GETFDPIC_INTERP	1	/* [add
 #ifndef __ASSEMBLY__
 
 /*
- * dedicate GR28; to keeping the a pointer to the current exception frame
+ * we dedicate GR28 to keeping a pointer to the current exception frame
+ * - gr28 is destroyed on entry to the kernel from userspace
  */
 register struct pt_regs *__frame asm("gr28");
-register struct pt_regs *__debug_frame asm("gr31");
-
-#ifndef container_of
-#define container_of(ptr, type, member) ({			\
-        const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
-        (type *)( (char *)__mptr - offsetof(type,member) );})
-#endif
-
-#define __debug_regs container_of(__debug_frame, struct pt_debug_regs, normal_regs)
 
 #define user_mode(regs)			(!((regs)->psr & PSR_S))
 #define instruction_pointer(regs)	((regs)->pc)
diff --git a/include/asm-frv/registers.h b/include/asm-frv/registers.h
index fccfd95..9666119 100644
--- a/include/asm-frv/registers.h
+++ b/include/asm-frv/registers.h
@@ -23,7 +23,13 @@
  *
  *	+0x2000	+----------------------
  *		| union {
- *		|	struct user_context
+ *		|	struct frv_frame0 {
+ *		|		struct user_context {
+ *		|			struct user_int_regs
+ *		|			struct user_fpmedia_regs
+ *		|		}
+ *		|		struct frv_debug_regs
+ *		|	}
  *		|	struct pt_regs [user exception]
  *		| }
  *		+---------------------- <-- __kernel_frame0_ptr (maybe GR28)
@@ -51,11 +57,11 @@ #ifndef _ASM_REGISTERS_H
 #define _ASM_REGISTERS_H
 
 #ifndef __ASSEMBLY__
-#define __OFFSET(X)	(X)
+#define __OFFSET(X,N)	((X)+(N)*4)
 #define __OFFSETC(X,N)	xxxxxxxxxxxxxxxxxxxxxxxx
 #else
-#define __OFFSET(X)	((X)*4)
-#define __OFFSETC(X,N)	((X)*4+(N))
+#define __OFFSET(X,N)	((X)+(N)*4)
+#define __OFFSETC(X,N)	((X)+(N))
 #endif
 
 /*****************************************************************************/
@@ -117,30 +123,13 @@ struct pt_regs {
 
 #endif
 
-#define REG_PSR		__OFFSET( 0)	/* Processor Status Register */
-#define REG_ISR		__OFFSET( 1)	/* Integer Status Register */
-#define REG_CCR		__OFFSET( 2)	/* Condition Code Register */
-#define REG_CCCR	__OFFSET( 3)	/* Condition Code for Conditional Insns Register */
-#define REG_LR		__OFFSET( 4)	/* Link Register */
-#define REG_LCR		__OFFSET( 5)	/* Loop Count Register */
-#define REG_PC		__OFFSET( 6)	/* Program Counter */
-
-#define REG__STATUS	__OFFSET( 7)	/* exception status */
 #define REG__STATUS_STEP	0x00000001	/* - reenable single stepping on return */
 #define REG__STATUS_STEPPED	0x00000002	/* - single step caused exception */
 #define REG__STATUS_BROKE	0x00000004	/* - BREAK insn caused exception */
 #define REG__STATUS_SYSC_ENTRY	0x40000000	/* - T on syscall entry (ptrace.c only) */
 #define REG__STATUS_SYSC_EXIT	0x80000000	/* - T on syscall exit (ptrace.c only) */
 
-#define REG_SYSCALLNO	__OFFSET( 8)	/* syscall number or -1 */
-#define REG_ORIG_GR8	__OFFSET( 9)	/* saved GR8 for signal handling */
-#define REG_GNER0	__OFFSET(10)
-#define REG_GNER1	__OFFSET(11)
-#define REG_IACC0	__OFFSET(12)
-
-#define REG_TBR		__OFFSET(14)	/* Trap Vector Register */
-#define REG_GR(R)	__OFFSET((14+(R)))
-#define REG__END	REG_GR(32)
+#define REG_GR(R)	__OFFSET(REG_GR0, (R))
 
 #define REG_SP		REG_GR(1)
 #define REG_FP		REG_GR(2)
@@ -149,27 +138,21 @@ #define REG_CURR_TASK	REG_GR(29)	/* curr
 
 /*****************************************************************************/
 /*
- * extension tacked in front of the exception frame in debug mode
+ * debugging registers
  */
 #ifndef __ASSEMBLY__
 
-struct pt_debug_regs
+struct frv_debug_regs
 {
-	unsigned long		bpsr;
 	unsigned long		dcr;
-	unsigned long		brr;
-	unsigned long		nmar;
-	struct pt_regs		normal_regs;
+	unsigned long		ibar[4] __attribute__((aligned(8)));
+	unsigned long		dbar[4] __attribute__((aligned(8)));
+	unsigned long		dbdr[4][4] __attribute__((aligned(8)));
+	unsigned long		dbmr[4][4] __attribute__((aligned(8)));
 } __attribute__((aligned(8)));
 
 #endif
 
-#define REG_NMAR		__OFFSET(-1)
-#define REG_BRR			__OFFSET(-2)
-#define REG_DCR			__OFFSET(-3)
-#define REG_BPSR		__OFFSET(-4)
-#define REG__DEBUG_XTRA		__OFFSET(4)
-
 /*****************************************************************************/
 /*
  * userspace registers
@@ -223,33 +206,27 @@ struct user_context
 	void *extension;
 } __attribute__((aligned(8)));
 
+struct frv_frame0 {
+	union {
+		struct pt_regs		regs;
+		struct user_context	uc;
+	};
+
+	struct frv_debug_regs		debug;
+
+} __attribute__((aligned(32)));
+
 #endif
 
-#define NR_USER_INT_REGS	(14 + 64)
-#define NR_USER_FPMEDIA_REGS	(64 + 2 + 2 + 8 + 8/4 + 1)
-#define NR_USER_CONTEXT		(NR_USER_INT_REGS + NR_USER_FPMEDIA_REGS + 1)
-
-#define USER_CONTEXT_SIZE	(((NR_USER_CONTEXT + 1) & ~1) * 4)
-
-#define __THREAD_FRAME		__OFFSET(0)
-#define __THREAD_CURR		__OFFSET(1)
-#define __THREAD_SP		__OFFSET(2)
-#define __THREAD_FP		__OFFSET(3)
-#define __THREAD_LR		__OFFSET(4)
-#define __THREAD_PC		__OFFSET(5)
-#define __THREAD_GR(R)		__OFFSET(6 + (R) - 16)
-#define __THREAD_FRAME0		__OFFSET(19)
-#define __THREAD_USER		__OFFSET(19)
-
-#define __USER_INT		__OFFSET(0)
-#define __INT_GR(R)		__OFFSET(14 + (R))
-
-#define __USER_FPMEDIA		__OFFSET(NR_USER_INT_REGS)
-#define __FPMEDIA_FR(R)		__OFFSET(NR_USER_INT_REGS + (R))
-#define __FPMEDIA_FNER(R)	__OFFSET(NR_USER_INT_REGS + 64 + (R))
-#define __FPMEDIA_MSR(R)	__OFFSET(NR_USER_INT_REGS + 66 + (R))
-#define __FPMEDIA_ACC(R)	__OFFSET(NR_USER_INT_REGS + 68 + (R))
-#define __FPMEDIA_ACCG(R)	__OFFSETC(NR_USER_INT_REGS + 76, (R))
-#define __FPMEDIA_FSR(R)	__OFFSET(NR_USER_INT_REGS + 78 + (R))
+#define __INT_GR(R)		__OFFSET(__INT_GR0,		(R))
+
+#define __FPMEDIA_FR(R)		__OFFSET(__FPMEDIA_FR0,		(R))
+#define __FPMEDIA_FNER(R)	__OFFSET(__FPMEDIA_FNER0,	(R))
+#define __FPMEDIA_MSR(R)	__OFFSET(__FPMEDIA_MSR0,	(R))
+#define __FPMEDIA_ACC(R)	__OFFSET(__FPMEDIA_ACC0,	(R))
+#define __FPMEDIA_ACCG(R)	__OFFSETC(__FPMEDIA_ACCG0,	(R))
+#define __FPMEDIA_FSR(R)	__OFFSET(__FPMEDIA_FSR0,	(R))
+
+#define __THREAD_GR(R)		__OFFSET(__THREAD_GR16,		(R) - 16)
 
 #endif /* _ASM_REGISTERS_H */
diff --git a/include/asm-frv/thread_info.h b/include/asm-frv/thread_info.h
index ea426ab..d66c48e 100644
--- a/include/asm-frv/thread_info.h
+++ b/include/asm-frv/thread_info.h
@@ -19,6 +19,8 @@ #ifndef __ASSEMBLY__
 #include <asm/processor.h>
 #endif
 
+#define THREAD_SIZE		8192
+
 /*
  * low level task data that entry.S needs immediate access to
  * - this struct should fit entirely inside of one cache line
@@ -46,15 +48,7 @@ struct thread_info {
 
 #else /* !__ASSEMBLY__ */
 
-/* offsets into the thread_info struct for assembly code access */
-#define TI_TASK			0x00000000
-#define TI_EXEC_DOMAIN		0x00000004
-#define TI_FLAGS		0x00000008
-#define TI_STATUS		0x0000000C
-#define TI_CPU			0x00000010
-#define TI_PRE_COUNT		0x00000014
-#define TI_ADDR_LIMIT		0x00000018
-#define TI_RESTART_BLOCK	0x0000001C
+#include <asm/asm-offsets.h>
 
 #endif
 
@@ -83,12 +77,6 @@ #define INIT_THREAD_INFO(tsk)			\
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
-#ifdef CONFIG_SMALL_TASKS
-#define THREAD_SIZE		4096
-#else
-#define THREAD_SIZE		8192
-#endif
-
 /* how to get the thread information struct from C */
 register struct thread_info *__current_thread_info asm("gr15");
 
@@ -111,11 +99,7 @@ #endif
 
 #define free_thread_info(info)	kfree(info)
 
-#else /* !__ASSEMBLY__ */
-
-#define THREAD_SIZE	8192
-
-#endif
+#endif /* __ASSEMBLY__ */
 
 /*
  * thread information flags
