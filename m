Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTJJKOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTJJKOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:14:46 -0400
Received: from gprs148-28.eurotel.cz ([160.218.148.28]:43648 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262004AbTJJKOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:14:45 -0400
Date: Fri, 10 Oct 2003 12:14:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [pm] Better method of getting rid of signals
Message-ID: <20031010101435.GA5536@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

recalc_sigpending() seems like better idea, since it does not have
potential to kill some signal. Now with proper locking. Please apply,

								Pavel

--- tmp/linux/kernel/power/process.c	2003-08-27 12:00:53.000000000 +0200
+++ linux/kernel/power/process.c	2003-10-09 11:21:14.000000000 +0200
@@ -49,10 +49,11 @@
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
