Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWGAPEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWGAPEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWGAO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:38 -0400
Received: from www.osadl.org ([213.239.205.134]:31140 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751529AbWGAO5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:03 -0400
Message-Id: <20060701145224.488981000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:31 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, greg@snapgear.com
Subject: [RFC][patch 11/44] M68KNOMMU: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-m68knommu.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/m68knommu/platform/5307/pit.c    |    2 +-
 arch/m68knommu/platform/5307/timers.c |    4 ++--
 include/asm-m68knommu/irq.h           |    4 ++--
 include/asm-m68knommu/signal.h        |    2 --
 4 files changed, 5 insertions(+), 7 deletions(-)

Index: linux-2.6.git/include/asm-m68knommu/irq.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68knommu/irq.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-m68knommu/irq.h	2006-07-01 16:51:34.000000000 +0200
@@ -62,8 +62,8 @@ extern void (*mach_disable_irq)(unsigned
 
 /*
  * various flags for request_irq() - the Amiga now uses the standard
- * mechanism like all other architectures - SA_INTERRUPT and SA_SHIRQ
- * are your friends.
+ * mechanism like all other architectures - IRQF_DISABLED and
+ * IRQF_SHARED are your friends.
  */
 #define IRQ_FLG_LOCK	(0x0001)	/* handler is not replaceable	*/
 #define IRQ_FLG_REPLACE	(0x0002)	/* replace existing handler	*/
Index: linux-2.6.git/include/asm-m68knommu/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-m68knommu/signal.h	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/include/asm-m68knommu/signal.h	2006-07-01 16:51:34.000000000 +0200
@@ -74,7 +74,6 @@ typedef unsigned long sigset_t;
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
  * SA_RESETHAND clears the handler when the signal is delivered.
@@ -94,7 +93,6 @@ typedef unsigned long sigset_t;
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
-#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 /* 
  * sigaltstack controls
Index: linux-2.6.git/arch/m68knommu/platform/5307/pit.c
===================================================================
--- linux-2.6.git.orig/arch/m68knommu/platform/5307/pit.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/m68knommu/platform/5307/pit.c	2006-07-01 16:51:34.000000000 +0200
@@ -48,7 +48,7 @@ void coldfire_pit_init(irqreturn_t (*han
 	volatile unsigned char *icrp;
 	volatile unsigned long *imrp;
 
-	request_irq(MCFINT_VECBASE + MCFINT_PIT1, handler, SA_INTERRUPT,
+	request_irq(MCFINT_VECBASE + MCFINT_PIT1, handler, IRQF_DISABLED,
 		"ColdFire Timer", NULL);
 
 	icrp = (volatile unsigned char *) (MCF_IPSBAR + MCFICM_INTC0 +
Index: linux-2.6.git/arch/m68knommu/platform/5307/timers.c
===================================================================
--- linux-2.6.git.orig/arch/m68knommu/platform/5307/timers.c	2006-07-01 16:51:25.000000000 +0200
+++ linux-2.6.git/arch/m68knommu/platform/5307/timers.c	2006-07-01 16:51:34.000000000 +0200
@@ -61,7 +61,7 @@ void coldfire_timer_init(irqreturn_t (*h
 	__raw_writew(MCFTIMER_TMR_ENORI | MCFTIMER_TMR_CLK16 |
 		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, TA(MCFTIMER_TMR));
 
-	request_irq(mcf_timervector, handler, SA_INTERRUPT, "timer", NULL);
+	request_irq(mcf_timervector, handler, IRQF_DISABLED, "timer", NULL);
 	mcf_settimericr(1, mcf_timerlevel);
 
 #ifdef CONFIG_HIGHPROFILE
@@ -125,7 +125,7 @@ void coldfire_profile_init(void)
 		MCFTIMER_TMR_RESTART | MCFTIMER_TMR_ENABLE, PA(MCFTIMER_TMR));
 
 	request_irq(mcf_profilevector, coldfire_profile_tick,
-		(SA_INTERRUPT | IRQ_FLG_FAST), "profile timer", NULL);
+		(IRQF_DISABLED | IRQ_FLG_FAST), "profile timer", NULL);
 	mcf_settimericr(2, 7);
 }
 

--

