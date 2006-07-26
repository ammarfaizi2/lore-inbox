Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWGZWgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWGZWgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWGZWgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:36:00 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:56024 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751197AbWGZWf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:35:59 -0400
To: Andrew Morton <akpm@osdl.org>
CC: Arjan van de Ven <arjan@linux.intel.com>, vatsa@in.ibm.com,
       torvalds@osdl.org, davej@redhat.com, mingo@elte.hu,
       76306.1226@compuserve.com, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	<Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	<20060725185449.GA8074@elte.hu>
	<1153855844.8932.56.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
	<1153921207.3381.21.camel@laptopd505.fenrus.org>
	<20060726155114.GA28945@redhat.com>
	<Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
	<1153942954.3381.50.camel@laptopd505.fenrus.org>
	<20060726204233.GA23488@in.ibm.com>
	<1153947786.3381.58.camel@laptopd505.fenrus.org>
	<1153947786.3381.58.camel@laptopd505.fenrus.org>
	<20060726143357.2f0787e7.akpm@osdl.org>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 26 Jul 2006 23:35:50 +0100
In-Reply-To: <20060726143357.2f0787e7.akpm@osdl.org>
Message-ID: <r6ejw8vvsp.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
> We should delete lock_cpu_hotplug() and start again.

Here is another example of possible lock_cpu_hotplug() problems.  Is
it worth tracking down, or should I just ignore the messages until a
proper solution is figured out?  The only problem is that it means S3
suspend doesn't work.

The hardware is a Thinkpad T60, T2400 dual-core, compiled with SMP and
PREEMPT, hotpluggable CPUs, and it has a SATA drive.  Kernel is
2.6.18-rc1.  Suspend (UP) worked with 2.6.15-25-386 from Ubuntu using
the same sleep.sh script.  The messages below, including the large
lockdep backtrace, occur after running sleep.sh (run by Fn-F4):


[  546.652000] Stopping tasks: ====================================================================================
[  566.848000]  stopping tasks timed out after 20 seconds (8 tasks remaining):
[  566.848000]   rt-test-0
[  566.848000]   rt-test-1
[  566.848000]   rt-test-2
[  566.848000]   rt-test-3
[  566.848000]   rt-test-4
[  566.848000]   rt-test-5
[  566.848000]   rt-test-6
[  566.848000]   rt-test-7

The lockdep code also reported problems:

[  538.292000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
[  546.144000] Freezing cpus ...
[  546.172000] 
[  546.172000] =======================================================
[  546.172000] [ INFO: possible circular locking dependency detected ]
[  546.172000] -------------------------------------------------------
[  546.172000] sleep.sh/15184 is trying to acquire lock:
[  546.172000]  (&policy->lock){--..}, at: [<c0310645>] mutex_lock+0x25/0x30
[  546.172000] 
[  546.172000] but task is already holding lock:
[  546.172000]  ((cpu_chain).rwsem){----}, at: [<c0133267>] blocking_notifier_call_chain+0x17/0x40
[  546.172000] 
[  546.172000] which lock already depends on the new lock.
[  546.172000] 
[  546.172000] 
[  546.172000] the existing dependency chain (in reverse order) is:
[  546.172000] 
[  546.172000] -> #2 ((cpu_chain).rwsem){----}:
[  546.172000]        [<c0142479>] lock_acquire+0x69/0x90
[  546.172000]        [<c013e08f>] down_read+0x4f/0x60
[  546.172000]        [<c0133267>] blocking_notifier_call_chain+0x17/0x40
[  546.172000]        [<c0147496>] cpu_up+0x76/0x110
[  546.172000]        [<c01005e5>] init+0x295/0x370
[  546.172000]        [<c0101005>] kernel_thread_helper+0x5/0x10
[  546.176000] 
[  546.176000] -> #1 (cpucontrol){--..}:
[  546.176000]        [<c0142479>] lock_acquire+0x69/0x90
[  546.176000]        [<c03103de>] __mutex_lock_slowpath+0x7e/0x2c0
[  546.176000]        [<c0310645>] mutex_lock+0x25/0x30
[  546.176000]        [<c01473c9>] __lock_cpu_hotplug+0x29/0x70
[  546.176000]        [<c014753a>] lock_cpu_hotplug+0xa/0x10
[  546.176000]        [<c02ae6cf>] __cpufreq_driver_target+0xf/0x60
[  546.176000]        [<c02b0218>] cpufreq_governor_performance+0x38/0x40
[  546.176000]        [<c02aee1c>] __cpufreq_governor+0x9c/0x1c0
[  546.176000]        [<c02af1d3>] __cpufreq_set_policy+0x103/0x150
[  546.180000]        [<c02af52e>] cpufreq_set_policy+0x4e/0x90
[  546.180000]        [<c02af871>] cpufreq_add_dev+0x301/0x5a0
[  546.180000]        [<c026685b>] sysdev_driver_register+0x7b/0xc0
[  546.180000]        [<c02af018>] cpufreq_register_driver+0x78/0x130
[  546.180000]        [<f899f04b>] 0xf899f04b
[  546.180000]        [<c014ae93>] sys_init_module+0xa3/0x210
[  546.180000]        [<c010339d>] sysenter_past_esp+0x56/0x8d
[  546.180000] 
[  546.180000] -> #0 (&policy->lock){--..}:
[  546.180000]        [<c0142479>] lock_acquire+0x69/0x90
[  546.180000]        [<c03103de>] __mutex_lock_slowpath+0x7e/0x2c0
[  546.184000]        [<c0310645>] mutex_lock+0x25/0x30
[  546.184000]        [<c02aecf2>] cpufreq_driver_target+0x32/0x70
[  546.184000]        [<c02afd54>] cpufreq_cpu_callback+0x64/0xb0
[  546.184000]        [<c01330e0>] notifier_call_chain+0x30/0x50
[  546.184000]        [<c0133275>] blocking_notifier_call_chain+0x25/0x40
[  546.184000]        [<c01475ca>] cpu_down+0x8a/0x2a0
[  546.184000]        [<c014cb51>] disable_nonboot_cpus+0x51/0xd0
[  546.184000]        [<c014bef7>] enter_state+0x67/0x1b0
[  546.184000]        [<c014c0df>] state_store+0x9f/0xb0
[  546.184000]        [<c01afb4e>] subsys_attr_store+0x2e/0x30
[  546.188000]        [<c01b0345>] sysfs_write_file+0xb5/0x100
[  546.188000]        [<c0171c67>] vfs_write+0xa7/0x190
[  546.188000]        [<c0172697>] sys_write+0x47/0x70
[  546.188000]        [<c010339d>] sysenter_past_esp+0x56/0x8d
[  546.188000] 
[  546.188000] other info that might help us debug this:
[  546.188000] 
[  546.188000] 2 locks held by sleep.sh/15184:
[  546.188000]  #0:  (cpucontrol){--..}, at: [<c0310355>] mutex_lock_interruptible+0x25/0x30
[  546.188000]  #1:  ((cpu_chain).rwsem){----}, at: [<c0133267>] blocking_notifier_call_chain+0x17/0x40
[  546.188000] 
[  546.188000] stack backtrace:
[  546.188000]  [<c0105c5b>] show_trace+0x1b/0x20
[  546.188000]  [<c0105c84>] dump_stack+0x24/0x30
[  546.188000]  [<c013fe41>] print_circular_bug_tail+0x61/0x70
[  546.188000]  [<c0141b77>] __lock_acquire+0x867/0xde0
[  546.188000]  [<c0142479>] lock_acquire+0x69/0x90
[  546.188000]  [<c03103de>] __mutex_lock_slowpath+0x7e/0x2c0
[  546.188000]  [<c0310645>] mutex_lock+0x25/0x30
[  546.188000]  [<c02aecf2>] cpufreq_driver_target+0x32/0x70
[  546.188000]  [<c02afd54>] cpufreq_cpu_callback+0x64/0xb0
[  546.188000]  [<c01330e0>] notifier_call_chain+0x30/0x50
[  546.192000]  [<c0133275>] blocking_notifier_call_chain+0x25/0x40
[  546.192000]  [<c01475ca>] cpu_down+0x8a/0x2a0
[  546.192000]  [<c014cb51>] disable_nonboot_cpus+0x51/0xd0
[  546.192000]  [<c014bef7>] enter_state+0x67/0x1b0
[  546.192000]  [<c014c0df>] state_store+0x9f/0xb0
[  546.192000]  [<c01afb4e>] subsys_attr_store+0x2e/0x30
[  546.192000]  [<c01b0345>] sysfs_write_file+0xb5/0x100
[  546.192000]  [<c0171c67>] vfs_write+0xa7/0x190
[  546.192000]  [<c0172697>] sys_write+0x47/0x70
[  546.192000]  [<c010339d>] sysenter_past_esp+0x56/0x8d
[  546.204000] Breaking affinity for irq 0
[  546.308000] CPU 1 is now offline
[  546.308000] lockdep: not fixing up alternatives.
[  546.652000] CPU1 is down
[  546.652000] Stopping tasks: ====================================================================================
[  566.848000]  stopping tasks timed out after 20 seconds (8 tasks remaining):
[  566.848000]   rt-test-0
[  566.848000]   rt-test-1
[  566.848000]   rt-test-2
[  566.848000]   rt-test-3
[  566.848000]   rt-test-4
[  566.848000]   rt-test-5
[  566.848000]   rt-test-6
[  566.848000]   rt-test-7
[  566.848000] Restarting tasks...<6> Strange, rt-test-0 not stopped
[  566.848000]  Strange, rt-test-1 not stopped
[  566.848000]  Strange, rt-test-2 not stopped
[  566.848000]  Strange, rt-test-3 not stopped
[  566.848000]  Strange, rt-test-4 not stopped
[  566.848000]  Strange, rt-test-5 not stopped
[  566.848000]  Strange, rt-test-6 not stopped
[  566.848000]  Strange, rt-test-7 not stopped
[  568.112000]  done
[  568.112000] Thawing cpus ...
[  568.464000] lockdep: not fixing up alternatives.
[  568.464000] Booting processor 1/1 eip 3000
[  568.472000] Initializing CPU#1
etc.
