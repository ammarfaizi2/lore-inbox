Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWHCEWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWHCEWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWHCEWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:22:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22194 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932340AbWHCEWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:22:12 -0400
Message-ID: <44D179F8.6000907@engr.sgi.com>
Date: Wed, 02 Aug 2006 21:22:16 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [patch 2/3] Extended system accounting over taskstats
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010603070206000308040305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603070206000308040305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch is to replace "[patch 2/3] add CSA accounting to
taskstats" posted on 7/31.

This patch adds extended system accounting handling over
taskstats interface. A CONFIG_TASK_XACCT flag is created
to enable the extended accounting code.


Signed-off-by:  Jay Lan <jlan@sgi.com>



--------------010603070206000308040305
Content-Type: text/plain;
 name="taskstats-acct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="taskstats-acct.patch"

Index: linux/include/linux/taskstats.h
===================================================================
--- linux.orig/include/linux/taskstats.h	2006-08-02 16:03:31.000000000 -0700
+++ linux/include/linux/taskstats.h	2006-08-02 19:09:02.880918552 -0700
@@ -107,6 +107,17 @@ struct taskstats {
 	__u64	ac_minflt;		/* Minor Page Fault */
 	__u64	ac_majflt;		/* Major Page Fault */
 	/* Basic Accounting Fields end */
+
+ 	/* Extended accounting fields start */
+ 	__u64	acct_rss_mem1;		/* accumulated rss usage */
+ 	__u64	acct_vm_mem1;		/* accumulated virtual memory usage */
+ 	__u64	hiwater_rss;		/* High-watermark of RSS usage */
+ 	__u64	hiwater_vm;		/* High-water virtual memory usage */
+ 	__u64	read_char;		/* bytes read */
+ 	__u64	write_char;		/* bytes written */
+ 	__u64	read_syscalls;		/* read syscalls */
+ 	__u64	write_syscalls;		/* write syscalls */
+ 	/* Extended accounting fields end */
 };
 
 
Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig	2006-08-02 14:52:08.000000000 -0700
+++ linux/init/Kconfig	2006-08-02 17:12:24.937020076 -0700
@@ -182,6 +182,15 @@ config TASK_DELAY_ACCT
 
 	  Say N if unsure.
 
+config TASK_XACCT
+	bool "Enable extended accounting over taskstats (EXPERIMENTAL)"
+	depends on TASKSTATS
+	help
+	  Collect extended task accounting data and send the data
+	  to userland for processing over the taskstats interface.
+
+	  Say N if unsure.
+
 config SYSCTL
 	bool "Sysctl support" if EMBEDDED
 	default y
Index: linux/kernel/taskstats.c
===================================================================
--- linux.orig/kernel/taskstats.c	2006-08-02 15:45:36.000000000 -0700
+++ linux/kernel/taskstats.c	2006-08-02 17:15:11.618985115 -0700
@@ -20,6 +20,7 @@
 #include <linux/taskstats_kern.h>
 #include <linux/tsacct_kern.h>
 #include <linux/delayacct.h>
+#include <linux/tsacct_kern.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <net/genetlink.h>
@@ -204,6 +205,9 @@ static int fill_pid(pid_t pid, struct ta
 	stats->version = TASKSTATS_VERSION;
 	bacct_add_tsk(stats, tsk);
 
+	/* fill in extended acct fields */
+	xacct_add_tsk(stats, tsk);
+
 	/* Define err: label here if needed */
 	put_task_struct(tsk);
 	return rc;
Index: linux/include/linux/tsacct_kern.h
===================================================================
--- linux.orig/include/linux/tsacct_kern.h	2006-08-02 16:39:56.000000000 -0700
+++ linux/include/linux/tsacct_kern.h	2006-08-02 19:08:17.624349288 -0700
@@ -16,4 +16,13 @@ static inline void bacct_add_tsk(struct 
 {}
 #endif /* CONFIG_TASKSTATS */
 
+#ifdef CONFIG_TASK_XACCT
+extern void xacct_add_tsk(struct taskstats *stats, struct task_struct *p);
+#else
+static inline void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
+{}
+#endif /* CONFIG_TASK_XACCT */
+
 #endif
+
+
Index: linux/kernel/tsacct.c
===================================================================
--- linux.orig/kernel/tsacct.c	2006-08-02 16:40:42.000000000 -0700
+++ linux/kernel/tsacct.c	2006-08-02 19:16:32.806622818 -0700
@@ -67,3 +67,22 @@ void bacct_add_tsk(struct taskstats *sta
 	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
 }
 
+
+#ifdef CONFIG_TASK_XACCT
+/*
+ * fill in extended accounting fields
+ */
+void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
+{
+	stats->acct_rss_mem1 = p->acct_rss_mem1;
+	stats->acct_vm_mem1  = p->acct_vm_mem1;
+	if (p->mm) {
+		stats->hiwater_rss   = p->mm->hiwater_rss;
+		stats->hiwater_vm    = p->mm->hiwater_vm;
+	}
+	stats->read_char	= p->rchar;
+	stats->write_char	= p->wchar;
+	stats->read_syscalls	= p->syscr;
+	stats->write_syscalls	= p->syscw;
+}
+#endif


--------------010603070206000308040305--
