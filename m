Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWBAMbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWBAMbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBAMbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:31:25 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:57946 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932446AbWBAMbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:31:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=P3DGu+BJ8Hnj0Fs/ES0xhoEenoRvKcjk5Gsdgmr709xjZMJB+Kb7dF+pmmMQ/coYA2A3tt5kPgFOxbL7d/W2o0PprLFUFvcWvTXDfRTb6jXUwj0WS7Z3eONKtbUUvzHLctWYK/UqXTvdNjAFBM/JqWuyD+TWMvE65U713H+URFM=  ;
Message-ID: <43E0AA18.1090208@yahoo.com.au>
Date: Wed, 01 Feb 2006 23:31:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com> <43D941FD.9050705@yahoo.com.au> <43D94595.4030002@symas.com> <43D94C2D.6080401@yahoo.com.au> <43D9D4ED.8050406@symas.com>
In-Reply-To: <43D9D4ED.8050406@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Nick Piggin wrote:
>> Howard Chu wrote:
>>
>>>
>>> And again in this case, A should not be immediately reacquiring the 
>>> lock if it doesn't actually need it.
>>>
>>
>> No, not immediately, I said "for a very long time". As in: A does not
>> need the exclusion provided by the lock for a very long time so it
>> drops it to avoid needless contention, then reaquires it when it finally
>> does need the lock.
> 
> 
> OK. I think this is really a separate situation. Just to recap: A takes 
> lock, does some work, releases lock, a very long time passes, then A 
> takes the lock again. In the "time passes" part, that mutex could be 
> locked and unlocked any number of times by other threads and A won't 
> know or care. Particularly on an SMP machine, other threads that were 
> blocked on that mutex could do useful work in the interim without 
> impacting A's progress at all. So here, when A leaves the mutex unlocked 
> for a long time, it's desirable to give the mutex to one of the waiters 
> ASAP.
> 

But how do you quantify "a long time"? And what happens if process A is
a very high priority and which nothing else is allowed to run?

>> Just accept that my described scenario is legitimate then consider it in
>> isolation rather than getting caught up in the superfluous details of how
>> such a situation might come about.
> 
> 
> OK. I'm not trying to be difficult here. In much of life, context is 
> everything; very little can be understood in isolation.
> 

OK, but other valid examples were offered up - lock inversion avoidance,
and externally driven systems (ie. where it is not known which lock will
be taken next).

> Back to the scenario:
> 
>> A realtime system with tasks A and B, A has an RT scheduling priority of
>> 1, and B is 2. A and B are both runnable, so A is running. A takes a 
>> mutex
>> then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
>> some point it drops the mutex and then tries to take it again.
>>
>> What happens?
> 
> 
> As I understand the spec, A must block because B has acquired the mutex. 
> Once again, the SUS discussion of priority inheritance would never need 
> to have been written if this were not the case:
> 
>  >>>
> In a priority-driven environment, a direct use of traditional primitives 
> like mutexes and condition variables can lead to unbounded priority 
> inversion, where a higher priority thread can be blocked by a lower 
> priority thread, or set of threads, for an unbounded duration of time. 
> As a result, it becomes impossible to guarantee thread deadlines. 
> Priority inversion can be bounded and minimized by the use of priority 
> inheritance protocols. This allows thread deadlines to be guaranteed 
> even in the presence of synchronization requirements.
> <<<
> 
> The very first sentence indicates that a higher priority thread can be 
> blocked by a lower priority thread. If your interpretation of the spec 
> were correct, then such an instance would never occur. Since your 

Wrong. It will obviously occur if the lower priority process is able
to take a lock before a higher priority process.

The situation will not exist in "the scenario" though, if we follow
my reading of the spec, because *the scheduler* determines the next
process to gain the mutex. This makes perfect sense to me.

> scenario is using realtime threads, then we can assume that the Priority 
> Ceiling feature is present and you can use it if needed. ( 
> http://www.opengroup.org/onlinepubs/000095399/xrat/xsh_chap02.html#tag_03_02_09_06 
> Realtime Threads option group )
> 

Any kind of priority boost / inherentance like this is orthogonal to
the issue. They still do not prevent B from acquiring the mutex and
thereby blocking the execution of the higher priority A. I think this
is against the spirit of the spec, especially the part where it says
*the scheduler* will choose which process to gain the lock.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
