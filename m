Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUKHOlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUKHOlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUKHOfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:35:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64704 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261850AbUKHOc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:32:59 -0500
Date: Mon, 8 Nov 2004 14:32:41 GMT
Message-Id: <200411081432.iA8EWfnc023411@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] Bit operations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides an out-of-line implementation of find_next_bit()
and rearranges linux/bitops.h to avoid a dependency loop between inline
functions in there and in asm/bitops.h trying to include one another.

Signed-Off-By: dhowells@redhat.com
---
diffstat bitops-2610rc1mm3.diff
 include/linux/bitops.h |    3 +-
 lib/Makefile           |    1 
 lib/find_next_bit.c    |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/bitops.h linux-2.6.10-rc1-mm3-frv/include/linux/bitops.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/bitops.h	2004-06-18 13:42:16.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/bitops.h	2004-11-05 14:13:04.362457008 +0000
@@ -1,7 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
 #include <asm/types.h>
-#include <asm/bitops.h>
 
 /*
  * ffs: find first bit set. This is defined the same way as
@@ -71,6 +70,8 @@ extern __inline__ int generic_fls(int x)
 	return r;
 }
 
+#include <asm/bitops.h>
+
 extern __inline__ int get_bitmask_order(unsigned int count)
 {
 	int order;
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/lib/find_next_bit.c linux-2.6.10-rc1-mm3-frv/lib/find_next_bit.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/lib/find_next_bit.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/lib/find_next_bit.c	2004-11-05 14:13:04.571439356 +0000
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
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/lib/Makefile linux-2.6.10-rc1-mm3-frv/lib/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/lib/Makefile	2004-11-05 13:15:52.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/lib/Makefile	2004-11-05 14:13:04.574439103 +0000
@@ -14,6 +14,7 @@ endif
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
