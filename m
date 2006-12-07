Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031832AbWLGIOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031832AbWLGIOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031835AbWLGIOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:14:18 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:4684 "EHLO
	outbound0.sv.meer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031832AbWLGIOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:14:18 -0500
Subject: [PATCH 3/5 -mm] fault-injection: Clamp debugfs stacktrace-depth to
	MAX_STACK_TRACE_DEPTH
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <1165478812.2706.8.camel@localhost.localdomain>
References: <1165478812.2706.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 00:14:15 -0800
Message-Id: <1165479255.2706.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clamp /debug/fail*/stacktrace-depth to MAX_STACK_TRACE_DEPTH.
Ensures that a read of /debug/fail*/stacktrace-depth always
returns a truthful answer.

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/fault-inject.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

Index: linux-2.6.18/lib/fault-inject.c
===================================================================
--- linux-2.6.18.orig/lib/fault-inject.c
+++ linux-2.6.18/lib/fault-inject.c
@@ -53,6 +53,8 @@ static bool fail_task(struct fault_attr 
 	return !in_interrupt() && task->make_it_fail;
 }
 
+#define MAX_STACK_TRACE_DEPTH 32
+
 #ifdef CONFIG_STACK_UNWIND
 
 static asmlinkage int fail_stacktrace_callback(struct unwind_frame_info *info,
@@ -98,8 +100,7 @@ static bool fail_stacktrace(struct fault
 
 	trace.nr_entries = 0;
 	trace.entries = entries;
-	trace.max_entries = (depth < MAX_STACK_TRACE_DEPTH) ?
-				depth : MAX_STACK_TRACE_DEPTH;
+	trace.max_entries = depth;
 	trace.skip = 1;
 	trace.all_contexts = 0;
 
@@ -179,6 +180,13 @@ static void debugfs_ul_set(void *data, u
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
@@ -192,6 +200,17 @@ static struct dentry *debugfs_create_ul(
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
@@ -284,8 +303,8 @@ int init_fault_attr_dentries(struct faul
 						mode, dir, &attr->task_filter);
 
 	attr->dentries.stacktrace_depth_file =
-		debugfs_create_ul("stacktrace-depth", mode, dir,
-				  &attr->stacktrace_depth);
+		debugfs_create_ul_MAX_STACK_TRACE_DEPTH(
+			"stacktrace-depth", mode, dir, &attr->stacktrace_depth);
 
 	attr->dentries.require_start_file =
 		debugfs_create_ul("require-start", mode, dir, &attr->require_start);


