Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHQDCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHQDCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUHQDCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:02:49 -0400
Received: from ozlabs.org ([203.10.76.45]:44181 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261610AbUHQDCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:02:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.26857.85337.840272@cargo.ozlabs.ibm.com>
Date: Tue, 17 Aug 2004 12:09:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Don't call scheduler on offline cpu
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When taking a cpu offline, once the cpu has been removed from
cpu_online_map, it is not supposed to service any more interrupts.
This presents a problem on ppc64 because we cannot truly disable the
decrementer.  There used to be cpu_is_offline() checks in several
scheduler functions (e.g. rebalance_tick()) which papered over this
issue, but these checks were removed recently.  So with recent 2.6
kernels, an attempt to offline a cpu can result in a crash in
find_busiest_group().  This patch prevents such crashes.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/time.c~ppc64-timer_interrupt-handle-offline-cpu arch/ppc64/kernel/time.c
--- 2.6.8-rc4/arch/ppc64/kernel/time.c~ppc64-timer_interrupt-handle-offline-cpu	2004-08-11 10:44:27.000000000 -0500
+++ 2.6.8-rc4-nathanl/arch/ppc64/kernel/time.c	2004-08-11 10:44:27.000000000 -0500
@@ -48,6 +48,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/cpu.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -281,8 +282,20 @@ int timer_interrupt(struct pt_regs * reg
 	while (lpaca->next_jiffy_update_tb <= (cur_tb = get_tb())) {
 
 #ifdef CONFIG_SMP
-		smp_local_timer_interrupt(regs);
+		/*
+		 * We cannot disable the decrementer, so in the period
+		 * between this cpu's being marked offline in cpu_online_map
+		 * and calling stop-self, it is taking timer interrupts.
+		 * Avoid calling into the scheduler rebalancing code if this
+		 * is the case.
+		 */
+		if (!cpu_is_offline(cpu))
+			smp_local_timer_interrupt(regs);
 #endif
+		/*
+		 * No need to check whether cpu is offline here; boot_cpuid
+		 * should have been fixed up by now.
+		 */
 		if (cpu == boot_cpuid) {
 			write_seqlock(&xtime_lock);
 			tb_last_stamp = lpaca->next_jiffy_update_tb;
