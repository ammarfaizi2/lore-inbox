Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVHCW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVHCW7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVHCW5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:57:08 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:20107 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261615AbVHCWyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:54:35 -0400
Message-ID: <42F14B26.1070409@acm.org>
Date: Wed, 03 Aug 2005 17:54:30 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IPMI driver update part 2, high-res timer support fixes
Content-Type: multipart/mixed;
 boundary="------------060105010408010702090001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060105010408010702090001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060105010408010702090001
Content-Type: unknown/unknown;
 name="ipmi_hrt_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_hrt_fixes.diff"

Fix some problems with the high-res timer support.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13-rc5/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.13-rc5.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.13-rc5/drivers/char/ipmi/ipmi_si_intf.c
@@ -61,11 +61,11 @@
 # endif
 static inline void add_usec_to_timer(struct timer_list *t, long v)
 {
-	t->sub_expires += nsec_to_arch_cycle(v * 1000);
-	while (t->sub_expires >= arch_cycles_per_jiffy)
+	t->arch_cycle_expires += nsec_to_arch_cycle(v * 1000);
+	while (t->arch_cycle_expires >= arch_cycles_per_jiffy)
 	{
 		t->expires++;
-		t->sub_expires -= arch_cycles_per_jiffy;
+		t->arch_cycle_expires -= arch_cycles_per_jiffy;
 	}
 }
 #endif
@@ -761,18 +761,20 @@
 #if defined(CONFIG_HIGH_RES_TIMERS)
 	unsigned long flags;
 	unsigned long jiffies_now;
+	unsigned long seq;
 
 	if (del_timer(&(smi_info->si_timer))) {
 		/* If we don't delete the timer, then it will go off
 		   immediately, anyway.  So we only process if we
 		   actually delete the timer. */
 
-		/* We already have irqsave on, so no need for it
-                   here. */
-		read_lock(&xtime_lock);
-		jiffies_now = jiffies;
-		smi_info->si_timer.expires = jiffies_now;
-		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
+		do {
+			seq = read_seqbegin_irqsave(&xtime_lock, flags);
+			jiffies_now = jiffies;
+			smi_info->si_timer.expires = jiffies_now;
+			smi_info->si_timer.arch_cycle_expires
+				= get_arch_cycles(jiffies_now);
+		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
 
@@ -826,15 +828,19 @@
 	/* If the state machine asks for a short delay, then shorten
            the timer timeout. */
 	if (smi_result == SI_SM_CALL_WITH_DELAY) {
+#if defined(CONFIG_HIGH_RES_TIMERS)
+		unsigned long seq;
+#endif
 		spin_lock_irqsave(&smi_info->count_lock, flags);
 		smi_info->short_timeouts++;
 		spin_unlock_irqrestore(&smi_info->count_lock, flags);
 #if defined(CONFIG_HIGH_RES_TIMERS)
-		read_lock(&xtime_lock);
-                smi_info->si_timer.expires = jiffies;
-                smi_info->si_timer.sub_expires
-                        = get_arch_cycles(smi_info->si_timer.expires);
-                read_unlock(&xtime_lock);
+		do {
+			seq = read_seqbegin_irqsave(&xtime_lock, flags);
+			smi_info->si_timer.expires = jiffies;
+			smi_info->si_timer.arch_cycle_expires
+				= get_arch_cycles(smi_info->si_timer.expires);
+		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
 #else
 		smi_info->si_timer.expires = jiffies + 1;
@@ -845,7 +851,7 @@
 		spin_unlock_irqrestore(&smi_info->count_lock, flags);
 		smi_info->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
 #if defined(CONFIG_HIGH_RES_TIMERS)
-		smi_info->si_timer.sub_expires = 0;
+		smi_info->si_timer.arch_cycle_expires = 0;
 #endif
 	}
 

--------------060105010408010702090001--
