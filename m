Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUHIEzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUHIEzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUHIEzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:55:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35484 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265993AbUHIEzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:55:37 -0400
Subject: Re: [PATCH] cleanup ACPI numa warnings
From: Dave Hansen <haveblue@us.ibm.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092025184.2292.26.camel@localhost.localdomain>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk> <1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
	 <1092025184.2292.26.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-eqt3wylFLUziiCjtlLvg"
Message-Id: <1092027151.6496.13709.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 21:52:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eqt3wylFLUziiCjtlLvg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-08-08 at 21:19, Alex Williamson wrote:
>    Ok, I was all set to switch to static inlines, but it doesn't work.
> Compiling w/ debug on, _dbg is undefined, which is part of the
> ACPI_DB_INFO macro, but it only gets setup by the ACPI_FUNCTION_NAME
> macro.  Guess I got lucky by choosing to do it as a macro.  IMHO, it
> doesn't really make sense to make the static inline functions more
> complicated or hide where they're getting called to make this all work.
> So, I think the choices are to stick with the ugly macros or put #ifdefs
> around the code and essentially leave it the way it is.  Sorry I didn't
> give it a more thorough look when originally questioned.  Better ideas?
> Thanks,

That code is already pretty hideous, so perhaps my original question
doesn't have that much impact.  The attached patch at least uses inline
functions.  It still has the #ifdefs, but what else do you expect for
debugging code?  Is this a feasible approach?

-- Dave

--=-eqt3wylFLUziiCjtlLvg
Content-Disposition: attachment; filename=ACPI-warnings-1.patch
Content-Type: text/x-patch; name=ACPI-warnings-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Only in acpi-warnings/drivers/acpi/: .Kconfig.swp
diff -ru clean/drivers/acpi/numa.c acpi-warnings/drivers/acpi/numa.c
--- clean/drivers/acpi/numa.c	2004-06-15 22:19:44.000000000 -0700
+++ acpi-warnings/drivers/acpi/numa.c	2004-08-08 21:46:58.000000000 -0700
@@ -38,6 +38,33 @@
 
 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler, unsigned int max_entries);
 
+#ifdef ACPI_DEBUG_OUTPUT
+static inline void acpi_print_srat_processor_affinity(struct acpi_table_processor_affinity *p)
+{
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Processor (id[0x%02x] "
+			"eid[0x%02x]) in proximity domain %d %s\n",
+	                 p->apic_id, p->lsapic_eid, p->proximity_domain,
+	                 p->flags.enabled?"enabled":"disabled")); }
+}
+
+static inline void acpi_print_srat_memory_affinity(struct acpi_table_memory_affinity *p)
+{
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "SRAT Memory (0x%08x%08x length "
+	                 "0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+	                 p->base_addr_hi, p->base_addr_lo, p->length_hi,
+	                 p->length_lo, p->memory_type, p->proximity_domain,
+	                 p->flags.enabled ? "enabled" : "disabled",
+	                 p->flags.hot_pluggable ? " hot-pluggable" : "")); }
+}
+#else
+static inline void acpi_print_srat_memory_affinity(acpi_table_entry_header *header) {}
+static inline void acpi_print_srat_processor_affinity(acpi_table_entry_header *header) {}
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
+		acpi_print_srat_processor_affinity((struct acpi_table_processor_affinity *)header);
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
+		acpi_print_srat_memory_affinity((struct acpi_table_memory_affinity *)header);
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

--=-eqt3wylFLUziiCjtlLvg--

