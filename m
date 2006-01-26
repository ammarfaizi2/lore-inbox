Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWAZVlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWAZVlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWAZVlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:41:20 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:14683 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751419AbWAZVlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:41:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DJlnfq0ZBhCTkYdqPgm/i9YHAhHzgs/ZrsjdM71/dENc8SmrS6LOWs2oV/Y3B+Ov1PAxc8rQ6Tw0qls3KGugqLT0qstO+unbFTmBO8ZjunBovaGObj5f3HNLXySPjS2zbs96FY6ZP+tjLMFqnQ27TyyuOKu1LmJnx26QOY1LbJA=  ;
Message-ID: <43D941FD.9050705@yahoo.com.au>
Date: Fri, 27 Jan 2006 08:41:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com>
In-Reply-To: <43D93FEA.3070305@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Nick Piggin wrote:
> 
>> OK, you believe that the mutex *must* be granted to a blocking thread
>> at the time of the unlock. I don't think this is unreasonable from the
>> wording (because it does not seem to be completely unambiguous english),
>> however think about this -
>>
>> A realtime system with tasks A and B, A has an RT scheduling priority of
>> 1, and B is 2. A and B are both runnable, so A is running. A takes a 
>> mutex
>> then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
>> some point it drops the mutex and then tries to take it again.
>>
>> What happens?
>>
>> I haven't programmed realtime systems of any complexity, but I'd think it
>> would be undesirable if A were to block and allow B to run at this point.
> 
> 
> But why does A take the mutex in the first place? Presumably because it 
> is about to execute a critical section. And also presumably, A will not 
> release the mutex until it no longer has anything critical to do; 
> certainly it could hold it longer if it needed to.
> 
> If A still needed the mutex, why release it and reacquire it, why not 
> just hold onto it? The fact that it is being released is significant.
> 

Regardless of why, that is just the simplest scenario I could think
of that would give us a test case. However...

Why not hold onto it? We sometimes do this in the kernel if we need
to take a lock that is incompatible with the lock already being held,
or if we discover we need to take a mutex which nests outside our
currently held lock in other paths. Ie to prevent deadlock.

Another reason might be because we will be running for a very long
time without requiring the lock. Or we might like to release it because
we expect a higher priority process to take it.

>> Now this has nothing to do with PI or SCHED_OTHER, so behaviour is 
>> exactly
>> determined by our respective interpretations of what it means for "the
>> scheduling policy to decide which task gets the mutex".
>>
>> What have I proven? Nothing ;) but perhaps my question could be answered
>> by someone who knows a lot more about RT systems than I.
> 
> 
> In the last RT work I did 12-13 years ago, there was only one high 
> priority producer task and it was never allowed to block. The consumers 
> just kept up as best they could (multi-proc machine of course). I've 
> seldom seen a need for many priority levels. Probably not much you can 
> generalzie from this though.
> 

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
