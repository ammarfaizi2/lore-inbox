Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSAEEaN>; Fri, 4 Jan 2002 23:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287505AbSAEE3y>; Fri, 4 Jan 2002 23:29:54 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:65042 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287439AbSAEE3h>; Fri, 4 Jan 2002 23:29:37 -0500
Date: Fri, 4 Jan 2002 20:33:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201041857490.937-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, i finally had the time to take a look at the code and i've some
comments. I'll start by saying what i like and it is the sched.c cleanup
from the messy condition that suffered by a long time. Then a question,
why the hell are you trying to achieve O(1) inside the single CPU schedulers ?
Once a smart guy said me that only fools never change opinion so i'm not
going to judge you for this, but do you remember 4 years ago when i posted
the priority queue patch what you did say ?
You said, just in case you do not remember, that the load average over a
single CPU even for high loaded servers is typically lower than 5.
So why the hell create 13456 queues to achieve an O(1) on the lookup code
when 70% of the switch cost is switch-mm ?
Yes, 70% of the cost of a context switch is switch-mm, and this measured
with a cycle counter. Take a look at this if you do not believe :

http://www.xmailserver.org/linux-patches/ltcpu.png

More, you removed the MM affinity test that, i agree that is not always
successful, but even if it's able to correctly predict 50% of the
reschedules, it'll be able to save you more then O(1) pickup on a 1..3
runqueue length. Once you've split the queue and removed the common lock
you reduced _a_lot_ the scheduler cost for the SMP case and inside the
local CPU you don't need O(1) pickups.
Why ?
Look at how many people suffered the current scheduler performances for
the UP case. Noone. People posted patches to get O(1) pickups ( yep, even
me ), guys  tried them believing that these would have solved their
problems and noone requested a merge because the current scheduler
architecture is just OK for the uniprocessor case.
Lets come at the code. Have you ever tried to measure the context switch
times for standard tasks when there's an RT tasks running ?
Every time an RT run, every task on other CPUs will try to pickup a task
inside the RT queue :

    if (unlikely(rt_array.nr_active))
        if (rt_schedule())
            goto out_return;

and more, inside the rt_schedule() you're going to get the full lock set :

    lock_rt();
    ...

static void lock_rt(void)
{
    int i;

    __cli();
    for (i = 0; i < smp_num_cpus; i++)
        spin_lock(&cpu_rq(i)->lock);
    spin_lock(&rt_lock);
}

with disabled interrupts. More the wakeup code for RT task is, let's say,
at least sub-optimal :

        if (unlikely(rt_task(p))) {
            spin_lock(&rt_lock);
            enqueue_task(p, &rt_array);

>>          smp_send_reschedule_all();

            current->need_resched = 1;
            spin_unlock(&rt_lock);
        }

You basically broadcast IPIs with all other CPUs falling down to get the
whole lock set. I let you imagine what happens. The load estimator is both
complex, expensive ( mult, divs, mods ) and does not work :

static inline void update_sleep_avg_deactivate(task_t *p)
{
    unsigned int idx;
    unsigned long j = jiffies, last_sample = p->run_timestamp / HZ,
        curr_sample = j / HZ, delta = curr_sample - last_sample;

    if (delta) {
        if (delta < SLEEP_HIST_SIZE) {
            for (idx = 0; idx < delta; idx++) {
                p->sleep_idx++;
                p->sleep_idx %= SLEEP_HIST_SIZE;
                p->sleep_hist[p->sleep_idx] = 0;
            }
        } else {
            for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
                p->sleep_hist[idx] = 0;
            p->sleep_idx = 0;
        }
    }
    p->sleep_timestamp = j;
}

If you scale down to seconds with /HZ, delta will be 99.99% of cases zero.
How much do you think a task will run 1-3 seconds ?!?
You basically shortened the schedule() path by adding more code on the
wakeup() path. This :

static inline unsigned int update_sleep_avg_activate(task_t *p)
{
    unsigned int idx;
    unsigned long j = jiffies, last_sample = p->sleep_timestamp / HZ,
        curr_sample = j / HZ, delta = curr_sample - last_sample,
        delta_ticks, sum = 0;

    if (delta) {
        if (delta < SLEEP_HIST_SIZE) {
            p->sleep_hist[p->sleep_idx] += HZ - (p->sleep_timestamp % HZ);
            p->sleep_idx++;
            p->sleep_idx %= SLEEP_HIST_SIZE;

            for (idx = 1; idx < delta; idx++) {
                p->sleep_idx++;
                p->sleep_idx %= SLEEP_HIST_SIZE;
                p->sleep_hist[p->sleep_idx] = HZ;
            }
        } else {
            for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
                p->sleep_hist[idx] = HZ;
            p->sleep_idx = 0;
        }
        p->sleep_hist[p->sleep_idx] = 0;
        delta_ticks = j % HZ;
    } else
        delta_ticks = j - p->sleep_timestamp;
    p->sleep_hist[p->sleep_idx] += delta_ticks;
    p->run_timestamp = j;

    for (idx = 0; idx < SLEEP_HIST_SIZE; idx++)
        sum += p->sleep_hist[idx];

    return sum * HZ / ((SLEEP_HIST_SIZE-1)*HZ + (j % HZ));
}

plus this :

#define MAX_BOOST (MAX_PRIO/3)
    sleep = update_sleep_avg_activate(p);
    load = HZ - sleep;
    penalty = (MAX_BOOST * load)/HZ;
    if (penalty) {
        p->prio = NICE_TO_PRIO(p->__nice) + penalty;
        if (p->prio < 0)
            p->prio = 0;
        if (p->prio > MAX_PRIO-1)
            p->prio = MAX_PRIO-1;
    }

cannot be defined a short path inside wakeup().
Even the expire task, that is called at HZ frequency is not that short :

void expire_task(task_t *p)
{
    runqueue_t *rq = this_rq();
    unsigned long flags;

    if (rt_task(p)) {
        if ((p->policy == SCHED_RR) && p->time_slice) {
            spin_lock_irqsave(&rq->lock, flags);
            spin_lock(&rt_lock);
            if (!--p->time_slice) {
                /*
                 * RR tasks get put to the end of the
                 * runqueue when their timeslice expires.
                 */
                dequeue_task(p, &rt_array);
                enqueue_task(p, &rt_array);
                p->time_slice = RT_PRIO_TO_TIMESLICE(p->prio);
                p->need_resched = 1;
            }
            spin_unlock(&rt_lock);
            spin_unlock_irqrestore(&rq->lock, flags);
        }
        return;
    }
    if (p->array != rq->active) {
        p->need_resched = 1;
        return;
    }
    /*
     * The task cannot change CPUs because it's the current task.
     */
    spin_lock_irqsave(&rq->lock, flags);
    if (!--p->time_slice) {
        p->need_resched = 1;
        p->time_slice = PRIO_TO_TIMESLICE(p->prio);

        /*
         * Timeslice used up - discard any possible
         * priority penalty:
         */
        dequeue_task(p, rq->active);
        enqueue_task(p, rq->expired);
    } else {
        /*
         * Deactivate + activate the task so that the
         * load estimator gets updated properly:
         */
        deactivate_task(p, rq);
        activate_task(p, rq);
    }
    load_balance(rq);
    spin_unlock_irqrestore(&rq->lock, flags);
}

with a runqueue balance done at every timer tick.
Another thing that i'd like to let you note is that with the current
2.5.2-preX scheduler the recalculation loop is no more a problem
because it's done only for running tasks and the lock switch between
task_list and runqueue has been removed. This is just fine because if you
consider the worst case for the recalc loop frequency is one CPU bound
task running. In this case the frequency is about 1/TS ~= 20 and it's done
only for one task. If you've two CPU bound tasks runnning the frequency
will become about 1/(2 * TS) ~= 10 ( recalc two tasks ). With the modified
2.5.2-preX has been cut _a_lot_ the recalculation loop cost and, while
before on my machine i was able to clearly distinguish recalc loop
LatSched samples ( ~= 40000 cycles with about 120 processes ), now the
context switch cost is uniform over the time ( no random peaks to 40000 cycles ).
Anyway, it's the balancing code that will make the _real_world_ tests
difference on a multi queue scheduler, not O(1) pickups.




- Davide



