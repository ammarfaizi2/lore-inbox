Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267969AbUHEUuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267969AbUHEUuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUHEUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:48:11 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:6072 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267939AbUHEUqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:46:46 -0400
Subject: [PATCH] cleanup ACPI numa warnings
From: Alex Williamson <alex.williamson@hp.com>
To: acpi-devel <acpi-devel@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL
Date: Thu, 05 Aug 2004 14:46:38 -0600
Message-Id: <1091738798.22406.9.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The patch below removes these warnings:

  CC      drivers/acpi/numa.o
drivers/acpi/numa.c: In function `acpi_table_print_srat_entry':
drivers/acpi/numa.c:55: warning: unused variable `p'
drivers/acpi/numa.c:65: warning: unused variable `p'
drivers/acpi/numa.c: In function `acpi_numa_init':
drivers/acpi/numa.c:179: warning: passing arg 2 of `acpi_table_parse_srat' from incompatible pointer type
drivers/acpi/numa.c:182: warning: passing arg 2 of `acpi_table_parse_srat' from incompatible pointer type

And propagates the MADT error checking code into the SRAT code.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== drivers/acpi/numa.c 1.10 vs edited =====
--- 1.10/drivers/acpi/numa.c	2004-02-18 02:19:31 -07:00
+++ edited/drivers/acpi/numa.c	2004-08-05 14:37:19 -06:00
@@ -38,6 +38,33 @@
 
 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler, unsigned int max_entries);
 
+#ifdef ACPI_DEBUG_OUTPUT
+#define acpi_print_srat_processor_affinity(header) { \
+	struct acpi_table_processor_affinity *p = \
+	                      (struct acpi_table_processor_affinity*) header; \
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] " \
+	                 "eid[0x%02x]) in proximity domain %d %s\n", \
+	                 p->apic_id, p->lsapic_eid, p->proximity_domain, \
+	                 p->flags.enabled?"enabled":"disabled")); }
+
+#define acpi_print_srat_memory_affinity(header) { \
+	struct acpi_table_memory_affinity *p = \
+	                         (struct acpi_table_memory_affinity*) header; \
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length " \
+	                 "0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",\
+	                 p->base_addr_hi, p->base_addr_lo, p->length_hi, \
+	                 p->length_lo, p->memory_type, p->proximity_domain, \
+	                 p->flags.enabled ? "enabled" : "disabled", \
+	                 p->flags.hot_pluggable ? " hot-pluggable" : "")); }
+#else
+#define acpi_print_srat_processor_affinity(header)
+#define acpi_print_srat_memory_affinity(header)
+#endif
+
+#define BAD_SRAT_ENTRY(entry, end) ( \
+	(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
+	((acpi_table_entry_header *)entry)->length != sizeof(*entry))
+
 void __init
 acpi_table_print_srat_entry (
 	acpi_table_entry_header	*header)
@@ -51,27 +78,11 @@
 	switch (header->type) {
 
 	case ACPI_SRAT_PROCESSOR_AFFINITY:
-	{
-		struct acpi_table_processor_affinity *p =
-			(struct acpi_table_processor_affinity*) header;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
-		       p->apic_id, p->lsapic_eid, p->proximity_domain,
-		       p->flags.enabled?"enabled":"disabled"));
-	}
+		acpi_print_srat_processor_affinity(header);
 		break;
-
 	case ACPI_SRAT_MEMORY_AFFINITY:
-	{
-		struct acpi_table_memory_affinity *p =
-			(struct acpi_table_memory_affinity*) header;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
-		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
-		       p->memory_type, p->proximity_domain,
-		       p->flags.enabled ? "enabled" : "disabled",
-		       p->flags.hot_pluggable ? " hot-pluggable" : ""));
-	}
+		acpi_print_srat_memory_affinity(header);
 		break;
-
 	default:
 		printk(KERN_WARNING PREFIX "Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -103,12 +114,12 @@
 
 
 static int __init
-acpi_parse_processor_affinity (acpi_table_entry_header *header)
+acpi_parse_processor_affinity (acpi_table_entry_header *header, unsigned long size)
 {
 	struct acpi_table_processor_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_table_processor_affinity*) header;
-	if (!processor_affinity)
+	if (BAD_SRAT_ENTRY(processor_affinity, size))
 		return -EINVAL;
 
 	acpi_table_print_srat_entry(header);
@@ -121,12 +132,12 @@
 
 
 static int __init
-acpi_parse_memory_affinity (acpi_table_entry_header *header)
+acpi_parse_memory_affinity (acpi_table_entry_header *header, unsigned long size)
 {
 	struct acpi_table_memory_affinity *memory_affinity;
 
 	memory_affinity = (struct acpi_table_memory_affinity*) header;
-	if (!memory_affinity)
+	if (BAD_SRAT_ENTRY(memory_affinity, size))
 		return -EINVAL;
 
 	acpi_table_print_srat_entry(header);






