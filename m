Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUAHOpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbUAHOp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:45:29 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:10128 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263868AbUAHOpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:45:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16381.27904.580087.442358@gargle.gargle.HOWL>
Date: Thu, 8 Jan 2004 09:45:20 -0500
To: linux-kernel@vger.kernel.org
CC: acpi-devel@lists.sourceforge.net, jbarnes@sgi.com, steiner@sgi.com
Subject: RFC: ACPI table overflow handling
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We ran into a problem with the current ACPI NUMA code overflowing an
array if the number of CPUs found in the SRAT was greater than NR_CPUS.

Looking at the acpi_table_parse_madt() I noticed that it doesn't do
anything to handle overflows, instead it relies on hacks in the
call-back functions to come up with a check instead, the various checks
in place are somewhat inconsistent in their implementation.

I could just hack the NUMA srat_num_cpus handling code to have a limit
as IMHO it is a lot cleaner to improve the acpi_table_parse_madt() API
by adding a max_entries argument and then have acpi_table_parse_madt
spit out a warning if it found too many entries.

Patch attached, it was generated against 2.6.0-test11 but applies fine
with a little fuzz to 2.6.1-rc2 (my apologies for not having fixed
x86_64 yet, it should be trivial to apply the i386 changes to the x86_64
tree as well).

I'd appreciate comments/oppinions/suggestions?

Thanks,
Jes

diff -urN -X /usr/people/jes/exclude-linux --exclude=io --exclude=sn --exclude='qla1280.[ch]' orig/linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c
--- orig/linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c	Wed Nov 26 12:45:28 2003
+++ linux-2.6.0-test11-ia64/arch/i386/kernel/acpi/boot.c	Thu Jan  8 05:11:49 2004
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
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr, 65536);
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
+	result = acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 65536);
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
+++ linux-2.6.0-test11-ia64/arch/ia64/kernel/acpi.c	Thu Jan  8 03:03:46 2004
@@ -550,29 +550,34 @@
 
 	/* Local APIC */
 
-	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr) < 0)
+	/*
+	 * For the callback functions that do not have problems with maximum
+	 * table sizes internally, we use 65536 - please adjust if you ever
+	 * build a system with more ;-)
+	 */
+	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_ADDR_OVR, acpi_parse_lapic_addr_ovr, 65536) < 0)
 		printk(KERN_ERR PREFIX "Error parsing LAPIC address override entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_LSAPIC, acpi_parse_lsapic) < 1)
+	if (acpi_table_parse_madt(ACPI_MADT_LSAPIC, acpi_parse_lsapic, NR_CPUS) < 1)
 		printk(KERN_ERR PREFIX "Error parsing MADT - no LAPIC entries\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_LAPIC_NMI, acpi_parse_lapic_nmi, 65536) < 0)
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
+	if (acpi_table_parse_madt(ACPI_MADT_INT_SRC_OVR, acpi_parse_int_src_ovr, 65536) < 0)
 		printk(KERN_ERR PREFIX "Error parsing interrupt source overrides entry\n");
 
-	if (acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src) < 0)
+	if (acpi_table_parse_madt(ACPI_MADT_NMI_SRC, acpi_parse_nmi_src, 65536) < 0)
 		printk(KERN_ERR PREFIX "Error parsing NMI SRC entry\n");
   skip_madt:
 
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
+++ linux-2.6.0-test11-ia64/drivers/acpi/tables.c	Thu Jan  8 04:46:09 2004
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
@@ -335,13 +336,17 @@
 		((unsigned long) madt + madt_size);
 
 	while (((unsigned long) entry) < madt_end) {
-		if (entry->type == entry_id) {
-			count++;
+		if (entry->type == entry_id && count++ < max_entries)
 			handler(entry);
-		}
+
 		entry = (acpi_table_entry_header *)
 			((unsigned long) entry + entry->length);
 	}
+	if (count > max_entries) {
+		printk(KERN_WARNING PREFIX "[%s:0x%02x] ignored %i entries of "
+		       "%i found\n", acpi_table_signatures[id], entry_id,
+		       count - max_entries, count);
+	}
 
 	return count;
 }
@@ -350,10 +355,11 @@
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
 
 
@@ -578,4 +584,3 @@
 
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
