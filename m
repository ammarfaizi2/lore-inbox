Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVH0AHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVH0AHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVH0AHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:07:09 -0400
Received: from fmr21.intel.com ([143.183.121.13]:42437 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030263AbVH0AHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:07:08 -0400
Date: Fri, 26 Aug 2005 17:07:01 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
Subject: [PATCH] acpi: Handle cpu_index greater than 256 properly in processor_core.c
Message-ID: <20050826170701.A27226@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix convert_acpiid_to_cpu function to handle cpu_index greater than 256. This 
patch also prevents a warning in IA64 cross-compile of this file 
(drivers/acpi/processor_core.c:517: warning: comparison is always false due 
to limited range of data type).

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.12/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.12.orig/drivers/acpi/processor_core.c	2005-08-16 09:41:53.687348208 -0700
+++ linux-2.6.12/drivers/acpi/processor_core.c	2005-08-16 10:53:29.957215912 -0700
@@ -425,18 +425,20 @@
 #define ARCH_BAD_APICID		(0xff)
 #endif
 
-static u8 convert_acpiid_to_cpu(u8 acpi_id)
+static int convert_acpiid_to_cpu(u8 acpi_id, unsigned int *cpu_index)
 {
 	u16 apic_id;
-	int i;
+	unsigned int i;
 
 	apic_id = arch_acpiid_to_apicid[acpi_id];
 	if (apic_id == ARCH_BAD_APICID)
 		return -1;
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (arch_cpu_to_apicid[i] == apic_id)
-			return i;
+		if (arch_cpu_to_apicid[i] == apic_id) {
+			*cpu_index = i;
+			return 0;
+		}
 	}
 	return -1;
 }
@@ -453,7 +455,8 @@
 	acpi_status		status = 0;
 	union acpi_object	object = {0};
 	struct acpi_buffer	buffer = {sizeof(union acpi_object), &object};
-	u8			cpu_index;
+	int 			retval;
+	unsigned int		cpu_index;
 	static int		cpu0_initialized;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_info");
@@ -497,10 +500,10 @@
 	 */
 	pr->acpi_id = object.processor.proc_id;
 
-	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
+	retval = convert_acpiid_to_cpu(pr->acpi_id, &cpu_index);
 
   	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
-  	if ( !cpu0_initialized && (cpu_index == 0xff) &&
+  	if ( !cpu0_initialized && retval &&
   		       	(num_online_cpus() == 1)) {
    		cpu_index = 0;
    	}
@@ -514,9 +517,9 @@
   	 *  less than the max # of CPUs. They should be ignored _iff
   	 *  they are physically not present.
   	 */
-   	if (cpu_index >=  NR_CPUS) {
+   	if (retval) {
    		if (ACPI_FAILURE(acpi_processor_hotadd_init(pr->handle, &pr->id))) {
-   			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+   			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
    				"Error getting cpuindex for acpiid 0x%x\n",
    				pr->acpi_id));
    			return_VALUE(-ENODEV);
