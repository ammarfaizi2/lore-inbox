Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVBAEz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVBAEz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVBAEz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:55:26 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:28379 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261542AbVBAEzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:55:11 -0500
Message-ID: <41FF0BEE.7080106@kolivas.org>
Date: Tue, 01 Feb 2005 15:56:14 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>	<41FE9582.7090003@kolivas.org> <87651di55a.fsf@sulphur.joq.us>	<41FEB8BA.7000106@kolivas.org> <87fz0hf20z.fsf@sulphur.joq.us>	<41FEED69.9060904@kolivas.org> <87u0owc2iy.fsf@sulphur.joq.us>
In-Reply-To: <87u0owc2iy.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> 
> 
>>Good work. Looks like you're probably right about the accounting. It
>>may be as simple as the fact that it is on the timer tick that we're
>>getting rescheduled and this ends up being accounted as more since the
>>accounting happens only at the scheduler tick. A test run setting
>>iso_cpu at 100% should tell you if it's accounting related - however
>>the RLIMIT_RT_CPU patch is accounted in a similar way so I'm not sure
>>there isn't another bug hanging around. 
> 
> 
>>I'm afraid on my hardware it has been behaving just like SCHED_FIFO
>>for some time which is why I've been hanging on your results. 
> 
> 
> My guess is that most of this test fits inside that huge cache of
> yours, making it run much faster than on my system.  You probably need
> to increase the number of clients to get comparable results.

Bah increasing the clients from 14 to 20 the script just fails in some 
meaningless way

Killed
[con@laptop jack_test4.1]$ [1/1] jack_test4_client (17/20) stopped.
[1/1] jack_test4_client (18/20) stopped.
./run.sh: line 153:  7504 Broken pipe             ${CMD} >>${LOG} 2>&1
[1/1] jack_test4_client ( 2/20) stopped.
./run.sh: line 153:  7507 Broken pipe             ${CMD} >>${LOG} 2>&1

even before it starts :(

> 
> When you say just like SCHED_FIFO, do you mean completely clean?  Or
> are you still getting unexplained xruns?  If that's the case, we need
> to figure out why and eliminate them.

On my P4 with the results I posted I am getting no xruns whatsoever with 
either SCHED_FIFO or ISO. As for the pentiumM I've given up trying to 
use that for latency runs since even with everything shut down and the 
file system with journal off running SCHED_FIFO I get 8ms peaks every 20 
seconds. I'll keep blaming reiserfs for that one. Only dropping to 
single user mode and unmounting filesystems can get rid of them.

> The reason I can measure an effect here is that the test is heavy
> enough to stress my system and the system is RT-clean enough for
> SCHED_FIFO to work properly.  (That's no surprise, I've been running
> it that way for years.)

Yeah I understand. I'm kinda stuck with hardware that either doesn't 
have a problem, or an installation too flawed to use.

> It did work better.  On the first run, there were a couple of real bad
> xruns starting up.  But, the other two runs look fairly clean.
> 
>   http://www.joq.us/jack/benchmarks/sched-iso-fix.100
> 
> With a compile running, bad xruns and really long delays become a
> serious problem again.
> 
>   http://www.joq.us/jack/benchmarks/sched-iso-fix.100+compile
> 
> Comparing the summary statistics with the 90% run, suggests that the
> same problems occur in both cases, but not as often at 100%.
> 
>   http://www.joq.us/jack/benchmarks/.SUMMARY
> 
> With these latency demands, the system can't ever pick the wrong
> thread on exit from even a single interrupt, or we're screwed.  I am
> pretty well convinced this is not happening reliably (except with
> SCHED_FIFO).

Looking at the code I see some bias towards keeping the cpu count too 
high (it decays too slowly) but your results confirm a bigger problem 
definitely exists. At 100% it should behave the same as SCHED_FIFO 
without mlock, and it is not in your test. I simply need to look at my 
code harder.

Cheers,
Con

