Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWBFTjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWBFTjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWBFTjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:39:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27885 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932317AbWBFTjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:39:10 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 05/20] sched: Fixup the scheduler syscalls to deal with
 pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:36:42 -0700
In-Reply-To: <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:34:08 -0700")
Message-ID: <m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The scheduler is controlled by pid, so fix up the guts of it's system
calls to pass the appropriate pspace when looking up tasks by pid.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/sched.c |    2 +-
 kernel/sys.c   |   14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

e37379b11b63503c1146cc17cec75c358154a1ec
diff --git a/kernel/sched.c b/kernel/sched.c
index 6579d49..449cc6e 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -3701,7 +3701,7 @@ task_t *idle_task(int cpu)
  */
 static inline task_t *find_process_by_pid(pid_t pid)
 {
-	return pid ? find_task_by_pid(pid) : current;
+	return pid ? find_task_by_pid(current->pspace, pid) : current;
 }
 
 /* Actually do priority change: must hold rq lock. */
diff --git a/kernel/sys.c b/kernel/sys.c
index dc8cb58..bd594c3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -264,6 +264,7 @@ out:
 
 asmlinkage long sys_setpriority(int which, int who, int niceval)
 {
+	struct pspace *pspace = current->pspace;
 	struct task_struct *g, *p;
 	struct user_struct *user;
 	int error = -EINVAL;
@@ -283,16 +284,16 @@ asmlinkage long sys_setpriority(int whic
 		case PRIO_PROCESS:
 			if (!who)
 				who = current->pid;
-			p = find_task_by_pid(who);
+			p = find_task_by_pid(pspace, who);
 			if (p)
 				error = set_one_prio(p, niceval, error);
 			break;
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			do_each_task_pid(pspace, who, PIDTYPE_PGID, p) {
 				error = set_one_prio(p, niceval, error);
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			} while_each_task_pid(pspace, who, PIDTYPE_PGID, p);
 			break;
 		case PRIO_USER:
 			user = current->user;
@@ -324,6 +325,7 @@ out:
  */
 asmlinkage long sys_getpriority(int which, int who)
 {
+	struct pspace *pspace = current->pspace;
 	struct task_struct *g, *p;
 	struct user_struct *user;
 	long niceval, retval = -ESRCH;
@@ -336,7 +338,7 @@ asmlinkage long sys_getpriority(int whic
 		case PRIO_PROCESS:
 			if (!who)
 				who = current->pid;
-			p = find_task_by_pid(who);
+			p = find_task_by_pid(pspace, who);
 			if (p) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
@@ -346,11 +348,11 @@ asmlinkage long sys_getpriority(int whic
 		case PRIO_PGRP:
 			if (!who)
 				who = process_group(current);
-			do_each_task_pid(who, PIDTYPE_PGID, p) {
+			do_each_task_pid(pspace, who, PIDTYPE_PGID, p) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
 					retval = niceval;
-			} while_each_task_pid(who, PIDTYPE_PGID, p);
+			} while_each_task_pid(pspace, who, PIDTYPE_PGID, p);
 			break;
 		case PRIO_USER:
 			user = current->user;
-- 
1.1.5.g3480

