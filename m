Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269613AbUJSXHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269613AbUJSXHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269615AbUJSXGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:06:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:63369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270084AbUJSWqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:23 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257383185@kroah.com>
Date: Tue, 19 Oct 2004 15:42:18 -0700
Message-Id: <10982257381647@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.52, 2004/10/06 13:46:10-07:00, paulus@samba.org

[PATCH] PPC64: Add pcibios_remove_root_bus

From: John Rose <johnrose@austin.ibm.com>

The following patch creates pcibios_remove_root_bus(), which performs
the ppc64-specific actions for removal of PCI Host Bridges.  This call
is invoked by the RPA DLPAR driver upon PHB removal.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc64/kernel/pSeries_pci.c |   48 ++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc64/pci-bridge.h  |    2 +
 2 files changed, 50 insertions(+)


diff -Nru a/arch/ppc64/kernel/pSeries_pci.c b/arch/ppc64/kernel/pSeries_pci.c
--- a/arch/ppc64/kernel/pSeries_pci.c	2004-10-19 15:22:56 -07:00
+++ b/arch/ppc64/kernel/pSeries_pci.c	2004-10-19 15:22:56 -07:00
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
--- a/include/asm-ppc64/pci-bridge.h	2004-10-19 15:22:56 -07:00
+++ b/include/asm-ppc64/pci-bridge.h	2004-10-19 15:22:56 -07:00
@@ -90,6 +90,8 @@
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 					 struct device_node *dev, int primary);
 
+extern int pcibios_remove_root_bus(struct pci_controller *phb);
+
 /* Use this macro after the PCI bus walk for max performance when it
  * is known that sysdata is correct.
  */

