Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUF1W40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUF1W40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUF1W40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:56:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35831 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265275AbUF1W4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:56:21 -0400
Message-ID: <40E0A1DC.5000905@mvista.com>
Date: Mon, 28 Jun 2004 15:55:24 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: boris.hu@intel.com, drepper@redhat.com, adam.li@intel.com,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] Bugfix for CLOCK_REALTIME absolute timer.
References: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>	<40E094DB.9000702@mvista.com> <20040628151725.09b691e4.akpm@osdl.org>
In-Reply-To: <20040628151725.09b691e4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>Andrew,
>>
>>Boris and I have kicked this around enough.  It think it is ready for prime time.
>>
> 
> 
>> static void schedule_next_timer(struct k_itimer *timr)
>> {
>>...
>>+	do {
>>+		seq = read_seqbegin(&xtime_lock);
>>+		new_wall_to =	wall_to_monotonic;
>>+		posix_get_now(&now);
>>+	} while (read_seqretry(&xtime_lock, seq));
>>+
>>+	if (!list_empty(&timr->abs_timer_entry)) {
>>+		spin_lock(&abs_list.lock);
>>+		add_clockset_delta(timr, &new_wall_to);
>>+	}
>>+		    
>> 	do {
>> 		posix_bump_timer(timr);
>> 	}while (posix_time_before(&timr->it_timer, &now));
>> 
>>+	if (!list_empty(&timr->abs_timer_entry))
>>+		spin_unlock(&abs_list.lock);
> 
> 
> The locking in here is a bit ugly.  Does the lock actually need to be held while
> the timer is being bumped?
> 
> And what is the upper bound on that while loop?

Yes, I agree that it is ugly.  And on top of that, we are holding the timer lock 
which is an irq version.  As to the need to hold it through the bump, we want 
the timers expire time to match what it should given the clock setting we are 
using, otherwise, the clock_was_set() code could come through and change that 
under us.  (Not a pretty sight.)

Now, the bounding on the while, :( it depends on a) the interval and b) how far 
the clock was moved.  The shorter the interval or the longer the time interval, 
the more we loop.  I suppose the best thing to do here is an div, but will, most 
of the time, take longer.
> 
> 
>> 	tmr->it_id = (timer_t)-1;
>>+        INIT_LIST_HEAD(&tmr->abs_timer_entry);
>> 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
> 
> 
> The cat ate your tab key? ;)

Oh, shit.  And I thought I had the cat locked away in the back room. ;)
> 
> 
>>+	if (!list_empty(&timr->abs_timer_entry)) {
>>+		spin_lock(&abs_list.lock);
>>+		list_del_init(&timr->abs_timer_entry);
>>+		spin_unlock(&abs_list.lock);
>>+	}
> 
> 
> This is repeated often.  Does it merit its own function?

Ok.
> 
> 
>>+static DECLARE_MUTEX(clock_was_set_lock);
>>+#define mutex_enter(x) down(x)
>>+#define mutex_enter_interruptable(x) down_interruptible(x)
>>+#define mutex_exit(x) up(x)
> 
> 
> Please open-code these operations.

Eh?  Seems funny that we have a definition for mutex (DECLARE_MUTEX) and don't 
have the defines to use them.  But, ok.
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

