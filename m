Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935763AbWK1Hvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935763AbWK1Hvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 02:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935764AbWK1Hvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 02:51:40 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:16903 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S935763AbWK1Hvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 02:51:39 -0500
Subject: [PATCH 2/2 -mm] fault-injection: lightweight code-coverage
	maximizer
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <mita@miraclelinux.com>
In-Reply-To: <1164699866.2894.88.camel@localhost.localdomain>
References: <1164699866.2894.88.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 23:51:30 -0800
Message-Id: <1164700290.2894.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow all non-unique call stacks, as judged by pushed sequence of EIPs,
to be to be ignored as failure candidates.

Upon keying in
	echo 1 >probability
	echo 3 >verbose
	echo -1 >times
a few dozen stacks are printk'ed, then system responsiveness
recovers to normal.  Similarly, starting a non-trivial program
will print a few stacks before responsiveness recovers.

Intent is to make code-coverage-maximizing test lightweight, perhaps
light enough to remain enabled during the course of the developer's
interactive testing of new code.

Enabled by default. (/debug/fail*/stacktrace-depth > 0)

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/fault-injection/fault-injection.txt |    7 +
 include/linux/fault-inject.h                      |    4 
 lib/fault-inject.c                                |  123 +++++++++++++++++++---
 3 files changed, 120 insertions(+), 14 deletions(-)

Index: linux-2.6.18/include/linux/fault-inject.h
===================================================================
--- linux-2.6.18.orig/include/linux/fault-inject.h
+++ linux-2.6.18/include/linux/fault-inject.h
@@ -23,6 +23,8 @@ struct fault_attr {
 	unsigned long require_end;
 	unsigned long reject_start;
 	unsigned long reject_end;
+	unsigned long uniquestack_depth;
+	atomic_t uniquestack_hash_table[256];
 
 	unsigned long count;
 
@@ -42,6 +44,7 @@ struct fault_attr {
 		struct dentry *require_end_file;
 		struct dentry *reject_start_file;
 		struct dentry *reject_end_file;
+		struct dentry *uniquestack_depth_file;
 	} dentries;
 
 #endif
@@ -53,6 +56,7 @@ struct fault_attr {
 		.require_end = ULONG_MAX,			\
 		.stacktrace_depth = 32,				\
 		.verbose = 2,					\
+		.uniquestack_depth = 32,			\
 	}
 
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
Index: linux-2.6.18/lib/fault-inject.c
===================================================================
--- linux-2.6.18.orig/lib/fault-inject.c
+++ linux-2.6.18/lib/fault-inject.c
@@ -1,3 +1,4 @@
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/random.h>
@@ -9,8 +10,12 @@
 #include <linux/unwind.h>
 #include <linux/stacktrace.h>
 #include <linux/kallsyms.h>
+#include <linux/jhash.h>
+#include <linux/syscalls.h>
 #include <linux/fault-inject.h>
 
+#define MAX_STACK_TRACE_DEPTH 32
+
 /*
  * setup_fault_attr() is a helper function for various __setup handlers, so it
  * returns 0 on error, because that is what __setup handlers do.
@@ -21,10 +26,11 @@ int __init setup_fault_attr(struct fault
 	unsigned long interval;
 	int times;
 	int space;
+ 	unsigned long uniquestack_depth;
 
-	/* "<interval>,<probability>,<space>,<times>" */
-	if (sscanf(str, "%lu,%lu,%d,%d",
-			&interval, &probability, &space, &times) < 4) {
+	/* "<interval>,<probability>,<space>,<times>,<uniquestack_depth>" */
+	if (sscanf(str, "%lu,%lu,%d,%d,%lu", &interval,
+		   &probability, &space, &times, &uniquestack_depth) < 5) {
 		printk(KERN_WARNING
 			"FAULT_INJECTION: failed to parse arguments\n");
 		return 0;
@@ -34,6 +40,8 @@ int __init setup_fault_attr(struct fault
 	attr->interval = interval;
 	atomic_set(&attr->times, times);
 	atomic_set(&attr->space, space);
+	attr->uniquestack_depth = (uniquestack_depth <= MAX_STACK_TRACE_DEPTH) ?
+		uniquestack_depth : MAX_STACK_TRACE_DEPTH;
 
 	return 1;
 }
@@ -53,8 +61,6 @@ static bool fail_task(struct fault_attr 
 	return !in_interrupt() && task->make_it_fail;
 }
 
-#define MAX_STACK_TRACE_DEPTH 32
-
 #ifdef CONFIG_STACK_UNWIND
 
 static asmlinkage int fail_stacktrace_callback(struct unwind_frame_info *info,
@@ -85,26 +91,54 @@ static bool fail_stacktrace(struct fault
 	return unwind_init_running(&info, fail_stacktrace_callback, attr);
 }
 
+static asmlinkage int unique_stack_callback(struct unwind_frame_info *info,
+						void *arg)
+{
+	u32 entries[MAX_STACK_TRACE_DEPTH];
+	int depth;
+	struct fault_attr *attr = arg;
+
+	for (depth = 0; depth < attr->uniquestack_depth
+			&& unwind(info) == 0 && UNW_PC(info); depth++) {
+		if (arch_unw_user_mode(info))
+			break;
+	}
+	if (attr->verbose > 8)
+		printk("%s: depth=%d, jhash=%x\n",
+		       __FUNCTION__, depth,
+		       jhash( entries, depth*sizeof(entries[0]), 0));
+	return jhash( entries, depth*sizeof(entries[0]), 0/*initval*/);
+}
+
+static int unique_stack_p(struct fault_attr *attr)
+{
+	struct unwind_frame_info info;
+
+	return unwind_init_running(&info, unique_stack_callback, attr);
+}
+
 #elif defined(CONFIG_STACKTRACE)
 
+static void stack_trace(struct stack_trace *trace, int depth)
+{
+	trace->nr_entries = 0;
+	trace->max_entries = depth;
+	trace->skip = 1;
+	trace->all_contexts = 0;
+
+	save_stack_trace(trace, NULL);
+}
+
 static bool fail_stacktrace(struct fault_attr *attr)
 {
 	struct stack_trace trace;
-	int depth = attr->stacktrace_depth;
 	unsigned long entries[MAX_STACK_TRACE_DEPTH];
 	int n;
 	bool found = (attr->require_start == 0 && attr->require_end == ULONG_MAX);
 
-	if (depth == 0)
-		return found;
-
-	trace.nr_entries = 0;
 	trace.entries = entries;
-	trace.max_entries = depth;
-	trace.skip = 1;
-	trace.all_contexts = 0;
 
-	save_stack_trace(&trace, NULL);
+	stack_trace(&trace, attr->stacktrace_depth);
 	for (n = 0; n < trace.nr_entries; n++) {
 		if (attr->reject_start <= entries[n] &&
 			       entries[n] < attr->reject_end)
@@ -116,6 +150,23 @@ static bool fail_stacktrace(struct fault
 	return found;
 }
 
+static int unique_stack_p(struct fault_attr *attr)
+{
+	struct stack_trace trace;
+	unsigned long entries[MAX_STACK_TRACE_DEPTH];
+
+	trace.entries = entries;
+	stack_trace(&trace, attr->uniquestack_depth);
+
+	if (attr->verbose > 8)
+		printk("%s: trace.nr_entries=%d jhash=%x\n",
+		       __FUNCTION__, trace.nr_entries,
+		       jhash( trace.entries,
+			      trace.nr_entries*sizeof(trace.entries[0]), 0));
+	return jhash( trace.entries,
+		      trace.nr_entries*sizeof(trace.entries[0]), 0/*initval*/);
+}
+
 #else
 
 static inline bool fail_stacktrace(struct fault_attr *attr)
@@ -130,8 +181,42 @@ static inline bool fail_stacktrace(struc
 	return false;
 }
 
+static int unique_stack_p(struct fault_attr *attr)
+{
+	(void) fail_stacktrace(attr);
+	return 0;
+}
 #endif
 
+static bool fail_uniquestack(struct fault_attr *attr)
+{
+	u32 oldhash;
+	u32 newhash;
+	uint offset = 0;
+
+	newhash = unique_stack_p(attr);
+
+	for ( oldhash = newhash; oldhash != 0; offset++) {
+		oldhash = atomic_xchg(
+			&attr->uniquestack_hash_table[
+				(newhash+offset)%ARRAY_SIZE(attr->uniquestack_hash_table)],
+			oldhash);
+		if (oldhash == newhash)
+			return false;
+		if (offset >= ARRAY_SIZE(attr->uniquestack_hash_table)) {
+			printk(KERN_NOTICE
+			       "FAULT_INJECTION: table overflow -- "
+			       "fault injection disabled\n");
+			return false;
+		}
+	}
+
+	if (attr->verbose > 8)
+		printk(KERN_NOTICE "FAULT_INJECTION: newhash=%x offset==%d\n",
+		       newhash, offset-1);
+	return true;
+}
+
 /*
  * This code is stolen from failmalloc-1.0
  * http://www.nongnu.org/failmalloc/
@@ -162,6 +247,9 @@ bool should_fail(struct fault_attr *attr
 	if (!fail_stacktrace(attr))
 		return false;
 
+	if (!fail_uniquestack(attr))
+		return false;
+
 	fail_dump(attr);
 
 	if (atomic_read(&attr->times) != -1)
@@ -262,6 +350,9 @@ void cleanup_fault_attr_dentries(struct 
 	debugfs_remove(attr->dentries.reject_end_file);
 	attr->dentries.reject_end_file = NULL;
 
+	debugfs_remove(attr->dentries.uniquestack_depth_file);
+	attr->dentries.uniquestack_depth_file = NULL;
+
 	if (attr->dentries.dir)
 		WARN_ON(!simple_empty(attr->dentries.dir));
 
@@ -315,6 +406,9 @@ int init_fault_attr_dentries(struct faul
 	attr->dentries.reject_end_file =
 		debugfs_create_ul("reject-end", mode, dir, &attr->reject_end);
 
+	attr->dentries.uniquestack_depth_file =
+		debugfs_create_ul_MAX_STACK_TRACE_DEPTH(
+			"uniquestack-depth", mode, dir, &attr->uniquestack_depth);
 
 	if (!attr->dentries.probability_file || !attr->dentries.interval_file
 	    || !attr->dentries.times_file || !attr->dentries.space_file
@@ -324,6 +418,7 @@ int init_fault_attr_dentries(struct faul
 	    || !attr->dentries.require_end_file
 	    || !attr->dentries.reject_start_file
 	    || !attr->dentries.reject_end_file
+	    || !attr->dentries.uniquestack_depth_file
 	    )
 		goto fail;
 
Index: linux-2.6.18/Documentation/fault-injection/fault-injection.txt
===================================================================
--- linux-2.6.18.orig/Documentation/fault-injection/fault-injection.txt
+++ linux-2.6.18/Documentation/fault-injection/fault-injection.txt
@@ -91,6 +91,13 @@ configuration of fault-injection capabil
 	for a caller within [require-start,require-end) OR
 	[reject-start,reject-end).
 
+- /debug/fail*/uniquestack-depth:
+
+	specifies the stacktrace depth walked during calculation of a
+	hash of caller's EIPs.  Hash is compared against a record of
+	those already seen since boot; if duplicate, no failure is injected.
+	'0' disables the test.
+
 - /debug/fail_page_alloc/ignore-gfp-highmem:
 
 	Format: { 'Y' | 'N' }


