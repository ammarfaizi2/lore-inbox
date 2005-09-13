Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVIMH6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVIMH6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIMH6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:58:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23008 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932431AbVIMH6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:58:37 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc1 BUG: spinlock wrong owner on CPU#0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Sep 2005 17:58:30 +1000
Message-ID: <26068.1126598310@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.6.14-rc1 on ia64, I sometimes get

BUG: spinlock wrong owner on CPU#0, swapper/1
 lock: e000003003014940, .magic: dead4ead, .owner: pdflush/75, .owner_cpu: 0

The first line is always swapper/1, the .owner varies between pdflush
and migration/1.  Backtrace is

0xe0000034f7890000        1        0  1    0   R  0xe0000034f7890300 *swapper
0xa000000100012fc0 dump_stack
        args (0xa0000001007f8550, 0xe000003003014940, 0xdead4ead, 0xe0000030064d02d4, 0x4b)
0xa0000001003f6650 spin_bug+0x130
        args (0xe000003003014940, 0xa0000001007f85b0, 0xe0000030064d0000, 0xa0000001003f6710, 0x308)
0xa0000001003f6710 _raw_spin_unlock+0x90
        args (0xe000003003014940, 0xe00000300301494c, 0xe000003003014950, 0xa000000100713ac0, 0x286)
0xa000000100713ac0 _spin_unlock_irqrestore+0x20
        args (0xe000003003014940, 0x10085a2010, 0xa0000001000a2470, 0x894, 0xe0000034f7988030)
0xa0000001000a2470 try_to_wake_up+0x8f0
        args (0xe0000034f7897cf0, 0x3, 0x6e, 0x6e, 0xe000003003014940)
0xa0000001000a2530 default_wake_function+0x30
        args (0xe0000034f798fdc0, 0x3, 0x0, 0xa00000010009a530, 0x50e)
0xa00000010009a530 __wake_up_common+0x90
        args (0xe0000034f7980050, 0x3, 0x1, 0x0, 0x0)
0xa0000001000a46b0 __wake_up+0x50
        args (0xe0000034f7980038, 0x3, 0x1, 0x0, 0x10085a2010)
0xa0000001000d72c0 __queue_work+0xa0
        args (0xe0000034f7980000, 0xe0000034f7897d80, 0x10085a6010, 0xa0000001000d8bd0, 0x309)
0xa0000001000d8bd0 queue_work+0xf0
        args (0xe0000034f7980000, 0xe0000034f7897d80, 0x1, 0xa0000001000e2e40, 0x610)
0xa0000001000e2e40 kthread_create+0x300
        args (0xe0000034f7897d48, 0xe0000034f7897d10, 0xa0000001007e1ed8, 0x10, 0xe0000034f7897e30)
0xa00000010010f1f0 start_one_pdflush_thread+0x30
        args (0xa000000100876d90, 0x183, 0xe000003003400000)
0xa000000100876d90 pdflush_init+0x30
        args (0xa000000100009640, 0x690, 0x0)
0xa000000100009640 init+0x3a0
        args (0xa0000001008aaaa0, 0x1, 0xa0000001009dc508, 0xa0000001009dc520, 0xa0000001009dc530)
0xa000000100010b60 kernel_thread_helper+0xe0
        args (0xa0000001008430d0, 0x0, 0xa000000100009120, 0x2, 0xa000000100bdb150)
0xa000000100009120 start_kernel_thread+0x20
        args (0xa0000001008430d0, 0x0)

or

BUG: spinlock wrong owner on CPU#0, swapper/1
 lock: e000003003014940, .magic: dead4ead, .owner: migration/1/5, .owner_cpu: 0

Call Trace:
 [<a000000100012720>] show_stack+0x80/0xa0
                                sp=e0000034f7897c50 bsp=e0000034f7891070
 [<a000000100012ff0>] dump_stack+0x30/0x60
                                sp=e0000034f7897e20 bsp=e0000034f7891058
 [<a0000001003f6650>] spin_bug+0x130/0x160
                                sp=e0000034f7897e20 bsp=e0000034f7891028
 [<a0000001003f6710>] _raw_spin_unlock+0x90/0x120
                                sp=e0000034f7897e20 bsp=e0000034f7890ff0
 [<a000000100711ae0>] _spin_unlock_irqrestore+0x20/0xa0
                                sp=e0000034f7897e20 bsp=e0000034f7890fc8
 [<a0000001000a2470>] try_to_wake_up+0x8f0/0x980
                                sp=e0000034f7897e20 bsp=e0000034f7890f40
 [<a0000001000a25f0>] wake_up_process+0x30/0x60
                                sp=e0000034f7897e30 bsp=e0000034f7890f20
 [<a0000001000baf60>] cpu_callback+0x1e0/0x240
                                sp=e0000034f7897e30 bsp=e0000034f7890ee8
 [<a0000001000d0360>] notifier_call_chain+0xe0/0x140
                                sp=e0000034f7897e30 bsp=e0000034f7890eb0
 [<a0000001000ebe30>] cpu_up+0x2d0/0x360
                                sp=e0000034f7897e30 bsp=e0000034f7890e58
 [<a0000001000094a0>] init+0x200/0x840
                                sp=e0000034f7897e30 bsp=e0000034f7890de8
 [<a000000100010b60>] kernel_thread_helper+0xe0/0x100
                                sp=e0000034f7897e30 bsp=e0000034f7890dc0
 [<a000000100009120>] start_kernel_thread+0x20/0x40
                                sp=e0000034f7897e30 bsp=e0000034f7890dc0


And no, I am not calling curr_task() or set_curr_task() anywhere before
this trace appears ...

DEBUG_KERNEL=y
MAGIC_SYSRQ=y
LOG_BUF_SHIFT=20
DETECT_SOFTLOCKUP=y
DEBUG_SLAB=y
DEBUG_PREEMPT=y
DEBUG_SPINLOCK=y
DEBUG_SPINLOCK_SLEEP=y
DEBUG_KOBJECT=y
DEBUG_INFO=y
DEBUG_FS=y
KDB=y
KDB_MODULES=y
KDB_CONTINUE_CATASTROPHIC=0

