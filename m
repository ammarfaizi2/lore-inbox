Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTDUO5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTDUO5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:57:07 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:64527 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S261305AbTDUO5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:57:05 -0400
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Convert Alpha to the new 2.5 IRQ API
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 21 Apr 2003 17:08:06 +0200
Message-ID: <wrpu1crevmx.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard, Linus,

This patch converts the Alpha architecture to the new 2.5 IRQ API.
Tested on Jensen.

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1121  -> 1.1122 
#	arch/alpha/kernel/proto.h	1.14    -> 1.15   
#	arch/alpha/kernel/time.c	1.16    -> 1.17   
#	arch/alpha/kernel/irq.c	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/21	maz@hina.wild-wind.fr.eu.org	1.1122
# Convert Alpha to the new IRQ API.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
--- a/arch/alpha/kernel/irq.c	Mon Apr 21 17:00:46 2003
+++ b/arch/alpha/kernel/irq.c	Mon Apr 21 17:00:46 2003
@@ -45,7 +45,10 @@
  * Special irq handlers.
  */
 
-void no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
+irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
 
 /*
  * Generic no controller code
@@ -414,7 +417,7 @@
 }
 
 int
-request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
+request_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *),
 	    unsigned long irqflags, const char * devname, void *dev_id)
 {
 	int retval;
diff -Nru a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
--- a/arch/alpha/kernel/proto.h	Mon Apr 21 17:00:46 2003
+++ b/arch/alpha/kernel/proto.h	Mon Apr 21 17:00:46 2003
@@ -1,4 +1,5 @@
 #include <linux/config.h>
+#include <linux/interrupt.h>
 
 
 /* Prototypes of functions used across modules here in this directory.  */
@@ -128,7 +129,7 @@
 /* extern void reset_for_srm(void); */
 
 /* time.c */
-extern void timer_interrupt(int irq, void *dev, struct pt_regs * regs);
+extern irqreturn_t timer_interrupt(int irq, void *dev, struct pt_regs * regs);
 extern void common_init_rtc(void);
 extern unsigned long est_cycle_freq;
 
diff -Nru a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c	Mon Apr 21 17:00:46 2003
+++ b/arch/alpha/kernel/time.c	Mon Apr 21 17:00:46 2003
@@ -94,7 +94,7 @@
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-void timer_interrupt(int irq, void *dev, struct pt_regs * regs)
+irqreturn_t timer_interrupt(int irq, void *dev, struct pt_regs * regs)
 {
 	unsigned long delta;
 	__u32 now;
@@ -139,6 +139,7 @@
 	}
 
 	write_sequnlock(&xtime_lock);
+	return IRQ_HANDLED;
 }
 
 void

-- 
Places change, faces change. Life is so very strange.
