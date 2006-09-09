Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWIIWUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWIIWUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWIIWUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:20:16 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:18900 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964973AbWIIWUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:20:14 -0400
Date: Sun, 10 Sep 2006 02:20:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Jean Delvare <jdelvare@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] proc: drop tasklist lock in task_state()
Message-ID: <20060909222002.GA152@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

task_state() needs tasklist_lock to protect ->parent/->real_parent.
However task->parent points to nowhere only when the actions below
happen in order

	1) release_task(task)		
	2) release_task(task->parent)
	3) a grace period passed

But 3) implies that the memory ops from 1) should be finished, so
pid_alive() can't be true in such a case.

Otherwise, we don't care if ->parent/->real_parent changes under us.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc6-mm1/fs/proc/array.c~3_tstate	2006-09-09 22:48:30.000000000 +0400
+++ rc6-mm1/fs/proc/array.c	2006-09-10 01:15:10.000000000 +0400
@@ -162,7 +162,7 @@ static inline char * task_state(struct t
 	int g;
 	struct fdtable *fdt = NULL;
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	buffer += sprintf(buffer,
 		"State:\t%s\n"
 		"SleepAVG:\t%lu%%\n"
@@ -174,14 +174,13 @@ static inline char * task_state(struct t
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
-	       	p->tgid,
-		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
-		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
+	       	p->tgid, p->pid,
+	       	pid_alive(p) ? rcu_dereference(p->real_parent)->tgid : 0,
+		pid_alive(p) && p->ptrace ? rcu_dereference(p->parent)->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
-	read_unlock(&tasklist_lock);
+
 	task_lock(p);
-	rcu_read_lock();
 	if (p->files)
 		fdt = files_fdtable(p->files);
 	buffer += sprintf(buffer,

