Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWF0SN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWF0SN6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWF0SN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:13:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:21664 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030204AbWF0SN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:13:57 -0400
Date: Tue, 27 Jun 2006 13:14:30 -0500
From: minyard@acm.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] IPMI: remove high res timer code
Message-ID: <20060627181430.GB10805@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There was some old high-res-timer code in the IPMI driver that
is dead.  Remove it.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.17.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
@@ -55,23 +55,6 @@
 #include <linux/mutex.h>
 #include <linux/kthread.h>
 #include <asm/irq.h>
-#ifdef CONFIG_HIGH_RES_TIMERS
-#include <linux/hrtime.h>
-# if defined(schedule_next_int)
-/* Old high-res timer code, do translations. */
-#  define get_arch_cycles(a) quick_update_jiffies_sub(a)
-#  define arch_cycles_per_jiffy cycles_per_jiffies
-# endif
-static inline void add_usec_to_timer(struct timer_list *t, long v)
-{
-	t->arch_cycle_expires += nsec_to_arch_cycle(v * 1000);
-	while (t->arch_cycle_expires >= arch_cycles_per_jiffy)
-	{
-		t->expires++;
-		t->arch_cycle_expires -= arch_cycles_per_jiffy;
-	}
-}
-#endif
 #include <linux/interrupt.h>
 #include <linux/rcupdate.h>
 #include <linux/ipmi_smi.h>
@@ -243,8 +226,6 @@ static int register_xaction_notifier(str
 	return atomic_notifier_chain_register(&xaction_notifier_list, nb);
 }
 
-static void si_restart_short_timer(struct smi_info *smi_info);
-
 static void deliver_recv_msg(struct smi_info *smi_info,
 			     struct ipmi_smi_msg *msg)
 {
@@ -768,7 +749,6 @@ static void sender(void                *
 	    && (smi_info->curr_msg == NULL))
 	{
 		start_next_msg(smi_info);
-		si_restart_short_timer(smi_info);
 	}
 	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
 }
@@ -833,37 +813,6 @@ static void request_events(void *send_in
 
 static int initialized = 0;
 
-/* Must be called with interrupts off and with the si_lock held. */
-static void si_restart_short_timer(struct smi_info *smi_info)
-{
-#if defined(CONFIG_HIGH_RES_TIMERS)
-	unsigned long flags;
-	unsigned long jiffies_now;
-	unsigned long seq;
-
-	if (del_timer(&(smi_info->si_timer))) {
-		/* If we don't delete the timer, then it will go off
-		   immediately, anyway.  So we only process if we
-		   actually delete the timer. */
-
-		do {
-			seq = read_seqbegin_irqsave(&xtime_lock, flags);
-			jiffies_now = jiffies;
-			smi_info->si_timer.expires = jiffies_now;
-			smi_info->si_timer.arch_cycle_expires
-				= get_arch_cycles(jiffies_now);
-		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-
-		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
-
-		add_timer(&(smi_info->si_timer));
-		spin_lock_irqsave(&smi_info->count_lock, flags);
-		smi_info->timeout_restarts++;
-		spin_unlock_irqrestore(&smi_info->count_lock, flags);
-	}
-#endif
-}
-
 static void smi_timeout(unsigned long data)
 {
 	struct smi_info   *smi_info = (struct smi_info *) data;
@@ -904,31 +853,15 @@ static void smi_timeout(unsigned long da
 	/* If the state machine asks for a short delay, then shorten
            the timer timeout. */
 	if (smi_result == SI_SM_CALL_WITH_DELAY) {
-#if defined(CONFIG_HIGH_RES_TIMERS)
-		unsigned long seq;
-#endif
 		spin_lock_irqsave(&smi_info->count_lock, flags);
 		smi_info->short_timeouts++;
 		spin_unlock_irqrestore(&smi_info->count_lock, flags);
-#if defined(CONFIG_HIGH_RES_TIMERS)
-		do {
-			seq = read_seqbegin_irqsave(&xtime_lock, flags);
-			smi_info->si_timer.expires = jiffies;
-			smi_info->si_timer.arch_cycle_expires
-				= get_arch_cycles(smi_info->si_timer.expires);
-		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
-#else
 		smi_info->si_timer.expires = jiffies + 1;
-#endif
 	} else {
 		spin_lock_irqsave(&smi_info->count_lock, flags);
 		smi_info->long_timeouts++;
 		spin_unlock_irqrestore(&smi_info->count_lock, flags);
 		smi_info->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
-#if defined(CONFIG_HIGH_RES_TIMERS)
-		smi_info->si_timer.arch_cycle_expires = 0;
-#endif
 	}
 
  do_add_timer:
