Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752056AbWHNSd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbWHNSd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWHNSd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:33:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752049AbWHNSdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:33:25 -0400
Date: Mon, 14 Aug 2006 14:33:19 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: workqueue lockdep bug.
Message-ID: <20060814183319.GJ15569@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
 I merged the workqueue changes from -mm into the Fedora-devel kernel to
kill off those billion cpufreq lockdep warnings.  The bug has now mutated
into this:

(Trimmed version of log from  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202223)

		Dave

 > Breaking affinity for irq 185
 > Breaking affinity for irq 193
 > Breaking affinity for irq 209
 > CPU 1 is now offline
 > lockdep: not fixing up alternatives.
 > 
 > =======================================================
 > [ INFO: possible circular locking dependency detected ]
 > 2.6.17-1.2548.fc6 #1
 > -------------------------------------------------------
 > pm-hibernate/4335 is trying to acquire lock:
 >  ((cpu_chain).rwsem){..--}, at: [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
 > 
 > but task is already holding lock:
 >  (workqueue_mutex){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
 > 
 > which lock already depends on the new lock.
 > 
 > 
 > the existing dependency chain (in reverse order) is:
 > 
 > -> #1 (workqueue_mutex){--..}:
 >        [<c043c08e>] lock_acquire+0x4b/0x6d
 >        [<c06126b1>] __mutex_lock_slowpath+0xbc/0x20a
 >        [<c0612820>] mutex_lock+0x21/0x24
 >        [<c0433c25>] workqueue_cpu_callback+0xfd/0x1ee
 >        [<c0614ef5>] notifier_call_chain+0x20/0x31
 >        [<c0430fb0>] blocking_notifier_call_chain+0x1d/0x2d
 >        [<c043f4c5>] _cpu_down+0x47/0x1c4
 >        [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
 >        [<c0445b32>] prepare_processes+0xe/0x41
 >        [<c0445d87>] pm_suspend_disk+0x9/0xf3
 >        [<c0444e12>] enter_state+0x54/0x1b7
 >        [<c0444ffb>] state_store+0x86/0x9c
 >        [<c04a9f88>] subsys_attr_store+0x20/0x25
 >        [<c04aa08c>] sysfs_write_file+0xab/0xd1
 >        [<c04732cb>] vfs_write+0xab/0x157
 >        [<c0473910>] sys_write+0x3b/0x60
 >        [<c0403faf>] syscall_call+0x7/0xb
 > 
 > -> #0 ((cpu_chain).rwsem){..--}:
 >        [<c043c08e>] lock_acquire+0x4b/0x6d
 >        [<c04390a0>] down_read+0x2d/0x40
 >        [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
 >        [<c043f5aa>] _cpu_down+0x12c/0x1c4
 >        [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
 >        [<c0445b32>] prepare_processes+0xe/0x41
 >        [<c0445d87>] pm_suspend_disk+0x9/0xf3
 >        [<c0444e12>] enter_state+0x54/0x1b7
 >        [<c0444ffb>] state_store+0x86/0x9c
 >        [<c04a9f88>] subsys_attr_store+0x20/0x25
 >        [<c04aa08c>] sysfs_write_file+0xab/0xd1
 >        [<c04732cb>] vfs_write+0xab/0x157
 >        [<c0473910>] sys_write+0x3b/0x60
 >        [<c0403faf>] syscall_call+0x7/0xb
 > 
 > other info that might help us debug this:
 > 
 > 2 locks held by pm-hibernate/4335:
 >  #0:  (cpu_add_remove_lock){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
 >  #1:  (workqueue_mutex){--..}, at: [<c0612820>] mutex_lock+0x21/0x24
 > 
 > stack backtrace:
 >  [<c04051ee>] show_trace_log_lvl+0x58/0x159
 >  [<c04057ea>] show_trace+0xd/0x10
 >  [<c0405903>] dump_stack+0x19/0x1b
 >  [<c043b176>] print_circular_bug_tail+0x59/0x64
 >  [<c043b98e>] __lock_acquire+0x80d/0x99c
 >  [<c043c08e>] lock_acquire+0x4b/0x6d
 >  [<c04390a0>] down_read+0x2d/0x40
 >  [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
 >  [<c043f5aa>] _cpu_down+0x12c/0x1c4
 >  [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
 >  [<c0445b32>] prepare_processes+0xe/0x41
 >  [<c0445d87>] pm_suspend_disk+0x9/0xf3
 >  [<c0444e12>] enter_state+0x54/0x1b7
 >  [<c0444ffb>] state_store+0x86/0x9c
 >  [<c04a9f88>] subsys_attr_store+0x20/0x25
 >  [<c04aa08c>] sysfs_write_file+0xab/0xd1
 >  [<c04732cb>] vfs_write+0xab/0x157
 >  [<c0473910>] sys_write+0x3b/0x60
 >  [<c0403faf>] syscall_call+0x7/0xb
 > DWARF2 unwinder stuck at syscall_call+0x7/0xb
 > Leftover inexact backtrace:
 >  [<c04057ea>] show_trace+0xd/0x10
 >  [<c0405903>] dump_stack+0x19/0x1b
 >  [<c043b176>] print_circular_bug_tail+0x59/0x64
 >  [<c043b98e>] __lock_acquire+0x80d/0x99c
 >  [<c043c08e>] lock_acquire+0x4b/0x6d
 >  [<c04390a0>] down_read+0x2d/0x40
 >  [<c0430fa4>] blocking_notifier_call_chain+0x11/0x2d
 >  [<c043f5aa>] _cpu_down+0x12c/0x1c4
 >  [<c043f805>] disable_nonboot_cpus+0x9b/0x11a
 >  [<c0445b32>] prepare_processes+0xe/0x41
 >  [<c0445d87>] pm_suspend_disk+0x9/0xf3
 >  [<c0444e12>] enter_state+0x54/0x1b7
 >  [<c0444ffb>] state_store+0x86/0x9c
 >  [<c04a9f88>] subsys_attr_store+0x20/0x25
 >  [<c04aa08c>] sysfs_write_file+0xab/0xd1
 >  [<c04732cb>] vfs_write+0xab/0x157
 >  [<c0473910>] sys_write+0x3b/0x60
 >  [<c0403faf>] syscall_call+0x7/0xb
 > CPU1 is down
 > Stopping tasks:

-- 
http://www.codemonkey.org.uk
