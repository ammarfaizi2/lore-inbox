Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbULCHaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbULCHaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbULCHaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:30:10 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:48016 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262064AbULCHaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:30:00 -0500
Date: Fri, 3 Dec 2004 00:29:25 -0700 (MST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
cc: piotr@larroy.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][BUG] Badness in smp_call_function at arch/i386/kernel/smp.c:552
In-Reply-To: <20041202230106.14bb42f5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412030005070.21568@montezuma.fsmlabs.com>
References: <20041202210340.GA19140@larroy.com>
 <Pine.LNX.4.61.0412022152480.21568@montezuma.fsmlabs.com>
 <20041202230106.14bb42f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004, Andrew Morton wrote:

> Well, sort-of.
> 
> If __handle_sysrq was really a normal IRQ handler then the correct thing to
> do here is to replace spin_lock_irqsave() with spin_lock().  But
> __handle_sysrq() can also be called via /proc/sysrq-trigger and via the
> handlers of multiple interrupt sources.  So we're stuck with using
> spin_lock_irqsave().
> 
> However enabling interrupts as you've done menas that theoretically we
> could deadlock on sysrq_key_table_lock if another sysrq happens at the
> wrong time.
> 
> Which deadlock opportunity would you prefer? ;)

Agreed, there is actually a higher chance of the smp_call_function 
deadlock occuring since the __handle_sysrq one relies on another sysrq 
event occuring via a different IRQ line interrupt handler, so 
we would have to do sysrq via serial and then sysrq via keyboard to cause 
the deadlock. Perhaps just make it a spin_trylock?

Index: linux-2.6.10-rc2-mm4/drivers/char/sysrq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm4/drivers/char/sysrq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysrq.c
--- linux-2.6.10-rc2-mm4/drivers/char/sysrq.c	30 Nov 2004 18:52:31 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm4/drivers/char/sysrq.c	3 Dec 2004 07:21:04 -0000
@@ -370,7 +370,10 @@ void __handle_sysrq(int key, struct pt_r
 	int i, j;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sysrq_key_table_lock, flags);
+	local_irq_save(flags);
+	if (!spin_trylock(&sysrq_key_table_lock))
+		goto bail;
+
 	orig_log_level = console_loglevel;
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq : ");
@@ -396,7 +399,9 @@ void __handle_sysrq(int key, struct pt_r
 		printk ("\n");
 		console_loglevel = orig_log_level;
 	}
-	spin_unlock_irqrestore(&sysrq_key_table_lock, flags);
+	spin_unlock(&sysrq_key_table_lock);
+bail:
+	local_irq_restore(flags);
 }
 
 /*
Index: linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 reboot.c
--- linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c	30 Nov 2004 18:52:19 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c	3 Dec 2004 07:23:44 -0000
@@ -274,6 +274,8 @@ void machine_shutdown(void)
 #ifdef CONFIG_SMP
 	int reboot_cpu_id;
 
+	local_irq_enable();
+
 	/* The boot cpu is always logical cpu 0 */
 	reboot_cpu_id = 0;
 
