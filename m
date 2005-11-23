Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVKWTAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVKWTAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVKWTAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:00:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62672 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932197AbVKWTAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:00:14 -0500
Date: Wed, 23 Nov 2005 18:59:48 GMT
Message-Id: <200511231859.jANIxmOG032278@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, dalomar@serrasold.com
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 3/3] FRV: Implement futex operations for FRV
In-Reply-To: <dhowells1132772387@warthog.cambridge.redhat.com>
References: <dhowells1132772387@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements futex operations for the FRV architecture. The
operations are applicable to both MMU and no-MMU modes; though the EFAULT
handling will be a little bit of wasted space on the latter.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-futexop-2615rc2.diff
 arch/frv/kernel/Makefile |    1 
 arch/frv/kernel/futex.c  |  242 +++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-frv/futex.h  |   42 --------
 3 files changed, 244 insertions(+), 41 deletions(-)

diff -uNrp linux-2.6.15-rc2-frv/arch/frv/kernel/futex.c linux-2.6.15-rc2-frv-shmem/arch/frv/kernel/futex.c
--- linux-2.6.15-rc2-frv/arch/frv/kernel/futex.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc2-frv-shmem/arch/frv/kernel/futex.c	2005-11-23 18:09:40.000000000 +0000
@@ -0,0 +1,242 @@
+/* futex.c: futex operations
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/futex.h>
+#include <asm/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+/*
+ * the various futex operations; MMU fault checking is ignored under no-MMU
+ * conditions
+ */
+static inline int atomic_futex_op_xchg_set(int oparg, int __user *uaddr, int *_oldval)
+{
+	int oldval, ret;
+
+	asm("0:						\n"
+	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
+	    "	ckeq		icc3,cc7		\n"
+	    "1:	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
+	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
+	    "2:	cst.p		%3,%M0		,cc3,#1	\n"
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
+	    "	beq		icc3,#0,0b		\n"
+	    "	setlos		0,%2			\n"
+	    "3:						\n"
+	    ".subsection 2				\n"
+	    "4:	setlos		%5,%2			\n"
+	    "	bra		3b			\n"
+	    ".previous					\n"
+	    ".section __ex_table,\"a\"			\n"
+	    "	.balign		8			\n"
+	    "	.long		1b,4b			\n"
+	    "	.long		2b,4b			\n"
+	    ".previous"
+	    : "+U"(*uaddr), "=&r"(oldval), "=&r"(ret), "=r"(oparg)
+	    : "3"(oparg), "i"(-EFAULT)
+	    : "memory", "cc7", "cc3", "icc3"
+	    );
+
+	*_oldval = oldval;
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_add(int oparg, int __user *uaddr, int *_oldval)
+{
+	int oldval, ret;
+
+	asm("0:						\n"
+	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
+	    "	ckeq		icc3,cc7		\n"
+	    "1:	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
+	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
+	    "	add		%1,%3,%3		\n"
+	    "2:	cst.p		%3,%M0		,cc3,#1	\n"
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
+	    "	beq		icc3,#0,0b		\n"
+	    "	setlos		0,%2			\n"
+	    "3:						\n"
+	    ".subsection 2				\n"
+	    "4:	setlos		%5,%2			\n"
+	    "	bra		3b			\n"
+	    ".previous					\n"
+	    ".section __ex_table,\"a\"			\n"
+	    "	.balign		8			\n"
+	    "	.long		1b,4b			\n"
+	    "	.long		2b,4b			\n"
+	    ".previous"
+	    : "+U"(*uaddr), "=&r"(oldval), "=&r"(ret), "=r"(oparg)
+	    : "3"(oparg), "i"(-EFAULT)
+	    : "memory", "cc7", "cc3", "icc3"
+	    );
+
+	*_oldval = oldval;
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_or(int oparg, int __user *uaddr, int *_oldval)
+{
+	int oldval, ret;
+
+	asm("0:						\n"
+	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
+	    "	ckeq		icc3,cc7		\n"
+	    "1:	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
+	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
+	    "	or		%1,%3,%3		\n"
+	    "2:	cst.p		%3,%M0		,cc3,#1	\n"
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
+	    "	beq		icc3,#0,0b		\n"
+	    "	setlos		0,%2			\n"
+	    "3:						\n"
+	    ".subsection 2				\n"
+	    "4:	setlos		%5,%2			\n"
+	    "	bra		3b			\n"
+	    ".previous					\n"
+	    ".section __ex_table,\"a\"			\n"
+	    "	.balign		8			\n"
+	    "	.long		1b,4b			\n"
+	    "	.long		2b,4b			\n"
+	    ".previous"
+	    : "+U"(*uaddr), "=&r"(oldval), "=&r"(ret), "=r"(oparg)
+	    : "3"(oparg), "i"(-EFAULT)
+	    : "memory", "cc7", "cc3", "icc3"
+	    );
+
+	*_oldval = oldval;
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_and(int oparg, int __user *uaddr, int *_oldval)
+{
+	int oldval, ret;
+
+	asm("0:						\n"
+	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
+	    "	ckeq		icc3,cc7		\n"
+	    "1:	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
+	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
+	    "	and		%1,%3,%3		\n"
+	    "2:	cst.p		%3,%M0		,cc3,#1	\n"
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
+	    "	beq		icc3,#0,0b		\n"
+	    "	setlos		0,%2			\n"
+	    "3:						\n"
+	    ".subsection 2				\n"
+	    "4:	setlos		%5,%2			\n"
+	    "	bra		3b			\n"
+	    ".previous					\n"
+	    ".section __ex_table,\"a\"			\n"
+	    "	.balign		8			\n"
+	    "	.long		1b,4b			\n"
+	    "	.long		2b,4b			\n"
+	    ".previous"
+	    : "+U"(*uaddr), "=&r"(oldval), "=&r"(ret), "=r"(oparg)
+	    : "3"(oparg), "i"(-EFAULT)
+	    : "memory", "cc7", "cc3", "icc3"
+	    );
+
+	*_oldval = oldval;
+	return ret;
+}
+
+static inline int atomic_futex_op_xchg_xor(int oparg, int __user *uaddr, int *_oldval)
+{
+	int oldval, ret;
+
+	asm("0:						\n"
+	    "	orcc		gr0,gr0,gr0,icc3	\n"	/* set ICC3.Z */
+	    "	ckeq		icc3,cc7		\n"
+	    "1:	ld.p		%M0,%1			\n"	/* LD.P/ORCR must be atomic */
+	    "	orcr		cc7,cc7,cc3		\n"	/* set CC3 to true */
+	    "	xor		%1,%3,%3		\n"
+	    "2:	cst.p		%3,%M0		,cc3,#1	\n"
+	    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	/* clear ICC3.Z if store happens */
+	    "	beq		icc3,#0,0b		\n"
+	    "	setlos		0,%2			\n"
+	    "3:						\n"
+	    ".subsection 2				\n"
+	    "4:	setlos		%5,%2			\n"
+	    "	bra		3b			\n"
+	    ".previous					\n"
+	    ".section __ex_table,\"a\"			\n"
+	    "	.balign		8			\n"
+	    "	.long		1b,4b			\n"
+	    "	.long		2b,4b			\n"
+	    ".previous"
+	    : "+U"(*uaddr), "=&r"(oldval), "=&r"(ret), "=r"(oparg)
+	    : "3"(oparg), "i"(-EFAULT)
+	    : "memory", "cc7", "cc3", "icc3"
+	    );
+
+	*_oldval = oldval;
+	return ret;
+}
+
+/*****************************************************************************/
+/*
+ * do the futex operations
+ */
+int futex_atomic_op_inuser(int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		ret = atomic_futex_op_xchg_set(oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_ADD:
+		ret = atomic_futex_op_xchg_add(oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_OR:
+		ret = atomic_futex_op_xchg_or(oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_ANDN:
+		ret = atomic_futex_op_xchg_and(~oparg, uaddr, &oldval);
+		break;
+	case FUTEX_OP_XOR:
+		ret = atomic_futex_op_xchg_xor(oparg, uaddr, &oldval);
+		break;
+	default:
+		ret = -ENOSYS;
+		break;
+	}
+
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS; break;
+		}
+	}
+
+	return ret;
+
+} /* end futex_atomic_op_inuser() */
diff -uNrp linux-2.6.15-rc2-frv/arch/frv/kernel/Makefile linux-2.6.15-rc2-frv-shmem/arch/frv/kernel/Makefile
--- linux-2.6.15-rc2-frv/arch/frv/kernel/Makefile	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/arch/frv/kernel/Makefile	2005-11-23 18:10:10.000000000 +0000
@@ -20,3 +20,4 @@ obj-$(CONFIG_FUJITSU_MB93493)	+= irq-mb9
 obj-$(CONFIG_PM)		+= pm.o cmode.o
 obj-$(CONFIG_MB93093_PDK)	+= pm-mb93093.o
 obj-$(CONFIG_SYSCTL)		+= sysctl.o
+obj-$(CONFIG_FUTEX)		+= futex.o
diff -uNrp linux-2.6.15-rc2-frv/include/asm-frv/futex.h linux-2.6.15-rc2-frv-shmem/include/asm-frv/futex.h
--- linux-2.6.15-rc2-frv/include/asm-frv/futex.h	2005-11-01 13:19:17.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/include/asm-frv/futex.h	2005-11-23 17:58:48.000000000 +0000
@@ -7,47 +7,7 @@
 #include <asm/errno.h>
 #include <asm/uaccess.h>
 
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
+extern int futex_atomic_op_inuser(int encoded_op, int __user *uaddr);
 
 #endif
 #endif
