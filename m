Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUFVQMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUFVQMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUFVP30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:26 -0400
Received: from holomorphy.com ([207.189.100.168]:37763 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264890AbUFVPRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:12 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [10/23] ia64 profiling cleanups
Message-ID: <0406220816.Mb0a5a5a5a1a5a3aKbKb0a3a4a0aHbZaIbJbLb5a3aJbHbXaWaMb2aHb0a1aKbWa15250@holomorphy.com>
In-Reply-To: <0406220816.0a0a1aMbIbXa5a1aIb1a2aJbYaLbLb5aXaHbZaXaIbXa2aWaJbMbIbZa5a5aZa4a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ia64 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/ia64/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/ia64/kernel/time.c	2004-06-15 22:19:01.000000000 -0700
+++ prof-2.6.7/arch/ia64/kernel/time.c	2004-06-22 07:25:51.482336664 -0700
@@ -19,7 +19,6 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/efi.h>
-#include <linux/profile.h>
 #include <linux/timex.h>
 
 #include <asm/machvec.h>
@@ -203,7 +202,7 @@
 	if (user_mode(regs))
 		return;
 
-	if (!prof_buffer)
+	if (!profiling_on())
 		return;
 
 	ip = instruction_pointer(regs);
@@ -217,19 +216,8 @@
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!cpu_isset(smp_processor_id(), prof_cpu_mask))
-		return;
-
-	ip -= (unsigned long) &_stext;
-	ip >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds IP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (ip > prof_len-1)
-		ip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[ip]);
+	if (cpu_isset(smp_processor_id(), prof_cpu_mask))
+		profile_tick(ip);
 }
 
 static irqreturn_t
