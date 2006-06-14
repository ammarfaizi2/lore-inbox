Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWFNOUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWFNOUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWFNOUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:20:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17440 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964969AbWFNOUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:20:02 -0400
Date: Wed, 14 Jun 2006 16:19:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/8] lock validator: early_init_irq_lock_type / console_init
Message-ID: <20060614141948.GE1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Two changes:
 - let the kernel compile for architectures that support TRACE_IRQ_FLAGS but
   don't support GENERIC_HARDIRQS.
 - s390's console_init must enable interrupts, but early_boot_irqs_on() gets
   called later. To avoid problems move console_init() after local_irq_enable().
   Hope this works on all architectures?!

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/linux/lockdep.h |    8 ++++++--
 init/main.c             |    6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -purN a/include/linux/lockdep.h b/include/linux/lockdep.h
--- a/include/linux/lockdep.h	2006-06-14 10:57:14.000000000 +0200
+++ b/include/linux/lockdep.h	2006-06-14 13:02:19.000000000 +0200
@@ -265,12 +265,16 @@ static inline void lockdep_on(void)
 struct lockdep_type_key { };
 #endif /* !LOCKDEP */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_GENERIC_HARDIRQS)
 extern void early_init_irq_lock_type(void);
+#else
+# define early_init_irq_lock_type()		do { } while (0)
+#endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
 extern void early_boot_irqs_off(void);
 extern void early_boot_irqs_on(void);
 #else
-# define early_init_irq_lock_type()		do { } while (0)
 # define early_boot_irqs_off()			do { } while (0)
 # define early_boot_irqs_on()			do { } while (0)
 #endif
diff -purN a/init/main.c b/init/main.c
--- a/init/main.c	2006-06-14 10:57:04.000000000 +0200
+++ b/init/main.c	2006-06-14 13:02:19.000000000 +0200
@@ -516,6 +516,9 @@ asmlinkage void __init start_kernel(void
 	softirq_init();
 	time_init();
 	timekeeping_init();
+	profile_init();
+	early_boot_irqs_on();
+	local_irq_enable();
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
@@ -525,9 +528,6 @@ asmlinkage void __init start_kernel(void
 	console_init();
 	if (panic_later)
 		panic(panic_later, panic_param);
-	profile_init();
-	early_boot_irqs_on();
-	local_irq_enable();
 
 	lockdep_info();
 
