Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVLOOqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVLOOqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVLOOpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:45:45 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:32922 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750711AbVLOOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:15 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143808.011897000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:02 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 05/21] PID Virtualization: code enhancements for virtual pids in /proc
Content-Disposition: inline; filename=F5-code-cleanup-procarray.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid ugly parameter specifications for the sprintf statement
we pull the ppid,tpid computations out. Later these statements
will get a tiny bit more elaborate, because we need to deal with
the special case of an illegal task_vvpid (not in the same container)
virtualization. This is simply in preparation for that.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 fs/proc/array.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc1/fs/proc/array.c
===================================================================
--- linux-2.6.15-rc1.orig/fs/proc/array.c	2005-12-12 16:12:09.000000000 -0500
+++ linux-2.6.15-rc1/fs/proc/array.c	2005-12-12 16:13:36.000000000 -0500
@@ -161,8 +161,17 @@ static inline char * task_state(struct t
 	struct group_info *group_info;
 	int g;
 	struct fdtable *fdt = NULL;
+	pid_t ppid, tpid;
 
 	read_lock(&tasklist_lock);
+	if (pid_alive(p))
+		ppid = task_vtgid(p->group_leader->real_parent);
+	else
+		ppid = 0;
+	if (pid_alive(p) && p->ptrace)
+		tpid = task_vppid(p);
+	else
+		tpid = 0;
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
 		"SleepAVG:\t%lu%%\n"
@@ -175,9 +184,8 @@ static inline char * task_state(struct t
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	task_vtgid(p),
-		task_vpid(p), pid_alive(p) ?
-			task_vtgid(p->group_leader->real_parent) : 0,
-		pid_alive(p) && p->ptrace ? task_vpid(p->parent) : 0,
+		task_vpid(p),
+		ppid, tpid,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);

--
