Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270583AbTGZWg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270592AbTGZWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:36:26 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:48783 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270583AbTGZWgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:36:17 -0400
Date: Sun, 27 Jul 2003 00:51:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Fix up refrigerator to work with ^Z-ed processes
Message-ID: <20030726225115.GA501@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes refrigerator work with ^Z-ed processes (and not eat
disks). Thanks to (have to find out who, I should sleep and not be
splitting patches). [Hand edited, apply by hand; or there should be
script for recomputing @@ X,Y Z,T @@'s somewhere].

schedule() added makes processes start at exactly that point, making
printouts nicer.

									Pavel

Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ 1,-1 1,-1 @@ 
 /*
  * Refrigerator and related stuff
  */
 
-#define INTERESTING(p) \
-			/* We don't want to touch kernel_threads..*/ \
-			if (p->flags & PF_IOTHREAD) \
-				continue; \
-			if (p == current) \
-				continue; \
-			if (p->state == TASK_ZOMBIE) \
-				continue;
+/* 0 = Ignore this process when freezing/thawing, 1 = freeze/thaw this process */
+static inline int interesting_process(struct task_struct *p)
+{
+	if (p->flags & PF_IOTHREAD)
+		return 0;
+	if (p == current)
+		return 0;
+	if ((p->state == TASK_ZOMBIE) || (p->state == TASK_DEAD))
+		return 0;
+
+	return 1;
+}
+
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
@@ -212,9 +218,12 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			INTERESTING(p);
+			if (!interesting_process(p))
+				continue;
 			if (p->flags & PF_FROZEN)
 				continue;
+			if (p->state == TASK_STOPPED)
+				continue;
 
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
@@ -245,19 +254,56 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+ 		if (!interesting_process(p))
+			continue;
+ 		if (p->flags & PF_FROZEN) {
+ 			p->flags &= ~PF_FROZEN;
+ 			wake_up_process(p);
+ 		} else
+ 			PRINTK(KERN_INFO " Strange, %s not frozen\n", p->comm );
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	schedule();
 	printk( " done\n" );
 	MDELAY(500);
 }



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
