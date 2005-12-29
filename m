Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVL2AoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVL2AoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVL2AjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:13 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42472 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932569AbVL2AjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:08 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 20] memcpy32 for x86_64
X-Mercurial-Node: 801287704e408ed65660d9430ee519955b6fbfea
Message-Id: <801287704e408ed65660.1135816281@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:21 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an x86_64-specific memcpy32 routine.  The routine is similar
to memcpy, but is guaranteed to work in units of 32 bits at a time.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ef833f6712e7 -r 801287704e40 arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	Wed Dec 28 14:19:42 2005 -0800
+++ b/arch/x86_64/kernel/x8664_ksyms.c	Wed Dec 28 14:19:42 2005 -0800
@@ -164,6 +164,8 @@
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
 
+EXPORT_SYMBOL_GPL(memcpy32);
+
 #ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 /* prototypes are wrong, these are assembly with custom calling functions */
 extern void rwsem_down_read_failed_thunk(void);
diff -r ef833f6712e7 -r 801287704e40 arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Wed Dec 28 14:19:42 2005 -0800
+++ b/arch/x86_64/lib/Makefile	Wed Dec 28 14:19:42 2005 -0800
@@ -9,4 +9,4 @@
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
-lib-y += memcpy.o memmove.o memset.o copy_user.o
+lib-y += memcpy.o memcpy32.o memmove.o memset.o copy_user.o
diff -r ef833f6712e7 -r 801287704e40 include/asm-x86_64/string.h
--- a/include/asm-x86_64/string.h	Wed Dec 28 14:19:42 2005 -0800
+++ b/include/asm-x86_64/string.h	Wed Dec 28 14:19:42 2005 -0800
@@ -45,6 +45,15 @@
 #define __HAVE_ARCH_MEMMOVE
 void * memmove(void * dest,const void *src,size_t count);
 
+/*
+ * memcpy32 - copy data, 32 bits at a time
+ *
+ * @dst: destination (must be 32-bit aligned)
+ * @src: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ */
+void memcpy32(void *dst, const void *src, size_t count);
+
 /* Use C out of line version for memcmp */ 
 #define memcmp __builtin_memcmp
 int memcmp(const void * cs,const void * ct,size_t count);
diff -r ef833f6712e7 -r 801287704e40 arch/x86_64/lib/memcpy32.S
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/memcpy32.S	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,23 @@
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
+	rep movsq
+	movl %edx,%ecx
+	rep movsd
+	ret
