Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVHWQG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVHWQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVHWQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:06:56 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:52445 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932125AbVHWQGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:06:55 -0400
Message-ID: <430B4C35.AE7CD179@tv-sign.ru>
Date: Tue, 23 Aug 2005 20:17:57 +0400
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
		 <43099235.65BC4757@tv-sign.ru>
		 <1124705208.23647.737.camel@tglx.tec.linutronix.de>
		 <430A012E.1CAF0A2F@tv-sign.ru> <1124791998.23647.789.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
>
> On Mon, 2005-08-22 at 20:45 +0400, Oleg Nesterov wrote:
> >
> > kernel/posix-timers.c:common_timer_del() calls del_timer_sync(), after
> > that nobody can access this timer, so we don't need to lock timer->it_lock
> > at all in this case. No lock - no deadlock.
>
> It still deadlocks:
>
> CPU 0                           CPU 1
> write_lock(&tasklist_lock);
> __exit_signal()
>                                 timer expires
>                                 base->running_timer = timer
>                                   send_group_sigqueue()
>                                    read_lock(&tasklist_lock();
> exit_itimers()
>   del_timer_sync(timer)
>      waits for ever because           waits for ever on tasklist_lock
>      base->running_timer == timer

Silly me.

> I still think the last patch I sent is still necessary.

Thomas, you know that I like this change in __exit_{signal,sighand},
but i think this change is dangerous, should go in a separate patch,
and needs a lot of testing. But the decision is up to Ingo and Roland.

I am looking at your previous patch:

> -       read_lock(&tasklist_lock);
> +retry:
> +       if (unlikely(p->flags & PF_EXITING))
> +               return -1;
> +
> +       if (unlikely(!read_trylock(&tasklist_lock))) {
> +               cpu_relax();
> +               goto retry;
> +       }
> +       if (unlikely(p->flags & PF_EXITING)) {
> +               ret = -1;
> +               goto out_err;

What do you think about this:

int try_to_lock_this_beep_tasklist_lock(struct task_struct *group_leader)
{
	while (unlikely(!read_trylock(&tasklist_lock))) {
		if (group_leader->flags & PF_EXITING) {
			smp_rmb();
			if (thread_group_empty(group_leader))
				return 0;
		}
		cpu_relax();
	}

	return 1;
}

No need to re-check after we got tasklist, the signal will be flushed.
I think it's better to move the locking into the posix_timer_event, btw.
In that case we can drop my patch.

What is your opinion, can it work?

P.S.
     Thomas, thanks for explanation about posix-cpu-timers.

Oleg.
