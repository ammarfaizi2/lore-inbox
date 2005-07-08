Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVGHM23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVGHM23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVGHM22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:28:28 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:41344 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262628AbVGHM2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:28:08 -0400
Date: Fri, 8 Jul 2005 16:28:46 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: 'sleeping function called from invalid context' bug when mounting
 an IDE device
Message-Id: <20050708162846.54de783d.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I've come across the following problem during the debugging of IDE driver for
Philips PNX0105 ARM9 platform in RT mode (CONFIG_PREEMPT_RT).
When I mount/unmount a device, the following error is printed out to a terminal:
 
> # mount /dev/discs/disc0/part1 /mnt/
> BUG: sleeping function called from invalid context IRQ 27(655) at
> kernel/rt.c:1449in_atomic():0 [00000000], irqs_disabled():128
 
And gdb shows the following:
 
> (gdb) b kernel/sched.c:5430
> Breakpoint 1 at 0xc0034880: file kernel/sched.c, line 5430.
> (gdb) c
> Continuing.
> 
> Breakpoint 1, __might_sleep (file=0x56 <Address 0x56 out of bounds>,
> line=1449)
>	 at kernel/sched.c:5434
> 5434			     in_atomic(), preempt_count(),
> irqs_disabled());
> (gdb) bt
> #0  __might_sleep (file=0x56 <Address 0x56 out of bounds>, line=1449)
>	 at kernel/sched.c:5434
> #1  0xc004f700 in __spin_lock (lock=0xc01ee10c, eip=3222413300) at
> kernel/rt.c:1449
> #2  0xc004f778 in _spin_lock_irqsave (spin=0x56) at kernel/rt.c:1474
> #3  0xc0121ff4 in ide_intr (irq=27, dev_id=0x0, regs=0x0) at
> drivers/ide/ide-io.c:1416
> #4  0xc00201c0 in __do_irq (irq=27, action=0xc03f8df4, regs=0x0)
>	 at arch/arm/kernel/irq.c:530
> #5  0xc001fec0 in do_hardirq (desc=0xc021f2bc) at
> arch/arm/kernel/irq.c:394
> #6  0xc0020008 in do_irqd (__desc=0xc021f2bc) at
> arch/arm/kernel/irq.c:447
> #7  0xc004c310 in kthread (_create=0xc02abe20) at kernel/kthread.c:95
> #8  0xc0039af4 in exit_notify (tsk=0x0) at kernel/exit.c:785
> Previous frame inner to this frame (corrupt stack?)
> 
So, the problem is in the generic IDE code, namely, in ide_intr() taking ide_lock.

The suggested patch is the following:

Index: linux/drivers/ide/ide-probe.c
===================================================================
--- linux.orig/drivers/ide/ide-probe.c	2005-05-11 19:08:12.000000000 +0000
+++ linux/drivers/ide/ide-probe.c	2005-05-12 16:19:29.000000000 +0000
@@ -1050,16 +1050,13 @@
 	 * Allocate the irq, if not already obtained for another hwif
 	 */
 	if (!match || match->irq != hwif->irq) {
-		int sa = SA_INTERRUPT;
+		int sa = 0;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 		sa = SA_SHIRQ;
 #endif /* __mc68000__ || CONFIG_APUS */
 
 		if (IDE_CHIPSET_IS_PCI(hwif->chipset)) {
 			sa = SA_SHIRQ;
-#ifndef CONFIG_IDEPCI_SHARE_IRQ
-			sa |= SA_INTERRUPT;
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
 		}
 
 		if (hwif->io_ports[IDE_CONTROL_OFFSET])

Can you please comment on it?

Thanks,
   Vitaly
