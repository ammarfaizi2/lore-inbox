Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWGPMJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWGPMJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 08:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWGPMJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 08:09:28 -0400
Received: from www17.your-server.de ([213.133.104.17]:33285 "EHLO
	www17.your-server.de") by vger.kernel.org with ESMTP
	id S1751024AbWGPMJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 08:09:27 -0400
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
From: Thomas Meyer <thomas@m3y3r.de>
To: linux-kernel@vger.kernel.org
Cc: gimli@dark-green.com
Content-Type: text/plain
Date: Sun, 16 Jul 2006 14:09:11 +0200
Message-Id: <1153051752.12981.0.camel@hotzenplotz.treehouse>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

For the record. Feedback is welcome. But i guess we stick with Edgars
solution.

PS: Where do i get the PCI firmware specification for free?

My idea was that the EFI memory map doesn't explicitly reserve all not
used memory, because the PCI MCFG memory area isn't listed in the EFI
memory map. but this seems to be a bug?!


diff --git a/arch/i386/kernel/efi.c b/arch/i386/kernel/efi.c
index fe15804..4a81f35 100644
--- a/arch/i386/kernel/efi.c
+++ b/arch/i386/kernel/efi.c
@@ -39,7 +39,7 @@ #include <asm/processor.h>
 #include <asm/desc.h>
 #include <asm/tlbflush.h>

-#define EFI_DEBUG      0
+#define EFI_DEBUG      1
 #define PFX            "EFI: "

 extern efi_status_t asmlinkage efi_call_phys(void *, ...);
@@ -649,3 +649,27 @@ u64 efi_mem_attributes(unsigned long phy
        }
        return 0;
 }
+
+int efi_is_free(unsigned long s, unsigned long e)
+{
+
+       int i;
+       efi_memory_desc_t *md;
+       void *p;
+
+       for (p = memmap.map, i = 0; p < memmap.map_end; p +=
memmap.desc_size, i++) {
+               md = p;
+               /* is the region (part) in overlap with the current
region ?*/
+               if (md->phys_addr >= e || md->phys_addr + (md->num_pages
<< EFI_PAGE_SHIFT) <= s) {
+                       continue;
+               } else {
+                       if (md->type == EFI_MEMORY_MAPPED_IO) {
+                               printk("EFI: memmap entry: %i is already
mapped!\n", i);
+                       } else {
+                               printk("EFI: MCFG blocking memmap entry:
%i\n", i);
+                               return 0;
+                       }
+               }
+       }
+       return 1;
+}
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index e545b09..bcf4665 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -13,6 +13,7 @@ #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <asm/e820.h>
+#include <linux/efi.h>
 #include "pci.h"

 /* aperture is up to 256MB but BIOS may reserve less */
@@ -198,13 +199,23 @@ void __init pci_mmcfg_init(void)
            (pci_mmcfg_config[0].base_address == 0))
                return;

-       if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-                       pci_mmcfg_config[0].base_address +
MMCONFIG_APER_MIN,
-                       E820_RESERVED)) {
-               printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not
E820-reserved\n",
-                               pci_mmcfg_config[0].base_address);
-               printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-               return;
+       if (efi_enabled) {
+               if (!efi_is_free(pci_mmcfg_config[0].base_address,
+                               pci_mmcfg_config[0].base_address +
MMCONFIG_APER_MIN)) {
+                       printk(KERN_ERR "PCI: EFI: memory region at %x
is already in use!\n",
+
pci_mmcfg_config[0].base_address);
+                       printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+                       return;
+               }
+       } else {
+               if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
+                               pci_mmcfg_config[0].base_address +
MMCONFIG_APER_MIN,
+                               E820_RESERVED)) {
+                       printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x
is not E820-reserved.\n",
+
pci_mmcfg_config[0].base_address);
+                       printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+                       return;
+               }
        }

        printk(KERN_INFO "PCI: Using MMCONFIG\n");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 66d621d..7dffbf9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -302,6 +302,7 @@ extern void efi_initialize_iomem_resourc
                                        struct resource *data_resource);
 extern unsigned long __init efi_get_time(void);
 extern int __init efi_set_rtc_mmss(unsigned long nowtime);
+extern int efi_is_free(unsigned long s, unsigned long e);
 extern struct efi_memory_map memmap;

 /**


