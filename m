Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270715AbUJUPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbUJUPvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbUJUPqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:46:33 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:7561 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S270780AbUJUPmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:42:37 -0400
Message-ID: <4177DA11.4090902@ru.mvista.com>
Date: Thu, 21 Oct 2004 19:47:29 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
CC: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com>
In-Reply-To: <4177CD3C.9020201@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
> Esben Nielsen wrote:
> 
>> On Thu, 21 Oct 2004, john cooper wrote:
>>
>>> Mutexes layered on existing semaphores seems convenient
>>> at the moment. However a more native mutex mechanism
>>> which tracks ownership would provide a basis for PI as
>>> well as further instrumentation. This may not be an
>>> issue at the present but I don't think it is too far
>>> off.
>>>
>>> -john
>>>
>>>
>>
>> Actually you need to have another kind of semaphore based on a new 
>> kind of
>> wait-queue: Priority based. I.e. the task with the highest priority get
>> woken up first. Then on top of that you build your mutex.
>>
> That more/less falls out of the PI mechanism. Though it
> appears conserving per-mutex data footprint and O(1)
> behavior are going to be at odds.
> 
>> I was planning to start to look at it and try to see if I could get
>> anything to work, but I must admit I haven't got much further than
>> just getting Igno's -U8.1 up running.
>>
> I myself wonder whether Ingo is 1 or N people.
> 
>> To get a mutex with priority inheritance add an element pointing to the
>> current owner and a field where you store the owners original priority
>> which it has to be set back to when it relases the mutex (I am not sure
>> how this will work out if someone holds several mutexes!)
>>
> A task holding several mutexes shouldn't be an issue.
> Though per task an ownership list needs to be maintained
> in descending priority order such that the effective PI
> can be resolved from all task owned mutexes.

Seems it is too coplex model at least for the first step. The one of 
possible trade-offs coming on mind is to trace the number of resources 
(mutexes) held by a process and to restore original priority only when 
resource count reaches 0. This is one of the sollutions accepted by RTOS 
guys.

The other concern with PI is that most likely PI should be prohibited 
for utilization with locks which are used in the way similar to "waiting 
completition" - i.e. if PI is employed on a mutex it is prohibited to 
release it if a process is not the owner of the mutex.

> 
> Also a multiple ownership model is needed for the case of
> shared-reader locks. This results in a list of owners
> where the list element can maintain per-mutex task ownership
> as well as per-task mutex ownerships.
> It is tempting to re-implement the wheel here but existing
> works are well on their way:
> 
> http://developer.osdl.org/dev/robustmutexes

It is definitly non-trivial work to adapt this approach - there are a 
lot of issues.

				Eugeny
> -john
> 


