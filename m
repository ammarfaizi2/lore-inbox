Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbUKLVrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbUKLVrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKLVrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:47:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:38102 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262628AbUKLVq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:46:29 -0500
Date: Fri, 12 Nov 2004 22:46:21 +0100 (MET)
Message-Id: <200411122146.iACLkLdr004348@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm5][3/3] perfctr ppc32 driver update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc32 low-level driver updates:
- Provide new API function for checking for pending interrupts:
  on ppc32 it always returns false.
- Enable performance counter interrupts on the later non-broken
  IBM 750 series processors (FX DD2.3, and GX).

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c     |    8 ++++++++
 include/asm-ppc/perfctr.h |    4 ++++
 2 files changed, 12 insertions(+)

diff -rupN linux-2.6.10-rc1-mm5/drivers/perfctr/ppc.c linux-2.6.10-rc1-mm5.perfctr-ppc32-driver-update/drivers/perfctr/ppc.c
--- linux-2.6.10-rc1-mm5/drivers/perfctr/ppc.c	2004-11-12 20:46:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5.perfctr-ppc32-driver-update/drivers/perfctr/ppc.c	2004-11-12 22:03:09.000000000 +0100
@@ -191,6 +191,8 @@ static inline int perfctr_cstatus_has_mm
  *
  * 750FX adds dual-PLL support and programmable core frequency switching.
  *
+ * 750FX DD2.3 fixed the DEC/PMI SRR0 corruption erratum.
+ *
  * 74xx
  * ----
  * 7400 adds MMCR2 and BAMR.
@@ -886,7 +888,13 @@ static int __init known_init(void)
 		pll_type = PLL_750;
 		break;
 	case 0x7000: case 0x7001: /* IBM750FX */
+		if ((pvr & 0xFF0F) >= 0x0203)
+			features |= PERFCTR_FEATURE_PCINT;
+		pm_type = PM_750;
+		pll_type = PLL_750FX;
+		break;
 	case 0x7002: /* IBM750GX */
+		features |= PERFCTR_FEATURE_PCINT;
 		pm_type = PM_750;
 		pll_type = PLL_750FX;
 		break;
diff -rupN linux-2.6.10-rc1-mm5/include/asm-ppc/perfctr.h linux-2.6.10-rc1-mm5.perfctr-ppc32-driver-update/include/asm-ppc/perfctr.h
--- linux-2.6.10-rc1-mm5/include/asm-ppc/perfctr.h	2004-11-12 20:46:55.000000000 +0100
+++ linux-2.6.10-rc1-mm5.perfctr-ppc32-driver-update/include/asm-ppc/perfctr.h	2004-11-12 21:46:16.000000000 +0100
@@ -160,6 +160,10 @@ extern unsigned int perfctr_cpu_identify
 #else
 static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
 #endif
+static inline int perfctr_cpu_has_pending_interrupt(const struct perfctr_cpu_state *state)
+{
+	return 0;
+}
 
 #endif	/* CONFIG_PERFCTR */
 
