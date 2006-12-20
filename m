Return-Path: <linux-kernel-owner+w=401wt.eu-S964981AbWLTMCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWLTMCL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWLTMBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:01:54 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1557 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbWLTMBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:01:47 -0500
Date: Wed, 20 Dec 2006 12:01:42 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 03/10] defxx: TURBOchannel support
Message-ID: <Pine.LNX.4.64N.0612191859420.20895@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a set of changes to add TURBOchannel support to the defxx driver.  
As at this point the EISA support in the driver has become the only not 
having been converted to the driver model, I took the opportunity to 
convert it as well.  Plus support for MMIO in addition to PIO operation as 
TURBOchannel requires it anyway.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 These changes have been tested at the run time with TC and PCI variations 
of the board.  EISA support has only been verified to build correctly.  I 
do believe I got it mostly right, but if there is somebody interested in 
keeping the DEFEA supported, then please send me results of testing or, 
for long-term testing, I would not mind accepting such a board either. ;-)

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-defta-69
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/Kconfig linux-mips-2.6.18-20060920/drivers/net/Kconfig
--- linux-mips-2.6.18-20060920.macro/drivers/net/Kconfig	2006-09-10 04:55:24.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/Kconfig	2006-12-15 22:45:17.000000000 +0000
@@ -2443,7 +2443,7 @@ config RIONET_RX_SIZE
 
 config FDDI
 	bool "FDDI driver support"
-	depends on (PCI || EISA)
+	depends on (PCI || EISA || TC)
 	help
 	  Fiber Distributed Data Interface is a high speed local area network
 	  design; essentially a replacement for high speed Ethernet. FDDI can
@@ -2453,11 +2453,31 @@ config FDDI
 	  will say N.
 
 config DEFXX
-	tristate "Digital DEFEA and DEFPA adapter support"
-	depends on FDDI && (PCI || EISA)
-	help
-	  This is support for the DIGITAL series of EISA (DEFEA) and PCI
-	  (DEFPA) controllers which can connect you to a local FDDI network.
+	tristate "Digital DEFTA/DEFEA/DEFPA adapter support"
+	depends on FDDI && (PCI || EISA || TC)
+	---help---
+	  This is support for the DIGITAL series of TURBOchannel (DEFTA),
+	  EISA (DEFEA) and PCI (DEFPA) controllers which can connect you
+	  to a local FDDI network.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called defxx.  If unsure, say N.
+
+config DEFXX_MMIO
+	bool
+	prompt "Use MMIO instead of PIO" if PCI || EISA
+	depends on DEFXX
+	default n if PCI || EISA
+	default y
+	---help---
+	  This instructs the driver to use EISA or PCI memory-mapped I/O
+	  (MMIO) as appropriate instead of programmed I/O ports (PIO).
+	  Enabling this gives an improvement in processing time in parts
+	  of the driver, but it may cause problems with EISA (DEFEA)
+	  adapters.  TURBOchannel does not have the concept of I/O ports,
+	  so MMIO is always used for these (DEFTA) adapters.
+
+	  If unsure, say N.
 
 config SKFP
 	tristate "SysKonnect FDDI PCI support"
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/defxx.c linux-mips-2.6.18-20060920/drivers/net/defxx.c
--- linux-mips-2.6.18-20060920.macro/drivers/net/defxx.c	2006-10-23 22:58:19.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/defxx.c	2006-12-20 00:22:01.000000000 +0000
@@ -10,10 +10,12 @@
  *
  * Abstract:
  *   A Linux device driver supporting the Digital Equipment Corporation
- *   FDDI EISA and PCI controller families.  Supported adapters include:
+ *   FDDI TURBOchannel, EISA and PCI controller families.  Supported
+ *   adapters include:
  *
- *		DEC FDDIcontroller/EISA (DEFEA)
- *		DEC FDDIcontroller/PCI  (DEFPA)
+ *		DEC FDDIcontroller/TURBOchannel (DEFTA)
+ *		DEC FDDIcontroller/EISA         (DEFEA)
+ *		DEC FDDIcontroller/PCI          (DEFPA)
  *
  * The original author:
  *   LVS	Lawrence V. Stefani <lstefani@yahoo.com>
@@ -193,24 +195,27 @@
  *		14 Aug 2004	macro		Fix device names reported.
  *		14 Jun 2005	macro		Use irqreturn_t.
  *		23 Oct 2006	macro		Big-endian host support.
+ *		14 Dec 2006	macro		TURBOchannel support.
  */
 
 /* Include files */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/eisa.h>
+#include <linux/errno.h>
+#include <linux/fddidevice.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/fddidevice.h>
+#include <linux/pci.h>
 #include <linux/skbuff.h>
-#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tc.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -219,8 +224,8 @@
 
 /* Version information string should be updated prior to each new release!  */
 #define DRV_NAME "defxx"
-#define DRV_VERSION "v1.09"
-#define DRV_RELDATE "2006/10/23"
+#define DRV_VERSION "v1.10"
+#define DRV_RELDATE "2006/12/14"
 
 static char version[] __devinitdata =
 	DRV_NAME ": " DRV_VERSION " " DRV_RELDATE
@@ -235,12 +240,41 @@ static char version[] __devinitdata =
  */
 #define NEW_SKB_SIZE (PI_RCV_DATA_K_SIZE_MAX+128)
 
+#define __unused __attribute__ ((unused))
+
+#ifdef CONFIG_PCI
+#define DFX_BUS_PCI(dev) (dev->bus == &pci_bus_type)
+#else
+#define DFX_BUS_PCI(dev) 0
+#endif
+
+#ifdef CONFIG_EISA
+#define DFX_BUS_EISA(dev) (dev->bus == &eisa_bus_type)
+#else
+#define DFX_BUS_EISA(dev) 0
+#endif
+
+#ifdef CONFIG_TC
+#define DFX_BUS_TC(dev) (dev->bus == &tc_bus_type)
+#else
+#define DFX_BUS_TC(dev) 0
+#endif
+
+#ifdef CONFIG_DEFXX_MMIO
+#define DFX_MMIO 1
+#else
+#define DFX_MMIO 0
+#endif
+
 /* Define module-wide (static) routines */
 
 static void		dfx_bus_init(struct net_device *dev);
+static void		dfx_bus_uninit(struct net_device *dev);
 static void		dfx_bus_config_check(DFX_board_t *bp);
 
-static int		dfx_driver_init(struct net_device *dev, const char *print_name);
+static int		dfx_driver_init(struct net_device *dev,
+					const char *print_name,
+					resource_size_t bar_start);
 static int		dfx_adap_init(DFX_board_t *bp, int get_buffers);
 
 static int		dfx_open(struct net_device *dev);
@@ -274,13 +308,13 @@ static void		dfx_xmt_flush(DFX_board_t *
 
 /* Define module-wide (static) variables */
 
-static struct net_device *root_dfx_eisa_dev;
+static struct pci_driver dfx_pci_driver;
+static struct eisa_driver dfx_eisa_driver;
+static struct tc_driver dfx_tc_driver;
 
 
 /*
  * =======================
- * = dfx_port_write_byte =
- * = dfx_port_read_byte	 =
  * = dfx_port_write_long =
  * = dfx_port_read_long  =
  * =======================
@@ -292,12 +326,11 @@ static struct net_device *root_dfx_eisa_
  *   None
  *       
  * Arguments:
- *   bp     - pointer to board information
- *   offset - register offset from base I/O address
- *   data   - for dfx_port_write_byte and dfx_port_write_long, this
- *			  is a value to write.
- *			  for dfx_port_read_byte and dfx_port_read_byte, this
- *			  is a pointer to store the read value.
+ *   bp		- pointer to board information
+ *   offset	- register offset from base I/O address
+ *   data	- for dfx_port_write_long, this is a value to write;
+ *		  for dfx_port_read_long, this is a pointer to store
+ *		  the read value
  *
  * Functional Description:
  *   These routines perform the correct operation to read or write
@@ -311,7 +344,7 @@ static struct net_device *root_dfx_eisa_
  *   registers using the register offsets defined in DEFXX.H.
  *
  *   PCI port block base addresses are assigned by the PCI BIOS or system
- *	 firmware.  There is one 128 byte port block which can be accessed.  It
+ *   firmware.  There is one 128 byte port block which can be accessed.  It
  *   allows for I/O mapping of both PDQ and PFI registers using the register
  *   offsets defined in DEFXX.H.
  *
@@ -319,7 +352,7 @@ static struct net_device *root_dfx_eisa_
  *   None
  *
  * Assumptions:
- *   bp->base_addr is a valid base I/O address for this adapter.
+ *   bp->base is a valid base I/O address for this adapter.
  *   offset is a valid register offset for this adapter.
  *
  * Side Effects:
@@ -330,69 +363,135 @@ static struct net_device *root_dfx_eisa_
  *   advantage of strict data type checking.
  */
 
-static inline void dfx_port_write_byte(
-	DFX_board_t	*bp,
-	int			offset,
-	u8			data
-	)
-
-	{
-	u16 port = bp->base_addr + offset;
-
-	outb(data, port);
-	}
+static inline void dfx_writel(DFX_board_t *bp, int offset, u32 data)
+{
+	writel(data, bp->base.mem + offset);
+	mb();
+}
 
-static inline void dfx_port_read_byte(
-	DFX_board_t	*bp,
-	int			offset,
-	u8			*data
-	)
+static inline void dfx_outl(DFX_board_t *bp, int offset, u32 data)
+{
+	outl(data, bp->base.port + offset);
+}
 
-	{
-	u16 port = bp->base_addr + offset;
+static void dfx_port_write_long(DFX_board_t *bp, int offset, u32 data)
+{
+	struct device __unused *bdev = bp->bus_dev;
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
 
-	*data = inb(port);
-	}
+	if (dfx_use_mmio)
+		dfx_writel(bp, offset, data);
+	else
+		dfx_outl(bp, offset, data);
+}
 
-static inline void dfx_port_write_long(
-	DFX_board_t	*bp,
-	int			offset,
-	u32			data
-	)
 
-	{
-	u16 port = bp->base_addr + offset;
+static inline void dfx_readl(DFX_board_t *bp, int offset, u32 *data)
+{
+	mb();
+	*data = readl(bp->base.mem + offset);
+}
 
-	outl(data, port);
-	}
+static inline void dfx_inl(DFX_board_t *bp, int offset, u32 *data)
+{
+	*data = inl(bp->base.port + offset);
+}
 
-static inline void dfx_port_read_long(
-	DFX_board_t	*bp,
-	int			offset,
-	u32			*data
-	)
+static void dfx_port_read_long(DFX_board_t *bp, int offset, u32 *data)
+{
+	struct device __unused *bdev = bp->bus_dev;
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
 
-	{
-	u16 port = bp->base_addr + offset;
+	if (dfx_use_mmio)
+		dfx_readl(bp, offset, data);
+	else
+		dfx_inl(bp, offset, data);
+}
 
-	*data = inl(port);
+
+/*
+ * ================
+ * = dfx_get_bars =
+ * ================
+ *   
+ * Overview:
+ *   Retrieves the address range used to access control and status
+ *   registers.
+ *  
+ * Returns:
+ *   None
+ *       
+ * Arguments:
+ *   bdev	- pointer to device information
+ *   bar_start	- pointer to store the start address
+ *   bar_len	- pointer to store the length of the area
+ *
+ * Assumptions:
+ *   I am sure there are some.
+ *
+ * Side Effects:
+ *   None
+ */
+static void dfx_get_bars(struct device *bdev,
+			 resource_size_t *bar_start, resource_size_t *bar_len)
+{
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_eisa = DFX_BUS_EISA(bdev);
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
+
+	if (dfx_bus_pci) {
+		int num = dfx_use_mmio ? 0 : 1;
+
+		*bar_start = pci_resource_start(to_pci_dev(bdev), num);
+		*bar_len = pci_resource_len(to_pci_dev(bdev), num);
+	}
+	if (dfx_bus_eisa) {
+		unsigned long base_addr = to_eisa_device(bdev)->base_addr;
+		resource_size_t bar;
+
+		if (dfx_use_mmio) {
+			bar = inb(base_addr + PI_ESIC_K_MEM_ADD_CMP_2);
+			bar <<= 8;
+			bar |= inb(base_addr + PI_ESIC_K_MEM_ADD_CMP_1);
+			bar <<= 8;
+			bar |= inb(base_addr + PI_ESIC_K_MEM_ADD_CMP_0);
+			bar <<= 16;
+			*bar_start = bar;
+			bar = inb(base_addr + PI_ESIC_K_MEM_ADD_MASK_2);
+			bar <<= 8;
+			bar |= inb(base_addr + PI_ESIC_K_MEM_ADD_MASK_1);
+			bar <<= 8;
+			bar |= inb(base_addr + PI_ESIC_K_MEM_ADD_MASK_0);
+			bar <<= 16;
+			*bar_len = (bar | PI_MEM_ADD_MASK_M) + 1;
+		} else {
+			*bar_start = base_addr;
+			*bar_len = PI_ESIC_K_CSR_IO_LEN;
+		}
+	}
+	if (dfx_bus_tc) {
+		*bar_start = to_tc_dev(bdev)->resource.start +
+			     PI_TC_K_CSR_OFFSET;
+		*bar_len = PI_TC_K_CSR_LEN;
 	}
+}
 
-
 /*
- * =============
- * = dfx_init_one_pci_or_eisa =
- * =============
+ * ================
+ * = dfx_register =
+ * ================
  *   
  * Overview:
- *   Initializes a supported FDDI EISA or PCI controller
+ *   Initializes a supported FDDI controller
  *  
  * Returns:
  *   Condition code
  *       
  * Arguments:
- *   pdev - pointer to pci device information (NULL for EISA)
- *   ioaddr - pointer to port (NULL for PCI)
+ *   bdev - pointer to device information
  *
  * Functional Description:
  *
@@ -408,56 +507,74 @@ static inline void dfx_port_read_long(
  *   initialized and the board resources are read and stored in
  *   the device structure.
  */
-static int __devinit dfx_init_one_pci_or_eisa(struct pci_dev *pdev, long ioaddr)
+static int __devinit dfx_register(struct device *bdev)
 {
 	static int version_disp;
-	char *print_name = DRV_NAME;
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
+	char *print_name = bdev->bus_id;
 	struct net_device *dev;
 	DFX_board_t	  *bp;			/* board pointer */
+	resource_size_t bar_start = 0;		/* pointer to port */
+	resource_size_t bar_len = 0;		/* resource length */
 	int alloc_size;				/* total buffer size used */
-	int err;
+	struct resource *region;
+	int err = 0;
 
 	if (!version_disp) {	/* display version info if adapter is found */
 		version_disp = 1;	/* set display flag to TRUE so that */
 		printk(version);	/* we only display this string ONCE */
 	}
 
-	if (pdev != NULL)
-		print_name = pci_name(pdev);
-
 	dev = alloc_fddidev(sizeof(*bp));
 	if (!dev) {
-		printk(KERN_ERR "%s: unable to allocate fddidev, aborting\n",
+		printk(KERN_ERR "%s: Unable to allocate fddidev, aborting\n",
 		       print_name);
 		return -ENOMEM;
 	}
 
 	/* Enable PCI device. */
-	if (pdev != NULL) {
-		err = pci_enable_device (pdev);
-		if (err) goto err_out;
-		ioaddr = pci_resource_start (pdev, 1);
+	if (dfx_bus_pci && pci_enable_device(to_pci_dev(bdev))) {
+		printk(KERN_ERR "%s: Cannot enable PCI device, aborting\n",
+		       print_name);
+		goto err_out;
 	}
 
 	SET_MODULE_OWNER(dev);
-	if (pdev != NULL)
-		SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_NETDEV_DEV(dev, bdev);
+
+	bp = netdev_priv(dev);
+	bp->bus_dev = bdev;
+	dev_set_drvdata(bdev, dev);
 
-	bp = dev->priv;
+	dfx_get_bars(bdev, &bar_start, &bar_len);
 
-	if (!request_region(ioaddr,
-			    pdev ? PFI_K_CSR_IO_LEN : PI_ESIC_K_CSR_IO_LEN,
-			    print_name)) {
+	if (dfx_use_mmio)
+		region = request_mem_region(bar_start, bar_len, print_name);
+	else
+		region = request_region(bar_start, bar_len, print_name);
+	if (!region) {
 		printk(KERN_ERR "%s: Cannot reserve I/O resource "
-		       "0x%x @ 0x%lx, aborting\n", print_name,
-		       pdev ? PFI_K_CSR_IO_LEN : PI_ESIC_K_CSR_IO_LEN, ioaddr);
+		       "0x%lx @ 0x%lx, aborting\n",
+		       print_name, (long)bar_len, (long)bar_start);
 		err = -EBUSY;
-		goto err_out;
+		goto err_out_disable;
 	}
 
-	/* Initialize new device structure */
+	/* Set up I/O base address. */
+	if (dfx_use_mmio) {
+		bp->base.mem = ioremap_nocache(bar_start, bar_len);
+		if (!bp->base.mem) {
+			printk(KERN_ERR "%s: Cannot map MMIO\n", print_name);
+			goto err_out_region;
+		}
+	} else {
+		bp->base.port = bar_start;
+		dev->base_addr = bar_start;
+	}
 
-	dev->base_addr			= ioaddr; /* save port (I/O) base address */
+	/* Initialize new device structure */
 
 	dev->get_stats			= dfx_ctl_get_stats;
 	dev->open			= dfx_open;
@@ -466,22 +583,12 @@ static int __devinit dfx_init_one_pci_or
 	dev->set_multicast_list		= dfx_ctl_set_multicast_list;
 	dev->set_mac_address		= dfx_ctl_set_mac_address;
 
-	if (pdev == NULL) {
-		/* EISA board */
-		bp->bus_type = DFX_BUS_TYPE_EISA;
-		bp->next = root_dfx_eisa_dev;
-		root_dfx_eisa_dev = dev;
-	} else {
-		/* PCI board */
-		bp->bus_type = DFX_BUS_TYPE_PCI;
-		bp->pci_dev = pdev;
-		pci_set_drvdata (pdev, dev);
-		pci_set_master (pdev);
-	}
+	if (dfx_bus_pci)
+		pci_set_master(to_pci_dev(bdev));
 
-	if (dfx_driver_init(dev, print_name) != DFX_K_SUCCESS) {
+	if (dfx_driver_init(dev, print_name, bar_start) != DFX_K_SUCCESS) {
 		err = -ENODEV;
-		goto err_out_region;
+		goto err_out_unmap;
 	}
 
 	err = register_netdev(dev);
@@ -500,44 +607,28 @@ err_out_kfree:
 		     sizeof(PI_CONSUMER_BLOCK) +
 		     (PI_ALIGN_K_DESC_BLK - 1);
 	if (bp->kmalloced)
-		pci_free_consistent(pdev, alloc_size,
-				    bp->kmalloced, bp->kmalloced_dma);
+		dma_free_coherent(bdev, alloc_size,
+				  bp->kmalloced, bp->kmalloced_dma);
+
+err_out_unmap:
+	if (dfx_use_mmio)
+		iounmap(bp->base.mem);
+
 err_out_region:
-	release_region(ioaddr, pdev ? PFI_K_CSR_IO_LEN : PI_ESIC_K_CSR_IO_LEN);
+	if (dfx_use_mmio)
+		release_mem_region(bar_start, bar_len);
+	else
+		release_region(bar_start, bar_len);
+
+err_out_disable:
+	if (dfx_bus_pci)
+		pci_disable_device(to_pci_dev(bdev));
+
 err_out:
 	free_netdev(dev);
 	return err;
 }
 
-static int __devinit dfx_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	return dfx_init_one_pci_or_eisa(pdev, 0);
-}
-
-static int __init dfx_eisa_init(void)
-{
-	int rc = -ENODEV;
-	int i;			/* used in for loops */
-	u16 port;		/* temporary I/O (port) address */
-	u32 slot_id;		/* EISA hardware (slot) ID read from adapter */
-
-	DBG_printk("In dfx_eisa_init...\n");
-
-	/* Scan for FDDI EISA controllers */
-
-	for (i=0; i < DFX_MAX_EISA_SLOTS; i++)		/* only scan for up to 16 EISA slots */
-	{
-		port = (i << 12) + PI_ESIC_K_SLOT_ID;	/* port = I/O address for reading slot ID */
-		slot_id = inl(port);					/* read EISA HW (slot) ID */
-		if ((slot_id & 0xF0FFFFFF) == DEFEA_PRODUCT_ID)
-		{
-			port = (i << 12);					/* recalc base addr */
-
-			if (dfx_init_one_pci_or_eisa(NULL, port) == 0) rc = 0;
-		}
-	}
-	return rc;
-}
 
 /*
  * ================
@@ -545,7 +636,7 @@ static int __init dfx_eisa_init(void)
  * ================
  *   
  * Overview:
- *   Initializes EISA and PCI controller bus-specific logic.
+ *   Initializes the bus-specific controller logic.
  *  
  * Returns:
  *   None
@@ -561,7 +652,7 @@ static int __init dfx_eisa_init(void)
  *   None
  *
  * Assumptions:
- *   dev->base_addr has already been set with the proper
+ *   bp->base has already been set with the proper
  *	 base I/O address for this device.
  *
  * Side Effects:
@@ -572,87 +663,103 @@ static int __init dfx_eisa_init(void)
 
 static void __devinit dfx_bus_init(struct net_device *dev)
 {
-	DFX_board_t *bp = dev->priv;
-	u8			val;	/* used for I/O read/writes */
+	DFX_board_t *bp = netdev_priv(dev);
+	struct device *bdev = bp->bus_dev;
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_eisa = DFX_BUS_EISA(bdev);
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
+	u8 val;
 
 	DBG_printk("In dfx_bus_init...\n");
 
-	/*
-	 * Initialize base I/O address field in bp structure
-	 *
-	 * Note: bp->base_addr is the same as dev->base_addr.
-	 *		 It's useful because often we'll need to read
-	 *		 or write registers where we already have the
-	 *		 bp pointer instead of the dev pointer.  Having
-	 *		 the base address in the bp structure will
-	 *		 save a pointer dereference.
-	 *
-	 *		 IMPORTANT!! This field must be defined before
-	 *		 any of the dfx_port_* inline functions are
-	 *		 called.
-	 */
-
-	bp->base_addr = dev->base_addr;
-
-	/* And a pointer back to the net_device struct */
+	/* Initialize a pointer back to the net_device struct */
 	bp->dev = dev;
 
 	/* Initialize adapter based on bus type */
 
-	if (bp->bus_type == DFX_BUS_TYPE_EISA)
-		{
-		/* Get the interrupt level from the ESIC chip */
-
-		dfx_port_read_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, &val);
-		switch ((val & PI_CONFIG_STAT_0_M_IRQ) >> PI_CONFIG_STAT_0_V_IRQ)
-			{
-			case PI_CONFIG_STAT_0_IRQ_K_9:
-				dev->irq = 9;
-				break;
-
-			case PI_CONFIG_STAT_0_IRQ_K_10:
-				dev->irq = 10;
-				break;
-
-			case PI_CONFIG_STAT_0_IRQ_K_11:
-				dev->irq = 11;
-				break;
-
-			case PI_CONFIG_STAT_0_IRQ_K_15:
-				dev->irq = 15;
-				break;
-			}
-
-		/* Enable access to I/O on the board by writing 0x03 to Function Control Register */
+	if (dfx_bus_tc)
+		dev->irq = to_tc_dev(bdev)->interrupt;
+	if (dfx_bus_eisa) {
+		unsigned long base_addr = to_eisa_device(bdev)->base_addr;
+
+		/* Get the interrupt level from the ESIC chip.  */
+		val = inb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0);
+		val &= PI_CONFIG_STAT_0_M_IRQ;
+		val >>= PI_CONFIG_STAT_0_V_IRQ;
+
+		switch (val) {
+		case PI_CONFIG_STAT_0_IRQ_K_9:
+			dev->irq = 9;
+			break;
 
-		dfx_port_write_byte(bp, PI_ESIC_K_FUNCTION_CNTRL, PI_ESIC_K_FUNCTION_CNTRL_IO_ENB);
+		case PI_CONFIG_STAT_0_IRQ_K_10:
+			dev->irq = 10;
+			break;
 
-		/* Set the I/O decode range of the board */
+		case PI_CONFIG_STAT_0_IRQ_K_11:
+			dev->irq = 11;
+			break;
 
-		val = ((dev->base_addr >> 12) << PI_IO_CMP_V_SLOT);
-		dfx_port_write_byte(bp, PI_ESIC_K_IO_CMP_0_1, val);
-		dfx_port_write_byte(bp, PI_ESIC_K_IO_CMP_1_1, val);
+		case PI_CONFIG_STAT_0_IRQ_K_15:
+			dev->irq = 15;
+			break;
+		}
 
-		/* Enable access to rest of module (including PDQ and packet memory) */
+		/*
+		 * Enable memory decoding (MEMCS0) and/or port decoding
+		 * (IOCS1/IOCS0) as appropriate in Function Control
+		 * Register.  One of the port chip selects seems to be
+		 * used for the Burst Holdoff register, but this bit of
+		 * documentation is missing and as yet it has not been
+		 * determined which of the two.  This is also the reason
+		 * the size of the decoded port range is twice as large
+		 * as one required by the PDQ.
+		 */
 
-		dfx_port_write_byte(bp, PI_ESIC_K_SLOT_CNTRL, PI_SLOT_CNTRL_M_ENB);
+		/* Set the decode range of the board.  */
+		val = ((bp->base.port >> 12) << PI_IO_CMP_V_SLOT);
+		outb(base_addr + PI_ESIC_K_IO_ADD_CMP_0_1, val);
+		outb(base_addr + PI_ESIC_K_IO_ADD_CMP_0_0, 0);
+		outb(base_addr + PI_ESIC_K_IO_ADD_CMP_1_1, val);
+		outb(base_addr + PI_ESIC_K_IO_ADD_CMP_1_0, 0);
+		val = PI_ESIC_K_CSR_IO_LEN - 1;
+		outb(base_addr + PI_ESIC_K_IO_ADD_MASK_0_1, (val >> 8) & 0xff);
+		outb(base_addr + PI_ESIC_K_IO_ADD_MASK_0_0, val & 0xff);
+		outb(base_addr + PI_ESIC_K_IO_ADD_MASK_1_1, (val >> 8) & 0xff);
+		outb(base_addr + PI_ESIC_K_IO_ADD_MASK_1_0, val & 0xff);
+
+		/* Enable the decoders.  */
+		val = PI_FUNCTION_CNTRL_M_IOCS1 | PI_FUNCTION_CNTRL_M_IOCS0;
+		if (dfx_use_mmio)
+			val |= PI_FUNCTION_CNTRL_M_MEMCS0;
+		outb(base_addr + PI_ESIC_K_FUNCTION_CNTRL, val);
 
 		/*
-		 * Map PDQ registers into I/O space.  This is done by clearing a bit
-		 * in Burst Holdoff register.
+		 * Enable access to the rest of the module
+		 * (including PDQ and packet memory).
 		 */
+		val = PI_SLOT_CNTRL_M_ENB;
+		outb(base_addr + PI_ESIC_K_SLOT_CNTRL, val);
 
-		dfx_port_read_byte(bp, PI_ESIC_K_BURST_HOLDOFF, &val);
-		dfx_port_write_byte(bp, PI_ESIC_K_BURST_HOLDOFF, (val & ~PI_BURST_HOLDOFF_M_MEM_MAP));
+		/*
+		 * Map PDQ registers into memory or port space.  This is
+		 * done with a bit in the Burst Holdoff register.
+		 */
+		val = inb(base_addr + PI_DEFEA_K_BURST_HOLDOFF);
+		if (dfx_use_mmio)
+			val |= PI_BURST_HOLDOFF_V_MEM_MAP;
+		else
+			val &= ~PI_BURST_HOLDOFF_V_MEM_MAP;
+		outb(base_addr + PI_DEFEA_K_BURST_HOLDOFF, val);
 
 		/* Enable interrupts at EISA bus interface chip (ESIC) */
-
-		dfx_port_read_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, &val);
-		dfx_port_write_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, (val | PI_CONFIG_STAT_0_M_INT_ENB));
-		}
-	else
-		{
-		struct pci_dev *pdev = bp->pci_dev;
+		val = inb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0);
+		val |= PI_CONFIG_STAT_0_M_INT_ENB;
+		outb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0, val);
+	}
+	if (dfx_bus_pci) {
+		struct pci_dev *pdev = to_pci_dev(bdev);
 
 		/* Get the interrupt level from the PCI Configuration Table */
 
@@ -661,17 +768,70 @@ static void __devinit dfx_bus_init(struc
 		/* Check Latency Timer and set if less than minimal */
 
 		pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &val);
-		if (val < PFI_K_LAT_TIMER_MIN)	/* if less than min, override with default */
-			{
+		if (val < PFI_K_LAT_TIMER_MIN) {
 			val = PFI_K_LAT_TIMER_DEF;
 			pci_write_config_byte(pdev, PCI_LATENCY_TIMER, val);
-			}
+		}
 
 		/* Enable interrupts at PCI bus interface chip (PFI) */
+		val = PFI_MODE_M_PDQ_INT_ENB | PFI_MODE_M_DMA_ENB;
+		dfx_port_write_long(bp, PFI_K_REG_MODE_CTRL, val);
+	}
+}
 
-		dfx_port_write_long(bp, PFI_K_REG_MODE_CTRL, (PFI_MODE_M_PDQ_INT_ENB | PFI_MODE_M_DMA_ENB));
-		}
+/*
+ * ==================
+ * = dfx_bus_uninit =
+ * ==================
+ *   
+ * Overview:
+ *   Uninitializes the bus-specific controller logic.
+ *  
+ * Returns:
+ *   None
+ *       
+ * Arguments:
+ *   dev - pointer to device information
+ *
+ * Functional Description:
+ *   Perform bus-specific logic uninitialization.
+ *
+ * Return Codes:
+ *   None
+ *
+ * Assumptions:
+ *   bp->base has already been set with the proper
+ *	 base I/O address for this device.
+ *
+ * Side Effects:
+ *   Interrupts are disabled at the adapter bus-specific logic.
+ */
+
+static void __devinit dfx_bus_uninit(struct net_device *dev)
+{
+	DFX_board_t *bp = netdev_priv(dev);
+	struct device *bdev = bp->bus_dev;
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_eisa = DFX_BUS_EISA(bdev);
+	u8 val;
+
+	DBG_printk("In dfx_bus_uninit...\n");
+
+	/* Uninitialize adapter based on bus type */
+
+	if (dfx_bus_eisa) {
+		unsigned long base_addr = to_eisa_device(bdev)->base_addr;
+
+		/* Disable interrupts at EISA bus interface chip (ESIC) */
+		val = inb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0);
+		val &= ~PI_CONFIG_STAT_0_M_INT_ENB;
+		outb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0, val);
+	}
+	if (dfx_bus_pci) {
+		/* Disable interrupts at PCI bus interface chip (PFI) */
+		dfx_port_write_long(bp, PFI_K_REG_MODE_CTRL, 0);
 	}
+}
 
 
 /*
@@ -706,18 +866,16 @@ static void __devinit dfx_bus_init(struc
 
 static void __devinit dfx_bus_config_check(DFX_board_t *bp)
 {
+	struct device __unused *bdev = bp->bus_dev;
+	int dfx_bus_eisa = DFX_BUS_EISA(bdev);
 	int	status;				/* return code from adapter port control call */
-	u32	slot_id;			/* EISA-bus hardware id (DEC3001, DEC3002,...) */
 	u32	host_data;			/* LW data returned from port control call */
 
 	DBG_printk("In dfx_bus_config_check...\n");
 
 	/* Configuration check only valid for EISA adapter */
 
-	if (bp->bus_type == DFX_BUS_TYPE_EISA)
-		{
-		dfx_port_read_long(bp, PI_ESIC_K_SLOT_ID, &slot_id);
-
+	if (dfx_bus_eisa) {
 		/*
 		 * First check if revision 2 EISA controller.  Rev. 1 cards used
 		 * PDQ revision B, so no workaround needed in this case.  Rev. 3
@@ -725,14 +883,11 @@ static void __devinit dfx_bus_config_che
 		 * case, either.  Only Rev. 2 cards used either Rev. D or E
 		 * chips, so we must verify the chip revision on Rev. 2 cards.
 		 */
-
-		if (slot_id == DEFEA_PROD_ID_2)
-			{
+		if (to_eisa_device(bdev)->id.driver_data == DEFEA_PROD_ID_2) {
 			/*
-			 * Revision 2 FDDI EISA controller found, so let's check PDQ
-			 * revision of adapter.
+			 * Revision 2 FDDI EISA controller found,
+			 * so let's check PDQ revision of adapter.
 			 */
-
 			status = dfx_hw_port_ctrl_req(bp,
 											PI_PCTRL_M_SUB_CMD,
 											PI_SUB_CMD_K_PDQ_REV_GET,
@@ -806,13 +961,20 @@ static void __devinit dfx_bus_config_che
  */
 
 static int __devinit dfx_driver_init(struct net_device *dev,
-				     const char *print_name)
+				     const char *print_name,
+				     resource_size_t bar_start)
 {
-	DFX_board_t *bp = dev->priv;
+	DFX_board_t *bp = netdev_priv(dev);
+	struct device *bdev = bp->bus_dev;
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_eisa = DFX_BUS_EISA(bdev);
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
 	int alloc_size;			/* total buffer size needed */
 	char *top_v, *curr_v;		/* virtual addrs into memory block */
 	dma_addr_t top_p, curr_p;	/* physical addrs into memory block */
 	u32 data, le32;			/* host data register value */
+	char *board_name = NULL;
 
 	DBG_printk("In dfx_driver_init...\n");
 
@@ -881,20 +1043,18 @@ static int __devinit dfx_driver_init(str
 	 */
 
 	memcpy(dev->dev_addr, bp->factory_mac_addr, FDDI_K_ALEN);
-	if (bp->bus_type == DFX_BUS_TYPE_EISA)
-		printk("%s: DEFEA at I/O addr = 0x%lX, IRQ = %d, "
-		       "Hardware addr = %02X-%02X-%02X-%02X-%02X-%02X\n",
-		       print_name, dev->base_addr, dev->irq,
-		       dev->dev_addr[0], dev->dev_addr[1],
-		       dev->dev_addr[2], dev->dev_addr[3],
-		       dev->dev_addr[4], dev->dev_addr[5]);
-	else
-		printk("%s: DEFPA at I/O addr = 0x%lX, IRQ = %d, "
-		       "Hardware addr = %02X-%02X-%02X-%02X-%02X-%02X\n",
-		       print_name, dev->base_addr, dev->irq,
-		       dev->dev_addr[0], dev->dev_addr[1],
-		       dev->dev_addr[2], dev->dev_addr[3],
-		       dev->dev_addr[4], dev->dev_addr[5]);
+	if (dfx_bus_tc)
+		board_name = "DEFTA";
+	if (dfx_bus_eisa)
+		board_name = "DEFEA";
+	if (dfx_bus_pci)
+		board_name = "DEFPA";
+	pr_info("%s: %s at %saddr = 0x%llx, IRQ = %d, "
+		"Hardware addr = %02X-%02X-%02X-%02X-%02X-%02X\n",
+		print_name, board_name, dfx_use_mmio ? "" : "I/O ",
+		(long long)bar_start, dev->irq,
+		dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+		dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 
 	/*
 	 * Get memory for descriptor block, consumer block, and other buffers
@@ -909,8 +1069,9 @@ static int __devinit dfx_driver_init(str
 #endif
 					sizeof(PI_CONSUMER_BLOCK) +
 					(PI_ALIGN_K_DESC_BLK - 1);
-	bp->kmalloced = top_v = pci_alloc_consistent(bp->pci_dev, alloc_size,
-						     &bp->kmalloced_dma);
+	bp->kmalloced = top_v = dma_alloc_coherent(bp->bus_dev, alloc_size,
+						   &bp->kmalloced_dma,
+						   GFP_ATOMIC);
 	if (top_v == NULL) {
 		printk("%s: Could not allocate memory for host buffers "
 		       "and structures!\n", print_name);
@@ -1220,14 +1381,15 @@ static int dfx_adap_init(DFX_board_t *bp
 
 static int dfx_open(struct net_device *dev)
 {
+	DFX_board_t *bp = netdev_priv(dev);
 	int ret;
-	DFX_board_t	*bp = dev->priv;
 
 	DBG_printk("In dfx_open...\n");
 	
 	/* Register IRQ - support shared interrupts by passing device ptr */
 
-	ret = request_irq(dev->irq, dfx_interrupt, IRQF_SHARED, dev->name, dev);
+	ret = request_irq(dev->irq, dfx_interrupt, IRQF_SHARED, dev->name,
+			  dev);
 	if (ret) {
 		printk(KERN_ERR "%s: Requested IRQ %d is busy\n", dev->name, dev->irq);
 		return ret;
@@ -1310,7 +1472,7 @@ static int dfx_open(struct net_device *d
 
 static int dfx_close(struct net_device *dev)
 {
-	DFX_board_t	*bp = dev->priv;
+	DFX_board_t *bp = netdev_priv(dev);
 
 	DBG_printk("In dfx_close...\n");
 
@@ -1646,7 +1808,7 @@ static void dfx_int_type_0_process(DFX_b
 
 static void dfx_int_common(struct net_device *dev)
 {
-	DFX_board_t 	*bp = dev->priv;
+	DFX_board_t *bp = netdev_priv(dev);
 	PI_UINT32	port_status;		/* Port Status register */
 
 	/* Process xmt interrupts - frequent case, so always call this routine */
@@ -1717,18 +1879,16 @@ static void dfx_int_common(struct net_de
 
 static irqreturn_t dfx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct net_device	*dev = dev_id;
-	DFX_board_t		*bp;	/* private board structure pointer */
-
-	/* Get board pointer only if device structure is valid */
-
-	bp = dev->priv;
-
-	/* See if we're already servicing an interrupt */
+	struct net_device *dev = dev_id;
+	DFX_board_t *bp = netdev_priv(dev);
+	struct device *bdev = bp->bus_dev;
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_eisa = DFX_BUS_EISA(bdev);
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
 
 	/* Service adapter interrupts */
 
-	if (bp->bus_type == DFX_BUS_TYPE_PCI) {
+	if (dfx_bus_pci) {
 		u32 status;
 
 		dfx_port_read_long(bp, PFI_K_REG_STATUS, &status);
@@ -1752,10 +1912,12 @@ static irqreturn_t dfx_interrupt(int irq
 				     PFI_MODE_M_DMA_ENB));
 
 		spin_unlock(&bp->lock);
-	} else {
+	}
+	if (dfx_bus_eisa) {
+		unsigned long base_addr = to_eisa_device(bdev)->base_addr;
 		u8 status;
 
-		dfx_port_read_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, &status);
+		status = inb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0);
 		if (!(status & PI_CONFIG_STAT_0_M_PEND))
 			return IRQ_NONE;
 
@@ -1763,15 +1925,35 @@ static irqreturn_t dfx_interrupt(int irq
 
 		/* Disable interrupts at the ESIC */
 		status &= ~PI_CONFIG_STAT_0_M_INT_ENB;
-		dfx_port_write_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, status);
+		outb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0, status);
 
 		/* Call interrupt service routine for this adapter */
 		dfx_int_common(dev);
 
 		/* Reenable interrupts at the ESIC */
-		dfx_port_read_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, &status);
+		status = inb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0);
 		status |= PI_CONFIG_STAT_0_M_INT_ENB;
-		dfx_port_write_byte(bp, PI_ESIC_K_IO_CONFIG_STAT_0, status);
+		outb(base_addr + PI_ESIC_K_IO_CONFIG_STAT_0, status);
+
+		spin_unlock(&bp->lock);
+	}
+	if (dfx_bus_tc) {
+		u32 status;
+
+		dfx_port_read_long(bp, PI_PDQ_K_REG_PORT_STATUS, &status);
+		if (!(status & (PI_PSTATUS_M_RCV_DATA_PENDING |
+				PI_PSTATUS_M_XMT_DATA_PENDING |
+				PI_PSTATUS_M_SMT_HOST_PENDING |
+				PI_PSTATUS_M_UNSOL_PENDING |
+				PI_PSTATUS_M_CMD_RSP_PENDING |
+				PI_PSTATUS_M_CMD_REQ_PENDING |
+				PI_PSTATUS_M_TYPE_0_PENDING)))
+			return IRQ_NONE;
+
+		spin_lock(&bp->lock);
+
+		/* Call interrupt service routine for this adapter */
+		dfx_int_common(dev);
 
 		spin_unlock(&bp->lock);
 	}
@@ -1825,7 +2007,7 @@ static irqreturn_t dfx_interrupt(int irq
 
 static struct net_device_stats *dfx_ctl_get_stats(struct net_device *dev)
 	{
-	DFX_board_t	*bp = dev->priv;
+	DFX_board_t *bp = netdev_priv(dev);
 
 	/* Fill the bp->stats structure with driver-maintained counters */
 
@@ -2011,8 +2193,8 @@ static struct net_device_stats *dfx_ctl_
  */
 
 static void dfx_ctl_set_multicast_list(struct net_device *dev)
-	{
-	DFX_board_t			*bp = dev->priv;
+{
+	DFX_board_t *bp = netdev_priv(dev);
 	int					i;			/* used as index in for loop */
 	struct dev_mc_list	*dmi;		/* ptr to multicast addr entry */
 
@@ -2126,8 +2308,8 @@ static void dfx_ctl_set_multicast_list(s
 
 static int dfx_ctl_set_mac_address(struct net_device *dev, void *addr)
 	{
-	DFX_board_t		*bp = dev->priv;
 	struct sockaddr	*p_sockaddr = (struct sockaddr *)addr;
+	DFX_board_t *bp = netdev_priv(dev);
 
 	/* Copy unicast address to driver-maintained structs and update count */
 
@@ -2766,9 +2948,9 @@ static int dfx_rcv_init(DFX_board_t *bp,
 			 
 			my_skb_align(newskb, 128);
 			bp->descr_block_virt->rcv_data[i + j].long_1 =
-				(u32)pci_map_single(bp->pci_dev, newskb->data,
+				(u32)dma_map_single(bp->bus_dev, newskb->data,
 						    NEW_SKB_SIZE,
-						    PCI_DMA_FROMDEVICE);
+						    DMA_FROM_DEVICE);
 			/*
 			 * p_rcv_buff_va is only used inside the
 			 * kernel so we put the skb pointer here.
@@ -2882,17 +3064,17 @@ static void dfx_rcv_queue_process(
 						
 						my_skb_align(newskb, 128);
 						skb = (struct sk_buff *)bp->p_rcv_buff_va[entry];
-						pci_unmap_single(bp->pci_dev,
+						dma_unmap_single(bp->bus_dev,
 							bp->descr_block_virt->rcv_data[entry].long_1,
 							NEW_SKB_SIZE,
-							PCI_DMA_FROMDEVICE);
+							DMA_FROM_DEVICE);
 						skb_reserve(skb, RCV_BUFF_K_PADDING);
 						bp->p_rcv_buff_va[entry] = (char *)newskb;
 						bp->descr_block_virt->rcv_data[entry].long_1 =
-							(u32)pci_map_single(bp->pci_dev,
+							(u32)dma_map_single(bp->bus_dev,
 								newskb->data,
 								NEW_SKB_SIZE,
-								PCI_DMA_FROMDEVICE);
+								DMA_FROM_DEVICE);
 					} else
 						skb = NULL;
 				} else
@@ -3012,7 +3194,7 @@ static int dfx_xmt_queue_pkt(
 	)
 
 	{
-	DFX_board_t		*bp = dev->priv;
+	DFX_board_t		*bp = netdev_priv(dev);
 	u8			prod;				/* local transmit producer index */
 	PI_XMT_DESCR		*p_xmt_descr;		/* ptr to transmit descriptor block entry */
 	XMT_DRIVER_DESCR	*p_xmt_drv_descr;	/* ptr to transmit driver descriptor */
@@ -3118,8 +3300,8 @@ static int dfx_xmt_queue_pkt(
 	 */
 
 	p_xmt_descr->long_0	= (u32) (PI_XMT_DESCR_M_SOP | PI_XMT_DESCR_M_EOP | ((skb->len) << PI_XMT_DESCR_V_SEG_LEN));
-	p_xmt_descr->long_1 = (u32)pci_map_single(bp->pci_dev, skb->data,
-						  skb->len, PCI_DMA_TODEVICE);
+	p_xmt_descr->long_1 = (u32)dma_map_single(bp->bus_dev, skb->data,
+						  skb->len, DMA_TO_DEVICE);
 
 	/*
 	 * Verify that descriptor is actually available
@@ -3222,10 +3404,10 @@ static int dfx_xmt_done(DFX_board_t *bp)
 
 		/* Return skb to operating system */
 		comp = bp->rcv_xmt_reg.index.xmt_comp;
-		pci_unmap_single(bp->pci_dev,
+		dma_unmap_single(bp->bus_dev,
 				 bp->descr_block_virt->xmt_data[comp].long_1,
 				 p_xmt_drv_descr->p_skb->len,
-				 PCI_DMA_TODEVICE);
+				 DMA_TO_DEVICE);
 		dev_kfree_skb_irq(p_xmt_drv_descr->p_skb);
 
 		/*
@@ -3346,10 +3528,10 @@ static void dfx_xmt_flush( DFX_board_t *
 
 		/* Return skb to operating system */
 		comp = bp->rcv_xmt_reg.index.xmt_comp;
-		pci_unmap_single(bp->pci_dev,
+		dma_unmap_single(bp->bus_dev,
 				 bp->descr_block_virt->xmt_data[comp].long_1,
 				 p_xmt_drv_descr->p_skb->len,
-				 PCI_DMA_TODEVICE);
+				 DMA_TO_DEVICE);
 		dev_kfree_skb(p_xmt_drv_descr->p_skb);
 
 		/* Increment transmit error counter */
@@ -3377,13 +3559,44 @@ static void dfx_xmt_flush( DFX_board_t *
 	bp->cons_block_virt->xmt_rcv_data = prod_cons;
 	}
 
-static void __devexit dfx_remove_one_pci_or_eisa(struct pci_dev *pdev, struct net_device *dev)
+/*
+ * ==================
+ * = dfx_unregister =
+ * ==================
+ *   
+ * Overview:
+ *   Shuts down an FDDI controller
+ *  
+ * Returns:
+ *   Condition code
+ *       
+ * Arguments:
+ *   bdev - pointer to device information
+ *
+ * Functional Description:
+ *
+ * Return Codes:
+ *   None
+ *
+ * Assumptions:
+ *   It compiles so it should work :-( (PCI cards do :-)
+ *
+ * Side Effects:
+ *   Device structures for FDDI adapters (fddi0, fddi1, etc) are
+ *   freed.
+ */
+static void __devexit dfx_unregister(struct device *bdev)
 {
-	DFX_board_t	*bp = dev->priv;
+	struct net_device *dev = dev_get_drvdata(bdev);
+	DFX_board_t *bp = netdev_priv(dev);
+	int dfx_bus_pci = DFX_BUS_PCI(bdev);
+	int dfx_bus_tc = DFX_BUS_TC(bdev);
+	int dfx_use_mmio = DFX_MMIO || dfx_bus_tc;
+	resource_size_t bar_start = 0;		/* pointer to port */
+	resource_size_t bar_len = 0;		/* resource length */
 	int		alloc_size;		/* total buffer size used */
 
 	unregister_netdev(dev);
-	release_region(dev->base_addr,  pdev ? PFI_K_CSR_IO_LEN : PI_ESIC_K_CSR_IO_LEN );
 
 	alloc_size = sizeof(PI_DESCR_BLOCK) +
 		     PI_CMD_REQ_K_SIZE_MAX + PI_CMD_RSP_K_SIZE_MAX +
@@ -3393,78 +3606,141 @@ static void __devexit dfx_remove_one_pci
 		     sizeof(PI_CONSUMER_BLOCK) +
 		     (PI_ALIGN_K_DESC_BLK - 1);
 	if (bp->kmalloced)
-		pci_free_consistent(pdev, alloc_size, bp->kmalloced,
-				    bp->kmalloced_dma);
+		dma_free_coherent(bdev, alloc_size,
+				  bp->kmalloced, bp->kmalloced_dma);
+
+	dfx_bus_uninit(dev);
+
+	dfx_get_bars(bdev, &bar_start, &bar_len);
+	if (dfx_use_mmio) {
+		iounmap(bp->base.mem);
+		release_mem_region(bar_start, bar_len);
+	} else
+		release_region(bar_start, bar_len);
+
+	if (dfx_bus_pci)
+		pci_disable_device(to_pci_dev(bdev));
+
 	free_netdev(dev);
 }
 
-static void __devexit dfx_remove_one (struct pci_dev *pdev)
+
+static int __devinit __unused dfx_dev_register(struct device *);
+static int __devexit __unused dfx_dev_unregister(struct device *);
+
+#ifdef CONFIG_PCI
+static int __devinit dfx_pci_register(struct pci_dev *,
+				      const struct pci_device_id *);
+static void __devexit dfx_pci_unregister(struct pci_dev *);
+
+static struct pci_device_id dfx_pci_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_FDDI) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dfx_pci_table);
+
+static struct pci_driver dfx_pci_driver = {
+	.name		= "defxx",
+	.id_table	= dfx_pci_table,
+	.probe		= dfx_pci_register,
+	.remove		= __devexit_p(dfx_pci_unregister),
+};
+
+static __devinit int dfx_pci_register(struct pci_dev *pdev,
+				      const struct pci_device_id *ent)
 {
-	struct net_device *dev = pci_get_drvdata(pdev);
+	return dfx_register(&pdev->dev);
+}
 
-	dfx_remove_one_pci_or_eisa(pdev, dev);
-	pci_set_drvdata(pdev, NULL);
+static void __devexit dfx_pci_unregister(struct pci_dev *pdev)
+{
+	dfx_unregister(&pdev->dev);
 }
+#endif /* CONFIG_PCI */
 
-static struct pci_device_id dfx_pci_tbl[] = {
-	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_FDDI, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, }
+#ifdef CONFIG_EISA
+static struct eisa_device_id dfx_eisa_table[] = {
+        { "DEC3001", DEFEA_PROD_ID_1 },
+        { "DEC3002", DEFEA_PROD_ID_2 },
+        { "DEC3003", DEFEA_PROD_ID_3 },
+        { "DEC3004", DEFEA_PROD_ID_4 },
+        { }
 };
-MODULE_DEVICE_TABLE(pci, dfx_pci_tbl);
+MODULE_DEVICE_TABLE(eisa, dfx_eisa_table);
 
-static struct pci_driver dfx_driver = {
-	.name		= "defxx",
-	.probe		= dfx_init_one,
-	.remove		= __devexit_p(dfx_remove_one),
-	.id_table	= dfx_pci_tbl,
+static struct eisa_driver dfx_eisa_driver = {
+	.id_table	= dfx_eisa_table,
+	.driver		= {
+		.name	= "defxx",
+		.bus	= &eisa_bus_type,
+		.probe	= dfx_dev_register,
+		.remove	= __devexit_p(dfx_dev_unregister),
+	},
 };
+#endif /* CONFIG_EISA */
 
-static int dfx_have_pci;
-static int dfx_have_eisa;
+#ifdef CONFIG_TC
+static struct tc_device_id const dfx_tc_table[] = {
+	{ "DEC     ", "PMAF-FA " },
+	{ "DEC     ", "PMAF-FD " },
+	{ "DEC     ", "PMAF-FS " },
+	{ "DEC     ", "PMAF-FU " },
+	{ }
+};
+MODULE_DEVICE_TABLE(tc, dfx_tc_table);
 
+static struct tc_driver dfx_tc_driver = {
+	.id_table	= dfx_tc_table,
+	.driver		= {
+		.name	= "defxx",
+		.bus	= &tc_bus_type,
+		.probe	= dfx_dev_register,
+		.remove	= __devexit_p(dfx_dev_unregister),
+	},
+};
+#endif /* CONFIG_TC */
 
-static void __exit dfx_eisa_cleanup(void)
+static int __devinit __unused dfx_dev_register(struct device *dev)
 {
-	struct net_device *dev = root_dfx_eisa_dev;
+	int status;
 
-	while (dev)
-	{
-		struct net_device *tmp;
-		DFX_board_t *bp;
-
-		bp = (DFX_board_t*)dev->priv;
-		tmp = bp->next;
-		dfx_remove_one_pci_or_eisa(NULL, dev);
-		dev = tmp;
-	}
+	status = dfx_register(dev);
+	if (!status)
+		get_device(dev);
+	return status;
 }
 
-static int __init dfx_init(void)
+static int __devexit __unused dfx_dev_unregister(struct device *dev)
 {
-	int rc_pci, rc_eisa;
+	put_device(dev);
+	dfx_unregister(dev);
+	return 0;
+}
 
-	rc_pci = pci_module_init(&dfx_driver);
-	if (rc_pci >= 0) dfx_have_pci = 1;
-	
-	rc_eisa = dfx_eisa_init();
-	if (rc_eisa >= 0) dfx_have_eisa = 1;
 
-	return ((rc_eisa < 0) ? 0 : rc_eisa)  + ((rc_pci < 0) ? 0 : rc_pci); 
+static int __devinit dfx_init(void)
+{
+	int status;
+
+	status = pci_register_driver(&dfx_pci_driver);
+	if (!status)
+		status = eisa_driver_register(&dfx_eisa_driver);
+	if (!status)
+		status = tc_register_driver(&dfx_tc_driver);
+	return status;
 }
 
-static void __exit dfx_cleanup(void)
+static void __devexit dfx_cleanup(void)
 {
-	if (dfx_have_pci)
-		pci_unregister_driver(&dfx_driver);
-	if (dfx_have_eisa)
-		dfx_eisa_cleanup();
-		
+	tc_unregister_driver(&dfx_tc_driver);
+	eisa_driver_unregister(&dfx_eisa_driver);
+	pci_unregister_driver(&dfx_pci_driver);
 }	
 
 module_init(dfx_init);
 module_exit(dfx_cleanup);
 MODULE_AUTHOR("Lawrence V. Stefani");
-MODULE_DESCRIPTION("DEC FDDIcontroller EISA/PCI (DEFEA/DEFPA) driver "
+MODULE_DESCRIPTION("DEC FDDIcontroller TC/EISA/PCI (DEFTA/DEFEA/DEFPA) driver "
 		   DRV_VERSION " " DRV_RELDATE);
 MODULE_LICENSE("GPL");
 
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/net/defxx.h linux-mips-2.6.18-20060920/drivers/net/defxx.h
--- linux-mips-2.6.18-20060920.macro/drivers/net/defxx.h	2006-10-23 00:27:28.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/net/defxx.h	2006-12-16 04:02:34.000000000 +0000
@@ -26,6 +26,7 @@
  *		12-Sep-96	LVS		Removed packet request header pointers.
  *		04 Aug 2003	macro		Converted to the DMA API.
  *		23 Oct 2006	macro		Big-endian host support.
+ *		14 Dec 2006	macro		TURBOchannel support.
  */
 
 #ifndef _DEFXX_H_
@@ -1471,9 +1472,17 @@ typedef union
 
 #endif /* __BIG_ENDIAN */
 
+/* Define TC PDQ CSR offset and length */
+
+#define PI_TC_K_CSR_OFFSET		0x100000
+#define PI_TC_K_CSR_LEN			0x40		/* 64 bytes */
+
 /* Define EISA controller register offsets */
 
-#define PI_ESIC_K_BURST_HOLDOFF		0x040
+#define PI_ESIC_K_CSR_IO_LEN		0x80		/* 128 bytes */
+
+#define PI_DEFEA_K_BURST_HOLDOFF	0x040
+
 #define PI_ESIC_K_SLOT_ID            	0xC80
 #define PI_ESIC_K_SLOT_CNTRL		0xC84
 #define PI_ESIC_K_MEM_ADD_CMP_0     	0xC85
@@ -1488,14 +1497,14 @@ typedef union
 #define PI_ESIC_K_MEM_ADD_LO_CMP_0  	0xC8E
 #define PI_ESIC_K_MEM_ADD_LO_CMP_1  	0xC8F
 #define PI_ESIC_K_MEM_ADD_LO_CMP_2  	0xC90
-#define PI_ESIC_K_IO_CMP_0_0		0xC91
-#define PI_ESIC_K_IO_CMP_0_1		0xC92
-#define PI_ESIC_K_IO_CMP_1_0		0xC93
-#define PI_ESIC_K_IO_CMP_1_1		0xC94
-#define PI_ESIC_K_IO_CMP_2_0		0xC95
-#define PI_ESIC_K_IO_CMP_2_1		0xC96
-#define PI_ESIC_K_IO_CMP_3_0		0xC97
-#define PI_ESIC_K_IO_CMP_3_1		0xC98
+#define PI_ESIC_K_IO_ADD_CMP_0_0	0xC91
+#define PI_ESIC_K_IO_ADD_CMP_0_1	0xC92
+#define PI_ESIC_K_IO_ADD_CMP_1_0	0xC93
+#define PI_ESIC_K_IO_ADD_CMP_1_1	0xC94
+#define PI_ESIC_K_IO_ADD_CMP_2_0	0xC95
+#define PI_ESIC_K_IO_ADD_CMP_2_1	0xC96
+#define PI_ESIC_K_IO_ADD_CMP_3_0	0xC97
+#define PI_ESIC_K_IO_ADD_CMP_3_1	0xC98
 #define PI_ESIC_K_IO_ADD_MASK_0_0    	0xC99
 #define PI_ESIC_K_IO_ADD_MASK_0_1    	0xC9A
 #define PI_ESIC_K_IO_ADD_MASK_1_0    	0xC9B
@@ -1518,11 +1527,16 @@ typedef union
 #define PI_ESIC_K_INPUT_PORT         	0xCAC
 #define PI_ESIC_K_OUTPUT_PORT        	0xCAD
 #define PI_ESIC_K_FUNCTION_CNTRL	0xCAE
-#define PI_ESIC_K_CSR_IO_LEN		PI_ESIC_K_FUNCTION_CNTRL+1	/* always last reg + 1 */
 
-/* Define the value all drivers must write to the function control register. */
+/* Define the bits in the function control register. */
 
-#define PI_ESIC_K_FUNCTION_CNTRL_IO_ENB	0x03
+#define PI_FUNCTION_CNTRL_M_IOCS0	0x01
+#define PI_FUNCTION_CNTRL_M_IOCS1	0x02
+#define PI_FUNCTION_CNTRL_M_IOCS2	0x04
+#define PI_FUNCTION_CNTRL_M_IOCS3	0x08
+#define PI_FUNCTION_CNTRL_M_MEMCS0	0x10
+#define PI_FUNCTION_CNTRL_M_MEMCS1	0x20
+#define PI_FUNCTION_CNTRL_M_DMA		0x80
 
 /* Define the bits in the slot control register. */
 
@@ -1540,6 +1554,10 @@ typedef union
 #define PI_BURST_HOLDOFF_V_RESERVED	1
 #define PI_BURST_HOLDOFF_V_MEM_MAP	0
 
+/* Define the implicit mask of the Memory Address Mask Register.  */
+
+#define PI_MEM_ADD_MASK_M		0x3ff
+
 /*
  * Define the fields in the IO Compare registers.
  * The driver must initialize the slot field with the slot ID shifted by the
@@ -1577,6 +1595,7 @@ typedef union
 #define DEFEA_PROD_ID_1		0x0130A310		/* DEC product 300, rev 1	*/
 #define DEFEA_PROD_ID_2		0x0230A310		/* DEC product 300, rev 2	*/
 #define DEFEA_PROD_ID_3		0x0330A310		/* DEC product 300, rev 3	*/
+#define DEFEA_PROD_ID_4		0x0430A310		/* DEC product 300, rev 4	*/
 
 /**********************************************/
 /* Digital PFI Specification v1.0 Definitions */
@@ -1633,12 +1652,6 @@ typedef union
 #define PFI_STATUS_V_FIFO_EMPTY		 1
 #define PFI_STATUS_V_DMA_IN_PROGRESS 0
 
-#define DFX_MAX_EISA_SLOTS		16			/* maximum number of EISA slots to scan */
-#define DFX_MAX_NUM_BOARDS		8			/* maximum number of adapters supported */
-
-#define DFX_BUS_TYPE_PCI		0			/* type code for DEC FDDIcontroller/PCI */
-#define DFX_BUS_TYPE_EISA		1			/* type code for DEC FDDIcontroller/EISA */
-
 #define DFX_FC_PRH2_PRH1_PRH0		0x54003820	/* Packet Request Header bytes + FC */
 #define DFX_PRH0_BYTE			0x20		/* Packet Request Header byte 0 */
 #define DFX_PRH1_BYTE			0x38		/* Packet Request Header byte 1 */
@@ -1756,10 +1769,11 @@ typedef struct DFX_board_tag
 	/* Store device, bus-specific, and parameter information for this adapter */
 
 	struct net_device		*dev;						/* pointer to device structure */
-	struct net_device		*next;
-	u32				bus_type;					/* bus type (0 == PCI, 1 == EISA) */
-	u16				base_addr;					/* base I/O address (same as dev->base_addr) */
-	struct pci_dev *		pci_dev;
+	union {
+		void __iomem *mem;
+		int port;
+	} base;										/* base address */
+	struct device			*bus_dev;
 	u32				full_duplex_enb;				/* FDDI Full Duplex enable (1 == on, 2 == off) */
 	u32				req_ttrt;					/* requested TTRT value (in 80ns units) */
 	u32				burst_size;					/* adapter burst size (enumerated) */
