Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289057AbSAGAcv>; Sun, 6 Jan 2002 19:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289058AbSAGAcm>; Sun, 6 Jan 2002 19:32:42 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:48653 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289057AbSAGAcb>; Sun, 6 Jan 2002 19:32:31 -0500
Date: Sun, 6 Jan 2002 16:37:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] mqo1 changes ...
In-Reply-To: <Pine.LNX.4.33.0201061613330.3556-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201061121450.7219-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Ingo Molnar wrote:

>
> On Sat, 5 Jan 2002, Davide Libenzi wrote:
>
> > Ingo, there a fix in ksyms.c ( missing ; ).
>
> thanks, applied, it's in -C1.
>
> > There's a checkpointing code for rt tasks.
>
> thanks, we can certainly do something like this, i've added a variation of
> this to -C1. One thing your patch misses: we need to update the event
> counter when we remove RT tasks as well.

Other solution, differentiate between waiting an running.



> > Ingo, are you sure we need to lock the whole lock set to do rt queue
> > pickups ?
> > RT lock ( first ) + prev-task lock ( next ) should be sufficent.
> > The lock rule will become 1) RT  2) cpu
>
> i had something like this in previous scheduler versions and it was
> deadlock land. But i agree that we can do better and i've already started
> relaxing the draconian RT locking rules again in my tree. (that's not in
> -C1 yet.) But it's much more complex than what you describe, because the
> ->policy value and ->cpu can change as well, so locking in this manner has
> to be done very carefully.

Why ?
You've two queue that are touched, the RT one and the 'prev' one.
I'm using it in BMQS ( the bottom line logic is the same ) and it works
great.



> > The estimator has been removed and the prio/timeslice logic has been used.
> > Each time there's a swap on arrays the rq counter is increased.
>
> not applied. I had this in the very first version of the O(1) scheduler,
> it was called expire_count:
>
> +               unsigned long nr_running, nr_switches, expire_count;
>
> i replaced it with the current estimator, which works much better in a
> number of trickier workloads.
>
> > Each time a task is injected inside the run queue its priority is fastly
> > updated == bonus for sleeping tasks.
> > Each time a task exaust its time slice its priority is decreased, penalty
> > for cpu hungry tasks.
>
> i found this to be a too simple approach that doesnt work for some
> workloads. The history-based load estimator i wrote is sound from a
> theoretical point of view, it calculates an integral of the load value and
> thus represents the load history of the task accurately.
>
> this estimator is well-tested under a number of workloads which do break
> under simpler schemes like the switch-counter based estimator. (the
> 4-entry history estimator clearly beats even some estimators that are more
> accurate than the switch-count based estimator - like the run/sleep
> timestamping estimator or the single-entry history estimator.)
>
> the way i developed/tested the estimator was to put the system under
> various extreme loads and i traced interactive processes. If they were not
> working smoothly (ie. they were starved of the runqueue despite their
> interactive nature) then i changed the estimator.

Can you give me the software you used to test the interactive feel ?
Or to trace tasks ?
I've my method, see below.



> so if you'd like to replace it then please do not do it casually, trace
> the difference under a number of important workloads - i have done so.

No Ingo, you're wrong. That logic gives you the same thing with much less
complexity. The current scheduler, that was not bad about interactive
feel, used to give to i/o bound tasks only _one_ time slice before they
got trapped inside the cpu bound tasks cage.

counter = counter >> 1 + TASK_TIMESLICE

By using the current method tasks will have, if the queue size is 32, 32
cpu hog steps before going down.
Ingo, this is _exactly_ the logic behind BVT schedulers, if you do not use
you time you get a bonus. The logic of the time distribution is inside the
recalc loop ( or the switch arrays ) and tasks that are not requiring a
recharge loop, are rewarded with a bonus when they'll enter the run queue.
Tasks spending their time slice drops priority.
The cost of reentering the run queue is this :


        unsigned long prio_bonus = rq->swap_cnt - p->swap_cnt_last;
        p->swap_cnt_last = rq->swap_cnt;
        if (prio_bonus < MAX_PRIO) {
            p->prio -= prio_bonus;
            if (p->prio < 0)
                p->prio = 0;
        } else
            p->prio = 0;


against this :


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

The cost of exiting the run queue is zero, against this :

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

Ingo, did you realize that 'delta' is always zero here ?

The code i'm proposing you, that is the same of 2.5.2.pre9, has a very
good interactive feel ( better than the old one/2.5.2-pre2 ) and has a
very short reenter path.
How did i measure the interactive feel ?
It's quite simple, i patched both kernels with LatSched :

http://www.xmailserver.org/linux-patches/lnxsched.html#LatSched

and i coded a simple program that sleeps for N seconds and does :

for (;;);

after the sleep.
The program output its pid and i use that to grab the run time ( the last
one == the one after the sleep ) in cycles of the i/o bound task from a
schedcnt dump :

http://www.xmailserver.org/linux-patches/lnxsched.html#SchedCnt

My reference load is gcc kernel build ( open to try other loads ).
The personal feeling confirm measured result.
I'm not still able to boot my machine with your code ingo, i cannot even
get SysRQ or a panic, it freezes completely. It boots and somewhere inside
the daemon startup freezes. The daemon in which crashes are random even if
the most common one is lpd.
Yesterday i was able to reach the login but as soon as i pressed a key it
freezed. The machine i'm using is an 1GHz Athlon with 256 Mb of ram.




- Davide


