Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVHVUoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVHVUoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVHVUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:44:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41959 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751110AbVHVUog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:44:36 -0400
Message-ID: <430A012E.1CAF0A2F@tv-sign.ru>
Date: Mon, 22 Aug 2005 20:45:34 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
References: <20050818060126.GA13152@elte.hu>
		 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
		 <43076138.C37ED380@tv-sign.ru>
		 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
		 <43085E97.4EC3908B@tv-sign.ru>
		 <1124659468.23647.695.camel@tglx.tec.linutronix.de>
		 <1124661032.23647.698.camel@tglx.tec.linutronix.de>
		 <4309731E.ED621149@tv-sign.ru>
		 <1124698127.23647.716.camel@tglx.tec.linutronix.de>
		 <43099235.65BC4757@tv-sign.ru> <1124705208.23647.737.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
>
> It exists. It triggers on preempt-RT and I can trigger it on vanilla SMP
> by waiting for the timer expiry in release_task() before the
> __exit_signal() call. That's reasonable, as it can happen that way by
> chance too. It requires that the timer expires on a different CPU, but I
> don't see a reason why this should not happen.

Ok, exit_itimers()->itimer_delete() called when the last thread exits
or does exec.

kernel/posix-timers.c:common_timer_del() calls del_timer_sync(), after
that nobody can access this timer, so we don't need to lock timer->it_lock
at all in this case. No lock - no deadlock.

But I know nothing about kernel/posix-cpu-timers.c, I doubt it will work
for posix_cpu_timer_del(). I don't have time to study posix-cpu-timers now.
However, I see that __exit_signal() calls posix_cpu_timers_exit_xxx(), so
may be it can work?

   380  int posix_cpu_timer_del(struct k_itimer *timer)
   381  {
   382          struct task_struct *p = timer->it.cpu.task;
   383
   384          if (timer->it.cpu.firing)
   385                  return TIMER_RETRY;
   386
   387          if (unlikely(p == NULL))
   388                  return 0;
   389
   390          if (!list_empty(&timer->it.cpu.entry)) {
   391                  read_lock(&tasklist_lock);

Surely, it should be impossible to happen when process exists, otherwise
it would deadlock immediately, we did write_lock(tasklist).

Thomas, do you know something about posix-cpu-timers.c?

Oleg.
