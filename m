Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVHUVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVHUVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVHUVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:24:09 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:46291
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751101AbVHUVYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:24:08 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43085E97.4EC3908B@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
	 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
	 <43085E97.4EC3908B@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 21 Aug 2005 23:24:28 +0200
Message-Id: <1124659468.23647.695.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg,

On Sun, 2005-08-21 at 14:59 +0400, Oleg Nesterov wrote:
> CPU_0					CPU_1
> 
> release_task:				posix_timer_fn:
> 	write_lock(tasklist);			lock(timer->it_lock);
> 
> 	exit_timers:				send_sigxxx();
> 		lock(timer->it_lock)			read_lock(tasklist);
> 				
> Deadlock.
> 
> Dear cc-list, what do you think?

The patch below on top of your patch should solve this. We don't need
tasklist_lock to check p->flags. As you pointed out p cannot be invalid
in send_sigqueue as it's protected by get_task_struct() in
create_timer()

For send_group_sigqueue it's protected by exit_itimers() waiting for
k_itimer.it_lock.

It still does not solve the ugly dependency on tasklist_lock but at
least the race and the deadlock are fixed.

tglx

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


--- linux-2.6.13-rc6.signal/kernel/signal.oleg.c	2005-08-21 23:07:03.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/signal.c	2005-08-21 23:09:07.000000000 +0200
@@ -1381,11 +1381,14 @@ send_sigqueue(int sig, struct sigqueue *
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
 
-	if (unlikely(p->flags & PF_EXITING)) {
-		ret = -1;
-		goto out_err;
+retry:
+	if (unlikely(p->flags & PF_EXITING))
+		return -1;
+
+	if ((unlikely(!read_trylock(&tasklist_lock))) {
+		cpu_relax();
+		goto retry;
 	}
 
 	spin_lock_irqsave(&p->sighand->siglock, flags);
@@ -1414,7 +1417,6 @@ send_sigqueue(int sig, struct sigqueue *
 
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
-out_err:
 	read_unlock(&tasklist_lock);
 
 	return ret;
@@ -1427,7 +1429,14 @@ send_group_sigqueue(int sig, struct sigq
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
-	read_lock(&tasklist_lock);
+retry:
+	if (unlikely(p->flags & PF_EXITING))
+		return -1;
+
+	if (unlikely(!read_trylock(&tasklist_lock))) {
+		cpu_relax();
+		goto retry;
+	}
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
--- linux-2.6.13-rc6.signal/kernel/posix-timers.oleg.c	2005-08-21 23:09:58.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/posix-timers.c	2005-08-21 23:19:42.000000000 +0200
@@ -501,7 +501,8 @@ static void posix_timer_fn(unsigned long
 			remove_from_abslist(timr);
 		}
 
-		if (posix_timer_event(timr, si_private))
+		/* Do not rearm the timer, when we are exiting */
+		if (posix_timer_event(timr, si_private) > 0)
 			/*
 			 * signal was not sent because of sig_ignor
 			 * we will not get a call back to restart it AND


