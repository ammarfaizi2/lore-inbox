Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWALAaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWALAaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWALAaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:30:39 -0500
Received: from mx.pathscale.com ([64.160.42.68]:54486 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964852AbWALAai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:30:38 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] Introduce __raw_memcpy_toio32
X-Mercurial-Node: cd6d8a62dad54690bc93174d8bf0b6d082b1ee89
Message-Id: <cd6d8a62dad54690bc93.1137025775@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1137025774@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 16:29:35 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: rdreier@cisco.com, ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This arch-independent routine copies data to a memory-mapped I/O region,
using 32-bit accesses.  It does not guarantee access ordering, nor does
it perform a memory barrier afterwards.  This style of access is required
by some devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c90267e4a29b -r cd6d8a62dad5 lib/Makefile
--- a/lib/Makefile	Wed Jan 11 13:31:24 2006 +0800
+++ b/lib/Makefile	Wed Jan 11 16:25:30 2006 -0800
@@ -9,7 +9,7 @@
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
-obj-y += sort.o parser.o halfmd4.o
+obj-y += sort.o parser.o halfmd4.o raw_memcpy_io.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff -r c90267e4a29b -r cd6d8a62dad5 include/linux/io.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/linux/io.h	Wed Jan 11 16:25:30 2006 -0800
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
+void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
+
+#endif /* _LINUX_IO_H */
diff -r c90267e4a29b -r cd6d8a62dad5 lib/raw_memcpy_io.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/lib/raw_memcpy_io.c	Wed Jan 11 16:25:30 2006 -0800
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
+#include <linux/io.h>
+#include <linux/module.h>
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
