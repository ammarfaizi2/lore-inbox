Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVBCCF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVBCCF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVBCCF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:05:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:48604 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262446AbVBCCFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:05:12 -0500
Subject: i386 HPET code
From: john stultz <johnstul@us.ibm.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 18:05:05 -0800
Message-Id: <1107396306.2040.237.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Venkatesh,
	I've been looking into a bug where i386 2.6 kernels do not boot on IBM
e325s if HPET_TIMER is enabled (hpet=disable works around the issue).
When running x86-64 kernels, the issue isn't seen. It appears that after
the hpet is enabled, we stop receiving timer ticks. I've not played on
any other HPET enabled systems, nor have I looked at the HPET spec, so
I'm not sure if this is a hardware issue or not.

The following patch, which uses the x86-64 code for
hpet_timer_stop_set_go() seems to fix the issue.

Your thoughts?

thanks
-john


===== arch/i386/kernel/time_hpet.c 1.10 vs edited =====
--- 1.10/arch/i386/kernel/time_hpet.c	2004-11-02 06:40:42 -08:00
+++ edited/arch/i386/kernel/time_hpet.c	2005-02-02 17:59:27 -08:00
@@ -64,29 +64,30 @@
 {
 	unsigned int cfg;
 
-	/*
-	 * Stop the timers and reset the main counter.
-	 */
+/*
+ * Stop the timers and reset the main counter.
+ */
+
 	cfg = hpet_readl(HPET_CFG);
-	cfg &= ~HPET_CFG_ENABLE;
+	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
 	hpet_writel(cfg, HPET_CFG);
 	hpet_writel(0, HPET_COUNTER);
 	hpet_writel(0, HPET_COUNTER + 4);
 
-	/*
-	 * Set up timer 0, as periodic with first interrupt to happen at
-	 * hpet_tick, and period also hpet_tick.
-	 */
-	cfg = hpet_readl(HPET_T0_CFG);
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
-	       HPET_TN_SETVAL | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T0_CFG);
-	hpet_writel(tick, HPET_T0_CMP);
+/*
+ * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
+ * and period also hpet_tick.
+ */
+
+	hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
+		    HPET_TN_32BIT, HPET_T0_CFG);
+	hpet_writel(hpet_tick, HPET_T0_CMP);
+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
+
+/*
+ * Go!
+ */
 
-	/*
- 	 * Go!
- 	 */
-	cfg = hpet_readl(HPET_CFG);
 	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
 	hpet_writel(cfg, HPET_CFG);
 


