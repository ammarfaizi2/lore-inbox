Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWG0Xwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWG0Xwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWG0Xwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:52:31 -0400
Received: from www.osadl.org ([213.239.205.134]:36509 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751878AbWG0Xwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:52:31 -0400
Subject: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 01:56:47 +0200
Message-Id: <1154044607.27297.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64, latest git

	tglx

[   57.971202] =============================================
[   57.973118] [ INFO: possible recursive locking detected ]
[   57.973231] ---------------------------------------------
[   57.973343] events/0/5 is trying to acquire lock:
[   57.973452]  (&nc->lock){.+..}, at: [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
[   57.973839]
[   57.973840] but task is already holding lock:
[   57.974040]  (&nc->lock){.+..}, at: [<ffffffff80290501>] cache_reap+0xd1/0x290
[   57.974420]
[   57.974421] other info that might help us debug this:
[   57.974625] 3 locks held by events/0/5:
[   57.974729]  #0:  (cache_chain_mutex){--..}, at: [<ffffffff80290458>] cache_reap+0x28/0x290
[   57.975171]  #1:  (&nc->lock){.+..}, at: [<ffffffff80290501>] cache_reap+0xd1/0x290
[   57.975610]  #2:  (&parent->list_lock){.+..}, at: [<ffffffff8028f572>] __drain_alien_cache+0x42/0x90
[   57.976056]
[   57.976057] stack backtrace:
[   57.976250]
[   57.976251] Call Trace:
[   57.976447]  [<ffffffff802542fc>] __lock_acquire+0x8cc/0xcb0
[   57.976562]  [<ffffffff80254a02>] lock_acquire+0x52/0x70
[   57.976675]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
[   57.976790]  [<ffffffff804a6b74>] _spin_lock+0x34/0x50
[   57.976903]  [<ffffffff8028f201>] kmem_cache_free+0x141/0x210
[   57.977018]  [<ffffffff8028f388>] slab_destroy+0xb8/0xf0
[   57.977131]  [<ffffffff8028f4c8>] free_block+0x108/0x170
[   57.977245]  [<ffffffff8028f598>] __drain_alien_cache+0x68/0x90
[   57.977360]  [<ffffffff80290501>] cache_reap+0xd1/0x290
[   57.977473]  [<ffffffff8029069f>] cache_reap+0x26f/0x290
[   57.977588]  [<ffffffff80249a13>] run_workqueue+0xc3/0x120
[   57.977701]  [<ffffffff80290430>] cache_reap+0x0/0x290
[   57.977814]  [<ffffffff80249c91>] worker_thread+0x121/0x160
[   57.977928]  [<ffffffff802305d0>] default_wake_function+0x0/0x10
[   57.978045]  [<ffffffff80249b70>] worker_thread+0x0/0x160
[   57.978158]  [<ffffffff8024d7ba>] kthread+0xda/0x110
[   57.978270]  [<ffffffff8020af2a>] child_rip+0x8/0x12
[   57.978381]  [<ffffffff804a725b>] _spin_unlock_irq+0x2b/0x60
[   57.978496]  [<ffffffff8020a53b>] restore_args+0x0/0x30
[   57.978609]  [<ffffffff8024d6e0>] kthread+0x0/0x110
[   57.978719]  [<ffffffff8020af22>] child_rip+0x0/0x12


