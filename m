Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbRF0WBU>; Wed, 27 Jun 2001 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbRF0WBB>; Wed, 27 Jun 2001 18:01:01 -0400
Received: from f14a-pat.swiftview.com ([208.151.247.147]:17878 "EHLO
	swiftview.com") by vger.kernel.org with ESMTP id <S265424AbRF0WAv>;
	Wed, 27 Jun 2001 18:00:51 -0400
Message-ID: <3B3A56D7.90544D15@swiftview.com>
Date: Wed, 27 Jun 2001 14:57:43 -0700
From: Scott Long <scott@swiftview.com>
Reply-To: scott@swiftview.com
Organization: SwiftView, Inc.
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: wake_up vs. wake_up_sync
In-Reply-To: <3B3A4E8B.E4301909@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does reschedule_idle() ever cause the current CPU to get scheduled? That
is, if someone calls wake_up() and wakes up a higher-priority process
could reschedule_idle() potentially immediately switch the current CPU
to that higher-priority process?

Because this is NOT what I want to happen (it would produce a deadlock
in this particular situation). Having other CPUs get scheduled is ok,
but having the process that called wake_up() get kicked out would be
very bad. In that case I suppose I will have to use wake_up_sync().

Would the following be an appropriate solution?

{
    wake_up_sync(&wq->q);

    /* Potential deadlock situation */
    user_unlock(&wq->lock);

    /* Potential for deadlock has passed */
    reschedule_idle();
}

Thanks,
Scott

Manfred Spraul wrote:
> 
> > I'm having trouble understanding the difference between these.
> > Synchronous apparently causes try_to_wake_up() to NOT call
> > reschedule_idle() but I'm uncertain what reschedule_idle() is doing. I
> > assume it just looks for an idle CPU and makes that CPU reschedule.
> >
> > What is the purpose of wake_up_sync?
> 
> Avoid the reschedule_idle() call - it's quite costly, and it could cause
> processes jumping from one cpu to another.
> 
> > Why would you want to prevent
> > reschedule_idle()?
> >
> If one process runs, wakes up another process and _knows_ that it's
> going to sleep immediately after the wake_up it doesn't need the
> reschedule_idle: the current cpu will be idle soon, the scheduler
> doesn't need to find another cpu for the woken up thread.
> 
> I think the pipe code is the only user of _sync right now - pipes cause
> an incredible amount of task switches.
> 
> --
>         Manfred
