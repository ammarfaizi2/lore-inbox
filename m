Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbVLWUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVLWUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbVLWUs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:48:27 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3719 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161047AbVLWUs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:48:27 -0500
Subject: Re: questions on wait_event ...
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexey Shinkin <alexshinkin@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY16-F260F9C6F509BFC683D3A6AF330@phx.gbl>
References: <BAY16-F260F9C6F509BFC683D3A6AF330@phx.gbl>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 15:48:25 -0500
Message-Id: <1135370905.5774.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please include CCs of people who respond to you or you might not ever
get a response.  There's too much traffic on the LKML, your email may
get lost in the noise.

On Fri, 2005-12-23 at 07:46 +0600, Alexey Shinkin wrote:
> Look:
> 
> We call wait_event() , condition is FALSE at the moment  :
> 
>     do {
>          if (condition)
>                  break;
>     /* and here we have condition changed  to TRUE  */
>     /*  process is NOT in any wait queue yet  */
>     /*  then  unroll     __wait_event(wq, condition);        */
> 
>      do {							DEFINE_WAIT(__wait);					for (;;) {
> 	prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);
> 
>           /* at this point condition is TRUE , process is in a wait queue 
> and its state is
>              TASK_UNINTERRUPTIBLE.   If  rescheduling happens now the 
> process will asleep,
>               despite of condition is  TRUE . And will not be woken up until 
> next wake_up happens
>               Is that correct ?  */

OHHH! Your question is about __preemption__!!!

That's a completely different story, because if a process gets
preempted, it will _not_ be taken off the runqueue even if it's state is
in TASK_UNINTERRUPTIBLE.  Otherwise, there would be lots of places in
the kernel that is broken.

from schedule in sched.c:

/* when preempted, the preempt_count gets "PREEMPT_ACTIVE"
   so the following if will not be entered */

	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
		switch_count = &prev->nvcsw;
		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
				unlikely(signal_pending(prev))))
			prev->state = TASK_RUNNING;
		else {
			if (prev->state == TASK_UNINTERRUPTIBLE)
				rq->nr_uninterruptible++;

/* Here we would have taken off the task from the runqueue
   but we don't, so the task _will_ wake up again when it is
   scheduled back in. */

			deactivate_task(prev, rq);
		}
	}

-- Steve

> 	if (condition)						     break;
>                     schedule();
>         }
>    finish_wait(&wq, &__wait);
> } while (0)
>    /*  end of unroll __wait_event*/
> 
> } while (0)
> 
> _________________________________________________________________
> Express yourself instantly with MSN Messenger! Download today it's FREE! 
> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

