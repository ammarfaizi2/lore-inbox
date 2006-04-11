Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDKKyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDKKyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWDKKyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:54:38 -0400
Received: from mail.suse.de ([195.135.220.2]:12719 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750730AbWDKKyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:54:37 -0400
Date: Tue, 11 Apr 2006 12:54:36 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: [PATCH] [1/7] x86-64/i386: Don't process APICs/IO-APICs in ACPI 
 when APIC is disabled.
Message-ID: <443B8AEC.mailFIE19Q70S@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When nolapic was passed or the local APIC was disabled
for another reason ACPI would still parse the IO-APICs
until these were explicitely disabled with noapic.

Usually this resulted in a non booting configuration unless
"nolapic noapic" was used.

I also disabled the local APIC parsing in this case, although
that's only cosmetic (suppresses a few printks) 

This hopefully makes nolapic work in all cases.

Cc: len.brown@intel.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/acpi/boot.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -168,7 +168,7 @@ int __init acpi_parse_mcfg(unsigned long
 	unsigned long i;
 	int config_size;
 
-	if (!phys_addr || !size)
+	if (!phys_addr || !size || !cpu_has_apic)
 		return -EINVAL;
 
 	mcfg = (struct acpi_table_mcfg *)__acpi_map_table(phys_addr, size);
@@ -693,6 +693,9 @@ static int __init acpi_parse_madt_lapic_
 {
 	int count;
 
+	if (!cpu_has_apic)
+		return -ENODEV;
+
 	/* 
 	 * Note that the LAPIC address is obtained from the MADT (32-bit value)
 	 * and (optionally) overriden by a LAPIC_ADDR_OVR entry (64-bit value).
