Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWDMNe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWDMNe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWDMNe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:34:27 -0400
Received: from mail.renesas.com ([202.234.163.13]:57486 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964886AbWDMNe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:34:26 -0400
Date: Thu, 13 Apr 2006 22:34:17 +0900 (JST)
Message-Id: <20060413.223417.465769640.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.17-rc1-mm2] m32r: Fix pt_regs for
 !COFNIG_ISA_DSP_LEVEL2 target
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org, ksakamot@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This modification is required to fix debugging function for 
m32r targets with !CONFIG_ISA_DSP_LEVEL2, by unifying 
'struct pt_regs' and 'struct sigcontext' size for all M32R ISA.

Some m32r processor core with !CONFIG_ISA_DSP_LEVEL2 configuration
has only single accumulator a0 (ex. VDEC2 core, M32102 core, etc.),
the others with CONFIG_ISA_DSP_LEVEL2 has two accumulators, a0 and a1.

This means there are two variations of thread context.
So far, we reduced and changed stackframe size at a syscall 
for their context size.  However, this causes a problem that 
a GDB for processors with CONFIG_ISA_DSP_LEVEL2 cannot be used
for processors with !CONFIG_ISA_DSP_LEVEL2.

>From the viewpoint of GDB support, we should reduce such variation of
stackframe size for simplicity.
In this patch, dummy members are added to 'struct pt_regs' and 
'struct sigcontext' to adjust their size for !CONFIG_ISA_DSP_LEVEL2.


This modification is also a one step for a GDB update in future.
Currently, on the m32r, GDB can access process's context by using 
ptrace functions in a simple way of register by register access.
By unifying stackframe size, we have a possibility to make use of
ptrace functions of not only a single register access but also 
block register access, PTRACE_{GETREGS,PUTREGS}.

However, for this purpose, we might have to modify stackframe
structure some more; for example, PSW (processor status word) register
should be pre-processed before pushing to stack at a syscall, and so on.
In this case, we must update carefully both kernel and GDB at a time...


Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Cc: Kei Sakamoto <ksakamot@linux-m32r.org>
---

 arch/m32r/kernel/entry.S      |   49 ++++++++++++++++--------------------------
 arch/m32r/kernel/signal.c     |    4 +++
 include/asm-m32r/assembler.h  |    5 ++++
 include/asm-m32r/ptrace.h     |   25 ++++++++-------------
 include/asm-m32r/sigcontext.h |    2 +
 5 files changed, 40 insertions(+), 45 deletions(-)

Index: linux-2.6.17-rc1-mm2/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.17-rc1-mm2.orig/arch/m32r/kernel/entry.S	2006-04-10 10:37:48.379298460 +0900
+++ linux-2.6.17-rc1-mm2/arch/m32r/kernel/entry.S	2006-04-10 11:06:21.561851775 +0900
@@ -20,7 +20,7 @@
  * Stack layout in 'ret_from_system_call':
  * 	ptrace needs to have all regs on the stack.
  *	if the order here is changed, it needs to be
- *	updated in fork.c:copy_process, signal.c:do_signal,
+ *	updated in fork.c:copy_thread, signal.c:do_signal,
  *	ptrace.c and ptrace.h
  *
  * M32Rx/M32R2				M32R
@@ -41,18 +41,17 @@
  *       @(0x38,sp) - syscall_nr	ditto
  *       @(0x3c,sp) - acc0h		@(0x3c,sp) - acch
  *       @(0x40,sp) - acc0l		@(0x40,sp) - accl
- *       @(0x44,sp) - acc1h		@(0x44,sp) - psw
- *       @(0x48,sp) - acc1l		@(0x48,sp) - bpc
- *       @(0x4c,sp) - psw		@(0x4c,sp) - bbpsw
- *       @(0x50,sp) - bpc		@(0x50,sp) - bbpc
- *       @(0x54,sp) - bbpsw		@(0x54,sp) - spu (cr3)
- *       @(0x58,sp) - bbpc		@(0x58,sp) - fp (r13)
- *       @(0x5c,sp) - spu (cr3)		@(0x5c,sp) - lr (r14)
- *       @(0x60,sp) - fp (r13)		@(0x60,sp) - spi (cr12)
- *       @(0x64,sp) - lr (r14)		@(0x64,sp) - orig_r0
- *       @(0x68,sp) - spi (cr2)
- *       @(0x6c,sp) - orig_r0
- *
+ *       @(0x44,sp) - acc1h		@(0x44,sp) - dummy_acc1h
+ *       @(0x48,sp) - acc1l		@(0x48,sp) - dummy_acc1l
+ *       @(0x4c,sp) - psw		ditto
+ *       @(0x50,sp) - bpc		ditto
+ *       @(0x54,sp) - bbpsw		ditto
+ *       @(0x58,sp) - bbpc		ditto
+ *       @(0x5c,sp) - spu (cr3)		ditto
+ *       @(0x60,sp) - fp (r13)		ditto
+ *       @(0x64,sp) - lr (r14)		ditto
+ *       @(0x68,sp) - spi (cr2)		ditto
+ *       @(0x6c,sp) - orig_r0		ditto
  */
 
 #include <linux/config.h>
@@ -102,6 +101,12 @@
 #define ACC0L(reg)		@(0x40,reg)
 #define ACC1H(reg)		@(0x44,reg)
 #define ACC1L(reg)		@(0x48,reg)
+#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
+#define ACCH(reg)		@(0x3C,reg)
+#define ACCL(reg)		@(0x40,reg)
+#else
+#error unknown isa configuration
+#endif
 #define PSW(reg)		@(0x4C,reg)
 #define BPC(reg)		@(0x50,reg)
 #define BBPSW(reg)		@(0x54,reg)
@@ -111,21 +116,6 @@
 #define LR(reg)			@(0x64,reg)
 #define SP(reg)			@(0x68,reg)
 #define ORIG_R0(reg)		@(0x6C,reg)
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-#define ACCH(reg)		@(0x3C,reg)
-#define ACCL(reg)		@(0x40,reg)
-#define PSW(reg)		@(0x44,reg)
-#define BPC(reg)		@(0x48,reg)
-#define BBPSW(reg)		@(0x4C,reg)
-#define BBPC(reg)		@(0x50,reg)
-#define SPU(reg)		@(0x54,reg)
-#define FP(reg)			@(0x58,reg)  /* FP = R13 */
-#define LR(reg)			@(0x5C,reg)
-#define SP(reg)			@(0x60,reg)
-#define ORIG_R0(reg)		@(0x64,reg)
-#else
-#error unknown isa configuration
-#endif
 
 CF_MASK		= 0x00000001
 TF_MASK		= 0x00000100
@@ -231,7 +221,7 @@ restore_all:
 	RESTORE_ALL
 
 	# perform work that needs to be done immediately before resumption
-	# r9 : frags
+	# r9 : flags
 	ALIGN
 work_pending:
 	and3	r4, r9, #_TIF_NEED_RESCHED
@@ -1015,4 +1005,3 @@ ENTRY(sys_call_table)
 	.long sys_waitid
 
 syscall_table_size=(.-sys_call_table)
-
Index: linux-2.6.17-rc1-mm2/arch/m32r/kernel/signal.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/arch/m32r/kernel/signal.c	2006-04-10 10:37:48.423291494 +0900
+++ linux-2.6.17-rc1-mm2/arch/m32r/kernel/signal.c	2006-04-10 10:54:25.721816023 +0900
@@ -118,6 +118,8 @@ restore_sigcontext(struct pt_regs *regs,
 #elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
 	COPY(acch);
 	COPY(accl);
+	COPY(dummy_acc1h);
+	COPY(dummy_acc1l);
 #else
 #error unknown isa configuration
 #endif
@@ -203,6 +205,8 @@ setup_sigcontext(struct sigcontext __use
 #elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
 	COPY(acch);
 	COPY(accl);
+	COPY(dummy_acc1h);
+	COPY(dummy_acc1l);
 #else
 #error unknown isa configuration
 #endif
Index: linux-2.6.17-rc1-mm2/include/asm-m32r/assembler.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/asm-m32r/assembler.h	2006-04-10 10:37:29.471292397 +0900
+++ linux-2.6.17-rc1-mm2/include/asm-m32r/assembler.h	2006-04-10 10:54:25.731814445 +0900
@@ -109,6 +109,9 @@
 	push	r13
 	mvfachi	r13
 	push	r13
+	ldi	r13, #0
+	push	r13		; dummy push acc1h
+	push	r13		; dummy push acc1l
 #else
 #error unknown isa configuration
 #endif
@@ -156,6 +159,8 @@
 	pop	r13
 	mvtaclo	r13, a1
 #elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
+	pop	r13		; dummy pop acc1h
+	pop	r13		; dummy pop acc1l
 	pop	r13
 	mvtachi	r13
 	pop	r13
Index: linux-2.6.17-rc1-mm2/include/asm-m32r/ptrace.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/asm-m32r/ptrace.h	2006-04-10 10:37:29.796240944 +0900
+++ linux-2.6.17-rc1-mm2/include/asm-m32r/ptrace.h	2006-04-10 10:54:25.737813499 +0900
@@ -43,6 +43,14 @@
 #define PT_ACC1L	18
 #define PT_ACCH		PT_ACC0H
 #define PT_ACCL		PT_ACC0L
+#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
+#define PT_ACCH		15
+#define PT_ACCL		16
+#define PT_DUMMY_ACC1H	17
+#define PT_DUMMY_ACC1L	18
+#else
+#error unknown isa conifiguration
+#endif
 #define PT_PSW		19
 #define PT_BPC		20
 #define PT_BBPSW	21
@@ -52,21 +60,6 @@
 #define PT_LR		25
 #define PT_SPI		26
 #define PT_ORIGR0	27
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-#define PT_ACCH		15
-#define PT_ACCL		16
-#define PT_PSW		17
-#define PT_BPC		18
-#define PT_BBPSW	19
-#define PT_BBPC		20
-#define PT_SPU		21
-#define PT_FP		22
-#define PT_LR		23
-#define PT_SPI		24
-#define PT_ORIGR0	25
-#else
-#error unknown isa conifiguration
-#endif
 
 /* virtual pt_reg entry for gdb */
 #define PT_PC		30
@@ -121,6 +114,8 @@ struct pt_regs {
 #elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
 	unsigned long acch;
 	unsigned long accl;
+	unsigned long dummy_acc1h;
+	unsigned long dummy_acc1l;
 #else
 #error unknown isa configuration
 #endif
Index: linux-2.6.17-rc1-mm2/include/asm-m32r/sigcontext.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/asm-m32r/sigcontext.h	2006-04-10 10:37:29.851232236 +0900
+++ linux-2.6.17-rc1-mm2/include/asm-m32r/sigcontext.h	2006-04-10 10:54:25.743812553 +0900
@@ -32,6 +32,8 @@ struct sigcontext {
 #elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
 	unsigned long sc_acch;
 	unsigned long sc_accl;
+	unsigned long sc_dummy_acc1h;
+	unsigned long sc_dummy_acc1l;
 #else
 #error unknown isa configuration
 #endif

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
