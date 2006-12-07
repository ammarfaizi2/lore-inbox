Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163185AbWLGSaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163185AbWLGSaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163187AbWLGSaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:30:15 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1076 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163185AbWLGSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:30:12 -0500
Date: Thu, 7 Dec 2006 19:30:11 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>
Subject: [PATCH 3/5] PCI MMConfig: Only map what's necessary.
Message-ID: <20061207183011.GC73583@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Muli Ben-Yehuda <muli@il.ibm.com>
References: <20061207181726.GA69863@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207181726.GA69863@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86-64 mmconfig code always map a range of MMCONFIG_APER_MAX
bytes, i.e. 256MB, whatever the number of accessible busses is.  Fix
it, and add the end of the zone in the printk while we're at it.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
---
 arch/x86_64/pci/mmconfig.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index c71c181..3d13220 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -13,10 +13,6 @@
 
 #include "pci.h"
 
-/* aperture is up to 256MB but BIOS may reserve less */
-#define MMCONFIG_APER_MIN	(2 * 1024*1024)
-#define MMCONFIG_APER_MAX	(256 * 1024*1024)
-
 /* Verify the first 16 busses. We assume that systems with more busses
    get MCFG right. */
 #define PCI_MMCFG_MAX_CHECK_BUS 16
@@ -143,17 +139,19 @@ int __init pci_mmcfg_arch_init(void)
 	}
 
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
+		u32 size = (pci_mmcfg_config[0].end_bus_number - pci_mmcfg_config[0].start_bus_number + 1) << 20;
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
 		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
-							 MMCONFIG_APER_MAX);
+							 size);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for "
 					"segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
 			return 0;
 		}
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n",
-		       pci_mmcfg_config[i].base_address);
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x-%x\n",
+		       pci_mmcfg_config[i].base_address,
+		       pci_mmcfg_config[i].base_address + size - 1);
 	}
 
 	raw_pci_ops = &pci_mmcfg;
-- 
1.4.4.1.g278f

