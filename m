Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUJXOZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUJXOZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUJXOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:25:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:52168 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261495AbUJXOZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:25:33 -0400
Date: Sun, 24 Oct 2004 16:25:25 +0200 (MEST)
Message-Id: <200410241425.i9OEPPTM015941@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.9-mm1] perfctr ppc32 update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch is an update to perfctr's PPC32 low-level driver:
- Add support for the MPC7447A processor.
- Add partial support for the new MPC7448 processor.
  PLL_CFG decoding not yet implemented due to lack of docs.
- Enable overflow interrupt support on all G4 processors except
  those with the DEC/TAU/PMI erratum.
- Wrap thread_struct's perfctr pointer in an #ifdef to avoid
  bloat when perfctr is disabled. This was requested by some
  users in the PPC32 embedded world.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c       |   20 +++++++++++---------
 include/asm-ppc/processor.h |    2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff -rupN linux-2.6.9-mm1/drivers/perfctr/ppc.c linux-2.6.9-mm1.perfctr-ppc32-update/drivers/perfctr/ppc.c
--- linux-2.6.9-mm1/drivers/perfctr/ppc.c	2004-10-24 01:06:08.000000000 +0200
+++ linux-2.6.9-mm1.perfctr-ppc32-update/drivers/perfctr/ppc.c	2004-10-24 02:07:44.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: ppc.c,v 1.12 2004/05/31 18:13:42 mikpe Exp $
+/* $Id: ppc.c,v 1.27 2004/10/24 00:07:44 mikpe Exp $
  * PPC32 performance-monitoring counters driver.
  *
  * Copyright (C) 2004  Mikael Pettersson
@@ -149,14 +149,6 @@ static inline int perfctr_cstatus_has_mm
  *   doing this (a) reserves one PMC, and (b) needs indirect accesses
  *   since the SPR number in general isn't known at compile-time.
  *
- * Driver notes
- * ------------
- * - The driver currently does not support performance monitor interrupts,
- *   mostly because of the 750/7400/7410 erratum. Working around it would
- *   require disabling the decrementer interrupt, reserving a performance
- *   counter and setting it up for TBL bit-flip events, and having the PMI
- *   handler invoke the decrementer handler.
- *
  * 604
  * ---
  * 604 has MMCR0, PMC1, PMC2, SIA, and SDA.
@@ -903,10 +895,13 @@ static int __init known_init(void)
 		pll_type = PLL_7400;
 		break;
 	case 0x800C: /* 7410 */
+		if ((pvr & 0xFFFF) >= 0x1103)
+			features |= PERFCTR_FEATURE_PCINT;
 		pm_type = PM_7400;
 		pll_type = PLL_7400;
 		break;
 	case 0x8000: /* 7451/7441 */
+		features |= PERFCTR_FEATURE_PCINT;
 		pm_type = PM_7450;
 		pll_type = PLL_7450;
 		break;
@@ -916,9 +911,16 @@ static int __init known_init(void)
 		pll_type = ((pvr & 0xFFFF) < 0x0303) ? PLL_7450 : PLL_7457;
 		break;
 	case 0x8002: /* 7457/7447 */
+	case 0x8003: /* 7447A */
+		features |= PERFCTR_FEATURE_PCINT;
 		pm_type = PM_7450;
 		pll_type = PLL_7457;
 		break;
+	case 0x8004: /* 7448 */
+		features |= PERFCTR_FEATURE_PCINT;
+		pm_type = PM_7450;
+		pll_type = PLL_NONE; /* known to differ from 7447A, no details yet */
+		break;
 	default:
 		return -ENODEV;
 	}
diff -rupN linux-2.6.9-mm1/include/asm-ppc/processor.h linux-2.6.9-mm1.perfctr-ppc32-update/include/asm-ppc/processor.h
--- linux-2.6.9-mm1/include/asm-ppc/processor.h	2004-10-24 01:06:17.000000000 +0200
+++ linux-2.6.9-mm1.perfctr-ppc32-update/include/asm-ppc/processor.h	2004-10-24 14:51:02.811634000 +0200
@@ -126,7 +126,9 @@ struct thread_struct {
 	unsigned long	spefscr;	/* SPE & eFP status */
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
+#ifdef CONFIG_PERFCTR_VIRTUAL
 	struct vperfctr *perfctr;	/* performance counters */
+#endif
 };
 
 #define ARCH_MIN_TASKALIGN 16
