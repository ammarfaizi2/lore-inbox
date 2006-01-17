Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWAQOxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAQOxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAQOvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:51:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:53421 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750928AbWAQOua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143327.142026000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:16 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 18/34] PID Virtualization code enhancements for virtual pids in /proc
Content-Disposition: inline; filename=F5-code-cleanup-procarray.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid ugly parameter specifications for the sprintf statement
we pull the ppid,tpid computations out. Later these statements
will get a tiny bit more elaborate, because we need to deal with
the special case of an illegal task_vvpid (not in the same container)
virtualization. This is simply in preparation for that.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
---
 array.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6.15/fs/proc/array.c
===================================================================
--- linux-2.6.15.orig/fs/proc/array.c	2006-01-17 08:37:04.000000000 -0500
+++ linux-2.6.15/fs/proc/array.c	2006-01-17 08:37:04.000000000 -0500
@@ -161,8 +161,17 @@
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
@@ -175,9 +184,8 @@
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

