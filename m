Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280496AbRKJFdA>; Sat, 10 Nov 2001 00:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280502AbRKJFck>; Sat, 10 Nov 2001 00:32:40 -0500
Received: from sushi.toad.net ([162.33.130.105]:5607 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280496AbRKJFcb>;
	Sat, 10 Nov 2001 00:32:31 -0500
Subject: PnP BIOS driver patch #11
To: linux-kernel@vger.kernel.org
Date: Sat, 10 Nov 2001 00:32:38 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011110053238.64A30B70@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is more tweaking of the PnP BIOS driver to accompany
a forthcoming patch to the parport driver.

- Add inline version of pnpbios_get_device to pnp_bios.h
- Add comments
- Take lock when accessing devlist within register_driver

-- 
Thomas Hood

The patch:
--- linux-2.4.13-ac8_ORIG/include/linux/pnp_bios.h	Thu Nov  8 19:42:17 2001
+++ linux-2.4.13-ac8/include/linux/pnp_bios.h	Fri Nov  9 23:45:31 2001
@@ -199,7 +199,12 @@
 #else /* CONFIG_PNPBIOS */
 #define pnpbios_for_each_dev(dev)	for(dev = NULL; 0; )
 
-static __inline__ struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev)
+static __inline__ struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prevdev)
+{
+	return NULL;
+}
+
+static __inline__ int pnpbios_get_device(char *pnpid, int prevnodenum, struct pci_dev *dev)
 {
 	return NULL;
 }
--- linux-2.4.13-ac8_ORIG/drivers/pnp/pnp_bios.c	Thu Nov  8 19:42:16 2001
+++ linux-2.4.13-ac8/drivers/pnp/pnp_bios.c	Sat Nov 10 00:26:31 2001
@@ -1000,17 +1000,6 @@
 
 static LIST_HEAD(pnpbios_drivers);
 
-/**
- * pnpbios_match_device - Tell if a PnPBIOS device structure has
- *                        a matching PnPBIOS device id structure
- * @ids: array of PnPBIOS device id structures to search in
- * @dev: the PnPBIOS device structure to match against
- * 
- * Used by a driver to check whether a PnPBIOS device present in the
- * system is in its list of supported devices.Returns the matching
- * pnpbios_device_id structure or %NULL if there is no match.
- */
-
 static const struct pnpbios_device_id *
 pnpbios_match_device(const struct pnpbios_device_id *ids, const struct pci_dev *dev)
 {
@@ -1026,26 +1015,32 @@
 static int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
-	int ret = 0;
+	struct pci_dev tmpdev;
+	unsigned long flags;
+	int ret;
 
 	if (drv->id_table) {
 		id = pnpbios_match_device(drv->id_table, dev);
-		if (!id) {
-			ret = 0;
-			goto out;
-		}
+		if (!id)
+			return 0;
 	} else
 		id = NULL;
 
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
+	memcpy( &tmpdev, dev, sizeof(struct pci_dev));
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+	tmpdev.global_list.prev = NULL;
+	tmpdev.global_list.next = NULL;
+
 	dev_probe_lock();
-	if (drv->probe(dev, id) >= 0) {
-		// Hack for 2.4 - in 2.5 this needs to be generic stuff anyway
-		dev->driver = (void *)drv;
-		ret = 1;
-	}
+	ret = drv->probe(&tmpdev, id);
 	dev_probe_unlock();
-out:
-	return ret;
+	if (ret < 1)
+		return 0;
+
+	dev->driver = (void *)drv;
+
+	return 1;
 }
 
 /**
@@ -1053,6 +1048,15 @@
  * @drv: the driver structure to register
  * 
  * Adds the driver structure to the list of registered drivers
+ *
+ * For each device in the pnpbios device list that matches one of
+ * the ids in drv->id_table, marks the device as having this
+ * driver, and calls the driver's "probe" callback function with
+ * arguments (1) a pointer to a *temporary* struct pci_dev containing
+ * resource info for the device, and (2) a pointer to the id string
+ * of the device; expects the probe function to return 1 if the
+ * driver claims the device, otherwise 0
+ * 
  * Returns the number of pci devices which were claimed by the driver
  * during registration.  The driver remains registered even if the
  * return value is zero.
@@ -1077,10 +1081,10 @@
  * pnpbios_unregister_driver - unregister a pci driver
  * @drv: the driver structure to unregister
  * 
- * Deletes the driver structure from the list of registered PnPBIOS drivers,
- * gives it a chance to clean up by calling its remove() function for
- * each device it was responsible for, and marks those devices as
- * driverless.
+ * Deletes the driver structure from the list of registered PnPBIOS
+ * drivers, gives it a chance to clean up by calling its "remove"
+ * function for each device it was responsible for, and marks those
+ * devices as driverless.
  */
 void
 pnpbios_unregister_driver(struct pnpbios_driver *drv)
