Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWISGA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWISGA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWISGA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:00:27 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:36872 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S932242AbWISGA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:00:26 -0400
Subject: Re: [patch 7/8] process filtering for fault-injection capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <20060914102032.989190948@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102032.989190948@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:54:51 -0700
Message-Id: <1158645291.2419.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add functionality to the process_filter variable: A negative argument
injects failures for only for pid==-process_filter, thereby permitting
per-process failures from boot time.

Restore process-filter arg to kernel command line.

Reintroduce process_filter_file addition to debugfs,
factored out earlier in series.

Add printk, called upon each failure injection.


Signed-off-by: Don Mullis <dwm@meer.net>

---
 Documentation/fault-injection/fault-injection.txt |    9 +++++++
 include/linux/fault-inject.h                      |    1 
 lib/fault-inject-debugfs.c                        |   11 ++++++++
 lib/fault-inject.c                                |   27 ++++++++++++++++------
 4 files changed, 40 insertions(+), 8 deletions(-)

Index: linux-2.6.17/include/linux/fault-inject.h
===================================================================
--- linux-2.6.17.orig/include/linux/fault-inject.h
+++ linux-2.6.17/include/linux/fault-inject.h
@@ -15,11 +15,8 @@ struct fault_attr {
 	unsigned long interval;
 	atomic_t times;
 	atomic_t space;
-
 	unsigned long count;
-
-	/* A value of '0' means process filter is disabled. */
-	u32 process_filter;
+	atomic_t process_filter;
 };
 
 #define DEFINE_FAULT_ATTR(name) \
Index: linux-2.6.17/lib/fault-inject.c
===================================================================
--- linux-2.6.17.orig/lib/fault-inject.c
+++ linux-2.6.17/lib/fault-inject.c
@@ -14,11 +14,12 @@ int setup_fault_attr(struct fault_attr *
 	unsigned long interval;
 	int times;
 	int space;
+	int process_filter;
 
-	/* "<interval>,<probability>,<space>,<times>" */
-	if (sscanf(str, "%lu,%lu,%d,%d",
-			&interval, &probability, &space, &times) < 4) {
-		printk(KERN_WARNING "SHOULD_FAIL: failed to parse arguments\n");
+	/* "<interval>,<probability>,<process-filter>,<space>,<times>" */
+	if (sscanf(str, "%lu,%lu,%d,%d,%d",
+			&interval, &probability, &process_filter, &space, &times) < 4) {
+		printk(KERN_WARNING "FAULT_INJECTION: failed to parse arguments\n");
 		return 0;
 	}
 
@@ -26,6 +27,7 @@ int setup_fault_attr(struct fault_attr *
 	attr->interval = interval;
 	atomic_set(&attr->times, times);
 	atomic_set(&attr->space, space);
+	atomic_set(&attr->process_filter, process_filter);
 
 	return 1;
 }
@@ -53,10 +55,20 @@ void should_fail_srandom(unsigned long e
 static int fail_process(struct fault_attr *attr, struct task_struct *task)
 {
 	/* process filter is disabled */
-	if (!attr->process_filter)
+	if (atomic_read(&attr->process_filter)==0)
 		return 1;
 
-	return !in_interrupt() && task->make_it_fail;
+	/* controlled by /proc/<pid>/make-it-fail, but boolean not set */
+	if (atomic_read(&attr->process_filter)>0 && !task->make_it_fail)
+		return 0;
+
+	/* enabled for single pid, but no match with pid */
+	if (atomic_read(&attr->process_filter)<0 &&
+	    -atomic_read(&attr->process_filter)!=task->pid)
+		return 0;
+
+	/* XX  Are we sure we never want calls from interrupt context to fail? */
+	return !in_interrupt();
 }
 
 /*
@@ -89,7 +101,8 @@ int should_fail(struct fault_attr *attr,
 	return 0;
 
 fail:
-
+	printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure, pid==%d\n",
+	       current->pid);
 	if (atomic_read(&max_failures(attr)) != -1)
 		atomic_dec_not_zero(&max_failures(attr));
 
Index: linux-2.6.17/Documentation/fault-injection/fault-injection.txt
===================================================================
--- linux-2.6.17.orig/Documentation/fault-injection/fault-injection.txt
+++ linux-2.6.17/Documentation/fault-injection/fault-injection.txt
@@ -52,6 +52,15 @@ configuration of fault-injection capabil
 	on each call to should_fail(,size).  Failure injection is
 	suppressed until "space" reaches zero.
 
+- /debug/*/process-filter:
+
+	filter failures by pid.
+	A value of '0' disables filtering by process.
+	Any positive value limits failures to only processes indicated by
+	/proc/<pid>/make-it-fail==1.
+	A negative value means that failures are enabled for
+	pid==-process_filter irrespective of /proc/<pid>/make-it-fail.
+
 o Boot option
 
 In order to inject faults while debugfs is not available (early boot time),
Index: linux-2.6.17/lib/fault-inject-debugfs.c
===================================================================
--- linux-2.6.17.orig/lib/fault-inject-debugfs.c
+++ linux-2.6.17/lib/fault-inject-debugfs.c
@@ -8,6 +8,7 @@ struct fault_attr_entries {
 	struct dentry *interval_file;
 	struct dentry *times_file;
 	struct dentry *space_file;
+	struct dentry *process_filter_file;
 };
 
 static void debugfs_ul_set(void *data, u64 val)
@@ -66,6 +67,10 @@ static void cleanup_fault_attr_entries(s
 			debugfs_remove(entries->space_file);
 			entries->space_file = NULL;
 		}
+		if (entries->process_filter_file) {
+			debugfs_remove(entries->process_filter_file);
+			entries->process_filter_file = NULL;
+		}
 		debugfs_remove(entries->dir);
 		entries->dir = NULL;
 	}
@@ -105,6 +110,12 @@ static int init_fault_attr_entries(struc
 		goto fail;
 	entries->space_file = file;
 
+	file = debugfs_create_atomic_t("process-filter", mode, dir,
+				       &attr->process_filter);
+	if (!file)
+		goto fail;
+	entries->process_filter_file = file;
+
 	return 0;
 fail:
 	cleanup_fault_attr_entries(entries);


