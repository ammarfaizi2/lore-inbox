Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270115AbUJSXmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270115AbUJSXmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270212AbUJSXjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:39:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:9098 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270115AbUJSWqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:32 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257333598@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <10982257332170@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.8, 2004/10/06 11:21:11-07:00, greg@kroah.com

[PATCH] PCI: remove pci_find_class() usage from arch specific files.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/alpha/kernel/console.c      |    2 +-
 arch/i386/kernel/cpu/mtrr/main.c |    8 +++++---
 arch/ppc64/kernel/pci.c          |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)


diff -Nru a/arch/alpha/kernel/console.c b/arch/alpha/kernel/console.c
--- a/arch/alpha/kernel/console.c	2004-10-19 15:27:16 -07:00
+++ b/arch/alpha/kernel/console.c	2004-10-19 15:27:16 -07:00
@@ -47,7 +47,7 @@
 
 	if (!sel_func) sel_func = (void *)default_vga_hose_select;
 
-	for(dev=NULL; (dev=pci_find_class(PCI_CLASS_DISPLAY_VGA << 8, dev));) {
+	for(dev=NULL; (dev=pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, dev));) {
 		if (!hose) hose = dev->sysdata;
 		else hose = sel_func(hose, dev->sysdata);
 	}
diff -Nru a/arch/i386/kernel/cpu/mtrr/main.c b/arch/i386/kernel/cpu/mtrr/main.c
--- a/arch/i386/kernel/cpu/mtrr/main.c	2004-10-19 15:27:16 -07:00
+++ b/arch/i386/kernel/cpu/mtrr/main.c	2004-10-19 15:27:16 -07:00
@@ -77,22 +77,24 @@
 {
 	struct pci_dev *dev;
 	
-	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
+	if ((dev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
 		/* ServerWorks LE chipsets have problems with write-combining 
 		   Don't allow it and leave room for other chipsets to be tagged */
 		if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 		    dev->device == PCI_DEVICE_ID_SERVERWORKS_LE) {
 			printk(KERN_INFO "mtrr: Serverworks LE detected. Write-combining disabled.\n");
+			pci_dev_put(dev);
 			return 0;
 		}
 		/* Intel 450NX errata # 23. Non ascending cachline evictions to
 		   write combining memory may resulting in data corruption */
 		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
-		    dev->device == PCI_DEVICE_ID_INTEL_82451NX)
-		{
+		    dev->device == PCI_DEVICE_ID_INTEL_82451NX) {
 			printk(KERN_INFO "mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
+			pci_dev_put(dev);
 			return 0;
 		}
+		pci_dev_put(dev);
 	}		
 	return (mtrr_if->have_wrcomb ? mtrr_if->have_wrcomb() : 0);
 }
diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	2004-10-19 15:27:16 -07:00
+++ b/arch/ppc64/kernel/pci.c	2004-10-19 15:27:16 -07:00
@@ -303,7 +303,7 @@
 		ppc_md.pcibios_fixup();
 
 	/* Cache the location of the ISA bridge (if we have one) */
-	ppc64_isabridge_dev = pci_find_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	ppc64_isabridge_dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
 	if (ppc64_isabridge_dev != NULL)
 		printk("ISA bridge at %s\n", pci_name(ppc64_isabridge_dev));
 

