Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754622AbWKHRqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbWKHRqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbWKHRqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:46:50 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754622AbWKHRqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:46:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=ONLuhQ81NCDmp0DmQZpwPXXuuBcF27kui16s58q00M9ENmgtEJpz5b437T6YlVJ8Kyr85EA/atmqCzp9g6/Rrdpodfna7LFuLOdRkvOt8eJV0RwDzJO0bS1124vMpnux1/zoyG82E48yZJ70qcOdbyc39wgxpFJc9KmGwjMrgHw=
References: <20061108174540.976625689@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:43 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>, okuji@enbug.org
Subject: [patch 2/7] fault-injection capabilities infrastructure
Content-Disposition: inline; filename=should-fail.patch
Message-ID: <45521806.269d1f82.2fc8.5124@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides base functions implement to fault-injection
capabilities.

- The function should_fail() is taken from failmalloc-1.0
  (http://www.nongnu.org/failmalloc/)

Cc: okuji@enbug.org
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Don Mullis <dwm@meer.net>

 include/linux/fault-inject.h |   69 ++++++++++++++++
 lib/Kconfig.debug            |   12 ++
 lib/Makefile                 |    1 
 lib/fault-inject.c           |  179 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)

Index: 2.6-rc/lib/Kconfig.debug
===================================================================
--- 2.6-rc.orig/lib/Kconfig.debug
+++ 2.6-rc/lib/Kconfig.debug
@@ -412,3 +412,15 @@ config LKDTM
 
 	Documentation on how to use the module can be found in
 	drivers/misc/lkdtm.c
+
+config FAULT_INJECTION
+	bool
+
+config FAULT_INJECTION_DEBUG_FS
+	bool "Debugfs entries for fault-injection capabilities"
+	depends on FAULT_INJECTION && SYSFS
+	select DEBUG_FS
+	help
+	  This option enables to configure fault-injection capabilities via
+	  debugfs entries.
+
Index: 2.6-rc/lib/Makefile
===================================================================
--- 2.6-rc.orig/lib/Makefile
+++ 2.6-rc/lib/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_SMP) += percpu_counter.o
 obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
+obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
Index: 2.6-rc/include/linux/fault-inject.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/linux/fault-inject.h
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
+	} dentries;
+
+#endif
+};
+
+#define FAULT_ATTR_INITIALIZER {				\
+		.interval = 1,					\
+		.times = ATOMIC_INIT(1),			\
+	}
+
+#define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER	
+int setup_fault_attr(struct fault_attr *attr, char *str);
+void should_fail_srandom(unsigned long entropy);
+int should_fail(struct fault_attr *attr, ssize_t size);
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+int init_fault_attr_dentries(struct fault_attr *attr, const char *name);
+void cleanup_fault_attr_dentries(struct fault_attr *attr);
+
+#else /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+static inline int init_fault_attr_dentries(struct fault_attr *attr,
+					  const char *name)
+{
+	return -ENODEV;
+}
+
+static inline void cleanup_fault_attr_dentries(struct fault_attr *attr)
+{
+}
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#endif /* CONFIG_FAULT_INJECTION */
+
+#endif /* _LINUX_FAULT_INJECT_H */
Index: 2.6-rc/lib/fault-inject.c
===================================================================
--- /dev/null
+++ 2.6-rc/lib/fault-inject.c
@@ -0,0 +1,179 @@
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
+static void fail_dump(struct fault_attr *attr)
+{
+	if (attr->verbose > 0)
+		printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure\n");
+	if (attr->verbose > 1)
+		dump_stack();
+}
+
+#define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
+
+/*
+ * This code is stolen from failmalloc-1.0
+ * http://www.nongnu.org/failmalloc/
+ */
+
+int should_fail(struct fault_attr *attr, ssize_t size)
+{
+	if (atomic_read(&attr->times) == 0)
+		return 0;
+
+	if (atomic_read(&attr->space) > size) {
+		atomic_sub(size, &attr->space);
+		return 0;
+	}
+
+	if (attr->interval > 1) {
+		attr->count++;
+		if (attr->count % attr->interval)
+			return 0;
+	}
+
+	if (attr->probability > random32() % 100)
+		goto fail;
+
+	return 0;
+
+fail:
+	fail_dump(attr);
+
+	if (atomic_read(&attr->times) != -1)
+		atomic_dec_not_zero(&attr->times);
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
+void cleanup_fault_attr_dentries(struct fault_attr *attr)
+{
+	debugfs_remove(attr->dentries.probability_file);
+	attr->dentries.probability_file = NULL;
+
+	debugfs_remove(attr->dentries.interval_file);
+	attr->dentries.interval_file = NULL;
+
+	debugfs_remove(attr->dentries.times_file);
+	attr->dentries.times_file = NULL;
+
+	debugfs_remove(attr->dentries.space_file);
+	attr->dentries.space_file = NULL;
+
+	debugfs_remove(attr->dentries.verbose_file);
+	attr->dentries.verbose_file = NULL;
+
+	if (attr->dentries.dir)
+		WARN_ON(!simple_empty(attr->dentries.dir));
+
+	debugfs_remove(attr->dentries.dir);
+	attr->dentries.dir = NULL;
+}
+
+int init_fault_attr_dentries(struct fault_attr *attr, const char *name)
+{
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	struct dentry *dir;
+
+	memset(&attr->dentries, 0, sizeof(attr->dentries));
+
+	dir = debugfs_create_dir(name, NULL);
+	if (!dir)
+		goto fail;
+	attr->dentries.dir = dir;
+
+	attr->dentries.probability_file =
+		debugfs_create_ul("probability", mode, dir, &attr->probability);
+
+	attr->dentries.interval_file =
+		debugfs_create_ul("interval", mode, dir, &attr->interval);
+
+	attr->dentries.times_file =
+		debugfs_create_atomic_t("times", mode, dir, &attr->times);
+
+	attr->dentries.space_file =
+		debugfs_create_atomic_t("space", mode, dir, &attr->space);
+
+	attr->dentries.verbose_file =
+		debugfs_create_ul("verbose", mode, dir, &attr->verbose);
+
+	if (!attr->dentries.probability_file || !attr->dentries.interval_file
+	    || !attr->dentries.times_file || !attr->dentries.space_file
+	    || !attr->dentries.verbose_file)
+		goto fail;
+
+	return 0;
+fail:
+	cleanup_fault_attr_dentries(attr);
+	return -ENOMEM;
+}
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */

--
