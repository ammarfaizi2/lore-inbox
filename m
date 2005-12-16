Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVLPNKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVLPNKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVLPNKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:10:02 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:13016 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932269AbVLPNKA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:10:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MUk5tk4xWKzJbXMctNH1f15aetPDQ0+lzAbva8lvkv1nt+GLSPWit/gyD8ZBnDGXjnyaXHgbhnVLkZg5f/SWCDenpvKYhiYXBpbsSR44giQXn0M8wSSxSmYy4ROedCnBKIkLJxhJF8PZAjsfnOq1P7PB0l7dqd2CkRsWYWF3n1I=
Date: Fri, 16 Dec 2005 14:10:02 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051216141002.2b54e87d.diegocg@gmail.com>
In-Reply-To: <20051215140013.7d4ffd5b.akpm@osdl.org>
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 15 Dec 2005 14:00:13 -0800,
Andrew Morton <akpm@osdl.org> escribió:


> Supporting 8k stacks is a small amount of code and nobody has seen a need
> to make changes in there for quite a long time.  So there's little cost to
> keeping the existing code.
> 
> And the existing code is useful:

Maybe this slighty different approach is better? 



Signed-off-by: Diego Calleja <diegocg@gmail.com>

Index: test/arch/i386/Kconfig.debug
===================================================================
--- test.orig/arch/i386/Kconfig.debug	2005-12-16 13:59:54.000000000 +0100
+++ test/arch/i386/Kconfig.debug	2005-12-16 14:03:27.000000000 +0100
@@ -42,15 +42,16 @@
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
-config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
+config 8KSTACKS
+	bool "Use 8Kb for kernel stacks instead of 4Kb"
 	depends on DEBUG_KERNEL
 	help
-	  If you say Y here the kernel will use a 4Kb stacksize for the
-	  kernel stack attached to each process/thread. This facilitates
-	  running more threads on a system and also reduces the pressure
+	  If you say Y here the kernel will use a 8Kb stacksize for the
+	  kernel stack attached to each process/thread. This makes harder
+	  to overflow the stack, and it's used to debug possible stack
+	  overflow problems. Notice that this increases the pressure
 	  on the VM subsystem for higher order allocations. This option
-	  will also use IRQ stacks to compensate for the reduced stackspace.
+	  will also disable IRQ stacks.
 
 config X86_FIND_SMP_CONFIG
 	bool
Index: test/arch/i386/kernel/irq.c
===================================================================
--- test.orig/arch/i386/kernel/irq.c	2005-12-16 13:59:54.000000000 +0100
+++ test/arch/i386/kernel/irq.c	2005-12-16 14:01:24.000000000 +0100
@@ -33,7 +33,7 @@
 }
 #endif
 
-#ifdef CONFIG_4KSTACKS
+#ifndef CONFIG_8KSTACKS
 /*
  * per-CPU IRQ handling contexts (thread information and stack)
  */
@@ -55,7 +55,7 @@
 {	
 	/* high bits used in ret_from_ code */
 	int irq = regs->orig_eax & 0xff;
-#ifdef CONFIG_4KSTACKS
+#ifndef CONFIG_8KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
 #endif
@@ -76,7 +76,7 @@
 	}
 #endif
 
-#ifdef CONFIG_4KSTACKS
+#ifndef CONFIG_8KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
 	irqctx = hardirq_ctx[smp_processor_id()];
@@ -112,7 +112,7 @@
 	return 1;
 }
 
-#ifdef CONFIG_4KSTACKS
+#ifndef CONFIG_8KSTACKS
 
 /*
  * These should really be __section__(".bss.page_aligned") as well, but
Index: test/include/asm-i386/irq.h
===================================================================
--- test.orig/include/asm-i386/irq.h	2005-12-16 13:59:54.000000000 +0100
+++ test/include/asm-i386/irq.h	2005-12-16 14:04:05.000000000 +0100
@@ -27,7 +27,7 @@
 # define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
-#ifdef CONFIG_4KSTACKS
+#ifndef CONFIG_8KSTACKS
   extern void irq_ctx_init(int cpu);
   extern void irq_ctx_exit(int cpu);
 # define __ARCH_HAS_DO_SOFTIRQ
Index: test/include/asm-i386/module.h
===================================================================
--- test.orig/include/asm-i386/module.h	2005-12-16 13:59:54.000000000 +0100
+++ test/include/asm-i386/module.h	2005-12-16 14:04:36.000000000 +0100
@@ -64,8 +64,8 @@
 #define MODULE_REGPARM ""
 #endif
 
-#ifdef CONFIG_4KSTACKS
-#define MODULE_STACKSIZE "4KSTACKS "
+#ifdef CONFIG_8KSTACKS
+#define MODULE_STACKSIZE "8KSTACKS "
 #else
 #define MODULE_STACKSIZE ""
 #endif
Index: test/include/asm-i386/thread_info.h
===================================================================
--- test.orig/include/asm-i386/thread_info.h	2005-12-16 13:59:54.000000000 +0100
+++ test/include/asm-i386/thread_info.h	2005-12-16 14:04:57.000000000 +0100
@@ -53,7 +53,7 @@
 #endif
 
 #define PREEMPT_ACTIVE		0x10000000
-#ifdef CONFIG_4KSTACKS
+#ifndef CONFIG_8KSTACKS
 #define THREAD_SIZE            (4096)
 #else
 #define THREAD_SIZE		(8192)
