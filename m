Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVFOFdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVFOFdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFOFdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:33:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:6824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261496AbVFOFda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:33:30 -0400
Date: Tue, 14 Jun 2005 22:33:16 -0700
From: Greg KH <gregkh@suse.de>
To: len.brown@intel.com, ak@suse.de
Cc: acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [PATCH 04/04] PCI: let AMD boxes use MMCONFIG
Message-ID: <20050615053316.GE23394@kroah.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615053214.GD23394@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that we parse and handle the MCFG table properly, we can hopefully
remove the AMD check and let those boxes use MMCONFIG.

Note, this needs _lots_ of testing on lots of boxes before going to
mainline...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/i386/pci/mmconfig.c   |    7 -------
 arch/x86_64/pci/mmconfig.c |    7 -------
 2 files changed, 14 deletions(-)

--- gregkh-2.6.orig/arch/i386/pci/mmconfig.c	2005-06-14 22:07:52.000000000 -0700
+++ gregkh-2.6/arch/i386/pci/mmconfig.c	2005-06-14 22:09:16.000000000 -0700
@@ -127,13 +127,6 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		goto out;
 
-	/* Kludge for now. Don't use mmconfig on AMD systems because
-	   those have some busses where mmconfig doesn't work,
-	   and we don't parse ACPI MCFG well enough to handle that. 
-	   Remove when proper handling is added. */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		goto out; 
-
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
--- gregkh-2.6.orig/arch/x86_64/pci/mmconfig.c	2005-06-14 22:08:44.000000000 -0700
+++ gregkh-2.6/arch/x86_64/pci/mmconfig.c	2005-06-14 22:09:11.000000000 -0700
@@ -111,13 +111,6 @@
 	    (pci_mmcfg_config[0].base_address == 0))
 		return 0;
 
-	/* Kludge for now. Don't use mmconfig on AMD systems because
-	   those have some busses where mmconfig doesn't work,
-	   and we don't parse ACPI MCFG well enough to handle that. 
-	   Remove when proper handling is added. */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		return 0; 
-
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {
