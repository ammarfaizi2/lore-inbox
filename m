Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935757AbWK1Hoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935757AbWK1Hoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 02:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935762AbWK1Hoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 02:44:39 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:27910 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S935757AbWK1Hoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 02:44:38 -0500
Subject: [PATCH 1/2 -mm] fault-injection: safer defaults, trivial
	optimization, cleanup
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <mita@miraclelinux.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 23:44:26 -0800
Message-Id: <1164699866.2894.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set /debug/fail*/* defaults supposed most likely to please a new user.
Clamp /debug/fail*/stacktrace-depth to MAX_STACK_TRACE_DEPTH.

In should_fail(), move stack-unwinding test past cheaper tests (performance
gain not quantified).  Simplify logic; eliminate goto.
Use bool/true/false consistently.

Correct and disambiguate documentation.

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/fault-injection/failmodule.sh       |    4 -
 Documentation/fault-injection/fault-injection.txt |   39 +++++------
 include/linux/fault-inject.h                      |    3 
 lib/fault-inject.c                                |   74 +++++++++++++---------
 mm/page_alloc.c                                   |    2 
 mm/slab.c                                         |    1 
 6 files changed, 71 insertions(+), 52 deletions(-)

Index: linux-2.6.18/mm/slab.c
===================================================================
--- linux-2.6.18.orig/mm/slab.c
+++ linux-2.6.18/mm/slab.c
@@ -3111,6 +3111,7 @@ static struct failslab_attr {
 
 } failslab = {
 	.attr = FAULT_ATTR_INITIALIZER,
+	.ignore_gfp_wait = 1,
 };
 
 static int __init setup_failslab(char *str)
Index: linux-2.6.18/include/linux/fault-inject.h
===================================================================
--- linux-2.6.18.orig/include/linux/fault-inject.h
+++ linux-2.6.18/include/linux/fault-inject.h
@@ -52,12 +52,13 @@ struct fault_attr {
 		.times = ATOMIC_INIT(1),			\
 		.require_end = ULONG_MAX,			\
 		.stacktrace_depth = 32,				\
+		.verbose = 2,					\
 	}
 
 #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
 int setup_fault_attr(struct fault_attr *attr, char *str);
 void should_fail_srandom(unsigned long entropy);
-int should_fail(struct fault_attr *attr, ssize_t size);
+bool should_fail(struct fault_attr *attr, ssize_t size);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 
Index: linux-2.6.18/lib/fault-inject.c
===================================================================
--- linux-2.6.18.orig/lib/fault-inject.c
+++ linux-2.6.18/lib/fault-inject.c
@@ -48,11 +48,13 @@ static void fail_dump(struct fault_attr 
 
 #define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
 
-static int fail_task(struct fault_attr *attr, struct task_struct *task)
+static bool fail_task(struct fault_attr *attr, struct task_struct *task)
 {
 	return !in_interrupt() && task->make_it_fail;
 }
 
+#define MAX_STACK_TRACE_DEPTH 32
+
 #ifdef CONFIG_STACK_UNWIND
 
 static asmlinkage int fail_stacktrace_callback(struct unwind_frame_info *info,
@@ -68,15 +70,15 @@ static asmlinkage int fail_stacktrace_ca
 			break;
 		if (attr->reject_start <= UNW_PC(info) &&
 			       UNW_PC(info) < attr->reject_end)
-			return 0;
+			return false;
 		if (attr->require_start <= UNW_PC(info) &&
 			       UNW_PC(info) < attr->require_end)
-			found = 1;
+			found = true;
 	}
 	return found;
 }
 
-static int fail_stacktrace(struct fault_attr *attr)
+static bool fail_stacktrace(struct fault_attr *attr)
 {
 	struct unwind_frame_info info;
 
@@ -85,9 +87,7 @@ static int fail_stacktrace(struct fault_
 
 #elif defined(CONFIG_STACKTRACE)
 
-#define MAX_STACK_TRACE_DEPTH 32
-
-static int fail_stacktrace(struct fault_attr *attr)
+static bool fail_stacktrace(struct fault_attr *attr)
 {
 	struct stack_trace trace;
 	int depth = attr->stacktrace_depth;
@@ -100,8 +100,7 @@ static int fail_stacktrace(struct fault_
 
 	trace.nr_entries = 0;
 	trace.entries = entries;
-	trace.max_entries = (depth < MAX_STACK_TRACE_DEPTH) ?
-				depth : MAX_STACK_TRACE_DEPTH;
+	trace.max_entries = depth;
 	trace.skip = 1;
 	trace.all_contexts = 0;
 
@@ -109,26 +108,26 @@ static int fail_stacktrace(struct fault_
 	for (n = 0; n < trace.nr_entries; n++) {
 		if (attr->reject_start <= entries[n] &&
 			       entries[n] < attr->reject_end)
-			return 0;
+			return false;
 		if (attr->require_start <= entries[n] &&
 			       entries[n] < attr->require_end)
-			found = 1;
+			found = true;
 	}
 	return found;
 }
 
 #else
 
-static inline int fail_stacktrace(struct fault_attr *attr)
+static inline bool fail_stacktrace(struct fault_attr *attr)
 {
-	static int firsttime = 1;
+	static bool firsttime = true;
 
 	if (firsttime) {
 		printk(KERN_WARNING
 		"This architecture does not implement save_stack_trace()\n");
-		firsttime = 0;
+		firsttime = false;
 	}
-	return 0;
+	return false;
 }
 
 #endif
@@ -138,40 +137,37 @@ static inline int fail_stacktrace(struct
  * http://www.nongnu.org/failmalloc/
  */
 
-int should_fail(struct fault_attr *attr, ssize_t size)
+bool should_fail(struct fault_attr *attr, ssize_t size)
 {
 	if (attr->task_filter && !fail_task(attr, current))
-		return 0;
-
-	if (!fail_stacktrace(attr))
-		return 0;
+		return false;
 
 	if (atomic_read(&attr->times) == 0)
-		return 0;
+		return false;
 
 	if (atomic_read(&attr->space) > size) {
 		atomic_sub(size, &attr->space);
-		return 0;
+		return false;
 	}
 
 	if (attr->interval > 1) {
 		attr->count++;
 		if (attr->count % attr->interval)
-			return 0;
+			return false;
 	}
 
-	if (attr->probability > random32() % 100)
-		goto fail;
+	if (attr->probability <= random32() % 100)
+		return false;
 
-	return 0;
+	if (!fail_stacktrace(attr))
+		return false;
 
-fail:
 	fail_dump(attr);
 
 	if (atomic_read(&attr->times) != -1)
 		atomic_dec_not_zero(&attr->times);
 
-	return 1;
+	return true;
 }
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
@@ -181,6 +177,13 @@ static void debugfs_ul_set(void *data, u
 	*(unsigned long *)data = val;
 }
 
+static void debugfs_ul_set_MAX_STACK_TRACE_DEPTH(void *data, u64 val)
+{
+	*(unsigned long *)data =
+		val < MAX_STACK_TRACE_DEPTH ?
+		val : MAX_STACK_TRACE_DEPTH;
+}
+
 static u64 debugfs_ul_get(void *data)
 {
 	return *(unsigned long *)data;
@@ -194,6 +197,17 @@ static struct dentry *debugfs_create_ul(
 	return debugfs_create_file(name, mode, parent, value, &fops_ul);
 }
 
+DEFINE_SIMPLE_ATTRIBUTE(fops_ul_MAX_STACK_TRACE_DEPTH, debugfs_ul_get,
+			debugfs_ul_set_MAX_STACK_TRACE_DEPTH, "%llu\n");
+
+static struct dentry *debugfs_create_ul_MAX_STACK_TRACE_DEPTH(
+	const char *name, mode_t mode,
+	struct dentry *parent, unsigned long *value)
+{
+	return debugfs_create_file(name, mode, parent, value,
+				   &fops_ul_MAX_STACK_TRACE_DEPTH);
+}
+
 static void debugfs_atomic_t_set(void *data, u64 val)
 {
 	atomic_set((atomic_t *)data, val);
@@ -286,8 +300,8 @@ int init_fault_attr_dentries(struct faul
 						mode, dir, &attr->task_filter);
 
 	attr->dentries.stacktrace_depth_file =
-		debugfs_create_ul("stacktrace-depth", mode, dir,
-				  &attr->stacktrace_depth);
+		debugfs_create_ul_MAX_STACK_TRACE_DEPTH(
+			"stacktrace-depth", mode, dir, &attr->stacktrace_depth);
 
 	attr->dentries.require_start_file =
 		debugfs_create_ul("require-start", mode, dir, &attr->require_start);
Index: linux-2.6.18/mm/page_alloc.c
===================================================================
--- linux-2.6.18.orig/mm/page_alloc.c
+++ linux-2.6.18/mm/page_alloc.c
@@ -929,6 +929,8 @@ static struct fail_page_alloc_attr {
 
 } fail_page_alloc = {
 	.attr = FAULT_ATTR_INITIALIZER,
+	.ignore_gfp_wait = 1,
+	.ignore_gfp_highmem = 1,
 };
 
 static int __init setup_fail_page_alloc(char *str)
Index: linux-2.6.18/Documentation/fault-injection/failmodule.sh
===================================================================
--- linux-2.6.18.orig/Documentation/fault-injection/failmodule.sh
+++ linux-2.6.18/Documentation/fault-injection/failmodule.sh
@@ -26,6 +26,6 @@ fi
 # Disable any fault injection
 echo 0 > /debug/$1/stacktrace-depth
 
-echo `cat /sys/module/$2/sections/.text` > /debug/$1/address-start
-echo `cat /sys/module/$2/sections/.exit.text` > /debug/$1/address-end
+echo `cat /sys/module/$2/sections/.text` > /debug/$1/require-start
+echo `cat /sys/module/$2/sections/.exit.text` > /debug/$1/require-end
 echo $STACKTRACE_DEPTH > /debug/$1/stacktrace-depth
Index: linux-2.6.18/Documentation/fault-injection/fault-injection.txt
===================================================================
--- linux-2.6.18.orig/Documentation/fault-injection/fault-injection.txt
+++ linux-2.6.18/Documentation/fault-injection/fault-injection.txt
@@ -29,16 +29,16 @@ o debugfs entries
 fault-inject-debugfs kernel module provides some debugfs entries for runtime
 configuration of fault-injection capabilities.
 
-- /debug/*/probability:
+- /debug/fail*/probability:
 
 	likelihood of failure injection, in percent.
 	Format: <percent>
 
 	Note that one-failure-per-handred is a very high error rate
 	for some testcases. Please set probably=100 and configure
-	/debug/*/interval for such testcases.
+	/debug/fail*/interval for such testcases.
 
-- /debug/*/interval:
+- /debug/fail*/interval:
 
 	specifies the interval between failures, for calls to
 	should_fail() that pass all the other tests.
@@ -46,18 +46,18 @@ configuration of fault-injection capabil
 	Note that if you enable this, by setting interval>1, you will
 	probably want to set probability=100.
 
-- /debug/*/times:
+- /debug/fail*/times:
 
 	specifies how many times failures may happen at most.
 	A value of -1 means "no limit".
 
-- /debug/*/space:
+- /debug/fail*/space:
 
 	specifies an initial resource "budget", decremented by "size"
 	on each call to should_fail(,size).  Failure injection is
 	suppressed until "space" reaches zero.
 
-- /debug/*/verbose
+- /debug/fail*/verbose
 
 	Format: { 0 | 1 | 2 }
 	specifies the verbosity of the messages when failure is injected.
@@ -66,17 +66,17 @@ configuration of fault-injection capabil
 	it is useful to debug the problems revealed by fault injection
 	capabilities.
 
-- /debug/*/task-filter:
+- /debug/fail*/task-filter:
 
-	Format: { 0 | 1 }
-	A value of '0' disables filtering by process (default).
+	Format: { 'Y' | 'N' }
+	A value of 'N' disables filtering by process (default).
 	Any positive value limits failures to only processes indicated by
 	/proc/<pid>/make-it-fail==1.
 
-- /debug/*/require-start:
-- /debug/*/require-end:
-- /debug/*/reject-start:
-- /debug/*/reject-end:
+- /debug/fail*/require-start:
+- /debug/fail*/require-end:
+- /debug/fail*/reject-start:
+- /debug/fail*/reject-end:
 
 	specifies the range of virtual addresses tested during
 	stacktrace walking.  Failure is injected only if some caller
@@ -85,22 +85,23 @@ configuration of fault-injection capabil
 	Default required range is [0,ULONG_MAX) (whole of virtual address space).
 	Default rejected range is [0,0).
 
-- /debug/*/stacktrace-depth:
+- /debug/fail*/stacktrace-depth:
 
 	specifies the maximum stacktrace depth walked during search
-	for a caller within [address-start,address-end).
+	for a caller within [require-start,require-end) OR
+	[reject-start,reject-end).
 
 - /debug/fail_page_alloc/ignore-gfp-highmem:
 
-	Format: { 0 | 1 }
-	default is 0, setting it to '1' won't inject failures into
+	Format: { 'Y' | 'N' }
+	default is 'N', setting it to 'Y' won't inject failures into
 	highmem/user allocations.
 
 - /debug/failslab/ignore-gfp-wait:
 - /debug/fail_page_alloc/ignore-gfp-wait:
 
-	Format: { 0 | 1 }
-	default is 0, setting it to '1' will inject failures
+	Format: { 'Y' | 'N' }
+	default is 'N', setting it to 'Y' will inject failures
 	only into non-sleep allocations (GFP_ATOMIC allocations).
 
 o Boot option


