Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVAJRiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVAJRiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVAJRgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:36:55 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64979 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262366AbVAJRVJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:09 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776591967@kroah.com>
Date: Mon, 10 Jan 2005 09:20:59 -0800
Message-Id: <11053776592652@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.19, 2004/12/22 10:11:27-08:00, matthew@wil.cx

[PATCH] PCI: Software visible configuration request retry status

PCI Express allows cards to return "Configuration Request Retry" if they're
not ready to handle accesses to configuration space.  The PCI Express 1.0a
specification says that the Root Complex should retry the access.  ECN 27
http://www.pcisig.com/specifications/pciexpress/ECN_CRS_Software_Visibility_No27.pdf
allows software to handle the CRS.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |   42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h |   14 ++++++++++++++
 2 files changed, 53 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-01-10 08:59:29 -08:00
+++ b/drivers/pci/probe.c	2005-01-10 08:59:29 -08:00
@@ -2,6 +2,7 @@
  * probe.c - PCI detection and setup code
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -336,6 +337,22 @@
 	return child;
 }
 
+static void pci_enable_crs(struct pci_dev *dev)
+{
+	u16 cap, rpctl;
+	int rpcap = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!rpcap)
+		return;
+
+	pci_read_config_word(dev, rpcap + PCI_CAP_FLAGS, &cap);
+	if (((cap & PCI_EXP_FLAGS_TYPE) >> 4) != PCI_EXP_TYPE_ROOT_PORT)
+		return;
+
+	pci_read_config_word(dev, rpcap + PCI_EXP_RTCTL, &rpctl);
+	rpctl |= PCI_EXP_RTCTL_CRSSVE;
+	pci_write_config_word(dev, rpcap + PCI_EXP_RTCTL, rpctl);
+}
+
 unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus);
 
 /*
@@ -366,6 +383,8 @@
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
+	pci_enable_crs(dev);
+
 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
 		unsigned int cmax, busnr;
 		/*
@@ -614,9 +633,7 @@
 	struct pci_dev *dev;
 	u32 l;
 	u8 hdr_type;
-
-	if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
-		return NULL;
+	int delay = 1;
 
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
 		return NULL;
@@ -624,6 +641,25 @@
 	/* some broken boards return 0 or ~0 if a slot is empty: */
 	if (l == 0xffffffff || l == 0x00000000 ||
 	    l == 0x0000ffff || l == 0xffff0000)
+		return NULL;
+
+	/* Configuration request Retry Status */
+	while (l == 0xffff0001) {
+		msleep(delay);
+		delay *= 2;
+		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
+			return NULL;
+		/* Card hasn't responded in 60 seconds?  Must be stuck. */
+		if (delay > 60 * 1000) {
+			printk(KERN_WARNING "Device %04x:%02x:%02x.%d not "
+					"responding\n", pci_domain_nr(bus),
+					bus->number, PCI_SLOT(devfn),
+					PCI_FUNC(devfn));
+			return NULL;
+		}
+	}
+
+	if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
 		return NULL;
 
 	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-01-10 08:59:29 -08:00
+++ b/include/linux/pci.h	2005-01-10 08:59:29 -08:00
@@ -364,6 +364,20 @@
 #define  PCI_EXP_DEVSTA_URD	0x08	/* Unsupported Request Detected */
 #define  PCI_EXP_DEVSTA_AUXPD	0x10	/* AUX Power Detected */
 #define  PCI_EXP_DEVSTA_TRPND	0x20	/* Transactions Pending */
+#define PCI_EXP_LNKCAP		12	/* Link Capabilities */
+#define PCI_EXP_LNKCTL		16	/* Link Control */
+#define PCI_EXP_LNKSTA		18	/* Link Status */
+#define PCI_EXP_SLTCAP		20	/* Slot Capabilities */
+#define PCI_EXP_SLTCTL		24	/* Slot Control */
+#define PCI_EXP_SLTSTA		26	/* Slot Status */
+#define PCI_EXP_RTCTL		28	/* Root Control */
+#define  PCI_EXP_RTCTL_SECEE	0x01	/* System Error on Correctable Error */
+#define  PCI_EXP_RTCTL_SENFEE	0x02	/* System Error on Non-Fatal Error */
+#define  PCI_EXP_RTCTL_SEFEE	0x04	/* System Error on Fatal Error */
+#define  PCI_EXP_RTCTL_PMEIE	0x08	/* PME Interrupt Enable */
+#define  PCI_EXP_RTCTL_CRSSVE	0x10	/* CRS Software Visibility Enable */
+#define PCI_EXP_RTCAP		30	/* Root Capabilities */
+#define PCI_EXP_RTSTA		32	/* Root Status */
 
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)

