Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbREXBHb>; Wed, 23 May 2001 21:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbREXBHW>; Wed, 23 May 2001 21:07:22 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:49419 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262389AbREXBHK>; Wed, 23 May 2001 21:07:10 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105240100.DAA27108@green.mif.pg.gda.pl>
Subject: [PATCH] for drivers/net/3com  -ac15
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), akpm@uow.edu.au
Date: Thu, 24 May 2001 03:00:02 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From kufel!ankry  Thu May 24 02:57:39 2001
Return-Path: <kufel!ankry>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id CAA27068
	for green.mif.pg.gda.pl!ankry; Thu, 24 May 2001 02:57:39 +0200
Received: (from ankry@localhost)
	by kufel.dom (8.9.3/8.9.3) id DAA02169
	for ankry@green; Thu, 24 May 2001 03:03:30 +0200
Date: Thu, 24 May 2001 03:03:30 +0200
From: Andrzej Krzysztofowicz <kufel!ankry>
Message-Id: <200105240103.DAA02169@kufel.dom>
To: kufel!green.mif.pg.gda.pl!ankry
Subject: 3com

Hi,
  This version of 3Com network drivers patch contains suggested fixes:

- module version printing moved to init_module() where possible
- fixed wrong description of "full_duplex" parameter
- restored formating strings in version printing for people who need
  literal % in the version strings and ignore warnings ...

Andrzej

***********************************************************************
diff -uNr linux-2.4.4-ac15/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.4.4-ac15/drivers/net/3c501.c	Sat May 19 19:00:45 2001
+++ linux/drivers/net/3c501.c	Thu May 24 02:22:31 2001
@@ -251,7 +251,7 @@
 }
 
 /**
- *	el1_probe: 
+ *	el1_probe1: 
  *	@dev: The device structure to use
  *	@ioaddr: An I/O address to probe at.
  *
@@ -270,6 +270,7 @@
 	unsigned char station_addr[6];
 	int autoirq = 0;
 	int i;
+	static int printed_version;
 
 	/*
 	 *	Reserve I/O resource for exclusive use by this driver
@@ -340,15 +341,17 @@
 	if (autoirq)
 		dev->irq = autoirq;
 
+#ifndef MODULE
+	if (!printed_version++)
+		printk("%s", version);
+#endif /* MODULE */
+
 	printk(KERN_INFO "%s: %s EtherLink at %#lx, using %sIRQ %d.\n", dev->name, mname, dev->base_addr,
 			autoirq ? "auto":"assigned ", dev->irq);
 
 #ifdef CONFIG_IP_MULTICAST
 	printk(KERN_WARNING "WARNING: Use of the 3c501 in a multicast kernel is NOT recommended.\n");
-#endif
-
-	if (el_debug)
-		printk(version);
+#endif /* CONFIG_IP_MULTICAST */
 
 	/*
 	 *	Initialize the device structure.
@@ -925,6 +928,8 @@
 static int irq=5;
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "EtherLink I/O base address");
+MODULE_PARM_DESC(irq, "EtherLink IRQ number");
 
 /**
  * init_module:
@@ -940,6 +945,7 @@
  
 int init_module(void)
 {
+	printk("%s", version);
 	dev_3c501.irq=irq;
 	dev_3c501.base_addr=io;
 	if (register_netdev(&dev_3c501) != 0)
diff -uNr linux-2.4.4-ac15/drivers/net/3c503.c linux/drivers/net/3c503.c
--- linux-2.4.4-ac15/drivers/net/3c503.c	Sat May 19 19:00:45 2001
+++ linux/drivers/net/3c503.c	Thu May 24 02:22:31 2001
@@ -149,7 +149,7 @@
 
     /* Reset and/or avoid any lurking NE2000 */
     if (inb(ioaddr + 0x408) == 0xff) {
-    	mdelay(1);
+	mdelay(1);
 	retval = -ENODEV;
 	goto out;
     }
@@ -178,8 +178,10 @@
 	goto out;
     }
 
-    if (ei_debug  &&  version_printed++ == 0)
-	printk(version);
+#ifndef MODULE
+    if (version_printed++ == 0)
+	printk("%s", version);
+#endif /* MODULE */
 
     dev->base_addr = ioaddr;
     /* Allocate dev->priv and fill in 8390 specific dev fields. */
@@ -615,6 +617,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM(xcvr, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink II I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink II IRQ number(s) (assigned)");
+MODULE_PARM_DESC(xcvr, "EtherLink II tranceiver(s) (0=internal, 1=external)");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
@@ -623,6 +628,7 @@
 {
 	int this_dev, found = 0;
 
+	printk("%s", version);
 	for (this_dev = 0; this_dev < MAX_EL2_CARDS; this_dev++) {
 		struct net_device *dev = &dev_el2[this_dev];
 		dev->irq = irq[this_dev];
diff -uNr linux-2.4.4-ac15/drivers/net/3c505.c linux/drivers/net/3c505.c
--- linux-2.4.4-ac15/drivers/net/3c505.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c505.c	Thu May 24 02:22:31 2001
@@ -1621,6 +1621,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
 MODULE_PARM(dma, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink Plus I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink Plus IRQ number(s) (assigned)");
+MODULE_PARM_DESC(dma, "EtherLink Plus DMA channel(s)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.4-ac15/drivers/net/3c507.c linux/drivers/net/3c507.c
--- linux-2.4.4-ac15/drivers/net/3c507.c	Sat May 19 19:00:45 2001
+++ linux/drivers/net/3c507.c	Thu May 24 02:22:31 2001
@@ -348,8 +348,10 @@
 		goto out;
 	}
 
-	if (net_debug  &&  version_printed++ == 0)
-		printk(version);
+#ifndef MODULE
+	if (version_printed++ == 0)
+		printk("%s", version);
+#endif /* MODULE */
 
 	printk("%s: 3c507 at %#x,", dev->name, ioaddr);
 
@@ -404,9 +406,6 @@
 	printk(", IRQ %d, %sternal xcvr, memory %#lx-%#lx.\n", dev->irq,
 		   dev->if_port ? "ex" : "in", dev->mem_start, dev->mem_end-1);
 
-	if (net_debug)
-		printk(version);
-
 	/* Initialize the device structure. */
 	lp = dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
 	if (dev->priv == NULL) {
@@ -859,16 +858,22 @@
 static int irq;
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "EtherLink16 I/O base address");
+MODULE_PARM_DESC(irq, "(ignored)");
 
 int init_module(void)
 {
+
+	printk("%s", version);
+	if (irq > 0)
+		printk(KERN_WARNING "3c507: irq parameter ignored by this driver\n");
 	if (io == 0)
-		printk("3c507: You should not use auto-probing with insmod!\n");
+		printk(KERN_WARNING "3c507: You should not use auto-probing with insmod!\n");
 	dev_3c507.base_addr = io;
 	dev_3c507.irq       = irq;
 	dev_3c507.init	    = el16_probe;
 	if (register_netdev(&dev_3c507) != 0) {
-		printk("3c507: register_netdev() returned non-zero.\n");
+		printk(KERN_ERR "3c507: register_netdev() returned non-zero.\n");
 		return -EIO;
 	}
 	return 0;
diff -uNr linux-2.4.4-ac15/drivers/net/3c509.c linux/drivers/net/3c509.c
--- linux-2.4.4-ac15/drivers/net/3c509.c	Sat May 19 18:35:42 2001
+++ linux/drivers/net/3c509.c	Thu May 24 02:22:31 2001
@@ -74,8 +74,9 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-static char versionA[] __initdata = "3c509.c:1.18 12Mar2001 becker@scyld.com\n";
-static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";
+static char version[] __initdata =
+	KERN_INFO "3c509.c:1.18 12Mar2001 becker@scyld.com\n"
+	KERN_INFO "http://www.scyld.com/network/3c509.html\n";
 
 #ifdef EL3_DEBUG
 static int el3_debug = EL3_DEBUG;
@@ -174,7 +175,7 @@
 };
 #endif /* CONFIG_MCA */
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static struct isapnp_device_id el3_isapnp_adapters[] __initdata = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5090),
@@ -201,7 +202,7 @@
 
 static u16 el3_isapnp_phys_addr[8][3];
 static int nopnp;
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 int __init el3_probe(struct net_device *dev)
 {
@@ -211,9 +212,10 @@
 	u16 phys_addr[3];
 	static int current_tag;
 	int mca_slot = -1;
-#ifdef CONFIG_ISAPNP
+	static int printed_version;
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	static int pnp_cards;
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	if (dev) SET_MODULE_OWNER(dev);
 
@@ -317,7 +319,7 @@
 	}
 #endif /* CONFIG_MCA */
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	if (nopnp == 1)
 		goto no_pnp;
 
@@ -353,7 +355,7 @@
 		}
 	}
 no_pnp:
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	/* Select an open I/O location at 0x1*0 to do contention select. */
 	for ( ; id_port < 0x200; id_port += 0x10) {
@@ -399,7 +401,7 @@
 		phys_addr[i] = htons(id_read_eeprom(i));
 	}
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	if (nopnp == 0) {
 		/* The ISA PnP 3c509 cards respond to the ID sequence.
 		   This check is needed in order not to register them twice. */
@@ -419,7 +421,7 @@
 			}
 		}
 	}
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	{
 		unsigned int iobase = id_read_eeprom(8);
@@ -496,8 +498,10 @@
 	spin_lock_init(&lp->lock);
 	el3_root_dev = dev;
 
-	if (el3_debug > 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+#ifndef MODULE
+	if (!printed_version++)
+		printk("%s", version);
+#endif /* MODULE */
 
 	/* The EL3-specific entries in the device structure. */
 	dev->open = &el3_open;
@@ -1007,15 +1011,20 @@
 MODULE_PARM(irq,"1-8i");
 MODULE_PARM(xcvr,"1-8i");
 MODULE_PARM(max_interrupt_work, "i");
-#ifdef CONFIG_ISAPNP
+MODULE_PARM_DESC(debug, "EtherLink III debug level (0-6)");
+MODULE_PARM_DESC(irq, "EtherLink III IRQ number(s) (assigned)");
+MODULE_PARM_DESC(max_interrupt_work, "EtherLink III maximum events handled per interrupt");
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 MODULE_PARM(nopnp, "i");
-#endif
+MODULE_PARM_DESC(nopnp, "EtherLink III PnP disable (0-1)");
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 int
 init_module(void)
 {
 	int el3_cards = 0;
 
+	printk("%s", version);
 	if (debug >= 0)
 		el3_debug = debug;
 
@@ -1042,7 +1051,7 @@
 #ifdef CONFIG_MCA		
 		if(lp->mca_slot!=-1)
 			mca_mark_as_unused(lp->mca_slot);
-#endif			
+#endif /* CONFIG_MCA */		
 		next_dev = lp->next_dev;
 		unregister_netdev(el3_root_dev);
 		release_region(el3_root_dev->base_addr, EL3_IO_EXTENT);
diff -uNr linux-2.4.4-ac15/drivers/net/3c515.c linux/drivers/net/3c515.c
--- linux-2.4.4-ac15/drivers/net/3c515.c	Sat May 19 19:00:45 2001
+++ linux/drivers/net/3c515.c	Thu May 24 02:22:31 2001
@@ -87,6 +87,10 @@
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
+MODULE_PARM_DESC(debug, "3c515 debug level (0-6)");
+MODULE_PARM_DESC(options, "3c515: Bits 0-2: media type, bit 3: duplex, bit 4: bus mastering");
+MODULE_PARM_DESC(full_duplex, "(ignored)");
+MODULE_PARM_DESC(max_interrupt_work, "3c515 Maximum events handled per interrupt");
 
 /* "Knobs" for adjusting internal parameters. */
 /* Put out somewhat more debugging messages. (0 - no msg, 1 minimal msgs). */
@@ -417,8 +421,7 @@
 
 	if (debug >= 0)
 		corkscrew_debug = debug;
-	if (corkscrew_debug)
-		printk(version);
+	printk("%s", version);
 
 	root_corkscrew_dev = NULL;
 	cards_found = corkscrew_scan(NULL);
@@ -434,8 +437,8 @@
 
 	cards_found = corkscrew_scan(dev);
 
-	if (corkscrew_debug > 0 && cards_found)
-		printk(version);
+	if (cards_found)
+		printk("%s", version);
 
 	return cards_found ? 0 : -ENODEV;
 }
diff -uNr linux-2.4.4-ac15/drivers/net/3c523.c linux/drivers/net/3c523.c
--- linux-2.4.4-ac15/drivers/net/3c523.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/3c523.c	Thu May 24 02:22:31 2001
@@ -1226,6 +1226,8 @@
 static int io[MAX_3C523_CARDS];
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_3C523_CARDS) "i");
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_3C523_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink/MC I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink/MC IRQ number(s)");
 
 int init_module(void)
 {
diff -uNr linux-2.4.4-ac15/drivers/net/3c527.c linux/drivers/net/3c527.c
--- linux-2.4.4-ac15/drivers/net/3c527.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/3c527.c	Thu May 24 02:22:31 2001
@@ -307,8 +307,10 @@
 
 	/* Time to play MCA games */
 
-	if (mc32_debug  &&  version_printed++ == 0)
-		printk(version);
+#ifndef MODULE
+	if (version_printed++ == 0)
+		printk("%s", version);
+#endif /* MODULE */
 
 	printk(KERN_INFO "%s: %s found in slot %d:", dev->name, cardname, slot);
 
@@ -1660,6 +1662,7 @@
 {
 	int result;
 	
+	printk("%s", version);
 	this_device.init = mc32_probe;
 	if ((result = register_netdev(&this_device)) != 0)
 		return result;
diff -uNr linux-2.4.4-ac15/drivers/net/3c59x.c linux/drivers/net/3c59x.c
--- linux-2.4.4-ac15/drivers/net/3c59x.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/3c59x.c	Thu May 24 02:22:31 2001
@@ -220,7 +220,8 @@
 #include <linux/delay.h>
 
 static char version[] __devinitdata =
-KERN_INFO "3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html\n";
+KERN_INFO "3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html\n"
+KERN_INFO "See Documentation/networking/vortex.txt\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c59x/3c90x/3c575 series Vortex/Boomerang/Cyclone driver");
@@ -236,6 +237,17 @@
 MODULE_PARM(compaq_irq, "i");
 MODULE_PARM(compaq_device_id, "i");
 MODULE_PARM(watchdog, "i");
+MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
+MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: duplex");
+MODULE_PARM_DESC(full_duplex, "3c59x full duplex setting (1)");
+MODULE_PARM_DESC(hw_checksums, "3c59x Hardware checksum checking by adapter(s) (0-1)");
+MODULE_PARM_DESC(flow_ctrl, "3c59x 802.3x flow control usage (PAUSE only) (0-1)");
+MODULE_PARM_DESC(enable_wol, "3c59x: Turn on Wake-on-LAN for adapter(s) (0-1)");
+MODULE_PARM_DESC(max_interrupt_work, "3c59x Maximum events handled per interrupt");
+MODULE_PARM_DESC(compaq_ioaddr, "3c59x PCI I/O base address (Compaq BIOS problem workaround)");
+MODULE_PARM_DESC(compaq_irq, "3c59x PCI IRQ number (Compaq BIOS problem workaround)");
+MODULE_PARM_DESC(compaq_device_id, "3c59x PCI device ID (Compaq BIOS problem workaround)");
+MODULE_PARM_DESC(watchdog, "3c59x transmit timeout in milliseconds");
 
 /* Operational parameter that usually are not changed. */
 
@@ -888,6 +900,10 @@
 {
 	int rc;
 
+#ifdef MODULE
+	printk ("%s", version);
+#endif /* MODULE */
+
 	/* wake up and enable device */		
 	if (pci_enable_device (pdev)) {
 		rc = -EIO;
@@ -919,12 +935,6 @@
 	int retval;
 	struct vortex_chip_info * const vci = &vortex_info_tbl[chip_idx];
 
-	if (!printed_version) {
-		printk (version);
-		printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
-		printed_version = 1;
-	}
-
 	dev = init_etherdev(NULL, sizeof(*vp));
 	retval = -ENOMEM;
 	if (!dev) {
@@ -932,6 +942,11 @@
 		goto out;
 	}
 	SET_MODULE_OWNER(dev);
+
+#ifndef MODULE
+	if (!printed_version++)
+		printk ("%s", version);
+#endif /* MODULE */
 
 	printk(KERN_INFO "%s: 3Com %s %s at 0x%lx, ",
 	       dev->name,


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
