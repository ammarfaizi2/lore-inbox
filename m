Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290973AbSBLLsh>; Tue, 12 Feb 2002 06:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290974AbSBLLs2>; Tue, 12 Feb 2002 06:48:28 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:22796 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S290973AbSBLLqk>; Tue, 12 Feb 2002 06:46:40 -0500
Date: Tue, 12 Feb 2002 20:45:14 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: deller@puffin.external.hp.com
Subject: [PATCH] pcnet32 v1.27
Message-Id: <20020212204514.69ea7d45.go@turbolinux.co.jp>
Organization: Turbolinux
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I merged with Helge Deller's pcnet32 v1.27 to current 2.4.18pre's pcnet32.
<deller@puffin.external.hp.com>
And I fixed some small problems and cleaned them up.
It uses new mii module.

* use alloc_etherdev and register_netdev
* fix pci probe not increment cards_found (only for v1.27)
* FD auto negotiate error workaround for xSeries250
* clean up and use new mii module

It has been tested for quite a long time by IBM's engineer.
And the status for now is pretty good.

If it is possible, please apply it.
If you can't do this, please apply the workaround of xSeries250 which I sent before.

There is patched source.
http://bazaar.turbolinux.co.jp/~go/pcnet32/pcnet32.c

--- linux/drivers/net/pcnet32.c.orig	Sun Feb 10 20:11:27 2002
+++ linux/drivers/net/pcnet32.c	Sun Feb 10 20:37:25 2002
@@ -22,8 +22,9 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.25kf"
-#define DRV_RELDATE	"17.11.2001"
+#define DRV_VERSION	"1.27a"
+#define DRV_RELDATE	"10.02.2002"
+#define PFX		DRV_NAME ": "
 
 static const char *version =
 DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " tsbogend@alpha.franken.de\n";
@@ -53,8 +54,6 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 
-static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
-
 /*
  * PCI device identifiers for "new style" Linux PCI Device Drivers
  */
@@ -64,14 +63,33 @@
     { 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, pcnet32_pci_tbl);
+
+int cards_found __initdata;
+
+/* 
+ * VLB I/O addresses 
+ */
+static unsigned int pcnet32_portlist[] __initdata = 
+	{ 0x300, 0x320, 0x340, 0x360, 0 };
+
+
+
 static int pcnet32_debug = 1;
 static int tx_start = 1; /* Mapping -- 0:20, 1:64, 2:128, 3:~220 (depends on chip vers) */
+static int pcnet32vlb;	 /* check for VLB cards ? */
 
 static struct net_device *pcnet32_dev;
 
-static const int max_interrupt_work = 80;
-static const int rx_copybreak = 200;
+static int max_interrupt_work = 80;
+static int rx_copybreak = 200;
 
+#ifdef PORT_AUI
+#undef PORT_AUI
+#endif
+#ifdef PORT_MII
+#undef PORT_MII
+#endif
 #define PORT_AUI      0x00
 #define PORT_10BT     0x01
 #define PORT_GPSI     0x02
@@ -107,7 +125,7 @@
     PORT_ASEL			   /* 15 not supported	  */
 };
 
-#define MAX_UNITS 8
+#define MAX_UNITS 8	/* More are supported, limit only on options */
 static int options[MAX_UNITS];
 static int full_duplex[MAX_UNITS];
 
@@ -186,7 +204,19 @@
  * v1.25kf Added No Interrupt on successful Tx for some Tx's <kaf@fc.hp.com>
  * v1.26   Converted to pci_alloc_consistent, Jamey Hicks / George France
  *                                           <jamey@crl.dec.com>
- * v1.26p Fix oops on rmmod+insmod; plug i/o resource leak - Paul Gortmaker
+ * -	   Fixed a few bugs, related to running the controller in 32bit mode.
+ *	   23 Oct, 2000.  Carsten Langgaard, carstenl@mips.com
+ *	   Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * v1.26p  Fix oops on rmmod+insmod; plug i/o resource leak - Paul Gortmaker
+ * v1.27   improved CSR/PROM address detection, lots of cleanups,
+ * 	   new pcnet32vlb module option, HP-PARISC support,
+ * 	   added module parameter descriptions, 
+ * 	   initial ethtool support - Helge Deller <deller@gmx.de>
+ * v1.27a  Sun Feb 10 2002 Go Taniguchi <go@turbolinux.co.jp>
+ *	   use alloc_etherdev and register_netdev
+ *	   fix pci probe not increment cards_found
+ *	   FD auto negotiate error workaround for xSeries250
+ *	   clean up and use new mii module
  */
 
 
@@ -200,13 +230,13 @@
 #define PCNET32_LOG_RX_BUFFERS 5
 #endif
 
-#define TX_RING_SIZE			(1 << (PCNET32_LOG_TX_BUFFERS))
-#define TX_RING_MOD_MASK		(TX_RING_SIZE - 1)
-#define TX_RING_LEN_BITS		((PCNET32_LOG_TX_BUFFERS) << 12)
-
-#define RX_RING_SIZE			(1 << (PCNET32_LOG_RX_BUFFERS))
-#define RX_RING_MOD_MASK		(RX_RING_SIZE - 1)
-#define RX_RING_LEN_BITS		((PCNET32_LOG_RX_BUFFERS) << 4)
+#define TX_RING_SIZE		(1 << (PCNET32_LOG_TX_BUFFERS))
+#define TX_RING_MOD_MASK	(TX_RING_SIZE - 1)
+#define TX_RING_LEN_BITS	((PCNET32_LOG_TX_BUFFERS) << 12)
+
+#define RX_RING_SIZE		(1 << (PCNET32_LOG_RX_BUFFERS))
+#define RX_RING_MOD_MASK	(RX_RING_SIZE - 1)
+#define RX_RING_LEN_BITS	((PCNET32_LOG_RX_BUFFERS) << 4)
 
 #define PKT_BUF_SZ		1544
 
@@ -221,7 +251,7 @@
 #define PCNET32_DWIO_RESET	0x18
 #define PCNET32_DWIO_BDP	0x1C
 
-#define PCNET32_TOTAL_SIZE 0x20
+#define PCNET32_TOTAL_SIZE	0x20
 
 #define CRC_POLYNOMIAL_LE 0xedb88320UL	/* Ethernet CRC, little endian */
 
@@ -271,37 +301,36 @@
  */
 struct pcnet32_private {
     /* The Tx and Rx ring entries must be aligned on 16-byte boundaries in 32bit mode. */
-    struct pcnet32_rx_head   rx_ring[RX_RING_SIZE];
-    struct pcnet32_tx_head   tx_ring[TX_RING_SIZE];
-    struct pcnet32_init_block	init_block;
-    dma_addr_t dma_addr;		/* DMA address of beginning of this object, returned by pci_alloc_consistent */
-    struct pci_dev *pci_dev;		/* Pointer to the associated pci device structure */
-    const char *name;
+    struct pcnet32_rx_head    rx_ring[RX_RING_SIZE];
+    struct pcnet32_tx_head    tx_ring[TX_RING_SIZE];
+    struct pcnet32_init_block init_block;
+    dma_addr_t 		dma_addr;	/* DMA address of beginning of this object, 
+					   returned by pci_alloc_consistent */
+    struct pci_dev	*pci_dev;	/* Pointer to the associated pci device structure */
+    const char		*name;
     /* The saved address of a sent-in-place packet/buffer, for skfree(). */
-    struct sk_buff *tx_skbuff[TX_RING_SIZE];
-    struct sk_buff *rx_skbuff[RX_RING_SIZE];
-    dma_addr_t tx_dma_addr[TX_RING_SIZE];
-    dma_addr_t rx_dma_addr[RX_RING_SIZE];
+    struct sk_buff	*tx_skbuff[TX_RING_SIZE];
+    struct sk_buff	*rx_skbuff[RX_RING_SIZE];
+    dma_addr_t		tx_dma_addr[TX_RING_SIZE];
+    dma_addr_t		rx_dma_addr[RX_RING_SIZE];
     struct pcnet32_access a;
-    spinlock_t lock;					/* Guard lock */
-    unsigned int cur_rx, cur_tx;		/* The next free ring entry */
-    unsigned int dirty_rx, dirty_tx;	/* The ring entries to be free()ed. */
+    spinlock_t		lock;		/* Guard lock */
+    unsigned int	cur_rx, cur_tx;	/* The next free ring entry */
+    unsigned int	dirty_rx, dirty_tx; /* The ring entries to be free()ed. */
     struct net_device_stats stats;
-    char tx_full;
-    int	 options;
-    int	 shared_irq:1,			/* shared irq possible */
-	ltint:1,
-#ifdef DO_DXSUFLO
-      dxsuflo:1,			    /* disable transmit stop on uflo */
-#endif
-	mii:1;					/* mii port available */
-    struct net_device *next;
+    char		tx_full;
+    int			options;
+    int	shared_irq:1,			/* shared irq possible */
+	ltint:1,			/* enable TxDone-intr inhibitor */
+	dxsuflo:1,			/* disable transmit stop on uflo */
+	mii:1;				/* mii port available */
+    struct net_device	*next;
     struct mii_if_info mii_if;
 };
 
-static int  pcnet32_probe_vlbus(int cards_found);
+static void pcnet32_probe_vlbus(void);
 static int  pcnet32_probe_pci(struct pci_dev *, const struct pci_device_id *);
-static int  pcnet32_probe1(unsigned long, unsigned char, int, int, struct pci_dev *);
+static int  pcnet32_probe1(unsigned long, unsigned char, int, struct pci_dev *);
 static int  pcnet32_open(struct net_device *);
 static int  pcnet32_init_ring(struct net_device *);
 static int  pcnet32_start_xmit(struct sk_buff *, struct net_device *);
@@ -320,15 +349,6 @@
     PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
 };
 
-struct pcnet32_pci_id_info {
-    const char *name;
-    u16 vendor_id, device_id, svid, sdid, flags;
-    int io_size;
-    int (*probe1) (unsigned long, unsigned char, int, int, struct pci_dev *);
-};
-
-
-MODULE_DEVICE_TABLE (pci, pcnet32_pci_tbl);
 
 static u16 pcnet32_wio_read_csr (unsigned long addr, int index)
 {
@@ -376,13 +396,13 @@
 }
 
 static struct pcnet32_access pcnet32_wio = {
-    pcnet32_wio_read_csr,
-    pcnet32_wio_write_csr,
-    pcnet32_wio_read_bcr,
-    pcnet32_wio_write_bcr,
-    pcnet32_wio_read_rap,
-    pcnet32_wio_write_rap,
-    pcnet32_wio_reset
+    read_csr:	pcnet32_wio_read_csr,
+    write_csr:	pcnet32_wio_write_csr,
+    read_bcr:	pcnet32_wio_read_bcr,
+    write_bcr:	pcnet32_wio_write_bcr,
+    read_rap:	pcnet32_wio_read_rap,
+    write_rap:	pcnet32_wio_write_rap,
+    reset:	pcnet32_wio_reset
 };
 
 static u16 pcnet32_dwio_read_csr (unsigned long addr, int index)
@@ -431,82 +451,61 @@
 }
 
 static struct pcnet32_access pcnet32_dwio = {
-    pcnet32_dwio_read_csr,
-    pcnet32_dwio_write_csr,
-    pcnet32_dwio_read_bcr,
-    pcnet32_dwio_write_bcr,
-    pcnet32_dwio_read_rap,
-    pcnet32_dwio_write_rap,
-    pcnet32_dwio_reset
-
+    read_csr:	pcnet32_dwio_read_csr,
+    write_csr:	pcnet32_dwio_write_csr,
+    read_bcr:	pcnet32_dwio_read_bcr,
+    write_bcr:	pcnet32_dwio_write_bcr,
+    read_rap:	pcnet32_dwio_read_rap,
+    write_rap:	pcnet32_dwio_write_rap,
+    reset:	pcnet32_dwio_reset
 };
 
-
 
-/* only probes for non-PCI devices, the rest are handled by pci_register_driver via pcnet32_probe_pci*/
-static int __init pcnet32_probe_vlbus(int cards_found)
+
+/* only probes for non-PCI devices, the rest are handled by 
+ * pci_register_driver via pcnet32_probe_pci */
+
+static void __devinit
+pcnet32_probe_vlbus(void)
 {
-    unsigned long ioaddr = 0; // FIXME dev ? dev->base_addr: 0;
-    unsigned int  irq_line = 0; // FIXME dev ? dev->irq : 0;
-    int *port;
+    unsigned int *port, ioaddr;
     
-    printk(KERN_INFO "pcnet32_probe_vlbus: cards_found=%d\n", cards_found);
-#ifndef __powerpc__
-    if (ioaddr > 0x1ff) {
-	if (check_region(ioaddr, PCNET32_TOTAL_SIZE) == 0)
-	    return pcnet32_probe1(ioaddr, irq_line, 0, 0, NULL);
-	else
-	    return -ENODEV;
-    } else
-#endif
-	if (ioaddr != 0)
-	    return -ENXIO;
-    
-    /* now look for PCnet32 VLB cards */
-    for (port = pcnet32_portlist; *port; port++) {
-	unsigned long ioaddr = *port;
-	
-	if ( check_region(ioaddr, PCNET32_TOTAL_SIZE) == 0) {
+    /* search for PCnet32 VLB cards at known addresses */
+    for (port = pcnet32_portlist; (ioaddr = *port); port++) {
+	if (!check_region(ioaddr, PCNET32_TOTAL_SIZE)) {
 	    /* check if there is really a pcnet chip on that ioaddr */
-	    if ((inb(ioaddr + 14) == 0x57) &&
-		(inb(ioaddr + 15) == 0x57) &&
-		(pcnet32_probe1(ioaddr, 0, 0, 0, NULL) == 0))
-		cards_found++;
+	    if ((inb(ioaddr + 14) == 0x57) && (inb(ioaddr + 15) == 0x57))
+		pcnet32_probe1(ioaddr, 0, 0, NULL);
 	}
     }
-    return cards_found ? 0: -ENODEV;
 }
 
 
-
 static int __devinit
 pcnet32_probe_pci(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-    static int card_idx;
-    long ioaddr;
-    int err = 0;
-
-    printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);
+    unsigned long ioaddr;
+    int err;
 
-    if ((err = pci_enable_device(pdev)) < 0) {
-	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
+    err = pci_enable_device(pdev);
+    if (err < 0) {
+	printk(KERN_ERR PFX "failed to enable device -- err=%d\n", err);
 	return err;
     }
     pci_set_master(pdev);
 
     ioaddr = pci_resource_start (pdev, 0);
-    printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
     if (!ioaddr) {
-        printk (KERN_ERR "no PCI IO resources, aborting\n");
+        printk (KERN_ERR PFX "card has no PCI IO resources, aborting\n");
         return -ENODEV;
     }
-	
+    
     if (!pci_dma_supported(pdev, PCNET32_DMA_MASK)) {
-	printk(KERN_ERR "pcnet32.c: architecture does not support 32bit PCI busmaster DMA\n");
+	printk(KERN_ERR PFX "architecture does not support 32bit PCI busmaster DMA\n");
 	return -ENODEV;
     }
 
-    return pcnet32_probe1(ioaddr, pdev->irq, 1, card_idx, pdev);
+    return pcnet32_probe1(ioaddr, pdev->irq, 1, pdev);
 }
 
 
@@ -515,41 +514,44 @@
  *  pdev will be NULL when called from pcnet32_probe_vlbus.
  */
 static int __devinit
-pcnet32_probe1(unsigned long ioaddr, unsigned char irq_line, int shared, int card_idx, struct pci_dev *pdev)
+pcnet32_probe1(unsigned long ioaddr, unsigned char irq_line, int shared,
+		struct pci_dev *pdev)
 {
     struct pcnet32_private *lp;
     struct resource *res;
     dma_addr_t lp_dma_addr;
-    int i,media,fdx = 0, mii = 0, fset = 0;
-#ifdef DO_DXSUFLO
-    int dxsuflo = 0;
-#endif
-    int ltint = 0;
+    int i, media;
+    int fdx, mii, fset, dxsuflo, ltint;
     int chip_version;
     char *chipname;
     struct net_device *dev;
     struct pcnet32_access *a = NULL;
+    u8 promaddr[6];
 
     /* reset the chip */
     pcnet32_dwio_reset(ioaddr);
     pcnet32_wio_reset(ioaddr);
 
     /* NOTE: 16-bit check is first, otherwise some older PCnet chips fail */
-    if (pcnet32_wio_read_csr (ioaddr, 0) == 4 && pcnet32_wio_check (ioaddr)) {
+    if (pcnet32_wio_read_csr(ioaddr, 0) == 4 && pcnet32_wio_check(ioaddr)) {
 	a = &pcnet32_wio;
     } else {
-	if (pcnet32_dwio_read_csr (ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
+	if (pcnet32_dwio_read_csr(ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
 	    a = &pcnet32_dwio;
 	} else
 	    return -ENODEV;
     }
 
-    chip_version = a->read_csr (ioaddr, 88) | (a->read_csr (ioaddr,89) << 16);
+    chip_version = a->read_csr(ioaddr, 88) | (a->read_csr(ioaddr,89) << 16);
     if (pcnet32_debug > 2)
 	printk(KERN_INFO "  PCnet chip version is %#x.\n", chip_version);
     if ((chip_version & 0xfff) != 0x003)
 	return -ENODEV;
+    
+    /* initialize variables */
+    fdx = mii = fset = dxsuflo = ltint = 0;
     chip_version = (chip_version >> 12) & 0xffff;
+
     switch (chip_version) {
     case 0x2420:
 	chipname = "PCnet/PCI 79C970"; /* PCI */
@@ -588,23 +590,24 @@
 	 * mode by which the card should operate
 	 */
 	/* switch to home wiring mode */
-	media = a->read_bcr (ioaddr, 49);
+	media = a->read_bcr(ioaddr, 49);
 #if 0
 	if (pcnet32_debug > 2)
-	    printk(KERN_DEBUG "pcnet32: pcnet32 media value %#x.\n",  media);
+	    printk(KERN_DEBUG PFX "media value %#x.\n",  media);
 	media &= ~3;
 	media |= 1;
 #endif
 	if (pcnet32_debug > 2)
-	    printk(KERN_DEBUG "pcnet32: pcnet32 media reset to %#x.\n",  media);
-	a->write_bcr (ioaddr, 49, media);
+	    printk(KERN_DEBUG PFX "media reset to %#x.\n",  media);
+	a->write_bcr(ioaddr, 49, media);
 	break;
     case 0x2627:
 	chipname = "PCnet/FAST III 79C975"; /* PCI */
 	fdx = 1; mii = 1;
 	break;
     default:
-	printk(KERN_INFO "pcnet32: PCnet version %#x, no PCnet32 chip.\n",chip_version);
+	printk(KERN_INFO PFX "PCnet version %#x, no PCnet32 chip.\n",
+			chip_version);
 	return -ENODEV;
     }
 
@@ -619,17 +622,15 @@
     {
 	a->write_bcr(ioaddr, 18, (a->read_bcr(ioaddr, 18) | 0x0800));
 	a->write_csr(ioaddr, 80, (a->read_csr(ioaddr, 80) & 0x0C00) | 0x0c00);
-#ifdef DO_DXSUFLO
 	dxsuflo = 1;
-#endif
 	ltint = 1;
     }
     
-    dev = init_etherdev(NULL, 0);
-    if(dev==NULL)
+    dev = alloc_etherdev(0);
+    if(!dev)
 	return -ENOMEM;
 
-    printk(KERN_INFO "%s: %s at %#3lx,", dev->name, chipname, ioaddr);
+    printk(KERN_INFO PFX "%s at %#3lx,", chipname, ioaddr);
 
     /* In most chips, after a chip reset, the ethernet address is read from the
      * station address PROM at the base address and programmed into the
@@ -645,31 +646,28 @@
 	dev->dev_addr[2*i] = val & 0x0ff;
 	dev->dev_addr[2*i+1] = (val >> 8) & 0x0ff;
     }
-    {
-	u8 promaddr[6];
-	for (i = 0; i < 6; i++) {
-	    promaddr[i] = inb(ioaddr + i);
-	}
-	if( memcmp( promaddr, dev->dev_addr, 6) )
-	{
-	    printk(" warning PROM address does not match CSR address\n");
-#if defined(__i386__)
-	    printk(KERN_WARNING "%s: Probably a Compaq, using the PROM address of", dev->name);
-	    memcpy(dev->dev_addr, promaddr, 6);
-#elif defined(__powerpc__)
-	    if (!is_valid_ether_addr(dev->dev_addr)
-		&& is_valid_ether_addr(promaddr)) {
-		    printk("\n" KERN_WARNING "%s: using PROM address:",
-			   dev->name);
-		    memcpy(dev->dev_addr, promaddr, 6);
-	    }
+
+    /* read PROM address and compare with CSR address */
+    for (i = 0; i < 6; i++)
+	promaddr[i] = inb(ioaddr + i);
+    
+    if( memcmp( promaddr, dev->dev_addr, 6)
+	|| !is_valid_ether_addr(dev->dev_addr) ) {
+#ifndef __powerpc__
+	if( is_valid_ether_addr(promaddr) ){
+#else
+	if( !is_valid_ether_addr(dev->dev_addr)
+	    && is_valid_ether_addr(promaddr)) {
 #endif
-	}	    	    
+	    printk(" warning: CSR address invalid,\n");
+	    printk(KERN_INFO "    using instead PROM address of");
+	    memcpy(dev->dev_addr, promaddr, 6);
+	}
     }
+
     /* if the ethernet address is not valid, force to 00:00:00:00:00:00 */
     if( !is_valid_ether_addr(dev->dev_addr) )
-	for (i = 0; i < 6; i++)
-	    dev->dev_addr[i]=0;
+	memset(dev->dev_addr, 0, sizeof(dev->dev_addr));
 
     for (i = 0; i < 6; i++)
 	printk(" %2.2x", dev->dev_addr[i] );
@@ -699,7 +697,7 @@
 
     dev->base_addr = ioaddr;
     res = request_region(ioaddr, PCNET32_TOTAL_SIZE, chipname);
-    if (res == NULL)
+    if (!res)
 	return -EBUSY;
     
     /* pci_alloc_consistent returns page-aligned memory, so we do not have to check the alignment */
@@ -711,7 +709,6 @@
     memset(lp, 0, sizeof(*lp));
     lp->dma_addr = lp_dma_addr;
     lp->pci_dev = pdev;
-    printk("\n" KERN_INFO "pcnet32: pcnet32_private lp=%p lp_dma_addr=%#08x", lp, lp_dma_addr);
 
     spin_lock_init(&lp->lock);
     
@@ -719,24 +716,23 @@
     lp->name = chipname;
     lp->shared_irq = shared;
     lp->mii_if.full_duplex = fdx;
-#ifdef DO_DXSUFLO
     lp->dxsuflo = dxsuflo;
-#endif
     lp->ltint = ltint;
     lp->mii = mii;
-    if (options[card_idx] > sizeof (options_mapping))
+    if ((cards_found >= MAX_UNITS) || (options[cards_found] > sizeof(options_mapping)))
 	lp->options = PORT_ASEL;
     else
-	lp->options = options_mapping[options[card_idx]];
+	lp->options = options_mapping[options[cards_found]];
     lp->mii_if.dev = dev;
     lp->mii_if.mdio_read = mdio_read;
     lp->mii_if.mdio_write = mdio_write;
     
-    if (fdx && !(lp->options & PORT_ASEL) && full_duplex[card_idx])
+    if (fdx && !(lp->options & PORT_ASEL) && 
+		((cards_found>=MAX_UNITS) || full_duplex[cards_found]))
 	lp->options |= PORT_FD;
     
-    if (a == NULL) {
-      printk(KERN_ERR "pcnet32: No access methods\n");
+    if (!a) {
+      printk(KERN_ERR PFX "No access methods\n");
       pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
       release_resource(res);
       return -ENODEV;
@@ -791,8 +787,6 @@
 	}
     }
 
-    if (pcnet32_debug > 0)
-	printk(KERN_INFO "%s", version);
     
     /* The PCNET32-specific entries in the device structure. */
     dev->open = &pcnet32_open;
@@ -808,11 +802,13 @@
     pcnet32_dev = dev;
 
     /* Fill in the generic fields of the device structure. */
-    ether_setup(dev);
+    register_netdev(dev);
+    printk(KERN_INFO "%s: registered as %s\n",dev->name, lp->name);
+    cards_found++;
     return 0;
 }
 
-
+
 static int
 pcnet32_open(struct net_device *dev)
 {
@@ -857,6 +853,9 @@
 	    val |= 1;
 	    if (lp->options == (PORT_FD | PORT_AUI))
 		val |= 2;
+	} else if (lp->options & PORT_ASEL) {
+	/* workaround for xSeries250 */
+	    val |= 3;
 	}
 	lp->a.write_bcr (ioaddr, 9, val);
     }
@@ -889,6 +888,7 @@
 	lp->a.write_csr (ioaddr, 3, val);
     }
 #endif
+
     if (lp->ltint) { /* Enable TxDone-intr inhibitor */
 	val = lp->a.read_csr (ioaddr, 5);
 	val |= (1<<14);
@@ -923,7 +923,7 @@
     if (pcnet32_debug > 2)
 	printk(KERN_DEBUG "%s: pcnet32 open after %d ticks, init block %#x csr0 %4.4x.\n",
 	       dev->name, i, (u32) (lp->dma_addr + offsetof(struct pcnet32_private, init_block)),
-	       lp->a.read_csr (ioaddr, 0));
+	       lp->a.read_csr(ioaddr, 0));
 
 
     MOD_INC_USE_COUNT;
@@ -1033,7 +1033,7 @@
 
     /* Transmitter timeout, serious problems. */
 	printk(KERN_ERR "%s: transmit timed out, status %4.4x, resetting.\n",
-	       dev->name, lp->a.read_csr (ioaddr, 0));
+	       dev->name, lp->a.read_csr(ioaddr, 0));
 	lp->a.write_csr (ioaddr, 0, 0x0004);
 	lp->stats.tx_errors++;
 	if (pcnet32_debug > 2) {
@@ -1069,7 +1069,7 @@
 
     if (pcnet32_debug > 3) {
 	printk(KERN_DEBUG "%s: pcnet32_start_xmit() called, csr0 %4.4x.\n",
-	       dev->name, lp->a.read_csr (ioaddr, 0));
+	       dev->name, lp->a.read_csr(ioaddr, 0));
     }
 
     spin_lock_irqsave(&lp->lock, flags);
@@ -1136,8 +1136,9 @@
     int boguscnt =  max_interrupt_work;
     int must_restart;
 
-    if (dev == NULL) {
-	printk (KERN_DEBUG "pcnet32_interrupt(): irq %d for unknown device.\n", irq);
+    if (!dev) {
+	printk (KERN_DEBUG "%s(): irq %d for unknown device\n",
+		__FUNCTION__, irq);
 	return;
     }
 
@@ -1208,7 +1209,8 @@
 
 		/* We must free the original skb */
 		if (lp->tx_skbuff[entry]) {
-                    pci_unmap_single(lp->pci_dev, lp->tx_dma_addr[entry], lp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
+                    pci_unmap_single(lp->pci_dev, lp->tx_dma_addr[entry],
+			lp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
 		    dev_kfree_skb_irq(lp->tx_skbuff[entry]);
 		    lp->tx_skbuff[entry] = 0;
                     lp->tx_dma_addr[entry] = 0;
@@ -1216,13 +1218,12 @@
 		dirty_tx++;
 	    }
 
-#ifndef final_version
 	    if (lp->cur_tx - dirty_tx >= TX_RING_SIZE) {
-		printk(KERN_ERR "out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
-		       dirty_tx, lp->cur_tx, lp->tx_full);
+		printk(KERN_ERR "%s: out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
+			dev->name, dirty_tx, lp->cur_tx, lp->tx_full);
 		dirty_tx += TX_RING_SIZE;
 	    }
-#endif
+
 	    if (lp->tx_full &&
 		netif_queue_stopped(dev) &&
 		dirty_tx > lp->cur_tx - TX_RING_SIZE + 2) {
@@ -1263,7 +1264,7 @@
 
     /* Clear any other interrupt, and set interrupt enable. */
     lp->a.write_csr (ioaddr, 0, 0x7940);
-    lp->a.write_rap(ioaddr,rap);
+    lp->a.write_rap (ioaddr,rap);
     
     if (pcnet32_debug > 4)
 	printk(KERN_DEBUG "%s: exiting interrupt, csr0=%#4.4x.\n",
@@ -1316,7 +1317,9 @@
 			skb_put (skb, pkt_len);
 			lp->rx_skbuff[entry] = newskb;
 			newskb->dev = dev;
-                        lp->rx_dma_addr[entry] = pci_map_single(lp->pci_dev, newskb->tail, newskb->len, PCI_DMA_FROMDEVICE);
+                        lp->rx_dma_addr[entry] = 
+				pci_map_single(lp->pci_dev, newskb->tail,
+					newskb->len, PCI_DMA_FROMDEVICE);
 			lp->rx_ring[entry].base = le32_to_cpu(lp->rx_dma_addr[entry]);
 			rx_in_place = 1;
 		    } else
@@ -1446,13 +1449,13 @@
 	
     /* set all multicast bits */
     if (dev->flags & IFF_ALLMULTI){ 
-	ib->filter [0] = 0xffffffff;
-	ib->filter [1] = 0xffffffff;
+	ib->filter[0] = 0xffffffff;
+	ib->filter[1] = 0xffffffff;
 	return;
     }
     /* clear the multicast filter */
-    ib->filter [0] = 0;
-    ib->filter [1] = 0;
+    ib->filter[0] = 0;
+    ib->filter[1] = 0;
 
     /* Add addresses */
     for (i = 0; i < dev->mc_count; i++){
@@ -1664,20 +1667,28 @@
     }
     return -EOPNOTSUPP;
 }
-					    
+
 static struct pci_driver pcnet32_driver = {
-	name:		DRV_NAME,
-	probe:		pcnet32_probe_pci,
-	remove:		NULL,
-	id_table:	pcnet32_pci_tbl,
+    name:	DRV_NAME,
+    probe:	pcnet32_probe_pci,
+    id_table:	pcnet32_pci_tbl,
 };
 
 MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, DRV_NAME " debug level (0-6)");
 MODULE_PARM(max_interrupt_work, "i");
+MODULE_PARM_DESC(max_interrupt_work, DRV_NAME " maximum events handled per interrupt");  
 MODULE_PARM(rx_copybreak, "i");
+MODULE_PARM_DESC(rx_copybreak, DRV_NAME " copy breakpoint for copy-only-tiny-frames"); 
 MODULE_PARM(tx_start_pt, "i");
+MODULE_PARM_DESC(tx_start_pt, DRV_NAME " transmit start point (0-3)"); 
+MODULE_PARM(pcnet32vlb, "i");
+MODULE_PARM_DESC(pcnet32vlb, DRV_NAME " Vesa local bus (VLB) support (0/1)"); 
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(options, DRV_NAME " initial option setting(s) (0-15)"); 
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM_DESC(full_duplex, DRV_NAME " full duplex setting(s) (1)");
+
 MODULE_AUTHOR("Thomas Bogendoerfer");
 MODULE_DESCRIPTION("Driver for PCnet32 and PCnetPCI based ethercards");
 MODULE_LICENSE("GPL");
@@ -1688,36 +1699,25 @@
 
 static int __init pcnet32_init_module(void)
 {
-    int cards_found = 0;
-    int err;
+    printk(KERN_INFO "%s", version);
 
     if (debug > 0)
 	pcnet32_debug = debug;
+
     if ((tx_start_pt >= 0) && (tx_start_pt <= 3))
 	tx_start = tx_start_pt;
-    
-    pcnet32_dev = NULL;
+
     /* find the PCI devices */
-#define USE_PCI_REGISTER_DRIVER
-#ifdef USE_PCI_REGISTER_DRIVER
-    if ((err = pci_module_init(&pcnet32_driver)) < 0 )
-       return err;
-#else
-    {
-        struct pci_device_id *devid = pcnet32_pci_tbl;
-        for (devid = pcnet32_pci_tbl; devid != NULL && devid->vendor != 0; devid++) {
-            struct pci_dev *pdev = pci_find_subsys(devid->vendor, devid->device, devid->subvendor, devid->subdevice, NULL);
-            if (pdev != NULL) {
-                if (pcnet32_probe_pci(pdev, devid) >= 0) {
-                    cards_found++;
-                }
-            }
-        }
-    }
-#endif
-    return 0;
-    /* find any remaining VLbus devices */
-    return pcnet32_probe_vlbus(cards_found);
+    pci_module_init(&pcnet32_driver);
+
+    /* should we find any remaining VLbus devices ? */
+    if (pcnet32vlb)
+	pcnet32_probe_vlbus();
+
+    if (cards_found)
+	printk(KERN_INFO PFX "%d cards_found.\n", cards_found);
+    
+    return cards_found ? 0 : -ENODEV;
 }
 
 static void __exit pcnet32_cleanup_module(void)
@@ -1726,13 +1726,13 @@
 
     /* No need to check MOD_IN_USE, as sys_delete_module() checks. */
     while (pcnet32_dev) {
-        struct pcnet32_private *lp = pcnet32_dev->priv;
+	struct pcnet32_private *lp = pcnet32_dev->priv;
 	next_dev = lp->next;
 	unregister_netdev(pcnet32_dev);
 	release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
-	if (lp->pci_dev != NULL)
-	    pci_unregister_driver(&pcnet32_driver);
-        pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
+	if (lp->pci_dev)
+		pci_unregister_driver(&pcnet32_driver);
+	pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	kfree(pcnet32_dev);
 	pcnet32_dev = next_dev;
     }
