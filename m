Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWKOCZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWKOCZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbWKOCZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:25:51 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:10998 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751452AbWKOCZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:25:50 -0500
Subject: -rt patch scheduler w/ BKL
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 14 Nov 2006 18:25:33 -0800
Message-Id: <1163557533.9173.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current -rt patch changes the scheduler so that the BKL is no longer
properly reacquired. If SPINLOCK_BKL is selected it's possible for
reacquire_kernel_lock() to return without acquiring the BKL, in vanilla
linux the return value of that function is evaluated, but in -rt that
code is removed. The result is that if __schedule gets recalled on
TIF_NEED_RESCHED the BKL will be released unconditionally ..

The following error is an example of the issue with spinlock debugging.
It happens pretty quickly when using NFS root ..

BUG: spinlock wrong owner on CPU#0, hotplug/699
 lock: 803c5840, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
Call Trace:
 [<8033e964>] _raw_spin_unlock+0xb8/0xd0
 [<8033e964>] _raw_spin_unlock+0xb8/0xd0
 [<8033c134>] schedule+0x48/0x128
 [<8033c134>] schedule+0x48/0x128
 [<8033ba90>] __schedule+0x7fc/0xcc4
 [<803278f8>] xprt_timer+0x0/0xb0
 [<8033e3dc>] __spin_lock_irqsave+0x30/0x44
 [<802adad0>] kernel_sendmsg+0x24/0x38
 [<8033e64c>] __spin_unlock_irqrestore+0x14/0x48
 [<8032c468>] rpc_wait_bit_interruptible+0x2c/0x40
 [<8032c43c>] rpc_wait_bit_interruptible+0x0/0x40
 [<8033c134>] schedule+0x48/0x128
 [<80141324>] prepare_to_wait+0x34/0x90
 [<8032c468>] rpc_wait_bit_interruptible+0x2c/0x40
 [<8032755c>] __xprt_lock_write_next_cong+0xac/0xcc
 [<8032ba00>] rpc_sleep_on+0x40/0x60
 [<8033cf50>] __wait_on_bit+0xbc/0x128
 [<8033cf14>] __wait_on_bit+0x80/0x128
 [<80327494>] xprt_end_transmit+0x40/0x5c
 [<80327494>] xprt_end_transmit+0x40/0x5c
 [<8032c43c>] rpc_wait_bit_interruptible+0x0/0x40
 [<8033d038>] out_of_line_wait_on_bit+0x7c/0x98
 [<80324fe0>] call_transmit_status+0x30/0x48
 [<801fe370>] nfs_xdr_fhandle+0x0/0x54
 [<80141178>] wake_bit_function+0x0/0x5c
 [<8032c7b0>] __rpc_execute+0x168/0x2bc
 [<8032c6e0>] __rpc_execute+0x98/0x2bc
 [<80325374>] rpc_call_setup+0x90/0x98
 [<803254c0>] rpc_call_sync+0xf4/0x110
 [<801fa568>] nfs_wait_schedule+0x0/0x40
 [<801ffef8>] nfs_proc_getattr+0x6c/0xc4
 [<80135b94>] sigprocmask+0x180/0x220
 [<80141178>] wake_bit_function+0x0/0x5c
 [<801fa730>] __nfs_revalidate_inode+0x188/0x320
 [<8015a6ac>] __generic_file_aio_read+0x108/0x2f4
 [<80181124>] do_sync_read+0xdc/0x16c
 [<801f9478>] nfs_file_open+0x0/0x9c
 [<80204878>] nfs_sync_inode_wait+0x90/0x230
 [<801fb424>] nfs_getattr+0xd0/0xd8
 [<8017f400>] do_filp_open+0x5c/0x78
 [<8018ee88>] vfs_fstat+0x34/0x58
 [<8018ee6c>] vfs_fstat+0x18/0x58
 [<8018eecc>] sys_fstat64+0x20/0x48
 [<80181e14>] vfs_read+0x11c/0x1a0
 [<801822e4>] remote_llseek+0x94/0x18c
 [<8017bbb0>] kmem_cache_free+0x80/0xd4
 [<80182680>] sys_read+0x7c/0x110
 [<80182634>] sys_read+0x30/0x110
 [<8017f4fc>] do_sys_open+0xe0/0x138
 [<8010bcdc>] syscall_trace_entry+0x70/0x90
 [<8010bcdc>] syscall_trace_entry+0x70/0x90


So I would imagine the solution is to put back the code that is in
vanilla linux which uses a "goto" to essentially reschedule avoided this
issue. However, I have no idea why the scheduler was changed to
schedule() --> __schedule() and the BKL checks removed, which is the
reason for this email ..

So anyone have thoughts on this?

Daniel

