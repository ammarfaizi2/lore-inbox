Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTLNTtr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLNTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 14:49:47 -0500
Received: from qlink.QueensU.CA ([130.15.126.18]:45509 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S262327AbTLNTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 14:49:36 -0500
Subject: Re: HT schedulers' performance on single HT processor
From: Nathan Fredrickson <8nrf@qlink.queensu.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200312130157.36843.kernel@kolivas.org>
References: <200312130157.36843.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1071431363.19011.64.camel@rocky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 14 Dec 2003 14:49:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-12 at 09:57, Con Kolivas wrote:
> I set out to find how the hyper-thread schedulers would affect the all 
> important kernel compile benchmark on machines that most of us are likely to 
> encounter soon. The single processor HT machine.

I ran some further tests since I have access to some SMP systems with HT
(1, 2 and 4 physical processors).

Tested a kernel compile with make -jX vmlinux, where X = 1...16. 
Results are the best real time out of five runs.

Hardware: Xeon HT 2GHz

Test cases:
1phys (uniproc)  - UP test11 kernel with HT disabled in the BIOS
1phys w/HT       - SMP test11 kernel on 1 physical proc with HT enabled
1phys w/HT (w26) - same as above with Nick's w26 sched-rollup patch
1phys w/HT (C1)  - same as above with Ingo's C1 patch
2phys            - SMP test11 kernel on 2 physical proc with HT disabled
2phys w/HT       - SMP test11 kernel on 2 physical proc with HT enabled
2phys w/HT (w26) - same as above with Nick's w26 sched-rollup patch
2phys w/HT (C1)  - same as above with Ingo's C1 patch

I can also run the same on four physical processors if there is
interest.

Here are some of the results.  The units are time in seconds so lower is
better.  The complete results and some graphs are available at:
http://nrf.sortof.com/kbench/test11-kbench.html

             j =   1       2       3       4       8
1phys (uniproc)  305.86  306.07  306.47  306.63  306.69
1phys w/HT       311.70  311.01  267.05  267.16  267.62
1phys w/HT (w26) 311.85  311.58  267.20  267.53  267.76
1phys w/HT (C1)  313.72  312.89  268.16  269.17  268.67
2phys            306.00  305.00  161.15  161.31  161.51
2phys w/HT       309.02  308.36  196.91  151.70  145.80
2phys w/HT (w26) 310.65  309.34  167.16  151.37  145.22
2phys w/HT (C1)  310.86  307.90  162.05  152.16  145.82

Same table as above normalized to the j=1 uniproc case to make
comparisons easier.  Lower is still better.

             j =  1     2     3     4     8
1phys (uniproc)  1.00  1.00  1.00  1.00  1.00
1phys w/HT       1.02  1.02  0.87  0.87  0.87
1phys w/HT (w26) 1.02  1.02  0.87  0.87  0.88
1phys w/HT (C1)  1.03  1.02  0.88  0.88  0.88
2phys            1.00  1.00  0.53  0.53  0.53
2phys w/HT       1.01  1.01  0.64  0.50  0.48
2phys w/HT (w26) 1.02  1.01  0.55  0.49  0.47
2phys w/HT (C1)  1.02  1.01  0.53  0.50  0.48

Con Kolivas wrote:
> I was concerned this might happen and indeed the sequential single threaded 
> compile is slightly worse on both HT schedulers. (1)

My test showed the same (assuming -j1 is the same as omitting the 
option).  The slowdown of the -j1 case with HT is 1-3%.

There was not much benefit from either HT or SMP with j=2.  Maximum
speedup was not realized until j=3 for one physical processor and j=5
for 2 physical processors.  This suggests that j should be set to at
least the number of logical processors + 1.

> (3) There is a very real performance advantage in this benchmark to enabling 
> SMP on a HT cpu. However, in the best case it only amounts to 11%. This means 
> that if a specialised HT scheduler patch gained say 10% it would only amount 
> to 1% overall - hardly an exciting amount. 

Agree, there is certainly an advantage to using HT as long as there are
enough runnable processes (j>=3).  Running additional processes in
parallel (j=16) does not increase performance any further nor does it
decease it.  My best case speedup amounts to 15%, which is right in the
middle of the 10-20% range that Intel talks about.

> Conclusion?
> If you run nothing but kernel compiles all day on a P4 HT, make sure you 
> compile it for SMP ;-)

And make sure you compile with the -jX option with X >= logical_procs+1

Nathan

