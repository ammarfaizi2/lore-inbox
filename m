Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWAZV4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWAZV4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWAZV4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:56:43 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:27913 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1750709AbWAZV4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:56:42 -0500
Message-ID: <43D94595.4030002@symas.com>
Date: Thu, 26 Jan 2006 13:56:37 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com> <43D941FD.9050705@yahoo.com.au>
In-Reply-To: <43D941FD.9050705@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Howard Chu wrote:
>> Nick Piggin wrote:
>>
>>> OK, you believe that the mutex *must* be granted to a blocking thread
>>> at the time of the unlock. I don't think this is unreasonable from the
>>> wording (because it does not seem to be completely unambiguous 
>>> english),
>>> however think about this -
>>>
>>> A realtime system with tasks A and B, A has an RT scheduling 
>>> priority of
>>> 1, and B is 2. A and B are both runnable, so A is running. A takes a 
>>> mutex
>>> then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
>>> some point it drops the mutex and then tries to take it again.
>>>
>>> What happens?
>>>
>>> I haven't programmed realtime systems of any complexity, but I'd 
>>> think it
>>> would be undesirable if A were to block and allow B to run at this 
>>> point.
>>
>>
>> But why does A take the mutex in the first place? Presumably because 
>> it is about to execute a critical section. And also presumably, A 
>> will not release the mutex until it no longer has anything critical 
>> to do; certainly it could hold it longer if it needed to.
>>
>> If A still needed the mutex, why release it and reacquire it, why not 
>> just hold onto it? The fact that it is being released is significant.
>>
>
> Regardless of why, that is just the simplest scenario I could think
> of that would give us a test case. However...
>
> Why not hold onto it? We sometimes do this in the kernel if we need
> to take a lock that is incompatible with the lock already being held,
> or if we discover we need to take a mutex which nests outside our
> currently held lock in other paths. Ie to prevent deadlock.

In those cases, A cannot retake the mutex anyway. I.e., you just said 
that you released the first mutex because you want to acquire a 
different one. So those cases don't fit this example very well.

> Another reason might be because we will be running for a very long
> time without requiring the lock.

And again in this case, A should not be immediately reacquiring the lock 
if it doesn't actually need it.

> Or we might like to release it because
> we expect a higher priority process to take it.

And in this case, the expected behavior is the same as I've been pursuing.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

