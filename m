Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWAJTzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWAJTzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWAJTzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:55:43 -0500
Received: from mx.pathscale.com ([64.160.42.68]:57002 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932547AbWAJTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:55:42 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
X-Mercurial-Node: 2d4af213d9c5975d28fc11c472f3b5e1cf2c21cd
Message-Id: <2d4af213d9c5975d28fc.1136922837@serpentine.internal.keyresearch.com>
In-Reply-To: <patchbomb.1136922836@serpentine.internal.keyresearch.com>
Date: Tue, 10 Jan 2006 11:53:57 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de,
       rdreier@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This arch-independent routine copies data to a memory-mapped I/O region,
using 32-bit accesses.  It does not guarantee access ordering, nor does
it perform a memory barrier afterwards.  This style of access is required
by some devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 48616306e7bd -r 2d4af213d9c5 lib/Makefile
--- a/lib/Makefile	Tue Jan 10 10:41:42 2006 +0800
+++ b/lib/Makefile	Tue Jan 10 11:52:46 2006 -0800
@@ -21,6 +21,7 @@
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
+lib-$(CONFIG_GENERIC_RAW_MEMCPY_IO) += raw_memcpy_io.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
diff -r 48616306e7bd -r 2d4af213d9c5 lib/raw_memcpy_io.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/raw_memcpy_io.c	Tue Jan 10 11:52:46 2006 -0800
@@ -0,0 +1,39 @@
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
+#include <linux/types.h>
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
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count)
+{
+	u32 __iomem *dst = to;
+	const u32 *src = from;
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		__raw_writel(*src++, dst++);
+}
