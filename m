Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264726AbSJOPrB>; Tue, 15 Oct 2002 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264727AbSJOPrB>; Tue, 15 Oct 2002 11:47:01 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:40103 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264726AbSJOPq6>; Tue, 15 Oct 2002 11:46:58 -0400
Message-ID: <3DAC3944.73A6BF14@austin.ibm.com>
Date: Tue, 15 Oct 2002 10:50:29 -0500
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: mingo@elte.hu
Subject: [PATCH] [PERFORMANCE RESULTS] priority preemption in Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I looked at priority preemption for the 2.5 kernel using two workloads

        * SPECweb99 (Network)
        * VolanoMark (Loopback)

Counters were added in try_to_wake_up() to determine how many times it was
called and how many times priority preemption resulted from the wakeup.

I also created a patch that allows priority preemption for SCHED_OTHER
processes to be tuned in /proc/sys/kernel/preemption.  The default value
is 0 and a value of 40 essentially turns off priority preemption for
SCHED_OTHER.  The code that checks the tunable in try_to_wake_up() is :

if (p->prio < rq->curr->prio) {
        if (idle_rq(rq) || rt_task(p) || p->prio + preempt_threshold < rq->curr->prio)
                resched_task(rq->curr);
}

The 2.5.38 tunable priority preemption patch is here :

http://www-124.ibm.com/developerworks/opensource/linuxperf/volanomark/15Oct02/pri_preempt-2.5.38.patch

The 2.5.25 combined instrumentation + tunable priority preemption patch is here :

http://www-124.ibm.com/developerworks/opensource/linuxperf/volanomark/15Oct02/pri_preempt_cntr-2.5.25.patch

The user app to read the try_to_wake_up() stats is here :

http://www-124.ibm.com/developerworks/opensource/linuxperf/volanomark/15Oct02/prestat.c

I ran VolanoMark on 2.5.25 because it does not run well on 2.5.28 and beyond.
[problem being debugged].

The VolanoMark setup :

8-way 700 Mhz PIII, 1MB L2, 4GB HIGHMEM support
IBM J2RE 1.3.1 [20020302] with heap size of 1536MB for client & server
VolanoMark 2.1.2 ran in loopback mode with messages=1000, rooms=10

2.5.25 UP VolanoMark
====================

Table 1 - preemption = default , counters for VolanoMark loopback

Srvr  Clnt    preemption            calls to     % priority    
Nice  Nice    threshold   msg/sec   wake_up      preemptions
----  ------  ----------  -------   -----------  -----------
0     0       0 (default) 13183     3.49 M       28.4 %
0     -19     0           13881     4.42 M       86.6 % ***
0     +19     0           10553     5.52 M       10.5 %
+19   0       0           13508     4.06 M       82.9 % ***
+19   -19     0           13669     4.06 M       83.0 % ***
+19   +19     0           11694     3.42 M       21.5 %
-19   0       0           12107     5.54 M       10.7 %
-19   -19     0           13109     3.55 M       28.7 %
-19   +19     0           10516     5.51 M       10.4 %

*** Table 1 shows that nicing the client to a higher priority than the
server improves throughput compared to the default nice values of 0.

*** Table 1 shows that nicing the client to a higher priority increased
priority preemptions to 86.6 % , 82.9 % , and 83.0 % of total wakeups
compared to 28.4 % for a default nice value of 0. The total number of
wakeups also increased.

===

I then set the preemption threshold to 40 in order to eliminate the
priority preemption and repeated the test.

echo "40" > /proc/sys/kernel/preemption

Table 2 - preemption = 40 , counters for VolanoMark loopback

Srvr  Clnt    preemption            calls to     % priority    
Nice  Nice    threshold   msg/sec   wake_up      preemptions
----  ------  ----------  -------   -----------  -----------
0     0       40          13605     3.22 M       0.0 %
0     -19     40          18740     1.67 M       0.0 % ***
0     +19     40          10716     5.35 M       0.0 %
+19   0       40          16548     2.01 M       0.0 % ***
+19   -19     40          16885     2.00 M       0.0 % ***
+19   +19     40          11889     3.15 M       0.0 %
-19   0       40          12254     5.36 M       0.0 %
-19   -19     40          13574     3.24 M       0.0 %
-19   +19     40          10649     5.35 M       0.0 %

*** Table 2 shows that when priority preemption was reduced, eliminated
in this case, it improved throughput significantly.  The total number of
wakeups were also reduced.

=======

The data for the 8-way test showed a 5% increase in throughput when
preemption threshold was set to 40.

VolanoMark Summary
==================

For UP, nicing the client to -19 and eliminating priority preemption
improved throughput (msg/sec) by about 40 % (18740/13183)

=================================SPECweb99==================================

Troy Wilson tested the priority preemption patch on SPECweb99.

*** SPECweb99 was ran for research purposes only. ***
*** The runs were non compliant.                  ***
*** See description below.                        ***

The SPECweb99 setup is :

8-way 900 Mhz PIII, 2MB L2, 64GB HIGHMEM support with 32 GB memory.
Apache 2.0.36 using prefork 
(4) e1000 Gb controllers
(16) clients

The tunable priority preemption patch was tested on 2.5.33.

Table 3 - SPECweb99 conforming connections 

kernel    preemption     conforming     percent
          threshold      connections    improvement
======    ===========    ===========    ===========

2.5.33    0 (default)    2906           baseline
2.5.33    40             2990           2.9 %

Table 3 shows that reducing priority preemption improved the
number of conforming connections by 2.9 %.

The try_to_wake_up() counters were not ran on SPECweb99 nor was the
UP case ran.

Bill

IBM Linux Technology Center
http://www-124.ibm.com/developerworks/oss/linux
hartner@austin.ibm.com

=============================================================

*  SPEC(tm) and the benchmark name SPECweb(tm) are registered
trademarks of the Standard Performance Evaluation Corporation.
This benchmarking was performed for research purposes only,
and is non compliant, with the following deviations from the
rules -

  1 - It was run on hardware that does not meet the SPEC
      availability-to-the-public criteria.  The machine is
      an engineering sample.

  2 - access_log wasn't kept for full accounting.  It was
      being written, but deleted every 200 seconds.
