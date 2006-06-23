Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWFWUAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWFWUAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWFWUAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:00:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15253 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752008AbWFWUAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:00:37 -0400
Message-ID: <449C4865.7040706@engr.sgi.com>
Date: Fri, 23 Jun 2006 13:00:37 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com> <44999A98.8030406@engr.sgi.com> <44999F5A.2080809@watson.ibm.com> <4499D7CD.1020303@engr.sgi.com> <449C2181.6000007@watson.ibm.com> <449C30C1.6090802@engr.sgi.com> <449C3897.70001@watson.ibm.com>
In-Reply-To: <449C3897.70001@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
>Jay Lan wrote:
>  
>>Shailabh Nagar wrote:
>>
>>    
>>>Hi Andrew,
>>>
>>>Two developments on the tgid overhead issue:
>>>
>>>1. The latest results show that overhead is significant
>>>only when the exit rate exceeds roughly 1000 threads/second.
>>>
>>>      
>>I worked with Shailabh this week to run various testing and
>>debugging as he requested. I was pulled off to some urgent
>>task yesterday and surprising saw this coming this morning...
>>    
>
>Sorry...didn't mean to surprise. I sent you the data last night
>privately with request for comments.
>  

Yeah, i saw it, but did not have time to respond before your posting.

>Your testing and help has been very valuable and helped uncover
>two issues: the locking patch (sent separately) and also a
>dependency between taskstats and delay accounting (for which another
>patch is being sent out shortly).
>
>  
>>Let's slow it down please. My last testing (after your fix in
>>#2 below) still showed 109% overhead at system time. 
>>    
>
>True, but my point is that the overhead is at an extremely
>high exit rate. I think the test in which you saw 109% overhead
>ran 5000 iterations of 1000 threads and had an elapsed time of
>294 seconds (with tgid turned off) giving an exit rate of roughly
>8500 exits/second, right ?
>
>My results confirm the high overhead at these exit rates. In fact,
>on the system I used, I see the 649% overhead for the 2200 exits/second case
>even higher than yours) but the point is whether that exit rate
>is a valid design criteria.
>  

Agreed. The indeed the deciding factor. The exit rate in the labs
does not help answer this question. I need input from our fields.

>  
>>And, the per-thread group processing also increase the rate of ENOBUFS
>>at the receiver.
>>    
>
>Could you quantify please ? Also, pls list the exit rate at which
>this happens.
>  

I have not posted it nor quantify it because i must bring down the errors
count, or we (CSA) have to explore a different way. So any comparison
on these number at this point does not really help. Again, if the exit rate
is unrealistic, then i need to run a different set of testings. What
sleep_factor did you use? Are those printf() in your new test program
essential?

>  
>>I need to check with other guys to find out if 1000 threads/sec
>>indeed unrealistic at our customers' environments. A good
>>design should allow a mechanism to turn off the penalty due to
>>a feature that is not common to everybody. I do not understand
>>your objection.
>>    
>
>Only objection is that design shouldn't cater to a case that is
>extremely unlikely in practice. In most situations, there is no
>or insignificant penalty.
>  

If this type of exit rate can happen even once a day, the surge may cause
loss of accounting data of other processes. Again, i do not have data
to say either way yet. But i would rather spend time on working on
the ENOBUFS error than running all different tests to argue on the
per-TG switch.

Regards,
 - jay

>Perhaps others on the list can also chip in whether this kind of exit
>rate is realistic in some scenarios and where the peformance
>penalty matters (i.e. not system shutdown etc.)
>
>Please note that the exits have to be for multithreaded apps, not
>single-threaded ones for which tgid sending is already turned off.
>
>Thanks,
>Shailabh
>
>  
>>Regards,
>> - jay
>>
>>
>>    
>>>2. A new patch that modifies the locking used within taskstats,
>>>brings down the overhead of the extreme case quite a bit.
>>>I'll submit the patch along shortly in a separate mail.
>>>
>>>To get back to the effect of exit rate, I modified the fork+exit
>>>benchmark to vary the rate at which exits happened and
>>>ran tests on a 4-way 1.4 GHz x86_64 box. The kernel was 2.6.17,
>>>uses the delay accounting/taskstat patches in 2.6.17-mm1 + the new
>>>locking patch mentioned in 2. above.
>>>
>>>The results show that differential between tgid on and off
>>>starts becoming significant once the exit rate crosses roughly 1000
>>>threads/second. Below that exit rate, the difference is negligible.
>>>Above it, the difference starts climbing rapidly.
>>>
>>>So I guess the question is whether this rate of exit is representative
>>>enough of real life to warrant making any more changes to the existing
>>>patchset, beyond the locking changes in 2. above.
>>>
>>>>From my limited experience, I think this is too high an exit rate
>>>to be worrying about overhead.
>>>
>>>
>>>      %ovhd of tgid on over off
>>>      (higher is worse)
>>>
>>>Exit     User     Sys     Elapsed
>>>Rate     Time     Time    Time
>>>
>>>2283      25.76  649.41   -0.14
>>>1193     -10.53   88.81   -0.12
>>>963      -11.90    3.28   -0.10
>>>806       -8.54   -0.84    0.16
>>>694       -4.41    2.38    0.03
>>>
>>>Exit Rate: units are threads exiting per second.
>>>Calculated by (#threads_forked+exited)/(elapsed_time)/2
>>>Since app pretty much does only thread create and exit for 10000
>>>threads (1000 threads, 10 iterations), this is a good measure
>>>for exit rate.
>>>
>>>%diff in user, sys, elapsed times calculated using
>>>(tgid_on - tgid_off)/tgid_off * 100
>>>where tgid_on/off times are reported by /usr/bin/time as before.
>>>
>>>Each data point for tgid_on and tgid_off was an average
>>>of 10 runs of the fork+exit benchmark.
>>>The rate of exits was controlled by delaying the individual
>>>threads through a usleep before being allowed to exit.
>>>
>>>Machine was 4-way 1.6GHz x86_64 Opteron.
>>>
>>>"exit_recv -w", the user program consuming the stats, was running
>>>on the side, reading the stats but not writing to a file or
>>>printing to screen.
>>>
>>>      
>>    
>
>  

