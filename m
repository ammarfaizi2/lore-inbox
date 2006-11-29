Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967417AbWK2PYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967417AbWK2PYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 10:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967416AbWK2PYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 10:24:05 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:36516 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S967418AbWK2PYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 10:24:02 -0500
Date: Wed, 29 Nov 2006 20:54:04 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: akpm@osdl.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061129152404.GA7082@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Looks like the lockdep has resumed yelling about the cpufreq-cpu hotplug 
interactions! Again, it's the Ondemand governor that's the culprit.

On linux-2.6.19-rc6-mm2, this is what I got yesterday evening.

[root@llm05 tests]# echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
[root@llm05 tests]# echo 0 > /sys/devices/system/cpu/cpu1/online

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.19-rc6-mm2 #14
-------------------------------------------------------
bash/4601 is trying to acquire lock:
 (&policy->lock){--..}, at: [<c045793d>] mutex_lock+0x12/0x15

but task is already holding lock:
 (cache_chain_mutex){--..}, at: [<c045793d>] mutex_lock+0x12/0x15

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (cache_chain_mutex){--..}:
       [<c013bddc>] __lock_acquire+0x8ef/0x9f3
       [<c013c1ec>] lock_acquire+0x68/0x82
       [<c04577da>] __mutex_lock_slowpath+0xd3/0x224
       [<c045793d>] mutex_lock+0x12/0x15
       [<c01642f1>] cpuup_callback+0x1a3/0x2d6
       [<c045a952>] notifier_call_chain+0x2b/0x5b
       [<c012efb6>] __raw_notifier_call_chain+0x18/0x1d
       [<c012efd5>] raw_notifier_call_chain+0x1a/0x1c
       [<c013f798>] _cpu_down+0x56/0x1ef
       [<c013fa5c>] cpu_down+0x26/0x3a
       [<c029dde2>] store_online+0x27/0x5a
       [<c029adec>] sysdev_store+0x20/0x25
       [<c0197284>] sysfs_write_file+0xb6/0xde
       [<c01674d4>] vfs_write+0x90/0x144
       [<c0167c74>] sys_write+0x3d/0x61
       [<c0103d36>] sysenter_past_esp+0x5f/0x99
       [<ffffffff>] 0xffffffff

-> #2 (workqueue_mutex){--..}:
       [<c013bddc>] __lock_acquire+0x8ef/0x9f3
       [<c013c1ec>] lock_acquire+0x68/0x82
       [<c04577da>] __mutex_lock_slowpath+0xd3/0x224
       [<c045793d>] mutex_lock+0x12/0x15
       [<c0131e91>] __create_workqueue+0x5b/0x11c
       [<c03c4a9a>] cpufreq_governor_dbs+0xa0/0x2e8
       [<c03c2cde>] __cpufreq_governor+0x64/0xac
       [<c03c30d5>] __cpufreq_set_policy+0x187/0x20b
       [<c03c33a1>] store_scaling_governor+0x132/0x16a
       [<c03c2af9>] store+0x35/0x46
       [<c0197284>] sysfs_write_file+0xb6/0xde
       [<c01674d4>] vfs_write+0x90/0x144
       [<c0167c74>] sys_write+0x3d/0x61
       [<c0103d36>] sysenter_past_esp+0x5f/0x99
       [<ffffffff>] 0xffffffff

-> #1 (dbs_mutex){--..}:
       [<c013bddc>] __lock_acquire+0x8ef/0x9f3
       [<c013c1ec>] lock_acquire+0x68/0x82
       [<c04577da>] __mutex_lock_slowpath+0xd3/0x224
       [<c045793d>] mutex_lock+0x12/0x15
       [<c03c4a7e>] cpufreq_governor_dbs+0x84/0x2e8
       [<c03c2cde>] __cpufreq_governor+0x64/0xac
       [<c03c30d5>] __cpufreq_set_policy+0x187/0x20b
       [<c03c33a1>] store_scaling_governor+0x132/0x16a
       [<c03c2af9>] store+0x35/0x46
       [<c0197284>] sysfs_write_file+0xb6/0xde
       [<c01674d4>] vfs_write+0x90/0x144
       [<c0167c74>] sys_write+0x3d/0x61
       [<c0103d36>] sysenter_past_esp+0x5f/0x99
       [<ffffffff>] 0xffffffff

-> #0 (&policy->lock){--..}:
       [<c013bce0>] __lock_acquire+0x7f3/0x9f3
       [<c013c1ec>] lock_acquire+0x68/0x82
       [<c04577da>] __mutex_lock_slowpath+0xd3/0x224
       [<c045793d>] mutex_lock+0x12/0x15
       [<c03c2c1f>] cpufreq_driver_target+0x2b/0x51
       [<c03c38db>] cpufreq_cpu_callback+0x42/0x52
       [<c045a952>] notifier_call_chain+0x2b/0x5b
       [<c012efb6>] __raw_notifier_call_chain+0x18/0x1d
       [<c012efd5>] raw_notifier_call_chain+0x1a/0x1c
       [<c013f798>] _cpu_down+0x56/0x1ef
       [<c013fa5c>] cpu_down+0x26/0x3a
       [<c029dde2>] store_online+0x27/0x5a
       [<c029adec>] sysdev_store+0x20/0x25
       [<c0197284>] sysfs_write_file+0xb6/0xde
       [<c01674d4>] vfs_write+0x90/0x144
       [<c0167c74>] sys_write+0x3d/0x61
       [<c0103d36>] sysenter_past_esp+0x5f/0x99
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

4 locks held by bash/4601:
 #0:  (cpu_add_remove_lock){--..}, at: [<c045793d>] mutex_lock+0x12/0x15
 #1:  (sched_hotcpu_mutex){--..}, at: [<c045793d>] mutex_lock+0x12/0x15
 #2:  (workqueue_mutex){--..}, at: [<c045793d>] mutex_lock+0x12/0x15
 #3:  (cache_chain_mutex){--..}, at: [<c045793d>] mutex_lock+0x12/0x15

stack backtrace:
 [<c0104c8f>] show_trace_log_lvl+0x19/0x2e
 [<c0104d8f>] show_trace+0x12/0x14
 [<c0104da5>] dump_stack+0x14/0x16
 [<c013a157>] print_circular_bug_tail+0x7c/0x85
 [<c013bce0>] __lock_acquire+0x7f3/0x9f3
 [<c013c1ec>] lock_acquire+0x68/0x82
 [<c04577da>] __mutex_lock_slowpath+0xd3/0x224
 [<c045793d>] mutex_lock+0x12/0x15
 [<c03c2c1f>] cpufreq_driver_target+0x2b/0x51
 [<c03c38db>] cpufreq_cpu_callback+0x42/0x52
 [<c045a952>] notifier_call_chain+0x2b/0x5b
 [<c012efb6>] __raw_notifier_call_chain+0x18/0x1d
 [<c012efd5>] raw_notifier_call_chain+0x1a/0x1c
 [<c013f798>] _cpu_down+0x56/0x1ef
 [<c013fa5c>] cpu_down+0x26/0x3a
 [<c029dde2>] store_online+0x27/0x5a
 [<c029adec>] sysdev_store+0x20/0x25
 [<c0197284>] sysfs_write_file+0xb6/0xde
 [<c01674d4>] vfs_write+0x90/0x144
 [<c0167c74>] sys_write+0x3d/0x61
 [<c0103d36>] sysenter_past_esp+0x5f/0x99
 =======================
Breaking affinity for irq 24
CPU 1 is now offline

Ok, so to cut the long story short, 
- While changing governor from anything to
ondemand, locks are taken in the following order

policy->lock ===> dbs_mutex ===> workqueue_mutex.

- While offlining a cpu, locks are taken in the following order

cpu_add_remove_lock ==> sched_hotcpu_mutex ==> workqueue_mutex ==
==> cache_chain_mutex ==> policy->lock.

The dependency graph built out of this info has a circular dependency
as pointed out by lockdep. However, I am not quite sure how seriously this
circular dependency warning should be taken.

One way to avoid these warnings is to take the policy->lock before the
rest of the locks, while offlining the cpu. 
For a moment I even thought of taking/releasing policy->lock under
CPU_LOCK_ACQUIRE/CPU_LOCK_RELEASE events in cpufreq_cpu_callback. 
But that's a bad idea since 'policy' is percpu data in the first place
and hence needs to be cpu-hotplug aware.

These circular-dependency warnings are emitted in 
2.6.19-rc6-mm1 as well as (2.6.19-rc6 + hotplug_locking_rework patches)

So do we
- Rethink the strategy of per-subsystem hotcpu-locks ?

  OR
  
- Think of a way to straighten out the super-convoluted cpufreq code ?

At the moment, I would suggest the latter :-)

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
