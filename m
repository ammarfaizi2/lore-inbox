Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWHMMj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWHMMj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHMMj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:39:56 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:54146 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751024AbWHMMj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:39:56 -0400
Date: Sun, 13 Aug 2006 21:03:40 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] do_sched_setscheduler: don't take tasklist_lock
Message-ID: <20060813170340.GA1913@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to take tasklist_lock or disable irqs for
find_task_by_pid() + get_task_struct(). Use RCU locks
instead.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc3/kernel/sched.c~1_dss	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc3/kernel/sched.c	2006-08-13 20:19:02.000000000 +0400
@@ -4156,14 +4156,15 @@ do_sched_setscheduler(pid_t pid, int pol
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
-	read_lock_irq(&tasklist_lock);
+
+	rcu_read_lock();
 	p = find_process_by_pid(pid);
-	if (!p) {
-		read_unlock_irq(&tasklist_lock);
+	if (p)
+		get_task_struct(p);
+	rcu_read_unlock();
+	if (!p)
 		return -ESRCH;
-	}
-	get_task_struct(p);
-	read_unlock_irq(&tasklist_lock);
+
 	retval = sched_setscheduler(p, policy, &lparam);
 	put_task_struct(p);
 

