Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWE0MYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWE0MYV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWE0MYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:24:20 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:32613 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751502AbWE0MYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:24:09 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 7/7] Simple testing for kmemleak
Date: Sat, 27 May 2006 13:24:05 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060527122405.21451.17780.stgit@localhost.localdomain>
In-Reply-To: <20060527120709.21451.3187.stgit@localhost.localdomain>
References: <20060527120709.21451.3187.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch only contains some very simple testing at the moment. Proper
testing will be needed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 lib/Kconfig.debug |    8 ++++++++
 mm/Makefile       |    1 +
 mm/memleak-test.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c109dae..c96d1ae 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -102,6 +102,14 @@ config DEBUG_MEMLEAK
 	  only shown in /sys/kernel/debug/memleak. Enabling this
 	  feature will introduce an overhead to memory allocations.
 
+config DEBUG_MEMLEAK_TEST
+	tristate "Test the kernel memory leak detector"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  Say Y here to build the test harness for the kernel memory
+	  leak detector.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
diff --git a/mm/Makefile b/mm/Makefile
index d487d96..aef1bd8 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_DEBUG_MEMLEAK) += memleak.o
+obj-$(CONFIG_DEBUG_MEMLEAK_TEST) += memleak-test.o
diff --git a/mm/memleak-test.c b/mm/memleak-test.c
new file mode 100644
index 0000000..15ddd36
--- /dev/null
+++ b/mm/memleak-test.c
@@ -0,0 +1,54 @@
+/*
+ * mm/memleak-test.c
+ *
+ * Copyright (C) 2006 ARM Limited
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include <linux/memleak.h>
+
+/* Some very simple testing. This function needs to be extended for
+ * proper testing */
+static int __init memleak_test_init(void)
+{
+	printk(KERN_INFO "KMemLeak testing\n");
+
+	/* make some orphan pointers */
+	kmalloc(32, GFP_KERNEL);
+	kmalloc(32, GFP_KERNEL);
+#ifndef CONFIG_MODULES
+	kmem_cache_alloc(files_cachep, GFP_KERNEL);
+	kmem_cache_alloc(files_cachep, GFP_KERNEL);
+#endif
+	vmalloc(64);
+	vmalloc(64);
+
+	return 0;
+}
+module_init(memleak_test_init);
+
+static void __exit memleak_test_exit(void)
+{
+}
+module_exit(memleak_test_exit);
+
+MODULE_LICENSE("GPL");
