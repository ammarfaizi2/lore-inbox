Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbRBLT4o>; Mon, 12 Feb 2001 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129955AbRBLT4h>; Mon, 12 Feb 2001 14:56:37 -0500
Received: from cs.columbia.edu ([128.59.16.20]:1779 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129219AbRBLT4S>;
	Mon, 12 Feb 2001 14:56:18 -0500
Date: Mon, 12 Feb 2001 11:56:10 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new version of the starfire driver for 2.2.19pre
In-Reply-To: <E14SKOc-0007Bz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102121151240.4687-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Alan Cox wrote:

> Ok I didnt realise the firmware thing was tcp checksum paths only. Thats fine

Thanks.

Here is an incremental patch from the version in 2.2.19pre10 to the latest 
version of starfire.c. Please apply, the 2219pre10 version doesn't work if 
compiled-in (because drivers/net builds net.a not net.o). It also fixes 
the MII interface detection problem mentioned by Don Becker.

The patch is longish, but it's mostly whitespace and moving code around. 
It also removes all the code that's #ifdef ZEROCOPY, since Jeff Garzik 
doesn't want it in 2.4.x and it definitely can't work in 2.2.x.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------
--- /usr/src/local/linux-2.2.19pre10-vanilla/drivers/net/starfire.c	Mon Feb 12 11:42:32 2001
+++ linux-2.2.18/drivers/net/starfire.c	Sun Feb 11 16:52:50 2001
@@ -20,7 +20,7 @@
 	-----------------------------------------------------------
 
 	Linux kernel-specific changes:
-	
+
 	LK1.1.1 (jgarzik):
 	- Use PCI driver interface
 	- Fix MOD_xxx races
@@ -31,7 +31,7 @@
 
 	LK1.1.3 (Andrew Morton)
 	- Timer cleanups
-	
+
 	LK1.1.4 (jgarzik):
 	- Merge Becker version 1.03
 
@@ -41,6 +41,17 @@
 
 	LK1.2.2 (Ion Badulescu)
 	- Backported to 2.2.x
+
+	LK1.2.3 (Ion Badulescu)
+	- Fix the flaky mdio interface
+	- More compat clean-ups
+
+	LK1.2.4 (Ion Badulescu)
+	- More 2.2.x initialization fixes
+
+TODO:
+	- implement tx_timeout() properly
+	- support ethtool
 */
 
 /* These identify the driver base version and may not be removed. */
@@ -50,7 +61,7 @@
 " Updates and info at http://www.scyld.com/network/starfire.html\n";
 
 static const char version3[] =
-" (unofficial 2.2.x kernel port, version 1.2.2, February 07, 2001)\n";
+" (unofficial 2.2.x kernel port, version 1.2.4, February 11, 2001)\n";
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -66,8 +77,8 @@
  * for this driver to really use the firmware. Note that Rx/Tx
  * hardware TCP checksumming is not possible without the firmware.
  *
- * I'm currently talking to Adaptec about this redistribution issue.
- * Stay tuned...
+ * I'm currently [Feb 2001] talking to Adaptec about this redistribution
+ * issue. Stay tuned...
  */
 #undef HAS_FIRMWARE
 /*
@@ -75,10 +86,6 @@
  * of length 1. If and when this is fixed, the #define below can be removed.
  */
 #define HAS_BROKEN_FIRMWARE
-/*
- * Define this if using the driver with the zero-copy patch
- */
-#undef ZEROCOPY
 
 /* Used for tuning interrupt latency vs. overhead. */
 static int interrupt_mitigation = 0x0;
@@ -87,12 +94,27 @@
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
@@ -116,29 +138,9 @@
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT  (2*HZ)
-
-#define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
-
-/*
- * The ia64 doesn't allow for unaligned loads even of integers being
- * misaligned on a 2 byte boundary. Thus always force copying of
- * packets as the starfire doesn't allow for misaligned DMAs ;-(
- * 23/10/2000 - Jes
- *
- * Neither does the Alpha. -Ion
- */
-#if defined(__ia64__) || defined(__alpha__)
-#define PKT_SHOULD_COPY(pkt_len)       1
-#else
-#define PKT_SHOULD_COPY(pkt_len)       (pkt_len < rx_copybreak)
-#endif
+#define TX_TIMEOUT	(2*HZ)
 
-#ifdef ZEROCOPY
-#define skb_first_frag_len(skb)	skb_headlen(skb)
-#else  /* not ZEROCOPY */
 #define skb_first_frag_len(skb)	(skb->len)
-#endif /* not ZEROCOPY */
 
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
@@ -146,6 +148,7 @@
 #error You must compile this driver with "-O".
 #endif
 
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -159,58 +162,159 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 
-#include <linux/version.h>
+#ifdef HAS_FIRMWARE
+#include "starfire_firmware.h"
+#endif /* HAS_FIRMWARE */
+
+MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
+MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
+MODULE_PARM(max_interrupt_work, "i");
+MODULE_PARM(mtu, "i");
+MODULE_PARM(debug, "i");
+MODULE_PARM(rx_copybreak, "i");
+MODULE_PARM(interrupt_mitigation, "i");
+MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
+
+/*
+				Theory of Operation
+
+I. Board Compatibility
+
+This driver is for the Adaptec 6915 "Starfire" 64 bit PCI Ethernet adapter.
+
+II. Board-specific settings
+
+III. Driver operation
+
+IIIa. Ring buffers
+
+The Starfire hardware uses multiple fixed-size descriptor queues/rings.  The
+ring sizes are set fixed by the hardware, but may optionally be wrapped
+earlier by the END bit in the descriptor.
+This driver uses that hardware queue size for the Rx ring, where a large
+number of entries has no ill effect beyond increases the potential backlog.
+The Tx ring is wrapped with the END bit, since a large hardware Tx queue
+disables the queue layer priority ordering and we have no mechanism to
+utilize the hardware two-level priority queue.  When modifying the
+RX/TX_RING_SIZE pay close attention to page sizes and the ring-empty warning
+levels.
+
+IIIb/c. Transmit/Receive Structure
+
+See the Adaptec manual for the many possible structures, and options for
+each structure.  There are far too many to document here.
+
+For transmit this driver uses type 0/1 transmit descriptors (depending
+on the presence of the zerocopy patches), and relies on automatic
+minimum-length padding.  It does not use the completion queue
+consumer index, but instead checks for non-zero status entries.
+
+For receive this driver uses type 0 receive descriptors.  The driver
+allocates full frame size skbuffs for the Rx ring buffers, so all frames
+should fit in a single descriptor.  The driver does not use the completion
+queue consumer index, but instead checks for non-zero status entries.
+
+When an incoming frame is less than RX_COPYBREAK bytes long, a fresh skbuff
+is allocated and the frame is copied to the new skbuff.  When the incoming
+frame is larger, the skbuff is passed directly up the protocol stack.
+Buffers consumed this way are replaced by newly allocated skbuffs in a later
+phase of receive.
+
+A notable aspect of operation is that unaligned buffers are not permitted by
+the Starfire hardware.  The IP header at offset 14 in an ethernet frame thus
+isn't longword aligned, which may cause problems on some machine
+e.g. Alphas and IA64. For these architectures, the driver is forced to copy
+the frame into a new skbuff unconditionally. Copied frames are put into the
+skbuff at an offset of "+2", thus 16-byte aligning the IP header.
+
+IIId. Synchronization
+
+The driver runs as two independent, single-threaded flows of control.  One
+is the send-packet routine, which enforces single-threaded use by the
+dev->tbusy flag.  The other thread is the interrupt handler, which is single
+threaded by the hardware and interrupt handling software.
+
+The send packet thread has partial control over the Tx ring and 'dev->tbusy'
+flag.  It sets the tbusy flag whenever it's queuing a Tx packet. If the next
+queue slot is empty, it clears the tbusy flag when finished otherwise it sets
+the 'lp->tx_full' flag.
+
+The interrupt handler has exclusive control over the Rx ring and records stats
+from the Tx ring.  After reaping the stats, it marks the Tx queue entry as
+empty by incrementing the dirty_tx mark. Iff the 'lp->tx_full' flag is set, it
+clears both the tx_full and tbusy flags.
+
+IV. Notes
+
+IVb. References
+
+The Adaptec Starfire manuals, available only from Adaptec.
+http://www.scyld.com/expert/100mbps.html
+http://www.scyld.com/expert/NWay.html
+
+IVc. Errata
+
+*/
+
+
+
+/* 2.2.x compatibility code */
 #if LINUX_VERSION_CODE < 0x20300
 #include <linux/kcomp.h>
 
 static LIST_HEAD(pci_drivers);
 
 struct pci_driver_mapping {
-        struct pci_dev *dev;
-        struct pci_driver *drv;
-        void *driver_data;
+	struct pci_dev *dev;
+	struct pci_driver *drv;
+	void *driver_data;
 };
 
 struct pci_device_id {
-        unsigned int vendor, device;
-        unsigned int subvendor, subdevice;
-        unsigned int class, class_mask;
-        unsigned long driver_data;
+	unsigned int vendor, device;
+	unsigned int subvendor, subdevice;
+	unsigned int class, class_mask;
+	unsigned long driver_data;
 };
 
 struct pci_driver {
-        struct list_head node;
-        struct pci_dev *dev;
-        char *name;
-        const struct pci_device_id *id_table;   /* NULL if wants all devices */
-        int (*probe)(struct pci_dev *dev, const struct pci_device_id *id);      /* New device inserted */
-        void (*remove)(struct pci_dev *dev);    /* Device removed (NULL if not a hot-plug capable driver) */
-        void (*suspend)(struct pci_dev *dev);   /* Device suspended */
-        void (*resume)(struct pci_dev *dev);    /* Device woken up */
+	struct list_head node;
+	struct pci_dev *dev;
+	char *name;
+	const struct pci_device_id *id_table;	/* NULL if wants all devices */
+	int (*probe)(struct pci_dev *dev, const struct pci_device_id *id);		/* New device inserted */
+	void (*remove)(struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
+	void (*suspend)(struct pci_dev *dev);	/* Device suspended */
+	void (*resume)(struct pci_dev *dev);	/* Device woken up */
 };
 
 #define PCI_MAX_MAPPINGS 16
 static struct pci_driver_mapping drvmap [PCI_MAX_MAPPINGS] = { { NULL, } , };
 
-#define __devinit
-#define __devinitdata
+#define __devinit			__init
+#define __devinitdata			__initdata
 #define __devexit
 #define MODULE_DEVICE_TABLE(foo,bar)
+#define SET_MODULE_OWNER(dev)
+#define COMPAT_MOD_INC_USE_COUNT	MOD_INC_USE_COUNT
+#define COMPAT_MOD_DEC_USE_COUNT	MOD_DEC_USE_COUNT
 #define PCI_ANY_ID (~0)
-#define IORESOURCE_MEM          2
-#define PCI_DMA_FROMDEVICE 0
-#define PCI_DMA_TODEVICE 0
+#define IORESOURCE_MEM			2
+#define PCI_DMA_FROMDEVICE		0
+#define PCI_DMA_TODEVICE		0
 
 #define request_mem_region(addr, size, name)	((void *)1)
 #define release_mem_region(addr, size)
 #define del_timer_sync(timer)	del_timer(timer)
 
 static inline void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-										 dma_addr_t *dma_handle)
+					 dma_addr_t *dma_handle)
 {
 	void *virt_ptr;
 
@@ -222,7 +326,7 @@
 #define pci_map_single(cookie, address, size, dir)	virt_to_bus(address)
 #define pci_unmap_single(cookie, address, size, dir)
 #define pci_dma_sync_single(cookie, address, size, dir)
-#undef  pci_resource_flags
+#undef	pci_resource_flags
 #define pci_resource_flags(dev, i) \
   ((dev->base_address[i] & IORESOURCE_IO) ? IORESOURCE_IO : IORESOURCE_MEM)
 
@@ -282,19 +386,22 @@
 		id = NULL;
 
 	found = 0;
-	for (i = 0; i < PCI_MAX_MAPPINGS && !found; i++)
+	for (i = 0; i < PCI_MAX_MAPPINGS; i++)
 		if (!drvmap[i].dev) {
 			drvmap[i].dev = dev;
 			drvmap[i].drv = drv;
 			found = 1;
+			break;
 		}
 
-	if (drv->probe(dev, id) >= 0) {
-		if(found)
-			return 1;
-	} else {
-		drvmap[i - 1].dev = NULL;
-	}
+	if (!found)
+		return 0;
+
+	if (drv->probe(dev, id) >= 0)
+		return 1;
+
+	/* clean up */
+	drvmap[i].dev = NULL;
 	return 0;
 }
 
@@ -326,13 +433,15 @@
 	list_del(&drv->node);
 	for (dev = pci_devices; dev; dev = dev->next) {
 		found = 0;
-		for (i = 0; i < PCI_MAX_MAPPINGS && !found; i++)
-			if (drvmap[i].dev == dev)
+		for (i = 0; i < PCI_MAX_MAPPINGS; i++)
+			if (drvmap[i].dev == dev) {
 				found = 1;
+				break;
+			}
 		if (found) {
 			if (drv->remove)
 				drv->remove(dev);
-			drvmap[i - 1].dev = NULL;
+			drvmap[i].dev = NULL;
 		}
 	}
 #endif
@@ -348,116 +457,46 @@
 
 static inline int pci_module_init(struct pci_driver *drv)
 {
-	int rc = pci_register_driver (drv);
-
-	if (rc > 0)
+	if (pci_register_driver(drv))
 		return 0;
-
-	/* if we get here, we need to clean up pci driver instance
-	 * and return some sort of error */
-	pci_unregister_driver (drv);
-
 	return -ENODEV;
 }
 
-#endif /* LINUX_VERSION_CODE < 0x20300 */
-
-#ifdef HAS_FIRMWARE
-#include "starfire_firmware.h"
-#endif /* HAS_FIRMWARE */
+static struct pci_driver starfire_driver;
 
-MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
-MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
-MODULE_PARM(max_interrupt_work, "i");
-MODULE_PARM(mtu, "i");
-MODULE_PARM(debug, "i");
-MODULE_PARM(rx_copybreak, "i");
-MODULE_PARM(interrupt_mitigation, "i");
-MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
-
-/*
-				Theory of Operation
-
-I. Board Compatibility
-
-This driver is for the Adaptec 6915 "Starfire" 64 bit PCI Ethernet adapter.
-
-II. Board-specific settings
-
-III. Driver operation
-
-IIIa. Ring buffers
-
-The Starfire hardware uses multiple fixed-size descriptor queues/rings.  The
-ring sizes are set fixed by the hardware, but may optionally be wrapped
-earlier by the END bit in the descriptor.
-This driver uses that hardware queue size for the Rx ring, where a large
-number of entries has no ill effect beyond increases the potential backlog.
-The Tx ring is wrapped with the END bit, since a large hardware Tx queue
-disables the queue layer priority ordering and we have no mechanism to
-utilize the hardware two-level priority queue.  When modifying the
-RX/TX_RING_SIZE pay close attention to page sizes and the ring-empty warning
-levels.
-
-IIIb/c. Transmit/Receive Structure
-
-See the Adaptec manual for the many possible structures, and options for
-each structure.  There are far too many to document here.
-
-For transmit this driver uses type 0/1 transmit descriptors (depending
-on the presence of the zerocopy patches), and relies on automatic
-minimum-length padding.  It does not use the completion queue
-consumer index, but instead checks for non-zero status entries.
-
-For receive this driver uses type 0 receive descriptors.  The driver
-allocates full frame size skbuffs for the Rx ring buffers, so all frames
-should fit in a single descriptor.  The driver does not use the completion
-queue consumer index, but instead checks for non-zero status entries.
-
-When an incoming frame is less than RX_COPYBREAK bytes long, a fresh skbuff
-is allocated and the frame is copied to the new skbuff.  When the incoming
-frame is larger, the skbuff is passed directly up the protocol stack.
-Buffers consumed this way are replaced by newly allocated skbuffs in a
-later phase of receive.
-
-A notable aspect of operation is that unaligned buffers are not permitted by
-the Starfire hardware.  The IP header at offset 14 in an ethernet frame thus
-isn't longword aligned, which may cause problems on some machine
-e.g. Alphas and IA64. For these architectures, the driver is forced to copy
-the frame into a new skbuff unconditionally. Copied frames are put into the
-skbuff at an offset of "+2", thus 16-byte aligning the IP header.
-
-IIId. Synchronization
+int __init starfire_probe(struct net_device *dev)
+{
+	static int __initdata probed = 0;
 
-The driver runs as two independent, single-threaded flows of control.  One
-is the send-packet routine, which enforces single-threaded use by the
-dev->tbusy flag.  The other thread is the interrupt handler, which is single
-threaded by the hardware and interrupt handling software.
+	if (probed)
+		return -ENODEV;
+	probed++;
 
-The send packet thread has partial control over the Tx ring and 'dev->tbusy'
-flag.  It sets the tbusy flag whenever it's queuing a Tx packet. If the next
-queue slot is empty, it clears the tbusy flag when finished otherwise it sets
-the 'lp->tx_full' flag.
+	return pci_module_init(&starfire_driver);
+}
 
-The interrupt handler has exclusive control over the Rx ring and records stats
-from the Tx ring.  After reaping the stats, it marks the Tx queue entry as
-empty by incrementing the dirty_tx mark. Iff the 'lp->tx_full' flag is set, it
-clears both the tx_full and tbusy flags.
+#define init_tx_timer(dev, func, timeout)
+#define kick_tx_timer(dev, func, timeout) \
+	if (netif_queue_stopped(dev)) { \
+		/* If this happens network layer tells us we're broken. */ \
+		if (jiffies - dev->trans_start > timeout) \
+			func(dev); \
+	}
 
-IV. Notes
+#else  /* LINUX_VERSION_CODE > 0x20300 */
 
-IVb. References
+#define COMPAT_MOD_INC_USE_COUNT
+#define COMPAT_MOD_DEC_USE_COUNT
 
-The Adaptec Starfire manuals, available only from Adaptec.
-http://www.scyld.com/expert/100mbps.html
-http://www.scyld.com/expert/NWay.html
+#define init_tx_timer(dev, func, timeout) \
+	dev->tx_timeout = func; \
+	dev->watchdog_timeo = timeout;
+#define kick_tx_timer(dev, func, timeout)
 
-IVc. Errata
 
-*/
+#endif /* LINUX_VERSION_CODE > 0x20300 */
+/* end of compatibility code */
 
-
 
 enum chip_capability_flags {CanHaveMII=1, };
 #define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR0)
@@ -574,7 +613,7 @@
 
 /* The Rx and Tx buffer descriptors. */
 struct starfire_rx_desc {
-	u32 rxaddr;					/* Optionally 64 bits. */
+	u32 rxaddr;			/* Optionally 64 bits. */
 };
 enum rx_desc_bits {
 	RxDescValid=1, RxDescEndRing=2,
@@ -587,14 +626,14 @@
 #define csum_rx_status
 #endif /* HAS_FIRMWARE */
 struct rx_done_desc {
-	u32 status;					/* Low 16 bits is length. */
+	u32 status;			/* Low 16 bits is length. */
 #ifdef csum_rx_status
-	u32 status2;				/* Low 16 bits is csum */
+	u32 status2;			/* Low 16 bits is csum */
 #endif /* csum_rx_status */
 #ifdef full_rx_status
 	u32 status2;
 	u16 vlanid;
-	u16 csum; 			/* partial checksum */
+	u16 csum;			/* partial checksum */
 	u32 timestamp;
 #endif /* full_rx_status */
 };
@@ -602,41 +641,24 @@
 	RxOK=0x20000000, RxFIFOErr=0x10000000, RxBufQ2=0x08000000,
 };
 
-#ifdef ZEROCOPY
-/* Type 0 Tx descriptor. */
-/* If more fragments are needed, don't forget to change the
-   descriptor spacing as well! */
-struct starfire_tx_desc {
-	u32 status;
-	u32 nbufs;
-	u32 first_addr;
-	u16 first_len;
-	u16 total_len;
-	struct {
-		u32 addr;
-		u32 len;
-	} frag[6];
-};
-#else  /* not ZEROCOPY */
 /* Type 1 Tx descriptor. */
 struct starfire_tx_desc {
-	u32 status;					/* Upper bits are status, lower 16 length. */
+	u32 status;			/* Upper bits are status, lower 16 length. */
 	u32 first_addr;
 };
-#endif /* not ZEROCOPY */
 enum tx_desc_bits {
 	TxDescID=0xB0000000,
 	TxCRCEn=0x01000000, TxDescIntr=0x08000000,
 	TxRingWrap=0x04000000, TxCalTCP=0x02000000,
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
+#define PRIV_ALIGN	15	/* Required alignment mask */
 struct rx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t mapping;
@@ -644,9 +666,6 @@
 struct tx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t first_mapping;
-#ifdef ZEROCOPY
-	dma_addr_t frag_mapping[6];
-#endif /* ZEROCOPY */
 };
 
 struct netdev_private {
@@ -670,45 +689,45 @@
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
+	unsigned char phys[2];		/* MII device addresses. */
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
@@ -717,13 +736,14 @@
 	static int printed_version = 0;
 	long ioaddr;
 	int drv_flags, io_size;
+	int boguscnt;
 
 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 
 	if (!printed_version++)
 		printk(KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
-		       version1, version2, version3);
+			   version1, version2, version3);
 
 	if (pci_enable_device (pdev))
 		return -EIO;
@@ -734,21 +754,22 @@
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
-	
-	irq = pdev->irq; 
+	SET_MODULE_OWNER(dev);
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
@@ -757,34 +778,42 @@
 	}
 
 	pci_set_master (pdev);
-	
+
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, netdrv_tbl[chip_idx].name, ioaddr);
 
-#ifdef ZEROCOPY
-	/* Starfire can do SG and TCP/UDP checksumming */
-	dev->features |= NETIF_F_SG;
-#ifdef HAS_FIRMWARE
-	dev->features |= NETIF_F_IP_CSUM;
-#endif /* HAS_FIRMWARE */
-#endif /* ZEROCOPY */
-
 	/* Serial EEPROM reads are hidden by the hardware. */
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
@@ -806,7 +835,7 @@
 		if (np->default_port)
 			np->medialock = 1;
 	}
-	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
+	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
 		np->full_duplex = 1;
 
 	if (np->full_duplex)
@@ -815,6 +844,7 @@
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
 	dev->hard_start_xmit = &start_tx;
+	init_tx_timer(dev, tx_timeout, TX_TIMEOUT);
 	dev->stop = &netdev_close;
 	dev->get_stats = &get_stats;
 	dev->set_multicast_list = &set_rx_mode;
@@ -825,14 +855,27 @@
 
 	if (drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
+		int mii_status;
 		for (phy = 0; phy < 32 && phy_idx < 4; phy++) {
-			int mii_status = mdio_read(dev, phy, 1);
-			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
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
@@ -858,7 +901,11 @@
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
 
@@ -879,11 +926,11 @@
 
 	/* Do we ever need to reset the chip??? */
 
-	MOD_INC_USE_COUNT;
+	COMPAT_MOD_INC_USE_COUNT;
 
 	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
 	if (retval) {
-		MOD_DEC_USE_COUNT;
+		COMPAT_MOD_DEC_USE_COUNT;
 		return retval;
 	}
 
@@ -892,7 +939,7 @@
 	writel(1, ioaddr + PCIDeviceConfig);
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
-			   dev->name, dev->irq);
+		       dev->name, dev->irq);
 	/* Allocate the various queues, failing gracefully. */
 	if (np->tx_done_q == 0)
 		np->tx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_done_q_dma);
@@ -902,47 +949,38 @@
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
 			pci_free_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE,
-								np->rx_done_q, np->rx_done_q_dma);
+					    np->rx_done_q, np->rx_done_q_dma);
 		if (np->tx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-								np->tx_ring, np->tx_ring_dma);
+					    np->tx_ring, np->tx_ring_dma);
 		if (np->rx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-								np->rx_ring, np->rx_ring_dma);
-		MOD_DEC_USE_COUNT;
+					    np->rx_ring, np->rx_ring_dma);
+		COMPAT_MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
 	init_ring(dev);
 	/* Set the size of the Rx buffers. */
 	writel((np->rx_buf_sz << RxBufferLenShift) |
-		   (0 << RxMinDescrThreshShift) |
-		   RxPrefetchMode | RxVariableQ |
-		   RxDescSpace4,
-		   ioaddr + RxDescQCtrl);
+	       (0 << RxMinDescrThreshShift) |
+	       RxPrefetchMode | RxVariableQ |
+	       RxDescSpace4,
+	       ioaddr + RxDescQCtrl);
 
-#ifdef ZEROCOPY
-	/* Set Tx descriptor to type 0 and spacing to 64 bytes. */
-	writel((2 << TxHiPriFIFOThreshShift) |
-	       (0 << TxPadLenShift) |
-	       (4 << TxDMABurstSizeShift) |
-	       TxDescSpace64 | TxDescType0,
-	       ioaddr + TxDescCtrl);
-#else  /* not ZEROCOPY */
 	/* Set Tx descriptor to type 1 and padding to 0 bytes. */
 	writel((2 << TxHiPriFIFOThreshShift) |
 	       (0 << TxPadLenShift) |
 	       (4 << TxDMABurstSizeShift) |
 	       TxDescSpaceUnlim | TxDescType1,
 	       ioaddr + TxDescCtrl);
-#endif /* not ZEROCOPY */
 
 #if defined(ADDR_64BITS) && defined(__alpha__)
 	/* XXX We really need a 64-bit PCI dma interfaces too... -DaveM */
@@ -959,25 +997,25 @@
 	writel(np->tx_done_q_dma, ioaddr + TxCompletionAddr);
 #ifdef full_rx_status
 	writel(np->rx_done_q_dma |
-		   RxComplType3 |
-		   (0 << RxComplThreshShift),
-		   ioaddr + RxCompletionAddr);
+	       RxComplType3 |
+	       (0 << RxComplThreshShift),
+	       ioaddr + RxCompletionAddr);
 #else  /* not full_rx_status */
 #ifdef csum_rx_status
 	writel(np->rx_done_q_dma |
-		   RxComplType2 |
-		   (0 << RxComplThreshShift),
-		   ioaddr + RxCompletionAddr);
+	       RxComplType2 |
+	       (0 << RxComplThreshShift),
+	       ioaddr + RxCompletionAddr);
 #else  /* not csum_rx_status */
 	writel(np->rx_done_q_dma |
-		   RxComplType0 |
-		   (0 << RxComplThreshShift),
-		   ioaddr + RxCompletionAddr);
+	       RxComplType0 |
+	       (0 << RxComplThreshShift),
+	       ioaddr + RxCompletionAddr);
 #endif /* not csum_rx_status */
 #endif /* not full_rx_status */
 
 	if (debug > 1)
-		printk(KERN_DEBUG "%s:  Filling in the station address.\n", dev->name);
+		printk(KERN_DEBUG "%s: Filling in the station address.\n", dev->name);
 
 	/* Fill both the unused Tx SA register and the Rx perfect filter. */
 	for (i = 0; i < 6; i++)
@@ -1003,7 +1041,7 @@
 	netif_start_queue(dev);
 
 	if (debug > 1)
-		printk(KERN_DEBUG "%s:  Setting the Rx and Tx modes.\n", dev->name);
+		printk(KERN_DEBUG "%s: Setting the Rx and Tx modes.\n", dev->name);
 	set_rx_mode(dev);
 
 	np->advertising = mdio_read(dev, np->phys[0], 4);
@@ -1016,7 +1054,7 @@
 	       IntrRxGFPDead | IntrNoTxCsum | IntrTxBadID,
 	       ioaddr + IntrEnable);
 	writel(0x00800000 | readl(ioaddr + PCIDeviceConfig),
-		   ioaddr + PCIDeviceConfig);
+	       ioaddr + PCIDeviceConfig);
 
 #ifdef HAS_FIRMWARE
 	/* Load Rx/Tx firmware into the frame processors */
@@ -1033,7 +1071,7 @@
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done netdev_open().\n",
-			   dev->name);
+		       dev->name);
 
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
@@ -1066,8 +1104,8 @@
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
@@ -1086,7 +1124,7 @@
 
 	if (debug > 3) {
 		printk(KERN_DEBUG "%s: Media selection timer tick, status %8.8x.\n",
-			   dev->name, (int)readl(ioaddr + IntrStatus));
+		       dev->name, (int)readl(ioaddr + IntrStatus));
 	}
 	check_duplex(dev, 0);
 #if ! defined(final_version)
@@ -1096,7 +1134,7 @@
 		/* Bogus hardware IRQ: Fake an interrupt handler call. */
 		if (new_status & 1) {
 			printk(KERN_ERR "%s: Interrupt blocked, status %8.8x/%8.8x.\n",
-				   dev->name, new_status, (int)readl(ioaddr + IntrStatus));
+			       dev->name, new_status, (int)readl(ioaddr + IntrStatus));
 			intr_handler(dev->irq, dev, 0);
 		}
 	}
@@ -1112,7 +1150,7 @@
 	long ioaddr = dev->base_addr;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
-		   " resetting...\n", dev->name, (int)readl(ioaddr + IntrStatus));
+	       " resetting...\n", dev->name, (int)readl(ioaddr + IntrStatus));
 
 #ifndef __alpha__
 	{
@@ -1183,13 +1221,6 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_info[i].skb = NULL;
 		np->tx_info[i].first_mapping = 0;
-#ifdef ZEROCOPY
-		{
-			int j;
-			for (j = 0; j < 6; j++)
-				np->tx_info[i].frag_mapping[j] = 0;
-		}
-#endif /* ZEROCOPY */
 		np->tx_ring[i].status = 0;
 	}
 	return;
@@ -1199,15 +1230,8 @@
 {
 	struct netdev_private *np = dev->priv;
 	unsigned int entry;
-#ifdef ZEROCOPY
-	int i;
-#endif
 
-	if (netif_queue_stopped(dev)) {
-		/* If this happens network layer tells us we're broken. */
-		if (jiffies - dev->trans_start > TX_TIMEOUT)
-			tx_timeout(dev);
-	}
+	kick_tx_timer(dev, tx_timeout, TX_TIMEOUT);
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -1215,80 +1239,22 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
-#if defined(ZEROCOPY) && defined(HAS_FIRMWARE) && defined(HAS_BROKEN_FIRMWARE)
-	{
-		int has_bad_length = 0;
-
-		if (skb_first_frag_len(skb) == 1)
-			has_bad_length = 1;
-		else {
-			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-				if (skb_shinfo(skb)->frags[i].size == 1) {
-					has_bad_length = 1;
-					break;
-				}
-		}
-
-		if (has_bad_length)
-			skb_checksum_help(skb);
-	}
-#endif /* ZEROCOPY && HAS_FIRMWARE && HAS_BROKEN_FIRMWARE */
-
 	np->tx_info[entry].skb = skb;
 	np->tx_info[entry].first_mapping =
 		pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
 
 	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
-#ifdef ZEROCOPY
-	np->tx_ring[entry].first_len = cpu_to_le32(skb_first_frag_len(skb));
-	np->tx_ring[entry].total_len = cpu_to_le32(skb->len);
-	/* Add  "| TxDescIntr" to generate Tx-done interrupts. */
-	np->tx_ring[entry].status = cpu_to_le32(TxDescID | TxCRCEn);
-	np->tx_ring[entry].nbufs = cpu_to_le32(skb_shinfo(skb)->nr_frags + 1);
-#else  /* not ZEROCOPY */
-	/* Add  "| TxDescIntr" to generate Tx-done interrupts. */
+	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
 	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID | TxCRCEn | 1 << 16);
-#endif /* not ZEROCOPY */
 
 	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
 		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
 
-	/* not ifdef'ed, but shouldn't happen without ZEROCOPY */
-	if (skb->ip_summed == CHECKSUM_HW)
-		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
-
 	if (debug > 5) {
-#ifdef ZEROCOPY
-		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x nbufs %d len %4.4x/%4.4x.\n",
-			   dev->name, np->cur_tx, entry,
-			   le32_to_cpu(np->tx_ring[entry].status),
-			   le32_to_cpu(np->tx_ring[entry].nbufs),
-			   le32_to_cpu(np->tx_ring[entry].first_len),
-			   le32_to_cpu(np->tx_ring[entry].total_len));
-#else  /* not ZEROCOPY */
 		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x.\n",
-			   dev->name, np->cur_tx, entry,
-			   le32_to_cpu(np->tx_ring[entry].status));
-#endif /* not ZEROCOPY */
-	}
-
-#ifdef ZEROCOPY
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		skb_frag_t *this_frag = &skb_shinfo(skb)->frags[i];
-
-		/* we already have the proper value in entry */
-		np->tx_info[entry].frag_mapping[i] =
-			pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
-
-		np->tx_ring[entry].frag[i].addr = cpu_to_le32(np->tx_info[entry].frag_mapping[i]);
-		np->tx_ring[entry].frag[i].len = cpu_to_le32(this_frag->size);
-		if (debug > 5) {
-			printk(KERN_DEBUG "%s: Tx #%d frag %d len %4.4x.\n",
-				   dev->name, np->cur_tx, i,
-				   le32_to_cpu(np->tx_ring[entry].frag[i].len));
-		}
+		       dev->name, np->cur_tx, entry,
+		       le32_to_cpu(np->tx_ring[entry].status));
 	}
-#endif /* ZEROCOPY */
 
 	np->cur_tx++;
 
@@ -1322,11 +1288,12 @@
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
@@ -1339,7 +1306,7 @@
 
 		if (debug > 4)
 			printk(KERN_DEBUG "%s: Interrupt status %4.4x.\n",
-				   dev->name, intr_status);
+			       dev->name, intr_status);
 
 		if (intr_status == 0)
 			break;
@@ -1350,63 +1317,48 @@
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
-#ifdef ZEROCOPY
-					int i;
-#endif /* ZEROCOPY */
-					u16 entry = tx_status; 		/* Implicit truncate */
-					entry /= sizeof(struct starfire_tx_desc);
-
-					skb = np->tx_info[entry].skb;
-					np->tx_info[entry].skb = NULL;
-					pci_unmap_single(np->pci_dev,
-									 np->tx_info[entry].first_mapping,
-									 skb_first_frag_len(skb),
-									 PCI_DMA_TODEVICE);
-					np->tx_info[entry].first_mapping = 0;
-
-#ifdef ZEROCOPY
-					for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-						pci_unmap_single(np->pci_dev,
-										 np->tx_info[entry].frag_mapping[i],
-										 skb_shinfo(skb)->frags[i].size,
-										 PCI_DMA_TODEVICE);
-						np->tx_info[entry].frag_mapping[i] = 0;
-					}
-#endif /* ZEROCOPY */
 
-					/* Scavenge the descriptor. */
-					dev_kfree_skb_irq(skb);
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
 
-					np->dirty_tx++;
-				}
-				np->tx_done_q[np->tx_done].status = 0;
-				np->tx_done = (np->tx_done+1) & (DONE_Q_SIZE-1);
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
@@ -1419,23 +1371,23 @@
 
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
@@ -1452,98 +1404,99 @@
 
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
-			skb->protocol = eth_type_trans(skb, dev);
+		skb->protocol = eth_type_trans(skb, dev);
 #if defined(full_rx_status) || defined(csum_rx_status)
-			if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000) {
-				skb->ip_summed = CHECKSUM_UNNECESSARY;
-			}
-			/*
-			 * This feature doesn't seem to be working, at least
-			 * with the two firmware versions I have. If the GFP sees
-			 * a fragment, it either ignores it completely, or reports
-			 * "bad checksum" on it.
-			 *
-			 * Maybe I missed something -- corrections are welcome.
-			 * Until then, the printk stays. :-) -Ion
-			 */
-			else if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x00400000) {
-				skb->ip_summed = CHECKSUM_HW;
-				skb->csum = le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0xffff;
-				printk(KERN_DEBUG "%s: checksum_hw, status2 = %x\n", dev->name, np->rx_done_q[np->rx_done].status2);
-			}
-#endif
-			netif_rx(skb);
-			dev->last_rx = jiffies;
-			np->stats.rx_packets++;
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
@@ -1558,10 +1511,10 @@
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
@@ -1572,10 +1525,10 @@
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
@@ -1587,9 +1540,9 @@
 
 	if (intr_status & IntrLinkChange) {
 		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
-			   " %4.4x  partner %4.4x.\n", dev->name,
-			   mdio_read(dev, np->phys[0], 4),
-			   mdio_read(dev, np->phys[0], 5));
+		       " %4.4x, partner %4.4x.\n", dev->name,
+		       mdio_read(dev, np->phys[0], 4),
+		       mdio_read(dev, np->phys[0], 5));
 		check_duplex(dev, 0);
 	}
 	if (intr_status & IntrStatsMax) {
@@ -1598,10 +1551,9 @@
 	/* Came close to underrunning the Tx FIFO, increase threshold. */
 	if (intr_status & IntrTxDataLow)
 		writel(++np->tx_threshold, dev->base_addr + TxThreshold);
-	if ((intr_status &
-		 ~(IntrAbnormalSummary|IntrLinkChange|IntrStatsMax|IntrTxDataLow|1)) && debug)
+	if ((intr_status & ~(IntrAbnormalSummary|IntrLinkChange|IntrStatsMax|IntrTxDataLow|1)) && debug)
 		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
-			   dev->name, intr_status);
+		       dev->name, intr_status);
 	/* Hmmmmm, it's not clear how to recover from DMA faults. */
 	if (intr_status & IntrDMAErr)
 		np->stats.tx_fifo_errors++;
@@ -1619,12 +1571,13 @@
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
@@ -1665,19 +1618,19 @@
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
@@ -1696,7 +1649,7 @@
 
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
-			 i++, mclist = mclist->next) {
+		     i++, mclist = mclist->next) {
 			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 23, mc_filter);
 		}
 		/* Clear the perfect filter list. */
@@ -1778,15 +1731,15 @@
 			   np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
-				   i, le32_to_cpu(np->tx_ring[i].status),
-				   le32_to_cpu(np->tx_ring[i].first_addr),
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
@@ -1805,31 +1758,17 @@
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		struct sk_buff *skb = np->tx_info[i].skb;
-#ifdef ZEROCOPY
-		int j;
-#endif /* ZEROCOPY */
-		if (skb != NULL) {
-			pci_unmap_single(np->pci_dev,
-					 np->tx_info[i].first_mapping,
-					 skb_first_frag_len(skb), PCI_DMA_TODEVICE);
-			np->tx_info[i].first_mapping = 0;
-			dev_kfree_skb(skb);
-			np->tx_info[i].skb = NULL;
-#ifdef ZEROCOPY
-			for (j = 0; j < 6; j++)
-				if (np->tx_info[i].frag_mapping[j]) {
-					pci_unmap_single(np->pci_dev,
-									 np->tx_info[i].frag_mapping[j],
-									 skb_shinfo(skb)->frags[j].size,
-									 PCI_DMA_TODEVICE);
-					np->tx_info[i].frag_mapping[j] = 0;
-				} else
-					break;
-#endif /* ZEROCOPY */
-		}
+		if (skb == NULL)
+			continue;
+		pci_unmap_single(np->pci_dev,
+				 np->tx_info[i].first_mapping,
+				 skb_first_frag_len(skb), PCI_DMA_TODEVICE);
+		np->tx_info[i].first_mapping = 0;
+		dev_kfree_skb(skb);
+		np->tx_info[i].skb = NULL;
 	}
 
-	MOD_DEC_USE_COUNT;
+	COMPAT_MOD_DEC_USE_COUNT;
 
 	return 0;
 }
@@ -1839,7 +1778,7 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct netdev_private *np;
-	
+
 	if (!dev)
 		BUG();
 
@@ -1849,7 +1788,7 @@
 	iounmap((char *)dev->base_addr);
 
 	release_mem_region(pci_resource_start (pdev, 0),
-					   pci_resource_len (pdev, 0));
+			   pci_resource_len (pdev, 0));
 
 	if (np->tx_done_q)
 		pci_free_consistent(np->pci_dev, PAGE_SIZE,
@@ -1896,8 +1835,7 @@
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
