Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTKFRUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTKFRUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:20:51 -0500
Received: from zok.SGI.COM ([204.94.215.101]:20409 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263715AbTKFRUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:20:47 -0500
Date: Thu, 6 Nov 2003 09:20:17 -0800
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [DMESG] cpumask_t in action
Message-ID: <20031106172017.GA28613@sgi.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
References: <20031105222202.GA24119@sgi.com> <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 04:51:59PM +0000, Matthew Wilcox wrote:
> The arch/ia64 code is not the only offender; ACPI is terribly verbose too.
> I'm going to cc the acpi list too.  See comments below.
> 
> > ACPI: SRAT Processor (id[0x00] eid[0x00]) in proximity domain 0 enabled
[snip[
> > ACPI: SRAT Processor (id[0x20] eid[0x5e]) in proximity domain 47 enabled
> 
> ... for example ;-)  96 lines which honestly tell me nothing.
> 
> > ACPI: SRAT Memory (0x0000003000000000 length 0x0000001000000000 type 0x1) in proximity domain 0 enabled
> > ACPI: SRAT Memory (0x000000b000000000 length 0x0000001000000000 type 0x1) in proximity domain 1 enabled
> [ snip 44 lines ]
> > ACPI: SRAT Memory (0x0000173000000000 length 0x0000001000000000 type 0x1) in proximity domain 46 enabled
> > ACPI: SRAT Memory (0x000017b000000000 length 0x0000001000000000 type 0x1) in proximity domain 47 enabled

Here's one for those two.

Jesse

===== drivers/acpi/numa.c 1.5 vs edited =====
--- 1.5/drivers/acpi/numa.c	Tue Feb 18 12:56:05 2003
+++ edited/drivers/acpi/numa.c	Thu Nov  6 09:18:50 2003
@@ -31,6 +31,13 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
+#undef ACPI_NUMA_DEBUG
+#ifdef ACPI_NUMA_DEBUG
+#define Dprintk(x...) printk(x)
+#else
+#define Dprintk(x...)
+#endif
+
 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler);
 
 void __init
@@ -46,7 +53,7 @@
 	{
 		struct acpi_table_processor_affinity *p =
 			(struct acpi_table_processor_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		Dprintk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
 		       p->apic_id, p->lsapic_eid, p->proximity_domain,
 		       p->flags.enabled?"enabled":"disabled");
 	}
@@ -56,7 +63,7 @@
 	{
 		struct acpi_table_memory_affinity *p =
 			(struct acpi_table_memory_affinity*) header;
-		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		Dprintk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
 		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
 		       p->memory_type, p->proximity_domain,
 		       p->flags.enabled ? "enabled" : "disabled",
