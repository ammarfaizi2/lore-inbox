Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWBHGsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWBHGsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWBHGnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14723 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161015AbWBHGnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:00 -0500
Message-Id: <20060208064917.544933000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Daniel Drake <dsd@gentoo.org>, ashok.raj@intel.com,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 22/23] [PATCH] x86_64: Dont record local apic ids when they are disabled in MADT
Content-Disposition: inline; filename=x86_64-dont-record-local-apic-ids-when-they-are-disabled-in-madt.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Some broken BIOS's had processors disabled, but
same apic id as a valid processor. This causes
acpi_processor_start() to think this disabled
cpu is ok, and croak. So we dont record bad
apicid's anymore.

http://bugzilla.kernel.org/show_bug.cgi?id=5930

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/i386/kernel/acpi/boot.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6.15.3/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.15.3.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.15.3/arch/i386/kernel/acpi/boot.c
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
 

--
