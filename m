Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUJUQ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUJUQ4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUJUQwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:52:45 -0400
Received: from mail.timesys.com ([65.117.135.102]:14502 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S268987AbUJUQvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:51:07 -0400
Message-ID: <4177E89A.1090100@timesys.com>
Date: Thu, 21 Oct 2004 12:49:30 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eugeny S. Mints" <emints@ru.mvista.com>
CC: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com>
In-Reply-To: <4177DA11.4090902@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 16:45:57.0562 (UTC) FILETIME=[704D91A0:01C4B78D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeny S. Mints wrote:

> john cooper wrote:
>
>> A task holding several mutexes shouldn't be an issue.
>> Though per task an ownership list needs to be maintained
>> in descending priority order such that the effective PI
>> can be resolved from all task owned mutexes.
>
>
> Seems it is too coplex model at least for the first step. The one of 
> possible trade-offs coming on mind is to trace the number of resources 
> (mutexes) held by a process and to restore original priority only when 
> resource count reaches 0. This is one of the sollutions accepted by 
> RTOS guys.

It would seem a mutex ownership list still needs to be maintained.
Doing so in unordered priority will give a small fixed insertion
time, but will require an exhaustive search in order to calculate
maximum priority. Doing so in priority order will require an
average of #mutex_owned / 2 for the insertion, and gives a fixed
time for maximum priority calculation. The latter appears to offer
a performance benefit to the degree the incoming priorities are
random.

> The other concern with PI is that most likely PI should be prohibited 
> for utilization with locks which are used in the way similar to 
> "waiting completition" - i.e. if PI is employed on a mutex it is 
> prohibited to release it if a process is not the owner of the mutex.

Yes, that type of usage breaks the notion of ownership.
It would be a error for a task to attempt relinquishing
a mutex which it had not acquired and was holding at the
time of unlock.

>> http://developer.osdl.org/dev/robustmutexes
>
>
> It is definitly non-trivial work to adapt this approach - there are a 
> lot of issues.

I should have qualified that reference. Those folks are
addressing more than PI mutexes. Indeed their goal is
support of fast user mutexes which offer detection of mutex
owners gone astray (exited, killed, etc..). It is the kernel
component of the work to which I was referring.

-john


-- 
john.cooper@timesys.com

