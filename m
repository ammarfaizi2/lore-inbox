Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDWUQj>; Mon, 23 Apr 2001 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRDWUQd>; Mon, 23 Apr 2001 16:16:33 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:23052 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129359AbRDWUQA>; Mon, 23 Apr 2001 16:16:00 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104232015.WAA07001@green.mif.pg.gda.pl>
Subject: [PATCH] some network __init code
To: alan@lxorguk.ukuu.org.uk (Alan Cox), jgarzik@mandrakesoft.com
Date: Mon, 23 Apr 2001 22:15:55 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following change in -ac11:

-static const char *rcsid = "$Id: sk_g16.c,v 1.1 1994/06/30 16:25:15 root Exp $";
+static const char rcsid[] = "$Id: sk_g16.c,v 1.1 1994/06/30 16:25:15 root Exp $";

breaks drivers/net/sk_g16.c because of further:

	...
	rcsid = NULL;		/* We do not want to use this further */

[ AFAIR it is broken anyway (CONFIG_OBSOLETE), but... ]

1. What are the char* -> char array conversions of "version" strings for ?
2. I would understand them if the string were __initdata; but most of them
   are not.
3. The following patch
   - marks most of the version strings __initdata/__devinitdata (necessary
     removing of "const" from their declaration), removes unnecessary format
     strings from their printk()s, moves to __init/adds log level markers to
     them (KERN_*)
   - adds/fixes some other __init code,
   - removes some unnecessary zero initializers
   from most of the network drivers.

Any comments ?

Andrzej

*******************************************************************
diff -ur linux-2.4.3-ac12/drivers/net/3c501.c linux-ac12/drivers/net/3c501.c
--- linux-2.4.3-ac12/drivers/net/3c501.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/3c501.c	Mon Apr 23 00:40:12 2001
@@ -85,9 +85,6 @@
  *
  */
 
-static const char version[] =
-    "3c501.c: 2000/02/08 Alan Cox (alan@redhat.com).\n";
-
 /*
  *	Braindamage remaining:
  *	The 3c501 board.
@@ -115,6 +112,9 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 
+static char version[] __initdata =
+    KERN_INFO "3c501.c: 2000/02/08 Alan Cox (alan@redhat.com).\n";
+
 /* A zero-terminated list of I/O addresses to be probed.
    The 3c501 can be at many locations, but here are the popular ones. */
 static unsigned int netcard_portlist[] __initdata = { 
@@ -348,7 +348,7 @@
 #endif
 
 	if (el_debug)
-		printk("%s", version);
+		printk(version);
 
 	/*
 	 *	Initialize the device structure.
diff -ur linux-2.4.3-ac12/drivers/net/3c503.c linux-ac12/drivers/net/3c503.c
--- linux-2.4.3-ac12/drivers/net/3c503.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/3c503.c	Mon Apr 23 00:40:13 2001
@@ -30,9 +30,6 @@
 
 */
 
-static const char version[] =
-    "3c503.c:v1.10 9/23/93  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -52,6 +49,9 @@
 #include "3c503.h"
 #define WRD_COUNT 4
 
+static char version[] __initdata =
+    KERN_INFO "3c503.c:v1.10 9/23/93  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+
 int el2_probe(struct net_device *dev);
 static int el2_pio_probe(struct net_device *dev);
 static int el2_probe1(struct net_device *dev, int ioaddr);
diff -ur linux-2.4.3-ac12/drivers/net/3c507.c linux-ac12/drivers/net/3c507.c
--- linux-2.4.3-ac12/drivers/net/3c507.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/3c507.c	Mon Apr 23 00:41:06 2001
@@ -23,10 +23,6 @@
 	The statistics need to be updated correctly.
 */
 
-static const char version[] =
-	"3c507.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
-
 #include <linux/module.h>
 
 /*
@@ -62,6 +58,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 
+static char version[] __initdata =
+	KERN_INFO "3c507.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 /* use 0 for production, 1 for verification, 2..7 for debug */
 #ifndef NET_DEBUG
diff -ur linux-2.4.3-ac12/drivers/net/3c515.c linux-ac12/drivers/net/3c515.c
--- linux-2.4.3-ac12/drivers/net/3c515.c	Tue Apr 17 22:16:00 2001
+++ linux-ac12/drivers/net/3c515.c	Mon Apr 23 00:47:21 2001
@@ -77,7 +77,8 @@
 #define REQUEST_IRQ(i,h,f,n, instance) request_irq(i,h,f,n, instance)
 #define IRQ(irq, dev_id, pt_regs) (irq, dev_id, pt_regs)
 
-static char *version __initdata = "3c515.c:v0.99-sn 2000/02/12 becker@cesdis.gsfc.nasa.gov and others\n";
+static char version[] __initdata =
+	KERN_INFO "3c515.c:v0.99-sn 2000/02/12 becker@cesdis.gsfc.nasa.gov and others\n";
 
 MODULE_AUTHOR("Donald Becker <becker@cesdis.gsfc.nasa.gov>");
 MODULE_DESCRIPTION("3Com 3c515 Corkscrew driver");
diff -ur linux-2.4.3-ac12/drivers/net/3c527.c linux-ac12/drivers/net/3c527.c
--- linux-2.4.3-ac12/drivers/net/3c527.c	Tue Apr 17 22:16:00 2001
+++ linux-ac12/drivers/net/3c527.c	Mon Apr 23 00:54:44 2001
@@ -16,9 +16,6 @@
  *
  */
 
-static const char *version =
-	"3c527.c:v0.6 2001/03/03 Richard Proctor (rnp@netlink.co.nz)\n";
-
 /**
  * DOC: Traps for the unwary
  *
@@ -104,6 +101,9 @@
 
 #include "3c527.h"
 
+static char version[] __initdata =
+	KERN_DEBUG "3c527.c:v0.6 2001/03/03 Richard Proctor (rnp@netlink.co.nz)\n";
+
 /*
  * The name of the card. Is used for messages and in the requests for
  * io regions, irqs and dma channels
@@ -186,7 +186,7 @@
 	char		*name;
 };
 
-const struct mca_adapters_t mc32_adapters[] = {
+struct mca_adapters_t mc32_adapters[] __initdata = {
 	{ 0x0041, "3COM EtherLink MC/32" },
 	{ 0x8EF5, "IBM High Performance Lan Adapter" },
 	{ 0x0000, NULL }
@@ -308,7 +308,7 @@
 	/* Time to play MCA games */
 
 	if (mc32_debug  &&  version_printed++ == 0)
-		printk(KERN_DEBUG "%s", version);
+		printk(version);
 
 	printk(KERN_INFO "%s: %s found in slot %d:", dev->name, cardname, slot);
 
diff -ur linux-2.4.3-ac12/drivers/net/3c59x.c linux-ac12/drivers/net/3c59x.c
--- linux-2.4.3-ac12/drivers/net/3c59x.c	Wed Apr  4 00:31:24 2001
+++ linux-ac12/drivers/net/3c59x.c	Mon Apr 23 00:58:55 2001
@@ -220,7 +220,7 @@
 #include <linux/delay.h>
 
 static char version[] __devinitdata =
-"3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html\n";
+KERN_INFO "3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c59x/3c90x/3c575 series Vortex/Boomerang/Cyclone driver");
@@ -920,7 +920,7 @@
 	struct vortex_chip_info * const vci = &vortex_info_tbl[chip_idx];
 
 	if (!printed_version) {
-		printk (KERN_INFO "%s", version);
+		printk (version);
 		printk (KERN_INFO "See Documentation/networking/vortex.txt\n");
 		printed_version = 1;
 	}
diff -ur linux-2.4.3-ac12/drivers/net/ac3200.c linux-ac12/drivers/net/ac3200.c
--- linux-2.4.3-ac12/drivers/net/ac3200.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/ac3200.c	Mon Apr 23 00:20:46 2001
@@ -19,9 +19,6 @@
 
   */
 
-static const char version[] =
-	"ac3200.c:v1.01 7/1/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -38,6 +35,9 @@
 
 #include "8390.h"
 
+static char version[] __initdata =
+	KERN_INFO "ac3200.c:v1.01 7/1/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+
 /* Offsets from the base address. */
 #define AC_NIC_BASE	0x00
 #define AC_SA_PROM	0x16			/* The station address PROM. */
diff -ur linux-2.4.3-ac12/drivers/net/apne.c linux-ac12/drivers/net/apne.c
--- linux-2.4.3-ac12/drivers/net/apne.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/apne.c	Mon Apr 23 01:03:20 2001
@@ -116,7 +116,7 @@
 #define WORDSWAP(a) ( (((a)>>8)&0xff) | ((a)<<8) )
 
 
-static const char version[] =
+static char version[] __initdata =
     KERN_INFO "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
 
 static int apne_owned;	/* signal if card already owned */
diff -ur linux-2.4.3-ac12/drivers/net/atari_bionet.c linux-ac12/drivers/net/atari_bionet.c
--- linux-2.4.3-ac12/drivers/net/atari_bionet.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/atari_bionet.c	Mon Apr 23 01:04:56 2001
@@ -79,9 +79,6 @@
 
 #define MAX_POLL_TIME	10
 
-static char version[] =
-	"bionet.c:v1.0 06-feb-96 (c) Hartmut Laue.\n";
-
 #include <linux/module.h>
 
 #include <linux/errno.h>
@@ -114,6 +111,8 @@
 #include <asm/atari_acsi.h>
 #include <asm/atari_stdma.h>
 
+static char version[] __initdata =
+	KERN_INFO "bionet.c:v1.0 06-feb-96 (c) Hartmut Laue.\n";
 
 extern struct net_device *init_etherdev(struct net_device *dev, int sizeof_private);
 
diff -ur linux-2.4.3-ac12/drivers/net/atarilance.c linux-ac12/drivers/net/atarilance.c
--- linux-2.4.3-ac12/drivers/net/atarilance.c	Sun Apr 22 14:48:51 2001
+++ linux-ac12/drivers/net/atarilance.c	Mon Apr 23 01:06:04 2001
@@ -42,9 +42,6 @@
 
 */
 
-static char version[] = "atarilance.c: v1.3 04/04/96 "
-					   "Roman.Hodek@informatik.uni-erlangen.de\n";
-
 #include <linux/module.h>
 
 #include <linux/stddef.h>
@@ -67,6 +64,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+
+static char version[] __initdata = KERN_INFO "atarilance.c: v1.3 04/04/96 "
+					   "Roman.Hodek@informatik.uni-erlangen.de\n";
 
 /* Debug level:
  *  0 = silent, print only serious errors
diff -ur linux-2.4.3-ac12/drivers/net/de600.c linux-ac12/drivers/net/de600.c
--- linux-2.4.3-ac12/drivers/net/de600.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/de600.c	Mon Apr 23 01:08:41 2001
@@ -1,5 +1,3 @@
-static const char version[] =
-	"de600.c: $Revision: 1.40 $,  Bjorn Ekwall (bj0rn@blox.se)\n";
 /*
  *	de600.c
  *
@@ -110,6 +108,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+
+static char version[] __initdata =
+	KERN_INFO "de600.c: $Revision: 1.40 $,  Bjorn Ekwall (bj0rn@blox.se)\n";
 
 static unsigned int de600_debug = DE600_DEBUG;
 MODULE_PARM(de600_debug, "i");
diff -ur linux-2.4.3-ac12/drivers/net/de620.c linux-ac12/drivers/net/de620.c
--- linux-2.4.3-ac12/drivers/net/de620.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/de620.c	Mon Apr 23 01:09:39 2001
@@ -38,8 +38,6 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *****************************************************************************/
-static const char version[] =
-	"de620.c: $Revision: 1.40 $,  Bjorn Ekwall <bj0rn@blox.se>\n";
 
 /***********************************************************************
  *
@@ -139,6 +137,9 @@
 
 /* Constant definitions for the DE-620 registers, commands and bits */
 #include "de620.h"
+
+static char version[] __initdata =
+	KERN_INFO "de620.c: $Revision: 1.40 $,  Bjorn Ekwall <bj0rn@blox.se>\n";
 
 typedef unsigned char byte;
 
diff -ur linux-2.4.3-ac12/drivers/net/e2100.c linux-ac12/drivers/net/e2100.c
--- linux-2.4.3-ac12/drivers/net/e2100.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/e2100.c	Mon Apr 23 01:12:25 2001
@@ -31,8 +31,8 @@
 	If this happens, you must power down the machine for about 30 seconds.
 */
 
-static const char version[] =
-	"e2100.c:v1.01 7/21/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+static char version[] __initdata =
+	KERN_INFO "e2100.c:v1.01 7/21/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 #include <linux/module.h>
 
diff -ur linux-2.4.3-ac12/drivers/net/eepro.c linux-ac12/drivers/net/eepro.c
--- linux-2.4.3-ac12/drivers/net/eepro.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/eepro.c	Mon Apr 23 01:21:55 2001
@@ -96,9 +96,6 @@
 
 */
 
-static const char version[] =
-	"eepro.c: v0.12c 01/08/2000 aris@conectiva.com.br\n";
-
 #include <linux/module.h>
 
 /*
@@ -152,6 +149,8 @@
 /* udelay(2) */
 #define compat_init_data     __initdata
 
+static const char version[] compat_init_data =
+	KERN_INFO "eepro.c: v0.12c 01/08/2000 aris@conectiva.com.br\n";
 
 /* First, a few definitions that the brave might change. */
 /* A zero-terminated list of I/O addresses to be probed. */
@@ -588,7 +587,7 @@
 	return -ENODEV;
 }
 
-static void printEEPROMInfo(short ioaddr, struct net_device *dev)
+static void __init printEEPROMInfo(short ioaddr, struct net_device *dev)
 {
 	unsigned short Word;
 	int i,j;
@@ -647,7 +646,7 @@
    probes on the ISA bus.  A good device probe avoids doing writes, and
    verifies that the correct device exists and functions.  */
 
-static int eepro_probe1(struct net_device *dev, short ioaddr)
+static int __init eepro_probe1(struct net_device *dev, short ioaddr)
 {
 	unsigned short station_addr[6], id, counter;
 	int i,j, irqMask;
diff -ur linux-2.4.3-ac12/drivers/net/eepro100.c linux-ac12/drivers/net/eepro100.c
--- linux-2.4.3-ac12/drivers/net/eepro100.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/eepro100.c	Mon Apr 23 01:14:51 2001
@@ -27,10 +27,6 @@
 		PCI DMA API fixes, adding pci_dma_sync_single calls where neccesary
 */
 
-static const char *version =
-"eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html\n"
-"eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n";
-
 /* A few user-configurable values that apply to all boards.
    First set is undocumented and spelled per Intel recommendations. */
 
@@ -110,6 +106,10 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
+
+static char version[] __devinitdata =
+KERN_INFO "eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html\n"
+KERN_INFO "eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others\n";
 
 MODULE_AUTHOR("Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>");
 MODULE_DESCRIPTION("Intel i82557/i82558/i82559 PCI EtherExpressPro driver");
diff -ur linux-2.4.3-ac12/drivers/net/epic100.c linux-ac12/drivers/net/epic100.c
--- linux-2.4.3-ac12/drivers/net/epic100.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/epic100.c	Mon Apr 23 01:27:33 2001
@@ -109,11 +109,9 @@
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-"epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>\n";
-static char version2[] __devinitdata =
-"  http://www.scyld.com/network/epic100.html\n";
-static char version3[] __devinitdata =
-"  (unofficial 2.4.x kernel port, version 1.1.7, April 17, 2001)\n";
+KERN_INFO "epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>\n"
+KERN_INFO "  http://www.scyld.com/network/epic100.html\n"
+KERN_INFO "  (unofficial 2.4.x kernel port, version 1.1.7, April 17, 2001)\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("SMC 83c170 EPIC series Ethernet driver");
@@ -350,8 +348,7 @@
 #ifndef MODULE
 	static int printed_version;
 	if (!printed_version++)
-		printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
-			version, version2, version3);
+		printk (version);
 #endif
 	
 	card_idx++;
@@ -1445,8 +1442,7 @@
 {
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
-	printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
-		version, version2, version3);
+	printk (version);
 #endif
 
 	return pci_module_init (&epic_driver);
diff -ur linux-2.4.3-ac12/drivers/net/es3210.c linux-ac12/drivers/net/es3210.c
--- linux-2.4.3-ac12/drivers/net/es3210.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/es3210.c	Mon Apr 23 01:29:28 2001
@@ -45,9 +45,6 @@
 
 */
 
-static const char version[] =
-	"es3210.c: Driver revision v0.03, 14/09/96\n";
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -60,6 +57,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include "8390.h"
+
+static char version[] __initdata =
+	KERN_INFO "es3210.c: Driver revision v0.03, 14/09/96\n";
 
 int es_probe(struct net_device *dev);
 static int es_probe1(struct net_device *dev, int ioaddr);
diff -ur linux-2.4.3-ac12/drivers/net/eth16i.c linux-ac12/drivers/net/eth16i.c
--- linux-2.4.3-ac12/drivers/net/eth16i.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/eth16i.c	Mon Apr 23 01:38:44 2001
@@ -142,9 +142,6 @@
 	  irq without configuration utility.
 */
 
-static char *version = 
-    "eth16i.c: v0.35 01-Jul-1999 Mika Kuoppala (miku@iki.fi)\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -170,7 +167,8 @@
 #include <asm/io.h>		  
 #include <asm/dma.h>
 
-
+static char version[] __initdata = 
+   KERN_INFO "eth16i.c: v0.35 01-Jul-1999 Mika Kuoppala (miku@iki.fi)\n";
 
 /* Few macros */
 #define BIT(a)		       ( (1 << (a)) )  
@@ -354,21 +352,21 @@
 #define RESET                  ID_ROM_0
 
 /* This is the I/O address list to be probed when seeking the card */
-static unsigned int eth16i_portlist[] = {
+static unsigned int eth16i_portlist[] __initdata = {
 	0x260, 0x280, 0x2A0, 0x240, 0x340, 0x320, 0x380, 0x300, 0 
 };
 
-static unsigned int eth32i_portlist[] = { 
+static unsigned int eth32i_portlist[] __initdata = { 
 	0x1000, 0x2000, 0x3000, 0x4000, 0x5000, 0x6000, 0x7000, 0x8000,
 	0x9000, 0xA000, 0xB000, 0xC000, 0xD000, 0xE000, 0xF000, 0 
 };
 
 /* This is the Interrupt lookup table for Eth16i card */
-static unsigned int eth16i_irqmap[] = { 9, 10, 5, 15, 0 };
+static unsigned int eth16i_irqmap[] __initdata = { 9, 10, 5, 15, 0 };
 #define NUM_OF_ISA_IRQS    4
 
 /* This is the Interrupt lookup table for Eth32i card */
-static unsigned int eth32i_irqmap[] = { 3, 5, 7, 9, 10, 11, 12, 15, 0 };  
+static unsigned int eth32i_irqmap[] __initdata = { 3, 5, 7, 9, 10, 11, 12, 15, 0 };  
 #define EISA_IRQ_REG	0xc89
 #define NUM_OF_EISA_IRQS   8
 
@@ -434,7 +432,7 @@
 
 static struct net_device_stats *eth16i_get_stats(struct net_device *dev);
 
-static char cardname[] = "ICL EtherTeam 16i/32";
+static char cardname[] __initdata = "ICL EtherTeam 16i/32";
 
 int __init eth16i_probe(struct net_device *dev)
 {
@@ -514,7 +512,7 @@
 	BITSET(ioaddr + CONFIG_REG_0, BIT(7));  /* Disable the data link */
 
 	if( (eth16i_debug & version_printed++) == 0)
-		printk(KERN_INFO "%s", version);
+		printk(version);
 
 	dev->base_addr = ioaddr;
 	dev->irq = eth16i_get_irq(ioaddr);
@@ -832,7 +830,7 @@
 }
 #endif
 
-static int eth16i_get_irq(int ioaddr)
+static int __init eth16i_get_irq(int ioaddr)
 {
 	unsigned char cbyte;
 
@@ -850,7 +848,7 @@
 	}
 }
 
-static int eth16i_check_signature(int ioaddr)
+static int __init eth16i_check_signature(int ioaddr)
 {
 	int i;
 	unsigned char creg[4] = { 0 };
diff -ur linux-2.4.3-ac12/drivers/net/fmv18x.c linux-ac12/drivers/net/fmv18x.c
--- linux-2.4.3-ac12/drivers/net/fmv18x.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/fmv18x.c	Mon Apr 23 01:40:25 2001
@@ -31,9 +31,6 @@
     The Fujitsu FMV-181/182 user's guide
 */
 
-static const char version[] =
-	"fmv18x.c:v2.2.0 09/24/98  Yutaka TAMIYA (tamy@flab.fujitsu.co.jp)\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -58,6 +55,9 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>
+
+static char version[] __initdata =
+	KERN_INFO "fmv18x.c:v2.2.0 09/24/98  Yutaka TAMIYA (tamy@flab.fujitsu.co.jp)\n";
 
 static int fmv18x_probe_list[] __initdata = {
 	0x220, 0x240, 0x260, 0x280, 0x2a0, 0x2c0, 0x300, 0x340, 0
diff -ur linux-2.4.3-ac12/drivers/net/hamachi.c linux-ac12/drivers/net/hamachi.c
--- linux-2.4.3-ac12/drivers/net/hamachi.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/hamachi.c	Mon Apr 23 01:43:25 2001
@@ -727,7 +727,7 @@
 	return 0;
 }
 
-static int read_eeprom(long ioaddr, int location)
+static int __init read_eeprom(long ioaddr, int location)
 {
 	int bogus_cnt = 1000;
 
diff -ur linux-2.4.3-ac12/drivers/net/hp-plus.c linux-ac12/drivers/net/hp-plus.c
--- linux-2.4.3-ac12/drivers/net/hp-plus.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/hp-plus.c	Mon Apr 23 01:45:12 2001
@@ -39,6 +39,9 @@
 
 #include "8390.h"
 
+static char version[] __initdata =
+KERN_INFO "hp-plus.c:v1.10 9/24/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+
 /* A zero-terminated list of I/O addresses to be probed. */
 static unsigned int hpplus_portlist[] __initdata =
 {0x200, 0x240, 0x280, 0x2C0, 0x300, 0x320, 0x340, 0};
diff -ur linux-2.4.3-ac12/drivers/net/hp.c linux-ac12/drivers/net/hp.c
--- linux-2.4.3-ac12/drivers/net/hp.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/hp.c	Mon Apr 23 02:08:43 2001
@@ -18,10 +18,6 @@
 	  The Crynwr packet driver.
 */
 
-static const char version[] =
-	"hp.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -37,6 +33,9 @@
 #include <asm/io.h>
 
 #include "8390.h"
+
+static char version[] __initdata =
+	KERN_INFO "hp.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 /* A zero-terminated list of I/O addresses to be probed. */
 static unsigned int hppclan_portlist[] __initdata =
diff -ur linux-2.4.3-ac12/drivers/net/lance.c linux-ac12/drivers/net/lance.c
--- linux-2.4.3-ac12/drivers/net/lance.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/lance.c	Mon Apr 23 02:00:07 2001
@@ -38,8 +38,6 @@
     Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 11/01/2001
 */
 
-static const char version[] = "lance.c:v1.15ac 1999/11/13 dplatt@3do.com, becker@cesdis.gsfc.nasa.gov\n";
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -59,6 +57,9 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
+static char version[] __initdata =
+	KERN_INFO "lance.c:v1.15ac 1999/11/13 dplatt@3do.com, becker@cesdis.gsfc.nasa.gov\n";
+
 static unsigned int lance_portlist[] __initdata = { 0x300, 0x320, 0x340, 0x360, 0};
 int lance_probe(struct net_device *dev);
 static int lance_probe1(struct net_device *dev, int ioaddr, int irq, int options);
@@ -347,7 +348,7 @@
    board probes now that kmalloc() can allocate ISA DMA-able regions.
    This also allows the LANCE driver to be used as a module.
    */
-int lance_probe(struct net_device *dev)
+int __init lance_probe(struct net_device *dev)
 {
 	int *port, result;
 
diff -ur linux-2.4.3-ac12/drivers/net/myri_sbus.c linux-ac12/drivers/net/myri_sbus.c
--- linux-2.4.3-ac12/drivers/net/myri_sbus.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/myri_sbus.c	Mon Apr 23 02:07:40 2001
@@ -3,9 +3,6 @@
  * Copyright (C) 1996, 1999 David S. Miller (davem@redhat.com)
  */
 
-static char version[] =
-        "myri_sbus.c:v1.9 12/Sep/99 David S. Miller (davem@redhat.com)\n";
-
 #include <linux/module.h>
 
 #include <linux/config.h>
@@ -52,6 +49,9 @@
 
 #include "myri_code.h"
 
+static char version[] __initdata =
+	KERN_INFO "myri_sbus.c:v1.9 12/Sep/99 David S. Miller (davem@redhat.com)\n";
+
 /* #define DEBUG_DETECT */
 /* #define DEBUG_IRQ */
 /* #define DEBUG_TRANSMIT */
@@ -845,7 +845,7 @@
 }
 
 #ifdef DEBUG_DETECT
-static void dump_eeprom(struct myri_eth *mp)
+static void __init dump_eeprom(struct myri_eth *mp)
 {
 	printk("EEPROM: clockval[%08x] cpuvers[%04x] "
 	       "id[%02x,%02x,%02x,%02x,%02x,%02x]\n",
diff -ur linux-2.4.3-ac12/drivers/net/natsemi.c linux-ac12/drivers/net/natsemi.c
--- linux-2.4.3-ac12/drivers/net/natsemi.c	Sun Apr 22 14:48:41 2001
+++ linux-ac12/drivers/net/natsemi.c	Mon Apr 23 01:54:35 2001
@@ -530,7 +530,7 @@
 	EE_WriteCmd=(5 << 6), EE_ReadCmd=(6 << 6), EE_EraseCmd=(7 << 6),
 };
 
-static int eeprom_read(long addr, int location)
+static int __devinit eeprom_read(long addr, int location)
 {
 	int i;
 	int retval = 0;
diff -ur linux-2.4.3-ac12/drivers/net/ne.c linux-ac12/drivers/net/ne.c
--- linux-2.4.3-ac12/drivers/net/ne.c	Tue Apr 17 22:16:01 2001
+++ linux-ac12/drivers/net/ne.c	Mon Apr 23 02:02:49 2001
@@ -35,12 +35,6 @@
 
 /* Routines for the NatSemi-based designs (NE[12]000). */
 
-static const char version1[] =
-"ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)\n";
-static const char version2[] =
-"Last modified Nov 1, 2000 by Paul Gortmaker\n";
-
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -55,6 +49,10 @@
 #include <linux/etherdevice.h>
 #include "8390.h"
 
+static char version[] __initdata =
+KERN_INFO "ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)\n"
+KERN_INFO "Last modified Nov 1, 2000 by Paul Gortmaker\n";
+
 /* Some defines that people can play with if so inclined. */
 
 /* Do we support clones that don't adhere to 14,15 of the SAprom ? */
@@ -266,7 +264,7 @@
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
+		printk(version);
 
 	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
 
diff -ur linux-2.4.3-ac12/drivers/net/ne2.c linux-ac12/drivers/net/ne2.c
--- linux-2.4.3-ac12/drivers/net/ne2.c	Wed Apr  4 00:16:04 2001
+++ linux-ac12/drivers/net/ne2.c	Mon Apr 23 01:51:38 2001
@@ -57,8 +57,6 @@
 	If it doesn't work, be sure to send me a mail with the problems !
 */
 
-static const char *version = "ne2.c:v0.91 Nov 16 1998 Wim Dumon <wimpie@kotnet.org>\n";
-
 #include <linux/module.h>
 #include <linux/version.h>
 
@@ -85,7 +83,8 @@
 #include <linux/skbuff.h>
 #include "8390.h"
 
-
+static char version[] __initdata =
+	KERN_INFO "ne2.c:v0.91 Nov 16 1998 Wim Dumon <wimpie@kotnet.org>\n";
 
 /* Some defines that people can play with if so inclined. */
 
@@ -118,9 +117,9 @@
 static int irqs[4] __initdata = {3, 4, 5, 9};
 
 /* From the D-Link ADF file: */
-static unsigned int dlink_addresses[4]=
+static unsigned int dlink_addresses[4] __initdata =
                 {0x300, 0x320, 0x340, 0x360};
-static int dlink_irqs[8] = {3, 4, 5, 9, 10, 11, 14, 15};
+static int dlink_irqs[8] __initdata = {3, 4, 5, 9, 10, 11, 14, 15};
 
 struct ne2_adapters_t {
 	unsigned int	id;
@@ -165,7 +164,7 @@
  *
  */
 
-static void dlink_put_eeprom(unsigned char value, unsigned int addr)
+static void __init dlink_put_eeprom(unsigned char value, unsigned int addr)
 {
 	int z;
 	unsigned char v1, v2;
@@ -186,7 +185,7 @@
 	}
 }
 
-static void dlink_send_eeprom_bit(unsigned int bit, unsigned int addr)
+static void __init dlink_send_eeprom_bit(unsigned int bit, unsigned int addr)
 {
 	/* shift data bit into correct position */
 
@@ -200,7 +199,7 @@
 	dlink_put_eeprom(0x09 | bit, addr);
 }
 
-static void dlink_send_eeprom_word(unsigned int value, unsigned int len, unsigned int addr)
+static void __init dlink_send_eeprom_word(unsigned int value, unsigned int len, unsigned int addr)
 {
 	int z;
 
@@ -216,7 +215,7 @@
 	}
 }
 
-static unsigned int dlink_get_eeprom(unsigned int eeaddr, unsigned int addr)
+static unsigned int __init dlink_get_eeprom(unsigned int eeaddr, unsigned int addr)
 {
 	int z;
 	unsigned int value = 0;
diff -ur linux-2.4.3-ac12/drivers/net/ni5010.c linux-ac12/drivers/net/ni5010.c
--- linux-2.4.3-ac12/drivers/net/ni5010.c	Tue Apr 17 22:16:01 2001
+++ linux-ac12/drivers/net/ni5010.c	Mon Apr 23 02:13:01 2001
@@ -70,8 +70,8 @@
 #include "ni5010.h"
 
 static const char *boardname = "NI5010";
-static char *version =
-	"ni5010.c: v1.00 06/23/97 Jan-Pascal van Best and Andreas Mohr\n";
+static char version[] __initdata =
+	KERN_INFO "ni5010.c: v1.00 06/23/97 Jan-Pascal van Best and Andreas Mohr\n";
 	
 /* bufsize_rcv == 0 means autoprobing */
 static unsigned int bufsize_rcv;
@@ -237,7 +237,7 @@
 	PRINTK2((KERN_DEBUG "%s: I/O #3 passed!\n", dev->name));
 
 	if (NI5010_DEBUG && version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+		printk(version);
 
 	printk("NI5010 ethercard probe at 0x%x: ", ioaddr);
 
diff -ur linux-2.4.3-ac12/drivers/net/pcnet32.c linux-ac12/drivers/net/pcnet32.c
--- linux-2.4.3-ac12/drivers/net/pcnet32.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/pcnet32.c	Mon Apr 23 02:31:57 2001
@@ -21,8 +21,6 @@
  *
  *************************************************************************/
 
-static const char *version = "pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -45,6 +43,9 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 
+static const char version[] __devinitdata =
+	KERN_INFO "pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de\n";
+
 static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
 
 static int pcnet32_debug = 1;
@@ -481,7 +482,7 @@
 
 
 
-static int __init
+static int __devinit
 pcnet32_probe_pci(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
     static int card_idx;
@@ -516,7 +517,7 @@
  *  Called from both pcnet32_probe_vlbus and pcnet_probe_pci.  
  *  pdev will be NULL when called from pcnet32_probe_vlbus.
  */
-static int __init
+static int __devinit
 pcnet32_probe1(unsigned long ioaddr, unsigned char irq_line, int shared, int card_idx, struct pci_dev *pdev)
 {
     struct pcnet32_private *lp;
@@ -777,7 +778,7 @@
     }
 
     if (pcnet32_debug > 0)
-	printk(KERN_INFO "%s", version);
+	printk(version);
     
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
diff -ur linux-2.4.3-ac12/drivers/net/plip.c linux-ac12/drivers/net/plip.c
--- linux-2.4.3-ac12/drivers/net/plip.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/plip.c	Mon Apr 23 02:22:13 2001
@@ -54,7 +54,6 @@
  *     To use with DOS box, please do (Turn on ARP switch):
  *	# ifconfig plip[0-2] arp
  */
-static const char version[] = "NET3 PLIP version 2.4-parport gniibe@mri.co.jp\n";
 
 /*
   Sources:
@@ -121,6 +120,9 @@
 
 #include <linux/parport.h>
 
+static const char version[] __initdata =
+	KERN_INFO "NET3 PLIP version 2.4-parport gniibe@mri.co.jp\n";
+
 /* Maximum number of devices to support. */
 #define PLIP_MAX  8
 
@@ -302,7 +304,7 @@
 	if (!pardev)
 		return -ENODEV;
 
-	printk(KERN_INFO "%s", version);
+	printk(version);
 	if (dev->irq != -1)
 		printk(KERN_INFO "%s: Parallel port at %#3lx, using IRQ %d.\n",
 		       dev->name, dev->base_addr, dev->irq);
diff -ur linux-2.4.3-ac12/drivers/net/ptifddi.c linux-ac12/drivers/net/ptifddi.c
--- linux-2.4.3-ac12/drivers/net/ptifddi.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/ptifddi.c	Mon Apr 23 02:24:54 2001
@@ -5,15 +5,15 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
-static char *version =
-        "ptifddi.c:v1.0 10/Dec/96 David S. Miller (davem@caipfs.rutgers.edu)\n";
-
 #include <linux/string.h>
 #include <linux/init.h>
 
 #include "ptifddi.h"
 
 #include "ptifddi_asm.h"
+
+static char version[] __initdata =
+	KERN_INFO "ptifddi.c:v1.0 10/Dec/96 David S. Miller (davem@caipfs.rutgers.edu)\n";
 
 #ifdef MODULE
 static struct ptifddi *root_pti_dev;
diff -ur linux-2.4.3-ac12/drivers/net/seeq8005.c linux-ac12/drivers/net/seeq8005.c
--- linux-2.4.3-ac12/drivers/net/seeq8005.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/seeq8005.c	Mon Apr 23 02:23:29 2001
@@ -14,9 +14,6 @@
 
 */
 
-static const char version[] =
-	"seeq8005.c:v1.00 8/07/95 Hamish Coleman (hamish@zot.apana.org.au)\n";
-
 /*
   Sources:
   	SEEQ 8005 databook
@@ -53,6 +50,9 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include "seeq8005.h"
+
+static char version[] __initdata =
+	KERN_INFO "seeq8005.c:v1.00 8/07/95 Hamish Coleman (hamish@zot.apana.org.au)\n";
 
 /* First, a few definitions that the brave might change. */
 /* A zero-terminated list of I/O addresses to be probed. */
diff -ur linux-2.4.3-ac12/drivers/net/sis900.c linux-ac12/drivers/net/sis900.c
--- linux-2.4.3-ac12/drivers/net/sis900.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sis900.c	Mon Apr 23 03:05:20 2001
@@ -80,7 +80,7 @@
 	SIS_900 = 0,
 	SIS_7016
 };
-static char * card_names[] = {
+static char * card_names[] __devinitdata = {
 	"SiS 900 PCI Fast Ethernet",
 	"SiS 7016 PCI Fast Ethernet"
 };
@@ -602,7 +602,7 @@
  *	Note that location is in word (16 bits) unit
  */
 
-static u16 read_eeprom(long ioaddr, int location)
+static u16 __devinit read_eeprom(long ioaddr, int location)
 {
 	int i;
 	u16 retval = 0;
diff -ur linux-2.4.3-ac12/drivers/net/sk_g16.c linux-ac12/drivers/net/sk_g16.c
--- linux-2.4.3-ac12/drivers/net/sk_g16.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sk_g16.c	Mon Apr 23 02:51:00 2001
@@ -23,8 +23,6 @@
  *
 -*/
 
-static const char rcsid[] = "$Id: sk_g16.c,v 1.1 1994/06/30 16:25:15 root Exp $";
-
 /*
  * The Schneider & Koch (SK) G16 Network device driver is based
  * on the 'ni6510' driver from Michael Hipp which can be found at
@@ -81,6 +79,8 @@
 
 #include "sk_g16.h"
 
+static char rcsid[] __initdata = "$Id: sk_g16.c,v 1.1 1994/06/30 16:25:15 root Exp $";
+
 /* 
  * Schneider & Koch Card Definitions 
  * =================================
@@ -544,12 +544,13 @@
 {
 	int ioaddr;			   /* I/O port address used for POS regs */
 	int *port, ports[] = SK_IO_PORTS;  /* SK_G16 supported ports */
+	static unsigned version_printed;
 
 	/* get preconfigured base_addr from dev which is done in Space.c */
 	int base_addr = dev->base_addr; 
 
-        PRINTK(("%s: %s", SK_NAME, rcsid));
-        rcsid = NULL;                 /* We do not want to use this further */
+	if (version_printed++ == 0)
+	        PRINTK(("%s: %s", SK_NAME, rcsid));
 
 	if (base_addr > 0x0ff)        /* Check a single specified address */
 	{
@@ -2080,7 +2081,7 @@
  *     YY/MM/DD  uid  Description
 -*/
 
-void SK_print_ram(struct net_device *dev)
+void __init SK_print_ram(struct net_device *dev)
 {
 
     int i;    
diff -ur linux-2.4.3-ac12/drivers/net/sk_mca.c linux-ac12/drivers/net/sk_mca.c
--- linux-2.4.3-ac12/drivers/net/sk_mca.c	Wed Apr  4 00:16:05 2001
+++ linux-ac12/drivers/net/sk_mca.c	Mon Apr 23 02:58:51 2001
@@ -91,6 +91,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/mca.h>
+#include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -151,7 +152,7 @@
 
 /* deduce resources out of POS registers */
 
-static void getaddrs(int slot, int junior, int *base, int *irq,
+static void __init getaddrs(int slot, int junior, int *base, int *irq,
 		     skmca_medium * medium)
 {
 	u_char pos0, pos1, pos2;
@@ -197,7 +198,7 @@
    is disabled and won't get detected using the standard probe.  We
    therefore have to scan the slots manually :-( */
 
-static int dofind(int *junior, int firstslot)
+static int __init dofind(int *junior, int firstslot)
 {
 	int slot;
 	unsigned int id;
@@ -524,7 +525,7 @@
 
 /* probe for device's irq */
 
-static int ProbeIRQ(struct SKMCA_NETDEV *dev)
+static int __init ProbeIRQ(struct SKMCA_NETDEV *dev)
 {
 	unsigned long imaskval, njiffies, irq;
 	u16 csr0val;
@@ -1072,7 +1073,7 @@
 
 static int startslot;		/* counts through slots when probing multiple devices */
 
-int skmca_probe(struct SKMCA_NETDEV *dev)
+int __init skmca_probe(struct SKMCA_NETDEV *dev)
 {
 	int force_detect = 0;
 	int junior, slot, i;
@@ -1250,8 +1251,8 @@
 };
 #endif
 
-int irq = 0;
-int io = 0;
+int irq;
+int io;
 
 int init_module(void)
 {
diff -ur linux-2.4.3-ac12/drivers/net/smc-mca.c linux-ac12/drivers/net/smc-mca.c
--- linux-2.4.3-ac12/drivers/net/smc-mca.c	Wed Apr  4 00:18:23 2001
+++ linux-ac12/drivers/net/smc-mca.c	Mon Apr 23 03:10:58 2001
@@ -91,7 +91,7 @@
 	char *name;
 };
 
-static const struct smc_mca_adapters_t smc_mca_adapters[] = {
+static struct smc_mca_adapters_t smc_mca_adapters[] __initdata = {
     { 0x61c8, "SMC Ethercard PLUS Elite/A BNC/AUI (WD8013EP/A)" },
     { 0x61c9, "SMC Ethercard PLUS Elite/A UTP/AUI (WD8013WP/A)" },
     { 0x6fc0, "WD Ethercard PLUS/A (WD8003E/A or WD8003ET/A)" },
diff -ur linux-2.4.3-ac12/drivers/net/smc-ultra.c linux-ac12/drivers/net/smc-ultra.c
--- linux-2.4.3-ac12/drivers/net/smc-ultra.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/smc-ultra.c	Mon Apr 23 02:37:57 2001
@@ -53,9 +53,6 @@
 	interface and then load the module with an explicit io=0x___ option.
 */
 
-static const char version[] =
-	"smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
 #include <linux/config.h>
 #include <linux/module.h>
 
@@ -71,6 +68,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include "8390.h"
+
+static char version[] __initdata =
+	KERN_INFO "smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 /* A zero-terminated list of I/O addresses to be probed. */
 static unsigned int ultra_portlist[] __initdata =
diff -ur linux-2.4.3-ac12/drivers/net/smc-ultra32.c linux-ac12/drivers/net/smc-ultra32.c
--- linux-2.4.3-ac12/drivers/net/smc-ultra32.c	Wed Apr  4 00:16:05 2001
+++ linux-ac12/drivers/net/smc-ultra32.c	Mon Apr 23 03:11:27 2001
@@ -43,9 +43,6 @@
 
 */
 
-static const char *version = "smc-ultra32.c: 06/97 v1.00\n";
-
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -59,6 +56,8 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include "8390.h"
+
+static const char version[] __initdata = KERN_INFO "smc-ultra32.c: 06/97 v1.00\n";
 
 int ultra32_probe(struct net_device *dev);
 static int ultra32_probe1(struct net_device *dev, int ioaddr);
diff -ur linux-2.4.3-ac12/drivers/net/smc9194.c linux-ac12/drivers/net/smc9194.c
--- linux-2.4.3-ac12/drivers/net/smc9194.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/smc9194.c	Mon Apr 23 02:52:33 2001
@@ -53,9 +53,6 @@
  .      12/15/00  Christian Jullien fix "Warning: kfree_skb on hard IRQ"
  ----------------------------------------------------------------------------*/
 
-static KERN_INFOconst char version[] =
-	"smc9194.c:v0.14 12/15/00 by Erik Stahlman (erik@vt.edu)\n";
-
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
@@ -78,6 +75,10 @@
 #include <linux/skbuff.h>
 
 #include "smc9194.h"
+
+static char version[] __initdata =
+	KERN_INFO "smc9194.c:v0.14 12/15/00 by Erik Stahlman (erik@vt.edu)\n";
+
 /*------------------------------------------------------------------------
  .
  . Configuration options, for the experienced user to change.
@@ -897,7 +898,7 @@
 	   against the hardware address, or do some other tests. */
 
 	if (version_printed++ == 0)
-		printk("%s", version);
+		printk(version);
 
 	/* fill in some of the fields */
 	dev->base_addr = ioaddr;
diff -ur linux-2.4.3-ac12/drivers/net/sun3lance.c linux-ac12/drivers/net/sun3lance.c
--- linux-2.4.3-ac12/drivers/net/sun3lance.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sun3lance.c	Mon Apr 23 03:39:30 2001
@@ -21,8 +21,6 @@
   
 */
 
-static char *version = "sun3lance.c: v1.1 11/17/1999  Sam Creasey (sammy@oh.verio.com)\n";
-
 #include <linux/module.h>
 
 #include <linux/stddef.h>
@@ -50,6 +48,9 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
+static char version[] __initdata =
+	KERN_INFO "sun3lance.c: v1.1 11/17/1999  Sam Creasey (sammy@oh.verio.com)\n";
+
 /* sun3/60 addr/irq for the lance chip.  If your sun is different,
    change this. */
 #define LANCE_OBIO 0x120000
@@ -880,7 +881,7 @@
 
 
 #ifdef MODULE
-static char devicename[9] = { 0, };
+static char devicename[9];
 
 static struct net_device sun3lance_dev =
 {
diff -ur linux-2.4.3-ac12/drivers/net/sunbmac.c linux-ac12/drivers/net/sunbmac.c
--- linux-2.4.3-ac12/drivers/net/sunbmac.c	Sun Apr 22 14:48:51 2001
+++ linux-ac12/drivers/net/sunbmac.c	Mon Apr 23 03:24:14 2001
@@ -39,7 +39,7 @@
 #include "sunbmac.h"
 
 static char version[] __initdata =
-        "sunbmac.c:v1.9 11/Sep/99 David S. Miller (davem@redhat.com)\n";
+	KERN_INFO "sunbmac.c:v1.9 11/Sep/99 David S. Miller (davem@redhat.com)\n";
 
 #undef DEBUG_PROBE
 #undef DEBUG_TX
@@ -1062,7 +1062,7 @@
 	SET_MODULE_OWNER(dev);
 
 	if (version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+		printk(version);
 
 	if (!dev)
 		return -ENOMEM;
diff -ur linux-2.4.3-ac12/drivers/net/sungem.c linux-ac12/drivers/net/sungem.c
--- linux-2.4.3-ac12/drivers/net/sungem.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sungem.c	Mon Apr 23 03:37:37 2001
@@ -39,7 +39,7 @@
 #include "sungem.h"
 
 static char version[] __devinitdata =
-        "sungem.c:v0.75 21/Mar/01 David S. Miller (davem@redhat.com)\n";
+	KERN_INFO "sungem.c:v0.75 21/Mar/01 David S. Miller (davem@redhat.com)\n";
 
 MODULE_AUTHOR("David S. Miller (davem@redhat.com)");
 MODULE_DESCRIPTION("Sun GEM Gbit ethernet driver");
@@ -1601,7 +1601,7 @@
 	int i;
 
 	if (gem_version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+		printk(version);
 
 	gemreg_base = pci_resource_start(pdev, 0);
 	gemreg_len = pci_resource_len(pdev, 0);
diff -ur linux-2.4.3-ac12/drivers/net/sunhme.c linux-ac12/drivers/net/sunhme.c
--- linux-2.4.3-ac12/drivers/net/sunhme.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sunhme.c	Mon Apr 23 03:22:27 2001
@@ -13,9 +13,6 @@
  *     argument : macaddr=0x00,0x10,0x20,0x30,0x40,0x50
  */
 
-static char version[] =
-        "sunhme.c:v1.99 12/Sep/99 David S. Miller (davem@redhat.com)\n";
-
 #include <linux/module.h>
 
 #include <linux/config.h>
@@ -67,6 +64,8 @@
 
 #include "sunhme.h"
 
+static char version[] __initdata =
+	KERN_INFO "sunhme.c:v1.99 12/Sep/99 David S. Miller (davem@redhat.com)\n";
 
 static int macaddr[6];
 
@@ -2160,7 +2159,7 @@
 }
 
 #ifdef CONFIG_SBUS
-static void quattro_sbus_interrupt(int irq, void *cookie, struct pt_regs *ptregs)
+static void __init quattro_sbus_interrupt(int irq, void *cookie, struct pt_regs *ptregs)
 {
 	struct quattro *qp = (struct quattro *) cookie;
 	int i;
@@ -2675,7 +2674,7 @@
 	SET_MODULE_OWNER(dev);
 
 	if (hme_version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+		printk(version);
 
 	if (qfe_slot != -1)
 		printk(KERN_INFO "%s: Quattro HME slot %d (SBUS) 10/100baseT Ethernet ",
diff -ur linux-2.4.3-ac12/drivers/net/sunlance.c linux-ac12/drivers/net/sunlance.c
--- linux-2.4.3-ac12/drivers/net/sunlance.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sunlance.c	Mon Apr 23 03:36:56 2001
@@ -66,9 +66,6 @@
 
 #undef DEBUG_DRIVER
 
-static char version[] =
-	"sunlance.c:v2.00 11/Sep/99 Miguel de Icaza (miguel@nuclecu.unam.mx)\n";
-
 static char lancestr[] = "LANCE";
 
 #include <linux/config.h>
@@ -108,6 +105,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+
+static char version[] __initdata =
+	KERN_INFO "sunlance.c:v2.00 11/Sep/99 Miguel de Icaza (miguel@nuclecu.unam.mx)\n";
 
 /* Define: 2^4 Tx buffers and 2^4 Rx buffers */
 #ifndef LANCE_LOG_TX_BUFFERS
diff -ur linux-2.4.3-ac12/drivers/net/sunqe.c linux-ac12/drivers/net/sunqe.c
--- linux-2.4.3-ac12/drivers/net/sunqe.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/sunqe.c	Mon Apr 23 03:17:05 2001
@@ -7,9 +7,6 @@
  * Copyright (C) 1996, 1999 David S. Miller (davem@redhat.com)
  */
 
-static char version[] =
-        "sunqe.c:v2.9 9/11/99 David S. Miller (davem@redhat.com)\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -46,6 +43,9 @@
 
 #include "sunqe.h"
 
+static char version[] __initdata =
+	KERN_INFO "sunqe.c:v2.9 9/11/99 David S. Miller (davem@redhat.com)\n";
+
 static struct sunqec *root_qec_dev;
 
 static void qe_set_multicast(struct net_device *dev);
@@ -750,7 +750,7 @@
 		qe_devs[0]->dev_addr[j] = idprom->id_ethaddr[j];
 
 	if (version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+		printk(version);
 
 	qe_devs[1] = qe_devs[2] = qe_devs[3] = NULL;
 	for (i = 1; i < 4; i++) {
diff -ur linux-2.4.3-ac12/drivers/net/tlan.c linux-ac12/drivers/net/tlan.c
--- linux-2.4.3-ac12/drivers/net/tlan.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/tlan.c	Mon Apr 23 03:34:02 2001
@@ -205,7 +205,8 @@
 static	int		bbuf;
 static	u8		*TLanPadBuffer;
 static	char		TLanSignature[] = "TLAN";
-static const char tlan_banner[] = "ThunderLAN driver v1.14a\n";
+static char tlan_banner[] __devinitdata =
+	KERN_INFO "ThunderLAN driver v1.14a\n";
 static int tlan_have_pci;
 static int tlan_have_eisa;
 
@@ -429,7 +430,7 @@
 {
 	static int	pad_allocated;
 	
-	printk(KERN_INFO "%s", tlan_banner);
+	printk(tlan_banner);
 	
 	TLanPadBuffer = (u8 *) kmalloc(TLAN_MIN_FRAME_SIZE, 
 					GFP_KERNEL);
diff -ur linux-2.4.3-ac12/drivers/net/wd.c linux-ac12/drivers/net/wd.c
--- linux-2.4.3-ac12/drivers/net/wd.c	Sun Apr 22 14:48:42 2001
+++ linux-ac12/drivers/net/wd.c	Mon Apr 23 03:28:35 2001
@@ -24,9 +24,6 @@
 
 */
 
-static const char version[] =
-	"wd.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -41,6 +38,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include "8390.h"
+
+static  char version[] __initdata =
+	KERN_INFO "wd.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 /* A zero-terminated list of I/O addresses to be probed. */
 static unsigned int wd_portlist[] __initdata =
diff -ur linux-2.4.3-ac12/drivers/net/znet.c linux-ac12/drivers/net/znet.c
--- linux-2.4.3-ac12/drivers/net/znet.c	Sun Apr 22 14:48:43 2001
+++ linux-ac12/drivers/net/znet.c	Mon Apr 23 03:27:44 2001
@@ -1,7 +1,5 @@
 /* znet.c: An Zenith Z-Note ethernet driver for linux. */
 
-static const char version[] = "znet.c:v1.02 9/23/94 becker@cesdis.gsfc.nasa.gov\n";
-
 /*
 	Written by Donald Becker.
 
@@ -80,6 +78,9 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 
+static char version[] __initdata =
+	KERN_INFO "znet.c:v1.02 9/23/94 becker@cesdis.gsfc.nasa.gov\n";
+
 #ifndef ZNET_DEBUG
 #define ZNET_DEBUG 1
 #endif
@@ -244,7 +245,7 @@
 	}
 
 	if (znet_debug > 0)
-		printk("%s%s", KERN_INFO, version);
+		printk(version);
 
 	dev->priv = (void *) &zn;
 	zn.rx_dma = netinfo->dma1;



-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
