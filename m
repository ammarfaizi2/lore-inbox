Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWALRHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWALRHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWALRHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:07:17 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42431 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751223AbWALRHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:07:13 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] Introduce __iowrite32_copy
X-Mercurial-Node: ec2b3675168a90ce4f12fdf689d7668e93a2b493
Message-Id: <ec2b3675168a90ce4f12.1137085531@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137085530@eng-12.pathscale.com>
Date: Thu, 12 Jan 2006 09:05:31 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, ak@suse.de
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, rdreier@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This arch-independent routine copies data to a memory-mapped I/O region,
using 32-bit accesses.  The naming is double-underscored to make it clear
that it does not guarantee write ordering, nor does it perform a
memory barrier afterwards; the kernel doc also explicitly states this.
This style of access is required by some devices.

This change also introduces include/linux/io.h, at Andrew's suggestion.
It only has one occupant at the moment, but is a logical destination
for oft-replicated contents of include/asm-*/{io,iomap}.h to migrate to.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c90267e4a29b -r ec2b3675168a lib/Makefile
--- a/lib/Makefile	Wed Jan 11 13:31:24 2006 +0800
+++ b/lib/Makefile	Thu Jan 12 09:03:37 2006 -0800
@@ -9,7 +9,7 @@
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
-obj-y += sort.o parser.o halfmd4.o
+obj-y += sort.o parser.o halfmd4.o iomap_copy.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff -r c90267e4a29b -r ec2b3675168a include/linux/io.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/linux/io.h	Thu Jan 12 09:03:37 2006 -0800
@@ -0,0 +1,25 @@
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
+#ifndef _LINUX_IO_H
+#define _LINUX_IO_H
+
+#include <asm/io.h>
+
+void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
+
+#endif /* _LINUX_IO_H */
diff -r c90267e4a29b -r ec2b3675168a lib/iomap_copy.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/iomap_copy.c	Thu Jan 12 09:03:37 2006 -0800
@@ -0,0 +1,42 @@
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
+#include <linux/io.h>
+#include <linux/module.h>
+
+/**
+ * __iowrite32_copy - copy data to MMIO space, in 32-bit units
+ * @to: destination, in MMIO space (must be 32-bit aligned)
+ * @from: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ *
+ * Copy data from kernel space to MMIO space, in units of 32 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ */
+void __attribute__((weak)) __iowrite32_copy(void __iomem *to,
+					    const void *from,
+					    size_t count)
+{
+	u32 __iomem *dst = to;
+	const u32 *src = from;
+	const u32 *end = src + count;
+
+	while (src < end)
+		__raw_writel(*src++, dst++);
+}
+EXPORT_SYMBOL_GPL(__iowrite32_copy);
