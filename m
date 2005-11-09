Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVKIFDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVKIFDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 00:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVKIFDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 00:03:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:27027 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030484AbVKIFDy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 00:03:54 -0500
Message-ID: <43718334.2090905@us.ibm.com>
Date: Tue, 08 Nov 2005 23:03:48 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, slpratt@us.ibm.com, anton@samba.org
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au>
In-Reply-To: <436FF6A6.1040708@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>
> I think you are right that the NUMA domain is probably being too
> constrictive of task balancing, and that is where the regression
> is coming from.
>
> For some workloads it is definitely important to have the NUMA
> domain, because it helps spread load over memory controllers as
> well as CPUs - so I guess eliminating that domain is not a good
> long term solution.
>
> I would look at changing parameters of SD_NODE_INIT in include/
> asm-powerpc/topology.h so they are closer to SD_CPU_INIT parameters
> (ie. more aggressive).

I ran with the following:

--- topology.h.orig     2005-11-08 13:11:57.000000000 -0600
+++ topology.h  2005-11-08 13:17:15.000000000 -0600
@@ -43,11 +43,11 @@ static inline int node_to_first_cpu(int
        .span                   = CPU_MASK_NONE,        \
        .parent                 = NULL,                 \
        .groups                 = NULL,                 \
-       .min_interval           = 8,                    \
-       .max_interval           = 32,                   \
-       .busy_factor            = 32,                   \
+       .min_interval           = 1,                    \
+       .max_interval           = 4,                    \
+       .busy_factor            = 64,                   \
        .imbalance_pct          = 125,                  \
-       .cache_hot_time         = (10*1000000),         \
+       .cache_hot_time         = (5*1000000/2),        \
        .cache_nice_tries       = 1,                    \
        .per_cpu_gain           = 100,                  \
        .flags                  = SD_LOAD_BALANCE       \

There was no improvement in performance.  The schedstats from this run 
follow:

       2516          sys_sched_yield()
          0(  0.00%) found (only) active queue empty on current cpu
          0(  0.00%) found (only) expired queue empty on current cpu
         46(  1.83%) found both queues empty on current cpu
       2470( 98.17%) found neither queue empty on current cpu


    22969106          schedule()
     694922          goes idle
          3(  0.00%) switched active and expired queues
          0(  0.00%) used existing active queue

          0          active_load_balance()
          0          sched_balance_exec()

      0.19/1.28      avg runtime/latency over all cpus (ms)

[scheduler domain #0]
    1153606          load_balance()
      82580(  7.16%) called while idle
                         488(  0.59%) tried but failed to move any tasks
                       63876( 77.35%) found no busier group
                       18216( 22.06%) succeeded in moving at least one task
                                      (average imbalance:   1.526)
     317610( 27.53%) called while busy
                          15(  0.00%) tried but failed to move any tasks
                      220139( 69.31%) found no busier group
                       97456( 30.68%) succeeded in moving at least one task
                                      (average imbalance:   1.752)
     753416( 65.31%) called when newly idle
                         487(  0.06%) tried but failed to move any tasks
                      624132( 82.84%) found no busier group
                      128797( 17.10%) succeeded in moving at least one task
                                      (average imbalance:   1.531)

          0          sched_balance_exec() tried to push a task

[scheduler domain #1]
     715638          load_balance()
      68533(  9.58%) called while idle
                        3140(  4.58%) tried but failed to move any tasks
                       60357( 88.07%) found no busier group
                        5036(  7.35%) succeeded in moving at least one task
                                      (average imbalance:   1.251)
      22486(  3.14%) called while busy
                          64(  0.28%) tried but failed to move any tasks
                       21352( 94.96%) found no busier group
                        1070(  4.76%) succeeded in moving at least one task
                                      (average imbalance:   1.922)
     624619( 87.28%) called when newly idle
                        5218(  0.84%) tried but failed to move any tasks
                      591970( 94.77%) found no busier group
                       27431(  4.39%) succeeded in moving at least one task
                                      (average imbalance:   1.382)

          0          sched_balance_exec() tried to push a task

[scheduler domain #2]
     685164          load_balance()
      63247(  9.23%) called while idle
                        7280( 11.51%) tried but failed to move any tasks
                       52200( 82.53%) found no busier group
                        3767(  5.96%) succeeded in moving at least one task
                                      (average imbalance:   1.361)
      24729(  3.61%) called while busy
                         418(  1.69%) tried but failed to move any tasks
                       21025( 85.02%) found no busier group
                        3286( 13.29%) succeeded in moving at least one task
                                      (average imbalance:   3.579)
     597188( 87.16%) called when newly idle
                       67577( 11.32%) tried but failed to move any tasks
                      371377( 62.19%) found no busier group
                      158234( 26.50%) succeeded in moving at least one task
                                      (average imbalance:   2.146)

          0          sched_balance_exec() tried to push a task

>
> I would also take a look at removing SD_WAKE_IDLE from the flags.
> This flag should make balancing more aggressive, but it can have
> problems when applied to a NUMA domain due to too much task
> movement.

Independent from the run above, I ran with the following:

--- topology.h.orig     2005-11-08 19:32:19.000000000 -0600
+++ topology.h  2005-11-08 19:34:25.000000000 -0600
@@ -53,7 +53,6 @@ static inline int node_to_first_cpu(int
        .flags                  = SD_LOAD_BALANCE       \
                                | SD_BALANCE_EXEC       \
                                | SD_BALANCE_NEWIDLE    \
-                               | SD_WAKE_IDLE          \
                                | SD_WAKE_BALANCE,      \
        .last_balance           = jiffies,              \
        .balance_interval       = 1,                    \

There was no improvement in performance. 

I didn't expect any change in performance this time, because I
don't think the SD_WAKE_IDLE flag is effective in the NUMA
domain, due to the following code in wake_idle:

        for_each_domain(cpu, sd) {
                if (sd->flags & SD_WAKE_IDLE) {
                        cpus_and(tmp, sd->span, p->cpus_allowed);
                        for_each_cpu_mask(i, tmp) {
                                if (idle_cpu(i))
                                        return i;
                        }
                }
                else
                        break;
        }
 
If I read that loop correctly it stops at the first domain
which doesn't have SD_WAKE_IDLE set, which is the CPU domain
(see SD_CPU_INIT), and thus it never gets to the NUMA domain.

Thanks for the suggestions Nick.  Andrew raises some
good questions that I will address tomorrow.

Cheers,
Brian

