Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUDGVbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUDGVbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:31:02 -0400
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:21632 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264170AbUDGVa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:30:59 -0400
Date: Wed, 7 Apr 2004 23:30:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Swsusp should not wake up stopped processes
Message-ID: <20040407213045.GA689@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If you stop process with ^Z, then suspend, process is awakened. Thats
a bug. Solution is to simply leave already stopped processes
alone. Plus we no longer use TASK_STOPPED for processes in
refrigerator. Userland might see us and get confused... Please apply,

								Pavel

--- clean/kernel/power/process.c	2003-08-27 12:00:53.000000000 +0200
+++ linux/kernel/power/process.c	2004-04-07 23:14:19.000000000 +0200
@@ -30,7 +30,8 @@
 	if ((p == current) || 
 	    (p->flags & PF_IOTHREAD) || 
 	    (p->state == TASK_ZOMBIE) ||
-	    (p->state == TASK_DEAD))
+	    (p->state == TASK_DEAD) ||
+	    (p->state == TASK_STOPPED))
 		return 0;
 	return 1;
 }
@@ -38,21 +39,19 @@
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
 {
-	/* You need correct to work with real-time processes.
-	   OTOH, this way one process may see (via /proc/) some other
-	   process in stopped state (and thereby discovered we were
-	   suspended. We probably do not care. 
-	 */
+	/* Hmm, should we be allowed to suspend when there are realtime
+	   processes around? */
 	long save;
 	save = current->state;
-	current->state = TASK_STOPPED;
+	current->state = TASK_UNINTERRUPTIBLE;
 	pr_debug("%s entered refrigerator\n", current->comm);
 	printk("=");
 	current->flags &= ~PF_FREEZE;
-	if (flag)
-		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
-					   and that may lead to 100%CPU sucking because those threads
-					   just don't manage signals. */
+
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending(); /* We sent fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
+
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
