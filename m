Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWF2URt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWF2URt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWF2URs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:17:48 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:4795 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751290AbWF2URr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:17:47 -0400
Date: Thu, 29 Jun 2006 22:17:46 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] small kernel/sched.c cleanup
Message-ID: <20060629201746.GA32142@rhlx01.fht-esslingen.de>
References: <20060613195509.GF24167@rhlx01.fht-esslingen.de> <448F2C97.2090103@tls.msk.ru> <20060629194320.GA11245@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629194320.GA11245@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- constify and optimize stat_nam (thanks to Michael Tokarev!)
- spelling and comment fixes

Run-tested on 2.6.17-mm4.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm4.orig/kernel/sched.c linux-2.6.17-mm4.my/kernel/sched.c
--- linux-2.6.17-mm4.orig/kernel/sched.c	2006-06-29 11:57:17.000000000 +0200
+++ linux-2.6.17-mm4.my/kernel/sched.c	2006-06-29 21:48:22.000000000 +0200
@@ -3418,7 +3418,7 @@
 
 #ifdef CONFIG_PREEMPT
 /*
- * this is is the entry point to schedule() from in-kernel preemption
+ * this is the entry point to schedule() from in-kernel preemption
  * off of preempt_enable.  Kernel preemptions off return from interrupt
  * occur there and call schedule directly.
  */
@@ -3461,7 +3461,7 @@
 EXPORT_SYMBOL(preempt_schedule);
 
 /*
- * this is is the entry point to schedule() from kernel preemption
+ * this is the entry point to schedule() from kernel preemption
  * off of irq context.
  * Note, that this is called and return with irqs disabled. This will
  * protect us against recursive calling from irq.
@@ -3473,7 +3473,7 @@
 	struct task_struct *task = current;
 	int saved_lock_depth;
 #endif
-	/* Catch callers which need to be fixed*/
+	/* Catch callers which need to be fixed */
 	BUG_ON(ti->preempt_count || !irqs_disabled());
 
 need_resched:
@@ -4689,7 +4689,7 @@
 	return list_entry(p->sibling.next,struct task_struct,sibling);
 }
 
-static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
+static const char stat_nam[] = "RSDTtZX";
 
 static void show_task(struct task_struct *p)
 {
@@ -4697,12 +4697,9 @@
 	unsigned long free = 0;
 	unsigned state;
 
-	printk("%-13.13s ", p->comm);
 	state = p->state ? __ffs(p->state) + 1 : 0;
-	if (state < ARRAY_SIZE(stat_nam))
-		printk(stat_nam[state]);
-	else
-		printk("?");
+	printk("%-13.13s %c", p->comm,
+		state < sizeof(stat_nam) - 1 ? stat_nam[state] : '?');
 #if (BITS_PER_LONG == 32)
 	if (state == TASK_RUNNING)
 		printk(" running ");
@@ -5929,7 +5926,7 @@
 	cache = vmalloc(max_size);
 	if (!cache) {
 		printk("could not vmalloc %d bytes for cache!\n", 2*max_size);
-		return 1000000; // return 1 msec on very small boxen
+		return 1000000; /* return 1 msec on very small boxen */
 	}
 
 	while (size <= max_size) {
