Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUIXFsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUIXFsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUIXFro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:47:44 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:13011 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268306AbUIXFnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:43:50 -0400
Date: Fri, 24 Sep 2004 14:45:35 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] Updated patches for PCI IRQ resource deallocation support [1/3]
To: greg@kroah.com, len.brown@intel.com, tony.luck@intel.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Message-id: <4153B47F.8090105@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for PCI code that has no dependencies.
Greg, please apply.

----
Name:		add_pcibios_disable_device_hook.patch
Kernel Version:	2.6.9-rc2-mm1
Depends:	none.
Description:

This patch adds a hook 'pcibios_disable_device()' into
pci_disable_device() to call architecture specific PCI resource
deallocation code. It's a opposite part of pcibios_enable_device().
We need this hook to deallocate architecture specific PCI resource
such as IRQ resource, etc.. This patch is just for adding the hook, so
'pcibios_disable_device()' is defined as a null function on all
architecture so far.

I tested this patch on i386, x86_64 and ia64. But it has not been
tested on other architectures because I don't have these machines.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.9-rc2-mm1-kanesige/arch/alpha/kernel/pci.c            |    5 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/arm/kernel/bios32.c           |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/i386/pci/common.c             |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/pci/pci.c                |    5 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/m68knommu/kernel/comempci.c   |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/mips/pci/pci.c                |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/mips/pmc-sierra/yosemite/ht.c |    5 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/parisc/kernel/pci.c           |    6 ++++++
 linux-2.6.9-rc2-mm1-kanesige/arch/ppc/kernel/pci.c              |    5 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/ppc64/kernel/pci.c            |    5 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/sh/boards/overdrive/galileo.c |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/sh/drivers/pci/pci.c          |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/sh64/kernel/pcibios.c         |    5 +++++
 linux-2.6.9-rc2-mm1-kanesige/arch/sparc/kernel/pcic.c           |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/sparc64/kernel/pci.c          |    4 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/v850/kernel/rte_mb_a_pci.c    |    6 ++++++
 linux-2.6.9-rc2-mm1-kanesige/drivers/pci/pci.c                  |    2 ++
 linux-2.6.9-rc2-mm1-kanesige/include/linux/pci.h                |    1 +
 18 files changed, 77 insertions(+)

diff -puN arch/alpha/kernel/pci.c~IRQ_deallocation_pci arch/alpha/kernel/pci.c
--- linux-2.6.9-rc2-mm1/arch/alpha/kernel/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.539784455 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/alpha/kernel/pci.c	2004-09-22 20:29:17.715566370 +0900
@@ -381,6 +381,11 @@ pcibios_enable_device(struct pci_dev *de
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
--- linux-2.6.9-rc2-mm1/arch/arm/kernel/bios32.c~IRQ_deallocation_pci	2004-09-22 20:29:17.556386080 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/arm/kernel/bios32.c	2004-09-22 20:29:17.716542936 +0900
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
--- linux-2.6.9-rc2-mm1/arch/i386/pci/common.c~IRQ_deallocation_pci	2004-09-22 20:29:17.561268911 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/i386/pci/common.c	2004-09-22 20:29:17.717519502 +0900
@@ -249,3 +249,7 @@ int pcibios_enable_device(struct pci_dev
 
 	return pcibios_enable_irq(dev);
 }
+
+void pcibios_disable_device(struct pci_dev *dev)
+{
+}
diff -puN arch/ia64/pci/pci.c~IRQ_deallocation_pci arch/ia64/pci/pci.c
--- linux-2.6.9-rc2-mm1/arch/ia64/pci/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.569081441 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/pci/pci.c	2004-09-22 20:29:17.717519502 +0900
@@ -449,6 +449,11 @@ pcibios_enable_device (struct pci_dev *d
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
--- linux-2.6.9-rc2-mm1/arch/m68knommu/kernel/comempci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.591542463 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/m68knommu/kernel/comempci.c	2004-09-22 20:29:17.718496068 +0900
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
--- linux-2.6.9-rc2-mm1/arch/mips/pci/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.601308125 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/mips/pci/pci.c	2004-09-22 20:29:17.719472634 +0900
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
--- linux-2.6.9-rc2-mm1/arch/mips/pmc-sierra/yosemite/ht.c~IRQ_deallocation_pci	2004-09-22 20:29:17.610097221 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/mips/pmc-sierra/yosemite/ht.c	2004-09-22 20:29:17.719472634 +0900
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
--- linux-2.6.9-rc2-mm1/arch/parisc/kernel/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.613026919 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/parisc/kernel/pci.c	2004-09-22 20:29:17.720449201 +0900
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
--- linux-2.6.9-rc2-mm1/arch/ppc64/kernel/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.614980052 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ppc64/kernel/pci.c	2004-09-22 20:29:17.720449201 +0900
@@ -345,6 +345,11 @@ int pcibios_enable_device(struct pci_dev
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
--- linux-2.6.9-rc2-mm1/arch/ppc/kernel/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.638417640 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ppc/kernel/pci.c	2004-09-22 20:29:17.722402333 +0900
@@ -1420,6 +1420,11 @@ int pcibios_enable_device(struct pci_dev
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
--- linux-2.6.9-rc2-mm1/arch/sh64/kernel/pcibios.c~IRQ_deallocation_pci	2004-09-22 20:29:17.641347339 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/sh64/kernel/pcibios.c	2004-09-22 20:29:17.722402333 +0900
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
--- linux-2.6.9-rc2-mm1/arch/sh/boards/overdrive/galileo.c~IRQ_deallocation_pci	2004-09-22 20:29:17.643300471 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/sh/boards/overdrive/galileo.c	2004-09-22 20:29:17.723378899 +0900
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
--- linux-2.6.9-rc2-mm1/arch/sh/drivers/pci/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.655995832 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/sh/drivers/pci/pci.c	2004-09-22 20:29:17.723378899 +0900
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
--- linux-2.6.9-rc2-mm1/arch/sparc64/kernel/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.675527156 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/sparc64/kernel/pci.c	2004-09-22 20:29:17.724355465 +0900
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
--- linux-2.6.9-rc2-mm1/arch/sparc/kernel/pcic.c~IRQ_deallocation_pci	2004-09-22 20:29:17.687245950 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/sparc/kernel/pcic.c	2004-09-22 20:29:17.725332032 +0900
@@ -869,6 +869,10 @@ int pcibios_enable_device(struct pci_dev
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
--- linux-2.6.9-rc2-mm1/arch/v850/kernel/rte_mb_a_pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.689199082 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/v850/kernel/rte_mb_a_pci.c	2004-09-22 20:29:17.726308598 +0900
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
--- linux-2.6.9-rc2-mm1/drivers/pci/pci.c~IRQ_deallocation_pci	2004-09-22 20:29:17.700917877 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/drivers/pci/pci.c	2004-09-22 20:29:17.726308598 +0900
@@ -411,6 +411,8 @@ pci_disable_device(struct pci_dev *dev)
 		pci_command &= ~PCI_COMMAND_MASTER;
 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
+
+	pcibios_disable_device(dev);
 }
 
 /**
diff -puN include/linux/pci.h~IRQ_deallocation_pci include/linux/pci.h
--- linux-2.6.9-rc2-mm1/include/linux/pci.h~IRQ_deallocation_pci	2004-09-22 20:29:17.712636671 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/include/linux/pci.h	2004-09-22 20:29:17.727285164 +0900
@@ -687,6 +687,7 @@ extern struct list_head pci_devices;	/* 
 
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
+void pcibios_disable_device(struct pci_dev *);
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */

_

