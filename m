Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWBHO6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWBHO6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWBHO6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:58:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16028 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030426AbWBHO6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:58:23 -0500
Date: Wed, 8 Feb 2006 15:56:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, npiggin@suse.de, rostedt@goodmis.org,
       pwil3058@bigpond.net.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-ID: <20060208145632.GA32279@elte.hu>
References: <20060207142828.GA20930@wotan.suse.de> <200602080157.07823.kernel@kolivas.org> <20060207141525.19d2b1be.akpm@osdl.org> <200602081011.09749.kernel@kolivas.org> <20060207153617.6520f126.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207153617.6520f126.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> In that case I think we're better off fixing both problems rather than 
> fixing neither.
> 
> Suresh, Martin, Ingo, Nick and Con: please drop everything, 
> triple-check and test this:

Peter's latest patch looks good to me, code-wise.

i also did some testing. Find below the test results of running 12 types 
of benchmarks (running each benchmark at least 3 times), on 4 separate 
kernels, on 3 separate boxes (altogether giving 12 separate bootups and 
432 testresults).

the 4 kernels i used are:

         v2.6.15: vanilla 2.6.15
            -rc2: v2.6.16-rc2-git4
  -rc2-nosmpnice: v2.6.16-rc2-git4 + Nick's nosmpnice patch
   -rc2-smpnice2: v2.6.16-rc2-git4 + Peter's latest smpnice patch

[ Test method: the same set of 4 kernel images was used on each of the 
  boxes. The same .config was used to build all the kernel images: 
  SMP+SMT, no debugging and preempt-off. Each kernel instance did 3 
  tests of every test-row, and the table contains the fastest, "MIN" 
  result. (the precise method: there were at least 3 tests done, and 
  the test-scripts detected 3 consecutive test-results that are within a 
  given spread. I.e. outliers automatically cause a restart of that 
  test.) ]

here are the numbers (time units, smaller is better, percentage is 
relative to the baseline v2.6.15 column):

2/4-way HT P4-Xeon box:                (smaller is better)
======================
   MIN           v2.6.15             -rc2   -rc2-nosmpnice    -rc2-smpnice2
---------------------------------------------------------------------------
        ctx-2:      3.51      4.13 ( 17%)      4.68 ( 33%)      3.65 (  3%)
       ctx-20:      4.44      4.72 (  6%)      4.41 (  0%)      4.40 (  0%)
      ctx-200:      8.15      8.58 (  5%)      8.54 (  4%)      8.06 ( -1%)
         mmap:    784.00    756.00 ( -3%)    768.00 ( -2%)    763.00 ( -2%)
       select:     69.17     70.09 (  1%)     69.04 (  0%)     69.24 (  0%)
    proc-exec:    153.77    156.03 (  1%)    158.14 (  2%)    158.11 (  2%)
    proc-fork:    136.66    137.83 (  0%)    138.78 (  1%)    139.79 (  2%)
 syscall-open:      5.02      4.66 ( -7%)      4.82 ( -4%)      4.77 ( -4%)
 hackbench-10:      0.77      0.82 (  6%)      0.85 ( 10%)      0.79 (  2%)
 hackbench-20:      1.56      1.49 ( -4%)      1.38 (-11%)      1.42 ( -8%)
 hackbench-50:      4.20      4.02 ( -4%)      3.57 (-15%)      3.48 (-17%)
       volano:     18.53     20.07 (  8%)     19.09 (  3%)     19.33 (  4%)

as can be seen, the -rc2 slowdown is gone on this box. -nosmpnice and 
-smpnice2 are equivalent, within noise => good.

1/2-way dual-core Athlon64 box:        (smaller is better)
==============================
   MIN           v2.6.15             -rc2   -rc2-nosmpnice    -rc2-smpnice2
---------------------------------------------------------------------------
        ctx-2:      1.10      1.22 ( 10%)      1.33 ( 20%)      1.23 ( 11%)
       ctx-20:      1.36      1.38 (  1%)      1.32 ( -2%)      1.34 ( -1%)
      ctx-200:      2.99      3.36 ( 12%)      3.82 ( 27%)      3.70 ( 23%)
         mmap:    371.00    336.00 ( -9%)    332.00 (-10%)    426.00 ( 14%)
       select:     19.04     18.94 (  0%)     18.13 ( -4%)     18.43 ( -3%)
    proc-exec:    984.00    998.50 (  1%)   1017.83 (  3%)   1004.83 (  2%)
    proc-fork:     87.98     92.11 (  4%)     90.56 (  2%)     93.38 (  6%)
 syscall-open:      3.22      3.31 (  2%)      3.48 (  8%)      3.66 ( 13%)
 hackbench-10:      0.61      0.63 (  3%)      0.60 (  0%)      0.60 ( -1%)
 hackbench-20:      1.14      1.20 (  5%)      1.17 (  2%)      1.15 (  0%)
 hackbench-50:      2.72      2.88 (  6%)      2.82 (  3%)      2.78 (  2%)
       volano:      9.68     10.26 (  6%)     10.15 (  4%)      9.98 (  3%)

here the fluctuation of the numbers is higher (caching artifacts on this 
box prevent a less noisy measurement.) , but it can be seen that most of 
the -rc2 slowdown is gone, and in fact -smpnice2 seems to be a small net 
win over -nosmpnice => good.

1-way P4 box:                          (smaller is better)
============
   MIN           v2.6.15             -rc2   -rc2-nosmpnice    -rc2-smpnice2
---------------------------------------------------------------------------
         mmap:    889.00    859.00 ( -3%)    862.00 ( -3%)    855.00 ( -3%)
        ctx-2:      2.26      2.27 (  0%)      2.36 (  4%)      2.25 (  0%)
       select:     78.98     79.13 (  0%)     77.30 ( -2%)     79.09 (  0%)
       ctx-20:      2.57      2.65 (  3%)      2.60 (  1%)      2.60 (  1%)
      ctx-200:      7.58      7.66 (  1%)      7.66 (  1%)      7.50 ( -1%)
    proc-exec:    173.28    172.28 (  0%)    172.40 (  0%)    172.28 (  0%)
    proc-fork:    155.38    153.38 ( -1%)    155.60 (  0%)    153.33 ( -1%)
 syscall-open:      5.30      5.32 (  0%)      5.37 (  1%)      5.32 (  0%)
 hackbench-10:      1.92      1.90 ( -1%)      1.89 ( -1%)      1.85 ( -4%)
 hackbench-20:      3.88      3.64 ( -6%)      3.65 ( -6%)      3.61 ( -6%)
 hackbench-50:      9.75      9.48 ( -2%)      9.28 ( -4%)      9.24 ( -5%)
       volano:     28.18     28.99 (  2%)     28.40 (  0%)     27.63 ( -1%)

this confirms that smpnice has no effect on an UP box => good.

all in one, my conclusion is that Peter's patch fixes the smpnice 
slowdown on a wide range of boxes:

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
