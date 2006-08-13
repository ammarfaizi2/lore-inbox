Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWHMLbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWHMLbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 07:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWHMLbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 07:31:37 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:10734 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750845AbWHMLbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 07:31:36 -0400
Date: Sun, 13 Aug 2006 19:55:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtmutex-clean-up-and-remove-some-extra-spinlocks-more
Message-ID: <20060813155521.GA1311@oleg>
References: <1154439588.25445.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154439588.25445.31.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of Steven's rtmutex-clean-up-and-remove-some-extra-spinlocks.patch

There are still 2 get_task_struct()s under ->pi_lock. Imho, this is
confusing. Move them outside of ->pi_lock protected section. The task
can't go away, otherwise it was unsafe to take task->pi_lock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc3/kernel/rtmutex.c~	2006-08-13 18:49:28.000000000 +0400
+++ 2.6.18-rc3/kernel/rtmutex.c	2006-08-13 19:07:45.000000000 +0400
@@ -249,6 +249,7 @@ static int rt_mutex_adjust_prio_chain(st
 
 	/* Grab the next task */
 	task = rt_mutex_owner(lock);
+	get_task_struct(task);
 	spin_lock_irqsave(&task->pi_lock, flags);
 
 	if (waiter == rt_mutex_top_waiter(lock)) {
@@ -267,7 +268,6 @@ static int rt_mutex_adjust_prio_chain(st
 		__rt_mutex_adjust_prio(task);
 	}
 
-	get_task_struct(task);
 	spin_unlock_irqrestore(&task->pi_lock, flags);
 
 	top_waiter = rt_mutex_top_waiter(lock);
@@ -589,10 +589,10 @@ void rt_mutex_adjust_pi(struct task_stru
 		return;
 	}
 
-	/* gets dropped in rt_mutex_adjust_prio_chain()! */
-	get_task_struct(task);
 	spin_unlock_irqrestore(&task->pi_lock, flags);
 
+	/* gets dropped in rt_mutex_adjust_prio_chain()! */
+	get_task_struct(task);
 	rt_mutex_adjust_prio_chain(task, 0, NULL, NULL, task);
 }
 

