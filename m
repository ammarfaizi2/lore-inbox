Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWECWbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWECWbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWECWbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:31:52 -0400
Received: from mga07.intel.com ([143.182.124.22]:38306 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750932AbWECWbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:31:51 -0400
X-IronPort-AV: i="4.05,85,1146466800"; 
   d="scan'208"; a="31214079:sNHT181642314"
Date: Wed, 3 May 2006 15:27:47 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, ak@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: i386/x86_84: disable PCI resource decode on device disable
Message-ID: <20060503152747.A29327@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a PCI device is disabled via pci_disable_device(), it's still
left decoding its BAR resource ranges even though its driver
will have likely released those regions (and may even have
unloaded). pci_enable_device() already explicitly enables 
BAR resource decode for the device being enabled. This patch
disables resource decode for the PCI device being disabled,
making it symmetric with the enable call.

I saw this while doing something else, not because of a
problem report. Still, seems to be the correct thing to do.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

 arch/i386/pci/common.c |    1 +
 arch/i386/pci/i386.c   |    9 +++++++++
 arch/i386/pci/pci.h    |    1 +
 3 files changed, 11 insertions(+)

Index: linux-2.6.17-rc3-git7/arch/i386/pci/common.c
===================================================================
--- linux-2.6.17-rc3-git7.orig/arch/i386/pci/common.c
+++ linux-2.6.17-rc3-git7/arch/i386/pci/common.c
@@ -288,6 +288,7 @@ int pcibios_enable_device(struct pci_dev
 
 void pcibios_disable_device (struct pci_dev *dev)
 {
+	pcibios_disable_resources(dev);
 	if (pcibios_disable_irq)
 		pcibios_disable_irq(dev);
 }
Index: linux-2.6.17-rc3-git7/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.17-rc3-git7.orig/arch/i386/pci/i386.c
+++ linux-2.6.17-rc3-git7/arch/i386/pci/i386.c
@@ -242,6 +242,15 @@ int pcibios_enable_resources(struct pci_
 	return 0;
 }
 
+void pcibios_disable_resources(struct pci_dev *dev)
+{
+	u16 cmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+}
+
 /*
  *  If we set up a device for bus mastering, we need to check the latency
  *  timer as certain crappy BIOSes forget to set it properly.
Index: linux-2.6.17-rc3-git7/arch/i386/pci/pci.h
===================================================================
--- linux-2.6.17-rc3-git7.orig/arch/i386/pci/pci.h
+++ linux-2.6.17-rc3-git7/arch/i386/pci/pci.h
@@ -35,6 +35,7 @@ extern unsigned int pcibios_max_latency;
 
 void pcibios_resource_survey(void);
 int pcibios_enable_resources(struct pci_dev *, int);
+void pcibios_disable_resources(struct pci_dev *);
 
 /* pci-pc.c */
 
