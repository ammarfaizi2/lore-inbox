Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWAQPAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWAQPAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWAQPAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:00:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26531 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751239AbWAQOub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:31 -0500
Message-Id: <20060117143329.386499000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:29 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 31/34] PID Virtualization Implementation of low level virtualization functions
Content-Disposition: inline; filename=G5-virtfunct-impl.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We finally utilize the pid space implementation to obtain a real virtualizaton
inside the pid/vpid conversion functions. Care has been taken to retain
the fast path (either in global context or in the same pidspace) as inline, 
while the exception case (typically involves checking for container root)
is handled separately.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 include/linux/sched.h |   49 +++++++++++++++++++++++++++++++++++++++++++------
 kernel/container.c    |   28 ++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 6 deletions(-)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:37:08.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:09.000000000 -0500
@@ -870,9 +870,25 @@
  *  pid domain translation functions:
  *	- from kernel to user pid domain
  */
+
+extern pid_t __pid_to_vpid_ctx_excp(pid_t pid, int psid_pid,
+				     const struct task_struct *ctx);
+
 static inline pid_t pid_to_vpid_ctx(pid_t pid, const struct task_struct *ctx)
 {
-	return pid;
+	int psid_pid, psid_ctx;
+
+	if (!ctx->container)
+		return pid;
+
+	psid_ctx = pid_to_pidspace(ctx->__pid);
+	psid_pid = pid_to_pidspace(pid);
+	pid      = pidspace_pid_to_vpid(pid);
+
+	if (likely(psid_ctx == psid_pid))
+		return pid;
+
+	return __pid_to_vpid_ctx_excp(pid, psid_pid, ctx);
 }
 
 static inline pid_t pid_to_vpid(pid_t pid)
@@ -884,9 +900,11 @@
 {
 	int isgrp = (pid < 0) ;
 
-	if (isgrp) pid = -pid;
+	if (isgrp)
+		pid = -pid;
 	pid = pid_to_vpid_ctx(pid, ctx);
-	if (isgrp) pid = -pid;
+	if (isgrp && pid != -1)
+		pid = -pid;
 	return pid;
 }
 
@@ -895,13 +913,32 @@
 	return pgid_to_vpgid_ctx(pid, current);
 }
 
+extern pid_t __vpid_to_pid_excp(pid_t pid);
+
 static inline pid_t vpid_to_pid(pid_t pid)
 {
-	return pid;
+	if (!current->container)
+		return pid;
+
+	if (pid == 1)
+		return current->container->init_pid;
+
+	if (!pid_to_pidspace(pid)) {
+		int psid = pid_to_pidspace(current->__pid);
+		return pidspace_vpid_to_pid(psid, pid);
+	}
+	return __vpid_to_pid_excp(pid);
 }
 
 static inline pid_t vpgid_to_pgid(pid_t pid)
 {
+	int isgrp = (pid < 0) ;
+
+	if (isgrp)
+		pid = -pid;
+	pid = vpid_to_pid(pid);
+	if (isgrp && pid != -1)
+		pid = -pid;
 	return pid;
 }
 
@@ -931,7 +968,7 @@
 static inline pid_t task_vpid_ctx(const struct task_struct *p,
 				   const struct task_struct *ctx)
 {
-	return task_pid(p);
+	return pid_to_vpid_ctx(task_pid(p), ctx);
 }
 
 static inline pid_t task_vpid(const struct task_struct *p)
@@ -963,7 +1000,7 @@
 
 static inline pid_t virt_process_group(const struct task_struct *p)
 {
-	return process_group(p);
+	return pid_to_vpid(process_group(p));
 }
 
 static inline unsigned int task_pidspace_id(const struct task_struct *p)
Index: linux-2.6.15/kernel/container.c
===================================================================
--- linux-2.6.15.orig/kernel/container.c	2006-01-17 08:37:08.000000000 -0500
+++ linux-2.6.15/kernel/container.c	2006-01-17 08:37:09.000000000 -0500
@@ -138,3 +138,31 @@
 	return rc;
 }
 
+pid_t __pid_to_vpid_ctx_excp(pid_t pid, int pidspace_id,
+			     const struct task_struct *ctx)
+{
+	/* figure out whether pid .. virtual to pidspace_id_pid space
+	 * is meaningful to ctx (which is in differnt pidspace_id).
+	 * since a container's init_proc resides physically in psdi=0
+	 */
+	if (unlikely(ctx == ctx->container->init_proc)) {
+		if (pidspace_id != ctx->container->pidspace_id)
+			pid = -1;
+		return pid;
+	}
+	if (pid == ctx->container->init_pid)
+		return 1;
+	return -1;
+}
+
+pid_t __vpid_to_pid_excp(pid_t pid)
+{
+	/* we only let realpid pass as vpid if it marks the top of
+	 * current is the init_proc and vpid == init_pid
+	 */
+	if (current->container->pidspace_id == pid_to_pidspace(pid))
+		return pid;
+	return -1;
+}
+
+

--

