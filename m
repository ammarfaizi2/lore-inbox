Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbRGPVWs>; Mon, 16 Jul 2001 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbRGPVWi>; Mon, 16 Jul 2001 17:22:38 -0400
Received: from sncgw.nai.com ([161.69.248.229]:17591 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267706AbRGPVWa>;
	Mon, 16 Jul 2001 17:22:30 -0400
Message-ID: <XFMail.20010716142557.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010716091446.B1186@w-mikek2.des.beaverton.ibm.com>
Date: Mon, 16 Jul 2001 14:25:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Mike Kravetz <mkravetz@sequent.com>
Subject: Re: CPU affinity & IPI latency
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Hubertus Franke <frankeh@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
Pros to this solution are 1) we are not going to give other fields a different
meaning 2) when the idle will call schedule it'll pick the task w/o rescan.




- Davide

