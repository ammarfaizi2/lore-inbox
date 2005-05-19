Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVESU4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVESU4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVESU4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:56:40 -0400
Received: from dynamic.62-99-255-84.adsl-line.inode.at ([62.99.255.84]:14335
	"EHLO mercury.foo") by vger.kernel.org with ESMTP id S261255AbVESU4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:56:31 -0400
Date: Thu, 19 May 2005 22:57:07 +0200 (CEST)
From: Dominik Hackl <dominik@hackl.dhs.org>
X-X-Sender: dominik@mercury.foo
To: James.Bottomley@HansenPartnership.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4] voyager_smp.c static inline fix 
Message-ID: <Pine.LNX.4.61.0505192229370.1587@mercury.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes a compile bug by moving a static inline function to the 
right place. The body of a static inline function has to be declared 
before the use of this function.


	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>



--- linux-2.6.12-rc4.orig/arch/i386/mach-voyager/voyager_smp.c	2005-05-15 09:43:23.000000000 +0200
+++ linux-2.6.12-rc4/arch/i386/mach-voyager/voyager_smp.c	2005-05-19 22:19:40.000000000 +0200
@@ -97,7 +97,6 @@ static void ack_vic_irq(unsigned int irq
 static void vic_enable_cpi(void);
 static void do_boot_cpu(__u8 cpuid);
 static void do_quad_bootstrap(void);
-static inline void wrapper_smp_local_timer_interrupt(struct pt_regs *);
 
 int hard_smp_processor_id(void);
 
@@ -126,6 +125,14 @@ send_QIC_CPI(__u32 cpuset, __u8 cpi)
 }
 
 static inline void
+wrapper_smp_local_timer_interrupt(struct pt_regs *regs)
+{
+	irq_enter();
+	smp_local_timer_interrupt(regs);
+	irq_exit();
+}
+
+static inline void
 send_one_CPI(__u8 cpu, __u8 cpi)
 {
 	if(voyager_quad_processors & (1<<cpu))
@@ -1249,14 +1256,6 @@ smp_vic_timer_interrupt(struct pt_regs *
 	smp_local_timer_interrupt(regs);
 }
 
-static inline void
-wrapper_smp_local_timer_interrupt(struct pt_regs *regs)
-{
-	irq_enter();
-	smp_local_timer_interrupt(regs);
-	irq_exit();
-}
-
 /* local (per CPU) timer interrupt.  It does both profiling and
  * process statistics/rescheduling.
  *
