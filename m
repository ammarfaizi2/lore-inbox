Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161406AbWASUOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161406AbWASUOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161407AbWASUOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:14:38 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:50658 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1161403AbWASUOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:14:35 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 5/5] ACPI: clean up memory attribute checking for map/read/write
Date: Thu, 19 Jan 2006 13:14:31 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060118181116.GA5537@lists.us.dell.com> <200601191310.57303.bjorn.helgaas@hp.com>
In-Reply-To: <200601191310.57303.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191314.31705.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 ioremap is now smart enough to use the correct memory attributes,
so remove the EFI checks from osl.c.

Depends on the previous ia64 ioremap patch.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm3/drivers/acpi/osl.c
===================================================================
--- work-mm3.orig/drivers/acpi/osl.c	2006-01-19 11:37:23.000000000 -0700
+++ work-mm3/drivers/acpi/osl.c	2006-01-19 11:38:05.000000000 -0700
@@ -180,22 +180,14 @@
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size,
 		   void __iomem ** virt)
 {
-	if (efi_enabled) {
-		if (EFI_MEMORY_WB & efi_mem_attributes(phys)) {
-			*virt = (void __iomem *)phys_to_virt(phys);
-		} else {
-			*virt = ioremap(phys, size);
-		}
-	} else {
-		if (phys > ULONG_MAX) {
-			printk(KERN_ERR PREFIX "Cannot map memory that high\n");
-			return AE_BAD_PARAMETER;
-		}
-		/*
-		 * ioremap checks to ensure this is in reserved space
-		 */
-		*virt = ioremap((unsigned long)phys, size);
+	if (phys > ULONG_MAX) {
+		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
+		return AE_BAD_PARAMETER;
 	}
+	/*
+	 * ioremap checks to ensure this is in reserved space
+	 */
+	*virt = ioremap((unsigned long)phys, size);
 
 	if (!*virt)
 		return AE_NO_MEMORY;
@@ -405,18 +397,8 @@
 {
 	u32 dummy;
 	void __iomem *virt_addr;
-	int iomem = 0;
 
-	if (efi_enabled) {
-		if (EFI_MEMORY_WB & efi_mem_attributes(phys_addr)) {
-			/* HACK ALERT! We can use readb/w/l on real memory too.. */
-			virt_addr = (void __iomem *)phys_to_virt(phys_addr);
-		} else {
-			iomem = 1;
-			virt_addr = ioremap(phys_addr, width);
-		}
-	} else
-		virt_addr = (void __iomem *)phys_to_virt(phys_addr);
+	virt_addr = ioremap(phys_addr, width);
 	if (!value)
 		value = &dummy;
 
@@ -434,10 +416,7 @@
 		BUG();
 	}
 
-	if (efi_enabled) {
-		if (iomem)
-			iounmap(virt_addr);
-	}
+	iounmap(virt_addr);
 
 	return AE_OK;
 }
@@ -446,18 +425,8 @@
 acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 {
 	void __iomem *virt_addr;
-	int iomem = 0;
 
-	if (efi_enabled) {
-		if (EFI_MEMORY_WB & efi_mem_attributes(phys_addr)) {
-			/* HACK ALERT! We can use writeb/w/l on real memory too */
-			virt_addr = (void __iomem *)phys_to_virt(phys_addr);
-		} else {
-			iomem = 1;
-			virt_addr = ioremap(phys_addr, width);
-		}
-	} else
-		virt_addr = (void __iomem *)phys_to_virt(phys_addr);
+	virt_addr = ioremap(phys_addr, width);
 
 	switch (width) {
 	case 8:
@@ -473,8 +442,7 @@
 		BUG();
 	}
 
-	if (iomem)
-		iounmap(virt_addr);
+	iounmap(virt_addr);
 
 	return AE_OK;
 }
