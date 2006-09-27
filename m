Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031155AbWI0Wc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031155AbWI0Wc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031156AbWI0Wc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:32:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1031155AbWI0WcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:32:25 -0400
Message-ID: <451AFBE5.9000008@redhat.com>
Date: Wed, 27 Sep 2006 17:32:05 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Athlon64x2 problem with 2.6.18-rt4 and hrtimers
References: <451ADF7A.8070709@redhat.com> <1159394364.9326.560.camel@localhost.localdomain>
In-Reply-To: <1159394364.9326.560.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas Gleixner wrote:
> Clark,
> 
> On Wed, 2006-09-27 at 15:30 -0500, Clark Williams wrote:
>> What I've been seeing were some very long latencies while running
>> cyclictimer (v0.1 thru v0.9). The test would start up and run with quite
>> good numbers for a few thousand iterations, then really large latencies
>> would start to occur (between 5000 and 30000 us). I have not dumped the
>> stats to a file and done any statistical analysis as to how frequent the
>> large latencies are, nor whether they're trending up or down.
> 
> Would be interesting to see.

I'll email you two files of 30k loops each, one from cpu0 and the other
bound to cpu1. Command line will look like this:

$ sudo taskset 0x1 cyclictest --prio=1 --loops=30000 --verbose >cpu0.out
$ sudo taskset 0x2 cyclictest --prio=1 --loops=30000 --verbose >cpu1.out

> 
>> I had a suspicion that it involved signal delivery because of the following:
>>
>> $ sudo ./cyclictest32 --prio=1
>> 0.01 0.03 0.01 1/151 3486
>>
>> T: 0 ( 3484) P: 1 I:    1000 C:    8955 Min:      10 Act:   38011 Avg:
>>  20919 Max:   38445
>> $ sudo ./cyclictest32 --prio=1 --nanosleep
>> 0.01 0.03 0.00 1/151 3490
>>
>> T: 0 ( 3488) P: 1 I:    1000 C:   12995 Min:       6 Act:       7 Avg:
>>      6 Max:      31
>>
>> As you can see, the Avg and Max times stay quite low when using
>> nanosleep; the latencies only happen when using itimers.
> 
> Also can you run a test with prio=80, if there is any difference ?

No difference (wouldn't expect there to be).

> 
>> I was describing this behavior when DJ Delorie suggested that it might
>> be affinity based rather than signal delivery. He suggested binding the
>> test to a particular processor, so I did with the following results:
>>
>> $ sudo taskset 0x1 ./cyclictest32 --prio=1
>> 0.11 0.07 0.08 1/149 3311
>>
>> T: 0 ( 3305) P: 1 I:    1000 C:   45709 Min:       8 Act:      11 Avg:
>>     10 Max:      53
>> $ sudo taskset 0x2 ./cyclictest32 --prio=1
>> 0.03 0.05 0.08 1/149 3323
>>
>> T: 0 ( 3313) P: 1 I:    1000 C:   74451 Min:      10 Act:   58011 Avg:
>>  28976 Max:   58818
>>
>> So it seems that the latencies only occur on processor 1 (not on
>> processor 0).  I booted 2.6.18-rt4 with and without idle=poll (as Ingo
>> suggested) and saw the long latencies in both cases when the test was
>> bound to processor 1 (never with processor 0).
> 
> Hmm. 

Took the words right out of my mouth :)

> 
>> Hopefully this is useful information. I just wanted to let you guys
>> know, since you'll probably have a fix available long before I can
>> comprehend the arch/x86_64 code where this probably occurs.  Let me know
>> if you want other things, like the .config or something else.
> 
> Can you please switch on CONFIG_LATENCY_TRACE (depends on
> CONFIG_LATENCY_TIMING) ?
> 
> Use the latest version of cyclictest and add -b XXX to the command line,
> where XXX is the maximum latency in micro seconds. Once the latency is
> greater than the given maximum, the kernel tracer and cyclictest is
> stopped.
> 
> Now you can read the kernel trace:
> 
> cat /proc/latency_trace >trace.log 
> 
> The trace should give us more insight.
> 
> Please be aware that the tracer adds significant overhead to the kernel,
> so the latencies will be much higher.
> 

Yeah, I've used the latency tracer before.  I'll do this in the morning
when I get in.

Thanks,

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFGvvlHyuj/+TTEp0RAndeAKCPoB1H/ladkOw9e9/wXgptBlw+VwCfS4Ws
ey7tUDjYiEdvgqKTbIAp410=
=Exvn
-----END PGP SIGNATURE-----
