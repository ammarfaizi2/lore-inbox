Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWILL0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWILL0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWILL0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:26:50 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:58084 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030188AbWILL0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:26:44 -0400
Date: Tue, 12 Sep 2006 13:26:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Use alternative user-copy operations for new hardware.
Message-ID: <20060912112641.GE2826@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Use alternative user-copy operations for new hardware.

This introduces new user-copy operations which are optimized for
copying more than 256 Bytes on new hardware.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head64.S     |   13 +++
 arch/s390/kernel/setup.c      |    6 +
 arch/s390/lib/Makefile        |    1 
 arch/s390/lib/uaccess_mvcos.c |  156 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/setup.h      |    2 
 include/asm-s390/uaccess.h    |    1 
 6 files changed, 178 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-09-12 10:57:46.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-09-12 10:57:59.000000000 +0200
@@ -250,6 +250,19 @@ startup_continue:
 	oi	7(%r12),0x80		# set IDTE flag
 0:
 
+#
+# find out if we have the MVCOS instruction
+#
+	la	%r1,0f-.LPG1(%r13)	# set program check address
+	stg	%r1,__LC_PGM_NEW_PSW+8
+	.short	0xc800			# mvcos 0(%r0),0(%r0),%r0
+	.short	0x0000
+	.short	0x0000
+0:	tm	0x8f,0x13		# special-operation exception?
+	bno	1f-.LPG1(%r13)		# if yes, MVCOS is present
+	oi	6(%r12),2		# set MVCOS flag
+1:
+
         lpswe .Lentry-.LPG1(13)         # jump to _stext in primary-space,
                                         # virtual and never return ...
         .align 16
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-09-12 10:57:59.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-09-12 10:57:59.000000000 +0200
@@ -647,7 +647,11 @@ setup_arch(char **cmdline_p)
 
 	memory_end = memory_size;
 
-	memcpy(&uaccess, &uaccess_std, sizeof(uaccess));
+	if (MACHINE_HAS_MVCOS)
+		memcpy(&uaccess, &uaccess_mvcos, sizeof(uaccess));
+	else
+		memcpy(&uaccess, &uaccess_std, sizeof(uaccess));
+
 	parse_early_param();
 
 #ifndef CONFIG_64BIT
diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2006-09-12 10:57:59.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/Makefile	2006-09-12 10:57:59.000000000 +0200
@@ -5,4 +5,5 @@
 EXTRA_AFLAGS := -traditional
 
 lib-y += delay.o string.o uaccess_std.o
+lib-$(CONFIG_64BIT) += uaccess_mvcos.o
 lib-$(CONFIG_SMP) += spinlock.o
diff -urpN linux-2.6/arch/s390/lib/uaccess_mvcos.c linux-2.6-patched/arch/s390/lib/uaccess_mvcos.c
--- linux-2.6/arch/s390/lib/uaccess_mvcos.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_mvcos.c	2006-09-12 10:57:59.000000000 +0200
@@ -0,0 +1,156 @@
+/*
+ *  arch/s390/lib/uaccess_mvcos.c
+ *
+ *  Optimized user space space access functions based on mvcos.
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ *		 Gerald Schaefer (gerald.schaefer@de.ibm.com)
+ */
+
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <asm/uaccess.h>
+#include <asm/futex.h>
+
+#ifndef __s390x__
+#define AHI	"ahi"
+#define ALR	"alr"
+#define CLR	"clr"
+#define LHI	"lhi"
+#define SLR	"slr"
+#else
+#define AHI	"aghi"
+#define ALR	"algr"
+#define CLR	"clgr"
+#define LHI	"lghi"
+#define SLR	"slgr"
+#endif
+
+size_t copy_from_user_mvcos(size_t size, const void __user *ptr, void *x)
+{
+	register unsigned long reg0 asm("0") = 0x81UL;
+	unsigned long tmp1, tmp2;
+
+	tmp1 = -4096UL;
+	asm volatile(
+		"0: .insn ss,0xc80000000000,0(%0,%2),0(%1),0\n"
+		"   jz    4f\n"
+		"1:"ALR"  %0,%3\n"
+		"  "SLR"  %1,%3\n"
+		"  "SLR"  %2,%3\n"
+		"   j     0b\n"
+		"2: la    %4,4095(%1)\n"/* %4 = ptr + 4095 */
+		"   nr    %4,%3\n"	/* %4 = (ptr + 4095) & -4096 */
+		"  "SLR"  %4,%1\n"
+		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
+		"   jnh   5f\n"
+		"3: .insn ss,0xc80000000000,0(%4,%2),0(%1),0\n"
+		"  "SLR"  %0,%4\n"
+		"   j     5f\n"
+		"4:"SLR"  %0,%0\n"
+		"5: \n"
+		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
+		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
+		: "d" (reg0) : "cc", "memory");
+	return size;
+}
+
+size_t copy_to_user_mvcos(size_t size, void __user *ptr, const void *x)
+{
+	register unsigned long reg0 asm("0") = 0x810000UL;
+	unsigned long tmp1, tmp2;
+
+	tmp1 = -4096UL;
+	asm volatile(
+		"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
+		"   jz    4f\n"
+		"1:"ALR"  %0,%3\n"
+		"  "SLR"  %1,%3\n"
+		"  "SLR"  %2,%3\n"
+		"   j     0b\n"
+		"2: la    %4,4095(%1)\n"/* %4 = ptr + 4095 */
+		"   nr    %4,%3\n"	/* %4 = (ptr + 4095) & -4096 */
+		"  "SLR"  %4,%1\n"
+		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
+		"   jnh   5f\n"
+		"3: .insn ss,0xc80000000000,0(%4,%1),0(%2),0\n"
+		"  "SLR"  %0,%4\n"
+		"   j     5f\n"
+		"4:"SLR"  %0,%0\n"
+		"5: \n"
+		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
+		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
+		: "d" (reg0) : "cc", "memory");
+	return size;
+}
+
+size_t copy_in_user_mvcos(size_t size, void __user *to, const void __user *from)
+{
+	register unsigned long reg0 asm("0") = 0x810081UL;
+	unsigned long tmp1, tmp2;
+
+	tmp1 = -4096UL;
+	/* FIXME: copy with reduced length. */
+	asm volatile(
+		"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
+		"   jz    2f\n"
+		"1:"ALR"  %0,%3\n"
+		"  "SLR"  %1,%3\n"
+		"  "SLR"  %2,%3\n"
+		"   j     0b\n"
+		"2:"SLR"  %0,%0\n"
+		"3: \n"
+		EX_TABLE(0b,3b)
+		: "+a" (size), "+a" (to), "+a" (from), "+a" (tmp1), "=a" (tmp2)
+		: "d" (reg0) : "cc", "memory");
+	return size;
+}
+
+size_t clear_user_mvcos(size_t size, void __user *to)
+{
+	register unsigned long reg0 asm("0") = 0x810000UL;
+	unsigned long tmp1, tmp2;
+
+	tmp1 = -4096UL;
+	asm volatile(
+		"0: .insn ss,0xc80000000000,0(%0,%1),0(%4),0\n"
+		"   jz    4f\n"
+		"1:"ALR"  %0,%2\n"
+		"  "SLR"  %1,%2\n"
+		"   j     0b\n"
+		"2: la    %3,4095(%1)\n"/* %4 = to + 4095 */
+		"   nr    %3,%2\n"	/* %4 = (to + 4095) & -4096 */
+		"  "SLR"  %3,%1\n"
+		"  "CLR"  %0,%3\n"	/* copy crosses next page boundary? */
+		"   jnh   5f\n"
+		"3: .insn ss,0xc80000000000,0(%3,%1),0(%4),0\n"
+		"  "SLR"  %0,%3\n"
+		"   j     5f\n"
+		"4:"SLR"  %0,%0\n"
+		"5: \n"
+		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
+		: "+a" (size), "+a" (to), "+a" (tmp1), "=a" (tmp2)
+		: "a" (empty_zero_page), "d" (reg0) : "cc", "memory");
+	return size;
+}
+
+extern size_t copy_from_user_std_small(size_t, const void __user *, void *);
+extern size_t copy_to_user_std_small(size_t, void __user *, const void *);
+extern size_t strnlen_user_std(size_t, const char __user *);
+extern size_t strncpy_from_user_std(size_t, const char __user *, char *);
+extern int futex_atomic_op(int, int __user *, int, int *);
+extern int futex_atomic_cmpxchg(int __user *, int, int);
+
+struct uaccess_ops uaccess_mvcos = {
+	.copy_from_user = copy_from_user_mvcos,
+	.copy_from_user_small = copy_from_user_std_small,
+	.copy_to_user = copy_to_user_mvcos,
+	.copy_to_user_small = copy_to_user_std_small,
+	.copy_in_user = copy_in_user_mvcos,
+	.clear_user = clear_user_mvcos,
+	.strnlen_user = strnlen_user_std,
+	.strncpy_from_user = strncpy_from_user_std,
+	.futex_atomic_op = futex_atomic_op,
+	.futex_atomic_cmpxchg = futex_atomic_cmpxchg,
+};
diff -urpN linux-2.6/include/asm-s390/setup.h linux-2.6-patched/include/asm-s390/setup.h
--- linux-2.6/include/asm-s390/setup.h	2006-09-12 10:57:46.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/setup.h	2006-09-12 10:57:59.000000000 +0200
@@ -44,10 +44,12 @@ extern unsigned long machine_flags;
 #define MACHINE_HAS_IEEE	(machine_flags & 2)
 #define MACHINE_HAS_CSP		(machine_flags & 8)
 #define MACHINE_HAS_DIAG44	(1)
+#define MACHINE_HAS_MVCOS	(0)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
 #define MACHINE_HAS_DIAG44	(machine_flags & 32)
+#define MACHINE_HAS_MVCOS	(machine_flags & 512)
 #endif /* __s390x__ */
 
 
diff -urpN linux-2.6/include/asm-s390/uaccess.h linux-2.6-patched/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	2006-09-12 10:57:59.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/uaccess.h	2006-09-12 10:57:59.000000000 +0200
@@ -100,6 +100,7 @@ struct uaccess_ops {
 
 extern struct uaccess_ops uaccess;
 extern struct uaccess_ops uaccess_std;
+extern struct uaccess_ops uaccess_mvcos;
 
 static inline int __put_user_fn(size_t size, void __user *ptr, void *x)
 {
