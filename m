Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbRADWPz>; Thu, 4 Jan 2001 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131664AbRADWPf>; Thu, 4 Jan 2001 17:15:35 -0500
Received: from mailb.telia.com ([194.22.194.6]:16909 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S131372AbRADWPZ>;
	Thu, 4 Jan 2001 17:15:25 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: ludovic fernandez <ludovic.fernandez@sun.com>,
        Daniel Phillips <phillips@innominate.de>,
        george anzinger <george@mvista.com>
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
Date: Thu, 4 Jan 2001 23:10:49 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de> <3A5437A1.F540D794@sun.com>
In-Reply-To: <3A5437A1.F540D794@sun.com>
MIME-Version: 1.0
Message-Id: <01010423104900.01080@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2001 09:43, ludovic fernandez wrote:
> Daniel Phillips wrote:
> > The key idea here is to disable preemption on spin lock and reenable on
> > spin unlock.  That's a practical idea, highly compatible with the
> > current way of doing things.  Its a fairly heavy hit on spinlock
> > performance, but maybe the overall performance hit is small.  Benchmarks
> > are needed.
>
> I'm not sure the hit on spinlock is this heavy (one increment for lock
> and one dec + test on unlock), but I completely agree (and volonteer)
> for benchmarking.

And the conditional jump is usually predicted correctly :-)
+static inline void enable_preempt(void)

+{
+        if (atomic_read(&current->preemptable) <= 0) {
+                BUG();
+        }
+        if (atomic_read(&current->preemptable) == 1) {


This part can probably be put in a proper non inline function.
Cache issues...
+                /*
+                * At that point a scheduling is healthy iff:
+                * - a scheduling request is pending.
+                * - the task is in running state.
+                * - this is not an interrupt context.
+                * - local interrupts are enabled.
+                */
+                if (current->need_resched == 1     &&
+                   current->state == TASK_RUNNING &&
+                   !in_interrupt()                &&
+                   local_irq_are_enabled())
+                {
+                        schedule();
+                }


+        }
+        atomic_dec(&current->preemptable);

What if something happens during the schedule() that would require
another thread...?

+}       

I have been discussing different layout with George on Montavista
also doing this kind of work... (different var and value range)

static incline void enable_preempt(void) {
    if (--current->preempt_count) {
        smp_mb(); /* not shure if needed... */
        preempt_schedule();
    }
}

in sched.c (some smp_mb might be needed here too...)
void preempt_schedule() {
    while (current->need_resched) {
        current->preempt->count++; /* prevent competition with IRQ code */
        if (current->need_resched)
            schedule();
        current->preempt_count--;
    }
}

> I'm not convinced a full preemptive kernel is something
> interesting mainly due to the context switch cost (actually mmu contex
> switch). 

It will NOT be fully, it will be mostly.
You will only context switch when a higher prio thread gets runnable, two 
ways:
1) external intterupt waking higher prio process, same context swithes as 
when running in user code. We won't get more interrupts.
2) wake up due to something we do. Not that many places, mostly due to
releasing syncronization objects (spinlocks does not count).

If this still is a problem, we can select to only preemt to processes running
RT stuff. SCHED_FIFO and SCHED_RR by letting them set need_resched to 2...


> Benchmarking is a good way to get a global overview on this.

Remember to benchmark with stuff that will make the positive aspects visible 
too. Playing audio (with smaller buffers), more reliably burning CD ROMs,
less hichups while playing video [if run with higher prio...]
Plain throuput tests won't tell the whole story!

see
 http://www.gardena.net/benno/linux/audio
 http://www.linuxdj.com/latency-graph/

> What about only preemptable kernel threads ?

No, it won't help enough.


-- 
--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
