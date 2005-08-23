Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVHWKNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVHWKNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 06:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVHWKNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 06:13:10 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37599
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751309AbVHWKNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 06:13:09 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <430A012E.1CAF0A2F@tv-sign.ru>
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
	 <430A012E.1CAF0A2F@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 23 Aug 2005 12:13:18 +0200
Message-Id: <1124791998.23647.789.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 20:45 +0400, Oleg Nesterov wrote:
> Thomas Gleixner wrote:
> Ok, exit_itimers()->itimer_delete() called when the last thread exits
> or does exec.
> 
> kernel/posix-timers.c:common_timer_del() calls del_timer_sync(), after
> that nobody can access this timer, so we don't need to lock timer->it_lock
> at all in this case. No lock - no deadlock.

It still deadlocks:

CPU 0                           CPU 1
write_lock(&tasklist_lock);     
__exit_signal()
                                timer expires
                                base->running_timer = timer
                                  send_group_sigqueue()
                                   read_lock(&tasklist_lock();
exit_itimers()
  del_timer_sync(timer)
     waits for ever because           waits for ever on tasklist_lock
     base->running_timer == timer


I still think the last patch I sent is still necessary.

> But I know nothing about kernel/posix-cpu-timers.c, I doubt it will work
> for posix_cpu_timer_del(). I don't have time to study posix-cpu-timers now.
> However, I see that __exit_signal() calls posix_cpu_timers_exit_xxx(), so
> may be it can work?
> 
>    380  int posix_cpu_timer_del(struct k_itimer *timer)
>    381  {
>    382          struct task_struct *p = timer->it.cpu.task;
>    383
>    384          if (timer->it.cpu.firing)
>    385                  return TIMER_RETRY;
>    386
>    387          if (unlikely(p == NULL))
>    388                  return 0;
>    389
>    390          if (!list_empty(&timer->it.cpu.entry)) {
>    391                  read_lock(&tasklist_lock);
> 
> Surely, it should be impossible to happen when process exists, otherwise
> it would deadlock immediately, we did write_lock(tasklist).
> 
> Thomas, do you know something about posix-cpu-timers.c?

Not much. I look into this 

tglx


