Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270654AbUJUPAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbUJUPAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270737AbUJUO6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:58:11 -0400
Received: from mail.timesys.com ([65.117.135.102]:54122 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S270756AbUJUOyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:54:06 -0400
Message-ID: <4177CD3C.9020201@timesys.com>
Date: Thu, 21 Oct 2004 10:52:44 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Jens Axboe <axboe@suse.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk>
In-Reply-To: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 14:49:03.0000 (UTC) FILETIME=[1B4C5980:01C4B77D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:

>On Thu, 21 Oct 2004, john cooper wrote:
>
>>Mutexes layered on existing semaphores seems convenient
>>at the moment. However a more native mutex mechanism
>>which tracks ownership would provide a basis for PI as
>>well as further instrumentation. This may not be an
>>issue at the present but I don't think it is too far
>>off.
>>
>>-john
>>
>>
>
>Actually you need to have another kind of semaphore based on a new kind of
>wait-queue: Priority based. I.e. the task with the highest priority get
>woken up first. Then on top of that you build your mutex.
>
That more/less falls out of the PI mechanism. Though it
appears conserving per-mutex data footprint and O(1)
behavior are going to be at odds.

>I was planning to start to look at it and try to see if I could get
>anything to work, but I must admit I haven't got much further than
>just getting Igno's -U8.1 up running.
>
I myself wonder whether Ingo is 1 or N people.

>To get a mutex with priority inheritance add an element pointing to the
>current owner and a field where you store the owners original priority
>which it has to be set back to when it relases the mutex (I am not sure
>how this will work out if someone holds several mutexes!)
>
A task holding several mutexes shouldn't be an issue.
Though per task an ownership list needs to be maintained
in descending priority order such that the effective PI
can be resolved from all task owned mutexes.

Also a multiple ownership model is needed for the case of
shared-reader locks. This results in a list of owners
where the list element can maintain per-mutex task ownership
as well as per-task mutex ownerships.

It is tempting to re-implement the wheel here but existing
works are well on their way:

http://developer.osdl.org/dev/robustmutexes

-john

-- 
john.cooper@timesys.com

