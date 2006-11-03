Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753371AbWKCQtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbWKCQtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbWKCQtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:49:18 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:48024 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1753371AbWKCQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:49:17 -0500
Subject: [PATCH] lockdep: fix delayacct locking bug
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       arjan <arjan@infradead.org>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 17:48:47 +0100
Message-Id: <1162572527.26989.22.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


======================================================
[ INFO: soft-safe -> soft-unsafe lock order detected ]
2.6.19-rc4 #1
------------------------------------------------------
mm_tester/1875 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (&tsk->delays->lock){--..}, at: [<c0156652>] __delayacct_add_tsk+0x131/0x1d3

and this task is already holding:
 (&sighand->siglock){.+..}, at: [<c0156b69>] taskstats_exit_send+0x52/0x3b2
which would create a new lock dependency:
 (&sighand->siglock){.+..} -> (&tsk->delays->lock){--..}

but this new dependency connects a soft-irq-safe lock:
 (&sighand->siglock){.+..}
... which became soft-irq-safe at:
  [<c013d0da>] mark_lock+0x5c/0x38c
  [<c013de51>] __lock_acquire+0x348/0x971
  [<c013ea35>] lock_acquire+0x5c/0x77
  [<c032132d>] _spin_lock_irqsave+0x3c/0x4b
  [<c012fda9>] lock_task_sighand+0x1f/0x3c
  [<c01309fd>] group_send_sig_info+0x25/0x56
  [<c0130a4c>] send_group_sig_info+0x1e/0x30
  [<c012a7c6>] it_real_fn+0x1d/0x5f
  [<c013a453>] hrtimer_run_queues+0xf2/0x14a
  [<c012e4fa>] run_timer_softirq+0x20/0x166
  [<c012b307>] __do_softirq+0x6b/0xe6
  [<c0106279>] do_softirq+0x61/0xd1
  [<ffffffff>] 0xffffffff

to a soft-irq-unsafe lock:
 (&tsk->delays->lock){--..}
... which became soft-irq-unsafe at:
...  [<c013d0da>] mark_lock+0x5c/0x38c
  [<c013deec>] __lock_acquire+0x3e3/0x971
  [<c013ea35>] lock_acquire+0x5c/0x77
  [<c032108a>] _spin_lock+0x33/0x3e
  [<c015642b>] delayacct_end+0x58/0x7b
  [<c015651e>] __delayacct_blkio_end+0x37/0x3a
  [<c0157c0f>] sync_page+0x38/0x3b
  [<c031f920>] __wait_on_bit_lock+0x2a/0x52
  [<c0157bc9>] __lock_page+0x5b/0x61
  [<c0159bc9>] read_cache_page+0xea/0x13a
  [<c01abc05>] read_dev_sector+0x2e/0x84
  [<c01ad364>] read_lba+0x5c/0xc0
  [<c01ad602>] efi_partition+0x8f/0x6ed
  [<c01abf3f>] rescan_partitions+0x106/0x20b
  [<c019655b>] do_open+0x2aa/0x3ae
  [<c01966b4>] blkdev_get+0x55/0x60
  [<c01abdd7>] register_disk+0x17c/0x1de
  [<c01e1810>] add_disk+0x36/0x41
  [<c02775a7>] ide_disk_probe+0x8ef/0x918
  [<c026b40f>] generic_ide_probe+0x1f/0x20
  [<c02586a3>] really_probe+0x39/0xda
  [<c02588cb>] __driver_attach+0x69/0xa1
  [<c0257dbe>] bus_for_each_dev+0x3a/0x5c
  [<c02585c3>] driver_attach+0x16/0x18
  [<c0258092>] bus_add_driver+0x61/0x165
  [<c010049b>] init+0x123/0x2d1
  [<c0104be7>] kernel_thread_helper+0x7/0x10
  [<ffffffff>] 0xffffffff

other info that might help us debug this:

<snip 607 lines of other output>

stack backtrace:
 [<c0104eb6>] dump_trace+0x69/0x1b6
 [<c010501b>] show_trace_log_lvl+0x18/0x2c
 [<c010562e>] show_trace+0xf/0x11
 [<c01056de>] dump_stack+0x15/0x17
 [<c013d7f1>] check_usage+0x262/0x26c
 [<c013e331>] __lock_acquire+0x828/0x971
 [<c013ea35>] lock_acquire+0x5c/0x77
 [<c032108a>] _spin_lock+0x33/0x3e
 [<c0156652>] __delayacct_add_tsk+0x131/0x1d3
 [<c0156b94>] taskstats_exit_send+0x7d/0x3b2
 [<c01294ad>] do_exit+0x1f6/0x7f0
 [<c0129b37>] complete_and_exit+0x0/0x13
 [<c0103f5b>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb

Leftover inexact backtrace:

 =======================

Make the delayacct lock irqsave; this avoids the possible deadlock where
an interrupt is taken while holding the delayacct lock which needs to take
the delayacct lock.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/delayacct.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6-twins/kernel/delayacct.c
===================================================================
--- linux-2.6-twins.orig/kernel/delayacct.c	2006-11-03 17:28:35.000000000 +0100
+++ linux-2.6-twins/kernel/delayacct.c	2006-11-03 17:28:59.000000000 +0100
@@ -66,6 +66,7 @@ static void delayacct_end(struct timespe
 {
 	struct timespec ts;
 	s64 ns;
+	unsigned long flags;
 
 	do_posix_clock_monotonic_gettime(end);
 	ts = timespec_sub(*end, *start);
@@ -73,10 +74,10 @@ static void delayacct_end(struct timespe
 	if (ns < 0)
 		return;
 
-	spin_lock(&current->delays->lock);
+	spin_lock_irqsave(&current->delays->lock, flags);
 	*total += ns;
 	(*count)++;
-	spin_unlock(&current->delays->lock);
+	spin_unlock_irqrestore(&current->delays->lock, flags);
 }
 
 void __delayacct_blkio_start(void)
@@ -104,6 +105,7 @@ int __delayacct_add_tsk(struct taskstats
 	s64 tmp;
 	struct timespec ts;
 	unsigned long t1,t2,t3;
+	unsigned long flags;
 
 	/* Though tsk->delays accessed later, early exit avoids
 	 * unnecessary returning of other data
@@ -136,14 +138,14 @@ int __delayacct_add_tsk(struct taskstats
 
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
-	spin_lock(&tsk->delays->lock);
+	spin_lock_irqsave(&tsk->delays->lock, flags);
 	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
 	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
 	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
-	spin_unlock(&tsk->delays->lock);
+	spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 done:
 	return 0;
@@ -152,11 +154,12 @@ done:
 __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 {
 	__u64 ret;
+	unsigned long flags;
 
-	spin_lock(&tsk->delays->lock);
+	spin_lock_irqsave(&tsk->delays->lock, flags);
 	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
 				tsk->delays->swapin_delay);
-	spin_unlock(&tsk->delays->lock);
+	spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
 


