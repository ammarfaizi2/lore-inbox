Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVEBF6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVEBF6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 01:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEBF6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 01:58:54 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:14208 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S261749AbVEBF6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 01:58:52 -0400
Subject: [patch 1/1] Added NO_IOAPIC_CHECK in io_apic_get_unique_id() for ACPI boot
To: akpm@osdl.org
Cc: ak@muc.de, len.brown@intel.com, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
       Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Sun, 01 May 2005 03:54:33 -0700
Message-Id: <20050501105434.2B95E42AD7@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows xAPIC systems that don't have serial bus for interrupts delivery to by-pass the check on uniquness of IO-APIC IDs. Some of ES7000's panic failing this unnecessary check. The genapic mechanism has NO_IOAPIC_CHECK flag, which is defined in each subarch. The MP boot utilizes it, but the ACPI boot is missing it.

Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

---


diff -puN arch/i386/kernel/io_apic.c~no-ioapic-check arch/i386/kernel/io_apic.c
--- linux-2.6.13-rc3-mm2/arch/i386/kernel/io_apic.c~no-ioapic-check	2005-05-01 02:15:48.054362032 -0700
+++ linux-2.6.13-rc3-mm2-root/arch/i386/kernel/io_apic.c	2005-05-01 02:28:23.282549896 -0700
@@ -2436,13 +2436,18 @@ int __init io_apic_get_unique_id (int io
 	unsigned long flags;
 	int i = 0;
 
+	/* Don't check I/O APIC IDs for some xAPIC systems.  They have
+	 * no meaning without the serial APIC bus. 
+	 */
+
+	if (NO_IOAPIC_CHECK)
+		return apic_id;
+
 	/*
 	 * The P4 platform supports up to 256 APIC IDs on two separate APIC 
 	 * buses (one for LAPICs, one for IOAPICs), where predecessors only 
 	 * supports up to 16 on one shared APIC bus.
 	 * 
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
 	 */
 
 	if (physids_empty(apic_id_map))
_
