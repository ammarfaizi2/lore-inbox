Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTADUak>; Sat, 4 Jan 2003 15:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbTADUak>; Sat, 4 Jan 2003 15:30:40 -0500
Received: from mail2.scram.de ([195.226.127.112]:57352 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id <S261426AbTADUaH>;
	Sat, 4 Jan 2003 15:30:07 -0500
Date: Sat, 4 Jan 2003 21:37:34 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>, <mike_phillips@urscorp.com>,
       <phillim2@comcast.net>, Jeff Garzik <jgarzik@pobox.com>
Subject: Token Ring Updates (TMS380 drivers + one trivial tr.c bugfix)
Message-ID: <Pine.LNX.4.44.0301042128360.17599-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.984, 2003-01-04 21:22:07+01:00, jochen@ayse.bocc.de
  Fixed forgotten strings for rename tmsisa -> skisa.

ChangeSet@1.983, 2003-01-04 21:20:14+01:00, jochen@ayse.bocc.de
  New low level tms380 driver for Proteon 1392 / 1392+ cards
  (port from existing 2.2 kernel code)

ChangeSet@1.977.2.2, 2003-01-04 09:27:02+01:00, jochen@ayse.bocc.de
  RIF fix for tcpdump.

ChangeSet@1.977.2.1, 2003-01-04 09:21:58+01:00, jochen@ayse.bocc.de
  - add spinlock to fix race condition in tms380tr.
  - fix startup of tmsisa to not register and unregister devices multiple
    times, so hotplug doesn't run wild.
  - add support for statically compiling tmsisa into kernel.
  - remove unnecessary console SPAM during boot.
  - fixed probing of ISA devices in tmsisa.
  - fixed unsafe reference counting.
  - fixed __init function causing Oops with new module system.
  - rename tmsisa to skisa.

 b/drivers/net/Space.c              |    4
 b/drivers/net/tokenring/Kconfig    |    8
 b/drivers/net/tokenring/Makefile   |    2
 b/drivers/net/tokenring/skisa.c    |  516 +++++++++++++++++++++++++++++++++++++
 b/drivers/net/tokenring/tms380tr.c |   92 +++---
 b/drivers/net/tokenring/tms380tr.h |    1
 drivers/net/tokenring/tmsisa.c     |  473 ---------------------------------
 7 files changed, 578 insertions(+), 518 deletions(-)

 tr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

 Space.c             |    4
 tokenring/Kconfig   |   15 +
 tokenring/Makefile  |    1
 tokenring/proteon.c |  503 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 523 insertions(+)

 skisa.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Nru a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c	Sat Jan  4 21:25:30 2003
+++ b/drivers/net/Space.c	Sat Jan  4 21:25:30 2003
@@ -555,6 +555,7 @@
 #ifdef CONFIG_TR
 /* Token-ring device probe */
 extern int ibmtr_probe(struct net_device *);
+extern int sk_isa_probe(struct net_device *);
 extern int smctr_probe(struct net_device *);

 static int
@@ -563,6 +564,9 @@
     if (1
 #ifdef CONFIG_IBMTR
 	&& ibmtr_probe(dev)
+#endif
+#ifdef CONFIG_SKISA
+	&& sk_isa_probe(dev)
 #endif
 #ifdef CONFIG_SMCTR
 	&& smctr_probe(dev)
diff -Nru a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	Sat Jan  4 21:25:30 2003
+++ b/drivers/net/tokenring/Kconfig	Sat Jan  4 21:25:30 2003
@@ -131,18 +131,18 @@
 	  The module will be called tmspci.o. If you want to compile it
 	  as a module, say M here and read <file:Documentation/modules.txt>.

-config TMSISA
-	tristate "Generic TMS380 ISA support"
+config SKISA
+	tristate "SysKonnect TR4/16 ISA support"
 	depends on TR && TMS380TR!=n && ISA
 	help
-	  This tms380 module supports generic TMS380-based ISA cards.
+	  This tms380 module supports SysKonnect TR4/16 ISA cards.

 	  These cards are known to work:
 	  - SysKonnect TR4/16 ISA (SK-4190)

 	  This driver is available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called tmsisa.o. If you want to compile it
+	  The module will be called skisa.o. If you want to compile it
 	  as a module, say M here and read <file:Documentation/modules.txt>.

 config ABYSS
diff -Nru a/drivers/net/tokenring/Makefile b/drivers/net/tokenring/Makefile
--- a/drivers/net/tokenring/Makefile	Sat Jan  4 21:25:30 2003
+++ b/drivers/net/tokenring/Makefile	Sat Jan  4 21:25:30 2003
@@ -11,6 +11,6 @@
 obj-$(CONFIG_ABYSS) 	+= abyss.o
 obj-$(CONFIG_MADGEMC) 	+= madgemc.o
 obj-$(CONFIG_TMSPCI) 	+= tmspci.o
-obj-$(CONFIG_TMSISA) 	+= tmsisa.o
+obj-$(CONFIG_SKISA) 	+= skisa.o
 obj-$(CONFIG_SMCTR) 	+= smctr.o
 obj-$(CONFIG_3C359)	+= 3c359.o
diff -Nru a/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/net/tokenring/skisa.c	Sat Jan  4 21:25:30 2003
@@ -0,0 +1,516 @@
+/*
+ *  skisa.c: A network driver for SK-NET TMS380-based ISA token ring cards.
+ *
+ *  Based on tmspci written 1999 by Adam Fritzler
+ *
+ *  Written 2000 by Jochen Friedrich
+ *  Dedicated to my girlfriend Steffi Bopp
+ *
+ *  This software may be used and distributed according to the terms
+ *  of the GNU General Public License, incorporated herein by reference.
+ *
+ *  This driver module supports the following cards:
+ *	- SysKonnect TR4/16(+) ISA	(SK-4190)
+ *
+ *  Maintainer(s):
+ *    AF        Adam Fritzler           mid@auk.cx
+ *    JF	Jochen Friedrich	jochen@scram.de
+ *
+ *  Modification History:
+ *	14-Jan-01	JF	Created
+ *	28-Oct-02	JF	Fixed probe of card for static compilation.
+ *				Fixed module init to not make hotplug go wild.
+ *	09-Nov-02	JF	Fixed early bail out on out of memory
+ *				situations if multiple cards are found.
+ *				Cleaned up some unnecessary console SPAM.
+ *	09-Dec-02	JF	Fixed module reference counting.
+ *	02-Jan-03	JF	Renamed to skisa.c
+ *
+ */
+static const char version[] = "skisa.c: v1.03 09/12/2002 by Jochen Friedrich\n";
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/trdevice.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pci.h>
+#include <asm/dma.h>
+
+#include "tms380tr.h"
+
+#define SK_ISA_IO_EXTENT 32
+
+/* A zero-terminated list of I/O addresses to be probed. */
+static unsigned int portlist[] __initdata = {
+	0x0A20, 0x1A20, 0x0B20, 0x1B20, 0x0980, 0x1980, 0x0900, 0x1900,// SK
+	0
+};
+
+/* A zero-terminated list of IRQs to be probed.
+ * Used again after initial probe for sktr_chipset_init, called from sktr_open.
+ */
+static unsigned short irqlist[] = {
+	3, 5, 9, 10, 11, 12, 15,
+	0
+};
+
+/* A zero-terminated list of DMAs to be probed. */
+static int dmalist[] __initdata = {
+	5, 6, 7,
+	0
+};
+
+static char isa_cardname[] = "SK NET TR 4/16 ISA\0";
+
+int sk_isa_probe(struct net_device *dev);
+static int sk_isa_open(struct net_device *dev);
+static int sk_isa_close(struct net_device *dev);
+static void sk_isa_read_eeprom(struct net_device *dev);
+static unsigned short sk_isa_setnselout_pins(struct net_device *dev);
+
+static unsigned short sk_isa_sifreadb(struct net_device *dev, unsigned short reg)
+{
+	return inb(dev->base_addr + reg);
+}
+
+static unsigned short sk_isa_sifreadw(struct net_device *dev, unsigned short reg)
+{
+	return inw(dev->base_addr + reg);
+}
+
+static void sk_isa_sifwriteb(struct net_device *dev, unsigned short val, unsigned short reg)
+{
+	outb(val, dev->base_addr + reg);
+}
+
+static void sk_isa_sifwritew(struct net_device *dev, unsigned short val, unsigned short reg)
+{
+	outw(val, dev->base_addr + reg);
+}
+
+struct sk_isa_card {
+	struct net_device *dev;
+	struct sk_isa_card *next;
+};
+
+static struct sk_isa_card *sk_isa_card_list;
+
+static int __init sk_isa_probe1(int ioaddr)
+{
+	unsigned char old, chk1, chk2;
+
+	old = inb(ioaddr + SIFADR);	/* Get the old SIFADR value */
+
+	chk1 = 0;	/* Begin with check value 0 */
+	do {
+		/* Write new SIFADR value */
+		outb(chk1, ioaddr + SIFADR);
+
+		/* Read, invert and write */
+		chk2 = inb(ioaddr + SIFADD);
+		chk2 ^= 0x0FE;
+		outb(chk2, ioaddr + SIFADR);
+
+		/* Read, invert and compare */
+		chk2 = inb(ioaddr + SIFADD);
+		chk2 ^= 0x0FE;
+
+		if(chk1 != chk2)
+			return (-1);	/* No adapter */
+
+		chk1 -= 2;
+	} while(chk1 != 0);	/* Repeat 128 times (all byte values) */
+
+    	/* Restore the SIFADR value */
+	outb(old, ioaddr + SIFADR);
+
+	return (0);
+}
+
+int __init sk_isa_probe(struct net_device *dev)
+{
+        static int versionprinted;
+	struct net_local *tp;
+	int i,j;
+	struct sk_isa_card *card;
+
+	SET_MODULE_OWNER(dev);
+	if (!dev->base_addr)
+	{
+		for(i = 0; portlist[i]; i++)
+		{
+			if (!request_region(portlist[i], SK_ISA_IO_EXTENT, isa_cardname))
+				continue;
+
+			if(sk_isa_probe1(portlist[i]))
+			{
+				release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+				continue;
+			}
+
+			dev->base_addr = portlist[i];
+			break;
+		}
+		if(!dev->base_addr)
+			return -1;
+	}
+	else
+	{
+		if (!request_region(dev->base_addr, SK_ISA_IO_EXTENT, isa_cardname))
+			return -1;
+
+		if(sk_isa_probe1(dev->base_addr))
+		{
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			return -1;
+  		}
+	}
+
+	/* At this point we have found a valid card. */
+
+	if (versionprinted++ == 0)
+		printk(KERN_DEBUG "%s", version);
+
+#ifndef MODULE
+	dev = init_trdev(dev, 0);
+	if (!dev)
+	{
+		release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+		return -1;
+	}
+#endif
+
+	if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL))
+       	{
+		release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+		return -1;
+	}
+
+	dev->base_addr &= ~3;
+
+	sk_isa_read_eeprom(dev);
+
+	printk(KERN_DEBUG "%s:    Ring Station Address: ", dev->name);
+	printk("%2.2x", dev->dev_addr[0]);
+	for (j = 1; j < 6; j++)
+		printk(":%2.2x", dev->dev_addr[j]);
+	printk("\n");
+
+	tp = (struct net_local *)dev->priv;
+	tp->setnselout = sk_isa_setnselout_pins;
+
+	tp->sifreadb = sk_isa_sifreadb;
+	tp->sifreadw = sk_isa_sifreadw;
+	tp->sifwriteb = sk_isa_sifwriteb;
+	tp->sifwritew = sk_isa_sifwritew;
+
+	memcpy(tp->ProductID, isa_cardname, PROD_ID_SIZE + 1);
+
+	tp->tmspriv = NULL;
+
+	dev->open = sk_isa_open;
+	dev->stop = sk_isa_close;
+
+	if (dev->irq == 0)
+	{
+		for(j = 0; irqlist[j] != 0; j++)
+		{
+			dev->irq = irqlist[j];
+			if (!request_irq(dev->irq, tms380tr_interrupt, 0,
+				isa_cardname, dev))
+				break;
+                }
+
+                if(irqlist[j] == 0)
+                {
+                        printk(KERN_INFO "%s: AutoSelect no IRQ available\n", dev->name);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+	else
+	{
+		for(j = 0; irqlist[j] != 0; j++)
+			if (irqlist[j] == dev->irq)
+				break;
+		if (irqlist[j] == 0)
+		{
+			printk(KERN_INFO "%s: Illegal IRQ %d specified\n",
+				dev->name, dev->irq);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			tmsdev_term(dev);
+			return -1;
+		}
+		if (request_irq(dev->irq, tms380tr_interrupt, 0,
+			isa_cardname, dev))
+		{
+                        printk(KERN_INFO "%s: Selected IRQ %d not available\n",
+				dev->name, dev->irq);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+
+	if (dev->dma == 0)
+	{
+		for(j = 0; dmalist[j] != 0; j++)
+		{
+			dev->dma = dmalist[j];
+                        if (!request_dma(dev->dma, isa_cardname))
+				break;
+		}
+
+		if(dmalist[j] == 0)
+		{
+			printk(KERN_INFO "%s: AutoSelect no DMA available\n", dev->name);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+	else
+	{
+		for(j = 0; dmalist[j] != 0; j++)
+			if (dmalist[j] == dev->dma)
+				break;
+		if (dmalist[j] == 0)
+		{
+                        printk(KERN_INFO "%s: Illegal DMA %d specified\n",
+				dev->name, dev->dma);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			tmsdev_term(dev);
+			return -1;
+		}
+		if (request_dma(dev->dma, isa_cardname))
+		{
+                        printk(KERN_INFO "%s: Selected DMA %d not available\n",
+				dev->name, dev->dma);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+
+	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
+	       dev->name, dev->base_addr, dev->irq, dev->dma);
+
+	if (register_trdev(dev) == 0)
+	{
+		/* Enlist in the card list */
+		card = kmalloc(sizeof(struct sk_isa_card), GFP_KERNEL);
+		if (!card) {
+			unregister_trdev(dev);
+			release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			free_dma(dev->dma);
+			tmsdev_term(dev);
+			return -1;
+		}
+		card->next = sk_isa_card_list;
+		sk_isa_card_list = card;
+		card->dev = dev;
+	}
+	else
+	{
+		printk("KERN_INFO %s: register_trdev() returned non-zero.\n", dev->name);
+		release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+		free_irq(dev->irq, dev);
+		free_dma(dev->dma);
+		tmsdev_term(dev);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Reads MAC address from adapter RAM, which should've read it from
+ * the onboard ROM.
+ *
+ * Calling this on a board that does not support it can be a very
+ * dangerous thing.  The Madge board, for instance, will lock your
+ * machine hard when this is called.  Luckily, its supported in a
+ * seperate driver.  --ASF
+ */
+static void sk_isa_read_eeprom(struct net_device *dev)
+{
+	int i;
+
+	/* Address: 0000:0000 */
+	sk_isa_sifwritew(dev, 0, SIFADX);
+	sk_isa_sifwritew(dev, 0, SIFADR);
+
+	/* Read six byte MAC address data */
+	dev->addr_len = 6;
+	for(i = 0; i < 6; i++)
+		dev->dev_addr[i] = sk_isa_sifreadw(dev, SIFINC) >> 8;
+}
+
+unsigned short sk_isa_setnselout_pins(struct net_device *dev)
+{
+	return 0;
+}
+
+static int sk_isa_open(struct net_device *dev)
+{
+	struct net_local *tp = (struct net_local *)dev->priv;
+	unsigned short val = 0;
+	unsigned short oldval;
+	int i;
+
+	val = 0;
+	for(i = 0; irqlist[i] != 0; i++)
+	{
+		if(irqlist[i] == dev->irq)
+			break;
+	}
+
+	val |= CYCLE_TIME << 2;
+	val |= i << 4;
+	i = dev->dma - 5;
+	val |= i;
+	if(tp->DataRate == SPEED_4)
+		val |= LINE_SPEED_BIT;
+	else
+		val &= ~LINE_SPEED_BIT;
+	oldval = sk_isa_sifreadb(dev, POSREG);
+	/* Leave cycle bits alone */
+	oldval |= 0xf3;
+	val &= oldval;
+	sk_isa_sifwriteb(dev, val, POSREG);
+
+	tms380tr_open(dev);
+	return 0;
+}
+
+static int sk_isa_close(struct net_device *dev)
+{
+	tms380tr_close(dev);
+	return 0;
+}
+
+#ifdef MODULE
+
+#define ISATR_MAX_ADAPTERS 3
+
+static int io[ISATR_MAX_ADAPTERS];
+static int irq[ISATR_MAX_ADAPTERS];
+static int dma[ISATR_MAX_ADAPTERS];
+
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(io, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
+MODULE_PARM(irq, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
+MODULE_PARM(dma, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
+
+int init_module(void)
+{
+	int i, num;
+	struct net_device *dev;
+
+	num = 0;
+	if (io[0])
+	{ /* Only probe addresses from command line */
+		dev = init_trdev(NULL, 0);
+		if (!dev)
+			return (-ENOMEM);
+		for (i = 0; i < ISATR_MAX_ADAPTERS; i++)
+	       	{
+			if (io[i] == 0)
+				continue;
+
+			dev->base_addr = io[i];
+			dev->irq       = irq[i];
+			dev->dma       = dma[i];
+
+			if (!sk_isa_probe(dev))
+			{
+				num++;
+				dev = init_trdev(NULL, 0);
+				if (!dev)
+					goto partial;
+			}
+		}
+		unregister_netdev(dev);
+		kfree(dev);
+	}
+       	else
+       	{
+		dev = init_trdev(NULL, 0);
+		if (!dev)
+			return (-ENOMEM);
+
+		for(i = 0; portlist[i]; i++)
+		{
+			if (num >= ISATR_MAX_ADAPTERS)
+				continue;
+
+			dev->base_addr = portlist[i];
+			dev->irq       = irq[num];
+			dev->dma       = dma[num];
+
+			if (!sk_isa_probe(dev))
+			{
+				num++;
+				dev = init_trdev(NULL, 0);
+				if (!dev)
+					goto partial;
+			}
+		}
+		unregister_netdev(dev);
+		kfree(dev);
+	}
+partial:
+	printk(KERN_NOTICE "tmsisa.c: %d cards found.\n", num);
+	/* Probe for cards. */
+	if (num == 0) {
+		printk(KERN_NOTICE "tmsisa.c: No cards found.\n");
+		return (-ENODEV);
+	}
+	return (0);
+}
+
+void cleanup_module(void)
+{
+	struct net_device *dev;
+	struct sk_isa_card *this_card;
+
+	while (sk_isa_card_list) {
+		dev = sk_isa_card_list->dev;
+
+		unregister_netdev(dev);
+		release_region(dev->base_addr, SK_ISA_IO_EXTENT);
+		free_irq(dev->irq, dev);
+		free_dma(dev->dma);
+		tmsdev_term(dev);
+		kfree(dev);
+		this_card = sk_isa_card_list;
+		sk_isa_card_list = this_card->next;
+		kfree(this_card);
+	}
+}
+#endif /* MODULE */
+
+
+/*
+ * Local variables:
+ *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmsisa.c"
+ *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmsisa.c"
+ *  c-set-style "K&R"
+ *  c-indent-level: 8
+ *  c-basic-offset: 8
+ *  tab-width: 8
+ * End:
+ */
diff -Nru a/drivers/net/tokenring/tms380tr.c b/drivers/net/tokenring/tms380tr.c
--- a/drivers/net/tokenring/tms380tr.c	Sat Jan  4 21:25:30 2003
+++ b/drivers/net/tokenring/tms380tr.c	Sat Jan  4 21:25:30 2003
@@ -57,6 +57,11 @@
  *				as well.
  *      14-Jan-01	JF	Fix DMA on ifdown/ifup sequences. Some
  *      			cleanup.
+ *	13-Jan-02	JF	Add spinlock to fix race condition.
+ *	09-Nov-02	JF	Fixed printks to not SPAM the console during
+ *				normal operation.
+ *	30-Dec-02	JF	Removed incorrect __init from
+ *				tms380tr_init_card.
  *
  *  To do:
  *    1. Multi/Broadcast packet handling (this may have fixed itself)
@@ -68,7 +73,7 @@
  */

 #ifdef MODULE
-static const char version[] = "tms380tr.c: v1.08 14/01/2001 by Christoph Goos, Adam Fritzler\n";
+static const char version[] = "tms380tr.c: v1.10 30/12/2002 by Christoph Goos, Adam Fritzler\n";
 #endif

 #include <linux/module.h>
@@ -230,10 +235,10 @@
 #endif

 /* Dummy function */
-static int __init tms380tr_init_card(struct net_device *dev)
+static int tms380tr_init_card(struct net_device *dev)
 {
 	if(tms380tr_debug > 3)
-		printk("%s: tms380tr_init_card\n", dev->name);
+		printk(KERN_DEBUG "%s: tms380tr_init_card\n", dev->name);

 	return (0);
 }
@@ -251,6 +256,9 @@
 	struct net_local *tp = (struct net_local *)dev->priv;
 	int err;

+	/* init the spinlock */
+	spin_lock_init(tp->lock);
+
 	/* Reset the hardware here. Don't forget to set the station address. */

 	if(dev->dma > 0)
@@ -276,7 +284,7 @@
 	tp->timer.data		= (unsigned long)dev;
 	add_timer(&tp->timer);

-	printk(KERN_INFO "%s: Adapter RAM size: %dK\n",
+	printk(KERN_DEBUG "%s: Adapter RAM size: %dK\n",
 	       dev->name, tms380tr_read_ptr(dev));

 	tms380tr_enable_interrupts(dev);
@@ -339,25 +347,25 @@
 	tms380tr_init_net_local(dev);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Resetting adapter...\n", dev->name);
+		printk(KERN_DEBUG "%s: Resetting adapter...\n", dev->name);
 	err = tms380tr_reset_adapter(dev);
 	if(err < 0)
 		return (-1);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Bringup diags...\n", dev->name);
+		printk(KERN_DEBUG "%s: Bringup diags...\n", dev->name);
 	err = tms380tr_bringup_diags(dev);
 	if(err < 0)
 		return (-1);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Init adapter...\n", dev->name);
+		printk(KERN_DEBUG "%s: Init adapter...\n", dev->name);
 	err = tms380tr_init_adapter(dev);
 	if(err < 0)
 		return (-1);

 	if(tms380tr_debug > 3)
-		printk(KERN_INFO "%s: Done!\n", dev->name);
+		printk(KERN_DEBUG "%s: Done!\n", dev->name);
 	return (0);
 }

@@ -628,6 +636,7 @@
 	TPL *tpl;
 	short length;
 	unsigned char *buf;
+	unsigned long flags;
 	struct sk_buff *skb;
 	int i;
 	dma_addr_t dmabuf, newbuf;
@@ -639,18 +648,22 @@
 		 * NOTE: We *must* always leave one unused TPL in the chain,
 		 * because otherwise the adapter might send frames twice.
 		 */
+		spin_lock_irqsave(&tp->lock, flags);
 		if(tp->TplFree->NextTPLPtr->BusyFlag)	/* No free TPL */
 		{
 			if (tms380tr_debug > 0)
-				printk(KERN_INFO "%s: No free TPL\n", dev->name);
+				printk(KERN_DEBUG "%s: No free TPL\n", dev->name);
+				spin_unlock_irqrestore(&tp->lock, flags);
 			return;
 		}

 		/* Send first buffer from queue */
 		skb = skb_dequeue(&tp->SendSkbQueue);
 		if(skb == NULL)
+		{
+			spin_unlock_irqrestore(&tp->lock, flags);
 			return;
-
+		}
 		tp->QueueSkb++;
 		dmabuf = 0;

@@ -698,6 +711,7 @@

 		/* Let adapter send the frame. */
 		tms380tr_exec_sifcmd(dev, CMD_TX_VALID);
+		spin_unlock_irqrestore(&tp->lock, flags);
 	}

 	return;
@@ -773,7 +787,7 @@
 	unsigned short irq_type;

 	if(dev == NULL) {
-		printk("%s: irq %d for unknown device.\n", dev->name, irq);
+		printk(KERN_INFO "%s: irq %d for unknown device.\n", dev->name, irq);
 		return;
 	}

@@ -785,7 +799,7 @@
 		irq_type &= STS_IRQ_MASK;

 		if(!tms380tr_chk_ssb(tp, irq_type)) {
-			printk(KERN_INFO "%s: DATA LATE occurred\n", dev->name);
+			printk(KERN_DEBUG "%s: DATA LATE occurred\n", dev->name);
 			break;
 		}

@@ -843,7 +857,7 @@
 			break;

 		default:
-			printk(KERN_INFO "Unknown Token Ring IRQ (0x%04x)\n", irq_type);
+			printk(KERN_DEBUG "Unknown Token Ring IRQ (0x%04x)\n", irq_type);
 			break;
 		}

@@ -1377,7 +1391,7 @@
 	do {
 		retry_cnt--;
 		if(tms380tr_debug > 3)
-			printk(KERN_INFO "BUD-Status: ");
+			printk(KERN_DEBUG "BUD-Status: ");
 		loop_cnt = BUD_MAX_LOOPCNT;	/* maximum: three seconds*/
 		do {			/* Inspect BUD results */
 			loop_cnt--;
@@ -1386,7 +1400,7 @@
 			Status &= STS_MASK;

 			if(tms380tr_debug > 3)
-				printk(KERN_INFO " %04X \n", Status);
+				printk(KERN_DEBUG " %04X \n", Status);
 			/* BUD successfully completed */
 			if(Status == STS_INITIALIZE)
 				return (1);
@@ -1443,10 +1457,10 @@

 	if(tms380tr_debug > 3)
 	{
-		printk(KERN_INFO "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-		printk(KERN_INFO "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
-		printk(KERN_INFO "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
-		printk(KERN_INFO "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
+		printk(KERN_DEBUG "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
+		printk(KERN_DEBUG "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+		printk(KERN_DEBUG "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
+		printk(KERN_DEBUG "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
 	}
 	/* Maximum: three initialization retries */
 	retry_cnt = INIT_MAX_RETRIES;
@@ -1797,7 +1811,7 @@

 	if(tms380tr_debug > 3)
 	{
-		printk("%s: AdapterCheckBlock: ", dev->name);
+		printk(KERN_DEBUG "%s: AdapterCheckBlock: ", dev->name);
 		for (i = 0; i < 4; i++)
 			printk("%04X", AdapterCheckBlock[i]);
 		printk("\n");
@@ -1874,52 +1888,52 @@
 			break;

 		case ILLEGAL_OP_CODE:
-			printk("%s: Illegal operation code in firmware\n",
+			printk(KERN_INFO "%s: Illegal operation code in firmware\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case PARITY_ERRORS:
-			printk("%s: Adapter internal bus parity error\n",
+			printk(KERN_INFO "%s: Adapter internal bus parity error\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case RAM_DATA_ERROR:
-			printk("%s: RAM data error\n", dev->name);
+			printk(KERN_INFO "%s: RAM data error\n", dev->name);
 			/* Parm[0-1]: MSW/LSW address of RAM location. */
 			break;

 		case RAM_PARITY_ERROR:
-			printk("%s: RAM parity error\n", dev->name);
+			printk(KERN_INFO "%s: RAM parity error\n", dev->name);
 			/* Parm[0-1]: MSW/LSW address of RAM location. */
 			break;

 		case RING_UNDERRUN:
-			printk("%s: Internal DMA underrun detected\n",
+			printk(KERN_INFO "%s: Internal DMA underrun detected\n",
 				dev->name);
 			break;

 		case INVALID_IRQ:
-			printk("%s: Unrecognized interrupt detected\n",
+			printk(KERN_INFO "%s: Unrecognized interrupt detected\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case INVALID_ERROR_IRQ:
-			printk("%s: Unrecognized error interrupt detected\n",
+			printk(KERN_INFO "%s: Unrecognized error interrupt detected\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		case INVALID_XOP:
-			printk("%s: Unrecognized XOP request detected\n",
+			printk(KERN_INFO "%s: Unrecognized XOP request detected\n",
 				dev->name);
 			/* Parm[0-3]: adapter internal register R13-R15 */
 			break;

 		default:
-			printk("%s: Unknown status", dev->name);
+			printk(KERN_INFO "%s: Unknown status", dev->name);
 			break;
 	}

@@ -2070,14 +2084,14 @@

 			if((HighAc != LowAc) || (HighAc == AC_NOT_RECOGNIZED))
 			{
-				printk(KERN_INFO "%s: (DA=%08lX not recognized)",
+				printk(KERN_DEBUG "%s: (DA=%08lX not recognized)\n",
 					dev->name,
 					*(unsigned long *)&tpl->MData[2+2]);
 			}
 			else
 			{
 				if(tms380tr_debug > 3)
-					printk("%s: Directed frame tx'd\n",
+					printk(KERN_DEBUG "%s: Directed frame tx'd\n",
 						dev->name);
 			}
 		}
@@ -2086,7 +2100,7 @@
 			if(!DIRECTED_FRAME(tpl))
 			{
 				if(tms380tr_debug > 3)
-					printk("%s: Broadcast frame tx'd\n",
+					printk(KERN_DEBUG "%s: Broadcast frame tx'd\n",
 						dev->name);
 			}
 		}
@@ -2163,7 +2177,7 @@
 			tms380tr_update_rcv_stats(tp,ReceiveDataPtr,Length);

 			if(tms380tr_debug > 3)
-				printk("%s: Packet Length %04X (%d)\n",
+				printk(KERN_DEBUG "%s: Packet Length %04X (%d)\n",
 					dev->name, Length, Length);

 			/* Indicate the received frame to system the
@@ -2347,12 +2361,11 @@
 	if (dev->priv == NULL)
 	{
 		struct net_local *tms_local;
-		dma_addr_t buffer;

 		dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL | GFP_DMA);
 		if (dev->priv == NULL)
 		{
-                        printk("%s: Out of memory for DMA\n",
+                        printk(KERN_INFO "%s: Out of memory for DMA\n",
                                 dev->name);
 			return -ENOMEM;
 		}
@@ -2361,16 +2374,15 @@
 		init_waitqueue_head(&tms_local->wait_for_tok_int);
 		tms_local->dmalimit = dmalimit;
 		tms_local->pdev = pdev;
-                buffer = pci_map_single(pdev, (void *)tms_local,
+                tms_local->dmabuffer = pci_map_single(pdev, (void *)tms_local,
                         sizeof(struct net_local), PCI_DMA_BIDIRECTIONAL);
-                if (buffer + sizeof(struct net_local) > dmalimit)
+                if (tms_local->dmabuffer + sizeof(struct net_local) > dmalimit)
                 {
-			printk("%s: Memory not accessible for DMA\n",
+			printk(KERN_INFO "%s: Memory not accessible for DMA\n",
 				dev->name);
 			tmsdev_term(dev);
 			return -ENOMEM;
 		}
-		tms_local->dmabuffer = buffer;
 	}

 	/* These can be overridden by the card driver if needed */
@@ -2401,7 +2413,7 @@

 int init_module(void)
 {
-	printk("%s", version);
+	printk(KERN_DEBUG "%s", version);

 	TMS380_module = &__this_module;
 	return 0;
diff -Nru a/drivers/net/tokenring/tms380tr.h b/drivers/net/tokenring/tms380tr.h
--- a/drivers/net/tokenring/tms380tr.h	Sat Jan  4 21:25:30 2003
+++ b/drivers/net/tokenring/tms380tr.h	Sat Jan  4 21:25:30 2003
@@ -1135,6 +1135,7 @@
 	unsigned short (*sifreadw)(struct net_device *, unsigned short);
 	void (*sifwritew)(struct net_device *, unsigned short, unsigned short);

+	spinlock_t lock;                /* SMP protection */
 	void *tmspriv;
 } NET_LOCAL;

diff -Nru a/drivers/net/tokenring/tmsisa.c b/drivers/net/tokenring/tmsisa.c
--- a/drivers/net/tokenring/tmsisa.c	Sat Jan  4 21:25:30 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,473 +0,0 @@
-/*
- *  tmsisa.c: A generic network driver for TMS380-based ISA token ring cards.
- *
- *  Based on tmspci written 1999 by Adam Fritzler
- *
- *  Written 2000 by Jochen Friedrich
- *  Dedicated to my girlfriend Steffi Bopp
- *
- *  This software may be used and distributed according to the terms
- *  of the GNU General Public License, incorporated herein by reference.
- *
- *  This driver module supports the following cards:
- *	- SysKonnect TR4/16(+) ISA	(SK-4190)
- *
- *  Maintainer(s):
- *    AF        Adam Fritzler           mid@auk.cx
- *    JF	Jochen Friedrich	jochen@scram.de
- *
- *  TODO:
- *	1. Add support for Proteon TR ISA adapters (1392, 1392+)
- */
-static const char version[] = "tmsisa.c: v1.00 14/01/2001 by Jochen Friedrich\n";
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <linux/trdevice.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/pci.h>
-#include <asm/dma.h>
-
-#include "tms380tr.h"
-
-#define TMS_ISA_IO_EXTENT 32
-
-/* A zero-terminated list of I/O addresses to be probed. */
-static unsigned int portlist[] __initdata = {
-	0x0A20, 0x1A20, 0x0B20, 0x1B20, 0x0980, 0x1980, 0x0900, 0x1900,// SK
-	0
-};
-
-/* A zero-terminated list of IRQs to be probed.
- * Used again after initial probe for sktr_chipset_init, called from sktr_open.
- */
-static unsigned short irqlist[] = {
-	3, 5, 9, 10, 11, 12, 15,
-	0
-};
-
-/* A zero-terminated list of DMAs to be probed. */
-static int dmalist[] __initdata = {
-	5, 6, 7,
-	0
-};
-
-static char isa_cardname[] = "SK NET TR 4/16 ISA\0";
-
-int tms_isa_probe(struct net_device *dev);
-static int tms_isa_open(struct net_device *dev);
-static int tms_isa_close(struct net_device *dev);
-static void tms_isa_read_eeprom(struct net_device *dev);
-static unsigned short tms_isa_setnselout_pins(struct net_device *dev);
-
-static unsigned short tms_isa_sifreadb(struct net_device *dev, unsigned short reg)
-{
-	return inb(dev->base_addr + reg);
-}
-
-static unsigned short tms_isa_sifreadw(struct net_device *dev, unsigned short reg)
-{
-	return inw(dev->base_addr + reg);
-}
-
-static void tms_isa_sifwriteb(struct net_device *dev, unsigned short val, unsigned short reg)
-{
-	outb(val, dev->base_addr + reg);
-}
-
-static void tms_isa_sifwritew(struct net_device *dev, unsigned short val, unsigned short reg)
-{
-	outw(val, dev->base_addr + reg);
-}
-
-struct tms_isa_card {
-	struct net_device *dev;
-	struct tms_isa_card *next;
-};
-
-static struct tms_isa_card *tms_isa_card_list;
-
-static int __init tms_isa_probe1(int ioaddr)
-{
-	unsigned char old, chk1, chk2;
-
-	old = inb(ioaddr + SIFADR);	/* Get the old SIFADR value */
-
-	chk1 = 0;	/* Begin with check value 0 */
-	do {
-		/* Write new SIFADR value */
-		outb(chk1, ioaddr + SIFADR);
-
-		/* Read, invert and write */
-		chk2 = inb(ioaddr + SIFADD);
-		chk2 ^= 0x0FE;
-		outb(chk2, ioaddr + SIFADR);
-
-		/* Read, invert and compare */
-		chk2 = inb(ioaddr + SIFADD);
-		chk2 ^= 0x0FE;
-
-		if(chk1 != chk2)
-			return (-1);	/* No adapter */
-
-		chk1 -= 2;
-	} while(chk1 != 0);	/* Repeat 128 times (all byte values) */
-
-    	/* Restore the SIFADR value */
-	outb(old, ioaddr + SIFADR);
-
-	return (0);
-}
-
-int __init tms_isa_probe(struct net_device *dev)
-{
-        static int versionprinted;
-	struct net_local *tp;
-	int j;
-	struct tms_isa_card *card;
-
-	if(check_region(dev->base_addr, TMS_ISA_IO_EXTENT))
-		return -1;
-
-	if(tms_isa_probe1(dev->base_addr))
-		return -1;
-
-	if (versionprinted++ == 0)
-		printk("%s", version);
-
-	/* At this point we have found a valid card. */
-
-	if (!request_region(dev->base_addr, TMS_ISA_IO_EXTENT, isa_cardname))
-		return -1;
-
-	if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL))
-       	{
-		release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-		return -1;
-	}
-
-	dev->base_addr &= ~3;
-
-	tms_isa_read_eeprom(dev);
-
-	printk("%s:    Ring Station Address: ", dev->name);
-	printk("%2.2x", dev->dev_addr[0]);
-	for (j = 1; j < 6; j++)
-		printk(":%2.2x", dev->dev_addr[j]);
-	printk("\n");
-
-	tp = (struct net_local *)dev->priv;
-	tp->setnselout = tms_isa_setnselout_pins;
-
-	tp->sifreadb = tms_isa_sifreadb;
-	tp->sifreadw = tms_isa_sifreadw;
-	tp->sifwriteb = tms_isa_sifwriteb;
-	tp->sifwritew = tms_isa_sifwritew;
-
-	memcpy(tp->ProductID, isa_cardname, PROD_ID_SIZE + 1);
-
-	tp->tmspriv = NULL;
-
-	dev->open = tms_isa_open;
-	dev->stop = tms_isa_close;
-
-	if (dev->irq == 0)
-	{
-		for(j = 0; irqlist[j] != 0; j++)
-		{
-			dev->irq = irqlist[j];
-			if (!request_irq(dev->irq, tms380tr_interrupt, 0,
-				isa_cardname, dev))
-				break;
-                }
-
-                if(irqlist[j] == 0)
-                {
-                        printk("%s: AutoSelect no IRQ available\n", dev->name);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			tmsdev_term(dev);
-			return -1;
-		}
-	}
-	else
-	{
-		for(j = 0; irqlist[j] != 0; j++)
-			if (irqlist[j] == dev->irq)
-				break;
-		if (irqlist[j] == 0)
-		{
-			printk("%s: Illegal IRQ %d specified\n",
-				dev->name, dev->irq);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			tmsdev_term(dev);
-			return -1;
-		}
-		if (request_irq(dev->irq, tms380tr_interrupt, 0,
-			isa_cardname, dev))
-		{
-                        printk("%s: Selected IRQ %d not available\n",
-				dev->name, dev->irq);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			tmsdev_term(dev);
-			return -1;
-		}
-	}
-
-	if (dev->dma == 0)
-	{
-		for(j = 0; dmalist[j] != 0; j++)
-		{
-			dev->dma = dmalist[j];
-                        if (!request_dma(dev->dma, isa_cardname))
-				break;
-		}
-
-		if(dmalist[j] == 0)
-		{
-			printk("%s: AutoSelect no DMA available\n", dev->name);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			free_irq(dev->irq, dev);
-			tmsdev_term(dev);
-			return -1;
-		}
-	}
-	else
-	{
-		for(j = 0; dmalist[j] != 0; j++)
-			if (dmalist[j] == dev->dma)
-				break;
-		if (dmalist[j] == 0)
-		{
-                        printk("%s: Illegal DMA %d specified\n",
-				dev->name, dev->dma);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			free_irq(dev->irq, dev);
-			tmsdev_term(dev);
-			return -1;
-		}
-		if (request_dma(dev->dma, isa_cardname))
-		{
-                        printk("%s: Selected DMA %d not available\n",
-				dev->name, dev->dma);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			free_irq(dev->irq, dev);
-			tmsdev_term(dev);
-			return -1;
-		}
-	}
-
-	printk("%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
-	       dev->name, dev->base_addr, dev->irq, dev->dma);
-
-	if (register_trdev(dev) == 0)
-	{
-		/* Enlist in the card list */
-		card = kmalloc(sizeof(struct tms_isa_card), GFP_KERNEL);
-		if (!card) {
-			unregister_trdev(dev);
-			release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-			free_irq(dev->irq, dev);
-			free_dma(dev->dma);
-			tmsdev_term(dev);
-			return -1;
-		}
-		card->next = tms_isa_card_list;
-		tms_isa_card_list = card;
-		card->dev = dev;
-	}
-	else
-	{
-		printk("%s: register_trdev() returned non-zero.\n", dev->name);
-		release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-		free_irq(dev->irq, dev);
-		free_dma(dev->dma);
-		tmsdev_term(dev);
-		return -1;
-	}
-
-	return 0;
-}
-
-/*
- * Reads MAC address from adapter RAM, which should've read it from
- * the onboard ROM.
- *
- * Calling this on a board that does not support it can be a very
- * dangerous thing.  The Madge board, for instance, will lock your
- * machine hard when this is called.  Luckily, its supported in a
- * seperate driver.  --ASF
- */
-static void tms_isa_read_eeprom(struct net_device *dev)
-{
-	int i;
-
-	/* Address: 0000:0000 */
-	tms_isa_sifwritew(dev, 0, SIFADX);
-	tms_isa_sifwritew(dev, 0, SIFADR);
-
-	/* Read six byte MAC address data */
-	dev->addr_len = 6;
-	for(i = 0; i < 6; i++)
-		dev->dev_addr[i] = tms_isa_sifreadw(dev, SIFINC) >> 8;
-}
-
-unsigned short tms_isa_setnselout_pins(struct net_device *dev)
-{
-	return 0;
-}
-
-static int tms_isa_open(struct net_device *dev)
-{
-	struct net_local *tp = (struct net_local *)dev->priv;
-	unsigned short val = 0;
-	unsigned short oldval;
-	int i;
-
-	val = 0;
-	for(i = 0; irqlist[i] != 0; i++)
-	{
-		if(irqlist[i] == dev->irq)
-			break;
-	}
-
-	val |= CYCLE_TIME << 2;
-	val |= i << 4;
-	i = dev->dma - 5;
-	val |= i;
-	if(tp->DataRate == SPEED_4)
-		val |= LINE_SPEED_BIT;
-	else
-		val &= ~LINE_SPEED_BIT;
-	oldval = tms_isa_sifreadb(dev, POSREG);
-	/* Leave cycle bits alone */
-	oldval |= 0xf3;
-	val &= oldval;
-	tms_isa_sifwriteb(dev, val, POSREG);
-
-	tms380tr_open(dev);
-	MOD_INC_USE_COUNT;
-	return 0;
-}
-
-static int tms_isa_close(struct net_device *dev)
-{
-	tms380tr_close(dev);
-	MOD_DEC_USE_COUNT;
-	return 0;
-}
-
-#ifdef MODULE
-
-#define ISATR_MAX_ADAPTERS 3
-
-static int io[ISATR_MAX_ADAPTERS];
-static int irq[ISATR_MAX_ADAPTERS];
-static int dma[ISATR_MAX_ADAPTERS];
-
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(io, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
-MODULE_PARM(irq, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
-MODULE_PARM(dma, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
-
-int init_module(void)
-{
-	int i, num;
-	struct net_device *dev;
-
-	num = 0;
-	if (io[0])
-	{ /* Only probe addresses from command line */
-		for (i = 0; i < ISATR_MAX_ADAPTERS; i++)
-	       	{
-			if (io[i] == 0)
-				continue;
-
-			dev = init_trdev(NULL, 0);
-			if (!dev)
-				return (-ENOMEM);
-
-			dev->base_addr = io[i];
-			dev->irq       = irq[i];
-			dev->dma       = dma[i];
-
-			if (tms_isa_probe(dev))
-			{
-				unregister_netdev(dev);
-				kfree(dev);
-			}
-			else
-				num++;
-		}
-	}
-       	else
-       	{
-		for(i = 0; portlist[i]; i++)
-		{
-			if (num >= ISATR_MAX_ADAPTERS)
-				continue;
-
-			dev = init_trdev(NULL, 0);
-			if (!dev)
-				return (-ENOMEM);
-
-			dev->base_addr = portlist[i];
-			dev->irq       = irq[num];
-			dev->dma       = dma[num];
-
-			if (tms_isa_probe(dev))
-			{
-				unregister_netdev(dev);
-				kfree(dev);
-			}
-			else
-				num++;
-		}
-	}
-	printk(KERN_NOTICE "tmsisa.c: %d cards found.\n", num);
-	/* Probe for cards. */
-	if (num == 0) {
-		printk(KERN_NOTICE "tmsisa.c: No cards found.\n");
-	}
-	return (0);
-}
-
-void cleanup_module(void)
-{
-	struct net_device *dev;
-	struct tms_isa_card *this_card;
-
-	while (tms_isa_card_list) {
-		dev = tms_isa_card_list->dev;
-
-		unregister_netdev(dev);
-		release_region(dev->base_addr, TMS_ISA_IO_EXTENT);
-		free_irq(dev->irq, dev);
-		free_dma(dev->dma);
-		tmsdev_term(dev);
-		kfree(dev);
-		this_card = tms_isa_card_list;
-		tms_isa_card_list = this_card->next;
-		kfree(this_card);
-	}
-}
-#endif /* MODULE */
-
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmsisa.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmsisa.c"
- *  c-set-style "K&R"
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */

diff -Nru a/net/802/tr.c b/net/802/tr.c
--- a/net/802/tr.c	Sat Jan  4 21:25:50 2003
+++ b/net/802/tr.c	Sat Jan  4 21:25:50 2003
@@ -324,6 +324,7 @@
 {
 	int i;
 	unsigned int hash, rii_p = 0;
+	unsigned rif = 0;
 	rif_cache entry;


@@ -335,6 +336,7 @@

        	if(trh->saddr[0] & TR_RII)
 	{
+		rif = 1;
 		trh->saddr[0]&=0x7f;
 		if (((ntohs(trh->rcf) & TR_RCF_LEN_MASK) >> 8) > 2)
 		{
@@ -381,7 +383,6 @@
 			entry->rcf = trh->rcf & htons((unsigned short)~TR_RCF_BROADCAST_MASK);
 			memcpy(&(entry->rseg[0]),&(trh->rseg[0]),8*sizeof(unsigned short));
 			entry->local_ring = 0;
-			trh->saddr[0]|=TR_RII; /* put the routing indicator back for tcpdump */
 		}
 		else
 		{
@@ -408,6 +409,8 @@
 		    }
            	entry->last_used=jiffies;
 	}
+	if (rif)
+		trh->saddr[0]|=TR_RII; /* put the routing indicator back for tcpdump */
 	spin_unlock_bh(&rif_lock);
 }

diff -Nru a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c	Sat Jan  4 21:26:15 2003
+++ b/drivers/net/Space.c	Sat Jan  4 21:26:15 2003
@@ -556,6 +556,7 @@
 /* Token-ring device probe */
 extern int ibmtr_probe(struct net_device *);
 extern int sk_isa_probe(struct net_device *);
+extern int proteon_probe(struct net_device *);
 extern int smctr_probe(struct net_device *);

 static int
@@ -567,6 +568,9 @@
 #endif
 #ifdef CONFIG_SKISA
 	&& sk_isa_probe(dev)
+#endif
+#ifdef CONFIG_PROTEON
+	&& proteon_probe(dev)
 #endif
 #ifdef CONFIG_SMCTR
 	&& smctr_probe(dev)
diff -Nru a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	Sat Jan  4 21:26:15 2003
+++ b/drivers/net/tokenring/Kconfig	Sat Jan  4 21:26:15 2003
@@ -145,6 +145,21 @@
 	  The module will be called skisa.o. If you want to compile it
 	  as a module, say M here and read <file:Documentation/modules.txt>.

+config PROTEON
+	tristate "Proteon ISA support"
+	depends on TR && TMS380TR!=n && ISA
+	help
+	  This tms380 module supports Proteon ISA cards.
+
+	  These cards are known to work:
+	  - Proteon 1392
+	  - Proteon 1392 plus
+
+	  This driver is available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called proteon.o. If you want to compile it
+	  as a module, say M here and read <file:Documentation/modules.txt>.
+
 config ABYSS
 	tristate "Madge Smart 16/4 PCI Mk2 support"
 	depends on TR && TMS380TR!=n && PCI
diff -Nru a/drivers/net/tokenring/Makefile b/drivers/net/tokenring/Makefile
--- a/drivers/net/tokenring/Makefile	Sat Jan  4 21:26:15 2003
+++ b/drivers/net/tokenring/Makefile	Sat Jan  4 21:26:15 2003
@@ -10,6 +10,7 @@
 obj-$(CONFIG_TMS380TR) 	+= tms380tr.o
 obj-$(CONFIG_ABYSS) 	+= abyss.o
 obj-$(CONFIG_MADGEMC) 	+= madgemc.o
+obj-$(CONFIG_PROTEON) 	+= proteon.o
 obj-$(CONFIG_TMSPCI) 	+= tmspci.o
 obj-$(CONFIG_SKISA) 	+= skisa.o
 obj-$(CONFIG_SMCTR) 	+= smctr.o
diff -Nru a/drivers/net/tokenring/proteon.c b/drivers/net/tokenring/proteon.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/net/tokenring/proteon.c	Sat Jan  4 21:26:15 2003
@@ -0,0 +1,503 @@
+/*
+ *  proteon.c: A network driver for Proteon ISA token ring cards.
+ *
+ *  Based on tmspci written 1999 by Adam Fritzler
+ *
+ *  Written 2003 by Jochen Friedrich
+ *
+ *  This software may be used and distributed according to the terms
+ *  of the GNU General Public License, incorporated herein by reference.
+ *
+ *  This driver module supports the following cards:
+ *	- Proteon 1392, 1392+
+ *
+ *  Maintainer(s):
+ *    AF        Adam Fritzler           mid@auk.cx
+ *    JF	Jochen Friedrich	jochen@scram.de
+ *
+ *  Modification History:
+ *	02-Jan-03	JF	Created
+ *
+ */
+static const char version[] = "proteon.c: v1.00 02/01/2003 by Jochen Friedrich\n";
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/trdevice.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pci.h>
+#include <asm/dma.h>
+
+#include "tms380tr.h"
+
+#define PROTEON_IO_EXTENT 32
+
+/* A zero-terminated list of I/O addresses to be probed. */
+static unsigned int portlist[] __initdata = {
+	0x0A20, 0x0E20, 0x1A20, 0x1E20, 0x2A20, 0x2E20, 0x3A20, 0x3E20,// Prot.
+	0x4A20, 0x4E20, 0x5A20, 0x5E20, 0x6A20, 0x6E20, 0x7A20, 0x7E20,// Prot.
+	0x8A20, 0x8E20, 0x9A20, 0x9E20, 0xAA20, 0xAE20, 0xBA20, 0xBE20,// Prot.
+	0xCA20, 0xCE20, 0xDA20, 0xDE20, 0xEA20, 0xEE20, 0xFA20, 0xFE20,// Prot.
+	0
+};
+
+/* A zero-terminated list of IRQs to be probed. */
+static unsigned short irqlist[] = {
+	7, 6, 5, 4, 3, 12, 11, 10, 9,
+	0
+};
+
+/* A zero-terminated list of DMAs to be probed. */
+static int dmalist[] __initdata = {
+	5, 6, 7,
+	0
+};
+
+static char cardname[] = "Proteon 1392\0";
+
+int proteon_probe(struct net_device *dev);
+static int proteon_open(struct net_device *dev);
+static int proteon_close(struct net_device *dev);
+static void proteon_read_eeprom(struct net_device *dev);
+static unsigned short proteon_setnselout_pins(struct net_device *dev);
+
+static unsigned short proteon_sifreadb(struct net_device *dev, unsigned short reg)
+{
+	return inb(dev->base_addr + reg);
+}
+
+static unsigned short proteon_sifreadw(struct net_device *dev, unsigned short reg)
+{
+	return inw(dev->base_addr + reg);
+}
+
+static void proteon_sifwriteb(struct net_device *dev, unsigned short val, unsigned short reg)
+{
+	outb(val, dev->base_addr + reg);
+}
+
+static void proteon_sifwritew(struct net_device *dev, unsigned short val, unsigned short reg)
+{
+	outw(val, dev->base_addr + reg);
+}
+
+struct proteon_card {
+	struct net_device *dev;
+	struct proteon_card *next;
+};
+
+static struct proteon_card *proteon_card_list;
+
+static int __init proteon_probe1(int ioaddr)
+{
+	unsigned char chk1, chk2;
+	int i;
+
+	chk1 = inb(ioaddr + 0x1f);      /* Get Proteon ID reg 1 */
+	if (chk1 != 0x1f)
+		return (-1);
+	chk1 = inb(ioaddr + 0x1e) & 0x07;       /* Get Proteon ID reg 0 */
+	for (i=0; i<16; i++) {
+		chk2 = inb(ioaddr + 0x1e) & 0x07;
+		if (((chk1 + 1) & 0x07) != chk2)
+			return (-1);
+		chk1 = chk2;
+	}
+	return (0);
+}
+
+int __init proteon_probe(struct net_device *dev)
+{
+        static int versionprinted;
+	struct net_local *tp;
+	int i,j;
+	struct proteon_card *card;
+
+	SET_MODULE_OWNER(dev);
+	if (!dev->base_addr)
+	{
+		for(i = 0; portlist[i]; i++)
+		{
+			if (!request_region(portlist[i], PROTEON_IO_EXTENT, cardname))
+				continue;
+
+			if(proteon_probe1(portlist[i]))
+			{
+				release_region(dev->base_addr, PROTEON_IO_EXTENT);
+				continue;
+			}
+
+			dev->base_addr = portlist[i];
+			break;
+		}
+		if(!dev->base_addr)
+			return -1;
+	}
+	else
+	{
+		if (!request_region(dev->base_addr, PROTEON_IO_EXTENT, cardname))
+			return -1;
+
+		if(proteon_probe1(dev->base_addr))
+		{
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			return -1;
+  		}
+	}
+
+	/* At this point we have found a valid card. */
+
+	if (versionprinted++ == 0)
+		printk(KERN_DEBUG "%s", version);
+
+#ifndef MODULE
+	dev = init_trdev(dev, 0);
+	if (!dev)
+	{
+		release_region(dev->base_addr, PROTEON_IO_EXTENT);
+		return -1;
+	}
+#endif
+
+	if (tmsdev_init(dev, ISA_MAX_ADDRESS, NULL))
+       	{
+		release_region(dev->base_addr, PROTEON_IO_EXTENT);
+		return -1;
+	}
+
+	dev->base_addr &= ~3;
+
+	proteon_read_eeprom(dev);
+
+	printk(KERN_DEBUG "%s:    Ring Station Address: ", dev->name);
+	printk("%2.2x", dev->dev_addr[0]);
+	for (j = 1; j < 6; j++)
+		printk(":%2.2x", dev->dev_addr[j]);
+	printk("\n");
+
+	tp = (struct net_local *)dev->priv;
+	tp->setnselout = proteon_setnselout_pins;
+
+	tp->sifreadb = proteon_sifreadb;
+	tp->sifreadw = proteon_sifreadw;
+	tp->sifwriteb = proteon_sifwriteb;
+	tp->sifwritew = proteon_sifwritew;
+
+	memcpy(tp->ProductID, cardname, PROD_ID_SIZE + 1);
+
+	tp->tmspriv = NULL;
+
+	dev->open = proteon_open;
+	dev->stop = proteon_close;
+
+	if (dev->irq == 0)
+	{
+		for(j = 0; irqlist[j] != 0; j++)
+		{
+			dev->irq = irqlist[j];
+			if (!request_irq(dev->irq, tms380tr_interrupt, 0,
+				cardname, dev))
+				break;
+                }
+
+                if(irqlist[j] == 0)
+                {
+                        printk(KERN_INFO "%s: AutoSelect no IRQ available\n", dev->name);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+	else
+	{
+		for(j = 0; irqlist[j] != 0; j++)
+			if (irqlist[j] == dev->irq)
+				break;
+		if (irqlist[j] == 0)
+		{
+			printk(KERN_INFO "%s: Illegal IRQ %d specified\n",
+				dev->name, dev->irq);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			tmsdev_term(dev);
+			return -1;
+		}
+		if (request_irq(dev->irq, tms380tr_interrupt, 0,
+			cardname, dev))
+		{
+                        printk(KERN_INFO "%s: Selected IRQ %d not available\n",
+				dev->name, dev->irq);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+
+	if (dev->dma == 0)
+	{
+		for(j = 0; dmalist[j] != 0; j++)
+		{
+			dev->dma = dmalist[j];
+                        if (!request_dma(dev->dma, cardname))
+				break;
+		}
+
+		if(dmalist[j] == 0)
+		{
+			printk(KERN_INFO "%s: AutoSelect no DMA available\n", dev->name);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+	else
+	{
+		for(j = 0; dmalist[j] != 0; j++)
+			if (dmalist[j] == dev->dma)
+				break;
+		if (dmalist[j] == 0)
+		{
+                        printk(KERN_INFO "%s: Illegal DMA %d specified\n",
+				dev->name, dev->dma);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			tmsdev_term(dev);
+			return -1;
+		}
+		if (request_dma(dev->dma, cardname))
+		{
+                        printk(KERN_INFO "%s: Selected DMA %d not available\n",
+				dev->name, dev->dma);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			tmsdev_term(dev);
+			return -1;
+		}
+	}
+
+	printk(KERN_DEBUG "%s:    IO: %#4lx  IRQ: %d  DMA: %d\n",
+	       dev->name, dev->base_addr, dev->irq, dev->dma);
+
+	if (register_trdev(dev) == 0)
+	{
+		/* Enlist in the card list */
+		card = kmalloc(sizeof(struct proteon_card), GFP_KERNEL);
+		if (!card) {
+			unregister_trdev(dev);
+			release_region(dev->base_addr, PROTEON_IO_EXTENT);
+			free_irq(dev->irq, dev);
+			free_dma(dev->dma);
+			tmsdev_term(dev);
+			return -1;
+		}
+		card->next = proteon_card_list;
+		proteon_card_list = card;
+		card->dev = dev;
+	}
+	else
+	{
+		printk("KERN_INFO %s: register_trdev() returned non-zero.\n", dev->name);
+		release_region(dev->base_addr, PROTEON_IO_EXTENT);
+		free_irq(dev->irq, dev);
+		free_dma(dev->dma);
+		tmsdev_term(dev);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Reads MAC address from adapter RAM, which should've read it from
+ * the onboard ROM.
+ *
+ * Calling this on a board that does not support it can be a very
+ * dangerous thing.  The Madge board, for instance, will lock your
+ * machine hard when this is called.  Luckily, its supported in a
+ * seperate driver.  --ASF
+ */
+static void proteon_read_eeprom(struct net_device *dev)
+{
+	int i;
+
+	/* Address: 0000:0000 */
+	proteon_sifwritew(dev, 0, SIFADX);
+	proteon_sifwritew(dev, 0, SIFADR);
+
+	/* Read six byte MAC address data */
+	dev->addr_len = 6;
+	for(i = 0; i < 6; i++)
+		dev->dev_addr[i] = proteon_sifreadw(dev, SIFINC) >> 8;
+}
+
+unsigned short proteon_setnselout_pins(struct net_device *dev)
+{
+	return 0;
+}
+
+static int proteon_open(struct net_device *dev)
+{
+	struct net_local *tp = (struct net_local *)dev->priv;
+	unsigned short val = 0;
+	int i;
+
+	/* Proteon reset sequence */
+	outb(0, dev->base_addr + 0x11);
+	mdelay(20);
+	outb(0x04, dev->base_addr + 0x11);
+	mdelay(20);
+	outb(0, dev->base_addr + 0x11);
+	mdelay(100);
+
+	/* set control/status reg */
+	val = inb(dev->base_addr + 0x11);
+	val |= 0x78;
+	val &= 0xf9;
+	if(tp->DataRate == SPEED_4)
+		val |= 0x20;
+	else
+		val &= ~0x20;
+
+	outb(val, dev->base_addr + 0x11);
+	outb(0xff, dev->base_addr + 0x12);
+	for(i = 0; irqlist[i] != 0; i++)
+	{
+		if(irqlist[i] == dev->irq)
+			break;
+	}
+	val = i;
+	i = (7 - dev->dma) << 4;
+	val |= i;
+	outb(val, dev->base_addr + 0x13);
+
+	tms380tr_open(dev);
+	return 0;
+}
+
+static int proteon_close(struct net_device *dev)
+{
+	tms380tr_close(dev);
+	return 0;
+}
+
+#ifdef MODULE
+
+#define ISATR_MAX_ADAPTERS 3
+
+static int io[ISATR_MAX_ADAPTERS];
+static int irq[ISATR_MAX_ADAPTERS];
+static int dma[ISATR_MAX_ADAPTERS];
+
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(io, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
+MODULE_PARM(irq, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
+MODULE_PARM(dma, "1-" __MODULE_STRING(ISATR_MAX_ADAPTERS) "i");
+
+int init_module(void)
+{
+	int i, num;
+	struct net_device *dev;
+
+	num = 0;
+	if (io[0])
+	{ /* Only probe addresses from command line */
+		dev = init_trdev(NULL, 0);
+		if (!dev)
+			return (-ENOMEM);
+		for (i = 0; i < ISATR_MAX_ADAPTERS; i++)
+	       	{
+			if (io[i] == 0)
+				continue;
+
+			dev->base_addr = io[i];
+			dev->irq       = irq[i];
+			dev->dma       = dma[i];
+
+			if (!proteon_probe(dev))
+			{
+				num++;
+				dev = init_trdev(NULL, 0);
+				if (!dev)
+					goto partial;
+			}
+		}
+		unregister_netdev(dev);
+		kfree(dev);
+	}
+       	else
+       	{
+		dev = init_trdev(NULL, 0);
+		if (!dev)
+			return (-ENOMEM);
+
+		for(i = 0; portlist[i]; i++)
+		{
+			if (num >= ISATR_MAX_ADAPTERS)
+				continue;
+
+			dev->base_addr = portlist[i];
+			dev->irq       = irq[num];
+			dev->dma       = dma[num];
+
+			if (!proteon_probe(dev))
+			{
+				num++;
+				dev = init_trdev(NULL, 0);
+				if (!dev)
+					goto partial;
+			}
+		}
+		unregister_netdev(dev);
+		kfree(dev);
+	}
+partial:
+	printk(KERN_NOTICE "proteon.c: %d cards found.\n", num);
+	/* Probe for cards. */
+	if (num == 0) {
+		printk(KERN_NOTICE "proteon.c: No cards found.\n");
+		return (-ENODEV);
+	}
+	return (0);
+}
+
+void cleanup_module(void)
+{
+	struct net_device *dev;
+	struct proteon_card *this_card;
+
+	while (proteon_card_list) {
+		dev = proteon_card_list->dev;
+
+		unregister_netdev(dev);
+		release_region(dev->base_addr, PROTEON_IO_EXTENT);
+		free_irq(dev->irq, dev);
+		free_dma(dev->dma);
+		tmsdev_term(dev);
+		kfree(dev);
+		this_card = proteon_card_list;
+		proteon_card_list = this_card->next;
+		kfree(this_card);
+	}
+}
+#endif /* MODULE */
+
+
+/*
+ * Local variables:
+ *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c proteon.c"
+ *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c proteon.c"
+ *  c-set-style "K&R"
+ *  c-indent-level: 8
+ *  c-basic-offset: 8
+ *  tab-width: 8
+ * End:
+ */


diff -Nru a/drivers/net/tokenring/skisa.c b/drivers/net/tokenring/skisa.c
--- a/drivers/net/tokenring/skisa.c	Sat Jan  4 21:26:36 2003
+++ b/drivers/net/tokenring/skisa.c	Sat Jan  4 21:26:36 2003
@@ -473,10 +473,10 @@
 		kfree(dev);
 	}
 partial:
-	printk(KERN_NOTICE "tmsisa.c: %d cards found.\n", num);
+	printk(KERN_NOTICE "skisa.c: %d cards found.\n", num);
 	/* Probe for cards. */
 	if (num == 0) {
-		printk(KERN_NOTICE "tmsisa.c: No cards found.\n");
+		printk(KERN_NOTICE "skisa.c: No cards found.\n");
 		return (-ENODEV);
 	}
 	return (0);
@@ -506,8 +506,8 @@

 /*
  * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmsisa.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c tmsisa.c"
+ *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c skisa.c"
+ *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/tokenring/ -c skisa.c"
  *  c-set-style "K&R"
  *  c-indent-level: 8
  *  c-basic-offset: 8



===================================================================


This BitKeeper patch contains the following changesets:
1.977.2.1,1.977.2.2,1.983,1.984
## Wrapped with gzip_uu ##


begin 664 bkpatch991
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
`
end


