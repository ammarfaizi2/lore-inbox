Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWINKVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWINKVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWINKU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:20:59 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:17484 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750786AbWINKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:35 -0400
Message-Id: <20060914102033.462112306@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:20 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 8/8] stacktrace filtering for fault-injection capabilities
Content-Disposition: inline; filename=module-filter.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides stacktrace filtering feature.
The stacktrace filter allows failing only for the caller you are
interested in.

stacktrace filter is enabled by setting the value of
/debugfs/*/stacktrace-depth more than 0.
and specify the range of the virtual address
by the /debugfs/*/address-start and /debugfs/*/address-end

Please see the example that demostrates how to inject slab allocation
failures only for a specific module
in Documentation/fault-injection/fault-injection.txt

Cc: Valdis.Kletnieks@vt.edu
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/fault-inject.h |   15 +++++++++
 lib/Kconfig.debug            |    2 +
 lib/fault-inject-debugfs.c   |   32 +++++++++++++++++++
 lib/fault-inject.c           |   71 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

Index: work-shouldfail/lib/fault-inject.c
===================================================================
--- work-shouldfail.orig/lib/fault-inject.c
+++ work-shouldfail/lib/fault-inject.c
@@ -6,6 +6,9 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/unwind.h>
+#include <linux/stacktrace.h>
+#include <linux/kallsyms.h>
 #include <linux/fault-inject.h>
 
 int setup_fault_attr(struct fault_attr *attr, char *str)
@@ -59,6 +62,72 @@ static int fail_process(struct fault_att
 	return !in_interrupt() && task->make_it_fail;
 }
 
+#ifdef CONFIG_STACK_UNWIND
+
+static asmlinkage int fail_stacktrace_callback(struct unwind_frame_info *info,
+						void *arg)
+{
+	int depth;
+	struct fault_attr *attr = arg;
+
+	for (depth = 0; depth < attr->stacktrace_depth
+			&& unwind(info) == 0 && UNW_PC(info); depth++) {
+		if (arch_unw_user_mode(info))
+			break;
+		if (attr->address_start <= UNW_PC(info) &&
+			       UNW_PC(info) < attr->address_end)
+			return 1;
+	}
+	return 0;
+}
+
+static int fail_stacktrace(struct fault_attr *attr)
+{
+	struct unwind_frame_info info;
+
+	/* stacktrace filter is disabled */
+	if (attr->stacktrace_depth == 0)
+		return 1;
+
+	return unwind_init_running(&info, fail_stacktrace_callback, attr);
+}
+
+#elif defined(CONFIG_STACKTRACE)
+
+#include <linux/stacktrace.h>
+
+#define MAX_STACK_TRACE_DEPTH 10
+
+static int fail_stacktrace(struct fault_attr *attr)
+{
+	struct stack_trace trace;
+	int depth = attr->stacktrace_depth;
+	unsigned long entries[MAX_STACK_TRACE_DEPTH];
+	int n;
+
+	/* stacktrace filter is disabled */
+	if (depth == 0)
+		return 1;
+
+	trace.nr_entries = 0;
+	trace.entries = entries;
+	trace.max_entries = (depth < MAX_STACK_TRACE_DEPTH) ?
+				depth : MAX_STACK_TRACE_DEPTH;
+
+	save_stack_trace(&trace, NULL, 0, 1);
+	for (n = 0; n < trace.nr_entries; n++)
+		if (attr->address_start <= entries[n] &&
+			       entries[n] < attr->address_end)
+			return 1;
+	return 0;
+}
+
+#else
+
+#define fail_stacktrace(attr)	(0)
+
+#endif
+
 /*
  * This code is stolen from failmalloc-1.0
  * http://www.nongnu.org/failmalloc/
@@ -68,6 +137,8 @@ int should_fail(struct fault_attr *attr,
 {
 	if (!fail_process(attr, current))
 		return 0;
+	if (!fail_stacktrace(attr))
+		return 0;
 
 	if (atomic_read(&max_failures(attr)) == 0)
 		return 0;
Index: work-shouldfail/include/linux/fault-inject.h
===================================================================
--- work-shouldfail.orig/include/linux/fault-inject.h
+++ work-shouldfail/include/linux/fault-inject.h
@@ -30,6 +30,21 @@ struct fault_attr {
 
 	/* A value of '0' means process filter is disabled. */
 	u32 process_filter;
+
+	/*
+	 * maximam number of stacktrace depth walking allowed
+	 * A value of '0' means stacktrace filter is disabled.
+	 */
+	unsigned long stacktrace_depth;
+
+	/*
+	 * If stacktrace_depth is enabled, it allows failing only when it
+	 * has been called from the virtual addresses in the range
+	 * 'address_start' to 'address_end-1'
+	 */ 
+	unsigned long address_start;
+	unsigned long address_end;
+
 };
 
 #define DEFINE_FAULT_ATTR(name) \
Index: work-shouldfail/lib/fault-inject-debugfs.c
===================================================================
--- work-shouldfail.orig/lib/fault-inject-debugfs.c
+++ work-shouldfail/lib/fault-inject-debugfs.c
@@ -9,6 +9,9 @@ struct fault_attr_entries {
 	struct dentry *times_file;
 	struct dentry *space_file;
 	struct dentry *process_filter_file;
+	struct dentry *stacktrace_depth_file;
+	struct dentry *address_start_file;
+	struct dentry *address_end_file;
 };
 
 static void debugfs_ul_set(void *data, u64 val)
@@ -71,6 +74,18 @@ static void cleanup_fault_attr_entries(s
 			debugfs_remove(entries->process_filter_file);
 			entries->process_filter_file = NULL;
 		}
+		if (entries->stacktrace_depth_file) {
+			debugfs_remove(entries->stacktrace_depth_file);
+			entries->stacktrace_depth_file = NULL;
+		}
+		if (entries->address_start_file) {
+			debugfs_remove(entries->address_start_file);
+			entries->address_start_file = NULL;
+		}
+		if (entries->address_end_file) {
+			debugfs_remove(entries->address_end_file);
+			entries->address_end_file = NULL;
+		}
 		debugfs_remove(entries->dir);
 		entries->dir = NULL;
 	}
@@ -116,6 +131,23 @@ static int init_fault_attr_entries(struc
 		goto fail;
 	entries->process_filter_file = file;
 
+	file = debugfs_create_ul("stacktrace-depth", mode, dir,
+				   &attr->stacktrace_depth);
+	if (!file)
+		goto fail;
+	entries->stacktrace_depth_file = file;
+
+	file = debugfs_create_ul("address-start", mode, dir,
+				   &attr->address_start);
+	if (!file)
+		goto fail;
+	entries->address_start_file = file;
+
+	file = debugfs_create_ul("address-end", mode, dir, &attr->address_end);
+	if (!file)
+		goto fail;
+	entries->address_end_file = file;
+
 	return 0;
 fail:
 	cleanup_fault_attr_entries(entries);
Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -371,6 +371,8 @@ config RCU_TORTURE_TEST
 
 config FAULT_INJECTION
 	bool
+	select STACKTRACE
+	select FRAME_POINTER
 
 config FAILSLAB
 	bool "fault-injection capabilitiy for kmalloc"

--
