Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161680AbWKETfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161680AbWKETfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161681AbWKETfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 14:35:20 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:61602 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1161680AbWKETfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 14:35:18 -0500
Date: Sun, 5 Nov 2006 22:34:57 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
Message-ID: <20061105193457.GA3082@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When task->array != NULL, try_to_wake_up() just goes to "out_running" and sets
task->state = TASK_RUNNING.

In that case hrtimer_wakeup() does:

	timeout->task = NULL;		<----- [1]

	spin_lock(runqueues->lock);

	task->state = TASK_RUNNING;	<----- [2]

from Documentation/memory-barriers.txt

	Memory operations that occur before a LOCK operation may appear to
	happen after it completes.

This means that [2] may be completed before [1], and

CPU_0							CPU_1
rt_mutex_slowlock:

for (;;) {
	...
		if (timeout && !timeout->task)
			return -ETIMEDOUT;
	...

	schedule();
							hrtimer_wakeup() sets
	...						task->state = TASK_RUNNING,
							but "timeout->task = NULL"
							is not completed
	set_current_state(TASK_INTERRUPTIBLE);
}

we can miss a timeout.

Of course, this all is scholasticism, this can't happen in practice, but
may be this patch makes sense as a documentation update.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/hrtimer.c~1_hrtw	2006-10-22 18:24:03.000000000 +0400
+++ STATS/kernel/hrtimer.c	2006-11-05 22:32:36.000000000 +0300
@@ -662,9 +662,12 @@ static int hrtimer_wakeup(struct hrtimer
 		container_of(timer, struct hrtimer_sleeper, timer);
 	struct task_struct *task = t->task;
 
-	t->task = NULL;
-	if (task)
+	if (task) {
+		t->task = NULL;
+		/* must be visible before task->state = TASK_RUNNING */
+		smp_wmb();
 		wake_up_process(task);
+	}
 
 	return HRTIMER_NORESTART;
 }

