Return-Path: <linux-kernel-owner+w=401wt.eu-S1161078AbWLPPsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWLPPsL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWLPPro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:44 -0500
Received: from queue04-winn.ispmail.ntl.com ([81.103.221.58]:42406 "EHLO
	queue04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161079AbWLPPri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:38 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 09/10] Testing module for kmemleak
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:35:54 +0000
Message-ID: <20061216153554.18200.8452.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a loadable module that deliberately leaks memory. It
is used for testing various memory leaking scenarios.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 lib/Kconfig.debug |   11 ++++++
 mm/Makefile       |    1 +
 mm/memleak-test.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9695af1..b430479 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -263,6 +263,17 @@ config DEBUG_KEEP_INIT
 
 	  If unsure, say N.
 
+config DEBUG_MEMLEAK_TEST
+	tristate "Test the kernel memory leak detector"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  Say Y or M here to build the test harness for the kernel
+	  memory leak detector. At the moment, this option enables a
+	  module that explicitly leaks memory.
+
+	  If unsure, say N.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
diff --git a/mm/Makefile b/mm/Makefile
index aafe03f..9f5d450 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
 obj-$(CONFIG_DEBUG_MEMLEAK) += memleak.o
+obj-$(CONFIG_DEBUG_MEMLEAK_TEST) += memleak-test.o
diff --git a/mm/memleak-test.c b/mm/memleak-test.c
new file mode 100644
index 0000000..51320d8
--- /dev/null
+++ b/mm/memleak-test.c
@@ -0,0 +1,94 @@
+/*
+ * mm/memleak-test.c
+ *
+ * Copyright (C) 2006 ARM Limited
+ * Written by Catalin Marinas <catalin.marinas@gmail.com>
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
+#include <linux/list.h>
+#include <linux/percpu.h>
+
+#include <linux/memleak.h>
+
+struct test_node {
+	long header[25];
+	struct list_head list;
+	long footer[25];
+};
+
+static LIST_HEAD(test_list);
+static DEFINE_PER_CPU(void *, test_pointer);
+
+/* Some very simple testing. This function needs to be extended for
+ * proper testing */
+static int __init memleak_test_init(void)
+{
+	struct test_node *elem;
+	int i;
+
+	printk(KERN_INFO "KMemLeak testing\n");
+
+	/* make some orphan objects */
+	kmalloc(32, GFP_KERNEL);
+	kmalloc(32, GFP_KERNEL);
+	kmalloc(1024, GFP_KERNEL);
+	kmalloc(1024, GFP_KERNEL);
+	kmalloc(2048, GFP_KERNEL);
+	kmalloc(2048, GFP_KERNEL);
+	kmalloc(4096, GFP_KERNEL);
+	kmalloc(4096, GFP_KERNEL);
+#ifndef CONFIG_MODULES
+	kmem_cache_alloc(files_cachep, GFP_KERNEL);
+	kmem_cache_alloc(files_cachep, GFP_KERNEL);
+#endif
+	vmalloc(64);
+	vmalloc(64);
+
+	/* add elements to a list. They should only appear as orphan
+	 * after the module is removed */
+	for (i = 0; i < 10; i++) {
+		elem = kmalloc(sizeof(*elem), GFP_KERNEL);
+		if (!elem)
+			return -ENOMEM;
+		memset(elem, 0, sizeof(*elem));
+		INIT_LIST_HEAD(&elem->list);
+
+		list_add_tail(&elem->list, &test_list);
+	}
+
+	for_each_possible_cpu(i)
+		per_cpu(test_pointer, i) = kmalloc(129, GFP_KERNEL);
+
+	return 0;
+}
+module_init(memleak_test_init);
+
+static void __exit memleak_test_exit(void)
+{
+	struct test_node *elem, *tmp;
+
+	/* remove the list elements without actually freeing the memory */
+	list_for_each_entry_safe(elem, tmp, &test_list, list)
+		list_del(&elem->list);
+}
+module_exit(memleak_test_exit);
+
+MODULE_LICENSE("GPL");
