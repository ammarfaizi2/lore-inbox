Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161393AbWKHRsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161393AbWKHRsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161398AbWKHRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:48:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754632AbWKHRr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:47:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=dJeUtJEGGGS0Zv5Ff4xoFSmPIBDcW0J8l4FoXOyBjM91iGkT2SUmHfjUMS+9ht1EObbmKlZI0QzA8rTyWQAyZhOxtiyVB03Ec/2gozjuwFGztZFh1dspA9Ct/EVxgrlnYc9Zuzwuf0EeHlPsFsGZJb9svhhwNYJIZRk1vHB4sRE=
References: <20061108174540.976625689@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:48 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 7/7] stacktrace filtering
Content-Disposition: inline; filename=module-filter.patch
Message-ID: <4552184b.3677cb4e.51c4.ffffbd4f@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides stacktrace filtering feature.

The stacktrace filter allows failing only for the caller you are
interested in.

For example someone may want to inject kmalloc() failures into
only e100 module. they want to inject not only direct kmalloc() call,
but also indirect allocation, too.

- e100_poll --> netif_receive_skb --> packet_rcv_spkt --> skb_clone
  --> kmem_cache_alloc

This patch enables to detect function calls like this by stacktrace
and inject failures. The script Documentaion/fault-injection/failmodule.sh
helps it.

The range of text section of loaded e100 is expected to be
[/sys/module/e100/sections/.text, /sys/module/e100/sections/.exit.text)

So failmodule.sh stores these values into /debug/failslab/address-start
and /debug/failslab/address-end. The maximum stacktrace depth is specified
by /debug/failslab/stacktrace-depth.

Please see the example that demonstrates how to inject slab allocation
failures only for a specific module
in Documentation/fault-injection/fault-injection.txt

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Don Mullis <dwm@meer.net>

 include/linux/fault-inject.h |    7 ++
 lib/Kconfig.debug            |    2 
 lib/fault-inject.c           |  107 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 115 insertions(+), 1 deletion(-)

Index: 2.6-rc/lib/fault-inject.c
===================================================================
--- 2.6-rc.orig/lib/fault-inject.c
+++ 2.6-rc/lib/fault-inject.c
@@ -6,6 +6,9 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/unwind.h>
+#include <linux/stacktrace.h>
+#include <linux/kallsyms.h>
 #include <linux/fault-inject.h>
 
 int setup_fault_attr(struct fault_attr *attr, char *str)
@@ -46,6 +49,82 @@ static int fail_task(struct fault_attr *
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
+		"This architecture does not implement save_stack_trace()\n");
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
@@ -56,6 +135,9 @@ int should_fail(struct fault_attr *attr,
 	if (attr->task_filter && !fail_task(attr, current))
 		return 0;
 
+	if (!fail_any_address(attr) && !fail_stacktrace(attr))
+		return 0;
+
 	if (atomic_read(&attr->times) == 0)
 		return 0;
 
@@ -143,6 +225,15 @@ void cleanup_fault_attr_dentries(struct 
 	debugfs_remove(attr->dentries.task_filter_file);
 	attr->dentries.task_filter_file = NULL;
 
+	debugfs_remove(attr->dentries.stacktrace_depth_file);
+	attr->dentries.stacktrace_depth_file = NULL;
+
+	debugfs_remove(attr->dentries.address_start_file);
+	attr->dentries.address_start_file = NULL;
+
+	debugfs_remove(attr->dentries.address_end_file);
+	attr->dentries.address_end_file = NULL;
+
 	if (attr->dentries.dir)
 		WARN_ON(!simple_empty(attr->dentries.dir));
 
@@ -180,9 +271,23 @@ int init_fault_attr_dentries(struct faul
 	attr->dentries.task_filter_file = debugfs_create_bool("task-filter",
 						mode, dir, &attr->task_filter);
 
+	attr->dentries.stacktrace_depth_file =
+		debugfs_create_ul("stacktrace-depth", mode, dir,
+				  &attr->stacktrace_depth);
+
+	attr->dentries.address_start_file = debugfs_create_ul("address-start",
+					mode, dir, &attr->address_start);
+
+	attr->dentries.address_end_file =
+		debugfs_create_ul("address-end", mode, dir, &attr->address_end);
+
+
 	if (!attr->dentries.probability_file || !attr->dentries.interval_file
 	    || !attr->dentries.times_file || !attr->dentries.space_file
-	    || !attr->dentries.verbose_file || !attr->dentries.task_filter_file)
+	    || !attr->dentries.verbose_file || !attr->dentries.task_filter_file
+	    || !attr->dentries.stacktrace_depth_file
+	    || !attr->dentries.address_start_file
+	    || !attr->dentries.address_end_file)
 		goto fail;
 
 	return 0;
Index: 2.6-rc/include/linux/fault-inject.h
===================================================================
--- 2.6-rc.orig/include/linux/fault-inject.h
+++ 2.6-rc/include/linux/fault-inject.h
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
 	} dentries;
 
 #endif
@@ -40,6 +46,7 @@ struct fault_attr {
 #define FAULT_ATTR_INITIALIZER {				\
 		.interval = 1,					\
 		.times = ATOMIC_INIT(1),			\
+		.address_end = ULONG_MAX,			\
 	}
 
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER	
Index: 2.6-rc/lib/Kconfig.debug
===================================================================
--- 2.6-rc.orig/lib/Kconfig.debug
+++ 2.6-rc/lib/Kconfig.debug
@@ -415,6 +415,8 @@ config LKDTM
 
 config FAULT_INJECTION
 	bool
+	select STACKTRACE
+	select FRAME_POINTER
 
 config FAILSLAB
 	bool "Fault-injection capabilitiy for kmalloc"

--
