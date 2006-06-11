Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWFKFtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWFKFtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWFKFte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:49:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46033 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161082AbWFKFte (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Sun, 11 Jun 2006 01:49:34 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Date: Sat, 10 Jun 2006 22:49:25 -0700
User-Agent: KMail/1.9.1
Cc: linux-kerneL@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu>
In-Reply-To: <20060610064850.GA11002@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m76iEwE6eL3I7RX"
Message-Id: <200606102249.26063.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_m76iEwE6eL3I7RX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 09 June 2006 23:48, Ingo Molnar wrote:
> * Darren Hart <dvhltc@us.ibm.com> wrote:
> > @@ -1543,6 +1543,17 @@ static int try_to_wake_up(task_t *p, uns
> >  		}
> >  	}
> >
> > +	/*
> > +	 * XXX  Don't send RT task elsewhere unless it can preempt current
> > +	 * XXX  on other CPU.  Better yet would be for awakened RT tasks to
> > +	 * XXX  examine this(and all other) CPU(s) to see what is the best
> > +	 * XXX  fit.  For example there is no check here to see if the
> > +	 * XXX  currently running task can be preempted (which would be the
> > +	 * XXX  ideal case).
> > +	 */
> > +	if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq))
> > +		goto out_set_cpu;
> > +
>
> Great testcase! Note that we already do RT-overload wakeups further
> below:
>
>                 /*
>                  * If a newly woken up RT task cannot preempt the
>                  * current (RT) task then try to find another
>                  * CPU it can preempt:
>                  */
>                 if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq)) {
>                         smp_send_reschedule_allbutself();
>                         rt_overload_wakeup++;
>                 }
>
> what i think happened is that the above logic misses the case you have
> described in detail, and doesnt mark the current CPU for rescheduling.
>
> I.e. it sends an IPI to all _other_ CPUs, including the 'wrong target' -
> but it doesnt mark the current CPU for reschedule - hence if the current
> CPU is the only right target we might fail to handle this task!
>
> could you try the (untested) patch below, does it solve your testcase
> too?

Thanks for the updated patch!  It wouldn't quite build (proc_misc.c still 
referenced the old rt_overload_* variables, fixup patch attached removing 
those print statements).  I have it running on a 4 way opteron box running 
prio-preempt in a timed while loop, exiting only on failure.  It's been 
running fine for several minutes - usually fails in under a mintue.  We'll 
see how it's doing in the morning :-)

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team

--Boundary-00=_m76iEwE6eL3I7RX
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rto-proc_misc-fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rto-proc_misc-fixup.patch"

diff -Nurp linux-2.6.16/fs/proc/proc_misc.c linux-2.6.16-fixup/fs/proc/proc_misc.c
--- linux-2.6.16/fs/proc/proc_misc.c	2006-06-10 16:48:23.000000000 -0700
+++ linux-2.6.16-fixup/fs/proc/proc_misc.c	2006-06-10 17:00:55.000000000 -0700
@@ -569,19 +569,11 @@ static int show_stat(struct seq_file *p,
 	{
 		unsigned long nr_uninterruptible_cpu(int cpu);
 		extern int pi_initialized;
-		extern int rt_overload_schedule,
-			   rt_overload_wakeup, rt_overload_pulled;
 		unsigned long rt_nr_running_cpu(int cpu);
 		extern atomic_t rt_overload;
 
 		int i;
 
-		seq_printf(p, "rt_overload_schedule: %d\n",
-					rt_overload_schedule);
-		seq_printf(p, "rt_overload_wakeup:   %d\n",
-					rt_overload_wakeup);
-		seq_printf(p, "rt_overload_pulled:   %d\n",
-					rt_overload_pulled);
 		seq_printf(p, "pi_init: %d\n", pi_initialized);
 		seq_printf(p, "nr_running(): %ld\n",
 			nr_running());
@@ -593,8 +585,6 @@ static int show_stat(struct seq_file *p,
 		for_each_cpu(i)
 			seq_printf(p, "rt_nr_running(%d): %ld\n",
 				i, rt_nr_running_cpu(i));
-		seq_printf(p, "rt_overload: %d\n", atomic_read(&rt_overload));
-
 	}
 #endif
 

--Boundary-00=_m76iEwE6eL3I7RX--
