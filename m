Return-Path: <linux-kernel-owner+w=401wt.eu-S1751595AbXAHRSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbXAHRSR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbXAHRSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 12:18:17 -0500
Received: from CHOKECHERRY.SRV.CS.CMU.EDU ([128.2.185.41]:48819 "EHLO
	chokecherry.srv.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596AbXAHRSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 12:18:16 -0500
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 12:18:16 EST
Date: Mon, 8 Jan 2007 12:07:19 -0500
From: Benjamin Gilbert <bgilbert@cs.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Failure to release lock after CPU hot-unplug canceled
Message-Id: <20070108120719.16d4674e.bgilbert@cs.cmu.edu>
Organization: Carnegie Mellon University
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a module returns NOTIFY_BAD to a CPU_DOWN_PREPARE callback, subsequent
attempts to take a CPU down cause the write into sysfs to wedge.

This is reproducible in 2.6.20-rc4, but was originally found in 2.6.18.5.

Steps to reproduce:

1.  Load the test module included below
2.  Run the following shell commands as root:

echo 0 > /sys/devices/system/cpu/cpu1/online
echo 0 > /sys/devices/system/cpu/cpu1/online

The second echo command hangs in uninterruptible sleep during the write()
call, and the following appears in dmesg:

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.20-rc4-686 #1
-------------------------------------------------------
bash/1699 is trying to acquire lock:
 (cpu_add_remove_lock){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (workqueue_mutex){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (workqueue_mutex){--..}:
       [<c01374b9>] __lock_acquire+0x912/0xa34
       [<c01378f6>] lock_acquire+0x67/0x8a
       [<c037900d>] __mutex_lock_slowpath+0xf6/0x2b8
       [<c03791eb>] mutex_lock+0x1c/0x1f
       [<c012dc27>] workqueue_cpu_callback+0x10b/0x20c
       [<c037c687>] notifier_call_chain+0x20/0x31
       [<c012a907>] raw_notifier_call_chain+0x8/0xa
       [<c013aa10>] _cpu_down+0x47/0x1f8
       [<c013abe7>] cpu_down+0x26/0x38
       [<c0296462>] store_online+0x27/0x5a
       [<c02935f4>] sysdev_store+0x20/0x25
       [<c0190da1>] sysfs_write_file+0xb3/0xdb
       [<c01602d9>] vfs_write+0xaf/0x163
       [<c0160925>] sys_write+0x3d/0x61
       [<c0102d88>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

-> #1 (cache_chain_mutex){--..}:
       [<c01374b9>] __lock_acquire+0x912/0xa34
       [<c01378f6>] lock_acquire+0x67/0x8a
       [<c037900d>] __mutex_lock_slowpath+0xf6/0x2b8
       [<c03791eb>] mutex_lock+0x1c/0x1f
       [<c015dc0d>] cpuup_callback+0x29/0x2d3
       [<c037c687>] notifier_call_chain+0x20/0x31
       [<c012a907>] raw_notifier_call_chain+0x8/0xa
       [<c013a869>] _cpu_up+0x3d/0xbf
       [<c013a911>] cpu_up+0x26/0x38
       [<c010045e>] init+0x7d/0x2d9
       [<c0103a3f>] kernel_thread_helper+0x7/0x10
       [<ffffffff>] 0xffffffff

-> #0 (cpu_add_remove_lock){--..}:
       [<c01373ba>] __lock_acquire+0x813/0xa34
       [<c01378f6>] lock_acquire+0x67/0x8a
       [<c037900d>] __mutex_lock_slowpath+0xf6/0x2b8
       [<c03791eb>] mutex_lock+0x1c/0x1f
       [<c013abd2>] cpu_down+0x11/0x38
       [<c0296462>] store_online+0x27/0x5a
       [<c02935f4>] sysdev_store+0x20/0x25
       [<c0190da1>] sysfs_write_file+0xb3/0xdb
       [<c01602d9>] vfs_write+0xaf/0x163
       [<c0160925>] sys_write+0x3d/0x61
       [<c0102d88>] syscall_call+0x7/0xb
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

2 locks held by bash/1699:
 #0:  (cache_chain_mutex){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f
 #1:  (workqueue_mutex){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c0103dcd>] show_trace_log_lvl+0x1a/0x2f
 [<c01043f4>] show_trace+0x12/0x14
 [<c01044a6>] dump_stack+0x16/0x18
 [<c0135c99>] print_circular_bug_tail+0x5f/0x68
 [<c01373ba>] __lock_acquire+0x813/0xa34
 [<c01378f6>] lock_acquire+0x67/0x8a
 [<c037900d>] __mutex_lock_slowpath+0xf6/0x2b8
 [<c03791eb>] mutex_lock+0x1c/0x1f
 [<c013abd2>] cpu_down+0x11/0x38
 [<c0296462>] store_online+0x27/0x5a
 [<c02935f4>] sysdev_store+0x20/0x25
 [<c0190da1>] sysfs_write_file+0xb3/0xdb
 [<c01602d9>] vfs_write+0xaf/0x163
 [<c0160925>] sys_write+0x3d/0x61
 [<c0102d88>] syscall_call+0x7/0xb
 =======================

Exiting the bash process after the first echo command instead results in
the following:

=====================================
[ BUG: lock held at task exit time! ]
-------------------------------------
bash/1547 is exiting with locks still held!
2 locks held by bash/1547:
 #0:  (cache_chain_mutex){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f
 #1:  (workqueue_mutex){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c0103dcd>] show_trace_log_lvl+0x1a/0x2f
 [<c01043f4>] show_trace+0x12/0x14
 [<c01044a6>] dump_stack+0x16/0x18
 [<c01358ba>] debug_check_no_locks_held+0x80/0x86
 [<c01217ed>] do_exit+0x6bf/0x6f5
 [<c0121893>] sys_exit_group+0x0/0x11
 [<c01218a2>] sys_exit_group+0xf/0x11
 [<c0102d88>] syscall_call+0x7/0xb
 =======================

If I can provide any other information to help track this down, please let
me know.

--Benjamin Gilbert

8<---------------------------------------------------------->8

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/cpu.h>

static int cpu_callback(struct notifier_block *nb, unsigned long action,
			void *data)
{
	int cpu=(int)data;
	
	switch (action) {
	case CPU_DOWN_PREPARE:
		printk(KERN_DEBUG "Refusing shutdown of CPU %d\n", cpu);
		return NOTIFY_BAD;
	case CPU_DEAD:
		printk(KERN_DEBUG "CPU %d down\n", cpu);
		break;
	}
	return NOTIFY_OK;
}

static struct notifier_block cpu_notifier = {
	.notifier_call = cpu_callback
};

int __init mod_start(void)
{
	int err;
	
	err=register_cpu_notifier(&cpu_notifier);
	if (err)
		return err;
	return 0;
}
module_init(mod_start);

void __exit mod_shutdown(void)
{
	unregister_cpu_notifier(&cpu_notifier);
}
module_exit(mod_shutdown);

MODULE_LICENSE("GPL");
