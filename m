Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWHaXeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWHaXeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWHaXeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:34:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:5230 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751238AbWHaXeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:34:13 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent;
	b=OquNUwtIHjXwXGAM7YKSNvrkrtRydmVTNasc82wssIAvXPbNGs6izxHxF8g2+ZPp3
	B3VT+2KvpH3YulPQ4mjHQ==
Date: Thu, 31 Aug 2006 16:33:53 -0700
From: adurbin@google.com
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [PATCH] x86_64: insert IOAPIC(s) and Local APIC into resource map
Message-ID: <20060831233352.GB21338@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch places the IOAPIC(s) and the Local APIC specified by ACPI
tables into the resource map. The APICs will then be visible within
/proc/iomem

Signed-off-by: Aaron Durbin <adurbin@google.com>

---


diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 2b8cef0..d9c677b 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -25,6 +25,7 @@ #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/ioport.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -43,6 +44,11 @@ int apic_calibrate_pmtmr __initdata;
 
 int disable_apic_timer __initdata;
 
+static struct resource lapic_resource = {
+	.name = "Local APIC",
+	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
+};
+
 /*
  * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
  * IPIs in place of local APIC timers
@@ -638,6 +644,40 @@ static int __init detect_init_APIC (void
 	return 0;
 }
 
+#ifdef CONFIG_X86_IO_APIC
+static struct resource * __init ioapic_setup_resources(void)
+{
+#define IOAPIC_RESOURCE_NAME_SIZE 11
+	unsigned long n;
+	struct resource *res;
+	char *mem;
+	int i;
+
+	if (nr_ioapics <= 0)
+		return NULL;
+
+	n = IOAPIC_RESOURCE_NAME_SIZE + sizeof(struct resource);
+	n *= nr_ioapics;
+
+	res = alloc_bootmem(n);
+
+	if (!res)
+		return NULL;
+
+	memset(res, 0, n);
+	mem = (void *)&res[nr_ioapics];
+
+	for (i = 0; i < nr_ioapics; i++) {
+		res[i].name = mem;
+		res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
+		mem += IOAPIC_RESOURCE_NAME_SIZE;
+	}
+
+	return res;
+}
+#endif
+
 void __init init_apic_mappings(void)
 {
 	unsigned long apic_phys;
@@ -656,6 +696,11 @@ void __init init_apic_mappings(void)
 	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
 	apic_printk(APIC_VERBOSE,"mapped APIC to %16lx (%16lx)\n", APIC_BASE, apic_phys);
 
+	/* Put local APIC into the resource map. */
+	lapic_resource.start = apic_phys;
+	lapic_resource.end = lapic_resource.start + PAGE_SIZE - 1;
+	insert_resource(&iomem_resource, &lapic_resource);
+
 	/*
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
@@ -666,7 +711,9 @@ #ifdef CONFIG_X86_IO_APIC
 	{
 		unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
 		int i;
+		struct resource *ioapic_res;
 
+		ioapic_res = ioapic_setup_resources();
 		for (i = 0; i < nr_ioapics; i++) {
 			if (smp_found_config) {
 				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
@@ -678,6 +725,13 @@ #ifdef CONFIG_X86_IO_APIC
 			apic_printk(APIC_VERBOSE,"mapped IOAPIC to %016lx (%016lx)\n",
 					__fix_to_virt(idx), ioapic_phys);
 			idx++;
+
+			if (ioapic_res) {
+				ioapic_res->start = ioapic_phys;
+				ioapic_res->end = ioapic_phys + (4 * 1024) - 1;
+				insert_resource(&iomem_resource, ioapic_res);
+				ioapic_res++;
+			}
 		}
 	}
 #endif
