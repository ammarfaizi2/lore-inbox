Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967460AbWK2Xi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967460AbWK2Xi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967678AbWK2XiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:38:01 -0500
Received: from [198.186.3.68] ([198.186.3.68]:680 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S967460AbWK2Xh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:37:58 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] Add memcpy_cachebypass,
	a memcpy that tries to reduce cache pressure
X-Mercurial-Node: 3300b7b66f4678bbef9ed92a0f9bf88c4fc2fd8a
Message-Id: <3300b7b66f4678bbef9e.1164843308@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1164843307@eng-12.pathscale.com>
Date: Wed, 29 Nov 2006 15:35:08 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akmp@osdl.org
Cc: rdreier@cisco.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
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

diff -r c76ed2f1387b -r 3300b7b66f46 arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Wed Nov 29 13:28:14 2006 +0800
+++ b/arch/x86_64/lib/Makefile	Wed Nov 29 15:34:11 2006 -0800
@@ -9,4 +9,5 @@ lib-y := csum-partial.o csum-copy.o csum
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
-lib-y += memcpy.o memmove.o memset.o copy_user.o rwlock.o
+lib-y += memcpy.o memmove.o memset.o copy_user.o rwlock.o \
+	memcpy_cachebypass.o
diff -r c76ed2f1387b -r 3300b7b66f46 arch/x86_64/lib/memcpy_cachebypass.S
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/memcpy_cachebypass.S	Wed Nov 29 15:34:11 2006 -0800
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
+ * memcpy_cachebypass - memcpy-compatible copy routine, using streaming loads
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
+	.globl	memcpy_cachebypass
+	.type	memcpy_cachebypass, @function
+memcpy_cachebypass:
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
diff -r c76ed2f1387b -r 3300b7b66f46 include/asm-x86_64/string.h
--- a/include/asm-x86_64/string.h	Wed Nov 29 13:28:14 2006 +0800
+++ b/include/asm-x86_64/string.h	Wed Nov 29 15:34:11 2006 -0800
@@ -39,6 +39,8 @@ extern void *__memcpy(void *to, const vo
 		 __ret = __builtin_memcpy((dst),(src),__len);	\
 	   __ret; }) 
 
+#define __HAVE_ARCH_MEMCPY_CACHEBYPASS
+extern void *memcpy_cachebypass(void *to, const void *from, size_t len); 
 
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
diff -r c76ed2f1387b -r 3300b7b66f46 include/linux/string.h
--- a/include/linux/string.h	Wed Nov 29 13:28:14 2006 +0800
+++ b/include/linux/string.h	Wed Nov 29 15:34:11 2006 -0800
@@ -85,6 +85,9 @@ extern void * memset(void *,int,__kernel
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_MEMCPY_CACHEBYPASS
+#define memcpy_cachebypass(dest, src, count) memcpy((dest), (src), (count))
+#endif
 #ifndef __HAVE_ARCH_MEMMOVE
 extern void * memmove(void *,const void *,__kernel_size_t);
 #endif
