Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVHXRG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVHXRG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVHXRG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:06:26 -0400
Received: from mail1.utc.com ([192.249.46.190]:36792 "EHLO mail1.utc.com")
	by vger.kernel.org with ESMTP id S1751215AbVHXRGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:06:24 -0400
Message-ID: <430CA8EB.3070105@cybsft.com>
Date: Wed, 24 Aug 2005 12:05:47 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc6-rt15 won't compile without HR-Timers
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090305060005090003000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090305060005090003000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,

Without the attached patch 2.6.13-rc6-rt15 won't compile for me with 
CONFIG_HIGH_RES_TIMERS not configured.

-- 
    kr

--------------090305060005090003000703
Content-Type: text/x-patch;
 name="nohrtfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nohrtfix.patch"

--- linux-2.6.13/include/linux/timer.h.orig	2005-08-24 11:15:22.000000000 -0500
+++ linux-2.6.13/include/linux/timer.h	2005-08-24 11:15:35.000000000 -0500
@@ -76,6 +76,7 @@
 
 #ifdef CONFIG_HIGH_RES_TIMERS
 extern void add_hres_timer_us(struct timer_list *timer, unsigned long usec);
+extern void init_hrtimers(void);
 #else
 #define add_hres_timer_us(t,exp) mod_timer(t,(exp*HZ)/1000000)
 #endif
@@ -125,7 +126,6 @@
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
 extern void init_timers(void);
-extern void init_hrtimers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
--- linux-2.6.13/kernel/timer.c.orig	2005-08-24 11:16:04.000000000 -0500
+++ linux-2.6.13/kernel/timer.c	2005-08-24 11:06:32.000000000 -0500
@@ -1920,9 +1920,9 @@
 	.notifier_call	= timer_cpu_notify,
 };
 
+#ifdef CONFIG_HIGH_RES_TIMERS
 void __init init_hrtimers(void)
 {
-#ifdef CONFIG_HIGH_RES_TIMERS
 	open_softirq(HRTIMER_SOFTIRQ,
 		     (void (*)(struct softirq_action*))hrtimers_expire_timers,
 		     NULL);
@@ -1931,8 +1931,8 @@
 	printk("arch_cycles_per_jiffy: %ld\n", arch_cycles_per_jiffy);
 	printk("hr_max_jiffies_expiry: %d\n", hr_max_jiffies_expiry);
 	printk("hr_max_expiry: %d\n", hr_max_expiry);
-#endif
 }
+#endif
 
 void __init init_timers(void)
 {

--------------090305060005090003000703--
