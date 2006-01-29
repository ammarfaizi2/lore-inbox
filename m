Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWA2H3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWA2H3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWA2H3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:29:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23007 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750888AbWA2H3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:29:03 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 3/5] pid:  Implement kill_tref.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 00:28:28 -0700
In-Reply-To: <m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Sun, 29 Jan 2006 00:24:20 -0700")
Message-ID: <m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently most functions for sending a signal to
a task or group of tasks take a pid as an argoument.
kill_ref instead takes a task_ref.  I would use a
function that simply takes a task but the tasklist_lock
must be taken to ensure that there is not a race in
derferencing task_ref->task.

kill_tref can stand in for either kill_proc, or kill_pg
depending on the type of the reference.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/sched.h |    3 +++
 kernel/signal.c       |   31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

2d2627206f44ce032e521705efb5f712d440ba13
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 12f3cc5..8cd8075 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1109,6 +1109,9 @@ extern int send_sig_info(int, struct sig
 extern int send_group_sig_info(int, struct siginfo *, struct task_struct *);
 extern int force_sigsegv(int, struct task_struct *);
 extern int force_sig_info(int, struct siginfo *, struct task_struct *);
+extern int __kill_tref_info(int sig, struct siginfo *info, struct task_ref *ref);
+extern int kill_tref_info(int sig, struct siginfo *info, struct task_ref *ref);
+extern int kill_tref(struct task_ref *ref, int sig, int priv);
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
diff --git a/kernel/signal.c b/kernel/signal.c
index d3efafd..20a67ae 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1146,6 +1146,32 @@ retry:
 	return ret;
 }
 
+int __kill_tref_info(int sig, struct siginfo *info, struct task_ref *ref)
+{
+	struct task_struct *p = ref->task;
+	int retval, success;
+
+	success = 0;
+	retval = -ESRCH;
+	do_each_task(p, ref->type) {
+		int err = group_send_sig_info(sig, info, p);
+		success |= !err;
+		retval = err;
+	} while_each_task(p, ref->type);
+	return success ? 0 : retval;
+}
+
+int kill_tref_info(int sig, struct siginfo *info, struct task_ref *ref)
+{
+	int retval;
+
+	read_lock(&tasklist_lock);
+	retval = __kill_tref_info(sig, info, ref);
+	read_unlock(&tasklist_lock);
+
+	return retval;
+}
+
 /*
  * kill_pg_info() sends a signal to a process group: this is what the tty
  * control characters do (^C, ^Z etc)
@@ -1365,6 +1391,11 @@ kill_proc(pid_t pid, int sig, int priv)
 	return kill_proc_info(sig, __si_special(priv), pid);
 }
 
+int kill_tref(struct task_ref *ref, int sig, int priv)
+{
+	return kill_tref_info(sig, __si_special(priv), ref);
+}
+
 /*
  * These functions support sending signals using preallocated sigqueue
  * structures.  This is needed "because realtime applications cannot
-- 
1.1.5.g3480

