Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWINKWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWINKWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWINKV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:21:58 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:14924 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750769AbWINKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:35 -0400
Message-Id: <20060914102032.633059366@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:18 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 6/8] debugfs entries for configuration
Content-Disposition: inline; filename=knobs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel module provides debugfs entries to enable to configure
fault-injection capabilities for failslab, fail_page_alloc, and
fail_make_request.

The slab allocator, the page allocator, and the block layer are initalized
before debugfs is available. and failslab, fail_page_alloc, and
fail_make_request are also enabled at the same time.
So I put the initalization and cleanup for these debugfs entries into
this kernel module.

This module provides the following entries so that we can configure
by writing these files.

/debug/
|-- fail_make_request
|   |-- interval
|   |-- probability
|   |-- space
|   `-- times
|-- fail_page_alloc
|   |-- interval
|   |-- probability
|   |-- space
|   `-- times
`-- failslab
    |-- interval
    |-- probability
    |-- space
    `-- times

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 lib/Kconfig.debug          |    8 ++
 lib/Makefile               |    1 
 lib/fault-inject-debugfs.c |  179 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -393,3 +393,11 @@ config FAIL_MAKE_REQUEST
 	help
 	  This option provides fault-injection capabilitiy to disk IO.
 
+config FAULT_INJECTION_DEBUGFS 
+	tristate "runtime configuration for fault-injection capabilities"
+	depends on DEBUG_KERNEL && SYSFS && FAULT_INJECTION
+	select DEBUG_FS
+	help
+	  This option provides kernel module that provides runtime
+	  configuration interface by debugfs.
+
Index: work-shouldfail/lib/fault-inject-debugfs.c
===================================================================
--- /dev/null
+++ work-shouldfail/lib/fault-inject-debugfs.c
@@ -0,0 +1,179 @@
+#include <linux/module.h>
+#include <linux/fault-inject.h>
+#include <linux/debugfs.h>
+
+struct fault_attr_entries {
+	struct dentry *dir;
+	struct dentry *probability_file;
+	struct dentry *interval_file;
+	struct dentry *times_file;
+	struct dentry *space_file;
+	struct dentry *process_filter_file;
+};
+
+static void debugfs_ul_set(void *data, u64 val)
+{
+	*(unsigned long *)data = val;
+}
+
+static u64 debugfs_ul_get(void *data)
+{
+	return *(unsigned long *)data;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
+
+static struct dentry *debugfs_create_ul(const char *name, mode_t mode,
+				struct dentry *parent, unsigned long *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_ul);
+}
+
+static void debugfs_atomic_t_set(void *data, u64 val)
+{
+	atomic_set((atomic_t *)data, val);
+}
+
+static u64 debugfs_atomic_t_get(void *data)
+{
+	return atomic_read((atomic_t *)data);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_atomic_t, debugfs_atomic_t_get,
+			debugfs_atomic_t_set, "%lld\n");
+
+static struct dentry *debugfs_create_atomic_t(const char *name, mode_t mode,
+				struct dentry *parent, atomic_t *value)
+{
+	return debugfs_create_file(name, mode, parent, value, &fops_atomic_t);
+}
+
+static void cleanup_fault_attr_entries(struct fault_attr_entries *entries)
+{
+	if (entries->dir) {
+		if (entries->probability_file) {
+			debugfs_remove(entries->probability_file);
+			entries->probability_file = NULL;
+		}
+		if (entries->interval_file) {
+			debugfs_remove(entries->interval_file);
+			entries->interval_file = NULL;
+		}
+		if (entries->times_file) {
+			debugfs_remove(entries->times_file);
+			entries->times_file = NULL;
+		}
+		if (entries->space_file) {
+			debugfs_remove(entries->space_file);
+			entries->space_file = NULL;
+		}
+		if (entries->process_filter_file) {
+			debugfs_remove(entries->process_filter_file);
+			entries->process_filter_file = NULL;
+		}
+		debugfs_remove(entries->dir);
+		entries->dir = NULL;
+	}
+}
+
+static int init_fault_attr_entries(struct fault_attr_entries *entries,
+				struct fault_attr *attr, const char *name)
+{
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	struct dentry *dir;
+	struct dentry *file;
+
+	memset(entries, 0, sizeof(*entries));
+
+	dir = debugfs_create_dir(name, NULL);
+	if (!dir)
+		goto fail;
+	entries->dir = dir;
+
+	file = debugfs_create_ul("probability", mode, dir, &attr->probability);
+	if (!file)
+		goto fail;
+	entries->probability_file = file;
+
+	file = debugfs_create_ul("interval", mode, dir, &attr->interval);
+	if (!file)
+		goto fail;
+	entries->interval_file = file;
+
+	file = debugfs_create_atomic_t("times", mode, dir, &attr->times);
+	if (!file)
+		goto fail;
+	entries->times_file = file;
+
+	file = debugfs_create_atomic_t("space", mode, dir, &attr->space);
+	if (!file)
+		goto fail;
+	entries->space_file = file;
+
+	file = debugfs_create_bool("process-filter", mode, dir,
+				   &attr->process_filter);
+	if (!file)
+		goto fail;
+	entries->process_filter_file = file;
+
+	return 0;
+fail:
+	cleanup_fault_attr_entries(entries);
+	return -ENOMEM;
+}
+
+#ifdef CONFIG_FAILSLAB
+static struct fault_attr_entries failslab_entries;
+#endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+static struct fault_attr_entries fail_page_alloc_entries;
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+static struct fault_attr_entries fail_make_request_entries;
+#endif
+
+static void cleanup_entries(void)
+{
+#ifdef CONFIG_FAILSLAB
+	cleanup_fault_attr_entries(&failslab_entries);
+#endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+	cleanup_fault_attr_entries(&fail_page_alloc_entries);
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	cleanup_fault_attr_entries(&fail_make_request_entries);
+#endif
+}
+
+static int init_entries(void)
+{
+	int err;
+
+#ifdef CONFIG_FAILSLAB
+	err = init_fault_attr_entries(&failslab_entries, failslab, "failslab");
+	if (err)
+		goto fail;
+#endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+	err = init_fault_attr_entries(&fail_page_alloc_entries, fail_page_alloc,
+				     "fail_page_alloc");
+	if (err)
+		goto fail;
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	err = init_fault_attr_entries(&fail_make_request_entries,
+				     fail_make_request, "fail_make_request");
+	if (err)
+		goto fail;
+#endif
+
+	return 0;
+fail:
+	cleanup_entries();
+
+	return err;
+}
+
+module_init(init_entries);
+module_exit(cleanup_entries);
+MODULE_LICENSE("GPL");
Index: work-shouldfail/lib/Makefile
===================================================================
--- work-shouldfail.orig/lib/Makefile
+++ work-shouldfail/lib/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
+obj-$(CONFIG_FAULT_INJECTION_DEBUGFS) += fault-inject-debugfs.o
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h

--
