Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280974AbRKCPzq>; Sat, 3 Nov 2001 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280975AbRKCPzf>; Sat, 3 Nov 2001 10:55:35 -0500
Received: from fungus.teststation.com ([212.32.186.211]:3599 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S280974AbRKCPz1>; Sat, 3 Nov 2001 10:55:27 -0500
Date: Sat, 3 Nov 2001 16:55:17 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>, Martin Eriksson <nitrax@giron.wox.org>
Subject: [patch] Re: via-rhine and MMIO
In-Reply-To: <3BDE6EE7.EC006474@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0111031249130.4332-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Jeff Garzik wrote:

> WRT the above code, you should add a check to see if '150' is enough of
> a wait.  MMIO is faster and would affect that loop.  Maybe you want to
> schedule_timeout before reading MACRegEEcsr to delay a little bit.

The problem is (also) that the reload from eeprom reloads cfgA, cfgB, ...
so it changes the mode back to PIO (or whatever the eeprom says).

Since I can't verify that the reset-from-win98-powerdown thing still works
when moving the eeprom reload before resetting, I don't move the reload.
Instead I enable mmio twice (wait_for_reset is shared and wants one mode).


There is also a difference between the older vt3043/vt86c100a chips and
the vt6102 in which bit to flip to enable MMIO. More recent docs say that
the bit used for vt3043/vt86c100a is reserved.

The vt6102 was listed as using a 4096 byte io_size in mmio mode, which
isn't true when looking at the pci cfg (or the docs) and conflicts with
the sanity checks.


The code below works for me on both a vt6102 and a vt3043.

Anyone wanting to test the effects of this patch should edit
drivers/net/via-rhine.c and enable the define for VIA_USE_MEMORY.
VIA_USE_MEMORY could be turned into CONFIG_VIA_RHINE_USE_MEMORY ...

/Urban


diff -urN -X exclude linux-2.4.14-pre6-orig/drivers/net/via-rhine.c linux/drivers/net/via-rhine.c
--- linux-2.4.14-pre6-orig/drivers/net/via-rhine.c	Sat Nov  3 00:25:11 2001
+++ linux/drivers/net/via-rhine.c	Sat Nov  3 16:40:35 2001
@@ -73,6 +73,9 @@
 	- David Woodhouse: Set dev->base_addr before the first time we call
 					   wait_for_reset(). It's a lot happier that way.
 					   Free np->tx_bufs only if we actually allocated it.
+
+	LK1.1.12:
+	- Martin Eriksson: Allow Memory-Mapped IO to be enabled.
 */
 
 
@@ -155,7 +158,7 @@
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
-KERN_INFO "via-rhine.c:v1.10-LK1.1.11  20/08/2001  Written by Donald Becker\n"
+KERN_INFO "via-rhine.c:v1.10-LK1.1.12  03/11/2001  Written by Donald Becker\n"
 KERN_INFO "  http://www.scyld.com/network/via-rhine.html\n";
 
 static char shortname[] __devinitdata = "via-rhine";
@@ -163,7 +166,9 @@
 
 /* This driver was written to use PCI memory space, however most versions
    of the Rhine only work correctly with I/O space accesses. */
+/* #define VIA_USE_MEMORY */
 #if defined(VIA_USE_MEMORY)
+#define USE_MEM
 #warning Many adapters using the VIA Rhine chip are not configured to work
 #warning with PCI memory space accesses.
 #else
@@ -320,10 +325,8 @@
 
 #if defined(VIA_USE_MEMORY)
 #define RHINE_IOTYPE (PCI_USES_MEM | PCI_USES_MASTER | PCI_ADDR1)
-#define RHINEII_IOSIZE 4096
 #else
 #define RHINE_IOTYPE (PCI_USES_IO  | PCI_USES_MASTER | PCI_ADDR0)
-#define RHINEII_IOSIZE 256
 #endif
 
 /* directly indexed by enum via_rhine_chips, above */
@@ -331,7 +334,7 @@
 {
 	{ "VIA VT86C100A Rhine", RHINE_IOTYPE, 128,
 	  CanHaveMII | ReqTxAlign },
-	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, RHINEII_IOSIZE,
+	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
 	{ "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
 	  CanHaveMII | ReqTxAlign }
@@ -355,10 +358,19 @@
 	RxRingPtr=0x18, TxRingPtr=0x1C, GFIFOTest=0x54,
 	MIIPhyAddr=0x6C, MIIStatus=0x6D, PCIBusConfig=0x6E,
 	MIICmd=0x70, MIIRegAddr=0x71, MIIData=0x72, MACRegEEcsr=0x74,
-	Config=0x78, ConfigA=0x7A, RxMissed=0x7C, RxCRCErrs=0x7E,
+	ConfigA=0x78, ConfigB=0x79, ConfigC=0x7A, ConfigD=0x7B,
+	RxMissed=0x7C, RxCRCErrs=0x7E,
 	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
 
+#ifdef USE_MEM
+/* Registers we check that mmio and reg are the same. */
+int mmio_verify_registers[] = {
+	RxConfig, TxConfig, IntrEnable, ConfigA, ConfigB, ConfigC, ConfigD,
+	0
+};
+#endif
+
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
 	IntrRxDone=0x0001, IntrRxErr=0x0004, IntrRxEmpty=0x0020,
@@ -505,6 +517,31 @@
 			   name, 5*i);
 }
 
+#ifdef USE_MEM
+static void __devinit enable_mmio(long ioaddr, int chip_id)
+{
+	int n;
+	if (chip_id == VT3043 || chip_id == VT86C100A) {
+		/* More recent docs say that this bit is reserved ... */
+		n = inb(ioaddr + ConfigA) | 0x20;
+		outb(n, ioaddr + ConfigA);
+	} else if (chip_id == VT6102) {
+		n = inb(ioaddr + ConfigD) | 0x80;
+		outb(n, ioaddr + ConfigD);
+	}
+}
+#endif
+
+static void __devinit reload_eeprom(long ioaddr)
+{
+	int i;
+	outb(0x20, ioaddr + MACRegEEcsr);
+	/* Typically 2 cycles to reload. */
+	for (i = 0; i < 150; i++)
+		if (! (inb(ioaddr + MACRegEEcsr) & 0x20))
+			break;
+}
+
 static int __devinit via_rhine_init_one (struct pci_dev *pdev,
 					 const struct pci_device_id *ent)
 {
@@ -514,8 +551,12 @@
 	int chip_id = (int) ent->driver_data;
 	static int card_idx = -1;
 	long ioaddr;
+	long memaddr;
 	int io_size;
 	int pci_flags;
+#ifdef USE_MEM
+	long ioaddr0;
+#endif
 	
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -545,8 +586,9 @@
 		goto err_out;
 	}
 
-	ioaddr = pci_resource_start (pdev, pci_flags & PCI_ADDR0 ? 0 : 1);
-	
+	ioaddr = pci_resource_start (pdev, 0);
+	memaddr = pci_resource_start (pdev, 1);
+
 	if (pci_flags & PCI_USES_MASTER)
 		pci_set_master (pdev);
 
@@ -560,14 +602,29 @@
 	if (pci_request_regions(pdev, shortname))
 		goto err_out_free_netdev;
 
-#ifndef USE_IO
-	ioaddr = (long) ioremap (ioaddr, io_size);
+#ifdef USE_MEM
+	ioaddr0 = ioaddr;
+	enable_mmio(ioaddr0, chip_id);
+
+	ioaddr = (long) ioremap (memaddr, io_size);
 	if (!ioaddr) {
-		printk (KERN_ERR "ioremap failed for device %s, region 0x%X @ 0x%X\n",
-			pdev->slot_name, io_size,
-			pci_resource_start (pdev, 1));
+		printk (KERN_ERR "ioremap failed for device %s, region 0x%X @ 0x%lX\n",
+				pdev->slot_name, io_size, memaddr);
 		goto err_out_free_res;
 	}
+
+	/* Check that selected MMIO registers match the PIO ones */
+	i = 0;
+	while (mmio_verify_registers[i]) {
+		int reg = mmio_verify_registers[i++];
+		unsigned char a = inb(ioaddr0+reg);
+		unsigned char b = readb(ioaddr+reg);
+		if (a != b) {
+			printk (KERN_ERR "MMIO do not match PIO [%02x] (%02x != %02x)\n",
+					reg, a, b);
+			goto err_out_unmap;
+		}
+	}
 #endif
 
 	/* D-Link provided reset code (with comment additions) */
@@ -595,11 +652,16 @@
 	wait_for_reset(dev, shortname);
 
 	/* Reload the station address from the EEPROM. */
-	writeb(0x20, ioaddr + MACRegEEcsr);
-	/* Typically 2 cycles to reload. */
-	for (i = 0; i < 150; i++)
-		if (! (readb(ioaddr + MACRegEEcsr) & 0x20))
-			break;
+#ifdef USE_IO
+	reload_eeprom(ioaddr);
+#else
+	reload_eeprom(ioaddr0);
+	/* Reloading from eeprom overwrites cfgA-D, so we must re-enable MMIO.
+	   If reload_eeprom() was done first this could be avoided, but it is
+	   not known if that still works with the "win98-reboot" problem. */
+	enable_mmio(ioaddr0, chip_id);
+#endif
+
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
 
@@ -660,7 +722,9 @@
 		goto err_out_unmap;
 
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
-		   dev->name, via_rhine_chip_info[chip_id].name, ioaddr);
+		   dev->name, via_rhine_chip_info[chip_id].name,
+		   (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);
+
 	for (i = 0; i < 5; i++)
 			printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
@@ -711,7 +775,7 @@
 	return 0;
 
 err_out_unmap:
-#ifndef USE_IO
+#ifdef USE_MEM
 	iounmap((void *)ioaddr);
 err_out_free_res:
 #endif
@@ -1587,13 +1651,12 @@
 static void __devexit via_rhine_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct netdev_private *np = dev->priv;
 	
 	unregister_netdev(dev);
 
 	pci_release_regions(pdev);
 
-#ifndef USE_IO
+#ifdef USE_MEM
 	iounmap((char *)(dev->base_addr));
 #endif
 

