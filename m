Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUFVPaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUFVPaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUFVP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:38 -0400
Received: from holomorphy.com ([207.189.100.168]:38019 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264886AbUFVPRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:11 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [11/23] alpha profiling cleanups
Message-ID: <0406220817.3a5aKbLb3aXa0aYa0aKb4aMbYaIbKbIb3aMb0aLbLbJbKb1aYaJbKbXa5a3a0a5a15250@holomorphy.com>
In-Reply-To: <0406220816.Mb0a5a5a5a1a5a3aKbKb0a3a4a0aHbZaIbJbLb5a3aJbHbXaWaMb2aHb0a1aKbWa15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:17:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert alpha to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/alpha/kernel/irq_impl.h
===================================================================
--- prof-2.6.7.orig/arch/alpha/kernel/irq_impl.h	2004-06-15 22:20:26.000000000 -0700
+++ prof-2.6.7/arch/alpha/kernel/irq_impl.h	2004-06-22 07:25:52.346205336 -0700
@@ -46,26 +46,13 @@
 static inline void
 alpha_do_profile(unsigned long pc)
 {
-	extern char _stext;
-
-	if (!prof_buffer)
+	if (!profiling_on())
 		return;
 
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
 	 */
-	if (!((1<<smp_processor_id()) & prof_cpu_mask))
-		return;
-
-	pc -= (unsigned long) &_stext;
-	pc >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds PC values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (pc > prof_len - 1)
-		pc = prof_len - 1;
-	atomic_inc((atomic_t *)&prof_buffer[pc]);
+	if ((1<<smp_processor_id()) & prof_cpu_mask)
+		profile_tick(pc);
 }
