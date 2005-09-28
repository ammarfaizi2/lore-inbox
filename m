Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVI1HNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVI1HNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVI1HNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:13:46 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:34179 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030205AbVI1HNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:13:20 -0400
Date: Wed, 28 Sep 2005 09:12:26 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 5/7] HPET-RTC: disable interrupt when no longer needed
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071226.23025.56681.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: f4d1cd71b546dc9332e9a967de127e57
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the emulated RTC interrupt is no longer needed, we better disable
it; otherwise, we get a spurious interrupt whenever the timer has
rolled over and reaches the same comparator value.

Having a superfluous interrupt every five minutes doesn't hurt much,
but it's bad style anyway.  ;-)

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/time_hpet.c	2005-09-27 21:54:12.000000000 +0200
+++ linux-2.6.13/arch/i386/kernel/time_hpet.c	2005-09-27 21:56:38.000000000 +0200
@@ -319,8 +319,12 @@ static void hpet_rtc_timer_reinit(void)
 {
 	unsigned int cfg, cnt;
 
-	if (!(PIE_on | AIE_on | UIE_on))
+	if (unlikely(!(PIE_on | AIE_on | UIE_on))) {
+		cfg = hpet_readl(HPET_T1_CFG);
+		cfg &= ~HPET_TN_ENABLE;
+		hpet_writel(cfg, HPET_T1_CFG);
 		return;
+	}
 
 	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
 		hpet_rtc_int_freq = PIE_freq;
Index: linux-2.6.13/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.13.orig/arch/x86_64/kernel/time.c	2005-09-27 21:54:12.000000000 +0200
+++ linux-2.6.13/arch/x86_64/kernel/time.c	2005-09-27 21:57:27.000000000 +0200
@@ -1149,8 +1149,12 @@ static void hpet_rtc_timer_reinit(void)
 {
 	unsigned int cfg, cnt;
 
-	if (!(PIE_on | AIE_on | UIE_on))
+	if (unlikely(!(PIE_on | AIE_on | UIE_on))) {
+		cfg = hpet_readl(HPET_T1_CFG);
+		cfg &= ~HPET_TN_ENABLE;
+		hpet_writel(cfg, HPET_T1_CFG);
 		return;
+	}
 
 	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
 		hpet_rtc_int_freq = PIE_freq;
