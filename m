Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVCGHk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVCGHk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCGHk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:40:57 -0500
Received: from ozlabs.org ([203.10.76.45]:36492 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261673AbVCGHfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:35:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16940.400.977922.580230@cargo.ozlabs.ibm.com>
Date: Mon, 7 Mar 2005 18:24:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: brking@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Mode 2 PCI-X config space size fix
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Brian King <brking@us.ibm.com>.

When working with a PCI-X Mode 2 adapter on a PCI-X Mode 1 PPC64
system, the current code used to determine the config space size
of a device results in a PCI Master abort and an EEH error, resulting
in the device being taken offline. This patch checks OF to see if
the PCI bridge supports PCI-X Mode 2 and fails config accesses beyond
256 bytes if it does not.

Signed-off-by: Brian King <brking@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/iSeries_pci.c test/arch/ppc64/kernel/iSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/iSeries_pci.c	2005-01-22 09:25:41.000000000 +1100
+++ test/arch/ppc64/kernel/iSeries_pci.c	2005-03-07 18:21:41.000000000 +1100
@@ -610,6 +610,10 @@
 
 	if (node == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset > 255) {
+		*val = ~0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
 
 	fn = hv_cfg_read_func[(size - 1) & 3];
 	HvCall3Ret16(fn, &ret, node->DsaAddr.DsaAddr, offset, 0);
@@ -636,6 +640,8 @@
 
 	if (node == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset > 255)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	fn = hv_cfg_write_func[(size - 1) & 3];
 	ret = HvCall4(fn, node->DsaAddr.DsaAddr, offset, val, 0);
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c test/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2005-01-12 18:20:48.000000000 +1100
+++ test/arch/ppc64/kernel/pSeries_pci.c	2005-03-07 18:21:41.000000000 +1100
@@ -52,6 +52,16 @@
 
 extern struct mpic *pSeries_mpic;
 
+static int config_access_valid(struct device_node *dn, int where)
+{
+	if (where < 256)
+		return 1;
+	if (where < 4096 && dn->pci_ext_config_space)
+		return 1;
+
+	return 0;
+}
+
 static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
 {
 	int returnval = -1;
@@ -60,10 +70,11 @@
 
 	if (!dn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (where & (size - 1))
+	if (!config_access_valid(dn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
+		(dn->devfn << 8) | (where & 0xff);
 	buid = dn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
@@ -108,10 +119,11 @@
 
 	if (!dn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (where & (size - 1))
+	if (!config_access_valid(dn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
+	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
+		(dn->devfn << 8) | (where & 0xff);
 	buid = dn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr, buid >> 32, buid & 0xffffffff, size, (ulong) val);
diff -urN linux-2.5/arch/ppc64/kernel/pci_dn.c test/arch/ppc64/kernel/pci_dn.c
--- linux-2.5/arch/ppc64/kernel/pci_dn.c	2005-01-12 18:20:48.000000000 +1100
+++ test/arch/ppc64/kernel/pci_dn.c	2005-03-07 18:21:41.000000000 +1100
@@ -37,6 +37,7 @@
 static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
+	int *type = (int *)get_property(dn, "ibm,pci-config-space-type", NULL);
 	u32 *regs;
 
 	dn->phb = phb;
@@ -46,6 +47,8 @@
 		dn->busno = (regs[0] >> 16) & 0xff;
 		dn->devfn = (regs[0] >> 8) & 0xff;
 	}
+
+	dn->pci_ext_config_space = (type && *type == 1);
 	return NULL;
 }
 
diff -urN linux-2.5/include/asm-ppc64/prom.h test/include/asm-ppc64/prom.h
--- linux-2.5/include/asm-ppc64/prom.h	2005-01-29 09:58:49.000000000 +1100
+++ test/include/asm-ppc64/prom.h	2005-03-07 18:21:41.000000000 +1100
@@ -137,6 +137,7 @@
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int	pci_ext_config_space;	/* for pci devices */
 	struct  pci_controller *phb;	/* for pci devices */
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 
