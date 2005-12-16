Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVLPCnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVLPCnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLPCnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:43:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6596 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751143AbVLPCnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:43:01 -0500
Date: Thu, 15 Dec 2005 18:42:52 -0800 (PST)
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>, hawkes@sgi.com,
       Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20051216024252.27639.63120.sendpatchset@tomahawk.engr.sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmitting using Tony Luck's suggested alternative.

The udelay() inline for ia64 uses the ITC.  If CONFIG_PREEMPT is enabled
and the platform has unsynchronized ITCs and the calling task migrates
to another CPU while doing the udelay loop, then the effective delay may
be too short or very, very long.

This patch disables preemption around 100 usec chunks of the overall
desired udelay time.  This minimizes preemption-holdoffs.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/include/asm-ia64/delay.h
===================================================================
--- linux.orig/include/asm-ia64/delay.h	2005-12-15 15:34:16.000000000 -0800
+++ linux/include/asm-ia64/delay.h	2005-12-15 15:34:57.000000000 -0800
@@ -84,14 +84,6 @@
 	ia64_delay_loop (loops - 1);
 }
 
-static __inline__ void
-udelay (unsigned long usecs)
-{
-	unsigned long start = ia64_get_itc();
-	unsigned long cycles = usecs*local_cpu_data->cyc_per_usec;
-
-	while (ia64_get_itc() - start < cycles)
-		cpu_relax();
-}
+extern void udelay (unsigned long usecs);
 
 #endif /* _ASM_IA64_DELAY_H */
Index: linux/arch/ia64/kernel/time.c
===================================================================
--- linux.orig/arch/ia64/kernel/time.c	2005-12-15 15:34:16.000000000 -0800
+++ linux/arch/ia64/kernel/time.c	2005-12-15 15:34:57.000000000 -0800
@@ -249,3 +249,31 @@
 	 */
 	set_normalized_timespec(&wall_to_monotonic, -xtime.tv_sec, -xtime.tv_nsec);
 }
+
+#define SMALLUSECS 100
+
+void
+udelay (unsigned long usecs)
+{
+	unsigned long start;
+	unsigned long cycles;
+	unsigned long smallusecs;
+
+	/*
+	 * Execute the non-preemptible delay loop (because the ITC might
+	 * not be synchronized between CPUS) in relatively short time
+	 * chunks, allowing preemption between the chunks.
+	 */
+	while (usecs > 0) {
+		smallusecs = (usecs > SMALLUSECS) ? SMALLUSECS : usecs;
+		preempt_disable();
+		cycles = smallusecs*local_cpu_data->cyc_per_usec;
+		start = ia64_get_itc();
+
+		while (ia64_get_itc() - start < cycles)
+			cpu_relax();
+
+		preempt_enable();
+		usecs -= smallusecs;
+	}
+}
