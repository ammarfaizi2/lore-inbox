Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWIKPce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWIKPce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWIKPce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:32:34 -0400
Received: from maggie.spheresystems.co.uk ([82.71.70.17]:8639 "EHLO
	maggie.spheresystems.co.uk") by vger.kernel.org with ESMTP
	id S1751304AbWIKPcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:32:33 -0400
From: "Andrew Bird (Sphere Systems)" <ajb@spheresystems.co.uk>
Organization: Sphere Systems Ltd
To: linux-kernel@vger.kernel.org
Subject: Spinlock debugging
Date: Mon, 11 Sep 2006 16:32:27 +0100
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111632.27484.ajb@spheresystems.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	this is my first post to the list, so please be kind. I am working on the 
nozomi (UMTS modem) driver, which is not in the main kernel.
I have a issue with the tty code. Currently the driver defines a 'put_char' 
tty function but it is empty, except for a debug message. Now I know that 
this means that the tty layer will use it to write single chars and so data 
will be lost. But if I comment out the line that tells the tty layer that 
it's implemented, I end up with a BUG - spinlock recursion. Can anybody tell 
me how to interpret the output?

Thanks and please CC as I'm not subscribed to the list

Andrew


[856] nozomi_read_config_table(): Initialization OK!
BUG: spinlock recursion on CPU#0, minicom/1918
 lock: dc4fade4, .magic: dead4ead, .owner: minicom/1918, .owner_cpu: 0
 [<c01bb897>] _raw_spin_lock+0x31/0x65
 [<c02c5fd6>] _spin_lock_irqsave+0x9/0xd
 [<e08b7de7>] ntty_write+0x35/0xf2 [nozomi]
 [<c0116672>] scheduler_tick+0x9d/0x2af
 [<c0106792>] timer_interrupt+0x73/0x7a
 [<c01fa505>] tty_default_put_char+0x15/0x18
 [<c01facfd>] opost+0x93/0x1ce
 [<c01fb96e>] n_tty_receive_buf+0x52b/0xb37
 [<c0103542>] common_interrupt+0x1a/0x20
 [<c011007b>] wakeup_code+0x7b/0xba
 [<c0119e01>] release_console_sem+0x74/0xa9
 [<c0119ce8>] vprintk+0x1d1/0x1f5
 [<c0106792>] timer_interrupt+0x73/0x7a
 [<c01ba361>] vsnprintf+0x45a/0x497
 [<c01fa14f>] flush_to_ldisc+0xd4/0xeb
 [<e08b67c3>] receive_data+0x1a6/0x1b6 [nozomi]
 [<c02c5fd6>] _spin_lock_irqsave+0x9/0xd
 [<c01204d3>] lock_timer_base+0x15/0x2f
 [<c02c5fd6>] _spin_lock_irqsave+0x9/0xd
 [<c01f64f0>] __add_entropy_words+0x58/0x167
 [<e08b6f92>] interrupt_handler+0x52c/0x723 [nozomi]
 [<c01addca>] __freed_request+0x1c/0x65
 [<c01ade30>] freed_request+0x1d/0x37
 [<c022d951>] __ide_end_request+0xb1/0xba
 [<c01ac11e>] elv_queue_empty+0x1b/0x21
 [<c022e922>] ide_do_request+0x89/0x2f8
 [<c022efa0>] ide_intr+0x10e/0x11a
 [<c02348ef>] ide_dma_intr+0x0/0x92
 [<c0133918>] handle_IRQ_event+0x21/0x4a
 [<c01339ba>] __do_IRQ+0x79/0xcb
 [<c010472a>] do_IRQ+0x5e/0x79
 =======================
 [<c0103542>] common_interrupt+0x1a/0x20
 [<c01f931a>] tty_open+0x276/0x2ac
 [<c0154f8c>] chrdev_open+0x111/0x127
 [<c0154e7b>] chrdev_open+0x0/0x127
 [<c014cc35>] __dentry_open+0xb6/0x185
 [<c014cdaa>] nameidata_to_filp+0x19/0x28
 [<c014cd2a>] filp_open+0x26/0x2c
 [<c014ceb0>] get_unused_fd+0xac/0xb4
 [<c014cf75>] do_sys_open+0x31/0x9c
 [<c0102b75>] syscall_call+0x7/0xb
BUG: spinlock lockup on CPU#0, minicom/1918, dc4fade4
 [<c01bb85d>] __spin_lock_debug+0x66/0x6f
 [<c01bb8bc>] _raw_spin_lock+0x56/0x65
 [<c02c5fd6>] _spin_lock_irqsave+0x9/0xd
 [<e08b7de7>] ntty_write+0x35/0xf2 [nozomi]
 [<c0116672>] scheduler_tick+0x9d/0x2af
 [<c0106792>] timer_interrupt+0x73/0x7a
 [<c01fa505>] tty_default_put_char+0x15/0x18
 [<c01facfd>] opost+0x93/0x1ce
 [<c01fb96e>] n_tty_receive_buf+0x52b/0xb37
 [<c0103542>] common_interrupt+0x1a/0x20
 [<c011007b>] wakeup_code+0x7b/0xba
 [<c0119e01>] release_console_sem+0x74/0xa9
 [<c0119ce8>] vprintk+0x1d1/0x1f5
 [<c0106792>] timer_interrupt+0x73/0x7a
 [<c01ba361>] vsnprintf+0x45a/0x497
 [<c01fa14f>] flush_to_ldisc+0xd4/0xeb
 [<e08b67c3>] receive_data+0x1a6/0x1b6 [nozomi]
 [<c02c5fd6>] _spin_lock_irqsave+0x9/0xd
 [<c01204d3>] lock_timer_base+0x15/0x2f
 [<c02c5fd6>] _spin_lock_irqsave+0x9/0xd
 [<c01f64f0>] __add_entropy_words+0x58/0x167
 [<e08b6f92>] interrupt_handler+0x52c/0x723 [nozomi]
 [<c01addca>] __freed_request+0x1c/0x65
 [<c01ade30>] freed_request+0x1d/0x37
 [<c022d951>] __ide_end_request+0xb1/0xba
 [<c01ac11e>] elv_queue_empty+0x1b/0x21
 [<c022e922>] ide_do_request+0x89/0x2f8
 [<c022efa0>] ide_intr+0x10e/0x11a
 [<c02348ef>] ide_dma_intr+0x0/0x92
 [<c0133918>] handle_IRQ_event+0x21/0x4a
 [<c01339ba>] __do_IRQ+0x79/0xcb
 [<c010472a>] do_IRQ+0x5e/0x79
 =======================
 [<c0103542>] common_interrupt+0x1a/0x20
 [<c01f931a>] tty_open+0x276/0x2ac
 [<c0154f8c>] chrdev_open+0x111/0x127
 [<c0154e7b>] chrdev_open+0x0/0x127
 [<c014cc35>] __dentry_open+0xb6/0x185
 [<c014cdaa>] nameidata_to_filp+0x19/0x28
 [<c014cd2a>] filp_open+0x26/0x2c
 [<c014ceb0>] get_unused_fd+0xac/0xb4
 [<c014cf75>] do_sys_open+0x31/0x9c
 [<c0102b75>] syscall_call+0x7/0xb
