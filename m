Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTIIUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTIIUMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:12:20 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:22838 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264479AbTIIUMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:12:10 -0400
Date: Tue, 9 Sep 2003 13:11:41 -0700
To: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] don't use alloc_bootmem in drivers/acpi/table.c
Message-ID: <20030909201141.GA6949@sgi.com>
Mail-Followup-To: andrew.grover@intel.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms use the ACPI tables to find memory, so using
alloc_bootmem there won't work.

Thanks,
Jesse


diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	Tue Sep  9 10:24:34 2003
+++ b/drivers/acpi/tables.c	Tue Sep  9 10:24:34 2003
@@ -69,7 +69,8 @@
 
 static unsigned long		sdt_pa;		/* Physical Address */
 static unsigned long		sdt_count;	/* Table count */
-static struct acpi_table_sdt	*sdt_entry;
+
+static struct acpi_table_sdt	sdt_entry[ACPI_MAX_TABLES];
 
 void
 acpi_table_print (
@@ -425,12 +426,6 @@
 			sdt_count = ACPI_MAX_TABLES;
 		}
 
-		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
-		if (!sdt_entry) {
-			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
-			return -ENOMEM;
-		}
-
 		for (i = 0; i < sdt_count; i++)
 			sdt_entry[i].pa = (unsigned long) mapped_xsdt->entry[i];
 	}
@@ -475,12 +470,6 @@
 			printk(KERN_WARNING PREFIX "Truncated %lu RSDT entries\n",
 				(sdt_count - ACPI_MAX_TABLES));
 			sdt_count = ACPI_MAX_TABLES;
-		}
-
-		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
-		if (!sdt_entry) {
-			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
-			return -ENOMEM;
 		}
 
 		for (i = 0; i < sdt_count; i++)
