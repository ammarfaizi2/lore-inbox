Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLSARA>; Mon, 18 Dec 2000 19:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLSAQu>; Mon, 18 Dec 2000 19:16:50 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58741
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129391AbQLSAQh>; Mon, 18 Dec 2000 19:16:37 -0500
Date: Tue, 19 Dec 2000 00:46:04 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Converting drivers/net/rcpci45.c to new PCI API
Message-ID: <20001219004604.B761@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is my attempt at converting the rcpci45 driver (240t13p2) to the new
PCI API interface. I fully expect to have missed something so please
comment away. BTW, I do not consider this the final version of this patch;
therefore the maintainers are not explicitly on the recipients lists.

There are some other cleanups I want to do, and I need to make my indentation
match the drivers, but that will be after the basic conversion is done.


--- linux-240-t13-pre1-clean/drivers/net/rcpci45.c	Sat Nov  4 23:27:08 2000
+++ linux/drivers/net/rcpci45.c	Thu Dec 14 21:41:17 2000
@@ -36,6 +36,8 @@
 **  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 **
 **   
+**  Rasmus Andersen, December 2000: Converted to new PCI API.
+**
 **  Pete Popov, January 11,99: Fixed a couple of 2.1.x problems 
 **  (virt_to_bus() not called), tested it under 2.2pre5 (as a module), and 
 **  added a #define(s) to enable the use of the same file for both, the 2.0.x 
@@ -47,10 +49,6 @@
 **
 ***************************************************************************/
 
-static char *version =
-"RedCreek Communications PCI linux driver version 2.02\n";
-
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -75,6 +73,9 @@
 #include <linux/skbuff.h>
 
 
+static char version[] __initdata =
+"RedCreek Communications PCI linux driver version 2.03\n";
+
 #define RC_LINUX_MODULE
 #include "rclanmtl.h"
 #include "rcif.h"
@@ -123,7 +124,6 @@
     U32    function;
     struct timer_list timer;        /*  timer */
     struct net_device_stats  stats; /* the statistics structure */
-    struct net_device *next;            /* points to the next RC adapter */
     unsigned long numOutRcvBuffers;/* number of outstanding receive buffers*/
     unsigned char shutdown;
     unsigned char reboot;
@@ -138,8 +138,6 @@
 static PDPA  PCIAdapters[MAX_ADAPTERS];
 
 static int RCinit(struct net_device *dev);
-static int RCscan(void);
-static int RCfound_device(int, int, int, int, int, int);
 
 static int RCopen(struct net_device *);
 static int RC_xmit_packet(struct sk_buff *, struct net_device *);
@@ -155,71 +153,29 @@
 static int RC_allocate_and_post_buffers(struct net_device *, int);
 
 
-/* A list of all installed RC devices, for removing the driver module. */
-static struct net_device *root_RCdev;
+static struct pci_device_id rcpci45_pci_table[] __devinitdata = {
+	{ RC_PCI45_VENDOR_ID, RC_PCI45_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, rcpci_pci_table);
 
-static int __init rcpci_init_module (void)
+static void rcpci45_remove_one(struct pci_dev *pdev)
 {
-    int cards_found;
-
-    cards_found = RCscan();
-    if (cards_found)
-        printk(version);
-    return cards_found ? 0 : -ENODEV;
-}
+	struct net_device *dev = pdev->driver_data;
+	PDPA pDpa = dev->priv;
 
-static int RCscan(void)
-{
-    int cards_found = 0;
-    static int pci_index;
-
-    if (!pcibios_present()) 
-        return cards_found;
-
-    for (;pci_index < 0x8; pci_index++) 
-    {
-        unsigned char pci_bus, pci_device_fn;
-        int scan_status;
-        int board_index = 0;
-        unsigned char pci_irq_line;
-        unsigned int pci_ioaddr;
-	struct pci_dev *pdev;
-
-        scan_status =  
-            (pcibios_find_device (RC_PCI45_VENDOR_ID, 
-                                  RC_PCI45_DEVICE_ID, 
-                                  pci_index, 
-                                  &pci_bus, 
-                                  &pci_device_fn));
-#ifdef RCDEBUG
-        printk("rc scan_status = 0x%X\n", scan_status);
-#endif
-        if (scan_status != PCIBIOS_SUCCESSFUL ||
-	    !((pdev = pci_find_slot(pci_bus, pci_device_fn))))
-            break;
-	pci_irq_line = pdev->irq;
-	pci_ioaddr = pci_resource_start (pdev, 0);
+        if (!dev) {
+                printk (KERN_ERR "remove non-existent device\n");
+                return;
+        }
 
-#ifdef RCDEBUG
-        printk("rc: Found RedCreek PCI adapter\n");
-        printk("rc: pci_bus = %d,  pci_device_fn = %d\n", pci_bus, pci_device_fn);
-        printk("rc: pci_irq_line = 0x%x \n", pci_irq_line);
-        printk("rc: pci_ioaddr = 0x%x\n", pci_ioaddr);
-#endif
+	printk("IOP reset: 0x%x\n", RCResetIOP(pDpa->id));
 
-	if (pci_enable_device(pdev))
-		break;
-	pci_set_master(pdev);
+	unregister_netdev(dev);
+	iounmap((void *)dev->base_addr);
+        free_irq(dev->irq, dev);
 
-        if (!RCfound_device(pci_ioaddr, pci_irq_line,
-                          pci_bus, pci_device_fn,
-                          board_index++, cards_found))
-            cards_found++;
-    }
-#ifdef RCDEBUG
-    printk("rc: found %d cards \n", cards_found);
-#endif
-    return cards_found;
+	kfree(dev);
 }
 
 static int RCinit(struct net_device *dev)
@@ -233,17 +189,22 @@
     return 0;
 }
 
-static int
-RCfound_device(int memaddr, int irq, 
-               int bus, int function, int product_index, int card_idx)
+static int rcpci45_init_one(struct pci_dev *pdev, 
+			    const struct pci_device_id *ent)
 {
     int dev_size = 32768;        
     unsigned long *vaddr=0;
     PDPA pDpa;
     int init_status;
 
+    long memaddr = pci_resource_start(pdev, 0);
+    int card_idx;    
     struct net_device *dev;
-    
+
+    static int card_counter = 0;
+
+    card_idx = card_counter++; /* Yeah, icky hack. */
+
     /* 
      * Allocate and fill new device structure. 
      * We need enough for struct net_device plus DPA plus the LAN API private
@@ -256,10 +217,13 @@
     dev = (struct net_device *) kmalloc(dev_size, GFP_DMA | GFP_KERNEL |GFP_ATOMIC);
     if (!dev)
     {
-        printk("rc: unable to kmalloc dev\n");
+        printk("rcpci45 driver: unable to kmalloc dev struct\n");
         return 1;   
     }
     memset(dev, 0, dev_size);
+
+    pdev->driver_data = dev;
+
     /*
      * dev->priv will point to the start of DPA.
      */
@@ -268,15 +232,16 @@
 #ifdef RCDEBUG
     printk("rc: dev = 0x%x, dev->priv = 0x%x\n", (uint)dev, (uint)dev->priv);
 #endif
-
+    
     pDpa = dev->priv;
 
     pDpa->dev = dev;            /* this is just for easy reference */
-    pDpa->function = function;
-    pDpa->bus = bus;
+    pDpa->function = pdev->devfn;
+    pDpa->bus = (unsigned char)pdev->bus->number;
     pDpa->id = card_idx;        /* the device number */
     pDpa->pci_addr = memaddr;
     PCIAdapters[card_idx] = pDpa;
+
 #ifdef RCDEBUG
     printk("rc: pDpa = 0x%x, id = %d \n", (uint)pDpa, (uint)pDpa->id);
 #endif
@@ -300,7 +265,7 @@
            (uint)dev, (uint)dev->priv, (uint)vaddr);
 #endif
     dev->base_addr = (unsigned long)vaddr;
-    dev->irq = irq;
+    dev->irq = pdev->irq;
 
     /*
      * Request a shared interrupt line.
@@ -342,9 +307,6 @@
     dev->init = &RCinit;
     ether_setup(dev);            /* linux kernel interface */
 
-    pDpa->next = root_RCdev;
-    root_RCdev = dev;
-
     if (register_netdev(dev) != 0) /* linux kernel interface */
     {
         printk("rc: unable to register device \n");
@@ -359,6 +321,22 @@
     return 0; /* success */
 }
 
+static struct pci_driver rcpci45_driver = {
+	name: "rcpci45",
+	id_table: rcpci45_pci_table,
+	probe: rcpci45_init_one,
+	remove: rcpci45_remove_one,
+};
+
+static int __init rcpci_init_module (void)
+{
+	int rc = pci_module_init(&rcpci45_driver);
+
+	if (!rc)
+		printk(version);
+	return rc;
+}
+
 static int
 RCopen(struct net_device *dev)
 {
@@ -1185,31 +1163,7 @@
 
 static void __exit rcpci_cleanup_module (void)
 {
-    PDPA pDpa;
-    struct net_device *next;
-
-
-#ifdef RCDEBUG
-    printk("rc: RC cleanup_module\n");
-    printk("rc: root_RCdev = 0x%x\n", (uint)root_RCdev);
-#endif
-
-
-    while (root_RCdev)
-    {
-        pDpa = (PDPA) root_RCdev->priv;
-#ifdef RCDEBUG
-        printk("rc: cleanup 0x%08X\n", (uint)root_RCdev);
-#endif
-        printk("IOP reset: 0x%x\n", RCResetIOP(pDpa->id));
-        unregister_netdev(root_RCdev);
-        next = pDpa->next;
-
-        iounmap((unsigned long *)root_RCdev->base_addr); 
-        free_irq( root_RCdev->irq, root_RCdev );
-        kfree(root_RCdev);
-        root_RCdev = next;
-    }
+	pci_unregister_driver(&rcpci45_driver);
 }
 
 module_init(rcpci_init_module);


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

If a man says something in a forest and there are no women around to 
hear him, is he still wrong? -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
