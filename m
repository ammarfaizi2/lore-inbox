Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271164AbTGPWOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271166AbTGPWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:14:07 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:41104
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271163AbTGPWNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:13:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wiktor Wodecki <wodecki@gmx.net>, Wiktor Wodecki <wodecki@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Date: Thu, 17 Jul 2003 08:30:57 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307170030.25934.kernel@kolivas.org> <20030716215947.GE670@gmx.de>
In-Reply-To: <20030716215947.GE670@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307170830.57706.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 07:59, Wiktor Wodecki wrote:
> Hello,
>
> I have been gone from the computer for a couple of hours, and now
> everything is very chopping. For example I'm transfering some huge data

Small bug I noticed after sleeping on the patch. I'll post a fix later today.

Con

> over nfs to another linux box (on sun, tho) where there is not enough
> space available. It happens that in the middle of the copying the
> process 'hangs'. I cannot interrupt it with ctrl-[cz], it takes a couple
> of seconds (~20). I cannot tell for sure that the problem is with the O6
> patch, since I haven't done it on an other kernel, yet.
>
> On Thu, Jul 17, 2003 at 12:30:25AM +1000, Con Kolivas wrote:
> > O*int patches trying to improve the interactivity of the 2.5/6 scheduler
> > for desktops. It appears possible to do this without moving to nanosecond
> > resolution.
> >
> > This one makes a massive difference... Please test this to death.
> >
> > Changes:
> > The big change is in the way sleep_avg is incremented. Any amount of
> > sleep will now raise you by at least one priority with each wakeup. This
> > causes massive differences to startup time, extremely rapid conversion to
> > interactive state, and recovery from non-interactive state rapidly as
> > well (prevents X stalling after thrashing around under high loads for
> > many seconds).
> >
> > The sleep buffer was dropped to just 10ms. This has the effect of causing
> > mild round robinning of very interactive tasks if they run for more than
> > 10ms. The requeuing was changed from (unlikely()) to an ordinary if..
> > branch as this will be hit much more now.
> >
> > MAX_BONUS as a #define was made easier to understand
> >
> > Idle tasks were made slightly less interactive to prevent cpu hogs from
> > becoming interactive on their very first wakeup.
> >
> > Con
> >
> > This patch-O6int-0307170012 applies on top of 2.6.0-test1-mm1 and can be
> > found here:
> > http://kernel.kolivas.org/2.5
> >
> > and here:
> >
> > --- linux-2.6.0-test1-mm1/kernel/sched.c	2003-07-16 20:27:32.000000000
> > +1000 +++ linux-2.6.0-testck1/kernel/sched.c	2003-07-17
> > 00:13:24.000000000 +1000 @@ -76,9 +76,9 @@
> >  #define MIN_SLEEP_AVG		(HZ)
> >  #define MAX_SLEEP_AVG		(10*HZ)
> >  #define STARVATION_LIMIT	(10*HZ)
> > -#define SLEEP_BUFFER		(HZ/20)
> > +#define SLEEP_BUFFER		(HZ/100)
> >  #define NODE_THRESHOLD		125
> > -#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO /
> > 100) +#define MAX_BONUS		(40 * PRIO_BONUS_RATIO / 100)
> >
> >  /*
> >   * If a task is 'interactive' then we reinsert it in the active
> > @@ -399,7 +399,7 @@ static inline void activate_task(task_t
> >  		 */
> >  		if (sleep_time > MIN_SLEEP_AVG){
> >  			p->avg_start = jiffies - MIN_SLEEP_AVG;
> > -			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
> > +			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 2) /
> >  				MAX_BONUS;
> >  		} else {
> >  			/*
> > @@ -413,14 +413,10 @@ static inline void activate_task(task_t
> >  			p->sleep_avg += sleep_time;
> >
> >  			/*
> > -			 * Give a bonus to tasks that wake early on to prevent
> > -			 * the problem of the denominator in the bonus equation
> > -			 * from continually getting larger.
> > +			 * Processes that sleep get pushed to a higher priority
> > +			 * each time they sleep
> >  			 */
> > -			if ((runtime - MIN_SLEEP_AVG) < MAX_SLEEP_AVG)
> > -				p->sleep_avg += (runtime - p->sleep_avg) *
> > -					(MAX_SLEEP_AVG + MIN_SLEEP_AVG - runtime) *
> > -					(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
> > +			p->sleep_avg = (p->sleep_avg * MAX_BONUS / runtime + 1) * runtime /
> > MAX_BONUS;
> >
> >  			/*
> >  			 * Keep a small buffer of SLEEP_BUFFER sleep_avg to
> > @@ -1311,7 +1307,7 @@ void scheduler_tick(int user_ticks, int
> >  			enqueue_task(p, rq->expired);
> >  		} else
> >  			enqueue_task(p, rq->active);
> > -	} else if (unlikely(p->prio < effective_prio(p))){
> > +	} else if (p->prio < effective_prio(p)){
> >  		/*
> >  		 * Tasks that have lowered their priority are put to the end
> >  		 * of the active array with their remaining timeslice
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

