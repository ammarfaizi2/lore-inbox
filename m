Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWFOMME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWFOMME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWFOMMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:12:03 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:47320 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030289AbWFOMMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:12:00 -0400
Date: Thu, 15 Jun 2006 20:12:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm_timer: remove a racy and obsolete PF_EXITING check
Message-ID: <20060615161202.GA21463@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm_timer() checks PF_EXITING to prevent BUG_ON(->exit_state)
in run_posix_cpu_timers().

However, for some reason it does so only for CPUCLOCK_PERTHREAD
case (which is imho wrong).

Also, this check is not reliable, PF_EXITING could be set on
another cpu without any locks/barriers just after the check,
so it can't prevent from attaching the timer to the exiting
task.

The previous patch makes this check unneeded.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc6/kernel/posix-cpu-timers.c~3_ARM	2006-06-15 18:46:00.000000000 +0400
+++ 2.6.17-rc6/kernel/posix-cpu-timers.c	2006-06-15 19:04:54.000000000 +0400
@@ -555,9 +555,6 @@ static void arm_timer(struct k_itimer *t
 	struct cpu_timer_list *next;
 	unsigned long i;
 
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)	&& (p->flags & PF_EXITING))
-		return;
-
 	head = (CPUCLOCK_PERTHREAD(timer->it_clock) ?
 		p->cpu_timers : p->signal->cpu_timers);
 	head += CPUCLOCK_WHICH(timer->it_clock);

