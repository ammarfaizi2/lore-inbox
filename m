Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUAMKp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUAMKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:45:59 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:24273 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263983AbUAMKpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:45:53 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       Jesse Barnes <jbarnes@sgi.com>, Jack Steiner <steiner@sgi.com>,
       David Mosberger <davidm@hpl.hp.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI NUMA quiet printk and cleanup
From: Jes Sorensen <jes@wildopensource.com>
In-Reply-To: <yq0r7y4dvqf.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 13 Jan 2004 05:45:50 -0500
Message-ID: <yq0k73wdt41.fsf_-_@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd love to see the following patch go into -mm. It turns two current
ACPI printk's into ACPI debug messages thgat only shows when
ACPI_DEBUG is enabled and eliminates some excessive NULL
initialization of variables that are immediately being set to their
real value afterwards.

The patch should be very easy to verify - compiled and booted on an sn2.

Thanks,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.1-jb-acpi-clean/drivers/acpi/numa.c linux-2.6.1/drivers/acpi/numa.c
--- orig/linux-2.6.1-jb-acpi-clean/drivers/acpi/numa.c	Tue Jan 13 02:25:32 2004
+++ linux-2.6.1/drivers/acpi/numa.c	Tue Jan 13 02:38:32 2004
@@ -30,6 +30,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
+#include <acpi/acmacros.h>
 
 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler, unsigned int max_entries);
 
@@ -46,9 +47,9 @@
 	{
 		struct acpi_table_processor_affinity *p =
 			(struct acpi_table_processor_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
 		       p->apic_id, p->lsapic_eid, p->proximity_domain,
-		       p->flags.enabled?"enabled":"disabled");
+		       p->flags.enabled?"enabled":"disabled"));
 	}
 		break;
 
@@ -56,11 +57,11 @@
 	{
 		struct acpi_table_memory_affinity *p =
 			(struct acpi_table_memory_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
 		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
 		       p->memory_type, p->proximity_domain,
 		       p->flags.enabled ? "enabled" : "disabled",
-		       p->flags.hot_pluggable ? " hot-pluggable" : "");
+		       p->flags.hot_pluggable ? " hot-pluggable" : ""));
 	}
 		break;
 
@@ -97,7 +98,7 @@
 static int __init
 acpi_parse_processor_affinity (acpi_table_entry_header *header)
 {
-	struct acpi_table_processor_affinity *processor_affinity = NULL;
+	struct acpi_table_processor_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_table_processor_affinity*) header;
 	if (!processor_affinity)
@@ -115,7 +116,7 @@
 static int __init
 acpi_parse_memory_affinity (acpi_table_entry_header *header)
 {
-	struct acpi_table_memory_affinity *memory_affinity = NULL;
+	struct acpi_table_memory_affinity *memory_affinity;
 
 	memory_affinity = (struct acpi_table_memory_affinity*) header;
 	if (!memory_affinity)
@@ -133,7 +134,7 @@
 static int __init
 acpi_parse_srat (unsigned long phys_addr, unsigned long size)
 {
-	struct acpi_table_srat	*srat = NULL;
+	struct acpi_table_srat	*srat;
 
 	if (!phys_addr || !size)
 		return -EINVAL;
