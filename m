Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUHECYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUHECYC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUHECYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:24:02 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:32127 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266695AbUHECX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:23:58 -0400
Message-ID: <41119A3B.2020202@yahoo.com.au>
Date: Thu, 05 Aug 2004 12:23:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube> <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au> <411196EE.9050408@bigpond.net.au>
In-Reply-To: <411196EE.9050408@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> Nick Piggin wrote:
>
>> Peter Williams wrote:
>>
>>> Albert Cahalan wrote:
>>>
>>>> Are these going to be numbered consecutively, or might
>>>> they better be done like the task state? SCHED_FIFO is
>>>> in fact already treated this way in one place. One might
>>>> want to test values this way:
>>>>
>>>> if(foo & (SCHED_ISO|SCHED_RR|SCHED_FIFO))  ...
>>>>
>>>> (leaving aside SCHED_OTHER==0, or just translate
>>>> that single value for the ABI)
>>>>
>>>> I'd like to see these get permenant allocations
>>>> soon, even if the code doesn't go into the kernel.
>>>> This is because user-space needs to know the values.
>>>
>>>
>>>
>>>
>>> Excellent idea.  The definition of rt_task() could become:
>>>
>>> #define rt_task(p) ((p)->policy & (SCHED_RR|SCHED_FIFO))
>>>
>>> instead of the highly dodgy:
>>
>
> I probably should have said "slightly" instead of "highly" here but I 
> got carried away. :-)
>
>>>
>>> #define rt_task(p) ((p)->prio < MAX_RT_PRIO)
>>>
>>
>> Nothing wrong with that, is there?
>
>
> It's sloppy logic in that "prio" being less than MAX_RT_PRIO is a 
> consequence of the task being real time not the definition of it.  At 
> the moment it is a sufficient condition for identifying a task as real 
> time but that may not always be the case.

Actually, p->prio < MAX_RT_PRIO iff rt_task(p). This can't change 
without horribly breaking
stuff.

> But, the real issue is, what's the point of having a field, "policy", 
> that IS the definitive indicator of the task's scheduling policy if 
> you don't use it?  An rt_task() function/macro defined in terms of the 
> policy field with this suggested numbering scheme should always be 
> correct.
>
> At the moment rt_task(p) could be defined as ((p)->policy != 
> SCHED_OTHER) but the addition of SCHED_ISO and SCHED_BATCH would break 
> that.  Another option would be (((p)->policy == SCHED_FIFO) || 
> ((p)->policy == SCHED_RR)) but that's a little long winded and 
> (avoiding it) is probably the reason for the current definition. 


Conversely, p->prio < MAX_RT_PRIO neatly defines a task as being 
realtime without worrying
about what exact policy it is using. However if you add or remove 
scheduling policies, your
p->policy method breaks.

