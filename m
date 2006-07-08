Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWGHQ2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWGHQ2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWGHQ2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:28:08 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:2700 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S964892AbWGHQ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:28:06 -0400
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1) 
In-Reply-To: Your message of "Sat, 08 Jul 2006 10:17:57 +0200."
             <200607081017.57969.rjw@sisk.pl> 
X-Mailer: MH-E 7.85; nmh 1.1; GNU Emacs 21.4.1
Date: Sat, 08 Jul 2006 12:22:45 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FzFZt-0005Hn-NC@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d4781dbd447b997114ed9ac4b1b5b095401b8aa789d13042a52a350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Added LKML to the CC: since lockdep reports more problems when the S3
suspend fails.  The hardware is a TP T60, T2400 dual-core, compiled with
SMP and PREEMPT, SATA drive, and now also compiled with hotpluggable
CPUs.  Kernel is 2.6.18-rc1.  Suspend worked with 2.6.15-25-386 from
Ubuntu using the same sleep.sh script.]

<http://forum.thinkpads.com/viewtopic.php?t=19031> had a useful
suggestion to get suspend working on SMP: enable hotpluggable CPUs.
Should SMP + ACPI enable it?  Or maybe enable it once it is not an
experimental feature?

Anyway I tried it and made progress.  The suspend got farther but failed
with:

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
[  568.552000] Calibrating delay using timer specific routine.. 3657.74 BogoMIPS (lpj=7315481)
[  568.552000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[  568.552000] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[  568.552000] monitor/mwait feature present.
[  568.552000] CPU: L1 I cache: 32K, L1 D cache: 32K
[  568.552000] CPU: L2 cache: 2048K
[  568.552000] CPU: Physical Processor ID: 0
[  568.552000] CPU: Processor Core ID: 1
[  568.552000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000940 0000c1a9 00000000 00000000
[  568.552000] CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
[  568.556000] CPU1 is up
[  570.952000] Intel(R) PRO/1000 Network Driver - version 7.0.38-k4
[  570.952000] Copyright (c) 1999-2006 Intel Corporation.
[  570.956000] PCI: Enabling device 0000:02:00.0 (0100 -> 0103)
[  570.956000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
[  570.956000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[  571.020000] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:41:52:50:de
[  571.088000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[  575.476000] ACPI: Power Button (FF) [PWRF]
[  575.476000] ACPI: Lid Switch [LID]
[  575.476000] ACPI: Sleep Button (CM) [SLPB]
[  575.516000] ACPI: Thermal Zone [THM0] (58 C)
[  575.516000] ACPI: Thermal Zone [THM1] (59 C)
[  575.784000] ACPI: AC Adapter [AC] (on-line)
[  577.120000] ACPI: Battery Slot [BAT0] (battery present)
