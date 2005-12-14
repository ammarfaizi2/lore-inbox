Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVLNXZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVLNXZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVLNXZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:25:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53665 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965073AbVLNXZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:25:38 -0500
Date: Wed, 14 Dec 2005 15:25:26 -0800 (PST)
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>, hawkes@sgi.com,
       Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] ia64: disable preemption in udelay()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this to a wider audience:

The udelay() inline for ia64 uses the ITC.  If CONFIG_PREEMPT is enabled
and the platform has unsynchronized ITCs and the calling task migrates
to another CPU while doing the udelay loop, then the effective delay may
be too short or very, very long.

The most simple fix is to disable preemption around the udelay looping.
The downside is that this inhibits realtime preemption for cases of long
udelays.  One datapoint:  an SGI realtime engineer reports that if
CONFIG_PREEMPT is turned off, that no significant holdoffs are
are attributed to udelay().

I am reluctant to propose a much more complicated patch (that disables
preemption only for "short" delays, and uses the global RTC as the time
base for longer, preemptible delays) unless this patch introduces
significant and unacceptable preemption delays.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/include/asm-ia64/delay.h
===================================================================
--- linux.orig/include/asm-ia64/delay.h	2005-10-27 17:02:08.000000000 -0700
+++ linux/include/asm-ia64/delay.h	2005-12-14 10:30:55.000000000 -0800
@@ -87,11 +87,17 @@
 static __inline__ void
 udelay (unsigned long usecs)
 {
-	unsigned long start = ia64_get_itc();
-	unsigned long cycles = usecs*local_cpu_data->cyc_per_usec;
+	unsigned long start;
+	unsigned long cycles;
+
+	preempt_disable();
+	cycles = usecs*local_cpu_data->cyc_per_usec;
+	start = ia64_get_itc();
 
 	while (ia64_get_itc() - start < cycles)
 		cpu_relax();
+
+	preempt_enable();
 }
 
 #endif /* _ASM_IA64_DELAY_H */
