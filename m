Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbRESVm7>; Sat, 19 May 2001 17:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbRESVmu>; Sat, 19 May 2001 17:42:50 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:42761 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261351AbRESVmd>; Sat, 19 May 2001 17:42:33 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105192142.XAA02267@green.mif.pg.gda.pl>
Subject: [PATCH] 2.4.4-ac11 aironet fixes
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 19 May 2001 23:42:41 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes aironet drivers. It contains
- fixed Config.in to disable non-working configurations (PNP without isapnp,
  built-in ISA or I365)
- marked __init/__devinit/__devinitdata some initial code/variables
- disable (#if 0) currently unused function (awc4500_pnp_hw_reset)
- version printing fixes
- long delay fixes (udelay()->mdelay())
- added MODULE_PARM_DESC
- functions with local onlu use marked static
- removes duplicated version string from PCMCIA driver.

Andrzej

diff -ur linux-2.4.4-ac11/drivers/net/Config.in linux/drivers/net/Config.in
--- linux-2.4.4-ac11/drivers/net/Config.in	Fri May 18 17:56:21 2001
+++ linux/drivers/net/Config.in	Fri May 18 23:27:59 2001
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
 
diff -ur linux-2.4.4-ac11/drivers/net/aironet4500_card.c linux/drivers/net/aironet4500_card.c
--- linux-2.4.4-ac11/drivers/net/aironet4500_card.c	Tue May  1 21:14:31 2001
+++ linux/drivers/net/aironet4500_card.c	Fri May 18 22:59:20 2001
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
+KERN_INFO "aironet4500_cards.c v0.2  Feb 27, 2000  Elmer Joandi, elmer@ylenurme.ee.\n";
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
+			printk(awc_version);
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
+			printk(awc_version);
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
+						printk(awc_version);
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
diff -ur linux-2.4.4-ac11/drivers/net/aironet4500_core.c linux/drivers/net/aironet4500_core.c
--- linux-2.4.4-ac11/drivers/net/aironet4500_core.c	Tue May  1 21:14:31 2001
+++ linux/drivers/net/aironet4500_core.c	Fri May 18 23:13:36 2001
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
+	printk(aironet4500_core_version);
 	return 0;
 	
 
 }
 
-static void aironet_core_exit(void)
+static void __exit aironet_core_exit(void)
 {
 	printk(KERN_INFO "aironet4500 unloading core module \n");
 
diff -ur linux-2.4.4-ac11/drivers/net/aironet4500_proc.c linux/drivers/net/aironet4500_proc.c
--- linux-2.4.4-ac11/drivers/net/aironet4500_proc.c	Fri May 18 22:03:13 2001
+++ linux/drivers/net/aironet4500_proc.c	Fri May 18 22:02:19 2001
@@ -1,5 +1,5 @@
 /*
- *	 Aironet 4500 Pcmcia driver
+ *	 Aironet 4500 /proc interface
  *
  *		Elmer Joandi, Januar 1999
  *	Copyright GPL
diff -uNr linux-2.4.4-ac11/drivers/net/pcmcia/aironet4500_cs.c linux/drivers/net/pcmcia/aironet4500_cs.c
--- linux-2.4.4-ac11/drivers/net/pcmcia/aironet4500_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/aironet4500_cs.c	Sat May 19 23:19:08 2001
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


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
