Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRKFNyE>; Tue, 6 Nov 2001 08:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRKFNxz>; Tue, 6 Nov 2001 08:53:55 -0500
Received: from sushi.toad.net ([162.33.130.105]:24043 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279307AbRKFNxm>;
	Tue, 6 Nov 2001 08:53:42 -0500
Subject: [PATCH] PnPBIOS patch #11
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 06 Nov 2001 08:53:00 -0500
Message-Id: <1005054783.20875.37.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same patch as #10 except that pnpbios_get_device()
has been chopped out (because I think Alan doesn't like it).

- Minor formatting changes
- Use spin_lock_init() instead of "= SPIN_LOCK_UNLOCKED"
- Add some comments
- Don't export pnpbios_announce_device, which isn't
  used by outsiders
- Don't spinlock when accessing info that doesn't change
- Update Christian Schmidt's e-mail address

Should be safe to apply.

--
Thomas Hood

The Patch:
--- linux-2.4.13-ac7/drivers/pnp/pnp_bios.c	Sat Nov  3 18:15:27 2001
+++ linux-2.4.13-ac7-fix/drivers/pnp/pnp_bios.c	Tue Nov  6 08:48:10 2001
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
@@ -230,19 +230,19 @@
  *
  */
 
-#define PNP_GET_NUM_SYS_DEV_NODES       0x00
-#define PNP_GET_SYS_DEV_NODE            0x01
-#define PNP_SET_SYS_DEV_NODE            0x02
-#define PNP_GET_EVENT                   0x03
-#define PNP_SEND_MESSAGE                0x04
+#define PNP_GET_NUM_SYS_DEV_NODES           0x00
+#define PNP_GET_SYS_DEV_NODE                0x01
+#define PNP_SET_SYS_DEV_NODE                0x02
+#define PNP_GET_EVENT                       0x03
+#define PNP_SEND_MESSAGE                    0x04
 #define PNP_GET_DOCKING_STATION_INFORMATION 0x05
-#define PNP_SET_STATIC_ALLOCED_RES_INFO 0x09
-#define PNP_GET_STATIC_ALLOCED_RES_INFO 0x0a
-#define PNP_GET_APM_ID_TABLE            0x0b
-#define PNP_GET_PNP_ISA_CONFIG_STRUC    0x40
-#define PNP_GET_ESCD_INFO               0x41
-#define PNP_READ_ESCD                   0x42
-#define PNP_WRITE_ESCD                  0x43
+#define PNP_SET_STATIC_ALLOCED_RES_INFO     0x09
+#define PNP_GET_STATIC_ALLOCED_RES_INFO     0x0a
+#define PNP_GET_APM_ID_TABLE                0x0b
+#define PNP_GET_PNP_ISA_CONFIG_STRUC        0x40
+#define PNP_GET_ESCD_INFO                   0x41
+#define PNP_READ_ESCD                       0x42
+#define PNP_WRITE_ESCD                      0x43
 
 /*
  * Call PnP BIOS with function 0x00, "get number of system device nodes"
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
@@ -898,62 +898,59 @@
 		nodes_got, nodes_got != 1 ? "s" : "", devs);
 }
 
+/*
+ * Return pointer to device node after *prev with name pnpid[]
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
-
-out:
-	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
 
-	return dev;
+	return (struct pci_dev *)NULL;
 }
 
 EXPORT_SYMBOL(pnpbios_find_device);
 
-static struct pci_dev *__pnpbios_find_device_by_nodenum( u8 nodenum )
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
 
@@ -976,11 +973,11 @@
  * @dev: the PnPBIOS device structure to match against
  * 
  * Used by a driver to check whether a PnPBIOS device present in the
- * system is in its list of supported devices.Returns the matching
+ * system is in its list of supported devices.  Returns the matching
  * pnpbios_device_id structure or %NULL if there is no match.
  */
 
-const struct pnpbios_device_id *
+static const struct pnpbios_device_id *
 pnpbios_match_device(const struct pnpbios_device_id *ids, const struct pci_dev *dev)
 {
 	while (*ids->id)
@@ -992,7 +989,7 @@
 	return NULL;
 }
 
-int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
+static int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
 	int ret = 0;
@@ -1017,8 +1014,6 @@
 	return ret;
 }
 
-EXPORT_SYMBOL(pnpbios_announce_device);
-
 /**
  * pnpbios_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -1206,6 +1201,7 @@
 	int i, length;
 
 	spin_lock_init(&pnp_bios_lock);
+	spin_lock_init(&pnpbios_devices_lock);
 
 	if(pnpbios_disabled) {
 		printk(KERN_INFO "PnPBIOS: Disabled.\n");
--- linux-2.4.13-ac7/include/linux/pnp_bios.h	Sat Nov  3 18:29:25 2001
+++ linux-2.4.13-ac7-fix/include/linux/pnp_bios.h	Tue Nov  6 08:40:53 2001
@@ -137,8 +137,7 @@
 	for(dev = pnpbios_dev_g(pnpbios_devices.next); dev != pnpbios_dev_g(&pnpbios_devices); dev = pnpbios_dev_g(dev->global_list.next))
 
 /* exported functions */
-extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *dev);
-extern int  pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev);
+extern struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prevdev);
 extern int  pnpbios_register_driver(struct pnpbios_driver *drv);
 extern void pnpbios_unregister_driver(struct pnpbios_driver *drv);
 
@@ -202,11 +201,6 @@
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

