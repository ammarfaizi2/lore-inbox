Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVLOOjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVLOOjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVLOOjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:39:42 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:61850 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750727AbVLOOjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:39:16 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143909.434438000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:13 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 16/21] PID Virtualization: container attach/detach calls
Content-Disposition: inline; filename=G3-container-fork-exit.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call the container attach and detach functions at their respective
locations. This happens during the fork and exit functions.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 kernel/exit.c |    1 +
 kernel/fork.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc1/kernel/exit.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/exit.c	2005-12-12 18:39:51.000000000 -0500
+++ linux-2.6.15-rc1/kernel/exit.c	2005-12-12 18:41:09.000000000 -0500
@@ -101,6 +101,7 @@ repeat: 
 		zap_leader = (leader->exit_signal == -1);
 	}
 
+	container_detach(p);
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
Index: linux-2.6.15-rc1/kernel/fork.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/fork.c	2005-12-12 18:40:32.000000000 -0500
+++ linux-2.6.15-rc1/kernel/fork.c	2005-12-12 18:41:36.000000000 -0500
@@ -43,6 +43,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/container.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1001,6 +1002,7 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_mm;
 	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_keys;
+	container_attach(p);
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
@@ -1178,6 +1180,7 @@ bad_fork_cleanup_policy:
 	mpol_free(p->mempolicy);
 #endif
 bad_fork_cleanup:
+	container_detach(p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
@@ -1241,7 +1244,7 @@ long do_fork(unsigned long clone_flags,
 {
 	struct task_struct *p;
 	int trace = 0;
-	long pid = alloc_pidmap(DEFAULT_PIDSPACE);
+	long pid = alloc_pidmap(task_pidspace_id(current));
 	long vpid;
 
 	if (pid < 0)

--
