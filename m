Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTHGVOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbTHGVOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:14:30 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:50887 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S270501AbTHGVO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:14:26 -0400
Message-ID: <3F32C131.50A997BA@hp.com>
Date: Thu, 07 Aug 2003 15:14:25 -0600
From: Alex Williamson <alex_williamson@hp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.6.0-test2-bk5-aw-ob500 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH] Check for X__DSDT in acpi_get_table_header_early()
Content-Type: multipart/mixed;
 boundary="------------40D24DD113FB2909FB6880A3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------40D24DD113FB2909FB6880A3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


   I finally got tired of my rx2600 printing garbage at the end of
the list of ACPI tables so I decided to fix it.  Turns out the HP
rx2600 does not provide a DSDT in the FADT, so we were trying to
print a table at 0x0.  It does provide a X_DSDT.  This patch will
make acpi_get_table_header_early() prefer the X_DSDT over the DSDT
and adds more checking for null.  Looks like the same code is in
2.6 and 2.4, please apply for both.  Thanks,

	Alex
 
-- 
Alex Williamson                             HP Linux & Open Source Lab
--------------40D24DD113FB2909FB6880A3
Content-Type: text/plain; charset=us-ascii;
 name="xdsdt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xdsdt.diff"

--- linux/drivers/acpi/tables.c	2003-07-27 11:00:40.000000000 -0600
+++ linux/drivers/acpi/tables.c	2003-08-07 14:15:11.000000000 -0600
@@ -256,10 +256,17 @@
 
 	/* Map the DSDT header via the pointer in the FADT */
 	if (id == ACPI_DSDT) {
-		struct acpi_table_fadt *fadt = (struct acpi_table_fadt *) *header;
+		struct fadt_descriptor_rev2 *fadt = (struct fadt_descriptor_rev2 *) *header;
+
+		if (fadt->header.revision == 3 && fadt->Xdsdt) {
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

--------------40D24DD113FB2909FB6880A3--

