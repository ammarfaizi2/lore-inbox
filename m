Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVLWBgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVLWBgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVLWBgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:36:11 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9349 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751234AbVLWBgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:36:10 -0500
Subject: [RFC] [PATCH] Add memcpy32 function
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 22 Dec 2005 17:35:59 -0800
Message-Id: <1135301759.4212.76.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to the comments that followed Roland Dreier posting our
InfiniPath driver for review last week, we've been making some cleanups
to our driver code.

As our chip requires 32-bit accesses, we need a copy function that
guarantees operating in such terms.  It was suggested that we make this
generic, with arch-specific optimised versions.

This patch introduces the generic copy routine, memcpy32.  At Andrew's
suggestion, I've put it in a new header file, include/linux/io.h, which
I've styled after include/linux/string.h.

Linus made some comments this morning about the manner in which the
functions in string.h are provided, but I wanted to float this patch for
review in any case, if only to see whether the alternative really is
preferred.

If desired, I can introduce instead an
include/asm-generic/memcpy32-algo.h header which defines the generic
memcpy32 routine, and edit all 20-odd asm-*/io.h files to use it.  That
seems wasteful, though.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 0a6978881777 lib/Makefile
--- a/lib/Makefile	Fri Dec 23 01:41:03 2005 +0800
+++ b/lib/Makefile	Thu Dec 22 15:45:05 2005 -0800
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o io.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
diff -r 0a6978881777 include/linux/io.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/linux/io.h	Thu Dec 22 15:45:05 2005 -0800
@@ -0,0 +1,32 @@
+#ifndef _LINUX_IO_H_
+#define _LINUX_IO_H_
+
+#include <linux/types.h>
+
+#ifdef __KERNEL__
+
+/*
+ * Include machine specific inline routines.
+ */
+#include <asm/io.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifndef __HAVE_ARCH_MEMCPY32
+/*
+ * Copy routine that is guaranteed to operate in terms of 32-bit
+ * quantities.  Source and dest must be 32-bit aligned.  Count is
+ * number of 32-bit quantities (NOT bytes) to copy.
+ */
+void *memcpy32(void *, const void *, __kernel_size_t);
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_IO_H_ */
diff -r 0a6978881777 lib/io.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/io.c	Thu Dec 22 15:45:05 2005 -0800
@@ -0,0 +1,21 @@
+#include <linux/io.h>
+
+#ifndef __HAVE_ARCH_MEMCPY32
+/**
+ * memcpy32 - Copy one area of memory to another, as a series of
+ * aligned 32-bit values.
+ * @dest: Where to copy to (must be 32-bit aligned)
+ * @src: Where to copy from (must be 32-bit aligned)
+ * @count: The number of 32-bit values to copy
+ */
+void *memcpy32(void *dest, const void *src, size_t count)
+{
+	u32 *tmp = dest;
+	u32 *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+EXPORT_SYMBOL_GPL(memcpy32);
+#endif


