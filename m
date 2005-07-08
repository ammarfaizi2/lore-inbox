Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVGHMg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVGHMg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVGHMg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:36:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262591AbVGHMgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:36:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1491.1120594224@warthog.cambridge.redhat.com> 
References: <1491.1120594224@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Provide better printk() support for SMP machines [try #2]
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Fri, 08 Jul 2005 13:36:12 +0100
Message-ID: <31737.1120826172@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch prevents oopses interleaving with characters from other
printks on other CPUs by only breaking the lock if the oops is happening on
the machine holding the lock.

It might be better if the oops generator got the lock and then called an inner
vprintk routine that assumed the caller holds the lock, thus making oops
reports "atomic".

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 ../printk-smp-2613rc2mm1-2.diff 
 kernel/printk.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff -uNrp linux-2.6.13-rc2-mm1/kernel/printk.c linux-2.6.13-rc2-mm1-cachefs/kernel/printk.c
--- linux-2.6.13-rc2-mm1/kernel/printk.c	2005-07-07 22:24:17.000000000 +0100
+++ linux-2.6.13-rc2-mm1-cachefs/kernel/printk.c	2005-07-08 12:35:51.000000000 +0100
@@ -514,6 +514,9 @@ asmlinkage int printk(const char *fmt, .
 	return r;
 }
 
+/* cpu currently holding logbuf_lock */
+static volatile unsigned int printk_cpu = UINT_MAX;
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 	unsigned long flags;
@@ -522,11 +525,15 @@ asmlinkage int vprintk(const char *fmt, 
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (unlikely(oops_in_progress))
+	preempt_disable();
+	if (unlikely(oops_in_progress) && printk_cpu == raw_smp_processor_id())
+		/* If a crash is occurring during printk() on this CPU,
+		 * make sure we can't deadlock */
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
 	spin_lock_irqsave(&logbuf_lock, flags);
+	printk_cpu = raw_smp_processor_id();
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -588,13 +595,14 @@ asmlinkage int vprintk(const char *fmt, 
 			log_level_unknown = 1;
 	}
 
-	if (!cpu_online(smp_processor_id())) {
+	if (!cpu_online(raw_smp_processor_id())) {
 		/*
 		 * Some console drivers may assume that per-cpu resources have
 		 * been allocated.  So don't allow them to be called by this
 		 * CPU until it is officially up.  We shouldn't be calling into
 		 * random console drivers on a CPU which doesn't exist yet..
 		 */
+		printk_cpu = UINT_MAX;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		goto out;
 	}
@@ -604,6 +612,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
 		 */
+		printk_cpu = UINT_MAX;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 		console_may_schedule = 0;
 		release_console_sem();
@@ -613,9 +622,11 @@ asmlinkage int vprintk(const char *fmt, 
 		 * allows the semaphore holder to proceed and to call the
 		 * console drivers with the output which we just produced.
 		 */
+		printk_cpu = UINT_MAX;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
+	preempt_enable();
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
