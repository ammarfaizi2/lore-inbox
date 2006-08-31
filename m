Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWHaXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWHaXxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWHaXxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:53:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13172 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932489AbWHaXxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:53:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent;
	b=vyUuiV3maUKZCmzyiGqToUbB8PTY1x6JFrL/1y3+zjknFe73Y0Eukec/A3TI9WHiN
	AuRhBYIRy0m4oyZ/W4vmQ==
Date: Thu, 31 Aug 2006 16:52:45 -0700
From: adurbin@google.com
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [PATCH] i386/x86_64: add HPET(s) into resource map
Message-ID: <20060831235245.GC21338@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add HPET(s) into resource map. This will allow for the HPET(s) to be
visibile within /proc/iomem.

Signed-off-by: Aaron Durbin <adurbin@google.com>

---

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index ee003bc..d3fafb2 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -29,6 +29,8 @@ #include <linux/efi.h>
 #include <linux/module.h>
 #include <linux/dmi.h>
 #include <linux/irq.h>
+#include <linux/bootmem.h>
+#include <linux/ioport.h>
 
 #include <asm/pgtable.h>
 #include <asm/io_apic.h>
@@ -579,6 +581,8 @@ #ifdef CONFIG_HPET_TIMER
 static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
 {
 	struct acpi_table_hpet *hpet_tbl;
+	struct resource *hpet_res;
+	resource_size_t res_start;
 
 	if (!phys || !size)
 		return -EINVAL;
@@ -594,12 +598,26 @@ static int __init acpi_parse_hpet(unsign
 		       "memory.\n");
 		return -1;
 	}
+
+#define HPET_RESOURCE_NAME_SIZE 9
+	hpet_res = alloc_bootmem(sizeof(*hpet_res) + HPET_RESOURCE_NAME_SIZE);
+	if (hpet_res) {
+		memset(hpet_res, 0, sizeof(*hpet_res));
+		hpet_res->name = (void *)&hpet_res[1];
+		hpet_res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		snprintf((char *)hpet_res->name, HPET_RESOURCE_NAME_SIZE, 
+			 "HPET %u", hpet_tbl->number);
+		hpet_res->end = (1 * 1024) - 1;
+	}
+
 #ifdef	CONFIG_X86_64
 	vxtime.hpet_address = hpet_tbl->addr.addrl |
 	    ((long)hpet_tbl->addr.addrh << 32);
 
 	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
 	       hpet_tbl->id, vxtime.hpet_address);
+
+	res_start = vxtime.hpet_address;
 #else				/* X86 */
 	{
 		extern unsigned long hpet_address;
@@ -607,9 +625,17 @@ #else				/* X86 */
 		hpet_address = hpet_tbl->addr.addrl;
 		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
 		       hpet_tbl->id, hpet_address);
+
+		res_start = hpet_address;
 	}
 #endif				/* X86 */
 
+	if (hpet_res) {
+		hpet_res->start = res_start;
+		hpet_res->end += res_start;
+		insert_resource(&iomem_resource, hpet_res);
+	}
+
 	return 0;
 }
 #else
