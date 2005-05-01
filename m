Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVEAV3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVEAV3e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVEAV0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:26:44 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:28947 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262694AbVEAVSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:35 -0400
Message-Id: <200505012112.j41LCNoE016402@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 4/22] UML - Cross-build support : mk_ptregs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	mk_ptregs converted.  Nothing new here, it's the same situation
as with mk_user_constants.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -urN RC12-rc3-uml-user-constants/arch/um/Makefile RC12-rc3-uml-ptregs/arch/um/Makefile
--- RC12-rc3-uml-user-constants/arch/um/Makefile	Wed Apr 27 18:23:10 2005
+++ RC12-rc3-uml-ptregs/arch/um/Makefile	Wed Apr 27 18:22:38 2005
@@ -196,7 +196,7 @@
 $(ARCH_DIR)/util: scripts_basic $(SYS_DIR)/sc.h FORCE
 	$(Q)$(MAKE) $(build)=$@
 
-$(ARCH_DIR)/kernel/skas/util: scripts_basic FORCE
+$(ARCH_DIR)/kernel/skas/util: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 $(ARCH_DIR)/os-$(OS)/util: scripts_basic FORCE
diff -urN RC12-rc3-uml-user-constants/arch/um/kernel/skas/util/Makefile RC12-rc3-uml-ptregs/arch/um/kernel/skas/util/Makefile
--- RC12-rc3-uml-user-constants/arch/um/kernel/skas/util/Makefile	Fri Mar 11 15:54:46 2005
+++ RC12-rc3-uml-ptregs/arch/um/kernel/skas/util/Makefile	Wed Apr 27 17:07:25 2005
@@ -2,3 +2,4 @@
 always			:= $(hostprogs-y)
 
 mk_ptregs-objs := mk_ptregs-$(SUBARCH).o
+HOSTCFLAGS_mk_ptregs-$(SUBARCH).o := -I$(objtree)/arch/um
diff -urN RC12-rc3-uml-user-constants/arch/um/kernel/skas/util/mk_ptregs-i386.c RC12-rc3-uml-ptregs/arch/um/kernel/skas/util/mk_ptregs-i386.c
--- RC12-rc3-uml-user-constants/arch/um/kernel/skas/util/mk_ptregs-i386.c	Fri Mar 11 15:54:46 2005
+++ RC12-rc3-uml-ptregs/arch/um/kernel/skas/util/mk_ptregs-i386.c	Wed Apr 27 17:07:25 2005
@@ -1,8 +1,7 @@
 #include <stdio.h>
-#include <asm/ptrace.h>
-#include <asm/user.h>
+#include <user-offsets.h>
 
-#define PRINT_REG(name, val) printf("#define HOST_%s %d\n", (name), (val))
+#define SHOW(name) printf("#define %s %d\n", #name, name)
 
 int main(int argc, char **argv)
 {
@@ -12,28 +11,27 @@
 	printf("#ifndef __SKAS_PT_REGS_\n");
 	printf("#define __SKAS_PT_REGS_\n");
 	printf("\n");
-	printf("#define HOST_FRAME_SIZE %d\n", FRAME_SIZE);
-	printf("#define HOST_FP_SIZE %d\n",
-	       sizeof(struct user_i387_struct) / sizeof(unsigned long));
-	printf("#define HOST_XFP_SIZE %d\n",
-	       sizeof(struct user_fxsr_struct) / sizeof(unsigned long));
+	SHOW(HOST_FRAME_SIZE);
+	SHOW(HOST_FP_SIZE);
+	SHOW(HOST_XFP_SIZE);
+
+	SHOW(HOST_IP);
+	SHOW(HOST_SP);
+	SHOW(HOST_EFLAGS);
+	SHOW(HOST_EAX);
+	SHOW(HOST_EBX);
+	SHOW(HOST_ECX);
+	SHOW(HOST_EDX);
+	SHOW(HOST_ESI);
+	SHOW(HOST_EDI);
+	SHOW(HOST_EBP);
+	SHOW(HOST_CS);
+	SHOW(HOST_SS);
+	SHOW(HOST_DS);
+	SHOW(HOST_FS);
+	SHOW(HOST_ES);
+	SHOW(HOST_GS);
 
-	PRINT_REG("IP", EIP);
-	PRINT_REG("SP", UESP);
-	PRINT_REG("EFLAGS", EFL);
-	PRINT_REG("EAX", EAX);
-	PRINT_REG("EBX", EBX);
-	PRINT_REG("ECX", ECX);
-	PRINT_REG("EDX", EDX);
-	PRINT_REG("ESI", ESI);
-	PRINT_REG("EDI", EDI);
-	PRINT_REG("EBP", EBP);
-	PRINT_REG("CS", CS);
-	PRINT_REG("SS", SS);
-	PRINT_REG("DS", DS);
-	PRINT_REG("FS", FS);
-	PRINT_REG("ES", ES);
-	PRINT_REG("GS", GS);
 	printf("\n");
 	printf("#endif\n");
 	return(0);
diff -urN RC12-rc3-uml-user-constants/arch/um/kernel/skas/util/mk_ptregs-x86_64.c RC12-rc3-uml-ptregs/arch/um/kernel/skas/util/mk_ptregs-x86_64.c
--- RC12-rc3-uml-user-constants/arch/um/kernel/skas/util/mk_ptregs-x86_64.c	Fri Mar 11 15:54:46 2005
+++ RC12-rc3-uml-ptregs/arch/um/kernel/skas/util/mk_ptregs-x86_64.c	Wed Apr 27 17:07:25 2005
@@ -5,11 +5,10 @@
  */
 
 #include <stdio.h>
-#define __FRAME_OFFSETS
-#include <asm/ptrace.h>
+#include <user-offsets.h>
 
-#define PRINT_REG(name, val) \
-	printf("#define HOST_%s (%d / sizeof(unsigned long))\n", (name), (val))
+#define SHOW(name) \
+	printf("#define %s (%d / sizeof(unsigned long))\n", #name, name)
 
 int main(int argc, char **argv)
 {
@@ -18,36 +17,35 @@
 	printf("\n");
 	printf("#ifndef __SKAS_PT_REGS_\n");
 	printf("#define __SKAS_PT_REGS_\n");
-	printf("#define HOST_FRAME_SIZE (%d / sizeof(unsigned long))\n",
-	       FRAME_SIZE);
-	PRINT_REG("RBX", RBX);
-	PRINT_REG("RCX", RCX);
-	PRINT_REG("RDI", RDI);
-	PRINT_REG("RSI", RSI);
-	PRINT_REG("RDX", RDX);
-	PRINT_REG("RBP", RBP);
-	PRINT_REG("RAX", RAX);
-	PRINT_REG("R8", R8);
-	PRINT_REG("R9", R9);
-	PRINT_REG("R10", R10);
-	PRINT_REG("R11", R11);
-	PRINT_REG("R12", R12);
-	PRINT_REG("R13", R13);
-	PRINT_REG("R14", R14);
-	PRINT_REG("R15", R15);
-	PRINT_REG("ORIG_RAX", ORIG_RAX);
-	PRINT_REG("CS", CS);
-	PRINT_REG("SS", SS);
-	PRINT_REG("EFLAGS", EFLAGS);
+	SHOW(HOST_FRAME_SIZE);
+	SHOW(HOST_RBX);
+	SHOW(HOST_RCX);
+	SHOW(HOST_RDI);
+	SHOW(HOST_RSI);
+	SHOW(HOST_RDX);
+	SHOW(HOST_RBP);
+	SHOW(HOST_RAX);
+	SHOW(HOST_R8);
+	SHOW(HOST_R9);
+	SHOW(HOST_R10);
+	SHOW(HOST_R11);
+	SHOW(HOST_R12);
+	SHOW(HOST_R13);
+	SHOW(HOST_R14);
+	SHOW(HOST_R15);
+	SHOW(HOST_ORIG_RAX);
+	SHOW(HOST_CS);
+	SHOW(HOST_SS);
+	SHOW(HOST_EFLAGS);
 #if 0
-	PRINT_REG("FS", FS);
-	PRINT_REG("GS", GS);
-	PRINT_REG("DS", DS);
-	PRINT_REG("ES", ES);
+	SHOW(HOST_FS);
+	SHOW(HOST_GS);
+	SHOW(HOST_DS);
+	SHOW(HOST_ES);
 #endif
 
-	PRINT_REG("IP", RIP);
-	PRINT_REG("SP", RSP);
+	SHOW(HOST_IP);
+	SHOW(HOST_SP);
 	printf("#define HOST_FP_SIZE 0\n");
 	printf("#define HOST_XFP_SIZE 0\n");
 	printf("\n");

