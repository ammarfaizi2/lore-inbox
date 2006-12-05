Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935003AbWLEWTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935003AbWLEWTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935292AbWLEWTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:19:06 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42960 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935003AbWLEWTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:19:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.19-rc6-mm2: lockdep unhappy with disable_nonboot_cpus()
Date: Tue, 5 Dec 2006 23:14:08 +0100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612052314.08840.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I try to suspend (echo disk > /sys/power/state) an SMP x86-64 box with a
lockdep-enabled kernel, I get this (100% of the time):

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.19-rc6-mm2 #62
-------------------------------------------------------
bash/4519 is trying to acquire lock:
 (&policy->lock){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30

but task is already holding lock:
 (cache_chain_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (cache_chain_mutex){--..}:
       [<ffffffff802b1d1f>] add_lock_to_list+0x8f/0xd0
       [<ffffffff802b469d>] __lock_acquire+0xa9d/0xc20
       [<ffffffff802b48aa>] lock_acquire+0x8a/0xc0
       [<ffffffff8026e39d>] __mutex_lock_slowpath+0xdd/0x280
       [<ffffffff8026e565>] mutex_lock+0x25/0x30
       [<ffffffff802e7305>] cpuup_callback+0x1e5/0x330
       [<ffffffff802a51ef>] notifier_call_chain+0x3f/0x80
       [<ffffffff802a5259>] __raw_notifier_call_chain+0x9/0x10
       [<ffffffff802a5271>] raw_notifier_call_chain+0x11/0x20
       [<ffffffff802b87cf>] _cpu_down+0x7f/0x290
       [<ffffffff802b8c62>] disable_nonboot_cpus+0x92/0x130
       [<ffffffff802be88b>] prepare_processes+0x1b/0xf0
       [<ffffffff802beb8c>] pm_suspend_disk+0xc/0x180
       [<ffffffff802bd3e5>] enter_state+0x65/0x220
       [<ffffffff802bd61a>] state_store+0x7a/0xa0
       [<ffffffff80318ab4>] subsys_attr_store+0x24/0x30
       [<ffffffff80318e58>] sysfs_write_file+0xe8/0x120
       [<ffffffff8021870f>] vfs_write+0xdf/0x1a0
       [<ffffffff80219280>] sys_write+0x50/0x90
       [<ffffffff8026825e>] system_call+0x7e/0x83
       [<00002b4b9ff8bcb0>] 0x2b4b9ff8bcb0
       [<ffffffffffffffff>] 0xffffffffffffffff

-> #2 (workqueue_mutex){--..}:
       [<ffffffff802b1d1f>] add_lock_to_list+0x8f/0xd0
       [<ffffffff802b469d>] __lock_acquire+0xa9d/0xc20
       [<ffffffff802b48aa>] lock_acquire+0x8a/0xc0
       [<ffffffff8026e39d>] __mutex_lock_slowpath+0xdd/0x280
       [<ffffffff8026e565>] mutex_lock+0x25/0x30
       [<ffffffff802a8db0>] __create_workqueue+0x80/0x1a0
       [<ffffffff881c6550>] cpufreq_governor_dbs+0xd0/0x3b0 [cpufreq_ondemand]
       [<ffffffff8047c385>] __cpufreq_governor+0xb5/0x120
       [<ffffffff8047c587>] __cpufreq_set_policy+0x197/0x230
       [<ffffffff8047c85c>] store_scaling_governor+0x19c/0x200
       [<ffffffff8027c907>] store+0x57/0x80
       [<ffffffff80318e58>] sysfs_write_file+0xe8/0x120
       [<ffffffff8021870f>] vfs_write+0xdf/0x1a0
       [<ffffffff80219280>] sys_write+0x50/0x90
       [<ffffffff8026825e>] system_call+0x7e/0x83
       [<00002b6437c31cb0>] 0x2b6437c31cb0
       [<ffffffffffffffff>] 0xffffffffffffffff

-> #1 (dbs_mutex){--..}:
       [<ffffffff802b1d1f>] add_lock_to_list+0x8f/0xd0
       [<ffffffff802b469d>] __lock_acquire+0xa9d/0xc20
       [<ffffffff802b48aa>] lock_acquire+0x8a/0xc0
       [<ffffffff8026e39d>] __mutex_lock_slowpath+0xdd/0x280
       [<ffffffff8026e565>] mutex_lock+0x25/0x30
       [<ffffffff881c652e>] cpufreq_governor_dbs+0xae/0x3b0 [cpufreq_ondemand]
       [<ffffffff8047c385>] __cpufreq_governor+0xb5/0x120
       [<ffffffff8047c587>] __cpufreq_set_policy+0x197/0x230
       [<ffffffff8047c85c>] store_scaling_governor+0x19c/0x200
       [<ffffffff8027c907>] store+0x57/0x80
       [<ffffffff80318e58>] sysfs_write_file+0xe8/0x120
       [<ffffffff8021870f>] vfs_write+0xdf/0x1a0
       [<ffffffff80219280>] sys_write+0x50/0x90
       [<ffffffff8026825e>] system_call+0x7e/0x83
       [<00002b6437c31cb0>] 0x2b6437c31cb0
       [<ffffffffffffffff>] 0xffffffffffffffff

-> #0 (&policy->lock){--..}:
       [<ffffffff802b2cc7>] print_circular_bug_tail+0x57/0xb0
       [<ffffffff802b4584>] __lock_acquire+0x984/0xc20
       [<ffffffff802b48aa>] lock_acquire+0x8a/0xc0
       [<ffffffff8026e39d>] __mutex_lock_slowpath+0xdd/0x280
       [<ffffffff8026e565>] mutex_lock+0x25/0x30
       [<ffffffff8047cad4>] cpufreq_driver_target+0x44/0x80
       [<ffffffff8047d354>] cpufreq_cpu_callback+0x64/0x80
       [<ffffffff802a51ef>] notifier_call_chain+0x3f/0x80
       [<ffffffff802a5259>] __raw_notifier_call_chain+0x9/0x10
       [<ffffffff802a5271>] raw_notifier_call_chain+0x11/0x20
       [<ffffffff802b87cf>] _cpu_down+0x7f/0x290
       [<ffffffff802b8c62>] disable_nonboot_cpus+0x92/0x130
       [<ffffffff802be88b>] prepare_processes+0x1b/0xf0
       [<ffffffff802beb8c>] pm_suspend_disk+0xc/0x180
       [<ffffffff802bd3e5>] enter_state+0x65/0x220
       [<ffffffff802bd61a>] state_store+0x7a/0xa0
       [<ffffffff80318ab4>] subsys_attr_store+0x24/0x30
       [<ffffffff80318e58>] sysfs_write_file+0xe8/0x120
       [<ffffffff8021870f>] vfs_write+0xdf/0x1a0
       [<ffffffff80219280>] sys_write+0x50/0x90
       [<ffffffff8026825e>] system_call+0x7e/0x83
       [<00002b4b9ff8bcb0>] 0x2b4b9ff8bcb0
       [<ffffffffffffffff>] 0xffffffffffffffff

other info that might help us debug this:

5 locks held by bash/4519:
 #0:  (pm_mutex){--..}, at: [<ffffffff802bd3d2>] enter_state+0x52/0x220
 #1:  (cpu_add_remove_lock){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
 #2:  (sched_hotcpu_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
 #3:  (workqueue_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
 #4:  (cache_chain_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30

stack backtrace:

Call Trace:
 [<ffffffff80274a3d>] dump_trace+0xcd/0x4b0
 [<ffffffff80274e63>] show_trace+0x43/0x70
 [<ffffffff80274ea5>] dump_stack+0x15/0x20
 [<ffffffff802b2d08>] print_circular_bug_tail+0x98/0xb0
 [<ffffffff802b4584>] __lock_acquire+0x984/0xc20
 [<ffffffff802b48aa>] lock_acquire+0x8a/0xc0
 [<ffffffff8026e39d>] __mutex_lock_slowpath+0xdd/0x280
 [<ffffffff8026e565>] mutex_lock+0x25/0x30
 [<ffffffff8047cad4>] cpufreq_driver_target+0x44/0x80
 [<ffffffff8047d354>] cpufreq_cpu_callback+0x64/0x80
 [<ffffffff802a51ef>] notifier_call_chain+0x3f/0x80
 [<ffffffff802a5259>] __raw_notifier_call_chain+0x9/0x10
 [<ffffffff802a5271>] raw_notifier_call_chain+0x11/0x20
 [<ffffffff802b87cf>] _cpu_down+0x7f/0x290
 [<ffffffff802b8c62>] disable_nonboot_cpus+0x92/0x130
 [<ffffffff802be88b>] prepare_processes+0x1b/0xf0
 [<ffffffff802beb8c>] pm_suspend_disk+0xc/0x180
 [<ffffffff802bd3e5>] enter_state+0x65/0x220
 [<ffffffff802bd61a>] state_store+0x7a/0xa0
 [<ffffffff80318ab4>] subsys_attr_store+0x24/0x30
 [<ffffffff80318e58>] sysfs_write_file+0xe8/0x120
 [<ffffffff8021870f>] vfs_write+0xdf/0x1a0
 [<ffffffff80219280>] sys_write+0x50/0x90
 [<ffffffff8026825e>] system_call+0x7e/0x83
 [<00002b4b9ff8bcb0>]

5 locks held by bash/4519:
 #0:  (pm_mutex){--..}, at: [<ffffffff802bd3d2>] enter_state+0x52/0x220
 #1:  (cpu_add_remove_lock){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
 #2:  (sched_hotcpu_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
 #3:  (workqueue_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
 #4:  (cache_chain_mutex){--..}, at: [<ffffffff8026e565>] mutex_lock+0x25/0x30
CPU 1 is now offline
lockdep: not fixing up alternatives.
CPU1 is down

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
