Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRKDBlB>; Sat, 3 Nov 2001 20:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277316AbRKDBkv>; Sat, 3 Nov 2001 20:40:51 -0500
Received: from sushi.toad.net ([162.33.130.105]:57325 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S277294AbRKDBkn>;
	Sat, 3 Nov 2001 20:40:43 -0500
Subject: [PATCH] PnPBIOS patch #10
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Schmidt <schmidt@bcc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 03 Nov 2001 20:40:03 -0500
Message-Id: <1004838006.1319.6.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the remainder of the changes I made to the PnPBIOS driver.

- Minor formatting changes
- Use spin_lock_init() instead of "= SPIN_LOCK_UNLOCKED"
- Add some comments
- Don't export pnpbios_announce_device, which isn't
  used by anyone else
- Don't lock when accessing info that doesn't change
- Update Christian Schmidt's e-mail address
- Add pnpbios_get_device()  The idea here is to provide a
  replacement for pnpbios_find_device(), which returns
  a pointer into the driver's device list, which must
  be locked since it can be updated.  The _get_ function
  copies the node into a struct pci_dev provided by the
  caller, instead of returning a pointer, so the caller
  needn't lock to read the info.  Instead of a pointer
  to a previous node, the caller provides the previous
  node number.

Tested by me.  Should be quite safe to apply.

Alan: Please let me know if you have criticisms of the patch.

--
Thomas Hood

The Patch:
--- linux-2.4.13-ac7/drivers/pnp/pnp_bios.c	Sat Nov  3 18:15:27 2001
+++ linux-2.4.13-ac7-fix/drivers/pnp/pnp_bios.c	Sat Nov  3 20:09:10 2001
@@ -1,7 +1,7 @@
 /*
  * PnP BIOS services
  * 
- * Originally (C) 1998 Christian Schmidt (chr.schmidt@tu-bs.de)
+ * Originally (C) 1998 Christian Schmidt <schmidt@digadd.de>
  * Modifications (c) 1998 Tom Lees <tom@lpsg.demon.co.uk>
  * Minor reorganizations by David Hinds <dahinds@users.sourceforge.net>
  * Modifications (c) 2001 by Thomas Hood <jdthood@mail.com>
@@ -86,12 +86,12 @@
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
 /* The PnP BIOS entries in the GDT */
-#define PNP_GDT		0x0060
-#define PNP_CS32	(PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16	(PNP_GDT+0x08)	/* code segment for BIOS */
-#define PNP_DS		(PNP_GDT+0x10)	/* data segment for BIOS */
-#define PNP_TS1		(PNP_GDT+0x18)	/* transfer data segment */
-#define PNP_TS2		(PNP_GDT+0x20)	/* another data segment */
+#define PNP_GDT    (0x0060)
+#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
+#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
+#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
+#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
+#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
 
 /* 
  * These are some opcodes for a "static asmlinkage"
@@ -137,7 +137,7 @@
 u32 pnp_bios_fault_eip;
 u32 pnp_bios_is_utter_crap = 0;
 
-static spinlock_t pnp_bios_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t pnp_bios_lock;
 
 static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
 				u16 arg4, u16 arg5, u16 arg6, u16 arg7)
@@ -793,26 +793,26 @@
  * presumably it continues to describe the current config.
  * For those BIOSes that can change the current config, we
  * keep the information in the devlist up to date.
+ *
+ * Note that it is currently assumed that the list does not
+ * grow or shrink in size after init time, and slot_name
+ * never changes.
  */
 
 static LIST_HEAD(pnpbios_devices);
 
-spinlock_t pnpbios_devices_lock = SPIN_LOCK_UNLOCKED;
-EXPORT_SYMBOL(pnpbios_devices_lock);
+static spinlock_t pnpbios_devices_lock;
 
 static int inline pnpbios_insert_device(struct pci_dev *dev)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 
 	/*
 	 * FIXME: Check for re-add of existing node;
 	 * return -1 if node already present
 	 */
-	list_add_tail(&dev->global_list, &pnpbios_devices);
 
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+	/* We don't lock because we only do this at init time */
+	list_add_tail(&dev->global_list, &pnpbios_devices);
 
 	return 0;
 }
@@ -898,62 +898,93 @@
 		nodes_got, nodes_got != 1 ? "s" : "", devs);
 }
 
+/*
+ * Return pointer to device node after *prev with name pnpid[]
+ *
+ * Deprecated, since the information in the node may be 
+ * updated while it's being read.
+ * Use pnpbios_get_device instead.
+ */
 struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
 {
 	struct pci_dev *dev;
-	int nodenum;
-	unsigned long flags;
+	int minnodenum;
 
-	nodenum = 0;
+	minnodenum = 0;
 	if(prev)
-		nodenum=prev->devfn + 1;
-
-	spin_lock_irqsave(&pnpbios_devices_lock, flags);
+		minnodenum=prev->devfn + 1;
 
+	/*
+	 * We don't lock.  We assume that the list can be
+	 * traversed and slot_name searched at any time,
+	 * since this is static information.
+	 */
 	pnpbios_for_each_dev(dev) {
-		if(dev->devfn >= nodenum) {
+		if(dev->devfn >= minnodenum) {
 			if(memcmp(dev->slot_name, pnpid, 7)==0)
-				goto out;
+				return dev;
 		}
 	}
-	dev = (struct pci_dev *)NULL;
 
-out:
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
-
-	return dev;
+	return (struct pci_dev *)NULL;
 }
 
 EXPORT_SYMBOL(pnpbios_find_device);
 
-static struct pci_dev *__pnpbios_find_device_by_nodenum( u8 nodenum )
+/*
+ * Copy device node with node number greater than prevnodenum
+ *    and with name pnpid[] to *dev.
+ * Return node number on success, -1 on failure.
+ *
+ * Note: Call with prevnodenum = -1 the first time.
+ */
+int pnpbios_get_device(char *pnpid, int prevnodenum, struct pci_dev *usrdev)
+{
+	struct pci_dev *dev;
+
+	pnpbios_for_each_dev(dev) {
+		if((int)dev->devfn > prevnodenum && memcmp(dev->slot_name,pnpid,7)==0) {
+			unsigned long flags;
+			/* We lock to prevent updates while we are making a copy */
+			spin_lock_irqsave(&pnpbios_devices_lock, flags);
+			memcpy(usrdev,dev,sizeof(struct pci_dev));
+			spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+			usrdev->global_list.prev = NULL;
+			usrdev->global_list.next = NULL;
+			return (int)dev->devfn;
+		}
+	}
+
+	/* Didn't got it */
+	return -1;
+}
+
+EXPORT_SYMBOL(pnpbios_get_device);
+
+static struct pci_dev *pnpbios_find_device_by_nodenum( u8 nodenum )
 {
 	struct pci_dev *dev;
 
 	pnpbios_for_each_dev(dev) {
 		if(dev->devfn == nodenum)
-			goto out;
+			return dev;
 	}
-	dev = (struct pci_dev *)NULL;
 
-out:
-	return dev;
+	return NULL;
 }
 
 static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
 {
 	struct pci_dev *dev;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 
-	dev = __pnpbios_find_device_by_nodenum( nodenum );
+	dev = pnpbios_find_device_by_nodenum( nodenum );
 	if ( dev ) {
+		unsigned long flags;
+		spin_lock_irqsave(&pnpbios_devices_lock, flags);
 		pnpbios_node_resource_data_to_dev(data,dev);
+		spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 	}
 
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
-
 	return;
 }
 
@@ -980,7 +1011,7 @@
  * pnpbios_device_id structure or %NULL if there is no match.
  */
 
-const struct pnpbios_device_id *
+static const struct pnpbios_device_id *
 pnpbios_match_device(const struct pnpbios_device_id *ids, const struct pci_dev *dev)
 {
 	while (*ids->id)
@@ -992,7 +1023,7 @@
 	return NULL;
 }
 
-int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
+static int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
 	int ret = 0;
@@ -1017,8 +1048,6 @@
 	return ret;
 }
 
-EXPORT_SYMBOL(pnpbios_announce_device);
-
 /**
  * pnpbios_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -1206,6 +1235,7 @@
 	int i, length;
 
 	spin_lock_init(&pnp_bios_lock);
+	spin_lock_init(&pnpbios_devices_lock);
 
 	if(pnpbios_disabled) {
 		printk(KERN_INFO "PnPBIOS: Disabled.\n");
--- linux-2.4.13-ac7/include/linux/pnp_bios.h	Sat Nov  3 18:29:25 2001
+++ linux-2.4.13-ac7-fix/include/linux/pnp_bios.h	Sat Nov  3 19:15:11 2001
@@ -137,8 +137,8 @@
 	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
 
 /* exported functions */
-extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev);
-extern int  pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev);
+extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prevdev);
+extern int  pnpbios_get_device(char *pnpid, int prevnodenum, struct pci_dev *dev);
 extern int  pnpbios_register_driver(struct pnpbios_driver *drv);
 extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
 
@@ -202,11 +202,6 @@
 static __inline__ struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev)
 {
 	return NULL;
-}
-
-static __inline__ int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
-{
-	return 0;
 }
 
 static __inline__ int pnpbios_register_driver(struct pnpbios_driver *drv)

