Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280930AbRKCDvl>; Fri, 2 Nov 2001 22:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280931AbRKCDvd>; Fri, 2 Nov 2001 22:51:33 -0500
Received: from sushi.toad.net ([162.33.130.105]:51360 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280930AbRKCDvW>;
	Fri, 2 Nov 2001 22:51:22 -0500
Subject: [PATCH] PnP BIOS update #9
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 02 Nov 2001 22:50:39 -0500
Message-Id: <1004759442.5995.18.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I neglected to include the patch to pnp_bios.h which
a declaration of pnpbios_get_device().  This patch
supersedes patch "#8".

1) Minor documentation changes
2) One minor bugfix (devs count wrong if error encountered)
3) Yet more paranoid checking of PnP BIOS results and
   more verbose error reporting
4) Slap spinlocks around accesses to those parts of device
   list info that can be updated at run time.
5) Add function pnpbios_get_device().
6) Remove declaration of pnpbios_announce_device() which
   I added earlier, since no one else uses this function
   and it seems designed only for internal use.  Omit the 
   EXPORT_SYMBOL declaration too.

This has been tested by me; and there are no tricky changes,
so this should be safe to put in.

TODO: locking of driver list as well?
                                             // Thomas

The patch:
--- linux-2.4.13-ac6/drivers/pnp/pnp_bios.c	Fri Oct 26 18:13:48 2001
+++ linux-2.4.13-ac6-fix/drivers/pnp/pnp_bios.c	Fri Nov  2 21:11:07 2001
@@ -4,7 +4,7 @@
  * Originally (C) 1998 Christian Schmidt (chr.schmidt@tu-bs.de)
  * Modifications (c) 1998 Tom Lees <tom@lpsg.demon.co.uk>
  * Minor reorganizations by David Hinds <dahinds@users.sourceforge.net>
- * More modifications by Thomas Hood <jdthood_AT_yahoo.co.uk>
+ * Modifications (c) 2001 by Thomas Hood <jdthood@mail.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -46,19 +46,16 @@
 #include <linux/spinlock.h>
 #include <asm/system.h>
 
-/* PnP bios signature: "$PnP" */
-#define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
 /*
- * Forward declarations
+ *
+ * PNP BIOS LOW LEVEL INTERFACE
+ *
  */
 
-static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data );
+/* PnP BIOS signature: "$PnP" */
+#define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-/*
- * This is the standard structure used to identify the entry point
- * to the Plug and Play bios
- */
 #pragma pack(1)
 union pnp_bios_expansion_header {
 	struct {
@@ -81,9 +78,6 @@
 };
 #pragma pack()
 
-/*
- * Local Variables
- */
 static struct {
 	u16	offset;
 	u16	segment;
@@ -91,13 +85,13 @@
 
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
-/* The PnP entries in the GDT */
-#define PNP_GDT		0x0060
-#define PNP_CS32	(PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16	(PNP_GDT+0x08)	/* code segment for bios */
-#define PNP_DS		(PNP_GDT+0x10)	/* data segment for bios */
-#define PNP_TS1		(PNP_GDT+0x18)	/* transfer data segment */
-#define PNP_TS2		(PNP_GDT+0x20)	/* another data segment */
+/* The PnP BIOS entries in the GDT */
+#define PNP_GDT    (0x0060)
+#define PNP_CS32   (PNP_GDT+0x00)	/* segment for calling fn */
+#define PNP_CS16   (PNP_GDT+0x08)	/* code segment for BIOS */
+#define PNP_DS     (PNP_GDT+0x10)	/* data segment for BIOS */
+#define PNP_TS1    (PNP_GDT+0x18)	/* transfer data segment */
+#define PNP_TS2    (PNP_GDT+0x20)	/* another data segment */
 
 /* 
  * These are some opcodes for a "static asmlinkage"
@@ -135,24 +129,6 @@
 set_limit (gdt [(selname) >> 3], size)
 
 /*
- * Callable PnP BIOS functions
- */
-#define PNP_GET_NUM_SYS_DEV_NODES       0x00
-#define PNP_GET_SYS_DEV_NODE            0x01
-#define PNP_SET_SYS_DEV_NODE            0x02
-#define PNP_GET_EVENT                   0x03
-#define PNP_SEND_MESSAGE                0x04
-#define PNP_GET_DOCKING_STATION_INFORMATION 0x05
-#define PNP_SET_STATIC_ALLOCED_RES_INFO 0x09
-#define PNP_GET_STATIC_ALLOCED_RES_INFO 0x0a
-#define PNP_GET_APM_ID_TABLE            0x0b
-#define PNP_GET_PNP_ISA_CONFIG_STRUC    0x40
-#define PNP_GET_ESCD_INFO               0x41
-#define PNP_READ_ESCD                   0x42
-#define PNP_WRITE_ESCD                  0x43
-
-
-/*
  * At some point we want to use this stack frame pointer to unwind
  * after PnP BIOS oopses. 
  */
@@ -161,7 +137,7 @@
 u32 pnp_bios_fault_eip;
 u32 pnp_bios_is_utter_crap = 0;
 
-static spinlock_t pnp_bios_lock;
+static spinlock_t pnp_bios_lock = SPIN_LOCK_UNLOCKED;
 
 static inline u16 call_pnp_bios(u16 func, u16 arg1, u16 arg2, u16 arg3,
 				u16 arg4, u16 arg5, u16 arg6, u16 arg7)
@@ -170,15 +146,13 @@
 	u16 status;
 
 	/*
-	 *	PnPBIOS is generally not terribly re-entrant.
-	 *	Also don't rely on it to save everything correctly
- 	 *
- 	 *	On some boxes IRQ's during PnP bios calls seem fatal
+	 * PnP BIOSes are generally not terribly re-entrant.
+	 * Also, don't rely on them to save everything correctly.
 	 */
-
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
-		
+
+	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 	__cli();
 	__asm__ __volatile__(
@@ -212,7 +186,7 @@
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
 	
-	/* If we got here and this is set the pnp bios faulted on us.. */
+	/* If we get here and this is set then the PnP BIOS faulted on us. */
 	if(pnp_bios_is_utter_crap)
 	{
 		printk(KERN_ERR "PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue.\n");
@@ -223,6 +197,7 @@
 	return status;
 }
 
+
 /*
  *
  * UTILITY FUNCTIONS
@@ -245,12 +220,30 @@
 	return (pnp_bios_hdr != NULL);
 }
 
+/* Forward declaration */
+static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data );
+
+
 /*
  *
  * PnP BIOS ACCESS FUNCTIONS
  *
  */
 
+#define PNP_GET_NUM_SYS_DEV_NODES           0x00
+#define PNP_GET_SYS_DEV_NODE                0x01
+#define PNP_SET_SYS_DEV_NODE                0x02
+#define PNP_GET_EVENT                       0x03
+#define PNP_SEND_MESSAGE                    0x04
+#define PNP_GET_DOCKING_STATION_INFORMATION 0x05
+#define PNP_SET_STATIC_ALLOCED_RES_INFO     0x09
+#define PNP_GET_STATIC_ALLOCED_RES_INFO     0x0a
+#define PNP_GET_APM_ID_TABLE                0x0b
+#define PNP_GET_PNP_ISA_CONFIG_STRUC        0x40
+#define PNP_GET_ESCD_INFO                   0x41
+#define PNP_READ_ESCD                       0x42
+#define PNP_WRITE_ESCD                      0x43
+
 /*
  * Call PnP BIOS with function 0x00, "get number of system device nodes"
  */
@@ -274,8 +267,8 @@
 }
 
 /*
- * Note that some PnP BIOSes (on Sony Vaio laptops) die a horrible
- * death if they are asked to access the "current" configuration
+ * Note that some PnP BIOSes (e.g., on Sony Vaio laptops) die a horrible
+ * death if they are asked to access the "current" configuration.
  * Therefore, if it's a matter of indifference, it's better to call
  * get_dev_node() and set_dev_node() with boot=1 rather than with boot=0.
  */
@@ -309,6 +302,7 @@
 	return status;
 }
 
+
 /*
  * Call PnP BIOS with function 0x02, "set system device node"
  * Input: *nodenum = desired node, 
@@ -504,9 +498,10 @@
 }
 #endif
 
+
 /*
  *
- * PnP DOCKING FUNCTIONS
+ * DOCKING FUNCTIONS
  *
  */
 
@@ -626,7 +621,8 @@
 	complete_and_exit(&unload_sem, 0);
 }
 
-#endif
+#endif   /* CONFIG_HOTPLUG */
+
 
 /*
  *
@@ -781,18 +777,43 @@
         return;
 }
 
+
 /*
  *
- * PnP BIOS PUBLIC DEVICE MANAGEMENT LAYER FUNCTIONS
+ * DEVICE LIST MANAGEMENT FUNCTIONS
  *
+ *
+ * Some of these are exported to give public access
+ *
+ * Question: Why maintain a device list when the PnP BIOS can 
+ * list devices for us?  Answer: Some PnP BIOSes can't report
+ * the current configuration, only the boot configuration.
+ * The boot configuration can be changed, so we need to keep
+ * a record of what the configuration was when we booted;
+ * presumably it continues to describe the current config.
+ * For those BIOSes that can change the current config, we
+ * keep the information in the devlist up to date.
+ *
+ * Note that it is currently assumed that the list does not
+ * grow or shrink in size after init time, and slot_name
+ * never changes.
  */
 
 static LIST_HEAD(pnpbios_devices);
 
+static spinlock_t pnpbios_devices_lock = SPIN_LOCK_UNLOCKED;
+
 static int inline pnpbios_insert_device(struct pci_dev *dev)
 {
-	/* FIXME: Need to check for re-add of existing node */
+
+	/*
+	 * FIXME: Check for re-add of existing node;
+	 * return -1 if node already present
+	 */
+
+	/* We don't lock because we only do this at init time */
 	list_add_tail(&dev->global_list, &pnpbios_devices);
+
 	return 0;
 }
 
@@ -819,6 +840,10 @@
 #undef CHAR
 #undef HEX 
 
+/*
+ * Build a linked list of pci_devs in order of ascending node number.
+ * Called only at init time.
+ */
 static void __init pnpbios_build_devlist(void)
 {
 	int i;
@@ -839,14 +864,20 @@
 	if (!node)
 		return;
 
-	for(i=0,nodenum=0;i<0xff && nodenum!=0xff;i++) {
+	for(i=0,nodenum=0; i<0xff && nodenum!=0xff; i++) {
 		int thisnodenum = nodenum;
 		/* For now we build the list from the "boot" config
 		 * because asking for the "current" config causes
-		 * some BIOSes to crash.
-		 */
-		if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )1 , node))
+		 * some BIOSes to crash.                          */
+		if (pnp_bios_get_dev_node((u8 *)&nodenum, (char )1 , node)) {
+			printk(KERN_WARNING "PnPBIOS: PnP BIOS reported error on attempt to get dev node.\n");
 			break;
+		}
+		/* The BIOS returns with nodenum = the next node number */
+		if (nodenum < thisnodenum) {
+			printk(KERN_WARNING "PnPBIOS: Node number is out of sequence. Naughty BIOS!\n");
+			break;
+		}
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pci_dev), GFP_KERNEL);
 		if (!dev)
@@ -858,7 +889,8 @@
 		pnpbios_node_resource_data_to_dev(node,dev);
 		if(pnpbios_insert_device(dev)<0)
 			kfree(dev);
-		devs++;
+		else
+			devs++;
 	}
 	kfree(node);
 
@@ -866,75 +898,118 @@
 		nodes_got, nodes_got != 1 ? "s" : "", devs);
 }
 
-static struct pci_dev *pnpbios_find_device_by_nodenum( u8 nodenum )
+/*
+ * Return pointer to device node after *prev with name pnpid[]
+ *
+ * Deprecated, since the information in the node may change.
+ * Use pnpbios_get_device instead.
+ */
+struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
 {
 	struct pci_dev *dev;
+	int minnodenum;
+
+	minnodenum = 0;
+	if(prev)
+		minnodenum=prev->devfn + 1;
 
+	/*
+	 * We don't lock.  We assume that the list can be
+	 * traversed and slot_name searched at any time,
+	 * since this is static information.
+	 */
 	pnpbios_for_each_dev(dev) {
-		if(dev->devfn == nodenum)
-			return dev;
+		if(dev->devfn >= minnodenum) {
+			if(memcmp(dev->slot_name, pnpid, 7)==0)
+				return dev;
+		}
 	}
 
-	return NULL;
+	return (struct pci_dev *)NULL;
 }
 
-static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
+EXPORT_SYMBOL(pnpbios_find_device);
+
+/*
+ * Copy device node with node number greater than prevnodenum
+ * and with name pnpid[] to *dev.
+ * Call with prevnodenum = -1 the first time.
+ * Return node number on success, -1 on failure.
+ */
+int pnpbios_get_device(char *pnpid, int prevnodenum, struct pci_dev *usrdev)
 {
-	struct pci_dev *dev = pnpbios_find_device_by_nodenum( nodenum );
-	if ( dev ) {
-		pnpbios_node_resource_data_to_dev(data,dev);
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
 	}
 
-	return;
+	/* Didn't got it */
+	return -1;
 }
 
-/*
- *
- * PUBLIC INTERFACE FUNCTIONS to PnP BIOS ENUMERATION
- *
- */
+EXPORT_SYMBOL(pnpbios_get_device);
 
-/*
- * Find device in list
- */
-struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
+static struct pci_dev *pnpbios_find_device_by_nodenum( u8 nodenum )
 {
 	struct pci_dev *dev;
-	int nodenum;
-
-	nodenum = 0;
-	if(prev)
-		nodenum=prev->devfn + 1; /* Encode node number here */
 
 	pnpbios_for_each_dev(dev) {
-		if(dev->devfn >= nodenum) {
-			if(memcmp(dev->slot_name, pnpid, 7)==0)
-				return dev;
-		}
+		if(dev->devfn == nodenum)
+			return dev;
 	}
 
 	return NULL;
 }
 
-EXPORT_SYMBOL(pnpbios_find_device);
+static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
+{
+	struct pci_dev *dev;
+
+	dev = pnpbios_find_device_by_nodenum( nodenum );
+	if ( dev ) {
+		unsigned long flags;
+		spin_lock_irqsave(&pnpbios_devices_lock, flags);
+		pnpbios_node_resource_data_to_dev(data,dev);
+		spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+	}
+
+	return;
+}
+
 
 /*
- *  Registration of PnPBIOS drivers and handling of hot-pluggable devices.
+ *
+ * DRIVER REGISTRATION FUNCTIONS
+ *
+ *
+ * Exported to give public access
+ *
  */
 
 static LIST_HEAD(pnpbios_drivers);
 
 /**
- * pnpbios_match_device - Tell if a PnPBIOS device structure has a matching PnPBIOS device id structure
+ * pnpbios_match_device - Tell if a PnPBIOS device structure has
+ *                        a matching PnPBIOS device id structure
  * @ids: array of PnPBIOS device id structures to search in
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
@@ -946,7 +1021,7 @@
 	return NULL;
 }
 
-int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
+static int pnpbios_announce_device(struct pnpbios_driver *drv, struct pci_dev *dev)
 {
 	const struct pnpbios_device_id *id;
 	int ret = 0;
@@ -971,8 +1046,6 @@
 	return ret;
 }
 
-EXPORT_SYMBOL(pnpbios_announce_device);
-
 /**
  * pnpbios_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -1007,7 +1080,6 @@
  * each device it was responsible for, and marks those devices as
  * driverless.
  */
-
 void
 pnpbios_unregister_driver(struct pnpbios_driver *drv)
 {
@@ -1025,10 +1097,14 @@
 
 EXPORT_SYMBOL(pnpbios_unregister_driver);
 
+
 /*
  *
  * RESOURCE RESERVATION FUNCTIONS
  *
+ *
+ * Used only at init time
+ *
  */
 
 static void __init pnpbios_reserve_ioport_range(char *pnpid, int start, int end)
@@ -1093,11 +1169,11 @@
 				dev->resource[i].end
 			);
 		} else if (dev->resource[i].flags & IORESOURCE_MEM) {
-			/* memory */
+			/* iomem */
 			/* For now do nothing */
 			continue;
 		} else {
-			/* Neither ioport nor memory */
+			/* Neither ioport nor iomem */
 			/* Do nothing */
 			continue;
 		}
@@ -1106,13 +1182,7 @@
 	return;
 }
 
-/*
- * Reserve resources used by system board devices
- *
- * We really shouldn't just _reserve_ these regions since
- * that prevents the device drivers from claiming them.
- */
-static void __init pnpbios_reserve_resources( void )
+static void __init pnpbios_reserve_board_resources( void )
 {
 	struct pci_dev *dev;
 
@@ -1129,11 +1199,11 @@
 	return;
 }
 
+
 /* 
  *
  * INIT AND EXIT
  *
- *
  */
 
 extern int is_sony_vaio_laptop;
@@ -1210,7 +1280,7 @@
 	}
 
 	pnpbios_build_devlist();
-	pnpbios_reserve_resources();
+	pnpbios_reserve_board_resources();
 #ifdef CONFIG_PROC_FS
 	pnpbios_proc_init();
 #endif
@@ -1225,7 +1295,7 @@
 
 MODULE_LICENSE("GPL");
 
-/* We have to run it early and specifically in non modular.. */
+/* We have to run it early and not as a module. */
 module_init(pnpbios_init);
 
 #ifdef CONFIG_HOTPLUG
--- linux-2.4.13-ac6/include/linux/pnp_bios.h	Fri Oct 26 18:13:49 2001
+++ linux-2.4.13-ac6-fix/include/linux/pnp_bios.h	Fri Nov  2 21:24:58 2001
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


