Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVHSGe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVHSGe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVHSGe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:34:56 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:3736 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750955AbVHSGez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:34:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MosvepnfyaqF92G0lGp1Mknoi2Mpnlw7dhUGpcQugKseEUldHjkrCpcemcRHhpNuph31RgJMps3qtuGtu/IBBTgFAVVdQ5PUxoNN8jluj9dQhvgprByDAnQAvCu6kw6U1DyJWYd/P3s0cy83e1+Jus1xebeRKYGTNj4JlKAwyK8=  ;
Message-ID: <43057D91.1090505@yahoo.com.au>
Date: Fri, 19 Aug 2005 16:34:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com>
In-Reply-To: <43057641.70700@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

Thanks for joining the discussion. One request, if I may,
can you retain the CC list on posts please?

Howard Chu wrote:
 >
>>  AFAIKS, sched_yield should only really be used by realtime
>>  applications that know exactly what they're doing.
> 
> 
> pthread_yield() was deleted from the POSIX threads drafts years ago. 
> sched_yield() is the officially supported API, and OpenLDAP is using it 
> for the documented purpose. Anyone who says "applications shouldn't be 
> using sched_yield()" doesn't know what they're talking about.
> 

Linux's SCHED_OTHER policy offers static priorities in the range [0..0].
I think anything else would be a bug, because from my reading of the
standards, a process with a higher static priority shall always preempt
a process with a lower priority.

And SCHED_OTHER simply doesn't work that way.

So sched_yield() from a SCHED_OTHER task is free to basically do anything
at all. Is that the kind of behaviour you had in mind?

>>  It's really more a feature than a bug that it breaks so easily
>>  because they should be really using futexes instead, which have much
>>  better behaviour than any sched_yield ever could (they will directly
>>  wake up another process waiting for the lock and avoid the thundering
>>  herd for contended locks)
> 
> 
> You assume that spinlocks are the only reason a developer may want to 
> yield the processor. This assumption is unfounded. Case in point - the 
> primary backend in OpenLDAP uses a transactional database with 
> page-level locking of its data structures to provide high levels of 
> concurrency. It is the nature of such a system to encounter deadlocks 
> over the normal course of operations. When a deadlock is detected, some 
> thread must be chosen (by one of a variety of algorithms) to abort its 
> transaction, in order to allow other operations to proceed to 
> completion. In this situation, the chosen thread must get control of the 
> CPU long enough to clean itself up, and then it must yield the CPU in 
> order to allow any other competing threads to complete their 
> transaction. The thread with the aborted transaction relinquishes all of 
> its locks and then waits to get another shot at the CPU to try 
> everything over again. Again, this is all fundamental to the nature of 

You didn't explain why you can't use a mutex to do this. From
your brief description, it seems like a mutex might just do
the job nicely.

> transactional programming. If the 2.6 kernel makes this programming 
> model unreasonably slow, then quite simply this kernel is not viable as 
> a database platform.
> 

Actually it should still be fast. It may yield excessive CPU to
other tasks (including those that are reniced). You didn't rely
on sched_yield providing some semantics about not doing such a
thing, did you?

Send instant messages to your online friends http://au.messenger.yahoo.com 
