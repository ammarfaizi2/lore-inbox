Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWARARM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWARARM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWARARM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:17:12 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:1228 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932241AbWARARL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:17:11 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Date: Tue, 17 Jan 2006 17:17:03 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060106223932.GB9230@lists.us.dell.com> <200601131724.42054.bjorn.helgaas@hp.com>
In-Reply-To: <200601131724.42054.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171717.03192.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 17:24, Bjorn Helgaas wrote:
> ... the
> DMI stuff crashes HP sx2000 (and probably sx1000) boxes, probably
> because of some memory attribute problem.  So I'll have more
> feedback after I debug that ;-)

It *is* a memory attribute problem.  The current code always calls
ioremap() on efi.smbios.  The first problem is that this is a
physical address on x86, but a virtual address on ia64.

The second problem is that we don't check the supported attributes
for the SMBIOS table.  On HP sx1000/sx2000, these tables are in system
memory, which doesn't support uncacheable access, so ioremap() does
the wrong thing.

The patch below addresses both problems (but I can't test the x86 EFI
change).  I don't really like it, because the memory attribute checking
is not complete (it only checks the first page, not the whole range),
and there's already very similar code in acpi_os_map_memory(),
acpi_os_read_memory(), acpi_os_write_memory(), and efi_range_is_wc().

But it's a start, and maybe the consolidation could be done later.

Index: work-mm3/arch/i386/kernel/dmi_scan.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/dmi_scan.c	2006-01-17 15:18:42.000000000 -0700
+++ work-mm3/arch/i386/kernel/dmi_scan.c	2006-01-17 16:58:11.000000000 -0700
@@ -39,9 +39,18 @@
 			    void (*decode)(struct dmi_header *))
 {
 	u8 *buf, *data;
-	int i = 0;
+	int iomem = 1, i = 0;
 		
-	buf = dmi_ioremap(base, len);
+	if (efi_enabled) {
+		if (efi_mem_attributes(base & EFI_MEMORY_WB)) {
+			iomem = 0;
+			buf = (u8 *) phys_to_virt(base);
+		} else if (efi_mem_attributes(base & EFI_MEMORY_UC))
+			buf = dmi_ioremap(base, len);
+		else
+			buf = NULL;
+	} else
+		buf = dmi_ioremap(base, len);
 	if (buf == NULL)
 		return -1;
 
@@ -66,7 +75,8 @@
 		data += 2;
 		i++;
 	}
-	dmi_iounmap(buf, len);
+	if (iomem)
+		dmi_iounmap(buf, len);
 	return 0;
 }
 
@@ -216,19 +226,30 @@
 	int rc;
 
 	if (efi_enabled) {
-		if (!efi.smbios)
+		unsigned long phys_addr = __pa(efi.smbios);
+		int iomem = 0;
+
+		if (!phys_addr)
 			goto out;
 
                /* This is called as a core_initcall() because it isn't
                 * needed during early boot.  This also means we can
                 * iounmap the space when we're done with it.
 		*/
-		p = ioremap((unsigned long)efi.smbios, 0x10000);
+		if (efi_mem_attributes(phys_addr & EFI_MEMORY_WB))
+			p = (char *) phys_to_virt(phys_addr);
+		else if (efi_mem_attributes(phys_addr & EFI_MEMORY_UC)) {
+			iomem = 1;
+			p = ioremap(phys_addr, 0x10000);
+		} else
+			p = NULL;
+
 		if (p == NULL)
 			goto out;
 
 		rc = dmi_present(p + 0x10); /* offset of _DMI_ string */
-		iounmap(p);
+		if (iomem)
+			iounmap(p);
 		if (!rc)
 			return;
 	}
Index: work-mm3/arch/i386/kernel/efi.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/efi.c	2005-10-27 18:02:08.000000000 -0600
+++ work-mm3/arch/i386/kernel/efi.c	2006-01-17 17:10:20.000000000 -0700
@@ -391,7 +391,7 @@
 			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
-			efi.smbios = (void *) config_tables[i].table;
+			efi.smbios = __va(config_tables[i].table);
 			printk(KERN_INFO " SMBIOS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
