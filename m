Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRHTWQN>; Mon, 20 Aug 2001 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269676AbRHTWP7>; Mon, 20 Aug 2001 18:15:59 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:46470 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269673AbRHTWPi>; Mon, 20 Aug 2001 18:15:38 -0400
Date: Mon, 20 Aug 2001 15:15:50 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: romieu@cogenit.fr, mitch@sfgoth.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.9/drivers/atm to new module_{init,exit} + some pci_device_id tables
Message-ID: <20010820151550.A12592@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>Where's the patch ?

	Oops.  Sorry about that.  Here is the patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atm.diffs"

--- linux-2.4.9/drivers/block/genhd.c	Thu Jul 19 17:48:15 2001
+++ linux/drivers/block/genhd.c	Mon Aug 20 07:38:50 2001
@@ -27,7 +27,6 @@
 extern int net_dev_init(void);
 extern void console_map_init(void);
 extern int soc_probe(void);
-extern int atmdev_init(void);
 extern int i2o_init(void);
 extern int cpqarray_init(void);
 
@@ -53,9 +52,6 @@
 #endif
 #ifdef CONFIG_NET
 	net_dev_init();
-#endif
-#ifdef CONFIG_ATM
-	(void) atmdev_init();
 #endif
 #ifdef CONFIG_VT
 	console_map_init();
diff -r -u linux-2.4.9/drivers/atm/Makefile linux/drivers/atm/Makefile
--- linux-2.4.9/drivers/atm/Makefile	Mon Mar 26 15:36:30 2001
+++ linux/drivers/atm/Makefile	Mon Aug 20 04:54:23 2001
@@ -7,7 +7,7 @@
 
 export-objs := uPD98402.o suni.o idt77105.o
 
-obj-y := atmdev_init.o
+obj-y :=
 
 obj-$(CONFIG_ATM_ENI) += eni.o suni.o
 obj-$(CONFIG_ATM_ZATM) += zatm.o uPD98402.o
diff -r -u linux-2.4.9/drivers/atm/ambassador.c linux/drivers/atm/ambassador.c
--- linux-2.4.9/drivers/atm/ambassador.c	Wed Jun 27 16:18:13 2001
+++ linux/drivers/atm/ambassador.c	Mon Aug 20 04:54:23 2001
@@ -795,8 +795,7 @@
   return;
 }
 
-#ifdef MODULE
-static void drain_rx_pools (amb_dev * dev) {
+static void __exit drain_rx_pools (amb_dev * dev) {
   unsigned char pool;
   
   PRINTD (DBG_FLOW|DBG_POOL, "drain_rx_pools %p", dev);
@@ -806,7 +805,6 @@
   
   return;
 }
-#endif
 
 static inline void fill_rx_pool (amb_dev * dev, unsigned char pool, int priority) {
   rx_in rx;
@@ -2581,6 +2579,18 @@
 /********** module stuff **********/
 
 #ifdef MODULE
+static struct pci_device_id ambassador_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_MADGE,
+	  device: PCI_DEVICE_ID_MADGE_AMBASSADOR,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ambassador_pci_tbl);
+#endif
+
 EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR(maintainer_string);
@@ -2600,9 +2610,7 @@
 MODULE_PARM_DESC(rx_lats, "number of extra buffers to cope with RX latencies");
 MODULE_PARM_DESC(pci_lat, "PCI latency in bus cycles");
 
-/********** module entry **********/
-
-int init_module (void) {
+static int __init amb_module_init (void) {
   int devs;
   
   PRINTD (DBG_FLOW|DBG_INIT, "init_module");
@@ -2634,9 +2642,7 @@
   return devs ? 0 : -ENODEV;
 }
 
-/********** module exit **********/
-
-void cleanup_module (void) {
+static void __exit amb_exit (void) {
   amb_dev * dev;
   
   PRINTD (DBG_FLOW|DBG_INIT, "cleanup_module");
@@ -2664,38 +2670,5 @@
   return;
 }
 
-#else
-
-/********** monolithic entry **********/
-
-int __init amb_detect (void) {
-  int devs;
-  
-  // sanity check - cast needed as printk does not support %Zu
-  if (sizeof(amb_mem) != 4*16 + 4*12) {
-    PRINTK (KERN_ERR, "Fix amb_mem (is %lu words).",
-	    (unsigned long) sizeof(amb_mem));
-    return 0;
-  }
-  
-  show_version();
-  
-  amb_check_args();
-  
-  // get the juice
-  devs = amb_probe();
-  
-  if (devs) {
-    init_timer (&housekeeping);
-    housekeeping.function = do_housekeeping;
-    // paranoia
-    housekeeping.data = 1;
-    set_timer (&housekeeping, 0);
-  } else {
-    PRINTK (KERN_INFO, "no (usable) adapters found");
-  }
-  
-  return devs;
-}
-
-#endif
+module_init(amb_module_init);
+module_exit(amb_exit);
diff -r -u linux-2.4.9/drivers/atm/atmdev_init.c linux/drivers/atm/atmdev_init.c
--- linux-2.4.9/drivers/atm/atmdev_init.c	Fri Dec 29 14:35:47 2000
+++ linux/drivers/atm/atmdev_init.c	Mon Aug 20 07:38:25 2001
@@ -1,60 +0,0 @@
-/* drivers/atm/atmdev_init.c - ATM device driver initialization */
- 
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
- 
-
-#include <linux/config.h>
-#include <linux/init.h>
-
-
-#ifdef CONFIG_ATM_ZATM
-extern int zatm_detect(void);
-#endif
-#ifdef CONFIG_ATM_NICSTAR
-extern int nicstar_detect(void);
-#endif
-#ifdef CONFIG_ATM_AMBASSADOR
-extern int amb_detect(void);
-#endif
-#ifdef CONFIG_ATM_HORIZON
-extern int hrz_detect(void);
-#endif
-#ifdef CONFIG_ATM_IA
-extern int ia_detect(void);
-#endif
-#ifdef CONFIG_ATM_FORE200E
-extern int fore200e_detect(void);
-#endif
-
-
-/*
- * For historical reasons, atmdev_init returns the number of devices found.
- * Note that some detections may not go via atmdev_init (e.g. eni.c), so this
- * number is meaningless.
- */
-
-int __init atmdev_init(void)
-{
-	int devs;
-
-	devs = 0;
-#ifdef CONFIG_ATM_ZATM
-	devs += zatm_detect();
-#endif
-#ifdef CONFIG_ATM_NICSTAR
-	devs += nicstar_detect();
-#endif
-#ifdef CONFIG_ATM_AMBASSADOR
-	devs += amb_detect();
-#endif
-#ifdef CONFIG_ATM_HORIZON
-	devs += hrz_detect();
-#endif
-#ifdef CONFIG_ATM_IA
-	devs += ia_detect();
-#endif
-#ifdef CONFIG_ATM_FORE200E
-	devs += fore200e_detect();
-#endif
-	return devs;
-}
diff -r -u linux-2.4.9/drivers/atm/fore200e.c linux/drivers/atm/fore200e.c
--- linux-2.4.9/drivers/atm/fore200e.c	Wed Jun 27 16:18:13 2001
+++ linux/drivers/atm/fore200e.c	Mon Aug 20 04:54:23 2001
@@ -97,10 +97,21 @@
 static struct fore200e* fore200e_boards = NULL;
 
 
-#ifdef MODULE
 MODULE_AUTHOR("Christophe Lizzi - credits to Uwe Dannowski and Heikki Vatiainen");
 MODULE_DESCRIPTION("FORE Systems 200E-series ATM driver - version " FORE200E_VERSION);
 MODULE_SUPPORTED_DEVICE("PCA-200E, SBA-200E");
+
+#ifdef MODULE
+static struct pci_device_id fore200e_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_FORE,
+	  device: PCI_DEVICE_ID_FORE_PCA200E,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, fore200e_pci_tbl);
 #endif
 
 
@@ -2584,8 +2595,8 @@
 }
 
 
-int __init
-fore200e_detect(void)
+static int __init
+fore200e_module_init(void)
 {
     const struct fore200e_bus* bus;
     struct       fore200e*     fore200e;
@@ -2622,8 +2633,7 @@
 }
 
 
-#ifdef MODULE
-static void
+static void __exit
 fore200e_cleanup(struct fore200e** head)
 {
     struct fore200e* fore200e = *head;
@@ -2634,7 +2644,6 @@
 
     kfree(fore200e);
 }
-#endif
 
 
 static int
@@ -2908,16 +2917,8 @@
 }
 
 
-#ifdef MODULE
-static int __init
-fore200e_module_init(void)
-{
-    DPRINTK(1, "module loaded\n");
-    return fore200e_detect() == 0;
-}
-
 static void __exit
-fore200e_module_cleanup(void)
+fore200e_module_exit(void)
 {
     while (fore200e_boards) {
 	fore200e_cleanup(&fore200e_boards);
@@ -2926,8 +2927,7 @@
 }
 
 module_init(fore200e_module_init);
-module_exit(fore200e_module_cleanup);
-#endif
+module_exit(fore200e_module_exit);
 
 
 static const struct atmdev_ops fore200e_ops =
diff -r -u linux-2.4.9/drivers/atm/horizon.c linux/drivers/atm/horizon.c
--- linux-2.4.9/drivers/atm/horizon.c	Fri Dec 29 14:35:47 2000
+++ linux/drivers/atm/horizon.c	Mon Aug 20 04:54:23 2001
@@ -352,6 +352,19 @@
   
 */
 
+#if LINUX_VERSION_CODE >= 0x020400 && defined(MODULE)
+static struct pci_device_id horizon_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_MADGE,
+	  device: PCI_DEVICE_ID_MADGE_HORIZON,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, horizon_pci_tbl);
+#endif
+
 /********** globals **********/
 
 static hrz_dev * hrz_devs = NULL;
@@ -2930,7 +2943,6 @@
   return;
 }
 
-#ifdef MODULE
 EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR(maintainer_string);
@@ -2946,9 +2958,7 @@
 MODULE_PARM_DESC(max_rx_size, "maximum size of RX AAL5 frames");
 MODULE_PARM_DESC(pci_lat, "PCI latency in bus cycles");
 
-/********** module entry **********/
-
-int init_module (void) {
+static int __init horizon_init (void) {
   int devs;
   
   // sanity check - cast is needed since printk does not support %Zu
@@ -2981,7 +2991,7 @@
 
 /********** module exit **********/
 
-void cleanup_module (void) {
+static void __exit horizon_exit (void) {
   hrz_dev * dev;
   PRINTD (DBG_FLOW, "cleanup_module");
   
@@ -3004,40 +3014,5 @@
   return;
 }
 
-#else
-
-/********** monolithic entry **********/
-
-int __init hrz_detect (void) {
-  int devs;
-  
-  // sanity check - cast is needed since printk does not support %Zu
-  if (sizeof(struct MEMMAP) != 128*1024/4) {
-    PRINTK (KERN_ERR, "Fix struct MEMMAP (is %lu fakewords).",
-	    (unsigned long) sizeof(struct MEMMAP));
-    return 0;
-  }
-  
-  show_version();
-  
-  // what about command line arguments?
-  // check arguments
-  hrz_check_args();
-  
-  // get the juice
-  devs = hrz_probe();
-  
-  if (devs) {
-    init_timer (&housekeeping);
-    housekeeping.function = do_housekeeping;
-    // paranoia
-    housekeeping.data = 1;
-    set_timer (&housekeeping, 0);
-  } else {
-    PRINTK (KERN_ERR, "no (usable) adapters found");
-  }
-
-  return devs;
-}
-
-#endif
+module_init(horizon_init);
+module_exit(horizon_exit);
diff -r -u linux-2.4.9/drivers/atm/iphase.c linux/drivers/atm/iphase.c
--- linux-2.4.9/drivers/atm/iphase.c	Thu Jun 28 14:48:08 2001
+++ linux/drivers/atm/iphase.c	Mon Aug 20 04:54:23 2001
@@ -89,6 +89,17 @@
             |IF_IADBG_ABR | IF_IADBG_EVENT*/ 0; 
 
 #ifdef MODULE
+static struct pci_device_id iphase_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_IPHASE,
+	  device: PCI_DEVICE_ID_IPHASE_5575,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, iphase_pci_tbl);
+
 MODULE_PARM(IA_TX_BUF, "i");
 MODULE_PARM(IA_TX_BUF_SZ, "i");
 MODULE_PARM(IA_RX_BUF, "i");
@@ -3160,11 +3171,7 @@
 };  
 	  
   
-#if LINUX_VERSION_CODE >= 0x20312
-int __init ia_detect(void)
-#else
-__initfunc(int ia_detect(void)) 
-#endif 
+static int __init ia_module_init(void)
 {  
 	struct atm_dev *dev;  
 	IADEV *iadev;  
@@ -3173,7 +3180,7 @@
 	struct pci_dev *prev_dev;       
 	if (!pci_present()) {  
 		printk(KERN_ERR DEV_LABEL " driver but no PCI BIOS ?\n");  
-		return 0;  
+		return -ENODEV;  
 	}  
 	iadev = (IADEV *)kmalloc(sizeof(IADEV), GFP_KERNEL); 
 	if (!iadev) return -ENOMEM;  
@@ -3218,28 +3225,17 @@
                 memset((char*)iadev, 0, sizeof(IADEV)); 
 		index++;  
                 dev = NULL;
-	}  
-	return index;  
-}  
-  
+	}
+	if (index == 0)
+		return -ENODEV;
 
-#ifdef MODULE  
-  
-int init_module(void)  
-{  
-	IF_EVENT(printk(">ia init_module\n");)  
-	if (!ia_detect()) {  
-		printk(KERN_ERR DEV_LABEL ": no adapter found\n");  
-		return -ENXIO;  
-	}  
    	ia_timer.expires = jiffies + 3*HZ;
    	add_timer(&ia_timer); 
-   
-	return 0;  
+ 	return 0;
 }  
   
-  
-void cleanup_module(void)  
+
+static void __exit ia_exit(void)  
 {  
 	struct atm_dev *dev;  
 	IADEV *iadev;  
@@ -3291,5 +3287,5 @@
         }
 }  
 
-#endif  
-
+module_init(ia_module_init);
+module_exit(ia_exit);
diff -r -u linux-2.4.9/drivers/atm/nicstar.c linux/drivers/atm/nicstar.c
--- linux-2.4.9/drivers/atm/nicstar.c	Sun Jul 15 16:15:44 2001
+++ linux/drivers/atm/nicstar.c	Mon Aug 20 04:54:23 2001
@@ -272,12 +272,22 @@
 static char *mac[NS_MAX_CARDS];
 MODULE_PARM(mac, "1-" __MODULE_STRING(NS_MAX_CARDS) "s");
 
+#ifdef MODULE
+static struct pci_device_id nicstar_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_IDT,
+	  device: PCI_DEVICE_ID_IDT_IDT77201,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, nicstar_pci_tbl);
+#endif
 
 /* Functions*******************************************************************/
 
-#ifdef MODULE
-
-int __init init_module(void)
+static int __init nicstar_init(void)
 {
    int i;
    unsigned error = 0;	/* Initialized to remove compile warning */
@@ -334,7 +344,7 @@
 
 
 
-void cleanup_module(void)
+static void __exit nicstar_exit(void)
 {
    int i, j;
    unsigned short pci_command;
@@ -419,59 +429,6 @@
 }
 
 
-#else
-
-int __init nicstar_detect(void)
-{
-   int i;
-   unsigned error = 0;	/* Initialized to remove compile warning */
-   struct pci_dev *pcidev;
-
-   if(!pci_present())
-   {
-      printk("nicstar: no PCI subsystem found.\n");
-      return -EIO;
-   }
-
-   for(i = 0; i < NS_MAX_CARDS; i++)
-      cards[i] = NULL;
-
-   pcidev = NULL;
-   for(i = 0; i < NS_MAX_CARDS; i++)
-   {
-      if ((pcidev = pci_find_device(PCI_VENDOR_ID_IDT,
-                                    PCI_DEVICE_ID_IDT_IDT77201,
-                                    pcidev)) == NULL)
-         break;
-
-      error = ns_init_card(i, pcidev);
-      if (error)
-         cards[i--] = NULL;	/* Try to find another card but don't increment index */
-   }
-
-   if (i == 0 && error)
-      return -EIO;
-
-   TXPRINTK("nicstar: TX debug enabled.\n");
-   RXPRINTK("nicstar: RX debug enabled.\n");
-   PRINTK("nicstar: General debug enabled.\n");
-#ifdef PHY_LOOPBACK
-   printk("nicstar: using PHY loopback.\n");
-#endif /* PHY_LOOPBACK */
-   XPRINTK("nicstar: init_module() returned.\n");
-
-   init_timer(&ns_timer);
-   ns_timer.expires = jiffies + NS_POLL_PERIOD;
-   ns_timer.data = 0UL;
-   ns_timer.function = ns_poll;
-   add_timer(&ns_timer);
-   return i;
-}
-
-
-#endif /* MODULE */
-
-
 static u32 ns_read_sram(ns_dev *card, u32 sram_address)
 {
    unsigned long flags;
@@ -3155,3 +3112,6 @@
    spin_unlock_irqrestore(&card->res_lock, flags);
    return (unsigned char) data;
 }
+
+module_init(nicstar_init);
+module_exit(nicstar_exit);
diff -r -u linux-2.4.9/drivers/atm/zatm.c linux/drivers/atm/zatm.c
--- linux-2.4.9/drivers/atm/zatm.c	Wed Jun 27 16:19:07 2001
+++ linux/drivers/atm/zatm.c	Mon Aug 20 06:22:59 2001
@@ -1801,68 +1801,77 @@
 };
 
 
-int __init zatm_detect(void)
+int __devinit zatm_probe(struct pci_dev *pci_dev,
+			 const struct pci_device_id *id)
 {
 	struct atm_dev *dev;
 	struct zatm_dev *zatm_dev;
-	int devs,type;
 
-	zatm_dev = (struct zatm_dev *) kmalloc(sizeof(struct zatm_dev),
-	    GFP_KERNEL);
-	if (!zatm_dev) return -ENOMEM;
-	devs = 0;
-	for (type = 0; type < 2; type++) {
-		struct pci_dev *pci_dev;
-
-		pci_dev = NULL;
-		while ((pci_dev = pci_find_device(PCI_VENDOR_ID_ZEITNET,type ?
-		    PCI_DEVICE_ID_ZEITNET_1225 : PCI_DEVICE_ID_ZEITNET_1221,
-		    pci_dev))) {
-			if (pci_enable_device(pci_dev)) break;
-			dev = atm_dev_register(DEV_LABEL,&ops,-1,NULL);
-			if (!dev) break;
-			zatm_dev->pci_dev = pci_dev;
-			ZATM_DEV(dev) = zatm_dev;
-			zatm_dev->copper = type;
-			if (zatm_init(dev) || zatm_start(dev)) {
-				atm_dev_deregister(dev);
-				break;
-			}
-			zatm_dev->more = zatm_boards;
-			zatm_boards = dev;
-			devs++;
-			zatm_dev = (struct zatm_dev *) kmalloc(sizeof(struct
-			    zatm_dev),GFP_KERNEL);
-			if (!zatm_dev) {
-				printk(KERN_EMERG "zatm.c: memory shortage\n");
-				return devs;
-			}
-		}
+	if (pci_enable_device(pci_dev))
+		return -ENODEV;
+
+	if ((zatm_dev = kmalloc(sizeof(struct zatm_dev), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	dev = atm_dev_register(DEV_LABEL,&ops,-1,NULL);
+	if (!dev) {
+		kfree(zatm_dev);
+		return -ENOMEM;
 	}
-	kfree(zatm_dev);
-	return devs;
+	zatm_dev->pci_dev = pci_dev;
+	ZATM_DEV(dev) = zatm_dev;
+	zatm_dev->copper = (id->device == PCI_DEVICE_ID_ZEITNET_1221);
+	if (zatm_init(dev) || zatm_start(dev)) {
+		atm_dev_deregister(dev);
+		kfree(zatm_dev);
+		return -EIO;
+	}
+	zatm_dev->more = zatm_boards;
+	zatm_boards = dev;
+	MOD_INC_USE_COUNT;	/* Currently not removable if at least
+				   one card is found. */
+	return 0;
 }
 
+static void __devexit zatm_remove(struct pci_dev *pci_dev)
+{
+	/* STUB */
+}
 
-#ifdef MODULE
- 
-int init_module(void)
+
+static struct pci_device_id zatm_pci_tbl[] __devinitdata = {
+	{
+	  vendor: PCI_VENDOR_ID_ZEITNET,
+	  device: PCI_DEVICE_ID_ZEITNET_1221,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_ZEITNET,
+	  device: PCI_DEVICE_ID_ZEITNET_1225,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, zatm_pci_tbl);
+
+static struct pci_driver zatm_driver = {
+	name:		"zatm",
+	id_table: 	zatm_pci_tbl,
+	probe:		zatm_probe,
+	remove:		zatm_remove,
+};
+
+static int __init zatm_module_init(void)
 {
-	if (!zatm_detect()) {
-		printk(KERN_ERR DEV_LABEL ": no adapter found\n");
-		return -ENXIO;
-	}
-	MOD_INC_USE_COUNT;
-	return 0;
+	return pci_register_driver(&zatm_driver);
 }
  
  
-void cleanup_module(void)
+static void __exit zatm_exit(void)
 {
-	/*
-	 * Well, there's no way to get rid of the driver yet, so we don't
-	 * have to clean up, right ? :-)
-	 */
+	pci_unregister_driver(&zatm_driver);
 }
- 
-#endif
+module_init(zatm_module_init);
+module_exit(zatm_exit);

--M9NhX3UHpAaciwkO--
