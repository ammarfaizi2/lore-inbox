Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUEFJSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUEFJSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUEFJSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:18:45 -0400
Received: from palrel11.hp.com ([156.153.255.246]:10903 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261879AbUEFJSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:18:40 -0400
From: "Sourav Sen" <souravs@india.hp.com>
To: <Matt_Domsch@dell.com>, <matthew.e.tolentino@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 14:48:32 +0530
Message-ID: <003901c4334b$1a8a6de0$39624c0f@india.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending it as the last one line wrapped :-(

----------------------------------------------------
Hi,

The following simple patch creates a read-only file 
"memmap" under <mount point>/firmware/efi/ in sysfs 
and exposes the efi memory map thru it.
 
Thanks
Sourav
HP-STS, Bangalore

The patch is w.r.t 2.6.6-rc3
----------------------------
===========================================================================
--- a/drivers/firmware/efivars.c        2004-05-05 13:55:40.000000000 +0530
+++ b/drivers/firmware/efivars.c        2004-05-06 14:03:13.000000000 +0530
@@ -580,10 +580,42 @@ systab_read(struct subsystem *entry, cha
        return str - buf;
 }

+/*
+ * Expose the efi memory map as kernel keeps it. Note, it may be a little
+ * different from what gets actually passed in at loader handoff time as a
+ * call to efi_memmap_walk modifies that.
+ */
+
+static ssize_t
+efi_memmap_read(struct subsystem *entry, char * buf)
+{
+       void * efi_map_start, *efi_map_end, *p;
+       efi_memory_desc_t *md;
+       u64 efi_desc_size;
+       char * str = buf;
+
+       if (!entry || !buf)
+               return -EINVAL;
+
+       efi_map_start = __va(ia64_boot_param->efi_memmap);
+       efi_map_end   = efi_map_start + ia64_boot_param->efi_memmap_size;
+       efi_desc_size = ia64_boot_param->efi_memdesc_size;
+
+       for (p = efi_map_start; p < efi_map_end; p += efi_desc_size) {
+               md = (efi_memory_desc_t *)p;
+               str += sprintf(str, "%2u  %-#18lx  %#016lx %#016lx\n", \
+                       md->type, md->attribute, md->phys_addr, \
+                       md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT));
+       }
+       return (str - buf);
+}
+
 static EFI_ATTR(systab, 0400, systab_read, NULL);
+static EFI_ATTR(memmap, 0400, efi_memmap_read, NULL);

 static struct subsys_attribute *efi_subsys_attrs[] = {
        &efi_attr_systab,
+       &efi_attr_memmap,       /* Here comes one */
        NULL,   /* maybe more in the future? */
 }; 
