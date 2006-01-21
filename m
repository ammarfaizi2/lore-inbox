Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWAUCgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWAUCgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAUCgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:36:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:7926 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750793AbWAUCgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:36:54 -0500
Subject: [PATCH RT] don't let printk unconditionally turn on interrupts
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 21:36:41 -0500
Message-Id: <1137811001.6762.179.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

My first try at booting -rt8 on my machine crashed immediately.  No nmi,
no nothing. Just a lockup at the registration of the ACPI_PM timer.
This would happen every time, and after struggling for a while, I
finally found out why!

The printk in timeofday_periodic_hook that is called holding the
write_lock of system_time_lock (a raw_seq_lock) was causing lots of
havoc.  The printk would turn on interrupts, and then I would get a
deadlock when the interrupt would do a read on system_time_lock.

So here's the patch:

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rt8/kernel/printk.c
===================================================================
--- linux-2.6.15-rt8.orig/kernel/printk.c	2006-01-20 14:12:07.000000000 -0500
+++ linux-2.6.15-rt8/kernel/printk.c	2006-01-20 21:23:46.000000000 -0500
@@ -772,7 +772,7 @@
 		 */
 #if defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_PRINTK_IGNORE_LOGLEVEL) && !defined(CONFIG_PPC) \
     && !defined(CONFIG_PARANOID_GENERIC_TIME)
-		spin_unlock_irq(&logbuf_lock);
+		spin_unlock_irqrestore(&logbuf_lock, flags);
 #else
 		spin_unlock(&logbuf_lock);
 #endif


