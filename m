Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUAMAcU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUAMAcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:32:20 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:37813 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263595AbUAMAcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:32:17 -0500
Subject: [PATCH] 2.4/2.6 use xdsdt to print table header
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Cc: len.brown@intel.com
Content-Type: text/plain
Message-Id: <1073953935.6497.173.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 17:32:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I'm resending this patch to get it into the main ACPI source.  This
fixes a problem where the DSDT pointer in the FADT is NULL because it
uses the 64bit XDSDT instead.  The current code is happy to map a NULL
address and return success to the caller.  This can crash the system or
printout garbage headers to the console.  It's a simple matter to check
table revision and use the XDSDT in favor of the DSDT.  This has been
living happily in both the 2.4 and 2.6 ia64 tree for some time.  Please
accept.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Mon Jan 12 15:37:12 2004
+++ b/drivers/acpi/tables.c	Mon Jan 12 15:37:12 2004
@@ -262,10 +262,17 @@
 
 	/* Map the DSDT header via the pointer in the FADT */
 	if (id == ACPI_DSDT) {
-		struct acpi_table_fadt *fadt = (struct acpi_table_fadt *) *header;
+		struct fadt_descriptor_rev2 *fadt = (struct fadt_descriptor_rev2 *) *header;
+
+		if (fadt->revision == 3 && fadt->Xdsdt) {
+			*header = (void *) __acpi_map_table(fadt->Xdsdt,
+					sizeof(struct acpi_table_header));
+		} else if (fadt->V1_dsdt) {
+			*header = (void *) __acpi_map_table(fadt->V1_dsdt,
+					sizeof(struct acpi_table_header));
+		} else
+			*header = 0;
 
-		*header = (void *) __acpi_map_table(fadt->dsdt_addr,
-				sizeof(struct acpi_table_header));
 		if (!*header) {
 			printk(KERN_WARNING PREFIX "Unable to map DSDT\n");
 			return -ENODEV;



