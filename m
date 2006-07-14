Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWGNNFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWGNNFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 09:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbWGNNFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 09:05:03 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:38061 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030441AbWGNNFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 09:05:02 -0400
Subject: [PATCH] remove volatile from nmi.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 09:04:48 -0400
Message-Id: <1152882288.1883.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm using this as something of an exercise to completely understand
memory barriers.  So if something is incorrect, please let me know.

This patch removes the volatile keyword from arch/i386/kernel/nmi.c.

The first removal is trivial, since the barrier in the while loop makes
it unnecessary. (as proved in "[patch] spinlocks: remove 'volatile'"
thread)
http://marc.theaimsgroup.com/?l=linux-kernel&m=115217423929806&w=2


The second is what I think is correct.  So please review.

Thanks,

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.18-rc1.orig/arch/i386/kernel/nmi.c	2006-07-14 08:35:00.000000000 -0400
+++ linux-2.6.18-rc1/arch/i386/kernel/nmi.c	2006-07-14 08:38:07.000000000 -0400
@@ -106,7 +106,7 @@ int nmi_active;
  */
 static __init void nmi_cpu_busy(void *data)
 {
-	volatile int *endflag = data;
+	int *endflag = data;
 	local_irq_enable_in_hardirq();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
@@ -121,7 +121,7 @@ static __init void nmi_cpu_busy(void *da
 
 static int __init check_nmi_watchdog(void)
 {
-	volatile int endflag = 0;
+	int endflag = 0;
 	unsigned int *prev_nmi_count;
 	int cpu;
 
@@ -150,7 +150,7 @@ static int __init check_nmi_watchdog(voi
 			continue;
 #endif
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
-			endflag = 1;
+			set_wmb(endflag, 1);
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
 				cpu,
 				prev_nmi_count[cpu],
@@ -161,7 +161,7 @@ static int __init check_nmi_watchdog(voi
 			return -1;
 		}
 	}
-	endflag = 1;
+	set_wmb(endflag, 1);
 	printk("OK.\n");
 
 	/* now that we know it works we can reduce NMI frequency to


