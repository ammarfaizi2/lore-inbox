Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbVJTDhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbVJTDhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbVJTDhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:37:43 -0400
Received: from lemon.ken.nicta.com.au ([203.143.174.44]:24548 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S1751724AbVJTDhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:37:42 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Date: Thu, 20 Oct 2005 13:37:31 +1000
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: VM 7.19 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 203.143.160.117
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: [PATCH] `unaligned access' in acpi get_root_bridge_busnr()
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In drivers/acpi/glue.c the address of an integer is cast to the
address of an unsigned long.  This breaks on systems where a long is
larger than an int --- for a start the int can be misaligned; for a
second the assignment through the pointer will overwrite part of the
next variable.

Patch is against linux-2.6.14-rc4

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

Index: linux-2.6-import/drivers/acpi/glue.c
===================================================================
--- linux-2.6-import.orig/drivers/acpi/glue.c	2005-09-09 09:08:49.928854100 +1000
+++ linux-2.6-import/drivers/acpi/glue.c	2005-10-20 13:32:32.126445742 +1000
@@ -89,46 +89,46 @@ static int acpi_find_bridge_device(struc
 /* Get PCI root bridge's handle from its segment and bus number */
 struct acpi_find_pci_root {
 	unsigned int seg;
 	unsigned int bus;
 	acpi_handle handle;
 };
 
 static acpi_status
 do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 {
-	int *busnr = (int *)data;
+	unsigned long *busnr = (unsigned long *)data;
 	struct acpi_resource_address64 address;
 
 	if (resource->id != ACPI_RSTYPE_ADDRESS16 &&
 	    resource->id != ACPI_RSTYPE_ADDRESS32 &&
 	    resource->id != ACPI_RSTYPE_ADDRESS64)
 		return AE_OK;
 
 	acpi_resource_to_address64(resource, &address);
 	if ((address.address_length > 0) &&
 	    (address.resource_type == ACPI_BUS_NUMBER_RANGE))
 		*busnr = address.min_address_range;
 
 	return AE_OK;
 }
 
 static int get_root_bridge_busnr(acpi_handle handle)
 {
 	acpi_status status;
-	int bus, bbn;
+	unsigned long bus, bbn;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
 	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
-				       (unsigned long *)&bbn);
+				       &bbn);
 	if (status == AE_NOT_FOUND) {
 		/* Assume bus = 0 */
 		printk(KERN_INFO PREFIX
 		       "Assume root bridge [%s] bus is 0\n",
 		       (char *)buffer.pointer);
 		status = AE_OK;
 		bbn = 0;
 	}
 	if (ACPI_FAILURE(status)) {
 		bbn = -ENODEV;
@@ -146,21 +146,21 @@ static int get_root_bridge_busnr(acpi_ha
 		goto exit;
 	/* We select _CRS */
 	if (bbn != bus) {
 		printk(KERN_INFO PREFIX
 		       "_BBN and _CRS returns different value for %s. Select _CRS\n",
 		       (char *)buffer.pointer);
 		bbn = bus;
 	}
       exit:
 	acpi_os_free(buffer.pointer);
-	return bbn;
+	return (int)bbn;
 }
 
 static acpi_status
 find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
 	unsigned long seg, bus;
 	acpi_status status;
 	int tmp;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
