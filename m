Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVA1O6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVA1O6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVA1O4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:56:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15795 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261443AbVA1O41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:56:27 -0500
Message-Id: <200501281456.j0SEuPRF017696@d01av04.pok.ibm.com>
Subject: [PATCH 2/2] ppc64: Arch hook to determine config space size
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, brking@us.ibm.com
From: brking@us.ibm.com
Date: Fri, 28 Jan 2005 08:56:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When working with a PCI-X Mode 2 adapter on a PCI-X Mode 1 PPC64
system, the current code used to determine the config space size
of a device results in a PCI Master abort and an EEH error, resulting
in the device being taken offline. This patch adds a ppc64
override to query OF to determine if the system and PHB support
PCI-X mode 2.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6.11-rc2-bk5-bjking1/arch/ppc64/kernel/pSeries_pci.c |   18 +++++++++++
 1 files changed, 18 insertions(+)

diff -puN arch/ppc64/kernel/pSeries_pci.c~ppc64_arch_cfg_space_size arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.11-rc2-bk5/arch/ppc64/kernel/pSeries_pci.c~ppc64_arch_cfg_space_size	2005-01-27 16:57:03.000000000 -0600
+++ linux-2.6.11-rc2-bk5-bjking1/arch/ppc64/kernel/pSeries_pci.c	2005-01-27 16:57:48.000000000 -0600
@@ -583,3 +583,21 @@ static void fixup_winbond_82c105(struct 
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
+
+int pcibios_exp_cfg_space(struct pci_dev *dev)
+{
+	int *type;
+	struct device_node *dn;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (!hose)
+		return 0;
+
+	dn = (struct device_node *) hose->arch_data;
+	type = (int *)get_property(dn, "ibm,pci-config-space-type", NULL);
+
+	if (type && *type == 1)
+		return 1;
+
+	return 0;
+}
_
