Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVHUVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVHUVtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVHUVtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:49:50 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:59347
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751155AbVHUVtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:49:49 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1124659468.23647.695.camel@tglx.tec.linutronix.de>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
	 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
	 <43085E97.4EC3908B@tv-sign.ru>
	 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 21 Aug 2005 23:50:32 +0200
Message-Id: <1124661032.23647.698.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-21 at 23:24 +0200, Thomas Gleixner wrote:
> Oleg,

Sorry for making noise. I introduced the race again.

tglx


--- linux-2.6.13-rc6.signal/kernel/signal.oleg.c	2005-08-21 23:07:03.000000000 +0200
+++ linux-2.6.13-rc6.signal/kernel/signal.c	2005-08-21 23:48:52.000000000 +0200
@@ -1381,8 +1381,15 @@ send_sigqueue(int sig, struct sigqueue *
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
 	if (unlikely(p->flags & PF_EXITING)) {
 		ret = -1;
 		goto out_err;
@@ -1427,7 +1434,18 @@ send_group_sigqueue(int sig, struct sigq
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
+	if (unlikely(p->flags & PF_EXITING)) {
+		ret = -1;
+		goto out_err;
+	}
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
@@ -1461,8 +1479,9 @@ send_group_sigqueue(int sig, struct sigq
 	__group_complete_signal(sig, p);
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+out_err:
 	read_unlock(&tasklist_lock);
-	return(ret);
+	return ret;
 }
 
 /*
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


