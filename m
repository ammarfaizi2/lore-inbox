Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWFASK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWFASK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWFASK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:10:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:9206 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750790AbWFASKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:10:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U9Rq8jYBztNPMsyqjxHkP770tmXYnX1PgCrR2ghCiv+gQrx6zGxBRXtncA4XV5s8TTVzpiOMac/VSAKMBNPGF0TxDtJ796Zw0woOLiPy9WFfd40stcHcdSV0qP41AfPAan4enFfSjFxCRYpeCL7OKqyS+PTNhV/mFDIBEcinmrk=
Message-ID: <642640090606011108x48fa96e8t30b4644ca0eea821@mail.gmail.com>
Date: Thu, 1 Jun 2006 12:08:47 -0600
From: "Ryan McAvoy" <ryan.sed@gmail.com>
To: mingo@redhat.com
Subject: Deadlock with realtime-preempt patch-2.6.15-rt21 on mips processor
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to get a linux kernel running on a mips processor with the
realtime-preempt patches applied (2.6.15-rt21).  I have gotten it
running, but it is quite unstable and frequently hangs.  I have
tracked down one occurrence as a deadlock.  This one in particular
occurs when I send a break (eg: reBoot) via the serial console.

I have deadlock detection turned on, and got some output from it.
Please find it at the end of this message.

I believe it is caused by an attempt to lock the same spinlock twice
on one thread as follows (calls ordered from bottom to top):
     drivers/serial/8250.c:       serial8250_console_write <== Tries
to lock up->port.lock
     kernel/printk.c:             __call_console_drivers
     kernel/printk.c:             _call_console_drivers
     kernel/printk.c:             call_console_drivers
     kernel/printk.c:             release_console_sem
     kernel/printk.c:             vprintk
     kernel/printk.c:             printk
     drivers/char/sysrq.c:        __handle_sysrq
     drivers/char/sysrq.c:        handle_sysrq
     include/linux/serial_core.h: uart_handle_sysrq_char
     drivers/serial/8250.c:       receive_chars
     drivers/serial/8250.c:       serial8250_handle_port
     drivers/serial/8250.c:       serial8250_interrupt <== locks
up->port.lock prior to calling serial8250_handle_port
     ...


I am uncertain how to fix this problem.  Any assistance that could be
provided would be appreciated.  Please cc any response to me as I am
not subscribed to news groups.  Thanks.

Ryan McAvoy

    ==========================================
    [ BUG: lock recursion deadlock detected! |
    ------------------------------------------
    already locked:  [8033304c] {&port->lock}
    .. ->owner: 811a6e82
    .. held by:            IRQ 27:  105 [811a6e80,  56]
    ... acquired at:               -{current task's backtrace}----------------->
    Call Trace:
     [<80147d58>] check_deadlock+0x280/0x308
     [<80147d3c>] check_deadlock+0x264/0x308
     [<8012666c>] vprintk+0x324/0x3f8
     [<8011f24c>] activate_task+0x94/0xc8
     [<801f8b2c>] serial8250_console_write+0x7c/0x7b0
     [<80146124>] task_blocks_on_lock+0x3c/0x238
     [<8011fc80>] try_to_wake_up+0xa0/0x1f0
     [<8029b3e8>] ___down_mutex+0x310/0x5c0
     [<8011f24c>] activate_task+0x94/0xc8
     [<801f8b2c>] serial8250_console_write+0x7c/0x7b0
     [<80125ae0>] __call_console_drivers+0x80/0xb0
     [<80126108>] release_console_sem+0x128/0x368
     [<8012666c>] vprintk+0x324/0x3f8
     [<80126598>] vprintk+0x250/0x3f8
     [<8029b1f4>] ___down_mutex+0x11c/0x5c0
     [<8012675c>] printk+0x1c/0x28
     [<801f2158>] __handle_sysrq+0x68/0x178
     [<802f7000>] _sinittext+0x0/0x80
     [<801f66ac>] receive_chars+0x1ec/0x338
     [<80146390>] ____up_mutex+0x70/0x218
     [<801f6be8>] serial8250_interrupt+0x248/0x268
     [<80299ca0>] schedule+0x68/0x168
     [<80299830>] __schedule+0x5c8/0x9d0
     [<8014e4ec>] handle_IRQ_event+0xa4/0x1a8
     [<8014e5f8>] handle_simple_irq+0x0/0x138
     [<80299ca0>] schedule+0x68/0x168
     [<8014e5f8>] handle_simple_irq+0x0/0x138
     [<8014e730>] handle_level_irq+0x0/0x160
     [<8014f8c0>] do_irqd+0x160/0x378
     [<8014f760>] do_irqd+0x0/0x378
     [<80141058>] kthread+0x130/0x178
     [<80104030>] kernel_thread_helper+0x10/0x18
     [<80104020>] kernel_thread_helper+0x0/0x18

    showing all tasks:
    ?            init:    1 [80a73730, 116] (not blocked)
    S           IRQ 6:    2 [80a73298,  50] (not blocked)
    S          IRQ 21:    3 [80a72e00,  51] (not blocked)
    S  softirq-high/0:    4 [80a72968,  98] (not blocked)
    S softirq-timer/0:    5 [80a724d0,  98] (not blocked)
    S softirq-net-tx/:    6 [80a72038,  98] (not blocked)
    S softirq-net-rx/:    7 [87f89750,  98] (not blocked)
    S  softirq-scsi/0:    8 [87f892b8,  98] (not blocked)
    S softirq-tasklet:    9 [87f88e20,  98] (not blocked)
    S      watchdog/0:   10 [87f88988,   0] (not blocked)
    S       desched/0:   11 [87f884f0, 105] (not blocked)
    S        events/0:   12 [87f88058,  98] (not blocked)
    S         khelper:   13 [87fb1770, 110] (not blocked)
    S         kthread:   14 [87fb12d8, 110] (not blocked)
    S           IRQ 8:   15 [87fb0e40,  52] (not blocked)
    S           IRQ 9:   16 [87fb09a8,  53] (not blocked)
    S       kblockd/0:   17 [87fb0510, 120] (not blocked)
    S          IRQ 28:   19 [8118d790,  54] (not blocked)
    S         pdflush:   38 [8118c9c8, 125] (not blocked)
    S         pdflush:   39 [8118d2f8, 115] (not blocked)
    S           aio/0:   41 [87fb0078, 120] (not blocked)
    S         kswapd0:   40 [811a77b0, 125] (not blocked)
    S       mtdblockd:   76 [8118ce60, 115] (not blocked)
    S           IRQ 2:  104 [8118c098,  55] (not blocked)
    D          IRQ 27:  105 [811a6e80,  56] (not blocked)
    S           udevd:  121 [811a69e8, 111] (not blocked)
    S           klogd:  399 [87d03338, 125] (not blocked)
    S         syslogd:  402 [87d02a08, 116] (not blocked)
    S          thttpd:  413 [811a60b8, 116] (not blocked)
    S              sh:  421 [8118c530, 115] (not blocked)

    =============================================

    [ turning off deadlock detection.Please report this trace. ]
