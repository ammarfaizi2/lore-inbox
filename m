Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280867AbRKOOyz>; Thu, 15 Nov 2001 09:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280871AbRKOOyq>; Thu, 15 Nov 2001 09:54:46 -0500
Received: from sushi.toad.net ([162.33.130.105]:42648 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280867AbRKOOyi>;
	Thu, 15 Nov 2001 09:54:38 -0500
Subject: [PATCH] pnpbios #12
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 09:54:55 -0500
Message-Id: <1005836097.785.32.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #12
- Put more of pnp_bios.h inside #ifdef __KERNEL__ ... #endif
- Remove unused pnpbios_module_init stuff from pnp_bios.h
- Make locking coarser.  This is a first step toward making
  the driver ready for hotplug.  This is a non-trivial change.

In addition to #11:
- Minor formatting changes
- Use spin_lock_init() instead of "= SPIN_LOCK_UNLOCKED"
- Add some comments
- Don't export pnpbios_announce_device, which isn't
  used by outsiders
- Don't spinlock when accessing info that doesn't change
- Update Christian Schmidt's e-mail address

The patch:
--- linux-2.4.13-ac8_ORIG/include/linux/pnp_bios.h	Thu Nov  8 19:42:17 2001
+++ linux-2.4.13-ac8/include/linux/pnp_bios.h	Wed Nov 14 10:59:44 2001
@@ -18,14 +18,13 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * $Original Id: pnp-bios.h,v 0.1 1998/03/19 23:00:00 cs Exp $
- * pnp_bios.h,v 1.1 1999/08/04 15:56:03 root Exp
  */
 
 #ifndef _LINUX_PNP_BIOS_H
 #define _LINUX_PNP_BIOS_H
 
+#ifdef __KERNEL__
+
 #include <linux/types.h>
 #include <linux/pci.h>
 
@@ -109,8 +108,6 @@
 };
 #pragma pack()
 
-#ifdef __KERNEL__
-
 struct pnpbios_device_id
 {
 	char id[8];
@@ -125,24 +122,26 @@
 	void (*remove) (struct pci_dev *dev);		/* Device removed, either due to hotplug remove or module remove */
 };
 
-#define pnpbios_dev_g(n) list_entry(n, struct pci_dev, global_list)
-
-static __inline struct pnpbios_driver *pnpbios_dev_driver(const struct pci_dev *dev)
-{
-	return (struct pnpbios_driver *)dev->driver;
-}
-
 #ifdef CONFIG_PNPBIOS
-#define pnpbios_for_each_dev(dev) \
-	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
 
-/* exported functions */
+/* exported */
 extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prevdev);
 extern int  pnpbios_get_device(char *pnpid, int prevnodenum, struct pci_dev *dev);
 extern int  pnpbios_register_driver(struct pnpbios_driver *drv);
 extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
 
-/* non-exported functions */
+/* non-exported */
+#define pnpbios_for_each_dev(dev) \
+	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
+
+
+#define pnpbios_dev_g(n) list_entry(n, struct pci_dev, global_list)
+
+static __inline struct pnpbios_driver *pnpbios_dev_driver(const struct pci_dev *dev)
+{
+	return (struct pnpbios_driver *)dev->driver;
+}
+
 extern int  pnpbios_dont_use_current_config;
 extern void *pnpbios_kmalloc(size_t size, int f);
 extern void pnpbios_init (void);
@@ -197,9 +196,13 @@
 }
 
 #else /* CONFIG_PNPBIOS */
-#define pnpbios_for_each_dev(dev)	for(dev = NULL; 0; )
 
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
@@ -212,11 +215,6 @@
 static __inline__ void pnpbios_unregister_driver(struct pnpbios_driver *drv)
 {
 	return;
-}
-
-static __inline__ int pnpbios_module_init(struct pnpbios_driver *drv) 
-{
-	return -ENODEV; 
 }
 
 #endif /* CONFIG_PNPBIOS */
--- linux-2.4.13-ac8_ORIG/drivers/pnp/pnp_bios.c	Thu Nov  8 19:42:16 2001
+++ linux-2.4.13-ac8/drivers/pnp/pnp_bios.c	Thu Nov 15 09:51:02 2001
@@ -940,23 +940,27 @@
  */
 int pnpbios_get_device(char *pnpid, int prevnodenum, struct pci_dev *usrdev)
 {
+	unsigned long flags;
 	struct pci_dev *dev;
+	int ret;
 
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 	pnpbios_for_each_dev(dev) {
 		if((int)dev->devfn > prevnodenum && memcmp(dev->slot_name,pnpid,7)==0) {
-			unsigned long flags;
 			/* We lock to prevent updates while we are making a copy */
-			spin_lock_irqsave(&pnpbios_devices_lock, flags);
 			memcpy(usrdev,dev,sizeof(struct pci_dev));
-			spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 			usrdev->global_list.prev = NULL;
 			usrdev->global_list.next = NULL;
-			return (int)dev->devfn;
+			ret = (int)dev->devfn;
+			goto out;
 		}
 	}
-
 	/* Didn't got it */
-	return -1;
+	ret = -1;
+out:
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+
+	return ret;
 }
 
 EXPORT_SYMBOL(pnpbios_get_device);
@@ -975,15 +979,15 @@
 
 static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
 {
+	unsigned long flags;
 	struct pci_dev *dev;
 
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 	dev = pnpbios_find_device_by_nodenum( nodenum );
 	if ( dev ) {
-		unsigned long flags;
-		spin_lock_irqsave(&pnpbios_devices_lock, flags);
 		pnpbios_node_resource_data_to_dev(data,dev);
-		spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 	}
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 
 	return;
 }
@@ -1000,17 +1004,6 @@
 
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
@@ -1026,26 +1019,30 @@
 static int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
-	int ret = 0;
+	struct pci_dev tmpdev;
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
 
+	memcpy( &tmpdev, dev, sizeof(struct pci_dev));
+	tmpdev.global_list.prev = NULL;
+	tmpdev.global_list.next = NULL;
+
 	dev_probe_lock();
-	if (drv->probe(dev, id) >= 0) {
-		// Hack for 2.4 - in 2.5 this needs to be generic stuff anyway
-		dev->driver = (void *)drv;
-		ret = 1;
-	}
+	/* Obviously, probe() should not call any pnpbios functions */
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
@@ -1053,6 +1050,15 @@
  * @drv: the driver structure to register
  * 
  * Adds the driver structure to the list of registered drivers
+ *
+ * For each device in the pnpbios device list that matches one of
+ * the ids in drv->id_table, calls the driver's "probe" function with
+ * arguments (1) a pointer to a *temporary* struct pci_dev containing
+ * resource info for the device, and (2) a pointer to the id string
+ * of the device.  Expects the probe function to return 1 if the
+ * driver claims the device (otherwise 0) in which case, marks the
+ * device as having this driver.
+ * 
  * Returns the number of pci devices which were claimed by the driver
  * during registration.  The driver remains registered even if the
  * return value is zero.
@@ -1061,13 +1067,16 @@
 pnpbios_register_driver(struct pnpbios_driver *drv)
 {
 	struct pci_dev *dev;
+	unsigned long flags;
 	int count = 0;
 
 	list_add_tail(&drv->node, &pnpbios_drivers);
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 	pnpbios_for_each_dev(dev) {
 		if (!pnpbios_dev_driver(dev))
 			count += pnpbios_announce_device(drv, dev);
 	}
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 	return count;
 }
 
@@ -1077,17 +1086,19 @@
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
 {
+	unsigned long flags;
 	struct pci_dev *dev;
 
 	list_del(&drv->node);
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 	pnpbios_for_each_dev(dev) {
 		if (dev->driver == (void *)drv) {
 			if (drv->remove)
@@ -1095,6 +1106,7 @@
 			dev->driver = NULL;
 		}
 	}
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 }
 
 EXPORT_SYMBOL(pnpbios_unregister_driver);

