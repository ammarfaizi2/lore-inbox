Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVJWVMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVJWVMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVJWVMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:12:54 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:20526 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750772AbVJWVMx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:12:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sbb3L6BlkaozqvlsZVWvinmFGq2d+46gmHROeBtgsUsQh3TfK/ZaMuQ3p37Vdvq1+Y0LEqF35XL1H1GEPfXTlVccdvD89ihXfSj/G0gyajwhIfHYC2ntwIEKAHtosF7vNi6hsNTRuuzkCyVrG1LmaAKl4z+/gJcKeWdAE3AvMjY=
Message-ID: <29495f1d0510231412n41ab2d27y41f13a9c9e62b0c2@mail.gmail.com>
Date: Sun, 23 Oct 2005 14:12:51 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 9/9] ipmi: add timer thread
Cc: minyard@acm.org, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
In-Reply-To: <20051023134934.1b81d9c6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051021145835.GI19532@i2.minyard.local>
	 <20051023134934.1b81d9c6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/05, Andrew Morton <akpm@osdl.org> wrote:
> Corey Minyard <minyard@acm.org> wrote:
> >
> > We must poll for responses to commands when interrupts aren't in use.
> > The default poll interval is based on using a kernel timer, which
> > varies with HZ.  For character-based interfaces like KCS and SMIC
> > though, that can be way too slow (>15 minutes to flash a new firmware
> > with KCS, >20 seconds to retrieve the sensor list).
> >
> > This creates a low-priority kernel thread to poll more often.  If the
> > state machine is idle, so is the kernel thread.  But if there's an
> > active command, it polls quite rapidly.  This decrease a firmware
> > flash time from 15 minutes to 1.5 minutes, and the sensor list time to
> > 4.5 seconds, on a Dell PowerEdge x8x system.
> >
> > The timer-based polling remains, to ensure some amount of
> > responsiveness even under high user process CPU load.
> >
> > Checking for a stopped timer at rmmod now uses atomics and
> > del_timer_sync() to ensure safe stoppage.
> >
> > ...
> >
> > +static int ipmi_thread(void *data)
> > +{
> > +     struct smi_info *smi_info = data;
> > +     unsigned long flags, last=1;
> > +     enum si_sm_result smi_result;
> > +
> > +     daemonize("kipmi%d", smi_info->intf_num);
> > +     allow_signal(SIGKILL);
> > +     set_user_nice(current, 19);
> > +     while (!atomic_read(&smi_info->stop_operation)) {
> > +             schedule_timeout(last);
> > +             spin_lock_irqsave(&(smi_info->si_lock), flags);
> > +             smi_result=smi_event_handler(smi_info, 0);
> > +             spin_unlock_irqrestore(&(smi_info->si_lock), flags);
> > +             if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
> > +                     last = 0;
> > +             else if (smi_result == SI_SM_CALL_WITH_DELAY) {
> > +                     udelay(1);
> > +                     last = 0;
> > +             }
> > +             else {
> > +                     /* System is idle; go to sleep */
> > +                     last = 1;
> > +                     current->state = TASK_INTERRUPTIBLE;
> > +             }
> > +     }
> > +     smi_info->thread_pid = 0;
> > +     complete_and_exit(&(smi_info->exiting), 0);
> > +     return 0;
> > +}

<snip>

> The first call to schedule_timeout() here will not actually sleep at all,
> due to it being in state TASK_RUNNING.  Is that deliberate?
>
> Also, this thread can exit in state TASK_INTERUPTIBLE.  That's not a bug
> per-se, but apparently it'll spit a warning in some of the patches which
> Ingo is working on.  I don't know why, but I'm sure there's a good reason
> ;)

You beat me to this one, Andrew! :) Both issue can be avoided by using
schedule_timeout_interruptible().

Additionally, I think the last variable is simply being used to switch
between a 0 and 1 jiffy sleep (took me a while to figure that out in
GMail sadly -- any chance the variable could be renamed?). In the
current implementaion of schedule_timeout(), these will result in the
same behavior, expiring the timer at the next timer interrupt (the
next jiffy increment is the first time we'll notice we had a timer in
the past to expire). Not sure if that's the intent and perhaps just a
means to indicate what is desired (a sleep will still occur, even
though a udelay() has already in the loop, for instance), but wanted
to make sure.

Thanks,
Nish
