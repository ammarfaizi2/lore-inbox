Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbTGUVOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGUVOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:14:01 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:32437 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270730AbTGUVNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:13:50 -0400
Date: Mon, 21 Jul 2003 23:28:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030721212828.GE436@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz> <m2u19g9p2c.fsf@telia.com> <20030721125813.GA4775@zaurus.ucw.cz> <m21xwkvte8.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21xwkvte8.fsf@telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But why do you touch PF_FROZEN here? Refrigerator should do that.
> > And wake_up_process should not be needed...
> > If it is in refrigerator, it polls PF_FREEZE...
> 
> Note that the old code always called wake_up_process(), which is
> necessary to make the process run one more iteration in refrigerator()
> and relize that it is time to unfreeze.
> 
> The patch changes things so that wake_up_process() is NOT called if
> the process is stopped at some other place than in refrigerator().
> This ensures that processes that were stopped before we invoked swsusp
> are still stopped after resume.

Yes, but you still print warning for them. I hopefully killed that.

> I manually clear PF_FREEZE here in an attempt to handle a race
> condition, but I realize I need to understand more of the scheduler
> and signal code before I know for sure if this is necessary and/or
> sufficient.

I do not see the race so I killed that... Here's what I applied.

								Pavel

--- /usr/src/tmp/linux/kernel/suspend.c	2003-07-21 22:15:39.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-07-21 22:11:28.000000000 +0200
@@ -5,7 +5,7 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
  *
  * I'd like to thank the following people for their work:
  * 
@@ -84,7 +84,6 @@
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
 
 /* References to section boundaries */
-extern char _text, _etext, _edata, __bss_start, _end;
 extern char __nosave_begin, __nosave_end;
 
 extern int is_head_of_free_region(struct page *);
@@ -164,14 +163,21 @@
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
+	if (p->state == TASK_STOPPED)
+		return 0;
+
+
+	return 1;
+}
 
 #define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 
@@ -214,7 +220,8 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			INTERESTING(p);
+			if (!interesting_process(p))
+				continue;
 			if (p->flags & PF_FROZEN)
 				continue;
 
@@ -247,13 +254,14 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN)
-			p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+ 		if (!interesting_process(p))
+ 			continue;
+ 
+ 		if (p->flags & PF_FROZEN) {
+ 			p->flags &= ~PF_FROZEN;
+ 			wake_up_process(p);
+ 		} else
+ 			PRINTK(KERN_ERR " Strange, %s not frozen\n", p->comm );
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
