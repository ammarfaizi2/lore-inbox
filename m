Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273420AbRINQLh>; Fri, 14 Sep 2001 12:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273421AbRINQL3>; Fri, 14 Sep 2001 12:11:29 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:25047 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273420AbRINQLP>; Fri, 14 Sep 2001 12:11:15 -0400
Date: Fri, 14 Sep 2001 09:10:35 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: shreenivasa H V <shreenihv@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler policy
Message-ID: <20010914091035.A1102@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20010914022756.9487.qmail@nwcst280.netaddress.usa.net> <20010913211431.A1021@w-mikek2.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913211431.A1021@w-mikek2.sequent.com>; from kravetz@us.ibm.com on Thu, Sep 13, 2001 at 09:14:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 09:14:31PM -0700, Mike Kravetz wrote:
> On Thu, Sep 13, 2001 at 09:27:56PM -0500, shreenivasa H V wrote:
> > Hi,
> > 
> > In process scheduling, when an epoch ends because of the current process
> > completing its time quantum (and all the runnable ones having finished their
> > respective quantums), at the start of the new epoch, will the current running
> > process retain the cpu (assuming all the runnable ones are of the same
> > priority)?
> 
> Short answer, for UP kernels yes.
> 
> If all the tasks on the runqueue have the same priority (nice value),
> then they will all (almost) have the same goodness value at the start
> of the new epoch.  However, tasks with the same memory map as the
> currently running task will get their goodness value boosted by 1.
> The next task to run will be the first one found that has the same
> memory map as the currently running task.  The check for 'still_running'
> ensures that the the currently running task will be found first.

I thought about this some more and need to correct my original
response.  It is possible for another task to run after the start
of a new epoch.  This could come about due to the fact that the
runqueue lock is dropped during the 'recalculate' operation.  More
important to note is that during recalculate a window is open
where interrupts are enabled.  If a timer interrupt is serviced
in this window AFTER the counter value for the currently running
task has been adjusted, then the timer interrupt code will decrement
the counter value of the currently running task by 1.  In this
case the currently running task will have a lower goodness value
than other tasks that share the same memory map.  Therefore, some
other task with the same memory map would be chosen to run next.

In addition, when the runqueue lock is dropped during recalculate
tasks can be added to the runqueue which could have higher goodness
values (but the same priority) as the currently running task.
However, I'm not sure if these cases are within the constraints of
your original question.

My amended answer is most likely yes: possible no. :)

-- 
Mike Kravetz                                  kravetz@us.ibm.com
IBM Linux Technology Center       (we're not at Sequent anymore)
