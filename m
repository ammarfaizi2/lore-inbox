Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUCQS3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCQS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:29:22 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:61082 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261920AbUCQS3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:29:16 -0500
Date: Wed, 17 Mar 2004 10:29:00 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: OOPS when force unloading sctp with CONFIG_DEBUG_SLAB enabled
Message-ID: <Pine.LNX.4.58.0403171008560.2014@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the following oops when force unloading sctp (rmmod -f sctp) with
2.6.5-rc1 and 2.6.4.  This happens only when CONFIG_DEBUG_SLAB is enabled.

This used to work fine until 2.6.3.

looks like somehow a freed task struct is getting dereferenced in
try_to_wake_up() and it causes oops when debug memory allocations is enabled.
The call sequence seems to be
	sys_delete_module
	cleanup_module
	sock_release
	module_put
	wake_up_process
	try_to_wake_up

Thanks
Sridhar

Mar 17 08:31:40 w-sridhar kernel: Unable to handle kernel paging request at virtual address 6b6b6b7b
Mar 17 08:31:40 w-sridhar kernel:  printing eip:
Mar 17 08:31:40 w-sridhar kernel: c011ad39
Mar 17 08:31:40 w-sridhar kernel: *pde = 00000000
Mar 17 08:31:40 w-sridhar kernel: Oops: 0000 [#1]
Mar 17 08:31:40 w-sridhar kernel: PREEMPT SMP
Mar 17 08:31:40 w-sridhar kernel: CPU:    0
Mar 17 08:31:40 w-sridhar kernel: EIP:    0060:[<c011ad39>]    Tainted: GF
Mar 17 08:31:40 w-sridhar kernel: EFLAGS: 00010086   (2.6.5-rc1)
Mar 17 08:31:40 w-sridhar kernel: EIP is at try_to_wake_up+0x29/0x310
Mar 17 08:31:40 w-sridhar kernel: eax: 6b6b6b6b   ebx: c041cc80   ecx: ccc66da4   edx: cdc258a0
Mar 17 08:31:40 w-sridhar kernel: esi: cdc7c000   edi: c041cc80   ebp: cdc7df18   esp: cdc7def4
Mar 17 08:31:40 w-sridhar kernel: ds: 007b   es: 007b   ss: 0068
Mar 17 08:31:40 w-sridhar kernel: Process rmmod (pid: 1636, threadinfo=cdc7c000 task=cde2a140)
Mar 17 08:31:40 w-sridhar kernel: Stack: d08e2300 cdc7df14 c02bde4c cfcd9304 00000000 00000282 cdf1e5bc cdc7c000
Mar 17 08:31:40 w-sridhar kernel:        d08e2300 cdc7df2c c011b03e cdc258a0 00000007 00000000 cdc7df44 c02bac4a
Mar 17 08:31:40 w-sridhar kernel:        cdf1e5bc c03843b8 d08e2300 00000a80 cdc7df54 d08d6f24 cdf1e5bc 00000a80
Mar 17 08:31:40 w-sridhar kernel: Call Trace:
Mar 17 08:31:40 w-sridhar kernel:  [<c02bde4c>] sk_free+0x6c/0xf0
Mar 17 08:31:40 w-sridhar kernel:  [<c011b03e>] wake_up_process+0x1e/0x30
Mar 17 08:31:40 w-sridhar kernel:  [<c02bac4a>] sock_release+0xea/0xf0
Mar 17 08:31:40 w-sridhar kernel:  [<d08d6f24>] cleanup_module+0x24/0x1d5 [sctp]
Mar 17 08:31:40 w-sridhar kernel:  [<c013dbd4>] sys_delete_module+0x174/0x1d0
Mar 17 08:31:40 w-sridhar kernel:  [<c0157d18>] sys_munmap+0x58/0x80
Mar 17 08:31:40 w-sridhar kernel:  [<c0107adf>] syscall_call+0x7/0xb
Mar 17 08:31:40 w-sridhar kernel:
Mar 17 08:31:40 w-sridhar kernel: Code: 8b 40 10 8b 14 85 20 f0 41 c0 ff 46 14 01 d7 31 c0 86 07 84
Mar 17 08:31:40 w-sridhar kernel:  <6>note: rmmod[1636] exited with preempt_count 1
Mar 17 08:31:40 w-sridhar kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Mar 17 08:31:40 w-sridhar kernel: in_atomic():1, irqs_disabled():0
Mar 17 08:31:40 w-sridhar kernel: Call Trace:
Mar 17 08:31:40 w-sridhar kernel:  [<c011f46b>] __might_sleep+0xab/0xd0
Mar 17 08:31:40 w-sridhar kernel:  [<c0123b02>] profile_exit_task+0x22/0x60
Mar 17 08:31:40 w-sridhar kernel:  [<c0125a9a>] do_exit+0x7a/0x610
Mar 17 08:31:40 w-sridhar kernel:  [<c0108cd0>] do_divide_error+0x0/0xf0
Mar 17 08:31:40 w-sridhar kernel:  [<c0119855>] do_page_fault+0x215/0x58a
Mar 17 08:31:40 w-sridhar kernel:  [<c011a934>] recalc_task_prio+0xb4/0x1f0
Mar 17 08:31:40 w-sridhar kernel:  [<c011c9f9>] schedule+0x3a9/0x7b0
Mar 17 08:31:40 w-sridhar kernel:  [<c011bfe3>] scheduler_tick+0x43/0x6a0
Mar 17 08:31:40 w-sridhar kernel:  [<c0119640>] do_page_fault+0x0/0x58a
Mar 17 08:31:40 w-sridhar kernel:  [<c0108569>] error_code+0x2d/0x38
Mar 17 08:31:40 w-sridhar kernel:  [<c02b007b>] atkbd_connect+0x19b/0x420
Mar 17 08:31:40 w-sridhar kernel:  [<c011ad39>] try_to_wake_up+0x29/0x310
Mar 17 08:31:40 w-sridhar kernel:  [<c02bde4c>] sk_free+0x6c/0xf0
Mar 17 08:31:40 w-sridhar kernel:  [<c011b03e>] wake_up_process+0x1e/0x30
Mar 17 08:31:40 w-sridhar kernel:  [<c02bac4a>] sock_release+0xea/0xf0
Mar 17 08:31:40 w-sridhar kernel:  [<d08d6f24>] cleanup_module+0x24/0x1d5 [sctp]
Mar 17 08:31:40 w-sridhar kernel:  [<c013dbd4>] sys_delete_module+0x174/0x1d0
Mar 17 08:31:40 w-sridhar kernel:  [<c0157d18>] sys_munmap+0x58/0x80
Mar 17 08:31:40 w-sridhar kernel:  [<c0107adf>] syscall_call+0x7/0xb

