Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751936AbWI1SVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbWI1SVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWI1SVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:21:16 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64350 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751936AbWI1SVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:21:14 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent:from;
	b=TE4i6185KeaZ8Wh1oSGO3NauEd2bybYf/WiG0n9bCyJCHAEd61Iz05Oxp9LiT1/oI
	t00BAWfztP6UeWbrCdjfg==
Date: Thu, 28 Sep 2006 11:20:57 -0700
To: ak@suse.de
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Insert Local and IO APIC(s) into resource map
Message-ID: <20060928182057.GA26282@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: adurbin@google.com (Aaron Durbin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch inserts the Local APIC and IO APIC(s) into the resource tree. It
allows the APIC resources to be visible within /proc/iomem. The patch
also takes into account IO APIC(s) mapped in the PCI space by deferring
the insertion until after PCI has allocated its necessary resources.

Signed-off-by: Aaron Durbin <adurbin@google.com>

---

The previous patch addressing thsi functionality should be dropped and replaced
with this newer particular patch.

The patch is against 2.6.18.

 arch/x86_64/kernel/apic.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
index 2b8cef0..6880d83 100644
--- a/arch/x86_64/kernel/apic.c
+++ b/arch/x86_64/kernel/apic.c
@@ -25,6 +25,7 @@ #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/ioport.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -43,6 +44,12 @@ int apic_calibrate_pmtmr __initdata;
 
 int disable_apic_timer __initdata;
 
+static struct resource *ioapic_resources;
+static struct resource lapic_resource = {
+	.name = "Local APIC",
+	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
+};
+
 /*
  * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
  * IPIs in place of local APIC timers
@@ -638,6 +645,64 @@ static int __init detect_init_APIC (void
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
+	mem = alloc_bootmem(n);
+	res = (void *)mem;
+
+	if (mem != NULL) {
+		memset(mem, 0, n);
+		mem += sizeof(struct resource) * nr_ioapics;
+
+		for (i = 0; i < nr_ioapics; i++) {
+			res[i].name = mem;
+			res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+			sprintf(mem,  "IOAPIC %u", i);
+			mem += IOAPIC_RESOURCE_NAME_SIZE;
+		}
+	}
+
+	ioapic_resources = res;
+
+	return res;
+}
+
+static int __init ioapic_insert_resources(void)
+{
+	int i;
+	struct resource *r = ioapic_resources;
+
+	if (!r) {
+		printk("IO APIC resources could be not be allocated.\n");
+		return -1;
+	}
+
+	for (i = 0; i < nr_ioapics; i++) {
+		insert_resource(&iomem_resource, r);
+		r++;
+	}
+
+	return 0;
+}
+
+/* Insert the IO APIC resources after PCI initialization has occured to handle
+ * IO APICS that are mapped in on a BAR in PCI space. */
+late_initcall(ioapic_insert_resources);
+#endif
+
 void __init init_apic_mappings(void)
 {
 	unsigned long apic_phys;
@@ -656,6 +721,11 @@ void __init init_apic_mappings(void)
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
@@ -666,7 +736,9 @@ #ifdef CONFIG_X86_IO_APIC
 	{
 		unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
 		int i;
+		struct resource *ioapic_res;
 
+		ioapic_res = ioapic_setup_resources();
 		for (i = 0; i < nr_ioapics; i++) {
 			if (smp_found_config) {
 				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
@@ -678,6 +750,12 @@ #ifdef CONFIG_X86_IO_APIC
 			apic_printk(APIC_VERBOSE,"mapped IOAPIC to %016lx (%016lx)\n",
 					__fix_to_virt(idx), ioapic_phys);
 			idx++;
+
+			if (ioapic_res != NULL) {
+				ioapic_res->start = ioapic_phys;
+				ioapic_res->end = ioapic_phys + (4 * 1024) - 1;
+				ioapic_res++;
+			}
 		}
 	}
 #endif
-- 
1.4.2.1.g4daf

