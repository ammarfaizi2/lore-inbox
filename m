Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWG1Ub2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWG1Ub2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWG1Ub2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:31:28 -0400
Received: from www.osadl.org ([213.239.205.134]:20652 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161219AbWG1Ub2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:31:28 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       alokk@calsoftinc.com
In-Reply-To: <1154118476.10196.5.camel@localhost.localdomain>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <1154067247.27297.104.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
	 <1154117501.10196.2.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
	 <1154118476.10196.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 22:35:47 +0200
Message-Id: <1154118947.10196.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 22:27 +0200, Thomas Gleixner wrote:
> > Why does _spin_lock call kmem_cache_free?
> > 
> > Is the stack trace an accurate representation of the calling sequence?
> 
> Probably not. Thats a call tail optimization artifact. I retest with
> UNWIND info =y 

[  125.530611] input: AT Translated Set 2 keyboard as /class/input/input0
[  128.510384]
[  128.510386] =============================================
[  128.512303] [ INFO: possible recursive locking detected ]
[  128.512415] ---------------------------------------------
[  128.512527] events/0/5 is trying to acquire lock:
[  128.512636]  (&nc->lock){.+..}, at: [<ffffffff802908c1>] kmem_cache_free+0x141/0x210
[  128.513024]
[  128.513025] but task is already holding lock:
[  128.513225]  (&nc->lock){.+..}, at: [<ffffffff80291bc1>] cache_reap+0xd1/0x290
[  128.513608]
[  128.513609] other info that might help us debug this:
[  128.513813] 3 locks held by events/0/5:
[  128.513917]  #0:  (cache_chain_mutex){--..}, at: [<ffffffff80291b18>] cache_reap+0x28/0x290
[  128.514362]  #1:  (&nc->lock){.+..}, at: [<ffffffff80291bc1>] cache_reap+0xd1/0x290
[  128.514803]  #2:  (&parent->list_lock){.+..}, at: [<ffffffff80290c32>] __drain_alien_cache+0x42/0x90
[  128.515253]
[  128.515253] stack backtrace:
[  128.515448]
[  128.515449] Call Trace:
[  128.515740]  [<ffffffff8020b75e>] show_trace+0xae/0x280
[  128.515864]  [<ffffffff8020bb75>] dump_stack+0x15/0x20
[  128.515987]  [<ffffffff8025447c>] __lock_acquire+0x8cc/0xcb0
[  128.516178]  [<ffffffff80254b82>] lock_acquire+0x52/0x70
[  128.516369]  [<ffffffff804a8374>] _spin_lock+0x34/0x50
[  128.516562]  [<ffffffff802908c1>] kmem_cache_free+0x141/0x210
[  128.516799]  [<ffffffff80290a48>] slab_destroy+0xb8/0xf0
[  128.517034]  [<ffffffff80290b88>] free_block+0x108/0x170
[  128.517270]  [<ffffffff80290c58>] __drain_alien_cache+0x68/0x90
[  128.517509]  [<ffffffff80291d5f>] cache_reap+0x26f/0x290
[  128.517745]  [<ffffffff80249b93>] run_workqueue+0xc3/0x120
[  128.517926]  [<ffffffff80249e11>] worker_thread+0x121/0x160
[  128.518105]  [<ffffffff8024d93a>] kthread+0xda/0x110
[  128.518286]  [<ffffffff8020af2a>] child_rip+0x8/0x12

ffffffff80290c32 /home/tglx/work/kernel/git/linux-2.6.git/mm/slab.c:1012
ffffffff80291bc1 /home/tglx/work/kernel/git/linux-2.6.git/mm/slab.c:1031
ffffffff802908c1 /home/tglx/work/kernel/git/linux-2.6.git/mm/slab.c:1074
ffffffff80291b18 /home/tglx/work/kernel/git/linux-2.6.git/mm/slab.c:3749

Let me know, if you need more info

	tglx


