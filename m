Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbRGPWx2>; Mon, 16 Jul 2001 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267729AbRGPWxT>; Mon, 16 Jul 2001 18:53:19 -0400
Received: from sncgw.nai.com ([161.69.248.229]:24810 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267727AbRGPWxK>;
	Mon, 16 Jul 2001 18:53:10 -0400
Message-ID: <XFMail.20010716155639.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <OFEFD69977.739BBF18-ON85256A8B.00763728@pok.ibm.com>
Date: Mon, 16 Jul 2001 15:56:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Hubertus Franke <frankeh@us.ibm.com>
Subject: Re: CPU affinity & IPI latency
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-Jul-2001 Hubertus Franke wrote:
> 
> Clean, but in this solutions, you can lock out tasks for a
> several cycles, if indeed several of them where added
> in the time before we can service the IPI on the target cpu.
> You can end up with strange priority inversion problems,
> because these tasks aren't seen by the general scheduler
> or let alone are on the runqueue.
> That's why I opted in my design for a single slot.

The idea of list was kind of extension, but to solve this particular problem we
just need a single task ( with no extra member in task_struct ) pointer.


> One could opt for the following implementation to ensure only
> a single waiting task, namely put the already enqueued one back
> if the goodness is worse.
> 
> 
> static inline void wpush(aligned_data * ad, struct task_struct * tsk) {
>        if (ad->wlist &&
>           (preemption_goodness(tsk,ad->wlist,ad->curr->mm) > 0))
>         {
>             add_to_runqueue(ad->wlist,tsk);
>             if (task_on_runqueue(tsk))
>                 list_del(&tsk->run_list);
>             /* obsolete now tsk->wlist_next = ad->wlist; */
>             ad->wlist = tsk;
>         }
> }

wpush() must be called only if *) the target is idle <and> *) the list ( slot )
is empty.
I won't add the goodness checking in there.
Yes, it could happen that another task with greater goodness needs a CPU to run
and, w/o goodness checking this could not be rescheduled on the idle.
But think about at what would happen if the IPI had a zero time response.
The idle would be running the old ( listed or slotted ) task and the CPU would
not be idle anymore.



> 
> I also don't like the fact that with reschedule_idle() you
> just put the task into the runqueue, then you take it out again,
> just to put it back into it after the IPI and that as it seems
> on every reschedule_idle() path.

You can "suspend" the task even by adding an extra field inside the task
struct and add checking of this field around inside the code.
The list removal does not need you to spread extra checking into the code.
It's a simple method to hide a task without modifying a bunch of code.


> In my design one simply wouldn't send the IPI to a target CPU that
> has a pending IPI waiting and preemption wouldn't happen based on
> the goodness values.

You do exactly that with this solution, you reserve the task for
the target idle.
What do You mean with "preemption wouldn't happen based on the goodness values"?



> I grant, that my design seems a bit more intrusive on the code,
> but you were argueing just yesterday not to get stuck up with
> closeness to the current code and semantics.

Pls, don't make me say this stuff.
My was not to make the code more intrusive but, on the contrary, to make it
light by relaxing, in some aspect, the SMP scheduler behaviour compatibility.
I already expressed my opinion about that in previous emails.





- Davide

