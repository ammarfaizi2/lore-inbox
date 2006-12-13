Return-Path: <linux-kernel-owner+w=401wt.eu-S932453AbWLMSbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWLMSbz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWLMSbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:31:36 -0500
Received: from [198.186.3.68] ([198.186.3.68]:38746 "EHLO mx.pathscale.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932657AbWLMSbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:31:34 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] Add memcpy_uncached_read,
	a memcpy that tries to reduce cache pressure
X-Mercurial-Node: e7c3b265254b705286f13ec15d90b56884bafaae
Message-Id: <e7c3b265254b705286f1.1166032640@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1166032639@eng-12.pathscale.com>
Date: Wed, 13 Dec 2006 09:57:20 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This copy routine is memcpy-compatible, but on some architectures will use
cache-bypassing loads to avoid bringing the source data into the cache.

One case where this is useful is when a device issues a DMA to a memory
region, and the CPU must copy the DMAed data elsewhere before doing any
work with it.  Since the source data is read-once, write-never from the
CPU's perspective, caching the data at those addresses can only evict
potentially useful data.

We provide an x86_64 implementation that uses SSE non-temporal loads,
and a generic version that falls back to plain memcpy.

Implementors for other arches should not use cache-bypassing stores to
the destination, as in most cases, the destination is accessed almost
immediately after a copy finishes.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 4a0c3ede5076 -r e7c3b265254b arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Tue Dec 12 10:43:21 2006 -0800
+++ b/arch/x86_64/lib/Makefile	Wed Dec 13 09:51:09 2006 -0800
@@ -9,4 +9,5 @@ lib-y := csum-partial.o csum-copy.o csum
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
-lib-y += memcpy.o memmove.o memset.o copy_user.o rwlock.o
+lib-y += memcpy.o memmove.o memset.o copy_user.o rwlock.o \
+	memcpy_uncached_read.o
diff -r 4a0c3ede5076 -r e7c3b265254b arch/x86_64/lib/memcpy_uncached_read.S
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/memcpy_uncached_read.S	Wed Dec 13 09:51:09 2006 -0800
@@ -0,0 +1,142 @@
+/*
+ * Copyright (c) 2006 QLogic Corporation.  All Rights Reserved.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+/*
+ * memcpy_uncached_read - memcpy-compatible copy routine, using streaming loads
+ * @dest: destination address
+ * @src: source address (will not be cached)
+ * @count: number of bytes to copy
+ *
+ * Use streaming loads and normal stores for a special-case copy where
+ * we know we won't be reading the source again, but will be reading the
+ * destination again soon.
+ */
+	.text
+	.p2align 4,,15
+	/* rdi  destination, rsi source, rdx count */
+	.globl	memcpy_uncached_read
+	.type	memcpy_uncached_read, @function
+memcpy_uncached_read:
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
diff -r 4a0c3ede5076 -r e7c3b265254b include/asm-x86_64/string.h
--- a/include/asm-x86_64/string.h	Tue Dec 12 10:43:21 2006 -0800
+++ b/include/asm-x86_64/string.h	Wed Dec 13 09:51:09 2006 -0800
@@ -39,6 +39,8 @@ extern void *__memcpy(void *to, const vo
 		 __ret = __builtin_memcpy((dst),(src),__len);	\
 	   __ret; }) 
 
+#define __HAVE_ARCH_MEMCPY_UNCACHED_READ
+extern void *memcpy_uncached_read(void *to, const void *from, size_t len); 
 
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
diff -r 4a0c3ede5076 -r e7c3b265254b include/linux/string.h
--- a/include/linux/string.h	Tue Dec 12 10:43:21 2006 -0800
+++ b/include/linux/string.h	Wed Dec 13 09:51:09 2006 -0800
@@ -85,6 +85,9 @@ extern void * memset(void *,int,__kernel
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_MEMCPY_UNCACHED_READ
+#define memcpy_uncached_read(dest, src, count) memcpy((dest), (src), (count))
+#endif
 #ifndef __HAVE_ARCH_MEMMOVE
 extern void * memmove(void *,const void *,__kernel_size_t);
 #endif
