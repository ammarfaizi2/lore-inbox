Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318500AbSHPONY>; Fri, 16 Aug 2002 10:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318501AbSHPONX>; Fri, 16 Aug 2002 10:13:23 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:42444 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S318500AbSHPONW>; Fri, 16 Aug 2002 10:13:22 -0400
Message-ID: <20020816141718.4766.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Fri, 16 Aug 2002 16:17:18 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Antti Salmela <asalmela@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
References: <20020814145454.A21254@wasala.fi> <1029328630.26226.21.camel@irongate.swansea.linux.org.uk> <20020814161037.A22388@wasala.fi> <1029331629.26227.36.camel@irongate.swansea.linux.org.uk> <20020814185505.A23923@wasala.fi> <20020814173057.18028.qmail@thales.mathematik.uni-ulm.de> <1029375182.28236.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029375182.28236.31.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 02:33:02AM +0100, Alan Cox wrote:
> Thanks - your analysis is informative to say the least. It looks like
> the PIV load balancing code is the problem. 

A few more observations and maybe a solution for the problem
(kernel is 2.4.20-pre1-ac3):

I ran Richard Gooch's scheduler benchmark[1] as a normal user with
num_running set to 50 (./a.out 50). The box locks up hard within a few
seconds. There is no Ooops, Magic-SysRq doesn't work anymore, neither does
console switching or Ctrl-Alt-Delete. NMI-Watchdog is enabled and failed
to reboot the box.

This suggests that sched_yield, nice or sched_setscheduler is involved
with sched_yield beeing #1 candidate.

Further investigation showed that adding BUG_ON(p->array != array);
in dequeue_task would have given some interesting results.
At least the following is quite possible and doesn't even require SMP:

      Task                          Interrupt
Calls sys_sched_yield
      ======> Timer Interrupt
				    Timer Interrupt decreases times lice,
				    the time slice expires and the task is
				    moved to the expired array.
Continues with yield.
Assume current->prio == MAX_PRIO-1,
current->time_slice <= 1 is satisifed
anyway, i.e. wie do:
   dequeue_task(current, rq->active);
   enqueue_task(current, rq->expired);
However, the task has already been moved
from the active to the expired array
by the timer interrupt, i.e.
dequeue_task and enqueue_task will get
the nr_active counts and the bitmaps
wrong because they remove the task from
the wrong array.  --> BOOOM

The (untested) patch below should correct this problem along with
a locking oddity (last hunk) that IMHO either needs fixing or a BIG
comment. Be prepared for a few (up to 4) lines of fuzz due to additional
BUG_ONs in both versions of the file.

     regards   Christian Ehrhardt

[1] http://www.atnf.csiro.au/people/rgooch/benchmarks/linux-scheduler.html


--- /usr/src/linux-2.4.20-pre1-ac3/kernel/sched.c	Thu Aug 15 20:03:01 2002
+++ sched.c	Fri Aug 16 16:15:57 2002
@@ -769,7 +772,7 @@
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
+			dequeue_task(p, p->array);
 			enqueue_task(p, rq->active);
 		}
 		goto out;
@@ -785,7 +788,7 @@
 	if (p->sleep_avg)
 		p->sleep_avg--;
 	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
+		dequeue_task(p, p->array);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = TASK_TIMESLICE(p);
@@ -1396,7 +1399,7 @@
 	 */
 	if (likely(current->prio == MAX_PRIO-1)) {
 		if (current->time_slice <= 1) {
-			dequeue_task(current, rq->active);
+			dequeue_task(current, array);
 			enqueue_task(current, rq->expired);
 		} else
 			current->time_slice--;
@@ -1411,7 +1414,7 @@
 		list_add_tail(&current->run_list, array->queue + current->prio);
 		__set_bit(current->prio, array->bitmap);
 	}
-	spin_unlock(&rq->lock);
+	rq_unlock (rq);
 
 	schedule();
 

-- 
THAT'S ALL FOLKS!
