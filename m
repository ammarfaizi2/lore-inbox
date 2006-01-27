Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWA0IIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWA0IIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWA0IIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:08:30 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:65034 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1030259AbWA0II3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:08:29 -0500
Message-ID: <43D9D4ED.8050406@symas.com>
Date: Fri, 27 Jan 2006 00:08:13 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com> <43D941FD.9050705@yahoo.com.au> <43D94595.4030002@symas.com> <43D94C2D.6080401@yahoo.com.au>
In-Reply-To: <43D94C2D.6080401@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Howard Chu wrote:
>
>>> Another reason might be because we will be running for a very long
>>> time without requiring the lock.
>>
>>
>> And again in this case, A should not be immediately reacquiring the 
>> lock if it doesn't actually need it.
>>
>
> No, not immediately, I said "for a very long time". As in: A does not
> need the exclusion provided by the lock for a very long time so it
> drops it to avoid needless contention, then reaquires it when it finally
> does need the lock.

OK. I think this is really a separate situation. Just to recap: A takes 
lock, does some work, releases lock, a very long time passes, then A 
takes the lock again. In the "time passes" part, that mutex could be 
locked and unlocked any number of times by other threads and A won't 
know or care. Particularly on an SMP machine, other threads that were 
blocked on that mutex could do useful work in the interim without 
impacting A's progress at all. So here, when A leaves the mutex unlocked 
for a long time, it's desirable to give the mutex to one of the waiters 
ASAP.

>>> Or we might like to release it because
>>> we expect a higher priority process to take it.
>>
>>
>> And in this case, the expected behavior is the same as I've been 
>> pursuing.
>>
>
> No, we're talking about what happens when A tries to aquire it again.
>
> Just accept that my described scenario is legitimate then consider it in
> isolation rather than getting caught up in the superfluous details of how
> such a situation might come about.

OK. I'm not trying to be difficult here. In much of life, context is 
everything; very little can be understood in isolation.

Back to the scenario:

> A realtime system with tasks A and B, A has an RT scheduling priority of
> 1, and B is 2. A and B are both runnable, so A is running. A takes a 
> mutex
> then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
> some point it drops the mutex and then tries to take it again.
>
> What happens?

As I understand the spec, A must block because B has acquired the mutex. 
Once again, the SUS discussion of priority inheritance would never need 
to have been written if this were not the case:

 >>>
In a priority-driven environment, a direct use of traditional primitives 
like mutexes and condition variables can lead to unbounded priority 
inversion, where a higher priority thread can be blocked by a lower 
priority thread, or set of threads, for an unbounded duration of time. 
As a result, it becomes impossible to guarantee thread deadlines. 
Priority inversion can be bounded and minimized by the use of priority 
inheritance protocols. This allows thread deadlines to be guaranteed 
even in the presence of synchronization requirements.
<<<

The very first sentence indicates that a higher priority thread can be 
blocked by a lower priority thread. If your interpretation of the spec 
were correct, then such an instance would never occur. Since your 
scenario is using realtime threads, then we can assume that the Priority 
Ceiling feature is present and you can use it if needed. ( 
http://www.opengroup.org/onlinepubs/000095399/xrat/xsh_chap02.html#tag_03_02_09_06 
Realtime Threads option group )

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

