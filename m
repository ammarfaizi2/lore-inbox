Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVI1HNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVI1HNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVI1HNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:13:45 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:35203 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030207AbVI1HNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:13:20 -0400
Date: Wed, 28 Sep 2005 09:12:31 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 6/7] HPET-RTC: fix timer config register accesses
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071231.23025.2922.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: f968a577e6e619a9e09c6ac4b381cfb5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the RTC timer is in non-periodic mode; some stupid BIOS
might have initialized it to periodic mode.

Furthermore, don't set the SETVAL bit in the config register.  This
wouldn't have any effect unless the timer was in period mode (which it
isn't), and then the actual timer frequency would be half that of the
desired one because incrementing the comparator in the interrupt
handler would be done after the hardware has already incremented it
itself.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/time_hpet.c	2005-09-27 21:56:38.000000000 +0200
+++ linux-2.6.13/arch/i386/kernel/time_hpet.c	2005-09-27 21:59:13.000000000 +0200
@@ -309,7 +309,8 @@ int hpet_rtc_timer_init(void)
 	local_irq_restore(flags);
 
 	cfg = hpet_readl(HPET_T1_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_SETVAL | HPET_TN_32BIT;
+	cfg &= ~HPET_TN_PERIODIC;
+	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_T1_CFG);
 
 	return 1;
@@ -335,12 +336,6 @@ static void hpet_rtc_timer_reinit(void)
 	cnt = hpet_readl(HPET_T1_CMP);
 	cnt += hpet_tick*HZ/hpet_rtc_int_freq;
 	hpet_writel(cnt, HPET_T1_CMP);
-
-	cfg = hpet_readl(HPET_T1_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_SETVAL | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T1_CFG);
-
-	return;
 }
 
 /*
Index: linux-2.6.13/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.13.orig/arch/x86_64/kernel/time.c	2005-09-27 21:57:27.000000000 +0200
+++ linux-2.6.13/arch/x86_64/kernel/time.c	2005-09-27 21:59:13.000000000 +0200
@@ -1139,7 +1139,8 @@ int hpet_rtc_timer_init(void)
 	local_irq_restore(flags);
 
 	cfg = hpet_readl(HPET_T1_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_SETVAL | HPET_TN_32BIT;
+	cfg &= ~HPET_TN_PERIODIC;
+	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_T1_CFG);
 
 	return 1;
@@ -1165,12 +1166,6 @@ static void hpet_rtc_timer_reinit(void)
 	cnt = hpet_readl(HPET_T1_CMP);
 	cnt += hpet_tick*HZ/hpet_rtc_int_freq;
 	hpet_writel(cnt, HPET_T1_CMP);
-
-	cfg = hpet_readl(HPET_T1_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_SETVAL | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T1_CFG);
-
-	return;
 }
 
 /*
