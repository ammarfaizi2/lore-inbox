Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVBCOeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVBCOeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263318AbVBCObT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:31:19 -0500
Received: from fmr14.intel.com ([192.55.52.68]:64136 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S263848AbVBCO2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:28:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: i386 HPET code
Date: Thu, 3 Feb 2005 06:28:27 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: i386 HPET code
Thread-Index: AcUJlMpMZ/3QgHvgSPiEUnOrIFAxfgAZ2kcg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "john stultz" <johnstul@us.ibm.com>
Cc: "Andi Kleen" <ak@suse.de>, "lkml" <linux-kernel@vger.kernel.org>,
       "keith maanthey" <kmannth@us.ibm.com>,
       "Max Asbock" <masbock@us.ibm.com>, "Chris McDermott" <lcm@us.ibm.com>
X-OriginalArrivalTime: 03 Feb 2005 14:28:29.0002 (UTC) FILETIME=[A126F2A0:01C509FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi John, Andrew,


Can you check whether only the following change makes the problem go
away. If yes, then it looks like a hardware issue.

>	hpet_writel(hpet_tick, HPET_T0_CMP);
>+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
>

Thanks,
Venki

>-----Original Message-----
>From: john stultz [mailto:johnstul@us.ibm.com] 
>Sent: Wednesday, February 02, 2005 6:05 PM
>To: Pallipadi, Venkatesh
>Cc: Andi Kleen; lkml; keith maanthey; Max Asbock; Chris McDermott
>Subject: i386 HPET code
>
>Hey Venkatesh,
>	I've been looking into a bug where i386 2.6 kernels do 
>not boot on IBM
>e325s if HPET_TIMER is enabled (hpet=disable works around the issue).
>When running x86-64 kernels, the issue isn't seen. It appears 
>that after
>the hpet is enabled, we stop receiving timer ticks. I've not played on
>any other HPET enabled systems, nor have I looked at the HPET spec, so
>I'm not sure if this is a hardware issue or not.
>
>The following patch, which uses the x86-64 code for
>hpet_timer_stop_set_go() seems to fix the issue.
>
>Your thoughts?
>
>thanks
>-john
>
>
>===== arch/i386/kernel/time_hpet.c 1.10 vs edited =====
>--- 1.10/arch/i386/kernel/time_hpet.c	2004-11-02 06:40:42 -08:00
>+++ edited/arch/i386/kernel/time_hpet.c	2005-02-02 
>17:59:27 -08:00
>@@ -64,29 +64,30 @@
> {
> 	unsigned int cfg;
> 
>-	/*
>-	 * Stop the timers and reset the main counter.
>-	 */
>+/*
>+ * Stop the timers and reset the main counter.
>+ */
>+
> 	cfg = hpet_readl(HPET_CFG);
>-	cfg &= ~HPET_CFG_ENABLE;
>+	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
> 	hpet_writel(cfg, HPET_CFG);
> 	hpet_writel(0, HPET_COUNTER);
> 	hpet_writel(0, HPET_COUNTER + 4);
> 
>-	/*
>-	 * Set up timer 0, as periodic with first interrupt to happen at
>-	 * hpet_tick, and period also hpet_tick.
>-	 */
>-	cfg = hpet_readl(HPET_T0_CFG);
>-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC |
>-	       HPET_TN_SETVAL | HPET_TN_32BIT;
>-	hpet_writel(cfg, HPET_T0_CFG);
>-	hpet_writel(tick, HPET_T0_CMP);
>+/*
>+ * Set up timer 0, as periodic with first interrupt to happen 
>at hpet_tick,
>+ * and period also hpet_tick.
>+ */
>+
>+	hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
>+		    HPET_TN_32BIT, HPET_T0_CFG);
>+	hpet_writel(hpet_tick, HPET_T0_CMP);
>+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
>+
>+/*
>+ * Go!
>+ */
> 
>-	/*
>- 	 * Go!
>- 	 */
>-	cfg = hpet_readl(HPET_CFG);
> 	cfg |= HPET_CFG_ENABLE | HPET_CFG_LEGACY;
> 	hpet_writel(cfg, HPET_CFG);
> 
>
>
>
