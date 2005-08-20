Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVHTQEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVHTQEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 12:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVHTQEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 12:04:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49613
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932535AbVHTQED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 12:04:03 -0400
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <430739D4.681DB651@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <430739D4.681DB651@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 20 Aug 2005 18:04:08 +0200
Message-Id: <1124553848.23647.635.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 18:10 +0400, Oleg Nesterov wrote:

> posix_timer_event() first checks that the thread (SIGEV_THREAD_ID
> case) does not have PF_EXITING flag, then it calls send_sigqueue()
> which locks task list. But if the thread exits in between the kernel
> will oops.

> posix_timer_event() runs under k_itimer.it_lock, but this does not
> help if that thread was not the only one in thread group, in this
> case we don't call exit_itimers().

I added exit_notify_itimers() for that case. It is synchronized vs.
posix_timer_event() via the timer lock and therefor protects against the
race described above.

It solves the problem for the only user of send_sigqueue for now, but I
think we should have a more general interface to such functionality to
allow simple usage.

tglx

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/include/linux/sched.h linux-2.6.13-rc6.work/include/linux/sched.h
--- linux-2.6.13-rc6/include/linux/sched.h	2005-08-13 12:25:56.000000000 +0200
+++ linux-2.6.13-rc6.work/include/linux/sched.h	2005-08-20 17:43:36.000000000 +0200
@@ -1051,6 +1051,7 @@ extern void __exit_signal(struct task_st
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
+extern void exit_notify_itimers(struct signal_struct *);
 
 extern NORET_TYPE void do_group_exit(int);
 
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/posix-timers.c linux-2.6.13-rc6.work/kernel/posix-timers.c
--- linux-2.6.13-rc6/kernel/posix-timers.c	2005-08-13 12:25:58.000000000 +0200
+++ linux-2.6.13-rc6.work/kernel/posix-timers.c	2005-08-20 17:43:36.000000000 +0200
@@ -1169,6 +1169,33 @@ void exit_itimers(struct signal_struct *
 }
 
 /*
+ * This is called by __exit_signal, when there are still references to
+ * the shared signal_struct
+ */
+void exit_notify_itimers(struct signal_struct *sig)
+{
+	struct k_itimer *timer;
+	struct list_head *tmp;
+	unsigned long flags;
+
+	list_for_each(tmp, &sig->posix_timers) {
+
+		timer = list_entry(tmp, struct k_itimer, list);
+
+		/* Protect against posix_timer_fn */
+		spin_lock_irqsave(&timer->it_lock, flags);
+		if (timer->it_process == current) {
+			
+			if (timer->it_sigev_notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
+				timer->it_sigev_notify = SIGEV_SIGNAL;
+			
+			timer->it_process = timer->it_process->group_leader;
+		} 
+		spin_lock_irqrestore(&timer->it_lock, flags);
+	}
+}
+
+/*
  * And now for the "clock" calls
  *
  * These functions are called both from timer functions (with the timer
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/signal.c linux-2.6.13-rc6.work/kernel/signal.c
--- linux-2.6.13-rc6/kernel/signal.c	2005-08-13 12:25:58.000000000 +0200
+++ linux-2.6.13-rc6.work/kernel/signal.c	2005-08-20 17:57:46.000000000 +0200
@@ -390,6 +390,7 @@ void __exit_signal(struct task_struct *t
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
 		sig->sched_time += tsk->sched_time;
+		exit_notify_itimers(sig);
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
@@ -1381,13 +1382,12 @@ send_sigqueue(int sig, struct sigqueue *
 	int ret = 0;
 
 	/*
-	 * We need the tasklist lock even for the specific
-	 * thread case (when we don't need to follow the group
-	 * lists) in order to avoid races with "p->sighand"
-	 * going away or changing from under us.
+	 * No need to hold tasklist lock here. 
+	 * posix_timer_event() is synchronized via 
+	 * exit_itimers() and exit_notify_itimers() to 
+	 * be protected against p->sighand == NULL
 	 */
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);  
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	
 	if (unlikely(!list_empty(&q->list))) {
@@ -1414,7 +1414,6 @@ send_sigqueue(int sig, struct sigqueue *
 
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
-	read_unlock(&tasklist_lock);
 	return(ret);
 }
 


