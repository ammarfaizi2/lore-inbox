Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTIYRWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTIYRWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:22:18 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:39115 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261168AbTIYRST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:18:19 -0400
Date: Thu, 25 Sep 2003 19:17:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (6/19): system call restart bug.
Message-ID: <20030925171738.GG2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix restarting of system calls done by use of the execute instruction.

diffstat:
 arch/s390/kernel/compat_signal.c |    9 +++++++--
 arch/s390/kernel/entry.S         |   18 ++++++++++--------
 arch/s390/kernel/entry64.S       |   18 ++++++++++--------
 arch/s390/kernel/signal.c        |    4 ++--
 include/asm-s390/ptrace.h        |    3 ++-
 5 files changed, 31 insertions(+), 21 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Thu Sep 25 18:33:24 2003
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Thu Sep 25 18:33:26 2003
@@ -579,7 +579,7 @@
 			/* fallthrough */
 			case -ERESTARTNOINTR:
 				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr -= 2;
+				regs->psw.addr -= regs->ilc;
 		}
 	}
 
@@ -641,7 +641,12 @@
 		    regs->gprs[2] == -ERESTARTSYS ||
 		    regs->gprs[2] == -ERESTARTNOINTR) {
 			regs->gprs[2] = regs->orig_gpr2;
-			regs->psw.addr -= 2;
+			regs->psw.addr -= regs->ilc;
+		}
+		/* Restart the system call with a new system call number */
+		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
+			regs->gprs[2] = __NR_restart_syscall;
+			set_thread_flag(TIF_RESTART_SVC);
 		}
 	}
 	return 0;
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Thu Sep 25 18:33:26 2003
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Thu Sep 25 18:33:26 2003
@@ -45,8 +45,9 @@
 SP_AREGS     =  STACK_FRAME_OVERHEAD + PT_ACR0
 SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + PT_ORIGGPR2
 /* Now the additional entries */
-SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
-SP_SIZE      =  (SP_TRAP+4)
+SP_ILC       =  (SP_ORIG_R2+GPR_SIZE)
+SP_TRAP      =  (SP_ILC+2)
+SP_SIZE      =  (SP_TRAP+2)
 
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
@@ -98,7 +99,8 @@
         stam    %a0,%a15,SP_AREGS(%r15)   # store access registers to kst.
         mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+12 # store ac. regs
         mvc     SP_PSW(8,%r15),\psworg    # move user PSW to stack
-	mvc	SP_TRAP(4,%r15),BASED(.L\psworg) # store trap indication
+	mvc	SP_ILC(2,%r15),__LC_SVC_ILC      # store instruction length
+	mvc	SP_TRAP(2,%r15),BASED(.L\psworg) # store trap indication
         xc      0(4,%r15),0(%r15)         # clear back chain
         .endm
 
@@ -670,11 +672,11 @@
 .Lc_pactive:   .long  PREEMPT_ACTIVE
 .Lc0xff:       .long  0xff
 .Lnr_syscalls: .long  NR_syscalls
-.L0x018:       .long  0x018
-.L0x020:       .long  0x020
-.L0x028:       .long  0x028
-.L0x030:       .long  0x030
-.L0x038:       .long  0x038
+.L0x018:       .word  0x018
+.L0x020:       .word  0x020
+.L0x028:       .word  0x028
+.L0x030:       .word  0x030
+.L0x038:       .word  0x038
 
 /*
  * Symbol constants
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:26 2003
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:26 2003
@@ -45,8 +45,9 @@
 SP_AREGS     =  STACK_FRAME_OVERHEAD + PT_ACR0
 SP_ORIG_R2   =  STACK_FRAME_OVERHEAD + PT_ORIGGPR2
 /* Now the additional entries */
-SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
-SP_SIZE      =  (SP_TRAP+4)
+SP_ILC       =  (SP_ORIG_R2+GPR_SIZE)
+SP_TRAP      =  (SP_ILC+2)
+SP_SIZE      =  (SP_TRAP+2)
 
 _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
@@ -86,7 +87,8 @@
         stam    %a0,%a15,SP_AREGS(%r15)  # store access registers to kst.
         mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+16 # store ac. regs
         mvc     SP_PSW(16,%r15),\psworg  # move user PSW to stack
-	mvc	SP_TRAP(4,%r15),.L\psworg-.Lconst(%r14) # store trap ind.
+	mvc	SP_ILC(2,%r15),__LC_SVC_ILC # store instruction length
+	mvc	SP_TRAP(2,%r15),.L\psworg-.Lconst(%r14) # store trap ind.
         xc      0(8,%r15),0(%r15)        # clear back chain
         .endm
 
@@ -690,9 +692,9 @@
 .Lconst:
 .Lc_ac:        .long  0,0,1
 .Lc_pactive:   .long  PREEMPT_ACTIVE
-.L0x0130:      .long  0x0130
-.L0x0140:      .long  0x0140
-.L0x0150:      .long  0x0150
-.L0x0160:      .long  0x0160
-.L0x0170:      .long  0x0170
+.L0x0130:      .word  0x0130
+.L0x0140:      .word  0x0140
+.L0x0150:      .word  0x0150
+.L0x0160:      .word  0x0160
+.L0x0170:      .word  0x0170
 .Lnr_syscalls: .long  NR_syscalls
diff -urN linux-2.6/arch/s390/kernel/signal.c linux-2.6-s390/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/kernel/signal.c	Thu Sep 25 18:33:26 2003
@@ -418,7 +418,7 @@
 			/* fallthrough */
 			case -ERESTARTNOINTR:
 				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr -= 2;
+				regs->psw.addr -= regs->ilc;
 		}
 	}
 
@@ -487,7 +487,7 @@
 		    regs->gprs[2] == -ERESTARTSYS ||
 		    regs->gprs[2] == -ERESTARTNOINTR) {
 			regs->gprs[2] = regs->orig_gpr2;
-			regs->psw.addr -= 2;
+			regs->psw.addr -= regs->ilc;
 		}
 		/* Restart the system call with a new system call number */
 		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	Mon Sep  8 21:50:17 2003
+++ linux-2.6-s390/include/asm-s390/ptrace.h	Thu Sep 25 18:33:26 2003
@@ -301,7 +301,8 @@
 	unsigned long gprs[NUM_GPRS];
 	unsigned int  acrs[NUM_ACRS];
 	unsigned long orig_gpr2;
-	unsigned int  trap;
+	unsigned short ilc;
+	unsigned short trap;
 } __attribute__ ((packed));
 
 /*
