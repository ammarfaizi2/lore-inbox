Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWIYSg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWIYSg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIYSgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:32 -0400
Received: from [198.99.130.12] ([198.99.130.12]:53908 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751453AbWIYSgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:03 -0400
Message-Id: <200609251834.k8PIYWLu005031@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/8] UML - Fix missing x86_64 register definitions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UML/x86_64 headers were missing ptrace support for some segment
registers.  The underlying problem was that the x86_64 kernel uses
user_regs_struct rather than the ptrace register definitions in
ptrace.  This patch switches UML/x86_64 to using user_regs_struct
for its definitions of the host's registers.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/ptrace.h	2006-09-22 11:36:43.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/ptrace.h	2006-09-22 13:19:12.000000000 -0400
@@ -50,6 +50,21 @@
 #define HOST_FS 25
 #define HOST_GS 26
 
+/* Also defined in asm/ptrace-x86_64.h, but not in libc headers.  So, these
+ * are already defined for kernel code, but not for userspace code.
+ */
+#ifndef FS_BASE
+/* These aren't defined in ptrace.h, but exist in struct user_regs_struct,
+ * which is what x86_64 ptrace actually uses.
+ */
+#define FS_BASE (HOST_FS_BASE * sizeof(long))
+#define GS_BASE (HOST_GS_BASE * sizeof(long))
+#define DS (HOST_DS * sizeof(long))
+#define ES (HOST_ES * sizeof(long))
+#define FS (HOST_FS * sizeof(long))
+#define GS (HOST_GS * sizeof(long))
+#endif
+
 #define REGS_FS_BASE(r) ((r)[HOST_FS_BASE])
 #define REGS_GS_BASE(r) ((r)[HOST_GS_BASE])
 #define REGS_DS(r) ((r)[HOST_DS])
@@ -89,9 +104,12 @@ union uml_pt_regs {
 #endif
 #ifdef UML_CONFIG_MODE_SKAS
 	struct skas_regs {
-		/* XXX */
-		unsigned long regs[27];
-		unsigned long fp[65];
+		/* x86_64 ptrace uses sizeof(user_regs_struct) as its register
+		 * file size, while i386 uses FRAME_SIZE.  Therefore, we need
+		 * to use UM_FRAME_SIZE here instead of HOST_FRAME_SIZE.
+		 */
+		unsigned long regs[UM_FRAME_SIZE];
+		unsigned long fp[HOST_FP_SIZE];
                 struct faultinfo faultinfo;
 		long syscall;
 		int is_user;
@@ -120,11 +138,16 @@ extern int mode_tt;
 #define UPT_R14(r) __CHOOSE_MODE(SC_R14(UPT_SC(r)), REGS_R14((r)->skas.regs))
 #define UPT_R15(r) __CHOOSE_MODE(SC_R15(UPT_SC(r)), REGS_R15((r)->skas.regs))
 #define UPT_CS(r) __CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_FS_BASE(r) \
+	__CHOOSE_MODE(SC_FS_BASE(UPT_SC(r)), REGS_FS_BASE((r)->skas.regs))
 #define UPT_FS(r) __CHOOSE_MODE(SC_FS(UPT_SC(r)), REGS_FS((r)->skas.regs))
+#define UPT_GS_BASE(r) \
+	__CHOOSE_MODE(SC_GS_BASE(UPT_SC(r)), REGS_GS_BASE((r)->skas.regs))
 #define UPT_GS(r) __CHOOSE_MODE(SC_GS(UPT_SC(r)), REGS_GS((r)->skas.regs))
 #define UPT_DS(r) __CHOOSE_MODE(SC_DS(UPT_SC(r)), REGS_DS((r)->skas.regs))
 #define UPT_ES(r) __CHOOSE_MODE(SC_ES(UPT_SC(r)), REGS_ES((r)->skas.regs))
 #define UPT_CS(r) __CHOOSE_MODE(SC_CS(UPT_SC(r)), REGS_CS((r)->skas.regs))
+#define UPT_SS(r) __CHOOSE_MODE(SC_SS(UPT_SC(r)), REGS_SS((r)->skas.regs))
 #define UPT_ORIG_RAX(r) \
 	__CHOOSE_MODE((r)->tt.orig_rax, REGS_ORIG_RAX((r)->skas.regs))
 
@@ -183,6 +206,13 @@ struct syscall_args {
                 case RBP: val = UPT_RBP(regs); break; \
                 case ORIG_RAX: val = UPT_ORIG_RAX(regs); break; \
                 case CS: val = UPT_CS(regs); break; \
+                case SS: val = UPT_SS(regs); break; \
+		case FS_BASE: val = UPT_FS_BASE(regs); break; \
+                case GS_BASE: val = UPT_GS_BASE(regs); break; \
+                case DS: val = UPT_DS(regs); break; \
+                case ES: val = UPT_ES(regs); break; \
+                case FS : val = UPT_FS (regs); break; \
+		case GS: val = UPT_GS(regs); break;	    \
                 case EFLAGS: val = UPT_EFLAGS(regs); break; \
                 default :  \
                         panic("Bad register in UPT_REG : %d\n", reg);  \
@@ -214,6 +244,13 @@ struct syscall_args {
                 case RBP: UPT_RBP(regs) = __upt_val; break; \
                 case ORIG_RAX: UPT_ORIG_RAX(regs) = __upt_val; break; \
                 case CS: UPT_CS(regs) = __upt_val; break; \
+                case SS: UPT_SS(regs) = __upt_val; break; \
+                case FS_BASE: UPT_FS_BASE(regs) = __upt_val; break; \
+                case GS_BASE: UPT_GS_BASE(regs) = __upt_val; break; \
+                case DS: UPT_DS(regs) = __upt_val; break; \
+                case ES: UPT_ES(regs) = __upt_val; break; \
+                case FS: UPT_FS(regs) = __upt_val; break; \
+                case GS: UPT_GS(regs) = __upt_val; break; \
                 case EFLAGS: UPT_EFLAGS(regs) = __upt_val; break; \
                 default :  \
                         panic("Bad register in UPT_SET : %d\n", reg);  \
Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/sc.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/sysdep-x86_64/sc.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/sc.h	2006-09-22 13:19:12.000000000 -0400
@@ -35,11 +35,11 @@
 #define SC_GS(sc) SC_OFFSET(sc, SC_GS)
 #define SC_EFLAGS(sc) SC_OFFSET(sc, SC_EFLAGS)
 #define SC_SIGMASK(sc) SC_OFFSET(sc, SC_SIGMASK)
+#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
 #if 0
 #define SC_ORIG_RAX(sc) SC_OFFSET(sc, SC_ORIG_RAX)
 #define SC_DS(sc) SC_OFFSET(sc, SC_DS)
 #define SC_ES(sc) SC_OFFSET(sc, SC_ES)
-#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
 #endif
 
 #endif
Index: linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-x86_64.h	2006-09-22 11:34:59.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h	2006-09-22 13:19:12.000000000 -0400
@@ -16,12 +16,15 @@
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_X86_64
 
+/* Also defined in sysdep/ptrace.h, so may already be defined. */
+#ifndef FS_BASE
 #define FS_BASE (21 * sizeof(unsigned long))
 #define GS_BASE (22 * sizeof(unsigned long))
 #define DS (23 * sizeof(unsigned long))
 #define ES (24 * sizeof(unsigned long))
 #define FS (25 * sizeof(unsigned long))
 #define GS (26 * sizeof(unsigned long))
+#endif
 
 #define PT_REGS_RBX(r) UPT_RBX(&(r)->regs)
 #define PT_REGS_RCX(r) UPT_RCX(&(r)->regs)

