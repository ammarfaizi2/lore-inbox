Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWAZNtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWAZNtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWAZNtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:49:35 -0500
Received: from fmr22.intel.com ([143.183.121.14]:23490 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932234AbWAZNtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:49:35 -0500
Date: Thu, 26 Jan 2006 05:48:42 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ak@muc.de, ronald@hummelink.net,
       DiegoCG@teleline.es, venkatesh.pallipadi@intel.com
Subject: Dont record local apic ids when they are disabled in MADT
Message-ID: <20060126054842.A11917@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

We had added additional_cpus=xx for x86_64, but apparently there were some
BIOSs that had duplicate apic ids when they were reported disabled.

It seems fair not to record them, this was causing some bad behaviour due to
the duplicate apic id. More details in the bugzilla recorded in the log.

Please help with inclusion.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Some broken BIOS's had processors disabled, but 
same apic id as a valid processor. This causes
acpi_processor_start() to think this disabled 
cpu is ok, and croak. So we dont record bad
apicid's anymore.

http://bugzilla.kernel.org/show_bug.cgi?id=5930

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------------------------------
 arch/i386/kernel/acpi/boot.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc1-mm2/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.16-rc1-mm2/arch/i386/kernel/acpi/boot.c
@@ -248,10 +248,17 @@ acpi_parse_lapic(acpi_table_entry_header
 
 	acpi_table_print_madt_entry(header);
 
-	/* Register even disabled CPUs for cpu hotplug */
-
-	x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
+	/* Record local apic id only when enabled */
+	if (processor->flags.enabled)
+		x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
 
+	/*
+	 * We need to register disabled CPU as well to permit
+	 * counting disabled CPUs. This allows us to size
+	 * cpus_possible_map more accurately, to permit
+	 * to not preallocating memory for all NR_CPUS
+	 * when we use CPU hotplug.
+	 */
 	mp_register_lapic(processor->id,	/* APIC ID */
 			  processor->flags.enabled);	/* Enabled? */
 
