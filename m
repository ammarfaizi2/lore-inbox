Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVHTQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVHTQrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 12:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVHTQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 12:47:36 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:46820 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932522AbVHTQrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 12:47:36 -0400
Message-ID: <43076138.C37ED380@tv-sign.ru>
Date: Sat, 20 Aug 2005 20:58:32 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix send_sigqueue() vs thread exit race
References: <20050818060126.GA13152@elte.hu> <1124495303.23647.579.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix send_sigqueue() vs thread exit race

posix_timer_event() first checks that the thread (SIGEV_THREAD_ID
case) does not have PF_EXITING flag, then it calls send_sigqueue()
which locks task list. But if the thread exits in between the kernel
will oops (->sighand == NULL after __exit_sighand).

This patch moves the PF_EXITING check into the send_sigqueue(), it
must be done atomically under tasklist_lock. When send_sigqueue()
detects exiting thread it returns -1. In that case posix_timer_event
will send the signal to thread group.

Also, this patch fixes task_struct use-after-free in posix_timer_event.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.13-rc6/kernel/signal.c~	2005-08-18 23:10:28.000000000 +0400
+++ 2.6.13-rc6/kernel/signal.c	2005-08-20 23:05:21.000000000 +0400
@@ -1366,16 +1366,16 @@ send_sigqueue(int sig, struct sigqueue *
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
+	read_lock(&tasklist_lock);
+
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
@@ -1385,7 +1385,7 @@ send_sigqueue(int sig, struct sigqueue *
 			BUG();
 		q->info.si_overrun++;
 		goto out;
-	} 
+	}
 	/* Short-circuit ignored signals.  */
 	if (sig_ignored(p, sig)) {
 		ret = 1;
@@ -1400,8 +1400,10 @@ send_sigqueue(int sig, struct sigqueue *
 
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+out_err:
 	read_unlock(&tasklist_lock);
-	return(ret);
+
+	return ret;
 }
 
 int
--- 2.6.13-rc6/kernel/posix-timers.c~	2005-08-18 21:37:08.000000000 +0400
+++ 2.6.13-rc6/kernel/posix-timers.c	2005-08-20 23:21:23.000000000 +0400
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
