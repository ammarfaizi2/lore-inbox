Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVCRWIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVCRWIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVCRWII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:08:08 -0500
Received: from fmr24.intel.com ([143.183.121.16]:45719 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262083AbVCRWEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:04:51 -0500
Date: Fri, 18 Mar 2005 14:04:37 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 04/12] Prevent duplicate bus numbers when scanning PCI bridge
Message-ID: <20050318140437.D1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When hot-plugging a root bridge, as we try to assign bus numbers
we may find that the hotplugged hieratchy has more PCI to PCI
bridges (i.e. bus requirements) than available.  Make sure we
don't step over an existing bus when that happens. 

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -puN drivers/pci/probe.c~prevent_duplicate_busnr drivers/pci/probe.c
--- linux-2.6.11-mm4-iohp/drivers/pci/probe.c~prevent_duplicate_busnr	2005-03-16 13:07:10.376304290 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/probe.c	2005-03-16 13:07:10.496421476 -0800
@@ -417,7 +417,7 @@ int __devinit pci_scan_bridge(struct pci
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
-	u32 buses;
+	u32 buses, i;
 	u16 bctl;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
@@ -476,6 +476,10 @@ int __devinit pci_scan_bridge(struct pci
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
+		/* Prevent assigning a bus number that already exists.
+		 * This can happen when a bridge is hot-plugged */
+		if (pci_find_bus(pci_domain_nr(bus), max+1))
+			return max;
 		child = pci_alloc_child_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
@@ -507,7 +511,11 @@ int __devinit pci_scan_bridge(struct pci
 			 * as cards with a PCI-to-PCI bridge can be
 			 * inserted later.
 			 */
-			max += CARDBUS_RESERVE_BUSNR;
+			for (i=0; i<CARDBUS_RESERVE_BUSNR; i++)
+				if (pci_find_bus(pci_domain_nr(bus),
+							max+i+1))
+					break;
+			max += i;
 		}
 		/*
 		 * Set the subordinate bus number to its real value.
_
