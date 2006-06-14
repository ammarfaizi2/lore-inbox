Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWFNGYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWFNGYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 02:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFNGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 02:24:14 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18693
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932198AbWFNGYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 02:24:13 -0400
Message-Id: <448FC7C0.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 14 Jun 2006 08:24:32 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Eric Sandeen" <sandeen@sgi.com>
Cc: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [discuss] [PATCH 1/2] (resend) x86_64 stack overflow
	debugging
References: <20060613194322.D0CDC10CC671@attica.americas.sgi.com>
In-Reply-To: <20060613194322.D0CDC10CC671@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you certain you will ever see this trigger? Assembly code switches to the special interrupt handling stack prior to calling do_IRQ(), so I can't see how you would ever find yourself on the process stack in stack_overflow_check(). Jan

>>> Eric Sandeen <sandeen@sgi.com> 13.06.06 21:43 >>>
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
 

