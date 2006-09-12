Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWILL0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWILL0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWILL0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:26:37 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:8057 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965191AbWILL0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:26:32 -0400
Date: Tue, 12 Sep 2006 13:26:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Make user-copy operations run-time configurable.
Message-ID: <20060912112629.GD2826@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Make user-copy operations run-time configurable.

Introduces a struct uaccess_ops which allows setting user-copy
operations at run-time.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/s390_ksyms.c |    6 
 arch/s390/kernel/setup.c      |    7 
 arch/s390/lib/Makefile        |    3 
 arch/s390/lib/uaccess.S       |  211 --------------------------
 arch/s390/lib/uaccess64.S     |  207 -------------------------
 arch/s390/lib/uaccess_std.c   |  340 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/futex.h      |   87 ----------
 include/asm-s390/uaccess.h    |  171 ++++++---------------
 8 files changed, 411 insertions(+), 621 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-patched/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	2006-09-12 10:56:59.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/s390_ksyms.c	2006-09-12 10:57:58.000000000 +0200
@@ -25,12 +25,6 @@ EXPORT_SYMBOL(_oi_bitmap);
 EXPORT_SYMBOL(_ni_bitmap);
 EXPORT_SYMBOL(_zb_findmap);
 EXPORT_SYMBOL(_sb_findmap);
-EXPORT_SYMBOL(__copy_from_user_asm);
-EXPORT_SYMBOL(__copy_to_user_asm);
-EXPORT_SYMBOL(__copy_in_user_asm);
-EXPORT_SYMBOL(__clear_user_asm);
-EXPORT_SYMBOL(__strncpy_from_user_asm);
-EXPORT_SYMBOL(__strnlen_user_asm);
 EXPORT_SYMBOL(diag10);
 
 /*
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-09-12 10:57:33.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-09-12 10:57:58.000000000 +0200
@@ -51,6 +51,12 @@
 #include <asm/sections.h>
 
 /*
+ * User copy operations.
+ */
+struct uaccess_ops uaccess;
+EXPORT_SYMBOL_GPL(uaccess);
+
+/*
  * Machine setup..
  */
 unsigned int console_mode = 0;
@@ -641,6 +647,7 @@ setup_arch(char **cmdline_p)
 
 	memory_end = memory_size;
 
+	memcpy(&uaccess, &uaccess_std, sizeof(uaccess));
 	parse_early_param();
 
 #ifndef CONFIG_64BIT
diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/Makefile	2006-09-12 10:57:58.000000000 +0200
@@ -4,6 +4,5 @@
 
 EXTRA_AFLAGS := -traditional
 
-lib-y += delay.o string.o
-lib-y += $(if $(CONFIG_64BIT),uaccess64.o,uaccess.o)
+lib-y += delay.o string.o uaccess_std.o
 lib-$(CONFIG_SMP) += spinlock.o
diff -urpN linux-2.6/arch/s390/lib/uaccess64.S linux-2.6-patched/arch/s390/lib/uaccess64.S
--- linux-2.6/arch/s390/lib/uaccess64.S	2006-09-12 10:56:59.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess64.S	1970-01-01 01:00:00.000000000 +0100
@@ -1,207 +0,0 @@
-/*
- *  arch/s390x/lib/uaccess.S
- *    __copy_{from|to}_user functions.
- *
- *  s390
- *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- *  These functions have standard call interface
- */
-
-#include <linux/errno.h>
-#include <asm/lowcore.h>
-#include <asm/asm-offsets.h>
-
-        .text
-        .align 4
-        .globl __copy_from_user_asm
-	# %r2 = to, %r3 = n, %r4 = from
-__copy_from_user_asm:
-	slgr	%r0,%r0
-0:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1f
-	slgr	%r2,%r2
-	br	%r14
-1:	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-	aghi	%r3,-256
-2:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1b
-3:	slgr	%r2,%r2
-	br	%r14
-4:	lghi	%r0,-4096
-	lgr	%r5,%r4
-	slgr	%r5,%r0
-	ngr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
-	slgr	%r5,%r4		# %r5 = #bytes to next user page boundary
-	clgr	%r3,%r5		# copy crosses next page boundary ?
-	jnh	6f		# no, the current page faulted
-	# move with the reduced length which is < 256
-5:	mvcp	0(%r5,%r2),0(%r4),%r0
-	slgr	%r3,%r5
-6:	lgr	%r2,%r3
-	br	%r14
-        .section __ex_table,"a"
-	.quad	0b,4b
-	.quad	2b,4b
-	.quad	5b,6b
-        .previous
-
-        .align 4
-        .text
-        .globl __copy_to_user_asm
-	# %r2 = from, %r3 = n, %r4 = to
-__copy_to_user_asm:
-	slgr	%r0,%r0
-0:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1f
-	slgr	%r2,%r2
-	br	%r14
-1:	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-	aghi	%r3,-256
-2:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1b
-3:	slgr	%r2,%r2
-	br	%r14
-4:	lghi	%r0,-4096
-	lgr	%r5,%r4
-	slgr	%r5,%r0
-	ngr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
-	slgr	%r5,%r4		# %r5 = #bytes to next user page boundary
-	clgr	%r3,%r5		# copy crosses next page boundary ?
-	jnh	6f		# no, the current page faulted
-	# move with the reduced length which is < 256
-5:	mvcs	0(%r5,%r4),0(%r2),%r0
-	slgr	%r3,%r5
-6:	lgr	%r2,%r3
-	br	%r14
-        .section __ex_table,"a"
-	.quad	0b,4b
-	.quad	2b,4b
-	.quad	5b,6b
-        .previous
-
-        .align 4
-        .text
-        .globl __copy_in_user_asm
-	# %r2 = from, %r3 = n, %r4 = to
-__copy_in_user_asm:
-	aghi	%r3,-1
-	jo	6f
-	sacf	256
-	bras	%r1,4f
-0:	aghi	%r3,257
-1:	mvc	0(1,%r4),0(%r2)
-	la	%r2,1(%r2)
-	la	%r4,1(%r4)
-	aghi	%r3,-1
-	jnz	1b
-2:	lgr	%r2,%r3
-	br	%r14
-3:	mvc	0(256,%r4),0(%r2)
-	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-4:	aghi	%r3,-256
-	jnm	3b
-5:	ex	%r3,4(%r1)
-	sacf	0
-6:	slgr	%r2,%r2
-	br	14
-        .section __ex_table,"a"
-	.quad	1b,2b
-	.quad	3b,0b
-	.quad	5b,0b
-        .previous
-
-        .align 4
-        .text
-        .globl __clear_user_asm
-	# %r2 = to, %r3 = n
-__clear_user_asm:
-	slgr	%r0,%r0
-	larl	%r5,empty_zero_page
-1:	mvcs	0(%r3,%r2),0(%r5),%r0
-	jnz	2f
-	slgr	%r2,%r2
-	br	%r14
-2:	la	%r2,256(%r2)
-	aghi	%r3,-256
-3:	mvcs	0(%r3,%r2),0(%r5),%r0
-	jnz	2b
-4:	slgr	%r2,%r2
-	br	%r14
-5:	lghi	%r0,-4096
-	lgr	%r4,%r2
-	slgr	%r4,%r0
-	ngr	%r4,%r0		# %r4 = (%r2 + 4096) & -4096
-	slgr	%r4,%r2		# %r4 = #bytes to next user page boundary
-	clgr	%r3,%r4		# clear crosses next page boundary ?
-	jnh	7f		# no, the current page faulted
-	# clear with the reduced length which is < 256
-6:	mvcs	0(%r4,%r2),0(%r5),%r0
-	slgr	%r3,%r4
-7:	lgr	%r2,%r3
-	br	%r14
-        .section __ex_table,"a"
-	.quad	1b,5b
-	.quad	3b,5b
-	.quad	6b,7b
-        .previous
-
-        .align 4
-        .text
-        .globl __strncpy_from_user_asm
-	# %r2 = count, %r3 = dst, %r4 = src
-__strncpy_from_user_asm:
-	lghi	%r0,0
-	lgr	%r1,%r4
-	la	%r2,0(%r2,%r4)	# %r2 points to first byte after string
-	sacf	256
-0:	srst	%r2,%r1
-	jo	0b
-	sacf	0
-	lgr	%r1,%r2
-	jh	1f		# \0 found in string ?
-	aghi	%r1,1		# include \0 in copy
-1:	slgr	%r1,%r4		# %r1 = copy length (without \0)
-	slgr	%r2,%r4		# %r2 = return length (including \0)
-2:	mvcp	0(%r1,%r3),0(%r4),%r0
-	jnz	3f
-	br	%r14
-3:	la	%r3,256(%r3)
-	la	%r4,256(%r4)
-	aghi	%r1,-256
-	mvcp	0(%r1,%r3),0(%r4),%r0
-	jnz	3b
-	br	%r14
-4:	sacf	0
-	lghi	%r2,-EFAULT
-	br	%r14
-	.section __ex_table,"a"
-	.quad	0b,4b
-	.previous
-
-        .align 4
-        .text
-        .globl __strnlen_user_asm
-	# %r2 = count, %r3 = src
-__strnlen_user_asm:
-	lghi	%r0,0
-	lgr	%r1,%r3
-	la	%r2,0(%r2,%r3)	# %r2 points to first byte after string
-	sacf	256
-0:	srst	%r2,%r1
-	jo	0b
-	sacf	0
-	aghi	%r2,1		# strnlen_user result includes the \0
-				# or return count+1 if \0 not found
-	slgr	%r2,%r3
-	br	%r14
-2:	sacf	0
-	slgr	%r2,%r2		# return 0 on exception
-	br	%r14
-	.section __ex_table,"a"
-	.quad	0b,2b
-	.previous
diff -urpN linux-2.6/arch/s390/lib/uaccess.S linux-2.6-patched/arch/s390/lib/uaccess.S
--- linux-2.6/arch/s390/lib/uaccess.S	2006-09-12 10:56:59.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/uaccess.S	1970-01-01 01:00:00.000000000 +0100
@@ -1,211 +0,0 @@
-/*
- *  arch/s390/lib/uaccess.S
- *    __copy_{from|to}_user functions.
- *
- *  s390
- *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
- *
- *  These functions have standard call interface
- */
-
-#include <linux/errno.h>
-#include <asm/lowcore.h>
-#include <asm/asm-offsets.h>
-
-        .text
-        .align 4
-        .globl __copy_from_user_asm
-	# %r2 = to, %r3 = n, %r4 = from
-__copy_from_user_asm:
-	slr	%r0,%r0
-0:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1f
-	slr	%r2,%r2
-	br	%r14
-1:	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-	ahi	%r3,-256
-2:	mvcp	0(%r3,%r2),0(%r4),%r0
-	jnz	1b
-3:	slr	%r2,%r2
-	br	%r14
-4:	lhi	%r0,-4096
-	lr	%r5,%r4
-	slr	%r5,%r0
-	nr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
-	slr	%r5,%r4		# %r5 = #bytes to next user page boundary
-	clr	%r3,%r5		# copy crosses next page boundary ?
-	jnh	6f		# no, the current page faulted
-	# move with the reduced length which is < 256
-5:	mvcp	0(%r5,%r2),0(%r4),%r0
-	slr	%r3,%r5
-6:	lr	%r2,%r3
-	br	%r14
-        .section __ex_table,"a"
-	.long	0b,4b
-	.long	2b,4b
-	.long	5b,6b
-        .previous
-
-        .align 4
-        .text
-        .globl __copy_to_user_asm
-	# %r2 = from, %r3 = n, %r4 = to
-__copy_to_user_asm:
-	slr	%r0,%r0
-0:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1f
-	slr	%r2,%r2
-	br	%r14
-1:	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-	ahi	%r3,-256
-2:	mvcs	0(%r3,%r4),0(%r2),%r0
-	jnz	1b
-3:	slr	%r2,%r2
-	br	%r14
-4:	lhi	%r0,-4096
-	lr	%r5,%r4
-	slr	%r5,%r0
-	nr	%r5,%r0		# %r5 = (%r4 + 4096) & -4096
-	slr	%r5,%r4		# %r5 = #bytes to next user page boundary
-	clr	%r3,%r5		# copy crosses next page boundary ?
-	jnh	6f		# no, the current page faulted
-	# move with the reduced length which is < 256
-5:	mvcs	0(%r5,%r4),0(%r2),%r0
-	slr	%r3,%r5
-6:	lr	%r2,%r3
-	br	%r14
-        .section __ex_table,"a"
-	.long	0b,4b
-	.long	2b,4b
-	.long	5b,6b
-        .previous
-
-        .align 4
-        .text
-        .globl __copy_in_user_asm
-	# %r2 = from, %r3 = n, %r4 = to
-__copy_in_user_asm:
-	ahi	%r3,-1
-	jo	6f
-	sacf	256
-	bras	%r1,4f
-0:	ahi	%r3,257
-1:	mvc	0(1,%r4),0(%r2)
-	la	%r2,1(%r2)
-	la	%r4,1(%r4)
-	ahi	%r3,-1
-	jnz	1b
-2:	lr	%r2,%r3
-	br	%r14
-3:	mvc	0(256,%r4),0(%r2)
-	la	%r2,256(%r2)
-	la	%r4,256(%r4)
-4:	ahi	%r3,-256
-	jnm	3b
-5:	ex	%r3,4(%r1)
-	sacf	0
-6:	slr	%r2,%r2
-	br	%r14
-        .section __ex_table,"a"
-	.long	1b,2b
-	.long	3b,0b
-	.long	5b,0b
-        .previous
-
-        .align 4
-        .text
-        .globl __clear_user_asm
-	# %r2 = to, %r3 = n
-__clear_user_asm:
-	bras	%r5,0f
-	.long	empty_zero_page
-0:	l	%r5,0(%r5)
-	slr	%r0,%r0
-1:	mvcs	0(%r3,%r2),0(%r5),%r0
-	jnz	2f
-	slr	%r2,%r2
-	br	%r14
-2:	la	%r2,256(%r2)
-	ahi	%r3,-256
-3:	mvcs	0(%r3,%r2),0(%r5),%r0
-	jnz	2b
-4:	slr	%r2,%r2
-	br	%r14
-5:	lhi	%r0,-4096
-	lr	%r4,%r2
-	slr	%r4,%r0
-	nr	%r4,%r0		# %r4 = (%r2 + 4096) & -4096
-	slr	%r4,%r2		# %r4 = #bytes to next user page boundary
-	clr	%r3,%r4		# clear crosses next page boundary ?
-	jnh	7f		# no, the current page faulted
-	# clear with the reduced length which is < 256
-6:	mvcs	0(%r4,%r2),0(%r5),%r0
-	slr	%r3,%r4
-7:	lr	%r2,%r3
-	br	%r14
-        .section __ex_table,"a"
-	.long	1b,5b
-	.long	3b,5b
-	.long	6b,7b
-        .previous
-
-        .align 4
-        .text
-        .globl __strncpy_from_user_asm
-	# %r2 = count, %r3 = dst, %r4 = src
-__strncpy_from_user_asm:
-	lhi	%r0,0
-	lr	%r1,%r4
-	la	%r4,0(%r4)	# clear high order bit from %r4
-	la	%r2,0(%r2,%r4)	# %r2 points to first byte after string
-	sacf	256
-0:	srst	%r2,%r1
-	jo	0b
-	sacf	0
-	lr	%r1,%r2
-	jh	1f		# \0 found in string ?
-	ahi	%r1,1		# include \0 in copy
-1:	slr	%r1,%r4		# %r1 = copy length (without \0)
-	slr	%r2,%r4		# %r2 = return length (including \0)
-2:	mvcp	0(%r1,%r3),0(%r4),%r0
-	jnz	3f
-	br	%r14
-3:	la	%r3,256(%r3)
-	la	%r4,256(%r4)
-	ahi	%r1,-256
-	mvcp	0(%r1,%r3),0(%r4),%r0
-	jnz	3b
-	br	%r14
-4:	sacf	0
-	lhi	%r2,-EFAULT
-	br	%r14
-	.section __ex_table,"a"
-	.long	0b,4b
-	.previous
-
-        .align 4
-        .text
-        .globl __strnlen_user_asm
-	# %r2 = count, %r3 = src
-__strnlen_user_asm:
-	lhi	%r0,0
-	lr	%r1,%r3
-	la	%r3,0(%r3)	# clear high order bit from %r4
-	la	%r2,0(%r2,%r3)	# %r2 points to first byte after string
-	sacf	256
-0:	srst	%r2,%r1
-	jo	0b
-	sacf	0
-	ahi	%r2,1		# strnlen_user result includes the \0
-				# or return count+1 if \0 not found
-	slr	%r2,%r3
-	br	%r14
-2:	sacf	0
-	slr	%r2,%r2		# return 0 on exception
-	br	%r14
-	.section __ex_table,"a"
-	.long	0b,2b
-	.previous
diff -urpN linux-2.6/arch/s390/lib/uaccess_std.c linux-2.6-patched/arch/s390/lib/uaccess_std.c
--- linux-2.6/arch/s390/lib/uaccess_std.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_std.c	2006-09-12 10:57:58.000000000 +0200
@@ -0,0 +1,340 @@
+/*
+ *  arch/s390/lib/uaccess_std.c
+ *
+ *  Standard user space access functions based on mvcp/mvcs and doing
+ *  interesting things in the secondary space mode.
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
+size_t copy_from_user_std(size_t size, const void __user *ptr, void *x)
+{
+	unsigned long tmp1, tmp2;
+
+	tmp1 = -256UL;
+	asm volatile(
+		"0: mvcp  0(%0,%2),0(%1),%3\n"
+		"   jz    5f\n"
+		"1:"ALR"  %0,%3\n"
+		"   la    %1,256(%1)\n"
+		"   la    %2,256(%2)\n"
+		"2: mvcp  0(%0,%2),0(%1),%3\n"
+		"   jnz   1b\n"
+		"   j     5f\n"
+		"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
+		"  "LHI"  %3,-4096\n"
+		"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
+		"  "SLR"  %4,%1\n"
+		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
+		"   jnh   6f\n"
+		"4: mvcp  0(%4,%2),0(%1),%3\n"
+		"  "SLR"  %0,%4\n"
+		"   j     6f\n"
+		"5:"SLR"  %0,%0\n"
+		"6: \n"
+		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
+		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
+		: : "cc", "memory");
+	return size;
+}
+
+size_t copy_from_user_std_small(size_t size, const void __user *ptr, void *x)
+{
+	unsigned long tmp1, tmp2;
+
+	tmp1 = 0UL;
+	asm volatile(
+		"0: mvcp  0(%0,%2),0(%1),%3\n"
+		"  "SLR"  %0,%0\n"
+		"   j     3f\n"
+		"1: la    %4,255(%1)\n" /* %4 = ptr + 255 */
+		"  "LHI"  %3,-4096\n"
+		"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
+		"  "SLR"  %4,%1\n"
+		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
+		"   jnh   3f\n"
+		"2: mvcp  0(%4,%2),0(%1),%3\n"
+		"  "SLR"  %0,%4\n"
+		"3:\n"
+		EX_TABLE(0b,1b) EX_TABLE(2b,3b)
+		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
+		: : "cc", "memory");
+	return size;
+}
+
+size_t copy_to_user_std(size_t size, void __user *ptr, const void *x)
+{
+	unsigned long tmp1, tmp2;
+
+	tmp1 = -256UL;
+	asm volatile(
+		"0: mvcs  0(%0,%1),0(%2),%3\n"
+		"   jz    5f\n"
+		"1:"ALR"  %0,%3\n"
+		"   la    %1,256(%1)\n"
+		"   la    %2,256(%2)\n"
+		"2: mvcs  0(%0,%1),0(%2),%3\n"
+		"   jnz   1b\n"
+		"   j     5f\n"
+		"3: la    %4,255(%1)\n" /* %4 = ptr + 255 */
+		"  "LHI"  %3,-4096\n"
+		"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
+		"  "SLR"  %4,%1\n"
+		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
+		"   jnh   6f\n"
+		"4: mvcs  0(%4,%1),0(%2),%3\n"
+		"  "SLR"  %0,%4\n"
+		"   j     6f\n"
+		"5:"SLR"  %0,%0\n"
+		"6: \n"
+		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
+		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
+		: : "cc", "memory");
+	return size;
+}
+
+size_t copy_to_user_std_small(size_t size, void __user *ptr, const void *x)
+{
+	unsigned long tmp1, tmp2;
+
+	tmp1 = 0UL;
+	asm volatile(
+		"0: mvcs  0(%0,%1),0(%2),%3\n"
+		"  "SLR"  %0,%0\n"
+		"   j     3f\n"
+		"1: la    %4,255(%1)\n" /* ptr + 255 */
+		"  "LHI"  %3,-4096\n"
+		"   nr    %4,%3\n"	/* (ptr + 255) & -4096UL */
+		"  "SLR"  %4,%1\n"
+		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
+		"   jnh   3f\n"
+		"2: mvcs  0(%4,%1),0(%2),%3\n"
+		"  "SLR"  %0,%4\n"
+		"3:\n"
+		EX_TABLE(0b,1b) EX_TABLE(2b,3b)
+		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
+		: : "cc", "memory");
+	return size;
+}
+
+size_t copy_in_user_std(size_t size, void __user *to, const void __user *from)
+{
+	unsigned long tmp1;
+
+	asm volatile(
+		"  "AHI"  %0,-1\n"
+		"   jo    5f\n"
+		"   sacf  256\n"
+		"   bras  %3,3f\n"
+		"0:"AHI"  %0,257\n"
+		"1: mvc   0(1,%1),0(%2)\n"
+		"   la    %1,1(%1)\n"
+		"   la    %2,1(%2)\n"
+		"  "AHI"  %0,-1\n"
+		"   jnz   1b\n"
+		"   j     5f\n"
+		"2: mvc   0(256,%1),0(%2)\n"
+		"   la    %1,256(%1)\n"
+		"   la    %2,256(%2)\n"
+		"3:"AHI"  %0,-256\n"
+		"   jnm   2b\n"
+		"4: ex    %0,1b-0b(%3)\n"
+		"   sacf  0\n"
+		"5: "SLR"  %0,%0\n"
+		"6:\n"
+		EX_TABLE(1b,6b) EX_TABLE(2b,0b) EX_TABLE(4b,0b)
+		: "+a" (size), "+a" (to), "+a" (from), "=a" (tmp1)
+		: : "cc", "memory");
+	return size;
+}
+
+size_t clear_user_std(size_t size, void __user *to)
+{
+	unsigned long tmp1, tmp2;
+
+	asm volatile(
+		"  "AHI"  %0,-1\n"
+		"   jo    5f\n"
+		"   sacf  256\n"
+		"   bras  %3,3f\n"
+		"   xc    0(1,%1),0(%1)\n"
+		"0:"AHI"  %0,257\n"
+		"   la    %2,255(%1)\n" /* %2 = ptr + 255 */
+		"   srl   %2,12\n"
+		"   sll   %2,12\n"	/* %2 = (ptr + 255) & -4096 */
+		"  "SLR"  %2,%1\n"
+		"  "CLR"  %0,%2\n"	/* clear crosses next page boundary? */
+		"   jnh   5f\n"
+		"  "AHI"  %2,-1\n"
+		"1: ex    %2,0(%3)\n"
+		"  "AHI"  %2,1\n"
+		"  "SLR"  %0,%2\n"
+		"   j     5f\n"
+		"2: xc    0(256,%1),0(%1)\n"
+		"   la    %1,256(%1)\n"
+		"3:"AHI"  %0,-256\n"
+		"   jnm   2b\n"
+		"4: ex    %0,0(%3)\n"
+		"   sacf  0\n"
+		"5: "SLR"  %0,%0\n"
+		"6:\n"
+		EX_TABLE(1b,6b) EX_TABLE(2b,0b) EX_TABLE(4b,0b)
+		: "+a" (size), "+a" (to), "=a" (tmp1), "=a" (tmp2)
+		: : "cc", "memory");
+	return size;
+}
+
+size_t strnlen_user_std(size_t size, const char __user *src)
+{
+	register unsigned long reg0 asm("0") = 0UL;
+	unsigned long tmp1, tmp2;
+
+	asm volatile(
+		"   la    %2,0(%1)\n"
+		"   la    %3,0(%0,%1)\n"
+		"  "SLR"  %0,%0\n"
+		"   sacf  256\n"
+		"0: srst  %3,%2\n"
+		"   jo    0b\n"
+		"   la    %0,1(%3)\n"	/* strnlen_user results includes \0 */
+		"  "SLR"  %0,%1\n"
+		"1: sacf  0\n"
+		EX_TABLE(0b,1b)
+		: "+a" (size), "+a" (src), "=a" (tmp1), "=a" (tmp2)
+		: "d" (reg0) : "cc", "memory");
+	return size;
+}
+
+size_t strncpy_from_user_std(size_t size, const char __user *src, char *dst)
+{
+	register unsigned long reg0 asm("0") = 0UL;
+	unsigned long tmp1, tmp2;
+
+	asm volatile(
+		"   la    %3,0(%1)\n"
+		"   la    %4,0(%0,%1)\n"
+		"   sacf  256\n"
+		"0: srst  %4,%3\n"
+		"   jo    0b\n"
+		"   sacf  0\n"
+		"   la    %0,0(%4)\n"
+		"   jh    1f\n"		/* found \0 in string ? */
+		"  "AHI"  %4,1\n"	/* include \0 in copy */
+		"1:"SLR"  %0,%1\n"	/* %0 = return length (without \0) */
+		"  "SLR"  %4,%1\n"	/* %4 = copy length (including \0) */
+		"2: mvcp  0(%4,%2),0(%1),%5\n"
+		"   jz    9f\n"
+		"3:"AHI"  %4,-256\n"
+		"   la    %1,256(%1)\n"
+		"   la    %2,256(%2)\n"
+		"4: mvcp  0(%4,%2),0(%1),%5\n"
+		"   jnz   3b\n"
+		"   j     9f\n"
+		"7: sacf  0\n"
+		"8:"LHI"  %0,%6\n"
+		"9:\n"
+		EX_TABLE(0b,7b) EX_TABLE(2b,8b) EX_TABLE(4b,8b)
+		: "+a" (size), "+a" (src), "+d" (dst), "=a" (tmp1), "=a" (tmp2)
+		: "d" (reg0), "K" (-EFAULT) : "cc", "memory");
+	return size;
+}
+
+#define __futex_atomic_op(insn, ret, oldval, newval, uaddr, oparg)	\
+	asm volatile(							\
+		"   sacf  256\n"					\
+		"0: l     %1,0(%6)\n"					\
+		"1:"insn						\
+		"2: cs    %1,%2,0(%6)\n"				\
+		"3: jl    1b\n"						\
+		"   lhi   %0,0\n"					\
+		"4: sacf  0\n"						\
+		EX_TABLE(0b,4b) EX_TABLE(2b,4b) EX_TABLE(3b,4b)		\
+		: "=d" (ret), "=&d" (oldval), "=&d" (newval),		\
+		  "=m" (*uaddr)						\
+		: "0" (-EFAULT), "d" (oparg), "a" (uaddr),		\
+		  "m" (*uaddr) : "cc");
+
+int futex_atomic_op(int op, int __user *uaddr, int oparg, int *old)
+{
+	int oldval = 0, newval, ret;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("lr %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("lr %2,%1\nar %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("lr %2,%1\nor %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("lr %2,%1\nnr %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("lr %2,%1\nxr %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+	dec_preempt_count();
+	*old = oldval;
+	return ret;
+}
+
+int futex_atomic_cmpxchg(int __user *uaddr, int oldval, int newval)
+{
+	int ret;
+
+	asm volatile(
+		"   sacf 256\n"
+		"   cs   %1,%4,0(%5)\n"
+		"0: lr   %0,%1\n"
+		"1: sacf 0\n"
+		EX_TABLE(0b,1b)
+		: "=d" (ret), "+d" (oldval), "=m" (*uaddr)
+		: "0" (-EFAULT), "d" (newval), "a" (uaddr), "m" (*uaddr)
+		: "cc", "memory" );
+	return ret;
+}
+
+struct uaccess_ops uaccess_std = {
+	.copy_from_user = copy_from_user_std,
+	.copy_from_user_small = copy_from_user_std_small,
+	.copy_to_user = copy_to_user_std,
+	.copy_to_user_small = copy_to_user_std_small,
+	.copy_in_user = copy_in_user_std,
+	.clear_user = clear_user_std,
+	.strnlen_user = strnlen_user_std,
+	.strncpy_from_user = strncpy_from_user_std,
+	.futex_atomic_op = futex_atomic_op,
+	.futex_atomic_cmpxchg = futex_atomic_cmpxchg,
+};
diff -urpN linux-2.6/include/asm-s390/futex.h linux-2.6-patched/include/asm-s390/futex.h
--- linux-2.6/include/asm-s390/futex.h	2006-09-12 10:57:10.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/futex.h	2006-09-12 10:57:58.000000000 +0200
@@ -7,75 +7,21 @@
 #include <asm/errno.h>
 #include <asm/uaccess.h>
 
-#ifndef __s390x__
-#define __futex_atomic_fixup \
-		     ".section __ex_table,\"a\"\n"			\
-		     "   .align 4\n"					\
-		     "   .long  0b,4b,2b,4b,3b,4b\n"			\
-		     ".previous"
-#else /* __s390x__ */
-#define __futex_atomic_fixup \
-		     ".section __ex_table,\"a\"\n"			\
-		     "   .align 8\n"					\
-		     "   .quad  0b,4b,2b,4b,3b,4b\n"			\
-		     ".previous"
-#endif /* __s390x__ */
-
-#define __futex_atomic_op(insn, ret, oldval, newval, uaddr, oparg)	\
-	asm volatile("   sacf 256\n"					\
-		     "0: l   %1,0(%6)\n"				\
-		     "1: " insn						\
-		     "2: cs  %1,%2,0(%6)\n"				\
-		     "3: jl  1b\n"					\
-		     "   lhi %0,0\n"					\
-		     "4: sacf 0\n"					\
-		     __futex_atomic_fixup				\
-		     : "=d" (ret), "=&d" (oldval), "=&d" (newval),	\
-		       "=m" (*uaddr)					\
-		     : "0" (-EFAULT), "d" (oparg), "a" (uaddr),		\
-		       "m" (*uaddr) : "cc" );
-
 static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
 {
 	int op = (encoded_op >> 28) & 7;
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, newval, ret;
+	int oldval, ret;
+
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-		__futex_atomic_op("lr %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
-		break;
-	case FUTEX_OP_ADD:
-		__futex_atomic_op("lr %2,%1\nar %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
-		break;
-	case FUTEX_OP_OR:
-		__futex_atomic_op("lr %2,%1\nor %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
-		break;
-	case FUTEX_OP_ANDN:
-		__futex_atomic_op("lr %2,%1\nnr %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
-		break;
-	case FUTEX_OP_XOR:
-		__futex_atomic_op("lr %2,%1\nxr %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
-		break;
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
+	ret = uaccess.futex_atomic_op(op, uaddr, oparg, &oldval);
 
 	if (!ret) {
 		switch (cmp) {
@@ -91,32 +37,13 @@ static inline int futex_atomic_op_inuser
 	return ret;
 }
 
-static inline int
-futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
+static inline int futex_atomic_cmpxchg_inatomic(int __user *uaddr,
+						int oldval, int newval)
 {
-	int ret;
-
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
-	asm volatile("   sacf 256\n"
-		     "   cs   %1,%4,0(%5)\n"
-		     "0: lr   %0,%1\n"
-		     "1: sacf 0\n"
-#ifndef __s390x__
-		     ".section __ex_table,\"a\"\n"
-		     "   .align 4\n"
-		     "   .long  0b,1b\n"
-		     ".previous"
-#else /* __s390x__ */
-		     ".section __ex_table,\"a\"\n"
-		     "   .align 8\n"
-		     "   .quad  0b,1b\n"
-		     ".previous"
-#endif /* __s390x__ */
-		     : "=d" (ret), "+d" (oldval), "=m" (*uaddr)
-		     : "0" (-EFAULT), "d" (newval), "a" (uaddr), "m" (*uaddr)
-		     : "cc", "memory" );
-	return oldval;
+
+	return uaccess.futex_atomic_cmpxchg(uaddr, oldval, newval);
 }
 
 #endif /* __KERNEL__ */
diff -urpN linux-2.6/include/asm-s390/uaccess.h linux-2.6-patched/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/uaccess.h	2006-09-12 10:57:58.000000000 +0200
@@ -47,7 +47,7 @@
 		S390_lowcore.user_asce : S390_lowcore.kernel_asce;	\
 	asm volatile ("lctlg 7,7,%0" : : "m" (__pto) );			\
 })
-#else
+#else /* __s390x__ */
 #define set_fs(x) \
 ({									\
 	unsigned long __pto;						\
@@ -56,7 +56,7 @@
 		S390_lowcore.user_asce : S390_lowcore.kernel_asce;	\
 	asm volatile ("lctl  7,7,%0" : : "m" (__pto) );			\
 })
-#endif
+#endif /* __s390x__ */
 
 #define segment_eq(a,b) ((a).ar4 == (b).ar4)
 
@@ -85,76 +85,50 @@ struct exception_table_entry
         unsigned long insn, fixup;
 };
 
-#ifndef __s390x__
-#define __uaccess_fixup \
-	".section .fixup,\"ax\"\n"	\
-	"2: lhi    %0,%4\n"		\
-	"   bras   1,3f\n"		\
-	"   .long  1b\n"		\
-	"3: l      1,0(1)\n"		\
-	"   br     1\n"			\
-	".previous\n"			\
-	".section __ex_table,\"a\"\n"	\
-	"   .align 4\n"			\
-	"   .long  0b,2b\n"		\
-	".previous"
-#define __uaccess_clobber "cc", "1"
-#else /* __s390x__ */
-#define __uaccess_fixup \
-	".section .fixup,\"ax\"\n"	\
-	"2: lghi   %0,%4\n"		\
-	"   jg     1b\n"		\
-	".previous\n"			\
-	".section __ex_table,\"a\"\n"	\
-	"   .align 8\n"			\
-	"   .quad  0b,2b\n"		\
-	".previous"
-#define __uaccess_clobber "cc"
-#endif /* __s390x__ */
+struct uaccess_ops {
+	size_t (*copy_from_user)(size_t, const void __user *, void *);
+	size_t (*copy_from_user_small)(size_t, const void __user *, void *);
+	size_t (*copy_to_user)(size_t, void __user *, const void *);
+	size_t (*copy_to_user_small)(size_t, void __user *, const void *);
+	size_t (*copy_in_user)(size_t, void __user *, const void __user *);
+	size_t (*clear_user)(size_t, void __user *);
+	size_t (*strnlen_user)(size_t, const char __user *);
+	size_t (*strncpy_from_user)(size_t, const char __user *, char *);
+	int (*futex_atomic_op)(int op, int __user *, int oparg, int *old);
+	int (*futex_atomic_cmpxchg)(int __user *, int old, int new);
+};
+
+extern struct uaccess_ops uaccess;
+extern struct uaccess_ops uaccess_std;
+
+static inline int __put_user_fn(size_t size, void __user *ptr, void *x)
+{
+	size = uaccess.copy_to_user_small(size, ptr, x);
+	return size ? -EFAULT : size;
+}
+
+static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
+{
+	size = uaccess.copy_from_user_small(size, ptr, x);
+	return size ? -EFAULT : size;
+}
 
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
  */
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-#define __put_user_asm(x, ptr, err) \
-({								\
-	err = 0;						\
-	asm volatile(						\
-		"0: mvcs  0(%1,%2),%3,%0\n"			\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "+&d" (err)					\
-		: "d" (sizeof(*(ptr))), "a" (ptr), "Q" (x),	\
-		  "K" (-EFAULT)					\
-		: __uaccess_clobber );				\
-})
-#else
-#define __put_user_asm(x, ptr, err) \
-({								\
-	err = 0;						\
-	asm volatile(						\
-		"0: mvcs  0(%1,%2),0(%3),%0\n"			\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "+&d" (err)					\
-		: "d" (sizeof(*(ptr))), "a" (ptr), "a" (&(x)),	\
-		  "K" (-EFAULT), "m" (x)			\
-		: __uaccess_clobber );				\
-})
-#endif
-
 #define __put_user(x, ptr) \
 ({								\
 	__typeof__(*(ptr)) __x = (x);				\
-	int __pu_err;						\
+	int __pu_err = -EFAULT;					\
         __chk_user_ptr(ptr);                                    \
 	switch (sizeof (*(ptr))) {				\
 	case 1:							\
 	case 2:							\
 	case 4:							\
 	case 8:							\
-		__put_user_asm(__x, ptr, __pu_err);		\
+		__pu_err = __put_user_fn(sizeof (*(ptr)),	\
+					 ptr, &__x);		\
 		break;						\
 	default:						\
 		__put_user_bad();				\
@@ -172,60 +146,36 @@ struct exception_table_entry
 
 extern int __put_user_bad(void) __attribute__((noreturn));
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-#define __get_user_asm(x, ptr, err) \
-({								\
-	err = 0;						\
-	asm volatile (						\
-		"0: mvcp  %O1(%2,%R1),0(%3),%0\n"		\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "+&d" (err), "=Q" (x)				\
-		: "d" (sizeof(*(ptr))), "a" (ptr),		\
-		  "K" (-EFAULT)					\
-		: __uaccess_clobber );				\
-})
-#else
-#define __get_user_asm(x, ptr, err) \
-({								\
-	err = 0;						\
-	asm volatile (						\
-		"0: mvcp  0(%2,%5),0(%3),%0\n"			\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "+&d" (err), "=m" (x)				\
-		: "d" (sizeof(*(ptr))), "a" (ptr),		\
-		  "K" (-EFAULT), "a" (&(x))			\
-		: __uaccess_clobber );				\
-})
-#endif
-
 #define __get_user(x, ptr)					\
 ({								\
-	int __gu_err;						\
-        __chk_user_ptr(ptr);                                    \
+	int __gu_err = -EFAULT;					\
+	__chk_user_ptr(ptr);					\
 	switch (sizeof(*(ptr))) {				\
 	case 1: {						\
 		unsigned char __x;				\
-		__get_user_asm(__x, ptr, __gu_err);		\
+		__gu_err = __get_user_fn(sizeof (*(ptr)),	\
+					 ptr, &__x);		\
 		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	case 2: {						\
 		unsigned short __x;				\
-		__get_user_asm(__x, ptr, __gu_err);		\
+		__gu_err = __get_user_fn(sizeof (*(ptr)),	\
+					 ptr, &__x);		\
 		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	case 4: {						\
 		unsigned int __x;				\
-		__get_user_asm(__x, ptr, __gu_err);		\
+		__gu_err = __get_user_fn(sizeof (*(ptr)),	\
+					 ptr, &__x);		\
 		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
 	case 8: {						\
 		unsigned long long __x;				\
-		__get_user_asm(__x, ptr, __gu_err);		\
+		__gu_err = __get_user_fn(sizeof (*(ptr)),	\
+					 ptr, &__x);		\
 		(x) = *(__force __typeof__(*(ptr)) *) &__x;	\
 		break;						\
 	};							\
@@ -247,8 +197,6 @@ extern int __get_user_bad(void) __attrib
 #define __put_user_unaligned __put_user
 #define __get_user_unaligned __get_user
 
-extern long __copy_to_user_asm(const void *from, long n, void __user *to);
-
 /**
  * __copy_to_user: - Copy a block of data into user space, with less checking.
  * @to:   Destination address, in user space.
@@ -266,7 +214,10 @@ extern long __copy_to_user_asm(const voi
 static inline unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __copy_to_user_asm(from, n, to);
+	if (__builtin_constant_p(n) && (n <= 256))
+		return uaccess.copy_to_user_small(n, to, from);
+	else
+		return uaccess.copy_to_user(n, to, from);
 }
 
 #define __copy_to_user_inatomic __copy_to_user
@@ -294,8 +245,6 @@ copy_to_user(void __user *to, const void
 	return n;
 }
 
-extern long __copy_from_user_asm(void *to, long n, const void __user *from);
-
 /**
  * __copy_from_user: - Copy a block of data from user space, with less checking.
  * @to:   Destination address, in kernel space.
@@ -316,7 +265,10 @@ extern long __copy_from_user_asm(void *t
 static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __copy_from_user_asm(to, n, from);
+	if (__builtin_constant_p(n) && (n <= 256))
+		return uaccess.copy_from_user_small(n, from, to);
+	else
+		return uaccess.copy_from_user(n, from, to);
 }
 
 /**
@@ -346,13 +298,10 @@ copy_from_user(void *to, const void __us
 	return n;
 }
 
-extern unsigned long __copy_in_user_asm(const void __user *from, long n,
-							void __user *to);
-
 static inline unsigned long
 __copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-	return __copy_in_user_asm(from, n, to);
+	return uaccess.copy_in_user(n, to, from);
 }
 
 static inline unsigned long
@@ -360,34 +309,28 @@ copy_in_user(void __user *to, const void
 {
 	might_sleep();
 	if (__access_ok(from,n) && __access_ok(to,n))
-		n = __copy_in_user_asm(from, n, to);
+		n = __copy_in_user(to, from, n);
 	return n;
 }
 
 /*
  * Copy a null terminated string from userspace.
  */
-extern long __strncpy_from_user_asm(long count, char *dst,
-					const char __user *src);
-
 static inline long
 strncpy_from_user(char *dst, const char __user *src, long count)
 {
         long res = -EFAULT;
         might_sleep();
         if (access_ok(VERIFY_READ, src, 1))
-                res = __strncpy_from_user_asm(count, dst, src);
+		res = uaccess.strncpy_from_user(count, src, dst);
         return res;
 }
 
-
-extern long __strnlen_user_asm(long count, const char __user *src);
-
 static inline unsigned long
 strnlen_user(const char __user * src, unsigned long n)
 {
 	might_sleep();
-	return __strnlen_user_asm(n, src);
+	return uaccess.strnlen_user(n, src);
 }
 
 /**
@@ -410,12 +353,10 @@ strnlen_user(const char __user * src, un
  * Zero Userspace
  */
 
-extern long __clear_user_asm(void __user *to, long n);
-
 static inline unsigned long
 __clear_user(void __user *to, unsigned long n)
 {
-	return __clear_user_asm(to, n);
+	return uaccess.clear_user(n, to);
 }
 
 static inline unsigned long
@@ -423,7 +364,7 @@ clear_user(void __user *to, unsigned lon
 {
 	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __clear_user_asm(to, n);
+		n = uaccess.clear_user(n, to);
 	return n;
 }
 
