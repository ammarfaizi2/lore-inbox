Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVLGDfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVLGDfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVLGDfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:35:05 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:22723 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964846AbVLGDfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:35:04 -0500
Subject: [RT] Race condition on bug output.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 22:34:53 -0500
Message-Id: <1133926493.6724.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I found a race condition in my kernel which can also be found in yours.
When I trigger the printk in check_periodic_interval, interrupts are
turned on in release_console_sem.  Unfortunately, this can have an
interrupt go off there (since they are turned back on there) and the
write_lock system_time_lock will be taken again, thus producing a
deadlock.

I'm not sure if this is the best solution, but this was the easiest.

Maybe the CONFIG_PARANOID_GENERIC_TIME should be added in the warnings
in init/main.c too?

Since interrupts are kept off in the ktimer (hrtimer, whatever) in
printk, this does not affect those patches.  This is a PREEMPT_RT only
problem.

-- Steve

Index: linux-2.6.14-rt22/kernel/printk.c
===================================================================
--- linux-2.6.14-rt22.orig/kernel/printk.c	2005-12-06 21:44:53.000000000 -0500
+++ linux-2.6.14-rt22/kernel/printk.c	2005-12-06 21:52:11.000000000 -0500
@@ -757,7 +757,8 @@
 		 * on PREEMPT_RT, call console drivers with
 		 * interrupts enabled (unless we are debugging):
 		 */
-#if defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_PRINTK_IGNORE_LOGLEVEL) && !defined(CONFIG_PPC)
+#if defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_PRINTK_IGNORE_LOGLEVEL) && !defined(CONFIG_PPC) \
+    && !defined(CONFIG_PARANOID_GENERIC_TIME)
 		spin_unlock_irq(&logbuf_lock);
 #else
 		spin_unlock(&logbuf_lock);


