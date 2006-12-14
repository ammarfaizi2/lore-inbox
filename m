Return-Path: <linux-kernel-owner+w=401wt.eu-S932644AbWLNLjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWLNLjd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWLNLjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:39:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:52034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932644AbWLNLjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:39:32 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19.1-rt14-smp circular locking dependency
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, davej@codemonkey.org.uk
In-Reply-To: <20061214095926.GA19549@elte.hu>
References: <1166090243.7147.10.camel@Homer.simpson.net>
	 <20061214095926.GA19549@elte.hu>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 12:39:26 +0100
Message-Id: <1166096366.6560.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:59 +0100, Ingo Molnar wrote: 
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > Greetings,
> > 
> > Lockdep doesn't approve of cpufreq, and seemingly with cause... I had 
> > to poke SysRq-O.
> 
> hm ... this must be an upstream problem too, right? -rt shouldnt change 
> anything in this area (in theory).

Yeah, it is.  It didn't seize up, but lockdep griped.  Trace from
2.6.19.1 below, cc added.

[  129.309689] Disabling non-boot CPUs ...
[  129.335627] 
[  129.335631] =======================================================
[  129.343584] [ INFO: possible circular locking dependency detected ]
[  129.350028] 2.6.19.1-smp #77
[  129.352973] -------------------------------------------------------
[  129.359379] s2ram/6178 is trying to acquire lock:
[  129.364178]  (cpu_bitmask_lock){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[  129.371298] 
[  129.371300] but task is already holding lock:
[  129.377274]  (workqueue_mutex){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[  129.384277] 
[  129.384279] which lock already depends on the new lock.
[  129.384281] 
[  129.392647] 
[  129.392649] the existing dependency chain (in reverse order) is:
[  129.400294] 
[  129.400296] -> #3 (workqueue_mutex){--..}:
[  129.406083]        [<c103dd54>] add_lock_to_list+0x3b/0x87
[  129.411895]        [<c1040420>] __lock_acquire+0xb75/0xc1a
[  129.417697]        [<c10407f1>] lock_acquire+0x5d/0x79
[  129.423135]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[  129.429470]        [<c13e23dd>] mutex_lock+0x8/0xa
[  129.434562]        [<c1035815>] __create_workqueue+0x5f/0x16c
[  129.440615]        [<c1312a83>] cpufreq_governor_dbs+0x2d6/0x32c
[  129.446943]        [<c131073e>] __cpufreq_governor+0x22/0x166
[  129.453009]        [<c13112d9>] __cpufreq_set_policy+0xe6/0x132
[  129.459267]        [<c131153a>] store_scaling_governor+0xa8/0x1e8
[  129.465676]        [<c1310dbc>] store+0x37/0x4a
[  129.470517]        [<c10b743c>] sysfs_write_file+0x8a/0xcb
[  129.476301]        [<c1077bb8>] vfs_write+0xa6/0x170
[  129.481584]        [<c107826c>] sys_write+0x3d/0x64
[  129.486761]        [<c1003173>] syscall_call+0x7/0xb
[  129.492018]        [<b7bece0e>] 0xb7bece0e
[  129.496389]        [<ffffffff>] 0xffffffff
[  129.500789] 
[  129.500791] -> #2 (dbs_mutex){--..}:
[  129.508253]        [<c103dd54>] add_lock_to_list+0x3b/0x87
[  129.516360]        [<c1040420>] __lock_acquire+0xb75/0xc1a
[  129.524405]        [<c10407f1>] lock_acquire+0x5d/0x79
[  129.532057]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[  129.540608]        [<c13e23dd>] mutex_lock+0x8/0xa
[  129.547856]        [<c13128bc>] cpufreq_governor_dbs+0x10f/0x32c
[  129.556348]        [<c131073e>] __cpufreq_governor+0x22/0x166
[  129.564548]        [<c13112d9>] __cpufreq_set_policy+0xe6/0x132
[  129.572865]        [<c131153a>] store_scaling_governor+0xa8/0x1e8
[  129.581379]        [<c1310dbc>] store+0x37/0x4a
[  129.588249]        [<c10b743c>] sysfs_write_file+0x8a/0xcb
[  129.596053]        [<c1077bb8>] vfs_write+0xa6/0x170
[  129.603290]        [<c107826c>] sys_write+0x3d/0x64
[  129.610398]        [<c1003173>] syscall_call+0x7/0xb
[  129.617624]        [<b7bece0e>] 0xb7bece0e
[  129.623954]        [<ffffffff>] 0xffffffff
[  129.630230] 
[  129.630232] -> #1 (&policy->lock){--..}:
[  129.639563]        [<c103dd54>] add_lock_to_list+0x3b/0x87
[  129.647225]        [<c1040420>] __lock_acquire+0xb75/0xc1a
[  129.654928]        [<c10407f1>] lock_acquire+0x5d/0x79
[  129.662217]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[  129.670439]        [<c13e23dd>] mutex_lock+0x8/0xa
[  129.677387]        [<c131144e>] cpufreq_set_policy+0x35/0x79
[  129.685230]        [<c1311a79>] cpufreq_add_dev+0x2b8/0x461
[  129.692970]        [<c1264128>] sysdev_driver_register+0x63/0xaa
[  129.701152]        [<c1311d58>] cpufreq_register_driver+0x68/0xfd
[  129.709430]        [<c1610cf9>] cpufreq_p4_init+0x3a/0x51
[  129.717006]        [<c100049b>] init+0x112/0x311
[  129.723784]        [<c1003dff>] kernel_thread_helper+0x7/0x18
[  129.731709]        [<ffffffff>] 0xffffffff
[  129.738040] 
[  129.738042] -> #0 (cpu_bitmask_lock){--..}:
[  129.747694]        [<c103f875>] print_circular_bug_tail+0x30/0x66
[  129.756036]        [<c1040231>] __lock_acquire+0x986/0xc1a
[  129.763786]        [<c10407f1>] lock_acquire+0x5d/0x79
[  129.771202]        [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[  129.779450]        [<c13e23dd>] mutex_lock+0x8/0xa
[  129.786496]        [<c1044326>] lock_cpu_hotplug+0x22/0x82
[  129.794243]        [<c131110b>] cpufreq_driver_target+0x27/0x5d
[  129.802449]        [<c1311c69>] cpufreq_cpu_callback+0x47/0x6c
[  129.810548]        [<c1032316>] notifier_call_chain+0x2c/0x39
[  129.818555]        [<c103233f>] raw_notifier_call_chain+0x8/0xa
[  129.826752]        [<c10440a9>] _cpu_down+0x4c/0x219
[  129.833942]        [<c1044483>] disable_nonboot_cpus+0x92/0x14b
[  129.842105]        [<c1049e2a>] enter_state+0x7e/0x1bc
[  129.849530]        [<c104a00b>] state_store+0xa3/0xac
[  129.856813]        [<c10b7110>] subsys_attr_store+0x20/0x25
[  129.864627]        [<c10b743c>] sysfs_write_file+0x8a/0xcb
[  129.872403]        [<c1077bb8>] vfs_write+0xa6/0x170
[  129.879661]        [<c107826c>] sys_write+0x3d/0x64
[  129.886801]        [<c1003173>] syscall_call+0x7/0xb
[  129.894041]        [<b7e63e0e>] 0xb7e63e0e
[  129.900412]        [<ffffffff>] 0xffffffff
[  129.906765] 
[  129.906766] other info that might help us debug this:
[  129.906768] 
[  129.920864] 2 locks held by s2ram/6178:
[  129.926703]  #0:  (cpu_add_remove_lock){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[  129.936543]  #1:  (workqueue_mutex){--..}, at: [<c13e23dd>] mutex_lock+0x8/0xa
[  129.946078] 
[  129.946080] stack backtrace:
[  129.954729]  [<c10041e3>] dump_trace+0x1c1/0x1f0
[  129.961574]  [<c100422c>] show_trace_log_lvl+0x1a/0x30
[  129.968917]  [<c1004967>] show_trace+0x12/0x14
[  129.975548]  [<c1004a88>] dump_stack+0x19/0x1b
[  129.982177]  [<c103f8a2>] print_circular_bug_tail+0x5d/0x66
[  129.989940]  [<c1040231>] __lock_acquire+0x986/0xc1a
[  129.997109]  [<c10407f1>] lock_acquire+0x5d/0x79
[  130.003939]  [<c13e21ad>] __mutex_lock_slowpath+0x6e/0x296
[  130.011630]  [<c13e23dd>] mutex_lock+0x8/0xa
[  130.018086]  [<c1044326>] lock_cpu_hotplug+0x22/0x82
[  130.025259]  [<c131110b>] cpufreq_driver_target+0x27/0x5d
[  130.032885]  [<c1311c69>] cpufreq_cpu_callback+0x47/0x6c
[  130.040410]  [<c1032316>] notifier_call_chain+0x2c/0x39
[  130.047832]  [<c103233f>] raw_notifier_call_chain+0x8/0xa
[  130.055434]  [<c10440a9>] _cpu_down+0x4c/0x219
[  130.062068]  [<c1044483>] disable_nonboot_cpus+0x92/0x14b
[  130.069682]  [<c1049e2a>] enter_state+0x7e/0x1bc
[  130.076490]  [<c104a00b>] state_store+0xa3/0xac
[  130.083188]  [<c10b7110>] subsys_attr_store+0x20/0x25
[  130.090443]  [<c10b743c>] sysfs_write_file+0x8a/0xcb
[  130.097596]  [<c1077bb8>] vfs_write+0xa6/0x170
[  130.104259]  [<c107826c>] sys_write+0x3d/0x64
[  130.110772]  [<c1003173>] syscall_call+0x7/0xb
[  130.117385]  [<b7e63e0e>] 0xb7e63e0e
[  130.123129]  =======================
[  130.191611] CPU 1 is now offline
[  130.200482] lockdep: not fixing up alternatives.
[  130.407367] CPU1 is down


