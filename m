Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWFLSdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWFLSdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWFLSdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:33:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63896 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752135AbWFLSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:33:09 -0400
Message-ID: <448DB363.6060102@sgi.com>
Date: Mon, 12 Jun 2006 13:33:07 -0500
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [PATCH] stack overflow checking for x86_64 / 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This existed for x86_64 in 2.4, but seems to have gone AWOL in 2.6.

I've pretty much just copied this over from the 2.4 code, with appropriate tweaks for the 2.6 
kernel, plus a bugfix.  I'd personally rather see it printed out the way other arches do it, i.e. 
bytes-remaining-until-overflow, rather than having to do the subtraction yourself.  Also, only 128 
bytes remaining seems awfully late to issue a warning.  But I'll start here :)

Thanks,

-Eric

signed-off-by: Eric Sandeen <sandeen@sgi.com>

Index: linux-2.6.16/arch/x86_64/Kconfig.debug
===================================================================
--- linux-2.6.16.orig/arch/x86_64/Kconfig.debug	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16/arch/x86_64/Kconfig.debug	2006-06-09 16:15:58.991377500 -0500
@@ -35,6 +35,13 @@
           Add a simple leak tracer to the IOMMU code. This is useful when you
  	 are debugging a buggy device driver that leaks IOMMU mappings.

+config DEBUG_STACKOVERFLOW
+        bool "Check for stack overflows"
+        depends on DEBUG_KERNEL
+        help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit.
+
  #config X86_REMOTE_DEBUG
  #       bool "kgdb debugging stub"

Index: linux-2.6.16/arch/x86_64/kernel/irq.c
===================================================================
--- linux-2.6.16.orig/arch/x86_64/kernel/irq.c	2006-06-09 16:14:55.991440250 -0500
+++ linux-2.6.16/arch/x86_64/kernel/irq.c	2006-06-12 13:04:59.226174500 -0500
@@ -26,6 +26,30 @@
  #endif
  #endif

+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+/*
+ * Probalistic stack overflow check:
+ *
+ * Only check the stack in process context, because everything else
+ * runs on the big interrupt stacks. Checking reliably is too expensive,
+ * so we just check from interrupts.
+ */
+static inline void stack_overflow_check(struct pt_regs *regs)
+{
+	u64 curbase = (u64) current->thread_info;
+	static unsigned long warned = -60*HZ;
+
+	if (regs->rsp >= curbase && regs->rsp <= curbase + THREAD_SIZE &&
+	    regs->rsp <  curbase + sizeof(struct thread_info) + 128 &&
+	    time_after(jiffies, warned + 60*HZ)) {
+		printk("do_IRQ: %s near stack overflow (cur:%Lx,rsp:%lx)\n",
+		       current->comm, curbase, regs->rsp);
+		show_stack(NULL,NULL);
+		warned = jiffies;
+	}
+}
+#endif
+
  /*
   * Generic, controller-independent functions:
   */
@@ -96,7 +120,9 @@

  	exit_idle();
  	irq_enter();
-
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+	stack_overflow_check(regs);
+#endif
  	__do_IRQ(irq, regs);
  	irq_exit();

