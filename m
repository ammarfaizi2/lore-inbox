Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVIXNaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVIXNaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 09:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVIXNaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 09:30:17 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:59538 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750745AbVIXNaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 09:30:15 -0400
Message-ID: <433557BB.EE6E5FE5@tv-sign.ru>
Date: Sat, 24 Sep 2005 17:42:19 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix exit_itimers() vs posix_timer_event() AB-BA deadlock
References: <20050818060126.GA13152@elte.hu>
			 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
			 <43076138.C37ED380@tv-sign.ru>
			 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
			 <43085E97.4EC3908B@tv-sign.ru>
			 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
			 <1124661032.23647.698.camel@tglx.tec.linutronix.de>
			 <4309731E.ED621149@tv-sign.ru>
			 <1124698127.23647.716.camel@tglx.tec.linutronix.de>
			 <43099235.65BC4757@tv-sign.ru>
			 <1124705208.23647.737.camel@tglx.tec.linutronix.de>
			 <430A012E.1CAF0A2F@tv-sign.ru> <1124791998.23647.789.camel@tglx.tec.linutronix.de> <430B4C35.AE7CD179@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_0                                   CPU_1

release_task:                           posix_timer_fn:
    write_lock(tasklist);                   spin_lock(timer->it_lock);

    exit_timers:                            send_sigqueue:
        spin_lock(timer->it_lock)               read_lock(tasklist);

Actually, it is a bit worse. If posix timer starts between tasklist
locking and del_timer_sync() call this deadlock will happen because
of TIMER_RETRY logic.

With this patch posix_timer_event() detects the exiting thread group
and aborts the sending of signal (taking tasklist_lock). To simplify
the code tasklist locking moved from send_{,group_}sigqueue to the
posix_timer_event().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc2/kernel/posix-timers.c~1_DLOCK	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc2/kernel/posix-timers.c	2005-09-24 18:03:05.000000000 +0400
@@ -411,6 +411,10 @@ exit:
 
 int posix_timer_event(struct k_itimer *timr,int si_private)
 {
+	struct task_struct *leader, *zombie;
+	int (*send_actor)(int, struct sigqueue *, struct task_struct *);
+	int ret;
+
 	memset(&timr->sigq->info, 0, sizeof(siginfo_t));
 	timr->sigq->info.si_sys_private = si_private;
 	/*
@@ -428,22 +432,40 @@ int posix_timer_event(struct k_itimer *t
 	timr->sigq->info.si_tid = timr->it_id;
 	timr->sigq->info.si_value = timr->it_sigev_value;
 
-	if (timr->it_sigev_notify & SIGEV_THREAD_ID) {
-		struct task_struct *leader;
-		int ret = send_sigqueue(timr->it_sigev_signo, timr->sigq,
-					timr->it_process);
-
-		if (likely(ret >= 0))
-			return ret;
-
-		timr->it_sigev_notify = SIGEV_SIGNAL;
-		leader = timr->it_process->group_leader;
-		put_task_struct(timr->it_process);
-		timr->it_process = leader;
-	}
-
-	return send_group_sigqueue(timr->it_sigev_signo, timr->sigq,
-				   timr->it_process);
+	/*
+	 * We are locking ->it_lock + tasklist_lock backwards
+	 * from release_task()->exit_itimers(), beware deadlock.
+	 */
+	leader = timr->it_process->group_leader;
+	while (unlikely(!read_trylock(&tasklist_lock))) {
+		if (leader->flags & PF_EXITING) {
+			smp_rmb();
+			if (thread_group_empty(leader))
+				return 0;
+		}
+		cpu_relax();
+	}
+
+	zombie = NULL;
+	send_actor = send_group_sigqueue;
+	if (timr->it_sigev_notify & SIGEV_THREAD_ID) {
+		if (unlikely(timr->it_process->flags & PF_EXITING)) {
+			zombie = timr->it_process;
+			timr->it_process = leader;
+			timr->it_sigev_notify = SIGEV_SIGNAL;
+		} else
+			send_actor = send_sigqueue;
+	}
+
+	ret = send_actor(timr->it_sigev_signo, timr->sigq,
+			 timr->it_process);
+
+	read_unlock(&tasklist_lock);
+
+	if (unlikely(zombie != NULL))
+		put_task_struct(zombie);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(posix_timer_event);
 
--- 2.6.14-rc2/kernel/signal.c~1_DLOCK	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc2/kernel/signal.c	2005-09-24 18:01:11.000000000 +0400
@@ -1367,22 +1367,14 @@ send_sigqueue(int sig, struct sigqueue *
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
-
-	if (unlikely(p->flags & PF_EXITING)) {
-		ret = -1;
-		goto out_err;
-	}
-
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 
 	if (unlikely(!list_empty(&q->list))) {
+		BUG_ON(q->info.si_code != SI_TIMER);
 		/*
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		if (q->info.si_code != SI_TIMER)
-			BUG();
 		q->info.si_overrun++;
 		goto out;
 	}
@@ -1400,9 +1392,6 @@ send_sigqueue(int sig, struct sigqueue *
 
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
-out_err:
-	read_unlock(&tasklist_lock);
-
 	return ret;
 }
 
@@ -1413,7 +1402,6 @@ send_group_sigqueue(int sig, struct sigq
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
@@ -1424,13 +1412,12 @@ send_group_sigqueue(int sig, struct sigq
 	}
 
 	if (unlikely(!list_empty(&q->list))) {
+		BUG_ON(q->info.si_code != SI_TIMER);
 		/*
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.  Other uses should not try to
 		 * send the signal multiple times.
 		 */
-		if (q->info.si_code != SI_TIMER)
-			BUG();
 		q->info.si_overrun++;
 		goto out;
 	} 
@@ -1447,8 +1434,7 @@ send_group_sigqueue(int sig, struct sigq
 	__group_complete_signal(sig, p);
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
-	read_unlock(&tasklist_lock);
-	return(ret);
+	return ret;
 }
 
 /*
