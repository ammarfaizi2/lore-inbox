Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbSJ1ETg>; Sun, 27 Oct 2002 23:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSJ1ETg>; Sun, 27 Oct 2002 23:19:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:2763 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262835AbSJ1ETf>; Sun, 27 Oct 2002 23:19:35 -0500
Date: Sun, 27 Oct 2002 20:23:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Erich Focht <efocht@ess.nec.de>, mingo@redhat.com,
       Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: NUMA scheduler  (was: 2.5 merge candidate list	1.5)
Message-ID: <3142297164.1035750188@[10.10.2.3]>
In-Reply-To: <1035766530.8077.82.camel@hbaum>
References: <1035766530.8077.82.camel@hbaum>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Michael, the way I read the NR_CPUS loop, you walk every cpu
>> in the system, and take the best from all of them. In which case
>> what's the point of the last_exec_cpu stuff? On the other hand, 
>> I changed your NR_CPUS to 4 (ie just walk the cpus in that node), 
>> and it got worse. So perhaps I'm just misreading your code ...
>> and it does seem significantly cheaper to execute than Erich's.
>> 
> You are reading it correct.  The only thing that the last_exec_cpu
> does is to help spread the load across nodes.  Without that what was
> happening is that node 0 would get completely loaded, then node 1,
> etc.  With it, in cases where one or more runqueues have the same
> length, the one chosen tends to get spread out a bit.  Not the 
> greatest solution, but it helps.

OK. I made a simple boring optimisation to your patch. Shaved almost
a second off system time for kernbench, and seems idiotproof to me,
shouldn't change anything apart from touching fewer runqueues: if
we find a runqueue with nr_running == 0, stop searching ... we ain't
going to find anything better ;-)

Kernbench:
                                   Elapsed        User      System         CPU
                    2.5.44-mm4     19.676s    192.794s     42.678s     1197.4%
            2.5.44-mm4-hbaum-1     19.746s    189.232s     38.354s     1152.2%
           2.5.44-mm4-hbaum-12     19.322s    190.176s     40.354s     1192.6%
 2.5.44-mm4-hbaum-12-firstzero     19.292s     189.66s     39.428s     1187.4%

Patch is probably space-eaten, so just whack it in by hand.

--- 2.5.44-mm4-hbaum-12/kernel/sched.c  2002-10-27 19:54:25.000000000 -0800
+++ 2.5.44-mm4-hbaum-12-first_low/kernel/sched.c        2002-10-27 16:42:10.000000000 -0800
@@ -2206,6 +2206,8 @@
                if (minload > cpu_rq(cur_cpu)->nr_running) {
                        minload = cpu_rq(cur_cpu)->nr_running;
                        best_cpu = cur_cpu;
+                       if (minload == 0)
+                               break;
                }
                if (++cur_cpu >= NR_CPUS)
                        cur_cpu = 0;

