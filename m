Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSJNQEG>; Mon, 14 Oct 2002 12:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSJNQEF>; Mon, 14 Oct 2002 12:04:05 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:47808 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261836AbSJNQED> convert rfc822-to-8bit; Mon, 14 Oct 2002 12:04:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: NUMA schedulers tests
Date: Mon, 14 Oct 2002 10:57:42 -0500
X-Mailer: KMail [version 1.4]
Cc: "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200210131317.35544.efocht@ess.nec.de>
In-Reply-To: <200210131317.35544.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210141057.42937.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 October 2002 6:17 am, Erich Focht wrote:
> Hi,
>
<snip>
>
> Schedulers tested (all on top of discontigmem for ia64):
>
> A: vanilla O(1) scheduler from 2.5.39
> B: Michael Hohnbaums simple NUMA scheduler (latest published rev 2)
> C: pooling NUMA scheduler with initial load balancing (patches 01+02
>    from the 5 patches sent out)
> D: node affine NUMA scheduler (patches 01+02+03)
> E: node affine NUMA scheduler with dynamic homenode (patches 01+02+03+05)
>
> All results are averages over several measurements, the numbers in braces
> are the standard deviation or "error bars".
>
> There's a lot to say about the results, e.g that E is the best because it
> has most features. But the only comment I really want to make on this now
> is: the numa_test is not good enough for testing node affinity as
> "hackbench 20" doesn't seem to disturb the initially balance too much.
> I'll improve this to make it more realistic. Otherwise it's good enough
> to see the advantage of not moving around tasks across the nodes.

Thanks very much for doing this Erich.  I have run the SPEC SDET benchmark on 
2.5.41-mm3, with your "E" scheduler, and Michael's rev 1 & 2 scheduler.  At 
this time I don't think I can publish actual throughput results, but only % 
differences, to abide by SPEC rules.  These results are not considered 
compliant by SPEC, and are used only to compare performance difference of 
these scheduler implementations.

SDET simulates the multiuser development environment, and may be useful for 
environments like universities, etc.   More information can be found at: 
http://www.spec.org/osg/sdm91/

SDET was configured to simulate 1, 2, 4, 8, 16, 32, 64 and 128 users.  SDET 
appears to benefit from spreading out exec'd processes on initial placement, 
but there also exists scenarios where exec'd tasks should reside on the same 
node.  Ideally, each of the scripts run in parallel would benefit from being 
initially spread out across the nodes, but the processes exec'd _within_ each 
script would benefit from being placed within the node.  I don't expect any 
scheduler to to identify and optimize for that today, but maybe that's 
something to work on in the future, who knows?   

Anyway, on to the results.  Almost forgot, this is on a 16 way NUMA-Q box.  
These results are not actual results, but normalized to a baseline for 
2.5.41-mm3 for 1 user:

1 user
vanilla	100
erich-E	062
michael-r1	103
michael-r2  065

2 users
vanilla	191
erich-E	112
michael-r1	180
michael-r2	116

4 users
vanilla	288
erich-E	213
michael-r1	306
michael-r2	208

8 users
vanilla	426
erich-E	336
michael-r1	405
michael-r2	333

16 users
vanilla	462
erich-E	412
michael-r1	464
michael-r2	427

32 users
vanilla	438
erich-E	425
michael-r1	436
michael-r2	332

64 users
vanilla	420
erich-E	410
michael-r1	430
michael-r2	432

128 users
vanilla	413
erich-E	397
michael-r1	413
michael-r2	398


In Michael's rev 1, initial placement of an exec'd task would be on the same 
CPU if nr_running <=2, (sched_best_cpu) which I believe why the low loaded 
tests perform better.  This is where I believe the tasks within a script are 
getting scheduled on the same CPU/node and benefit from locality.  Erich's 
and Michael's rev2 place the newly exec'd task on the least loaded cpu, which 
tends to spread those tasks exec'd within a script across nodes and hurt 
thoughput in those cases.  In the higher load cases, most of the results 
appear similar.  

Anyway, I used SDET to give yet another view of how these schedulers can 
affect performance.  At this point I personally do not have a preference on 
which scheduler one to use.  I'd like to hear from people who have made BIG 
changes to the scheduler (hint, hint) what they think of these 
implementations, and where we should go from here.  We should probably decide 
which implementation to use, and what we need to do to make it ready for 
inclusion, right?

Andrew Theurer

