Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbQKJLaA>; Fri, 10 Nov 2000 06:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbQKJL3u>; Fri, 10 Nov 2000 06:29:50 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:57349 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S129631AbQKJL3q>; Fri, 10 Nov 2000 06:29:46 -0500
Date: Fri, 10 Nov 2000 14:29:57 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NIC drivers check_region() removal continues
Message-ID: <20001110142957.A8245@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

new net drivers patchset (against 2.4.0-test11-pre1) attached.

Modifications: check_region() removal, passing dev->name to=20
request_region() & request_irq() etc.

Drivers affected: 3c501.c, 3c503.c, 3c505.c, 82596.c, eth16i.c, hp.c,
hp-plus.c, ibmlana.c, ne2.c, seeq8005.c, smc-mca.c, smc-ultra.c,=20
smc-ultra32.c

Best regard,
            Andrey

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c501
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/3c501.c /linux/drivers/net/3c501.c
--- /mnt/disk/linux/drivers/net/3c501.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/3c501.c	Sat Nov  4 21:22:59 2000
@@ -398,6 +398,7 @@
=20
 static int el_open(struct net_device *dev)
 {
+	int retval;
 	int ioaddr =3D dev->base_addr;
 	struct net_local *lp =3D (struct net_local *)dev->priv;
 	unsigned long flags;
@@ -407,9 +408,9 @@
 	if (el_debug > 2)
 		printk("%s: Doing el_open()...", dev->name);
=20
-	if (request_irq(dev->irq, &el_interrupt, 0, "3c501", dev)) {
+	if ((retval =3D request_irq(dev->irq, &el_interrupt, 0, dev->name, dev)))=
 {
 		MOD_DEC_USE_COUNT;
-		return -EAGAIN;
+		return retval;
 	}
=20
 	spin_lock_irqsave(&lp->lock, flags);

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c503
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/3c503.c /linux/drivers/net/3c503.c
--- /mnt/disk/linux/drivers/net/3c503.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/3c503.c	Sat Nov  4 18:58:39 2000
@@ -101,8 +101,6 @@
 		break;
 	if (base_bits !=3D 1)
 	    continue;
-	if (check_region(netcard_portlist[i], EL2_IO_EXTENT))
-	    continue;
 	if (el2_probe1(dev, netcard_portlist[i]) =3D=3D 0)
 	    return 0;
     }
@@ -126,13 +124,9 @@
     else if (base_addr !=3D 0)	/* Don't probe at all. */
 	return -ENXIO;
=20
-    for (i =3D 0; netcard_portlist[i]; i++) {
-	int ioaddr =3D netcard_portlist[i];
-	if (check_region(ioaddr, EL2_IO_EXTENT))
-	    continue;
-	if (el2_probe1(dev, ioaddr) =3D=3D 0)
+    for (i =3D 0; netcard_portlist[i]; i++)
+	if (el2_probe1(dev, netcard_portlist[i]) =3D=3D 0)
 	    return 0;
-    }
=20
     return -ENODEV;
 }
@@ -143,14 +137,18 @@
 int __init=20
 el2_probe1(struct net_device *dev, int ioaddr)
 {
-    int i, iobase_reg, membase_reg, saved_406, wordlength;
-    static unsigned version_printed =3D 0;
+    int i, iobase_reg, membase_reg, saved_406, wordlength, retval;
+    static unsigned version_printed;
     unsigned long vendor_id;
=20
+    if (!request_region(ioaddr, EL2_IO_EXTENT, dev->name))
+	return -EBUSY;
+
     /* Reset and/or avoid any lurking NE2000 */
     if (inb(ioaddr + 0x408) =3D=3D 0xff) {
     	mdelay(1);
-	return -ENODEV;
+	retval =3D -ENODEV;
+	goto out;
     }
=20
     /* We verify that it's a 3C503 board by checking the first three octets
@@ -160,7 +158,8 @@
     /* ASIC location registers should be 0 or have only a single bit set. =
*/
     if (   (iobase_reg  & (iobase_reg - 1))
 	|| (membase_reg & (membase_reg - 1))) {
-	return -ENODEV;
+	retval =3D -ENODEV;
+	goto out;
     }
     saved_406 =3D inb_p(ioaddr + 0x406);
     outb_p(ECNTRL_RESET|ECNTRL_THIN, ioaddr + 0x406); /* Reset it... */
@@ -172,7 +171,8 @@
     if ((vendor_id !=3D OLD_3COM_ID) && (vendor_id !=3D NEW_3COM_ID)) {
 	/* Restore the register we frobbed. */
 	outb(saved_406, ioaddr + 0x406);
-	return -ENODEV;
+	retval =3D -ENODEV;
+	goto out;
     }
=20
     if (ei_debug  &&  version_printed++ =3D=3D 0)
@@ -182,8 +182,9 @@
     /* Allocate dev->priv and fill in 8390 specific dev fields. */
     if (ethdev_init(dev)) {
 	printk ("3c503: unable to allocate memory for dev->priv.\n");
-	return -ENOMEM;
-     }
+	retval =3D -ENOMEM;
+	goto out;
+    }
=20
     printk("%s: 3c503 at i/o base %#3x, node ", dev->name, ioaddr);
=20
@@ -282,8 +283,6 @@
     ei_status.block_input =3D &el2_block_input;
     ei_status.block_output =3D &el2_block_output;
=20
-    request_region(ioaddr, EL2_IO_EXTENT, ei_status.name);
-
     if (dev->irq =3D=3D 2)
 	dev->irq =3D 9;
     else if (dev->irq > 5 && dev->irq !=3D 9) {
@@ -310,6 +309,9 @@
 	       dev->name, ei_status.name, (wordlength+1)<<3);
     }
     return 0;
+out:
+    release_region(ioaddr, EL2_IO_EXTENT);
+    return retval;
 }
 =0C
 static int

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-3c505
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/3c505.c /linux/drivers/net/3c505.c
--- /mnt/disk/linux/drivers/net/3c505.c	Thu Nov  9 21:28:06 2000
+++ /linux/drivers/net/3c505.c	Thu Nov  9 22:58:51 2000
@@ -854,6 +854,7 @@
 static int elp_open(struct net_device *dev)
 {
 	elp_device *adapter;
+	int retval;
=20
 	adapter =3D dev->priv;
=20
@@ -893,16 +894,17 @@
 	/*
 	 * install our interrupt service routine
 	 */
-	if (request_irq(dev->irq, &elp_interrupt, 0, "3c505", dev)) {
-		return -EAGAIN;
+	if ((retval =3D request_irq(dev->irq, &elp_interrupt, 0, dev->name, dev))=
) {
+		printk("%s: could not allocate IRQ%d\n", dev->name, dev->irq);
+		return retval;
 	}
-	if (request_dma(dev->dma, "3c505")) {
-		printk("%s: could not allocate DMA channel\n", dev->name);
-		return -EAGAIN;
+	if ((retval =3D request_dma(dev->dma, dev->name))) {
+		printk("%s: could not allocate DMA%d channel\n", dev->name, dev->dma);
+		return retval;
 	}
 	adapter->dma_buffer =3D (void *) dma_mem_alloc(DMA_BUFFER_SIZE);
 	if (!adapter->dma_buffer) {
-		printk("Could not allocate DMA buffer\n");
+		printk("%s: could not allocate DMA buffer\n", dev->name);
 	}
 	adapter->dmaing =3D 0;
=20

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-82596
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/82596.c /linux/drivers/net/82596.c
--- /mnt/disk/linux/drivers/net/82596.c	Thu Nov  2 22:01:06 2000
+++ /linux/drivers/net/82596.c	Wed Nov  8 23:42:42 2000
@@ -1093,7 +1093,7 @@
 	int i;
 	struct i596_private *lp;
 	char eth_addr[6];
-	static int probed =3D 0;
+	static int probed;
=20
 	if (probed)
 		return -ENODEV;
@@ -1131,9 +1131,9 @@
 		/* this is easy the ethernet interface can only be at 0x300 */
 		/* first check nothing is already registered here */
=20
-		if (check_region(ioaddr, I596_TOTAL_SIZE)) {
+		if (!request_region(ioaddr, I596_TOTAL_SIZE, dev->name)) {
 			printk("82596: IO address 0x%04x in use\n", ioaddr);
-			return -ENODEV;
+			return -EBUSY;
 		}
=20
 		for (i =3D 0; i < 8; i++) {
@@ -1145,17 +1145,14 @@
 		   some machines have 0x100, some 0x200. The DOS driver doesn't
 		   even bother with the checksum */
=20
-		if (checksum % 0x100)
-			return -ENODEV;
-
 		/* Some other boards trip the checksum.. but then appear as
 		 * ether address 0. Trap these - AC */
=20
-		if (memcmp(eth_addr, "\x00\x00\x49", 3) !=3D 0)
-			return -ENODEV;
-
-		if (!request_region(ioaddr, I596_TOTAL_SIZE, "i596"))
+		if ((checksum % 0x100) ||=20
+		    (memcmp(eth_addr, "\x00\x00\x49", 3) !=3D 0)) {
+			release_region(ioaddr, I596_TOTAL_SIZE);
 			return -ENODEV;
+		}
=20
 		dev->base_addr =3D ioaddr;
 		dev->irq =3D 10;

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-eth16i
Content-Transfer-Encoding: quoted-printable

--- eth16i.c.orig	Fri Nov 10 13:02:38 2000
+++ eth16i.c	Fri Nov 10 13:04:34 2000
@@ -451,20 +451,14 @@
 		return ENXIO;
=20
 	/* Seek card from the ISA io address space */
-	for(i =3D 0; (ioaddr =3D eth16i_portlist[i]) ; i++) {
-		if(check_region(ioaddr, ETH16I_IO_EXTENT))
-			continue;
+	for(i =3D 0; (ioaddr =3D eth16i_portlist[i]) ; i++)
 		if(eth16i_probe1(dev, ioaddr) =3D=3D 0)
 			return 0;
-	}
=20
 	/* Seek card from the EISA io address space */
-	for(i =3D 0; (ioaddr =3D eth32i_portlist[i]) ; i++) {
-		if(check_region(ioaddr, ETH16I_IO_EXTENT))
-			continue;
+	for(i =3D 0; (ioaddr =3D eth32i_portlist[i]) ; i++)
 		if(eth16i_probe1(dev, ioaddr) =3D=3D 0)
 			return 0;
-	}
=20
 	return ENODEV;
 }
@@ -472,10 +466,15 @@
 static int __init eth16i_probe1(struct net_device *dev, int ioaddr)
 {
 	struct eth16i_local *lp;
-=09
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
+	int retval;
+
 	boot =3D 1;  /* To inform initilization that we are in boot probe */
=20
+	/* Let's grab the region */
+	if (!request_region(ioaddr, ETH16I_IO_EXTENT, dev->name))
+		return -EBUSY;
+
 	/*
 	  The MB86985 chip has on register which holds information in which=20
 	  io address the chip lies. First read this register and compare
@@ -486,14 +485,18 @@
 	if(ioaddr < 0x1000) {
 =09
 		if(eth16i_portlist[(inb(ioaddr + JUMPERLESS_CONFIG) & 0x07)]=20
-		   !=3D ioaddr)
-			return -ENODEV;
+		   !=3D ioaddr) {
+			retval =3D -ENODEV;
+			goto out;
+		}
 	}
=20
 	/* Now we will go a bit deeper and try to find the chip's signature */
=20
-	if(eth16i_check_signature(ioaddr) !=3D 0)=20
-		return -ENODEV;
+	if(eth16i_check_signature(ioaddr) !=3D 0) {
+		retval =3D -ENODEV;
+		goto out;
+	}
=20
 	/*=20
 	   Now it seems that we have found a ethernet chip in this particular
@@ -520,17 +523,15 @@
=20
 	/* Try to obtain interrupt vector */
=20
-	if (request_irq(dev->irq, (void *)&eth16i_interrupt, 0, "eth16i", dev)) {=
=09
+	if ((retval =3D request_irq(dev->irq, (void *)&eth16i_interrupt, 0, dev->=
name, dev))) {
 		printk(KERN_WARNING "%s: %s at %#3x, but is unusable due conflicting IRQ=
 %d.\n",=20
 		       dev->name, cardname, ioaddr, dev->irq);
-		return -EAGAIN;
+		goto out;
 	}
=20
 	printk(KERN_INFO "%s: %s at %#3x, IRQ %d, ",
 	       dev->name, cardname, ioaddr, dev->irq);
=20
-	/* Let's grab the region */
-	request_region(ioaddr, ETH16I_IO_EXTENT, "eth16i");
=20
 	/* Now we will have to lock the chip's io address */
 	eth16i_select_regbank(TRANSCEIVER_MODE_RB, ioaddr);
@@ -544,8 +545,11 @@
 	/* Initialize the device structure */
 	if(dev->priv =3D=3D NULL) {
 		dev->priv =3D kmalloc(sizeof(struct eth16i_local), GFP_KERNEL);
-		if(dev->priv =3D=3D NULL)
-			return -ENOMEM;
+		if(dev->priv =3D=3D NULL) {
+			free_irq(dev->irq, dev);
+			retval =3D -ENOMEM;
+			goto out;
+		}
 	}
=20
 	memset(dev->priv, 0, sizeof(struct eth16i_local));
@@ -566,6 +570,9 @@
 	boot =3D 0;
=20
 	return 0;
+out:
+	release_region(ioaddr, ETH16I_IO_EXTENT);
+	return retval;
 }
=20
=20

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hp
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/hp.c /linux/drivers/net/hp.c
--- /mnt/disk/linux/drivers/net/hp.c	Thu Nov  9 21:28:04 2000
+++ /linux/drivers/net/hp.c	Thu Nov  9 22:44:27 2000
@@ -101,9 +101,9 @@
 {
 	int i, retval, board_id, wordmode;
 	const char *name;
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
=20
-	if (!request_region(ioaddr, HP_IO_EXTENT, "hp"))
+	if (!request_region(ioaddr, HP_IO_EXTENT, dev->name))
 		return -ENODEV;
=20
 	/* Check for the HP physical address, 08 00 09 xx xx xx. */
@@ -155,7 +155,7 @@
 				outb_p(irqmap[irq] | HP_RUN, ioaddr + HP_CONFIGURE);
 				outb_p( 0x00 | HP_RUN, ioaddr + HP_CONFIGURE);
 				if (irq =3D=3D probe_irq_off(cookie)		 /* It's a good IRQ line! */
-					&& request_irq (irq, ei_interrupt, 0, "hp", dev) =3D=3D 0) {
+					&& request_irq (irq, ei_interrupt, 0, dev->name, dev) =3D=3D 0) {
 					printk(" selecting IRQ %d.\n", irq);
 					dev->irq =3D *irqp;
 					break;
@@ -170,9 +170,8 @@
 	} else {
 		if (dev->irq =3D=3D 2)
 			dev->irq =3D 9;
-		if (request_irq(dev->irq, ei_interrupt, 0, "hp", dev)) {
+		if ((retval =3D request_irq(dev->irq, ei_interrupt, 0, dev->name, dev)))=
 {
 			printk (" unable to get IRQ %d.\n", dev->irq);
-			retval =3D -EBUSY;
 			goto out1;
 		}
 	}

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hp-plus
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/hp-plus.c /linux/drivers/net/hp-plus.c
--- /mnt/disk/linux/drivers/net/hp-plus.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/hp-plus.c	Mon Nov  6 00:51:11 2000
@@ -141,10 +141,10 @@
 	unsigned char checksum =3D 0;
 	const char *name =3D "HP-PC-LAN+";
 	int mem_start;
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
=20
-	if (!request_region(ioaddr, HP_IO_EXTENT, "hp-plus"))
-		return -ENODEV;
+	if (!request_region(ioaddr, HP_IO_EXTENT, dev->name))
+		return -EBUSY;
=20
 	/* Check for the HP+ signature, 50 48 0x 53. */
 	if (inw(ioaddr + HP_ID) !=3D 0x4850
@@ -249,9 +249,10 @@
 {
 	int ioaddr =3D dev->base_addr - NIC_OFFSET;
 	int option_reg;
+	int retval;
=20
-	if (request_irq(dev->irq, ei_interrupt, 0, "hp-plus", dev)) {
-	    return -EAGAIN;
+	if ((retval =3D request_irq(dev->irq, ei_interrupt, 0, dev->name, dev))) {
+	    return retval;
 	}
=20
 	/* Reset the 8390 and HP chip. */

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ibmlana
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/ibmlana.c /linux/drivers/net/ibmlana.c
--- /mnt/disk/linux/drivers/net/ibmlana.c	Thu Nov  2 22:01:04 2000
+++ /linux/drivers/net/ibmlana.c	Mon Nov  6 16:03:22 2000
@@ -857,7 +857,7 @@
=20
 	result =3D
 	    request_irq(priv->realirq, irq_handler,
-			SA_SHIRQ | SA_SAMPLE_RANDOM, "ibm_lana", dev);
+			SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
 	if (result !=3D 0) {
 		printk("%s: failed to register irq %d\n", dev->name,
 		       dev->irq);
@@ -1046,7 +1046,7 @@
 	/* can't work without an MCA bus ;-) */
=20
 	if (MCA_bus =3D=3D 0)
-		return ENODEV;
+		return -ENODEV;
=20
 	/* start address of 1 --> forced detection */
=20
@@ -1101,19 +1101,18 @@
 	/* nothing found ? */
=20
 	if (slot =3D=3D -1)
-		return ((base !=3D 0) || (irq !=3D 0)) ? ENXIO : ENODEV;
+		return ((base !=3D 0) || (irq !=3D 0)) ? -ENXIO : -ENODEV;
=20
 	/* announce success */
 	printk("%s: IBM LAN Adapter/A found in slot %d\n", dev->name,
 	       slot + 1);
=20
 	/* try to obtain I/O range */
-	if (check_region(iobase, IBM_LANA_IORANGE) < 0) {
-		printk("cannot allocate I/O range at %#x!\n", iobase);
+	if (!request_region(iobase, IBM_LANA_IORANGE, dev->name)) {
+		printk("%s: cannot allocate I/O range at %#x!\n", dev->name, iobase);
 		startslot =3D slot + 1;
-		return 0;
+		return -EBUSY;
 	}
-	request_region(iobase, IBM_LANA_IORANGE, "ibm_lana");
=20
 	/* make procfs entries */
=20
@@ -1128,6 +1127,10 @@
=20
 	priv =3D dev->priv =3D
 	    (ibmlana_priv *) kmalloc(sizeof(ibmlana_priv), GFP_KERNEL);
+	if (!priv) {
+		release_region(iobase, IBM_LANA_IORANGE);
+		return -ENOMEM;
+	}
 	priv->slot =3D slot;
 	priv->realirq =3D irq;
 	priv->medium =3D medium;
@@ -1189,24 +1192,11 @@
=20
 #define DEVMAX 5
=20
-#if (LINUX_VERSION_CODE >=3D 0x020363)
-static struct IBMLANA_NETDEV moddevs[DEVMAX] =3D
-    { {"    ", 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{"    ", 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{"    ", 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{"    ", 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{"    ", 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe}
-};
-#else
-static char NameSpace[8 * DEVMAX];
-static struct IBMLANA_NETDEV moddevs[DEVMAX] =3D
-    { {NameSpace + 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{NameSpace + 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{NameSpace + 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{NameSpace + 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe},
-{NameSpace + 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, ibmlana_probe}
+static struct IBMLANA_NETDEV moddevs[DEVMAX] =3D {
+	{ init: ibmlana_probe }, { init: ibmlana_probe },=20
+	{ init: ibmlana_probe }, { init: ibmlana_probe },
+	{ init: ibmlana_probe }
 };
-#endif
=20
 int irq =3D 0;
 int io =3D 0;

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ne2
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/ne2.c /linux/drivers/net/ne2.c
--- /mnt/disk/linux/drivers/net/ne2.c	Thu Nov  2 22:01:06 2000
+++ /linux/drivers/net/ne2.c	Tue Nov  7 19:55:59 2000
@@ -200,12 +200,12 @@
=20
 static int __init ne2_probe1(struct net_device *dev, int slot)
 {
-	int i, base_addr, irq;
+	int i, base_addr, irq, retval;
 	unsigned char POS;
 	unsigned char SA_prom[32];
 	const char *name =3D "NE/2";
 	int start_page, stop_page;
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
=20
 	if (ei_debug && version_printed++ =3D=3D 0)
 		printk(version);
@@ -226,6 +226,9 @@
 	base_addr =3D addresses[i - 1];
 	irq =3D irqs[(POS & 0x60)>>5];
=20
+	if (!request_region(base_addr, NE_IO_EXTENT, dev->name))
+		return -EBUSY;
+
 #ifdef DEBUG
 	printk("POS info : pos 2 =3D %#x ; base =3D %#x ; irq =3D %ld\n", POS,
 			base_addr, irq);
@@ -239,7 +242,8 @@
 	outb(0x21, base_addr + NE_CMD);
 	if (inb(base_addr + NE_CMD) !=3D 0x21) {
 		printk("NE/2 adapter not responding\n");
-		return -ENODEV;
+		retval =3D -ENODEV;
+		goto out;
 	}
=20
 	/* In the crynwr sources they do a RAM-test here. I skip it. I suppose
@@ -260,7 +264,8 @@
 		while ((inb_p(base_addr + EN0_ISR) & ENISR_RESET) =3D=3D 0)
 			if (jiffies - reset_start_time > 2*HZ/100) {
 				printk(" not found (no reset ack).\n");
-				return -ENODEV;
+				retval =3D -ENODEV;
+				goto out;
 			}
=20
 		outb_p(0xff, base_addr + EN0_ISR);         /* Ack all intr. */
@@ -309,14 +314,11 @@
=20
 	/* Snarf the interrupt now.  There's no point in waiting since we cannot
 	   share and the board will usually be enabled. */
-	{
-		int irqval =3D request_irq(dev->irq, ei_interrupt,=20
-				0, name, dev);
-		if (irqval) {
-			printk (" unable to get IRQ %d (irqval=3D%d).\n",=20
-					dev->irq, +irqval);
-			return -EAGAIN;
-		}
+	retval =3D request_irq(dev->irq, ei_interrupt, 0, dev->name, dev);
+	if (retval) {
+		printk (" unable to get IRQ %d (irqval=3D%d).\n",=20
+				dev->irq, retval);
+		goto out;
 	}
=20
 	dev->base_addr =3D base_addr;
@@ -325,11 +327,10 @@
 	if (ethdev_init(dev)) {
 		printk (" unable to get memory for dev->priv.\n");
 		free_irq(dev->irq, dev);
-		return -ENOMEM;
+		retval =3D -ENOMEM;
+		goto out;
 	}
=20
-	request_region(base_addr, NE_IO_EXTENT, name);
-
 	for(i =3D 0; i < ETHER_ADDR_LEN; i++) {
 		printk(" %2.2x", SA_prom[i]);
 		dev->dev_addr[i] =3D SA_prom[i];
@@ -362,6 +363,9 @@
 	dev->stop =3D &ne_close;
 	NS8390_init(dev, 0);
 	return 0;
+out:
+	release_region(base_addr, NE_IO_EXTENT);
+	return retval;
 }
=20
 static int ne_open(struct net_device *dev)

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-seeq8005
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/seeq8005.c /linux/drivers/net/seeq800=
5.c
--- /mnt/disk/linux/drivers/net/seeq8005.c	Thu Nov  2 22:01:00 2000
+++ /linux/drivers/net/seeq8005.c	Fri Nov  3 22:34:13 2000
@@ -116,13 +116,9 @@
 	else if (base_addr !=3D 0)	/* Don't probe at all. */
 		return -ENXIO;
=20
-	for (i =3D 0; seeq8005_portlist[i]; i++) {
-		int ioaddr =3D seeq8005_portlist[i];
-		if (check_region(ioaddr, SEEQ8005_IO_EXTENT))
-			continue;
-		if (seeq8005_probe1(dev, ioaddr) =3D=3D 0)
+	for (i =3D 0; seeq8005_portlist[i]; i++)
+		if (seeq8005_probe1(dev, seeq8005_portlist[i]) =3D=3D 0)
 			return 0;
-	}
=20
 	return -ENODEV;
 }
@@ -133,7 +129,7 @@
=20
 static int __init seeq8005_probe1(struct net_device *dev, int ioaddr)
 {
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
 	int i,j;
 	unsigned char SA_prom[32];
 	int old_cfg1;
@@ -141,33 +137,42 @@
 	int old_stat;
 	int old_dmaar;
 	int old_rear;
+	int retval;
+
+	if (!request_region(ioaddr, SEEQ8005_IO_EXTENT, "seeq8005"))
+		return -ENODEV;
=20
 	if (net_debug>1)
 		printk("seeq8005: probing at 0x%x\n",ioaddr);
=20
 	old_stat =3D inw(SEEQ_STATUS);					/* read status register */
-	if (old_stat =3D=3D 0xffff)
-		return -ENODEV;						/* assume that 0xffff =3D=3D no device */
+	if (old_stat =3D=3D 0xffff) {
+		retval =3D -ENODEV;
+		goto out;						/* assume that 0xffff =3D=3D no device */
+	}
 	if ( (old_stat & 0x1800) !=3D 0x1800 ) {				/* assume that unused bits ar=
e 1, as my manual says */
 		if (net_debug>1) {
 			printk("seeq8005: reserved stat bits !=3D 0x1800\n");
 			printk("          =3D=3D 0x%04x\n",old_stat);
 		}
-	 	return -ENODEV;
+	 	retval =3D -ENODEV;
+		goto out;
 	}
=20
 	old_rear =3D inw(SEEQ_REA);
 	if (old_rear =3D=3D 0xffff) {
 		outw(0,SEEQ_REA);
 		if (inw(SEEQ_REA) =3D=3D 0xffff) {				/* assume that 0xffff =3D=3D no de=
vice */
-			return -ENODEV;
+			retval =3D -ENODEV;
+			goto out;
 		}
 	} else if ((old_rear & 0xff00) !=3D 0xff00) {			/* assume that unused bit=
s are 1 */
 		if (net_debug>1) {
 			printk("seeq8005: unused rear bits !=3D 0xff00\n");
 			printk("          =3D=3D 0x%04x\n",old_rear);
 		}
-		return -ENODEV;
+		retval =3D -ENODEV;
+		goto out;
 	}
 =09
 	old_cfg2 =3D inw(SEEQ_CFG2);					/* read CFG2 register */
@@ -185,8 +190,8 @@
 	outw( SEEQCMD_FIFO_WRITE | SEEQCMD_SET_ALL_OFF, SEEQ_CMD);	/* setup for r=
eading PROM */
 	outw( 0, SEEQ_DMAAR);						/* set starting PROM address */
 	outw( SEEQCFG1_BUFFER_PROM, SEEQ_CFG1);				/* set buffer to look at PROM =
*/
-=09
-=09
+
+
 	j=3D0;
 	for(i=3D0; i <32; i++) {
 		j+=3D SA_prom[i] =3D inw(SEEQ_BUFFER) & 0xff;
@@ -201,7 +206,8 @@
 		outw( old_stat, SEEQ_STATUS);
 		outw( old_dmaar, SEEQ_DMAAR);
 		outw( old_cfg1, SEEQ_CFG1);
-		return -ENODEV;
+		retval =3D -ENODEV;
+		goto out;
 	}
 #endif
=20
@@ -299,14 +305,12 @@
 		 if (irqval) {
 			 printk ("%s: unable to get IRQ %d (irqval=3D%d).\n", dev->name,
 					 dev->irq, irqval);
-			 return -EAGAIN;
+			 retval =3D -EAGAIN;
+			 goto out;
 		 }
 	}
 #endif
=20
-	/* Grab the region so we can find another board if autoIRQ fails. */
-	request_region(ioaddr, SEEQ8005_IO_EXTENT,"seeq8005");
-
 	/* Initialize the device structure. */
 	dev->priv =3D kmalloc(sizeof(struct net_local), GFP_KERNEL);
 	if (dev->priv =3D=3D NULL)
@@ -327,6 +331,9 @@
 	dev->flags &=3D ~IFF_MULTICAST;
=20
 	return 0;
+out:
+	release_region(ioaddr, SEEQ8005_IO_EXTENT);
+	return retval;
 }
=20
 =0C

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-smc-mca
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/smc-mca.c /linux/drivers/net/smc-mca.c
--- /mnt/disk/linux/drivers/net/smc-mca.c	Thu Nov  2 22:01:04 2000
+++ /linux/drivers/net/smc-mca.c	Thu Nov  9 00:04:15 2000
@@ -194,7 +194,7 @@
 	}
=20
 	if(!adapter_found) {
-		return ((base_addr || irq) ? ENXIO : ENODEV);
+		return ((base_addr || irq) ? -ENXIO : -ENODEV);
 	}
=20
         /* Adapter found. */
@@ -249,6 +249,9 @@
 	if (dev->mem_start =3D=3D 0) /* sanity check, shouldn't happen */
 		return -ENODEV;
=20
+	if (!request_region(ioaddr, ULTRA_IO_EXTENT, dev->name))
+		return -EBUSY;
+
 	reg4 =3D inb(ioaddr + 4) & 0x7f;
 	outb(reg4, ioaddr + 4);
=20
@@ -279,14 +282,10 @@
=20
 	if (ethdev_init(dev)) {
 		printk (KERN_INFO ", no memory for dev->priv.\n");
+		release_region(ioaddr, ULTRA_IO_EXTENT);
 		return -ENOMEM;
 	}
=20
-	/* OK, we are certain this is going to work.  Setup the device.
-	 */
-
-	request_region(ioaddr, ULTRA_IO_EXTENT, "smc-mca");
-
 	/* The 8390 isn't at the base address, so fake the offset
 	 */
=20
@@ -322,9 +321,10 @@
 static int ultramca_open(struct net_device *dev)
 {
 	int ioaddr =3D dev->base_addr - ULTRA_NIC_OFFSET; /* ASIC addr */
+	int retval;
=20
-	if (request_irq(dev->irq, ei_interrupt, 0, ei_status.name, dev))
-		return -EAGAIN;
+	if ((retval =3D request_irq(dev->irq, ei_interrupt, 0, dev->name, dev)))
+		return retval;
=20
 	outb(ULTRA_MEMENB, ioaddr); /* Enable memory */
 	outb(0x80, ioaddr + 5);     /* ??? */

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-smc-ultra
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/smc-ultra.c /linux/drivers/net/smc-ul=
tra.c
--- /mnt/disk/linux/drivers/net/smc-ultra.c	Thu Nov  2 22:00:58 2000
+++ /linux/drivers/net/smc-ultra.c	Thu Nov  9 00:15:36 2000
@@ -112,41 +112,44 @@
 	else if (base_addr !=3D 0)	/* Don't probe at all. */
 		return -ENXIO;
=20
-	for (i =3D 0; ultra_portlist[i]; i++) {
-		int ioaddr =3D ultra_portlist[i];
-		if (check_region(ioaddr, ULTRA_IO_EXTENT))
-			continue;
-		if (ultra_probe1(dev, ioaddr) =3D=3D 0)
+	for (i =3D 0; ultra_portlist[i]; i++)
+		if (ultra_probe1(dev, ultra_portlist[i]) =3D=3D 0)
 			return 0;
-	}
=20
 	return -ENODEV;
 }
=20
 static int __init ultra_probe1(struct net_device *dev, int ioaddr)
 {
-	int i;
+	int i, retval;
 	int checksum =3D 0;
 	const char *model_name;
 	unsigned char eeprom_irq =3D 0;
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
 	/* Values from various config regs. */
 	unsigned char num_pages, irqreg, addr, piomode;
 	unsigned char idreg =3D inb(ioaddr + 7);
 	unsigned char reg4 =3D inb(ioaddr + 4) & 0x7f;
=20
+	if (!request_region(ioaddr, ULTRA_IO_EXTENT, dev->name))
+		return -EBUSY;
+
 	/* Check the ID nibble. */
 	if ((idreg & 0xF0) !=3D 0x20 			/* SMC Ultra */
-		&& (idreg & 0xF0) !=3D 0x40) 		/* SMC EtherEZ */
-		return -ENODEV;
+		&& (idreg & 0xF0) !=3D 0x40) {		/* SMC EtherEZ */
+		retval =3D -ENODEV;
+		goto out;
+	}
=20
 	/* Select the station address register set. */
 	outb(reg4, ioaddr + 4);
=20
 	for (i =3D 0; i < 8; i++)
 		checksum +=3D inb(ioaddr + 8 + i);
-	if ((checksum & 0xff) !=3D 0xFF)
-		return -ENODEV;
+	if ((checksum & 0xff) !=3D 0xFF) {
+		retval =3D -ENODEV;
+		goto out;
+	}
=20
 	if (ei_debug  &&  version_printed++ =3D=3D 0)
 		printk(version);
@@ -181,7 +184,8 @@
=20
 		if (irq =3D=3D 0) {
 			printk(", failed to detect IRQ line.\n");
-			return -EAGAIN;
+			retval =3D  -EAGAIN;
+			goto out;
 		}
 		dev->irq =3D irq;
 		eeprom_irq =3D 1;
@@ -190,12 +194,10 @@
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
 		printk (", no memory for dev->priv.\n");
-                return -ENOMEM;
+                retval =3D -ENOMEM;
+		goto out;
         }
=20
-	/* OK, we are certain this is going to work.  Setup the device. */
-	request_region(ioaddr, ULTRA_IO_EXTENT, model_name);
-
 	/* The 8390 isn't at the base address, so fake the offset */
 	dev->base_addr =3D ioaddr+ULTRA_NIC_OFFSET;
=20
@@ -236,17 +238,22 @@
 	NS8390_init(dev, 0);
=20
 	return 0;
+out:
+	release_region(ioaddr, ULTRA_IO_EXTENT);
+	return retval;
 }
=20
 static int
 ultra_open(struct net_device *dev)
 {
+	int retval;
 	int ioaddr =3D dev->base_addr - ULTRA_NIC_OFFSET; /* ASIC addr */
 	unsigned char irq2reg[] =3D {0, 0, 0x04, 0x08, 0, 0x0C, 0, 0x40,
-							   0, 0x04, 0x44, 0x48, 0, 0, 0, 0x4C, };
+				   0, 0x04, 0x44, 0x48, 0, 0, 0, 0x4C, };
=20
-	if (request_irq(dev->irq, ei_interrupt, 0, ei_status.name, dev))
-		return -EAGAIN;
+	retval =3D request_irq(dev->irq, ei_interrupt, 0, dev->name, dev);
+	if (retval)
+		return retval;
=20
 	outb(0x00, ioaddr);	/* Disable shared memory for safety. */
 	outb(0x80, ioaddr + 5);

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-smc-ultra32
Content-Transfer-Encoding: quoted-printable

diff -urN /mnt/disk/linux/drivers/net/smc-ultra32.c /linux/drivers/net/smc-=
ultra32.c
--- /mnt/disk/linux/drivers/net/smc-ultra32.c	Thu Nov  2 22:01:06 2000
+++ /linux/drivers/net/smc-ultra32.c	Thu Nov  9 00:40:32 2000
@@ -105,48 +105,62 @@
=20
 int __init ultra32_probe(struct net_device *dev)
 {
-	const char *ifmap[] =3D {"UTP No Link", "", "UTP/AUI", "UTP/BNC"};
-	int ioaddr, edge, media;
+	int ioaddr;
=20
 	if (!EISA_bus) return -ENODEV;
=20
 	/* EISA spec allows for up to 16 slots, but 8 is typical. */
 	for (ioaddr =3D 0x1000 + ULTRA32_BASE; ioaddr < 0x9000; ioaddr +=3D 0x100=
0)
-	if (check_region(ioaddr, ULTRA32_IO_EXTENT) =3D=3D 0 &&
-	    inb(ioaddr + ULTRA32_IDPORT) !=3D 0xff &&
-	    inl(ioaddr + ULTRA32_IDPORT) =3D=3D ULTRA32_ID) {
-		media =3D inb(ioaddr + ULTRA32_CFG7) & 0x03;
-		edge =3D inb(ioaddr + ULTRA32_CFG5) & 0x08;
-		printk("SMC Ultra32 in EISA Slot %d, Media: %s, %s IRQs.\n",
-		       ioaddr >> 12, ifmap[media],
-		       (edge ? "Edge Triggered" : "Level Sensitive"));
 		if (ultra32_probe1(dev, ioaddr) =3D=3D 0)
-		  return 0;
-	}
+			return 0;
+
 	return -ENODEV;
 }
=20
 int __init ultra32_probe1(struct net_device *dev, int ioaddr)
 {
-	int i;
+	int i, edge, media, retval;
 	int checksum =3D 0;
 	const char *model_name;
-	static unsigned version_printed =3D 0;
+	static unsigned version_printed;
 	/* Values from various config regs. */
-	unsigned char idreg =3D inb(ioaddr + 7);
-	unsigned char reg4 =3D inb(ioaddr + 4) & 0x7f;
+	unsigned char idreg;
+	unsigned char reg4;
+	const char *ifmap[] =3D {"UTP No Link", "", "UTP/AUI", "UTP/BNC"};
+
+	if (!request_region(ioaddr, ULTRA32_IO_EXTENT, dev->name))
+		return -EBUSY;
+
+	if (inb(ioaddr + ULTRA32_IDPORT) =3D=3D 0xff ||
+	    inl(ioaddr + ULTRA32_IDPORT) !=3D ULTRA32_ID) {
+		retval =3D -ENODEV;
+		goto out;
+	}
+
+	media =3D inb(ioaddr + ULTRA32_CFG7) & 0x03;
+	edge =3D inb(ioaddr + ULTRA32_CFG5) & 0x08;
+	printk("SMC Ultra32 in EISA Slot %d, Media: %s, %s IRQs.\n",
+		ioaddr >> 12, ifmap[media],
+		(edge ? "Edge Triggered" : "Level Sensitive"));
+
+	idreg =3D inb(ioaddr + 7);
+	reg4 =3D inb(ioaddr + 4) & 0x7f;
=20
 	/* Check the ID nibble. */
-	if ((idreg & 0xf0) !=3D 0x20) 			/* SMC Ultra */
-		return -ENODEV;
+	if ((idreg & 0xf0) !=3D 0x20) {			/* SMC Ultra */
+		retval =3D -ENODEV;
+		goto out;
+	}
=20
 	/* Select the station address register set. */
 	outb(reg4, ioaddr + 4);
=20
 	for (i =3D 0; i < 8; i++)
 		checksum +=3D inb(ioaddr + 8 + i);
-	if ((checksum & 0xff) !=3D 0xff)
-		return -ENODEV;
+	if ((checksum & 0xff) !=3D 0xff) {
+		retval =3D -ENODEV;
+		goto out;
+	}
=20
 	if (ei_debug  &&  version_printed++ =3D=3D 0)
 		printk(version);
@@ -175,7 +189,8 @@
 	if ((inb(ioaddr + ULTRA32_CFG5) & 0x40) =3D=3D 0) {
 		printk("\nsmc-ultra32: Card RAM is disabled!  "
 		       "Run EISA config utility.\n");
-		return -ENODEV;
+		retval =3D -ENODEV;
+		goto out;
 	}
 	if ((inb(ioaddr + ULTRA32_CFG2) & 0x04) =3D=3D 0)
 		printk("\nsmc-ultra32: Ignoring Bus-Master enable bit.  "
@@ -186,7 +201,8 @@
 		int irq =3D irqmap[inb(ioaddr + ULTRA32_CFG5) & 0x07];
 		if (irq =3D=3D 0) {
 			printk(", failed to detect IRQ line.\n");
-			return -EAGAIN;
+			retval =3D -EAGAIN;
+			goto out;
 		}
 		dev->irq =3D irq;
 	}
@@ -194,12 +210,10 @@
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
 	if (ethdev_init(dev)) {
 		printk (", no memory for dev->priv.\n");
-                return -ENOMEM;
+                retval =3D -ENOMEM;
+		goto out;
         }
=20
-	/* OK, we are certain this is going to work.  Setup the device. */
-	request_region(ioaddr, ULTRA32_IO_EXTENT, model_name);
-
 	/* The 8390 isn't at the base address, so fake the offset */
 	dev->base_addr =3D ioaddr + ULTRA32_NIC_OFFSET;
=20
@@ -229,15 +243,20 @@
 	NS8390_init(dev, 0);
=20
 	return 0;
+out:
+	release_region(ioaddr, ULTRA32_IO_EXTENT);
+	return retval;
 }
=20
 static int ultra32_open(struct net_device *dev)
 {
 	int ioaddr =3D dev->base_addr - ULTRA32_NIC_OFFSET; /* ASIC addr */
 	int irq_flags =3D (inb(ioaddr + ULTRA32_CFG5) & 0x08) ? 0 : SA_SHIRQ;
+	int retval;
=20
-	if (request_irq(dev->irq, ei_interrupt, irq_flags, ei_status.name, dev))
-		return -EAGAIN;
+	retval =3D request_irq(dev->irq, ei_interrupt, irq_flags, dev->name, dev);
+	if (retval)
+		return retval;
=20
 	outb(ULTRA32_MEMENB, ioaddr); /* Enable Shared Memory. */
 	outb(0x80, ioaddr + ULTRA32_CFG6); /* Enable Interrupts. */

--uAKRQypu60I7Lcqm--

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6C9w1Bm4rlNOo3YgRAi2CAJwOvDgmBQwhhTqCl3LgOSetInrpxQCaAxOM
eP4Jx85KQGkexVnkc9fdDbk=
=RzmV
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
