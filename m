Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUHTTCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUHTTCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268678AbUHTS76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:59:58 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:22184 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268667AbUHTS4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:56:06 -0400
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
From: Alex Williamson <alex.williamson@hp.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Paul Jackson <pj@sgi.com>,
       haveblue@us.ibm.com, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2550950000.1092019997@[10.10.2.4]>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk><1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
	 <2550950000.1092019997@[10.10.2.4]>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 20 Aug 2004 12:55:51 -0600
Message-Id: <1093028151.4993.42.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I'm not sure where we stand on this, sorry for the delay.  To recap,
the first patch I submitted cleaned up the original functions, but moved
the ugliness up into multi-line macros.  People didn't like the macros
and suggested static inlines.  However, static inlines don't work for
this application because the debug print needs state setup by the
ACPI_FUNCTION_NAME call.  IMHO, it's not worth setting up that state in
the static inline function for this little bit of cleanup.

   So, I think we left it at nobody liked the macros and static inlines
don't work.  General unhappiness.  Below is a patch that doesn't attempt
to cleanup the original code, it just adds the #ifdefs and range
checking w/ no macros.  Does this look better?  Below is the original
submit comment outlining the goal.  Thanks,

	Alex

   The patch below removes these warnings:

  CC      drivers/acpi/numa.o
drivers/acpi/numa.c: In function `acpi_table_print_srat_entry':
drivers/acpi/numa.c:55: warning: unused variable `p'
drivers/acpi/numa.c:65: warning: unused variable `p'
drivers/acpi/numa.c: In function `acpi_numa_init':
drivers/acpi/numa.c:179: warning: passing arg 2 of
`acpi_table_parse_srat' from incompatible pointer type
drivers/acpi/numa.c:182: warning: passing arg 2 of
`acpi_table_parse_srat' from incompatible pointer type

And propagates the MADT error checking code into the SRAT code.

Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== drivers/acpi/numa.c 1.10 vs edited =====
--- 1.10/drivers/acpi/numa.c	2004-02-18 02:19:31 -07:00
+++ edited/drivers/acpi/numa.c	2004-08-10 16:58:37 -06:00
@@ -51,6 +51,7 @@
 	switch (header->type) {
 
 	case ACPI_SRAT_PROCESSOR_AFFINITY:
+#ifdef ACPI_DEBUG_OUTPUT
 	{
 		struct acpi_table_processor_affinity *p =
 			(struct acpi_table_processor_affinity*) header;
@@ -58,9 +59,11 @@
 		       p->apic_id, p->lsapic_eid, p->proximity_domain,
 		       p->flags.enabled?"enabled":"disabled"));
 	}
+#endif
 		break;
 
 	case ACPI_SRAT_MEMORY_AFFINITY:
+#ifdef ACPI_DEBUG_OUTPUT
 	{
 		struct acpi_table_memory_affinity *p =
 			(struct acpi_table_memory_affinity*) header;
@@ -70,6 +73,7 @@
 		       p->flags.enabled ? "enabled" : "disabled",
 		       p->flags.hot_pluggable ? " hot-pluggable" : ""));
 	}
+#endif
 		break;
 
 	default:
@@ -103,12 +107,14 @@
 
 
 static int __init
-acpi_parse_processor_affinity (acpi_table_entry_header *header)
+acpi_parse_processor_affinity (acpi_table_entry_header *header, unsigned long size)
 {
 	struct acpi_table_processor_affinity *processor_affinity;
 
 	processor_affinity = (struct acpi_table_processor_affinity*) header;
-	if (!processor_affinity)
+	if (!processor_affinity || (unsigned long)processor_affinity +
+	    sizeof(*processor_affinity) > size ||
+	    header->length != sizeof(*processor_affinity))
 		return -EINVAL;
 
 	acpi_table_print_srat_entry(header);
@@ -121,12 +127,14 @@
 
 
 static int __init
-acpi_parse_memory_affinity (acpi_table_entry_header *header)
+acpi_parse_memory_affinity (acpi_table_entry_header *header, unsigned long size)
 {
 	struct acpi_table_memory_affinity *memory_affinity;
 
 	memory_affinity = (struct acpi_table_memory_affinity*) header;
-	if (!memory_affinity)
+	if (!memory_affinity || (unsigned long)memory_affinity +
+	    sizeof(*memory_affinity) > size ||
+	    header->length != sizeof(*memory_affinity))
 		return -EINVAL;
 
 	acpi_table_print_srat_entry(header);



