Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272898AbTHKSVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273030AbTHKSPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:15:35 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63914 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S272991AbTHKSM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:12:28 -0400
Message-ID: <3F37DC85.80208@mvista.com>
Date: Mon, 11 Aug 2003 13:12:21 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: IPMI updates for 2.6.0-test3
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020008070601070803060102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020008070601070803060102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus,

Here are some minor updates to the IPMI driver.  They fix the following:

    * A missing check for copy_to_user() in the watchdog driver.
    * Removal of unnecessary check_region() calls.
    * Fixes for the ACPI configuration. The previous one would only work
      with memory addresses, this will work with memory addresses,
      ports, and hadle checking that the type is correct.

Please apply.

-Corey

--------------020008070601070803060102
Content-Type: text/plain;
 name="linux-2.6.0-test3-ipmi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.0-test3-ipmi.diff"

diff -ur linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c linux.keepup/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c	Mon Aug 11 11:22:37 2003
+++ linux.keepup/drivers/char/ipmi/ipmi_kcs_intf.c	Mon Aug 11 12:19:57 2003
@@ -1018,52 +1018,81 @@
 
 #ifdef CONFIG_ACPI_INTERPRETER
 
-/* Retrieve the base physical address from ACPI tables.  Originally
-   from Hewlett-Packard simple bmc.c, a GPL KCS driver. */
-
 #include <linux/acpi.h>
 
 struct SPMITable {
-	s8	Signature[4];
-	u32	Length;
-	u8	Revision;
-	u8	Checksum;
-	s8	OEMID[6];
-	s8	OEMTableID[8];
-	s8	OEMRevision[4];
-	s8	CreatorID[4];
-	s8	CreatorRevision[4];
-	s16	InterfaceType;
-	s16	SpecificationRevision;
-	u8	InterruptType;
-	u8	GPE;
-	s16	Reserved;
-	u64	GlobalSystemInterrupt;
-	u8	BaseAddress[12];
-	u8	UID[4];
-} __attribute__ ((packed));
+	s8      Signature[4];
+	u32     Length;
+	u8      Revision;
+	u8      Checksum;
+	s8      OEMID[6];
+	s8      OEMTableID[8];
+	s8      OEMRevision[4];
+	s8      CreatorID[4];
+	s8      CreatorRevision[4];
+	u8      InterfaceType[2];
+	s16     SpecificationRevision;
+
+	/*
+	 * Bit 0 - SCI interrupt supported
+	 * Bit 1 - I/O APIC/SAPIC
+	 */
+	u8      InterruptType;
+
+	/* If bit 0 of InterruptType is set, then this is the SCI
+	   interrupt in the GPEx_STS register. */
+	u8      GPE;
+
+	s16     Reserved;
+
+	/* If bit 1 of InterruptType is set, then this is the I/O
+	   APIC/SAPIC interrupt. */
+	u32     GlobalSystemInterrupt;
+
+	/* The actual register address. */
+	struct acpi_generic_address addr;
 
-static unsigned long acpi_find_bmc(void)
-{
-	acpi_status status;
-	struct acpi_table_header *spmi;
-	static unsigned long io_base = 0;
+	u8      UID[4];
 
-	if (io_base != 0)
-		return io_base;
+	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
+};
 
+static int acpi_find_bmc(unsigned long *physaddr, int *port)
+{
+	acpi_status          status;
+	struct SPMITable     *spmi;
+	
 	status = acpi_get_firmware_table("SPMI", 1,
-			ACPI_LOGICAL_ADDRESSING, &spmi);
+					 ACPI_LOGICAL_ADDRESSING,
+					 (struct acpi_table_header **) &spmi);
+	if (status != AE_OK)
+		goto not_found;
+
+	if (spmi->InterfaceType[0] != 1)
+		/* Not IPMI. */
+		goto not_found;
+
+	if (spmi->InterfaceType[1] != 1)
+		/* Not KCS. */
+		goto not_found;
+
+	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		*physaddr = spmi->addr.address;
+		printk("ipmi_kcs_intf: Found ACPI-specified state machine"
+		       " at memory address 0x%lx\n",
+		       (unsigned long) spmi->addr.address);
+	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		*port = spmi->addr.address;
+		printk("ipmi_kcs_intf: Found ACPI-specified state machine"
+		       " at I/O address 0x%lx\n",
+		       (int) spmi->addr.address);
+	} else
+		goto not_found; /* Not an address type we recognise. */
 
-	if (status != AE_OK) {
-		printk(KERN_ERR "ipmi_kcs: SPMI table not found.\n");
-		return 0;
-	}
+	return 0;
 
-	memcpy(&io_base, ((struct SPMITable *)spmi)->BaseAddress,
-			sizeof(io_base));
-	
-	return io_base;
+ not_found:
+	return -ENODEV;
 }
 #endif
 
@@ -1074,6 +1103,7 @@
 	int		i = 0;
 #ifdef CONFIG_ACPI_INTERPRETER
 	unsigned long	physaddr = 0;
+	int             port = 0;
 #endif
 
 	if (initialized)
@@ -1101,20 +1131,19 @@
 	/* Only try the defaults if enabled and resources are available
 	   (because they weren't already specified above). */
 
-	if (kcs_trydefaults) {
+	if (kcs_trydefaults && (pos == 0)) {
+		rv = -EINVAL;
 #ifdef CONFIG_ACPI_INTERPRETER
-		if ((physaddr = acpi_find_bmc())) {
-			if (!check_mem_region(physaddr, 2)) {
-				rv = init_one_kcs(0, 
-						  0, 
-						  physaddr, 
-						  &(kcs_infos[pos]));
-				if (rv == 0)
-					pos++;
-			}
+		if (rv && (physaddr = acpi_find_bmc(&physaddr, &port) == 0)) {
+			rv = init_one_kcs(port, 
+					  0, 
+					  physaddr, 
+					  &(kcs_infos[pos]));
+			if (rv == 0)
+				pos++;
 		}
 #endif
-		if (!check_region(DEFAULT_IO_PORT, 2)) {
+		if (rv) {
 			rv = init_one_kcs(DEFAULT_IO_PORT, 
 					  0, 
 					  0, 
diff -ur linux.orig/drivers/char/ipmi/ipmi_watchdog.c linux.keepup/drivers/char/ipmi/ipmi_watchdog.c
--- linux.orig/drivers/char/ipmi/ipmi_watchdog.c	Mon Jun  2 15:58:29 2003
+++ linux.keepup/drivers/char/ipmi/ipmi_watchdog.c	Mon Aug 11 11:34:37 2003
@@ -559,7 +559,10 @@
 
 	case WDIOC_GETSTATUS:
 		val = 0;
-		return copy_to_user((void *) arg, &val, sizeof(val));
+		i = copy_to_user((void *) arg, &val, sizeof(val));
+		if (i)
+			return -EFAULT;
+		return 0;
 
 	default:
 		return -ENOIOCTLCMD;

--------------020008070601070803060102--

