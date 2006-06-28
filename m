Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWF1Xqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWF1Xqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWF1Xqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:46:53 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:9958 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751792AbWF1Xqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:46:51 -0400
Date: Wed, 28 Jun 2006 19:46:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>
Subject: [PATCH 2/3] SELinux: Add security hook call to kill_proc_info_as_uid
In-Reply-To: <Pine.LNX.4.64.0606281943240.17149@d.namei>
Message-ID: <Pine.LNX.4.64.0606281945560.17159@d.namei>
References: <Pine.LNX.4.64.0606281943240.17149@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Quigley <dpquigl@tycho.nsa.gov>

This patch adds a call to the extended security_task_kill hook introduced 
by the prior patch to the kill_proc_info_as_uid function so that these 
signals can be properly mediated by security modules. It also updates the 
existing hook call in check_kill_permission.

Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>


Please apply.

---

include/linux/sched.h |    2 +-
kernel/signal.c       |    7 +++++--
2 files changed, 6 insertions(+), 3 deletions(-)

diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/include/linux/sched.h linux-2.6.17-mm3-kill/include/linux/sched.h
--- linux-2.6.17-mm3/include/linux/sched.h	2006-06-28 13:58:59.000000000 -0400
+++ linux-2.6.17-mm3-kill/include/linux/sched.h	2006-06-27 14:46:36.000000000 -0400
@@ -1249,7 +1249,7 @@ extern int force_sig_info(int, struct si
 extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
-extern int kill_proc_info_as_uid(int, struct siginfo *, pid_t, uid_t, uid_t);
+extern int kill_proc_info_as_uid(int, struct siginfo *, pid_t, uid_t, uid_t, u32);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/kernel/signal.c linux-2.6.17-mm3-kill/kernel/signal.c
--- linux-2.6.17-mm3/kernel/signal.c	2006-06-28 13:58:59.000000000 -0400
+++ linux-2.6.17-mm3-kill/kernel/signal.c	2006-06-28 14:34:26.000000000 -0400
@@ -584,7 +584,7 @@ static int check_kill_permission(int sig
 	    && !capable(CAP_KILL))
 		return error;
 
-	error = security_task_kill(t, info, sig);
+	error = security_task_kill(t, info, sig, 0);
 	if (!error)
 		audit_signal_info(sig, t); /* Let audit system see the signal */
 	return error;
@@ -1107,7 +1107,7 @@ kill_proc_info(int sig, struct siginfo *
 
 /* like kill_proc_info(), but doesn't use uid/euid of "current" */
 int kill_proc_info_as_uid(int sig, struct siginfo *info, pid_t pid,
-		      uid_t uid, uid_t euid)
+		      uid_t uid, uid_t euid, u32 secid)
 {
 	int ret = -EINVAL;
 	struct task_struct *p;
@@ -1127,6 +1127,9 @@ int kill_proc_info_as_uid(int sig, struc
 		ret = -EPERM;
 		goto out_unlock;
 	}
+	ret = security_task_kill(p, info, sig, secid);
+	if (ret)
+		goto out_unlock;
 	if (sig && p->sighand) {
 		unsigned long flags;
 		spin_lock_irqsave(&p->sighand->siglock, flags);
