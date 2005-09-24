Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVIXVmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVIXVmE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIXVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 17:42:04 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:21663 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750767AbVIXVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 17:42:02 -0400
Date: Sat, 24 Sep 2005 14:42:01 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Unify sys_tkill() and sys_tgkill(), take 2
Message-ID: <Pine.LNX.4.58.0509241439410.13229@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The majority of the sys_tkill() and sys_tgkill() function code is
duplicated between the two of them. This patch pulls the duplication out
into a separate function -- do_tkill() -- and lets sys_tkill() and
sys_tgkill() be simple wrappers around it. This should make it easier to
maintain in light of future changes.

Diffed against 2.6.14-rc2.
Incorporates the latest LKML feedback.

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	2005-09-22 18:32:48.000000000 -0700
+++ b/kernel/signal.c	2005-09-24 14:32:58.000000000 -0700
@@ -2262,26 +2262,13 @@ sys_kill(int pid, int sig)
 	return kill_something_info(sig, &info, pid);
 }

-/**
- *  sys_tgkill - send signal to one specific thread
- *  @tgid: the thread group ID of the thread
- *  @pid: the PID of the thread
- *  @sig: signal to be sent
- *
- *  This syscall also checks the tgid and returns -ESRCH even if the PID
- *  exists but it's not belonging to the target process anymore. This
- *  method solves the problem of threads exiting and PIDs getting reused.
- */
-asmlinkage long sys_tgkill(int tgid, int pid, int sig)
+static int do_tkill(int tgid, int pid, int sig)
 {
-	struct siginfo info;
 	int error;
+	struct siginfo info;
 	struct task_struct *p;

-	/* This is only valid for single tasks */
-	if (pid <= 0 || tgid <= 0)
-		return -EINVAL;
-
+	error = -ESRCH;
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code = SI_TKILL;
@@ -2290,8 +2277,7 @@ asmlinkage long sys_tgkill(int tgid, int

 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
-	error = -ESRCH;
-	if (p && (p->tgid == tgid)) {
+	if (p && (tgid <= 0 || p->tgid == tgid)) {
 		error = check_kill_permission(sig, &info, p);
 		/*
 		 * The null signal is a permissions and process existence
@@ -2305,47 +2291,40 @@ asmlinkage long sys_tgkill(int tgid, int
 		}
 	}
 	read_unlock(&tasklist_lock);
+
 	return error;
 }

+/**
+ *  sys_tgkill - send signal to one specific thread
+ *  @tgid: the thread group ID of the thread
+ *  @pid: the PID of the thread
+ *  @sig: signal to be sent
+ *
+ *  This syscall also checks the tgid and returns -ESRCH even if the PID
+ *  exists but it's not belonging to the target process anymore. This
+ *  method solves the problem of threads exiting and PIDs getting reused.
+ */
+asmlinkage long sys_tgkill(int tgid, int pid, int sig)
+{
+	/* This is only valid for single tasks */
+	if (pid <= 0 || tgid <= 0)
+		return -EINVAL;
+
+	return do_tkill(tgid, pid, sig);
+}
+
 /*
  *  Send a signal to only one task, even if it's a CLONE_THREAD task.
  */
 asmlinkage long
 sys_tkill(int pid, int sig)
 {
-	struct siginfo info;
-	int error;
-	struct task_struct *p;
-
 	/* This is only valid for single tasks */
 	if (pid <= 0)
 		return -EINVAL;

-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code = SI_TKILL;
-	info.si_pid = current->tgid;
-	info.si_uid = current->uid;
-
-	read_lock(&tasklist_lock);
-	p = find_task_by_pid(pid);
-	error = -ESRCH;
-	if (p) {
-		error = check_kill_permission(sig, &info, p);
-		/*
-		 * The null signal is a permissions and process existence
-		 * probe.  No signal is actually delivered.
-		 */
-		if (!error && sig && p->sighand) {
-			spin_lock_irq(&p->sighand->siglock);
-			handle_stop_signal(sig, p);
-			error = specific_send_sig_info(sig, &info, p);
-			spin_unlock_irq(&p->sighand->siglock);
-		}
-	}
-	read_unlock(&tasklist_lock);
-	return error;
+	return do_tkill(0, pid, sig);
 }

 asmlinkage long
