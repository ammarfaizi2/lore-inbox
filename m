Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVHVWVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVHVWVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVHVWU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:20:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:14728 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751370AbVHVWUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:20:24 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43099235.65BC4757@tv-sign.ru>
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
Content-Type: text/plain
Organization: linutronix
Date: Mon, 22 Aug 2005 12:06:48 +0200
Message-Id: <1124705208.23647.737.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg,

On Mon, 2005-08-22 at 12:52 +0400, Oleg Nesterov wrote:
> Thomas Gleixner wrote:
> I think yes, and this is closely related to your and Paul
> "Use RCU to protect tasklist for unicast signals" patches.
> 
> We don't need RCU here, but we do need this hypothetical
> lock_task_sighand() (and __exit_sighand from __exit_signal
> change).
> 
> We still need tasklist_lock in send_group_queue for
> __group_complete_signal though. I hope Paul will solve
> this, it is needed for group_send_info() anyway.
> 
> But for the near future I don't see simple and non-intrusive
> fix for this deadlock. I am waiting for George to confirm
> that the bug exists and we are not crazy :)

It exists. It triggers on preempt-RT and I can trigger it on vanilla SMP
by waiting for the timer expiry in release_task() before the
__exit_signal() call. That's reasonable, as it can happen that way by
chance too. It requires that the timer expires on a different CPU, but I
don't see a reason why this should not happen.

The patch below solves it for me. 

tglx

diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/exit.c linux-2.6.13-rc6.signal/kernel/exit.c
--- linux-2.6.13-rc6/kernel/exit.c	2005-08-13 12:25:58.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/exit.c	2005-08-22 11:19:02.000000000 +0200
@@ -71,7 +71,6 @@ repeat: 
 		__ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
-	__exit_sighand(p);
 	/*
 	 * Note that the fastpath in sys_times depends on __exit_signal having
 	 * updated the counters before a task is removed from the tasklist of
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/fork.c linux-2.6.13-rc6.signal/kernel/fork.c
--- linux-2.6.13-rc6/kernel/fork.c	2005-08-13 12:25:58.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/fork.c	2005-08-22 11:35:05.000000000 +0200
@@ -1132,7 +1132,8 @@ bad_fork_cleanup_mm:
 bad_fork_cleanup_signal:
 	exit_signal(p);
 bad_fork_cleanup_sighand:
-	exit_sighand(p);
+	if (p->sighand)
+		exit_sighand(p);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/posix-timers.c linux-2.6.13-rc6.signal/kernel/posix-timers.c
--- linux-2.6.13-rc6/kernel/posix-timers.c	2005-08-13 12:25:58.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/posix-timers.c	2005-08-21 23:19:42.000000000 +0200
@@ -427,21 +427,23 @@ int posix_timer_event(struct k_itimer *t
 	timr->sigq->info.si_code = SI_TIMER;
 	timr->sigq->info.si_tid = timr->it_id;
 	timr->sigq->info.si_value = timr->it_sigev_value;
+
 	if (timr->it_sigev_notify & SIGEV_THREAD_ID) {
-		if (unlikely(timr->it_process->flags & PF_EXITING)) {
-			timr->it_sigev_notify = SIGEV_SIGNAL;
-			put_task_struct(timr->it_process);
-			timr->it_process = timr->it_process->group_leader;
-			goto group;
-		}
-		return send_sigqueue(timr->it_sigev_signo, timr->sigq,
-			timr->it_process);
-	}
-	else {
-	group:
-		return send_group_sigqueue(timr->it_sigev_signo, timr->sigq,
-			timr->it_process);
+		struct task_struct *leader;
+		int ret = send_sigqueue(timr->it_sigev_signo, timr->sigq,
+					timr->it_process);
+
+		if (likely(ret >= 0))
+			return ret;
+
+		timr->it_sigev_notify = SIGEV_SIGNAL;
+		leader = timr->it_process->group_leader;
+		put_task_struct(timr->it_process);
+		timr->it_process = leader;
 	}
+
+	return send_group_sigqueue(timr->it_sigev_signo, timr->sigq,
+				   timr->it_process);
 }
 EXPORT_SYMBOL_GPL(posix_timer_event);
 
@@ -499,7 +501,8 @@ static void posix_timer_fn(unsigned long
 			remove_from_abslist(timr);
 		}
 
-		if (posix_timer_event(timr, si_private))
+		/* Do not rearm the timer, when we are exiting */
+		if (posix_timer_event(timr, si_private) > 0)
 			/*
 			 * signal was not sent because of sig_ignor
 			 * we will not get a call back to restart it AND
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/signal.c linux-2.6.13-rc6.signal/kernel/signal.c
--- linux-2.6.13-rc6/kernel/signal.c	2005-08-13 12:25:58.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/signal.c	2005-08-22 11:51:08.000000000 +0200
@@ -395,6 +395,7 @@ void __exit_signal(struct task_struct *t
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
+	__exit_sighand(tsk);
 	if (sig) {
 		/*
 		 * We are cleaning up the signal_struct here.  We delayed
@@ -1380,16 +1381,20 @@ send_sigqueue(int sig, struct sigqueue *
 	unsigned long flags;
 	int ret = 0;
 
-	/*
-	 * We need the tasklist lock even for the specific
-	 * thread case (when we don't need to follow the group
-	 * lists) in order to avoid races with "p->sighand"
-	 * going away or changing from under us.
-	 */
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);  
+
+	while(!read_trylock(&tasklist_lock)) {
+		if (p->flags & PF_EXITING)
+			return -1;
+		cpu_relax();
+	}
+	if (unlikely(p->flags & PF_EXITING)) {
+		ret = -1;
+		goto out_err;
+	}
+
 	spin_lock_irqsave(&p->sighand->siglock, flags);
-	
+
 	if (unlikely(!list_empty(&q->list))) {
 		/*
 		 * If an SI_TIMER entry is already queue just increment
@@ -1399,7 +1404,7 @@ send_sigqueue(int sig, struct sigqueue *
 			BUG();
 		q->info.si_overrun++;
 		goto out;
-	} 
+	}
 	/* Short-circuit ignored signals.  */
 	if (sig_ignored(p, sig)) {
 		ret = 1;
@@ -1414,8 +1419,10 @@ send_sigqueue(int sig, struct sigqueue *
 
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+out_err:
 	read_unlock(&tasklist_lock);
-	return(ret);
+
+	return ret;
 }
 
 int
@@ -1425,7 +1432,16 @@ send_group_sigqueue(int sig, struct sigq
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
+
+	while(!read_trylock(&tasklist_lock)) {
+		if (!p->sighand)
+			return -1;
+		cpu_relax();
+	}
+	if (unlikely(!p->sighand)) {
+		ret = -1;
+		goto out_err;
+	}
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
@@ -1459,8 +1475,9 @@ send_group_sigqueue(int sig, struct sigq
 	__group_complete_signal(sig, p);
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+out_err:
 	read_unlock(&tasklist_lock);
-	return(ret);
+	return ret;
 }
 
 /*


