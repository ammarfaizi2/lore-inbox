Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSDCXyb>; Wed, 3 Apr 2002 18:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSDCXyV>; Wed, 3 Apr 2002 18:54:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:2066 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312494AbSDCXyO>;
	Wed, 3 Apr 2002 18:54:14 -0500
Subject: [PATCH] simple preemption debug check
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Apr 2002 18:54:18 -0500
Message-Id: <1017878059.22299.85.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This simple check was first suggested by Andrew Morton.  Pretty basic -
whines if a task exits with a nonzero preempt_count value.

I put an identical check in the 2.4 preempt-kernel patch and - sure
enough - it was found that XFS essentially disables preemption as it
destroys data structures containing locks without first unlocking.  The
SGI folks are working on that.

Anyhow, its a quick and clean solution to debugging potential problems. 
Patch is against 2.5.7, please apply.

	Robert Love

diff -urN linux-2.5.7/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.7/include/linux/spinlock.h	Mon Mar 18 15:37:15 2002
+++ linux/include/linux/spinlock.h	Wed Apr  3 18:46:00 2002
@@ -204,7 +204,7 @@
 
 #else
 
-#define preempt_get_count()	do { } while (0)
+#define preempt_get_count()	(0)
 #define preempt_disable()	do { } while (0)
 #define preempt_enable_no_resched()	do {} while(0)
 #define preempt_enable()	do { } while (0)
diff -urN linux-2.5.7/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.7/kernel/exit.c	Mon Mar 18 15:37:10 2002
+++ linux/kernel/exit.c	Wed Apr  3 18:44:24 2002
@@ -492,6 +492,11 @@
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
 
+	if (unlikely(preempt_get_count()))
+		printk(KERN_ERR "error: %s[%d] exited with preempt_count %d\n",
+				current->comm, current->pid,
+				preempt_get_count());
+
 fake_volatile:
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	acct_process(code);

