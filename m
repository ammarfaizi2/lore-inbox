Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWDXPEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWDXPEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWDXPEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:04:42 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:27215 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750865AbWDXPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:04:40 -0400
Date: Mon, 24 Apr 2006 17:04:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch 8/13] s390: futex atomic operations.
Message-ID: <20060424150443.GI15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 8/13] s390: futex atomic operations.

Add support for atomic futex operations.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/futex.h |   96 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 92 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/include/asm-s390/futex.h linux-2.6-patched/include/asm-s390/futex.h
--- linux-2.6/include/asm-s390/futex.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/futex.h	2006-04-24 16:47:25.000000000 +0200
@@ -1,6 +1,94 @@
-#ifndef _ASM_FUTEX_H
-#define _ASM_FUTEX_H
+#ifndef _ASM_S390_FUTEX_H
+#define _ASM_S390_FUTEX_H
 
-#include <asm-generic/futex.h>
+#ifdef __KERNEL__
 
-#endif
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+#ifndef __s390x__
+#define __futex_atomic_fixup \
+		     ".section __ex_table,\"a\"\n"			\
+		     "   .align 4\n"					\
+		     "   .long  0b,2b,1b,2b\n"				\
+		     ".previous"
+#else /* __s390x__ */
+#define __futex_atomic_fixup \
+		     ".section __ex_table,\"a\"\n"			\
+		     "   .align 8\n"					\
+		     "   .quad  0b,2b,1b,2b\n"				\
+		     ".previous"
+#endif /* __s390x__ */
+
+#define __futex_atomic_op(insn, ret, oldval, newval, uaddr, oparg)	\
+	asm volatile("   l   %1,0(%6)\n"				\
+		     "0: " insn						\
+		     "   cs  %1,%2,0(%6)\n"				\
+		     "1: jl  0b\n"					\
+		     "   lhi %0,0\n"					\
+		     "2:\n"						\
+		     __futex_atomic_fixup				\
+		     : "=d" (ret), "=&d" (oldval), "=&d" (newval),	\
+		       "=m" (*(unsigned long __user *) uaddr)		\
+		     : "0" (-EFAULT), "d" (oparg), "a" (uaddr),		\
+		       "m" (*(unsigned long __user *) uaddr) : "cc" );
+
+static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, newval, ret;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
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
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_S390_FUTEX_H */
