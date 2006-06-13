Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWFMTn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWFMTn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFMTn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:43:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37570 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751197AbWFMTn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:43:27 -0400
Date: Tue, 13 Jun 2006 14:43:22 -0500
To: discuss@x86-64.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] (resend) x86_64 stack overflow debugging
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20060613194322.D0CDC10CC671@attica.americas.sgi.com>
From: sandeen@sgi.com (Eric Sandeen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take two, now without spurious whitespace :(  Applies to git & 2.6.17-rc6

CONFIG_DEBUG_STACKOVERFLOW existed for x86_64 in 2.4, but seems to have gone AWOL in 2.6.

I've pretty much just copied this over from the 2.4 code, with appropriate tweaks for the 2.6 kernel, plus a bugfix.  I'd personally rather see it printed out the way other arches do it, i.e. bytes-remaining-until-overflow, rather than having to do the subtraction yourself.  Also, only 128 bytes remaining seems awfully late to issue a warning.  But I'll start here :)

Thanks,

-Eric 

Signed-off-by: Eric Sandeen <sandeen@sgi.com>

Index: linux/arch/x86_64/Kconfig.debug
===================================================================
--- linux.orig/arch/x86_64/Kconfig.debug	2006-03-19 23:53:29.000000000 -0600
+++ linux/arch/x86_64/Kconfig.debug	2006-06-13 08:54:36.923001750 -0500
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
 
Index: linux/arch/x86_64/kernel/irq.c
===================================================================
--- linux.orig/arch/x86_64/kernel/irq.c	2006-06-09 16:14:55.991440250 -0500
+++ linux/arch/x86_64/kernel/irq.c	2006-06-13 08:55:22.485849250 -0500
@@ -26,6 +26,30 @@
 #endif
 #endif
 
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+/*
+ * Probabilistic stack overflow check:
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
 
