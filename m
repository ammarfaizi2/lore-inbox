Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWAKWlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWAKWlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWAKWlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:41:32 -0500
Received: from mx.pathscale.com ([64.160.42.68]:18124 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932472AbWAKWl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:41:27 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
X-Mercurial-Node: 05b3d1af27ebbbe6e436a06b3d233dff6a2b60dd
Message-Id: <05b3d1af27ebbbe6e436.1137019195@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137019194@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 14:39:55 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This arch-independent routine copies data to a memory-mapped I/O region,
using 32-bit accesses.  It does not guarantee access ordering, nor does
it perform a memory barrier afterwards.  This style of access is required
by some devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c90267e4a29b -r 05b3d1af27eb lib/Makefile
--- a/lib/Makefile	Wed Jan 11 13:31:24 2006 +0800
+++ b/lib/Makefile	Wed Jan 11 14:35:45 2006 -0800
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o raw_memcpy_io.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
diff -r c90267e4a29b -r 05b3d1af27eb lib/raw_memcpy_io.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/raw_memcpy_io.c	Wed Jan 11 14:35:45 2006 -0800
@@ -0,0 +1,41 @@
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
+#include <linux/module.h>
+#include <asm/io.h>
+
+/**
+ * __raw_memcpy_toio32 - copy data to MMIO space, in 32-bit units
+ * @to: destination, in MMIO space (must be 32-bit aligned)
+ * @from: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ *
+ * Copy data from kernel space to MMIO space, in units of 32 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ */
+void __attribute__((weak)) __raw_memcpy_toio32(void __iomem *to,
+					       const void *from, size_t count)
+{
+	u32 __iomem *dst = to;
+	const u32 *src = from;
+	const u32 *end = src + count;
+
+	while (src < end)
+		__raw_writel(*src++, dst++);
+}
+EXPORT_SYMBOL_GPL(__raw_memcpy_toio32);
