Return-Path: <linux-kernel-owner+w=401wt.eu-S965037AbWLOBhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWLOBhV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWLOBgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:36:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46246 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964975AbWLOBgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:36:31 -0500
Message-Id: <20061215013848.261684000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, takata@linux-m32r.org
Subject: [patch 22/24] m32r: make userspace headers platform-independent
Content-Disposition: inline; filename=m32r-make-userspace-headers-platform-independent.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Hirokazu Takata <takata@linux-m32r.org>

The m32r kernel 2.6.18-rc1 or after cause build errors of "unknown isa
configuration" for userspace application programs, such as glibc, gdb, etc.

This is because the recent kernel do not include linux/config.h not to expose
kernel headers for userspace.

To fix the above compile errors, this patch fixes two headers ptrace.h and
sigcontext.h for m32r and makes them platform-independent.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/m32r/kernel/entry.S      |   65 ++++++++++++++++++------------------------
 include/asm-m32r/ptrace.h     |   28 ++----------------
 include/asm-m32r/sigcontext.h |   13 +-------
 3 files changed, 35 insertions(+), 71 deletions(-)

--- linux-2.6.18.5.orig/arch/m32r/kernel/entry.S
+++ linux-2.6.18.5/arch/m32r/kernel/entry.S
@@ -23,35 +23,35 @@
  *	updated in fork.c:copy_thread, signal.c:do_signal,
  *	ptrace.c and ptrace.h
  *
- * M32Rx/M32R2				M32R
- *       @(sp)      - r4		ditto
- *       @(0x04,sp) - r5		ditto
- *       @(0x08,sp) - r6		ditto
- *       @(0x0c,sp) - *pt_regs		ditto
- *       @(0x10,sp) - r0		ditto
- *       @(0x14,sp) - r1		ditto
- *       @(0x18,sp) - r2		ditto
- *       @(0x1c,sp) - r3		ditto
- *       @(0x20,sp) - r7		ditto
- *       @(0x24,sp) - r8		ditto
- *       @(0x28,sp) - r9		ditto
- *       @(0x2c,sp) - r10		ditto
- *       @(0x30,sp) - r11		ditto
- *       @(0x34,sp) - r12		ditto
- *       @(0x38,sp) - syscall_nr	ditto
- *       @(0x3c,sp) - acc0h		@(0x3c,sp) - acch
- *       @(0x40,sp) - acc0l		@(0x40,sp) - accl
- *       @(0x44,sp) - acc1h		@(0x44,sp) - dummy_acc1h
- *       @(0x48,sp) - acc1l		@(0x48,sp) - dummy_acc1l
- *       @(0x4c,sp) - psw		ditto
- *       @(0x50,sp) - bpc		ditto
- *       @(0x54,sp) - bbpsw		ditto
- *       @(0x58,sp) - bbpc		ditto
- *       @(0x5c,sp) - spu (cr3)		ditto
- *       @(0x60,sp) - fp (r13)		ditto
- *       @(0x64,sp) - lr (r14)		ditto
- *       @(0x68,sp) - spi (cr2)		ditto
- *       @(0x6c,sp) - orig_r0		ditto
+ * M32R/M32Rx/M32R2
+ *       @(sp)      - r4
+ *       @(0x04,sp) - r5
+ *       @(0x08,sp) - r6
+ *       @(0x0c,sp) - *pt_regs
+ *       @(0x10,sp) - r0
+ *       @(0x14,sp) - r1
+ *       @(0x18,sp) - r2
+ *       @(0x1c,sp) - r3
+ *       @(0x20,sp) - r7
+ *       @(0x24,sp) - r8
+ *       @(0x28,sp) - r9
+ *       @(0x2c,sp) - r10
+ *       @(0x30,sp) - r11
+ *       @(0x34,sp) - r12
+ *       @(0x38,sp) - syscall_nr
+ *       @(0x3c,sp) - acc0h
+ *       @(0x40,sp) - acc0l
+ *       @(0x44,sp) - acc1h		; ISA_DSP_LEVEL2 only
+ *       @(0x48,sp) - acc1l		; ISA_DSP_LEVEL2 only
+ *       @(0x4c,sp) - psw
+ *       @(0x50,sp) - bpc
+ *       @(0x54,sp) - bbpsw
+ *       @(0x58,sp) - bbpc
+ *       @(0x5c,sp) - spu (cr3)
+ *       @(0x60,sp) - fp (r13)
+ *       @(0x64,sp) - lr (r14)
+ *       @(0x68,sp) - spi (cr2)
+ *       @(0x6c,sp) - orig_r0
  */
 
 #include <linux/linkage.h>
@@ -95,17 +95,10 @@
 #define R11(reg)		@(0x30,reg)
 #define R12(reg)		@(0x34,reg)
 #define SYSCALL_NR(reg)		@(0x38,reg)
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 #define ACC0H(reg)		@(0x3C,reg)
 #define ACC0L(reg)		@(0x40,reg)
 #define ACC1H(reg)		@(0x44,reg)
 #define ACC1L(reg)		@(0x48,reg)
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-#define ACCH(reg)		@(0x3C,reg)
-#define ACCL(reg)		@(0x40,reg)
-#else
-#error unknown isa configuration
-#endif
 #define PSW(reg)		@(0x4C,reg)
 #define BPC(reg)		@(0x50,reg)
 #define BBPSW(reg)		@(0x54,reg)
--- linux-2.6.18.5.orig/include/asm-m32r/ptrace.h
+++ linux-2.6.18.5/include/asm-m32r/ptrace.h
@@ -33,21 +33,10 @@
 #define PT_R15		PT_SP
 
 /* processor status and miscellaneous context registers.  */
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 #define PT_ACC0H	15
 #define PT_ACC0L	16
-#define PT_ACC1H	17
-#define PT_ACC1L	18
-#define PT_ACCH		PT_ACC0H
-#define PT_ACCL		PT_ACC0L
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-#define PT_ACCH		15
-#define PT_ACCL		16
-#define PT_DUMMY_ACC1H	17
-#define PT_DUMMY_ACC1L	18
-#else
-#error unknown isa conifiguration
-#endif
+#define PT_ACC1H	17	/* ISA_DSP_LEVEL2 only */
+#define PT_ACC1L	18	/* ISA_DSP_LEVEL2 only */
 #define PT_PSW		19
 #define PT_BPC		20
 #define PT_BBPSW	21
@@ -103,19 +92,10 @@ struct pt_regs {
 	long syscall_nr;
 
 	/* Saved main processor status and miscellaneous context registers. */
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	unsigned long acc0h;
 	unsigned long acc0l;
-	unsigned long acc1h;
-	unsigned long acc1l;
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-	unsigned long acch;
-	unsigned long accl;
-	unsigned long dummy_acc1h;
-	unsigned long dummy_acc1l;
-#else
-#error unknown isa configuration
-#endif
+	unsigned long acc1h;	/* ISA_DSP_LEVEL2 only */
+	unsigned long acc1l;	/* ISA_DSP_LEVEL2 only */
 	unsigned long psw;
 	unsigned long bpc;		/* saved PC for TRAP syscalls */
 	unsigned long bbpsw;
--- linux-2.6.18.5.orig/include/asm-m32r/sigcontext.h
+++ linux-2.6.18.5/include/asm-m32r/sigcontext.h
@@ -23,19 +23,10 @@ struct sigcontext {
 	unsigned long sc_r12;
 
 	/* Saved main processor status and miscellaneous context registers. */
-#if defined(CONFIG_ISA_M32R2) && defined(CONFIG_ISA_DSP_LEVEL2)
 	unsigned long sc_acc0h;
 	unsigned long sc_acc0l;
-	unsigned long sc_acc1h;
-	unsigned long sc_acc1l;
-#elif defined(CONFIG_ISA_M32R2) || defined(CONFIG_ISA_M32R)
-	unsigned long sc_acch;
-	unsigned long sc_accl;
-	unsigned long sc_dummy_acc1h;
-	unsigned long sc_dummy_acc1l;
-#else
-#error unknown isa configuration
-#endif
+	unsigned long sc_acc1h;	/* ISA_DSP_LEVEL2 only */
+	unsigned long sc_acc1l;	/* ISA_DSP_LEVEL2 only */
 	unsigned long sc_psw;
 	unsigned long sc_bpc;		/* saved PC for TRAP syscalls */
 	unsigned long sc_bbpsw;

--
