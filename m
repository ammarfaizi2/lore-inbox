Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263331AbREXBVz>; Wed, 23 May 2001 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbREXBVs>; Wed, 23 May 2001 21:21:48 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:50443 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263331AbREXBVf>; Wed, 23 May 2001 21:21:35 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105240102.DAA27178@green.mif.pg.gda.pl>
Subject: [PATCH] drivers/net/others 
To: jgarzik@mandrakesoft.com (Jeff Garzik), akpm@uow.edu.au,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 24 May 2001 03:02:08 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And the next (unfinished) part of net drivers cleaning. Except previously
mentioned
- __init fixes
- version fixes
- added MODULE_PARM_DESC
- removed unnecessary zero initializers
it also contains
- mbps -> Mbps (8139too)
- warning fixes (unused variables) (8139too)
- aironet config fixes
- PCI IDs name sync with pci_ids (when different names) (pcnet32, tlan)
- long udelay()s fixed (aironet)
- disabled unused code (arlan-proc)
- comment typos fixed

Andrzej
***********************************************************************
diff -uNr linux-2.4.4-ac15/drivers/net/8139too.c linux/drivers/net/8139too.c
--- linux-2.4.4-ac15/drivers/net/8139too.c	Sat May 19 19:01:34 2001
+++ linux/drivers/net/8139too.c	Thu May 24 02:22:31 2001
@@ -154,6 +154,13 @@
 #define RTL8139_DRIVER_NAME   MODNAME " Fast Ethernet driver " RTL8139_VERSION
 #define PFX MODNAME ": "
 
+static char version[]
+#ifdef MODULE
+	__initdata
+#else
+	__devinitdata
+#endif
+	= KERN_INFO RTL8139_DRIVER_NAME "\n";
 
 /* enable PIO instead of MMIO, if CONFIG_8139TOO_PIO is selected */
 #ifdef CONFIG_8139TOO_PIO
@@ -188,8 +195,8 @@
 /* A few user-configurable values. */
 /* media options */
 #define MAX_UNITS 8
-static int media[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int media[MAX_UNITS] __devinitdata = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int full_duplex[MAX_UNITS] __devinitdata = {-1, -1, -1, -1, -1, -1, -1, -1};
 
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
 static int max_interrupt_work = 20;
@@ -582,6 +589,10 @@
 MODULE_PARM (max_interrupt_work, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM (full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC (multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
+MODULE_PARM_DESC (max_interrupt_work, "8139too maximum events handled per interrupt");
+MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full-duplex, bit 5: 100Mbps");
+MODULE_PARM_DESC (full_duplex, "8139too: Force full duplex for board(s) (0-1)");
 
 static int read_eeprom (void *ioaddr, int location, int addr_len);
 static int rtl8139_open (struct net_device *dev);
@@ -910,7 +921,7 @@
 	{
 		static int printed_version;
 		if (!printed_version++)
-			printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
+			printk ("%s", version);
 	}
 #endif
 
@@ -1018,11 +1029,11 @@
 		tp->duplex_lock = 1;
 	}
 	if (tp->default_port) {
-		printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
+		printk(KERN_INFO "  Forcing %dMbps %s-duplex operation.\n",
 			   (option & 0x20 ? 100 : 10),
 			   (option & 0x10 ? "full" : "half"));
 		mdio_write(dev, tp->phys[0], 0,
-				   ((option & 0x20) ? 0x2000 : 0) | 	/* 100mbps? */
+				   ((option & 0x20) ? 0x2000 : 0) | 	/* 100Mbps? */
 				   ((option & 0x10) ? 0x0100 : 0)); /* Full duplex? */
 	}
 
@@ -1172,10 +1183,12 @@
 static int mdio_read (struct net_device *dev, int phy_id, int location)
 {
 	struct rtl8139_private *tp = dev->priv;
+	int retval = 0;
+#ifdef CONFIG_8139TOO_8129
 	void *mdio_addr = tp->mmio_addr + Config4;
 	int mii_cmd = (0xf6 << 10) | (phy_id << 5) | location;
-	int retval = 0;
 	int i;
+#endif /* CONFIG_8139TOO_8129 */
 
 	DPRINTK ("ENTER\n");
 
@@ -1216,9 +1229,11 @@
 			int value)
 {
 	struct rtl8139_private *tp = dev->priv;
+#ifdef CONFIG_8139TOO_8129
 	void *mdio_addr = tp->mmio_addr + Config4;
 	int mii_cmd = (0x5002 << 16) | (phy_id << 23) | (location << 18) | value;
 	int i;
+#endif /* CONFIG_8139TOO_8129 */
 
 	DPRINTK ("ENTER\n");
 
@@ -2384,7 +2399,7 @@
 	 * even if no 8139 board is found.
 	 */
 #ifdef MODULE
-	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
+	printk ("%s", version);
 #endif
 
 	return pci_module_init (&rtl8139_pci_driver);
diff -uNr linux-2.4.4-ac15/drivers/net/82596.c linux/drivers/net/82596.c
--- linux-2.4.4-ac15/drivers/net/82596.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/82596.c	Thu May 24 02:22:31 2001
@@ -64,7 +64,7 @@
 #include <asm/pgalloc.h>
 
 static char version[] __initdata =
-	"82596.c $Revision: 1.4 $\n";
+	KERN_INFO "82596.c $Revision: 1.4 $\n";
 
 /* DEBUG flags
  */
@@ -151,6 +151,7 @@
 MODULE_AUTHOR("Richard Hirst");
 MODULE_DESCRIPTION("i82596 driver");
 MODULE_PARM(i596_debug, "i");
+MODULE_PARM_DESC(i596_debug, "i82596 debug mask");
 
 
 /* Copy frames shorter than rx_copybreak, otherwise pass on up in
@@ -1175,7 +1176,9 @@
 
 	DEB(DEB_PROBE,printk(" IRQ %d.\n", dev->irq));
 
-	DEB(DEB_PROBE,printk(version));
+#ifndef MODULE
+	printk("%s", version);
+#endif /* MODULE */
 
 	/* The 82596-specific entries in the device structure. */
 	dev->open = i596_open;
@@ -1493,9 +1496,11 @@
 static int io = 0x300;
 static int irq = 10;
 MODULE_PARM(irq, "i");
+MODULE_PARM_DESC(irq, "Apricot IRQ number");
 #endif
 
 MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "i82596 debug mask");
 static int debug = -1;
 
 int init_module(void)
@@ -1504,6 +1509,8 @@
 	dev_82596.base_addr = io;
 	dev_82596.irq = irq;
 #endif
+
+	printk("%s", version);
 	if (debug >= 0)
 		i596_debug = debug;
 	if (register_netdev(&dev_82596) != 0)
diff -uNr linux-2.4.4-ac15/drivers/net/8390.c linux/drivers/net/8390.c
--- linux-2.4.4-ac15/drivers/net/8390.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/8390.c	Thu May 24 02:22:31 2001
@@ -45,9 +45,6 @@
 
   */
 
-static const char version[] =
-    "8390.c:v1.10cvs 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -70,6 +67,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 
+static const char version[] =
+    KERN_INFO "8390.c:v1.10cvs 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+
 #define NS8390_CORE
 #include "8390.h"
 
@@ -1016,7 +1016,7 @@
 int ethdev_init(struct net_device *dev)
 {
 	if (ei_debug > 1)
-		printk(version);
+		printk("%s", version);
     
 	if (dev->priv == NULL) 
 	{
diff -uNr linux-2.4.4-ac15/drivers/net/Config.in linux/drivers/net/Config.in
--- linux-2.4.4-ac15/drivers/net/Config.in	Tue May 22 00:51:30 2001
+++ linux/drivers/net/Config.in	Thu May 24 02:22:31 2001
@@ -260,10 +260,14 @@
    tristate '  Aironet 4500/4800 series adapters' CONFIG_AIRONET4500
    dep_tristate '   Aironet 4500/4800 ISA/PCI/PNP/365 support ' CONFIG_AIRONET4500_NONCS $CONFIG_AIRONET4500
    if [ "$CONFIG_AIRONET4500" != "n" -a "$CONFIG_AIRONET4500_NONCS" != "n" ]; then
-      bool '     Aironet 4500/4800 PNP support ' CONFIG_AIRONET4500_PNP
+      if [ "$CONFIG_AIRONET4500_NONCS" = "m" -a "$CONFIG_ISAPNP" = "m" -o "$CONFIG_ISAPNP" = "y" ]; then
+	 bool '     Aironet 4500/4800 PNP support ' CONFIG_AIRONET4500_PNP
+      fi
       dep_bool '     Aironet 4500/4800 PCI support ' CONFIG_AIRONET4500_PCI $CONFIG_PCI
-      dep_bool '     Aironet 4500/4800 ISA broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_ISA $CONFIG_EXPERIMENTAL
-      dep_bool '     Aironet 4500/4800 I365 broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_I365 $CONFIG_EXPERIMENTAL
+      if [ "$CONFIG_AIRONET4500_NONCS" = "m" ]; then
+	 dep_bool '     Aironet 4500/4800 ISA broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_ISA $CONFIG_EXPERIMENTAL
+	 dep_bool '     Aironet 4500/4800 I365 broken support (EXPERIMENTAL)' CONFIG_AIRONET4500_I365 $CONFIG_EXPERIMENTAL
+      fi
    fi
    dep_tristate '   Aironet 4500/4800 PROC interface ' CONFIG_AIRONET4500_PROC $CONFIG_AIRONET4500 m
 
diff -uNr linux-2.4.4-ac15/drivers/net/ac3200.c linux/drivers/net/ac3200.c
--- linux-2.4.4-ac15/drivers/net/ac3200.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/ac3200.c	Thu May 24 02:22:31 2001
@@ -62,9 +62,11 @@
 
 /* Decoding of the configuration register. */
 static unsigned char config2irqmap[8] __initdata = {15, 12, 11, 10, 9, 7, 5, 3};
-static int addrmap[8] =
-{0xFF0000, 0xFE0000, 0xFD0000, 0xFFF0000, 0xFFE0000, 0xFFC0000,  0xD0000, 0 };
-static const char *port_name[4] = { "10baseT", "invalid", "AUI", "10base2"};
+static int addrmap[8] __initdata =
+	{0xFF0000, 0xFE0000, 0xFD0000, 0xFFF0000,
+	 0xFFE0000, 0xFFC0000, 0xD0000, 0 };
+static char *port_name[4] __initdata =
+	{ "10baseT", "invalid", "AUI", "10base2"};
 
 #define config2irq(configval)	config2irqmap[((configval) >> 3) & 7]
 #define config2mem(configval)	addrmap[(configval) & 7]
@@ -119,6 +121,7 @@
 static int __init ac_probe1(int ioaddr, struct net_device *dev)
 {
 	int i, retval;
+	static int printed_version;
 
 	if (!request_region(ioaddr, AC_IO_EXTENT, dev->name))
 		return -EBUSY;
@@ -234,8 +237,10 @@
 	ei_status.stop_page = AC_STOP_PG;
 	ei_status.word16 = 1;
 
-	if (ei_debug > 0)
-		printk(version);
+#ifndef MODULE
+	if (!printed_version++)
+		printk("%s", version);
+#endif /* MODULE */
 
 	ei_status.reset_8390 = &ac_reset_8390;
 	ei_status.block_input = &ac_block_input;
@@ -344,12 +349,16 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_AC32_CARDS) "i");
+MODULE_PARM_DESC(io, "ac3200 I/O base adress(es)");
+MODULE_PARM_DESC(irq, "ac3200 IRQ number(s)");
+MODULE_PARM_DESC(mem, "ac3200 Memory base address(es)");
 
 int
 init_module(void)
 {
 	int this_dev, found = 0;
 
+	printk("%s", version);
 	for (this_dev = 0; this_dev < MAX_AC32_CARDS; this_dev++) {
 		struct net_device *dev = &dev_ac32[this_dev];
 		dev->irq = irq[this_dev];
diff -uNr linux-2.4.4-ac15/drivers/net/acenic.c linux/drivers/net/acenic.c
--- linux-2.4.4-ac15/drivers/net/acenic.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/acenic.c	Thu May 24 02:22:31 2001
@@ -515,18 +515,18 @@
 static int max_tx_desc[ACE_MAX_MOD_PARMS];
 static int max_rx_desc[ACE_MAX_MOD_PARMS];
 static int tx_ratio[ACE_MAX_MOD_PARMS];
-static int dis_pci_mem_inval[ACE_MAX_MOD_PARMS] = {1, 1, 1, 1, 1, 1, 1, 1};
+static int dis_pci_mem_inval[ACE_MAX_MOD_PARMS] __initdata =
+				{1, 1, 1, 1, 1, 1, 1, 1};
 
 static char version[] __initdata = 
-  "acenic.c: v0.81 04/20/2001  Jes Sorensen, linux-acenic@SunSITE.dk\n"
-  "                            http://home.cern.ch/~jes/gige/acenic.html\n";
-
-static struct net_device *root_dev;
+  KERN_INFO "acenic.c: v0.81 04/20/2001  Jes Sorensen, linux-acenic@SunSITE.dk\n"
+  KERN_INFO "                            http://home.cern.ch/~jes/gige/acenic.html\n";
 
 static int probed __initdata = 0;
 
+static struct net_device *root_dev;
 
-int __devinit acenic_probe (ACE_PROBE_ARG)
+static int __init acenic_probe (ACE_PROBE_ARG)
 {
 #ifdef NEW_NETINIT
 	struct net_device *dev;
@@ -535,7 +535,7 @@
 	struct ace_private *ap;
 	struct pci_dev *pdev = NULL;
 	int boards_found = 0;
-	int version_disp;
+	static int version_disp;
 
 	if (probed)
 		return -ENODEV;
@@ -544,8 +544,6 @@
 	if (!pci_present())		/* is PCI support present? */
 		return -ENODEV;
 
-	version_disp = 0;
-
 	while ((pdev = pci_find_class(PCI_CLASS_NETWORK_ETHERNET<<8, pdev))) {
 
 		if (!((pdev->vendor == PCI_VENDOR_ID_ALTEON) &&
@@ -602,14 +600,12 @@
 		dev->set_mac_address = &ace_set_mac_addr;
 		dev->change_mtu = &ace_change_mtu;
 
+#ifndef MODULE
 		/* display version info if adapter is found */
-		if (!version_disp)
-		{
-			/* set display flag to TRUE so that */
-			/* we only display this string ONCE */
-			version_disp = 1;
-			printk(version);
-		}
+
+		if (!version_disp++)
+			printk("%s", version);
+#endif /* MODULE */
 
 		/*
 		 * Enable master mode before we start playing with the
@@ -748,7 +744,6 @@
 }
 
 
-#ifdef MODULE
 MODULE_AUTHOR("Jes Sorensen <jes@linuxcare.com>");
 MODULE_DESCRIPTION("AceNIC/3C985/GA620 Gigabit Ethernet driver");
 MODULE_PARM(link, "1-" __MODULE_STRING(8) "i");
@@ -757,7 +752,12 @@
 MODULE_PARM(max_tx_desc, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_coal_tick, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(max_rx_desc, "1-" __MODULE_STRING(8) "i");
-#endif
+MODULE_PARM_DESC(link, "Acenic/3C985/NetGear link state");
+MODULE_PARM_DESC(trace, "Acenic/3C985/NetGear firmware trace level");
+MODULE_PARM_DESC(tx_coal_tick, "Acenic/3C985/NetGear maximum clock ticks to wait for packets");
+MODULE_PARM_DESC(max_tx_desc, "Acenic/3C985/NetGear maximum number of transmit descriptors");
+MODULE_PARM_DESC(rx_coal_tick, "Acenic/3C985/NetGear maximum clock ticks to wait for packets");
+MODULE_PARM_DESC(max_rx_desc, "Acenic/3C985/NetGear maximum number of receive descriptors");
 
 
 static void __exit ace_module_cleanup(void)
@@ -855,7 +855,7 @@
 }
 
 
-int __init ace_module_init(void)
+static int __init ace_module_init(void)
 {
 	int status;
 
@@ -874,6 +874,7 @@
 #ifdef MODULE
 int init_module(void)
 {
+	printk("%s", version);
 	return ace_module_init();
 }
 
@@ -933,7 +934,7 @@
 }
 
 
-static int ace_allocate_descriptors(struct net_device *dev)
+static int __init ace_allocate_descriptors(struct net_device *dev)
 {
 	struct ace_private *ap = dev->priv;
 	int size;
@@ -3054,7 +3055,7 @@
  * This operation requires the NIC to be halted and is performed with
  * interrupts disabled and with the spinlock hold.
  */
-int __init ace_load_firmware(struct net_device *dev)
+static int __init ace_load_firmware(struct net_device *dev)
 {
 	struct ace_private *ap;
 	struct ace_regs *regs;
diff -uNr linux-2.4.4-ac15/drivers/net/aironet4500_card.c linux/drivers/net/aironet4500_card.c
--- linux-2.4.4-ac15/drivers/net/aironet4500_card.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/aironet4500_card.c	Thu May 24 02:22:31 2001
@@ -11,10 +11,6 @@
  *		Jeff Garzik - softnet, cleanups
  *
  */
-#ifdef MODULE
-static const char *awc_version =
-"aironet4500_cards.c v0.2  Feb 27, 2000  Elmer Joandi, elmer@ylenurme.ee.\n";
-#endif
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -56,6 +52,11 @@
 #define AIRONET4500_365		4
 
 
+static char awc_version[] __devinitdata =
+KERN_INFO "aironet4500_card.c v0.2  Feb 27, 2000  Elmer Joandi, elmer@ylenurme.ee.\n";
+
+static int version_printed __devinitdata = 0;
+
 #ifdef CONFIG_AIRONET4500_PCI
 
 #include <linux/pci.h>
@@ -75,7 +76,7 @@
  			int ioaddr, int cis_addr, int mem_addr,u8 pci_irq_line) ;
 
 
-int awc4500_pci_probe(struct net_device *dev)
+int __devinit awc4500_pci_probe(struct net_device *dev)
 {
 	int cards_found = 0;
 	static int pci_index;	/* Static, for multiple probe calls. */
@@ -136,6 +137,11 @@
 //		request_region(pci_cisaddr, AIRONET4X00_CIS_SIZE, "aironet4x00 cis");
 //		request_region(pci_memaddr, AIRONET4X00_MEM_SIZE, "aironet4x00 mem");
 
+#ifndef MODULE
+		if (!version_printed++)
+			printk("%s", awc_version);
+#endif /* MODULE */
+
 		mdelay(10);
 
 		pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
@@ -164,7 +170,7 @@
 }
 
 
-static int awc_pci_init(struct net_device * dev, struct pci_dev *pdev,
+static int __devinit awc_pci_init(struct net_device * dev, struct pci_dev *pdev,
  			int ioaddr, int cis_addr, int mem_addr, u8 pci_irq_line) {
 
 	int i, allocd_dev = 0;
@@ -294,6 +300,7 @@
 #define PNP_BUS_NUMBER number
 #define PNP_DEV_NUMBER devfn
 
+#if 0 /* unused ? */
 
 int awc4500_pnp_hw_reset(struct net_device *dev){
 	struct isapnp_logdev *logdev;
@@ -331,8 +338,9 @@
 
 	return 0;
 }
+#endif /* 0 */
 
-int awc4500_pnp_probe(struct net_device *dev)
+int __init awc4500_pnp_probe(struct net_device *dev)
 {
 	int isa_index = 0;
 	int isa_irq_line = 0;
@@ -383,6 +391,12 @@
 				return -ENOMEM;
 			}
 		}
+
+#ifndef MODULE
+		if (!version_printed++)
+			printk("%s", awc_version);
+#endif /* MODULE */
+
 		dev->priv = kmalloc(sizeof(struct awc_private),GFP_KERNEL );
 		memset(dev->priv,0,sizeof(struct awc_private));
 		if (!dev->priv) {
@@ -523,7 +537,7 @@
 
 
 
-int awc4500_isa_probe(struct net_device *dev)
+static int __init awc4500_isa_probe(struct net_device *dev)
 {
 //	int cards_found = 0;
 //	static int isa_index;	/* Static, for multiple probe calls. */
@@ -670,18 +684,18 @@
 	int product;
 };
 	
-inline u8 i365_in (struct i365_socket * s, int offset) { 
+static inline u8 i365_in (struct i365_socket * s, int offset) { 
 	outb(offset  + (s->socket % 2)* 0x40, s->offset_port);
 	return inb(s->data_port); 
 };
 
-inline void i365_out (struct i365_socket * s, int offset,int data){
+static inline void i365_out (struct i365_socket * s, int offset,int data){
 	outb(offset + (s->socket % 2)* 0x40 ,s->offset_port);
 	outb((data & 0xff),s->data_port)	;
 	
 };
 
-void awc_i365_card_release(struct i365_socket * s){
+static void __init awc_i365_card_release(struct i365_socket * s){
 	
 	i365_out(s, 0x5, 0); 		// clearing ints
 	i365_out(s, 0x6, 0x20); 	// mem 16 bits
@@ -690,10 +704,10 @@
 	i365_out(s, 0x2, 0);		// reset power
 	i365_out(s, 0x2, i365_in(s, 0x2) & 0x7f ); // cardenable off
 	i365_out(s, 0x2, 0);		// remove power
-	
 
 };
-int awc_i365_probe_once(struct i365_socket * s ){
+
+static int __init awc_i365_probe_once(struct i365_socket * s ){
 
 
 	int caps=i365_in(s, 0);
@@ -723,14 +737,14 @@
 	awc_i365_card_release(s);
 
 
-	udelay(100000);
+	mdelay(100);
 	
 	i365_out(s, 0x2, 0x10 ); 	// power enable
-	udelay(200000);
+	mdelay(200);
 	
 	i365_out(s, 0x2, 0x10 | 0x01 | 0x04 | 0x80);	//power enable
 	
-	udelay(250000);
+	mdelay(250);
 	
 	if (!s->irq)
 		s->irq = 11;
@@ -756,7 +770,7 @@
 	i365_out(s,0x15,0x3f | 0x40);		// enab mem reg bit
 	i365_out(s,0x06,0x01);			// enab mem 
 	
-	udelay(10000);
+	mdelay(10);
 	
 	cis[0] = 0x45;
 	
@@ -767,7 +781,7 @@
 
 	mem[0x3e0] = 0x45;
 
-	udelay(10000);
+	mdelay(10);
 	
 	memcpy_fromio(cis,0xD000, 0x3e0);
 	
@@ -795,7 +809,7 @@
 		s->socket, s->manufacturer,s->product);
 
 	i365_out(s,0x07, 0x1 | 0x2); 		// enable io 16bit
-	udelay(1000);
+	mdelay(1);
 	port = s->io;
 	i365_out(s,0x08, port & 0xff);
 	i365_out(s,0x09, (port & 0xff00)/ 0x100);
@@ -804,7 +818,7 @@
 
 	i365_out(s,0x06, 0x40); 		// enable io window
 
-	udelay(1000);
+	mdelay(1);
 
 	i365_out(s,0x3e0,0x45);
 	
@@ -822,17 +836,14 @@
 
 	
 	outw(0x10, s->io + 0x34);
-	udelay(10000);
+	mdelay(10);
 	
 	return 0;
-	
-	
 
-		
 };
 
 
-static int awc_i365_init(struct i365_socket * s) {
+static int __init awc_i365_init(struct i365_socket * s) {
 
 	struct net_device * dev;
 	int i;
@@ -877,9 +888,10 @@
 	}
 
 	return 0;
- 
+
   failed:
   	return -1;
+
 }
 
 
@@ -912,17 +924,12 @@
 
 		i++;
 	}
-	
-
-} 
-
 
 
+}
 
 
-        
-        
-int awc_i365_probe(void) {
+static int __init awc_i365_probe(void) {
 
 	int i = 1;
 	int k = 0;
@@ -930,7 +937,6 @@
 	int found=0;
 	
 	struct i365_socket s;
-	/* Always emit the version, before any failure. */
 
 	if (!awc_i365_sockets) {
 		printk("	awc i82635 4x00: use bitfiel opts awc_i365_sockets=0x3 <- (1|2) to probe sockets 0 and 1\n");
@@ -952,7 +958,13 @@
 			if (!ret){
 				if (awc_i365_init(&s))
 					goto failed;
-				else found++;
+				else{
+					found++;
+#ifndef MODULE
+					if (!version_printed++)
+						printk("%s", awc_version);
+#endif /* MODULE */
+				}
 			} else if (ret == -1)
 				goto failed;
 		};
@@ -969,8 +981,6 @@
 failed: 
 	awc_i365_release();
 	return -1;
-	
-
 }
 
 #endif /* CONFIG_AIRONET4500_I365 */
@@ -980,7 +990,7 @@
 {
 	int found = 0;
 
-	printk("%s\n ", awc_version);
+	printk("%s", awc_version);
 		
 #ifdef CONFIG_AIRONET4500_PCI
 	if (awc4500_pci_probe(NULL) == -ENODEV){
diff -uNr linux-2.4.4-ac15/drivers/net/aironet4500_core.c linux/drivers/net/aironet4500_core.c
--- linux-2.4.4-ac15/drivers/net/aironet4500_core.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/aironet4500_core.c	Thu May 24 02:22:31 2001
@@ -2537,8 +2537,8 @@
 
 };
 
-static const char *aironet4500_core_version =
-"aironet4500.c v0.1 1/1/99 Elmer Joandi, elmer@ylenurme.ee.\n";
+static char aironet4500_core_version[] __initdata =
+	KERN_INFO "aironet4500_core.c v0.1 1/1/99 Elmer Joandi, elmer@ylenurme.ee.\n";
 
 struct net_device * aironet4500_devices[MAX_AWCS];
 
@@ -2566,7 +2566,7 @@
 MODULE_PARM(awc_debug,"i");
 MODULE_PARM(tx_rate,"i");
 MODULE_PARM(channel,"i");
-MODULE_PARM(tx_full_rate,"i");
+//MODULE_PARM(tx_full_rate,"i");
 MODULE_PARM(adhoc,"i");
 MODULE_PARM(master,"i");
 MODULE_PARM(slave,"i");
@@ -2575,6 +2575,12 @@
 MODULE_PARM(large_buff_mem,"i");
 MODULE_PARM(small_buff_no,"i");
 MODULE_PARM(SSID,"c33");
+MODULE_PARM_DESC(awc_debug,"Aironet debug mask");
+MODULE_PARM_DESC(channel,"Aironet ");
+MODULE_PARM_DESC(adhoc,"Aironet Access Points not available (0-1)");
+MODULE_PARM_DESC(master,"Aironet is Adhoc master (creates network sync) (0-1)");
+MODULE_PARM_DESC(slave,"Aironet is Adhoc slave (0-1)");
+MODULE_PARM_DESC(max_mtu,"Aironet MTU limit (256-2312)");
 #endif
 
 /*EXPORT_SYMBOL(tx_queue_len);
@@ -3209,18 +3215,18 @@
 	return 0;
 };
 
-static int aironet_core_init(void)
+static int __init aironet_core_init(void)
 {
 //	unsigned long flags;
 
 		
-	printk(KERN_INFO"%s", aironet4500_core_version);
+	printk("%s", aironet4500_core_version);
 	return 0;
 	
 
 }
 
-static void aironet_core_exit(void)
+static void __exit aironet_core_exit(void)
 {
 	printk(KERN_INFO "aironet4500 unloading core module \n");
 
diff -uNr linux-2.4.4-ac15/drivers/net/aironet4500_proc.c linux/drivers/net/aironet4500_proc.c
--- linux-2.4.4-ac15/drivers/net/aironet4500_proc.c	Sat May 19 18:33:43 2001
+++ linux/drivers/net/aironet4500_proc.c	Thu May 24 02:22:31 2001
@@ -1,5 +1,5 @@
 /*
- *	 Aironet 4500 Pcmcia driver
+ *	 Aironet 4500 /proc interface
  *
  *		Elmer Joandi, Januar 1999
  *	Copyright GPL
diff -uNr linux-2.4.4-ac15/drivers/net/am79c961a.c linux/drivers/net/am79c961a.c
--- linux-2.4.4-ac15/drivers/net/am79c961a.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/am79c961a.c	Thu May 24 02:22:31 2001
@@ -46,7 +46,8 @@
 
 static unsigned int net_debug = NET_DEBUG;
 
-static char *version = "am79c961 ethernet driver (c) 1995 R.M.King v0.02\n";
+static char version[] __initdata =
+	KERN_INFO "am79c961 ethernet driver (c) 1995 R.M.King v0.02\n";
 
 /* --------------------------------------------------------------------------- */
 
@@ -639,8 +640,8 @@
 {
 	static unsigned version_printed;
 
-	if (net_debug && version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+	if (version_printed++ == 0)
+		printk("%s", version);
 }
 
 static int __init am79c961_init(void)
@@ -649,6 +650,9 @@
 	struct dev_priv *priv;
 	int i, ret;
 
+#ifdef MODULE
+	am79c961_banner();
+#endif /* MODULE */
 	dev = init_etherdev(NULL, sizeof(struct dev_priv));
 	ret = -ENOMEM;
 	if (!dev)
@@ -684,7 +688,9 @@
 	if (!request_region(dev->base_addr, 0x18, dev->name))
 		goto nodev;
 
+#ifndef MODULE
 	am79c961_banner();
+#endif /* MODULE */
 	printk(KERN_INFO "%s: am79c961 found at %08lx, IRQ%d, ether address ",
 		dev->name, dev->base_addr, dev->irq);
 
diff -uNr linux-2.4.4-ac15/drivers/net/apne.c linux/drivers/net/apne.c
--- linux-2.4.4-ac15/drivers/net/apne.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/apne.c	Thu May 24 02:22:31 2001
@@ -117,11 +117,11 @@
 
 
 static const char version[] =
-    "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
+    KERN_INFO "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
 
 static int apne_owned;	/* signal if card already owned */
 
-int __init apne_probe(struct net_device *dev)
+int apne_probe(struct net_device *dev)
 {
 #ifndef MANUAL_CONFIG
 	char tuple[8];
@@ -163,7 +163,7 @@
 
 }
 
-static int __init apne_probe1(struct net_device *dev, int ioaddr)
+static int apne_probe1(struct net_device *dev, int ioaddr)
 {
     int i;
     unsigned char SA_prom[32];
@@ -180,8 +180,10 @@
                 8,   9+GAYLE_ODD, 0xa, 0xb+GAYLE_ODD,
               0xc, 0xd+GAYLE_ODD, 0xe, 0xf+GAYLE_ODD };
 
-    if (ei_debug  &&  version_printed++ == 0)
-	printk(version);
+#ifndef MODULE
+    if (version_printed++ == 0)
+	printk("%s", version);
+#endif /* MODULE */
 
     printk("PCMCIA NE*000 ethercard probe");
 
@@ -550,6 +552,7 @@
 {
 	int err;
 
+	printk("%s", version);
 	apne_dev.init = apne_probe;
 	if ((err = register_netdev(&apne_dev))) {
 		if (err == -EIO)
diff -uNr linux-2.4.4-ac15/drivers/net/arlan-proc.c linux/drivers/net/arlan-proc.c
--- linux-2.4.4-ac15/drivers/net/arlan-proc.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/arlan-proc.c	Thu May 24 02:22:31 2001
@@ -249,6 +249,7 @@
 }
 
 
+#if 0
 /******************************		TEST 	MEMORY	**************/
 
 static int arlan_hw_test_memory(struct net_device *dev)
@@ -394,6 +395,7 @@
 
 	return 0;		/* no errors */
 }
+#endif /* 0 */
 #endif
 
 #ifdef ARLAN_PROC_INTERFACE
diff -uNr linux-2.4.4-ac15/drivers/net/arlan.c linux/drivers/net/arlan.c
--- linux-2.4.4-ac15/drivers/net/arlan.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/arlan.c	Thu May 24 02:22:31 2001
@@ -8,7 +8,8 @@
 #include <linux/config.h>
 #include "arlan.h"
 
-static const char *arlan_version = "C.Jennigs 97 & Elmer.Joandi@ut.ee  Oct'98, http://www.ylenurme.ee/~elmer/655/";
+static char arlan_version[] __initdata =
+	KERN_INFO "Arlan driver C.Jennigs 97 & Elmer.Joandi@ut.ee  Oct'98, http://www.ylenurme.ee/~elmer/655/";
 
 struct net_device *arlan_device[MAX_ARLANS];
 int last_arlan;
@@ -68,6 +69,23 @@
 MODULE_PARM(arlan_exit_debug, "i");
 MODULE_PARM(arlan_entry_and_exit_debug, "i");
 MODULE_PARM(arlan_EEPROM_bad, "i");
+MODULE_PARM_DESC(irq, "(unused)");
+MODULE_PARM_DESC(mem, "Arlan memory address for single device probing");
+MODULE_PARM_DESC(probe, "Arlan probe at initialization (0-1)");
+MODULE_PARM_DESC(arlan_debug, "Arlan debug enable (0-1)");
+MODULE_PARM_DESC(numDevices, "Number of Arlan devices; ignored if >1");
+MODULE_PARM_DESC(testMemory, "(unused)");
+MODULE_PARM_DESC(mdebug, "Arlan multicast debugging (0-1)");
+MODULE_PARM_DESC(retries, "Arlan maximum packet retransmisions");
+#ifdef ARLAN_ENTRY_EXIT_DEBUGGING
+MODULE_PARM_DESC(arlan_entry_debug, "Arlan driver function entry debugging");
+MODULE_PARM_DESC(arlan_exit_debug, "Arlan driver function exit debugging");
+MODULE_PARM_DESC(arlan_entry_and_exit_debug, "Arlan driver function entry and exit debugging");
+#else
+MODULE_PARM_DESC(arlan_entry_debug, "(ignored)");
+MODULE_PARM_DESC(arlan_exit_debug, "(ignored)");
+MODULE_PARM_DESC(arlan_entry_and_exit_debug, "(ignored)");
+#endif
 
 EXPORT_SYMBOL(arlan_device);
 EXPORT_SYMBOL(arlan_conf);
@@ -910,7 +928,11 @@
 }
 
 
-static int arlan_read_card_configuration(struct net_device *dev)
+static int
+#ifndef MODULE
+__init
+#endif
+arlan_read_card_configuration(struct net_device *dev)
 {
 	u_char tlx415;
 	volatile struct arlan_shmem *arlan = ((struct arlan_private *) dev->priv)->card;
@@ -1026,7 +1048,11 @@
 }
 
 
-static int lastFoundAt = 0xbe000;
+static int lastFoundAt 
+#ifndef MODULE
+	__initdata
+#endif
+	= 0xbe000;
 
 
 /*
@@ -1035,7 +1061,11 @@
  * verifies that the correct device exists and functions.
  */
 
-static int __init arlan_check_fingerprint(int memaddr)
+static int
+#ifndef MODULE
+__init
+#endif
+arlan_check_fingerprint(int memaddr)
 {
 	static char probeText[] = "TELESYSTEM SLW INC.    ARLAN \0";
 	char tempBuf[49];
@@ -1063,7 +1093,11 @@
 
 }
 
-static int __init arlan_probe_everywhere(struct net_device *dev)
+static int 
+#ifndef MODULE
+__init
+#endif
+arlan_probe_everywhere(struct net_device *dev)
 {
 	int m;
 	int probed = 0;
@@ -1162,8 +1196,11 @@
 
 
 
-static int __init
-	      arlan_allocate_device(int num, struct net_device *devs)
+static int
+#ifndef MODULE
+__init
+#endif
+arlan_allocate_device(int num, struct net_device *devs)
 {
 
 	struct net_device *dev;
@@ -1229,7 +1266,11 @@
 }
 
 
-static int __init arlan_probe_here(struct net_device *dev, int memaddr)
+static int
+#ifndef MODULE
+__init
+#endif
+arlan_probe_here(struct net_device *dev, int memaddr)
 {
 	volatile struct arlan_shmem *arlan;
 
@@ -1972,13 +2013,13 @@
 	ARLAN_DEBUG_EXIT("arlan_set_multicast");
 }
 
+#ifndef  MODULE
 
 int __init arlan_probe(struct net_device *dev)
 {
-	printk("Arlan driver %s\n", arlan_version);
-
 	if (arlan_probe_everywhere(dev))
 		return -ENODEV;
+	printk("%s", arlan_version);
 
 	arlans_found++;
 
@@ -1987,7 +2028,7 @@
 	return 0;
 }
 
-#ifdef  MODULE
+#else /* MODULE */
 
 int init_module(void)
 {
@@ -1995,6 +2036,7 @@
 
 	ARLAN_DEBUG_ENTRY("init_module");
 
+	printk("%s", arlan_version);
 	if (channelSet != channelSetUNKNOWN || channelNumber != channelNumberUNKNOWN || systemId != systemIdUNKNOWN)
 	{
 		printk(KERN_WARNING "arlan: wrong module params for multiple devices\n ");
@@ -2026,7 +2068,6 @@
 			arlan_probe_everywhere(arlan_device[i]);
 //		arlan_command(arlan_device[i], ARLAN_COMMAND_POWERDOWN );
 	}
-	printk(KERN_INFO "Arlan driver %s\n", arlan_version);
 	ARLAN_DEBUG_EXIT("init_module");
 	return 0;
 }
@@ -2061,4 +2102,4 @@
 }
 
 
-#endif
+#endif /* MODULE */
diff -uNr linux-2.4.4-ac15/drivers/net/at1700.c linux/drivers/net/at1700.c
--- linux-2.4.4-ac15/drivers/net/at1700.c	Sat May 19 18:33:43 2001
+++ linux/drivers/net/at1700.c	Thu May 24 02:22:31 2001
@@ -61,7 +61,7 @@
 #include <linux/mca.h>
 
 static char version[] __initdata =
-	"at1700.c:v1.15 4/7/98  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+	KERN_INFO "at1700.c:v1.15 4/7/98  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 /* Tunable parameters. */
 
@@ -70,7 +70,7 @@
 
 /* These unusual address orders are used to verify the CONFIG register. */
 
-static int fmv18x_probe_list[] = {
+static int fmv18x_probe_list[] __initdata = {
 	0x220, 0x240, 0x260, 0x280, 0x2a0, 0x2c0, 0x300, 0x340, 0
 };
 
@@ -78,7 +78,7 @@
  *	ISA
  */
 
-static int at1700_probe_list[] = {
+static int at1700_probe_list[] __initdata = {
 	0x260, 0x280, 0x2a0, 0x240, 0x340, 0x320, 0x380, 0x300, 0
 };
 
@@ -86,15 +86,15 @@
  *	MCA
  */
 #ifdef CONFIG_MCA	
-static int at1700_ioaddr_pattern[] = {
+static int at1700_ioaddr_pattern[] __initdata = {
 	0x00, 0x04, 0x01, 0x05, 0x02, 0x06, 0x03, 0x07
 };
 
-static int at1700_mca_probe_list[] = {
+static int at1700_mca_probe_list[] __initdata = {
 	0x400, 0x1400, 0x2400, 0x3400, 0x4400, 0x5400, 0x6400, 0x7400, 0
 };
 
-static int at1700_irq_pattern[] = {
+static int at1700_irq_pattern[] __initdata = {
 	0x00, 0x00, 0x00, 0x30, 0x70, 0xb0, 0x00, 0x00,
 	0x00, 0xf0, 0x34, 0x74, 0xb4, 0x00, 0x00, 0xf4, 0x00
 };
@@ -226,7 +226,8 @@
 	unsigned int i, irq, is_fmv18x = 0, is_at1700 = 0;
 	int slot, ret = -ENODEV;
 	struct net_local *lp;
-	
+	static int printed_version;
+
 	if (!request_region(ioaddr, AT1700_IO_EXTENT, dev->name))
 		return -EBUSY;
 
@@ -410,8 +411,10 @@
 	outb(dev->if_port, ioaddr + MODE13);
 	outb(0x00, ioaddr + COL16CNTL);
 
-	if (net_debug)
-		printk(version);
+#ifndef MODULE
+	if (!printed_version++)
+		printk("%s", version);
+#endif /* MODULE */
 
 	/* Initialize the device structure. */
 	dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
@@ -470,7 +473,7 @@
 #define EE_READ_CMD		(6 << 6)
 #define EE_ERASE_CMD	(7 << 6)
 
-static int read_eeprom(int ioaddr, int location)
+static int __init read_eeprom(int ioaddr, int location)
 {
 	int i;
 	unsigned short retval = 0;
@@ -880,9 +883,13 @@
 MODULE_PARM(io, "i");
 MODULE_PARM(irq, "i");
 MODULE_PARM(net_debug, "i");
+MODULE_PARM_DESC(io, "AT1700/FMV18X I/O base address");
+MODULE_PARM_DESC(irq, "AT1700/FMV18X IRQ number");
+MODULE_PARM_DESC(net_debug, "AT1700/FMV18X debug level (0-6)");
 
 int init_module(void)
 {
+	printk("%s", version);
 	if (io == 0)
 		printk("at1700: You should not use auto-probing with insmod!\n");
 	dev_at1700.base_addr = io;
diff -uNr linux-2.4.4-ac15/drivers/net/atari_bionet.c linux/drivers/net/atari_bionet.c
--- linux-2.4.4-ac15/drivers/net/atari_bionet.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/atari_bionet.c	Thu May 24 02:22:31 2001
@@ -126,6 +126,7 @@
  */
 unsigned int bionet_debug = NET_DEBUG;
 MODULE_PARM(bionet_debug, "i");
+MODULE_PARM_DESC(bionet_debug, "bionet debug level (0-2)");
 
 static unsigned int bionet_min_poll_time = 2;
 
@@ -354,8 +355,10 @@
 
 	SET_MODULE_OWNER(dev);
 
-	if (bionet_debug > 0 && version_printed++ == 0)
-		printk(version);
+#ifndef MODULE
+	if (version_printed++ == 0)
+		printk("%s", version);
+#endif /* MODULE */
 
 	printk("%s: %s found, eth-addr: %02x-%02x-%02x:%02x-%02x-%02x.\n",
 		dev->name, "BioNet 100",
@@ -650,6 +653,7 @@
 init_module(void) {
 	int err;
 
+	printk("%s", version);
 	bio_dev.init = bionet_probe;
 	if ((err = register_netdev(&bio_dev))) {
 		if (err == -EEXIST)  {
diff -uNr linux-2.4.4-ac15/drivers/net/atari_pamsnet.c linux/drivers/net/atari_pamsnet.c
--- linux-2.4.4-ac15/drivers/net/atari_pamsnet.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/atari_pamsnet.c	Thu May 24 02:22:31 2001
@@ -74,9 +74,6 @@
 
 #define MAX_POLL_TIME	10
 
-static char *version =
-	"pamsnet.c:v0.2beta 30-mar-96 (c) Torsten Lang.\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -108,6 +105,9 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
+static char version[] __initdata =
+	KERN_INFO "pamsnet.c:v0.2beta 30-mar-96 (c) Torsten Lang.\n";
+
 #undef READ
 #undef WRITE
 
@@ -123,6 +123,7 @@
  */
 unsigned int pamsnet_debug = NET_DEBUG;
 MODULE_PARM(pamsnet_debug, "i");
+MODULE_PARM_DESC(pamsnet_debug, "pamsnet debug enable (0-1)");
 
 static unsigned int pamsnet_min_poll_time = 2;
 
@@ -233,7 +234,7 @@
 #define READSECTOR  READPKT
 #define WRITESECTOR WRITEPKT
 
-u_char *inquire8="MV      PAM's NET/GK";
+u_char *inquire8 __initdata = "MV      PAM's NET/GK";
 
 #define DMALOW   dma_wd.dma_lo
 #define DMAMID   dma_wd.dma_md
@@ -283,7 +284,7 @@
 
 unsigned rw;
 int lance_target = -1;
-int if_up = 0;
+int if_up;
 
 /* The following routines access the ethernet board connected to the
  * ACSI port via the st_dma chip.
@@ -433,7 +434,7 @@
 /* inquiry() returns 0 when PAM's DMA found, -1 when timeout, -2 otherwise */
 /* Please note: The buffer is for internal use only but must be defined!   */
 
-static int
+static int __init
 inquiry (target, buffer)
 	int target;
 	unsigned char *buffer;
@@ -470,8 +471,7 @@
  * a pointer to it (virtual address!) or 0 in case of an error
  */
 
-static HADDR
-*read_hw_addr(target, buffer)
+static HADDR * __init read_hw_addr(target, buffer)
 	int target;
 	unsigned char *buffer;
 {
@@ -622,8 +622,11 @@
 
 	if ((dev == NULL) || (lance_target < 0))
 		return -ENODEV;
-	if (pamsnet_debug > 0 && version_printed++ == 0)
-		printk(version);
+
+#ifndef MODULE
+	if (version_printed++ == 0)
+		printk("%s", version);
+#endif /* MODULE */
 
 	printk("%s: %s found on target %01d, eth-addr: %02x:%02x:%02x:%02x:%02x:%02x.\n",
 		dev->name, "PAM's Net/GK", lance_target,
@@ -873,6 +876,7 @@
 init_module(void) {
 	int err;
 
+	printk("%s", version);
 	pam_dev.init = pamsnet_probe;
 	if ((err = register_netdev(&pam_dev))) {
 		if (err == -EEXIST)  {
diff -uNr linux-2.4.4-ac15/drivers/net/atarilance.c linux/drivers/net/atarilance.c
--- linux-2.4.4-ac15/drivers/net/atarilance.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/atarilance.c	Thu May 24 02:22:31 2001
@@ -615,8 +615,10 @@
 	else
 		*RIEBL_IVEC_ADDR = IRQ_SOURCE_TO_VECTOR(dev->irq);
 
+#ifndef MODULE
 	if (did_version++ == 0)
-		DPRINTK( 1, ( version ));
+		DPRINTK( 1, ( "%s", version ));
+#endif /* MODULE */
 
 	/* The LANCE-specific entries in the device structure. */
 	dev->open = &lance_open;
@@ -1161,6 +1163,7 @@
 
 {	int err;
 
+	DPRINTK( 1, ( "%s", version ));
 	atarilance_dev.init = atarilance_probe;
 	if ((err = register_netdev( &atarilance_dev ))) {
 		if (err == -EIO)  {
diff -uNr linux-2.4.4-ac15/drivers/net/atp.c linux/drivers/net/atp.c
--- linux-2.4.4-ac15/drivers/net/atp.c	Sat May 19 19:00:46 2001
+++ linux/drivers/net/atp.c	Thu May 24 02:22:31 2001
@@ -30,11 +30,6 @@
 
 */
 
-static const char versionA[] =
-"atp.c:v1.09 8/9/2000 Donald Becker <becker@scyld.com>\n";
-static const char versionB[] =
-"  http://www.scyld.com/network/atp.html\n";
-
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 
@@ -149,6 +144,10 @@
 
 #include "atp.h"
 
+static char version[] __initdata =
+	KERN_INFO "atp.c:v1.09 8/9/2000 Donald Becker <becker@scyld.com>\n"
+	KERN_INFO "  http://www.scyld.com/network/atp.html\n";
+
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("RealTek RTL8002/8012 parallel port Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
@@ -156,6 +155,10 @@
 MODULE_PARM(io, "1-" __MODULE_STRING(NUM_UNITS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(NUM_UNITS) "i");
 MODULE_PARM(xcvr, "1-" __MODULE_STRING(NUM_UNITS) "i");
+MODULE_PARM_DESC(max_interrupt_work, "ATP maximum events handled per interrupt");
+MODULE_PARM_DESC(debug, "ATP debug level (0-7)");
+MODULE_PARM_DESC(io, "ATP I/O base address(es)");
+MODULE_PARM_DESC(irq, "ATP IRQ number(s)");
 
 #define RUN_AT(x) (jiffies + (x))
 
@@ -243,6 +246,7 @@
 {
 	struct net_local *lp;
 	int saved_ctrl_reg, status, i;
+	static int printed_version;
 
 	outb(0xff, ioaddr + PAR_DATA);
 	/* Save the original value of the Control register, in case we guessed
@@ -314,9 +318,9 @@
 	get_node_ID(dev);
 
 #ifndef MODULE
-	if (net_debug)
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
-#endif
+	if (!printed_version++)
+		printk("%s", version);
+#endif /* MODULE */
 
 	printk(KERN_NOTICE "%s: Pocket adapter found at %#3lx, IRQ %d, SAPROM "
 		   "%02X:%02X:%02X:%02X:%02X:%02X.\n", dev->name, dev->base_addr,
@@ -928,8 +932,9 @@
 }
 
 static int __init atp_init_module(void) {
-	if (debug)					/* Emit version even if no cards detected. */
-		printk(KERN_INFO "%s" KERN_INFO "%s", versionA, versionB);
+#ifdef MODULE
+	printk("%s", version);
+#endif /* MODULE */
 	return atp_init(NULL);
 }
 
diff -uNr linux-2.4.4-ac15/drivers/net/bagetlance.c linux/drivers/net/bagetlance.c
--- linux-2.4.4-ac15/drivers/net/bagetlance.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/bagetlance.c	Thu May 24 02:22:31 2001
@@ -1,5 +1,5 @@
 /* $Id$
- * vmelance.c: Ethernet driver for VME Lance cards on Baget/MIPS
+ * bagetlance.c: Ethernet driver for VME Lance cards on Baget/MIPS
  *      This code stealed and adopted from linux/drivers/net/atarilance.c
  *      See that for author info
  *
@@ -12,8 +12,6 @@
  * related with 16BIT-only access to A24 space.
  */
 
-static char *version = "bagetlance.c: v1.1 11/10/98\n";
-
 #include <linux/module.h>
 
 #include <linux/stddef.h>
@@ -36,6 +34,9 @@
 
 #include <asm/baget/baget.h>
 
+static char version[] __initdata =
+	KERN_INFO "bagetlance.c: v1.1 11/10/98\n";
+
 #define BAGET_LANCE_IRQ  BAGET_IRQ_MASK(0xdf)
 
 /*
@@ -59,6 +60,7 @@
 static int lance_debug = 1;
 #endif
 MODULE_PARM(lance_debug, "i");
+MODULE_PARM_DESC(lance_debug, "Lance debug level (0-3)");
 
 /* Print debug messages on probing? */
 #undef LANCE_DEBUG_PROBE
@@ -182,7 +184,7 @@
  * prefix for Riebl cards, the 00:00 at the end is arbitrary.
  */
 
-static unsigned char OldRieblDefHwaddr[6] = {
+static unsigned char OldRieblDefHwaddr[6] __initdata = {
 	0x00, 0x00, 0x36, 0x04, 0x00, 0x00
 };
 
@@ -207,7 +209,7 @@
 	PAM_CARD		/* PAM card with EEPROM */
 };
 
-static char *lance_names[] = {
+static char *lance_names[] __initdata = {
 	"Riebl-Card (without battery)",
 	"Riebl-Card (with battery)",
 	"PAM intern card"
@@ -357,7 +359,7 @@
    Don't confuse with function name -- it stays from original code
 */
 
-void *slow_memcpy( void *dst, const void *src, size_t len )
+static void *slow_memcpy( void *dst, const void *src, size_t len )
 
 {	
 	unsigned long to     = (unsigned long)dst;
@@ -709,8 +711,10 @@
 	else
 		*RIEBL_IVEC_ADDR = IRQ_SOURCE_TO_VECTOR(dev->irq);
 
+#ifndef MODULE
 	if (did_version++ == 0)
-		DPRINTK( 1, ( version ));
+		DPRINTK( 0, ( "%s", version ));
+#endif /* MODULE */
 
 	/* The LANCE-specific entries in the device structure. */
 	dev->open = &lance_open;
@@ -1332,6 +1336,7 @@
 
 {	int err;
 
+	DPRINTK( 0, ( "%s", version ));
 	bagetlance_dev.init = bagetlance_probe;
 	if ((err = register_netdev( &bagetlance_dev ))) {
 		if (err == -EIO)  {
diff -uNr linux-2.4.4-ac15/drivers/net/bmac.c linux/drivers/net/bmac.c
--- linux-2.4.4-ac15/drivers/net/bmac.c	Sat May 19 19:02:23 2001
+++ linux/drivers/net/bmac.c	Thu May 24 02:22:32 2001
@@ -564,7 +564,7 @@
 }
 
 /* Bit-reverse one byte of an ethernet hardware address. */
-static unsigned char
+static unsigned char __init
 bitrev(unsigned char b)
 {
 	int d = 0, i;
@@ -1107,7 +1107,7 @@
 #define SROMAddressBits		6
 #define EnetAddressOffset	20
 
-static unsigned char
+static unsigned char __init
 bmac_clock_out_bit(struct net_device *dev)
 {
 	unsigned short         data;
@@ -1126,7 +1126,7 @@
 	return val;
 }
 
-static void
+static void __init
 bmac_clock_in_bit(struct net_device *dev, unsigned int val)
 {
 	unsigned short data;
@@ -1144,7 +1144,7 @@
 	udelay(DelayValue);
 }
 
-static void
+static void __init
 reset_and_select_srom(struct net_device *dev)
 {
 	/* first reset */
@@ -1157,7 +1157,7 @@
 	bmac_clock_in_bit(dev, 0);
 }
 
-static unsigned short
+static unsigned short __init
 read_srom(struct net_device *dev, unsigned int addr, unsigned int addr_len)
 {
 	unsigned short data, val;
@@ -1186,7 +1186,7 @@
  * checksums. What a pain..
  */
 
-static int
+static int __init
 bmac_verify_checksum(struct net_device *dev)
 {
 	unsigned short data, storedCS;
@@ -1199,7 +1199,7 @@
 }
 
 
-static void
+static void __init
 bmac_get_station_address(struct net_device *dev, unsigned char *ea)
 {
 	int i;
diff -uNr linux-2.4.4-ac15/drivers/net/cs89x0.c linux/drivers/net/cs89x0.c
--- linux-2.4.4-ac15/drivers/net/cs89x0.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/cs89x0.c	Thu May 24 02:22:32 2001
@@ -81,6 +81,14 @@
                     : Make `version[]' __initdata
                     : Uninlined the read/write reg/word functions.
 
+  Andrzej Krzysztofowicz
+                    : Kernel 2.4.5-pre5
+                    : Added MOD_DESC_PARM
+                    : Added KERN_INFO marker to version[]
+                    : Print version: 
+                    :   - always for module
+                    :   - when a device detected for built-in
+
 */
 
 /* Always include 'config.h' first in case the user wants to turn on
@@ -139,7 +147,7 @@
 #include "cs89x0.h"
 
 static char version[] __initdata =
-"cs89x0.c: v2.4.3-pre1 Russell Nelson <nelson@crynwr.com>, Andrew Morton <andrewm@uow.edu.au>\n";
+KERN_INFO "cs89x0.c: v2.4.5-ac16 Russell Nelson <nelson@crynwr.com>, Andrew Morton <andrewm@uow.edu.au>\n";
 
 /* First, a few definitions that the brave might change.
    A zero-terminated list of I/O addresses to be probed. Some special flags..
@@ -436,8 +444,10 @@
 	if (lp->chip_type != CS8900 && lp->chip_revision >= 'C')
 		lp->send_cmd = TX_NOW;
 
-	if (net_debug  &&  version_printed++ == 0)
-		printk(version);
+#ifndef MODULE
+	if (version_printed++ == 0)
+		printk("%s", version);
+#endif /* MODULE */
 
 	printk(KERN_INFO "%s: cs89%c0%s rev %c found at %#3lx ",
 	       dev->name,
@@ -1607,6 +1617,25 @@
 MODULE_PARM(dma , "i");
 MODULE_PARM(dmasize , "i");
 MODULE_PARM(use_dma , "i");
+MODULE_PARM_DESC(io, "cs89x0 I/O base address");
+MODULE_PARM_DESC(irq, "cs89x0 IRQ number");
+#if DEBUGGING
+MODULE_PARM_DESC(debug, "cs89x0 debug level (0-6)");
+#else
+MODULE_PARM_DESC(debug, "(ignored)");
+#endif
+MODULE_PARM_DESC(media, "Set cs89x0 adapter(s) media type(s) (rj45,bnc,aui)");
+/* No other value than -1 for duplex seem to be currently interpreted */
+MODULE_PARM_DESC(duplex, "(ignored)");
+#if ALLOW_DMA
+MODULE_PARM_DESC(dma , "cs89x0 ISA DMA channel; ignored if use_dma=0");
+MODULE_PARM_DESC(dmasize , "cs89x0 DMA size in kB (16,64); ignored if use_dma=0");
+MODULE_PARM_DESC(use_dma , "cs89x0 using DMA (0-1)");
+#else
+MODULE_PARM_DESC(dma , "(ignored)");
+MODULE_PARM_DESC(dmasize , "(ignored)");
+MODULE_PARM_DESC(use_dma , "(ignored)");
+#endif
 
 MODULE_AUTHOR("Mike Cruse, Russwll Nelson <nelson@crynwr.com>, Andrew Morton <andrewm@uow.edu.au>");
 
@@ -1650,6 +1679,7 @@
 	debug = 0;
 #endif
 
+	printk("%s", version);
 	dev_cs89x0.irq = irq;
 	dev_cs89x0.base_addr = io;
 
diff -uNr linux-2.4.4-ac15/drivers/net/daynaport.c linux/drivers/net/daynaport.c
--- linux-2.4.4-ac15/drivers/net/daynaport.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/daynaport.c	Thu May 24 02:22:32 2001
@@ -23,8 +23,8 @@
 		anymore. */
 /* Cabletron E6100 card support added by Tony Mantler (eek@escape.ca) April 1999 */
 
-static const char *version =
-	"daynaport.c: v0.02 1999-05-17 Alan Cox (Alan.Cox@linux.org) and others\n";
+static char version[] __initdata =
+	KERN_INFO "daynaport.c: v0.02 1999-05-17 Alan Cox (Alan.Cox@linux.org) and others\n";
 static int version_printed;
 
 #include <linux/module.h>
@@ -279,10 +279,8 @@
 		return -ENOMEM;
 	SET_MODULE_OWNER(dev);
 
-	if (!version_printed) {
-		printk(KERN_INFO "%s", version);
-		version_printed = 1;
-	}
+	if (!version_printed++)
+		printk(version);
 
 	/*
 	 *	Dayna specific init
diff -uNr linux-2.4.4-ac15/drivers/net/de4x5.c linux/drivers/net/de4x5.c
--- linux-2.4.4-ac15/drivers/net/de4x5.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/de4x5.c	Thu May 24 02:22:32 2001
@@ -439,8 +439,6 @@
     =========================================================================
 */
 
-static const char *version = "de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com\n";
-
 #include <linux/config.h>
 #include <linux/module.h>
 
@@ -478,6 +476,9 @@
 #include <linux/ctype.h>
 
 #include "de4x5.h"
+
+static const char version[] __initdata =
+	KERN_INFO "de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com\n";
 
 #define c_char const char
 #define TWIDDLE(a) (u_short)le16_to_cpu(get_unaligned((u_short *)(a)))
diff -uNr linux-2.4.4-ac15/drivers/net/declance.c linux/drivers/net/declance.c
--- linux-2.4.4-ac15/drivers/net/declance.c	Sat May 19 18:35:44 2001
+++ linux/drivers/net/declance.c	Thu May 24 02:22:32 2001
@@ -38,8 +38,8 @@
 
 #undef DEBUG_DRIVER
 
-static char *version =
-"declance.c: v0.008 by Linux Mips DECstation task force\n";
+static char version[] __initdata =
+KERN_INFO "declance.c: v0.008 by Linux Mips DECstation task force\n";
 
 static char *lancestr = "LANCE";
 
diff -uNr linux-2.4.4-ac15/drivers/net/dgrs.c linux/drivers/net/dgrs.c
--- linux-2.4.4-ac15/drivers/net/dgrs.c	Sat May 19 18:35:45 2001
+++ linux/drivers/net/dgrs.c	Thu May 24 02:22:32 2001
@@ -1441,6 +1441,9 @@
 MODULE_PARM(iptrap, "1-4i");
 MODULE_PARM(ipxnet, "i");
 MODULE_PARM(nicmode, "i");
+MODULE_PARM_DESC(debug, "Digi RightSwitch enable debugging (0-1)");
+MODULE_PARM_DESC(dma, "Digi RightSwitch enable BM DMA (0-1)");
+MODULE_PARM_DESC(nicmode, "Digi RightSwitch operating mode (1: switch, 2: multi-NIC)");
 
 static int __init dgrs_init_module (void)
 {
diff -uNr linux-2.4.4-ac15/drivers/net/dgrs_firmware.c linux/drivers/net/dgrs_firmware.c
--- linux-2.4.4-ac15/drivers/net/dgrs_firmware.c	Sat May 19 18:34:41 2001
+++ linux/drivers/net/dgrs_firmware.c	Thu May 24 02:22:32 2001
@@ -1,6 +1,6 @@
-static int dgrs_firmnum = 550;
-static char dgrs_firmver[] = "$Version$";
-static char dgrs_firmdate[] = "11/16/96 03:45:15";
+static int dgrs_firmnum __initdata = 550;
+static char dgrs_firmver[] __initdata = "$Version$";
+static char dgrs_firmdate[] __initdata = "11/16/96 03:45:15";
 static unsigned char dgrs_code[] __initdata = {
 	213,5,192,8,0,0,0,0,0,0,0,0,
 	0,0,0,0,0,0,0,0,0,0,0,0,
@@ -9963,4 +9963,4 @@
 	109,46,99,0,114,99,0,0,48,120,0,0,
 	0,0,0,0,0,0,0,0,0,0,0,0
 	} ;
-static int dgrs_ncode = 119520 ;
+static int dgrs_ncode __initdata = 119520 ;
diff -uNr linux-2.4.4-ac15/drivers/net/dmfe.c linux/drivers/net/dmfe.c
--- linux-2.4.4-ac15/drivers/net/dmfe.c	Tue May 22 00:51:30 2001
+++ linux/drivers/net/dmfe.c	Thu May 24 02:22:32 2001
@@ -261,20 +261,20 @@
 static char version[] __devinitdata =
 	KERN_INFO "Davicom DM9xxx net driver, version " DMFE_VERSION "\n";
 
-static int dmfe_debug = 0;
+static int dmfe_debug;
 static unsigned char dmfe_media_mode = DMFE_AUTO;
-static u32 dmfe_cr6_user_set = 0;
+static u32 dmfe_cr6_user_set;
 
 /* For module input parameter */
-static int debug = 0;
-static u32 cr6set = 0;
+static int debug;
+static u32 cr6set;
 static unsigned char mode = 8;
 static u8 chkmode = 1;
-static u8 HPNA_mode = 0;	/* Default: Low Power/High Speed */
-static u8 HPNA_rx_cmd = 0;	/* Default: Disable Rx remote command */
-static u8 HPNA_tx_cmd = 0;	/* Default: Don't issue remote command */
-static u8 HPNA_NoiseFloor = 0;	/* Default: HPNA NoiseFloor */
-static u8 SF_mode = 0;		/* Special Function: 1:VLAN, 2:RX Flow Control
+static u8 HPNA_mode;		/* Default: Low Power/High Speed */
+static u8 HPNA_rx_cmd;		/* Default: Disable Rx remote command */
+static u8 HPNA_tx_cmd;		/* Default: Don't issue remote command */
+static u8 HPNA_NoiseFloor;	/* Default: HPNA NoiseFloor */
+static u8 SF_mode;		/* Special Function: 1:VLAN, 2:RX Flow Control
 				   4: TX pause packet */
 
 unsigned long CrcTable[256] = {
@@ -395,7 +395,7 @@
 	u32 dev_rev, pci_pmr;
 
 	if (!printed_version++)
-		printk(version);
+		printk("%s", version);
 
 	DMFE_DBUG(0, "dmfe_init_one()", 0);
 
@@ -2014,7 +2014,10 @@
 MODULE_PARM(HPNA_tx_cmd, "i");
 MODULE_PARM(HPNA_NoiseFloor, "i");
 MODULE_PARM(SF_mode, "i");
-
+MODULE_PARM_DESC(debug, "Davicom DM9xxx enable debugging (0-1)");
+MODULE_PARM_DESC(mode, "Davicom DM9xxx: Bit 0: 10/100Mbps, bit 2: duplex, bit 8: HomePNA");
+MODULE_PARM_DESC(SF_mode, "Davicom DM9xxx special function (bit 0: VLAN, bit 1 Flow Control, bit 2: TX pause packet)");
+                                                                                                                                
 /*	Description:
  *	when user used insmod to add module, system invoked init_module()
  *	to initilize and register.
@@ -2024,8 +2027,10 @@
 {
 	int rc;
 
-	printk(version);
+#ifdef MODULE
+	printk("s", version);
 	printed_version = 1;
+#endif /* MODULE */
 
 	DMFE_DBUG(0, "init_module() ", debug);
 
diff -uNr linux-2.4.4-ac15/drivers/net/eql.c linux/drivers/net/eql.c
--- linux-2.4.4-ac15/drivers/net/eql.c	Sat May 19 19:02:23 2001
+++ linux/drivers/net/eql.c	Thu May 24 02:22:32 2001
@@ -16,9 +16,6 @@
  *    Phone: 1-703-847-0040 ext 103
  */
 
-static const char *version = 
-	"Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Janes (simon@ncm.com)\n";
-
 /*
  * Sources:
  *   skeleton.c by Donald Becker.
@@ -124,6 +121,8 @@
 
 #include <asm/uaccess.h>
 
+static char version[] __initdata = 
+	KERN_INFO "Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Janes (simon@ncm.com)\n";
 
 #ifndef EQL_DEBUG
 /* #undef EQL_DEBUG      -* print nothing at all, not even a boot-banner */
diff -uNr linux-2.4.4-ac15/drivers/net/lne390.c linux/drivers/net/lne390.c
--- linux-2.4.4-ac15/drivers/net/lne390.c	Sat May 19 18:33:45 2001
+++ linux/drivers/net/lne390.c	Thu May 24 02:22:32 2001
@@ -31,9 +31,6 @@
 	- no need to check if dev == NULL in lne390_probe1
 */
 
-static const char *version =
-	"lne390.c: Driver revision v0.99.1, 01/09/2000\n";
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -48,6 +45,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include "8390.h"
+
+static const char version[] __initdata =
+	"lne390.c: Driver revision v0.99.1, 01/09/2000\n";
 
 int lne390_probe(struct net_device *dev);
 static int lne390_probe1(struct net_device *dev, int ioaddr);
diff -uNr linux-2.4.4-ac15/drivers/net/mac89x0.c linux/drivers/net/mac89x0.c
--- linux-2.4.4-ac15/drivers/net/mac89x0.c	Sat May 19 18:34:43 2001
+++ linux/drivers/net/mac89x0.c	Thu May 24 02:22:32 2001
@@ -55,9 +55,6 @@
   use save_flags/restore_flags in net_get_stat, not just cli/sti
 */
 
-static char *version =
-"cs89x0.c:v1.02 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
-
 /* ======================= configure the driver here ======================= */
 
 /* use 0 for production, 1 for verification, >2 for debug */
@@ -106,6 +103,9 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include "cs89x0.h"
+
+static char version[] __initrdata =
+KERN_INFO "cs89x0.c:v1.02 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
 
 static unsigned int net_debug = NET_DEBUG;
 
diff -uNr linux-2.4.4-ac15/drivers/net/ne.c linux/drivers/net/ne.c
--- linux-2.4.4-ac15/drivers/net/ne.c	Sat May 19 19:00:48 2001
+++ linux/drivers/net/ne.c	Thu May 24 02:22:32 2001
@@ -263,7 +263,7 @@
 		}
 	}
 
-	if (ei_debug  &&  version_printed++ == 0)
+	if (version_printed++ == 0)
 		printk(version);
 
 	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
diff -uNr linux-2.4.4-ac15/drivers/net/pcmcia/aironet4500_cs.c linux/drivers/net/pcmcia/aironet4500_cs.c
--- linux-2.4.4-ac15/drivers/net/pcmcia/aironet4500_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/aironet4500_cs.c	Thu May 24 02:22:32 2001
@@ -10,10 +10,6 @@
  *
  */
 
-static const char *awc_version =
-"aironet4500_cs.c v0.1 1/1/99 Elmer Joandi, elmer@ylenurme.ee.\n";
-
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -50,6 +46,8 @@
 
 #include "../aironet4500.h"
 
+static const char awc_version[] =
+KERN_INFO "aironet4500_cs.c v0.1 1/1/99 Elmer Joandi, elmer@ylenurme.ee.\n";
 
 static u_int irq_mask = 0x5eF8;
 static int 	awc_ports[] = {0x140,0x100,0xc0, 0x80 };
@@ -65,8 +63,6 @@
 static int pc_debug = PCMCIA_DEBUG;
 MODULE_PARM(pc_debug, "i");
 #define PC_DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-static char *version =
-"aironet4500_cs.c v0.1 1/1/99 Elmer Joandi, elmer@ylenurme.ee.\n";
 #else
 #define PC_DEBUG(n, args...)
 #endif
@@ -615,8 +611,7 @@
 	servinfo_t serv;
 
 	/* Always emit the version, before any failure. */
-	printk(KERN_INFO"%s", awc_version);
-	PC_DEBUG(0, "%s\n", version);
+	printk(awc_version);
 	CardServices(GetCardServicesInfo, &serv);
 	if (serv.Revision != CS_RELEASE_CODE) {
 		printk(KERN_NOTICE "awc_cs: Card Services release "
diff -uNr linux-2.4.4-ac15/drivers/net/pcnet32.c linux/drivers/net/pcnet32.c
--- linux-2.4.4-ac15/drivers/net/pcnet32.c	Sat May 19 19:00:49 2001
+++ linux/drivers/net/pcnet32.c	Thu May 24 02:22:32 2001
@@ -45,6 +45,19 @@
 
 static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
 
+/*
+ * PCI device identifiers for "new style" Linux PCI Device Drivers
+ */
+static struct pci_device_id pcnet32_pci_tbl[] __devinitdata = {
+    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE_HOME, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, 0x1014, 0x2000, 0, 0, 0 },
+    { 0, }
+};
+
+static char version[] __devinitdata =
+	KERN_INFO "pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de\n";
+
 static int pcnet32_debug = 1;
 static int tx_start = 1; /* Mapping -- 0:20, 1:64, 2:128, 3:~220 (depends on chip vers) */
 
@@ -169,8 +182,6 @@
  *                                           <jamey@crl.dec.com>
  */
 
-static const char *version = "pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de\n";
-
 /*
  * Set the number of Tx and Rx buffers, using Log_2(# buffers).
  * Reasonable default values are 4 Tx buffers, and 16 Rx buffers.
@@ -204,16 +215,6 @@
 
 #define PCNET32_TOTAL_SIZE 0x20
 
-/* some PCI ids */
-#ifndef PCI_DEVICE_ID_AMD_LANCE
-#define PCI_VENDOR_ID_AMD	      0x1022
-#define PCI_DEVICE_ID_AMD_LANCE	      0x2000
-#endif
-#ifndef PCI_DEVICE_ID_AMD_PCNETHOME
-#define PCI_DEVICE_ID_AMD_PCNETHOME   0x2001
-#endif
-
-
 #define CRC_POLYNOMIAL_LE 0xedb88320UL	/* Ethernet CRC, little endian */
 
 /* The PCNET32 Rx and Tx ring descriptors. */
@@ -319,16 +320,6 @@
 };
 
 
-/*
- * PCI device identifiers for "new style" Linux PCI Device Drivers
- */
-static struct pci_device_id pcnet32_pci_tbl[] __devinitdata = {
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PCNETHOME, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, 0x1014, 0x2000, 0, 0, 0 },
-    { 0, }
-};
-
 MODULE_DEVICE_TABLE (pci, pcnet32_pci_tbl);
 
 static u16 pcnet32_wio_read_csr (unsigned long addr, int index)
@@ -529,6 +520,7 @@
     char *chipname;
     struct net_device *dev;
     struct pcnet32_access *a = NULL;
+    static int printed_version;
 
     /* reset the chip */
     pcnet32_dwio_reset(ioaddr);
@@ -775,9 +767,11 @@
 	}
     }
 
-    if (pcnet32_debug > 0)
+#ifndef MODULE
+    if (!printed_version++)
 	printk(version);
-    
+#endif /* MODULE */
+
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
     dev->hard_start_xmit = &pcnet32_start_xmit;
@@ -1561,6 +1555,7 @@
     if ((tx_start_pt >= 0) && (tx_start_pt <= 3))
 	tx_start = tx_start_pt;
     
+    printk(version);
     pcnet32_dev = NULL;
     /* find the PCI devices */
 #define USE_PCI_REGISTER_DRIVER
diff -uNr linux-2.4.4-ac15/drivers/net/sb1000.c linux/drivers/net/sb1000.c
--- linux-2.4.4-ac15/drivers/net/sb1000.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/sb1000.c	Thu May 24 02:22:32 2001
@@ -32,8 +32,6 @@
 	Merged with 2.2 - Alan Cox
 */
 
-static char version[] = "sb1000.c:v1.1.2 6/01/98 (fventuri@mediaone.net)\n";
-
 #include <linux/module.h>
 
 #include <linux/version.h>
@@ -50,6 +48,7 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>	/* for udelay() */
+#include <linux/init.h>
 #include <asm/processor.h>
 
 #include <asm/bitops.h>
@@ -62,6 +61,9 @@
 
 #include <linux/if_cablemodem.h>
 
+static char version[] __initdata =
+	KERN_INFO "sb1000.c:v1.1.2 6/01/98 (fventuri@mediaone.net)\n";
+
 #ifdef SB1000_DEBUG
 int sb1000_debug = SB1000_DEBUG;
 #else
@@ -146,7 +148,7 @@
 MODULE_DEVICE_TABLE(isapnp, id_table);
 
 /* probe for SB1000 using Plug-n-Play mechanism */
-int
+int __init
 sb1000_probe(struct net_device *dev)
 {
 
@@ -228,7 +230,7 @@
 		memset(dev->priv, 0, sizeof(struct sb1000_private));
 
 		if (sb1000_debug > 0)
-			printk(KERN_NOTICE "%s", version);
+			printk(version);
 
 		/* The SB1000-specific entries in the device structure. */
 		dev->open = sb1000_open;
diff -uNr linux-2.4.4-ac15/drivers/net/smc-ultra.c linux/drivers/net/smc-ultra.c
--- linux-2.4.4-ac15/drivers/net/smc-ultra.c	Sat May 19 19:00:50 2001
+++ linux/drivers/net/smc-ultra.c	Thu May 24 02:22:32 2001
@@ -79,9 +79,9 @@
 int ultra_probe(struct net_device *dev);
 static int ultra_probe1(struct net_device *dev, int ioaddr);
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static int ultra_probe_isapnp(struct net_device *dev);
-#endif
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 static int ultra_open(struct net_device *dev);
 static void ultra_reset_8390(struct net_device *dev);
@@ -99,7 +99,7 @@
 							 const unsigned char *buf, const int start_page);
 static int ultra_close_card(struct net_device *dev);
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static struct isapnp_device_id ultra_device_ids[] __initdata = {
         {       ISAPNP_VENDOR('S','M','C'), ISAPNP_FUNCTION(0x8416),
                 ISAPNP_VENDOR('S','M','C'), ISAPNP_FUNCTION(0x8416),
@@ -108,7 +108,7 @@
 };
 
 MODULE_DEVICE_TABLE(isapnp, ultra_device_ids);
-#endif
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 
 #define START_PG		0x00	/* First page of TX buffer */
@@ -139,13 +139,13 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 	/* Look for any installed ISAPnP cards */
 	if (isapnp_present() && (ultra_probe_isapnp(dev) == 0))
 		return 0;
 
 	printk(KERN_NOTICE "smc-ultra.c: No ISAPnP cards found, trying standard ones...\n");
-#endif
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 	for (i = 0; ultra_portlist[i]; i++)
 		if (ultra_probe1(dev, ultra_portlist[i]) == 0)
@@ -278,7 +278,7 @@
 	return retval;
 }
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 static int __init ultra_probe_isapnp(struct net_device *dev)
 {
         int i;
@@ -318,7 +318,7 @@
 
         return -ENODEV;
 }
-#endif
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 static int
 ultra_open(struct net_device *dev)
@@ -541,11 +541,11 @@
 			/* NB: ultra_close_card() does free_irq */
 			int ioaddr = dev->base_addr - ULTRA_NIC_OFFSET;
 
-#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 			struct pci_dev *idev = (struct pci_dev *)ei_status.priv;
 			if (idev)
 				idev->deactivate(idev);
-#endif
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 			unregister_netdev(dev);
 			release_region(ioaddr, ULTRA_IO_EXTENT);
diff -uNr linux-2.4.4-ac15/drivers/net/smc-ultra32.c linux/drivers/net/smc-ultra32.c
--- linux-2.4.4-ac15/drivers/net/smc-ultra32.c	Sat May 19 19:00:50 2001
+++ linux/drivers/net/smc-ultra32.c	Thu May 24 02:22:32 2001
@@ -106,6 +106,10 @@
 {
 	int ioaddr;
 
+#ifdef MODULE
+	printk(version);
+#endif /* MODULE */
+
 	if (!EISA_bus) return -ENODEV;
 
 	SET_MODULE_OWNER(dev);
@@ -163,8 +167,10 @@
 		goto out;
 	}
 
-	if (ei_debug  &&  version_printed++ == 0)
+#ifndef MODULE
+	if (version_printed++ == 0)
 		printk(version);
+#endif /* MODULE */
 
 	model_name = "SMC Ultra32";
 
diff -uNr linux-2.4.4-ac15/drivers/net/tlan.c linux/drivers/net/tlan.c
--- linux-2.4.4-ac15/drivers/net/tlan.c	Sat May 19 19:00:50 2001
+++ linux/drivers/net/tlan.c	Thu May 24 02:22:33 2001
@@ -241,21 +241,21 @@
 };
 
 static struct pci_device_id tlan_pci_tbl[] __devinitdata = {
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL10,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETFLEX_3P_INTEGRATED,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3I,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETFLEX_3P,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_THUNDER,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETFLEX_3P_BNC,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100_PROLIANT,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100PI,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100_DUAL,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100D,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_DESKPRO_4000_5233MMX,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100I,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7 },
 	{ PCI_VENDOR_ID_OLICOM, PCI_DEVICE_ID_OLICOM_OC2183,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
diff -uNr linux-2.4.4-ac15/drivers/net/tlan.h linux/drivers/net/tlan.h
--- linux-2.4.4-ac15/drivers/net/tlan.h	Sat May 19 18:34:46 2001
+++ linux/drivers/net/tlan.h	Thu May 24 02:22:33 2001
@@ -61,25 +61,8 @@
 	 *
 	 ****************************************************************/
 		
-#define PCI_DEVICE_ID_NETELLIGENT_10			0xAE34
-#define PCI_DEVICE_ID_NETELLIGENT_10_100		0xAE32
-#define PCI_DEVICE_ID_NETFLEX_3P_INTEGRATED		0xAE35
-#define PCI_DEVICE_ID_NETFLEX_3P			0xF130
-#define PCI_DEVICE_ID_NETFLEX_3P_BNC			0xF150
-#define PCI_DEVICE_ID_NETELLIGENT_10_100_PROLIANT	0xAE43
-#define PCI_DEVICE_ID_NETELLIGENT_10_100_DUAL		0xAE40
-#define PCI_DEVICE_ID_DESKPRO_4000_5233MMX		0xB011
 #define PCI_DEVICE_ID_NETELLIGENT_10_T2			0xB012
 #define PCI_DEVICE_ID_NETELLIGENT_10_100_WS_5100	0xB030
-#ifndef PCI_DEVICE_ID_OLICOM_OC2183
-#define PCI_DEVICE_ID_OLICOM_OC2183			0x0013
-#endif
-#ifndef PCI_DEVICE_ID_OLICOM_OC2325
-#define PCI_DEVICE_ID_OLICOM_OC2325			0x0012
-#endif
-#ifndef PCI_DEVICE_ID_OLICOM_OC2326
-#define PCI_DEVICE_ID_OLICOM_OC2326			0x0014
-#endif
 
 typedef struct tlan_adapter_entry {
 	u16	vendorId;


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
