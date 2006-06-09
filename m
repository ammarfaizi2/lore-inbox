Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWFIA6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWFIA6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWFIA6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:58:20 -0400
Received: from alt.aurema.com ([203.217.18.57]:3093 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S965070AbWFIA6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:58:19 -0400
Message-ID: <4488C765.2050108@aurema.com>
Date: Fri, 09 Jun 2006 10:57:09 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Kirill Korotaev <dev@openvz.org>, Srivatsa <vatsa@in.ibm.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest>	<448688B2.2030206@jp.fujitsu.com> <4487D6B0.3080502@bigpond.net.au>
In-Reply-To: <4487D6B0.3080502@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> WARNING: This e-mail has been altered to remove unsafe attachments
> and or a potential virus.
> 
> These attachments will be scrutinized by the System Administrators
> and if found to be safe forwarded to the recipient.
> 
> For more information please see the System Administrators
> <sam-members@aurema.com> +61 2 9698 2322.
> 
> An attachment named loops.sh was removed from this document as it
> constituted a security hazard.  If you require this document, please contact
> the sender and arrange an alternate means of receiving it.
> 
> 
> An attachment named asps.sh was removed from this document as it
> constituted a security hazard.  If you require this document, please contact
> the sender and arrange an alternate means of receiving it.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> MAEDA Naoaki wrote:
>>
>> I tried to run kernbench with hard cap, and then it spent a very
>> long time on "Cleaning souce tree..." phase. Because this phase
>> is not CPU hog, my expectation is that it act as without cap.
>>
>> That can be reproduced by just running "make clean" on top of a
>> kernel source tree with hard cap.
>>
>> % /usr/bin/time make clean
>> 1.62user 0.29system 0:01.90elapsed 101%CPU (0avgtext+0avgdata 
>> 0maxresident)k
>> 0inputs+0outputs (0major+68539minor)pagefaults 0swaps
>>
>>   # Without cap, it returns almost immediately
>>
>> % ~/withcap.sh  -C 900 /usr/bin/time make clean
>> 1.61user 0.29system 1:26.17elapsed 2%CPU (0avgtext+0avgdata 
>> 0maxresident)k
>> 0inputs+0outputs (0major+68537minor)pagefaults 0swaps
>>
>>   # With 90% hard cap, it takes about 1.5 minutes.
>>
>> % ~/withcap.sh  -C 100 /usr/bin/time make clean
>> 1.64user 0.34system 3:31.48elapsed 0%CPU (0avgtext+0avgdata 
>> 0maxresident)k
>> 0inputs+0outputs (0major+68538minor)pagefaults 0swaps
>>
>>   # It became worse with 10% hard cap.
>>
>> % ~/withcap.sh  -c 900 /usr/bin/time make clean
>> 1.63user 0.28system 0:01.89elapsed 100%CPU (0avgtext+0avgdata 
>> 0maxresident)k
>> 0inputs+0outputs (0major+68537minor)pagefaults 0swaps
>>
>>   # It doesn't happen with soft cap.
> 
> This behaviour is caused by the "make clean" being a short lived CPU 
> intensive task.  It was made worse by the facts that my simplifications 
> to the sinbin duration calculation which assumed a constant CPU burst 
> size based on the time slice and that exiting tasks could still have 
> caps enforced.  (The simplification was done to avoid 64 bit divides.)
> 
> I've put in a more complex sinbin calculation (and don't think the 64 
> bit divides will matter too much as they're on an infrequently travelled 
> path.  Exiting tasks are now excluded from having caps enforced on the 
> grounds that it's best for system performance to let them get out of the 
> way as soon as possible.  A patch is attached and I would appreciate it 
> if you could see if it improves the situation you are observing.
> 
> These changes don't completely get rid of the phenomenon but I think 
> that it's less severe.  I've written a couple of scripts to test this 
> behaviour using the wload program from:
> 
> <http://prdownloads.sourceforge.net/cpuse/simloads-0.1.1.tar.gz?download>
> 
> You run loop.sh with a single argument and it uses asps.sh.   What the 
> test does is run a number (specified by the argument to loop.sh) of 
> instances of wload in series and uses time to get the stats for the 
> series to complete.  It does these for a number of different durations 
> of wload running between 0.001 and 10.0 seconds.  Here's an example of 
> an output from an uncapped run:
> 
> Peter[peterw@heathwren ~]$ ./loops.sh 1
> -d=0.001: user = 0.01 system = 0.00 elapsed = 0.00 rate = 133%
> -d=0.005: user = 0.01 system = 0.00 elapsed = 0.01 rate = 84%
> -d=0.01: user = 0.02 system = 0.00 elapsed = 0.01 rate = 105%
> -d=0.05: user = 0.06 system = 0.00 elapsed = 0.05 rate = 103%
> -d=0.1: user = 0.10 system = 0.00 elapsed = 0.11 rate = 98%
> -d=0.5: user = 0.50 system = 0.00 elapsed = 0.50 rate = 100%
> -d=1.0: user = 1.00 system = 0.00 elapsed = 1.01 rate = 99%
> -d=5.0: user = 5.00 system = 0.00 elapsed = 5.01 rate = 99%
> -d=10.0: user = 10.00 system = 0.00 elapsed = 10.01 rate = 99%
> 
> and with a cap of 90%:
> 
> [peterw@heathwren ~]$ withcap -C 900 ./loops.sh 1
> -d=0.001: user = 0.00 system = 0.00 elapsed = 0.01 rate = 53%
> -d=0.005: user = 0.01 system = 0.00 elapsed = 0.02 rate = 61%
> -d=0.01: user = 0.01 system = 0.00 elapsed = 0.03 rate = 66%
> -d=0.05: user = 0.06 system = 0.00 elapsed = 0.07 rate = 85%
> -d=0.1: user = 0.10 system = 0.00 elapsed = 0.11 rate = 91%
> -d=0.5: user = 0.50 system = 0.00 elapsed = 0.56 rate = 90%
> -d=1.0: user = 1.00 system = 0.00 elapsed = 1.11 rate = 90%
> -d=5.0: user = 5.00 system = 0.00 elapsed = 5.54 rate = 90%
> -d=10.0: user = 10.00 system = 0.00 elapsed = 11.14 rate = 89%
> 
> Notice how the tasks' usage rates get closer to the cap the longer the 
> task runs and never exceeds the cap.  With smaller caps the effect is 
> different e.g. for a 9% cap we get:
> 
> [peterw@heathwren ~]$ withcap -C 90 ./loops.sh 1
> -d=0.001: user = 0.00 system = 0.00 elapsed = 0.01 rate = 109%
> -d=0.005: user = 0.01 system = 0.00 elapsed = 0.02 rate = 59%
> -d=0.01: user = 0.02 system = 0.00 elapsed = 0.05 rate = 35%
> -d=0.05: user = 0.05 system = 0.00 elapsed = 0.14 rate = 42%
> -d=0.1: user = 0.10 system = 0.00 elapsed = 0.25 rate = 43%
> -d=0.5: user = 0.50 system = 0.00 elapsed = 1.87 rate = 27%
> -d=1.0: user = 1.00 system = 0.00 elapsed = 5.37 rate = 18%
> -d=5.0: user = 5.00 system = 0.00 elapsed = 48.61 rate = 10%
> -d=10.0: user = 10.00 system = 0.00 elapsed = 102.22 rate = 9%
> 
> and short lived tasks are being under capped.
> 
> Bearing in mind that -d=0.01 is equivalent of a task running for just a 
> single tick and that that's about the shortest cycle length we're likely 
> to see for CPU intensive tasks (and then only when the capping 
> enforcement kicks) I think it is unrealistic to expect much better for 
> tasks with a life shorter than that.  Further it takes several cycles to 
> gather reasonable statistics to base capping enforcement so I think that 
> doing much better than this for short lived tasks is unrealistic.
> 
> You could also try using a smaller value for CAP_STATS_OFFSET as this 
> will shorten the half life of the Kalman filters and make the capping 
> react more quickly to changes in usage rates (which is what a task's 
> starting is).  The downside is that it will be less smooth.

I've done some informal testing with smaller values of CAP_STATS_OFFSET 
and there is only a minor improvement.

However, something that does improve behaviour for short lived tasks is 
to increase the value of HZ.  This is because the basic unit of CPU 
allocation by the scheduler is 1/HZ and this is also the minimum time 
(and granularity) with which sinbinning and other capping measures can 
be implemented.  This is the fundamental limiting factor for the 
accuracy of capping i.e. if everything worked perfectly the best 
granularity that can be expected from capping of short lived tasks is 
1000 / (HZ * duration) where duration is in seconds.

For longer living tasks, once the initial phase has passed the half life 
of the Kalman filters takes over from "HZ * duration" in the above 
expression.  Reducing CAP_STATS_OFFSET will shorten the half life of the 
filters and this in turn will make capping coarser.  On the other hand, 
if the half lives are too big then capping will be too slow in reacting 
to changes in a task's CPU usage patterns.  So there's a sweet spot in 
there somewhere.  There's also an upper limit imposed by the likelihood 
of arithmetic overflow during the calculations and this has to consider 
the fact that the average cycle length (one of the metrics) can be quite 
long.  The current values was based on these considerations.

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
