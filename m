Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRESVmS>; Sat, 19 May 2001 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbRESVl6>; Sat, 19 May 2001 17:41:58 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:42249 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261347AbRESVlr>; Sat, 19 May 2001 17:41:47 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105192141.XAA02258@green.mif.pg.gda.pl>
Subject: [PATCH] 2.4.4-ac11 network drivers cleaning
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 19 May 2001 23:41:24 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From kufel!root  Sat May 19 23:39:35 2001
Return-Path: <kufel!root>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id XAA02226
	for green.mif.pg.gda.pl!ankry; Sat, 19 May 2001 23:39:35 +0200
Received: (from root@localhost)
	by kufel.dom (8.9.3/8.9.3) id XAA02243
	for ankry@green; Sat, 19 May 2001 23:40:52 +0200
Date: Sat, 19 May 2001 23:40:52 +0200
From: root <kufel!root>
Message-Id: <200105192140.XAA02243@kufel.dom>
To: kufel!green.mif.pg.gda.pl!ankry
Subject: 3com

Hi Alan,

The following patch is a preliminary attempt for cleaning network drivers in
2.4 (drivers for 3Com boards for beginning). It contains:

- cleaning version printing as Jeff suggests (modular - always, built in -
  if detected)
- added MODULE_PARM_DESC (the main reason I've created the patch)
- made version __initdata
- a comment fix (3c501)
- added KERN_* markers to some printk's (only a few)
- enabled modular isapnp usage by 3c509

BTW, Looking at the "options" parameter in some drivers I found that using
it might be ugly in some cases and do not allow specyfic settings. For
example it is difficult to set 10Mbps/half-duplex not changing media type in
some drivers as it requires "options=0" setting, which is simply ignored.
Parameters like duplex setting should be IMO three-state (full/half/not
changed) while there's only one bit in "options" assigned to them currently.
Jeff, Alan, what do you think of changing the method for media/link type
setting and unifying it across drivers ?
Of course, I think of it as a 2.5 project...

Andrzej

**************************************************************************
diff -ur linux-2.4.4-ac11/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.4.4-ac11/drivers/net/3c501.c	Tue May  1 21:14:30 2001
+++ linux/drivers/net/3c501.c	Fri May 18 23:44:28 2001
@@ -238,6 +238,10 @@
 
 	SET_MODULE_OWNER(dev);
 
+#ifdef MODULE
+	printk(version);
+#endif /* MODULE */
+
 	if (base_addr > 0x1ff)	/* Check a single specified location. */
 		return el1_probe1(dev, base_addr);
 	else if (base_addr != 0)	/* Don't probe at all. */
@@ -251,7 +255,7 @@
 }
 
 /**
- *	el1_probe: 
+ *	el1_probe1: 
  *	@dev: The device structure to use
  *	@ioaddr: An I/O address to probe at.
  *
@@ -270,6 +274,7 @@
 	unsigned char station_addr[6];
 	int autoirq = 0;
 	int i;
+	static int printed_version;
 
 	/*
 	 *	Reserve I/O resource for exclusive use by this driver
@@ -340,15 +345,17 @@
 	if (autoirq)
 		dev->irq = autoirq;
 
+#ifndef MODULE
+	if (!printed_version++)
+		printk(version);
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
@@ -925,6 +932,8 @@
 static int irq=5;
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(io, "EtherLink I/O base address");
+MODULE_PARM_DESC(irq, "EtherLink IRQ number");
 
 /**
  * init_module:
diff -ur linux-2.4.4-ac11/drivers/net/3c503.c linux/drivers/net/3c503.c
--- linux-2.4.4-ac11/drivers/net/3c503.c	Tue May  1 21:14:30 2001
+++ linux/drivers/net/3c503.c	Fri May 18 23:45:06 2001
@@ -178,8 +178,10 @@
 	goto out;
     }
 
-    if (ei_debug  &&  version_printed++ == 0)
+#ifndef MODULE
+    if (version_printed++ == 0)
 	printk(version);
+#endif /* MODULE */
 
     dev->base_addr = ioaddr;
     /* Allocate dev->priv and fill in 8390 specific dev fields. */
@@ -615,6 +617,8 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
 MODULE_PARM(xcvr, "1-" __MODULE_STRING(MAX_EL2_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink II I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink II IRQ number(s) (assigned)");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
@@ -623,6 +627,7 @@
 {
 	int this_dev, found = 0;
 
+	printk(version);
 	for (this_dev = 0; this_dev < MAX_EL2_CARDS; this_dev++) {
 		struct net_device *dev = &dev_el2[this_dev];
 		dev->irq = irq[this_dev];
diff -ur linux-2.4.4-ac11/drivers/net/3c505.c linux/drivers/net/3c505.c
--- linux-2.4.4-ac11/drivers/net/3c505.c	Sat Apr 28 20:34:50 2001
+++ linux/drivers/net/3c505.c	Fri May 18 19:38:44 2001
@@ -1621,6 +1621,9 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
 MODULE_PARM(dma, "1-" __MODULE_STRING(ELP_MAX_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink Plus I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink Plus IRQ number(s) (assigned)");
+MODULE_PARM_DESC(dma, "EtherLink Plus DMA channel(s)");
 
 int init_module(void)
 {
diff -ur linux-2.4.4-ac11/drivers/net/3c507.c linux/drivers/net/3c507.c
--- linux-2.4.4-ac11/drivers/net/3c507.c	Tue May  1 21:14:30 2001
+++ linux/drivers/net/3c507.c	Fri May 18 23:45:41 2001
@@ -348,8 +348,10 @@
 		goto out;
 	}
 
-	if (net_debug  &&  version_printed++ == 0)
+#ifndef MODULE
+	if (version_printed++ == 0)
 		printk(version);
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
+	printk(version);
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
diff -ur linux-2.4.4-ac11/drivers/net/3c509.c linux/drivers/net/3c509.c
--- linux-2.4.4-ac11/drivers/net/3c509.c	Sat Apr 28 20:34:50 2001
+++ linux/drivers/net/3c509.c	Fri May 18 23:50:15 2001
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
@@ -211,12 +212,17 @@
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
 
+#ifdef MODULE
+	printk(version);
+#endif /* MODULE */
+
 	/* First check all slots of the EISA bus.  The next slot address to
 	   probe is kept in 'eisa_addr' to support multiple probe() calls. */
 	if (EISA_bus) {
@@ -317,7 +323,7 @@
 	}
 #endif /* CONFIG_MCA */
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	if (nopnp == 1)
 		goto no_pnp;
 
@@ -353,7 +359,7 @@
 		}
 	}
 no_pnp:
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	/* Select an open I/O location at 0x1*0 to do contention select. */
 	for ( ; id_port < 0x200; id_port += 0x10) {
@@ -399,7 +405,7 @@
 		phys_addr[i] = htons(id_read_eeprom(i));
 	}
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	if (nopnp == 0) {
 		/* The ISA PnP 3c509 cards respond to the ID sequence.
 		   This check is needed in order not to register them twice. */
@@ -419,7 +425,7 @@
 			}
 		}
 	}
-#endif /* CONFIG_ISAPNP */
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	{
 		unsigned int iobase = id_read_eeprom(8);
@@ -496,8 +502,10 @@
 	spin_lock_init(&lp->lock);
 	el3_root_dev = dev;
 
-	if (el3_debug > 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+#ifndef MODULE
+	if (!printed_version++)
+		printk(version);
+#endif /* MODULE */
 
 	/* The EL3-specific entries in the device structure. */
 	dev->open = &el3_open;
@@ -1007,9 +1015,13 @@
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
@@ -1042,7 +1054,7 @@
 #ifdef CONFIG_MCA		
 		if(lp->mca_slot!=-1)
 			mca_mark_as_unused(lp->mca_slot);
-#endif			
+#endif /* CONFIG_MCA */		
 		next_dev = lp->next_dev;
 		unregister_netdev(el3_root_dev);
 		release_region(el3_root_dev->base_addr, EL3_IO_EXTENT);
diff -ur linux-2.4.4-ac11/drivers/net/3c515.c linux/drivers/net/3c515.c
--- linux-2.4.4-ac11/drivers/net/3c515.c	Tue May  1 21:14:30 2001
+++ linux/drivers/net/3c515.c	Fri May 18 19:38:44 2001
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
+	printk(version);
 
 	root_corkscrew_dev = NULL;
 	cards_found = corkscrew_scan(NULL);
@@ -434,7 +437,7 @@
 
 	cards_found = corkscrew_scan(dev);
 
-	if (corkscrew_debug > 0 && cards_found)
+	if (cards_found)
 		printk(version);
 
 	return cards_found ? 0 : -ENODEV;
diff -ur linux-2.4.4-ac11/drivers/net/3c523.c linux/drivers/net/3c523.c
--- linux-2.4.4-ac11/drivers/net/3c523.c	Sat Apr 28 20:34:50 2001
+++ linux/drivers/net/3c523.c	Fri May 18 19:38:44 2001
@@ -1226,6 +1226,8 @@
 static int io[MAX_3C523_CARDS];
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_3C523_CARDS) "i");
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_3C523_CARDS) "i");
+MODULE_PARM_DESC(io, "EtherLink/MC I/O base address(es)");
+MODULE_PARM_DESC(irq, "EtherLink/MC IRQ number(s)");
 
 int init_module(void)
 {
diff -ur linux-2.4.4-ac11/drivers/net/3c527.c linux/drivers/net/3c527.c
--- linux-2.4.4-ac11/drivers/net/3c527.c	Tue May  1 21:14:31 2001
+++ linux/drivers/net/3c527.c	Fri May 18 23:51:09 2001
@@ -231,6 +231,9 @@
 	int adapter_found = 0;
 
 	SET_MODULE_OWNER(dev);
+#ifdef MODULE
+	printk(version);
+#endif /* MODULE */
 
 	/* Do not check any supplied i/o locations. 
 	   POS registers usually don't fail :) */
@@ -307,8 +310,10 @@
 
 	/* Time to play MCA games */
 
-	if (mc32_debug  &&  version_printed++ == 0)
+#ifndef MODULE
+	if (version_printed++ == 0)
 		printk(version);
+#endif /* MODULE */
 
 	printk(KERN_INFO "%s: %s found in slot %d:", dev->name, cardname, slot);
 
diff -ur linux-2.4.4-ac11/drivers/net/3c59x.c linux/drivers/net/3c59x.c
--- linux-2.4.4-ac11/drivers/net/3c59x.c	Tue May  1 21:14:31 2001
+++ linux/drivers/net/3c59x.c	Fri May 18 19:38:44 2001
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
+MODULE_PARM_DESC(full_duplex, "(ignored)");
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
+	printk (version);
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
+		printk (version);
+#endif /* MODULE */
 
 	printk(KERN_INFO "%s: 3Com %s %s at 0x%lx, ",
 	       dev->name,


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
