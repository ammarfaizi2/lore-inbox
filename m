Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGIMOx>; Tue, 9 Jul 2002 08:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSGIMOw>; Tue, 9 Jul 2002 08:14:52 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18104 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314546AbSGIMOv>; Tue, 9 Jul 2002 08:14:51 -0400
Date: Tue, 9 Jul 2002 17:50:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net
Subject: [OLS] RCU overhead measurements
Message-ID: <20020709175037.H4792@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a more detailed description of the rcu overhead measurement
data presented at OLS 2002. We used kernel profile ticks to roughly 
compare the overheads of different implementations of RCU in order 
to see which features in those implementations help and which don't.

For our experiments, we used the rt_rcu-2.5.3-1.patch (lockfree route cache)
along with 3 different RCU infrastructure implementations. We used
a test suggested by Dave Miller that sends a large number of
packets to random destination addresses changing the address after
every 5 packets. The test was run on an 8-cpu PIII Xeon system
with 6GB RAM. It was run under two environments -

1. Increased neighbor table garbage collection threshold thereby
   reducing the number of updates
2. Default GC threshold that results in very large number of
   garbage collection and route cache updates due to random
   destination addresses.

The key implementation features of the 3 RCU infrastructure patches are -

1. rcu_ltimer - Per-CPU queue of RCUs, periodic (10ms) checking for
                CPU going through a quiescent state.
2. rcu_sched  - Per-CPU queue of RCUs, all checking done from scheduler 
                context, global atomic counter of RCUs.
3. rcu_poll   - Global queue of RCUs, single polling tasklet, force
                reschedule on CPUs for completion of RCU grace period.

The patches can be found at http://lse.sf.net/locking/ols2002/rcu/patches.
A description of these as well as some other experimental patches
can be found in http://lse.sf.net/locking/ols2002/rcu/patches/rcu_impl.html.

The raw kernprof outputs are at 
http://lse.sf.net/locking/ols2002/rcu/results/rttest/rttest_davem/.

The numbers represent the profile ticks in the corresponding routines.

1. rt_rcu with neighbor table garbage collection threshold increased to
   prevent frequent overflow (due to random dest addresses).

function        	base    rcu_ltimer      rcu_sched       rcu_poll
--------        	----    ----------      ---------       --------
ip_route_output_key     4486    2026		2162		2135
call_rcu                	11		68		71
rcu_process_callbacks   	4		   		128
rcu_invoke_callbacks            4		   		24
rcu_batch_done		           		1		   
schedule		423	453		459		500
rcu_prepare_polling	   	   		   		13
rcu_polling		   	   		   		134


2. rt_rcu with frequent neighbor table overflow (due to random dest addresses)

function        	base    rcu_ltimer      rcu_sched       rcu_poll
--------        	----    ----------      ---------       --------
ip_route_output_key     2358    1646		1619		1641
call_rcu                	262		1147		2251
rcu_process_callbacks   	49		   		2778
rcu_invoke_callbacks            57		   		488
rcu_check_quiescent_state	27
rcu_check_callbacks		24
rcu_reg_batch			3
rcu_batch_done		           		3		   
schedule		294	   		849		808
rcu_prepare_polling	   	   		   		21
rcu_polling		   	   		   		2756
rcu_completion							4
force_cpu_reschedule						553
__tasklet_hi_schedule						1557


Based on these measurements, we can draw the following conclusions -

1. RCU, implemented the right way, can be beneficial even when
updates are more than rare. Atleast one patch (rcu_ltimer) shows
a net improvement (gain in ip_route_output_key - rcu overhead) under
heavy update load.

2. When updates are rare most implementations can work well and show
real benefits.

3. Global queues are out, it is important to have per-cpu queues as
seen from overheads in rcu_poll code.

4. Global atomic RCU counter in rcu_sched probably hurts as seen
in call_rcu() overhead. So we should try to avoid such global
counters.

Comments/suggestions ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
