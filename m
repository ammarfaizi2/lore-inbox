Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753309AbWKGUuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbWKGUuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbWKGUuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:50:10 -0500
Received: from smtp-out.google.com ([216.239.33.17]:55233 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753309AbWKGUuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:50:08 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=VCqowS8U9cvYb7rOdbf0MMT2Yo8l1mxoFbq77+z4X6z8/0i8IGXgXQ14SRnTBf6Lx
	k+lwWBSLuKx3l9OQUFrsQ==
Message-ID: <8f95bb250611071249i6cf92b98p99d4b08275de6656@mail.gmail.com>
Date: Tue, 7 Nov 2006 12:49:53 -0800
From: "Aaron Durbin" <adurbin@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: [PATCH] Update MMCONFIG resource insertion to check against e820 map.
Cc: linux-kernel@vger.kernel.org, "Matthew Wilcox" <matthew@wil.cx>,
       "Jeff Chua" <jeff.chua.linux@gmail.com>, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check to see if MMCONFIG region is marked as reserved in the e820 map before
inserting the MMCONFIG region into the resource map. If the region is not
entirely marked as reserved in the e820 map attempt to find a region that is.
Only insert the MMCONFIG region into the resource map if there was a region
found marked as reserved in the e820 map.  This should fix a known regression
in 2.6.19 by not reserving all of the I/O space on misconfigured systems.

---

This patch is against 2.6.19-rc4.

 arch/x86_64/pci/mmconfig.c |   76 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index e61093b..c39ec4d 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -163,33 +163,87 @@ static __init void unreachable_devices(v
 	}
 }

+#define PCI_MMCFG_RESOURCE_NAME_LEN 19
+/* Check the given mcfg_entry to see if its reported address range is marked
+ * as reserved in the e820 map. If it is not entirely marked as reserved it
+ * attempts to find a given bus range that is marked as reserved. If no range
+ * is determined, do not insert the MCFG resource into the resource map. */
+static __init void pci_mmcfg_check_and_insert_resource(int mcfg_entry,
+						      struct resource *res)
+{
+	struct acpi_table_mcfg_config *mcfg;
+	unsigned start_bus_num, end_bus_num;
+	unsigned num_buses;
+
+	mcfg = &pci_mmcfg_config[mcfg_entry];
+
+	start_bus_num = mcfg->start_bus_number;
+	end_bus_num = mcfg->end_bus_number;
+
+	if (end_bus_num < start_bus_num) {
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG region %u has "
+				"misconfigured bus entries [%u,%u].\n",
+				mcfg_entry, mcfg->start_bus_number,
+				mcfg->end_bus_number);
+		return;
+	}
+
+	while (end_bus_num >= start_bus_num) {
+		num_buses = end_bus_num - start_bus_num + 1;
+		if (e820_all_mapped(mcfg->base_address,
+				mcfg->base_address + (num_buses << 20) -1,
+				E820_RESERVED))
+			break;
+		end_bus_num--;
+	}
+
+	if (mcfg->end_bus_number != end_bus_num) {
+		unsigned long end_addr;
+		unsigned long start_addr;
+		start_addr = mcfg->base_address;
+		num_buses = mcfg->end_bus_number - mcfg->start_bus_number + 1;
+		end_addr =  mcfg->base_address + (num_buses << 20) - 1;
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG region %u not entirely "
+				"marked as e280-reserved (%016lx-%016lx).\n",
+			mcfg_entry, start_addr, end_addr);
+	}
+
+	/* If we could not find a region reserved in the e820 then we should
+	 * not reserve the resource. We will hope for the best that there
+	 * are no collisions. */
+	if (end_bus_num < start_bus_num)
+		return;
+
+	/* Fixup the resource limits for allocation without affecting the
+	 * reported bus number limits in the MCFG table. */
+	num_buses = end_bus_num - start_bus_num + 1;
+	res->start = mcfg->base_address;
+	res->end = res->start + (num_buses << 20) - 1;
+
+	snprintf((char *)res->name, PCI_MMCFG_RESOURCE_NAME_LEN,
+		 "PCI MMCONFIG %u", mcfg->pci_segment_group_number);
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	insert_resource(&iomem_resource, res);
+}
+
 static __init void pci_mmcfg_insert_resources(void)
 {
-#define PCI_MMCFG_RESOURCE_NAME_LEN 19
 	int i;
 	struct resource *res;
 	char *names;
-	unsigned num_buses;

 	res = kcalloc(PCI_MMCFG_RESOURCE_NAME_LEN + sizeof(*res),
 			pci_mmcfg_config_num, GFP_KERNEL);

 	if (!res) {
-		printk(KERN_ERR "PCI: Unable to allocate MMCONFIG resources\n");
+		printk(KERN_ERR "PCI: Unable to allocate MMCONFIG resources.\n");
 		return;
 	}

 	names = (void *)&res[pci_mmcfg_config_num];
 	for (i = 0; i < pci_mmcfg_config_num; i++, res++) {
-		num_buses = pci_mmcfg_config[i].end_bus_number -
-		    pci_mmcfg_config[i].start_bus_number + 1;
 		res->name = names;
-		snprintf(names, PCI_MMCFG_RESOURCE_NAME_LEN, "PCI MMCONFIG %u",
-			pci_mmcfg_config[i].pci_segment_group_number);
-		res->start = pci_mmcfg_config[i].base_address;
-		res->end = res->start + (num_buses << 20) - 1;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		insert_resource(&iomem_resource, res);
+		pci_mmcfg_check_and_insert_resource(i, res);
 		names += PCI_MMCFG_RESOURCE_NAME_LEN;
 	}
 }
-- 
1.4.2.1.g4daf
