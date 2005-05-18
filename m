Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVERE0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVERE0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVERE03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:26:29 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17421 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262077AbVEREZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:25:21 -0400
Message-Id: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/9] UML - small fixes left over from rc4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some changes that I sent in didn't make 2.6.12-rc4 for some reason.  This
adds them back.  We have 
	an x86_64 definition of TOP_ADDR
	a reimplementation of the x86_64 csum_partial_copy_from_user
	some syntax fixes in arch/um/kernel/ptrace.c
	removal of a CFLAGS definition in the x86_64 Makefile
	some include changes in the x86_64 ptrace.c and user-offsets.h
	a syntax fix in elf-x86_64.h
Also moved an include in the i386 and x86_64 Makefiles to make the symlinks 
work, and some small fixes from Al Viro.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/Kconfig_x86_64
===================================================================
--- linux-2.6.12-rc.orig/arch/um/Kconfig_x86_64	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/Kconfig_x86_64	2005-05-17 16:37:06.000000000 -0400
@@ -6,6 +6,10 @@ config 64BIT
 	bool
 	default y
 
+config TOP_ADDR
+ 	hex
+	default 0x60000000
+
 config 3_LEVEL_PGTABLES
        bool
        default y
Index: linux-2.6.12-rc/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-i386/ptrace.h	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-i386/ptrace.h	2005-05-17 16:37:06.000000000 -0400
@@ -31,7 +31,6 @@ extern int sysemu_supported;
 #ifdef UML_CONFIG_MODE_SKAS
 
 #include "skas_ptregs.h"
-#include "sysdep/faultinfo.h"
 
 #define REGS_IP(r) ((r)[HOST_IP])
 #define REGS_SP(r) ((r)[HOST_SP])
@@ -59,6 +58,7 @@ extern int sysemu_supported;
 #define PTRACE_SYSEMU_SINGLESTEP 32
 #endif
 
+#include "sysdep/faultinfo.h"
 #include "choose-mode.h"
 
 union uml_pt_regs {
Index: linux-2.6.12-rc/arch/um/include/sysdep-x86_64/checksum.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-x86_64/checksum.h	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-x86_64/checksum.h	2005-05-17 16:37:06.000000000 -0400
@@ -9,8 +9,6 @@
 #include "linux/in6.h"
 #include "asm/uaccess.h"
 
-extern unsigned int csum_partial_copy_from(const unsigned char *src, unsigned char *dst, int len,
-					   int sum, int *err_ptr);
 extern unsigned csum_partial(const unsigned char *buff, unsigned len,
                              unsigned sum);
 
@@ -31,10 +29,15 @@ unsigned int csum_partial_copy_nocheck(c
 }
 
 static __inline__
-unsigned int csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst,
-					 int len, int sum, int *err_ptr)
-{
-	return csum_partial_copy_from(src, dst, len, sum, err_ptr);
+unsigned int csum_partial_copy_from_user(const unsigned char *src, 
+                                         unsigned char *dst, int len, int sum, 
+                                         int *err_ptr)
+{
+        if(copy_from_user(dst, src, len)){
+                *err_ptr = -EFAULT;
+                return(-1);
+        }
+        return csum_partial(dst, len, sum);
 }
 
 /**
@@ -137,15 +140,6 @@ static inline unsigned add32_with_carry(
         return a;
 }
 
-#endif
+extern unsigned short ip_compute_csum(unsigned char * buff, int len);
 
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
Index: linux-2.6.12-rc/arch/um/include/sysdep-x86_64/ptrace.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-x86_64/ptrace.h	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-x86_64/ptrace.h	2005-05-17 16:37:06.000000000 -0400
@@ -135,6 +135,7 @@ extern int mode_tt;
 	__CHOOSE_MODE(SC_EFLAGS(UPT_SC(r)), REGS_EFLAGS((r)->skas.regs))
 #define UPT_SC(r) ((r)->tt.sc)
 #define UPT_SYSCALL_NR(r) __CHOOSE_MODE((r)->tt.syscall, (r)->skas.syscall)
+#define UPT_SYSCALL_RET(r) UPT_RAX(r)
 
 extern int user_context(unsigned long sp);
 
@@ -196,32 +197,32 @@ struct syscall_args {
 
 
 #define UPT_SET(regs, reg, val) \
-        ({      unsigned long val; \
+        ({      unsigned long __upt_val = val; \
                 switch(reg){ \
-		case R8: UPT_R8(regs) = val; break; \
-		case R9: UPT_R9(regs) = val; break; \
-		case R10: UPT_R10(regs) = val; break; \
-		case R11: UPT_R11(regs) = val; break; \
-		case R12: UPT_R12(regs) = val; break; \
-		case R13: UPT_R13(regs) = val; break; \
-		case R14: UPT_R14(regs) = val; break; \
-		case R15: UPT_R15(regs) = val; break; \
-                case RIP: UPT_IP(regs) = val; break; \
-                case RSP: UPT_SP(regs) = val; break; \
-                case RAX: UPT_RAX(regs) = val; break; \
-                case RBX: UPT_RBX(regs) = val; break; \
-                case RCX: UPT_RCX(regs) = val; break; \
-                case RDX: UPT_RDX(regs) = val; break; \
-                case RSI: UPT_RSI(regs) = val; break; \
-                case RDI: UPT_RDI(regs) = val; break; \
-                case RBP: UPT_RBP(regs) = val; break; \
-                case ORIG_RAX: UPT_ORIG_RAX(regs) = val; break; \
-                case CS: UPT_CS(regs) = val; break; \
-                case DS: UPT_DS(regs) = val; break; \
-                case ES: UPT_ES(regs) = val; break; \
-                case FS: UPT_FS(regs) = val; break; \
-                case GS: UPT_GS(regs) = val; break; \
-                case EFLAGS: UPT_EFLAGS(regs) = val; break; \
+                case R8: UPT_R8(regs) = __upt_val; break; \
+                case R9: UPT_R9(regs) = __upt_val; break; \
+                case R10: UPT_R10(regs) = __upt_val; break; \
+                case R11: UPT_R11(regs) = __upt_val; break; \
+                case R12: UPT_R12(regs) = __upt_val; break; \
+                case R13: UPT_R13(regs) = __upt_val; break; \
+                case R14: UPT_R14(regs) = __upt_val; break; \
+                case R15: UPT_R15(regs) = __upt_val; break; \
+                case RIP: UPT_IP(regs) = __upt_val; break; \
+                case RSP: UPT_SP(regs) = __upt_val; break; \
+                case RAX: UPT_RAX(regs) = __upt_val; break; \
+                case RBX: UPT_RBX(regs) = __upt_val; break; \
+                case RCX: UPT_RCX(regs) = __upt_val; break; \
+                case RDX: UPT_RDX(regs) = __upt_val; break; \
+                case RSI: UPT_RSI(regs) = __upt_val; break; \
+                case RDI: UPT_RDI(regs) = __upt_val; break; \
+                case RBP: UPT_RBP(regs) = __upt_val; break; \
+                case ORIG_RAX: UPT_ORIG_RAX(regs) = __upt_val; break; \
+                case CS: UPT_CS(regs) = __upt_val; break; \
+                case DS: UPT_DS(regs) = __upt_val; break; \
+                case ES: UPT_ES(regs) = __upt_val; break; \
+                case FS: UPT_FS(regs) = __upt_val; break; \
+                case GS: UPT_GS(regs) = __upt_val; break; \
+                case EFLAGS: UPT_EFLAGS(regs) = __upt_val; break; \
                 default :  \
                         panic("Bad register in UPT_SET : %d\n", reg);  \
 			break; \
@@ -245,14 +246,3 @@ struct syscall_args {
         CHOOSE_MODE((&(r)->tt.faultinfo), (&(r)->skas.faultinfo))
 
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
Index: linux-2.6.12-rc/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/ptrace.c	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/ptrace.c	2005-05-17 16:37:06.000000000 -0400
@@ -28,9 +28,9 @@ static inline void set_singlestepping(st
         child->thread.singlestep_syscall = 0;
 
 #ifdef SUBARCH_SET_SINGLESTEPPING
-        SUBARCH_SET_SINGLESTEPPING(child, on)
+        SUBARCH_SET_SINGLESTEPPING(child, on);
 #endif
-                }
+}
 
 /*
  * Called by kernel/ptrace.c when detaching..
@@ -83,7 +83,7 @@ long sys_ptrace(long request, long pid, 
 	}
 
 #ifdef SUBACH_PTRACE_SPECIAL
-        SUBARCH_PTRACE_SPECIAL(child,request,addr,data)
+        SUBARCH_PTRACE_SPECIAL(child,request,addr,data);
 #endif
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
Index: linux-2.6.12-rc/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/uml.lds.S	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/uml.lds.S	2005-05-17 16:37:06.000000000 -0400
@@ -73,6 +73,8 @@ SECTIONS
 
   .got           : { *(.got.plt) *(.got) }
   .dynamic       : { *(.dynamic) }
+  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
+  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
   /* We want the small data sections together, so single-instruction offsets
      can access them all, and initialized data all before uninitialized, so
      we can shorten the on-disk segment size.  */
Index: linux-2.6.12-rc/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-i386/Makefile	2005-05-17 16:35:18.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-i386/Makefile	2005-05-17 16:39:47.000000000 -0400
@@ -9,11 +9,11 @@ USER_OBJS := bugs.o ptrace_user.o sigcon
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
+include arch/um/scripts/Makefile.rules
+
 bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
 
 subdir- := util
-
-include arch/um/scripts/Makefile.rules
Index: linux-2.6.12-rc/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/Makefile	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/Makefile	2005-05-17 16:37:06.000000000 -0400
@@ -14,11 +14,11 @@ obj-$(CONFIG_MODULES) += module.o um_mod
 
 USER_OBJS := ptrace_user.o sigcontext.o
 
-include arch/um/scripts/Makefile.rules
-
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
 	semaphore.c thunk.S module.c
 
+include arch/um/scripts/Makefile.rules
+
 bitops.c-dir = lib
 csum-copy.S-dir = lib
 csum-partial.c-dir = lib
@@ -28,6 +28,4 @@ semaphore.c-dir = kernel
 thunk.S-dir = lib
 module.c-dir = kernel
 
-CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
-
 subdir- := util
Index: linux-2.6.12-rc/arch/um/sys-x86_64/ksyms.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/ksyms.c	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/ksyms.c	2005-05-17 16:37:06.000000000 -0400
@@ -16,5 +16,4 @@ EXPORT_SYMBOL(__up_wakeup);
 EXPORT_SYMBOL(__memcpy);
 
 /* Networking helper routines. */
-/*EXPORT_SYMBOL(csum_partial_copy_from);
-EXPORT_SYMBOL(csum_partial_copy_to);*/
+EXPORT_SYMBOL(ip_compute_csum);
Index: linux-2.6.12-rc/arch/um/sys-x86_64/ptrace.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/ptrace.c	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/ptrace.c	2005-05-17 16:37:06.000000000 -0400
@@ -5,10 +5,11 @@
  */
 
 #define __FRAME_OFFSETS
-#include "asm/ptrace.h"
-#include "linux/sched.h"
-#include "linux/errno.h"
-#include "asm/elf.h"
+#include <asm/ptrace.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <asm/elf.h>
 
 /* XXX x86_64 */
 unsigned long not_ss;
Index: linux-2.6.12-rc/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/syscalls.c	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/syscalls.c	2005-05-17 16:37:06.000000000 -0400
@@ -15,6 +15,7 @@
 #include "asm/unistd.h"
 #include "asm/prctl.h" /* XXX This should get the constants from libc */
 #include "choose-mode.h"
+#include "kern.h"
 
 asmlinkage long sys_uname64(struct new_utsname __user * name)
 {
Index: linux-2.6.12-rc/arch/um/sys-x86_64/user-offsets.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/user-offsets.c	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/user-offsets.c	2005-05-17 16:37:06.000000000 -0400
@@ -3,6 +3,14 @@
 #include <signal.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
+#include <asm/types.h>
+/* For some reason, x86_64 defines u64 and u32 only in <pci/types.h>, which I
+ * refuse to include here, even though they're used throughout the headers.  
+ * These are used in asm/user.h, and that include can't be avoided because of
+ * the sizeof(struct user_regs_struct) below.
+ */
+typedef __u64 u64;
+typedef __u32 u32;
 #include <asm/user.h>
 
 #define DEFINE(sym, val) \
Index: linux-2.6.12-rc/include/asm-um/elf-i386.h
===================================================================
--- linux-2.6.12-rc.orig/include/asm-um/elf-i386.h	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/include/asm-um/elf-i386.h	2005-05-17 16:37:06.000000000 -0400
@@ -5,7 +5,7 @@
 #ifndef __UM_ELF_I386_H
 #define __UM_ELF_I386_H
 
-#include "user.h"
+#include <asm/user.h>
 
 #define R_386_NONE	0
 #define R_386_32	1
Index: linux-2.6.12-rc/include/asm-um/elf-x86_64.h
===================================================================
--- linux-2.6.12-rc.orig/include/asm-um/elf-x86_64.h	2005-05-17 16:36:27.000000000 -0400
+++ linux-2.6.12-rc/include/asm-um/elf-x86_64.h	2005-05-17 16:37:06.000000000 -0400
@@ -8,6 +8,27 @@
 
 #include <asm/user.h>
 
+/* x86-64 relocation types, taken from asm-x86_64/elf.h */
+#define R_X86_64_NONE		0	/* No reloc */
+#define R_X86_64_64		1	/* Direct 64 bit  */
+#define R_X86_64_PC32		2	/* PC relative 32 bit signed */
+#define R_X86_64_GOT32		3	/* 32 bit GOT entry */
+#define R_X86_64_PLT32		4	/* 32 bit PLT address */
+#define R_X86_64_COPY		5	/* Copy symbol at runtime */
+#define R_X86_64_GLOB_DAT	6	/* Create GOT entry */
+#define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
+#define R_X86_64_RELATIVE	8	/* Adjust by program base */
+#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
+					   offset to GOT */
+#define R_X86_64_32		10	/* Direct 32 bit zero extended */
+#define R_X86_64_32S		11	/* Direct 32 bit sign extended */
+#define R_X86_64_16		12	/* Direct 16 bit zero extended */
+#define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
+#define R_X86_64_8		14	/* Direct 8 bit sign extended  */
+#define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
+
+#define R_X86_64_NUM		16
+
 typedef unsigned long elf_greg_t;
 
 #define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))
@@ -44,7 +65,8 @@ typedef struct { } elf_fpregset_t;
 } while (0)
 
 #ifdef TIF_IA32 /* XXX */
-        clear_thread_flag(TIF_IA32); \
+#error XXX, indeed
+        clear_thread_flag(TIF_IA32);
 #endif
 
 #define USE_ELF_CORE_DUMP

