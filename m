Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265752AbUA0UdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUA0UdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:33:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:63483 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265752AbUA0UdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:33:13 -0500
Message-ID: <4016CAE2.2070502@mvista.com>
Date: Tue, 27 Jan 2004 12:32:34 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: eric.piel@tremplin-utc.net, minyard@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX, MIPS nonsense removed,
 timer_gettime fix
References: <1074979873.4012e421714b1@mailetu.utc.fr>	<40162D2D.3030406@mvista.com> <20040127104648.1e749f5d.akpm@osdl.org>
In-Reply-To: <20040127104648.1e749f5d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>The attached patch does the following:
>>
>>Removes C++ comment in favor of C style.
>>
>>Removes the special treatment for MIPS SIGEV values.  We only require (and error 
>>if this fails) that the SIGEV_THREAD_ID value not share bits with the other 
>>SIGEV values.  Note that mips has yet to define this value so when they do...
>>
>>Corrects the check for the signal range to be from 1 to SIGRTMAX inclusive.
>>
>>Adds a check to verify that kmem_cache_alloc() actually returned a timer, error 
>>if not.
>>
>>Fixes a bug in timer_gettime() where the incorrect value was returned if a 
>>signal was pending on the timer OR the timer was a SIGEV_NONE timer.
> 
> 
>>-	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
>>-			event->sigev_signo &&
>>-			((unsigned) (event->sigev_signo > SIGRTMAX)))
>>+	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
>>+	    ((unsigned int) (event->sigev_signo - 1) >= SIGRTMAX))
>> 		return NULL;
> 
> 
> I was wondering if someone would try this one :( Really, this is just over
> the top.  Take pity upon your readers, and do:

I was rather thinking of educating them :)  It does produce better code...
> 
> 	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
> 		(event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX))
> 
> 
>>@@ -804,7 +826,7 @@
>> 	 * equal to jiffies, so the timer notify function is called directly.
>> 	 * We do not even queue SIGEV_NONE timers!
>> 	 */
>>-	if (!(timr->it_sigev_notify & SIGEV_NONE)) {
>>+	if (!((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
>> 		if (timr->it_timer.expires == jiffies)
>> 			timer_notify_task(timr);
>> 		else
> 
> 
> Are you sure this is correct?   If so, using != would be clearer.

Yes, if he said SIGEV_NONE we don't want to deliver a signal.  The restatement 
is OK with me.

Shall I resubmit?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

