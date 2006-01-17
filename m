Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWAQOvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWAQOvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAQOvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:51:01 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:52421 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751225AbWAQOua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143329.041007000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:27 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 29/34] PID Virtualization container attach/detach calls
Content-Disposition: inline; filename=G3-container-fork-exit.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call the container attach and detach functions at their respective
locations. This happens during the fork and exit functions.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 exit.c |    1 +
 fork.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.15/kernel/exit.c
===================================================================
--- linux-2.6.15.orig/kernel/exit.c	2006-01-17 08:37:07.000000000 -0500
+++ linux-2.6.15/kernel/exit.c	2006-01-17 08:37:08.000000000 -0500
@@ -101,6 +101,7 @@
 		zap_leader = (leader->exit_signal == -1);
 	}
 
+	container_detach(p);
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
Index: linux-2.6.15/kernel/fork.c
===================================================================
--- linux-2.6.15.orig/kernel/fork.c	2006-01-17 08:37:08.000000000 -0500
+++ linux-2.6.15/kernel/fork.c	2006-01-17 08:37:08.000000000 -0500
@@ -43,6 +43,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/container.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -999,6 +1000,7 @@
 		goto bad_fork_cleanup_mm;
 	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_keys;
+	container_attach(p);
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
@@ -1175,6 +1177,7 @@
 	mpol_free(p->mempolicy);
 #endif
 bad_fork_cleanup:
+	container_detach(p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
@@ -1238,7 +1241,7 @@
 {
 	struct task_struct *p;
 	int trace = 0;
-	long pid = alloc_pidmap(DEFAULT_PIDSPACE);
+	long pid = alloc_pidmap(task_pidspace_id(current));
 	long vpid;
 
 	if (pid < 0)

--

