Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUDFTZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 15:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUDFTZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 15:25:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20419 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263975AbUDFTZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 15:25:33 -0400
Date: Tue, 6 Apr 2004 21:25:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406192549.GA14869@elte.hu>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406155925.GW2234@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> I will use the HINT to measure the slowdown on HZ=1000. It's an
> optimal benchmark simulating userspace load at various cache sizes and
> it's somewhat realistic.

here are the INT results from the HINT benchmark (best of 3 runs):

 1000Hz, 3:1, PAE:    25513978.295333 net QUIPs
 1000Hz, 4:4, PAE:    25515998.582834 net QUIPs

i.e. the two kernels are equal in performance. (the noise of the
benchmark was around ~0.5% so this 0.01% win of 4:4 is a draw.) This is
not unexpected, the benchmark is too noisy to notice the 0.22% maximum
possible 4:4 hit.

> Also note that the slowdown for app calling heavily syscalls is 30%
> not 5-10%, [...]

you are right that it's not 5-10%, it's more like 5-15%. It's not 30%,
except in the mentioned case of heavily threaded MySQL benchmark, and in
microbenchmarks. (the microbenchmark case is understandable, 4:4 adds +3
usecs on PAE and +1 usec on non-PAE.)

i've just re-measured a couple of workloads that are very kernel and
syscall intensive, to get a feel for the worst-case:

 apache tested via 'ab':      5% slowdown
 dbench:                     10% slowdown
 tbench:                     16% slowdown

these would be the ones where i'd expect to see the biggest slowdown,
these are dominated by kernel overhead and do alot of small syscalls. 
(all these tests fully saturated the CPU.)

you should also consider that while 4:4 does introduce extra TLB
flushes, it also removes the TLB flush at context-switch. So for
context-switch intensive workloads the 4:4 overhead will be smaller. (in
some rare and atypical cases it might even be a speedup - e.g. NFS
servers driven by knfsd.) This is why e.g. lat_ctx is 4.15 with 3:1, and
it's 4.85 with 4:4, a 16% slowdown only - in contrast to lat_syscall
null, which is 0.7 usecs in the 3:1 case vs. 3.9 usecs in the 4:4 case.

But judging by your present attitude i'm sure you'll be able to find
worse performing testcases and will use them as the typical slowdown
number to quote from that point on ;) Good luck in your search.

here's the 4:4 overhead for some other workloads:

 kernel compilation (30% kernel overhead):      2% slowdown
 pure userspace code:                           0% slowdown
 
anyway, i can only repeat what i said last year in the announcement
email of the 4:4 feature:

   the typical cost of 4G/4G on typical x86 servers is +3 usecs of
   syscall latency (this is in addition to the ~1 usec null syscall
   latency). Depending on the workload this can cause a typical
   measurable wall-clock overhead from 0% to 30%, for typical
   application workloads (DB workload, networking workload, etc.).
   Isolated microbenchmarks can show a bigger slowdown as well - due to
   the syscall latency increase.

so it's not like there's a cat in the bag.
 
the cost of 4:4, just like the cost of any other kernel feature that
impacts performance (like e.g. PAE, highmem or swapping) should be
considered in light of the actual workload. 4:4 is definitely not an
'always good' feature - i never claimed it was. It is an enabler feature
for very large RAM systems, and it gives 3.98 GB of VM to userspace. It
is a slowdown for anything that doesnt need these features.

But for pure userspace code (which started this discussion), where
userspace overhead dominates by far, the cost is negligible even with
1000Hz.

	Ingo
