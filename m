Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUKAWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUKAWNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S286860AbUKAWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:13:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291930AbUKATae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:34 -0500
Date: Mon, 1 Nov 2004 19:30:20 GMT
Message-Id: <200411011930.iA1JUK4w023176@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 4/14] FRV: Bitops fixes
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides an out-of-line implementation of find_next_bit(),
and rearranges linux/bitops.h to avoid a dependency loop between inline
functions in there and in asm/bitops.h trying to include one another.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-bitops-2610rc1bk10.diff
 include/linux/bitops.h |    3 +-
 lib/Makefile           |    2 -
 lib/find_next_bit.c    |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/bitops.h linux-2.6.10-rc1-bk10-frv/include/linux/bitops.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/bitops.h	2004-06-18 13:42:16.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/include/linux/bitops.h	2004-11-01 11:47:05.091638567 +0000
@@ -1,7 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
 #include <asm/types.h>
-#include <asm/bitops.h>
 
 /*
  * ffs: find first bit set. This is defined the same way as
@@ -71,6 +70,8 @@
 	return r;
 }
 
+#include <asm/bitops.h>
+
 extern __inline__ int get_bitmask_order(unsigned int count)
 {
 	int order;
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/lib/find_next_bit.c linux-2.6.10-rc1-bk10-frv/lib/find_next_bit.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/lib/find_next_bit.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/lib/find_next_bit.c	2004-11-01 11:47:05.188630493 +0000
@@ -0,0 +1,55 @@
+/* find_next_bit.c: fallback find next bit implementation
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/bitops.h>
+
+int find_next_bit(const unsigned long *addr, int size, int offset)
+{
+	const unsigned long *base;
+	const int NBITS = sizeof(*addr) * 8;
+	unsigned long tmp;
+
+	base = addr;
+	if (offset) {
+		int suboffset;
+
+		addr += offset / NBITS;
+
+		suboffset = offset % NBITS;
+		if (suboffset) {
+			tmp = *addr;
+			tmp >>= suboffset;
+			if (tmp)
+				goto finish;
+		}
+
+		addr++;
+	}
+
+	while ((tmp = *addr) == 0)
+		addr++;
+
+	offset = (addr - base) * NBITS;
+
+ finish:
+	/* count the remaining bits without using __ffs() since that takes a 32-bit arg */
+	while (!(tmp & 0xff)) {
+		offset += 8;
+		tmp >>= 8;
+	}
+
+	while (!(tmp & 1)) {
+		offset++;
+		tmp >>= 1;
+	}
+
+	return offset;
+}
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/lib/Makefile linux-2.6.10-rc1-bk10-frv/lib/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-bk10/lib/Makefile	2004-11-01 11:45:34.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/lib/Makefile	2004-11-01 12:00:25.742993383 +0000
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o
+	 bitmap.o extable.o kobject_uevent.o find_next_bit.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
