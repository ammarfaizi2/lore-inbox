Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVBKRFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVBKRFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVBKRFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:05:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5628 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262274AbVBKRFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:05:22 -0500
Subject: Interrupt starvation points
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1108141521.21940.44.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Feb 2005 09:05:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I found some points during schedule when interrupts are off for
long periods . These two patches seem to help. One enables interrupts
inside schedule() , so that interrupts are enabled after each
need-resched loop, then disabled again before __schedule() is called. 

        The other patch enabled interrupt before calling up on
kernel_sem ..This one could use some thinking over. I did this cause
up() is very expensive on ARM , and combined with the looping above
interrupts can stay off for a long time .. 


Daniel


Index: linux-2.6.10/kernel/sched.c
===================================================================
--- linux-2.6.10.orig/kernel/sched.c	2005-02-08 22:32:48.000000000 +0000
+++ linux-2.6.10/kernel/sched.c	2005-02-08 22:33:58.000000000 +0000
@@ -3038,9 +3038,10 @@
 		send_sig(SIGUSR2, current, 1);
 	}
 	do {
+		local_irq_disable();
 		__schedule();
+		local_irq_enable(); // TODO: do sti; ret
 	} while (unlikely(test_thread_flag(TIF_NEED_RESCHED)));
-	local_irq_enable(); // TODO: do sti; ret
 }
 
 EXPORT_SYMBOL(schedule);


Index: linux-2.6.10/lib/kernel_lock.c
===================================================================
--- linux-2.6.10.orig/lib/kernel_lock.c	2005-02-08 18:16:30.000000000 +0000
+++ linux-2.6.10/lib/kernel_lock.c	2005-02-08 22:53:09.000000000 +0000
@@ -114,7 +114,9 @@
 
 void __lockfunc __release_kernel_lock(void)
 {
+	local_irq_enable();
 	up(&kernel_sem);
+	local_irq_disable();
 }
 
 /*




