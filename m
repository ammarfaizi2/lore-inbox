Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270497AbTHGVkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270929AbTHGVkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:40:47 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:15318 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S270497AbTHGVkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:40:37 -0400
Message-ID: <3F32C752.4000403@wmich.edu>
Date: Thu, 07 Aug 2003 17:40:34 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: Daniel Phillips <phillips@arcor.de>, Eugene Teo <eugene.teo@eugeneteo.net>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308061728.04447.rob@landley.net> <200308071642.55517.phillips@arcor.de> <200308071651.07522.rob@landley.net>
In-Reply-To: <200308071651.07522.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Thursday 07 August 2003 11:42, Daniel Phillips wrote:
> 
>>On Wednesday 06 August 2003 22:28, Rob Landley wrote:
>>
>>>So, how does SCHED_SOFTRR fail?  Theoretically there is a minimum
>>>timeslice you can hand out, yes?  And an upper bound on scheduling
>>>latency.  So logically, there is some maximum number "N" of SCHED_SOFTRR
>>>tasks running at once where you wind up round-robining with minimal
>>>timeslices and the system is saturated.  At N+1, you fall over.  (And in
>>>reality, there are interrupts and kernel threads and other things going
>>>on that get kind of cramped somewhere below N.)
>>
>>The upper bound for softrr realtime scheduling isn't based on number of
>>tasks, it's a global slice of cpu time: so long as the sum of running times
>>of all softrr tasks in the system lies below limit, softrr tasks will be
>>scheduled as SCHED_RR, otherwise they will be SCHED_NORMAL.
> 
> 
> I thought one of the advantages here was that a userspace program could give 
> hints about whether the scheduler should optimize it for latency or for 
> throughput, without having to be root.
> 
> XFree86 and Konqueror Xterm and Kmail could all say "latency in me is end-user 
> visible, so I care more about latency than throughput".  And stuff like the 
> nightly cron job that exists just to screw up my desktop because I AM awake 
> at 4 am a noticeable percentage of the time...  Anyway, it cares about 
> throughput and not at all about latency.  Same with just about any invocation 
> of gcc, so they'd never set the flags.

cron is user setable. Just set it to work at a time you aren't there.

> If Bash really wanted to get fancy, it could set the flag depending on whether 
> the process on the other end of its input PTY had the flag or not, but let's 
> worry about that later... :
> 
> 
>>>In theory, the real benefit of SCHED_SOFTRR is that an attempt to switch
>>>to it can fail with -EMYBRAINISMELTING up front, so you know when it
>>>won't work at the start, rather than having it glitch halfway through the
>>>run.
>>
>>Not as implemented.  Anyway, from the user's point of view, that would be
>>an unpleasant way for a sound player to fail.  What we want is something
>>more like a little red light that comes on (in the form of error
>>statistics, say) any time a softrr process gets demoted.  Granted, there
>>may be situations where what you want is the right behavior, but it's (as
>>you say) a separate issue of resource allocation.
> 
> 
> Uh-huh.
> 
> So with SCHED_SOFTRR, if the system gets heavily loaded enough later on then 
> the SOFTRR tasks can get demoted and start skipping.  So we're back to having 
> a system where cron had better not start up while you're mixing sound because 
> it might put you over the edge.

Again, cron is not something inevitable that you cant control. If you're 
mixing sound, dont run cron at times where it can interfere with your 
work. Cron is a throughput intensive process.  Complaining about 
processes like cron is like complaining about how your audio is skipping 
while running hdparm -t on the drive or dbench.


> I fail to see how this is an improvement on Con's "carpet bomb the problem 
> with heuristics out the wazoo" approach?  (I like heuristcs.  They're like 
> Duct Tape.  I like Duct Tape.

> 
>>Regards,
>>
>>Daniel
> 
> 
> Rob
> 

the problem is you want a process that works like it was run on a single 
tasking OS on an operating system that is built from the ground up to be 
  a multi-user multi-tasking OS and you want both to work perfectly at 
peak performance and you want it to know when you want which to work at 
peak performance automatically.

Duct tape cant do that, because just about nothing can. You're gonna 
have to make some effort as a user to do the job because short of 
artificial intelligence, the schedular is never going to be good enough 
for everyone to always be happy with heuristics or not.

Tune and optimize the schedular to handle problems with latency within 
like-processes and throughput within like-processes and allow priority 
levels to take care of how they work together. There is always room to 
optimize the code without changing what it eventually does too, in that 
way the schedular can be improved without exchanging it for something 
else whenever a problem occurs or allowing it to be directed by a 
specific group of loud users and set of userspace programs.

I'd just like to see less complication because less is faster and faster 
means less overhead in kernel time.  If i have to do some of the work 
that a bloated artificially intelligent schedular will do then i'm more 
than happy to because that system is going to be able to scale much 
better than something with complicated scheduling as the number of 
processes increases.

