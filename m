Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268147AbTBNAFZ>; Thu, 13 Feb 2003 19:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbTBNAFZ>; Thu, 13 Feb 2003 19:05:25 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:21736
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S268147AbTBNAEv>; Thu, 13 Feb 2003 19:04:51 -0500
Date: Thu, 13 Feb 2003 19:13:29 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [net drvr] starfire driver update for 2.5.60
Message-ID: <Pine.LNX.4.44.0302131859550.13539-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a rather large update for the starfire network driver,
implementing VLAN support, 64-bit dma_addr_t support, and NAPI support. It
also fixes a couple of show-stopper bugs in the old driver which were
biting real people out there.

I've had a few positive test results with this version, including one from
Martin Bligh who tested it on his monster SMP boxes. So I'm pretty
confident that it's mostly all right, and certainly better than what's
currently in the tree.

Please apply, thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-----------------------------------------------------
--- linux-2.5.60/drivers/net/Kconfig.old	Thu Feb 13 16:15:20 2003
+++ linux-2.5.60/drivers/net/Kconfig	Thu Feb 13 16:18:17 2003
@@ -1258,6 +1258,18 @@
 	  say M here and read <file:Documentation/modules.txt>.  This is
 	  recommended.  The module will be called starfire.
 
+config ADAPTEC_STARFIRE_NAPI
+	bool "Use Rx Polling (NAPI) (EXPERIMENTAL)"
+	depends on ADAPTEC_STARFIRE && EXPERIMENTAL
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
 config AC3200
 	tristate "Ansel Communications EISA 3200 support (EXPERIMENTAL)"
 	depends on NET_PCI && (ISA || EISA) && EXPERIMENTAL
--- linux-2.5.60/drivers/net/starfire.c.old	Thu Feb 13 15:22:31 2003
+++ linux-2.5.60/drivers/net/starfire.c	Mon Feb 10 17:33:36 2003
@@ -4,7 +4,7 @@
 
 	Current maintainer is Ion Badulescu <ionut@cs.columbia.edu>. Please
 	send all bug reports to me, and not to Donald Becker, as this code
-	has been modified quite a bit from Donald's original version.
+	has been heavily modified from Donald's original version.
 
 	This software may be used and distributed according to the terms of
 	the GNU General Public License (GPL), incorporated herein by reference.
@@ -13,6 +13,8 @@
 	a complete program and may only be used when the entire operating
 	system is licensed under the GPL.
 
+	The information below comes from Donald Becker's original driver:
+
 	The author may be reached as becker@scyld.com, or C/O
 	Scyld Computing Corporation
 	410 Severn Ave., Suite 210
@@ -101,15 +103,40 @@
 	- Better stats and error handling (Ion Badulescu)
 	- Use new pci_set_mwi() PCI API function (jgarzik)
 
-TODO:
-	- implement tx_timeout() properly
+	LK1.3.7 (Ion Badulescu)
+	- minimal implementation of tx_timeout()
+	- correctly shutdown the Rx/Tx engines in netdev_close()
+	- added calls to netif_carrier_on/off
+	(patch from Stefan Rompf <srompf@isg.de>)
 	- VLAN support
+
+	LK1.3.8 (Ion Badulescu)
+	- adjust DMA burst size on sparc64
+	- 64-bit support
+	- reworked zerocopy support for 64-bit buffers
+	- working and usable interrupt mitigation/latency
+	- reduced Tx interrupt frequency for lower interrupt overhead
+
+	LK1.3.9 (Ion Badulescu)
+	- bugfix for mcast filter
+	- enable the right kind of Tx interrupts (TxDMADone, not TxDone)
+
+	LK1.4.0 (Ion Badulescu)
+	- NAPI support
+
+	LK1.4.1 (Ion Badulescu)
+	- flush PCI posting buffers after disabling Rx interrupts
+	- put the chip to a D3 slumber on driver unload
+	- added config option to enable/disable NAPI
+
+TODO:	bugfixes (no bugs known as of right now)
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.3.6"
-#define DRV_RELDATE	"March 7, 2002"
+#define DRV_VERSION	"1.03+LK1.4.1"
+#define DRV_RELDATE	"February 10, 2002"
 
+#include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -118,27 +145,23 @@
 #include <linux/etherdevice.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/crc32.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
 /*
- * Adaptec's license for their Novell drivers (which is where I got the
+ * Adaptec's license for their drivers (which is where I got the
  * firmware files) does not allow one to redistribute them. Thus, we can't
  * include the firmware with this driver.
  *
- * However, an end-user is allowed to download and use it, after
- * converting it to C header files using starfire_firmware.pl.
+ * However, should a legal-to-distribute firmware become available,
+ * the driver developer would need only to obtain the firmware in the
+ * form of a C header file.
  * Once that's done, the #undef below must be changed into a #define
  * for this driver to really use the firmware. Note that Rx/Tx
  * hardware TCP checksumming is not possible without the firmware.
  *
- * If Adaptec could allow redistribution of the firmware (even in binary
- * format), life would become a lot easier. Unfortunately, I've lost my
- * Adaptec contacts, so progress on this front is rather unlikely to
- * occur. If anybody from Adaptec reads this and can help with this matter,
- * please let me know...
+ * WANTED: legal firmware to include with this GPL'd driver.
  */
 #undef HAS_FIRMWARE
 /*
@@ -157,11 +180,20 @@
 #include "starfire_firmware.h"
 #endif /* HAS_FIRMWARE */
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
+#define VLAN_SUPPORT
+#endif
+
+#ifndef CONFIG_ADAPTEC_STARFIRE_NAPI
+#undef HAVE_NETDEV_POLL
+#endif
+
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 
 /* Used for tuning interrupt latency vs. overhead. */
-static int interrupt_mitigation;
+static int intr_latency;
+static int small_frames;
 
 static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
 static int max_interrupt_work = 20;
@@ -169,6 +201,12 @@
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    The Starfire has a 512 element hash table based on the Ethernet CRC. */
 static int multicast_filter_limit = 512;
+/* Whether to do TCP/UDP checksums in hardware */
+#ifdef HAS_FIRMWARE
+static int enable_hw_cksum = 1;
+#else
+static int enable_hw_cksum = 0;
+#endif
 
 #define PKT_BUF_SZ	1536		/* Size of each temporary Rx buffer.*/
 /*
@@ -181,7 +219,9 @@
  * packets as the starfire doesn't allow for misaligned DMAs ;-(
  * 23/10/2000 - Jes
  *
- * The Alpha and the Sparc don't allow unaligned loads, either. -Ion
+ * The Alpha and the Sparc don't like unaligned loads, either. On Sparc64,
+ * at least, having unaligned frames leads to a rather serious performance
+ * penalty. -Ion
  */
 #if defined(__ia64__) || defined(__alpha__) || defined(__sparc__)
 static int rx_copybreak = PKT_BUF_SZ;
@@ -189,9 +229,17 @@
 static int rx_copybreak /* = 0 */;
 #endif
 
+/* PCI DMA burst size -- on sparc64 we want to force it to 64 bytes, on the others the default of 128 is fine. */
+#ifdef __sparc__
+#define DMA_BURST_SIZE 64
+#else
+#define DMA_BURST_SIZE 128
+#endif
+
 /* Used to pass the media type, etc.
    Both 'options[]' and 'full_duplex[]' exist for driver interoperability.
    The media type is usually passed in 'options[]'.
+   These variables are deprecated, use ethtool instead. -Ion
 */
 #define MAX_UNITS 8		/* More are supported, limit only on options */
 static int options[MAX_UNITS] = {0, };
@@ -201,33 +249,55 @@
 
 /* The "native" ring sizes are either 256 or 2048.
    However in some modes a descriptor may be marked to wrap the ring earlier.
-   The driver allocates a single page for each descriptor ring, constraining
-   the maximum size in an architecture-dependent way.
 */
 #define RX_RING_SIZE	256
 #define TX_RING_SIZE	32
 /* The completion queues are fixed at 1024 entries i.e. 4K or 8KB. */
 #define DONE_Q_SIZE	1024
+/* All queues must be aligned on a 256-byte boundary */
+#define QUEUE_ALIGN	256
+
+#if RX_RING_SIZE > 256
+#define RX_Q_ENTRIES Rx2048QEntries
+#else
+#define RX_Q_ENTRIES Rx256QEntries
+#endif
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT	(2 * HZ)
 
-#ifdef ZEROCOPY
-#if MAX_SKB_FRAGS <= 6
-#define MAX_STARFIRE_FRAGS 6
-#else  /* MAX_STARFIRE_FRAGS > 6 */
-#warning This driver will not work with more than 6 skb fragments.
-#warning Turning off zerocopy support.
-#undef ZEROCOPY
-#endif /* MAX_STARFIRE_FRAGS > 6 */
-#endif /* ZEROCOPY */
+/*
+ * This SUCKS.
+ * We need a much better method to determine if dma_addr_t is 64-bit.
+ */
+#if (defined(__i386__) && defined(CONFIG_HIGHMEM) && (LINUX_VERSION_CODE > 0x20500 || defined(CONFIG_HIGHMEM64G))) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
+/* 64-bit dma_addr_t */
+#define ADDR_64BITS	/* This chip uses 64 bit addresses. */
+#define cpu_to_dma(x) cpu_to_le64(x)
+#define dma_to_cpu(x) le64_to_cpu(x)
+#define RX_DESC_Q_ADDR_SIZE RxDescQAddr64bit
+#define TX_DESC_Q_ADDR_SIZE TxDescQAddr64bit
+#define RX_COMPL_Q_ADDR_SIZE RxComplQAddr64bit
+#define TX_COMPL_Q_ADDR_SIZE TxComplQAddr64bit
+#define RX_DESC_ADDR_SIZE RxDescAddr64bit
+#else  /* 32-bit dma_addr_t */
+#define cpu_to_dma(x) cpu_to_le32(x)
+#define dma_to_cpu(x) le32_to_cpu(x)
+#define RX_DESC_Q_ADDR_SIZE RxDescQAddr32bit
+#define TX_DESC_Q_ADDR_SIZE TxDescQAddr32bit
+#define RX_COMPL_Q_ADDR_SIZE RxComplQAddr32bit
+#define TX_COMPL_Q_ADDR_SIZE TxComplQAddr32bit
+#define RX_DESC_ADDR_SIZE RxDescAddr32bit
+#endif
 
-#ifdef ZEROCOPY
+#ifdef MAX_SKB_FRAGS
 #define skb_first_frag_len(skb)	skb_headlen(skb)
-#else  /* not ZEROCOPY */
+#define skb_num_frags(skb) (skb_shinfo(skb)->nr_frags + 1)
+#else  /* not MAX_SKB_FRAGS */
 #define skb_first_frag_len(skb)	(skb->len)
-#endif /* not ZEROCOPY */
+#define skb_num_frags(skb) 1
+#endif /* not MAX_SKB_FRAGS */
 
 /* 2.2.x compatibility code */
 #if LINUX_VERSION_CODE < 0x20300
@@ -236,9 +306,12 @@
 
 #else  /* LINUX_VERSION_CODE > 0x20300 */
 
+#include <linux/crc32.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 
+#include <linux/if_vlan.h>
+
 #define COMPAT_MOD_INC_USE_COUNT
 #define COMPAT_MOD_DEC_USE_COUNT
 
@@ -253,6 +326,43 @@
 #define PCI_SLOT_NAME(pci_dev)	(pci_dev)->slot_name
 
 #endif /* LINUX_VERSION_CODE > 0x20300 */
+
+#ifdef HAVE_NETDEV_POLL
+#define init_poll(dev) \
+	dev->poll = &netdev_poll; \
+	dev->weight = max_interrupt_work;
+#define netdev_rx(dev, ioaddr) \
+do { \
+	u32 intr_enable; \
+	if (netif_rx_schedule_prep(dev)) { \
+		__netif_rx_schedule(dev); \
+		intr_enable = readl(ioaddr + IntrEnable); \
+		intr_enable &= ~(IntrRxDone | IntrRxEmpty); \
+		writel(intr_enable, ioaddr + IntrEnable); \
+		readl(ioaddr + IntrEnable); \	/* flush PCI posting buffers */
+	} else { \
+		/* Paranoia check */ \
+		intr_enable = readl(ioaddr + IntrEnable); \
+		if (intr_enable & (IntrRxDone | IntrRxEmpty)) { \
+			printk("%s: interrupt while in polling mode!\n", dev->name); \
+			intr_enable &= ~(IntrRxDone | IntrRxEmpty); \
+			writel(intr_enable, ioaddr + IntrEnable); \
+		} \
+	} \
+} while (0)
+#define netdev_receive_skb(skb) netif_receive_skb(skb)
+#define vlan_netdev_receive_skb(skb, vlgrp, vlid) vlan_hwaccel_receive_skb(skb, vlgrp, vlid)
+static int	netdev_poll(struct net_device *dev, int *budget);
+#else  /* not HAVE_NETDEV_POLL */
+#define init_poll(dev)
+#define netdev_receive_skb(skb) netif_rx(skb)
+#define vlan_netdev_receive_skb(skb, vlgrp, vlid) vlan_hwaccel_rx(skb, vlgrp, vlid)
+#define netdev_rx(dev, ioaddr) \
+do { \
+	int quota = np->dirty_rx + RX_RING_SIZE - np->cur_rx; \
+	__netdev_rx(dev, &quota);\
+} while (0)
+#endif /* not HAVE_NETDEV_POLL */
 /* end of compatibility code */
 
 
@@ -269,15 +379,20 @@
 MODULE_PARM(mtu, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
-MODULE_PARM(interrupt_mitigation, "i");
+MODULE_PARM(intr_latency, "i");
+MODULE_PARM(small_frames, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM_DESC(max_interrupt_work, "Starfire maximum events handled per interrupt");
-MODULE_PARM_DESC(mtu, "Starfire MTU (all boards)");
-MODULE_PARM_DESC(debug, "Starfire debug level (0-6)");
-MODULE_PARM_DESC(rx_copybreak, "Starfire copy breakpoint for copy-only-tiny-frames");
-MODULE_PARM_DESC(options, "Starfire: Bits 0-3: media type, bit 17: full duplex");
-MODULE_PARM_DESC(full_duplex, "Starfire full duplex setting(s) (1)");
+MODULE_PARM(enable_hw_cksum, "i");
+MODULE_PARM_DESC(max_interrupt_work, "Maximum events handled per interrupt");
+MODULE_PARM_DESC(mtu, "MTU (all boards)");
+MODULE_PARM_DESC(debug, "Debug level (0-6)");
+MODULE_PARM_DESC(rx_copybreak, "Copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(intr_latency, "Maximum interrupt latency, in microseconds");
+MODULE_PARM_DESC(small_frames, "Maximum size of receive frames that bypass interrupt latency (0,64,128,256,512)");
+MODULE_PARM_DESC(options, "Deprecated: Bits 0-3: media type, bit 17: full duplex");
+MODULE_PARM_DESC(full_duplex, "Deprecated: Forced full-duplex setting (0/1)");
+MODULE_PARM_DESC(enable_hw_cksum, "Enable/disable hardware cksum support (0/1)");
 
 /*
 				Theory of Operation
@@ -306,14 +421,14 @@
 IIIb/c. Transmit/Receive Structure
 
 See the Adaptec manual for the many possible structures, and options for
-each structure.  There are far too many to document here.
+each structure.  There are far too many to document all of them here.
 
 For transmit this driver uses type 0/1 transmit descriptors (depending
-on the presence of the zerocopy infrastructure), and relies on automatic
+on the 32/64 bitness of the architecture), and relies on automatic
 minimum-length padding.  It does not use the completion queue
 consumer index, but instead checks for non-zero status entries.
 
-For receive this driver uses type 0 receive descriptors.  The driver
+For receive this driver uses type 0/1/2/3 receive descriptors.  The driver
 allocates full frame size skbuffs for the Rx ring buffers, so all frames
 should fit in a single descriptor.  The driver does not use the completion
 queue consumer index, but instead checks for non-zero status entries.
@@ -338,15 +453,15 @@
 dev->tbusy flag.  The other thread is the interrupt handler, which is single
 threaded by the hardware and interrupt handling software.
 
-The send packet thread has partial control over the Tx ring and 'dev->tbusy'
-flag.  It sets the tbusy flag whenever it's queuing a Tx packet. If the next
-queue slot is empty, it clears the tbusy flag when finished otherwise it sets
-the 'lp->tx_full' flag.
+The send packet thread has partial control over the Tx ring and the netif_queue
+status. If the number of free Tx slots in the ring falls below a certain number
+(currently hardcoded to 4), it signals the upper layer to stop the queue.
 
 The interrupt handler has exclusive control over the Rx ring and records stats
 from the Tx ring.  After reaping the stats, it marks the Tx queue entry as
-empty by incrementing the dirty_tx mark. Iff the 'lp->tx_full' flag is set, it
-clears both the tx_full and tbusy flags.
+empty by incrementing the dirty_tx mark. Iff the netif_queue is stopped and the
+number of free Tx slow is above the threshold, it signals the upper layer to
+restart the queue.
 
 IV. Notes
 
@@ -358,18 +473,15 @@
 
 IVc. Errata
 
+- StopOnPerr is broken, don't enable
+- Hardware ethernet padding exposes random data, perform software padding
+  instead (unverified -- works correctly for all the hardware I have)
+
 */
 
 
 
 enum chip_capability_flags {CanHaveMII=1, };
-#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR0)
-
-#if 0
-#define ADDR_64BITS 1			/* This chip uses 64 bit addresses. */
-#endif
-
-#define HAS_IP_COPYSUM 1
 
 enum chipset {
 	CH_6915 = 0,
@@ -401,7 +513,7 @@
 enum register_offsets {
 	PCIDeviceConfig=0x50040, GenCtrl=0x50070, IntrTimerCtrl=0x50074,
 	IntrClear=0x50080, IntrStatus=0x50084, IntrEnable=0x50088,
-	MIICtrl=0x52000, StationAddr=0x50120, EEPROMCtrl=0x51000,
+	MIICtrl=0x52000, TxStationAddr=0x50120, EEPROMCtrl=0x51000,
 	GPIOCtrl=0x5008C, TxDescCtrl=0x50090,
 	TxRingPtr=0x50098, HiPriTxRingPtr=0x50094, /* Low and High priority. */
 	TxRingHiAddr=0x5009C,		/* 64 bit address extension. */
@@ -412,11 +524,16 @@
 	CompletionQConsumerIdx=0x500C4, RxDMACtrl=0x500D0,
 	RxDescQCtrl=0x500D4, RxDescQHiAddr=0x500DC, RxDescQAddr=0x500E0,
 	RxDescQIdx=0x500E8, RxDMAStatus=0x500F0, RxFilterMode=0x500F4,
-	TxMode=0x55000, PerfFilterTable=0x56000, HashTable=0x56100,
+	TxMode=0x55000, VlanType=0x55064,
+	PerfFilterTable=0x56000, HashTable=0x56100,
 	TxGfpMem=0x58000, RxGfpMem=0x5a000,
 };
 
-/* Bits in the interrupt status/mask registers. */
+/*
+ * Bits in the interrupt status/mask registers.
+ * Warning: setting Intr[Ab]NormalSummary in the IntrEnable register
+ * enables all the interrupt sources that are or'ed into those status bits.
+ */
 enum intr_status_bits {
 	IntrLinkChange=0xf0000000, IntrStatsMax=0x08000000,
 	IntrAbnormalSummary=0x02000000, IntrGeneralTimer=0x01000000,
@@ -441,7 +558,16 @@
 /* Bits in the RxFilterMode register. */
 enum rx_mode_bits {
 	AcceptBroadcast=0x04, AcceptAllMulticast=0x02, AcceptAll=0x01,
-	AcceptMulticast=0x10, AcceptMyPhys=0xE040,
+	AcceptMulticast=0x10, PerfectFilter=0x40, HashFilter=0x30,
+	PerfectFilterVlan=0x80, MinVLANPrio=0xE000, VlanMode=0x0200,
+	WakeupOnGFP=0x0800,
+};
+
+/* Bits in the TxMode register */
+enum tx_mode_bits {
+	MiiSoftReset=0x8000, MIILoopback=0x4000,
+	TxFlowEnable=0x0800, RxFlowEnable=0x0400,
+	PadEnable=0x04, FullDuplex=0x02, HugeFrame=0x01,
 };
 
 /* Bits in the TxDescCtrl register. */
@@ -450,7 +576,8 @@
 	TxDescSpace128=0x30, TxDescSpace256=0x40,
 	TxDescType0=0x00, TxDescType1=0x01, TxDescType2=0x02,
 	TxDescType3=0x03, TxDescType4=0x04,
-	TxNoDMACompletion=0x08, TxDescQ64bit=0x80,
+	TxNoDMACompletion=0x08,
+	TxDescQAddr64bit=0x80, TxDescQAddr32bit=0,
 	TxHiPriFIFOThreshShift=24, TxPadLenShift=16,
 	TxDMABurstSizeShift=8,
 };
@@ -458,81 +585,144 @@
 /* Bits in the RxDescQCtrl register. */
 enum rx_ctrl_bits {
 	RxBufferLenShift=16, RxMinDescrThreshShift=0,
-	RxPrefetchMode=0x8000, Rx2048QEntries=0x4000,
-	RxVariableQ=0x2000, RxDesc64bit=0x1000,
-	RxDescQAddr64bit=0x0100,
+	RxPrefetchMode=0x8000, RxVariableQ=0x2000,
+	Rx2048QEntries=0x4000, Rx256QEntries=0,
+	RxDescAddr64bit=0x1000, RxDescAddr32bit=0,
+	RxDescQAddr64bit=0x0100, RxDescQAddr32bit=0,
 	RxDescSpace4=0x000, RxDescSpace8=0x100,
 	RxDescSpace16=0x200, RxDescSpace32=0x300,
 	RxDescSpace64=0x400, RxDescSpace128=0x500,
 	RxConsumerWrEn=0x80,
 };
 
+/* Bits in the RxDMACtrl register. */
+enum rx_dmactrl_bits {
+	RxReportBadFrames=0x80000000, RxDMAShortFrames=0x40000000,
+	RxDMABadFrames=0x20000000, RxDMACrcErrorFrames=0x10000000,
+	RxDMAControlFrame=0x08000000, RxDMAPauseFrame=0x04000000,
+	RxChecksumIgnore=0, RxChecksumRejectTCPUDP=0x02000000,
+	RxChecksumRejectTCPOnly=0x01000000,
+	RxCompletionQ2Enable=0x800000,
+	RxDMAQ2Disable=0, RxDMAQ2FPOnly=0x100000,
+	RxDMAQ2SmallPkt=0x200000, RxDMAQ2HighPrio=0x300000,
+	RxDMAQ2NonIP=0x400000,
+	RxUseBackupQueue=0x080000, RxDMACRC=0x040000,
+	RxEarlyIntThreshShift=12, RxHighPrioThreshShift=8,
+	RxBurstSizeShift=0,
+};
+
 /* Bits in the RxCompletionAddr register */
 enum rx_compl_bits {
-	RxComplQAddr64bit=0x80, TxComplProducerWrEn=0x40,
+	RxComplQAddr64bit=0x80, RxComplQAddr32bit=0,
+	RxComplProducerWrEn=0x40,
 	RxComplType0=0x00, RxComplType1=0x10,
 	RxComplType2=0x20, RxComplType3=0x30,
 	RxComplThreshShift=0,
 };
 
+/* Bits in the TxCompletionAddr register */
+enum tx_compl_bits {
+	TxComplQAddr64bit=0x80, TxComplQAddr32bit=0,
+	TxComplProducerWrEn=0x40,
+	TxComplIntrStatus=0x20,
+	CommonQueueMode=0x10,
+	TxComplThreshShift=0,
+};
+
+/* Bits in the GenCtrl register */
+enum gen_ctrl_bits {
+	RxEnable=0x05, TxEnable=0x0a,
+	RxGFPEnable=0x10, TxGFPEnable=0x20,
+};
+
+/* Bits in the IntrTimerCtrl register */
+enum intr_ctrl_bits {
+	Timer10X=0x800, EnableIntrMasking=0x60, SmallFrameBypass=0x100,
+	SmallFrame64=0, SmallFrame128=0x200, SmallFrame256=0x400, SmallFrame512=0x600,
+	IntrLatencyMask=0x1f,
+};
+
 /* The Rx and Tx buffer descriptors. */
 struct starfire_rx_desc {
-	u32 rxaddr;			/* Optionally 64 bits. */
+	dma_addr_t rxaddr;
 };
 enum rx_desc_bits {
 	RxDescValid=1, RxDescEndRing=2,
 };
 
-/* Completion queue entry.
-   You must update the page allocation, init_ring and the shift count in rx()
-   if using a larger format. */
-#ifdef HAS_FIRMWARE
-#define csum_rx_status
-#endif /* HAS_FIRMWARE */
-struct rx_done_desc {
+/* Completion queue entry. */
+struct short_rx_done_desc {
+	u32 status;			/* Low 16 bits is length. */
+};
+struct basic_rx_done_desc {
 	u32 status;			/* Low 16 bits is length. */
-#ifdef csum_rx_status
-	u32 status2;			/* Low 16 bits is csum */
-#endif /* csum_rx_status */
-#ifdef full_rx_status
-	u32 status2;
+	u16 vlanid;
+	u16 status2;
+};
+struct csum_rx_done_desc {
+	u32 status;			/* Low 16 bits is length. */
+	u16 csum;			/* Partial checksum */
+	u16 status2;
+};
+struct full_rx_done_desc {
+	u32 status;			/* Low 16 bits is length. */
+	u16 status3;
+	u16 status2;
 	u16 vlanid;
 	u16 csum;			/* partial checksum */
 	u32 timestamp;
-#endif /* full_rx_status */
 };
+/* XXX: this is ugly and I'm not sure it's worth the trouble -Ion */
+#ifdef HAS_FIRMWARE
+#ifdef VLAN_SUPPORT
+typedef struct full_rx_done_desc rx_done_desc;
+#define RxComplType RxComplType3
+#else  /* not VLAN_SUPPORT */
+typedef struct csum_rx_done_desc rx_done_desc;
+#define RxComplType RxComplType2
+#endif /* not VLAN_SUPPORT */
+#else  /* not HAS_FIRMWARE */
+#ifdef VLAN_SUPPORT
+typedef struct basic_rx_done_desc rx_done_desc;
+#define RxComplType RxComplType1
+#else  /* not VLAN_SUPPORT */
+typedef struct short_rx_done_desc rx_done_desc;
+#define RxComplType RxComplType0
+#endif /* not VLAN_SUPPORT */
+#endif /* not HAS_FIRMWARE */
+
 enum rx_done_bits {
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
-	} frag[MAX_STARFIRE_FRAGS];
-};
-#else  /* not ZEROCOPY */
 /* Type 1 Tx descriptor. */
-struct starfire_tx_desc {
+struct starfire_tx_desc_1 {
 	u32 status;			/* Upper bits are status, lower 16 length. */
-	u32 first_addr;
+	u32 addr;
 };
-#endif /* not ZEROCOPY */
+
+/* Type 2 Tx descriptor. */
+struct starfire_tx_desc_2 {
+	u32 status;			/* Upper bits are status, lower 16 length. */
+	u32 reserved;
+	u64 addr;
+};
+
+#ifdef ADDR_64BITS
+typedef struct starfire_tx_desc_2 starfire_tx_desc;
+#define TX_DESC_TYPE TxDescType2
+#else  /* not ADDR_64BITS */
+typedef struct starfire_tx_desc_1 starfire_tx_desc;
+#define TX_DESC_TYPE TxDescType1
+#endif /* not ADDR_64BITS */
+#define TX_DESC_SPACING TxDescSpaceUnlim
+
 enum tx_desc_bits {
 	TxDescID=0xB0000000,
 	TxCRCEn=0x01000000, TxDescIntr=0x08000000,
 	TxRingWrap=0x04000000, TxCalTCP=0x02000000,
 };
-struct tx_done_report {
+struct tx_done_desc {
 	u32 status;			/* timestamp, index. */
 #if 0
 	u32 intrstatus;			/* interrupt status */
@@ -545,41 +735,45 @@
 };
 struct tx_ring_info {
 	struct sk_buff *skb;
-	dma_addr_t first_mapping;
-#ifdef ZEROCOPY
-	dma_addr_t frag_mapping[MAX_STARFIRE_FRAGS];
-#endif /* ZEROCOPY */
+	dma_addr_t mapping;
+	unsigned int used_slots;
 };
 
 #define PHY_CNT		2
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
 	struct starfire_rx_desc *rx_ring;
-	struct starfire_tx_desc *tx_ring;
+	starfire_tx_desc *tx_ring;
 	dma_addr_t rx_ring_dma;
 	dma_addr_t tx_ring_dma;
 	/* The addresses of rx/tx-in-place skbuffs. */
 	struct rx_ring_info rx_info[RX_RING_SIZE];
 	struct tx_ring_info tx_info[TX_RING_SIZE];
 	/* Pointers to completion queues (full pages). */
-	struct rx_done_desc *rx_done_q;
+	rx_done_desc *rx_done_q;
 	dma_addr_t rx_done_q_dma;
 	unsigned int rx_done;
-	struct tx_done_report *tx_done_q;
+	struct tx_done_desc *tx_done_q;
 	dma_addr_t tx_done_q_dma;
 	unsigned int tx_done;
 	struct net_device_stats stats;
 	struct pci_dev *pci_dev;
+#ifdef VLAN_SUPPORT
+	struct vlan_group *vlgrp;
+#endif
+	void *queue_mem;
+	dma_addr_t queue_mem_dma;
+	size_t queue_mem_size;
+
 	/* Frequently used values: keep some adjacent for cache effect. */
 	spinlock_t lock;
 	unsigned int cur_rx, dirty_rx;	/* Producer/consumer ring indices */
-	unsigned int cur_tx, dirty_tx;
+	unsigned int cur_tx, dirty_tx, reap_tx;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
-	unsigned int tx_full:1,		/* The Tx queue is full. */
 	/* These values keep track of the transceiver/media in use. */
-		speed100:1;		/* Set if speed == 100MBit. */
-	unsigned int intr_mitigation;
+	int speed100;			/* Set if speed == 100MBit. */
 	u32 tx_mode;
+	u32 intr_timer_ctrl;
 	u8 tx_threshold;
 	/* MII transceiver section. */
 	struct mii_if_info mii_if;		/* MII lib hooks/info */
@@ -597,7 +791,8 @@
 static int	start_tx(struct sk_buff *skb, struct net_device *dev);
 static void	intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
 static void	netdev_error(struct net_device *dev, int intr_status);
-static int	netdev_rx(struct net_device *dev);
+static int	__netdev_rx(struct net_device *dev, int *quota);
+static void	refill_rx_ring(struct net_device *dev);
 static void	netdev_error(struct net_device *dev, int intr_status);
 static void	set_rx_mode(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
@@ -606,6 +801,44 @@
 static void	netdev_media_change(struct net_device *dev);
 
 
+#ifdef VLAN_SUPPORT
+static void netdev_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
+{
+        struct netdev_private *np = dev->priv;
+
+        spin_lock(&np->lock);
+	if (debug > 2)
+		printk("%s: Setting vlgrp to %p\n", dev->name, grp);
+        np->vlgrp = grp;
+	set_rx_mode(dev);
+        spin_unlock(&np->lock);
+}
+
+static void netdev_vlan_rx_add_vid(struct net_device *dev, unsigned short vid)
+{
+	struct netdev_private *np = dev->priv;
+
+	spin_lock(&np->lock);
+	if (debug > 1)
+		printk("%s: Adding vlanid %d to vlan filter\n", dev->name, vid);
+	set_rx_mode(dev);
+	spin_unlock(&np->lock);
+}
+
+static void netdev_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
+{
+	struct netdev_private *np = dev->priv;
+
+	spin_lock(&np->lock);
+	if (debug > 1)
+		printk("%s: removing vlanid %d from vlan filter\n", dev->name, vid);
+	if (np->vlgrp)
+		np->vlgrp->vlan_devices[vid] = NULL;
+	set_rx_mode(dev);
+	spin_unlock(&np->lock);
+}
+#endif /* VLAN_SUPPORT */
+
 
 static int __devinit starfire_init_one(struct pci_dev *pdev,
 				       const struct pci_device_id *ent)
@@ -617,10 +850,6 @@
 	long ioaddr;
 	int drv_flags, io_size;
 	int boguscnt;
-#ifndef HAVE_PCI_SET_MWI
-	u16 cmd;
-	u8 cache;
-#endif
 
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -637,13 +866,13 @@
 	ioaddr = pci_resource_start(pdev, 0);
 	io_size = pci_resource_len(pdev, 0);
 	if (!ioaddr || ((pci_resource_flags(pdev, 0) & IORESOURCE_MEM) == 0)) {
-		printk (KERN_ERR DRV_NAME " %d: no PCI MEM resources, aborting\n", card_idx);
+		printk(KERN_ERR DRV_NAME " %d: no PCI MEM resources, aborting\n", card_idx);
 		return -ENODEV;
 	}
 
 	dev = alloc_etherdev(sizeof(*np));
 	if (!dev) {
-		printk (KERN_ERR DRV_NAME " %d: cannot alloc etherdev, aborting\n", card_idx);
+		printk(KERN_ERR DRV_NAME " %d: cannot alloc etherdev, aborting\n", card_idx);
 		return -ENOMEM;
 	}
 	SET_MODULE_OWNER(dev);
@@ -651,7 +880,7 @@
 	irq = pdev->irq;
 
 	if (pci_request_regions (pdev, dev->name)) {
-		printk (KERN_ERR DRV_NAME " %d: cannot reserve PCI resources, aborting\n", card_idx);
+		printk(KERN_ERR DRV_NAME " %d: cannot reserve PCI resources, aborting\n", card_idx);
 		goto err_out_free_netdev;
 	}
 
@@ -659,7 +888,7 @@
 #if !defined(CONFIG_SPARC64) || LINUX_VERSION_CODE > 0x20300
 	ioaddr = (long) ioremap(ioaddr, io_size);
 	if (!ioaddr) {
-		printk (KERN_ERR DRV_NAME " %d: cannot remap 0x%x @ 0x%lx, aborting\n",
+		printk(KERN_ERR DRV_NAME " %d: cannot remap %#x @ %#lx, aborting\n",
 			card_idx, io_size, ioaddr);
 		goto err_out_free_res;
 	}
@@ -667,29 +896,26 @@
 
 	pci_set_master(pdev);
 
-#ifdef HAVE_PCI_SET_MWI
-	pci_set_mwi(pdev);
-#else
 	/* enable MWI -- it vastly improves Rx performance on sparc64 */
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	cmd |= PCI_COMMAND_INVALIDATE;
-	pci_write_config_word(pdev, PCI_COMMAND, cmd);
-
-	/* set PCI cache size */
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache);
-	if ((cache << 2) != SMP_CACHE_BYTES) {
-		printk(KERN_INFO "  PCI cache line size set incorrectly "
-		       "(%i bytes) by BIOS/FW, correcting to %i\n",
-		       (cache << 2), SMP_CACHE_BYTES);
-		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
-				      SMP_CACHE_BYTES >> 2);
-	}
-#endif
+	pci_set_mwi(pdev);
 
+#ifdef MAX_SKB_FRAGS
+	dev->features |= NETIF_F_SG;
+#endif /* MAX_SKB_FRAGS */
 #ifdef ZEROCOPY
-	/* Starfire can do SG and TCP/UDP checksumming */
-	dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
+	/* Starfire can do TCP/UDP checksumming */
+	if (enable_hw_cksum)
+		dev->features |= NETIF_F_IP_CSUM;
 #endif /* ZEROCOPY */
+#ifdef VLAN_SUPPORT
+	dev->features |= NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER;
+	dev->vlan_rx_register = netdev_vlan_rx_register;
+	dev->vlan_rx_add_vid = netdev_vlan_rx_add_vid;
+	dev->vlan_rx_kill_vid = netdev_vlan_rx_kill_vid;
+#endif /* VLAN_RX_KILL_VID */
+#ifdef ADDR_64BITS
+	dev->features |= NETIF_F_HIGHDMA;
+#endif /* ADDR_64BITS */
 
 	/* Serial EEPROM reads are hidden by the hardware. */
 	for (i = 0; i < 6; i++)
@@ -704,7 +930,7 @@
 #endif
 
 	/* Issue soft reset */
-	writel(0x8000, ioaddr + TxMode);
+	writel(MiiSoftReset, ioaddr + TxMode);
 	udelay(1000);
 	writel(0, ioaddr + TxMode);
 
@@ -750,15 +976,40 @@
 		np->mii_if.full_duplex = 1;
 
 	if (np->mii_if.full_duplex)
-		np->mii_if.force_media = 0;
-	else
 		np->mii_if.force_media = 1;
+	else
+		np->mii_if.force_media = 0;
 	np->speed100 = 1;
 
+	/* timer resolution is 128 * 0.8us */
+	np->intr_timer_ctrl = (((intr_latency * 10) / 1024) & IntrLatencyMask) |
+		Timer10X | EnableIntrMasking;
+
+	if (small_frames > 0) {
+		np->intr_timer_ctrl |= SmallFrameBypass;
+		switch (small_frames) {
+		case 1 ... 64:
+			np->intr_timer_ctrl |= SmallFrame64;
+			break;
+		case 65 ... 128:
+			np->intr_timer_ctrl |= SmallFrame128;
+			break;
+		case 129 ... 256:
+			np->intr_timer_ctrl |= SmallFrame256;
+			break;
+		default:
+			np->intr_timer_ctrl |= SmallFrame512;
+			if (small_frames > 512)
+				printk("Adjusting small_frames down to 512\n");
+			break;
+		}
+	}
+
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
 	dev->hard_start_xmit = &start_tx;
 	init_tx_timer(dev, tx_timeout, TX_TIMEOUT);
+	init_poll(dev);
 	dev->stop = &netdev_close;
 	dev->get_stats = &get_stats;
 	dev->set_multicast_list = &set_rx_mode;
@@ -767,11 +1018,10 @@
 	if (mtu)
 		dev->mtu = mtu;
 
-	i = register_netdev(dev);
-	if (i)
+	if (register_netdev(dev))
 		goto err_out_cleardev;
 
-	printk(KERN_INFO "%s: %s at 0x%lx, ",
+	printk(KERN_INFO "%s: %s at %#lx, ",
 		   dev->name, netdrv_tbl[chip_idx].name, ioaddr);
 	for (i = 0; i < 5; i++)
 		printk("%2.2x:", dev->dev_addr[i]);
@@ -796,7 +1046,7 @@
 				np->phys[phy_idx++] = phy;
 				np->mii_if.advertising = mdio_read(dev, phy, MII_ADVERTISE);
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
-					   "0x%4.4x advertising %4.4x.\n",
+					   "%#4.4x advertising %#4.4x.\n",
 					   dev->name, phy, mii_status, np->mii_if.advertising);
 				/* there can be only one PHY on-board */
 				break;
@@ -809,14 +1059,8 @@
 			memset(&np->mii_if, 0, sizeof(np->mii_if));
 	}
 
-#ifdef ZEROCOPY
-	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming enabled.\n",
-	       dev->name);
-#else  /* not ZEROCOPY */
-	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming disabled.\n",
-	       dev->name);
-#endif /* not ZEROCOPY */
-
+	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming %s.\n",
+	       dev->name, enable_hw_cksum ? "enabled" : "disabled");
 	return 0;
 
 err_out_cleardev:
@@ -825,7 +1069,6 @@
 err_out_free_res:
 	pci_release_regions (pdev);
 err_out_free_netdev:
-	unregister_netdev(dev);
 	kfree(dev);
 	return -ENODEV;
 }
@@ -861,6 +1104,7 @@
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int i, retval;
+	size_t tx_done_q_size, rx_done_q_size, tx_ring_size, rx_ring_size;
 
 	/* Do we ever need to reset the chip??? */
 
@@ -878,62 +1122,61 @@
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
 		       dev->name, dev->irq);
-	/* Allocate the various queues, failing gracefully. */
-	if (np->tx_done_q == 0)
-		np->tx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_done_q_dma);
-	if (np->rx_done_q == 0)
-		np->rx_done_q = pci_alloc_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE, &np->rx_done_q_dma);
-	if (np->tx_ring == 0)
-		np->tx_ring = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_ring_dma);
-	if (np->rx_ring == 0)
-		np->rx_ring = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->rx_ring_dma);
-	if (np->tx_done_q == 0 || np->rx_done_q == 0
-		|| np->rx_ring == 0 || np->tx_ring == 0) {
-		if (np->tx_done_q)
-			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-					    np->tx_done_q, np->tx_done_q_dma);
-		if (np->rx_done_q)
-			pci_free_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE,
-					    np->rx_done_q, np->rx_done_q_dma);
-		if (np->tx_ring)
-			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-					    np->tx_ring, np->tx_ring_dma);
-		if (np->rx_ring)
-			pci_free_consistent(np->pci_dev, PAGE_SIZE,
-					    np->rx_ring, np->rx_ring_dma);
-		COMPAT_MOD_DEC_USE_COUNT;
-		return -ENOMEM;
+
+	/* Allocate the various queues. */
+	if (np->queue_mem == 0) {
+		tx_done_q_size = ((sizeof(struct tx_done_desc) * DONE_Q_SIZE + QUEUE_ALIGN - 1) / QUEUE_ALIGN) * QUEUE_ALIGN;
+		rx_done_q_size = ((sizeof(rx_done_desc) * DONE_Q_SIZE + QUEUE_ALIGN - 1) / QUEUE_ALIGN) * QUEUE_ALIGN;
+		tx_ring_size = ((sizeof(starfire_tx_desc) * TX_RING_SIZE + QUEUE_ALIGN - 1) / QUEUE_ALIGN) * QUEUE_ALIGN;
+		rx_ring_size = sizeof(struct starfire_rx_desc) * RX_RING_SIZE;
+		np->queue_mem_size = tx_done_q_size + rx_done_q_size + tx_ring_size + rx_ring_size;
+		np->queue_mem = pci_alloc_consistent(np->pci_dev, np->queue_mem_size, &np->queue_mem_dma);
+		if (np->queue_mem == 0) {
+			COMPAT_MOD_DEC_USE_COUNT;
+			return -ENOMEM;
+		}
+
+		np->tx_done_q     = np->queue_mem;
+		np->tx_done_q_dma = np->queue_mem_dma;
+		np->rx_done_q     = (void *) np->tx_done_q + tx_done_q_size;
+		np->rx_done_q_dma = np->tx_done_q_dma + tx_done_q_size;
+		np->tx_ring       = (void *) np->rx_done_q + rx_done_q_size;
+		np->tx_ring_dma   = np->rx_done_q_dma + rx_done_q_size;
+		np->rx_ring       = (void *) np->tx_ring + tx_ring_size;
+		np->rx_ring_dma   = np->tx_ring_dma + tx_ring_size;
 	}
 
+	/* Start with no carrier, it gets adjusted later */
 	netif_carrier_off(dev);
 	init_ring(dev);
 	/* Set the size of the Rx buffers. */
 	writel((np->rx_buf_sz << RxBufferLenShift) |
 	       (0 << RxMinDescrThreshShift) |
 	       RxPrefetchMode | RxVariableQ |
+	       RX_Q_ENTRIES |
+	       RX_DESC_Q_ADDR_SIZE | RX_DESC_ADDR_SIZE |
 	       RxDescSpace4,
 	       ioaddr + RxDescQCtrl);
 
-#ifdef ZEROCOPY
-	/* Set Tx descriptor to type 0 and spacing to 64 bytes. */
-	writel((2 << TxHiPriFIFOThreshShift) |
-	       (0 << TxPadLenShift) |
-	       (4 << TxDMABurstSizeShift) |
-	       TxDescSpace64 | TxDescType0,
-	       ioaddr + TxDescCtrl);
-#else  /* not ZEROCOPY */
-	/* Set Tx descriptor to type 1 and padding to 0 bytes. */
+	/* Set up the Rx DMA controller. */
+	writel(RxChecksumIgnore |
+	       (0 << RxEarlyIntThreshShift) |
+	       (6 << RxHighPrioThreshShift) |
+	       ((DMA_BURST_SIZE / 32) << RxBurstSizeShift),
+	       ioaddr + RxDMACtrl);
+
+	/* Set Tx descriptor */
 	writel((2 << TxHiPriFIFOThreshShift) |
 	       (0 << TxPadLenShift) |
-	       (4 << TxDMABurstSizeShift) |
-	       TxDescSpaceUnlim | TxDescType1,
+	       ((DMA_BURST_SIZE / 32) << TxDMABurstSizeShift) |
+	       TX_DESC_Q_ADDR_SIZE |
+	       TX_DESC_SPACING | TX_DESC_TYPE,
 	       ioaddr + TxDescCtrl);
-#endif /* not ZEROCOPY */
 
-#if defined(ADDR_64BITS) && defined(__alpha__)
-	/* XXX We really need a 64-bit PCI dma interfaces too... -DaveM */
-	writel(np->rx_ring_dma >> 32, ioaddr + RxDescQHiAddr);
-	writel(np->tx_ring_dma >> 32, ioaddr + TxRingHiAddr);
+#if defined(ADDR_64BITS)
+	writel(np->queue_mem_dma >> 32, ioaddr + RxDescQHiAddr);
+	writel(np->queue_mem_dma >> 32, ioaddr + TxRingHiAddr);
+	writel(np->queue_mem_dma >> 32, ioaddr + CompletionHiAddr);
 #else
 	writel(0, ioaddr + RxDescQHiAddr);
 	writel(0, ioaddr + TxRingHiAddr);
@@ -943,32 +1186,23 @@
 	writel(np->tx_ring_dma, ioaddr + TxRingPtr);
 
 	writel(np->tx_done_q_dma, ioaddr + TxCompletionAddr);
-#ifdef full_rx_status
 	writel(np->rx_done_q_dma |
-	       RxComplType3 |
+	       RxComplType |
 	       (0 << RxComplThreshShift),
 	       ioaddr + RxCompletionAddr);
-#else  /* not full_rx_status */
-#ifdef csum_rx_status
-	writel(np->rx_done_q_dma |
-	       RxComplType2 |
-	       (0 << RxComplThreshShift),
-	       ioaddr + RxCompletionAddr);
-#else  /* not csum_rx_status */
-	writel(np->rx_done_q_dma |
-	       RxComplType0 |
-	       (0 << RxComplThreshShift),
-	       ioaddr + RxCompletionAddr);
-#endif /* not csum_rx_status */
-#endif /* not full_rx_status */
 
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: Filling in the station address.\n", dev->name);
 
-	/* Fill both the unused Tx SA register and the Rx perfect filter. */
+	/* Fill both the Tx SA register and the Rx perfect filter. */
 	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + 5 - i);
-	for (i = 0; i < 16; i++) {
+		writeb(dev->dev_addr[i], ioaddr + TxStationAddr + 5 - i);
+	/* The first entry is special because it bypasses the VLAN filter.
+	   Don't use it. */
+	writew(0, ioaddr + PerfFilterTable);
+	writew(0, ioaddr + PerfFilterTable + 4);
+	writew(0, ioaddr + PerfFilterTable + 8);
+	for (i = 1; i < 16; i++) {
 		u16 *eaddrs = (u16 *)dev->dev_addr;
 		long setup_frm = ioaddr + PerfFilterTable + i * 16;
 		writew(cpu_to_be16(eaddrs[2]), setup_frm); setup_frm += 4;
@@ -978,16 +1212,14 @@
 
 	/* Initialize other registers. */
 	/* Configure the PCI bus bursts and FIFO thresholds. */
-	np->tx_mode = 0x0C04;		/* modified when link is up. */
-	writel(0x8000 | np->tx_mode, ioaddr + TxMode);
+	np->tx_mode = TxFlowEnable|RxFlowEnable|PadEnable;	/* modified when link is up. */
+	writel(MiiSoftReset | np->tx_mode, ioaddr + TxMode);
 	udelay(1000);
 	writel(np->tx_mode, ioaddr + TxMode);
 	np->tx_threshold = 4;
 	writel(np->tx_threshold, ioaddr + TxThreshold);
 
-	interrupt_mitigation &= 0x1f;
-	np->intr_mitigation = interrupt_mitigation;
-	writel(np->intr_mitigation, ioaddr + IntrTimerCtrl);
+	writel(np->intr_timer_ctrl, ioaddr + IntrTimerCtrl);
 
 	netif_start_if(dev);
 	netif_start_queue(dev);
@@ -1002,29 +1234,35 @@
 	/* Enable GPIO interrupts on link change */
 	writel(0x0f00ff00, ioaddr + GPIOCtrl);
 
-	/* Set the interrupt mask and enable PCI interrupts. */
+	/* Set the interrupt mask */
 	writel(IntrRxDone | IntrRxEmpty | IntrDMAErr |
-	       IntrTxDone | IntrStatsMax | IntrLinkChange |
-	       IntrNormalSummary | IntrAbnormalSummary |
+	       IntrTxDMADone | IntrStatsMax | IntrLinkChange |
 	       IntrRxGFPDead | IntrNoTxCsum | IntrTxBadID,
 	       ioaddr + IntrEnable);
+	/* Enable PCI interrupts. */
 	writel(0x00800000 | readl(ioaddr + PCIDeviceConfig),
 	       ioaddr + PCIDeviceConfig);
 
+#ifdef VLAN_SUPPORT
+	/* Set VLAN type to 802.1q */
+	writel(ETH_P_8021Q, ioaddr + VlanType);
+#endif /* VLAN_SUPPORT */
+
 #ifdef HAS_FIRMWARE
 	/* Load Rx/Tx firmware into the frame processors */
 	for (i = 0; i < FIRMWARE_RX_SIZE * 2; i++)
 		writel(firmware_rx[i], ioaddr + RxGfpMem + i * 4);
 	for (i = 0; i < FIRMWARE_TX_SIZE * 2; i++)
 		writel(firmware_tx[i], ioaddr + TxGfpMem + i * 4);
-	/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
-	writel(0x003F, ioaddr + GenCtrl);
-#else  /* not HAS_FIRMWARE */
-	/* Enable the Rx and Tx units only. */
-	writel(0x000F, ioaddr + GenCtrl);
-#endif /* not HAS_FIRMWARE */
+#endif /* HAS_FIRMWARE */
+	if (enable_hw_cksum)
+		/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
+		writel(TxEnable|TxGFPEnable|RxEnable|RxGFPEnable, ioaddr + GenCtrl);
+	else
+		/* Enable the Rx and Tx units only. */
+		writel(TxEnable|RxEnable, ioaddr + GenCtrl);
 
-	if (debug > 2)
+	if (debug > 1)
 		printk(KERN_DEBUG "%s: Done netdev_open().\n",
 		       dev->name);
 
@@ -1036,11 +1274,17 @@
 {
 	struct netdev_private *np = dev->priv;
 	u16 reg0;
+	int silly_count = 1000;
 
 	mdio_write(dev, np->phys[0], MII_ADVERTISE, np->mii_if.advertising);
 	mdio_write(dev, np->phys[0], MII_BMCR, BMCR_RESET);
 	udelay(500);
-	while (mdio_read(dev, np->phys[0], MII_BMCR) & BMCR_RESET);
+	while (--silly_count && mdio_read(dev, np->phys[0], MII_BMCR) & BMCR_RESET)
+		/* do nothing */;
+	if (!silly_count) {
+		printk("%s: MII reset failed!\n", dev->name);
+		return;
+	}
 
 	reg0 = mdio_read(dev, np->phys[0], MII_BMCR);
 
@@ -1065,25 +1309,22 @@
 {
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
+	int old_debug;
 
-	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
-	       " resetting...\n", dev->name, (int)readl(ioaddr + IntrStatus));
-
-#ifndef __alpha__
-	{
-		int i;
-		printk(KERN_DEBUG "  Rx ring %p: ", np->rx_ring);
-		for (i = 0; i < RX_RING_SIZE; i++)
-			printk(" %8.8x", (unsigned int)le32_to_cpu(np->rx_ring[i].rxaddr));
-		printk("\n"KERN_DEBUG"  Tx ring %p: ", np->tx_ring);
-		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" %4.4x", le32_to_cpu(np->tx_ring[i].status));
-		printk("\n");
-	}
-#endif
+	printk(KERN_WARNING "%s: Transmit timed out, status %#8.8x, "
+	       "resetting...\n", dev->name, (int) readl(ioaddr + IntrStatus));
 
 	/* Perhaps we should reinitialize the hardware here. */
-	/* Stop and restart the chip's Tx processes . */
+
+	/*
+	 * Stop and restart the interface.
+	 * Cheat and increase the debug level temporarily.
+	 */
+	old_debug = debug;
+	debug = 2;
+	netdev_close(dev);
+	netdev_open(dev);
+	debug = old_debug;
 
 	/* Trigger an immediate transmit demand. */
 
@@ -1099,9 +1340,8 @@
 	struct netdev_private *np = dev->priv;
 	int i;
 
-	np->tx_full = 0;
-	np->cur_rx = np->cur_tx = 0;
-	np->dirty_rx = np->rx_done = np->dirty_tx = np->tx_done = 0;
+	np->cur_rx = np->cur_tx = np->reap_tx = 0;
+	np->dirty_rx = np->dirty_tx = np->rx_done = np->tx_done = 0;
 
 	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
 
@@ -1114,7 +1354,7 @@
 		np->rx_info[i].mapping = pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 		skb->dev = dev;			/* Mark as being used by this device. */
 		/* Grrr, we cannot offset to correctly align the IP header. */
-		np->rx_ring[i].rxaddr = cpu_to_le32(np->rx_info[i].mapping | RxDescValid);
+		np->rx_ring[i].rxaddr = cpu_to_dma(np->rx_info[i].mapping | RxDescValid);
 	}
 	writew(i - 1, dev->base_addr + RxDescQIdx);
 	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
@@ -1126,7 +1366,7 @@
 		np->rx_info[i].mapping = 0;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].rxaddr |= cpu_to_le32(RxDescEndRing);
+	np->rx_ring[RX_RING_SIZE - 1].rxaddr |= cpu_to_dma(RxDescEndRing);
 
 	/* Clear the completion rings. */
 	for (i = 0; i < DONE_Q_SIZE; i++) {
@@ -1134,18 +1374,9 @@
 		np->tx_done_q[i].status = 0;
 	}
 
-	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_info[i].skb = NULL;
-		np->tx_info[i].first_mapping = 0;
-#ifdef ZEROCOPY
-		{
-			int j;
-			for (j = 0; j < MAX_STARFIRE_FRAGS; j++)
-				np->tx_info[i].frag_mapping[j] = 0;
-		}
-#endif /* ZEROCOPY */
-		np->tx_ring[i].status = 0;
-	}
+	for (i = 0; i < TX_RING_SIZE; i++)
+		memset(&np->tx_info[i], 0, sizeof(np->tx_info[i]));
+
 	return;
 }
 
@@ -1154,19 +1385,21 @@
 {
 	struct netdev_private *np = dev->priv;
 	unsigned int entry;
-#ifdef ZEROCOPY
+	u32 status;
 	int i;
-#endif
 
 	kick_tx_timer(dev, tx_timeout, TX_TIMEOUT);
 
-	/* Caution: the write order is important here, set the field
-	   with the "ownership" bits last. */
-
-	/* Calculate the next Tx descriptor entry. */
-	entry = np->cur_tx % TX_RING_SIZE;
+	/*
+	 * be cautious here, wrapping the queue has weird semantics
+	 * and we may not have enough slots even when it seems we do.
+	 */
+	if ((np->cur_tx - np->dirty_tx) + skb_num_frags(skb) * 2 > TX_RING_SIZE) {
+		netif_stop_queue(dev);
+		return 1;
+	}
 
-#if defined(ZEROCOPY) && defined(HAS_FIRMWARE) && defined(HAS_BROKEN_FIRMWARE)
+#if defined(ZEROCOPY) && defined(HAS_BROKEN_FIRMWARE)
 	{
 		int has_bad_length = 0;
 
@@ -1183,85 +1416,72 @@
 		if (has_bad_length)
 			skb_checksum_help(skb);
 	}
-#endif /* ZEROCOPY && HAS_FIRMWARE && HAS_BROKEN_FIRMWARE */
-
-	np->tx_info[entry].skb = skb;
-	np->tx_info[entry].first_mapping =
-		pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
-
-	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
-#ifdef ZEROCOPY
-	np->tx_ring[entry].first_len = cpu_to_le16(skb_first_frag_len(skb));
-	np->tx_ring[entry].total_len = cpu_to_le16(skb->len);
-	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
-	np->tx_ring[entry].status = cpu_to_le32(TxDescID | TxCRCEn);
-	np->tx_ring[entry].nbufs = cpu_to_le32(skb_shinfo(skb)->nr_frags + 1);
-#else  /* not ZEROCOPY */
-	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
-	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID | TxCRCEn | 1 << 16);
-#endif /* not ZEROCOPY */
+#endif /* ZEROCOPY && HAS_BROKEN_FIRMWARE */
 
-	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
-		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
-
-#ifdef ZEROCOPY
-	if (skb->ip_summed == CHECKSUM_HW) {
-		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
-		np->stats.tx_compressed++;
-	}
-#endif /* ZEROCOPY */
+	entry = np->cur_tx % TX_RING_SIZE;
+	for (i = 0; i < skb_num_frags(skb); i++) {
+		int wrap_ring = 0;
+		status = TxDescID;
+
+		if (i == 0) {
+			np->tx_info[entry].skb = skb;
+			status |= TxCRCEn;
+			if (entry >= TX_RING_SIZE - skb_num_frags(skb)) {
+				status |= TxRingWrap;
+				wrap_ring = 1;
+			}
+			if (np->reap_tx) {
+				status |= TxDescIntr;
+				np->reap_tx = 0;
+			}
+			if (skb->ip_summed == CHECKSUM_HW) {
+				status |= TxCalTCP;
+				np->stats.tx_compressed++;
+			}
+			status |= skb_first_frag_len(skb) | (skb_num_frags(skb) << 16);
 
-	if (debug > 5) {
-#ifdef ZEROCOPY
-		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x nbufs %d len %4.4x/%4.4x.\n",
-		       dev->name, np->cur_tx, entry,
-		       le32_to_cpu(np->tx_ring[entry].status),
-		       le32_to_cpu(np->tx_ring[entry].nbufs),
-		       le32_to_cpu(np->tx_ring[entry].first_len),
-		       le32_to_cpu(np->tx_ring[entry].total_len));
-#else  /* not ZEROCOPY */
-		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x.\n",
-		       dev->name, np->cur_tx, entry,
-		       le32_to_cpu(np->tx_ring[entry].status));
-#endif /* not ZEROCOPY */
+			np->tx_info[entry].mapping =
+				pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
+		} else {
+#ifdef MAX_SKB_FRAGS
+			skb_frag_t *this_frag = &skb_shinfo(skb)->frags[i - 1];
+			status |= this_frag->size;
+			np->tx_info[entry].mapping =
+				pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
+#endif /* MAX_SKB_FRAGS */
+		}
+
+		np->tx_ring[entry].addr = cpu_to_dma(np->tx_info[entry].mapping);
+		np->tx_ring[entry].status = cpu_to_le32(status);
+		if (debug > 3)
+			printk(KERN_DEBUG "%s: Tx #%d/#%d slot %d status %#8.8x.\n",
+			       dev->name, np->cur_tx, np->dirty_tx,
+			       entry, status);
+		if (wrap_ring) {
+			np->tx_info[entry].used_slots = TX_RING_SIZE - entry;
+			np->cur_tx += np->tx_info[entry].used_slots;
+			entry = 0;
+		} else {
+			np->tx_info[entry].used_slots = 1;
+			np->cur_tx += np->tx_info[entry].used_slots;
+			entry++;
+		}
+		/* scavenge the tx descriptors twice per TX_RING_SIZE */
+		if (np->cur_tx % (TX_RING_SIZE / 2) == 0)
+			np->reap_tx = 1;
 	}
 
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
-			       dev->name, np->cur_tx, i,
-			       le32_to_cpu(np->tx_ring[entry].frag[i].len));
-		}
-	}
-#endif /* ZEROCOPY */
-
-	np->cur_tx++;
-
-	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
-		entry = -1;
-	entry++;
-
 	/* Non-x86: explicitly flush descriptor cache lines here. */
-	/* Ensure everything is written back above before the transmit is
+	/* Ensure all descriptors are written back before the transmit is
 	   initiated. - Jes */
 	wmb();
 
 	/* Update the producer index. */
-	writel(entry * (sizeof(struct starfire_tx_desc) / 8), dev->base_addr + TxProducerIdx);
+	writel(entry * (sizeof(starfire_tx_desc) / 8), dev->base_addr + TxProducerIdx);
 
-	if (np->cur_tx - np->dirty_tx >= TX_RING_SIZE - 1) {
-		np->tx_full = 1;
+	/* 4 is arbitrary, but should be ok */
+	if ((np->cur_tx - np->dirty_tx) + 4 > TX_RING_SIZE)
 		netif_stop_queue(dev);
-	}
 
 	dev->trans_start = jiffies;
 
@@ -1273,20 +1493,13 @@
    after the Tx thread. */
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
 {
-	struct net_device *dev = (struct net_device *)dev_instance;
+	struct net_device *dev = dev_instance;
 	struct netdev_private *np;
 	long ioaddr;
 	int boguscnt = max_interrupt_work;
 	int consumer;
 	int tx_status;
 
-#ifndef final_version			/* Can never occur. */
-	if (dev == NULL) {
-		printk (KERN_ERR "Netdev interrupt handler(): IRQ %d for unknown device.\n", irq);
-		return;
-	}
-#endif
-
 	ioaddr = dev->base_addr;
 	np = dev->priv;
 
@@ -1294,83 +1507,69 @@
 		u32 intr_status = readl(ioaddr + IntrClear);
 
 		if (debug > 4)
-			printk(KERN_DEBUG "%s: Interrupt status %4.4x.\n",
+			printk(KERN_DEBUG "%s: Interrupt status %#8.8x.\n",
 			       dev->name, intr_status);
 
-		if (intr_status == 0)
+		if (intr_status == 0 || intr_status == (u32) -1)
 			break;
 
-		if (intr_status & IntrRxDone)
-			netdev_rx(dev);
+		if (intr_status & (IntrRxDone | IntrRxEmpty))
+			netdev_rx(dev, ioaddr);
 
 		/* Scavenge the skbuff list based on the Tx-done queue.
 		   There are redundant checks here that may be cleaned up
 		   after the driver has proven to be reliable. */
 		consumer = readl(ioaddr + TxConsumerIdx);
-		if (debug > 4)
+		if (debug > 3)
 			printk(KERN_DEBUG "%s: Tx Consumer index is %d.\n",
 			       dev->name, consumer);
-#if 0
-		if (np->tx_done >= 250 || np->tx_done == 0)
-			printk(KERN_DEBUG "%s: Tx completion entry %d is %8.8x, %d is %8.8x.\n",
-			       dev->name, np->tx_done,
-			       le32_to_cpu(np->tx_done_q[np->tx_done].status),
-			       (np->tx_done+1) & (DONE_Q_SIZE-1),
-			       le32_to_cpu(np->tx_done_q[(np->tx_done+1)&(DONE_Q_SIZE-1)].status));
-#endif
 
 		while ((tx_status = le32_to_cpu(np->tx_done_q[np->tx_done].status)) != 0) {
-			if (debug > 4)
-				printk(KERN_DEBUG "%s: Tx completion entry %d is %8.8x.\n",
-				       dev->name, np->tx_done, tx_status);
+			if (debug > 3)
+				printk(KERN_DEBUG "%s: Tx completion #%d entry %d is %#8.8x.\n",
+				       dev->name, np->dirty_tx, np->tx_done, tx_status);
 			if ((tx_status & 0xe0000000) == 0xa0000000) {
 				np->stats.tx_packets++;
 			} else if ((tx_status & 0xe0000000) == 0x80000000) {
-				struct sk_buff *skb;
-#ifdef ZEROCOPY
-				int i;
-#endif /* ZEROCOPY */
-				u16 entry = tx_status;		/* Implicit truncate */
-				entry /= sizeof(struct starfire_tx_desc);
-
-				skb = np->tx_info[entry].skb;
+				u16 entry = (tx_status & 0x7fff) / sizeof(starfire_tx_desc);
+				struct sk_buff *skb = np->tx_info[entry].skb;
 				np->tx_info[entry].skb = NULL;
 				pci_unmap_single(np->pci_dev,
-						 np->tx_info[entry].first_mapping,
+						 np->tx_info[entry].mapping,
 						 skb_first_frag_len(skb),
 						 PCI_DMA_TODEVICE);
-				np->tx_info[entry].first_mapping = 0;
-
-#ifdef ZEROCOPY
-				for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-					pci_unmap_single(np->pci_dev,
-							 np->tx_info[entry].frag_mapping[i],
-							 skb_shinfo(skb)->frags[i].size,
-							 PCI_DMA_TODEVICE);
-					np->tx_info[entry].frag_mapping[i] = 0;
+				np->tx_info[entry].mapping = 0;
+				np->dirty_tx += np->tx_info[entry].used_slots;
+				entry = (entry + np->tx_info[entry].used_slots) % TX_RING_SIZE;
+#ifdef MAX_SKB_FRAGS
+				{
+					int i;
+					for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+						pci_unmap_single(np->pci_dev,
+								 np->tx_info[entry].mapping,
+								 skb_shinfo(skb)->frags[i].size,
+								 PCI_DMA_TODEVICE);
+						np->dirty_tx++;
+						entry++;
+					}
 				}
-#endif /* ZEROCOPY */
-
-				/* Scavenge the descriptor. */
+#endif /* MAX_SKB_FRAGS */
 				dev_kfree_skb_irq(skb);
-
-				np->dirty_tx++;
 			}
 			np->tx_done_q[np->tx_done].status = 0;
-			np->tx_done = (np->tx_done+1) & (DONE_Q_SIZE-1);
+			np->tx_done = (np->tx_done + 1) % DONE_Q_SIZE;
 		}
 		writew(np->tx_done, ioaddr + CompletionQConsumerIdx + 2);
 
-		if (np->tx_full && np->cur_tx - np->dirty_tx < TX_RING_SIZE - 4) {
+		if (netif_queue_stopped(dev) &&
+		    (np->cur_tx - np->dirty_tx + 4 < TX_RING_SIZE)) {
 			/* The ring is no longer full, wake the queue. */
-			np->tx_full = 0;
 			netif_wake_queue(dev);
 		}
 
 		/* Stats overflow */
-		if (intr_status & IntrStatsMax) {
+		if (intr_status & IntrStatsMax)
 			get_stats(dev);
-		}
 
 		/* Media change interrupt. */
 		if (intr_status & IntrLinkChange)
@@ -1381,72 +1580,58 @@
 			netdev_error(dev, intr_status);
 
 		if (--boguscnt < 0) {
-			printk(KERN_WARNING "%s: Too much work at interrupt, "
-			       "status=0x%4.4x.\n",
-			       dev->name, intr_status);
+			if (debug > 1)
+				printk(KERN_WARNING "%s: Too much work at interrupt, "
+				       "status=%#8.8x.\n",
+				       dev->name, intr_status);
 			break;
 		}
 	} while (1);
 
 	if (debug > 4)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
-		       dev->name, (int)readl(ioaddr + IntrStatus));
-
-#ifndef final_version
-	/* Code that should never be run!  Remove after testing.. */
-	{
-		static int stopit = 10;
-		if (!netif_running(dev) && --stopit < 0) {
-			printk(KERN_ERR "%s: Emergency stop, looping startup interrupt.\n",
-			       dev->name);
-			free_irq(irq, dev);
-		}
-	}
-#endif
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%#8.8x.\n",
+		       dev->name, (int) readl(ioaddr + IntrStatus));
 }
 
 
-/* This routine is logically part of the interrupt handler, but separated
-   for clarity and better register allocation. */
-static int netdev_rx(struct net_device *dev)
+/* This routine is logically part of the interrupt/poll handler, but separated
+   for clarity, code sharing between NAPI/non-NAPI, and better register allocation. */
+static int __netdev_rx(struct net_device *dev, int *quota)
 {
 	struct netdev_private *np = dev->priv;
-	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	u32 desc_status;
-
-	if (np->rx_done_q == 0) {
-		printk(KERN_ERR "%s:  rx_done_q is NULL!  rx_done is %d. %p.\n",
-		       dev->name, np->rx_done, np->tx_done_q);
-		return 0;
-	}
+	int retcode = 0;
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
 	while ((desc_status = le32_to_cpu(np->rx_done_q[np->rx_done].status)) != 0) {
 		struct sk_buff *skb;
 		u16 pkt_len;
 		int entry;
+		rx_done_desc *desc = &np->rx_done_q[np->rx_done];
 
 		if (debug > 4)
-			printk(KERN_DEBUG "  netdev_rx() status of %d was %8.8x.\n", np->rx_done, desc_status);
-		if (--boguscnt < 0)
-			break;
-		if ( ! (desc_status & RxOK)) {
+			printk(KERN_DEBUG "  netdev_rx() status of %d was %#8.8x.\n", np->rx_done, desc_status);
+		if (!(desc_status & RxOK)) {
 			/* There was a error. */
 			if (debug > 2)
-				printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n", desc_status);
+				printk(KERN_DEBUG "  netdev_rx() Rx error was %#8.8x.\n", desc_status);
 			np->stats.rx_errors++;
 			if (desc_status & RxFIFOErr)
 				np->stats.rx_fifo_errors++;
 			goto next_rx;
 		}
 
+		if (*quota <= 0) {	/* out of rx quota */
+			retcode = 1;
+			goto out;
+		}
+		(*quota)--;
+
 		pkt_len = desc_status;	/* Implicitly Truncate */
 		entry = (desc_status >> 16) & 0x7ff;
 
-#ifndef final_version
 		if (debug > 4)
-			printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d, bogus_cnt %d.\n", pkt_len, boguscnt);
-#endif
+			printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d, quota %d.\n", pkt_len, *quota);
 		/* Check if the packet is long enough to accept without copying
 		   to a minimally-sized skbuff. */
 		if (pkt_len < rx_copybreak
@@ -1456,12 +1641,8 @@
 			pci_dma_sync_single(np->pci_dev,
 					    np->rx_info[entry].mapping,
 					    pkt_len, PCI_DMA_FROMDEVICE);
-#if HAS_IP_COPYSUM			/* Call copy + cksum if available. */
 			eth_copy_and_sum(skb, np->rx_info[entry].skb->tail, pkt_len, 0);
 			skb_put(skb, pkt_len);
-#else
-			memcpy(skb_put(skb, pkt_len), np->rx_info[entry].skb->tail, pkt_len);
-#endif
 		} else {
 			pci_unmap_single(np->pci_dev, np->rx_info[entry].mapping, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			skb = np->rx_info[entry].skb;
@@ -1473,51 +1654,109 @@
 		/* You will want this info for the initial debug. */
 		if (debug > 5)
 			printk(KERN_DEBUG "  Rx data %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:"
-			       "%2.2x %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x %2.2x%2.2x "
-			       "%d.%d.%d.%d.\n",
+			       "%2.2x %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x %2.2x%2.2x.\n",
 			       skb->data[0], skb->data[1], skb->data[2], skb->data[3],
 			       skb->data[4], skb->data[5], skb->data[6], skb->data[7],
 			       skb->data[8], skb->data[9], skb->data[10],
-			       skb->data[11], skb->data[12], skb->data[13],
-			       skb->data[14], skb->data[15], skb->data[16],
-			       skb->data[17]);
+			       skb->data[11], skb->data[12], skb->data[13]);
 #endif
+
 		skb->protocol = eth_type_trans(skb, dev);
-#if defined(full_rx_status) || defined(csum_rx_status)
-		if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000) {
+#if defined(HAS_FIRMWARE) || defined(VLAN_SUPPORT)
+		if (debug > 4)
+			printk(KERN_DEBUG "  netdev_rx() status2 of %d was %#4.4x.\n", np->rx_done, le16_to_cpu(desc->status2));
+#endif
+#ifdef HAS_FIRMWARE
+		if (le16_to_cpu(desc->status2) & 0x0100) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			np->stats.rx_compressed++;
 		}
 		/*
 		 * This feature doesn't seem to be working, at least
 		 * with the two firmware versions I have. If the GFP sees
-		 * a fragment, it either ignores it completely, or reports
+		 * an IP fragment, it either ignores it completely, or reports
 		 * "bad checksum" on it.
 		 *
 		 * Maybe I missed something -- corrections are welcome.
 		 * Until then, the printk stays. :-) -Ion
 		 */
-		else if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x00400000) {
+		else if (le16_to_cpu(desc->status2) & 0x0040) {
 			skb->ip_summed = CHECKSUM_HW;
-			skb->csum = le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0xffff;
-			printk(KERN_DEBUG "%s: checksum_hw, status2 = %x\n", dev->name, np->rx_done_q[np->rx_done].status2);
+			skb->csum = le16_to_cpu(desc->csum);
+			printk(KERN_DEBUG "%s: checksum_hw, status2 = %#x\n", dev->name, le16_to_cpu(desc->status2));
 		}
-#endif
-		netif_rx(skb);
+#endif /* HAS_FIRMWARE */
+#ifdef VLAN_SUPPORT
+		if (np->vlgrp && le16_to_cpu(desc->status2) & 0x0200) {
+			if (debug > 4)
+				printk(KERN_DEBUG "  netdev_rx() vlanid = %d\n", le16_to_cpu(desc->vlanid));
+			/* vlan_netdev_receive_skb() expects a packet with the VLAN tag stripped out */
+			vlan_netdev_receive_skb(skb, np->vlgrp, le16_to_cpu(desc->vlanid) & VLAN_VID_MASK);
+		} else
+#endif /* VLAN_SUPPORT */
+			netdev_receive_skb(skb);
 		dev->last_rx = jiffies;
 		np->stats.rx_packets++;
 
-next_rx:
+	next_rx:
 		np->cur_rx++;
-		np->rx_done_q[np->rx_done].status = 0;
-		np->rx_done = (np->rx_done + 1) & (DONE_Q_SIZE-1);
+		desc->status = 0;
+		np->rx_done = (np->rx_done + 1) % DONE_Q_SIZE;
 	}
 	writew(np->rx_done, dev->base_addr + CompletionQConsumerIdx);
 
+ out:
+	refill_rx_ring(dev);
+	if (debug > 5)
+		printk(KERN_DEBUG "  exiting netdev_rx(): %d, status of %d was %#8.8x.\n",
+		       retcode, np->rx_done, desc_status);
+	return retcode;
+}
+
+
+#ifdef HAVE_NETDEV_POLL
+static int netdev_poll(struct net_device *dev, int *budget)
+{
+	u32 intr_status;
+	long ioaddr = dev->base_addr;
+	int retcode = 0, quota = dev->quota;
+
+	do {
+		writel(IntrRxDone | IntrRxEmpty, ioaddr + IntrClear);
+
+		retcode = __netdev_rx(dev, &quota);
+		*budget -= (dev->quota - quota);
+		dev->quota = quota;
+		if (retcode)
+			goto out;
+
+		intr_status = readl(ioaddr + IntrStatus);
+	} while (intr_status & (IntrRxDone | IntrRxEmpty));
+
+	netif_rx_complete(dev);
+	intr_status = readl(ioaddr + IntrEnable);
+	intr_status |= IntrRxDone | IntrRxEmpty;
+	writel(intr_status, ioaddr + IntrEnable);
+
+ out:
+	if (debug > 5)
+		printk(KERN_DEBUG "  exiting netdev_poll(): %d.\n", retcode);
+
+	/* Restart Rx engine if stopped. */
+	return retcode;
+}
+#endif /* HAVE_NETDEV_POLL */
+
+
+static void refill_rx_ring(struct net_device *dev)
+{
+	struct netdev_private *np = dev->priv;
+	struct sk_buff *skb;
+	int entry = -1;
+
 	/* Refill the Rx ring buffers. */
 	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
-		struct sk_buff *skb;
-		int entry = np->dirty_rx % RX_RING_SIZE;
+		entry = np->dirty_rx % RX_RING_SIZE;
 		if (np->rx_info[entry].skb == NULL) {
 			skb = dev_alloc_skb(np->rx_buf_sz);
 			np->rx_info[entry].skb = skb;
@@ -1527,20 +1766,13 @@
 				pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			skb->dev = dev;	/* Mark as being used by this device. */
 			np->rx_ring[entry].rxaddr =
-				cpu_to_le32(np->rx_info[entry].mapping | RxDescValid);
+				cpu_to_dma(np->rx_info[entry].mapping | RxDescValid);
 		}
 		if (entry == RX_RING_SIZE - 1)
-			np->rx_ring[entry].rxaddr |= cpu_to_le32(RxDescEndRing);
-		/* We could defer this until later... */
-		writew(entry, dev->base_addr + RxDescQIdx);
+			np->rx_ring[entry].rxaddr |= cpu_to_dma(RxDescEndRing);
 	}
-
-	if (debug > 5)
-		printk(KERN_DEBUG "  exiting netdev_rx() status of %d was %8.8x.\n",
-		       np->rx_done, desc_status);
-
-	/* Restart Rx engine if stopped. */
-	return 0;
+	if (entry >= 0)
+		writew(entry, dev->base_addr + RxDescQIdx);
 }
 
 
@@ -1550,6 +1782,7 @@
 	long ioaddr = dev->base_addr;
 	u16 reg0, reg1, reg4, reg5;
 	u32 new_tx_mode;
+	u32 new_intr_timer_ctrl;
 
 	/* reset status first */
 	mdio_read(dev, np->phys[0], MII_BMCR);
@@ -1594,15 +1827,23 @@
 		       np->speed100 ? "100" : "10",
 		       np->mii_if.full_duplex ? "full" : "half");
 
-		new_tx_mode = np->tx_mode & ~0x2;	/* duplex setting */
+		new_tx_mode = np->tx_mode & ~FullDuplex;	/* duplex setting */
 		if (np->mii_if.full_duplex)
-			new_tx_mode |= 2;
+			new_tx_mode |= FullDuplex;
 		if (np->tx_mode != new_tx_mode) {
 			np->tx_mode = new_tx_mode;
-			writel(np->tx_mode | 0x8000, ioaddr + TxMode);
+			writel(np->tx_mode | MiiSoftReset, ioaddr + TxMode);
 			udelay(1000);
 			writel(np->tx_mode, ioaddr + TxMode);
 		}
+
+		new_intr_timer_ctrl = np->intr_timer_ctrl & ~Timer10X;
+		if (np->speed100)
+			new_intr_timer_ctrl |= Timer10X;
+		if (np->intr_timer_ctrl != new_intr_timer_ctrl) {
+			np->intr_timer_ctrl = new_intr_timer_ctrl;
+			writel(new_intr_timer_ctrl, ioaddr + IntrTimerCtrl);
+		}
 	} else {
 		netif_carrier_off(dev);
 		printk(KERN_DEBUG "%s: Link is down\n", dev->name);
@@ -1616,9 +1857,12 @@
 
 	/* Came close to underrunning the Tx FIFO, increase threshold. */
 	if (intr_status & IntrTxDataLow) {
-		writel(++np->tx_threshold, dev->base_addr + TxThreshold);
-		printk(KERN_NOTICE "%s: Increasing Tx FIFO threshold to %d bytes\n",
-		       dev->name, np->tx_threshold * 16);
+		if (np->tx_threshold <= PKT_BUF_SZ / 16) {
+			writel(++np->tx_threshold, dev->base_addr + TxThreshold);
+			printk(KERN_NOTICE "%s: PCI bus congestion, increasing Tx FIFO threshold to %d bytes\n",
+			       dev->name, np->tx_threshold * 16);
+		} else
+			printk(KERN_WARNING "%s: PCI Tx underflow -- adapter is probably malfunctioning\n", dev->name);
 	}
 	if (intr_status & IntrRxGFPDead) {
 		np->stats.rx_fifo_errors++;
@@ -1629,7 +1873,7 @@
 		np->stats.tx_errors++;
 	}
 	if ((intr_status & ~(IntrNormalMask | IntrAbnormalSummary | IntrLinkChange | IntrStatsMax | IntrTxDataLow | IntrRxGFPDead | IntrNoTxCsum | IntrPCIPad)) && debug)
-		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
+		printk(KERN_ERR "%s: Something Wicked happened! %#8.8x.\n",
 		       dev->name, intr_status);
 }
 
@@ -1664,39 +1908,67 @@
 /* Chips may use the upper or lower CRC bits, and may reverse and/or invert
    them.  Select the endian-ness that results in minimal calculations.
 */
-
 static void set_rx_mode(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	u32 rx_mode;
+	u32 rx_mode = MinVLANPrio;
 	struct dev_mc_list *mclist;
 	int i;
+#ifdef VLAN_SUPPORT
+	struct netdev_private *np = dev->priv;
+
+	rx_mode |= VlanMode;
+	if (np->vlgrp) {
+		int vlan_count = 0;
+		long filter_addr = ioaddr + HashTable + 8;
+		for (i = 0; i < VLAN_VID_MASK; i++) {
+			if (np->vlgrp->vlan_devices[i]) {
+				if (vlan_count >= 32)
+					break;
+				writew(cpu_to_be16(i), filter_addr);
+				filter_addr += 16;
+				vlan_count++;
+			}
+		}
+		if (i == VLAN_VID_MASK) {
+			rx_mode |= PerfectFilterVlan;
+			while (vlan_count < 32) {
+				writew(0, filter_addr);
+				filter_addr += 16;
+				vlan_count++;
+			}
+		}
+	}
+#endif /* VLAN_SUPPORT */
 
 	if (dev->flags & IFF_PROMISC) {	/* Set promiscuous. */
-		rx_mode = AcceptBroadcast|AcceptAllMulticast|AcceptAll|AcceptMyPhys;
+		rx_mode |= AcceptAll;
 	} else if ((dev->mc_count > multicast_filter_limit)
 		   || (dev->flags & IFF_ALLMULTI)) {
 		/* Too many to match, or accept all multicasts. */
-		rx_mode = AcceptBroadcast|AcceptAllMulticast|AcceptMyPhys;
-	} else if (dev->mc_count <= 15) {
-		/* Use the 16 element perfect filter, skip first entry. */
-		long filter_addr = ioaddr + PerfFilterTable + 1 * 16;
-		for (i = 1, mclist = dev->mc_list; mclist && i <= dev->mc_count;
+		rx_mode |= AcceptBroadcast|AcceptAllMulticast|PerfectFilter;
+	} else if (dev->mc_count <= 14) {
+		/* Use the 16 element perfect filter, skip first two entries. */
+		long filter_addr = ioaddr + PerfFilterTable + 2 * 16;
+		u16 *eaddrs;
+		for (i = 2, mclist = dev->mc_list; mclist && i < dev->mc_count + 2;
 		     i++, mclist = mclist->next) {
-			u16 *eaddrs = (u16 *)mclist->dmi_addr;
+			eaddrs = (u16 *)mclist->dmi_addr;
 			writew(cpu_to_be16(eaddrs[2]), filter_addr); filter_addr += 4;
 			writew(cpu_to_be16(eaddrs[1]), filter_addr); filter_addr += 4;
 			writew(cpu_to_be16(eaddrs[0]), filter_addr); filter_addr += 8;
 		}
+		eaddrs = (u16 *)dev->dev_addr;
 		while (i++ < 16) {
-			writew(0xffff, filter_addr); filter_addr += 4;
-			writew(0xffff, filter_addr); filter_addr += 4;
-			writew(0xffff, filter_addr); filter_addr += 8;
+			writew(cpu_to_be16(eaddrs[0]), filter_addr); filter_addr += 4;
+			writew(cpu_to_be16(eaddrs[1]), filter_addr); filter_addr += 4;
+			writew(cpu_to_be16(eaddrs[2]), filter_addr); filter_addr += 8;
 		}
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
+		rx_mode |= AcceptBroadcast|PerfectFilter;
 	} else {
 		/* Must use a multicast hash table. */
 		long filter_addr;
+		u16 *eaddrs;
 		u16 mc_filter[32] __attribute__ ((aligned(sizeof(long))));	/* Multicast hash filter */
 
 		memset(mc_filter, 0, sizeof(mc_filter));
@@ -1707,16 +1979,17 @@
 
 			*fptr |= cpu_to_le32(1 << (bit_nr & 31));
 		}
-		/* Clear the perfect filter list, skip first entry. */
-		filter_addr = ioaddr + PerfFilterTable + 1 * 16;
-		for (i = 1; i < 16; i++) {
-			writew(0xffff, filter_addr); filter_addr += 4;
-			writew(0xffff, filter_addr); filter_addr += 4;
-			writew(0xffff, filter_addr); filter_addr += 8;
+		/* Clear the perfect filter list, skip first two entries. */
+		filter_addr = ioaddr + PerfFilterTable + 2 * 16;
+		eaddrs = (u16 *)dev->dev_addr;
+		for (i = 2; i < 16; i++) {
+			writew(cpu_to_be16(eaddrs[0]), filter_addr); filter_addr += 4;
+			writew(cpu_to_be16(eaddrs[1]), filter_addr); filter_addr += 4;
+			writew(cpu_to_be16(eaddrs[2]), filter_addr); filter_addr += 8;
 		}
-		for (filter_addr = ioaddr + HashTable, i=0; i < 32; filter_addr+= 16, i++)
+		for (filter_addr = ioaddr + HashTable, i = 0; i < 32; filter_addr+= 16, i++)
 			writew(mc_filter[i], filter_addr);
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+		rx_mode |= AcceptBroadcast|PerfectFilter|HashFilter;
 	}
 	writel(rx_mode, ioaddr + RxFilterMode);
 }
@@ -1763,6 +2036,7 @@
 		spin_lock_irq(&np->lock);
 		r = mii_ethtool_sset(&np->mii_if, &ecmd);
 		spin_unlock_irq(&np->lock);
+		check_duplex(dev);
 		return r;
 	}
 	/* restart autonegotiation */
@@ -1816,7 +2090,7 @@
 		spin_lock_irq(&np->lock);
 		rc = generic_mii_ioctl(&np->mii_if, data, cmd, NULL);
 		spin_unlock_irq(&np->lock);
-		
+
 		if ((cmd == SIOCSMIIREG) && (data->phy_id == np->phys[0]))
 			check_duplex(dev);
 	}
@@ -1834,41 +2108,42 @@
 	netif_stop_if(dev);
 
 	if (debug > 1) {
-		printk(KERN_DEBUG "%s: Shutting down ethercard, Intr status %4.4x.\n",
-			   dev->name, (int)readl(ioaddr + IntrStatus));
-		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
-			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
+		printk(KERN_DEBUG "%s: Shutting down ethercard, Intr status %#8.8x.\n",
+			   dev->name, (int) readl(ioaddr + IntrStatus));
+		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d, Rx %d / %d.\n",
+		       dev->name, np->cur_tx, np->dirty_tx,
+		       np->cur_rx, np->dirty_rx);
 	}
 
 	/* Disable interrupts by clearing the interrupt mask. */
 	writel(0, ioaddr + IntrEnable);
 
 	/* Stop the chip's Tx and Rx processes. */
+	writel(0, ioaddr + GenCtrl);
+	readl(ioaddr + GenCtrl);
 
-#ifdef __i386__
-	if (debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %9.9Lx:\n",
-			   (u64) np->tx_ring_dma);
+	if (debug > 5) {
+		printk(KERN_DEBUG"  Tx ring at %#llx:\n",
+		       (long long) np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
-			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
+			printk(KERN_DEBUG " #%d desc. %#8.8x %#llx -> %#8.8x.\n",
 			       i, le32_to_cpu(np->tx_ring[i].status),
-			       le32_to_cpu(np->tx_ring[i].first_addr),
+			       (long long) dma_to_cpu(np->tx_ring[i].addr),
 			       le32_to_cpu(np->tx_done_q[i].status));
-		printk(KERN_DEBUG "  Rx ring at %9.9Lx -> %p:\n",
-		       (u64) np->rx_ring_dma, np->rx_done_q);
+		printk(KERN_DEBUG "  Rx ring at %#llx -> %p:\n",
+		       (long long) np->rx_ring_dma, np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
-				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",
-				       i, le32_to_cpu(np->rx_ring[i].rxaddr), le32_to_cpu(np->rx_done_q[i].status));
+				printk(KERN_DEBUG " #%d desc. %#llx -> %#8.8x\n",
+				       i, (long long) dma_to_cpu(np->rx_ring[i].rxaddr), le32_to_cpu(np->rx_done_q[i].status));
 		}
 	}
-#endif /* __i386__ debugging only */
 
 	free_irq(dev->irq, dev);
 
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].rxaddr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
+		np->rx_ring[i].rxaddr = cpu_to_dma(0xBADF00D0); /* An invalid address. */
 		if (np->rx_info[i].skb != NULL) {
 			pci_unmap_single(np->pci_dev, np->rx_info[i].mapping, np->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(np->rx_info[i].skb);
@@ -1878,28 +2153,14 @@
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		struct sk_buff *skb = np->tx_info[i].skb;
-#ifdef ZEROCOPY
-		int j;
-#endif /* ZEROCOPY */
 		if (skb == NULL)
 			continue;
 		pci_unmap_single(np->pci_dev,
-				 np->tx_info[i].first_mapping,
+				 np->tx_info[i].mapping,
 				 skb_first_frag_len(skb), PCI_DMA_TODEVICE);
-		np->tx_info[i].first_mapping = 0;
+		np->tx_info[i].mapping = 0;
 		dev_kfree_skb(skb);
 		np->tx_info[i].skb = NULL;
-#ifdef ZEROCOPY
-		for (j = 0; j < MAX_STARFIRE_FRAGS; j++)
-			if (np->tx_info[i].frag_mapping[j]) {
-				pci_unmap_single(np->pci_dev,
-						 np->tx_info[i].frag_mapping[j],
-						 skb_shinfo(skb)->frags[j].size,
-						 PCI_DMA_TODEVICE);
-				np->tx_info[i].frag_mapping[j] = 0;
-			} else
-				break;
-#endif /* ZEROCOPY */
 	}
 
 	COMPAT_MOD_DEC_USE_COUNT;
@@ -1917,21 +2178,15 @@
 		BUG();
 
 	np = dev->priv;
-	if (np->tx_done_q)
-		pci_free_consistent(pdev, PAGE_SIZE,
-				    np->tx_done_q, np->tx_done_q_dma);
-	if (np->rx_done_q)
-		pci_free_consistent(pdev,
-				    sizeof(struct rx_done_desc) * DONE_Q_SIZE,
-				    np->rx_done_q, np->rx_done_q_dma);
-	if (np->tx_ring)
-		pci_free_consistent(pdev, PAGE_SIZE,
-				    np->tx_ring, np->tx_ring_dma);
-	if (np->rx_ring)
-		pci_free_consistent(pdev, PAGE_SIZE,
-				    np->rx_ring, np->rx_ring_dma);
+	if (np->queue_mem)
+		pci_free_consistent(pdev, np->queue_mem_size, np->queue_mem, np->queue_mem_dma);
 
 	unregister_netdev(dev);
+
+	/* XXX: add wakeup code -- requires firmware for MagicPacket */
+	pci_set_power_state(pdev, 3);	/* go to sleep in D3 mode */
+	pci_disable_device(pdev);
+
 	iounmap((char *)dev->base_addr);
 	pci_release_regions(pdev);
 
@@ -1954,6 +2209,17 @@
 #ifdef MODULE
 	printk(version);
 #endif
+#ifndef ADDR_64BITS
+	/* we can do this test only at run-time... sigh */
+	if (sizeof(dma_addr_t) == sizeof(u64)) {
+		printk("This driver has not been ported to this 64-bit architecture yet\n");
+		return -ENODEV;
+	}
+#endif /* not ADDR_64BITS */
+#ifndef HAS_FIRMWARE
+	/* unconditionally disable hw cksums if firmware is not present */
+	enable_hw_cksum = 0;
+#endif /* not HAS_FIRMWARE */
 	return pci_module_init (&starfire_driver);
 }
 
@@ -1970,8 +2236,6 @@
 
 /*
  * Local variables:
- *  compile-command: "gcc -DMODULE -Wall -Wstrict-prototypes -O2 -c starfire.c"
- *  simple-compile-command: "gcc -DMODULE -O2 -c starfire.c"
  *  c-basic-offset: 8
  *  tab-width: 8
  * End:

