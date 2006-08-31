Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWHaWtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWHaWtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHaWtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:49:25 -0400
Received: from smtp-out.google.com ([216.239.45.12]:52061 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932473AbWHaWtY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:49:24 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:
	content-type:content-disposition:user-agent;
	b=tRREh0noVj7NdpRXGyoqAkmyn5fQScepXbIInziQekmoeMbNLRhvhvuxRUuSyzLe/
	3ZROmSkCOOsDI0kZRX5fA==
Date: Thu, 31 Aug 2006 15:49:13 -0700
From: adurbin@google.com
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [PATCH] x86_64: add mmconfig to resource tree
Message-ID: <20060831224913.GA19882@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch addes the PCI memory mapped config region(s) to be visible in
/proc/iomem.  This will allow for more visibility into the physical memory
map without having to parse the dmesg output.

Signed-off-by: Aaron Durbin <adurbin@google.com>

---

diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index 3c55c76..f95af08 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -9,6 +9,7 @@ #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/ioport.h>
 #include <asm/e820.h>
 
 #include "pci.h"
@@ -164,6 +165,37 @@ static __init void unreachable_devices(v
 	}
 }
 
+static __init void pci_mmcfg_insert_resources(void)
+{
+#define PCI_MMCFG_RESOURCE_NAME_LEN 19
+	int i;
+	struct resource *res;
+	char *names;
+	unsigned n;
+
+	n = (PCI_MMCFG_RESOURCE_NAME_LEN + sizeof(*res));
+	n *= pci_mmcfg_config_num;
+
+	res = kcalloc(1, n, GFP_KERNEL);
+
+	if (!res)
+		return;
+
+	names = (void *)&res[pci_mmcfg_config_num];
+	for (i = 0; i < pci_mmcfg_config_num; i++, res++) {
+		n = pci_mmcfg_config[i].end_bus_number - 
+		    pci_mmcfg_config[i].start_bus_number + 1;
+		res->name = names;
+		snprintf(names, PCI_MMCFG_RESOURCE_NAME_LEN, "PCI MMCONFIG %u",
+			pci_mmcfg_config[i].pci_segment_group_number);
+		res->start = pci_mmcfg_config[i].base_address;
+		res->end = res->start + (n << 20) - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		insert_resource(&iomem_resource, res);
+		names += PCI_MMCFG_RESOURCE_NAME_LEN;
+	}
+}
+
 void __init pci_mmcfg_init(void)
 {
 	int i;
@@ -205,6 +237,7 @@ void __init pci_mmcfg_init(void)
 	}
 
 	unreachable_devices();
+	pci_mmcfg_insert_resources();
 
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
