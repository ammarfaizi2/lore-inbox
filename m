Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUFVPnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUFVPnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbUFVPbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:31:44 -0400
Received: from holomorphy.com ([207.189.100.168]:35203 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264820AbUFVPQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:46 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [5/23] m68knommu profiling cleanups
Message-ID: <0406220816.LbIbZa1aLbLbIbJb1aWa3aHbWaKbHbLbHb3a1aIbYaZaLbIb0a2a5a4aHbHbLbIb15250@holomorphy.com>
In-Reply-To: <0406220816.MbKb2aWaJbWa0aWaYaLbZaWa2aJbYaWaHb3aLb1a3aYa4a3aYaKb2aIbLbLbWa1a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68knommu to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/m68knommu/platform/5307/timers.c
===================================================================
--- prof-2.6.7.orig/arch/m68knommu/platform/5307/timers.c	2004-06-15 22:20:26.000000000 -0700
+++ prof-2.6.7/arch/m68knommu/platform/5307/timers.c	2004-06-22 07:25:47.118999992 -0700
@@ -14,6 +14,7 @@
 #include <linux/param.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/profile.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
 #include <asm/machdep.h>
@@ -111,16 +112,8 @@
 	/* Reset ColdFire timer2 */
 	mcf_proftp->ter = MCFTIMER_TER_CAP | MCFTIMER_TER_REF;
 
-        if (!user_mode(regs)) {
-                if (prof_buffer && current->pid) {
-                        extern int _stext;
-                        unsigned long ip = instruction_pointer(regs);
-                        ip -= (unsigned long) &_stext;
-                        ip >>= prof_shift;
-                        if (ip < prof_len)
-                                prof_buffer[ip]++;
-                }
-        }
+        if (!user_mode(regs) && profiling_on() && current->pid)
+		profile_tick(instruction_pointer(regs));
 }
 
 /***************************************************************************/
Index: prof-2.6.7/arch/m68knommu/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/m68knommu/kernel/time.c	2004-06-15 22:19:37.000000000 -0700
+++ prof-2.6.7/arch/m68knommu/kernel/time.c	2004-06-22 07:25:47.120999688 -0700
@@ -43,20 +43,8 @@
 
 static inline void do_profile (unsigned long pc)
 {
-	if (prof_buffer && current->pid) {
-		extern int _stext;
-		pc -= (unsigned long) &_stext;
-		pc >>= prof_shift;
-		if (pc < prof_len)
-			++prof_buffer[pc];
-		else
-		/*
-		 * Don't ignore out-of-bounds PC values silently,
-		 * put them into the last histogram slot, so if
-		 * present, they will show up as a sharp peak.
-		 */
-			++prof_buffer[prof_len-1];
-	}
+	if (current->pid)
+		profile_tick(pc);
 }
 
 /*
