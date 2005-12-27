Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVL0Xpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVL0Xpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVL0Xp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:45:29 -0500
Received: from mx.pathscale.com ([64.160.42.68]:44494 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932406AbVL0Xp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:45:26 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 3] memcpy32 for x86_64
X-Mercurial-Node: 042b7d9004acd65f6655faba88c8e236be7b9b09
Message-Id: <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135726914@eng-12.pathscale.com>
Date: Tue, 27 Dec 2005 15:41:56 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Cc: mpm@selenic.com, akpm@osdl.org, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an x86_64-specific memcpy32 routine.  The routine is similar
to memcpy, but is guaranteed to work in units of 32 bits at a time.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 7b7b442a4d63 -r 042b7d9004ac arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	Tue Dec 27 15:41:48 2005 -0800
+++ b/arch/x86_64/kernel/x8664_ksyms.c	Tue Dec 27 15:41:48 2005 -0800
@@ -150,6 +150,8 @@
 extern void * memcpy(void *,const void *,__kernel_size_t);
 extern void * __memcpy(void *,const void *,__kernel_size_t);
 
+extern void memcpy32(void *,const void *,__kernel_size_t);
+
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(memmove);
@@ -164,6 +166,8 @@
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
 
+EXPORT_SYMBOL_GPL(memcpy32);
+
 #ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 /* prototypes are wrong, these are assembly with custom calling functions */
 extern void rwsem_down_read_failed_thunk(void);
diff -r 7b7b442a4d63 -r 042b7d9004ac arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Tue Dec 27 15:41:48 2005 -0800
+++ b/arch/x86_64/lib/Makefile	Tue Dec 27 15:41:48 2005 -0800
@@ -9,4 +9,4 @@
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
-lib-y += memcpy.o memmove.o memset.o copy_user.o
+lib-y += memcpy.o memcpy32.o memmove.o memset.o copy_user.o
diff -r 7b7b442a4d63 -r 042b7d9004ac include/asm-x86_64/string.h
--- a/include/asm-x86_64/string.h	Tue Dec 27 15:41:48 2005 -0800
+++ b/include/asm-x86_64/string.h	Tue Dec 27 15:41:48 2005 -0800
@@ -45,6 +45,8 @@
 #define __HAVE_ARCH_MEMMOVE
 void * memmove(void * dest,const void *src,size_t count);
 
+void memcpy32(void *dst, const void *src, size_t count);
+
 /* Use C out of line version for memcmp */ 
 #define memcmp __builtin_memcmp
 int memcmp(const void * cs,const void * ct,size_t count);
diff -r 7b7b442a4d63 -r 042b7d9004ac arch/x86_64/lib/memcpy32.S
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/memcpy32.S	Tue Dec 27 15:41:48 2005 -0800
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2003, 2004, 2005 PathScale, Inc.
+ */
+
+/*
+ * memcpy32 - Copy a memory block, 32 bits at a time.
+ *
+ * Count is number of dwords; it need not be a qword multiple.
+ * Input:
+ * rdi destination
+ * rsi source
+ * rdx count
+ */
+
+ 	.globl memcpy32
+memcpy32:
+	movl %edx,%ecx
+	shrl $1,%ecx
+	andl $1,%edx
+	rep
+	movsq
+	movl %edx,%ecx
+	rep
+	movsd
+	ret
