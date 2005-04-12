Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVDLRxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVDLRxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVDLKg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:36:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:6088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262120AbVDLKbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:09 -0400
Message-Id: <200504121031.j3CAV3PW005218@shell0.pdx.osdl.net>
Subject: [patch 026/198] ppc32: ppc4xx_pic - add acknowledge when enabling level-sensitive IRQ
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ebs@ebshome.net,
       listmember@orkun.us
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eugene Surovegin <ebs@ebshome.net>

This patch adds interrupt acknowledge to the PPC4xx PIC enable_irq
implementation for level-sensitive IRQ sources.  This helps in cases when
enable/disable_irq is used in interrupt handlers for hardware, which
requires IRQ acknowledge to be issued from non-interrupt context (e.g. 
when actual ACK in device needs an I2C transaction).  For such strange
hardware, interrupt handler disables IRQ and defers actual ACK to some
other context.  When this happens, IRQ is enabled again.  For
level-sensitive sources we get spurious triggering right after IRQ is
enabled.  This patch fixes this.

Suggested by Tolunay Orkun <listmember@orkun.us>.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/syslib/ppc4xx_pic.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/ppc/syslib/ppc4xx_pic.c~ppc32-ppc4xx_pic-add-acknowledge-when-enabling-level-sensitive-irq arch/ppc/syslib/ppc4xx_pic.c
--- 25/arch/ppc/syslib/ppc4xx_pic.c~ppc32-ppc4xx_pic-add-acknowledge-when-enabling-level-sensitive-irq	2005-04-12 03:21:09.737656552 -0700
+++ 25-akpm/arch/ppc/syslib/ppc4xx_pic.c	2005-04-12 03:21:09.740656096 -0700
@@ -41,7 +41,10 @@ extern unsigned char ppc4xx_uic_ext_irq_
 #define UIC_HANDLERS(n)							\
 static void ppc4xx_uic##n##_enable(unsigned int irq)			\
 {									\
-	ppc_cached_irq_mask[n] |= IRQ_MASK_UIC##n(irq);			\
+	u32 mask = IRQ_MASK_UIC##n(irq);				\
+	if (irq_desc[irq].status & IRQ_LEVEL)				\
+		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
+	ppc_cached_irq_mask[n] |= mask;					\
 	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
 }									\
 									\
_
