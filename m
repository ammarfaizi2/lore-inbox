Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVA1O4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVA1O4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVA1O4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:56:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:4008 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261441AbVA1O4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:56:20 -0500
Message-Id: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com>
Subject: [PATCH 1/2] pci: Arch hook to determine config space size
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Fri, 28 Jan 2005 08:56:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When working with a PCI-X Mode 2 adapter on a PCI-X Mode 1 PPC64
system, the current code used to determine the config space size
of a device results in a PCI Master abort and an EEH error, resulting
in the device being taken offline. This patch adds the ability for
arch specific code to override part of the config space size
determination to fix this.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.11-rc2-bk5-bjking1/drivers/pci/probe.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN drivers/pci/probe.c~pci_arch_cfg_space_size drivers/pci/probe.c
--- linux-2.6.11-rc2-bk5/drivers/pci/probe.c~pci_arch_cfg_space_size	2005-01-27 16:56:46.000000000 -0600
+++ linux-2.6.11-rc2-bk5-bjking1/drivers/pci/probe.c	2005-01-27 16:56:46.000000000 -0600
@@ -627,6 +627,8 @@ static void pci_release_dev(struct devic
 	kfree(pci_dev);
 }
 
+int __attribute__ ((weak)) pcibios_exp_cfg_space(struct pci_dev *dev) { return 1; }
+
 /**
  * pci_cfg_space_size - get the configuration space size of the PCI device.
  *
@@ -653,6 +655,8 @@ static int pci_cfg_space_size(struct pci
 			goto fail;
 	}
 
+	if (!pcibios_exp_cfg_space(dev))
+		goto fail;
 	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
 		goto fail;
 	if (status == 0xffffffff)
_
