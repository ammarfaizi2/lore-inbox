Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSFGSg6>; Fri, 7 Jun 2002 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317317AbSFGSg5>; Fri, 7 Jun 2002 14:36:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37104 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317316AbSFGSg4>; Fri, 7 Jun 2002 14:36:56 -0400
Subject: Re: Scheduler Bug (set_cpus_allowed)
From: Robert Love <rml@tech9.net>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020606162028.E3193@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 11:36:46 -0700
Message-Id: <1023475007.1137.62.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 16:20, Mike Kravetz wrote:

> Consider the case where a task is to give up the CPU
> and schedule() is called.  In such a case the current
> task is removed from the runqueue (via deactivate_task).
> Now, further assume that there are no runnable tasks
> on the runqueue and we end up calling load_balance().
> In load_balance, we potentially drop the runqueue lock
> to obtain multiple runqueue locks in the proper order.
> Now, when we drop the runqueue lock we will still
> be running in the context of task p.  However, p does
> not reside on a runqueue.  It is now possible for
> set_cpus_allowed() to be called for p.  We can get the
> runqueue lock and take the fast path to simply update
> the task's cpu field.  If this happens, bad (very bad)
> things will happen!

Ugh I think you are right.  This is an incredibly small race, though!

> My first thought was to simply add a check to the
> above code to ensure that p was not currently running
> (p != rq->curr).  However, even with this change I
> 'think' the same problem exists later on in schedule()
> where we drop the runqueue lock before doing a context
> switch.  At this point, p is not on the runqueue and
> p != rq->curr, yet we are still runnning in the context
> of p until we actually do the context switch.  To tell
> the truth, I'm not exactly sure what 'rq->frozen' lock
> is for.  Also, the routine 'schedule_tail' does not
> appear to be used anywhere.

I agree here, too.

Fyi, schedule_tail is called from assembly code on SMP machines.  See
entry.S

rq->frozen is admittedly a bit confusing.  Dave Miller added it - on
some architectures mm->page_table_lock is grabbed during switch_mm(). 
Additionally, swap_out() and others grab page_table_lock during wakeups
which also grab rq->lock.  Bad locking... Dave's solution was to make
another lock, the "frozen state lock", which is held around context
switches.  This way we can protect the "not switched out yet" task
without grabbing the whole runqueue lock.

Anyhow, with this issue, I guess we need to fix it... I'll send a patch
to Linus.

	Robert Love

