Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277137AbRJHVJi>; Mon, 8 Oct 2001 17:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277134AbRJHVJ2>; Mon, 8 Oct 2001 17:09:28 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:9600 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277135AbRJHVJP>; Mon, 8 Oct 2001 17:09:15 -0400
Message-ID: <3BC2158E.BE52400D@welho.com>
Date: Tue, 09 Oct 2001 00:07:26 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com> <20011007162439.P748@nightmaster.csn.tu-chemnitz.de> <3BC067BB.73AF1EB5@welho.com> <3BC0982A.84ECBE7B@mvista.com> <3BC0D1C9.63C7F218@welho.com> <3BC0E9FD.4F3921C6@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Mika Liljeberg wrote:
> > I'm not sure I fully understood what you're driving at, but surely "each
> > task getting its allotted share" implies that the tasks are correctly
> > balanced across CPUs?
> 
> Actually I am trying to recast your requirement (for fairness) into
> something that is clean and easy to code :)

Fair enough. ;)

> The current schedule periodically calculates new time slices for each
> task.  It does this when no task in the run queue has any slice time
> left.  The slice size each task gets is related to the NICE value.  In
> practice then (other things being equal) each task will get a portion of
> the available processing time that is related to its NICE value.  I
> think this is fair.  But, of course, other things are not equal.  When a
> task is blocked and the recalculation happens, that task gets to keep
> 1/2 of it remaining slice as well as the new slice.  Since, in addition
> to slice time, the remaining slice value is used as a major component of
> the task's priority, this means that the blocked task, if it is blocked
> during a recalculate, will get a boosted priority.

Thanks for the concise explanation. I follow you a little better now.

> I think what Alan is suggesting is that the priority boost is needed for
> blocked tasks, but not necessarily the increased slice time.

I have to agree. If the job is I/O bound, it's unlikely to need the
extra CPU time.

> > > when a cpu finds itself with nothing to do
> > > (because all its tasks have completed their slices or blocked) and other
> > > cpus have tasks in their queues it is time to "shop" for a new task to
> > > run.
> >
> > This again has the problem that you only look for new tasks if you have
> > nothing to do. While this would work if you only look at the total
> > completion time of a set of tasks, it does nothing to ensure fair
> > scheduling for a particular task.
> 
> But doesn't the f(NICE) used as a slice do this.  The point is that we
> will not allow a recalculate until all run able tasks with non zero
> slice times have run their slice times to zero.  This insures that all
> tasks that can use the cpu will get their fair share of time each
> "recalculate period".

Ok, I think I get you. I didn't realize that there was already a strict
fairness enforcing mechanism built into the scheduler. So, you're
proposing to do a rebalance when the first CPU runs out of things to do,
which will happen sometime before the recalculate period expires?

Sounds reasonable, but I think you will see a flurry of rebalancing when
the recalculate period is ending and the CPUs are starting to run out of
things to do. This will cause load the balancer to frantically try to
spread the last few tasks with remaining time slices across the CPUs.
This is exactly the kind of thrashing that we would like to avoid.

> This is pretty much what is done today across the whole run queue.  The
> enhancement we are talking about is separating tasks by cpu and pretty
> much keeping them on one cpu.

Exactly.

> > >  This would then do load balancing just before each "recalculate
> > > tick".
> > > Of course, the above assumes that each cpu has its own run queue.
> > >
> > > George

Cheers,

	MikaL
