Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRF1C5c>; Wed, 27 Jun 2001 22:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265491AbRF1C5X>; Wed, 27 Jun 2001 22:57:23 -0400
Received: from [32.97.182.101] ([32.97.182.101]:28050 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265488AbRF1C5R>;
	Wed, 27 Jun 2001 22:57:17 -0400
Importance: Normal
Subject: Re: wake_up vs. wake_up_sync
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF61CC799C.768003D6-ON85256A79.000FA3AC@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 27 Jun 2001 22:54:17 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 06/27/2001 10:56:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Manfred,

Calling this a BUG is misleading. It is ok to be occasionally wrong
regarding the preemption priority as long as RT tasks are not involved.
This is due to the fact that PROC_CHANGE_PENALTIES are used, which already
provide for some priority inversion.

Hubertus Franke
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Manfred Spraul <manfred@colorfullife.com>@vger.kernel.org on 06/27/2001
06:41:29 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   Mike Kravetz <mkravetz@sequent.com>
cc:   Scott Long <scott@swiftview.com>, linux-kernel@vger.kernel.org
Subject:  Re: wake_up vs. wake_up_sync



Mike Kravetz wrote:
>
> On Wed, Jun 27, 2001 at 11:22:19PM +0200, Manfred Spraul wrote:
> > > Why would you want to prevent
> > > reschedule_idle()?
> > >
> > If one process runs, wakes up another process and _knows_ that it's
> > going to sleep immediately after the wake_up it doesn't need the
> > reschedule_idle: the current cpu will be idle soon, the scheduler
> > doesn't need to find another cpu for the woken up thread.
>
> I'm curious.  How does the caller of wake_up_sync know that the
> current cpu will soon be idle.  Does it assume that there are no
> other tasks on the runqueue waiting for a CPU?  If there are other
> tasks on the runqueue, isn't it possible that another task has a
> higher goodness value than the task being awakened.  In such a case,
> isn't is possible that the awakened task could sit on the runqueue
> (waiting for a CPU) while tasks with a lower goodness value are
> allowed to run?
>

I found one combination where that could happen:

process.thread
A.1: highest priority, runs on cpu0
B.1: lowest priority, runs on cpu1
A.2: another thread of process A, priority
PROC_CHANGE_PENALTY+PRIORITY(B.1)+1, sleeping.
B.2: same priority as A.2, sleeping, same process as B.1

A.1:
{
     wake_up("A.2");
/* nothing happens: preemption_goodness is 0 since B.1 has both
PROC_CHANGE_PENALTY and the += 1 from 'same mm'
*/
     wake_up_sync("B.2");
     schedule();
/* schedule selects A.2 instead of B.2 due to the += 1 from 'same mm'.
BUG: B.2 should replace B.1 on cpu1. The preemption_goodness is 1.
*/

IMHO obscure and very rare.

But I just found a bigger problem:
If wake_up_sync wakes up more than 1 process then cpus could remain in
cpu_idle() although processes are on the runqueue without cpus.

--
     Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



