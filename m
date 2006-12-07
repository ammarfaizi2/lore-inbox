Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032272AbWLGOuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032272AbWLGOuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032274AbWLGOuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:50:54 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1299 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032272AbWLGOux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:50:53 -0500
Date: Thu, 7 Dec 2006 15:50:52 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] PCI MMConfig: Only map what's necessary.
Message-ID: <20061207145052.GC45089@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061207143603.GA41804@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207143603.GA41804@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86-64 mmconfig code always map a range of MMCONFIG_APER_MAX
bytes, i.e. 256MB, whatever the number of accessible busses is.  Fix
it, and add the end of the zone in the printk while we're at it.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
---
 arch/x86_64/pci/mmconfig.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index b270f20..091f759 100644
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
 #define MAX_CHECK_BUS 16
@@ -145,16 +141,17 @@ int __init pci_mmcfg_arch_init(void)
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
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x-%x\n", pci_mmcfg_config[i].base_address, pci_mmcfg_config[i].base_address + size - 1);
 	}
 
 	raw_pci_ops = &pci_mmcfg;
-- 
1.4.4.1.g278f

