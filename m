Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbTEOMzD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 08:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTEOMzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 08:55:03 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:33042 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263994AbTEOMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 08:54:59 -0400
Date: Thu, 15 May 2003 15:14:36 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: linux-kernel@vger.kernel.org
cc: Jean Tourrilhes <jt@hpl.hp.com>, DevilKin <devilkin-ml@blindguardian.org>
Subject: [2.5.69] rtnl-deadlock with usermodehelper and keventd
Message-ID: <Pine.LNX.4.44.0305151443180.1435-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

seems we may run into mutual deadlock in the unregister_netdev() path with 
CONFIG_HOTPLUG=y. I managed to reproduce an irda-user report leading to 
the following description:

* killing irattach (userland daemon comparable to pppd) starts closing the
  irda tty-ldisc

* there we call unregister_netdev() on behalf of the (already closed) 
  irda0 network device.

* unregister_netdev() takes rtnl_lock

* further down in unregister_netdevice() with CONFIG_HOTPLUG the network 
  layers wants to call userland hotplug stuff

* the request to fork the usermodehelper gets queued for the event/0 
  workqueue (aka keventd) and we are blocking with rtnl still acquired for 
  completion.

* at this moment for some reason keventd has a linkwatch_event() 
  apparently already scheduled before the usermode helper. So we run into
  linkwatch_event() with tries to get rtnl_lock.

-> mutual deadlock: keventd waiting for rtnl_lock which is still hold by 
unregister_netdev blocking for completion of work scheduled for keventd.

I can reproduce this with 2.5.69 with CONFIG_HOTPLUG enabled, no matter 
what /proc/sys/kernel/hotplug is, even /bin/true is sufficient. I've no 
idea why I get this with irda0 but not with eth0 for example.
FWIW kernel is SMP running on UP without preempt.

As I don't see how the irda stuff could cause unregister_netdev() to 
schedule the hotplug stuff with some linkwatch_event already scheduled 
I've no idea what the real problem and fix might be.

Below a commented calltrace catched right when it hangs as described.

Thanks
Martin

-----------------------------

> May 14 13:14:17 laptop kernel: events/0      D C12FDF04 412092     3      1             4     2 (L-TLB)
> May 14 13:14:17 laptop kernel: Call Trace:
> May 14 13:14:17 laptop kernel:  [__down+150/256] __down+0x96/0x100
> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
> May 14 13:14:17 laptop kernel:  [.text.lock.rtnetlink+5/54] .text.lock.rtnetlink+0x5/0x36
> May 14 13:14:17 laptop kernel:  [linkwatch_event+29/48] linkwatch_event+0x1d/0x30
> May 14 13:14:17 laptop kernel:  [worker_thread+511/736] worker_thread+0x1ff/0x2e0
> May 14 13:14:17 laptop kernel:  [linkwatch_event+0/48] linkwatch_event+0x0/0x30
> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [worker_thread+0/736] worker_thread+0x0/0x2e0
> May 14 13:14:17 laptop kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

This is the keventd-thread. It has some work scheduled for the network 
layer, namely linkwatch_event(). This is currently blocking to get the 
rtnl_lock semaphore.


> May 14 13:14:17 laptop kernel: irattach      D 00000000 4283667124   400      1           537   396 (NOTLB)
> May 14 13:14:17 laptop kernel: Call Trace:
> May 14 13:14:17 laptop kernel:  [try_to_wake_up+296/464] try_to_wake_up+0x128/0x1d0
> May 14 13:14:17 laptop kernel:  [wait_for_completion+153/224] wait_for_completion+0x99/0xe0

(5)

> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [queue_work+132/160] queue_work+0x84/0xa0

(4)

> May 14 13:14:17 laptop kernel:  [call_usermodehelper+257/272] call_usermodehelper+0x101/0x110
> May 14 13:14:17 laptop kernel:  [__call_usermodehelper+0/112] __call_usermodehelper+0x0/0x70
> May 14 13:14:17 laptop kernel:  [vsprintf+39/48] vsprintf+0x27/0x30
> May 14 13:14:17 laptop kernel:  [sprintf+31/48] sprintf+0x1f/0x30
> May 14 13:14:17 laptop kernel:  [net_run_sbin_hotplug+174/195] net_run_sbin_hotplug+0xae/0xc3

(3)

> May 14 13:14:17 laptop kernel:  [try_to_wake_up+296/464] try_to_wake_up+0x128/0x1d0
> May 14 13:14:17 laptop kernel:  [pfifo_fast_reset+158/160] pfifo_fast_reset+0x9e/0xa0
> May 14 13:14:17 laptop kernel:  [qdisc_destroy+158/160] qdisc_destroy+0x9e/0xa0
> May 14 13:14:17 laptop kernel:  [unregister_netdevice+211/608] unregister_netdevice+0xd3/0x260
> May 14 13:14:17 laptop kernel:  [_end+282800068/1070304612] sirdev_dtor+0x0/0x20 [sir_dev]

(2)

> May 14 13:14:17 laptop kernel:  [unregister_netdev+24/48] unregister_netdev+0x18/0x30

(1)

> May 14 13:14:17 laptop kernel:  [_end+282800429/1070304612] sirdev_put_instance+0x149/0x1ad [sir_dev]
> May 14 13:14:17 laptop kernel:  [_end+282804705/1070304612] __func__.9+0x0/0x14 [sir_dev]
> May 14 13:14:17 laptop kernel:  [_end+282131315/1070304612] irtty_close+0x4f/0x120 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [tty_set_ldisc+1091/1200] tty_set_ldisc+0x443/0x4b0
> May 14 13:14:17 laptop kernel:  [uart_wait_until_sent+144/224] uart_wait_until_sent+0x90/0xe0
> May 14 13:14:17 laptop kernel:  [tty_wait_until_sent+243/272] tty_wait_until_sent+0xf3/0x110
> May 14 13:14:17 laptop kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
> May 14 13:14:17 laptop kernel:  [sock_destroy_inode+27/32] sock_destroy_inode+0x1b/0x20
> May 14 13:14:17 laptop kernel:  [_end+282132178/1070304612] +0x15a/0x16c [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282130740/1070304612] irtty_open+0x0/0x1f0 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282131236/1070304612] irtty_close+0x0/0x120 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282130132/1070304612] irtty_ioctl+0x0/0x260 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282129076/1070304612] irtty_receive_buf+0x0/0xc0 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282129268/1070304612] irtty_receive_room+0x0/0x30 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282129316/1070304612] irtty_write_wakeup+0x0/0x40 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [_end+282134820/1070304612] +0x0/0xe0 [irtty_sir]
> May 14 13:14:17 laptop kernel:  [sys_ioctl+256/656] sys_ioctl+0x100/0x290
> May 14 13:14:17 laptop kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Ok, nice trace btw: The last printk from sir_dev was at (1) before we 
called unregister_netdev() - which in turn acquired rtnl_lock (2). Due to 
the disappearing irda0 device (and CONFIG_HOTPLUG=y) the network layer 
decided to call the hotplug stuff (3). For this to fork the usermode 
helper, it scheduled some work for keventd (4). Finally we are blocking 
for completion until keventd finishes wait4 usermodehelper (5).

Unfortunately we are blocking for completion with rtnl still locked and 
keventd apparently having the linkwatch_event() scheduled before the 
usermodehelper -> mutual deadlock between irattach and keventd!

