Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135208AbRDRPcX>; Wed, 18 Apr 2001 11:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135209AbRDRPcP>; Wed, 18 Apr 2001 11:32:15 -0400
Received: from pak218.pakuni.net ([207.91.34.218]:48644 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S135208AbRDRPcG>;
	Wed, 18 Apr 2001 11:32:06 -0400
Date: Wed, 18 Apr 2001 11:07:53 -0500 (CDT)
From: Mike Phillips <mikep@linuxtr.net>
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Subject: [PATCH] Updated Olympic Driver
Message-ID: <Pine.LNX.4.10.10104181102180.5458-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch for the latest olympic driver. 

This updates the driver to use the netdev api, pci dma, alloc_trdev &
friends, fixes cardbus ejection, adds support for the zSeries and changes
network_monitor from a compile time option to a module parameter. 

The patch is against 2.4.3 clean, and applies against 2.4.3-ac9 with a
small offset in MAINTAINERS.

Thanks
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net

diff -urN --exclude-from=dontdiff linux-2.4.3.clean/Documentation/networking/olympic.txt linux-2.4.3.olympic/Documentation/networking/olympic.txt
--- linux-2.4.3.clean/Documentation/networking/olympic.txt	Fri Jul 28 15:50:51 2000
+++ linux-2.4.3.olympic/Documentation/networking/olympic.txt	Wed Apr 18 08:37:46 2001
@@ -3,18 +3,21 @@
 
 Release 0.2.0 - Release    
 	June 8th 1999 Peter De Schrijver & Mike Phillips
-
+Release 0.9.C - Release
+	April 18th 2001 Mike Phillips
 
 Thanks:
 Erik De Cock, Adrian Bridgett and Frank Fiene for their 
-patience and testing.  
-Paul Norton without whose tr.c code we would have had
-a lot more work to do.
+patience and testing.
+Donald Champion for the cardbus support
+Kyle Lucke for the dma api changes.   
+Jonathon Bitner for hardware support. 
+Everybody on linux-tr for their continued support.  
  
 Options:
 
-The driver accepts three options: ringspeed, pkt_buf_sz, and  
-message_level.
+The driver accepts four options: ringspeed, pkt_buf_sz,  
+message_level and network_monitor.
 
 These options can be specified differently for each card found. 
 
@@ -40,6 +43,17 @@
 value will display all soft messages as well.  NB This does not turn 
 debugging messages on, that must be done by modified the source code.
 
+network_monitor: Any non-zero value will provide a quasi network monitoring 
+mode.  All unexpected MAC frames (beaconing etc.) will be received
+by the driver and the source and destination addresses printed. 
+Also an entry will be added in  /proc/net called olympic_tr%d, where tr%d
+is the registered device name, i.e tr0, tr1, etc. This displays low
+level information about the configuration of the ring and the adapter.
+This feature has been designed for network administrators to assist in 
+the diagnosis of network / ring problems. (This used to OLYMPIC_NETWORK_MONITOR,
+but has now changed to allow each adapter to be configured differently and
+to alleviate the necessity to re-compile olympic to turn the option on).
+
 Multi-card:
 
 The driver will detect multiple cards and will work with shared interrupts,
@@ -60,16 +74,6 @@
 building routers, gateway's etc, you could start to use a lot of memory
 real fast.
 
-Network Monitor Mode:
-
-By modifying the #define OLYMPIC_NETWORK_MONITOR from 0 to 1 in the 
-source code the driver will implement a quasi network monitoring 
-mode.  All unexpected MAC frames (beaconing etc.) will be received
-by the driver and the source and destination addresses printed. 
-Also an entry will be added in  /proc/net called olympic_tr. This 
-displays low level information about the configuration of the ring and
-the adapter. This feature has been designed for network administrators
-to assist in the diagnosis of network / ring problems.
 
 6/8/99 Peter De Schrijver and Mike Phillips
 
diff -urN --exclude-from=dontdiff linux-2.4.3.clean/MAINTAINERS linux-2.4.3.olympic/MAINTAINERS
--- linux-2.4.3.clean/MAINTAINERS	Sun Mar 25 21:14:20 2001
+++ linux-2.4.3.olympic/MAINTAINERS	Sun Apr  1 19:22:08 2001
@@ -917,9 +917,9 @@
 P:	Peter De Shrijver
 M:	p2@ace.ulyssis.sutdent.kuleuven.ac.be	
 P:	Mike Phillips
-M:	phillim@amtrak.com
+M:	mikep@linuxtr.net 
 L:	linux-net@vger.kernel.org
-L:	linux-tr@emissary.aus-etc.com
+L:	linux-tr@linuxtr.net
 W:	http://www.linuxtr.net
 S:	Maintained
 
diff -urN --exclude-from=dontdiff linux-2.4.3.clean/drivers/net/Space.c linux-2.4.3.olympic/drivers/net/Space.c
--- linux-2.4.3.clean/drivers/net/Space.c	Tue Feb 13 16:15:05 2001
+++ linux-2.4.3.olympic/drivers/net/Space.c	Sun Apr  1 19:22:08 2001
@@ -544,7 +544,6 @@
 #ifdef CONFIG_TR
 /* Token-ring device probe */
 extern int ibmtr_probe(struct net_device *);
-extern int olympic_probe(struct net_device *);
 extern int smctr_probe(struct net_device *);
 
 static int
@@ -553,9 +552,6 @@
     if (1
 #ifdef CONFIG_IBMTR
 	&& ibmtr_probe(dev)
-#endif
-#ifdef CONFIG_IBMOL
-	&& olympic_probe(dev)
 #endif
 #ifdef CONFIG_SMCTR
 	&& smctr_probe(dev)
diff -urN --exclude-from=dontdiff linux-2.4.3.clean/drivers/net/tokenring/olympic.c linux-2.4.3.olympic/drivers/net/tokenring/olympic.c
--- linux-2.4.3.clean/drivers/net/tokenring/olympic.c	Tue Mar 20 15:05:00 2001
+++ linux-2.4.3.olympic/drivers/net/tokenring/olympic.c	Wed Apr 18 08:38:07 2001
@@ -1,6 +1,6 @@
 /*
  *   olympic.c (c) 1999 Peter De Schrijver All Rights Reserved
- *		   1999 Mike Phillips (mikep@linuxtr.net)
+ *		   1999/2000 Mike Phillips (mikep@linuxtr.net)
  *
  *  Linux driver for IBM PCI tokenring cards based on the Pit/Pit-Phy/Olympic
  *  chipset. 
@@ -38,10 +38,21 @@
  *            Fixing the hardware descriptors was another matter,
  *            because they weren't going through read[wl](), there all
  *            the results had to be in memory in le32 values. kdaaker
+ *
  * 12/23/00 - Added minimal Cardbus support (Thanks Donald).
  *
+ * 03/09/01 - Add new pci api, dev_base_lock, general clean up. 
+ *
+ * 03/27/01 - Add new dma pci (Thanks to Kyle Lucke) and alloc_trdev
+ *	      Change proc_fs behaviour, now one entry per adapter.
+ *
+ * 04/09/01 - Couple of bug fixes to the dma unmaps and ejecting the
+ *	      adapter when live does not take the system down with it.
+ * 
  *  To Do:
- *           Complete full Cardbus / hot-swap support.
+ *
+ *	     Complete full Cardbus / hot-swap support.
+ *	     Wake on lan	
  * 
  *  If Problems do Occur
  *  Most problems can be rectified by either closing and opening the interface
@@ -53,14 +64,6 @@
 
 #define OLYMPIC_DEBUG 0
 
-/* Change OLYMPIC_NETWORK_MONITOR to receive mac frames through the arb channel.
- * Will also create a /proc/net/olympic_tr entry if proc_fs is compiled into the
- * kernel.
- * Intended to be used to create a ring-error reporting network module 
- * i.e. it will give you the source address of beaconers on the ring 
- */
-
-#define OLYMPIC_NETWORK_MONITOR 0
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -100,14 +103,7 @@
  */
 
 static char *version = 
-"Olympic.c v0.5.C 12/23/00 - Peter De Schrijver & Mike Phillips" ; 
-
-static struct pci_device_id olympic_pci_tbl[] __initdata = {
-	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR_WAKE, PCI_ANY_ID, PCI_ANY_ID, },
-	{ }			/* Terminating entry */
-};
-MODULE_DEVICE_TABLE(pci, olympic_pci_tbl);
-
+"Olympic.c v0.9.C 4/18/01 - Peter De Schrijver & Mike Phillips" ; 
 
 static char *open_maj_error[]  = {"No error", "Lobe Media Test", "Physical Insertion",
 				   "Address Verification", "Neighbor Notification (Ring Poll)",
@@ -137,22 +133,34 @@
  */
 
 static int ringspeed[OLYMPIC_MAX_ADAPTERS] = {0,} ;
-
 MODULE_PARM(ringspeed, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i");
 
 /* Packet buffer size */
 
 static int pkt_buf_sz[OLYMPIC_MAX_ADAPTERS] = {0,} ;
- 
 MODULE_PARM(pkt_buf_sz, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i") ; 
 
 /* Message Level */
 
 static int message_level[OLYMPIC_MAX_ADAPTERS] = {0,} ; 
-
 MODULE_PARM(message_level, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i") ; 
 
-static int olympic_scan(struct net_device *dev);
+/* Change network_monitor to receive mac frames through the arb channel.
+ * Will also create a /proc/net/olympic_tr%d entry, where %d is the tr
+ * device, i.e. tr0, tr1 etc. 
+ * Intended to be used to create a ring-error reporting network module 
+ * i.e. it will give you the source address of beaconers on the ring 
+ */
+static int network_monitor[OLYMPIC_MAX_ADAPTERS] = {0,};
+MODULE_PARM(network_monitor, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i");
+
+static struct pci_device_id olympic_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_IBM,PCI_DEVICE_ID_IBM_TR_WAKE,PCI_ANY_ID,PCI_ANY_ID,},
+	{ } 	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci,olympic_pci_tbl) ; 
+
+static int __init olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent); 
 static int olympic_init(struct net_device *dev);
 static int olympic_open(struct net_device *dev);
 static int olympic_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -165,109 +173,89 @@
 static int olympic_change_mtu(struct net_device *dev, int mtu);
 static void olympic_srb_bh(struct net_device *dev) ; 
 static void olympic_asb_bh(struct net_device *dev) ; 
-#if OLYMPIC_NETWORK_MONITOR
-#ifdef CONFIG_PROC_FS
-static int sprintf_info(char *buffer, struct net_device *dev) ; 
-#endif
-#endif
+static int olympic_proc_info(char *buffer, char **start, off_t offset, int length, int *eof, void *data) ; 
 
-int __init olympic_probe(struct net_device *dev)
+static int __init olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	int cards_found;
+	struct net_device *dev ; 
+	struct olympic_private *olympic_priv;
+	static int card_no = -1 ;
+	int i ; 
 
-	cards_found=olympic_scan(dev);
-	return cards_found ? 0 : -ENODEV;
-}
+	card_no++ ; 
 
-static int __init olympic_scan(struct net_device *dev)
-{
-	struct pci_dev *pci_device = NULL ;
-	struct olympic_private *olympic_priv;
-	int card_no = 0 ;
-	if (pci_present()) {
+	if ((i = pci_enable_device(pdev))) {
+		return i ; 
+	}
 
-		while((pci_device=pci_find_device(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR_WAKE, pci_device))) {
-			__u16 pci_command ; 
+	pci_set_master(pdev);
 
-			if (pci_enable_device(pci_device))
-				continue;
+	if ((i = pci_request_regions(pdev,"olympic"))) { 
+		return i ; 
+	} ; 
+ 
+	dev = alloc_trdev(sizeof(struct olympic_private)) ; 
 
-			/* These lines are needed by the PowerPC, it appears that these flags
-			 * are not being set properly for the PPC, this may well be fixed with
-			 * the new PCI code */ 
-			pci_read_config_word(pci_device, PCI_COMMAND, &pci_command);
-			pci_command |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
-			pci_write_config_word(pci_device, PCI_COMMAND,pci_command);
-			pci_set_master(pci_device);
-
-			/* Check to see if io has been allocated, if so, we've already done this card,
-			   so continue on the card discovery loop  */
-
-			if (check_region(pci_resource_start(pci_device, 0), OLYMPIC_IO_SPACE)) {
-				card_no++ ; 
-				continue ; 
-			}
+	if (!dev) {
+		pci_release_regions(pdev) ; 
+		return -ENOMEM ; 
+	}
 
-			olympic_priv=kmalloc(sizeof (struct olympic_private), GFP_KERNEL);
-			if (!olympic_priv)
-				return 0;
-			memset(olympic_priv, 0, sizeof(struct olympic_private));
-			init_waitqueue_head(&olympic_priv->srb_wait);
-			init_waitqueue_head(&olympic_priv->trb_wait);
-#ifndef MODULE
-			dev = init_trdev(NULL, 0);
-			if (!dev) {
-				kfree(olympic_priv);
-				return 0;
-			}
-#endif
-			dev->priv=(void *)olympic_priv;
+	olympic_priv = dev->priv ;
+	
+	init_waitqueue_head(&olympic_priv->srb_wait);
+	init_waitqueue_head(&olympic_priv->trb_wait);
 #if OLYMPIC_DEBUG  
-			printk("pci_device: %p, dev:%p, dev->priv: %p\n", pci_device, dev, dev->priv);
+	printk(KERN_INFO "pci_device: %p, dev:%p, dev->priv: %p\n", pdev, dev, dev->priv);
 #endif
-			dev->irq=pci_device->irq;
-			dev->base_addr=pci_resource_start(pci_device, 0);
-			dev->init=&olympic_init;	/* AKPM: Not needed */
-			olympic_priv->olympic_card_name = (char *)pci_device->resource[0].name ; 
-			/* FIXME: check ioremap return val, handle cleanup */
-			olympic_priv->olympic_mmio = 
-				ioremap(pci_resource_start(pci_device,1),256);
-			olympic_priv->olympic_lap = 
-				ioremap(pci_resource_start(pci_device,2),2048);
-			
-			if ((pkt_buf_sz[card_no] < 100) || (pkt_buf_sz[card_no] > 18000) )
-				olympic_priv->pkt_buf_sz = PKT_BUF_SZ ; 
-			else
-				olympic_priv->pkt_buf_sz = pkt_buf_sz[card_no] ; 
-
-			olympic_priv->olympic_ring_speed = ringspeed[card_no] ; 
-			olympic_priv->olympic_message_level = message_level[card_no] ; 
-	
-			if(olympic_init(dev)==-1) {
-				kfree(dev->priv);
-#ifndef MODULE
-				unregister_netdev(dev);
-				kfree(dev);
-#endif
-				return 0;
-			}				
+	dev->irq=pdev->irq;
+	dev->base_addr=pci_resource_start(pdev, 0);
+	dev->init=NULL; /* Must be NULL otherwise we get called twice */
+	olympic_priv->olympic_card_name = (char *)pdev->name ; 
+	olympic_priv->olympic_mmio = ioremap(pci_resource_start(pdev,1),256);
+	olympic_priv->olympic_lap = ioremap(pci_resource_start(pdev,2),2048);
+	olympic_priv->pdev = pdev ; 
+				
+	if ((pkt_buf_sz[card_no] < 100) || (pkt_buf_sz[card_no] > 18000) )
+		olympic_priv->pkt_buf_sz = PKT_BUF_SZ ; 
+	else
+		olympic_priv->pkt_buf_sz = pkt_buf_sz[card_no] ; 
 
-			dev->open=&olympic_open;
-			dev->hard_start_xmit=&olympic_xmit;
-			dev->change_mtu=&olympic_change_mtu;
-
-			dev->stop=&olympic_close;
-			dev->do_ioctl=NULL;
-			dev->set_multicast_list=&olympic_set_rx_mode;
-			dev->get_stats=&olympic_get_stats ;
-			dev->set_mac_address=&olympic_set_mac_address ;  
-			return 1; 
-		}
+	dev->mtu = olympic_priv->pkt_buf_sz - TR_HLEN ; 
+	olympic_priv->olympic_ring_speed = ringspeed[card_no] ; 
+	olympic_priv->olympic_message_level = message_level[card_no] ; 
+	olympic_priv->olympic_network_monitor = network_monitor[card_no];
+	
+	if((i = olympic_init(dev))) {
+		iounmap(olympic_priv->olympic_mmio) ; 
+		iounmap(olympic_priv->olympic_lap) ; 
+		kfree(dev) ; 
+		pci_release_regions(pdev) ; 
+		return i ; 
+	}				
+
+	dev->open=&olympic_open;
+	dev->hard_start_xmit=&olympic_xmit;
+	dev->change_mtu=&olympic_change_mtu;
+	dev->stop=&olympic_close;
+	dev->do_ioctl=NULL;
+	dev->set_multicast_list=&olympic_set_rx_mode;
+	dev->get_stats=&olympic_get_stats ;
+	dev->set_mac_address=&olympic_set_mac_address ;  
+
+	pci_set_drvdata(pdev,dev) ; 
+	register_netdev(dev) ; 
+	printk("Olympic: %s registered as: %s\n",olympic_priv->olympic_card_name,dev->name);
+	if (olympic_priv->olympic_network_monitor) { /* Must go after register_netdev as we need the device name */ 
+		char proc_name[20] ; 
+		strcpy(proc_name,"net/olympic_") ; 
+		strcat(proc_name,dev->name) ; 
+		create_proc_read_entry(proc_name,0,0,olympic_proc_info,(void *)dev) ; 
+		printk("Olympic: Network Monitor information: /proc/%s\n",proc_name); 
 	}
 	return  0 ;
 }
 
-
 static int __init olympic_init(struct net_device *dev)
 {
     	struct olympic_private *olympic_priv;
@@ -279,17 +267,15 @@
 	olympic_mmio=olympic_priv->olympic_mmio;
 
 	printk("%s \n", version);
-	printk("%s: %s. I/O at %hx, MMIO at %p, LAP at %p, using irq %d\n",dev->name, olympic_priv->olympic_card_name, (unsigned int) dev->base_addr,olympic_priv->olympic_mmio, olympic_priv->olympic_lap, dev->irq);
+	printk("%s. I/O at %hx, MMIO at %p, LAP at %p, using irq %d\n", olympic_priv->olympic_card_name, (unsigned int) dev->base_addr,olympic_priv->olympic_mmio, olympic_priv->olympic_lap, dev->irq);
 
-	request_region(dev->base_addr, OLYMPIC_IO_SPACE, "olympic");
 	writel(readl(olympic_mmio+BCTL) | BCTL_SOFTRESET,olympic_mmio+BCTL);
 	t=jiffies;
 	while((readl(olympic_priv->olympic_mmio+BCTL)) & BCTL_SOFTRESET) {
 		schedule();		
 		if(jiffies-t > 40*HZ) {
 			printk(KERN_ERR "IBM PCI tokenring card not responding.\n");
-			release_region(dev->base_addr, OLYMPIC_IO_SPACE) ; 
-			return -1;
+			return -ENODEV;
 		}
 	}
 
@@ -313,14 +299,14 @@
 	if (olympic_priv->olympic_ring_speed  == 0) { /* Autosense */
 		writel(readl(olympic_mmio+GPR)|GPR_AUTOSENSE,olympic_mmio+GPR);
 		if (olympic_priv->olympic_message_level) 
-			printk(KERN_INFO "%s: Ringspeed autosense mode on\n",dev->name);
+			printk(KERN_INFO "%s: Ringspeed autosense mode on\n",olympic_priv->olympic_card_name);
 	} else if (olympic_priv->olympic_ring_speed == 16) {
 		if (olympic_priv->olympic_message_level) 
-			printk(KERN_INFO "%s: Trying to open at 16 Mbps as requested\n", dev->name);
+			printk(KERN_INFO "%s: Trying to open at 16 Mbps as requested\n", olympic_priv->olympic_card_name);
 		writel(GPR_16MBPS, olympic_mmio+GPR);
 	} else if (olympic_priv->olympic_ring_speed == 4) {
 		if (olympic_priv->olympic_message_level) 
-			printk(KERN_INFO "%s: Trying to open at 4 Mbps as requested\n", dev->name) ; 
+			printk(KERN_INFO "%s: Trying to open at 4 Mbps as requested\n", olympic_priv->olympic_card_name) ; 
 		writel(0, olympic_mmio+GPR);
 	} 
 	
@@ -335,10 +321,9 @@
 	t=jiffies;
 	while(!((readl(olympic_mmio+SISR_RR)) & SISR_SRB_REPLY)) {
 		schedule();		
-		if(jiffies-t > 40*HZ) {
+		if(jiffies-t > 15*HZ) {
 			printk(KERN_ERR "IBM PCI tokenring card not responding.\n");
-			release_region(dev->base_addr, OLYMPIC_IO_SPACE); 
-			return -1;
+			return -ENODEV;
 		}
 	}
 	
@@ -361,8 +346,7 @@
 #endif	
 	if(readw(init_srb+6)) {
 		printk(KERN_INFO "tokenring card intialization failed. errorcode : %x\n",readw(init_srb+6));
-		release_region(dev->base_addr, OLYMPIC_IO_SPACE);
-		return -1;
+		return -ENODEV;
 	}
 
 	if (olympic_priv->olympic_message_level) {
@@ -401,15 +385,10 @@
 {
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
 	__u8 *olympic_mmio=olympic_priv->olympic_mmio,*init_srb;
-	unsigned long flags;
+	unsigned long flags, t;
 	char open_error[255] ; 
 	int i, open_finished = 1 ;
 
-#if OLYMPIC_NETWORK_MONITOR
-	__u8 *oat ; 
-	__u8 *opt ; 
-#endif
-
 	if(request_irq(dev->irq, &olympic_interrupt, SA_SHIRQ , "olympic", dev)) {
 		return -EAGAIN;
 	}
@@ -451,12 +430,10 @@
 		writeb(OLYMPIC_CLEAR_RET_CODE,init_srb+2);
 
 		/* If Network Monitor, instruct card to copy MAC frames through the ARB */
-
-#if OLYMPIC_NETWORK_MONITOR
-		writew(swab16(OPEN_ADAPTER_ENABLE_FDX | OPEN_ADAPTER_PASS_ADC_MAC | OPEN_ADAPTER_PASS_ATT_MAC | OPEN_ADAPTER_PASS_BEACON), init_srb+8);
-#else
-		writew(swab16(OPEN_ADAPTER_ENABLE_FDX), init_srb+8);
-#endif		
+		if (olympic_priv->olympic_network_monitor) 
+			writew(swab16(OPEN_ADAPTER_ENABLE_FDX | OPEN_ADAPTER_PASS_ADC_MAC | OPEN_ADAPTER_PASS_ATT_MAC | OPEN_ADAPTER_PASS_BEACON), init_srb+8);
+		else
+			writew(swab16(OPEN_ADAPTER_ENABLE_FDX), init_srb+8);
 
 		if (olympic_priv->olympic_laa[0]) {
 			writeb(olympic_priv->olympic_laa[0],init_srb+12);
@@ -473,17 +450,23 @@
 
 		writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
 
+		t = jiffies ; 
  		while(olympic_priv->srb_queued) {        
         		interruptible_sleep_on_timeout(&olympic_priv->srb_wait, 60*HZ);
         		if(signal_pending(current))	{            
-				printk(KERN_WARNING "%s: SRB timed out.\n",
+				printk(KERN_WARNING "%s: Signal received in open.\n",
                 			dev->name);
-            			printk(KERN_WARNING "SISR=%x MISR=%x\n",
+            			printk(KERN_WARNING "SISR=%x LISR=%x\n",
                 			readl(olympic_mmio+SISR),
                 			readl(olympic_mmio+LISR));
             			olympic_priv->srb_queued=0;
             			break;
         		}
+			if ((jiffies-t) > 60*HZ) { 
+				printk(KERN_WARNING "%s: SRB timed out. \n",dev->name) ; 
+				olympic_priv->srb_queued=0;
+				break ; 
+			} 
     		}
 		restore_flags(flags);
 #if OLYMPIC_DEBUG
@@ -572,7 +555,8 @@
 
 		skb->dev = dev;
 
-		olympic_priv->olympic_rx_ring[i].buffer = cpu_to_le32(virt_to_bus(skb->data));
+		olympic_priv->olympic_rx_ring[i].buffer = cpu_to_le32(pci_map_single(olympic_priv->pdev, 
+							  skb->data,olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE)) ; 
 		olympic_priv->olympic_rx_ring[i].res_length = cpu_to_le32(olympic_priv->pkt_buf_sz); 
 		olympic_priv->rx_ring_skb[i]=skb;
 	}
@@ -583,12 +567,16 @@
 		return -EIO;
 	}
 
-	writel(virt_to_bus(&olympic_priv->olympic_rx_ring[0]), olympic_mmio+RXDESCQ);
-	writel(virt_to_bus(&olympic_priv->olympic_rx_ring[0]), olympic_mmio+RXCDA);
+	olympic_priv->rx_ring_dma_addr = pci_map_single(olympic_priv->pdev,olympic_priv->olympic_rx_ring, 
+					 sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
+	writel(olympic_priv->rx_ring_dma_addr, olympic_mmio+RXDESCQ);
+	writel(olympic_priv->rx_ring_dma_addr, olympic_mmio+RXCDA);
 	writew(i, olympic_mmio+RXDESCQCNT);
 		
-	writel(virt_to_bus(&olympic_priv->olympic_rx_status_ring[0]), olympic_mmio+RXSTATQ);
-	writel(virt_to_bus(&olympic_priv->olympic_rx_status_ring[0]), olympic_mmio+RXCSA);
+	olympic_priv->rx_status_ring_dma_addr = pci_map_single(olympic_priv->pdev, olympic_priv->olympic_rx_status_ring, 
+						sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
+	writel(olympic_priv->rx_status_ring_dma_addr, olympic_mmio+RXSTATQ);
+	writel(olympic_priv->rx_status_ring_dma_addr, olympic_mmio+RXCSA);
 	
  	olympic_priv->rx_ring_last_received = OLYMPIC_RX_RING_SIZE - 1;	/* last processed rx status */
 	olympic_priv->rx_status_last_received = OLYMPIC_RX_RING_SIZE - 1;  
@@ -597,20 +585,22 @@
 
 #if OLYMPIC_DEBUG 
 	printk("# of rx buffers: %d, RXENQ: %x\n",i, readw(olympic_mmio+RXENQ));
-	printk("RXCSA: %x, rx_status_ring[0]: %p\n",bus_to_virt(readl(olympic_mmio+RXCSA)),&olympic_priv->olympic_rx_status_ring[0]);
+	printk("RXCSA: %x, rx_status_ring[0]: %p\n",readl(olympic_mmio+RXCSA),&olympic_priv->olympic_rx_status_ring[0]);
 	printk(" stat_ring[1]: %p, stat_ring[2]: %p, stat_ring[3]: %p\n", &(olympic_priv->olympic_rx_status_ring[1]), &(olympic_priv->olympic_rx_status_ring[2]), &(olympic_priv->olympic_rx_status_ring[3]) );
 	printk(" stat_ring[4]: %p, stat_ring[5]: %p, stat_ring[6]: %p\n", &(olympic_priv->olympic_rx_status_ring[4]), &(olympic_priv->olympic_rx_status_ring[5]), &(olympic_priv->olympic_rx_status_ring[6]) );
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
-	printk("RXCDA: %x, rx_ring[0]: %p\n",bus_to_virt(readl(olympic_mmio+RXCDA)),&olympic_priv->olympic_rx_ring[0]);
+	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
+	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
+%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
 
 #if OLYMPIC_DEBUG 
 	printk("# of rx buffers: %d, RXENQ: %x\n",i, readw(olympic_mmio+RXENQ));
-	printk("RXCSA: %x, rx_ring[0]: %p\n",bus_to_virt(readl(olympic_mmio+RXCSA)),&olympic_priv->olympic_rx_status_ring[0]);
-	printk("RXCDA: %x, rx_ring[0]: %p\n",bus_to_virt(readl(olympic_mmio+RXCDA)),&olympic_priv->olympic_rx_ring[0]);
+	printk("RXCSA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCSA),&olympic_priv->olympic_rx_status_ring[0]);
+	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
 #endif 
 
 	writel(SISR_RX_STATUS | SISR_RX_NOBUF,olympic_mmio+SISR_MASK_SUM);
@@ -622,12 +612,16 @@
 		olympic_priv->olympic_tx_ring[i].buffer=0xdeadbeef;
 
 	olympic_priv->free_tx_ring_entries=OLYMPIC_TX_RING_SIZE;
-	writel(virt_to_bus(&olympic_priv->olympic_tx_ring[0]), olympic_mmio+TXDESCQ_1);
-	writel(virt_to_bus(&olympic_priv->olympic_tx_ring[0]), olympic_mmio+TXCDA_1);
+	olympic_priv->tx_ring_dma_addr = pci_map_single(olympic_priv->pdev,olympic_priv->olympic_tx_ring,
+					 sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE,PCI_DMA_TODEVICE) ; 
+	writel(olympic_priv->tx_ring_dma_addr, olympic_mmio+TXDESCQ_1);
+	writel(olympic_priv->tx_ring_dma_addr, olympic_mmio+TXCDA_1);
 	writew(OLYMPIC_TX_RING_SIZE, olympic_mmio+TXDESCQCNT_1);
 	
-	writel(virt_to_bus(&olympic_priv->olympic_tx_status_ring[0]),olympic_mmio+TXSTATQ_1);
-	writel(virt_to_bus(&olympic_priv->olympic_tx_status_ring[0]),olympic_mmio+TXCSA_1);
+	olympic_priv->tx_status_ring_dma_addr = pci_map_single(olympic_priv->pdev, olympic_priv->olympic_tx_status_ring,
+						sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
+	writel(olympic_priv->tx_status_ring_dma_addr,olympic_mmio+TXSTATQ_1);
+	writel(olympic_priv->tx_status_ring_dma_addr,olympic_mmio+TXCSA_1);
 	writew(OLYMPIC_TX_RING_SIZE,olympic_mmio+TXSTATQCNT_1);
 		
 	olympic_priv->tx_ring_free=0; /* next entry in tx ring to use */
@@ -640,33 +634,32 @@
 	printk("SISR MASK: %x\n",readl(olympic_mmio+SISR_MASK));
 #endif
 
-#if OLYMPIC_NETWORK_MONITOR
-	oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
-	opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
-
-	printk("%s: Node Address: %02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, 
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)), 
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+1),
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+2),
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+3),
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+4),
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+5));
-	printk("%s: Functional Address: %02x:%02x:%02x:%02x\n",dev->name, 
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)), 
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)+1),
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)+2),
-		    readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)+3));
-
-	printk("%s: NAUN Address: %02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, 
+	if (olympic_priv->olympic_network_monitor) { 
+		__u8 *oat ; 
+		__u8 *opt ; 
+		oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
+		opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
+
+		printk("%s: Node Address: %02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, 
+			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)), 
+			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+1),
+			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+2),
+			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+3),
+			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+4),
+			readb(oat+offsetof(struct olympic_adapter_addr_table,node_addr)+5));
+		printk("%s: Functional Address: %02x:%02x:%02x:%02x\n",dev->name, 
+			readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)), 
+			readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)+1),
+			readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)+2),
+			readb(oat+offsetof(struct olympic_adapter_addr_table,func_addr)+3));
+		printk("%s: NAUN Address: %02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, 
 			readb(opt+offsetof(struct olympic_parameters_table, up_node_addr)),
 			readb(opt+offsetof(struct olympic_parameters_table, up_node_addr)+1),
 			readb(opt+offsetof(struct olympic_parameters_table, up_node_addr)+2),
 			readb(opt+offsetof(struct olympic_parameters_table, up_node_addr)+3),
 			readb(opt+offsetof(struct olympic_parameters_table, up_node_addr)+4),
 			readb(opt+offsetof(struct olympic_parameters_table, up_node_addr)+5));
-
-
-#endif 	
+	}
 	
 	netif_start_queue(dev);
 	MOD_INC_USE_COUNT ;
@@ -703,7 +696,6 @@
 		olympic_priv->rx_status_last_received++ ;
 		olympic_priv->rx_status_last_received &= (OLYMPIC_RX_RING_SIZE -1);
 #if OLYMPIC_DEBUG
-		printk(" stat_ring addr: %x \n", &(olympic_priv->olympic_rx_status_ring[olympic_priv->rx_status_last_received]) ); 
 		printk("rx status: %x rx len: %x \n", le32_to_cpu(rx_status->status_buffercnt), le32_to_cpu(rx_status->fragmentcnt_framelen));
 #endif
 		length = le32_to_cpu(rx_status->fragmentcnt_framelen) & 0xffff;
@@ -760,10 +752,17 @@
 						olympic_priv->rx_ring_last_received &= (OLYMPIC_RX_RING_SIZE -1);
 						rx_ring_last_received = olympic_priv->rx_ring_last_received ;
 						skb2=olympic_priv->rx_ring_skb[rx_ring_last_received] ; 
+						/* unmap buffer */
+						pci_unmap_single(olympic_priv->pdev,
+							le32_to_cpu(olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer), 
+							olympic_priv->pkt_buf_sz,PCI_DMA_FROMDEVICE) ; 
 						skb_put(skb2,length);
 						skb2->protocol = tr_type_trans(skb2,dev);
-						olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer = cpu_to_le32(virt_to_bus(skb->data));
-						olympic_priv->olympic_rx_ring[rx_ring_last_received].res_length = cpu_to_le32(olympic_priv->pkt_buf_sz); 
+						olympic_priv->olympic_rx_ring[rx_ring_last_received].buffer = 
+							cpu_to_le32(pci_map_single(olympic_priv->pdev, skb->data, 
+							olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE));
+						olympic_priv->olympic_rx_ring[rx_ring_last_received].res_length = 
+							cpu_to_le32(olympic_priv->pkt_buf_sz); 
 						olympic_priv->rx_ring_skb[rx_ring_last_received] = skb ; 
 						netif_rx(skb2) ; 
 					} else {
@@ -773,13 +772,13 @@
 							rx_ring_last_received = olympic_priv->rx_ring_last_received ; 
 							rx_desc = &(olympic_priv->olympic_rx_ring[rx_ring_last_received]);
 							cpy_length = (i == 1 ? frag_len : le32_to_cpu(rx_desc->res_length)); 
-							memcpy(skb_put(skb, cpy_length), bus_to_virt(le32_to_cpu(rx_desc->buffer)), cpy_length) ; 
+							memcpy(skb_put(skb, cpy_length), olympic_priv->rx_ring_skb[rx_ring_last_received]->data, cpy_length) ;
 						} while (--i) ; 
 		
 						skb->protocol = tr_type_trans(skb,dev);
 						netif_rx(skb) ; 
 					} 
-					dev->last_rx = jiffies ;
+					dev->last_rx = jiffies ; 
 					olympic_priv->olympic_stats.rx_packets++ ; 
 					olympic_priv->olympic_stats.rx_bytes += length ; 
 				} /* if skb == null */
@@ -807,10 +806,15 @@
 	__u32 sisr;
 	__u8 *adapter_check_area ; 
 	
-	sisr=readl(olympic_mmio+SISR_RR) ; /* Reset sisr */ 
-	
+	/* 
+	 *  Read sisr but don't reset it yet. 
+	 *  The indication bit may have been set but the interrupt latch
+	 *  bit may not be set, so we'd lose the interrupt later. 
+	 */ 
+	sisr=readl(olympic_mmio+SISR) ; 
 	if (!(sisr & SISR_MI)) /* Interrupt isn't for us */ 
 		return ;
+	sisr=readl(olympic_mmio+SISR_RR) ;  /* Read & Reset sisr */ 
 
 	spin_lock(&olympic_priv->olympic_lock);
 
@@ -826,15 +830,22 @@
 			olympic_priv->srb_queued=0;
 		} /* SISR_SRB_REPLY */
 
+		/* We shouldn't ever miss the Tx interrupt, but the you never know, hence the loop to ensure
+		   we get all tx completions. */
 		if (sisr & SISR_TX1_EOF) {
-			olympic_priv->tx_ring_last_status++;
-			olympic_priv->tx_ring_last_status &= (OLYMPIC_TX_RING_SIZE-1);
-			olympic_priv->free_tx_ring_entries++;
-			olympic_priv->olympic_stats.tx_bytes += olympic_priv->tx_ring_skb[olympic_priv->tx_ring_last_status]->len;
-			olympic_priv->olympic_stats.tx_packets++ ; 
-			dev_kfree_skb_irq(olympic_priv->tx_ring_skb[olympic_priv->tx_ring_last_status]);
-			olympic_priv->olympic_tx_ring[olympic_priv->tx_ring_last_status].buffer=0xdeadbeef;
-			olympic_priv->olympic_tx_status_ring[olympic_priv->tx_ring_last_status].status=0;
+			while(olympic_priv->olympic_tx_status_ring[(olympic_priv->tx_ring_last_status + 1) & (OLYMPIC_TX_RING_SIZE-1)].status) { 
+				olympic_priv->tx_ring_last_status++;
+				olympic_priv->tx_ring_last_status &= (OLYMPIC_TX_RING_SIZE-1);
+				olympic_priv->free_tx_ring_entries++;
+				olympic_priv->olympic_stats.tx_bytes += olympic_priv->tx_ring_skb[olympic_priv->tx_ring_last_status]->len;
+				olympic_priv->olympic_stats.tx_packets++ ; 
+				pci_unmap_single(olympic_priv->pdev, 
+					le32_to_cpu(olympic_priv->olympic_tx_ring[olympic_priv->tx_ring_last_status].buffer), 
+					olympic_priv->tx_ring_skb[olympic_priv->tx_ring_last_status]->len,PCI_DMA_TODEVICE);
+				dev_kfree_skb_irq(olympic_priv->tx_ring_skb[olympic_priv->tx_ring_last_status]);
+				olympic_priv->olympic_tx_ring[olympic_priv->tx_ring_last_status].buffer=0xdeadbeef;
+				olympic_priv->olympic_tx_status_ring[olympic_priv->tx_ring_last_status].status=0;
+			}
 			netif_wake_queue(dev);
 		} /* SISR_TX1_EOF */
 	
@@ -843,12 +854,39 @@
 		} /* SISR_RX_STATUS */
 	
 		if (sisr & SISR_ADAPTER_CHECK) {
+			int i ; 
+			netif_stop_queue(dev);
 			printk(KERN_WARNING "%s: Adapter Check Interrupt Raised, 8 bytes of information follow:\n", dev->name);
 			writel(readl(olympic_mmio+LAPWWO),olympic_mmio+LAPA);
 			adapter_check_area = (__u8 *)(olympic_mmio+LAPWWO) ; 
 			printk(KERN_WARNING "%s: Bytes %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",dev->name, readb(adapter_check_area+0), readb(adapter_check_area+1), readb(adapter_check_area+2), readb(adapter_check_area+3), readb(adapter_check_area+4), readb(adapter_check_area+5), readb(adapter_check_area+6), readb(adapter_check_area+7)) ; 
-			free_irq(dev->irq, dev) ; 
-	
+			/* The adapter is effectively dead, clean up and exit */
+			for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
+				dev_kfree_skb_irq(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+				if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
+					pci_unmap_single(olympic_priv->pdev, 
+						le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
+						olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
+				}
+				olympic_priv->rx_status_last_received++;
+				olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
+			}
+			/* unmap rings */
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_status_ring_dma_addr, 
+				sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_ring_dma_addr,
+				sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
+
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_status_ring_dma_addr, 
+				sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_ring_dma_addr, 
+				sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
+
+			free_irq(dev->irq, dev) ;
+			MOD_DEC_USE_COUNT ;
+			dev->stop = NULL ;  
+			spin_unlock(&olympic_priv->olympic_lock) ; 
+			return ; 
 		} /* SISR_ADAPTER_CHECK */
 	
 		if (sisr & SISR_ASB_FREE) {
@@ -878,7 +916,6 @@
 		printk(KERN_WARNING "%s: Unexpected interrupt: %x\n",dev->name, sisr);
 		printk(KERN_WARNING "%s: SISR_MASK: %x\n",dev->name, readl(olympic_mmio+SISR_MASK)) ;
 	} /* One if the interrupts we want */
-
 	writel(SISR_MI,olympic_mmio+SISR_MASK_SUM);
 	
 	spin_unlock(&olympic_priv->olympic_lock) ; 
@@ -895,17 +932,15 @@
 	netif_stop_queue(dev);
 	
 	if(olympic_priv->free_tx_ring_entries) {
-		olympic_priv->olympic_tx_ring[olympic_priv->tx_ring_free].buffer = cpu_to_le32(virt_to_bus(skb->data));
+		olympic_priv->olympic_tx_ring[olympic_priv->tx_ring_free].buffer = 
+			cpu_to_le32(pci_map_single(olympic_priv->pdev, skb->data, skb->len,PCI_DMA_TODEVICE));
 		olympic_priv->olympic_tx_ring[olympic_priv->tx_ring_free].status_length = cpu_to_le32(skb->len | (0x80000000));
 		olympic_priv->tx_ring_skb[olympic_priv->tx_ring_free]=skb;
 		olympic_priv->free_tx_ring_entries--;
 
         	olympic_priv->tx_ring_free++;
         	olympic_priv->tx_ring_free &= (OLYMPIC_TX_RING_SIZE-1);
-
-
 		writew((((readw(olympic_mmio+TXENQ_1)) & 0x8000) ^ 0x8000) | 1,olympic_mmio+TXENQ_1);
-
 		netif_wake_queue(dev);
 		spin_unlock_irqrestore(&olympic_priv->olympic_lock,flags);
 		return 0;
@@ -921,7 +956,7 @@
 {
 	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
     	__u8 *olympic_mmio=olympic_priv->olympic_mmio,*srb;
-	unsigned long flags;
+	unsigned long t,flags;
 	int i;
 
 	netif_stop_queue(dev);
@@ -939,18 +974,21 @@
 	olympic_priv->srb_queued=1;
 
 	writel(LISR_SRB_CMD,olympic_mmio+LISR_SUM);
-
+	
+	t = jiffies ; 
 	while(olympic_priv->srb_queued) {
 	        interruptible_sleep_on_timeout(&olympic_priv->srb_wait, jiffies+60*HZ);
         	if(signal_pending(current))	{            
-			printk(KERN_WARNING "%s: SRB timed out.\n",
-                		dev->name);
-            		printk(KERN_WARNING "SISR=%x MISR=%x\n",
-                	readl(olympic_mmio+SISR),
-                	readl(olympic_mmio+LISR));
+			printk(KERN_WARNING "%s: SRB timed out.\n",dev->name);
+            		printk(KERN_WARNING "SISR=%x MISR=%x\n",readl(olympic_mmio+SISR),readl(olympic_mmio+LISR));
             		olympic_priv->srb_queued=0;
             		break;
         	}
+		if ((jiffies-t) > 60*HZ) { 
+			printk(KERN_WARNING "%s: SRB timed out. May not be fatal. \n",dev->name) ; 
+			olympic_priv->srb_queued=0;
+			break ; 
+		} 
     	}
 
 	restore_flags(flags) ; 
@@ -959,9 +997,24 @@
 	
 	for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
 		dev_kfree_skb(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+		if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
+			pci_unmap_single(olympic_priv->pdev, 
+				le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
+				olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
+		}
 		olympic_priv->rx_status_last_received++;
 		olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
 	}
+	/* unmap rings */
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_status_ring_dma_addr, 
+		sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_ring_dma_addr,
+		sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
+
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_status_ring_dma_addr, 
+		sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
+	pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_ring_dma_addr, 
+		sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
 
 	/* reset tx/rx fifo's and busmaster logic */
 
@@ -1239,9 +1292,6 @@
 	__u8 fdx_prot_error ; 
 	__u16 next_ptr;
 	int i ; 
-#if OLYMPIC_NETWORK_MONITOR
-	struct trh_hdr *mac_hdr ; 
-#endif
 
 	arb_block = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->arb) ; 
 	asb_block = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->asb) ; 
@@ -1271,8 +1321,7 @@
 #endif 
 		mac_frame = dev_alloc_skb(frame_len) ; 
 		if (!mac_frame) {
-			printk(KERN_WARNING "%s: Memory squeeze, dropping "
-			       "frame.\n", dev->name);
+			printk(KERN_WARNING "%s: Memory squeeze, dropping frame.\n", dev->name);
 			goto drop_frame;
 		}
 
@@ -1283,19 +1332,19 @@
 			buffer_len = swab16(readw(buf_ptr+offsetof(struct mac_receive_buffer,buffer_length))); 
 			memcpy_fromio(skb_put(mac_frame, buffer_len), frame_data , buffer_len ) ;
 			next_ptr=readw(buf_ptr+offsetof(struct mac_receive_buffer,next)); 
-
 		} while (next_ptr && (buf_ptr=olympic_priv->olympic_lap + ntohs(next_ptr)));
 
-#if OLYMPIC_NETWORK_MONITOR
-		printk(KERN_WARNING "%s: Received MAC Frame, details: \n",dev->name) ;
-		mac_hdr = (struct trh_hdr *)mac_frame->data ; 
-		printk(KERN_WARNING "%s: MAC Frame Dest. Addr: %02x:%02x:%02x:%02x:%02x:%02x \n", dev->name , mac_hdr->daddr[0], mac_hdr->daddr[1], mac_hdr->daddr[2], mac_hdr->daddr[3], mac_hdr->daddr[4], mac_hdr->daddr[5]) ; 
-		printk(KERN_WARNING "%s: MAC Frame Srce. Addr: %02x:%02x:%02x:%02x:%02x:%02x \n", dev->name , mac_hdr->saddr[0], mac_hdr->saddr[1], mac_hdr->saddr[2], mac_hdr->saddr[3], mac_hdr->saddr[4], mac_hdr->saddr[5]) ; 
-#endif
+		if (olympic_priv->olympic_network_monitor) { 
+			struct trh_hdr *mac_hdr ; 
+			printk(KERN_WARNING "%s: Received MAC Frame, details: \n",dev->name) ;
+			mac_hdr = (struct trh_hdr *)mac_frame->data ; 
+			printk(KERN_WARNING "%s: MAC Frame Dest. Addr: %02x:%02x:%02x:%02x:%02x:%02x \n", dev->name , mac_hdr->daddr[0], mac_hdr->daddr[1], mac_hdr->daddr[2], mac_hdr->daddr[3], mac_hdr->daddr[4], mac_hdr->daddr[5]) ; 
+			printk(KERN_WARNING "%s: MAC Frame Srce. Addr: %02x:%02x:%02x:%02x:%02x:%02x \n", dev->name , mac_hdr->saddr[0], mac_hdr->saddr[1], mac_hdr->saddr[2], mac_hdr->saddr[3], mac_hdr->saddr[4], mac_hdr->saddr[5]) ; 
+		}
 		mac_frame->dev = dev ; 
 		mac_frame->protocol = tr_type_trans(mac_frame,dev);
 		netif_rx(mac_frame) ; 	
-		dev->last_rx = jiffies ;
+		dev->last_rx = jiffies;
 
 drop_frame:
 		/* Now tell the card we have dealt with the received frame */
@@ -1351,17 +1400,29 @@
 			writel(readl(olympic_mmio+BCTL)&~(3<<13),olympic_mmio+BCTL);
 			netif_stop_queue(dev);
 			olympic_priv->srb = readw(olympic_priv->olympic_lap + LAPWWO) ; 
-			
-			olympic_priv->rx_status_last_received++;
-			olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
 			for(i=0;i<OLYMPIC_RX_RING_SIZE;i++) {
-				dev_kfree_skb(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+				dev_kfree_skb_irq(olympic_priv->rx_ring_skb[olympic_priv->rx_status_last_received]);
+				if (olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer != 0xdeadbeef) {
+					pci_unmap_single(olympic_priv->pdev, 
+						le32_to_cpu(olympic_priv->olympic_rx_ring[olympic_priv->rx_status_last_received].buffer),
+						olympic_priv->pkt_buf_sz, PCI_DMA_FROMDEVICE);
+				}
 				olympic_priv->rx_status_last_received++;
 				olympic_priv->rx_status_last_received&=OLYMPIC_RX_RING_SIZE-1;
 			}
+			/* unmap rings */
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_status_ring_dma_addr, 
+				sizeof(struct olympic_rx_status) * OLYMPIC_RX_RING_SIZE, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->rx_ring_dma_addr,
+				sizeof(struct olympic_rx_desc) * OLYMPIC_RX_RING_SIZE, PCI_DMA_TODEVICE);
+
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_status_ring_dma_addr, 
+				sizeof(struct olympic_tx_status) * OLYMPIC_TX_RING_SIZE, PCI_DMA_FROMDEVICE);
+			pci_unmap_single(olympic_priv->pdev, olympic_priv->tx_ring_dma_addr, 
+				sizeof(struct olympic_tx_desc) * OLYMPIC_TX_RING_SIZE, PCI_DMA_TODEVICE);
 
 			free_irq(dev->irq,dev);
-			
+			dev->stop=NULL;
 			printk(KERN_WARNING "%s: Adapter has been closed \n", dev->name) ; 
 			MOD_DEC_USE_COUNT ; 
 		} /* If serious error */
@@ -1489,61 +1550,20 @@
 	return 0 ; 
 }
 
-#if OLYMPIC_NETWORK_MONITOR
-#ifdef CONFIG_PROC_FS
 static int olympic_proc_info(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
 {
-	struct pci_dev *pci_device = NULL ;
+	struct net_device *dev = (struct net_device *)data ; 
+	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
+	__u8 *oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
+	__u8 *opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
+	int size = 0 ; 
 	int len=0;
 	off_t begin=0;
 	off_t pos=0;
-	int size;
 	
-	struct net_device *dev;
-
-
 	size = sprintf(buffer, 
-		"IBM Pit/Pit-Phy/Olympic Chipset Token Ring Adapters\n");
-	
-	pos+=size;
-	len+=size;
-	
-
-	while((pci_device=pci_find_device(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR_WAKE, pci_device))) {
-	
-		for (dev = dev_base; dev != NULL; dev = dev->next) 
-		{
-			if (dev->base_addr == pci_device->resource[0].start ) { /* Yep, an Olympic device */	
-				size = sprintf_info(buffer+len, dev);
-				len+=size;
-				pos=begin+len;
-				
-				if(pos<offset)
-				{
-					len=0;
-					begin=pos;
-				}
-				if(pos>offset+length)
-					break;
-			} /* if */
-		} /* for */
-	} /* While */
-
-	*start=buffer+(offset-begin);	/* Start of wanted data */
-	len-=(offset-begin);		/* Start slop */
-	if(len>length)
-		len=length;		/* Ending slop */
-	return len;
-}
-
-static int sprintf_info(char *buffer, struct net_device *dev)
-{
-	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
-	__u8 *oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ; 
-	__u8 *opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ; 
-	int size = 0 ; 
-		
-	size = sprintf(buffer, "\n%6s: Adapter Address   : Node Address      : Functional Addr\n",
+		"IBM Pit/Pit-Phy/Olympic Chipset Token Ring Adapter %s\n",dev->name);
+	size += sprintf(buffer+size, "\n%6s: Adapter Address   : Node Address      : Functional Addr\n",
  	   dev->name); 
 
 	size += sprintf(buffer+size, "%6s: %02x:%02x:%02x:%02x:%02x:%02x : %02x:%02x:%02x:%02x:%02x:%02x : %02x:%02x:%02x:%02x\n",
@@ -1628,70 +1648,56 @@
 	  readb(opt+offsetof(struct olympic_parameters_table, beacon_phys)+2),
 	  readb(opt+offsetof(struct olympic_parameters_table, beacon_phys)+3));
 
- 
-	return size;
+	len=size;
+	pos=begin+size;
+	if (pos<offset) {
+		len=0;
+		begin=pos;
+	}
+	*start=buffer+(offset-begin);	/* Start of wanted data */
+	len-=(offset-begin);		/* Start slop */
+	if(len>length)
+		len=length;		/* Ending slop */
+	return len;
 }
-#endif
-#endif 
-
-#ifdef MODULE
 
-static struct net_device* dev_olympic[OLYMPIC_MAX_ADAPTERS];
-
-int init_module(void)
+static void __devexit olympic_remove_one(struct pci_dev *pdev) 
 {
-        int i;
-
-#if OLYMPIC_NETWORK_MONITOR
-#ifdef CONFIG_PROC_FS
-	create_proc_read_entry("net/olympic_tr",0,0,olympic_proc_info,NULL); 
-#endif
-#endif
-        for (i = 0; (i<OLYMPIC_MAX_ADAPTERS); i++) {
-		dev_olympic[i] = NULL;
-                dev_olympic[i] = init_trdev(dev_olympic[i], 0);
-                if (dev_olympic[i] == NULL) {
-			if (i == 0)
-                        	return -ENOMEM;
-			break;
-		}
-
-		dev_olympic[i]->init      = &olympic_probe;
+	struct net_device *dev = pdev->driver_data ; 
+	struct olympic_private *olympic_priv=(struct olympic_private *)dev->priv;
 
-	        if (register_trdev(dev_olympic[i]) != 0) {
-			kfree(dev_olympic[i]);
-			dev_olympic[i] = NULL;
-		        if (i == 0) {
-			        printk("Olympic: No IBM PCI Token Ring cards found in system.\n");
-		                return -EIO;
-			} else {
-			       	printk("Olympic: %d IBM PCI Token Ring card(s) found in system.\n",i) ; 
-				return 0;
-			}
-	        }
+	if (olympic_priv->olympic_network_monitor) { 
+		char proc_name[20] ; 
+		strcpy(proc_name,"net/olympic_") ; 
+		strcat(proc_name,dev->name) ;
+		remove_proc_entry(proc_name,NULL); 
 	}
+	unregister_trdev(dev) ; 
+	iounmap(olympic_priv->olympic_mmio) ; 
+	iounmap(olympic_priv->olympic_lap) ; 
+	pci_release_regions(pdev) ; 	
+	kfree(dev) ; 
+}
 
-	return 0;
+static struct pci_driver olympic_driver = { 
+	name:		"olympic",
+	id_table:	olympic_pci_tbl,
+	probe:		olympic_probe,
+	remove:		olympic_remove_one
+};
+
+static int __init olympic_pci_init(void) 
+{
+	return pci_module_init (&olympic_driver) ; 
 }
 
-void cleanup_module(void)
+static void __exit olympic_pci_cleanup(void)
 {
-        int i;
+	return pci_unregister_driver(&olympic_driver) ; 
+}	
+
+
+module_init(olympic_pci_init) ; 
+module_exit(olympic_pci_cleanup) ; 
 
-        for (i = 0; i < OLYMPIC_MAX_ADAPTERS; i++)
-	        if (dev_olympic[i]) {
-			 unregister_trdev(dev_olympic[i]);
-			 release_region(dev_olympic[i]->base_addr, OLYMPIC_IO_SPACE);
-			 kfree(dev_olympic[i]->priv);
-			 kfree(dev_olympic[i]);
-			 dev_olympic[i] = NULL;
-                }
-
-#if OLYMPIC_NETWORK_MONITOR
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("net/olympic_tr", NULL) ; 
-#endif 
-#endif
-}
-#endif /* MODULE */
 
diff -urN --exclude-from=dontdiff linux-2.4.3.clean/drivers/net/tokenring/olympic.h linux-2.4.3.olympic/drivers/net/tokenring/olympic.h
--- linux-2.4.3.clean/drivers/net/tokenring/olympic.h	Tue Mar  6 22:28:35 2001
+++ linux-2.4.3.olympic/drivers/net/tokenring/olympic.h	Wed Apr 18 08:38:07 2001
@@ -1,6 +1,6 @@
 /*
  *  olympic.h (c) 1999 Peter De Schrijver All Rights Reserved
- *                1999 Mike Phillips (mikep@linuxtr.net)
+ *                1999,2000 Mike Phillips (mikep@linuxtr.net)
  *
  *  Linux driver for IBM PCI tokenring cards based on the olympic and the PIT/PHY chipset.
  *
@@ -251,6 +251,7 @@
 
 	__u8 *olympic_mmio;
 	__u8 *olympic_lap;
+	struct pci_dev *pdev ; 
 	char *olympic_card_name ; 
 
 	spinlock_t olympic_lock ; 
@@ -263,10 +264,12 @@
 	volatile int trb_queued;   /* True if a TRB is posted */
 	wait_queue_head_t trb_wait ; 
 
+	/* These must be on a 4 byte boundary. */
 	struct olympic_rx_desc olympic_rx_ring[OLYMPIC_RX_RING_SIZE];
 	struct olympic_tx_desc olympic_tx_ring[OLYMPIC_TX_RING_SIZE];
 	struct olympic_rx_status olympic_rx_status_ring[OLYMPIC_RX_RING_SIZE];	
 	struct olympic_tx_status olympic_tx_status_ring[OLYMPIC_TX_RING_SIZE];	
+
 	struct sk_buff *tx_ring_skb[OLYMPIC_TX_RING_SIZE], *rx_ring_skb[OLYMPIC_RX_RING_SIZE];	
 	int tx_ring_free, tx_ring_last_status, rx_ring_last_received,rx_status_last_received, free_tx_ring_entries;
 
@@ -274,9 +277,13 @@
 	__u16 olympic_lan_status ;
 	__u8 olympic_ring_speed ;
 	__u16 pkt_buf_sz ; 
-	__u8 olympic_receive_options, olympic_copy_all_options, olympic_message_level;  
+	__u8 olympic_receive_options, olympic_copy_all_options,olympic_message_level, olympic_network_monitor;  
 	__u16 olympic_addr_table_addr, olympic_parms_addr ; 
 	__u8 olympic_laa[6] ; 
+	__u32 rx_ring_dma_addr;
+	__u32 rx_status_ring_dma_addr;
+	__u32 tx_ring_dma_addr;
+	__u32 tx_status_ring_dma_addr;
 };
 
 struct olympic_adapter_addr_table {


