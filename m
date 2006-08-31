Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWHaKKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWHaKKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWHaKIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:52 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:5140 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751423AbWHaKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:45 -0400
Message-Id: <20060831100819.676694231@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:07:57 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 1/6] fault-injection capabilities infrastructure
Content-Disposition: inline; filename=should-fail.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides some functions for implement fault-injection
capabilities.

Lightweight random simulator is taken from crasher module for SUSE kernel.
The function should_fail() is taken from failmalloc-1.0
(http://www.nongnu.org/failmalloc/)

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/should_fail.h |   45 ++++++++++++++++++++++++
 lib/Kconfig.debug           |    4 ++
 lib/Makefile                |    1 
 lib/should_fail.c           |   82 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

Index: work-shouldfail/include/linux/should_fail.h
===================================================================
--- /dev/null
+++ work-shouldfail/include/linux/should_fail.h
@@ -0,0 +1,45 @@
+#ifndef _LINUX_SHOULD_FAIL_H
+#define _LINUX_SHOULD_FAIL_H
+
+#ifdef CONFIG_SHOULD_FAIL
+
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+struct should_fail_data {
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
+#define DEFINE_SHOULD_FAIL(name) \
+	struct should_fail_data name = { .times = ATOMIC_INIT(-1), }
+
+int setup_should_fail(struct should_fail_data *data, char *str);
+void should_fail_srandom(unsigned long entropy);
+int should_fail(struct should_fail_data *data, ssize_t size);
+
+#else
+
+#define should_fail(data, size)	(0)
+
+#endif /* CONFIG_SHOULD_FAIL */
+
+#endif /* _LINUX_SHOULD_FAIL_H */
Index: work-shouldfail/lib/should_fail.c
===================================================================
--- /dev/null
+++ work-shouldfail/lib/should_fail.c
@@ -0,0 +1,82 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/random.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/should_fail.h>
+
+int setup_should_fail(struct should_fail_data *data, char *str)
+{
+	unsigned long probability;
+	unsigned long interval;
+	int times;
+	int space;
+
+	/* "<probability>,<interval>,<times>,<space>" */
+	if (sscanf(str, "%lu,%lu,%d,%d", &probability, &interval, &times,
+		   &space) < 4)
+		return 0;
+
+	data->probability = probability;
+	data->interval = interval;
+	atomic_set(&data->times, times);
+	atomic_set(&data->space, space);
+
+	return 1;
+}
+
+#define failure_probability(data)	(data)->probability
+#define failure_interval(data)		(data)->interval
+#define max_failures(data)		(data)->times
+#define current_space(data)		(data)->space
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
+int should_fail(struct should_fail_data *data, ssize_t size)
+{
+	if (atomic_read(&max_failures(data)) == 0)
+		return 0;
+
+	if (atomic_read(&current_space(data)) > size) {
+		atomic_sub(size, &current_space(data));
+		return 0;
+	}
+
+	if (failure_interval(data) > 1) {
+		data->count++;
+		if (data->count % failure_interval(data))
+			return 0;
+	}
+
+	if (failure_probability(data) > should_fail_random() % 100)
+		goto fail;
+
+	return 0;
+
+fail:
+
+	if (atomic_read(&max_failures(data)) != -1)
+		atomic_dec_not_zero(&max_failures(data));
+
+	return 1;
+}
Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -368,3 +368,7 @@ config RCU_TORTURE_TEST
 	  at boot time (you probably don't).
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
+
+config SHOULD_FAIL
+	bool
+
Index: work-shouldfail/lib/Makefile
===================================================================
--- work-shouldfail.orig/lib/Makefile
+++ work-shouldfail/lib/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_TEXTSEARCH_FSM) += ts_fsm.o
 obj-$(CONFIG_SMP) += percpu_counter.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
+obj-$(CONFIG_SHOULD_FAIL) += should_fail.o
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h

--
