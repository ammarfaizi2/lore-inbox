Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbUKMCdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUKMCdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 21:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbUKLXXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:23:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:41955 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262689AbUKLXWo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:44 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017173174@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <11003017172508@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.18, 2004/11/10 16:43:46-08:00, tlnguyen@snoqualmie.dp.intel.com

[PATCH] PCI: pci-mmconfig fix

Here I have attached pci mmconfig fix for 2.6.9 kernel.

This will fix the flush error in pci_mmcfg_write.

When pci_mmcfg_write is used to program the PMCSR in the Power
Management Capability structure of PCI config space in the PCI Express
device to a different power state, the dummy readl to flush the previous
write violates the transition delay specified in the PCI power
management spec. Please see PCI Power Management Spec. 1.2 Table 5-6.
For example, while changing the power state of the device through PMCSR
register, a transition delay of 10msec is required before any access can
be made to the device.

Since the configuration write access for PCI Express is non posted,
flushing is not necessary and  it will be safe to remove the dummy
readl.

This patch will remove dummy readl function implemented in
"pci_mmcfg_write" and use set_fixmap_nocahe instead of set_fixmap.

Signed-off-by: Sundarapandian Durairaj <sundarapandian.duraijai@intel.com>
Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/mmconfig.c   |    5 +----
 arch/x86_64/pci/mmconfig.c |    3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)


diff -Nru a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
--- a/arch/i386/pci/mmconfig.c	2004-11-12 15:12:43 -08:00
+++ b/arch/i386/pci/mmconfig.c	2004-11-12 15:12:43 -08:00
@@ -30,7 +30,7 @@
 	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
-		set_fixmap(FIX_PCIE_MCFG, dev_base);
+		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
 	}
 }
 
@@ -84,9 +84,6 @@
 		writel(value, mmcfg_virt_addr + reg);
 		break;
 	}
-
-	/* Dummy read to flush PCI write */
-	readl(mmcfg_virt_addr);
 
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
diff -Nru a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
--- a/arch/x86_64/pci/mmconfig.c	2004-11-12 15:12:43 -08:00
+++ b/arch/x86_64/pci/mmconfig.c	2004-11-12 15:12:43 -08:00
@@ -63,9 +63,6 @@
 		break;
 	}
 
-	/* Dummy read to flush PCI write */
-	readl(addr);
-
 	return 0;
 }
 

