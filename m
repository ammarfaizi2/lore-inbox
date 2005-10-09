Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVJIQok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVJIQok (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVJIQok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:44:40 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:64380 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932077AbVJIQoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:44:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aSjlFmwtix8+5rECdrofyrG/a0l3sh63UZziXn9uPmNCv5DuoaCGxthvS+VSF9HFMaRRPXFOl1J+Qji0nQRskQUsx4JmMX1eGJljS3YK5M6PStNsbNasdpbOPJYS6jUPfPRa9SjsNlzeOTGDDZkD4/nSvIVnxAH6w6CpXKtr/y4=
Message-ID: <69304d110510090944n72d09568h5549c4b2cad23060@mail.gmail.com>
Date: Sun, 9 Oct 2005 18:44:34 +0200
From: Antonio Vargas <windenntw@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Question] Some question about Ingo scheduler.
Cc: liyu <liyu@ccoss.com.cn>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0510090955160.19961@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <434732DA.20701@ccoss.com.cn>
	 <Pine.LNX.4.58.0510090955160.19961@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 8 Oct 2005, liyu wrote:
>
> > Hi, Everyone on lkml
>
> Hi Liyu,
>
> >
> >     I am read linux scheduler at home in last vacation.
> >
> >     After read , I have some question that want to consult:
> >
> >     1.
> >
> >     In schedule() function, we can find some code like this:
> >
> >
> >         if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
> >                 switch_count = &prev->nvcsw;
> >                 if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
> >                                 unlikely(signal_pending(prev))))
> >                         prev->state = TASK_RUNNING;
> >                 else {
> >                         if (prev->state == TASK_UNINTERRUPTIBLE)
> >                                 rq->nr_uninterruptible++;
> >                         deactivate_task(prev, rq);
> >                 }
> >         }
> >
> >     I think I can understand code in two braces: they want to change
> > status of task which have signal pending when sleep, or remove task
> > that is 'deep sleeping' from ready queue.
> >     but my question is why we do not need such code (in both braces)
> > when preempt is enable?
>
> I'm sorry I don't quite understand your question, but I can at least
> explain the logic of what is happening.
>
> The first "if" is entered if the prev task is in something other than the
> TASK_RUNNING state (which is zero).  It also has to not have the
> PREEMPT_ACTIVE set.  The next "if" checks to see if the prev task is in
> the TASK_INTERRUPTIBLE state and has a signal pending. Which the
> TASK_INTERRUPTIBLE state allows to be woken up on signals.
>
> If there is no signal or the task is sleeping other than
> TASK_INTERRUPTIBLE then the task is taken off the run queue.
>
> Now the reason for the check against PREEMPT_ACTIVE is very important
> here.  If PREEMPT_ACTIVE is set, then that means that the task was
> preempted by something else and did _not_ call schedule directly. Code
> that usually sets current to something other than TASK_RUNNING usually has
> logic around it to test if it should call schedule and be taken off the
> run queue.  If PREEMPT_ACTIVE is set, then that means you don't know where
> in this logic the task was preempted. If you take it off the run queue
> now, it may not have been in a position to ever wake up. So you don't
> ever want a preemption to take a task off the run queue. Only when the
> task implicitly calls schedule.
>
> >
> >
> >     2. in scheduler_tick()
> >
> >     Before split time slice, we should be check some conditions first, these
> > check code is copied here:
> >
> >                 /*
> >                  * Prevent a too long timeslice allowing a task to
> > monopolize
> >                  * the CPU. We do this by splitting up the timeslice into
> >                  * smaller pieces.
> >                  *
> >                  * Note: this does not mean the task's timeslices expire or
> >                  * get lost in any way, they just might be preempted by
> >                  * another task of equal priority. (one with higher
> >                  * priority would have preempted this task already.) We
> >                  * requeue this task to the end of the list on this priority
> >                  * level, which is in essence a round-robin of tasks with
> >                  * equal priority.
> >                  *
> >                  * This only applies to tasks in the interactive
> >                  * delta range with at least TIMESLICE_GRANULARITY to
> > requeue.
> >                  */
> >                 if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
> >                         p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
> >                         (p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
> >                         (p->array == rq->active)) {
> >
> >
> >                         requeue_task(p, rq->active);
> >                         set_tsk_need_resched(p);
> >                 }
> >
> >     My  second question is , what's mean of
> >
> >     (task_timeslice(p) - p->time_slice) % TIMESLICE_GRANULARITY(p)
> >
>
> Sorry, I'm not about to even think about what Ingo's doing here ;-) I just
> trust Ingo knows what he's doing.
>
> You need to ask Ingo himself.
>

Hmmm... basic working is: assume that task P and Q are interactive,
and at the start of the scheduling cycle, both P and Q have got 200
slices to burn, and also that TIMESLICE_GRANULARITY is 50 for P and
100 for Q. Then, by starting to schedule P first, P would run for 50
cycles, Q for 100, P for 50, Q for 100 and P for 50 + 50.

Please note that there are probably more details to take acount of,
but basic logic is that given some tasks with same priority, they
don't use all their slice in one go but take turns in using it.
Probably the granilarity is related to static priority, dynamic
priority, interactive stimation or whatever else control feature.

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/


Every day, every year
you have to work
you have to study
you have to scene.
