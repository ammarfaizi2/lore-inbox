Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWERJOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWERJOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWERJOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:14:12 -0400
Received: from ozlabs.org ([203.10.76.45]:17551 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750924AbWERJOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:14:12 -0400
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 18 May 2006 19:14:04 +1000
Subject: [RFC/PATCH] Make printk work for really early debugging
Message-Id: <20060518091410.CC527679F4@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently printk is no use for early debugging because it refuses to actually
print anything to the console unless cpu_online(smp_processor_id()) is true.

The stated explanation is that console drivers may require per-cpu resources,
or otherwise barf, because the system is not yet setup correctly. Fair enough.

However some console drivers might be quite happy running early during boot,
in fact we have one, and so it'd be nice if printk understood that.

So I add a flag (which I would have called CON_BOOT, but that's taken) called
CON_ANYTIME, which indicates that a console is happy to be called anytime,
even if the cpu is not yet online.

Tested on a Power 5 machine, with both a CON_ANYTIME driver and a bogus
console driver that BUG()s if called while offline. No problems AFAICT.
Built for i386 UP & SMP.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/linux/console.h |    1 
 kernel/printk.c         |   50 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 17 deletions(-)

Index: to-merge/include/linux/console.h
===================================================================
--- to-merge.orig/include/linux/console.h
+++ to-merge/include/linux/console.h
@@ -87,6 +87,7 @@ void give_up_console(const struct consw 
 #define CON_CONSDEV	(2) /* Last on the command line */
 #define CON_ENABLED	(4)
 #define CON_BOOT	(8)
+#define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
 
 struct console
 {
Index: to-merge/kernel/printk.c
===================================================================
--- to-merge.orig/kernel/printk.c
+++ to-merge/kernel/printk.c
@@ -326,7 +326,9 @@ static void __call_console_drivers(unsig
 	struct console *con;
 
 	for (con = console_drivers; con; con = con->next) {
-		if ((con->flags & CON_ENABLED) && con->write)
+		if ((con->flags & CON_ENABLED) && con->write &&
+				(cpu_online(smp_processor_id()) ||
+				(con->flags & CON_ANYTIME)))
 			con->write(con, &LOG_BUF(start), end - start);
 	}
 }
@@ -452,6 +454,18 @@ __attribute__((weak)) unsigned long long
 	return sched_clock();
 }
 
+/* Check if we have any console registered that can be called early in boot. */
+static int have_callable_console(void)
+{
+	struct console *con;
+
+	for (con = console_drivers; con; con = con->next)
+		if (con->flags & CON_ANYTIME)
+			return 1;
+
+	return 0;
+}
+
 /**
  * printk - print a kernel message
  * @fmt: format string
@@ -565,27 +579,29 @@ asmlinkage int vprintk(const char *fmt, 
 			log_level_unknown = 1;
 	}
 
-	if (!cpu_online(smp_processor_id())) {
+	if (!down_trylock(&console_sem)) {
 		/*
-		 * Some console drivers may assume that per-cpu resources have
-		 * been allocated.  So don't allow them to be called by this
-		 * CPU until it is officially up.  We shouldn't be calling into
-		 * random console drivers on a CPU which doesn't exist yet..
+		 * We own the drivers.  We can drop the spinlock and
+		 * let release_console_sem() print the text, maybe ...
 		 */
+		console_locked = 1;
 		printk_cpu = UINT_MAX;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
-		goto out;
-	}
-	if (!down_trylock(&console_sem)) {
-		console_locked = 1;
+
 		/*
-		 * We own the drivers.  We can drop the spinlock and let
-		 * release_console_sem() print the text
+		 * Console drivers may assume that per-cpu resources have
+		 * been allocated. So unless they're explicitly marked as
+		 * being able to cope (CON_ANYTIME) don't call them until
+		 * this CPU is officially up.
 		 */
-		printk_cpu = UINT_MAX;
-		spin_unlock_irqrestore(&logbuf_lock, flags);
-		console_may_schedule = 0;
-		release_console_sem();
+		if (cpu_online(smp_processor_id()) || have_callable_console()) {
+			console_may_schedule = 0;
+			release_console_sem();
+		} else {
+			/* Release by hand to avoid flushing the buffer. */
+			console_locked = 0;
+			up(&console_sem);
+		}
 	} else {
 		/*
 		 * Someone else owns the drivers.  We drop the spinlock, which
@@ -595,7 +611,7 @@ asmlinkage int vprintk(const char *fmt, 
 		printk_cpu = UINT_MAX;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
-out:
+
 	preempt_enable();
 	return printed_len;
 }
