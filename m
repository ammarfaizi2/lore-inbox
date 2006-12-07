Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031828AbWLGIKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031828AbWLGIKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031831AbWLGIKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:10:08 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:4470 "EHLO
	outbound0.sv.meer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031828AbWLGIKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:10:06 -0500
Subject: [PATCH 2/5 -mm] fault-injection: Use bool-true-false throughout
From: Don Mullis <dwm@meer.net>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <1165478812.2706.8.camel@localhost.localdomain>
References: <1165478812.2706.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 00:10:03 -0800
Message-Id: <1165479003.2706.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use bool-true-false throughout.

Signed-off-by: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 include/linux/fault-inject.h |    2 +-
 lib/fault-inject.c           |   40 +++++++++++++++++++---------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

Index: linux-2.6.18/include/linux/fault-inject.h
===================================================================
--- linux-2.6.18.orig/include/linux/fault-inject.h
+++ linux-2.6.18/include/linux/fault-inject.h
@@ -57,7 +57,7 @@ struct fault_attr {
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
@@ -48,7 +48,7 @@ static void fail_dump(struct fault_attr 
 
 #define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
 
-static int fail_task(struct fault_attr *attr, struct task_struct *task)
+static bool fail_task(struct fault_attr *attr, struct task_struct *task)
 {
 	return !in_interrupt() && task->make_it_fail;
 }
@@ -68,15 +68,15 @@ static asmlinkage int fail_stacktrace_ca
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
 
@@ -85,9 +85,7 @@ static int fail_stacktrace(struct fault_
 
 #elif defined(CONFIG_STACKTRACE)
 
-#define MAX_STACK_TRACE_DEPTH 32
-
-static int fail_stacktrace(struct fault_attr *attr)
+static bool fail_stacktrace(struct fault_attr *attr)
 {
 	struct stack_trace trace;
 	int depth = attr->stacktrace_depth;
@@ -109,26 +107,26 @@ static int fail_stacktrace(struct fault_
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
@@ -138,32 +136,32 @@ static inline int fail_stacktrace(struct
  * http://www.nongnu.org/failmalloc/
  */
 
-int should_fail(struct fault_attr *attr, ssize_t size)
+bool should_fail(struct fault_attr *attr, ssize_t size)
 {
 	if (attr->task_filter && !fail_task(attr, current))
-		return 0;
+		return false;
 
 	if (!fail_stacktrace(attr))
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
 
 	if (attr->probability > random32() % 100)
 		goto fail;
 
-	return 0;
+	return false;
 
 fail:
 	fail_dump(attr);
@@ -171,7 +169,7 @@ fail:
 	if (atomic_read(&attr->times) != -1)
 		atomic_dec_not_zero(&attr->times);
 
-	return 1;
+	return true;
 }
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS


