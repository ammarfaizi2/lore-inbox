Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280060AbRJaE1o>; Tue, 30 Oct 2001 23:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280059AbRJaE1g>; Tue, 30 Oct 2001 23:27:36 -0500
Received: from sushi.toad.net ([162.33.130.105]:35484 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S280060AbRJaE1T>;
	Tue, 30 Oct 2001 23:27:19 -0500
Subject: [PATCH] PnP BIOS #7
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 30 Oct 2001 23:27:13 -0500
Message-Id: <1004502435.4315.192.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here's another PnP BIOS driver patch.

1) Minor documentation changes
2) One minor bugfix
3) Yet more paranoid checking of PnP BIOS results and
   yet more verbose error reporting
4) Slap spinlocks around device list accesses.
      For SMP safety, users of the nodes
      of this devlist [as returned by
      pnpbios_find_device()] should take
      pnpbios_devices_lock first.
                                             // Thomas

The patch:
--- linux-2.4.13-ac2/drivers/pnp/pnp_bios.c	Fri Oct 26 18:13:48 2001
+++ linux-2.4.13-ac2-fix/drivers/pnp/pnp_bios.c	Tue Oct 30 08:37:40 2001
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
@@ -91,11 +85,11 @@
 
 static union pnp_bios_expansion_header * pnp_bios_hdr = NULL;
 
-/* The PnP entries in the GDT */
+/* The PnP BIOS entries in the GDT */
 #define PNP_GDT		0x0060
 #define PNP_CS32	(PNP_GDT+0x00)	/* segment for calling fn */
-#define PNP_CS16	(PNP_GDT+0x08)	/* code segment for bios */
-#define PNP_DS		(PNP_GDT+0x10)	/* data segment for bios */
+#define PNP_CS16	(PNP_GDT+0x08)	/* code segment for BIOS */
+#define PNP_DS		(PNP_GDT+0x10)	/* data segment for BIOS */
 #define PNP_TS1		(PNP_GDT+0x18)	/* transfer data segment */
 #define PNP_TS2		(PNP_GDT+0x20)	/* another data segment */
 
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
 
+#define PNP_GET_NUM_SYS_DEV_NODES       0x00
+#define PNP_GET_SYS_DEV_NODE            0x01
+#define PNP_SET_SYS_DEV_NODE            0x02
+#define PNP_GET_EVENT                   0x03
+#define PNP_SEND_MESSAGE                0x04
+#define PNP_GET_DOCKING_STATION_INFORMATION 0x05
+#define PNP_SET_STATIC_ALLOCED_RES_INFO 0x09
+#define PNP_GET_STATIC_ALLOCED_RES_INFO 0x0a
+#define PNP_GET_APM_ID_TABLE            0x0b
+#define PNP_GET_PNP_ISA_CONFIG_STRUC    0x40
+#define PNP_GET_ESCD_INFO               0x41
+#define PNP_READ_ESCD                   0x42
+#define PNP_WRITE_ESCD                  0x43
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
+ *
  *
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
  */
 
 static LIST_HEAD(pnpbios_devices);
 
+spinlock_t pnpbios_devices_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(pnpbios_devices_lock);
+
 static int inline pnpbios_insert_device(struct pci_dev *dev)
 {
-	/* FIXME: Need to check for re-add of existing node */
+	unsigned long flags;
+
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
+
+	/*
+	 * FIXME: Check for re-add of existing node;
+	 * return -1 if node already present
+	 */
 	list_add_tail(&dev->global_list, &pnpbios_devices);
+
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+
 	return 0;
 }
 
@@ -819,6 +840,10 @@
 #undef CHAR
 #undef HEX 
 
+/*
+ * Build a linked list of pci_devs in order of ascending node number
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
 
@@ -866,66 +898,80 @@
 		nodes_got, nodes_got != 1 ? "s" : "", devs);
 }
 
-static struct pci_dev *pnpbios_find_device_by_nodenum( u8 nodenum )
+struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
 {
 	struct pci_dev *dev;
+	int nodenum;
+	unsigned long flags;
+
+	nodenum = 0;
+	if(prev)
+		nodenum=prev->devfn + 1;
+
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 
 	pnpbios_for_each_dev(dev) {
-		if(dev->devfn == nodenum)
-			return dev;
+		if(dev->devfn >= nodenum) {
+			if(memcmp(dev->slot_name, pnpid, 7)==0)
+				goto out;
+		}
 	}
+	dev = (struct pci_dev *)NULL;
 
-	return NULL;
+out:
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+
+	return dev;
 }
 
-static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
+EXPORT_SYMBOL(pnpbios_find_device);
+
+static struct pci_dev *__pnpbios_find_device_by_nodenum( u8 nodenum )
 {
-	struct pci_dev *dev = pnpbios_find_device_by_nodenum( nodenum );
-	if ( dev ) {
-		pnpbios_node_resource_data_to_dev(data,dev);
+	struct pci_dev *dev;
+
+	pnpbios_for_each_dev(dev) {
+		if(dev->devfn == nodenum)
+			goto out;
 	}
+	dev = (struct pci_dev *)NULL;
 
-	return;
+out:
+	return dev;
 }
 
-/*
- *
- * PUBLIC INTERFACE FUNCTIONS to PnP BIOS ENUMERATION
- *
- */
-
-/*
- * Find device in list
- */
-struct pci_dev *pnpbios_find_device(char *pnpid, struct pci_dev *prev)
+static void pnpbios_update_devlist( u8 nodenum, struct pnp_bios_node *data )
 {
 	struct pci_dev *dev;
-	int nodenum;
+	unsigned long flags;
 
-	nodenum = 0;
-	if(prev)
-		nodenum=prev->devfn + 1; /* Encode node number here */
+	spin_lock_irqsave(&pnpbios_devices_lock, flags);
 
-	pnpbios_for_each_dev(dev) {
-		if(dev->devfn >= nodenum) {
-			if(memcmp(dev->slot_name, pnpid, 7)==0)
-				return dev;
-		}
+	dev = __pnpbios_find_device_by_nodenum( nodenum );
+	if ( dev ) {
+		pnpbios_node_resource_data_to_dev(data,dev);
 	}
 
-	return NULL;
+	spin_unlock_irqrestore(&pnpbios_devices_lock, flags);
+
+	return;
 }
 
-EXPORT_SYMBOL(pnpbios_find_device);
 
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
@@ -1007,7 +1053,6 @@
  * each device it was responsible for, and marks those devices as
  * driverless.
  */
-
 void
 pnpbios_unregister_driver(struct pnpbios_driver *drv)
 {
@@ -1025,10 +1070,14 @@
 
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
@@ -1093,11 +1142,11 @@
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
@@ -1106,13 +1155,7 @@
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
 
@@ -1129,11 +1172,11 @@
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
@@ -1210,7 +1253,7 @@
 	}
 
 	pnpbios_build_devlist();
-	pnpbios_reserve_resources();
+	pnpbios_reserve_board_resources();
 #ifdef CONFIG_PROC_FS
 	pnpbios_proc_init();
 #endif
@@ -1225,7 +1268,7 @@
 
 MODULE_LICENSE("GPL");
 
-/* We have to run it early and specifically in non modular.. */
+/* We have to run it early and not as a module. */
 module_init(pnpbios_init);
 
 #ifdef CONFIG_HOTPLUG

