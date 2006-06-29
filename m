Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932923AbWF2Vo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbWF2Vo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbWF2VoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:24 -0400
Received: from mx.pathscale.com ([64.160.42.68]:40847 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932918AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA interrupt
	handler to reduce packet loss
X-Mercurial-Node: 1b00209ef20a0e7893d816ad92279caa89531cb9
Message-Id: <1b00209ef20a0e7893d8.1151617290@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:30 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where a large incoming RDMA is being received, we have to
copy data inside the interrupt handler before we can ACK each packet.
The source is DMAed to by the hardware, which means that the CPU won't
have it cached.  We only read the source this one time; using normal load
instructions pollutes the dcache with useless data, reducing performance
to the point where we can lose a significant number of packets.

Using a (memcpy-compatible) copy routine that loads with streaming
instructions, we try to not fill the dcache with useless data.  Avoiding
the cache refill penalty lets us keep up better with the sender, resulting
in many fewer dropped packets.  We use normal stores to the destination,
because the copied-to data will be used soon after the interrupt handler
completes.

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r c22b6c244d5d -r 1b00209ef20a drivers/infiniband/hw/ipath/Makefile
--- a/drivers/infiniband/hw/ipath/Makefile	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Makefile	Thu Jun 29 14:33:26 2006 -0700
@@ -35,3 +35,5 @@ ib_ipath-y := \
 	ipath_ud.o \
 	ipath_verbs.o \
 	ipath_verbs_mcast.o
+
+ib_ipath-$(CONFIG_X86_64) += ipath_memcpy_x86_64.o
diff -r c22b6c244d5d -r 1b00209ef20a drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -159,7 +159,7 @@ void ipath_copy_sge(struct ipath_sge_sta
 		BUG_ON(len == 0);
 		if (len > length)
 			len = length;
-		memcpy(sge->vaddr, data, len);
+		ipath_memcpy_nc(sge->vaddr, data, len);
 		sge->vaddr += len;
 		sge->length -= len;
 		sge->sge_length -= len;
diff -r c22b6c244d5d -r 1b00209ef20a drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:26 2006 -0700
@@ -728,4 +728,14 @@ extern unsigned int ib_ipath_max_srq_wrs
 
 extern const u32 ib_ipath_rnr_table[];
 
+/*
+ * Copy data.  Try not to pollute the dcache with the source data,
+ * because we won't be reading it again.
+ */
+#if defined(CONFIG_X86_64)
+void *ipath_memcpy_nc(void *dest, const void *src, size_t n);
+#else
+#define ipath_memcpy_nc(dest, src, n) memcpy(dest, src, n)
+#endif
+
 #endif				/* IPATH_VERBS_H */
diff -r c22b6c244d5d -r 1b00209ef20a drivers/infiniband/hw/ipath/ipath_memcpy_x86_64.S
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_memcpy_x86_64.S	Thu Jun 29 14:33:26 2006 -0700
@@ -0,0 +1,157 @@
+/*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ * ipath_memcpy_nc - memcpy-compatible copy routine, using streaming loads
+ * @dest: destination address
+ * @src: source address
+ * @count: number of bytes to copy
+ *
+ * Use streaming loads and normal stores for a special-case copy where
+ * we know we won't be reading the source again, but will be reading the
+ * destination again soon.
+ */
+	.text
+	.p2align 4,,15
+	/* rdi  destination, rsi source, rdx count */
+	.globl	ipath_memcpy_nc
+	.type	ipath_memcpy_nc, @function
+ipath_memcpy_nc:
+	movq	%rdi, %rax
+.L5:
+	cmpq	$15, %rdx
+	ja	.L34
+.L3:
+	cmpl	$8, %edx	/* rdx is 0..15 */
+	jbe	.L9
+.L6:
+	testb	$8, %dxl	/* rdx is 3,5,6,7,9..15 */
+	je	.L13
+	movq	(%rsi), %rcx
+	addq	$8, %rsi
+	movq	%rcx, (%rdi)
+	addq	$8, %rdi
+.L13:
+	testb	$4, %dxl
+	je	.L15
+	movl	(%rsi), %ecx
+	addq	$4, %rsi
+	movl	%ecx, (%rdi)
+	addq	$4, %rdi
+.L15:
+	testb	$2, %dxl
+	je	.L17
+	movzwl	(%rsi), %ecx
+	addq	$2, %rsi
+	movw	%cx, (%rdi)
+	addq	$2, %rdi
+.L17:
+	testb	$1, %dxl
+	je	.L33
+.L1:
+	movzbl	(%rsi), %ecx
+	movb	%cl, (%rdi)
+.L33:
+	ret
+.L34:
+	cmpq	$63, %rdx	/* rdx is > 15 */
+	ja	.L64
+	movl	$16, %ecx	/* rdx is 16..63 */
+.L25:
+	movq	8(%rsi), %r8
+	movq	(%rsi), %r9
+	addq	%rcx, %rsi
+	movq	%r8, 8(%rdi)
+	movq	%r9, (%rdi)
+	addq	%rcx, %rdi
+	subq	%rcx, %rdx
+	cmpl	%edx, %ecx	/* is rdx >= 16? */
+	jbe	.L25
+	jmp	.L3		/* rdx is 0..15 */
+	.p2align 4,,7
+.L64:
+	movl	$64, %ecx
+.L42:
+	prefetchnta	128(%rsi)
+	movq	(%rsi), %r8
+	movq	8(%rsi), %r9
+	movq	16(%rsi), %r10
+	movq	24(%rsi), %r11
+	subq	%rcx, %rdx
+	movq	%r8, (%rdi)
+	movq	32(%rsi), %r8
+	movq	%r9, 8(%rdi)
+	movq	40(%rsi), %r9
+	movq	%r10, 16(%rdi)
+	movq	48(%rsi), %r10
+	movq	%r11, 24(%rdi)
+	movq	56(%rsi), %r11
+	addq	%rcx, %rsi
+	movq	%r8, 32(%rdi)
+	movq	%r9, 40(%rdi)
+	movq	%r10, 48(%rdi)
+	movq	%r11, 56(%rdi)
+	addq	%rcx, %rdi
+	cmpq	%rdx, %rcx	/* is rdx >= 64? */
+	jbe	.L42
+	sfence
+	orl	%edx, %edx
+	je	.L33
+	jmp	.L5
+.L9:
+	jmp	*.L12(,%rdx,8)	/* rdx is 0..8 */
+	.section	.rodata
+	.align 8
+	.align 4
+.L12:
+	.quad	.L33
+	.quad	.L1
+	.quad	.L2
+	.quad	.L6
+	.quad	.L4
+	.quad	.L6
+	.quad	.L6
+	.quad	.L6
+	.quad	.L8
+	.text
+.L2:
+	movzwl	(%rsi), %ecx
+	movw	%cx, (%rdi)
+	ret
+.L4:
+	movl	(%rsi), %ecx
+	movl	%ecx, (%rdi)
+	ret
+.L8:
+	movq	(%rsi), %rcx
+	movq	%rcx, (%rdi)
+	ret
