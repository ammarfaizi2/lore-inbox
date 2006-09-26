Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWIZPN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWIZPN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWIZPN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:13:27 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:18191 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932097AbWIZPN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:13:26 -0400
Subject: [PATCH] sysrq: disable lockdep on reboot
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: notting@redhat.com, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, arjan <arjan@infradead.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 17:13:21 +0200
Message-Id: <1159283602.5038.25.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SysRq : Emergency Sync
Emergency Sync complete
SysRq : Emergency Remount R/O
Emergency Remount complete
SysRq : Resetting
BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)

Call Trace:
 [<ffffffff8026d56d>] show_trace+0xae/0x319
 [<ffffffff8026d7ed>] dump_stack+0x15/0x17
 [<ffffffff802a68d1>] trace_hardirqs_on+0xbc/0x13d
 [<ffffffff803a8eec>] sysrq_handle_reboot+0x9/0x11
 [<ffffffff803a8f8d>] __handle_sysrq+0x99/0x130
 [<ffffffff803a903b>] handle_sysrq+0x17/0x19
 [<ffffffff803a36ee>] kbd_event+0x32e/0x57d
 [<ffffffff80401e35>] input_event+0x42d/0x45b
 [<ffffffff804063eb>] atkbd_interrupt+0x44d/0x53d
 [<ffffffff803fe5c5>] serio_interrupt+0x49/0x86
 [<ffffffff803ff2a4>] i8042_interrupt+0x202/0x21a
 [<ffffffff80210cf0>] handle_IRQ_event+0x2c/0x64
 [<ffffffff802bfd8b>] __do_IRQ+0xaf/0x114
 [<ffffffff8026ea24>] do_IRQ+0xf8/0x107
 [<ffffffff8025f886>] ret_from_intr+0x0/0xf
DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
Leftover inexact backtrace:
 <IRQ> <EOI> [<ffffffff80258e36>] mwait_idle+0x3f/0x54
 [<ffffffff8024a33a>] cpu_idle+0xa2/0xc5
 [<ffffffff8026c34e>] rest_init+0x2b/0x2d
 [<ffffffff809708bc>] start_kernel+0x24a/0x24c
 [<ffffffff8097028b>] _sinittext+0x28b/0x292

Since we're shutting down anyway, don't bother being smart,
just turn the thing off.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/char/sysrq.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-lappy/drivers/char/sysrq.c
===================================================================
--- linux-2.6-lappy.orig/drivers/char/sysrq.c	2006-09-26 17:08:02.000000000 +0200
+++ linux-2.6-lappy/drivers/char/sysrq.c	2006-09-26 17:10:16.000000000 +0200
@@ -113,6 +113,7 @@ static struct sysrq_key_op sysrq_crashdu
 static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
+	lockdep_off();
 	local_irq_enable();
 	emergency_restart();
 }


