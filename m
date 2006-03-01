Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWB1XYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWB1XYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWB1XYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:24:38 -0500
Received: from fmr22.intel.com ([143.183.121.14]:46488 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932718AbWB1XYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:24:19 -0500
Message-Id: <20060301001722.845609000@araj-sfield>
References: <20060301001557.318047000@araj-sfield>
Date: Tue, 28 Feb 2006 16:16:00 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Len Brown <len.brown@intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 3/5] Support physical cpu hotplug for x86_64.
Content-Disposition: inline; filename=x86_64-physical-cpu-hotplug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables ACPI based physical CPU hotplug support for x86_64.
Implements acpi_map_lsapic() and acpi_unmap_lsapic() to support 
physical cpu hotplug.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------------------------------------------
 arch/i386/kernel/acpi/boot.c |   69 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 65 insertions(+), 4 deletions(-)

Index: linux-2.6.16-rc4-mm1/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.16-rc4-mm1.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.16-rc4-mm1/arch/i386/kernel/acpi/boot.c
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/config.h>
+#include <linux/cpumask.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/module.h>
@@ -505,16 +506,76 @@ EXPORT_SYMBOL(acpi_register_gsi);
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 int acpi_map_lsapic(acpi_handle handle, int *pcpu)
 {
-	/* TBD */
-	return -EINVAL;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	struct acpi_table_lapic *lapic;
+	cpumask_t tmp_map, new_map;
+	u8 physid;
+	int cpu;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
+		return -EINVAL;
+
+	if (!buffer.length || !buffer.pointer)
+		return -EINVAL;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length < sizeof(*lapic)) {
+		acpi_os_free(buffer.pointer);
+		return -EINVAL;
+	}
+
+	lapic = (struct acpi_table_lapic *)obj->buffer.pointer;
+
+	if ((lapic->header.type != ACPI_MADT_LAPIC) ||
+	    (!lapic->flags.enabled)) {
+		acpi_os_free(buffer.pointer);
+		return -EINVAL;
+	}
+
+	physid = lapic->id;
+
+	acpi_os_free(buffer.pointer);
+	buffer.length = ACPI_ALLOCATE_BUFFER;
+	buffer.pointer = NULL;
+
+	tmp_map = cpu_present_map;
+	mp_register_lapic(physid, lapic->flags.enabled);
+
+	/*
+	 * If mp_register_lapic successfully generates a new logical cpu
+	 * number, then the following will get us exactly what was mapped
+	 */
+	cpus_andnot(new_map, cpu_present_map, tmp_map);
+	if (cpus_empty(new_map)) {
+		printk ("Unable to map lapic to logical cpu number\n");
+		return -EINVAL;
+	}
+
+	cpu = first_cpu(new_map);
+
+	*pcpu = cpu;
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_map_lsapic);
 
 int acpi_unmap_lsapic(int cpu)
 {
-	/* TBD */
-	return -EINVAL;
+	int i;
+
+	for_each_cpu(i) {
+		if (x86_acpiid_to_apicid[i] == x86_cpu_to_apicid[cpu]) {
+			x86_acpiid_to_apicid[i] = -1;
+			break;
+		}
+	}
+	x86_cpu_to_apicid[cpu] = -1;
+	cpu_clear(cpu, cpu_present_map);
+	num_processors--;
+
+	return (0);
 }
 
 EXPORT_SYMBOL(acpi_unmap_lsapic);

--

