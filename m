Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWIFWkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWIFWkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWIFWhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:37:53 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:41152 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964787AbWIFWhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:37:47 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc6 09/10] Simple testing for kmemleak
Date: Wed, 06 Sep 2006 23:37:42 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060906223742.21550.98821.stgit@localhost.localdomain>
In-Reply-To: <20060906223536.21550.55411.stgit@localhost.localdomain>
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch only contains some very simple testing at the moment. Proper
testing will be needed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 lib/Kconfig.debug |   11 +++++++
 mm/Makefile       |    1 +
 mm/memleak-test.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b36ac64..64b6362 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -207,6 +207,17 @@ config DEBUG_KEEP_INIT
 
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
index edccbc0..fd46a73 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_DEBUG_MEMLEAK) += memleak.o
+obj-$(CONFIG_DEBUG_MEMLEAK_TEST) += memleak-test.o
diff --git a/mm/memleak-test.c b/mm/memleak-test.c
new file mode 100644
index 0000000..8120223
--- /dev/null
+++ b/mm/memleak-test.c
@@ -0,0 +1,89 @@
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
+#include <linux/list.h>
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
