Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTEJAaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTEJAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 20:30:00 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:22925 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263619AbTEJA36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 20:29:58 -0400
Date: Sat, 10 May 2003 02:42:32 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH] Unexpected lockups in scheduler with 2.5.60-2.5.69
Message-ID: <20030510004231.GA12822@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  there is problem with send_sig_info. This function can be invoked from
timer interrupt (timer_interrpt -> do_timer -> update_process_times ->
-> update_one_process -> ( do_process_times, do_it_prof, do_it_virt ) ->
-> send_sig -> send_sig_info) but it uses spin_unlock_irq instead of
correct spin_unlock_irqrestore.

  This enables interrupts, and later scheduler_tick() locks runqueue
(without disabling interrupts). And if we are unlucky, new interrupt
comes at this point. And if this interrupt tries to do wake_up()
(like RTC interrupt does), we deadlock on runqueue lock :-( And
it is bad...

  Problem was introduced by signal-fixes-2.5.59-A4, which spilt
original send_sig_info into two functions, and in one branch
it started using these unsafe spinlock variants (while group
variant uses irqsave/restore correctly).
					Best regards,
						Petr Vandrovec


diff -urdN linux/kernel/signal.c linux/kernel/signal.c
--- linux/kernel/signal.c	2003-05-09 04:35:12.000000000 +0200
+++ linux/kernel/signal.c	2003-05-10 01:55:24.000000000 +0200
@@ -1145,6 +1145,7 @@
 int
 send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -1154,9 +1155,9 @@
 	 * going away or changing from under us.
 	 */
 	read_lock(&tasklist_lock);  
-	spin_lock_irq(&p->sighand->siglock);
+	spin_lock_irqsave(&p->sighand->siglock, flags);
 	ret = specific_send_sig_info(sig, info, p);
-	spin_unlock_irq(&p->sighand->siglock);
+	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	read_unlock(&tasklist_lock);
 	return ret;
 }
