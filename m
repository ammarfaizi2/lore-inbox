Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWHVMKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWHVMKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHVMKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:10:52 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:39774 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932185AbWHVMKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:10:52 -0400
Date: Tue, 22 Aug 2006 14:10:42 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Lockdep message on workqueue_mutex
Message-ID: <20060822121042.GA29577@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

git commit 9b41ea7289a589993d3daabc61f999b4147872c4 causes the lockdep
message below on cpu hotplug (git kernel of today).

We have:

cpu_down (takes cpu_add_remove_lock)
[CPU_DOWN_PREPARE]
blocking_notifier_call_chain (takes (cpu_chain).rwsem)
workqueue_cpu_callback (takes workqueue_mutex)
blocking_notifier_call_chain (releases (cpu_chain).rwsem)
[CPU_DEAD]
blocking_notifier_call_chain (takes (cpu_chain).rwsem)
                              ^^^^^^^^^^^^^^^^^^^^^^^
-> reverse locking order, since we still hold workqueue_mutex.

But since all of this is protected by the cpu_add_remove_lock this looks
legal. Well, at least it's safe as long as no other cpu callback function
does anything that will take the workqueue_mutex as well.

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
bash/1308 is trying to acquire lock:
 ((cpu_chain).rwsem){..--}, at: [<0000000000139b5a>] blocking_notifier_call_chain+0x32/0x64

but task is already holding lock:
 (workqueue_mutex){--..}, at: [<000000000043e312>] mutex_lock+0x3e/0x4c

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (workqueue_mutex){--..}:
       [<000000000014b55c>] __lock_acquire+0x7e0/0xedc
       [<000000000014c202>] lock_acquire+0x9a/0xc8
       [<000000000043df82>] __mutex_lock_slowpath+0xb6/0x408
       [<000000000043e312>] mutex_lock+0x3e/0x4c
       [<000000000013e2ca>] workqueue_cpu_callback+0xf6/0x374
       [<00000000001398c0>] notifier_call_chain+0x54/0x78
       [<0000000000139b6c>] blocking_notifier_call_chain+0x44/0x64
       [<0000000000151f9c>] cpu_down+0xb8/0x34c
       [<0000000000295e9c>] store_online+0x60/0xc0
       [<00000000002905dc>] sysdev_store+0x40/0x58
       [<00000000001e2536>] sysfs_write_file+0x106/0x1ac
       [<000000000018dd44>] vfs_write+0xa8/0x188
       [<000000000018df02>] sys_write+0x56/0x88
       [<000000000010ce58>] sysc_noemu+0x10/0x16
       [<0000020000107e24>] 0x20000107e24

-> #0 ((cpu_chain).rwsem){..--}:
       [<000000000014b3cc>] __lock_acquire+0x650/0xedc
       [<000000000014c202>] lock_acquire+0x9a/0xc8
       [<0000000000147480>] down_read+0x54/0x9c
       [<0000000000139b5a>] blocking_notifier_call_chain+0x32/0x64
       [<00000000001520e4>] cpu_down+0x200/0x34c
       [<0000000000295e9c>] store_online+0x60/0xc0
       [<00000000002905dc>] sysdev_store+0x40/0x58
       [<00000000001e2536>] sysfs_write_file+0x106/0x1ac
       [<000000000018dd44>] vfs_write+0xa8/0x188
       [<000000000018df02>] sys_write+0x56/0x88
       [<000000000010ce58>] sysc_noemu+0x10/0x16
       [<0000020000107e24>] 0x20000107e24

other info that might help us debug this:

2 locks held by bash/1308:
 #0:  (cpu_add_remove_lock){--..}, at: [<000000000043e312>] mutex_lock+0x3e/0x4c
 #1:  (workqueue_mutex){--..}, at: [<000000000043e312>] mutex_lock+0x3e/0x4c

stack backtrace:
0441e8b900000000 4141e8b900000000 3ff2c76e1deacc92 0000000000000000 
       0000000000000000 000000000047f878 000000000047f878 0000000000103a42 
       0000000000000000 0000000000000000 0000000000000000 00000000006025a0 
       0000000000000000 000000000000000d 000000000e3b7a48 000000000e3b7ac0 
       000000000044eee0 0000000000103a42 000000000e3b7a48 000000000e3b7a98 
Call Trace:
([<00000000001039a8>] show_trace+0xc0/0xdc)
 [<0000000000103a64>] show_stack+0xa0/0xd0
 [<0000000000103ac2>] dump_stack+0x2e/0x3c
 [<0000000000149184>] print_circular_bug_tail+0x98/0xac
 [<000000000014b3cc>] __lock_acquire+0x650/0xedc
 [<000000000014c202>] lock_acquire+0x9a/0xc8
 [<0000000000147480>] down_read+0x54/0x9c
 [<0000000000139b5a>] blocking_notifier_call_chain+0x32/0x64
 [<00000000001520e4>] cpu_down+0x200/0x34c
 [<0000000000295e9c>] store_online+0x60/0xc0
 [<00000000002905dc>] sysdev_store+0x40/0x58
 [<00000000001e2536>] sysfs_write_file+0x106/0x1ac
 [<000000000018dd44>] vfs_write+0xa8/0x188
 [<000000000018df02>] sys_write+0x56/0x88
 [<000000000010ce58>] sysc_noemu+0x10/0x16
 [<0000020000107e24>] 0x20000107e24
