Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVCJA33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVCJA33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVCJA0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:26:47 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:52238 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262573AbVCJARI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:17:08 -0500
Message-Id: <200503100215.j2A2FpDN015222@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/9] UML - ptrace interface cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:15:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser, mostly:
Gets rid of all inclusions of {sys,linux,asm}/ptrace.h since their effects
and contents are somewhat distro- and architecture-dependent.  
arch/um/sysdep/ptrace_user is now responsible for providing the system's
ptrace interfaces to UML.
As such, it is a purely userspace header, and this exposed a couple of
places where kernel files were including it.  One of them needed 
MAX_REG_OFFSET, so this was provided by adding a new generated header,
user-constants.h, which includes this.
Also, changed PTRACE_{PEEK,POKE}_USER to _USR since that seems to be more
standard.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

InIndex: linux-2.6.11/arch/um/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/Makefile	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/Makefile	2005-03-08 20:23:17.000000000 -0500
@@ -182,13 +182,18 @@
 $(ARCH_DIR)/include/task.h: $(ARCH_DIR)/util/mk_task
 	$(call filechk,gen_header)
 
+$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/os/util/mk_user_constants
+	$(call filechk,gen_header)
+
 $(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/util/mk_constants
 	$(call filechk,gen_header)
 
 $(ARCH_DIR)/include/skas_ptregs.h: $(ARCH_DIR)/kernel/skas/util/mk_ptregs
 	$(call filechk,gen_header)
 
-$(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants: $(ARCH_DIR)/util \
+$(ARCH_DIR)/os/util/mk_user_constants: $(ARCH_DIR)/os/util FORCE ;
+
+$(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants: $(ARCH_DIR)/include/user_constants.h $(ARCH_DIR)/util \
 	FORCE ;
 
 $(ARCH_DIR)/kernel/skas/util/mk_ptregs: $(ARCH_DIR)/kernel/skas/util FORCE ;
@@ -199,4 +204,7 @@
 $(ARCH_DIR)/kernel/skas/util: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=$@
 
+$(ARCH_DIR)/os/util: scripts_basic FORCE
+	$(Q)$(MAKE) $(build)=$@
+
 export SUBARCH USER_CFLAGS OS
Index: linux-2.6.11/arch/um/include/registers.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/registers.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/registers.h	2005-03-08 20:23:17.000000000 -0500
@@ -9,6 +9,8 @@
 #include "sysdep/ptrace.h"
 
 extern void init_thread_registers(union uml_pt_regs *to);
+extern int save_fp_registers(int pid, unsigned long *fp_regs);
+extern int restore_fp_registers(int pid, unsigned long *fp_regs);
 extern void save_registers(int pid, union uml_pt_regs *regs);
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
Index: linux-2.6.11/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-i386/ptrace.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/sysdep-i386/ptrace.h	2005-03-08 20:24:49.000000000 -0500
@@ -7,6 +7,7 @@
 #define __SYSDEP_I386_PTRACE_H
 
 #include "uml-config.h"
+#include "user_constants.h"
 
 #ifdef UML_CONFIG_MODE_TT
 #include "sysdep/sc.h"
@@ -14,6 +15,9 @@
 
 #ifdef UML_CONFIG_MODE_SKAS
 
+#define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
+#define MAX_REG_OFFSET (UM_FRAME_SIZE)
+
 /* syscall emulation path in ptrace */
 
 #ifndef PTRACE_SYSEMU
@@ -26,7 +30,7 @@
 
 #include "skas_ptregs.h"
 
-#define HOST_FRAME_SIZE 17
+extern void update_debugregs(int seq);
 
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
Index: linux-2.6.11/arch/um/include/sysdep-i386/ptrace_user.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-i386/ptrace_user.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/sysdep-i386/ptrace_user.h	2005-03-08 20:31:37.000000000 -0500
@@ -6,6 +6,8 @@
 #ifndef __SYSDEP_I386_PTRACE_USER_H__
 #define __SYSDEP_I386_PTRACE_USER_H__
 
+#include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <asm/ptrace.h>
 
 #define PT_OFFSET(r) ((r) * sizeof(long))
@@ -33,9 +35,6 @@
 #define FP_FRAME_SIZE (27)
 #define FPX_FRAME_SIZE (128)
 
-#define MAX_REG_OFFSET (FRAME_SIZE_OFFSET)
-#define MAX_REG_NR (FRAME_SIZE)
-
 #ifdef PTRACE_GETREGS
 #define UM_HAVE_GETREGS
 #endif
@@ -60,6 +59,4 @@
 #define UM_HAVE_SETFPXREGS
 #endif
 
-extern void update_debugregs(int seq);
-
 #endif
Index: linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace.h	2005-03-08 20:25:54.000000000 -0500
@@ -8,6 +8,7 @@
 #define __SYSDEP_X86_64_PTRACE_H
 
 #include "uml-config.h"
+#include "user_constants.h"
 
 #ifdef UML_CONFIG_MODE_TT
 #include "sysdep/sc.h"
@@ -16,6 +17,9 @@
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas_ptregs.h"
 
+#define MAX_REG_OFFSET (UM_FRAME_SIZE)
+#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
+
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
 
Index: linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace_user.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-03-08 20:23:17.000000000 -0500
@@ -8,6 +8,8 @@
 #define __SYSDEP_X86_64_PTRACE_USER_H__
 
 #define __FRAME_OFFSETS
+#include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #include <asm/ptrace.h>
 #undef __FRAME_OFFSETS
 
@@ -45,9 +47,6 @@
 #define PT_ORIG_RAX_OFFSET (ORIG_RAX)
 #define PT_ORIG_RAX(regs) ((regs)[PT_INDEX(ORIG_RAX)])
 
-#define MAX_REG_OFFSET (FRAME_SIZE)
-#define MAX_REG_NR ((MAX_REG_OFFSET) / sizeof(unsigned long))
-
 /* x86_64 FC3 doesn't define this in /usr/include/linux/ptrace.h even though
  * it's defined in the kernel's include/linux/ptrace.h. Additionally, use the
  * 2.4 name and value for 2.4 host compatibility.
Index: linux-2.6.11/arch/um/kernel/process.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/process.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/process.c	2005-03-08 20:35:04.000000000 -0500
@@ -12,11 +12,6 @@
 #include <stdlib.h>
 #include <setjmp.h>
 #include <sys/time.h>
-#include <sys/ptrace.h>
-
-/*Userspace header, must be after sys/ptrace.h, and both must be included. */
-#include <linux/ptrace.h>
-
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/unistd.h>
@@ -28,7 +23,6 @@
 #include "signal_kern.h"
 #include "signal_user.h"
 #include "sysdep/ptrace.h"
-#include "sysdep/ptrace_user.h"
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
 #include "ptrace_user.h"
@@ -36,6 +30,7 @@
 #include "init.h"
 #include "os.h"
 #include "uml-config.h"
+#include "ptrace_user.h"
 #include "choose-mode.h"
 #include "mode.h"
 #ifdef UML_CONFIG_MODE_SKAS
@@ -259,7 +254,7 @@
 		panic("check_sysemu : expected SIGTRAP, "
 		      "got status = %d", status);
 
-	n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 		   os_getpid());
 	if(n < 0)
 		panic("check_sysemu : failed to modify system "
@@ -285,12 +280,12 @@
 			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
 			      "got status = %d", status);
 
-		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
+		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
 				 0);
 		if(syscall == __NR_getpid){
 			if (!count)
 				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
-			n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 				   os_getpid());
 			if(n < 0)
 				panic("check_sysemu : failed to modify system "
@@ -336,10 +331,10 @@
 			panic("check_ptrace : expected SIGTRAP + 0x80, "
 			      "got status = %d", status);
 		
-		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
+		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
 				 0);
 		if(syscall == __NR_getpid){
-			n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
+			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
 				   __NR_getppid);
 			if(n < 0)
 				panic("check_ptrace : failed to modify system "
Index: linux-2.6.11/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/ptrace.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/ptrace.c	2005-03-08 20:23:17.000000000 -0500
@@ -15,8 +15,8 @@
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 #include "kern_util.h"
-#include "ptrace_user.h"
 #include "skas_ptrace.h"
+#include "sysdep/ptrace.h"
 
 /*
  * Called by kernel/ptrace.c when detaching..
Index: linux-2.6.11/arch/um/kernel/skas/mem_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/mem_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/mem_user.c	2005-03-08 20:26:27.000000000 -0500
@@ -5,7 +5,6 @@
 
 #include <errno.h>
 #include <sys/mman.h>
-#include <sys/ptrace.h>
 #include "mem_user.h"
 #include "mem.h"
 #include "user.h"
Index: linux-2.6.11/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/process.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/process.c	2005-03-08 20:32:05.000000000 -0500
@@ -10,8 +10,6 @@
 #include <setjmp.h>
 #include <sched.h>
 #include <sys/wait.h>
-#include <sys/ptrace.h>
-#include <linux/ptrace.h>
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <asm/unistd.h>
@@ -62,7 +60,7 @@
 
 	if (!local_using_sysemu)
 	{
-		err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, __NR_getpid);
+		err = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET, __NR_getpid);
 		if(err < 0)
 			panic("handle_trap - nullifying syscall failed errno = %d\n",
 			      errno);
Index: linux-2.6.11/arch/um/kernel/trap_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/trap_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/trap_user.c	2005-03-08 20:23:17.000000000 -0500
@@ -8,7 +8,6 @@
 #include <setjmp.h>
 #include <signal.h>
 #include <sys/time.h>
-#include <sys/ptrace.h>
 #include <sys/wait.h>
 #include <asm/page.h>
 #include <asm/unistd.h>
Index: linux-2.6.11/arch/um/kernel/tt/exec_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/exec_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/exec_user.c	2005-03-08 20:23:17.000000000 -0500
@@ -9,8 +9,6 @@
 #include <sched.h>
 #include <errno.h>
 #include <sys/wait.h>
-#include <sys/ptrace.h>
-#include <linux/ptrace.h>
 #include <signal.h>
 #include "user_util.h"
 #include "kern_util.h"
Index: linux-2.6.11/arch/um/kernel/tt/gdb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/gdb.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/gdb.c	2005-03-08 20:23:17.000000000 -0500
@@ -8,8 +8,8 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
-#include <sys/ptrace.h>
 #include <sys/types.h>
+#include "ptrace_user.h"
 #include "uml-config.h"
 #include "kern_constants.h"
 #include "chan_user.h"
Index: linux-2.6.11/arch/um/kernel/tt/ptproxy/proxy.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/ptproxy/proxy.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/ptproxy/proxy.c	2005-03-08 20:23:17.000000000 -0500
@@ -18,9 +18,9 @@
 #include <termios.h>
 #include <sys/wait.h>
 #include <sys/types.h>
-#include <sys/ptrace.h>
 #include <sys/ioctl.h>
 #include <asm/unistd.h>
+#include "ptrace_user.h"
 
 #include "ptproxy.h"
 #include "sysdep.h"
Index: linux-2.6.11/arch/um/kernel/tt/ptproxy/ptrace.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/ptproxy/ptrace.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/ptproxy/ptrace.c	2005-03-08 20:23:17.000000000 -0500
@@ -12,9 +12,7 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/time.h>
-#include <sys/ptrace.h>
 #include <sys/wait.h>
-#include <asm/ptrace.h>
 
 #include "ptproxy.h"
 #include "debug.h"
@@ -127,7 +125,7 @@
 
 	case PTRACE_PEEKDATA:
 	case PTRACE_PEEKTEXT:
-	case PTRACE_PEEKUSER:
+	case PTRACE_PEEKUSR:
 		/* The value being read out could be -1, so we have to 
 		 * check errno to see if there's an error, and zero it
 		 * beforehand so we're not faked out by an old error
@@ -144,11 +142,11 @@
 
 	case PTRACE_POKEDATA:
 	case PTRACE_POKETEXT:
-	case PTRACE_POKEUSER:
+	case PTRACE_POKEUSR:
 		result = ptrace(arg1, child, arg3, arg4);
 		if(result == -1) return(-errno);
 
-		if(arg1 == PTRACE_POKEUSER) ptrace_pokeuser(arg3, arg4);
+		if(arg1 == PTRACE_POKEUSR) ptrace_pokeuser(arg3, arg4);
 		return(result);
 
 #ifdef UM_HAVE_SETFPREGS
Index: linux-2.6.11/arch/um/kernel/tt/ptproxy/sysdep.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/ptproxy/sysdep.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/ptproxy/sysdep.c	2005-03-08 20:23:17.000000000 -0500
@@ -11,7 +11,6 @@
 #include <signal.h>
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/ptrace.h>
 #include <linux/unistd.h>
 #include "ptrace_user.h"
 #include "user_util.h"
@@ -20,21 +19,21 @@
 int get_syscall(pid_t pid, long *arg1, long *arg2, long *arg3, long *arg4, 
 		long *arg5)
 {
-	*arg1 = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_ARG1_OFFSET, 0);
-	*arg2 = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_ARG2_OFFSET, 0);
-	*arg3 = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_ARG3_OFFSET, 0);
-	*arg4 = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_ARG4_OFFSET, 0);
-	*arg5 = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_ARG5_OFFSET, 0);
-	return(ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET, 0));
+	*arg1 = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_ARG1_OFFSET, 0);
+	*arg2 = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_ARG2_OFFSET, 0);
+	*arg3 = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_ARG3_OFFSET, 0);
+	*arg4 = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_ARG4_OFFSET, 0);
+	*arg5 = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_ARG5_OFFSET, 0);
+	return(ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET, 0));
 }
 
 void syscall_cancel(pid_t pid, int result)
 {
-	if((ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
+	if((ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET, 
 		   __NR_getpid) < 0) ||
 	   (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0) ||
 	   (wait_for_stop(pid, SIGTRAP, PTRACE_SYSCALL, NULL) < 0) ||
-	   (ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET, result) < 0) ||
+	   (ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET, result) < 0) ||
 	   (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0))
 		printk("ptproxy: couldn't cancel syscall: errno = %d\n", 
 		       errno);
@@ -42,7 +41,7 @@
 
 void syscall_set_result(pid_t pid, long result)
 {
-	ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET, result);
+	ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET, result);
 }
 
 void syscall_continue(pid_t pid)
@@ -52,7 +51,7 @@
 
 int syscall_pause(pid_t pid) 
 {
-	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, __NR_pause) < 0){
+	if(ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET, __NR_pause) < 0){
 		printk("syscall_change - ptrace failed, errno = %d\n", errno);
 		return(-1);
 	}
Index: linux-2.6.11/arch/um/kernel/tt/ptproxy/wait.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/ptproxy/wait.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/ptproxy/wait.c	2005-03-08 20:23:17.000000000 -0500
@@ -9,14 +9,13 @@
 #include <errno.h>
 #include <signal.h>
 #include <sys/wait.h>
-#include <sys/ptrace.h>
 
 #include "ptproxy.h"
 #include "sysdep.h"
 #include "wait.h"
 #include "user_util.h"
+#include "ptrace_user.h"
 #include "sysdep/ptrace.h"
-#include "sysdep/ptrace_user.h"
 #include "sysdep/sigcontext.h"
 
 int proxy_wait_return(struct debugger *debugger, pid_t unused)
@@ -59,10 +58,10 @@
 
 	pid = debugger->pid;
 
-	ip = ptrace(PTRACE_PEEKUSER, pid, PT_IP_OFFSET, 0);
+	ip = ptrace(PTRACE_PEEKUSR, pid, PT_IP_OFFSET, 0);
 	IP_RESTART_SYSCALL(ip);
 
-	if(ptrace(PTRACE_POKEUSER, pid, PT_IP_OFFSET, ip) < 0)
+	if(ptrace(PTRACE_POKEUSR, pid, PT_IP_OFFSET, ip) < 0)
 		tracer_panic("real_wait_return : Failed to restart system "
 			     "call, errno = %d\n", errno);
 
Index: linux-2.6.11/arch/um/kernel/tt/syscall_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/syscall_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/syscall_user.c	2005-03-08 20:23:17.000000000 -0500
@@ -6,7 +6,6 @@
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
-#include <sys/ptrace.h>
 #include <asm/unistd.h>
 #include "sysdep/ptrace.h"
 #include "sigcontext.h"
@@ -73,7 +72,7 @@
 		return;
 
 	/* syscall number -1 in sysemu skips syscall restarting in host */
-	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
+	if(ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET, 
 		  local_using_sysemu ? -1 : __NR_getpid) < 0)
 		tracer_panic("do_syscall : Nullifying syscall failed, "
 			     "errno = %d", errno);
Index: linux-2.6.11/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tracer.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tracer.c	2005-03-08 20:23:17.000000000 -0500
@@ -12,7 +12,6 @@
 #include <sched.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/ptrace.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include "user.h"
@@ -293,7 +292,7 @@
 				signal_index[proc_id] = last_index;
 			signal_record[proc_id][signal_index[proc_id]].pid = pid;
 			gettimeofday(&signal_record[proc_id][signal_index[proc_id]].time, NULL);
-			eip = ptrace(PTRACE_PEEKUSER, pid, PT_IP_OFFSET, 0);
+			eip = ptrace(PTRACE_PEEKUSR, pid, PT_IP_OFFSET, 0);
 			signal_record[proc_id][signal_index[proc_id]].addr = eip;
 			signal_record[proc_id][signal_index[proc_id]++].signal = sig;
 #endif			
Index: linux-2.6.11/arch/um/kernel/user_util.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/user_util.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/user_util.c	2005-03-08 20:23:17.000000000 -0500
@@ -10,7 +10,6 @@
 #include <setjmp.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-#include <sys/ptrace.h>
 #include <sys/utsname.h>
 #include <sys/param.h>
 #include <sys/time.h>
@@ -29,6 +28,7 @@
 #include "mem_user.h"
 #include "init.h"
 #include "helper.h"
+#include "ptrace_user.h"
 #include "uml-config.h"
 
 #define COMMAND_LINE_SIZE _POSIX_ARG_MAX
Index: linux-2.6.11/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.11.orig/arch/um/os-Linux/process.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/os-Linux/process.c	2005-03-08 20:23:17.000000000 -0500
@@ -8,9 +8,9 @@
 #include <errno.h>
 #include <signal.h>
 #include <linux/unistd.h>
-#include <sys/ptrace.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include "ptrace_user.h"
 #include "os.h"
 #include "user.h"
 #include "user_util.h"
Index: linux-2.6.11/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.11.orig/arch/um/os-Linux/sys-i386/registers.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/os-Linux/sys-i386/registers.c	2005-03-08 20:23:17.000000000 -0500
@@ -5,7 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
-#include <sys/ptrace.h>
+#include "sysdep/ptrace_user.h"
 #include "sysdep/ptrace.h"
 #include "uml-config.h"
 #include "skas_ptregs.h"
@@ -27,6 +27,23 @@
 		memcpy(to->skas.xfp, exec_fpx_regs, sizeof(to->skas.xfp));
 }
 
+/* XXX These need to use [GS]ETFPXREGS and copy_sc_{to,from}_user_skas needs
+ * to pass in a sufficiently large buffer
+ */
+int save_fp_registers(int pid, unsigned long *fp_regs)
+{
+	if(ptrace(PTRACE_GETFPREGS, pid, 0, fp_regs) < 0)
+		return(-errno);
+	return(0);
+}
+
+int restore_fp_registers(int pid, unsigned long *fp_regs)
+{
+	if(ptrace(PTRACE_SETFPREGS, pid, 0, fp_regs) < 0)
+		return(-errno);
+	return(0);
+}
+
 static int move_registers(int pid, int int_op, union uml_pt_regs *regs,
 			  int fp_op, unsigned long *fp_regs)
 {
Index: linux-2.6.11/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.11.orig/arch/um/os-Linux/sys-x86_64/registers.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/os-Linux/sys-x86_64/registers.c	2005-03-08 20:23:17.000000000 -0500
@@ -5,8 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
-#include <sys/ptrace.h>
-#include "sysdep/ptrace.h"
+#include "ptrace_user.h"
 #include "uml-config.h"
 #include "skas_ptregs.h"
 #include "registers.h"
Index: linux-2.6.11/arch/um/os-Linux/util/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/os-Linux/util/Makefile	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11/arch/um/os-Linux/util/Makefile	2005-03-08 20:23:17.000000000 -0500
@@ -0,0 +1,4 @@
+hostprogs-y		:= mk_user_constants 
+always			:= $(hostprogs-y)
+
+mk_user_constants-objs	:= mk_user_constants.o
Index: linux-2.6.11/arch/um/os-Linux/util/mk_user_constants.c
===================================================================
--- linux-2.6.11.orig/arch/um/os-Linux/util/mk_user_constants.c	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11/arch/um/os-Linux/util/mk_user_constants.c	2005-03-08 20:23:17.000000000 -0500
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <asm/types.h>
+/* For some reason, x86_64 nowhere defines u64 and u32, even though they're
+ * used throughout the headers.
+ */
+typedef __u64 u64;
+typedef __u32 u32;
+#include <asm/user.h>
+
+int main(int argc, char **argv)
+{
+  printf("/*\n");
+  printf(" * Generated by mk_user_constants\n");
+  printf(" */\n");
+  printf("\n");
+  printf("#ifndef __UM_USER_CONSTANTS_H\n");
+  printf("#define __UM_USER_CONSTANTS_H\n");
+  printf("\n");
+  /* I'd like to use FRAME_SIZE from ptrace.h here, but that's wrong on 
+   * x86_64 (216 vs 168 bytes).  user_regs_struct is the correct size on
+   * both x86_64 and i386.
+   */
+  printf("#define UM_FRAME_SIZE %d\n", (int) sizeof(struct user_regs_struct));
+
+  printf("\n");
+  printf("#endif\n");
+
+  return(0);
+}
Index: linux-2.6.11/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/ptrace.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/ptrace.c	2005-03-08 20:23:17.000000000 -0500
@@ -10,7 +10,7 @@
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
-#include "ptrace_user.h"
+#include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/sc.h"
 
Index: linux-2.6.11/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/ptrace_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/ptrace_user.c	2005-03-08 20:23:17.000000000 -0500
@@ -7,8 +7,8 @@
 #include <errno.h>
 #include <unistd.h>
 #include <linux/stddef.h>
-#include <sys/ptrace.h>
-#include <asm/ptrace.h>
+#include "ptrace_user.h"
+/* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
 #include <asm/user.h>
 #include "kern_util.h"
 #include "sysdep/thread.h"
@@ -52,7 +52,7 @@
 	nregs = sizeof(dummy->u_debugreg)/sizeof(dummy->u_debugreg[0]);
 	for(i = 0; i < nregs; i++){
 		if((i == 4) || (i == 5)) continue;
-		if(ptrace(PTRACE_POKEUSER, pid, &dummy->u_debugreg[i],
+		if(ptrace(PTRACE_POKEUSR, pid, &dummy->u_debugreg[i],
 			  regs[i]) < 0)
 			printk("write_debugregs - ptrace failed on "
 			       "register %d, value = 0x%x, errno = %d\n", i,
@@ -68,7 +68,7 @@
 	dummy = NULL;
 	nregs = sizeof(dummy->u_debugreg)/sizeof(dummy->u_debugreg[0]);
 	for(i = 0; i < nregs; i++){
-		regs[i] = ptrace(PTRACE_PEEKUSER, pid,
+		regs[i] = ptrace(PTRACE_PEEKUSR, pid,
 				 &dummy->u_debugreg[i], 0);
 	}
 }
Index: linux-2.6.11/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-i386/signal.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/sys-i386/signal.c	2005-03-08 20:39:58.000000000 -0500
@@ -11,8 +11,8 @@
 #include "asm/unistd.h"
 #include "frame_kern.h"
 #include "signal_user.h"
-#include "ptrace_user.h"
 #include "sigcontext.h"
+#include "registers.h"
 #include "mode.h"
 
 #ifdef CONFIG_MODE_SKAS
@@ -51,7 +51,7 @@
 	regs->regs.skas.fault_type = FAULT_WRITE(sc.err);
 	regs->regs.skas.trap_type = sc.trapno;
 
-	err = ptrace_setfpregs(userspace_pid[0], fpregs);
+	err = restore_fp_registers(userspace_pid[0], fpregs);
 	if(err < 0){
 	  	printk("copy_sc_from_user_skas - PTRACE_SETFPREGS failed, "
 		       "errno = %d\n", err);
@@ -90,7 +90,7 @@
 	sc.err = TO_SC_ERR(fault_type);
 	sc.trapno = regs->regs.skas.trap_type;
 
-	err = ptrace_getfpregs(userspace_pid[0], fpregs);
+	err = save_fp_registers(userspace_pid[0], fpregs);
 	if(err < 0){
 	  	printk("copy_sc_to_user_skas - PTRACE_GETFPREGS failed, "
 		       "errno = %d\n", err);
Index: linux-2.6.11/arch/um/sys-ppc/ptrace_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-ppc/ptrace_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/sys-ppc/ptrace_user.c	2005-03-08 20:23:17.000000000 -0500
@@ -1,4 +1,3 @@
-#include <sys/ptrace.h>
 #include <errno.h>
 #include <asm/ptrace.h>
 #include "sysdep/ptrace.h"
@@ -8,7 +7,7 @@
     int i;
     for (i=0; i < sizeof(struct sys_pt_regs)/sizeof(PPC_REG); ++i) {
 	errno = 0;
-	regs_out->regs[i] = ptrace(PTRACE_PEEKUSER, pid, i*4, 0);
+	regs_out->regs[i] = ptrace(PTRACE_PEEKUSR, pid, i*4, 0);
 	if (errno) {
 	    return -errno;
 	}
@@ -21,7 +20,7 @@
     int i;
     for (i=0; i < sizeof(struct sys_pt_regs)/sizeof(PPC_REG); ++i) {
 	if (i != 34 /* FIXME: PT_ORIG_R3 */ && i <= PT_MQ) {
-	    if (ptrace(PTRACE_POKEUSER, pid, i*4, regs_in->regs[i]) < 0) {
+	    if (ptrace(PTRACE_POKEUSR, pid, i*4, regs_in->regs[i]) < 0) {
 		return -errno;
 	    }
 	}
Index: linux-2.6.11/arch/um/sys-x86_64/ptrace_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/sys-x86_64/ptrace_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/sys-x86_64/ptrace_user.c	2005-03-08 20:23:17.000000000 -0500
@@ -6,9 +6,7 @@
 
 #include <stddef.h>
 #include <errno.h>
-#define __FRAME_OFFSETS
-#include <sys/ptrace.h>
-#include <asm/ptrace.h>
+#include "ptrace_user.h"
 #include "user.h"
 #include "kern_constants.h"
 
@@ -42,12 +40,12 @@
 void arch_leave_kernel(void *task, int pid)
 {
 #ifdef UM_USER_CS
-        if(ptrace(PTRACE_POKEUSER, pid, CS, UM_USER_CS) < 0)
+        if(ptrace(PTRACE_POKEUSR, pid, CS, UM_USER_CS) < 0)
                 printk("POKEUSR CS failed");
 #endif
 
-        if(ptrace(PTRACE_POKEUSER, pid, DS, __USER_DS) < 0)
+        if(ptrace(PTRACE_POKEUSR, pid, DS, __USER_DS) < 0)
                 printk("POKEUSR DS failed");
-        if(ptrace(PTRACE_POKEUSER, pid, ES, __USER_DS) < 0)
+        if(ptrace(PTRACE_POKEUSR, pid, ES, __USER_DS) < 0)
                 printk("POKEUSR ES failed");
 }

