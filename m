Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbTGUJrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 05:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269572AbTGUJrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 05:47:12 -0400
Received: from maila.telia.com ([194.22.194.231]:57085 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S269557AbTGUJrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 05:47:10 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Jul 2003 12:00:59 +0200
In-Reply-To: <20030717200039.GA227@elf.ucw.cz>
Message-ID: <m2u19g9p2c.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> > I have done some testing of the software suspend function in
> > 2.6.0-test1. It works mostly very well, but I have found two problems.
> > 
> > The first problem is that software suspend fails if a process is
> > stopped before you invoke suspend. (For example, by starting cat from
> > the shell and pressing ctrl-z.) When the processes are woken up again,
> > the cat process is stuck in the schedule loop in refrigerator(),
> > sucking up all available cpu time.
> 
> Thanks for a report. If it came with a patch it would be better
> ;-). I'll take a look.

Here is a patch to make software suspend correctly handle stopped
processes. It should apply cleanly on top of the patch you sent to
Linus to decouple SOFTWARE_SUSPEND and ACPI_SLEEP.

diff -u -r orig/linux-stopped/kernel/suspend.c linux-stopped/kernel/suspend.c
--- orig/linux-stopped/kernel/suspend.c	Sun Jul 20 11:14:58 2003
+++ linux-stopped/kernel/suspend.c	Mon Jul 21 11:51:51 2003
@@ -164,14 +164,18 @@
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
 
 #define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 
@@ -214,9 +218,12 @@
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
@@ -247,12 +254,15 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+		if (!interesting_process(p))
+			continue;
+
+		p->flags &= ~PF_FREEZE;
+		if (p->flags & PF_FROZEN) {
+			p->flags &= ~PF_FROZEN;
+			wake_up_process(p);
+		} else
+			PRINTK(KERN_INFO " Strange, %s not frozen\n", p->comm );
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
