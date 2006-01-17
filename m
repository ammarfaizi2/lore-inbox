Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWAQPAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWAQPAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAQPAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:00:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:39625 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751263AbWAQOuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:32 -0500
Message-Id: <20060117143329.554149000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:30 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 32/34] PID Virtualization Handle special case vpid return cases
Content-Disposition: inline; filename=G6-vpid-rc-special-handling.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Certain places in the virtual pid return locations need special handling
to return the appropriate information back to the user.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 fs/proc/array.c |   15 +++++++++------
 fs/proc/base.c  |    2 ++
 kernel/signal.c |    8 ++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

Index: linux-2.6.15/fs/proc/base.c
===================================================================
--- linux-2.6.15.orig/fs/proc/base.c	2006-01-17 08:37:07.000000000 -0500
+++ linux-2.6.15/fs/proc/base.c	2006-01-17 08:37:09.000000000 -0500
@@ -2103,6 +2103,8 @@
 
 	for ( ; p != &init_task; p = next_task(p)) {
 		int tgid = task_vpid_ctx(p, current);
+		if (tgid < 0)
+			continue;
 		if (!pid_alive(p))
 			continue;
 		if (--index >= 0)
Index: linux-2.6.15/fs/proc/array.c
===================================================================
--- linux-2.6.15.orig/fs/proc/array.c	2006-01-17 08:37:07.000000000 -0500
+++ linux-2.6.15/fs/proc/array.c	2006-01-17 08:37:09.000000000 -0500
@@ -164,13 +164,16 @@
 	pid_t ppid, tpid;
 
 	read_lock(&tasklist_lock);
-	if (pid_alive(p))
+	if (pid_alive(p)) {
 		ppid = task_vtgid_ctx(p->group_leader->real_parent, current);
-	else
+		if (ppid < 0) ppid = 1;
+	} else {
 		ppid = 0;
-	if (pid_alive(p) && p->ptrace)
+	}
+	if (pid_alive(p) && p->ptrace) {
 		tpid = task_vppid_ctx(p, current);
-	else
+		if (tpid < 0) tpid = 0;
+	} else
 		tpid = 0;
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
@@ -183,8 +186,8 @@
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
-	       	task_vtgid_ctx(p,current),
-		task_vpid_ctx(p,current),
+	       	task_vtgid_ctx(p, current),
+		task_vpid_ctx(p, current),
 		ppid, tpid,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
Index: linux-2.6.15/kernel/signal.c
===================================================================
--- linux-2.6.15.orig/kernel/signal.c	2006-01-17 08:37:07.000000000 -0500
+++ linux-2.6.15/kernel/signal.c	2006-01-17 08:37:09.000000000 -0500
@@ -2257,6 +2257,12 @@
 	struct siginfo info;
 	struct task_struct *p;
 
+	pid  = vpid_to_pid(pid);
+	if (pid < 0)
+		return pid;
+	tgid = vpid_to_pid(tgid);
+	if (tgid < 0)
+		return tgid;
 	error = -ESRCH;
 	info.si_signo = sig;
 	info.si_errno = 0;
@@ -2264,8 +2270,6 @@
 	info.si_pid = task_vtgid(current);
 	info.si_uid = current->uid;
 
-	pid  = vpid_to_pid(pid);
-	tgid = vpid_to_pid(tgid);
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	if (p && (tgid <= 0 || task_tgid(p) == tgid)) {

--

