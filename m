Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUIPMyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUIPMyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUIPMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:54:11 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28364 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267993AbUIPMwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:52:18 -0400
Date: Thu, 16 Sep 2004 21:54:14 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] add hook for PCI resource deallocation
To: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
Message-id: <41498CF6.9000808@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds a hook 'pcibios_disable_device()' into
pci_disable_device() to call architecture specific PCI resource
deallocation code. It's a opposite part of pcibios_enable_device().
We need this hook to deallocate architecture specific PCI resource
such as IRQ resource, etc.. This patch is just for adding the hook,
so pcibios_disable_device() is defined as a null function on all
architecture so far.

I tested this patch on i386, x86_64 and ia64. But it has not been
tested on other architectures because I don't have these machines.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.9-rc2-kanesige/arch/alpha/kernel/pci.c            |    5 +++++
 linux-2.6.9-rc2-kanesige/arch/arm/kernel/bios32.c           |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/i386/pci/common.c             |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/ia64/pci/pci.c                |    5 +++++
 linux-2.6.9-rc2-kanesige/arch/m68knommu/kernel/comempci.c   |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/mips/pci/pci.c                |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/mips/pmc-sierra/yosemite/ht.c |    5 +++++
 linux-2.6.9-rc2-kanesige/arch/parisc/kernel/pci.c           |    6 ++++++
 linux-2.6.9-rc2-kanesige/arch/ppc/kernel/pci.c              |    5 +++++
 linux-2.6.9-rc2-kanesige/arch/ppc64/kernel/pci.c            |    5 +++++
 linux-2.6.9-rc2-kanesige/arch/sh/boards/overdrive/galileo.c |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/sh/drivers/pci/pci.c          |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/sh64/kernel/pcibios.c         |    5 +++++
 linux-2.6.9-rc2-kanesige/arch/sparc/kernel/pcic.c           |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/sparc64/kernel/pci.c          |    4 ++++
 linux-2.6.9-rc2-kanesige/arch/v850/kernel/rte_mb_a_pci.c    |    6 ++++++
 linux-2.6.9-rc2-kanesige/drivers/pci/pci.c                  |    2 ++
 linux-2.6.9-rc2-kanesige/include/linux/pci.h                |    1 +
 18 files changed, 77 insertions(+)

diff -puN arch/alpha/kernel/pci.c~IRQ_deallocation_pci arch/alpha/kernel/pci.c
--- linux-2.6.9-rc2/arch/alpha/kernel/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.296954429 +0900
+++ linux-2.6.9-rc2-kanesige/arch/alpha/kernel/pci.c	2004-09-16 15:58:27.338946945 +0900
@@ -384,6 +384,11 @@ pcibios_enable_device(struct pci_dev *de
 	return 0;
 }
 
+void
+pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain firmware forgets to set it properly, as seen
diff -puN arch/arm/kernel/bios32.c~IRQ_deallocation_pci arch/arm/kernel/bios32.c
--- linux-2.6.9-rc2/arch/arm/kernel/bios32.c~IRQ_deallocation_pci	2004-09-16 15:58:27.299884139 +0900
+++ linux-2.6.9-rc2-kanesige/arch/arm/kernel/bios32.c	2004-09-16 15:58:27.338946945 +0900
@@ -672,6 +672,10 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
diff -puN arch/i386/pci/common.c~IRQ_deallocation_pci arch/i386/pci/common.c
--- linux-2.6.9-rc2/arch/i386/pci/common.c~IRQ_deallocation_pci	2004-09-16 15:58:27.301837280 +0900
+++ linux-2.6.9-rc2-kanesige/arch/i386/pci/common.c	2004-09-16 15:58:27.339923515 +0900
@@ -245,3 +245,7 @@ int pcibios_enable_device(struct pci_dev
 
 	return pcibios_enable_irq(dev);
 }
+
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
diff -puN arch/ia64/pci/pci.c~IRQ_deallocation_pci arch/ia64/pci/pci.c
--- linux-2.6.9-rc2/arch/ia64/pci/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.304766990 +0900
+++ linux-2.6.9-rc2-kanesige/arch/ia64/pci/pci.c	2004-09-16 15:58:27.340900085 +0900
@@ -427,6 +427,11 @@ pcibios_enable_device (struct pci_dev *d
 }
 
 void
+pcibios_disable_device (struct pci_dev *dev)
+{
+}
+
+void
 pcibios_align_resource (void *data, struct resource *res,
 		        unsigned long size, unsigned long align)
 {
diff -puN arch/m68knommu/kernel/comempci.c~IRQ_deallocation_pci arch/m68knommu/kernel/comempci.c
--- linux-2.6.9-rc2/arch/m68knommu/kernel/comempci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.306720130 +0900
+++ linux-2.6.9-rc2-kanesige/arch/m68knommu/kernel/comempci.c	2004-09-16 15:58:27.341876655 +0900
@@ -373,6 +373,10 @@ int pcibios_enable_device(struct pci_dev
 	return(0);
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 /*****************************************************************************/
 
 void pcibios_update_resource(struct pci_dev *dev, struct resource *root, struct resource *r, int resource)
diff -puN arch/mips/pci/pci.c~IRQ_deallocation_pci arch/mips/pci/pci.c
--- linux-2.6.9-rc2/arch/mips/pci/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.308673271 +0900
+++ linux-2.6.9-rc2-kanesige/arch/mips/pci/pci.c	2004-09-16 15:58:27.341876655 +0900
@@ -226,6 +226,10 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 static void __init pcibios_fixup_device_resources(struct pci_dev *dev,
 	struct pci_bus *bus)
 {
diff -puN arch/mips/pmc-sierra/yosemite/ht.c~IRQ_deallocation_pci arch/mips/pmc-sierra/yosemite/ht.c
--- linux-2.6.9-rc2/arch/mips/pmc-sierra/yosemite/ht.c~IRQ_deallocation_pci	2004-09-16 15:58:27.311602981 +0900
+++ linux-2.6.9-rc2-kanesige/arch/mips/pmc-sierra/yosemite/ht.c	2004-09-16 15:58:27.342853226 +0900
@@ -348,6 +348,11 @@ int pcibios_enable_device(struct pci_dev
 }
 
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
+
 
 void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
                              struct resource *res, int resource)
diff -puN arch/parisc/kernel/pci.c~IRQ_deallocation_pci arch/parisc/kernel/pci.c
--- linux-2.6.9-rc2/arch/parisc/kernel/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.313556121 +0900
+++ linux-2.6.9-rc2-kanesige/arch/parisc/kernel/pci.c	2004-09-16 15:58:27.343829796 +0900
@@ -331,6 +331,12 @@ int pcibios_enable_device(struct pci_dev
 }
 
 
+void
+pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
+
 /* PA-RISC specific */
 void pcibios_register_hba(struct pci_hba_data *hba)
 {
diff -puN arch/ppc64/kernel/pci.c~IRQ_deallocation_pci arch/ppc64/kernel/pci.c
--- linux-2.6.9-rc2/arch/ppc64/kernel/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.315509262 +0900
+++ linux-2.6.9-rc2-kanesige/arch/ppc64/kernel/pci.c	2004-09-16 15:58:27.343829796 +0900
@@ -348,6 +348,11 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void
+pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 /*
  * Return the domain number for this bus.
  */
diff -puN arch/ppc/kernel/pci.c~IRQ_deallocation_pci arch/ppc/kernel/pci.c
--- linux-2.6.9-rc2/arch/ppc/kernel/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.318438972 +0900
+++ linux-2.6.9-rc2-kanesige/arch/ppc/kernel/pci.c	2004-09-16 15:58:27.344806366 +0900
@@ -1430,6 +1430,11 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void
+pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 struct pci_controller*
 pci_bus_to_hose(int bus)
 {
diff -puN arch/sh64/kernel/pcibios.c~IRQ_deallocation_pci arch/sh64/kernel/pcibios.c
--- linux-2.6.9-rc2/arch/sh64/kernel/pcibios.c~IRQ_deallocation_pci	2004-09-16 15:58:27.320392112 +0900
+++ linux-2.6.9-rc2-kanesige/arch/sh64/kernel/pcibios.c	2004-09-16 15:58:27.345782936 +0900
@@ -142,6 +142,11 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void
+pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 /*
  *  If we set up a device for bus mastering, we need to check and set
  *  the latency timer as it may not be properly set.
diff -puN arch/sh/boards/overdrive/galileo.c~IRQ_deallocation_pci arch/sh/boards/overdrive/galileo.c
--- linux-2.6.9-rc2/arch/sh/boards/overdrive/galileo.c~IRQ_deallocation_pci	2004-09-16 15:58:27.322345253 +0900
+++ linux-2.6.9-rc2-kanesige/arch/sh/boards/overdrive/galileo.c	2004-09-16 15:58:27.346759506 +0900
@@ -529,6 +529,10 @@ int pcibios_enable_device(struct pci_dev
 
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 /* We should do some optimisation work here I think. Ok for now though */
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
diff -puN arch/sh/drivers/pci/pci.c~IRQ_deallocation_pci arch/sh/drivers/pci/pci.c
--- linux-2.6.9-rc2/arch/sh/drivers/pci/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.324298393 +0900
+++ linux-2.6.9-rc2-kanesige/arch/sh/drivers/pci/pci.c	2004-09-16 15:58:27.346759506 +0900
@@ -127,6 +127,10 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 /*
  *  If we set up a device for bus mastering, we need to check and set
  *  the latency timer as it may not be properly set.
diff -puN arch/sparc64/kernel/pci.c~IRQ_deallocation_pci arch/sparc64/kernel/pci.c
--- linux-2.6.9-rc2/arch/sparc64/kernel/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.327228103 +0900
+++ linux-2.6.9-rc2-kanesige/arch/sparc64/kernel/pci.c	2004-09-16 15:58:27.347736076 +0900
@@ -502,6 +502,10 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void pcibios_disable_device(struct pci_dev *pdev)
+{
+}
+
 void pcibios_resource_to_bus(struct pci_dev *pdev, struct pci_bus_region *region,
 			     struct resource *res)
 {
diff -puN arch/sparc/kernel/pcic.c~IRQ_deallocation_pci arch/sparc/kernel/pcic.c
--- linux-2.6.9-rc2/arch/sparc/kernel/pcic.c~IRQ_deallocation_pci	2004-09-16 15:58:27.329181244 +0900
+++ linux-2.6.9-rc2-kanesige/arch/sparc/kernel/pcic.c	2004-09-16 15:58:27.348712646 +0900
@@ -871,6 +871,10 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
+void pcibios_disable_device(struct pci_dev *pdev)
+{
+}
+
 /*
  * NMI
  */
diff -puN arch/v850/kernel/rte_mb_a_pci.c~IRQ_deallocation_pci arch/v850/kernel/rte_mb_a_pci.c
--- linux-2.6.9-rc2/arch/v850/kernel/rte_mb_a_pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.331134384 +0900
+++ linux-2.6.9-rc2-kanesige/arch/v850/kernel/rte_mb_a_pci.c	2004-09-16 15:58:27.349689217 +0900
@@ -247,6 +247,12 @@ int __nomods_init pcibios_enable_device 
 	return 0;
 }
 
+
+void
+pcibios_disable_device(struct pci_dev *dev)
+{
+}
+
 
 /* Resource allocation.  */
 static void __devinit pcibios_assign_resources (void)
diff -puN drivers/pci/pci.c~IRQ_deallocation_pci drivers/pci/pci.c
--- linux-2.6.9-rc2/drivers/pci/pci.c~IRQ_deallocation_pci	2004-09-16 15:58:27.333087524 +0900
+++ linux-2.6.9-rc2-kanesige/drivers/pci/pci.c	2004-09-16 15:58:27.349689217 +0900
@@ -406,6 +406,8 @@ pci_disable_device(struct pci_dev *dev)
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+
+	pcibios_disable_device(dev);
 }
 
 /**
diff -puN include/linux/pci.h~IRQ_deallocation_pci include/linux/pci.h
--- linux-2.6.9-rc2/include/linux/pci.h~IRQ_deallocation_pci	2004-09-16 15:58:27.336017235 +0900
+++ linux-2.6.9-rc2-kanesige/include/linux/pci.h	2004-09-16 15:58:27.350665787 +0900
@@ -686,6 +686,7 @@ extern struct list_head pci_devices;	/* 
 
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
+void pcibios_disable_device(struct pci_dev *);
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */

_


