Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTBDVJB>; Tue, 4 Feb 2003 16:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTBDVJB>; Tue, 4 Feb 2003 16:09:01 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9897 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267371AbTBDVI7>;
	Tue, 4 Feb 2003 16:08:59 -0500
Date: Tue, 04 Feb 2003 13:09:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Andrew Theurer <habanero@us.ibm.com>
cc: Rick Lindsley <ricklind@us.ibm.com>, Robert Love <rml@tech9.net>,
       Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] HT scheduler, sched-2.5.59-E6
Message-ID: <376170000.1044392941@flay>
In-Reply-To: <Pine.LNX.4.44.0302041800280.12001-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302041800280.12001-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this is the -E6 patch, with most of the HT-unrelated tunings and leftover
> changes (noticed by Robert) removed. I kept the activation reorganization
> because that is important in the HT case as well.
> 
> based on Erich's observations i also added AGRESSIVE_IDLE_STEAL, which
> defaults to 1 currently - could anyone try it with 0 on a NUMA box, how
> much of a difference does it make?

Passive aggressive results below - 16x NUMA-Q:
Summary: passive seems OK, though no better than current (for me).
Aggressive seems a little worse than current, though not too drastically.

--------------------------------------

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                                   Elapsed        User      System         CPU
                 2.5.59-gcc3.2       45.86      563.63      119.58     1489.33
           2.5.59-E6-agressive       46.09      564.41      120.19     1484.67
             2.5.59-E6-passive       46.20      564.53      120.00     1481.33

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                                   Elapsed        User      System         CPU
                 2.5.59-gcc3.2       47.15      567.41      143.72     1507.50
           2.5.59-E6-agressive       47.58      567.42      146.40     1499.50
             2.5.59-E6-passive       47.51      567.56      144.57     1498.33

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         5.2%
           2.5.59-E6-agressive        93.5%         5.4%
             2.5.59-E6-passive       104.2%         1.6%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         7.1%
           2.5.59-E6-agressive       100.9%         4.0%
             2.5.59-E6-passive       102.8%         9.9%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         5.3%
           2.5.59-E6-agressive       105.3%         8.1%
             2.5.59-E6-passive        98.8%         7.2%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         4.7%
           2.5.59-E6-agressive        99.7%         2.9%
             2.5.59-E6-passive        98.2%         4.3%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         1.8%
           2.5.59-E6-agressive        97.8%         0.3%
             2.5.59-E6-passive        98.4%         1.7%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         1.6%
           2.5.59-E6-agressive       100.3%         1.5%
             2.5.59-E6-passive        99.6%         1.6%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                 2.5.59-gcc3.2       100.0%         1.1%
           2.5.59-E6-agressive        99.8%         0.6%
             2.5.59-E6-passive        99.4%         1.1%

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59-gcc3.2        0.00       41.80      107.76        0.73
           2.5.59-E6-agressive        0.00       43.65      116.28        0.78
             2.5.59-E6-passive        0.00       41.56       93.15        0.65

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59-gcc3.2        0.00       38.00      229.83        2.11
           2.5.59-E6-agressive        0.00       60.41      298.63        1.91
             2.5.59-E6-passive        0.00       41.76      250.80        1.80

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59-gcc3.2        0.00       57.28      839.21        2.85
           2.5.59-E6-agressive        0.00       57.36      849.87        2.90
             2.5.59-E6-passive        0.00       57.45      850.05        3.55

NUMA schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59-gcc3.2        0.00      118.44     1788.09        6.25
           2.5.59-E6-agressive        0.00      117.88     1796.30        6.13
             2.5.59-E6-passive        0.00      116.91     1802.43        6.38

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                 2.5.59-gcc3.2        0.00      234.55     3633.76       15.02
           2.5.59-E6-agressive        0.00      233.69     3614.37       14.53
             2.5.59-E6-passive        0.00      236.53     3635.14       15.29

