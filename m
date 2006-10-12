Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWJLHnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWJLHnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJLHna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:43:30 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422793AbWJLHnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=Xqrupsf4zGOE5HG7zCRdn8TyP4ljiUmN0DU9zmSFlMU9Oy6JqTQRK2fvI+U3Yn3V8DSZ0utiXHGMYshw2tYUUf9H9zRSyTvSBOBvvfKabD86YwrckP3BRzj7QmdTutO3bXu/AtGiKKi/KKZxEpsNEKuHAzSZOafG08Vz4NcarEQ=
References: <20061012074305.047696736@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:07 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>, okuji@enbug.org
Subject: [patch 2/7] fault-injection capabilities infrastructure
Content-Disposition: inline; filename=should-fail.patch
Message-ID: <452df21c.77a917b6.3845.2dc5@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides base functions for implement fault-injection
capabilities.

- Lightweight random simulator is taken from crasher module for SUSE kernel

- The function should_fail() is taken from failmalloc-1.0
  (http://www.nongnu.org/failmalloc/)

Cc: okuji@enbug.org
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Don Mullis <dwm@meer.net>

 include/linux/fault-inject.h |   69 ++++++++++++++
 lib/Kconfig.debug            |   12 ++
 lib/Makefile                 |    1 
 lib/fault-inject.c           |  207 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 289 insertions(+)

Index: work-fault-inject/lib/Kconfig.debug
===================================================================
--- work-fault-inject.orig/lib/Kconfig.debug
+++ work-fault-inject/lib/Kconfig.debug
@@ -469,3 +469,15 @@ config LKDTM
 
 	Documentation on how to use the module can be found in
 	drivers/misc/lkdtm.c
+
+config FAULT_INJECTION
+	bool
+
+config FAULT_INJECTION_DEBUG_FS
+	bool "debugfs entries for fault-injection capabilities"
+	depends on FAULT_INJECTION && SYSFS
+	select DEBUG_FS
+	help
+	  This option enables to configure fault-injection capabilities via
+	  debugfs entries.
+
Index: work-fault-inject/lib/Makefile
===================================================================
--- work-fault-inject.orig/lib/Makefile
+++ work-fault-inject/lib/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_STATISTICS) += statistic.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
+obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
Index: work-fault-inject/include/linux/fault-inject.h
===================================================================
--- /dev/null
+++ work-fault-inject/include/linux/fault-inject.h
@@ -0,0 +1,69 @@
+#ifndef _LINUX_FAULT_INJECT_H
+#define _LINUX_FAULT_INJECT_H
+
+#ifdef CONFIG_FAULT_INJECTION
+
+#include <linux/types.h>
+#include <linux/debugfs.h>
+#include <asm/atomic.h>
+
+/*
+ * For explanation of the elements of this struct, see
+ * Documentation/fault-injection/fault-injection.txt
+ */
+struct fault_attr {
+	unsigned long probability;
+	unsigned long interval;
+	atomic_t times;
+	atomic_t space;
+	unsigned long verbose;
+
+	unsigned long count;
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+	struct {
+		struct dentry *dir;
+
+		struct dentry *probability_file;
+		struct dentry *interval_file;
+		struct dentry *times_file;
+		struct dentry *space_file;
+		struct dentry *verbose_file;
+	} entries;
+
+#endif
+};
+
+#define DEFINE_FAULT_ATTR(name)					\
+	struct fault_attr name = {				\
+		.interval = 1,					\
+		.times = ATOMIC_INIT(1),			\
+	}
+
+int setup_fault_attr(struct fault_attr *attr, char *str);
+void should_fail_srandom(unsigned long entropy);
+int should_fail(struct fault_attr *attr, ssize_t size);
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+int init_fault_attr_entries(struct fault_attr *attr, const char *name);
+void cleanup_fault_attr_entries(struct fault_attr *attr);
+
+#else /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+static inline int init_fault_attr_entries(struct fault_attr *attr,
+					  const char *name)
+{
+	return -ENODEV;
+}
+
+static inline void cleanup_fault_attr_entries(struct fault_attr *attr)
+{
+}
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#endif /* CONFIG_FAULT_INJECTION */
+
+#endif /* _LINUX_FAULT_INJECT_H */
Index: work-fault-inject/lib/fault-inject.c
===================================================================
--- /dev/null
+++ work-fault-inject/lib/fault-inject.c
@@ -0,0 +1,207 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/random.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/fault-inject.h>
+
+int setup_fault_attr(struct fault_attr *attr, char *str)
+{
+	unsigned long probability;
+	unsigned long interval;
+	int times;
+	int space;
+
+	/* "<interval>,<probability>,<space>,<times>" */
+	if (sscanf(str, "%lu,%lu,%d,%d",
+			&interval, &probability, &space, &times) < 4) {
+		printk(KERN_WARNING
+			"FAULT_INJECTION: failed to parse arguments\n");
+		return 0;
+	}
+
+	attr->probability = probability;
+	attr->interval = interval;
+	atomic_set(&attr->times, times);
+	atomic_set(&attr->space, space);
+
+	return 1;
+}
+
+#define failure_probability(attr)	(attr)->probability
+#define failure_interval(attr)		(attr)->interval
+#define max_failures(attr)		(attr)->times
+#define current_space(attr)		(attr)->space
+#define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
+
+static unsigned long rand_seed = 152L;
+
+static unsigned long should_fail_random(void)
+{
+	rand_seed = rand_seed * 690690L+1;
+	return rand_seed ^ jiffies;
+}
+
+void should_fail_srandom(unsigned long entropy)
+{
+	rand_seed ^= entropy;
+	should_fail_random();
+}
+
+static void fail_dump(struct fault_attr *attr)
+{
+	if (attr->verbose > 0)
+		printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure\n");
+	if (attr->verbose > 1)
+		dump_stack();
+}
+
+/*
+ * This code is stolen from failmalloc-1.0
+ * http://www.nongnu.org/failmalloc/
+ */
+
+int should_fail(struct fault_attr *attr, ssize_t size)
+{
+	if (atomic_read(&max_failures(attr)) == 0)
+		return 0;
+
+	if (atomic_read(&current_space(attr)) > size) {
+		atomic_sub(size, &current_space(attr));
+		return 0;
+	}
+
+	if (failure_interval(attr) > 1) {
+		attr->count++;
+		if (attr->count % failure_interval(attr))
+			return 0;
+	}
+
+	if (failure_probability(attr) > should_fail_random() % 100)
+		goto fail;
+
+	return 0;
+
+fail:
+	fail_dump(attr);
+
+	if (atomic_read(&max_failures(attr)) != -1)
+		atomic_dec_not_zero(&max_failures(attr));
+
+	return 1;
+}
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
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
+void cleanup_fault_attr_entries(struct fault_attr *attr)
+{
+	if (attr->entries.dir) {
+		if (attr->entries.probability_file) {
+			debugfs_remove(attr->entries.probability_file);
+			attr->entries.probability_file = NULL;
+		}
+		if (attr->entries.interval_file) {
+			debugfs_remove(attr->entries.interval_file);
+			attr->entries.interval_file = NULL;
+		}
+		if (attr->entries.times_file) {
+			debugfs_remove(attr->entries.times_file);
+			attr->entries.times_file = NULL;
+		}
+		if (attr->entries.space_file) {
+			debugfs_remove(attr->entries.space_file);
+			attr->entries.space_file = NULL;
+		}
+		if (attr->entries.verbose_file) {
+			debugfs_remove(attr->entries.verbose_file);
+			attr->entries.verbose_file = NULL;
+		}
+		debugfs_remove(attr->entries.dir);
+		attr->entries.dir = NULL;
+	}
+}
+
+int init_fault_attr_entries(struct fault_attr *attr, const char *name)
+{
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	struct dentry *dir;
+	struct dentry *file;
+
+	memset(&attr->entries, 0, sizeof(attr->entries));
+
+	dir = debugfs_create_dir(name, NULL);
+	if (!dir)
+		goto fail;
+	attr->entries.dir = dir;
+
+	file = debugfs_create_ul("probability", mode, dir, &attr->probability);
+	if (!file)
+		goto fail;
+	attr->entries.probability_file = file;
+
+	file = debugfs_create_ul("interval", mode, dir, &attr->interval);
+	if (!file)
+		goto fail;
+	attr->entries.interval_file = file;
+
+	file = debugfs_create_atomic_t("times", mode, dir, &attr->times);
+	if (!file)
+		goto fail;
+	attr->entries.times_file = file;
+
+	file = debugfs_create_atomic_t("space", mode, dir, &attr->space);
+	if (!file)
+		goto fail;
+	attr->entries.space_file = file;
+
+	file = debugfs_create_ul("verbose", mode, dir, &attr->verbose);
+	if (!file)
+		goto fail;
+	attr->entries.verbose_file = file;
+
+	return 0;
+fail:
+	cleanup_fault_attr_entries(attr);
+	return -ENOMEM;
+}
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */

--
