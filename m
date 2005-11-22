Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVKVSGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVKVSGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVKVSGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:06:17 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:60044 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965066AbVKVSGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:06:16 -0500
Message-ID: <43836F85.CF6D9CA3@tv-sign.ru>
Date: Tue, 22 Nov 2005 22:20:37 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: george@mvista.com, paulmck@us.ibm.com, Roland McGrath <roland@redhat.com>,
       akpm@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH] fix do_wait() vs exec() race
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru> <437BC01D.60302@mvista.com> <43826FDC.8010401@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When non-leader thread does exec, de_thread adds old leader to the
init's ->children list in EXIT_ZOMBIE state and drops tasklist_lock.

This means that release_task(leader) in de_thread() is racy vs do_wait()
from init task.

I think de_thread() should set old leader's state to EXIT_DEAD instead.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/fs/exec.c~	2005-11-22 19:35:31.000000000 +0300
+++ 2.6.15-rc2/fs/exec.c	2005-11-23 00:49:23.000000000 +0300
@@ -668,7 +668,7 @@ static inline int de_thread(struct task_
 	if (!thread_group_leader(current)) {
 		struct task_struct *parent;
 		struct dentry *proc_dentry1, *proc_dentry2;
-		unsigned long exit_state, ptrace;
+		unsigned long ptrace;
 
 		/*
 		 * Wait for the thread group leader to be a zombie.
@@ -726,15 +726,15 @@ static inline int de_thread(struct task_
 		list_del(&current->tasks);
 		list_add_tail(&current->tasks, &init_task.tasks);
 		current->exit_signal = SIGCHLD;
-		exit_state = leader->exit_state;
+
+		BUG_ON(leader->exit_state != EXIT_ZOMBIE);
+		leader->exit_state = EXIT_DEAD;
 
 		write_unlock_irq(&tasklist_lock);
 		spin_unlock(&leader->proc_lock);
 		spin_unlock(&current->proc_lock);
 		proc_pid_flush(proc_dentry1);
 		proc_pid_flush(proc_dentry2);
-
-		BUG_ON(exit_state != EXIT_ZOMBIE);
         }
 
 	/*
