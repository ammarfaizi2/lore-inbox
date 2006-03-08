Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752022AbWCHH2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbWCHH2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWCHH2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:28:00 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52457 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751737AbWCHH17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:27:59 -0500
Message-ID: <440E8723.7030008@soft.fujitsu.com>
Date: Wed, 08 Mar 2006 16:26:27 +0900
From: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][BUG] fix bug in ACPI based CPU hotplug
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a bug in ACPI based CPU hotplug code. Because of this bug,
ACPI based CPU hotplug will always fail if NR_CPUS is equal to or
more than 255.

Thanks,
Kenji Kaneshige


This patch fixes a serious bug in ACPI based CPU hotplug code. Because
of this bug, ACPI based CPU hotplug will always fail if NR_CPUS is
equal to or more than 255.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Motoyuki Itoh <motoyuki@soft.fujitsu.com>

---
 drivers/acpi/processor_core.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

Index: linux-2.6.16-rc5-mm2/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/acpi/processor_core.c	2006-03-07 13:42:20.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/acpi/processor_core.c	2006-03-08 14:03:58.000000000 +0900
@@ -382,7 +382,7 @@
 
 /* Use the acpiid in MADT to map cpus in case of SMP */
 #ifndef CONFIG_SMP
-#define convert_acpiid_to_cpu(acpi_id) (0xff)
+#define convert_acpiid_to_cpu(acpi_id) (-1)
 #else
 
 #ifdef CONFIG_IA64
@@ -395,7 +395,7 @@
 #define ARCH_BAD_APICID		(0xff)
 #endif
 
-static u8 convert_acpiid_to_cpu(u8 acpi_id)
+static int convert_acpiid_to_cpu(u8 acpi_id)
 {
 	u16 apic_id;
 	int i;
@@ -421,7 +421,7 @@
 	acpi_status status = 0;
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-	u8 cpu_index;
+	int cpu_index;
 	static int cpu0_initialized;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_info");
@@ -466,8 +466,7 @@
 	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
 
 	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
-	if (!cpu0_initialized && (cpu_index == 0xff) &&
-	    (num_online_cpus() == 1)) {
+	if (!cpu0_initialized && (cpu_index < 0) && (num_online_cpus() == 1)) {
 		cpu_index = 0;
 	}
 
@@ -480,7 +479,7 @@
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (cpu_index >= NR_CPUS) {
+	if (cpu_index < 0) {
 		if (ACPI_FAILURE
 		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
 			ACPI_ERROR((AE_INFO,
