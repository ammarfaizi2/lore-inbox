Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUAKOan (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUAKOan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:30:43 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:62137 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264264AbUAKOac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:30:32 -0500
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       jbarnes@sgi.com, steiner@sgi.com
Subject: Re: [ACPI] RFC: ACPI table overflow handling
References: <16381.27904.580087.442358@gargle.gargle.HOWL>
	<200401080920.04906.bjorn.helgaas@hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 11 Jan 2004 09:30:24 -0500
In-Reply-To: <200401080920.04906.bjorn.helgaas@hp.com>
Message-ID: <yq0ad4uimm7.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bjorn" == Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

Bjorn> I really like this idea.  I notice you didn't take the
Bjorn> opportunity to remove the ad hoc checking in ia64
Bjorn> acpi_parse_lsapic; probably that's the next step.  Also, did
Bjorn> you consider using max_entries==0 to signify "unlimited"?  Zero
Bjorn> seems like an otherwise useless value for max_entries and would
Bjorn> avoid having to choose an arbitrary limit.

Ok,

Here is a new version of the acpi patch, it uses 0 as 'unlimited' as
suggested by Bjorn and also removes two now obsolete ad-hoc overflow
tests as well as introduces x86_64 changes (not tested).

Cheers,
Jes

diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c
--- orig/linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c	Wed Nov 26 12:45:28 2003
+++ linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c	Sun Jan 11 05:16:24 2004
@@ -44,8 +44,8 @@
 extern int acpi_irq;
 extern int acpi_ht;
 
-int acpi_lapic = 0;
-int acpi_ioapic = 0;
+int acpi_lapic;
+int acpi_ioapic;
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
@@ -418,7 +418,7 @@
 	 * and (optionally) overriden by a LAPIC_ADDR_OVR entry (64-bit value).
 	 */
 
-	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr);
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr, 0);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC address override entry\n");
 		return result;
@@ -426,7 +426,8 @@
 
 	mp_register_lapic_address(acpi_lapic_addr);
 
-	result = acpi_table_parse_madt(ACPI_MADT_LAPIC, acpi_parse_lapic);
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC, acpi_parse_lapic,
+				       MAX_APICS);
 	if (!result) { 
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -438,7 +439,7 @@
 		return result;
 	}
 
-	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi);
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 0);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -475,8 +476,8 @@
 		return 1;
 	}
 
-	result = acpi_table_parse_madt(ACPI_MADT_IOAPIC, acpi_parse_ioapic);
-	if (!result) { 
+	result = acpi_table_parse_madt(ACPI_MADT_IOAPIC, acpi_parse_ioapic, MAX_IO_APICS);
+	if (!result) {
 		printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
 		return -ENODEV;
 	}
@@ -488,14 +489,14 @@
 	/* Build a default routing table for legacy (ISA) interrupts. */
 	mp_config_acpi_legacy_irqs();
 
-	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr);
+	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, NR_IRQ_VECTORS);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return result;
 	}
 
-	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src);
+	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src, NR_IRQ_VECTORS);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c
--- orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c	Wed Nov 26 12:44:07 2003
+++ linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c	Sun Jan 11 05:15:22 2004
@@ -189,8 +189,6 @@
 
 	if (!lsapic->flags.enabled)
 		printk(" disabled");
-	else if (available_cpus >= NR_CPUS)
-		printk(" ignored (increase NR_CPUS)");
 	else {
 		printk(" enabled");
 #ifdef CONFIG_SMP
@@ -393,12 +391,6 @@
 	size = ma->length_hi;
 	size = (size << 32) | ma->length_lo;
 
-	if (num_memblks >= NR_MEMBLKS) {
-		printk(KERN_ERR "Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
-		       size/(1024*1024), paddr);
-		return;
-	}
-
 	/* Ignore disabled entries */
 	if (!ma->flags.enabled)
 		return;
@@ -550,29 +542,29 @@
 
 	/* Local APIC */
 
-	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr, 0) < 0)
 		printk(KERN_ERR PREFIX "Error parsing LAPIC address override entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_LSAPIC, acpi_parse_lsapic) < 1)
+	if (acpi_table_parse_madt(ACPI_MADT_LSAPIC, acpi_parse_lsapic, NR_CPUS) < 1)
 		printk(KERN_ERR PREFIX "Error parsing MADT - no LAPIC entries\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 0) < 0)
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 
 	/* I/O APIC */
 
-	if (acpi_table_parse_madt(ACPI_MADT_IOSAPIC, acpi_parse_iosapic) < 1)
+	if (acpi_table_parse_madt(ACPI_MADT_IOSAPIC, acpi_parse_iosapic, 256) < 1)
 		printk(KERN_ERR PREFIX "Error parsing MADT - no IOSAPIC entries\n");
 
 	/* System-Level Interrupt Routing */
 
-	if (acpi_table_parse_madt(ACPI_MADT_PLAT_INT_SRC, acpi_parse_plat_int_src) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_PLAT_INT_SRC, acpi_parse_plat_int_src, ACPI_MAX_PLATFORM_INTERRUPTS) < 0)
 		printk(KERN_ERR PREFIX "Error parsing platform interrupt source entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, 0) < 0)
 		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src, 0) < 0)
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
   skip_madt:
 
diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/arch/x86_64/kernel/acpi/boot.c linux-2.6.0-test11-ia64/arch/x86_64/kernel/acpi/boot.c
--- orig/linux-2.6.0-test11-ia64/arch/x86_64/kernel/acpi/boot.c	Wed Nov 26 12:43:24 2003
+++ linux-2.6.0-test11-ia64/arch/x86_64/kernel/acpi/boot.c	Sun Jan 11 05:31:58 2004
@@ -46,8 +46,8 @@
 #include <asm/proto.h>
 #include <asm/tlbflush.h>
 
-int acpi_lapic = 0;
-int acpi_ioapic = 0;
+int acpi_lapic;
+int acpi_ioapic;
 
 #define PREFIX			"ACPI: "
 
@@ -398,7 +398,7 @@
 	 * and (optionally) overriden by a LAPIC_ADDR_OVR entry (64-bit value).
 	 */
 
-	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr);
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr, 0);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC address override entry\n");
 		return result;
@@ -406,7 +406,8 @@
 
 	mp_register_lapic_address(acpi_lapic_addr);
 
-	result = acpi_table_parse_madt(ACPI_MADT_LAPIC, acpi_parse_lapic);
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC, acpi_parse_lapic,
+				       MAX_APICS);
 	if (!result) { 
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -418,7 +419,7 @@
 		return result;
 	}
 
-	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi);
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 0);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
@@ -455,8 +456,8 @@
 		return 1;
 	}
 
-	result = acpi_table_parse_madt(ACPI_MADT_IOAPIC, acpi_parse_ioapic);
-	if (!result) { 
+	result = acpi_table_parse_madt(ACPI_MADT_IOAPIC, acpi_parse_ioapic, MAX_IO_APICS);
+	if (!result) {
 		printk(KERN_ERR PREFIX "No IOAPIC entries present\n");
 		return -ENODEV;
 	}
@@ -468,14 +469,15 @@
 	/* Build a default routing table for legacy (ISA) interrupts. */
 	mp_config_acpi_legacy_irqs();
 
-	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr);
+	result = acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, NR_IRQ_VECTORS);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
 		return result;
 	}
 
-	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src);
+	result = acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src,
+				       NO_IRQ_VECTORS);
 	if (result < 0) {
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/drivers/acpi/numa.c linux-2.6.0-test11-ia64/drivers/acpi/numa.c
--- orig/linux-2.6.0-test11-ia64/drivers/acpi/numa.c	Thu Dec 11 04:22:40 2003
+++ linux-2.6.0-test11-ia64/drivers/acpi/numa.c	Thu Jan  8 02:49:24 2004
@@ -38,7 +38,7 @@
 #define Dprintk(x...)
 #endif
 
-extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler);
+extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler, int max_entries);
 
 void __init
 acpi_table_print_srat_entry (
@@ -156,10 +156,11 @@
 int __init
 acpi_table_parse_srat (
 	enum acpi_srat_entry_id	id,
-	acpi_madt_entry_handler	handler)
+	acpi_madt_entry_handler	handler,
+	int max_entries)
 {
 	return acpi_table_parse_madt_family(ACPI_SRAT, sizeof(struct acpi_table_srat),
-					    id, handler);
+					    id, handler, max_entries);
 }
 
 
@@ -173,9 +174,11 @@
 
 	if (result > 0) {
 		result = acpi_table_parse_srat(ACPI_SRAT_PROCESSOR_AFFINITY,
-					       acpi_parse_processor_affinity);
+					       acpi_parse_processor_affinity,
+					       NR_CPUS);
 		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY,
-					       acpi_parse_memory_affinity);
+					       acpi_parse_memory_affinity,
+					       NR_MEMBLKS);
 	} else {
 		/* FIXME */
 		printk("Warning: acpi_table_parse(ACPI_SRAT) returned %d!\n",result);
diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/drivers/acpi/tables.c linux-2.6.0-test11-ia64/drivers/acpi/tables.c
--- orig/linux-2.6.0-test11-ia64/drivers/acpi/tables.c	Thu Dec 11 04:22:40 2003
+++ linux-2.6.0-test11-ia64/drivers/acpi/tables.c	Sun Jan 11 05:38:51 2004
@@ -295,13 +295,14 @@
 	enum acpi_table_id	id,
 	unsigned long		madt_size,
 	int			entry_id,
-	acpi_madt_entry_handler	handler)
+	acpi_madt_entry_handler	handler,
+	int			max_entries)
 {
 	void			*madt = NULL;
-	acpi_table_entry_header	*entry = NULL;
-	unsigned long		count = 0;
-	unsigned long		madt_end = 0;
-	unsigned int			i = 0;
+	acpi_table_entry_header	*entry;
+	unsigned int		count = 0;
+	unsigned long		madt_end;
+	unsigned int		i;
 
 	if (!handler)
 		return -EINVAL;
@@ -335,13 +336,18 @@
 		((unsigned long) madt + madt_size);
 
 	while (((unsigned long) entry) < madt_end) {
-		if (entry->type == entry_id) {
-			count++;
+		if (entry->type == entry_id &&
+		    (!max_entries || count++ < max_entries))
 			handler(entry);
-		}
+
 		entry = (acpi_table_entry_header *)
 			((unsigned long) entry + entry->length);
 	}
+	if (max_entries && count > max_entries) {
+		printk(KERN_WARNING PREFIX "[%s:0x%02x] ignored %i entries of "
+		       "%i found\n", acpi_table_signatures[id], entry_id,
+		       count - max_entries, count);
+	}
 
 	return count;
 }
@@ -350,10 +356,11 @@
 int __init
 acpi_table_parse_madt (
 	enum acpi_madt_entry_id	id,
-	acpi_madt_entry_handler	handler)
+	acpi_madt_entry_handler	handler,
+	int max_entries)
 {
 	return acpi_table_parse_madt_family(ACPI_APIC, sizeof(struct acpi_table_madt),
-					    id, handler);
+					    id, handler, max_entries);
 }
 
 
@@ -578,4 +585,3 @@
 
 	return 0;
 }
-
diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/include/linux/acpi.h linux-2.6.0-test11-ia64/include/linux/acpi.h
--- orig/linux-2.6.0-test11-ia64/include/linux/acpi.h	Wed Nov 26 12:42:43 2003
+++ linux-2.6.0-test11-ia64/include/linux/acpi.h	Thu Jan  8 03:08:06 2004
@@ -355,8 +355,8 @@
 int acpi_table_init (void);
 int acpi_table_parse (enum acpi_table_id id, acpi_table_handler handler);
 int acpi_get_table_header_early (enum acpi_table_id id, struct acpi_table_header **header);
-int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_handler handler);
-int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_handler handler);
+int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_handler handler, int max_entries);
+int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_handler handler, int max_entries);
 void acpi_table_print (struct acpi_table_header *header, unsigned long phys_addr);
 void acpi_table_print_madt_entry (acpi_table_entry_header *madt);
 void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
