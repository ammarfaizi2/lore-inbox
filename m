Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWHaKJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWHaKJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWHaKI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:56 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:10004 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751428AbWHaKIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:46 -0400
Message-Id: <20060831100821.436531918@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:08:01 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 5/6] debugfs entries for configuration
Content-Disposition: inline; filename=knobs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel module provides debugfs entries for fault-injection
capabilities configuation.

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

 lib/Kconfig.debug       |    8 ++
 lib/Makefile            |    1 
 lib/should_fail_knobs.c |  168 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

Index: work-shouldfail/lib/should_fail_knobs.c
===================================================================
--- /dev/null
+++ work-shouldfail/lib/should_fail_knobs.c
@@ -0,0 +1,168 @@
+#include <linux/module.h>
+#include <linux/should_fail.h>
+#include <linux/debugfs.h>
+
+struct should_fail_knobs {
+	struct dentry *dir;
+	struct dentry *probability_file;
+	struct dentry *interval_file;
+	struct dentry *times_file;
+	struct dentry *space_file;
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
+static void cleanup_should_fail_knobs(struct should_fail_knobs *knobs)
+{
+	if (knobs->dir) {
+		if (knobs->probability_file) {
+			debugfs_remove(knobs->probability_file);
+			knobs->probability_file = NULL;
+		}
+		if (knobs->interval_file) {
+			debugfs_remove(knobs->interval_file);
+			knobs->interval_file = NULL;
+		}
+		if (knobs->times_file) {
+			debugfs_remove(knobs->times_file);
+			knobs->times_file = NULL;
+		}
+		if (knobs->space_file) {
+			debugfs_remove(knobs->space_file);
+			knobs->space_file = NULL;
+		}
+		debugfs_remove(knobs->dir);
+		knobs->dir = NULL;
+	}
+}
+
+static int init_should_fail_knobs(struct should_fail_knobs *knobs,
+			   struct should_fail_data *data, const char *name)
+{
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	struct dentry *dir;
+	struct dentry *file;
+
+	memset(knobs, 0, sizeof(*knobs));
+
+	dir = debugfs_create_dir(name, NULL);
+	if (!dir)
+		goto fail;
+	knobs->dir = dir;
+
+	file = debugfs_create_ul("probability", mode, dir, &data->probability);
+	if (!file)
+		goto fail;
+	knobs->probability_file = file;
+
+	file = debugfs_create_ul("interval", mode, dir, &data->interval);
+	if (!file)
+		goto fail;
+	knobs->interval_file = file;
+
+	file = debugfs_create_atomic_t("times", mode, dir, &data->times);
+	if (!file)
+		goto fail;
+	knobs->times_file = file;
+
+	file = debugfs_create_atomic_t("space", mode, dir, &data->space);
+	if (!file)
+		goto fail;
+	knobs->space_file = file;
+
+	return 0;
+fail:
+	cleanup_should_fail_knobs(knobs);
+	return -ENOMEM;
+}
+
+#ifdef CONFIG_FAILSLAB
+static struct should_fail_knobs failslab_knobs;
+#endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+static struct should_fail_knobs fail_page_alloc_knobs;
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+static struct should_fail_knobs fail_make_request_knobs;
+#endif
+
+static void cleanup_knobs(void)
+{
+#ifdef CONFIG_FAILSLAB
+	cleanup_should_fail_knobs(&fail_make_request_knobs);
+#endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+	cleanup_should_fail_knobs(&fail_page_alloc_knobs);
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	cleanup_should_fail_knobs(&failslab_knobs);
+#endif
+}
+
+static int init_knobs(void)
+{
+	int err;
+
+#ifdef CONFIG_FAILSLAB
+	err = init_should_fail_knobs(&failslab_knobs, failslab, "failslab");
+	if (err)
+		goto fail;
+#endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+	err = init_should_fail_knobs(&fail_page_alloc_knobs, fail_page_alloc,
+				     "fail_page_alloc");
+	if (err)
+		goto fail;
+#endif
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	err = init_should_fail_knobs(&fail_make_request_knobs,
+				     fail_make_request, "fail_make_request");
+	if (err)
+		goto fail;
+#endif
+
+	return 0;
+fail:
+	cleanup_knobs();
+
+	return err;
+}
+
+module_init(init_knobs);
+module_exit(cleanup_knobs);
+MODULE_LICENSE("GPL");
Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -393,3 +393,11 @@ config FAIL_MAKE_REQUEST
 	help
 	  This option provides fault-injection capabilitiy to disk IO.
 
+config SHOULD_FAIL_KNOBS
+	tristate "runtime configuration for fault-injection capabilities"
+	depends on DEBUG_KERNEL && SYSFS && SHOULD_FAIL
+	select DEBUG_FS
+	help
+	  This option provides kernel module that provides runtime
+	  configuration interface by debugfs.
+
Index: work-shouldfail/lib/Makefile
===================================================================
--- work-shouldfail.orig/lib/Makefile
+++ work-shouldfail/lib/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_SMP) += percpu_counter.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
 obj-$(CONFIG_SHOULD_FAIL) += should_fail.o
+obj-$(CONFIG_SHOULD_FAIL_KNOBS) += should_fail_knobs.o
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h

--
