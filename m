Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVCVSEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVCVSEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCVSDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:03:02 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:28348 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261504AbVCVR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:44 -0500
Subject: [patch 1/1] uml: fix "cond. expr. as lvalues" warning
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 16:51:42 +0100
Message-Id: <20050322155145.3632A647B@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Gcc 3.4.3 (and probably any 3.4) emits some "deprecation" warnings currently
about usages of CHOOSE_MODE, since the below syntax has been deprecated:

(a ? foo: bar) = foobar;
which often results from expansion of:
CHOOSE_MODE(foo, bar) = foobar;

So add an additional __CHOOSE_MODE syntax for users which need to get a
lvalue, which uses (a ? &foo : &bar) inside a function, casts the result to
the correct type and dereference the pointer, and use it where needed (i.e.
in <sysdep/ptrace.h>)

The patch builds and runs correctly (this has been tested on i386 only, not on
x86_64), and removes all the warnings.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/choose-mode.h          |    7 +
 linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h   |   36 ++++----
 linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h |   58 +++++++-------
 3 files changed, 54 insertions(+), 47 deletions(-)

diff -puN arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues arch/um/include/choose-mode.h
--- linux-2.6.11/arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues	2005-03-22 16:24:29.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/include/choose-mode.h	2005-03-22 16:24:29.000000000 +0100
@@ -21,6 +21,13 @@
 #define CHOOSE_MODE_PROC(tt, skas, args...) \
 	CHOOSE_MODE(tt(args), skas(args))
 
+extern int mode_tt;
+static inline void *__choose_mode(void *tt, void *skas) {
+	return mode_tt ? tt : skas;
+}
+
+#define __CHOOSE_MODE(tt, skas) (*( (typeof(tt) *) __choose_mode(&(tt), &(skas))))
+
 #endif
 
 /*
diff -puN arch/um/include/sysdep-i386/ptrace.h~uml-fix-cond-expr-as-lvalues arch/um/include/sysdep-i386/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-i386/ptrace.h~uml-fix-cond-expr-as-lvalues	2005-03-22 16:25:12.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h	2005-03-22 16:28:39.000000000 +0100
@@ -93,39 +93,39 @@ extern int mode_tt;
 
 #define UPT_SC(r) ((r)->tt.sc)
 #define UPT_IP(r) \
-	CHOOSE_MODE(SC_IP(UPT_SC(r)), REGS_IP((r)->skas.regs))
+	__CHOOSE_MODE(SC_IP(UPT_SC(r)), REGS_IP((r)->skas.regs))
 #define UPT_SP(r) \
-	CHOOSE_MODE(SC_SP(UPT_SC(r)), REGS_SP((r)->skas.regs))
+	__CHOOSE_MODE(SC_SP(UPT_SC(r)), REGS_SP((r)->skas.regs))
 #define UPT_EFLAGS(r) \
-	CHOOSE_MODE(SC_EFLAGS(UPT_SC(r)), REGS_EFLAGS((r)->skas.regs))
+	__CHOOSE_MODE(SC_EFLAGS(UPT_SC(r)), REGS_EFLAGS((r)->skas.regs))
 #define UPT_EAX(r) \
-	CHOOSE_MODE(SC_EAX(UPT_SC(r)), REGS_EAX((r)->skas.regs))
+	__CHOOSE_MODE(SC_EAX(UPT_SC(r)), REGS_EAX((r)->skas.regs))
 #define UPT_EBX(r) \
-	CHOOSE_MODE(SC_EBX(UPT_SC(r)), REGS_EBX((r)->skas.regs))
+	__CHOOSE_MODE(SC_EBX(UPT_SC(r)), REGS_EBX((r)->skas.regs))
 #define UPT_ECX(r) \
-	CHOOSE_MODE(SC_ECX(UPT_SC(r)), REGS_ECX((r)->skas.regs))
+	__CHOOSE_MODE(SC_ECX(UPT_SC(r)), REGS_ECX((r)->skas.regs))
 #define UPT_EDX(r) \
-	CHOOSE_MODE(SC_EDX(UPT_SC(r)), REGS_EDX((r)->skas.regs))
+	__CHOOSE_MODE(SC_EDX(UPT_SC(r)), REGS_EDX((r)->skas.regs))
 #define UPT_ESI(r) \
-	CHOOSE_MODE(SC_ESI(UPT_SC(r)), REGS_ESI((r)->skas.regs))
+	__CHOOSE_MODE(SC_ESI(UPT_SC(r)), REGS_ESI((r)->skas.regs))
 #define UPT_EDI(r) \
-	CHOOSE_MODE(SC_EDI(UPT_SC(r)), REGS_EDI((r)->skas.regs))
+	__CHOOSE_MODE(SC_EDI(UPT_SC(r)), REGS_EDI((r)->skas.regs))
 #define UPT_EBP(r) \
-	CHOOSE_MODE(SC_EBP(UPT_SC(r)), REGS_EBP((r)->skas.regs))
+	__CHOOSE_MODE(SC_EBP(UPT_SC(r)), REGS_EBP((r)->skas.regs))
 #define UPT_ORIG_EAX(r) \
-	CHOOSE_MODE((r)->tt.syscall, (r)->skas.syscall)
+	__CHOOSE_MODE((r)->tt.syscall, (r)->skas.syscall)
 #define UPT_CS(r) \
-	CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+	__CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
 #define UPT_SS(r) \
-	CHOOSE_MODE(SC_SS(UPT_SC(r)), REGS_SS((r)->skas.regs))
+	__CHOOSE_MODE(SC_SS(UPT_SC(r)), REGS_SS((r)->skas.regs))
 #define UPT_DS(r) \
-	CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
+	__CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
 #define UPT_ES(r) \
-	CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
+	__CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
 #define UPT_FS(r) \
-	CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
+	__CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
 #define UPT_GS(r) \
-	CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
+	__CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
 
 #define UPT_SYSCALL_ARG1(r) UPT_EBX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_ECX(r)
@@ -222,7 +222,7 @@ struct syscall_args {
                     REGS_SEGV_IS_FIXABLE(&r->skas))
 
 #define UPT_FAULT_ADDR(r) \
-	CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
+	__CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
 
 #define UPT_FAULT_WRITE(r) \
 	CHOOSE_MODE(SC_FAULT_WRITE(UPT_SC(r)), REGS_FAULT_WRITE(&r->skas))
diff -puN arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-cond-expr-as-lvalues arch/um/include/sysdep-x86_64/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-cond-expr-as-lvalues	2005-03-22 16:48:29.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h	2005-03-22 16:48:34.000000000 +0100
@@ -104,37 +104,37 @@ union uml_pt_regs {
 /* XXX */
 extern int mode_tt;
 
-#define UPT_RBX(r) CHOOSE_MODE(SC_RBX(UPT_SC(r)), REGS_RBX((r)->skas.regs))
-#define UPT_RCX(r) CHOOSE_MODE(SC_RCX(UPT_SC(r)), REGS_RCX((r)->skas.regs))
-#define UPT_RDX(r) CHOOSE_MODE(SC_RDX(UPT_SC(r)), REGS_RDX((r)->skas.regs))
-#define UPT_RSI(r) CHOOSE_MODE(SC_RSI(UPT_SC(r)), REGS_RSI((r)->skas.regs))
-#define UPT_RDI(r) CHOOSE_MODE(SC_RDI(UPT_SC(r)), REGS_RDI((r)->skas.regs))
-#define UPT_RBP(r) CHOOSE_MODE(SC_RBP(UPT_SC(r)), REGS_RBP((r)->skas.regs))
-#define UPT_RAX(r) CHOOSE_MODE(SC_RAX(UPT_SC(r)), REGS_RAX((r)->skas.regs))
-#define UPT_R8(r) CHOOSE_MODE(SC_R8(UPT_SC(r)), REGS_R8((r)->skas.regs))
-#define UPT_R9(r) CHOOSE_MODE(SC_R9(UPT_SC(r)), REGS_R9((r)->skas.regs))
-#define UPT_R10(r) CHOOSE_MODE(SC_R10(UPT_SC(r)), REGS_R10((r)->skas.regs))
-#define UPT_R11(r) CHOOSE_MODE(SC_R11(UPT_SC(r)), REGS_R11((r)->skas.regs))
-#define UPT_R12(r) CHOOSE_MODE(SC_R12(UPT_SC(r)), REGS_R12((r)->skas.regs))
-#define UPT_R13(r) CHOOSE_MODE(SC_R13(UPT_SC(r)), REGS_R13((r)->skas.regs))
-#define UPT_R14(r) CHOOSE_MODE(SC_R14(UPT_SC(r)), REGS_R14((r)->skas.regs))
-#define UPT_R15(r) CHOOSE_MODE(SC_R15(UPT_SC(r)), REGS_R15((r)->skas.regs))
-#define UPT_CS(r) CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
-#define UPT_FS(r) CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
-#define UPT_GS(r) CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
-#define UPT_DS(r) CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
-#define UPT_ES(r) CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
-#define UPT_CS(r) CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_RBX(r) __CHOOSE_MODE(SC_RBX(UPT_SC(r)), REGS_RBX((r)->skas.regs))
+#define UPT_RCX(r) __CHOOSE_MODE(SC_RCX(UPT_SC(r)), REGS_RCX((r)->skas.regs))
+#define UPT_RDX(r) __CHOOSE_MODE(SC_RDX(UPT_SC(r)), REGS_RDX((r)->skas.regs))
+#define UPT_RSI(r) __CHOOSE_MODE(SC_RSI(UPT_SC(r)), REGS_RSI((r)->skas.regs))
+#define UPT_RDI(r) __CHOOSE_MODE(SC_RDI(UPT_SC(r)), REGS_RDI((r)->skas.regs))
+#define UPT_RBP(r) __CHOOSE_MODE(SC_RBP(UPT_SC(r)), REGS_RBP((r)->skas.regs))
+#define UPT_RAX(r) __CHOOSE_MODE(SC_RAX(UPT_SC(r)), REGS_RAX((r)->skas.regs))
+#define UPT_R8(r) __CHOOSE_MODE(SC_R8(UPT_SC(r)), REGS_R8((r)->skas.regs))
+#define UPT_R9(r) __CHOOSE_MODE(SC_R9(UPT_SC(r)), REGS_R9((r)->skas.regs))
+#define UPT_R10(r) __CHOOSE_MODE(SC_R10(UPT_SC(r)), REGS_R10((r)->skas.regs))
+#define UPT_R11(r) __CHOOSE_MODE(SC_R11(UPT_SC(r)), REGS_R11((r)->skas.regs))
+#define UPT_R12(r) __CHOOSE_MODE(SC_R12(UPT_SC(r)), REGS_R12((r)->skas.regs))
+#define UPT_R13(r) __CHOOSE_MODE(SC_R13(UPT_SC(r)), REGS_R13((r)->skas.regs))
+#define UPT_R14(r) __CHOOSE_MODE(SC_R14(UPT_SC(r)), REGS_R14((r)->skas.regs))
+#define UPT_R15(r) __CHOOSE_MODE(SC_R15(UPT_SC(r)), REGS_R15((r)->skas.regs))
+#define UPT_CS(r) __CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_FS(r) __CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
+#define UPT_GS(r) __CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
+#define UPT_DS(r) __CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
+#define UPT_ES(r) __CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
+#define UPT_CS(r) __CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
 #define UPT_ORIG_RAX(r) \
-	CHOOSE_MODE((r)->tt.orig_rax, REGS_ORIG_RAX((r)->skas.regs))
+	__CHOOSE_MODE((r)->tt.orig_rax, REGS_ORIG_RAX((r)->skas.regs))
 
-#define UPT_IP(r) CHOOSE_MODE(SC_IP(UPT_SC(r)), REGS_IP((r)->skas.regs))
-#define UPT_SP(r) CHOOSE_MODE(SC_SP(UPT_SC(r)), REGS_SP((r)->skas.regs))
+#define UPT_IP(r) __CHOOSE_MODE(SC_IP(UPT_SC(r)), REGS_IP((r)->skas.regs))
+#define UPT_SP(r) __CHOOSE_MODE(SC_SP(UPT_SC(r)), REGS_SP((r)->skas.regs))
 
 #define UPT_EFLAGS(r) \
-	CHOOSE_MODE(SC_EFLAGS(UPT_SC(r)), REGS_EFLAGS((r)->skas.regs))
+	__CHOOSE_MODE(SC_EFLAGS(UPT_SC(r)), REGS_EFLAGS((r)->skas.regs))
 #define UPT_SC(r) ((r)->tt.sc)
-#define UPT_SYSCALL_NR(r) CHOOSE_MODE((r)->tt.syscall, (r)->skas.syscall)
+#define UPT_SYSCALL_NR(r) __CHOOSE_MODE((r)->tt.syscall, (r)->skas.syscall)
 
 extern int user_context(unsigned long sp);
 
@@ -242,13 +242,13 @@ struct syscall_args {
                     REGS_SEGV_IS_FIXABLE(&r->skas))
 
 #define UPT_FAULT_ADDR(r) \
-	CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
+	__CHOOSE_MODE(SC_FAULT_ADDR(UPT_SC(r)), REGS_FAULT_ADDR(&r->skas))
 
 #define UPT_FAULT_WRITE(r) \
 	CHOOSE_MODE(SC_FAULT_WRITE(UPT_SC(r)), REGS_FAULT_WRITE(&r->skas))
 
-#define UPT_TRAP(r) CHOOSE_MODE(SC_TRAP_TYPE(UPT_SC(r)), REGS_TRAP(&r->skas))
-#define UPT_ERR(r) CHOOSE_MODE(SC_FAULT_TYPE(UPT_SC(r)), REGS_ERR(&r->skas))
+#define UPT_TRAP(r) __CHOOSE_MODE(SC_TRAP_TYPE(UPT_SC(r)), REGS_TRAP(&r->skas))
+#define UPT_ERR(r) __CHOOSE_MODE(SC_FAULT_TYPE(UPT_SC(r)), REGS_ERR(&r->skas))
 
 #endif
 
_
