Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbUC3JF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUC3JF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:05:58 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:7581 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263538AbUC3JFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:05:34 -0500
Message-ID: <4069384B.9070108@yahoo.com.au>
Date: Tue, 30 Mar 2004 19:05:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kernel@kolivas.org, rusty@rustcorp.com.au,
       anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325214815.GA19060@elte.hu> <23100000.1080253728@flay> <200403300030.25734.efocht@hpce.nec.com>
In-Reply-To: <200403300030.25734.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please use piggin@yahoo.com.au)

Erich Focht wrote:

>On Thursday 25 March 2004 23:28, Martin J. Bligh wrote:
>
>>Can we hold off on changing the fork/exec time balancing until we've
>>come to a plan as to what should actually be done with it? Unless we're
>>giving it some hint from userspace, it's frigging hard to be sure if
>>it's going to exec or not - and the vast majority of things do.
>>
>
>After more than a year (or two?) of discussions there's no better idea
>yet than giving a userspace hint. Default should be to balance at
>exec(), and maybe use a syscall for saying: balance all children a
>particular process is going to fork/clone at creation time. Everybody
>reached the insight that we can't foresee what's optimal, so there is
>only one solution: control the behavior. Give the user a tool to
>improve the performance. Just a small inheritable variable in the task
>structure is enough. Whether you give the hint at or before run-time
>or even at compile-time is not really the point...
>
>I don't think it's worth to wait and hope that somebody shows up with
>a magic algorithm which balances every kind of job optimally.
>
>

I'm with Martin here, we are just about to merge all this
sched-domains stuff. So we should at least wait until after
that. And of course, *nothing* gets changed without at least
one benchmark that shows it improves something. So far
nobody has come up to the plate with that.

>>There was a really good reason why the code is currently set up that
>>way, it's not some random accident ;-)
>>
>
>The current code isn't a result of a big optimization effort, it's the
>result of stripping stuff down to something which was acceptable at
>all in the 2.6 feature freeze phase such that we get at least _some_
>NUMA scheduler infrastructure. It was clear right from the beginning
>that it has to be extended to really become useful.
>
>
>>Clone is a much more interesting case, though at the time, I consciously
>>decided NOT to do that, as we really mostly want threads on the same
>>node.
>>
>
>That is not true in the case of HPC applications. And if someone uses
>OpenMP he is just doing that kind of stuff. I consider STREAM a good
>benchmark because it shows exactly the problem of HPC applications:
>they need a lot of memory bandwidth, they don't run in cache and the
>tasks live really long. Spreading those tasks across the nodes gives
>me more bandwidth per task and I accumulate the positive effect
>because the tasks run for hours or days. It's a simple and clear case
>where the scheduler should be improved.
>
>Benchmarks simulating "user work" like SPECsdet, kernel compile, AIM7
>are not relevant for HPC. In a compute center it actually doesn't
>matter much whether some shell command returns 10% faster, it just
>shouldn't disturb my super simulation code for which I bought an
>expensive NUMA box.
>
>

There are other things, like java, ervers, etc that use threads.
The point is that we have never had this before, and nobody
(until now) has been asking for it. And there are as yet no
convincing benchmarks that even show best case improvements. And
it could very easily have some bad cases. And finally, HPC
applications are the very ones that should be using CPU
affinities because they are usually tuned quite tightly to the
specific architecture.

Let's just make sure we don't change defaults without any
reason...

