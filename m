Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVHTRjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVHTRjh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVHTRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 13:39:37 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:65408 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932617AbVHTRjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 13:39:36 -0400
Message-ID: <43076D64.1C86C0C5@tv-sign.ru>
Date: Sat, 20 Aug 2005 21:50:28 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
References: <20050818060126.GA13152@elte.hu>
		 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
		 <430739D4.681DB651@tv-sign.ru> <1124553848.23647.635.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> 
> On Sat, 2005-08-20 at 18:10 +0400, Oleg Nesterov wrote:
> 
> > posix_timer_event() first checks that the thread (SIGEV_THREAD_ID
> > case) does not have PF_EXITING flag, then it calls send_sigqueue()
> > which locks task list. But if the thread exits in between the kernel
> > will oops.
> 
> > posix_timer_event() runs under k_itimer.it_lock, but this does not
> > help if that thread was not the only one in thread group, in this
> > case we don't call exit_itimers().
> 
> I added exit_notify_itimers() for that case. It is synchronized vs.
> posix_timer_event() via the timer lock and therefor protects against the
> race described above.
> 
> It solves the problem for the only user of send_sigqueue for now, but I
> think we should have a more general interface to such functionality to
> allow simple usage.
> 
> tglx
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/include/linux/sched.h linux-2.6.13-rc6.work/include/linux/sched.h
> --- linux-2.6.13-rc6/include/linux/sched.h      2005-08-13 12:25:56.000000000 +0200
> +++ linux-2.6.13-rc6.work/include/linux/sched.h 2005-08-20 17:43:36.000000000 +0200
> @@ -1051,6 +1051,7 @@ extern void __exit_signal(struct task_st
>  extern void exit_sighand(struct task_struct *);
>  extern void __exit_sighand(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
> +extern void exit_notify_itimers(struct signal_struct *);
> 
>  extern NORET_TYPE void do_group_exit(int);
> 
> diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6/kernel/posix-timers.c linux-2.6.13-rc6.work/kernel/posix-timers.c
> --- linux-2.6.13-rc6/kernel/posix-timers.c      2005-08-13 12:25:58.000000000 +0200
> +++ linux-2.6.13-rc6.work/kernel/posix-timers.c 2005-08-20 17:43:36.000000000 +0200
> @@ -1169,6 +1169,33 @@ void exit_itimers(struct signal_struct *
>  }
> 
>  /*
> + * This is called by __exit_signal, when there are still references to
> + * the shared signal_struct
> + */
> +void exit_notify_itimers(struct signal_struct *sig)
> +{
> +       struct k_itimer *timer;
> +       struct list_head *tmp;
> +       unsigned long flags;
> +
> +       list_for_each(tmp, &sig->posix_timers) {
> +
> +               timer = list_entry(tmp, struct k_itimer, list);
> +
> +               /* Protect against posix_timer_fn */
> +               spin_lock_irqsave(&timer->it_lock, flags);

I think this is deadlockable. We already (release_task) hold
tasklist_lock here. What if this timer has no SIGEV_THREAD_ID ?

posix_timer_fn locks timer->it_lock first, then locks tasklist_lock
in send_group_sigqueue().

Also, sys_timer_delete() locks ->it_lock, then ->sighand.lock.

I think the better fix would be re-check ->sighand in send_sigqueue,
like Paul's patches do.

Oleg.
