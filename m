Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVC3TAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVC3TAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVC3Sya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:54:30 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:49323 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262396AbVC3SvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:25 -0500
Subject: [patch 5/8] uml: fix "cond. expr. as lvalues" warning
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:33:55 +0200
Message-Id: <20050330173355.A8FE9EFEDA@zion>
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

Updated from last sent version to work also when only one mode (TT or SKAS) is
enabled.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/choose-mode.h          |   12 ++
 linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h   |   36 ++++----
 linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h |   58 +++++++-------
 3 files changed, 59 insertions(+), 47 deletions(-)

diff -puN arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues arch/um/include/choose-mode.h
--- linux-2.6.11/arch/um/include/choose-mode.h~uml-fix-cond-expr-as-lvalues	2005-03-27 20:55:12.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/choose-mode.h	2005-03-27 20:55:45.000000000 +0200
@@ -11,6 +11,14 @@
 #if defined(UML_CONFIG_MODE_TT) && defined(UML_CONFIG_MODE_SKAS)
 #define CHOOSE_MODE(tt, skas) (mode_tt ? (tt) : (skas))
 
+extern int mode_tt;
+
+static inline void *__choose_mode(void *tt, void *skas) {
+	return mode_tt ? tt : skas;
+}
+
+#define __CHOOSE_MODE(tt, skas) (*( (typeof(tt) *) __choose_mode(&(tt), &(skas))))
+
 #elif defined(UML_CONFIG_MODE_SKAS)
 #define CHOOSE_MODE(tt, skas) (skas)
 
@@ -21,6 +29,10 @@
 #define CHOOSE_MODE_PROC(tt, skas, args...) \
 	CHOOSE_MODE(tt(args), skas(args))
 
+#ifndef __CHOOSE_MODE
+#define __CHOOSE_MODE(tt, skas) CHOOSE_MODE(tt, skas)
+#endif
+
 #endif
 
 /*
diff -puN arch/um/include/sysdep-i386/ptrace.h~uml-fix-cond-expr-as-lvalues arch/um/include/sysdep-i386/ptrace.h
--- linux-2.6.11/arch/um/include/sysdep-i386/ptrace.h~uml-fix-cond-expr-as-lvalues	2005-03-27 20:55:12.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/sysdep-i386/ptrace.h	2005-03-27 20:55:12.000000000 +0200
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
--- linux-2.6.11/arch/um/include/sysdep-x86_64/ptrace.h~uml-fix-cond-expr-as-lvalues	2005-03-27 20:55:12.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/include/sysdep-x86_64/ptrace.h	2005-03-27 20:55:12.000000000 +0200
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
