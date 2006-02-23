Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWBWJU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWBWJU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWBWJU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:20:26 -0500
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:31886 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751630AbWBWJU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:20:26 -0500
Date: Thu, 23 Feb 2006 04:17:42 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: warn if unable to configure apic main timer
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602230420_MC3-1-B90E-39AF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using the APIC main timer option on x86_64, sometimes it
fails to complete its setup.  Warn about this and suggest
the user try 'disable_timer_pin_1' if their system clock runs
too fast. Also, make printing of the exact result of APIC
timer calibration require 'apic=verbose'.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc4-64.orig/arch/x86_64/kernel/apic.c
+++ 2.6.16-rc4-64/arch/x86_64/kernel/apic.c
@@ -738,6 +738,12 @@ static void setup_APIC_timer(unsigned in
 		apic_runs_main_timer++;
 	}
 	local_irq_restore(flags);
+
+	if (apic_runs_main_timer == 1) {
+		printk(KERN_WARNING "Could not configure APIC main timer.\n");
+		printk(KERN_WARNING "Try boot option 'disable_timer_pin_1'"
+				    " if your system clock runs too fast.\n");
+	}
 }
 
 /*
@@ -786,7 +792,7 @@ static int __init calibrate_APIC_clock(v
 		result = (apic_start - apic) * 1000L * cpu_khz /
 					(tsc - tsc_start);
 	}
-	printk("result %d\n", result);
+	apic_printk(APIC_VERBOSE,"APIC timer result %d\n", result);
 
 
 	printk(KERN_INFO "Detected %d.%03d MHz APIC timer.\n",
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
