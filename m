Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUDOPSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbUDOPSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:18:08 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:8169 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264255AbUDOPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:18:03 -0400
Subject: [PATCH] fix 4k irqstacks on x86 (and add voyager support)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Apr 2004 10:17:45 -0500
Message-Id: <1082042268.2166.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in the x86 code in that it sets the boot CPU to zero. 
This isn't correct since some subarch's use physically indexed CPUs. 
However, subarchs have either set the boot cpu before irq_INIT() (or
just inherited the default zero from INIT_THREAD_INFO()), so it's safe
to believe current_thread_info()->cpu about the boot cpu.

James

===== arch/i386/kernel/i8259.c 1.28 vs edited =====
--- 1.28/arch/i386/kernel/i8259.c	Mon Apr 12 12:54:45 2004
+++ edited/arch/i386/kernel/i8259.c	Thu Apr 15 09:59:27 2004
@@ -445,6 +445,5 @@
 	if (boot_cpu_data.hard_math && !cpu_has_fpu)
 		setup_irq(FPU_IRQ, &fpu_irq);
 
-	current_thread_info()->cpu = 0;
-	irq_ctx_init(0);
+	irq_ctx_init(current_thread_info()->cpu);
 }
===== arch/i386/mach-voyager/voyager_smp.c 1.19 vs edited =====
--- 1.19/arch/i386/mach-voyager/voyager_smp.c	Sun Mar 14 05:23:02 2004
+++ edited/arch/i386/mach-voyager/voyager_smp.c	Thu Apr 15 09:52:49 2004
@@ -599,12 +599,10 @@
 	idle->thread.eip = (unsigned long) start_secondary;
 	unhash_process(idle);
 	/* init_tasks (in sched.c) is indexed logically */
-#if 0
-	// for AC kernels
-	stack_start.esp = (THREAD_SIZE + (__u8 *)TSK_TO_KSTACK(idle));
-#else
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
-#endif
+	stack_start.esp = (void *) idle->thread.esp;
+
+	irq_ctx_init(cpu);
+
 	/* Note: Don't modify initial ss override */
 	VDEBUG(("VOYAGER SMP: Booting CPU%d at 0x%lx[%x:%x], stack %p\n", cpu, 
 		(unsigned long)hijack_source.val, hijack_source.idt.Segment,
===== arch/i386/mach-voyager/voyager_thread.c 1.3 vs edited =====
--- 1.3/arch/i386/mach-voyager/voyager_thread.c	Wed Feb 12 21:35:38 2003
+++ edited/arch/i386/mach-voyager/voyager_thread.c	Thu Apr 15 09:11:35 2004
@@ -135,7 +135,7 @@
 	init_timer(&wakeup_timer);
 
 	sigfillset(&current->blocked);
-	current->tty = NULL;	/* get rid of controlling tty */
+	current->signal->tty = NULL;
 
 	printk(KERN_NOTICE "Voyager starting monitor thread\n");
 

