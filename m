Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933043AbWKSTmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbWKSTmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933079AbWKSTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:42:12 -0500
Received: from h155.mvista.com ([63.81.120.155]:26285 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933043AbWKSTmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:42:10 -0500
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: mingo@elte.hu
Subject: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Date: Sun, 19 Nov 2006 22:43:34 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, dwalker@mvista.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611192243.34850.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As fasteoi type chips never had to define their ack() method before the
recent Ingo's change to handle_fasteoi_irq(), any attempt to execute handler
in thread resulted in the kernel crash. So, define their ack() methods to be
the same as their eoi() ones...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Since there was no feedback on three solutions I suggested, I'm going the way
of least resistance and making the fasteoi type chips behave the way that
handle_fasteoi_irq() is expecting from them...

 arch/powerpc/platforms/cell/interrupt.c |    1 +
 arch/powerpc/platforms/iseries/irq.c    |    1 +
 arch/powerpc/platforms/pseries/xics.c   |    2 ++
 arch/powerpc/sysdev/mpic.c              |    1 +
 4 files changed, 5 insertions(+)

Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -83,6 +83,7 @@ static struct irq_chip iic_chip = {
 	.typename = " CELL-IIC ",
 	.mask = iic_mask,
 	.unmask = iic_unmask,
+	.ack = iic_eoi,
 	.eoi = iic_eoi,
 };
 
Index: linux-2.6/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/irq.c
+++ linux-2.6/arch/powerpc/platforms/iseries/irq.c
@@ -282,6 +282,7 @@ static struct irq_chip iseries_pic = {
 	.shutdown	= iseries_shutdown_IRQ,
 	.unmask		= iseries_enable_IRQ,
 	.mask		= iseries_disable_IRQ,
+	.ack		= iseries_end_IRQ,
 	.eoi		= iseries_end_IRQ
 };
 
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c
@@ -477,6 +477,7 @@ static struct irq_chip xics_pic_direct =
 	.startup = xics_startup,
 	.mask = xics_mask_irq,
 	.unmask = xics_unmask_irq,
+	.ack = xics_eoi_direct,
 	.eoi = xics_eoi_direct,
 	.set_affinity = xics_set_affinity
 };
@@ -487,6 +488,7 @@ static struct irq_chip xics_pic_lpar = {
 	.startup = xics_startup,
 	.mask = xics_mask_irq,
 	.unmask = xics_unmask_irq,
+	.ack = xics_eoi_lpar,
 	.eoi = xics_eoi_lpar,
 	.set_affinity = xics_set_affinity
 };
Index: linux-2.6/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6/arch/powerpc/sysdev/mpic.c
@@ -718,6 +718,7 @@ static int mpic_set_irq_type(unsigned in
 static struct irq_chip mpic_irq_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_irq,
+	.ack		= mpic_end_irq,
 	.eoi		= mpic_end_irq,
 	.set_type	= mpic_set_irq_type,
 };

