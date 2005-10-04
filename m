Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVJDTB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVJDTB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVJDTBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:01:48 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:14349 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964920AbVJDTBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:01:45 -0400
Message-Id: <200510041853.j94Irqsn008947@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Allan Graves <allan.graves@oracle.com>
Subject: [PATCH 2/2] UML - 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Oct 2005 14:53:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Allan Graves:

Fix sysrq-t support for skas mode.  The old code had the IP and SP coming
from the registers in the thread struct, which are completely wrong since
those are the userspace registers.  This fixes that by pulling the correct
values from the jmp_buf in which the kernel state of each thread is stored.

Signed-off-by: Allan Graves <allan.graves@oracle.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13/arch/um/include/registers.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/registers.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/arch/um/include/registers.h	2005-10-04 13:48:55.000000000 -0400
@@ -15,16 +15,6 @@
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
 extern void get_safe_registers(unsigned long * regs);
+extern void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.13/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-04 13:39:29.000000000 -0400
+++ linux-2.6.13/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-04 13:48:55.000000000 -0400
@@ -218,10 +218,6 @@
                 case RBP: UPT_RBP(regs) = __upt_val; break; \
                 case ORIG_RAX: UPT_ORIG_RAX(regs) = __upt_val; break; \
                 case CS: UPT_CS(regs) = __upt_val; break; \
-                case DS: UPT_DS(regs) = __upt_val; break; \
-                case ES: UPT_ES(regs) = __upt_val; break; \
-                case FS: UPT_FS(regs) = __upt_val; break; \
-                case GS: UPT_GS(regs) = __upt_val; break; \
                 case EFLAGS: UPT_EFLAGS(regs) = __upt_val; break; \
                 default :  \
                         panic("Bad register in UPT_SET : %d\n", reg);  \
Index: linux-2.6.13/arch/um/kernel/sysrq.c
===================================================================
--- linux-2.6.13.orig/arch/um/kernel/sysrq.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/arch/um/kernel/sysrq.c	2005-10-04 13:48:55.000000000 -0400
@@ -62,13 +62,7 @@
 
 	if (esp == NULL) {
 		if (task != current && task != NULL) {
-			/* XXX: Isn't this bogus? I.e. isn't this the
-			 * *userspace* stack of this task? If not so, use this
-			 * even when task == current (as in i386).
-			 */
 			esp = (unsigned long *) KSTK_ESP(task);
-			/* Which one? No actual difference - just coding style.*/
-			//esp = (unsigned long *) PT_REGS_IP(&task->thread.regs);
 		} else {
 			esp = (unsigned long *) &esp;
 		}
@@ -84,5 +78,5 @@
 	}
 
 	printk("Call Trace: \n");
-	show_trace(current, esp);
+	show_trace(task, esp);
 }
Index: linux-2.6.13/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.13.orig/arch/um/os-Linux/sys-i386/registers.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/arch/um/os-Linux/sys-i386/registers.c	2005-10-04 13:48:55.000000000 -0400
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <setjmp.h>
 #include "sysdep/ptrace_user.h"
 #include "sysdep/ptrace.h"
 #include "uml-config.h"
@@ -126,13 +127,11 @@
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+{
+	struct __jmp_buf_tag *jmpbuf = buffer;
+
+	UPT_SET(uml_regs, EIP, jmpbuf->__jmpbuf[JB_PC]);
+	UPT_SET(uml_regs, UESP, jmpbuf->__jmpbuf[JB_SP]);
+	UPT_SET(uml_regs, EBP, jmpbuf->__jmpbuf[JB_BP]);
+}
Index: linux-2.6.13/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.13.orig/arch/um/os-Linux/sys-x86_64/registers.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/arch/um/os-Linux/sys-x86_64/registers.c	2005-10-04 13:48:55.000000000 -0400
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <setjmp.h>
 #include "ptrace_user.h"
 #include "uml-config.h"
 #include "skas_ptregs.h"
@@ -74,13 +75,11 @@
 	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+{
+	struct __jmp_buf_tag *jmpbuf = buffer;
+
+	UPT_SET(uml_regs, RIP, jmpbuf->__jmpbuf[JB_PC]);
+	UPT_SET(uml_regs, RSP, jmpbuf->__jmpbuf[JB_RSP]);
+	UPT_SET(uml_regs, RBP, jmpbuf->__jmpbuf[JB_RBP]);
+}
Index: linux-2.6.13/arch/um/sys-i386/sysrq.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-i386/sysrq.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/arch/um/sys-i386/sysrq.c	2005-10-04 13:48:55.000000000 -0400
@@ -88,9 +88,7 @@
 		task = current;
 
 	if (task != current) {
-		//ebp = (unsigned long) KSTK_EBP(task);
-		/* Which one? No actual difference - just coding style.*/
-		ebp = (unsigned long) PT_REGS_EBP(&task->thread.regs);
+		ebp = (unsigned long) KSTK_EBP(task);
 	} else {
 		asm ("movl %%ebp, %0" : "=r" (ebp) : );
 	}
@@ -99,15 +97,6 @@
 		((unsigned long)stack & (~(THREAD_SIZE - 1)));
 	print_context_stack(context, stack, ebp);
 
-	/*while (((long) stack & (THREAD_SIZE-1)) != 0) {
-		addr = *stack;
-		if (__kernel_text_address(addr)) {
-			printk("%08lx:	[<%08lx>]", (unsigned long) stack, addr);
-			print_symbol(" %s", addr);
-			printk("\n");
-		}
-		stack++;
-	}*/
 	printk("\n");
 }
 
Index: linux-2.6.13/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.13.orig/include/asm-um/processor-generic.h	2005-10-04 13:40:07.000000000 -0400
+++ linux-2.6.13/include/asm-um/processor-generic.h	2005-10-04 13:48:55.000000000 -0400
@@ -13,6 +13,7 @@
 #include "linux/config.h"
 #include "asm/ptrace.h"
 #include "choose-mode.h"
+#include "registers.h"
 
 struct mm_struct;
 
@@ -136,19 +137,15 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-#define KSTK_EIP(tsk) (PT_REGS_IP(&tsk->thread.regs))
-#define KSTK_ESP(tsk) (PT_REGS_SP(&tsk->thread.regs))
-#define get_wchan(p) (0)
 
+#ifdef CONFIG_MODE_SKAS
+#define KSTK_REG(tsk, reg) \
+	({ union uml_pt_regs regs; \
+	   get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
+	   UPT_REG(&regs, reg); })
+#else
+#define KSTK_REG(tsk, reg) (0xbadbabe)
 #endif
+#define get_wchan(p) (0)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
Index: linux-2.6.13/include/asm-um/processor-i386.h
===================================================================
--- linux-2.6.13.orig/include/asm-um/processor-i386.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/include/asm-um/processor-i386.h	2005-10-04 13:48:55.000000000 -0400
@@ -43,17 +43,10 @@
 #define ARCH_IS_STACKGROW(address) \
        (address + 32 >= UPT_SP(&current->thread.regs.regs))
 
+#define KSTK_EIP(tsk) KSTK_REG(tsk, EIP)
+#define KSTK_ESP(tsk) KSTK_REG(tsk, UESP)
+#define KSTK_EBP(tsk) KSTK_REG(tsk, EBP)
+
 #include "asm/processor-generic.h"
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.13/include/asm-um/processor-x86_64.h
===================================================================
--- linux-2.6.13.orig/include/asm-um/processor-x86_64.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/include/asm-um/processor-x86_64.h	2005-10-04 13:48:55.000000000 -0400
@@ -36,17 +36,9 @@
 #define ARCH_IS_STACKGROW(address) \
         (address + 128 >= UPT_SP(&current->thread.regs.regs))
 
+#define KSTK_EIP(tsk) KSTK_REG(tsk, RIP)
+#define KSTK_ESP(tsk) KSTK_REG(tsk, RSP)
+
 #include "asm/processor-generic.h"
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

