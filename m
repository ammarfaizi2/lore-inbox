Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRBPWWp>; Fri, 16 Feb 2001 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRBPWW1>; Fri, 16 Feb 2001 17:22:27 -0500
Received: from cs.columbia.edu ([128.59.16.20]:10491 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131346AbRBPWWN>;
	Fri, 16 Feb 2001 17:22:13 -0500
Date: Fri, 16 Feb 2001 14:22:07 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] starfire patch for 2.4.1-ac15
Message-ID: <Pine.LNX.4.30.0102161416240.23999-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This patch makes the 2.4 starfire driver essentially identical to the
version you added to 2.2.19pre. In addition, it also includes Manfred
Spraul's fixes (for problems which, although real, are very unlikely to
matter in real life).

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

----------------------------------------
--- /mnt/3/linux-2.4-ac/MAINTAINERS	Thu Feb 15 17:21:38 2001
+++ linux-2.4/MAINTAINERS	Wed Feb  7 17:38:50 2001
@@ -1200,6 +1166,11 @@
 W:	http://www.stallion.com
 S:	Supported
 
+STARFIRE/DURALAN NETWORK DRIVER
+P:	Ion Badulescu
+M:	ionut@cs.columbia.edu
+S:	Maintained
+
 STARMODE RADIO IP (STRIP) PROTOCOL DRIVER
 W:	http://mosquitonet.Stanford.EDU/strip.html
 S:	Unsupported ?
--- /mnt/3/linux-2.4-ac/Documentation/Configure.help	Thu Feb 15 17:21:37 2001
+++ linux-2.4/Documentation/Configure.help	Thu Feb 15 16:57:01 2001
@@ -8754,7 +8491,7 @@
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read Documentation/modules.txt. This is recommended.
-  The module will be called starfile.o.
+  The module will be called starfire.o.
   
 Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support
 CONFIG_ACENIC
--- /mnt/3/linux-2.4-ac/drivers/net/starfire.c	Thu Feb 15 17:22:15 2001
+++ linux-2.4/drivers/net/starfire.c	Fri Feb 16 12:54:32 2001
@@ -20,7 +20,7 @@
 	-----------------------------------------------------------
 
 	Linux kernel-specific changes:
-	
+
 	LK1.1.1 (jgarzik):
 	- Use PCI driver interface
 	- Fix MOD_xxx races
@@ -31,9 +31,30 @@
 
 	LK1.1.3 (Andrew Morton)
 	- Timer cleanups
-	
+
 	LK1.1.4 (jgarzik):
 	- Merge Becker version 1.03
+
+	LK1.2.1 (Ion Badulescu <ionut@cs.columbia.edu>)
+	- Support hardware Rx/Tx checksumming
+	- Use the GFP firmware taken from Adaptec's Netware driver
+
+	LK1.2.2 (Ion Badulescu)
+	- Backported to 2.2.x
+
+	LK1.2.3 (Ion Badulescu)
+	- Fix the flaky mdio interface
+	- More compat clean-ups
+
+	LK1.2.4 (Ion Badulescu)
+	- More 2.2.x initialization fixes
+
+	LK1.2.5 (Ion Badulescu)
+	- Several fixes from Manfred Spraul
+
+TODO:
+	- implement tx_timeout() properly
+	- support ethtool
 */
 
 /* These identify the driver base version and may not be removed. */
@@ -43,11 +64,32 @@
 " Updates and info at http://www.scyld.com/network/starfire.html\n";
 
 static const char version3[] =
-" (unofficial 2.4.x kernel port, version 1.1.4, August 10, 2000)\n";
+" (unofficial 2.4.x kernel port, version 1.2.5, February 15, 2001)\n";
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 
+/*
+ * Adaptec's license for their Novell drivers (which is where I got the
+ * firmware files) does not allow to redistribute them. Thus, we can't
+ * include them with this driver.
+ *
+ * However, an end-user is allowed to download and use them, after
+ * converting them to C header files using starfire_firmware.pl.
+ * Once that's done, the #undef must be changed into a #define
+ * for this driver to really use the firmware. Note that Rx/Tx
+ * hardware TCP checksumming is not possible without the firmware.
+ *
+ * I'm currently [Feb 2001] talking to Adaptec about this redistribution
+ * issue. Stay tuned...
+ */
+#undef HAS_FIRMWARE
+/*
+ * The current frame processor firmware fails to checksum a fragment
+ * of length 1. If and when this is fixed, the #define below can be removed.
+ */
+#define HAS_BROKEN_FIRMWARE
+
 /* Used for tuning interrupt latency vs. overhead. */
 static int interrupt_mitigation = 0x0;
 
@@ -55,12 +97,27 @@
 static int max_interrupt_work = 20;
 static int mtu = 0;
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
-   The Starfire has a 512 element hash table based on the Ethernet CRC.  */
+   The Starfire has a 512 element hash table based on the Ethernet CRC. */
 static int multicast_filter_limit = 32;
 
-/* Set the copy breakpoint for the copy-only-tiny-frames scheme.
-   Setting to > 1518 effectively disables this feature. */
+#define PKT_BUF_SZ	1536		/* Size of each temporary Rx buffer.*/
+/*
+ * Set the copy breakpoint for the copy-only-tiny-frames scheme.
+ * Setting to > 1518 effectively disables this feature.
+ *
+ * NOTE:
+ * The ia64 doesn't allow for unaligned loads even of integers being
+ * misaligned on a 2 byte boundary. Thus always force copying of
+ * packets as the starfire doesn't allow for misaligned DMAs ;-(
+ * 23/10/2000 - Jes
+ *
+ * Neither does the Alpha. -Ion
+ */
+#if defined(__ia64__) || defined(__alpha__)
+static int rx_copybreak = PKT_BUF_SZ;
+#else
 static int rx_copybreak = 0;
+#endif
 
 /* Used to pass the media type, etc.
    Both 'options[]' and 'full_duplex[]' exist for driver interoperability.
@@ -84,21 +141,9 @@
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT  (2*HZ)
+#define TX_TIMEOUT	(2*HZ)
 
-#define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
-
-/*
- * The ia64 doesn't allow for unaligned loads even of integers being
- * misaligned on a 2 byte boundary. Thus always force copying of
- * packets as the starfire doesn't allow for misaligned DMAs ;-(
- * 23/10/2000 - Jes
- */
-#ifdef __ia64__
-#define PKT_SHOULD_COPY(pkt_len)	1
-#else
-#define PKT_SHOULD_COPY(pkt_len)	(pkt_len < rx_copybreak)
-#endif
+#define skb_first_frag_len(skb)	(skb->len)
 
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
@@ -106,6 +151,7 @@
 #error You must compile this driver with "-O".
 #endif
 
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -119,16 +165,22 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 
+#ifdef HAS_FIRMWARE
+#include "starfire_firmware.h"
+#endif /* HAS_FIRMWARE */
+
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(mtu, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
+MODULE_PARM(interrupt_mitigation, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 
@@ -161,8 +213,9 @@
 See the Adaptec manual for the many possible structures, and options for
 each structure.  There are far too many to document here.
 
-For transmit this driver uses type 1 transmit descriptors, and relies on
-automatic minimum-length padding.  It does not use the completion queue
+For transmit this driver uses type 0/1 transmit descriptors (depending
+on the presence of the zerocopy patches), and relies on automatic
+minimum-length padding.  It does not use the completion queue
 consumer index, but instead checks for non-zero status entries.
 
 For receive this driver uses type 0 receive descriptors.  The driver
@@ -179,8 +232,9 @@
 A notable aspect of operation is that unaligned buffers are not permitted by
 the Starfire hardware.  The IP header at offset 14 in an ethernet frame thus
 isn't longword aligned, which may cause problems on some machine
-e.g. Alphas.  Copied frames are put into the skbuff at an offset of "+2",
-16-byte aligning the IP header.
+e.g. Alphas and IA64. For these architectures, the driver is forced to copy
+the frame into a new skbuff unconditionally. Copied frames are put into the
+skbuff at an offset of "+2", thus 16-byte aligning the IP header.
 
 IIId. Synchronization
 
@@ -213,6 +267,240 @@
 
 
 
+/* 2.2.x compatibility code */
+#if LINUX_VERSION_CODE < 0x20300
+#include <linux/kcomp.h>
+
+static LIST_HEAD(pci_drivers);
+
+struct pci_driver_mapping {
+	struct pci_dev *dev;
+	struct pci_driver *drv;
+	void *driver_data;
+};
+
+struct pci_device_id {
+	unsigned int vendor, device;
+	unsigned int subvendor, subdevice;
+	unsigned int class, class_mask;
+	unsigned long driver_data;
+};
+
+struct pci_driver {
+	struct list_head node;
+	struct pci_dev *dev;
+	char *name;
+	const struct pci_device_id *id_table;	/* NULL if wants all devices */
+	int (*probe)(struct pci_dev *dev, const struct pci_device_id *id);		/* New device inserted */
+	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
+	void (*suspend)(struct pci_dev *dev);	/* Device suspended */
+	void (*resume)(struct pci_dev *dev);	/* Device woken up */
+};
+
+#define PCI_MAX_MAPPINGS 16
+static struct pci_driver_mapping drvmap [PCI_MAX_MAPPINGS] = { { NULL, } , };
+
+#define __devinit			__init
+#define __devinitdata			__initdata
+#define __devexit
+#define MODULE_DEVICE_TABLE(foo,bar)
+#define SET_MODULE_OWNER(dev)
+#define COMPAT_MOD_INC_USE_COUNT	MOD_INC_USE_COUNT
+#define COMPAT_MOD_DEC_USE_COUNT	MOD_DEC_USE_COUNT
+#define PCI_ANY_ID (~0)
+#define IORESOURCE_MEM			2
+#define PCI_DMA_FROMDEVICE		0
+#define PCI_DMA_TODEVICE		0
+
+#define request_mem_region(addr, size, name)	((void *)1)
+#define release_mem_region(addr, size)
+#define del_timer_sync(timer)	del_timer(timer)
+
+static inline void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+					 dma_addr_t *dma_handle)
+{
+	void *virt_ptr;
+
+	virt_ptr = kmalloc(size, GFP_KERNEL);
+	*dma_handle = virt_to_bus(virt_ptr);
+	return virt_ptr;
+}
+#define pci_free_consistent(cookie, size, ptr, dma_ptr)	kfree(ptr)
+#define pci_map_single(cookie, address, size, dir)	virt_to_bus(address)
+#define pci_unmap_single(cookie, address, size, dir)
+#define pci_dma_sync_single(cookie, address, size, dir)
+#undef	pci_resource_flags
+#define pci_resource_flags(dev, i) \
+  ((dev->base_address[i] & IORESOURCE_IO) ? IORESOURCE_IO : IORESOURCE_MEM)
+
+void * pci_get_drvdata (struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < PCI_MAX_MAPPINGS; i++)
+		if (drvmap[i].dev == dev)
+			return drvmap[i].driver_data;
+
+	return NULL;
+}
+
+void pci_set_drvdata (struct pci_dev *dev, void *driver_data)
+{
+	int i;
+
+	for (i = 0; i < PCI_MAX_MAPPINGS; i++)
+		if (drvmap[i].dev == dev) {
+			drvmap[i].driver_data = driver_data;
+			return;
+		}
+}
+
+const struct pci_device_id *
+pci_compat_match_device(const struct pci_device_id *ids, struct pci_dev *dev)
+{
+	u16 subsystem_vendor, subsystem_device;
+
+	pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vendor);
+	pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &subsystem_device);
+
+	while (ids->vendor || ids->subvendor || ids->class_mask) {
+		if ((ids->vendor == PCI_ANY_ID || ids->vendor == dev->vendor) &&
+			(ids->device == PCI_ANY_ID || ids->device == dev->device) &&
+			(ids->subvendor == PCI_ANY_ID || ids->subvendor == subsystem_vendor) &&
+			(ids->subdevice == PCI_ANY_ID || ids->subdevice == subsystem_device) &&
+			!((ids->class ^ dev->class) & ids->class_mask))
+			return ids;
+		ids++;
+	}
+	return NULL;
+}
+
+static int
+pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
+{
+	const struct pci_device_id *id;
+	int found, i;
+
+	if (drv->id_table) {
+		id = pci_compat_match_device(drv->id_table, dev);
+		if (!id)
+			return 0;
+	} else
+		id = NULL;
+
+	found = 0;
+	for (i = 0; i < PCI_MAX_MAPPINGS; i++)
+		if (!drvmap[i].dev) {
+			drvmap[i].dev = dev;
+			drvmap[i].drv = drv;
+			found = 1;
+			break;
+		}
+
+	if (!found)
+		return 0;
+
+	if (drv->probe(dev, id) >= 0)
+		return 1;
+
+	/* clean up */
+	drvmap[i].dev = NULL;
+	return 0;
+}
+
+int
+pci_register_driver(struct pci_driver *drv)
+{
+	struct pci_dev *dev;
+	int count = 0, found, i;
+#ifdef CONFIG_PCI
+	list_add_tail(&drv->node, &pci_drivers);
+	for (dev = pci_devices; dev; dev = dev->next) {
+		found = 0;
+		for (i = 0; i < PCI_MAX_MAPPINGS && !found; i++)
+			if (drvmap[i].dev == dev)
+				found = 1;
+		if (!found)
+			count += pci_announce_device(drv, dev);
+	}
+#endif
+	return count;
+}
+
+void
+pci_unregister_driver(struct pci_driver *drv)
+{
+	struct pci_dev *dev;
+	int i, found;
+#ifdef CONFIG_PCI
+	list_del(&drv->node);
+	for (dev = pci_devices; dev; dev = dev->next) {
+		found = 0;
+		for (i = 0; i < PCI_MAX_MAPPINGS; i++)
+			if (drvmap[i].dev == dev) {
+				found = 1;
+				break;
+			}
+		if (found) {
+			if (drv->remove)
+				drv->remove(dev);
+			drvmap[i].dev = NULL;
+		}
+	}
+#endif
+}
+
+void *compat_request_region (unsigned long start, unsigned long n, const char *name)
+{
+	if (check_region (start, n) != 0)
+		return NULL;
+	request_region (start, n, name);
+	return (void *) 1;
+}
+
+static inline int pci_module_init(struct pci_driver *drv)
+{
+	if (pci_register_driver(drv))
+		return 0;
+	return -ENODEV;
+}
+
+static struct pci_driver starfire_driver;
+
+int __init starfire_probe(struct net_device *dev)
+{
+	static int __initdata probed = 0;
+
+	if (probed)
+		return -ENODEV;
+	probed++;
+
+	return pci_module_init(&starfire_driver);
+}
+
+#define init_tx_timer(dev, func, timeout)
+#define kick_tx_timer(dev, func, timeout) \
+	if (netif_queue_stopped(dev)) { \
+		/* If this happens network layer tells us we're broken. */ \
+		if (jiffies - dev->trans_start > timeout) \
+			func(dev); \
+	}
+
+#else  /* LINUX_VERSION_CODE > 0x20300 */
+
+#define COMPAT_MOD_INC_USE_COUNT
+#define COMPAT_MOD_DEC_USE_COUNT
+
+#define init_tx_timer(dev, func, timeout) \
+	dev->tx_timeout = func; \
+	dev->watchdog_timeo = timeout;
+#define kick_tx_timer(dev, func, timeout)
+
+
+#endif /* LINUX_VERSION_CODE > 0x20300 */
+/* end of compatibility code */
+
+
 enum chip_capability_flags {CanHaveMII=1, };
 #define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR0)
 #define MEM_ADDR_SZ 0x80000		/* And maps in 0.5MB(!).  */
@@ -262,19 +550,31 @@
 	TxThreshold=0x500B0,
 	CompletionHiAddr=0x500B4, TxCompletionAddr=0x500B8,
 	RxCompletionAddr=0x500BC, RxCompletionQ2Addr=0x500C0,
-	CompletionQConsumerIdx=0x500C4,
+	CompletionQConsumerIdx=0x500C4, RxDMACtrl=0x500D0,
 	RxDescQCtrl=0x500D4, RxDescQHiAddr=0x500DC, RxDescQAddr=0x500E0,
 	RxDescQIdx=0x500E8, RxDMAStatus=0x500F0, RxFilterMode=0x500F4,
-	TxMode=0x55000,
+	TxMode=0x55000, TxGfpMem=0x58000, RxGfpMem=0x5a000,
 };
 
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
-	IntrNormalSummary=0x8000,	IntrAbnormalSummary=0x02000000,
-	IntrRxDone=0x0300, IntrRxEmpty=0x10040, IntrRxPCIErr=0x80000,
-	IntrTxDone=0x4000, IntrTxEmpty=0x1000, IntrTxPCIErr=0x80000,
-	StatsMax=0x08000000, LinkChange=0xf0000000,
-	IntrTxDataLow=0x00040000,
+	IntrLinkChange=0xf0000000, IntrStatsMax=0x08000000,
+	IntrAbnormalSummary=0x02000000, IntrGeneralTimer=0x01000000,
+	IntrSoftware=0x800000, IntrRxComplQ1Low=0x400000,
+	IntrTxComplQLow=0x200000, IntrPCI=0x100000,
+	IntrDMAErr=0x080000, IntrTxDataLow=0x040000,
+	IntrRxComplQ2Low=0x020000, IntrRxDescQ1Low=0x010000,
+	IntrNormalSummary=0x8000, IntrTxDone=0x4000,
+	IntrTxDMADone=0x2000, IntrTxEmpty=0x1000,
+	IntrEarlyRxQ2=0x0800, IntrEarlyRxQ1=0x0400,
+	IntrRxQ2Done=0x0200, IntrRxQ1Done=0x0100,
+	IntrRxGFPDead=0x80, IntrRxDescQ2Low=0x40,
+	IntrNoTxCsum=0x20, IntrTxBadID=0x10,
+	IntrHiPriTxBadID=0x08, IntrRxGfp=0x04,
+	IntrTxGfp=0x02, IntrPCIPad=0x01,
+	/* not quite bits */
+	IntrRxDone=IntrRxQ2Done | IntrRxQ1Done,
+	IntrRxEmpty=IntrRxDescQ1Low | IntrRxDescQ2Low,
 };
 
 /* Bits in the RxFilterMode register. */
@@ -283,9 +583,40 @@
 	AcceptMulticast=0x10, AcceptMyPhys=0xE040,
 };
 
+/* Bits in the TxDescCtrl register. */
+enum tx_ctrl_bits {
+	TxDescSpaceUnlim=0x00, TxDescSpace32=0x10, TxDescSpace64=0x20,
+	TxDescSpace128=0x30, TxDescSpace256=0x40,
+	TxDescType0=0x00, TxDescType1=0x01, TxDescType2=0x02,
+	TxDescType3=0x03, TxDescType4=0x04,
+	TxNoDMACompletion=0x08, TxDescQ64bit=0x80,
+	TxHiPriFIFOThreshShift=24, TxPadLenShift=16,
+	TxDMABurstSizeShift=8,
+};
+
+/* Bits in the RxDescQCtrl register. */
+enum rx_ctrl_bits {
+	RxBufferLenShift=16, RxMinDescrThreshShift=0,
+	RxPrefetchMode=0x8000, Rx2048QEntries=0x4000,
+	RxVariableQ=0x2000, RxDesc64bit=0x1000,
+	RxDescQAddr64bit=0x0100,
+	RxDescSpace4=0x000, RxDescSpace8=0x100,
+	RxDescSpace16=0x200, RxDescSpace32=0x300,
+	RxDescSpace64=0x400, RxDescSpace128=0x500,
+	RxConsumerWrEn=0x80,
+};
+
+/* Bits in the RxCompletionAddr register */
+enum rx_compl_bits {
+	RxComplQAddr64bit=0x80, TxComplProducerWrEn=0x40,
+	RxComplType0=0x00, RxComplType1=0x10,
+	RxComplType2=0x20, RxComplType3=0x30,
+	RxComplThreshShift=0,
+};
+
 /* The Rx and Tx buffer descriptors. */
 struct starfire_rx_desc {
-	u32 rxaddr;					/* Optionally 64 bits. */
+	u32 rxaddr;			/* Optionally 64 bits. */
 };
 enum rx_desc_bits {
 	RxDescValid=1, RxDescEndRing=2,
@@ -294,14 +625,20 @@
 /* Completion queue entry.
    You must update the page allocation, init_ring and the shift count in rx()
    if using a larger format. */
+#ifdef HAS_FIRMWARE
+#define csum_rx_status
+#endif /* HAS_FIRMWARE */
 struct rx_done_desc {
-	u32 status;					/* Low 16 bits is length. */
+	u32 status;			/* Low 16 bits is length. */
+#ifdef csum_rx_status
+	u32 status2;			/* Low 16 bits is csum */
+#endif /* csum_rx_status */
 #ifdef full_rx_status
 	u32 status2;
 	u16 vlanid;
-	u16 csum; 			/* partial checksum */
+	u16 csum;			/* partial checksum */
 	u32 timestamp;
-#endif
+#endif /* full_rx_status */
 };
 enum rx_done_bits {
 	RxOK=0x20000000, RxFIFOErr=0x10000000, RxBufQ2=0x08000000,
@@ -309,26 +646,31 @@
 
 /* Type 1 Tx descriptor. */
 struct starfire_tx_desc {
-	u32 status;					/* Upper bits are status, lower 16 length. */
-	u32 addr;
+	u32 status;			/* Upper bits are status, lower 16 length. */
+	u32 first_addr;
 };
 enum tx_desc_bits {
-	TxDescID=0xB1010000,		/* Also marks single fragment, add CRC.  */
-	TxDescIntr=0x08000000, TxRingWrap=0x04000000,
+	TxDescID=0xB0000000,
+	TxCRCEn=0x01000000, TxDescIntr=0x08000000,
+	TxRingWrap=0x04000000, TxCalTCP=0x02000000,
 };
 struct tx_done_report {
-	u32 status;					/* timestamp, index. */
+	u32 status;			/* timestamp, index. */
 #if 0
-	u32 intrstatus;				/* interrupt status */
+	u32 intrstatus;			/* interrupt status */
 #endif
 };
 
-#define PRIV_ALIGN	15 	/* Required alignment mask */
-struct ring_info {
+struct rx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t mapping;
 };
+struct tx_ring_info {
+	struct sk_buff *skb;
+	dma_addr_t first_mapping;
+};
 
+#define MII_CNT		2
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
 	struct starfire_rx_desc *rx_ring;
@@ -336,8 +678,8 @@
 	dma_addr_t rx_ring_dma;
 	dma_addr_t tx_ring_dma;
 	/* The addresses of rx/tx-in-place skbuffs. */
-	struct ring_info rx_info[RX_RING_SIZE];
-	struct ring_info tx_info[TX_RING_SIZE];
+	struct rx_ring_info rx_info[RX_RING_SIZE];
+	struct tx_ring_info tx_info[TX_RING_SIZE];
 	/* Pointers to completion queues (full pages).  I should cache line pad..*/
 	u8 pad0[100];
 	struct rx_done_desc *rx_done_q;
@@ -350,45 +692,45 @@
 	struct timer_list timer;	/* Media monitoring timer. */
 	struct pci_dev *pci_dev;
 	/* Frequently used values: keep some adjacent for cache effect. */
-	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
+	unsigned int cur_rx, dirty_rx;	/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
-	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
-	unsigned int tx_full:1;				/* The Tx queue is full. */
+	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
+	unsigned int tx_full:1;		/* The Tx queue is full. */
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int full_duplex:1,			/* Full-duplex operation requested. */
-		medialock:1,					/* Xcvr set to fixed speed/duplex. */
+	unsigned int full_duplex:1,	/* Full-duplex operation requested. */
+		medialock:1,		/* Xcvr set to fixed speed/duplex. */
 		rx_flowctrl:1,
-		tx_flowctrl:1;					/* Use 802.3x flow control. */
-	unsigned int default_port:4;		/* Last dev->if_port value. */
+		tx_flowctrl:1;		/* Use 802.3x flow control. */
+	unsigned int default_port:4;	/* Last dev->if_port value. */
 	u32 tx_mode;
 	u8 tx_threshold;
 	/* MII transceiver section. */
-	int mii_cnt;						/* MII device addresses. */
-	u16 advertising;					/* NWay media advertisement */
-	unsigned char phys[2];				/* MII device addresses. */
-};
-
-static int  mdio_read(struct net_device *dev, int phy_id, int location);
-static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
-static int  netdev_open(struct net_device *dev);
-static void check_duplex(struct net_device *dev, int startup);
-static void netdev_timer(unsigned long data);
-static void tx_timeout(struct net_device *dev);
-static void init_ring(struct net_device *dev);
-static int  start_tx(struct sk_buff *skb, struct net_device *dev);
-static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
-static void netdev_error(struct net_device *dev, int intr_status);
-static int  netdev_rx(struct net_device *dev);
-static void netdev_error(struct net_device *dev, int intr_status);
-static void set_rx_mode(struct net_device *dev);
+	int mii_cnt;			/* MII device addresses. */
+	u16 advertising;		/* NWay media advertisement */
+	unsigned char phys[MII_CNT];	/* MII device addresses. */
+};
+
+static int	mdio_read(struct net_device *dev, int phy_id, int location);
+static void	mdio_write(struct net_device *dev, int phy_id, int location, int value);
+static int	netdev_open(struct net_device *dev);
+static void	check_duplex(struct net_device *dev, int startup);
+static void	netdev_timer(unsigned long data);
+static void	tx_timeout(struct net_device *dev);
+static void	init_ring(struct net_device *dev);
+static int	start_tx(struct sk_buff *skb, struct net_device *dev);
+static void	intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
+static void	netdev_error(struct net_device *dev, int intr_status);
+static int	netdev_rx(struct net_device *dev);
+static void	netdev_error(struct net_device *dev, int intr_status);
+static void	set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
-static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-static int  netdev_close(struct net_device *dev);
+static int	mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static int	netdev_close(struct net_device *dev);
 
 
 
-static int __devinit starfire_init_one (struct pci_dev *pdev,
-					const struct pci_device_id *ent)
+static int __devinit starfire_init_one(struct pci_dev *pdev,
+				       const struct pci_device_id *ent)
 {
 	struct netdev_private *np;
 	int i, irq, option, chip_idx = ent->driver_data;
@@ -396,39 +738,41 @@
 	static int card_idx = -1;
 	static int printed_version = 0;
 	long ioaddr;
-	int drv_flags, io_size = netdrv_tbl[chip_idx].io_size;
+	int drv_flags, io_size;
+	int boguscnt;
 
 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 
 	if (!printed_version++)
 		printk(KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
-		       version1, version2, version3);
+			   version1, version2, version3);
 
 	if (pci_enable_device (pdev))
 		return -EIO;
 
 	ioaddr = pci_resource_start (pdev, 0);
+	io_size = pci_resource_len (pdev, 0);
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
 		printk (KERN_ERR "starfire %d: no PCI MEM resources, aborting\n", card_idx);
 		return -ENODEV;
 	}
-	
+
 	dev = init_etherdev(NULL, sizeof(*np));
 	if (!dev) {
 		printk (KERN_ERR "starfire %d: cannot alloc etherdev, aborting\n", card_idx);
 		return -ENOMEM;
 	}
 	SET_MODULE_OWNER(dev);
-	
-	irq = pdev->irq; 
+
+	irq = pdev->irq;
 
 	if (request_mem_region (ioaddr, io_size, dev->name) == NULL) {
 		printk (KERN_ERR "starfire %d: resource 0x%x @ 0x%lx busy, aborting\n",
 			card_idx, io_size, ioaddr);
 		goto err_out_free_netdev;
 	}
-	
+
 	ioaddr = (long) ioremap (ioaddr, io_size);
 	if (!ioaddr) {
 		printk (KERN_ERR "starfire %d: cannot remap 0x%x @ 0x%lx, aborting\n",
@@ -437,7 +781,7 @@
 	}
 
 	pci_set_master (pdev);
-	
+
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, netdrv_tbl[chip_idx].name, ioaddr);
 
@@ -445,29 +789,45 @@
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20-i);
 	for (i = 0; i < 5; i++)
-			printk("%2.2x:", dev->dev_addr[i]);
+		printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);
 
 #if ! defined(final_version) /* Dump the EEPROM contents during development. */
 	if (debug > 4)
 		for (i = 0; i < 0x20; i++)
-			printk("%2.2x%s", (unsigned int)readb(ioaddr + EEPROMCtrl + i),
-				   i % 16 != 15 ? " " : "\n");
+			printk("%2.2x%s",
+			       (unsigned int)readb(ioaddr + EEPROMCtrl + i),
+			       i % 16 != 15 ? " " : "\n");
 #endif
 
+	/* Issue soft reset */
+	writel(0x8000, ioaddr + TxMode);
+	udelay(1000);
+	writel(0, ioaddr + TxMode);
+
 	/* Reset the chip to erase previous misconfiguration. */
 	writel(1, ioaddr + PCIDeviceConfig);
+	boguscnt = 1000;
+	while (--boguscnt > 0) {
+		udelay(10);
+		if ((readl(ioaddr + PCIDeviceConfig) & 1) == 0)
+			break;
+	}
+	if (boguscnt == 0)
+		printk("%s: chipset reset never completed!\n", dev->name);
+	/* wait a little longer */
+	udelay(1000);
 
 	dev->base_addr = ioaddr;
 	dev->irq = irq;
 
 	np = dev->priv;
-	pdev->driver_data = dev;
+	pci_set_drvdata(pdev, dev);
 
 	np->pci_dev = pdev;
 	drv_flags = netdrv_tbl[chip_idx].drv_flags;
 
-	if (dev->mem_start)
+	if (dev->mem_start && dev->mem_start != ~0UL)
 		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
@@ -478,7 +838,7 @@
 		if (np->default_port)
 			np->medialock = 1;
 	}
-	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
+	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
 		np->full_duplex = 1;
 
 	if (np->full_duplex)
@@ -487,8 +847,7 @@
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
 	dev->hard_start_xmit = &start_tx;
-	dev->tx_timeout = &tx_timeout;
-	dev->watchdog_timeo = TX_TIMEOUT;
+	init_tx_timer(dev, tx_timeout, TX_TIMEOUT);
 	dev->stop = &netdev_close;
 	dev->get_stats = &get_stats;
 	dev->set_multicast_list = &set_rx_mode;
@@ -499,14 +858,27 @@
 
 	if (drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
-		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
-			int mii_status = mdio_read(dev, phy, 1);
-			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
+		int mii_status;
+		for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
+			mdio_write(dev, phy, 0, 0x8000);
+			udelay(500);
+			boguscnt = 1000;
+			while (--boguscnt > 0)
+				if ((mdio_read(dev, phy, 0) & 0x8000) == 0)
+					break;
+			if (boguscnt == 0) {
+				printk("%s: PHY reset never completed!\n", dev->name);
+				continue;
+			}
+			mii_status = mdio_read(dev, phy, 1);
+			if (mii_status != 0x0000) {
 				np->phys[phy_idx++] = phy;
 				np->advertising = mdio_read(dev, phy, 4);
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x.\n",
 					   dev->name, phy, mii_status, np->advertising);
+				/* there can be only one PHY on-board */
+				break;
 			}
 		}
 		np->mii_cnt = phy_idx;
@@ -532,7 +904,11 @@
 	/* ??? Should we add a busy-wait here? */
 	do
 		result = readl(mdio_addr);
-	while ((result & 0xC0000000) != 0x80000000 && --boguscnt >= 0);
+	while ((result & 0xC0000000) != 0x80000000 && --boguscnt > 0);
+	if (boguscnt == 0)
+		return 0;
+	if ((result & 0xffff) == 0xffff)
+		return 0;
 	return result & 0xffff;
 }
 
@@ -553,48 +929,61 @@
 
 	/* Do we ever need to reset the chip??? */
 
+	COMPAT_MOD_INC_USE_COUNT;
+
 	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
-	if (retval)
+	if (retval) {
+		COMPAT_MOD_DEC_USE_COUNT;
 		return retval;
+	}
 
 	/* Disable the Rx and Tx, and reset the chip. */
 	writel(0, ioaddr + GenCtrl);
 	writel(1, ioaddr + PCIDeviceConfig);
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
-			   dev->name, dev->irq);
+		       dev->name, dev->irq);
 	/* Allocate the various queues, failing gracefully. */
 	if (np->tx_done_q == 0)
 		np->tx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_done_q_dma);
 	if (np->rx_done_q == 0)
-		np->rx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->rx_done_q_dma);
+		np->rx_done_q = pci_alloc_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE, &np->rx_done_q_dma);
 	if (np->tx_ring == 0)
 		np->tx_ring = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_ring_dma);
 	if (np->rx_ring == 0)
 		np->rx_ring = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->rx_ring_dma);
-	if (np->tx_done_q == 0  ||  np->rx_done_q == 0
-		|| np->rx_ring == 0 ||  np->tx_ring == 0) {
+	if (np->tx_done_q == 0 || np->rx_done_q == 0
+		|| np->rx_ring == 0 || np->tx_ring == 0) {
 		if (np->tx_done_q)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-								np->tx_done_q, np->tx_done_q_dma);
+					    np->tx_done_q, np->tx_done_q_dma);
 		if (np->rx_done_q)
-			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-								np->rx_done_q, np->rx_done_q_dma);
+			pci_free_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE,
+					    np->rx_done_q, np->rx_done_q_dma);
 		if (np->tx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-								np->tx_ring, np->tx_ring_dma);
+					    np->tx_ring, np->tx_ring_dma);
 		if (np->rx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-								np->rx_ring, np->rx_ring_dma);
+					    np->rx_ring, np->rx_ring_dma);
+		COMPAT_MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
 	init_ring(dev);
 	/* Set the size of the Rx buffers. */
-	writel((np->rx_buf_sz<<16) | 0xA000, ioaddr + RxDescQCtrl);
+	writel((np->rx_buf_sz << RxBufferLenShift) |
+	       (0 << RxMinDescrThreshShift) |
+	       RxPrefetchMode | RxVariableQ |
+	       RxDescSpace4,
+	       ioaddr + RxDescQCtrl);
 
 	/* Set Tx descriptor to type 1 and padding to 0 bytes. */
-	writel(0x02000401, ioaddr + TxDescCtrl);
+	writel((2 << TxHiPriFIFOThreshShift) |
+	       (0 << TxPadLenShift) |
+	       (4 << TxDMABurstSizeShift) |
+	       TxDescSpaceUnlim | TxDescType1,
+	       ioaddr + TxDescCtrl);
 
 #if defined(ADDR_64BITS) && defined(__alpha__)
 	/* XXX We really need a 64-bit PCI dma interfaces too... -DaveM */
@@ -609,10 +998,27 @@
 	writel(np->tx_ring_dma, ioaddr + TxRingPtr);
 
 	writel(np->tx_done_q_dma, ioaddr + TxCompletionAddr);
-	writel(np->rx_done_q_dma, ioaddr + RxCompletionAddr);
+#ifdef full_rx_status
+	writel(np->rx_done_q_dma |
+	       RxComplType3 |
+	       (0 << RxComplThreshShift),
+	       ioaddr + RxCompletionAddr);
+#else  /* not full_rx_status */
+#ifdef csum_rx_status
+	writel(np->rx_done_q_dma |
+	       RxComplType2 |
+	       (0 << RxComplThreshShift),
+	       ioaddr + RxCompletionAddr);
+#else  /* not csum_rx_status */
+	writel(np->rx_done_q_dma |
+	       RxComplType0 |
+	       (0 << RxComplThreshShift),
+	       ioaddr + RxCompletionAddr);
+#endif /* not csum_rx_status */
+#endif /* not full_rx_status */
 
 	if (debug > 1)
-		printk(KERN_DEBUG "%s:  Filling in the station address.\n", dev->name);
+		printk(KERN_DEBUG "%s: Filling in the station address.\n", dev->name);
 
 	/* Fill both the unused Tx SA register and the Rx perfect filter. */
 	for (i = 0; i < 6; i++)
@@ -638,26 +1044,37 @@
 	netif_start_queue(dev);
 
 	if (debug > 1)
-		printk(KERN_DEBUG "%s:  Setting the Rx and Tx modes.\n", dev->name);
+		printk(KERN_DEBUG "%s: Setting the Rx and Tx modes.\n", dev->name);
 	set_rx_mode(dev);
 
 	np->advertising = mdio_read(dev, np->phys[0], 4);
 	check_duplex(dev, 1);
 
 	/* Set the interrupt mask and enable PCI interrupts. */
-	writel(IntrRxDone | IntrRxEmpty | IntrRxPCIErr |
-		   IntrTxDone | IntrTxEmpty | IntrTxPCIErr |
-		   StatsMax | LinkChange | IntrNormalSummary | IntrAbnormalSummary
-		   | 0x0010 , ioaddr + IntrEnable);
+	writel(IntrRxDone | IntrRxEmpty | IntrDMAErr |
+	       IntrTxDone | IntrStatsMax | IntrLinkChange |
+	       IntrNormalSummary | IntrAbnormalSummary |
+	       IntrRxGFPDead | IntrNoTxCsum | IntrTxBadID,
+	       ioaddr + IntrEnable);
 	writel(0x00800000 | readl(ioaddr + PCIDeviceConfig),
-		   ioaddr + PCIDeviceConfig);
+	       ioaddr + PCIDeviceConfig);
 
-	/* Enable the Rx and Tx units. */
+#ifdef HAS_FIRMWARE
+	/* Load Rx/Tx firmware into the frame processors */
+	for (i = 0; i < FIRMWARE_RX_SIZE * 2; i++)
+		writel(cpu_to_le32(firmware_rx[i]), ioaddr + RxGfpMem + i * 4);
+	for (i = 0; i < FIRMWARE_TX_SIZE * 2; i++)
+		writel(cpu_to_le32(firmware_tx[i]), ioaddr + TxGfpMem + i * 4);
+	/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
+	writel(0x003F, ioaddr + GenCtrl);
+#else  /* not HAS_FIRMWARE */
+	/* Enable the Rx and Tx units only. */
 	writel(0x000F, ioaddr + GenCtrl);
+#endif /* not HAS_FIRMWARE */
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done netdev_open().\n",
-			   dev->name);
+		       dev->name);
 
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
@@ -690,8 +1107,8 @@
 			np->full_duplex = duplex;
 			if (debug > 1)
 				printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d"
-					   " negotiated capability %4.4x.\n", dev->name,
-					   duplex ? "full" : "half", np->phys[0], negotiated);
+				       " negotiated capability %4.4x.\n", dev->name,
+				       duplex ? "full" : "half", np->phys[0], negotiated);
 		}
 	}
 	if (new_tx_mode != np->tx_mode) {
@@ -710,7 +1127,7 @@
 
 	if (debug > 3) {
 		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x.\n",
-			   dev->name, (int)readl(ioaddr + IntrStatus));
+		       dev->name, (int)readl(ioaddr + IntrStatus));
 	}
 	check_duplex(dev, 0);
 #if ! defined(final_version)
@@ -720,7 +1137,7 @@
 		/* Bogus hardware IRQ: Fake an interrupt handler call. */
 		if (new_status & 1) {
 			printk(KERN_ERR "%s: Interrupt blocked, status %8.8x/%8.8x.\n",
-				   dev->name, new_status, (int)readl(ioaddr + IntrStatus));
+			       dev->name, new_status, (int)readl(ioaddr + IntrStatus));
 			intr_handler(dev->irq, dev, 0);
 		}
 	}
@@ -736,7 +1153,7 @@
 	long ioaddr = dev->base_addr;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
-		   " resetting...\n", dev->name, (int)readl(ioaddr + IntrStatus));
+	       " resetting...\n", dev->name, (int)readl(ioaddr + IntrStatus));
 
 #ifndef __alpha__
 	{
@@ -759,14 +1176,14 @@
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
-	return;
+	netif_wake_queue(dev);
 }
 
 
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
 static void init_ring(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int i;
 
 	np->tx_full = 0;
@@ -806,7 +1223,7 @@
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_info[i].skb = NULL;
-		np->tx_info[i].mapping = 0;
+		np->tx_info[i].first_mapping = 0;
 		np->tx_ring[i].status = 0;
 	}
 	return;
@@ -817,6 +1234,8 @@
 	struct netdev_private *np = dev->priv;
 	unsigned int entry;
 
+	kick_tx_timer(dev, tx_timeout, TX_TIMEOUT);
+
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
 
@@ -824,25 +1243,27 @@
 	entry = np->cur_tx % TX_RING_SIZE;
 
 	np->tx_info[entry].skb = skb;
-	np->tx_info[entry].mapping =
-		pci_map_single(np->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE);
+	np->tx_info[entry].first_mapping =
+		pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
+
+	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
+	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
+	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID | TxCRCEn | 1 << 16);
+
+	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
+		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
 
-	np->tx_ring[entry].addr = cpu_to_le32(np->tx_info[entry].mapping);
-	/* Add  "| TxDescIntr" to generate Tx-done interrupts. */
-	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID);
 	if (debug > 5) {
-		printk(KERN_DEBUG "%s: Tx #%d slot %d  %8.8x %8.8x.\n",
-			   dev->name, np->cur_tx, entry,
-			   le32_to_cpu(np->tx_ring[entry].status),
-			   le32_to_cpu(np->tx_ring[entry].addr));
+		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x.\n",
+		       dev->name, np->cur_tx, entry,
+		       le32_to_cpu(np->tx_ring[entry].status));
 	}
+
 	np->cur_tx++;
-#if 1
-	if (entry >= TX_RING_SIZE-1) {		 /* Wrap ring */
-		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
+
+	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
 		entry = -1;
-	}
-#endif
+	entry++;
 
 	/* Non-x86: explicitly flush descriptor cache lines here. */
 	/* Ensure everything is written back above before the transmit is
@@ -850,18 +1271,15 @@
 	wmb();
 
 	/* Update the producer index. */
-	writel(++entry, dev->base_addr + TxProducerIdx);
+	writel(entry * (sizeof(struct starfire_tx_desc) / 8), dev->base_addr + TxProducerIdx);
 
 	if (np->cur_tx - np->dirty_tx >= TX_RING_SIZE - 1) {
 		np->tx_full = 1;
 		netif_stop_queue(dev);
 	}
+
 	dev->trans_start = jiffies;
 
-	if (debug > 4) {
-		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			   dev->name, np->cur_tx, entry);
-	}
 	return 0;
 }
 
@@ -873,24 +1291,25 @@
 	struct netdev_private *np;
 	long ioaddr;
 	int boguscnt = max_interrupt_work;
+	int consumer;
+	int tx_status;
 
 #ifndef final_version			/* Can never occur. */
 	if (dev == NULL) {
-		printk (KERN_ERR "Netdev interrupt handler(): IRQ %d for unknown "
-				"device.\n", irq);
+		printk (KERN_ERR "Netdev interrupt handler(): IRQ %d for unknown device.\n", irq);
 		return;
 	}
 #endif
 
 	ioaddr = dev->base_addr;
-	np = (struct netdev_private *)dev->priv;
+	np = dev->priv;
 
 	do {
 		u32 intr_status = readl(ioaddr + IntrClear);
 
 		if (debug > 4)
 			printk(KERN_DEBUG "%s: Interrupt status %4.4x.\n",
-				   dev->name, intr_status);
+			       dev->name, intr_status);
 
 		if (intr_status == 0)
 			break;
@@ -901,48 +1320,48 @@
 		/* Scavenge the skbuff list based on the Tx-done queue.
 		   There are redundant checks here that may be cleaned up
 		   after the driver has proven to be reliable. */
-		{
-			int consumer = readl(ioaddr + TxConsumerIdx);
-			int tx_status;
-			if (debug > 4)
-				printk(KERN_DEBUG "%s: Tx Consumer index is %d.\n",
-					   dev->name, consumer);
+		consumer = readl(ioaddr + TxConsumerIdx);
+		if (debug > 4)
+			printk(KERN_DEBUG "%s: Tx Consumer index is %d.\n",
+			       dev->name, consumer);
 #if 0
-			if (np->tx_done >= 250  || np->tx_done == 0)
-				printk(KERN_DEBUG "%s: Tx completion entry %d is %8.8x, "
-					   "%d is %8.8x.\n", dev->name,
-					   np->tx_done, le32_to_cpu(np->tx_done_q[np->tx_done].status),
-					   (np->tx_done+1) & (DONE_Q_SIZE-1),
-					   le32_to_cpu(np->tx_done_q[(np->tx_done+1)&(DONE_Q_SIZE-1)].status));
+		if (np->tx_done >= 250 || np->tx_done == 0)
+			printk(KERN_DEBUG "%s: Tx completion entry %d is %8.8x, %d is %8.8x.\n",
+			       dev->name, np->tx_done,
+			       le32_to_cpu(np->tx_done_q[np->tx_done].status),
+			       (np->tx_done+1) & (DONE_Q_SIZE-1),
+			       le32_to_cpu(np->tx_done_q[(np->tx_done+1)&(DONE_Q_SIZE-1)].status));
 #endif
-			while ((tx_status = le32_to_cpu(np->tx_done_q[np->tx_done].status))
-				   != 0) {
-				if (debug > 4)
-					printk(KERN_DEBUG "%s: Tx completion entry %d is %8.8x.\n",
-						   dev->name, np->tx_done, tx_status);
-				if ((tx_status & 0xe0000000) == 0xa0000000) {
-					np->stats.tx_packets++;
-				} else if ((tx_status & 0xe0000000) == 0x80000000) {
-					struct sk_buff *skb;
-					u16 entry = tx_status; 		/* Implicit truncate */
-					entry >>= 3;
-
-					skb = np->tx_info[entry].skb;
-					pci_unmap_single(np->pci_dev,
-							 np->tx_info[entry].mapping,
-							 skb->len, PCI_DMA_TODEVICE);
-
-					/* Scavenge the descriptor. */
-					dev_kfree_skb_irq(skb);
-					np->tx_info[entry].skb = NULL;
-					np->tx_info[entry].mapping = 0;
-					np->dirty_tx++;
-				}
-				np->tx_done_q[np->tx_done].status = 0;
-				np->tx_done = (np->tx_done+1) & (DONE_Q_SIZE-1);
+
+		while ((tx_status = le32_to_cpu(np->tx_done_q[np->tx_done].status)) != 0) {
+			if (debug > 4)
+				printk(KERN_DEBUG "%s: Tx completion entry %d is %8.8x.\n",
+				       dev->name, np->tx_done, tx_status);
+			if ((tx_status & 0xe0000000) == 0xa0000000) {
+				np->stats.tx_packets++;
+			} else if ((tx_status & 0xe0000000) == 0x80000000) {
+				struct sk_buff *skb;
+				u16 entry = tx_status;		/* Implicit truncate */
+				entry /= sizeof(struct starfire_tx_desc);
+
+				skb = np->tx_info[entry].skb;
+				np->tx_info[entry].skb = NULL;
+				pci_unmap_single(np->pci_dev,
+						 np->tx_info[entry].first_mapping,
+						 skb_first_frag_len(skb),
+						 PCI_DMA_TODEVICE);
+				np->tx_info[entry].first_mapping = 0;
+
+				/* Scavenge the descriptor. */
+				dev_kfree_skb_irq(skb);
+
+				np->dirty_tx++;
 			}
-			writew(np->tx_done, ioaddr + CompletionQConsumerIdx + 2);
+			np->tx_done_q[np->tx_done].status = 0;
+			np->tx_done = (np->tx_done+1) & (DONE_Q_SIZE-1);
 		}
+		writew(np->tx_done, ioaddr + CompletionQConsumerIdx + 2);
+
 		if (np->tx_full && np->cur_tx - np->dirty_tx < TX_RING_SIZE - 4) {
 			/* The ring is no longer full, wake the queue. */
 			np->tx_full = 0;
@@ -955,23 +1374,23 @@
 
 		if (--boguscnt < 0) {
 			printk(KERN_WARNING "%s: Too much work at interrupt, "
-				   "status=0x%4.4x.\n",
-				   dev->name, intr_status);
+			       "status=0x%4.4x.\n",
+			       dev->name, intr_status);
 			break;
 		}
 	} while (1);
 
 	if (debug > 4)
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
-			   dev->name, (int)readl(ioaddr + IntrStatus));
+		       dev->name, (int)readl(ioaddr + IntrStatus));
 
 #ifndef final_version
 	/* Code that should never be run!  Remove after testing.. */
 	{
 		static int stopit = 10;
-		if (!netif_running(dev)  &&  --stopit < 0) {
+		if (!netif_running(dev) && --stopit < 0) {
 			printk(KERN_ERR "%s: Emergency stop, looping startup interrupt.\n",
-				   dev->name);
+			       dev->name);
 			free_irq(irq, dev);
 		}
 	}
@@ -988,83 +1407,99 @@
 
 	if (np->rx_done_q == 0) {
 		printk(KERN_ERR "%s:  rx_done_q is NULL!  rx_done is %d. %p.\n",
-			   dev->name, np->rx_done, np->tx_done_q);
+		       dev->name, np->rx_done, np->tx_done_q);
 		return 0;
 	}
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
 	while ((desc_status = le32_to_cpu(np->rx_done_q[np->rx_done].status)) != 0) {
+		struct sk_buff *skb;
+		u16 pkt_len;
+		int entry;
+
 		if (debug > 4)
-			printk(KERN_DEBUG "  netdev_rx() status of %d was %8.8x.\n",
-				   np->rx_done, desc_status);
+			printk(KERN_DEBUG "  netdev_rx() status of %d was %8.8x.\n", np->rx_done, desc_status);
 		if (--boguscnt < 0)
 			break;
 		if ( ! (desc_status & RxOK)) {
 			/* There was a error. */
 			if (debug > 2)
-				printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n",
-					   desc_status);
+				printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n", desc_status);
 			np->stats.rx_errors++;
 			if (desc_status & RxFIFOErr)
 				np->stats.rx_fifo_errors++;
-		} else {
-			struct sk_buff *skb;
-			u16 pkt_len = desc_status;			/* Implicitly Truncate */
-			int entry = (desc_status >> 16) & 0x7ff;
+			goto next_rx;
+		}
+
+		pkt_len = desc_status;	/* Implicitly Truncate */
+		entry = (desc_status >> 16) & 0x7ff;
 
 #ifndef final_version
-			if (debug > 4)
-				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
-					   ", bogus_cnt %d.\n",
-					   pkt_len, boguscnt);
+		if (debug > 4)
+			printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d, bogus_cnt %d.\n", pkt_len, boguscnt);
 #endif
-			/* Check if the packet is long enough to accept without copying
-			   to a minimally-sized skbuff. */
-			if (PKT_SHOULD_COPY(pkt_len)
-				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
-				skb->dev = dev;
-				skb_reserve(skb, 2);	/* 16 byte align the IP header */
-				pci_dma_sync_single(np->pci_dev,
-						    np->rx_info[entry].mapping,
-						    pkt_len, PCI_DMA_FROMDEVICE);
+		/* Check if the packet is long enough to accept without copying
+		   to a minimally-sized skbuff. */
+		if (pkt_len < rx_copybreak
+		    && (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
+			skb->dev = dev;
+			skb_reserve(skb, 2);	/* 16 byte align the IP header */
+			pci_dma_sync_single(np->pci_dev,
+					    np->rx_info[entry].mapping,
+					    pkt_len, PCI_DMA_FROMDEVICE);
 #if HAS_IP_COPYSUM			/* Call copy + cksum if available. */
-				eth_copy_and_sum(skb, np->rx_info[entry].skb->tail, pkt_len, 0);
-				skb_put(skb, pkt_len);
+			eth_copy_and_sum(skb, np->rx_info[entry].skb->tail, pkt_len, 0);
+			skb_put(skb, pkt_len);
 #else
-				memcpy(skb_put(skb, pkt_len), np->rx_info[entry].skb->tail,
-					   pkt_len);
+			memcpy(skb_put(skb, pkt_len), np->rx_info[entry].skb->tail, pkt_len);
 #endif
-			} else {
-				char *temp;
+		} else {
+			char *temp;
 
-				pci_unmap_single(np->pci_dev, np->rx_info[entry].mapping, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
-				skb = np->rx_info[entry].skb;
-				temp = skb_put(skb, pkt_len);
-				np->rx_info[entry].skb = NULL;
-				np->rx_info[entry].mapping = 0;
-			}
-#ifndef final_version				/* Remove after testing. */
-			/* You will want this info for the initial debug. */
-			if (debug > 5)
-				printk(KERN_DEBUG "  Rx data %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:"
-					   "%2.2x %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x %2.2x%2.2x "
-					   "%d.%d.%d.%d.\n",
-					   skb->data[0], skb->data[1], skb->data[2], skb->data[3],
-					   skb->data[4], skb->data[5], skb->data[6], skb->data[7],
-					   skb->data[8], skb->data[9], skb->data[10],
-					   skb->data[11], skb->data[12], skb->data[13],
-					   skb->data[14], skb->data[15], skb->data[16],
-					   skb->data[17]);
-#endif
-			skb->protocol = eth_type_trans(skb, dev);
-#ifdef full_rx_status
-			if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000)
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			pci_unmap_single(np->pci_dev, np->rx_info[entry].mapping, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			skb = np->rx_info[entry].skb;
+			temp = skb_put(skb, pkt_len);
+			np->rx_info[entry].skb = NULL;
+			np->rx_info[entry].mapping = 0;
+		}
+#ifndef final_version			/* Remove after testing. */
+		/* You will want this info for the initial debug. */
+		if (debug > 5)
+			printk(KERN_DEBUG "  Rx data %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:"
+			       "%2.2x %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x %2.2x%2.2x "
+			       "%d.%d.%d.%d.\n",
+			       skb->data[0], skb->data[1], skb->data[2], skb->data[3],
+			       skb->data[4], skb->data[5], skb->data[6], skb->data[7],
+			       skb->data[8], skb->data[9], skb->data[10],
+			       skb->data[11], skb->data[12], skb->data[13],
+			       skb->data[14], skb->data[15], skb->data[16],
+			       skb->data[17]);
 #endif
-			netif_rx(skb);
-			dev->last_rx = jiffies;
-			np->stats.rx_packets++;
+		skb->protocol = eth_type_trans(skb, dev);
+#if defined(full_rx_status) || defined(csum_rx_status)
+		if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		}
+		/*
+		 * This feature doesn't seem to be working, at least
+		 * with the two firmware versions I have. If the GFP sees
+		 * a fragment, it either ignores it completely, or reports
+		 * "bad checksum" on it.
+		 *
+		 * Maybe I missed something -- corrections are welcome.
+		 * Until then, the printk stays. :-) -Ion
+		 */
+		else if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x00400000) {
+			skb->ip_summed = CHECKSUM_HW;
+			skb->csum = le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0xffff;
+			printk(KERN_DEBUG "%s: checksum_hw, status2 = %x\n", dev->name, np->rx_done_q[np->rx_done].status2);
+		}
+#endif
+		netif_rx(skb);
+		dev->last_rx = jiffies;
+		np->stats.rx_packets++;
+
+next_rx:
 		np->cur_rx++;
 		np->rx_done_q[np->rx_done].status = 0;
 		np->rx_done = (np->rx_done + 1) & (DONE_Q_SIZE-1);
@@ -1079,10 +1514,10 @@
 			skb = dev_alloc_skb(np->rx_buf_sz);
 			np->rx_info[entry].skb = skb;
 			if (skb == NULL)
-				break;			/* Better luck next round. */
+				break;	/* Better luck next round. */
 			np->rx_info[entry].mapping =
 				pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
-			skb->dev = dev;			/* Mark as being used by this device. */
+			skb->dev = dev;	/* Mark as being used by this device. */
 			np->rx_ring[entry].rxaddr =
 				cpu_to_le32(np->rx_info[entry].mapping | RxDescValid);
 		}
@@ -1093,10 +1528,10 @@
 	}
 
 	if (debug > 5
-		|| memcmp(np->pad0, np->pad0 + 1, sizeof(np->pad0) -1))
+	    || memcmp(np->pad0, np->pad0 + 1, sizeof(np->pad0) -1))
 		printk(KERN_DEBUG "  exiting netdev_rx() status of %d was %8.8x %d.\n",
-			   np->rx_done, desc_status,
-			   memcmp(np->pad0, np->pad0 + 1, sizeof(np->pad0) -1));
+		       np->rx_done, desc_status,
+		       memcmp(np->pad0, np->pad0 + 1, sizeof(np->pad0) -1));
 
 	/* Restart Rx engine if stopped. */
 	return 0;
@@ -1106,28 +1541,25 @@
 {
 	struct netdev_private *np = dev->priv;
 
-	if (intr_status & LinkChange) {
+	if (intr_status & IntrLinkChange) {
 		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
-			   " %4.4x  partner %4.4x.\n", dev->name,
-			   mdio_read(dev, np->phys[0], 4),
-			   mdio_read(dev, np->phys[0], 5));
+		       " %4.4x, partner %4.4x.\n", dev->name,
+		       mdio_read(dev, np->phys[0], 4),
+		       mdio_read(dev, np->phys[0], 5));
 		check_duplex(dev, 0);
 	}
-	if (intr_status & StatsMax) {
+	if (intr_status & IntrStatsMax) {
 		get_stats(dev);
 	}
 	/* Came close to underrunning the Tx FIFO, increase threshold. */
 	if (intr_status & IntrTxDataLow)
 		writel(++np->tx_threshold, dev->base_addr + TxThreshold);
-	if ((intr_status &
-		 ~(IntrAbnormalSummary|LinkChange|StatsMax|IntrTxDataLow|1)) && debug)
+	if ((intr_status & ~(IntrAbnormalSummary|IntrLinkChange|IntrStatsMax|IntrTxDataLow|1)) && debug)
 		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
-			   dev->name, intr_status);
-	/* Hmmmmm, it's not clear how to recover from PCI faults. */
-	if (intr_status & IntrTxPCIErr)
+		       dev->name, intr_status);
+	/* Hmmmmm, it's not clear how to recover from DMA faults. */
+	if (intr_status & IntrDMAErr)
 		np->stats.tx_fifo_errors++;
-	if (intr_status & IntrRxPCIErr)
-		np->stats.rx_fifo_errors++;
 }
 
 static struct net_device_stats *get_stats(struct net_device *dev)
@@ -1142,12 +1574,13 @@
 	np->stats.tx_aborted_errors =
 		readl(ioaddr + 0x57024) + readl(ioaddr + 0x57028);
 	np->stats.tx_window_errors = readl(ioaddr + 0x57018);
-	np->stats.collisions = readl(ioaddr + 0x57004) + readl(ioaddr + 0x57008);
+	np->stats.collisions =
+		readl(ioaddr + 0x57004) + readl(ioaddr + 0x57008);
 
 	/* The chip only need report frame silently dropped. */
-	np->stats.rx_dropped	   += readw(ioaddr + RxDMAStatus);
+	np->stats.rx_dropped += readw(ioaddr + RxDMAStatus);
 	writew(0, ioaddr + RxDMAStatus);
-	np->stats.rx_crc_errors	   = readl(ioaddr + 0x5703C);
+	np->stats.rx_crc_errors = readl(ioaddr + 0x5703C);
 	np->stats.rx_frame_errors = readl(ioaddr + 0x57040);
 	np->stats.rx_length_errors = readl(ioaddr + 0x57058);
 	np->stats.rx_missed_errors = readl(ioaddr + 0x5707C);
@@ -1188,19 +1621,19 @@
 	struct dev_mc_list *mclist;
 	int i;
 
-	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
+	if (dev->flags & IFF_PROMISC) {	/* Set promiscuous. */
 		/* Unconditionally log net taps. */
 		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
 		rx_mode = AcceptBroadcast|AcceptAllMulticast|AcceptAll|AcceptMyPhys;
 	} else if ((dev->mc_count > multicast_filter_limit)
-			   ||  (dev->flags & IFF_ALLMULTI)) {
+		   || (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to match, or accept all multicasts. */
 		rx_mode = AcceptBroadcast|AcceptAllMulticast|AcceptMyPhys;
 	} else if (dev->mc_count <= 15) {
 		/* Use the 16 element perfect filter. */
 		long filter_addr = ioaddr + 0x56000 + 1*16;
-		for (i = 1, mclist = dev->mc_list; mclist  &&  i <= dev->mc_count;
-			 i++, mclist = mclist->next) {
+		for (i = 1, mclist = dev->mc_list; mclist && i <= dev->mc_count;
+		     i++, mclist = mclist->next) {
 			u16 *eaddrs = (u16 *)mclist->dmi_addr;
 			writew(cpu_to_be16(eaddrs[2]), filter_addr); filter_addr += 4;
 			writew(cpu_to_be16(eaddrs[1]), filter_addr); filter_addr += 4;
@@ -1219,7 +1652,7 @@
 
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-			 i++, mclist = mclist->next) {
+		     i++, mclist = mclist->next) {
 			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 23, mc_filter);
 		}
 		/* Clear the perfect filter list. */
@@ -1279,7 +1712,7 @@
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	netif_stop_queue(dev);
+	netif_device_detach(dev);
 
 	del_timer_sync(&np->timer);
 
@@ -1301,15 +1734,15 @@
 			   np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
-				   i, le32_to_cpu(np->tx_ring[i].status),
-				   le32_to_cpu(np->tx_ring[i].addr),
-				   le32_to_cpu(np->tx_done_q[i].status));
+			       i, le32_to_cpu(np->tx_ring[i].status),
+			       le32_to_cpu(np->tx_ring[i].first_addr),
+			       le32_to_cpu(np->tx_done_q[i].status));
 		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
-			   np->rx_ring_dma, np->rx_done_q);
+		       np->rx_ring_dma, np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
 				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",
-					   i, le32_to_cpu(np->rx_ring[i].rxaddr), le32_to_cpu(np->rx_done_q[i].status));
+				       i, le32_to_cpu(np->rx_ring[i].rxaddr), le32_to_cpu(np->rx_done_q[i].status));
 		}
 	}
 #endif /* __i386__ debugging only */
@@ -1328,25 +1761,27 @@
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		struct sk_buff *skb = np->tx_info[i].skb;
-		if (skb != NULL) {
-			pci_unmap_single(np->pci_dev,
-					 np->tx_info[i].mapping,
-					 skb->len, PCI_DMA_TODEVICE);
-			dev_kfree_skb(skb);
-		}
+		if (skb == NULL)
+			continue;
+		pci_unmap_single(np->pci_dev,
+				 np->tx_info[i].first_mapping,
+				 skb_first_frag_len(skb), PCI_DMA_TODEVICE);
+		np->tx_info[i].first_mapping = 0;
+		dev_kfree_skb(skb);
 		np->tx_info[i].skb = NULL;
-		np->tx_info[i].mapping = 0;
 	}
 
+	COMPAT_MOD_DEC_USE_COUNT;
+
 	return 0;
 }
 
 
 static void __devexit starfire_remove_one (struct pci_dev *pdev)
 {
-	struct net_device *dev = pdev->driver_data;
+	struct net_device *dev = pci_get_drvdata(pdev);
 	struct netdev_private *np;
-	
+
 	if (!dev)
 		BUG();
 
@@ -1356,7 +1791,7 @@
 	iounmap((char *)dev->base_addr);
 
 	release_mem_region(pci_resource_start (pdev, 0),
-					   pci_resource_len (pdev, 0));
+			   pci_resource_len (pdev, 0));
 
 	if (np->tx_done_q)
 		pci_free_consistent(np->pci_dev, PAGE_SIZE,
@@ -1403,8 +1838,7 @@
  * Local variables:
  *  compile-command: "gcc -DMODULE -Wall -Wstrict-prototypes -O6 -c starfire.c"
  *  simple-compile-command: "gcc -DMODULE -O6 -c starfire.c"
- *  c-indent-level: 4
- *  c-basic-offset: 4
- *  tab-width: 4
+ *  c-basic-offset: 8
+ *  tab-width: 8
  * End:
  */
--- /mnt/3/linux-2.4-ac/drivers/net/starfire_firmware.pl	Thu Feb 15 17:52:05 2001
+++ linux-2.4/drivers/net/starfire_firmware.pl	Thu Feb 15 17:52:19 2001
@@ -0,0 +1,31 @@
+#!/usr/bin/perl
+
+# This script can be used to generate a new starfire_firmware.h
+# from GFP_RX.DAT and GFP_TX.DAT, files included with the DDK
+# and also with the Novell drivers.
+
+open FW, "GFP_RX.DAT" || die;
+open FWH, ">starfire_firmware.h" || die;
+
+printf(FWH "static u32 firmware_rx[] = {\n");
+$counter = 0;
+while ($foo = <FW>) {
+  chomp;
+  printf(FWH "  0x%s, 0x0000%s,\n", substr($foo, 4, 8), substr($foo, 0, 4));
+  $counter++;
+}
+
+close FW;
+open FW, "GFP_TX.DAT" || die;
+
+printf(FWH "};\t/* %d Rx instructions */\n#define FIRMWARE_RX_SIZE %d\n\nstatic u32 firmware_tx[] = {\n", $counter, $counter);
+$counter = 0;
+while ($foo = <FW>) {
+  chomp;
+  printf(FWH "  0x%s, 0x0000%s,\n", substr($foo, 4, 8), substr($foo, 0, 4));
+  $counter++;
+}
+
+close FW;
+printf(FWH "};\t/* %d Tx instructions */\n#define FIRMWARE_TX_SIZE %d\n", $counter, $counter);
+close(FWH);

