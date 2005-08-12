Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVHLTtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVHLTtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVHLTtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:49:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751267AbVHLTtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:49:40 -0400
Date: Fri, 12 Aug 2005 15:44:44 -0400
Message-Id: <200508121944.j7CJiifE005958@redrum.boston.redhat.com>
From: Peter Martuccelli <peterm@redhat.com>
To: len.brown@intel.com
Cc: akpm@osdl.com, linux-kernel@vger.kernel.org, peterm@redhat.com
Subject: [PATCH 2.6.12.4] ACPI oops during ipmi_si driver init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Len,

Stumbled into this problem working on the ipmi_si driver.  When the
ipmi_si driver initialization fails the acpi_tb_get_table 
call, after rsdt_info has been allocated, acpi_get_firmware_table()
will oops trying to reference off rsdt_info->pointer in the cleanup
code.  The following patch resolves the problem.  I noticed this
problem on six different systems, all with slightly different stack
traces, but they all fail in the same manner. 

Patch applies cleanly to 2.6.12.4.  Tested at various sites and on
various systems, no additional problems detected.

Signed-off-by: peterm@redhat.com


Regards,

Peter

--- linux-2.6.9/drivers/acpi/tables/tbxfroot.c.orig	2005-08-11 23:44:01.000000000 -0400
+++ linux-2.6.9/drivers/acpi/tables/tbxfroot.c	2005-08-11 23:52:57.000000000 -0400
@@ -293,9 +293,12 @@ acpi_get_firmware_table (
 
 
 cleanup:
-	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
-	ACPI_MEM_FREE (rsdt_info);
-
+	if (rsdt_info) {
+	        if (rsdt_info->pointer) {
+         		acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
+		}
+		ACPI_MEM_FREE (rsdt_info);
+	}
 	if (header) {
 		ACPI_MEM_FREE (header);
 	}
