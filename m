Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUI2FVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUI2FVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 01:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUI2FVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 01:21:14 -0400
Received: from ozlabs.org ([203.10.76.45]:63914 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268213AbUI2FVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 01:21:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16730.17836.508342.113165@cargo.ozlabs.ibm.com>
Date: Wed, 29 Sep 2004 15:18:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: johnrose@austin.ibm.com, greg@kroah.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][1/2] PPC64: Add pcibios_remove_root_bus
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Rose <johnrose@austin.ibm.com>

The following patch creates pcibios_remove_root_bus(), which performs
the ppc64-specific actions for removal of PCI Host Bridges.  This call
is invoked by the RPA DLPAR driver upon PHB removal.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Nru a/arch/ppc64/kernel/pSeries_pci.c b/arch/ppc64/kernel/pSeries_pci.c
--- a/arch/ppc64/kernel/pSeries_pci.c	Tue Sep 28 11:10:41 2004
+++ b/arch/ppc64/kernel/pSeries_pci.c	Tue Sep 28 11:10:41 2004
@@ -472,6 +472,54 @@
 		remap_bus_range(hose->bus);
 }
 
+
+/* RPA-specific bits for removing PHBs */
+int pcibios_remove_root_bus(struct pci_controller *phb)
+{
+	struct pci_bus *b = phb->bus;
+	struct resource *res;
+	int rc, i;
+
+	res = b->resource[0];
+	if (!res->flags) {
+		printk(KERN_ERR "%s: no IO resource for PHB %s\n", __FUNCTION__,
+				b->name);
+		return 1;
+	}
+
+	rc = unmap_bus_range(b);
+	if (rc) {
+		printk(KERN_ERR "%s: failed to unmap IO on bus %s\n",
+			__FUNCTION__, b->name);
+		return 1;
+	}
+
+	if (release_resource(res)) {
+		printk(KERN_ERR "%s: failed to release IO on bus %s\n",
+				__FUNCTION__, b->name);
+		return 1;
+	}
+
+	for (i = 1; i < 3; ++i) {
+		res = b->resource[i];
+		if (!res->flags && i == 0) {
+			printk(KERN_ERR "%s: no MEM resource for PHB %s\n",
+				__FUNCTION__, b->name);
+			return 1;
+		}
+		if (res->flags && release_resource(res)) {
+			printk(KERN_ERR
+			       "%s: failed to release IO %d on bus %s\n",
+				__FUNCTION__, i, b->name);
+			return 1;
+		}
+	}
+
+	list_del(&phb->list_node);
+	return 0;
+}
+EXPORT_SYMBOL(pcibios_remove_root_bus);
+
 static void __init pSeries_request_regions(void)
 {
 	struct device_node *i8042;
diff -Nru a/include/asm-ppc64/pci-bridge.h b/include/asm-ppc64/pci-bridge.h
--- a/include/asm-ppc64/pci-bridge.h	Tue Sep 28 11:10:41 2004
+++ b/include/asm-ppc64/pci-bridge.h	Tue Sep 28 11:10:41 2004
@@ -90,6 +90,8 @@
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 					 struct device_node *dev, int primary);
 
+extern int pcibios_remove_root_bus(struct pci_controller *phb);
+
 /* Use this macro after the PCI bus walk for max performance when it
  * is known that sysdata is correct.
  */
