Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWE2Viy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWE2Viy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWE2ViH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:38:07 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49592 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751327AbWE2VZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:25 -0400
Date: Mon, 29 May 2006 23:25:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 32/61] lock validator: do not recurse in printk()
Message-ID: <20060529212545.GF3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

make printk()-ing from within the lock validation code safer by
using the lockdep-recursion counter.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/printk.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -516,7 +516,9 @@ asmlinkage int vprintk(const char *fmt, 
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
-	spin_lock_irqsave(&logbuf_lock, flags);
+	local_irq_save(flags);
+	current->lockdep_recursion++;
+	spin_lock(&logbuf_lock);
 	printk_cpu = smp_processor_id();
 
 	/* Emit the output into the temporary buffer */
@@ -586,7 +588,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 */
 		console_locked = 1;
 		printk_cpu = UINT_MAX;
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock(&logbuf_lock);
 
 		/*
 		 * Console drivers may assume that per-cpu resources have
@@ -602,6 +604,8 @@ asmlinkage int vprintk(const char *fmt, 
 			console_locked = 0;
 			up(&console_sem);
 		}
+		current->lockdep_recursion--;
+		local_irq_restore(flags);
 	} else {
 		/*
 		 * Someone else owns the drivers.  We drop the spinlock, which
@@ -609,7 +613,9 @@ asmlinkage int vprintk(const char *fmt, 
 		 * console drivers with the output which we just produced.
 		 */
 		printk_cpu = UINT_MAX;
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock(&logbuf_lock);
+		current->lockdep_recursion--;
+		local_irq_restore(flags);
 	}
 
 	preempt_enable();
@@ -783,7 +789,13 @@ void release_console_sem(void)
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
-		wake_up_interruptible(&log_wait);
+		/*
+		 * If we printk from within the lock dependency code,
+		 * from within the scheduler code, then do not lock
+		 * up due to self-recursion:
+		 */
+		if (current->lockdep_recursion <= 1)
+			wake_up_interruptible(&log_wait);
 }
 EXPORT_SYMBOL(release_console_sem);
 
