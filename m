Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030645AbWKOQTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbWKOQTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbWKOQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:19:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37094 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030644AbWKOQTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:19:21 -0500
Date: Wed, 15 Nov 2006 16:24:45 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] pci: Introduce pci_find_present
Message-ID: <20061115162445.641eb321@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This works like pci_dev_present but instead of returning boolean returns
the matching pci_device_id entry. This makes it much more useful. Code
bloat is basically nil as the old boolean function is rewritten in terms
of the new one.

This will be used by the updated VIA PCI quirks for one

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/pci/search.c linux-2.6.19-rc5-mm2/drivers/pci/search.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/pci/search.c	2006-11-15 13:25:47.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/pci/search.c	2006-11-15 13:52:14.000000000 +0000
@@ -413,6 +413,24 @@
 	return dev;
 }
 
+const struct pci_device_id *pci_find_present(const struct pci_device_id *ids)
+{
+	struct pci_dev *dev;
+	struct pci_device_id * found = NULL;
+
+	WARN_ON(in_interrupt());
+	down_read(&pci_bus_sem);
+	while (ids->vendor || ids->subvendor || ids->class_mask) {
+		list_for_each_entry(dev, &pci_devices, global_list) {
+			if ((found = pci_match_one_device(ids, dev)) != NULL)
+				break;
+		}
+		ids++;
+	}
+	up_read(&pci_bus_sem);
+	return found;
+}
+
 /**
  * pci_dev_present - Returns 1 if device matching the device list is present, 0 if not.
  * @ids: A pointer to a null terminated list of struct pci_device_id structures
@@ -424,27 +442,14 @@
  * find devices that are usually built into a system, or for a general hint as
  * to if another device happens to be present at this specific moment in time.
  */
+
 int pci_dev_present(const struct pci_device_id *ids)
 {
-	struct pci_dev *dev;
-	int found = 0;
-
-	WARN_ON(in_interrupt());
-	down_read(&pci_bus_sem);
-	while (ids->vendor || ids->subvendor || ids->class_mask) {
-		list_for_each_entry(dev, &pci_devices, global_list) {
-			if (pci_match_one_device(ids, dev)) {
-				found = 1;
-				goto exit;
-			}
-		}
-		ids++;
-	}
-exit:
-	up_read(&pci_bus_sem);
-	return found;
+	return pci_find_present(ids) == NULL ? 0 : 1;
 }
+
 EXPORT_SYMBOL(pci_dev_present);
+EXPORT_SYMBOL(pci_find_present);
 
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/include/linux/pci.h linux-2.6.19-rc5-mm2/include/linux/pci.h
--- linux.vanilla-2.6.19-rc5-mm2/include/linux/pci.h	2006-11-15 13:27:03.000000000 +0000
+++ linux-2.6.19-rc5-mm2/include/linux/pci.h	2006-11-15 13:53:30.000000000 +0000
@@ -461,6 +476,7 @@
 struct pci_dev *pci_get_bus_and_slot (unsigned int bus, unsigned int devfn);
 struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
+const struct pci_device_id *pci_find_present(const struct pci_device_id *ids);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -684,6 +700,7 @@
 { return NULL; }
 
 #define pci_dev_present(ids)	(0)
+#define pci_find_present(ids)	(NULL)
 #define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
