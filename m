Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbTLLO6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbTLLO6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:58:44 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:13756
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S265230AbTLLO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:57:43 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: HT schedulers' performance on single HT processor
Date: Sat, 13 Dec 2003 01:57:36 +1100
User-Agent: KMail/1.5.3
Cc: Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312130157.36843.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I set out to find how the hyper-thread schedulers would affect the all 
important kernel compile benchmark on machines that most of us are likely to 
encounter soon. The single processor HT machine.

Usual benchmark precautions taken; best of five runs (curiously the fastest 
was almost always the second run). Although for confirmation I really did 
this twice.

Tested a kernel compile with make vmlinux, make -j2 and make -j8. 

make vmlinux - tests to ensure the sequential single threaded make doesn't 
suffer as a result of these tweaks

make -j2 vmlinux - tests to see how well wasted idle time is avoided

make -j8 vmlinux - maximum throughput test (4x nr_cpus seems to be ceiling for 
this).

Hardware: P4 HT 3.066

Legend:
UP - Uniprocessor 2.6.0-test11 kernel
SMP - SMP kernel
C1 - With Ingo's C1 hyperthread patch
w26 - With Nick's w26 sched-rollup (hyperthread included)

make vmlinux
kernel	time
UP	65.96
SMP	65.80
C1	66.54
w26	66.25

I was concerned this might happen and indeed the sequential single threaded 
compile is slightly worse on both HT schedulers. (1)

make -j2 vmlinux
kernel	time
UP	65.17
SMP	57.77
C1	66.01
w26	57.94

Shows the smp kernel nicely utilises HT whereas the UP kernel doesn't. The C1 
result was very repeatable and I was unable to get it lower than this.(2)

make -j8 vmlinux
kernel	time
UP	65.00
SMP	57.85
C1	58.25
w26	57.94

Results are not obviously better(3) but C1 is still a little slower (2)

Ok so what happened as I see it?

(1) My concern with the HT patches and single compiles was that in an effort 
to keep both logical cores busy, the next task would bounce to the other 
logical core. While very cheap on HT it's still more expensive than staying 
on the same core. I can't prove that happened.

(2) We know the C1 patch has trouble booting on some hardware so maybe there's 
a bug in there affecting performance too.

(3) There is a very real performance advantage in this benchmark to enabling 
SMP on a HT cpu. However, in the best case it only amounts to 11%. This means 
that if a specialised HT scheduler patch gained say 10% it would only amount 
to 1% overall - hardly an exciting amount. 1% should have been on the edge of 
statistical significance, but I haven't even been able to show any difference 
at all. This does _not_ mean there aren't performance benefits elsewhere, but 
they obviously need evidence.

Conclusion?
If you run nothing but kernel compiles all day on a P4 HT, make sure you 
compile it for SMP ;-)

