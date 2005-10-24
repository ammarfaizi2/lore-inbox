Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVJXUMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVJXUMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVJXUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:12:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6128 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751256AbVJXUMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:12:13 -0400
Message-ID: <435D4009.2030306@mvista.com>
Date: Mon, 24 Oct 2005 13:11:53 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, minyard@acm.org,
       linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: [PATCH 9/9] ipmi: add timer thread
References: <20051021145835.GI19532@i2.minyard.local>	 <20051023134934.1b81d9c6.akpm@osdl.org> <29495f1d0510231412n41ab2d27y41f13a9c9e62b0c2@mail.gmail.com>
In-Reply-To: <29495f1d0510231412n41ab2d27y41f13a9c9e62b0c2@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:
> On 10/23/05, Andrew Morton <akpm@osdl.org> wrote:
> 
>>Corey Minyard <minyard@acm.org> wrote:
>>
>>>We must poll for responses to commands when interrupts aren't in use.
>>>The default poll interval is based on using a kernel timer, which
>>>varies with HZ.  For character-based interfaces like KCS and SMIC
>>>though, that can be way too slow (>15 minutes to flash a new firmware
>>>with KCS, >20 seconds to retrieve the sensor list).
>>>
>>>This creates a low-priority kernel thread to poll more often.  If the
>>>state machine is idle, so is the kernel thread.  But if there's an
>>>active command, it polls quite rapidly.  This decrease a firmware
>>>flash time from 15 minutes to 1.5 minutes, and the sensor list time to
>>>4.5 seconds, on a Dell PowerEdge x8x system.
>>>
>>>The timer-based polling remains, to ensure some amount of
>>>responsiveness even under high user process CPU load.
>>>
>>>Checking for a stopped timer at rmmod now uses atomics and
>>>del_timer_sync() to ensure safe stoppage.
>>>
>>>...
>>>
>>>+static int ipmi_thread(void *data)
>>>+{
>>>+     struct smi_info *smi_info = data;
>>>+     unsigned long flags, last=1;
>>>+     enum si_sm_result smi_result;
>>>+
>>>+     daemonize("kipmi%d", smi_info->intf_num);
>>>+     allow_signal(SIGKILL);
>>>+     set_user_nice(current, 19);
>>>+     while (!atomic_read(&smi_info->stop_operation)) {
>>>+             schedule_timeout(last);
>>>+             spin_lock_irqsave(&(smi_info->si_lock), flags);
>>>+             smi_result=smi_event_handler(smi_info, 0);
>>>+             spin_unlock_irqrestore(&(smi_info->si_lock), flags);
>>>+             if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
>>>+                     last = 0;
>>>+             else if (smi_result == SI_SM_CALL_WITH_DELAY) {
>>>+                     udelay(1);
>>>+                     last = 0;
>>>+             }
>>>+             else {
>>>+                     /* System is idle; go to sleep */
>>>+                     last = 1;
>>>+                     current->state = TASK_INTERRUPTIBLE;
>>>+             }
>>>+     }
>>>+     smi_info->thread_pid = 0;
>>>+     complete_and_exit(&(smi_info->exiting), 0);
>>>+     return 0;
>>>+}
> 
> 
> <snip>
> 
>>The first call to schedule_timeout() here will not actually sleep at all,
>>due to it being in state TASK_RUNNING.  Is that deliberate?
>>
>>Also, this thread can exit in state TASK_INTERUPTIBLE.  That's not a bug
>>per-se, but apparently it'll spit a warning in some of the patches which
>>Ingo is working on.  I don't know why, but I'm sure there's a good reason
>>;)
> 
> 
> You beat me to this one, Andrew! :) Both issue can be avoided by using
> schedule_timeout_interruptible().
> 
> Additionally, I think the last variable is simply being used to switch
> between a 0 and 1 jiffy sleep (took me a while to figure that out in
> GMail sadly -- any chance the variable could be renamed?). In the
> current implementaion of schedule_timeout(), these will result in the
> same behavior, expiring the timer at the next timer interrupt (the
> next jiffy increment is the first time we'll notice we had a timer in
> the past to expire). Not sure if that's the intent and perhaps just a
> means to indicate what is desired (a sleep will still occur, even
> though a udelay() has already in the loop, for instance), but wanted
> to make sure.

I think it would be VERY nice if we could eliminate calls to sleep for NIL time.  Sooner or later 
these are going to bite us very badly.

In the above code, the handling of the "task state" is, well, funny.  If last is 0, it is not 
modified implying that:

	if (last)
		schedule_timeout(last);

might be a better rendering of the intended function.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
