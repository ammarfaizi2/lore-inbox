Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWITTM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWITTM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWITTMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:12:25 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:47989 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932289AbWITTMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:12:25 -0400
Message-Id: <20060920191134.934555000@mvista.com>
User-Agent: quilt/0.45-1
Date: Wed, 20 Sep 2006 12:11:34 -0700
From: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] serial: scheduling with irqs disabled
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saw this during bootup ..

BUG: scheduling with irqs disabled: insmod/0x00000000/1110
caller is rt_spin_lock_slowlock+0x89/0x190
 [<c0104c3b>] show_trace+0x1b/0x20
 [<c0104d44>] dump_stack+0x24/0x30
 [<c040ff9e>] schedule+0x10e/0x120
 [<c0410d99>] rt_spin_lock_slowlock+0x89/0x190
 [<c0411502>] rt_spin_lock+0x22/0x30
 [<c0291669>] serial8250_console_write+0x49/0x170
 [<c011fa8d>] __call_console_drivers+0x6d/0x80
 [<c011fae3>] _call_console_drivers+0x43/0x90
 [<c0120265>] release_console_sem+0xe5/0x240
 [<c011fe4e>] vprintk+0x20e/0x380
 [<c011ffdb>] printk+0x1b/0x20
 [<c0140345>] sys_init_module+0xba5/0x1a30
 [<c01034d7>] syscall_call+0x7/0xb
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 drivers/serial/8250.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18/drivers/serial/8250.c
===================================================================
--- linux-2.6.18.orig/drivers/serial/8250.c
+++ linux-2.6.18/drivers/serial/8250.c
@@ -2252,7 +2252,7 @@ serial8250_console_write(struct console 
 
 	touch_nmi_watchdog();
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (up->port.sysrq) {
 		/* serial8250_handle_port() already took the lock */
 		locked = 0;
@@ -2282,7 +2282,7 @@ serial8250_console_write(struct console 
 
 	if (locked)
 		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)
--
