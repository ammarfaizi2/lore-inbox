Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWGAE4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWGAE4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWGAE4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 00:56:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:52904 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964906AbWGAE4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 00:56:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] Add memcpy_nc,
	a copy routine that tries to keep cache pressure down
X-Mercurial-Node: c37555581c772bf5c94aeb975ace03c4b15f78d2
Message-Id: <c37555581c772bf5c94a.1151729772@eng-12.pathscale.com>
Date: Fri, 30 Jun 2006 21:56:12 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This copy routine is memcpy-compatible, but on some architectures will use
cache-bypassing loads to avoid bringing the source data into the cache.

One case where this is useful is when a device issues a DMA to a memory
region, and the CPU must copy the DMAed data elsewhere before doing any
work with it.  Since the source data is read-once, write-never from the
CPU's perspective, caching those addresses can only evict potentially
useful data.

We provide an x86_64 implementation that uses SSE non-temporal loads,
and a generic version that falls back to plain memcpy.

Implementors for other arches should not use cache-bypassing stores to
the destination, as in most cases, the destination is accessed almost
immediately after a copy finishes.

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 8bf6291faa35 -r c37555581c77 include/linux/string.h
--- a/include/linux/string.h	Fri Jun 30 21:48:02 2006 -0700
+++ b/include/linux/string.h	Fri Jun 30 21:48:02 2006 -0700
@@ -85,6 +85,7 @@ extern void * memset(void *,int,__kernel
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
 #endif
+extern void * memcpy_nc(void *,const void *,__kernel_size_t);
 #ifndef __HAVE_ARCH_MEMMOVE
 extern void * memmove(void *,const void *,__kernel_size_t);
 #endif
diff -r 8bf6291faa35 -r c37555581c77 lib/string.c
--- a/lib/string.c	Fri Jun 30 21:48:02 2006 -0700
+++ b/lib/string.c	Fri Jun 30 21:48:02 2006 -0700
@@ -509,6 +509,38 @@ EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memcpy);
 #endif
 
+void *memcpy_nc(void *dest, const void *src, size_t count)
+	__attribute__((weak));
+
+/**
+ * memcpy_nc - Copy one area of memory to another, if possible
+ * bypassing the CPU's cache when loading the copied-from data
+ * @dest: Where to copy to
+ * @src: Where to copy from (bypassing the CPU's cache, if possible)
+ * @count: The size of the area.
+ *
+ * This memcpy-compatible routine is intended for use when the CPU
+ * only reads the source data once.  It is useful when, for example, a
+ * hardware device writes to a memory region, and the CPU needs to
+ * copy this data somewhere else before working on it.  In such a
+ * case, caching the source addresses only serves to evict possibly
+ * useful data that will probably have to be reloaded.
+ *
+ * An arch-specific implementation should not attempt to bypass the
+ * cache when storing to the destination, as copied data is usually
+ * accessed almost immediately after a copy finishes.
+ *
+ * This routine does not *guarantee* that the source addresses won't
+ * be cached; a user of this code must not rely on this behaviour for
+ * correctness.  It should only be used in cases where it provides a
+ * measurable performance improvement.
+ */
+void *memcpy_nc(void *dest, const void *src, size_t count)
+{
+	return memcpy(dest, src, count);
+}
+EXPORT_SYMBOL_GPL(memcpy_nc);
+
 #ifndef __HAVE_ARCH_MEMMOVE
 /**
  * memmove - Copy one area of memory to another
diff -r 8bf6291faa35 -r c37555581c77 arch/x86_64/lib/memcpy_nc.S
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/memcpy_nc.S	Fri Jun 30 21:48:02 2006 -0700
@@ -0,0 +1,142 @@
+/*
+ * Copyright (c) 2006 QLogic, Inc.  All Rights Reserved.
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
+ * memcpy_nc - memcpy-compatible copy routine, using streaming loads
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
+	.globl	memcpy_nc
+	.type	memcpy_nc, @function
+memcpy_nc:
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
