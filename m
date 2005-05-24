Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVEXPbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVEXPbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVEXPbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:31:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24815 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262115AbVEXP2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:28:33 -0400
Message-ID: <429347FA.8060203@mvista.com>
Date: Tue, 24 May 2005 08:27:54 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
References: <42909DC2.7922E05D@tv-sign.ru> <42926F83.9050608@mvista.com> <4292F5FF.1A92086C@tv-sign.ru>
In-Reply-To: <4292F5FF.1A92086C@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> George Anzinger wrote:
> 
>>Oleg Nesterov wrote:
>>
>>>This patch removes timer_active/set_timer_inactive which plays with
>>>timer_list's internals in favour of using try_to_del_timer_sync(),
>>>which was introduced in the previous patch.
>>
>>Is there a particular reason for this, like it does not work, for example, or
>>are you just trying to clean up code?
> 
> 
> It's a cleanup, I think that current code is correct.
> 
> 
>>If this currently works, please leave it alone.
> 
> 
> Ok.
> 
> 
>>We also note that this code is the subject of a patch to the RT patch to cover
>>the same issue when softirqs are run from threads and therefor allow
>>posix_timer_fn to be preempted.  (That fix being mainly to expand usage from
>>just SMP to SMP || SOFTIRQ_PREEMPT.)
> 
> 
> I guess you are talking about this patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111566867218576
> 
> 
>>Also, I think that del_timer_sync and friends need to be turned on if soft_irq
>>is preemptable.
> 
> 
> I agree completely.
> 
> 
>>+ * For RT the timer call backs are preemptable.  This means that folks
>>+ * trying to delete timers may run into timers that are "active" for
>>+ * long times.  To help out with this we provide a wake up function to
>>+ * wake up a caller who wants waking when a timer clears the call back.
>>+ * This is the same sort of thing that the del_timer_sync does, but we
>>+ * need (in the HRT case) to cover two lists and not just the one.
>>+ */
>>+#ifdef CONFIG_PREEMPT_SOFTIRQS
>>+#include <linux/wait.h>
>>+static DECLARE_WAIT_QUEUE_HEAD(timer_wake_queue);
>>+#define wake_timer_waiters() wake_up(&timer_wake_queue)
>>+#define wait_for_timer(timer) wait_event(timer_wake_queue, !timer_active(timer))
> 
> 
> I'm not an expert at all, so I may be wrong, but I don't think
> it's a good idea.
> 
> I think it is bad if __run_timers() could be preempted while
> ->running_timer != NULL. This will interact badly with __mod_timer,
> del_timer_sync. I think that __run_timers() should do:
> 
> 	set_running_timer(base, timer);
> 	preempt_disable();
> 	spin_unlock_irq(&base->lock);
> 
> 	timer->function();
> 
> 	set_running_timer(base, NULL);
> 	preempt_enable();
> 	spin_lock_irq(&base->lock);
> 
> What do you think?

First, I think we need to get Ingo in the discussion. :)

Second, the RT patch has been running this way with little problems, save a 
REALLY intense test we (Monta Vista) have run that, from time to time, shows 
this to be a problem in the posix-timer code that is fixed by including 
SOFTIRQ_PREEMPT as well as SMP in the timer ifdefs.

One thing I do see there (in the RT patch) is a change to del_timer_sync to wait 
for the timer call back to complete rather than to loop...
> 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
