Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVGFVPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVGFVPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVGFVPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:15:25 -0400
Received: from unused.mind.net ([69.9.134.98]:57294 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262553AbVGFVNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:13:35 -0400
Date: Wed, 6 Jul 2005 14:12:36 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
In-Reply-To: <20050706100451.GA7336@elte.hu>
Message-ID: <Pine.LNX.4.58.0507061110270.18016@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Ingo Molnar wrote:

> i have digged out an older HT-box .config of yours and have reproduced 
> an assert quite similar to the one above. Found one bug in that area: 
> the assert (conditional on RT_DEADLOCK_DETECT) was done a bit too early, 
> i have fixed this in my tree and have uploaded -51-02.

On -51-06, the vlc+dd test works ok (video is a bit choppy after the third
dd instance).  With the vlc+burnP6 test, the keyboard is lost first (for
everything except SysRq), then the serial console (for everything except
SysRq), then the mouse.  SysRq-I hangs X, but brings the serial console
back for a while.  At this point, I should be able to get more debug info 
than previously.

FWIW, I got this stack dump with SysRq-K:

SysRq : SAK
IRQ 4/307[CPU#0]: BUG in set_palette at drivers/char/vt.c:2918
 [<c0103ea7>] dump_stack+0x23/0x25 (20)
 [<c0121550>] __WARN_ON+0x66/0x86 (52)
 [<c02975df>] set_palette+0x5a/0x5c (24)
 [<c02980a8>] __handle_sysrq+0x9a/0x139 (48)
 [<c029817f>] handle_sysrq+0x38/0x3a (24)
 [<c02b40bf>] receive_chars+0x250/0x2ec (60)
 [<c02b4474>] serial8250_nterrupt+0xea/0x101 (44)
 [<c014b85b>] handle_IRQ_event+0x71/0xef (52)
 [<c014bfcb>] do_hardirq+0x53/0xda (40)
 [<c014c128>] do_irqd+0xd6/0x1d4 (40)
 [<c0136736>] kthread+0xb6/0xba (44)
 [<c01010c1>] kernel_thread_helper+0x5/0xb (556269596)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c01406ba>] .... add_preempt_count+0x1c/0x1e
.....[<c012150b>] ..   ( <= __WARN_ON+0x21/0x86)
.. [<c01406ba>] .... add_preempt_count+0x1c/0x1e
.....[<c01416d4>] ..   ( <= print_traces+0x1b/0x52)

------------------------------
| showing all locks held by: |  (IRQ 4/307 [ded7d930,  57]):
-----------------------------

#001:             [c087b2d0] {&irq_lists[i].lock}
... acquired at:  serial8250_interrupt+0x16/0x101

#002:             [c087ed40] {&port->lock}
... acquired at:  serial8250_interrupt+0x62/0x101

#003:             [c04bf380] {sysrq_key_table_lock}
... acquired at:  __handle_sysrq+0x2a/0x139

SysRq : Terminate All Tasks
SysRq : Kill All Tasks
SysRq : Emergency Sync
Emergency Sync complete
SysRq : Emergency Remount R/O
Emergency Remount complete
SysRq : SAK
IRQ 1/298[CPU#1]: BUG in set_palette at drivers/char/vt.c:2918
 [<c0103ea7>] dump_stack+0x23/0x25 (20)
 [<c0121550>] __WARN_ON+0x66/0x86 (52)
 [<c02975df>] set_palette+0x5a/0x5c (24)
 [<c02980a8>] __handle_sysrq+0x9a/0x139 (48)
 [<c029817f>] handle_sysrq+0x38/0x3a (24)
 [<c02928d3>] kbd_event+0xb9/0xdc (40)
 [<c02f2f06>] input_event+0xe6/0x478 (44)
 [<c02f6c45>] atkbd_report_key+0x3c/0xd4 (32)
 [<c02f6eb8>] atkbd_interrupt+0x1db/0x65f (56)
 [<c02adb6a>] serio_interrupt+0x49/0x8f (40)
 [<c02ae8a6>] i8042_interrupt+0x12a/0x238 (56)
 [<c014b85b>] handle_IRQ_event+0x71/0xef (52)
 [<c014bfcb>] do_hardirq+0x53/0xda (40)
 [<c014c128>] do_irqd+0xd6/0x1d4 (40)
 [<c0136736>] kthread+0xb6/0xba (44)
 [<c01010c1>] kernel_thread_helper+0x5/0xb (557096988)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c01406ba>] .... add_preempt_count+0x1c/0x1e
.....[<c012150b>] ..   ( <= __WARN_ON+0x21/0x86)
.. [<c01406ba>] .... add_preempt_count+0x1c/0x1e
.....[<c01416d4>] ..   ( <= print_traces+0x1b/0x52)

------------------------------
| showing all locks held by: |  (IRQ 1/298 [c14c2cb0,  56]):
------------------------------

#001:             [dec8404c] {&serio->lock}
... acquired at:  serio_interrupt+0x1f/0x8f

#002:             [c04bf380] {sysrq_key_table_lock}
... acquired at:  __handle_sysrq+0x2a/0x139

SysRq : Resetting


> > BTW, -50-44 through -50-51 wouldn't compile on the UP Athlon box.  

Correction:  There were a couple that wouldn't compile in there (-50-49
was one of them).  -50-48 and -51-01 on the Athlon give me a lot of these
with debugging enabled:

Jul  6 01:09:08 astarte kernel: delayed_work_timer_fn+0x1d/0x20softirq-timer/0/3[CPU#0]: BUG in ____up_mutex at kernel/rt.c:1302
Jul  6 01:09:08 astarte kernel:  [<c0104313>] dump_stack+0x23/0x30 (20)
Jul  6 01:09:08 astarte kernel:  [<c0120857>] __WARN_ON+0x77/0xc0 (56)
Jul  6 01:09:08 astarte kernel:  [<c013de4c>] rt_up+0x30c/0x470 (40)
Jul  6 01:09:08 astarte kernel:  [<c01201d2>] release_console_sem+0xc2/0x140 (36)
Jul  6 01:09:08 astarte kernel:  [<c011ff10>] vprintk+0x180/0x2a0 (120)
Jul  6 01:09:08 astarte kernel:  [<c011fd8d>] printk+0x1d/0x20 (16)
Jul  6 01:09:08 astarte kernel:  [<c01461d3>] __print_symbol+0x93/0x110 (400)
Jul  6 01:09:08 astarte kernel:  [<c01041e9>] show_trace+0x79/0xe0 (36)
Jul  6 01:09:08 astarte kernel:  [<c0104313>] dump_stack+0x23/0x30 (20)
Jul  6 01:09:08 astarte kernel:  [<c0120857>] __WARN_ON+0x77/0xc0 (56)
Jul  6 01:09:08 astarte kernel:  [<c013c989>] up_mutex+0x1f9/0x470 (36)
Jul  6 01:09:08 astarte kernel:  [<c0130ecd>] delayed_work_timer_fn+0x1d/0x20 (16)
Jul  6 01:09:08 astarte kernel:  [<c0129948>] run_timer_softirq+0x1f8/0x420 (56)
Jul  6 01:09:08 astarte kernel:  [<c012577f>] ksoftirqd+0xcf/0x170 (28)
Jul  6 01:09:08 astarte kernel:  [<c0135df6>] kthread+0xa6/0xe0 (48)
Jul  6 01:09:08 astarte kernel:  [<c01013e9>] kernel_thread_helper+0x5/0xc (537083932)
Jul  6 01:09:08 astarte kernel: ---------------------------
Jul  6 01:09:08 astarte kernel: | preempt count: 00000004 ]
Jul  6 01:09:08 astarte kernel: | 4-level deep critical section nesting:
Jul  6 01:09:08 astarte kernel: ----------------------------------------
Jul  6 01:09:08 astarte kernel: .. [<c014040c>] .... add_preempt_count+0x1c/0x20
Jul  6 01:09:08 astarte kernel: .....[<c012080f>] ..   ( <= __WARN_ON+0x2f/0xc0)
Jul  6 01:09:08 astarte kernel: .. [<c013db78>] .... rt_up+0x38/0x470
Jul  6 01:09:08 astarte kernel: .....[<c01201d2>] ..   ( <= release_console_sem+0xc2/0x140)
Jul  6 01:09:08 astarte kernel: .. [<c014040c>] .... add_preempt_count+0x1c/0x20
Jul  6 01:09:08 astarte kernel: .....[<c012080f>] ..   ( <= __WARN_ON+0x2f/0xc0)
Jul  6 01:09:08 astarte kernel: .. [<c014040c>] .... add_preempt_count+0x1c/0x20
Jul  6 01:09:08 astarte kernel: .....[<c014133b>] ..   ( <= print_traces+0x1b/0x60)
Jul  6 01:09:08 astarte kernel: 
Jul  6 01:09:09 astarte kernel: ------------------------------
Jul  6 01:09:09 astarte kernel: | showing all locks held by: |  (softirq-timer/0/3 [dffc2c90,  98]):
Jul  6 01:09:09 astarte kernel: ------------------------------

> do the 51-02 (and later) kernels work on the UP Athlon box?

I'll try out -51-06 (or later) on the UP Athlon when I get home.


--ww

