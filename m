Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVEAVdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVEAVdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVEAVbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:31:37 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:31507 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262699AbVEAVSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:39 -0400
Message-Id: <200505012112.j41LCKN5016397@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 3/22] UML - Start cross-build support : mk_user_constants
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	Beginning of cross-build fixes.  Instead of expecting that
mk_user_constants (compiled and executed on the build box) will see
the sizeof, etc. for target box, we do what every architecture already
does for asm-offsets.  Namely, have user-offsets.c compiled *for* *target*
into user-offsets.s and sed it into the header with relevant constants.
We don't need to reinvent any wheels - all tools are already there.

	This patch deals with mk_user_constants.  It doesn't assume any
relationship between target and build environment anymore - we pick all
defines we need from user-offsets.h.  Later patches will deal with the
rest of mk_... helpers in the same way.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -urN RC12-rc3-uml-os/arch/um/Makefile RC12-rc3-uml-user-constants/arch/um/Makefile
--- RC12-rc3-uml-os/arch/um/Makefile	Wed Apr 27 17:07:21 2005
+++ RC12-rc3-uml-user-constants/arch/um/Makefile	Wed Apr 27 18:23:10 2005
@@ -166,6 +166,14 @@
 $(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
+$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
+	$(CC) $(USER_CFLAGS) -S -o $@ $<
+
+$(ARCH_DIR)/user-offsets.h: $(ARCH_DIR)/user-offsets.s
+	$(call filechk,gen-asm-offsets)
+
+CLEAN_FILES += $(ARCH_DIR)/user-offsets.s  $(ARCH_DIR)/user-offsets.h 
+
 $(ARCH_DIR)/include/task.h: $(ARCH_DIR)/util/mk_task
 	$(call filechk,gen_header)
 
diff -urN RC12-rc3-uml-os/arch/um/os-Linux/util/Makefile RC12-rc3-uml-user-constants/arch/um/os-Linux/util/Makefile
--- RC12-rc3-uml-os/arch/um/os-Linux/util/Makefile	Wed Apr 20 21:25:30 2005
+++ RC12-rc3-uml-user-constants/arch/um/os-Linux/util/Makefile	Wed Apr 27 17:07:24 2005
@@ -1,4 +1,4 @@
 hostprogs-y		:= mk_user_constants
 always			:= $(hostprogs-y)
 
-mk_user_constants-objs	:= mk_user_constants.o
+HOSTCFLAGS_mk_user_constants.o := -I$(objtree)/arch/um
diff -urN RC12-rc3-uml-os/arch/um/os-Linux/util/mk_user_constants.c RC12-rc3-uml-user-constants/arch/um/os-Linux/util/mk_user_constants.c
--- RC12-rc3-uml-os/arch/um/os-Linux/util/mk_user_constants.c	Wed Apr 20 21:25:30 2005
+++ RC12-rc3-uml-user-constants/arch/um/os-Linux/util/mk_user_constants.c	Wed Apr 27 17:07:24 2005
@@ -1,11 +1,5 @@
 #include <stdio.h>
-#include <asm/types.h>
-/* For some reason, x86_64 nowhere defines u64 and u32, even though they're
- * used throughout the headers.
- */
-typedef __u64 u64;
-typedef __u32 u32;
-#include <asm/user.h>
+#include <user-offsets.h>
 
 int main(int argc, char **argv)
 {
@@ -20,7 +14,7 @@
    * x86_64 (216 vs 168 bytes).  user_regs_struct is the correct size on
    * both x86_64 and i386.
    */
-  printf("#define UM_FRAME_SIZE %d\n", (int) sizeof(struct user_regs_struct));
+  printf("#define UM_FRAME_SIZE %d\n", __UM_FRAME_SIZE);
 
   printf("\n");
   printf("#endif\n");
diff -urN RC12-rc3-uml-os/arch/um/sys-i386/user-offsets.c RC12-rc3-uml-user-constants/arch/um/sys-i386/user-offsets.c
--- RC12-rc3-uml-os/arch/um/sys-i386/user-offsets.c	Wed Dec 31 19:00:00 1969
+++ RC12-rc3-uml-user-constants/arch/um/sys-i386/user-offsets.c	Wed Apr 27 17:07:24 2005
@@ -0,0 +1,69 @@
+#include <stdio.h>
+#include <signal.h>
+#include <asm/ptrace.h>
+#include <asm/user.h>
+#include <linux/stddef.h>
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+	OFFSET(SC_IP, sigcontext, eip);
+	OFFSET(SC_SP, sigcontext, esp);
+	OFFSET(SC_FS, sigcontext, fs);
+	OFFSET(SC_GS, sigcontext, gs);
+	OFFSET(SC_DS, sigcontext, ds);
+	OFFSET(SC_ES, sigcontext, es);
+	OFFSET(SC_SS, sigcontext, ss);
+	OFFSET(SC_CS, sigcontext, cs);
+	OFFSET(SC_EFLAGS, sigcontext, eflags);
+	OFFSET(SC_EAX, sigcontext, eax);
+	OFFSET(SC_EBX, sigcontext, ebx);
+	OFFSET(SC_ECX, sigcontext, ecx);
+	OFFSET(SC_EDX, sigcontext, edx);
+	OFFSET(SC_EDI, sigcontext, edi);
+	OFFSET(SC_ESI, sigcontext, esi);
+	OFFSET(SC_EBP, sigcontext, ebp);
+	OFFSET(SC_TRAPNO, sigcontext, trapno);
+	OFFSET(SC_ERR, sigcontext, err);
+	OFFSET(SC_CR2, sigcontext, cr2);
+	OFFSET(SC_FPSTATE, sigcontext, fpstate);
+	OFFSET(SC_SIGMASK, sigcontext, oldmask);
+	OFFSET(SC_FP_CW, _fpstate, cw);
+	OFFSET(SC_FP_SW, _fpstate, sw);
+	OFFSET(SC_FP_TAG, _fpstate, tag);
+	OFFSET(SC_FP_IPOFF, _fpstate, ipoff);
+	OFFSET(SC_FP_CSSEL, _fpstate, cssel);
+	OFFSET(SC_FP_DATAOFF, _fpstate, dataoff);
+	OFFSET(SC_FP_DATASEL, _fpstate, datasel);
+	OFFSET(SC_FP_ST, _fpstate, _st);
+	OFFSET(SC_FXSR_ENV, _fpstate, _fxsr_env);
+
+	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_FP_SIZE,
+		sizeof(struct user_i387_struct) / sizeof(unsigned long));
+	DEFINE(HOST_XFP_SIZE,
+	       sizeof(struct user_fxsr_struct) / sizeof(unsigned long));
+
+	DEFINE(HOST_IP, EIP);
+	DEFINE(HOST_SP, UESP);
+	DEFINE(HOST_EFLAGS, EFL);
+	DEFINE(HOST_EAX, EAX);
+	DEFINE(HOST_EBX, EBX);
+	DEFINE(HOST_ECX, ECX);
+	DEFINE(HOST_EDX, EDX);
+	DEFINE(HOST_ESI, ESI);
+	DEFINE(HOST_EDI, EDI);
+	DEFINE(HOST_EBP, EBP);
+	DEFINE(HOST_CS, CS);
+	DEFINE(HOST_SS, SS);
+	DEFINE(HOST_DS, DS);
+	DEFINE(HOST_FS, FS);
+	DEFINE(HOST_ES, ES);
+	DEFINE(HOST_GS, GS);
+	DEFINE(__UM_FRAME_SIZE, sizeof(struct user_regs_struct));
+}
diff -urN RC12-rc3-uml-os/arch/um/sys-x86_64/user-offsets.c RC12-rc3-uml-user-constants/arch/um/sys-x86_64/user-offsets.c
--- RC12-rc3-uml-os/arch/um/sys-x86_64/user-offsets.c	Wed Dec 31 19:00:00 1969
+++ RC12-rc3-uml-user-constants/arch/um/sys-x86_64/user-offsets.c	Wed Apr 27 17:07:24 2005
@@ -0,0 +1,78 @@
+#include <stdio.h>
+#include <stddef.h>
+#include <signal.h>
+#define __FRAME_OFFSETS
+#include <asm/ptrace.h>
+#include <asm/user.h>
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+	OFFSET(SC_RBX, sigcontext, rbx);
+	OFFSET(SC_RCX, sigcontext, rcx);
+	OFFSET(SC_RDX, sigcontext, rdx);
+	OFFSET(SC_RSI, sigcontext, rsi);
+	OFFSET(SC_RDI, sigcontext, rdi);
+	OFFSET(SC_RBP, sigcontext, rbp);
+	OFFSET(SC_RAX, sigcontext, rax);
+	OFFSET(SC_R8, sigcontext, r8);
+	OFFSET(SC_R9, sigcontext, r9);
+	OFFSET(SC_R10, sigcontext, r10);
+	OFFSET(SC_R11, sigcontext, r11);
+	OFFSET(SC_R12, sigcontext, r12);
+	OFFSET(SC_R13, sigcontext, r13);
+	OFFSET(SC_R14, sigcontext, r14);
+	OFFSET(SC_R15, sigcontext, r15);
+	OFFSET(SC_IP, sigcontext, rip);
+	OFFSET(SC_SP, sigcontext, rsp);
+	OFFSET(SC_CR2, sigcontext, cr2);
+	OFFSET(SC_ERR, sigcontext, err);
+	OFFSET(SC_TRAPNO, sigcontext, trapno);
+	OFFSET(SC_CS, sigcontext, cs);
+	OFFSET(SC_FS, sigcontext, fs);
+	OFFSET(SC_GS, sigcontext, gs);
+	OFFSET(SC_EFLAGS, sigcontext, eflags);
+	OFFSET(SC_SIGMASK, sigcontext, oldmask);
+#if 0
+	OFFSET(SC_ORIG_RAX, sigcontext, orig_rax);
+	OFFSET(SC_DS, sigcontext, ds);
+	OFFSET(SC_ES, sigcontext, es);
+	OFFSET(SC_SS, sigcontext, ss);
+#endif
+
+	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_RBX, RBX);
+	DEFINE(HOST_RCX, RCX);
+	DEFINE(HOST_RDI, RDI);
+	DEFINE(HOST_RSI, RSI);
+	DEFINE(HOST_RDX, RDX);
+	DEFINE(HOST_RBP, RBP);
+	DEFINE(HOST_RAX, RAX);
+	DEFINE(HOST_R8, R8);
+	DEFINE(HOST_R9, R9);
+	DEFINE(HOST_R10, R10);
+	DEFINE(HOST_R11, R11);
+	DEFINE(HOST_R12, R12);
+	DEFINE(HOST_R13, R13);
+	DEFINE(HOST_R14, R14);
+	DEFINE(HOST_R15, R15);
+	DEFINE(HOST_ORIG_RAX, ORIG_RAX);
+	DEFINE(HOST_CS, CS);
+	DEFINE(HOST_SS, SS);
+	DEFINE(HOST_EFLAGS, EFLAGS);
+#if 0
+	DEFINE(HOST_FS, FS);
+	DEFINE(HOST_GS, GS);
+	DEFINE(HOST_DS, DS);
+	DEFINE(HOST_ES, ES);
+#endif
+
+	DEFINE(HOST_IP, RIP);
+	DEFINE(HOST_SP, RSP);
+	DEFINE(__UM_FRAME_SIZE, sizeof(struct user_regs_struct));
+}

