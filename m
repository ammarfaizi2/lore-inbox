Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284687AbRLEWCB>; Wed, 5 Dec 2001 17:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284535AbRLEWAL>; Wed, 5 Dec 2001 17:00:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35260 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284761AbRLEV7U>; Wed, 5 Dec 2001 16:59:20 -0500
Date: Wed, 5 Dec 2001 13:58:51 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
Message-ID: <20011205135851.D1193@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011126114610.B1141@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.33.0111280145300.3429-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111280145300.3429-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Nov 28, 2001 at 02:07:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 02:07:08AM +0100, Ingo Molnar wrote:
> 
> On Mon, 26 Nov 2001, Mike Kravetz wrote:
> 
> > I'm happy to see the cleanup of scheduler code that went into
> > 2.4.15/16.  One small difference in behavior (I think) is that the
> > currently running task is not given preference over other tasks on the
> > runqueue with the same 'goodness' value.  I would think giving the
> > current task preference is a good thing (especially in light of recent
> > discussions about too frequent moving/rescheduling of tasks).  Can
> > someone provide the rational for this change?  Was it just the result
> > of making the code cleaner?  Is it believed that this won't really
> > make a difference?
> 
> i've done this change as part of the sched_yield() fixes/cleanups, and the
> main reason for it is that the current process is preferred *anyway*, due
> to getting the +1 boost via current->mm == this_mm in goodness().
> 
> (and besides, the percentage/probability of cases where we'd fail reselect
> a runnable process where the previous scheduler would reselect it is very
> very low. It does not justify adding a branch to the scheduler hotpath
> IMO. In 99.9% of the cases if a runnable process is executing schedule()
> then there is a higher priority process around that will win the next
> selection. Or if there is a wakeup race, then the process will win the
> selection very likely because it won the previous selection.)
> 
> 	Ingo

FYI - I have been having a heck of a time getting our MQ scheduler to
work well in 2.4.16/2.5.0.  The problem was mainly with performance
when running (I'm afraid to say) VolanoMark.  Turns out that the above
change makes a big difference in this benchmark when running with the
MQ scheduler.  There is an almost 50% drop in performance on my 8 way.
I suspect that one would not see such a dramatic drop (if any) with
the current scheduler as its performance is mostly limited by lock
contention in this benchmark.

Now, I'm aware that very few people are actively using our MQ scheduler,
and even fewer care about VolanoMark performance (perhaps no one on this
list).  However, this seemed like an interesting observation.

-- 
Mike
