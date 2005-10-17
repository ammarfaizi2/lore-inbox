Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVJQXIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVJQXIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVJQXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:08:21 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:21345 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751321AbVJQXIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:08:20 -0400
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: Add pci_find_next_capability() to deal with >1 caps of
 same type
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 17 Oct 2005 16:08:12 -0700
Message-ID: <52mzl7pwrn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 17 Oct 2005 23:08:13.0794 (UTC) FILETIME=[A67C9420:01C5D36F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices have more than one capability of the same type.  For
example, the PCI header for the PathScale InfiniPath looks like:

	04:01.0 InfiniBand: Unknown device 1fc1:000d (rev 02)
		Subsystem: Unknown device 1fc1:000d
		Flags: bus master, fast devsel, latency 0, IRQ 193
		Memory at fea00000 (64-bit, non-prefetchable) [size=2M]
		Capabilities: [c0] HyperTransport: Slave or Primary Interface
		Capabilities: [f8] HyperTransport: Interrupt Discovery and Configuration

There are _two_ HyperTransport capabilities, and the PathScale driver
wants to look at both of them.

The current pci_find_capability() API doesn't work for this, since it
only allows us to get to the first capability of a given type.  The
patch below introduces a new pci_find_next_capability(), which can be
used in a loop like

	for (pos = pci_find_capability(pdev, <ID>);
	     pos;
	     pos = pci_find_next_capability(pdev, pos, <ID>)) {
		/* ... */
	}

I made this an EXPORT_SYMBOL() instead of an EXPORT_SYMBOL_GPL() since
it is a trivial wrapper around existing PCI functions, and I'd rather
see people use a nice wrapper instead of recreating the function.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 259d247..b852959 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -120,6 +120,33 @@ int pci_find_capability(struct pci_dev *
 }
 
 /**
+ * pci_find_next_capability - Find next capability after current position
+ * @dev: PCI device to query
+ * @pos: Position to search from
+ * @cap: capability code
+ */
+int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
+{
+	u8 id;
+	int ttl = 48;
+
+	while (ttl--) {
+		pci_read_config_byte(dev, pos + PCI_CAP_LIST_NEXT, &pos);
+		pos &= ~3;
+		if (pos < 0x40)
+			break;
+		pci_read_config_byte(dev, pos + PCI_CAP_LIST_ID, &id);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_find_next_capability);
+
+/**
  * pci_bus_find_capability - query for devices' capabilities 
  * @bus:   the PCI bus to query
  * @devfn: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7349058..8016d14 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -337,6 +337,7 @@ struct pci_dev *pci_find_device (unsigne
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
+int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
@@ -546,6 +547,7 @@ static inline int pci_assign_resource(st
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
+static inline int pci_find_next_capability (struct pci_dev *dev, u8 post, int cap) {return 0; }
 static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
