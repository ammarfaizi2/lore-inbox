Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWAGXbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWAGXbX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWAGXbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:31:23 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:17560 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161056AbWAGXbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:31:21 -0500
Message-ID: <43C04F47.7000002@bigpond.net.au>
Date: Sun, 08 Jan 2006 10:31:19 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client    on interactive
 response
References: <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net> <200601072030.59445.kernel@kolivas.org>
In-Reply-To: <200601072030.59445.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 7 Jan 2006 23:31:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 07 January 2006 16:27, Mike Galbraith wrote:
> 
>>>  Personally, I think that all TASK_UNINTERRUPTIBLE sleeps should be
>>>treated as non interactive rather than just be heavily discounted (and
>>>that TASK_NONINTERACTIVE shouldn't be needed in conjunction with it) BUT
>>>I may be wrong especially w.r.t. media streamers such as audio and video
>>>players and the mechanisms they use to do sleeps between cpu bursts.
>>
>>Try it, you won't like it.  When I first examined sleep_avg woes, my
>>reaction was to nuke uninterruptible sleep too... boy did that ever _suck_
>>:)
> 
> 
> Glad you've seen why I put the uninterruptible sleep logic in there. In 
> essence this is why the NFS client interactive case is not as nice - the NFS 
> code doesn't do "work on behalf of" a cpu hog with the TASK_UNINTERRUPTIBLE 
> state. The uninterruptible sleep detection logic made a massive difference to 
> interactivity when cpu bound tasks do disk I/O.

TASK_NONINTERACTIVE doesn't mean that the task is a CPU hog.  It just 
means that this sleep should be ignored as far as determining whether 
this task is interactive or not.

Also, compensation for uninterruptible sleeps should be handled by the 
"fairness" mechanism (i.e. time slices and the active/expired arrays) 
not the "interactive response" mechanism.  In other words, doing a lot 
of uninterruptible sleeps is (theoretically) not a sign that the task is 
interactive or for that matter that it's non interactive so 
(theoretically) should just be ignored.  That bad things happen when it 
isn't needs explaining.

I see two possible reasons:

1. Audio/video streamers aren't really interactive but we want to treat 
them as such (to ensure they have low latency).  The fact that they 
aren't really interactive may mean that the sleeps they do between runs 
are uninterruptible and if we don't count uninterruptible sleep we'll 
miss them.

2. The X server isn't really a completely interactive program either. 
It handles a lot of interactive on behalf of interactive programs (which 
should involve interactive sleeps and help get it classified as 
interactive) but also does a lot of non interactive stuff (which can be 
CPU intensive and make it loose points due to CPU hoggishness) which 
probably involves uninterruptible sleep.  The combination of ignoring 
the uninterruptible sleep and the occasional high CPU usage rate could 
result in losing too much bonus with consequent poor interactive 
responsiveness.

So it would be interesting to know which programs suffered badly when 
uninterruptible sleep was ignored?  This may enable an alternate 
solution to be found.

In any case and in the meantime, perhaps the solution is to use 
TASK_NONINTERACTIVE where needed but treat 
TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE sleep the same as 
TASK_UNINTERRUPTIBLE sleep instead of ignoring it?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
