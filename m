Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVAJLlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVAJLlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVAJLlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:41:05 -0500
Received: from ozlabs.org ([203.10.76.45]:33176 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262212AbVAJLkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:40:35 -0500
Date: Mon, 10 Jan 2005 22:39:27 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linas@austin.ibm.com
Subject: [PATCH] ppc64: fix xmon longjmp handling
Message-ID: <20050110113927.GQ14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It turns out gcc decides to allocate a stack frame in the current xmon
setjmp function. This means the stack linkage we save away is destroyed
when returning from it and its just a matter of time before another
function stomps on it.

This should fix the problem Linas reported this week.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN /dev/null arch/ppc64/xmon/setjmp.S
--- /dev/null	2004-12-08 17:25:40.367594856 +1100
+++ foobar2-anton/arch/ppc64/xmon/setjmp.S	2005-01-10 20:48:12.129869286 +1100
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 1996 Paul Mackerras.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ * NOTE: assert(sizeof(buf) > 184)
+ */
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+
+_GLOBAL(xmon_setjmp)
+	mflr    r0
+	std     r0,0(r3)
+	std     r1,8(r3)
+	std     r2,16(r3)
+	mfcr    r0
+	std     r0,24(r3)
+	std     r13,32(r3)
+	std     r14,40(r3)
+	std     r15,48(r3)
+	std     r16,56(r3)
+	std     r17,64(r3)
+	std     r18,72(r3)
+	std     r19,80(r3)
+	std     r20,88(r3)
+	std     r21,96(r3)
+	std     r22,104(r3)
+	std     r23,112(r3)
+	std     r24,120(r3)
+	std     r25,128(r3)
+	std     r26,136(r3)
+	std     r27,144(r3)
+	std     r28,152(r3)
+	std     r29,160(r3)
+	std     r30,168(r3)
+	std     r31,176(r3)
+	li      r3,0
+	blr
+
+_GLOBAL(xmon_longjmp)
+	cmpdi   r4,0
+	bne     1f
+	li      r4,1
+1:	ld      r13,32(r3)
+	ld      r14,40(r3)
+	ld      r15,48(r3)
+	ld      r16,56(r3)
+	ld      r17,64(r3)
+	ld      r18,72(r3)
+	ld      r19,80(r3)
+	ld      r20,88(r3)
+	ld      r21,96(r3)
+	ld      r22,104(r3)
+	ld      r23,112(r3)
+	ld      r24,120(r3)
+	ld      r25,128(r3)
+	ld      r26,136(r3)
+	ld      r27,144(r3)
+	ld      r28,152(r3)
+	ld      r29,160(r3)
+	ld      r30,168(r3)
+	ld      r31,176(r3)
+	ld      r0,24(r3)
+	mtcrf   56,r0
+	ld      r0,0(r3)
+	ld      r1,8(r3)
+	ld      r2,16(r3)
+	mtlr    r0
+	mr      r3,r4
+	blr
diff -L arch/ppc64/xmon/setjmp.c -puN arch/ppc64/xmon/setjmp.c~debug_xmon /dev/null
--- foobar2/arch/ppc64/xmon/setjmp.c
+++ /dev/null	2004-12-08 17:25:40.367594856 +1100
@@ -1,77 +0,0 @@
-/*
- * Copyright (C) 1996 Paul Mackerras.
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- *
- * NB this file must be compiled with -O2.
- */
-
-int
-xmon_setjmp(long *buf)  /* NOTE: assert(sizeof(buf) > 184) */
-{
-	/* XXX should save fp regs as well */
-	asm volatile (
-	"mflr 0; std 0,0(%0)\n\
-	 std	1,8(%0)\n\
-	 std	2,16(%0)\n\
-	 mfcr 0; std 0,24(%0)\n\
-	 std	13,32(%0)\n\
-	 std	14,40(%0)\n\
-	 std	15,48(%0)\n\
-	 std	16,56(%0)\n\
-	 std	17,64(%0)\n\
-	 std	18,72(%0)\n\
-	 std	19,80(%0)\n\
-	 std	20,88(%0)\n\
-	 std	21,96(%0)\n\
-	 std	22,104(%0)\n\
-	 std	23,112(%0)\n\
-	 std	24,120(%0)\n\
-	 std	25,128(%0)\n\
-	 std	26,136(%0)\n\
-	 std	27,144(%0)\n\
-	 std	28,152(%0)\n\
-	 std	29,160(%0)\n\
-	 std	30,168(%0)\n\
-	 std	31,176(%0)\n\
-	 " : : "r" (buf));
-    return 0;
-}
-
-void
-xmon_longjmp(long *buf, int val)
-{
-	if (val == 0)
-		val = 1;
-	asm volatile (
-	"ld	13,32(%0)\n\
-	 ld	14,40(%0)\n\
-	 ld	15,48(%0)\n\
-	 ld	16,56(%0)\n\
-	 ld	17,64(%0)\n\
-	 ld	18,72(%0)\n\
-	 ld	19,80(%0)\n\
-	 ld	20,88(%0)\n\
-	 ld	21,96(%0)\n\
-	 ld	22,104(%0)\n\
-	 ld	23,112(%0)\n\
-	 ld	24,120(%0)\n\
-	 ld	25,128(%0)\n\
-	 ld	26,136(%0)\n\
-	 ld	27,144(%0)\n\
-	 ld	28,152(%0)\n\
-	 ld	29,160(%0)\n\
-	 ld	30,168(%0)\n\
-	 ld	31,176(%0)\n\
-	 ld	0,24(%0)\n\
-	 mtcrf	0x38,0\n\
-	 ld	0,0(%0)\n\
-	 ld	1,8(%0)\n\
-	 ld	2,16(%0)\n\
-	 mtlr	0\n\
-	 mr	3,%1\n\
-	 " : : "r" (buf), "r" (val));
-}
_
