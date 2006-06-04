Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932277AbWFDWBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWFDWBf (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWFDWBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:01:33 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:13577 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932279AbWFDWBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:01:01 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 8/8] Simple testing for kmemleak
Date: Sun, 04 Jun 2006 23:00:57 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060604220057.16277.19657.stgit@localhost.localdomain>
In-Reply-To: <20060604215636.16277.15454.stgit@localhost.localdomain>
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
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

 lib/Kconfig.debug |    9 ++++++
 mm/Makefile       |    1 +
 mm/memleak-test.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7c3bca3..0a7c001 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -132,6 +132,15 @@ config DEBUG_MEMLEAK_SECONDARY_ALIASES
 	  false negatives but it can slightly increase the number of false
 	  positives.
 
+config DEBUG_MEMLEAK_TEST
+	tristate "Test the kernel memory leak detector"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  Say Y here to build the test harness for the kernel memory
+	  leak detector. At the moment, this option enables a module
+	  that explicitly leaks memory.
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
index 0000000..4061f99
--- /dev/null
+++ b/mm/memleak-test.c
@@ -0,0 +1,83 @@
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
