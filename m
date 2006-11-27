Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757054AbWK0Kun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbWK0Kun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 05:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757057AbWK0Kun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 05:50:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:12014 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1757041AbWK0Kum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 05:50:42 -0500
X-Authenticated: #14349625
Subject: [patch] Re: 2.6.19-rc6-mm1 --
	sched-improve-migration-accuracy.patch slows boot
From: Mike Galbraith <efault@gmx.de>
To: Don Mullis <dwm@meer.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1164591509.2894.76.camel@localhost.localdomain>
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <1164484124.2894.50.camel@localhost.localdomain>
	 <1164522263.5808.12.camel@Homer.simpson.net>
	 <1164591509.2894.76.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 11:50:11 +0100
Message-Id: <1164624611.5892.27.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-26 at 17:38 -0800, Don Mullis wrote: 
> > This must be a bisection false positive.  The patch in question is
> > essentially a no-op for a UP kernel.

Duh!  Except for the bug, which doesn't care either way.

> Testing alternately with 
> 	1) all -mm1 patches applied, and 
> 	2) all except sched-improve-migration-accuracy*.path applied,
> confirms the misbehavior.

While fixing a sched_time accounting buglet, I stupidly broke sleep_avg
accounting, and quite thoroughly for cpu hogs.  Since I updated a task's
timestamp at tick time, but sleep_avg adjustment only takes place at
schedule time, every tick a task took without scheduling resulted in a
tick of run time lost for sleep_avg accounting.  The below should fix
it, can you confirm?

Fix sleep_avg breakage induced by sched-improve-migration-accuracy.path
Use p->last_ran to fix sched_time buglet instead of p->timestamp.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.19-rc6-mm1/kernel/sched.c.org	2006-11-27 10:24:07.000000000 +0100
+++ linux-2.6.19-rc6-mm1/kernel/sched.c	2006-11-27 10:28:59.000000000 +0100
@@ -3024,8 +3024,8 @@ EXPORT_PER_CPU_SYMBOL(kstat);
 static inline void
 update_cpu_clock(struct task_struct *p, struct rq *rq, unsigned long long now)
 {
-	p->sched_time += now - p->timestamp;
-	p->timestamp = rq->most_recent_timestamp = now;
+	p->sched_time += now - p->last_ran;
+	p->last_ran = rq->most_recent_timestamp = now;
 }
 
 /*
@@ -3038,7 +3038,7 @@ unsigned long long current_sched_time(co
 	unsigned long flags;
 
 	local_irq_save(flags);
-	ns = p->sched_time + sched_clock() - p->timestamp;
+	ns = p->sched_time + sched_clock() - p->last_ran;
 	local_irq_restore(flags);
 
 	return ns;
@@ -3553,10 +3553,11 @@ switch_tasks:
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
 		prev->sleep_avg = 0;
+	prev->timestamp = prev->last_ran = now;
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
-		next->timestamp = prev->last_ran = now;
+		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;
 		++*switch_count;


