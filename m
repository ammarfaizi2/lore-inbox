Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWINKUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWINKUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWINKUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:20:36 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:7244 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750765AbWINKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:34 -0400
Message-Id: <20060914102030.721230898@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:14 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>, okuji@enbug.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 2/8] fault-injection capabilities infrastructure
Content-Disposition: inline; filename=should-fail.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides some functions for implement fault-injection
capabilities.

- Lightweight random simulator is taken from crasher module for SUSE kernel
- The function should_fail() is taken from failmalloc-1.0
  (http://www.nongnu.org/failmalloc/)

Cc: okuji@enbug.org
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/fault-inject.h |   41 ++++++++++++++++++++
 lib/Kconfig.debug            |    4 ++
 lib/Makefile                 |    1 
 lib/fault-inject.c           |   84 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)

Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -368,3 +368,7 @@ config RCU_TORTURE_TEST
 	  at boot time (you probably don't).
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
+
+config FAULT_INJECTION
+	bool
+
Index: work-shouldfail/lib/Makefile
===================================================================
--- work-shouldfail.orig/lib/Makefile
+++ work-shouldfail/lib/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_SMP) += percpu_counter.o
 obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
+obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
Index: work-shouldfail/include/linux/fault-inject.h
===================================================================
--- /dev/null
+++ work-shouldfail/include/linux/fault-inject.h
@@ -0,0 +1,41 @@
+#ifndef _LINUX_FAULT_INJECT_H
+#define _LINUX_FAULT_INJECT_H
+
+#ifdef CONFIG_FAULT_INJECTION
+
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+struct fault_attr {
+
+	/* how often it should fail in percent. */
+	unsigned long probability;
+
+	/* the interval of failures. */
+	unsigned long interval;
+
+	/*
+	 * how many times failures may happen at most.
+	 * A value of '-1' means infinity.
+	 */
+	atomic_t times;
+
+	/*
+	 * the size of free space where memory can be allocated safely.
+	 * A value of '0' means infinity.
+	 */
+	atomic_t space;
+
+	unsigned long count;
+};
+
+#define DEFINE_FAULT_ATTR(name) \
+	struct fault_attr name = { .times = ATOMIC_INIT(-1), }
+
+int setup_fault_attr(struct fault_attr *attr, char *str);
+void should_fail_srandom(unsigned long entropy);
+int should_fail(struct fault_attr *attr, ssize_t size);
+
+#endif /* CONFIG_FAULT_INJECTION */
+
+#endif /* _LINUX_FAULT_INJECT_H */
Index: work-shouldfail/lib/fault-inject.c
===================================================================
--- /dev/null
+++ work-shouldfail/lib/fault-inject.c
@@ -0,0 +1,84 @@
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
+		printk(KERN_WARNING "SHOULD_FAIL: failed to parse arguments\n");
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
+
+	if (atomic_read(&max_failures(attr)) != -1)
+		atomic_dec_not_zero(&max_failures(attr));
+
+	return 1;
+}

--
