Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTAQT0j>; Fri, 17 Jan 2003 14:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTAQT0i>; Fri, 17 Jan 2003 14:26:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:49568 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267646AbTAQT0h>; Fri, 17 Jan 2003 14:26:37 -0500
Date: Fri, 17 Jan 2003 11:26:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
       colpatch@us.ibm.com
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [patch] sched-2.5.59-A2
Message-ID: <148970000.1042831603@flay>
In-Reply-To: <147000000.1042830254@flay>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <200301171535.21226.efocht@ess.nec.de> <200301171911.29514.efocht@ess.nec.de> <147000000.1042830254@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I repeated the tests with your B0 version and it's still not
>> satisfying. Maybe too aggressive NODE_REBALANCE_IDLE_TICK, maybe the
>> difference is that the other calls of load_balance() never have the
>> chance to balance across nodes.
> 
> Nope, I found the problem. The topo cleanups are broken - we end up 
> taking all mem accesses, etc to node 0.

Kernbench:
                                   Elapsed        User      System         CPU
                        2.5.59     20.032s     186.66s      47.73s       1170%
               2.5.59-ingo-mjb     19.986s    187.044s     48.592s     1178.8%

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       36.38       90.70        0.62
               2.5.59-ingo-mjb        0.00       34.70       88.58        0.69

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       42.78      249.77        1.85
               2.5.59-ingo-mjb        0.00       49.33      256.59        1.69

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       56.84      848.00        2.78
               2.5.59-ingo-mjb        0.00       65.67      875.05        3.58

NUMA schedbench 32:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00      116.36     1807.29        5.75
               2.5.59-ingo-mjb        0.00      142.77     2039.47        8.42

NUMA schedbench 64:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00      240.01     3634.20       14.57
               2.5.59-ingo-mjb        0.00      293.48     4534.99       20.62

System times are little higher (multipliers are set at busy = 10,
idle = 10) .... I'll try setting the idle multipler to 100, but
the other thing to do would be into increase the cross-node migrate
resistance by setting some minimum imbalance offsets. That'll 
probably have to be node-specific ... something like the number
of cpus per node ... but probably 0 for the simple HT systems.

M.

