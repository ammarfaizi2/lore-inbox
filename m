Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbRGPVpm>; Mon, 16 Jul 2001 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbRGPVpd>; Mon, 16 Jul 2001 17:45:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24571 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267714AbRGPVpU>;
	Mon, 16 Jul 2001 17:45:20 -0400
Importance: Normal
Subject: Re: CPU affinity & IPI latency
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFEFD69977.739BBF18-ON85256A8B.00763728@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 16 Jul 2001 17:45:02 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/16/2001 05:45:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clean, but in this solutions, you can lock out tasks for a
several cycles, if indeed several of them where added
in the time before we can service the IPI on the target cpu.
You can end up with strange priority inversion problems,
because these tasks aren't seen by the general scheduler
or let alone are on the runqueue.
That's why I opted in my design for a single slot.

One could opt for the following implementation to ensure only
a single waiting task, namely put the already enqueued one back
if the goodness is worse.


static inline void wpush(aligned_data * ad, struct task_struct * tsk) {
       if (ad->wlist &&
          (preemption_goodness(tsk,ad->wlist,ad->curr->mm) > 0))
        {
            add_to_runqueue(ad->wlist,tsk);
            if (task_on_runqueue(tsk))
                list_del(&tsk->run_list);
            /* obsolete now tsk->wlist_next = ad->wlist; */
            ad->wlist = tsk;
        }
}

I also don't like the fact that with reschedule_idle() you
just put the task into the runqueue, then you take it out again,
just to put it back into it after the IPI and that as it seems
on every reschedule_idle() path.

In my design one simply wouldn't send the IPI to a target CPU that
has a pending IPI waiting and preemption wouldn't happen based on
the goodness values.

I grant, that my design seems a bit more intrusive on the code,
but you were argueing just yesterday not to get stuck up with
closeness to the current code and semantics.

Comments ?

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com



Davide Libenzi <davidel@xmailserver.org>@ewok.dev.mcafeelabs.com on
07/16/2001 05:25:57 PM

Sent by:  davidel@ewok.dev.mcafeelabs.com


To:   Mike Kravetz <mkravetz@sequent.com>
cc:   linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
      Hubertus Franke/Watson/IBM@IBMUS
Subject:  Re: CPU affinity & IPI latency




On 16-Jul-2001 Mike Kravetz wrote:
> On Fri, Jul 13, 2001 at 11:25:21PM -0400, Hubertus Franke wrote:
>>
>> Mike, could we utilize the existing mechanism such as has_cpu.
>>
>
> I like it.  Especially the way you eliminated the situation where
> we would have multiple tasks waiting for schedule.  Hope this is
> not a frequent situation!!!  The only thing I don't like is the
> use of has_cpu to prevent the task from being scheduled.  Right
> now, I can't think of any problems with it.  However, in the past
> I have been bit by using fields for purposes other than what they
> were designed for.

How about this ( draft ) :


struct task_struct {
        ...
        struct task_struct * wlist_next;
        ...
};


static union {
        struct schedule_data {
                struct task_struct * curr;
                struct task_struct * wlist;
                cycles_t last_schedule;
        } schedule_data;
        char __pad [SMP_CACHE_BYTES];
} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};


static inline struct task_struct * wpick(aligned_data * ad) {
        struct task_struct * tsk = ad->wlist;
        if (tsk) {
                ad->wlist = tsk->wlist_next;
                add_to_runqueue(tsk);
        }
        return tsk;
}

static inline void wpush(aligned_data * ad, struct task_struct * tsk) {
        if (task_on_runqueue(tsk))
                list_del(&tsk->run_list);
        tsk->wlist_next = ad->wlist;
        ad->wlist = tsk;
}


asmlinkage void schedule(void)
{
        ...
        if ((next = wpick(sched_data)))
                goto ...;
        ...
}

In reschedule_idle() when before sending the IPI we do a wpush().
We modify aligned_data->wlist and tsk->wlist_next under runqueue_lock so we
don't need another one.
A slight change is needed to reschedule_idle() to handle the new field.
Pros to this solution are 1) we are not going to give other fields a
different
meaning 2) when the idle will call schedule it'll pick the task w/o rescan.




- Davide




