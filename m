Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVEKRYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVEKRYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVEKRYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:24:11 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18936 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261237AbVEKRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:21:26 -0400
Message-ID: <42823F15.7090601@acm.org>
Date: Wed, 11 May 2005 12:21:25 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: acpi=off and acpi_get_firmware_table
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050105050405040609090806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105050405040609090806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In 2.6.12-rc4, I added acpi=off to the kernel command line and it 
panic-ed in acpi_get_firmware_table, called from the IPMI driver.

The attached patch fixes the problem, but it still spits out ugly 
"ACPI-0166: *** Error: Invalid address flags 8" errors.  So I doubt the 
patch is right, but maybe it points to something else.

Is it legal to call acpi_get_firmware_table if acpi is off?  If not, how 
can I tell that acpi is off?

-Corey

--------------050105050405040609090806
Content-Type: text/x-patch;
 name="acpi_table_null_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_table_null_fix.patch"

Index: linux-2.6.12-rc4/drivers/acpi/tables/tbxfroot.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/acpi/tables/tbxfroot.c
+++ linux-2.6.12-rc4/drivers/acpi/tables/tbxfroot.c
@@ -313,7 +313,9 @@
 
 
 cleanup:
-	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
+	if (rsdt_info->pointer)
+		acpi_os_unmap_memory (rsdt_info->pointer,
+			       	      (acpi_size) rsdt_info->pointer->length);
 	ACPI_MEM_FREE (rsdt_info);
 
 	if (header) {

--------------050105050405040609090806--
