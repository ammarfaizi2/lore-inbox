Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVI1HNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVI1HNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVI1HNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:13:43 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:36995 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030203AbVI1HNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:13:20 -0400
Date: Wed, 28 Sep 2005 09:12:37 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 7/7] HPET-RTC: cache the comparator register
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071236.23025.15941.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: 94e7f633d018021bce7a7f8fb1fa3035
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reads from an HPET register require a round trip to the south bridge
and are almost as slow as PCI reads.  By caching the last value we've
written to the comparator register, we can eliminate all HPET reads
from the fast path in the emulated RTC interrupt handler.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/time_hpet.c	2005-09-27 21:59:13.000000000 +0200
+++ linux-2.6.13/arch/i386/kernel/time_hpet.c	2005-09-27 22:01:29.000000000 +0200
@@ -275,6 +275,7 @@ static unsigned long PIE_freq = DEFAULT_
 static unsigned long PIE_count;
 
 static unsigned long hpet_rtc_int_freq; /* RTC interrupt frequency */
+static unsigned int hpet_t1_cmp; /* cached comparator register */
 
 /*
  * Timer 1 for RTC, we do not use periodic interrupt feature,
@@ -306,6 +307,7 @@ int hpet_rtc_timer_init(void)
 	cnt = hpet_readl(HPET_COUNTER);
 	cnt += ((hpet_tick*HZ)/hpet_rtc_int_freq);
 	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
 	local_irq_restore(flags);
 
 	cfg = hpet_readl(HPET_T1_CFG);
@@ -333,9 +335,10 @@ static void hpet_rtc_timer_reinit(void)
 		hpet_rtc_int_freq = DEFAULT_RTC_INT_FREQ;
 
 	/* It is more accurate to use the comparator value than current count.*/
-	cnt = hpet_readl(HPET_T1_CMP);
+	cnt = hpet_t1_cmp;
 	cnt += hpet_tick*HZ/hpet_rtc_int_freq;
 	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
 }
 
 /*
Index: linux-2.6.13/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.13.orig/arch/x86_64/kernel/time.c	2005-09-27 21:59:13.000000000 +0200
+++ linux-2.6.13/arch/x86_64/kernel/time.c	2005-09-27 22:01:29.000000000 +0200
@@ -1100,6 +1100,7 @@ static unsigned long PIE_freq = DEFAULT_
 static unsigned long PIE_count;
 
 static unsigned long hpet_rtc_int_freq; /* RTC interrupt frequency */
+static unsigned int hpet_t1_cmp; /* cached comparator register */
 
 int is_hpet_enabled(void)
 {
@@ -1136,6 +1137,7 @@ int hpet_rtc_timer_init(void)
 	cnt = hpet_readl(HPET_COUNTER);
 	cnt += ((hpet_tick*HZ)/hpet_rtc_int_freq);
 	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
 	local_irq_restore(flags);
 
 	cfg = hpet_readl(HPET_T1_CFG);
@@ -1163,9 +1165,10 @@ static void hpet_rtc_timer_reinit(void)
 		hpet_rtc_int_freq = DEFAULT_RTC_INT_FREQ;
 
 	/* It is more accurate to use the comparator value than current count.*/
-	cnt = hpet_readl(HPET_T1_CMP);
+	cnt = hpet_t1_cmp;
 	cnt += hpet_tick*HZ/hpet_rtc_int_freq;
 	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
 }
 
 /*
