Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVAaViu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVAaViu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVAaViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:38:50 -0500
Received: from [139.30.44.16] ([139.30.44.16]:46729 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261384AbVAaVin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:38:43 -0500
Date: Mon, 31 Jan 2005 22:38:41 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] "biological parent" pid
Message-ID: <Pine.LNX.4.53.0501311923440.18039@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ppid of a process is not really helpful if I want to reconstruct the 
real history of processes on a machine, since it may become 1 when the
parent dies and the process is reparented to init.

I am not aware of concepts in Linux or other unices that apply to this
case. So I made up the "biological parent pid" bioppid (in contrast to the
adoptive parents pid) that just never changes.
Any user of it must of course remember that it doesn't need to be a valid 
pid anymore or might even belong to a different process that was forked in 
the meantime. bioppid only had to be a valid pid at time btime (it's
a (btime, pid) pair that unambiguously identifies a process).

Comments? (other that I just broke /proc/nnn/status parsing once again :-)

Tim


--- linux-2.6.10/include/linux/sched.h	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-ppid/include/linux/sched.h	2005-01-31 19:20:00.000000000 +0100
@@ -556,6 +556,7 @@ struct task_struct {
 	unsigned did_exec:1;
 	pid_t pid;
 	pid_t tgid;
+	pid_t bioppid;                  /* biological parents */
 	/* 
 	 * pointers to (original) parent process, youngest child, younger sibling,
 	 * older sibling, respectively.  (p->father can be replaced with 

--- linux-2.6.10/kernel/fork.c	2004-12-24 22:33:59.000000000 +0100
+++ linux-2.6.10-ppid/kernel/fork.c	2005-01-31 18:15:39.000000000 +0100
@@ -889,6 +889,7 @@ static task_t *copy_process(unsigned lon
 	p->tgid = p->pid;
 	if (clone_flags & CLONE_THREAD)
 		p->tgid = current->tgid;
+	p->bioppid = current->pid;
 
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;

--- linux-2.6.10/fs/proc/array.c	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.10-ppid/fs/proc/array.c	2005-01-31 18:19:02.000000000 +0100
@@ -165,6 +165,7 @@ static inline char * task_state(struct t
 		"Tgid:\t%d\n"
 		"Pid:\t%d\n"
 		"PPid:\t%d\n"
+		"BioPPid:\t%d\n"
 		"TracerPid:\t%d\n"
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
@@ -172,6 +173,7 @@ static inline char * task_state(struct t
 		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	p->tgid,
 		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
+		p->bioppid,
 		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);

--- linux-2.6.10/kernel/acct.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.10-ppid/kernel/acct.c	2005-01-31 18:19:35.000000000 +0100
@@ -446,7 +446,7 @@ static void do_acct_process(long exitcod
 #endif
 #if ACCT_VERSION==3
 	ac.ac_pid = current->tgid;
-	ac.ac_ppid = current->parent->tgid;
+	ac.ac_ppid = current->bioppid;
 #endif
 
 	read_lock(&tasklist_lock);	/* pin current->signal */
