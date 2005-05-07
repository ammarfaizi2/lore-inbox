Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVEHAjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVEHAjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVEHAjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:39:11 -0400
Received: from [24.10.253.213] ([24.10.253.213]:21888 "EHLO linux.site")
	by vger.kernel.org with ESMTP id S262769AbVEHAjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:39:06 -0400
Subject: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors in EM64T mode (x86_64)
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Fri, 06 May 2005 22:34:34 -0700
Message-Id: <20050507053435.6DA214749E@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I revised the patch and it came out simpler (and much smaller) this time :) Please consider the following version:

<-Snip->

This patch disables unique IO_APIC_ID check for xAPIC systems running in EM64T mode. Xeon-based ES7000s panic failing this unnecessary check. IO_APIC_IDs only need to be unique in case of serial APIC bus. xAPIC systems deliver interrupts over the system bus.

Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

---


diff -puN arch/x86_64/kernel/io_apic.c~no-ioapic-check-x86_64-2 arch/x86_64/kernel/io_apic.c
--- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/io_apic.c~no-ioapic-check-x86_64-2	2005-05-06 21:58:55.149700760 -0700
+++ linux-2.6.13-rc3-mm3-root/arch/x86_64/kernel/io_apic.c	2005-05-06 22:00:41.361554104 -0700
@@ -1867,12 +1867,16 @@ int __init io_apic_get_unique_id (int io
 	int i = 0;
 
 	/*
+	 * xAPIC systems take advantage of APIC system bus architecture.
+	 */
+	
+	 if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return apic_id;
+	
+	/*
 	 * The P4 platform supports up to 256 APIC IDs on two separate APIC 
 	 * buses (one for LAPICs, one for IOAPICs), where predecessors only 
 	 * supports up to 16 on one shared APIC bus.
-	 * 
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
 	 */
 
 	if (physids_empty(apic_id_map))
_
