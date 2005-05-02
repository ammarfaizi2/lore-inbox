Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVEBPvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVEBPvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 11:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVEBPvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 11:51:51 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:30980 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261341AbVEBPvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 11:51:39 -0400
Message-Id: <200505021450.j42EovMx004248@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 4.5/22] UML - Cross-build support : mk_sc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 May 2005 10:50:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	Ditto for mk_sc

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -urN RC12-rc3-uml-ptregs/arch/um/Makefile-i386 RC12-rc3-uml-sc/arch/um/Makefile-i386
--- RC12-rc3-uml-ptregs/arch/um/Makefile-i386	Wed Apr 27 18:22:38 2005
+++ RC12-rc3-uml-sc/arch/um/Makefile-i386	Wed Apr 27 18:22:28 2005
@@ -32,7 +32,7 @@
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
 	$(call filechk,gen_header)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts_basic FORCE
+$(SYS_UTIL_DIR)/mk_sc: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 $(SYS_UTIL_DIR)/mk_thread: scripts_basic $(ARCH_SYMLINKS) $(GEN_HEADERS) FORCE
diff -urN RC12-rc3-uml-ptregs/arch/um/Makefile-x86_64 RC12-rc3-uml-sc/arch/um/Makefile-x86_64
--- RC12-rc3-uml-ptregs/arch/um/Makefile-x86_64	Wed Apr 27 18:22:38 2005
+++ RC12-rc3-uml-sc/arch/um/Makefile-x86_64	Wed Apr 27 18:22:28 2005
@@ -23,7 +23,7 @@
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread
 	$(call filechk,gen_header)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts_basic FORCE
+$(SYS_UTIL_DIR)/mk_sc: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 $(SYS_UTIL_DIR)/mk_thread: scripts_basic $(ARCH_SYMLINKS) $(GEN_HEADERS) FORCE
diff -urN RC12-rc3-uml-ptregs/arch/um/sys-i386/util/Makefile RC12-rc3-uml-sc/arch/um/sys-i386/util/Makefile
--- RC12-rc3-uml-ptregs/arch/um/sys-i386/util/Makefile	Sat Oct 16 09:05:21 2004
+++ RC12-rc3-uml-sc/arch/um/sys-i386/util/Makefile	Wed Apr 27 17:07:26 2005
@@ -6,3 +6,4 @@
 
 HOSTCFLAGS_mk_thread_kern.o	:= $(CFLAGS) $(CPPFLAGS)
 HOSTCFLAGS_mk_thread_user.o	:= $(USER_CFLAGS)
+HOSTCFLAGS_mk_sc.o := -I$(objtree)/arch/um
diff -urN RC12-rc3-uml-ptregs/arch/um/sys-i386/util/mk_sc.c RC12-rc3-uml-sc/arch/um/sys-i386/util/mk_sc.c
--- RC12-rc3-uml-ptregs/arch/um/sys-i386/util/mk_sc.c	Wed Aug 25 12:32:51 2004
+++ RC12-rc3-uml-sc/arch/um/sys-i386/util/mk_sc.c	Wed Apr 27 17:07:26 2005
@@ -1,52 +1,51 @@
 #include <stdio.h>
-#include <signal.h>
-#include <linux/stddef.h>
+#include <user-offsets.h>
 
 #define SC_OFFSET(name, field) \
-  printf("#define " name "(sc) *((unsigned long *) &(((char *) (sc))[%d]))\n",\
-	 offsetof(struct sigcontext, field))
+  printf("#define " #name "(sc) *((unsigned long *) &(((char *) (sc))[%d]))\n",\
+	 name)
 
 #define SC_FP_OFFSET(name, field) \
-  printf("#define " name \
+  printf("#define " #name \
 	 "(sc) *((unsigned long *) &(((char *) (SC_FPSTATE(sc)))[%d]))\n",\
-	 offsetof(struct _fpstate, field))
+	 name)
 
 #define SC_FP_OFFSET_PTR(name, field, type) \
-  printf("#define " name \
+  printf("#define " #name \
 	 "(sc) ((" type " *) &(((char *) (SC_FPSTATE(sc)))[%d]))\n",\
-	 offsetof(struct _fpstate, field))
+	 name)
 
 int main(int argc, char **argv)
 {
-  SC_OFFSET("SC_IP", eip);
-  SC_OFFSET("SC_SP", esp);
-  SC_OFFSET("SC_FS", fs);
-  SC_OFFSET("SC_GS", gs);
-  SC_OFFSET("SC_DS", ds);
-  SC_OFFSET("SC_ES", es);
-  SC_OFFSET("SC_SS", ss);
-  SC_OFFSET("SC_CS", cs);
-  SC_OFFSET("SC_EFLAGS", eflags);
-  SC_OFFSET("SC_EAX", eax);
-  SC_OFFSET("SC_EBX", ebx);
-  SC_OFFSET("SC_ECX", ecx);
-  SC_OFFSET("SC_EDX", edx);
-  SC_OFFSET("SC_EDI", edi);
-  SC_OFFSET("SC_ESI", esi);
-  SC_OFFSET("SC_EBP", ebp);
-  SC_OFFSET("SC_TRAPNO", trapno);
-  SC_OFFSET("SC_ERR", err);
-  SC_OFFSET("SC_CR2", cr2);
-  SC_OFFSET("SC_FPSTATE", fpstate);
-  SC_OFFSET("SC_SIGMASK", oldmask);
-  SC_FP_OFFSET("SC_FP_CW", cw);
-  SC_FP_OFFSET("SC_FP_SW", sw);
-  SC_FP_OFFSET("SC_FP_TAG", tag);
-  SC_FP_OFFSET("SC_FP_IPOFF", ipoff);
-  SC_FP_OFFSET("SC_FP_CSSEL", cssel);
-  SC_FP_OFFSET("SC_FP_DATAOFF", dataoff);
-  SC_FP_OFFSET("SC_FP_DATASEL", datasel);
-  SC_FP_OFFSET_PTR("SC_FP_ST", _st, "struct _fpstate");
-  SC_FP_OFFSET_PTR("SC_FXSR_ENV", _fxsr_env, "void");
+  SC_OFFSET(SC_IP, eip);
+  SC_OFFSET(SC_SP, esp);
+  SC_OFFSET(SC_FS, fs);
+  SC_OFFSET(SC_GS, gs);
+  SC_OFFSET(SC_DS, ds);
+  SC_OFFSET(SC_ES, es);
+  SC_OFFSET(SC_SS, ss);
+  SC_OFFSET(SC_CS, cs);
+  SC_OFFSET(SC_EFLAGS, eflags);
+  SC_OFFSET(SC_EAX, eax);
+  SC_OFFSET(SC_EBX, ebx);
+  SC_OFFSET(SC_ECX, ecx);
+  SC_OFFSET(SC_EDX, edx);
+  SC_OFFSET(SC_EDI, edi);
+  SC_OFFSET(SC_ESI, esi);
+  SC_OFFSET(SC_EBP, ebp);
+  SC_OFFSET(SC_TRAPNO, trapno);
+  SC_OFFSET(SC_ERR, err);
+  SC_OFFSET(SC_CR2, cr2);
+  SC_OFFSET(SC_FPSTATE, fpstate);
+  SC_OFFSET(SC_SIGMASK, oldmask);
+  SC_FP_OFFSET(SC_FP_CW, cw);
+  SC_FP_OFFSET(SC_FP_SW, sw);
+  SC_FP_OFFSET(SC_FP_TAG, tag);
+  SC_FP_OFFSET(SC_FP_IPOFF, ipoff);
+  SC_FP_OFFSET(SC_FP_CSSEL, cssel);
+  SC_FP_OFFSET(SC_FP_DATAOFF, dataoff);
+  SC_FP_OFFSET(SC_FP_DATASEL, datasel);
+  SC_FP_OFFSET_PTR(SC_FP_ST, _st, "struct _fpstate");
+  SC_FP_OFFSET_PTR(SC_FXSR_ENV, _fxsr_env, "void");
   return(0);
 }
diff -urN RC12-rc3-uml-ptregs/arch/um/sys-x86_64/util/Makefile RC12-rc3-uml-sc/arch/um/sys-x86_64/util/Makefile
--- RC12-rc3-uml-ptregs/arch/um/sys-x86_64/util/Makefile	Fri Mar 11 15:54:46 2005
+++ RC12-rc3-uml-sc/arch/um/sys-x86_64/util/Makefile	Wed Apr 27 17:07:26 2005
@@ -8,3 +8,4 @@
 
 HOSTCFLAGS_mk_thread_kern.o	:= $(CFLAGS) $(CPPFLAGS)
 HOSTCFLAGS_mk_thread_user.o	:= $(USER_CFLAGS)
+HOSTCFLAGS_mk_sc.o := -I$(objtree)/arch/um
diff -urN RC12-rc3-uml-ptregs/arch/um/sys-x86_64/util/mk_sc.c RC12-rc3-uml-sc/arch/um/sys-x86_64/util/mk_sc.c
--- RC12-rc3-uml-ptregs/arch/um/sys-x86_64/util/mk_sc.c	Fri Mar 11 15:54:46 2005
+++ RC12-rc3-uml-sc/arch/um/sys-x86_64/util/mk_sc.c	Wed Apr 27 17:07:26 2005
@@ -3,56 +3,45 @@
  */
 
 #include <stdio.h>
-#include <signal.h>
-#include <linux/stddef.h>
+#include <user-offsets.h>
 
-#define SC_OFFSET(name, field) \
-  printf("#define " name \
-	 "(sc) *((unsigned long *) &(((char *) (sc))[%ld]))\n",\
-	 offsetof(struct sigcontext, field))
-
-#define SC_FP_OFFSET(name, field) \
-  printf("#define " name \
-	 "(sc) *((unsigned long *) &(((char *) (SC_FPSTATE(sc)))[%ld]))\n",\
-	 offsetof(struct _fpstate, field))
-
-#define SC_FP_OFFSET_PTR(name, field, type) \
-  printf("#define " name \
-	 "(sc) ((" type " *) &(((char *) (SC_FPSTATE(sc)))[%d]))\n",\
-	 offsetof(struct _fpstate, field))
+#define SC_OFFSET(name) \
+  printf("#define " #name \
+	 "(sc) *((unsigned long *) &(((char *) (sc))[%d]))\n",\
+	 name)
 
 int main(int argc, char **argv)
 {
-  SC_OFFSET("SC_RBX", rbx);
-  SC_OFFSET("SC_RCX", rcx);
-  SC_OFFSET("SC_RDX", rdx);
-  SC_OFFSET("SC_RSI", rsi);
-  SC_OFFSET("SC_RDI", rdi);
-  SC_OFFSET("SC_RBP", rbp);
-  SC_OFFSET("SC_RAX", rax);
-  SC_OFFSET("SC_R8", r8);
-  SC_OFFSET("SC_R9", r9);
-  SC_OFFSET("SC_R10", r10);
-  SC_OFFSET("SC_R11", r11);
-  SC_OFFSET("SC_R12", r12);
-  SC_OFFSET("SC_R13", r13);
-  SC_OFFSET("SC_R14", r14);
-  SC_OFFSET("SC_R15", r15);
-  SC_OFFSET("SC_IP", rip);
-  SC_OFFSET("SC_SP", rsp);
-  SC_OFFSET("SC_CR2", cr2);
-  SC_OFFSET("SC_ERR", err);
-  SC_OFFSET("SC_TRAPNO", trapno);
-  SC_OFFSET("SC_CS", cs);
-  SC_OFFSET("SC_FS", fs);
-  SC_OFFSET("SC_GS", gs);
-  SC_OFFSET("SC_EFLAGS", eflags);
-  SC_OFFSET("SC_SIGMASK", oldmask);
+  SC_OFFSET(SC_RBX);
+  SC_OFFSET(SC_RCX);
+  SC_OFFSET(SC_RDX);
+  SC_OFFSET(SC_RSI);
+  SC_OFFSET(SC_RDI);
+  SC_OFFSET(SC_RBP);
+  SC_OFFSET(SC_RAX);
+  SC_OFFSET(SC_R8);
+  SC_OFFSET(SC_R9);
+  SC_OFFSET(SC_R10);
+  SC_OFFSET(SC_R11);
+  SC_OFFSET(SC_R12);
+  SC_OFFSET(SC_R13);
+  SC_OFFSET(SC_R14);
+  SC_OFFSET(SC_R15);
+  SC_OFFSET(SC_IP);
+  SC_OFFSET(SC_SP);
+  SC_OFFSET(SC_CR2);
+  SC_OFFSET(SC_ERR);
+  SC_OFFSET(SC_TRAPNO);
+  SC_OFFSET(SC_CS);
+  SC_OFFSET(SC_FS);
+  SC_OFFSET(SC_GS);
+  SC_OFFSET(SC_EFLAGS);
+  SC_OFFSET(SC_SIGMASK);
 #if 0
-  SC_OFFSET("SC_ORIG_RAX", orig_rax);
-  SC_OFFSET("SC_DS", ds);
-  SC_OFFSET("SC_ES", es);
-  SC_OFFSET("SC_SS", ss);
+  SC_OFFSET(SC_ORIG_RAX);
+  SC_OFFSET(SC_DS);
+  SC_OFFSET(SC_ES);
+  SC_OFFSET(SC_SS);
 #endif
   return(0);
 }

