Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWEQWTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWEQWTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWEQWTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:19:12 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53635 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751234AbWEQWMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:07 -0400
Message-Id: <20060517221414.756877000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:21 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Linus Torvalds <torvalds@g5.osdl.org>
Subject: [PATCH 21/22] [PATCH] Fix ptrace_attach()/ptrace_traceme()/de_thread() race
Content-Disposition: inline; filename=fix-ptrace_attach-ptrace_traceme-de_thread-race.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This holds the task lock (and, for ptrace_attach, the tasklist_lock)
over the actual attach event, which closes a race between attacking to a
thread that is either doing a PTRACE_TRACEME or getting de-threaded.

Thanks to Oleg Nesterov for reminding me about this, and Chris Wright
for noticing a lost return value in my first version.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/ptrace.c |   39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

--- linux-2.6.16.16.orig/kernel/ptrace.c
+++ linux-2.6.16.16/kernel/ptrace.c
@@ -149,12 +149,16 @@ int ptrace_may_attach(struct task_struct
 int ptrace_attach(struct task_struct *task)
 {
 	int retval;
-	task_lock(task);
+
 	retval = -EPERM;
 	if (task->pid <= 1)
-		goto bad;
+		goto out;
 	if (task->tgid == current->tgid)
-		goto bad;
+		goto out;
+
+	write_lock_irq(&tasklist_lock);
+	task_lock(task);
+
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
 		goto bad;
@@ -167,17 +171,15 @@ int ptrace_attach(struct task_struct *ta
 				      ? PT_ATTACHED : 0);
 	if (capable(CAP_SYS_PTRACE))
 		task->ptrace |= PT_PTRACE_CAP;
-	task_unlock(task);
 
-	write_lock_irq(&tasklist_lock);
 	__ptrace_link(task, current);
-	write_unlock_irq(&tasklist_lock);
 
 	force_sig_specific(SIGSTOP, task);
-	return 0;
 
 bad:
+	write_unlock_irq(&tasklist_lock);
 	task_unlock(task);
+out:
 	return retval;
 }
 
@@ -418,21 +420,22 @@ int ptrace_request(struct task_struct *c
  */
 int ptrace_traceme(void)
 {
-	int ret;
+	int ret = -EPERM;
 
 	/*
 	 * Are we already being traced?
 	 */
-	if (current->ptrace & PT_PTRACED)
-		return -EPERM;
-	ret = security_ptrace(current->parent, current);
-	if (ret)
-		return -EPERM;
-	/*
-	 * Set the ptrace bit in the process ptrace flags.
-	 */
-	current->ptrace |= PT_PTRACED;
-	return 0;
+	task_lock(current);
+	if (!(current->ptrace & PT_PTRACED)) {
+		ret = security_ptrace(current->parent, current);
+		/*
+		 * Set the ptrace bit in the process ptrace flags.
+		 */
+		if (!ret)
+			current->ptrace |= PT_PTRACED;
+	}
+	task_unlock(current);
+	return ret;
 }
 
 /**

--
