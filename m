Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWJLHoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWJLHoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422794AbWJLHoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:44:04 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422800AbWJLHn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=f+BYDp4Qvu3p8uJc3R21kmQACASL07Vw7t6dt56EXRBcb7iyKIShztDnkPN+6Dq27cVpX6P1+Nw1dkXQK64P2dH+D4mUPm6TcVwJgyxYVrPfMtmOvjZMFv+2zvKRAdKzT8rqf6ZzeIOvp2OCzAeeIm1JL/tiEW+T805wAE2201Q=
References: <20061012074305.047696736@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:12 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu
Subject: [patch 7/7] stacktrace filtering for fault-injection capabilities
Content-Disposition: inline; filename=module-filter.patch
Message-ID: <452df23e.44ca1e09.1a7f.780f@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Don Mullis <dwm@meer.net>

 include/linux/fault-inject.h |    7 ++
 lib/Kconfig.debug            |    2 
 lib/fault-inject.c           |  111 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

Index: work-fault-inject/lib/fault-inject.c
===================================================================
--- work-fault-inject.orig/lib/fault-inject.c
+++ work-fault-inject/lib/fault-inject.c
@@ -6,6 +6,9 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/unwind.h>
+#include <linux/stacktrace.h>
+#include <linux/kallsyms.h>
 #include <linux/fault-inject.h>
 
 int setup_fault_attr(struct fault_attr *attr, char *str)
@@ -64,6 +67,82 @@ static int fail_task(struct fault_attr *
 	return !in_interrupt() && task->make_it_fail;
 }
 
+static int fail_any_address(struct fault_attr *attr)
+{
+	return (attr->address_start == 0 && attr->address_end == ULONG_MAX);
+}
+
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
+	return unwind_init_running(&info, fail_stacktrace_callback, attr);
+}
+
+#elif defined(CONFIG_STACKTRACE)
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
+	if (depth == 0)
+		return 0;
+
+	trace.nr_entries = 0;
+	trace.entries = entries;
+	trace.max_entries = (depth < MAX_STACK_TRACE_DEPTH) ?
+				depth : MAX_STACK_TRACE_DEPTH;
+	trace.skip = 1;
+	trace.all_contexts = 0;
+
+	save_stack_trace(&trace, NULL);
+	for (n = 0; n < trace.nr_entries; n++)
+		if (attr->address_start <= entries[n] &&
+			       entries[n] < attr->address_end)
+			return 1;
+	return 0;
+}
+
+#else
+
+static inline int fail_stacktrace(struct fault_attr *attr)
+{
+	static int firsttime = 1;
+
+	if (firsttime) {
+		printk(KERN_WARNING
+		"This architecture does not implement save_stack_trace()"\n");
+		firsttime = 0;
+	}
+	return 0;
+}
+
+#endif
+
 /*
  * This code is stolen from failmalloc-1.0
  * http://www.nongnu.org/failmalloc/
@@ -74,6 +153,9 @@ int should_fail(struct fault_attr *attr,
 	if (attr->task_filter && !fail_task(attr, current))
 		return 0;
 
+	if (!fail_any_address(attr) && !fail_stacktrace(attr))
+		return 0;
+
 	if (atomic_read(&max_failures(attr)) == 0)
 		return 0;
 
@@ -168,6 +250,18 @@ void cleanup_fault_attr_entries(struct f
 			debugfs_remove(attr->entries.task_filter_file);
 			attr->entries.task_filter_file = NULL;
 		}
+		if (attr->entries.stacktrace_depth_file) {
+			debugfs_remove(attr->entries.stacktrace_depth_file);
+			attr->entries.stacktrace_depth_file = NULL;
+		}
+		if (attr->entries.address_start_file) {
+			debugfs_remove(attr->entries.address_start_file);
+			attr->entries.address_start_file = NULL;
+		}
+		if (attr->entries.address_end_file) {
+			debugfs_remove(attr->entries.address_end_file);
+			attr->entries.address_end_file = NULL;
+		}
 		debugfs_remove(attr->entries.dir);
 		attr->entries.dir = NULL;
 	}
@@ -217,6 +311,23 @@ int init_fault_attr_entries(struct fault
 		goto fail;
 	attr->entries.task_filter_file = file;
 
+	file = debugfs_create_ul("stacktrace-depth", mode, dir,
+				   &attr->stacktrace_depth);
+	if (!file)
+		goto fail;
+	attr->entries.stacktrace_depth_file = file;
+
+	file = debugfs_create_ul("address-start", mode, dir,
+				   &attr->address_start);
+	if (!file)
+		goto fail;
+	attr->entries.address_start_file = file;
+
+	file = debugfs_create_ul("address-end", mode, dir, &attr->address_end);
+	if (!file)
+		goto fail;
+	attr->entries.address_end_file = file;
+
 	return 0;
 fail:
 	cleanup_fault_attr_entries(attr);
Index: work-fault-inject/include/linux/fault-inject.h
===================================================================
--- work-fault-inject.orig/include/linux/fault-inject.h
+++ work-fault-inject/include/linux/fault-inject.h
@@ -18,6 +18,9 @@ struct fault_attr {
 	atomic_t space;
 	unsigned long verbose;
 	u32 task_filter;
+	unsigned long stacktrace_depth;
+	unsigned long address_start;
+	unsigned long address_end;
 
 	unsigned long count;
 
@@ -32,6 +35,9 @@ struct fault_attr {
 		struct dentry *space_file;
 		struct dentry *verbose_file;
 		struct dentry *task_filter_file;
+		struct dentry *stacktrace_depth_file;
+		struct dentry *address_start_file;
+		struct dentry *address_end_file;
 	} entries;
 
 #endif
@@ -41,6 +47,7 @@ struct fault_attr {
 	struct fault_attr name = {				\
 		.interval = 1,					\
 		.times = ATOMIC_INIT(1),			\
+		.address_end = ULONG_MAX,			\
 	}
 
 int setup_fault_attr(struct fault_attr *attr, char *str);
Index: work-fault-inject/lib/Kconfig.debug
===================================================================
--- work-fault-inject.orig/lib/Kconfig.debug
+++ work-fault-inject/lib/Kconfig.debug
@@ -472,6 +472,8 @@ config LKDTM
 
 config FAULT_INJECTION
 	bool
+	select STACKTRACE
+	select FRAME_POINTER
 
 config FAILSLAB
 	bool "fault-injection capabilitiy for kmalloc"

--
