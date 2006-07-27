Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWG0OYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWG0OYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWG0OYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:24:32 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:33552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751347AbWG0OYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:24:31 -0400
Date: Thu, 27 Jul 2006 15:24:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: lockdep: results on ARM
Message-ID: <20060727142425.GA5178@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on getting lockdep up and running on ARM, and have hit
a problem wrt our context switching with IRQs enabled.

I'm seeing:

Calibrating local timer... 104.40MHz.
BUG: warning at /home/rmk/git/linux-2.6-rmk/kernel/lockdep.c:2343/check_flags()
[<c0024ed0>] (dump_stack+0x0/0x14) from [<c005cf20>] (check_flags+0x88/0x1e4)
[<c005ce98>] (check_flags+0x0/0x1e4) from [<c005d0c4>] (lock_acquire+0x48/0x94)
 r5 = C05D4000  r4 = 60000013
[<c005d07c>] (lock_acquire+0x0/0x94) from [<c01e0f70>] (_spin_lock+0x30/0x40)
[<c01e0f40>] (_spin_lock+0x0/0x40) from [<c0041e5c>] (exit_fs+0x28/0xbc)
 r4 = C05CD26C
[<c0041e34>] (exit_fs+0x0/0xbc) from [<c0055900>] (kthread+0x2c/0x110)
 r6 = C021F520  r5 = C05CD040  r4 = C05D4000
[<c00558d4>] (kthread+0x0/0x110) from [<c00423b8>] (do_exit+0x0/0x83c)
 r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
 r4 = 00000000
irq event stamp: 0
hardirqs last  enabled at (0): [<00000000>] 0x0
hardirqs last disabled at (0): [<c003d918>] copy_process+0x31c/0x1274
softirqs last  enabled at (0): [<c003d918>] copy_process+0x31c/0x1274
softirqs last disabled at (0): [<00000000>] 0x0
CPU1: Booted secondary processor

which appears to be the lockdep code complaining that IRQs are on when
it thinks they shouldn't be.

Since new processes are created with the lockdep irq state marked as
"disabled", and the scheduler does not change IRQ state if an architecture
sets __ARCH_WANT_INTERRUPTS_ON_CTXSW, there is nothing which causes
lockdep to think IRQs should be on.  Moreover, trying to call the
trace_hardirqs_on() function doesn't work because it then bitches that
IRQs are already on.

The best fix I've come up with which seems to work is:

diff --git a/kernel/fork.c b/kernel/fork.c
index 1b0f7b1..bc8cda2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1055,7 +1055,11 @@ #ifdef CONFIG_NUMA
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	p->hardirqs_enabled = 1;
+#else
 	p->hardirqs_enabled = 0;
+#endif
 	p->hardirq_enable_ip = 0;
 	p->hardirq_enable_event = 0;
 	p->hardirq_disable_ip = _THIS_IP_;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
