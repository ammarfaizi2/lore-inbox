Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUIMSqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUIMSqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268851AbUIMSqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:46:24 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:27058 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S268849AbUIMSqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:46:02 -0400
Date: Mon, 13 Sep 2004 14:45:32 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Screwed up locking?
Message-ID: <Pine.GSO.4.33.0409131432330.10693-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere past 2.6.6 somebody screwed something up big time.  It looks like
*something* is grabbing a kernel lock and never letting go (or being
prempted.)  The system is stable for a while (in this case ~12 hours)
and then:
bad: scheduling while atomic!
 [<c02dbc24>] schedule+0xb24/0xb30
 [<c014190e>] __alloc_pages+0x1ce/0x370
 [<c0272527>] sock_aio_write+0x137/0x150
 [<c0222d6d>] n_tty_chars_in_buffer+0x3d/0x80
 [<c02dc13d>] schedule_timeout+0xbd/0xc0
 [<c0221163>] tty_poll+0x83/0xa0
 [<c01704be>] do_select+0x19e/0x2d0
 [<c0170170>] __pollwait+0x0/0xd0
 [<c0170907>] sys_select+0x2e7/0x540
 [<c010536b>] syscall_call+0x7/0xb
...
bad: scheduling while atomic!
 [<c02dbc24>] schedule+0xb24/0xb30
 [<c02db3a1>] schedule+0x2a1/0xb30
 [<c01306c8>] rcu_check_quiescent_state+0x78/0x90
 [<c011166b>] mark_offset_tsc+0x1fb/0x350
 [<c0224c80>] read_chan+0x0/0x820
 [<c02dbc66>] preempt_schedule+0x36/0x60
 [<c0224e0e>] read_chan+0x18e/0x820
 [<c0107ce4>] handle_IRQ_event+0x34/0x70
 [<c011b570>] default_wake_function+0x0/0x20
 [<c021f860>] tty_read+0x0/0x160
 [<c011b570>] default_wake_function+0x0/0x20
 [<c02dc5ef>] _spin_lock+0x6f/0x90
 [<c0224c80>] read_chan+0x0/0x820
 [<c021f99c>] tty_read+0x13c/0x160
 [<c0170865>] sys_select+0x245/0x540
 [<c015c070>] vfs_read+0xe0/0x150
 [<c012b103>] sigprocmask+0x63/0xd0
 [<c015c371>] sys_read+0x51/0x80
 [<c010536b>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c02dbc24>] schedule+0xb24/0xb30
 [<c011b5d1>] __wake_up_common+0x41/0x60
 [<c011b634>] __wake_up+0x44/0x60
 [<c02dbc66>] preempt_schedule+0x36/0x60
 [<c0226505>] pty_unthrottle+0x45/0x70
 [<c0222c3b>] check_unthrottle+0x3b/0x40
 [<c022518e>] read_chan+0x50e/0x820
 [<c0107ce4>] handle_IRQ_event+0x34/0x70
 [<c011b570>] default_wake_function+0x0/0x20
 [<c021f860>] tty_read+0x0/0x160
 [<c011b570>] default_wake_function+0x0/0x20
 [<c02dc5ef>] _spin_lock+0x6f/0x90
 [<c0224c80>] read_chan+0x0/0x820
 [<c021f99c>] tty_read+0x13c/0x160
 [<c0170865>] sys_select+0x245/0x540
 [<c015c070>] vfs_read+0xe0/0x150
 [<c012b103>] sigprocmask+0x63/0xd0
 [<c015c371>] sys_read+0x51/0x80
 [<c010536b>] syscall_call+0x7/0xb
...

Every keypress in my ssh session leave one of those on the console.  When
the connection closes, the system panics:

(Here we go again... I thought the interleaved panic BS was fixed.)

Warning: kfree_skb on hard IRQ c029e511
Warning: kfree_skb on hard IRQ c029e3cc
bad: scheduling while atomic!
 [<c02dbc 2s4>ys] _rsecahedd+ul0ex5+01x/0b2x840/
xb 3[0<                                         0
0 10[5<c39021>5c]0 8w9or>]k _rvefss_chreedad+0+x05x/f09x/016x
50                                                           1
rn e[<l cp0a1n2ibc10 3-> ]no sti gspyrnocicnmgas:k +A0ixee63,/ k0xidll0i
g  [i<cn0te15rrc3up71t >h]andler!                                       n

Once the locks are messed up, the system is doomed.

Version: 2.6.9-SMP-rc1 SMP BK[20040913014622] (preempt enabled)
System: Dual Athlon MP 1600 (Tyan Tiger MP)

I'm rebuilding with the current tree (BK[20040913174343]) with preempt turned
off.  If that fails, I'll enable lock debugging.

--Ricky


