Return-Path: <linux-kernel-owner+w=401wt.eu-S932207AbWLNJ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWLNJ5i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWLNJ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:57:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:49935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932207AbWLNJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:57:37 -0500
X-Authenticated: #14349625
Subject: 2.6.19.1-rt14-smp circular locking dependency
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 10:57:23 +0100
Message-Id: <1166090243.7147.10.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Lockdep doesn't approve of cpufreq, and seemingly with cause... I had to
poke SysRq-O.

[ 1103.164377] Disabling non-boot CPUs ...
[ 1103.171094] stopped custom tracer.
[ 1103.174614] 
[ 1103.174618] =======================================================
[ 1103.182692] [ INFO: possible circular locking dependency detected ]
[ 1103.189178] 2.6.19.1-rt14-smp #3
[ 1103.192564] -------------------------------------------------------
[ 1103.199062] s2ram/6643 is trying to acquire lock:
[ 1103.203976]  (cpu_bitmask_lock){--..}, at: [<c104a085>] lock_cpu_hotplug+0x22/0x6d
[ 1103.211988] 
[ 1103.211991] but task is already holding lock:
[ 1103.218112]  (workqueue_mutex){--..}, at: [<c1038a2a>] workqueue_cpu_callback+0x1c6/0x299
[ 1103.226702] 
[ 1103.226706] which lock already depends on the new lock.
[ 1103.226708] 
[ 1103.235197] 
[ 1103.235203] the existing dependency chain (in reverse order) is:
[ 1103.242992] 
[ 1103.242994] -> #3 (workqueue_mutex){--..}:
[ 1103.248905]        [<c1042c21>] add_lock_to_list+0x39/0x91
[ 1103.254859]        [<c10454fc>] __lock_acquire+0xc65/0xd3a
[ 1103.260760]        [<c104562e>] lock_acquire+0x5d/0x79
[ 1103.266271]        [<c13ec1b2>] _mutex_lock+0x2b/0x38
[ 1103.271801]        [<c1038516>] __create_workqueue+0x5f/0x16c
[ 1103.278013]        [<c131cf1f>] cpufreq_governor_dbs+0x274/0x321
[ 1103.284429]        [<c131ae69>] __cpufreq_governor+0x22/0x15e
[ 1103.290652]        [<c131b426>] __cpufreq_set_policy+0xe6/0x135
[ 1103.296994]        [<c131b990>] store_scaling_governor+0xa8/0x1e8
[ 1103.303577]        [<c131c335>] store+0x37/0x4a
[ 1103.308517]        [<c10c14a9>] sysfs_write_file+0x87/0xc1
[ 1103.314442]        [<c10801e8>] vfs_write+0xa6/0x170
[ 1103.319795]        [<c108089c>] sys_write+0x3d/0x64
[ 1103.325060]        [<c1003293>] syscall_call+0x7/0xb
[ 1103.330450]        [<b7cc9e0e>] 0xb7cc9e0e
[ 1103.334948]        [<ffffffff>] 0xffffffff
[ 1103.339453] 
[ 1103.339456] -> #2 (dbs_mutex){--..}:
[ 1103.347070]        [<c1042c21>] add_lock_to_list+0x39/0x91
[ 1103.347089]        [<c10454fc>] __lock_acquire+0xc65/0xd3a
[ 1103.347098]        [<c104562e>] lock_acquire+0x5d/0x79
[ 1103.347105]        [<c13ec1b2>] _mutex_lock+0x2b/0x38
[ 1103.347115]        [<c131cdba>] cpufreq_governor_dbs+0x10f/0x321
[ 1103.347124]        [<c131ae69>] __cpufreq_governor+0x22/0x15e
[ 1103.347134]        [<c131b426>] __cpufreq_set_policy+0xe6/0x135
[ 1103.347142]        [<c131b990>] store_scaling_governor+0xa8/0x1e8
[ 1103.347151]        [<c131c335>] store+0x37/0x4a
[ 1103.347158]        [<c10c14a9>] sysfs_write_file+0x87/0xc1
[ 1103.347167]        [<c10801e8>] vfs_write+0xa6/0x170
[ 1103.347176]        [<c108089c>] sys_write+0x3d/0x64
[ 1103.347184]        [<c1003293>] syscall_call+0x7/0xb
[ 1103.347192]        [<b7cc9e0e>] 0xb7cc9e0e
[ 1103.347212]        [<ffffffff>] 0xffffffff
[ 1103.347221] 
[ 1103.347222] -> #1 (&policy->lock){--..}:
[ 1103.347227]        [<c1042c21>] add_lock_to_list+0x39/0x91
[ 1103.347235]        [<c10454fc>] __lock_acquire+0xc65/0xd3a
[ 1103.347242]        [<c104562e>] lock_acquire+0x5d/0x79
[ 1103.347250]        [<c13ec1b2>] _mutex_lock+0x2b/0x38
[ 1103.347258]        [<c131b854>] cpufreq_set_policy+0x35/0x79
[ 1103.347266]        [<c131c0f5>] cpufreq_add_dev+0x2b4/0x451
[ 1103.347274]        [<c126734f>] sysdev_driver_register+0x59/0x96
[ 1103.347284]        [<c131c582>] cpufreq_register_driver+0x66/0xfc
[ 1103.347292]        [<c1630df9>] cpufreq_p4_init+0x3a/0x51
[ 1103.347301]        [<c10004b1>] init+0x128/0x3da
[ 1103.347308]        [<c1003f1b>] kernel_thread_helper+0x7/0x1c
[ 1103.347316]        [<ffffffff>] 0xffffffff
[ 1103.347371] 
[ 1103.347372] -> #0 (cpu_bitmask_lock){--..}:
[ 1103.347380]        [<c1043846>] print_circular_bug_tail+0x39/0x73
[ 1103.347389]        [<c1045375>] __lock_acquire+0xade/0xd3a
[ 1103.347397]        [<c104562e>] lock_acquire+0x5d/0x79
[ 1103.347404]        [<c13ec1b2>] _mutex_lock+0x2b/0x38
[ 1103.347412]        [<c104a085>] lock_cpu_hotplug+0x22/0x6d
[ 1103.347420]        [<c131bc31>] cpufreq_driver_target+0x27/0x5d
[ 1103.347429]        [<c131c2d9>] cpufreq_cpu_callback+0x47/0x6c
[ 1103.347437]        [<c1034fd6>] notifier_call_chain+0x2c/0x39
[ 1103.347446]        [<c1034fff>] raw_notifier_call_chain+0x8/0xa
[ 1103.347454]        [<c1049dc5>] _cpu_down+0x4c/0x25c
[ 1103.347463]        [<c104a1b5>] disable_nonboot_cpus+0x92/0x16d
[ 1103.347471]        [<c104fc39>] enter_state+0x72/0x1a6
[ 1103.347480]        [<c104fe10>] state_store+0xa3/0xac
[ 1103.347488]        [<c10c1170>] subsys_attr_store+0x20/0x25
[ 1103.347496]        [<c10c14a9>] sysfs_write_file+0x87/0xc1
[ 1103.347503]        [<c10801e8>] vfs_write+0xa6/0x170
[ 1103.347511]        [<c108089c>] sys_write+0x3d/0x64
[ 1103.347519]        [<c1003293>] syscall_call+0x7/0xb
[ 1103.347526]        [<b7e7be0e>] 0xb7e7be0e
[ 1103.347535]        [<ffffffff>] 0xffffffff
[ 1103.347544] 
[ 1103.347545] other info that might help us debug this:
[ 1103.347546] 
[ 1103.347549] 2 locks held by s2ram/6643:
[ 1103.347551]  #0:  (cpu_add_remove_lock){--..}, at: [<c104a136>] disable_nonboot_cpus+0x13/0x16d
[ 1103.347561]  #1:  (workqueue_mutex){--..}, at: [<c1038a2a>] workqueue_cpu_callback+0x1c6/0x299
[ 1103.347570] 
[ 1103.347571] stack backtrace:
[ 1103.347576]  [<c1004303>] dump_trace+0x1c1/0x1f0
[ 1103.347584]  [<c100434c>] show_trace_log_lvl+0x1a/0x30
[ 1103.347589]  [<c1004abd>] show_trace+0x12/0x14
[ 1103.347595]  [<c1004bde>] dump_stack+0x19/0x1b
[ 1103.347600]  [<c1043877>] print_circular_bug_tail+0x6a/0x73
[ 1103.347606]  [<c1045375>] __lock_acquire+0xade/0xd3a
[ 1103.347611]  [<c104562e>] lock_acquire+0x5d/0x79
[ 1103.347616]  [<c13ec1b2>] _mutex_lock+0x2b/0x38
[ 1103.347621]  [<c104a085>] lock_cpu_hotplug+0x22/0x6d
[ 1103.347627]  [<c131bc31>] cpufreq_driver_target+0x27/0x5d
[ 1103.347633]  [<c131c2d9>] cpufreq_cpu_callback+0x47/0x6c
[ 1103.347639]  [<c1034fd6>] notifier_call_chain+0x2c/0x39
[ 1103.347644]  [<c1034fff>] raw_notifier_call_chain+0x8/0xa
[ 1103.347651]  [<c1049dc5>] _cpu_down+0x4c/0x25c
[ 1103.347656]  [<c104a1b5>] disable_nonboot_cpus+0x92/0x16d
[ 1103.347662]  [<c104fc39>] enter_state+0x72/0x1a6
[ 1103.347668]  [<c104fe10>] state_store+0xa3/0xac
[ 1103.347674]  [<c10c1170>] subsys_attr_store+0x20/0x25
[ 1103.347679]  [<c10c14a9>] sysfs_write_file+0x87/0xc1
[ 1103.347684]  [<c10801e8>] vfs_write+0xa6/0x170
[ 1103.347690]  [<c108089c>] sys_write+0x3d/0x64
[ 1103.347695]  [<c1003293>] syscall_call+0x7/0xb
[ 1103.347701]  [<b7e7be0e>] 0xb7e7be0e
[ 1103.347706]  =======================


