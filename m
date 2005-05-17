Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVEQWq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVEQWq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEQWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:43:52 -0400
Received: from graphe.net ([209.204.138.32]:2314 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261748AbVEQWhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 18:37:14 -0400
Date: Tue, 17 May 2005 15:37:07 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org, akpm@osdl.org, shai@scalex86.org
Subject: [PATCH] Optimize sys_times for a single thread process
Message-ID: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid taking the tasklist_lock in sys_times if the process is
single threaded. In a NUMA system taking the tasklist_lock may
cause a bouncing cacheline if multiple independent processes
continually call sys_times to measure their performance.

Patch against 2.6.12-rc4

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/kernel/sys.c
===================================================================
--- linux-2.6.11.orig/kernel/sys.c	2005-05-17 12:46:12.000000000 -0700
+++ linux-2.6.11/kernel/sys.c	2005-05-17 12:59:36.000000000 -0700
@@ -894,35 +894,49 @@ asmlinkage long sys_times(struct tms __u
 	 */
 	if (tbuf) {
 		struct tms tmp;
-		struct task_struct *tsk = current;
-		struct task_struct *t;
 		cputime_t utime, stime, cutime, cstime;
 
-		read_lock(&tasklist_lock);
-		utime = tsk->signal->utime;
-		stime = tsk->signal->stime;
-		t = tsk;
-		do {
-			utime = cputime_add(utime, t->utime);
-			stime = cputime_add(stime, t->stime);
-			t = next_thread(t);
-		} while (t != tsk);
-
-		/*
-		 * While we have tasklist_lock read-locked, no dying thread
-		 * can be updating current->signal->[us]time.  Instead,
-		 * we got their counts included in the live thread loop.
-		 * However, another thread can come in right now and
-		 * do a wait call that updates current->signal->c[us]time.
-		 * To make sure we always see that pair updated atomically,
-		 * we take the siglock around fetching them.
-		 */
-		spin_lock_irq(&tsk->sighand->siglock);
-		cutime = tsk->signal->cutime;
-		cstime = tsk->signal->cstime;
-		spin_unlock_irq(&tsk->sighand->siglock);
-		read_unlock(&tasklist_lock);
+		if (current == next_thread(current)) {
+			/*
+			 * Single thread case. We do not need to scan the tasklist
+			 * and thus can avoid the read_lock(&task_list_lock). We
+			 * also do not need to take the siglock since we
+			 * are the only thread in this process
+			 */
+			utime = cputime_add(current->signal->utime, current->utime);
+			stime = cputime_add(current->signal->utime, current->stime);
+			cutime = current->signal->cutime;
+			cstime = current->signal->cstime;
+		} else {
+			/* Process with multiple threads */
+			struct task_struct *tsk = current;
+			struct task_struct *t;
+
+			read_lock(&tasklist_lock);
+			utime = tsk->signal->utime;
+			stime = tsk->signal->stime;
+			t = tsk;
+			do {
+				utime = cputime_add(utime, t->utime);
+				stime = cputime_add(stime, t->stime);
+				t = next_thread(t);
+			} while (t != tsk);
 
+			/*
+			 * While we have tasklist_lock read-locked, no dying thread
+			 * can be updating current->signal->[us]time.  Instead,
+			 * we got their counts included in the live thread loop.
+			 * However, another thread can come in right now and
+			 * do a wait call that updates current->signal->c[us]time.
+			 * To make sure we always see that pair updated atomically,
+			 * we take the siglock around fetching them.
+			 */
+			spin_lock_irq(&tsk->sighand->siglock);
+			cutime = tsk->signal->cutime;
+			cstime = tsk->signal->cstime;
+			spin_unlock_irq(&tsk->sighand->siglock);
+			read_unlock(&tasklist_lock);
+		}
 		tmp.tms_utime = cputime_to_clock_t(utime);
 		tmp.tms_stime = cputime_to_clock_t(stime);
 		tmp.tms_cutime = cputime_to_clock_t(cutime);
