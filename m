Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWAKWl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWAKWl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWAKWl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:41:29 -0500
Received: from mx.pathscale.com ([64.160.42.68]:19148 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932457AbWAKWl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:41:27 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 3] memcpy32 for x86_64
X-Mercurial-Node: 1052904816d73f208585b83efdb99e605a7e1fa5
Message-Id: <1052904816d73f208585.1137019196@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137019194@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 14:39:56 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an x86_64-specific memcpy32 routine.  The routine is similar
to memcpy, but is guaranteed to work in units of 32 bits at a time.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 05b3d1af27eb -r 1052904816d7 arch/x86_64/kernel/x8664_ksyms.c
--- a/arch/x86_64/kernel/x8664_ksyms.c	Wed Jan 11 14:35:45 2006 -0800
+++ b/arch/x86_64/kernel/x8664_ksyms.c	Wed Jan 11 14:35:45 2006 -0800
@@ -163,6 +163,8 @@
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
 
+EXPORT_SYMBOL_GPL(memcpy32);
+
 #ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 /* prototypes are wrong, these are assembly with custom calling functions */
 extern void rwsem_down_read_failed_thunk(void);
diff -r 05b3d1af27eb -r 1052904816d7 arch/x86_64/lib/Makefile
--- a/arch/x86_64/lib/Makefile	Wed Jan 11 14:35:45 2006 -0800
+++ b/arch/x86_64/lib/Makefile	Wed Jan 11 14:35:45 2006 -0800
@@ -9,4 +9,4 @@
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
-lib-y += memcpy.o memmove.o memset.o copy_user.o
+lib-y += memcpy.o memcpy32.o memmove.o memset.o copy_user.o
diff -r 05b3d1af27eb -r 1052904816d7 include/asm-x86_64/string.h
--- a/include/asm-x86_64/string.h	Wed Jan 11 14:35:45 2006 -0800
+++ b/include/asm-x86_64/string.h	Wed Jan 11 14:35:45 2006 -0800
@@ -45,6 +45,9 @@
 #define __HAVE_ARCH_MEMMOVE
 void * memmove(void * dest,const void *src,size_t count);
 
+/* copy data, 32 bits at a time */
+void memcpy32(void *dst, const void *src, size_t count);
+
 /* Use C out of line version for memcmp */ 
 #define memcmp __builtin_memcmp
 int memcmp(const void * cs,const void * ct,size_t count);
diff -r 05b3d1af27eb -r 1052904816d7 arch/x86_64/lib/memcpy32.S
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/arch/x86_64/lib/memcpy32.S	Wed Jan 11 14:35:45 2006 -0800
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2006 PathScale, Inc.  All Rights Reserved.
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
+/**
+ * memcpy32 - copy data, in units of 32 bits at a time
+ * @dst: destination (must be 32-bit aligned)
+ * @src: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ */
+ 	.globl memcpy32
+memcpy32:
+	movl %edx,%ecx
+	shrl $1,%ecx
+	andl $1,%edx
+	rep movsq
+	movl %edx,%ecx
+	rep movsd
+	ret
