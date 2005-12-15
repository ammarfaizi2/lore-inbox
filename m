Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVLOOmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVLOOmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLOOji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:39:38 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:6299 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750733AbVLOOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:39:33 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143926.069085000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:16 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 19/21] PID Virtualization: Handle special case vpid return cases
Content-Disposition: inline; filename=G6-vpid-rc-special-handling.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Certain places in the virtual pid return locations need special handling
to return the appropriate information back to the user.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 fs/proc/array.c |   17 ++++++++++-------
 fs/proc/base.c  |    2 ++
 kernel/signal.c |    8 ++++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

Index: linux-2.6.15-rc1/fs/proc/base.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/base.c	2005-12-12 16:44:15.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/base.c	2005-12-12 16:44:33.000000000 -0500
@@ -2103,6 +2103,8 @@ static int get_tgid_list(int index, unsi
 
 	for ( ; p != &init_task; p = next_task(p)) {
 		int tgid = task_vpid_ctx(p, current);
+		if (tgid < 0)
+			continue;
 		if (!pid_alive(p))
 			continue;
 		if (--index >= 0)
Index: linux-2.6.15-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/array.c	2005-12-12 16:44:15.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/array.c	2005-12-12 16:44:15.000000000 -0500
@@ -164,13 +164,16 @@ static inline char * task_state(struct t
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
@@ -183,8 +186,8 @@ static inline char * task_state(struct t
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
Index: linux-2.6.15-rc1/kernel/signal.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/signal.c	2005-12-12 16:44:15.000000000 -0500
+++ linux-2.6.15-rc1/kernel/signal.c	2005-12-12 16:44:32.000000000 -0500
@@ -2266,6 +2266,12 @@ static int do_tkill(int tgid, int pid, i
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
@@ -2273,8 +2279,6 @@ static int do_tkill(int tgid, int pid, i
 	info.si_pid = task_vtgid(current);
 	info.si_uid = current->uid;
 
-	pid  = vpid_to_pid(pid);
-	tgid = vpid_to_pid(tgid);
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	if (p && (tgid <= 0 || task_tgid(p) == tgid)) {

--
