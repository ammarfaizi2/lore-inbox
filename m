Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVGEUPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVGEUPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVGEUPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:15:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261798AbVGEUKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:10:30 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Provide better printk() support for SMP machines
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Tue, 05 Jul 2005 21:10:24 +0100
Message-ID: <1491.1120594224@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch prevents oopses interleaving with characters from other
printks on other machines by only zapping the locks if the oops is happening
on the machine holding the lock.

It might be better if the oops generator got the lock and then called an inner
vprintk routine that assumed the caller holds the lock, thus making oops
reports "atomic".

Signed-Off-By: David Howells <dhowells@redhat.com>
---
diff -uNrp linux-2.6.12-mm1/kernel/printk.c linux-2.6.12-mm1-cachefs-wander/kernel/printk.c
--- linux-2.6.12-mm1/kernel/printk.c	2005-06-22 13:54:08.000000000 +0100
+++ linux-2.6.12-mm1-cachefs-wander/kernel/printk.c	2005-06-22 13:57:02.000000000 +0100
@@ -514,6 +514,9 @@ asmlinkage int printk(const char *fmt, .
 	return r;
 }
 
+/* cpu currently holding logbuf_lock */
+static volatile int printk_cpu = -1;
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 	unsigned long flags;
@@ -522,11 +525,15 @@ asmlinkage int vprintk(const char *fmt, 
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (unlikely(oops_in_progress))
+	if (unlikely(oops_in_progress) && printk_cpu == smp_processor_id())
+		/* If a crash is occurring during printk() on this CPU,
+		 * make sure we can't deadlock */
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
 	spin_lock_irqsave(&logbuf_lock, flags);
+	printk_cpu = smp_processor_id();
+	smp_wmb();
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -595,6 +602,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * CPU until it is officially up.  We shouldn't be calling into
 		 * random console drivers on a CPU which doesn't exist yet..
 		 */
+		printk_cpu = -1;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		goto out;
 	}
@@ -604,6 +612,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
 		 */
+		printk_cpu = -1;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		console_may_schedule = 0;
 		release_console_sem();
@@ -613,6 +622,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * allows the semaphore holder to proceed and to call the
 		 * console drivers with the output which we just produced.
 		 */
+		printk_cpu = -1;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
