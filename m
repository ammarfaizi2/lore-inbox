Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTEKEP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 00:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTEKEP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 00:15:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64672 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262482AbTEKEPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 00:15:55 -0400
Date: Sat, 10 May 2003 19:14:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jos Hulzink <josh@stack.nl>, linux-kernel <linux-kernel@vger.kernel.org>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: irq balancing: performance disaster
Message-ID: <7750000.1052619248@[10.10.2.4]>
In-Reply-To: <200305110118.10136.josh@stack.nl>
References: <200305110118.10136.josh@stack.nl>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While tackling bug 699, it became clear to me that irq balancing is the cause 
> of the performance problems I, and all people using the SMP kernel Mandrake 
> 9.1 ships, are dealing with. I got the problems with 2.5.69 too. After 
> disabling irq balancing, the system is remarkably faster, and much more 
> responsive. 
> 
> For those interested in the issue, please look at bug 699.

Could you test out this patch from Keith Mannthey if you're having trouble?
It makes irq balance a config option, which makes it easier to disable.
Various people have requested it, but I don't have a box to test it on ;-(
Pulled out of -mjb tree, but should go onto mainline easily.

M.

diff -urpN -X /home/fletch/.diff.exclude 699-oom_locking/arch/i386/Kconfig 700-config_irqbal/arch/i386/Kconfig
--- 699-oom_locking/arch/i386/Kconfig	Thu Apr 24 21:41:50 2003
+++ 700-config_irqbal/arch/i386/Kconfig	Thu May  1 23:01:18 2003
@@ -834,6 +834,14 @@ config	1000HZ
 	bool "1000 Hz"
 endchoice
 
+config IRQBALANCE
+ 	bool "Enable kernel irq balancing"
+	depends on SMP
+	default y
+	help
+ 	  The defalut yes will allow the kernel to do irq load balancing.  
+	  Saying no will keep the kernel from doing irq load balancing. 	
+
 config HAVE_DEC_LOCK
 	bool
 	depends on (SMP || PREEMPT) && X86_CMPXCHG
diff -urpN -X /home/fletch/.diff.exclude 699-oom_locking/arch/i386/kernel/io_apic.c 700-config_irqbal/arch/i386/kernel/io_apic.c
--- 699-oom_locking/arch/i386/kernel/io_apic.c	Thu Apr 24 21:41:08 2003
+++ 700-config_irqbal/arch/i386/kernel/io_apic.c	Thu May  1 23:01:18 2003
@@ -263,7 +263,7 @@ static void set_ioapic_affinity (unsigne
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-#if defined(CONFIG_SMP)
+#if defined(CONFIG_IRQBALANCE) 
 # include <asm/processor.h>	/* kernel_thread() */
 # include <linux/kernel_stat.h>	/* kstat */
 # include <linux/slab.h>		/* kmalloc() */
@@ -654,8 +654,6 @@ static int __init irqbalance_disable(cha
 
 __setup("noirqbalance", irqbalance_disable);
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask);
-
 static inline void move_irq(int irq)
 {
 	/* note - we hold the desc->lock */
@@ -667,9 +665,9 @@ static inline void move_irq(int irq)
 
 __initcall(balanced_irq_init);
 
-#else /* !SMP */
+#else /* !IRQBALANCE */
 static inline void move_irq(int irq) { }
-#endif /* defined(CONFIG_SMP) */
+#endif /* defined(IRQBALANCE) */
 
 
 /*

