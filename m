Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRJTBJK>; Fri, 19 Oct 2001 21:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278710AbRJTBJG>; Fri, 19 Oct 2001 21:09:06 -0400
Received: from patan.Sun.COM ([192.18.98.43]:52954 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278709AbRJTBI4>;
	Fri, 19 Oct 2001 21:08:56 -0400
Message-ID: <3BD0CDED.3850B31D@sun.com>
Date: Fri, 19 Oct 2001 18:05:49 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jgarzik@mandrakesoft.com, manfred@colorfullife.com
Subject: [PATCH] try #2 even bigger natsemi patch
Content-Type: multipart/mixed;
 boundary="------------B140C38C5B1CF59C0113CCD5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B140C38C5B1CF59C0113CCD5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff,

I took your feedback, and cleaned up both the patch and more.  Attached are
two seperate diffs - one for adding the natsemi to pci_ids.h, and one
against natsemi.c

I'll do my best to narrate the dif hunk by hunk.  I hope this is sufficient
for you to send it on, now :)

* comments

* update release info
* add strings for 83816
 
* formatting for 8-space tab disply

* increase RX Queue to eliminate some Something Wicked messages
* Define the timer frequency
* formatting

* formatting

* strings for 83816
* use new PCI ID (depends on pci_ids.h patch

* formatting
* add constants for magic register's values
* rename an enum for consistancy
* rename all 'bit' enums so they are named the same as their 
  register, and are found in the same order
* Add a comment about the default interrupt state
* Add some missing but needed bits definitions (TXConfig...)

* more bits
* constants for Silicon Revisions

* more bits for descriptor status

* store SRR in private struct
* formatting
* add mdio_write function protoype

* formatting

* magic number removal

* call eeprom reload during probe - BEFORE chip reset

* use MII defines for mdio
* magic number removal
* save SRR

* moved bits

* cleanup mdio_read to look more like mdio_write
* add mdio_write
* add defines for bits to save across a reset
* expand natsemi_reset() to save and restore state that would be 
  nuked by a chip reset

* add a natsemi_reload_eeprom() func

* use a constant for netdev timer
* formatting

* magic number removal

* use the stored SRR
* poll for AnegDone for a bit during open()

* use magic register constants
* comments
* cleanup for WoL
* magic numbers
* no need to blast mac-address, natsemi_reset should be doing it now

* magic numbers

* print if we got a WoL event

* add the phy reset checker to catch spurious PHY resets
* use mod_timer

* formatting

* magic numbers

* increase a debug level (didn't check into netif_msg yet - later

* magic numbers

* use mdio_read where applicable

* magic

* get rid of "Something Wicked" and print what it actually is

* fixup bit definitions

* only do SOPASS for rev D or up

* remove FIXME comment

* More SOPASS for rev D

* Magic numbers

* use MII defines where appropriate

* use mdio_read()/mdio_write()

* WoL cleanup


Detailed enough?  Please don't make me break it down further :)	
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------B140C38C5B1CF59C0113CCD5
Content-Type: text/plain; charset=us-ascii;
 name="include_linux_pci_ids.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="include_linux_pci_ids.h.diff"

diff -ruN dist-2.4.12+patches/include/linux/pci_ids.h cvs-2.4.12+patches/include/linux/pci_ids.h
--- dist-2.4.12+patches/include/linux/pci_ids.h	Mon Oct 15 10:23:43 2001
+++ cvs-2.4.12+patches/include/linux/pci_ids.h	Mon Oct 15 10:23:43 2001
@@ -285,6 +285,7 @@
 #define PCI_DEVICE_ID_NS_87415		0x0002
 #define PCI_DEVICE_ID_NS_87560_LIO	0x000e
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
+#define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
 #define PCI_VENDOR_ID_TSENG		0x100c

--------------B140C38C5B1CF59C0113CCD5
Content-Type: text/plain; charset=us-ascii;
 name="drivers_net_natsemi.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_net_natsemi.c.diff"

diff -ruN dist-2.4.12+patches/drivers/net/natsemi.c cvs-2.4.12+patches/drivers/net/natsemi.c
--- dist-2.4.12+patches/drivers/net/natsemi.c	Mon Oct 15 10:22:07 2001
+++ cvs-2.4.12+patches/drivers/net/natsemi.c	Mon Oct 15 10:22:08 2001
@@ -85,6 +85,14 @@
 		* use long for ee_addr (various)
 		* print pointers properly (DaveM)
 		* include asm/irq.h (?)
+	
+	version 1.0.11:
+		* check and reset if PHY errors appear (Adrian Sun)
+		* WoL cleanup (Tim Hockin)
+		* Magic number cleanup (Tim Hockin)
+		* Don't reload EEPROM on every reset (Tim Hockin)
+		* Save and restore EEPROM state across reset (Tim Hockin)
+		* MDIO Cleanup (Tim Hockin)
 
 	TODO:
 	* big endian support with CFG:BEM instead of cpu_to_le32
@@ -93,9 +101,8 @@
 */
 
 #define DRV_NAME	"natsemi"
-#define DRV_VERSION	"1.07+LK1.0.10"
-#define DRV_RELDATE	"Oct 09, 2001"
-
+#define DRV_VERSION	"1.07+LK1.0.11"
+#define DRV_RELDATE	"Oct 19, 2001"
 
 /* Updated to recommendations in pci-skeleton v2.03. */
 
@@ -106,7 +113,7 @@
 c-help-name: National Semiconductor DP8381x series PCI Ethernet support
 c-help-symbol: CONFIG_NATSEMI
 c-help: This driver is for the National Semiconductor DP8381x series,
-c-help: including the 83815 chip.
+c-help: including the 8381[56] chips.
 c-help: More specific information and updates are available from 
 c-help: http://www.scyld.com/network/natsemi.html
 */
@@ -114,10 +121,12 @@
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 
-static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
+static int debug = 1; /* 1 normal messages, 0 quiet .. 7 verbose. */
+
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
 static int max_interrupt_work = 20;
 static int mtu;
+
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    This chip uses a 512 element hash table based on the Ethernet CRC.  */
 static int multicast_filter_limit = 100;
@@ -143,16 +152,17 @@
    bonding and packet priority.
    There are no ill effects from too-large receive rings. */
 #define TX_RING_SIZE	16
-#define TX_QUEUE_LEN	10		/* Limit ring entries actually used, min 4.  */
-#define RX_RING_SIZE	32
+#define TX_QUEUE_LEN	10 /* Limit ring entries actually used, min 4. */
+#define RX_RING_SIZE	64
 
 /* Operational parameters that usually are not changed. */
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (2*HZ)
 
 #define NATSEMI_HW_TIMEOUT	400
+#define NATSEMI_TIMER_FREQ	3*HZ
 
-#define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
+#define PKT_BUF_SZ		1536 /* Size of each temporary Rx buffer. */
 
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
@@ -179,17 +189,18 @@
 #include <linux/delay.h>
 #include <linux/rtnetlink.h>
 #include <linux/mii.h>
-#include <asm/processor.h>		/* Processor type for cache alignment. */
+#include <asm/processor.h> /* Processor type for cache alignment. */
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
 /* These identify the driver base version and may not be removed. */
-static char version[] __devinitdata =
-KERN_INFO DRV_NAME ".c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>\n"
-KERN_INFO "  http://www.scyld.com/network/natsemi.html\n"
-KERN_INFO "  (unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE "  Jeff Garzik, Tjeerd Mulder)\n";
+static char version[] __devinitdata = KERN_INFO 
+__FILE__ ":v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>\n"
+"  http://www.scyld.com/network/natsemi.html\n"
+"  unofficial 2.4.x kernel port, version " DRV_VERSION ", " DRV_RELDATE "\n"
+"  Jeff Garzik, Tjeerd Mulder\n";
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("National Semiconductor DP8381x series PCI Ethernet driver");
@@ -308,11 +319,11 @@
 	const char *name;
 	unsigned long flags;
 } natsemi_pci_info[] __devinitdata = {
-	{ "NatSemi DP83815", PCI_IOTYPE },
+	{ "NatSemi DP8381[56]", PCI_IOTYPE },
 };
 
 static struct pci_device_id natsemi_pci_tbl[] __devinitdata = {
-	{ 0x100B, 0x0020, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_83815, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, natsemi_pci_tbl);
@@ -331,54 +342,94 @@
 	BootRomAddr=0x50, BootRomData=0x54, SiliconRev=0x58, StatsCtrl=0x5C,
 	StatsData=0x60, RxPktErrs=0x60, RxMissed=0x68, RxCRCErrs=0x64,
 	BasicControl=0x80, BasicStatus=0x84,
-	AnegAdv=0x90, AnegPeer = 0x94, PhyStatus=0xC0, MIntrCtrl=0xC4, 
+	AnegAdv=0x90, AnegPeer=0x94, PhyStatus=0xC0, MIntrCtrl=0xC4, 
 	MIntrStatus=0xC8, PhyCtrl=0xE4,
 
 	/* These are from the spec, around page 78... on a separate table.
 	 * The meaning of these registers depend on the value of PGSEL. */
-	PGSEL=0xCC, PMDCSR=0xE4, TSTDAT=0xFC, DSPCFG=0xF4, SDCFG=0x8C
+	PGSEL=0xCC, PMDCSR=0xE4, TSTDAT=0xFC, DSPCFG=0xF4, SDCFG=0xF8
 };
+/* the values for the 'magic' registers above (PGSEL=1) */
+#define PMDCSR_VAL	0x189C
+#define TSTDAT_VAL	0x0
+#define DSPCFG_VAL	0x5040
+#define SDCFG_VAL	0x008c
 
 /* misc PCI space registers */
-enum PCISpaceRegs {
+enum pci_register_offsets {
 	PCIPM=0x44,
 };
 
-/* Bit in ChipCmd. */
-enum ChipCmdBits {
+enum ChipCmd_bits {
 	ChipReset=0x100, RxReset=0x20, TxReset=0x10, RxOff=0x08, RxOn=0x04,
 	TxOff=0x02, TxOn=0x01,
 };
 
-enum PCIBusCfgBits {
+enum ChipConfig_bits {
+	CfgPhyDis=0x200, CfgPhyRst=0x400, CfgAnegEnable=0x2000,
+	CfgAneg100=0x4000, CfgAnegFull=0x8000, CfgAnegDone=0x8000000,
+	CfgFullDuplex=0x20000000,
+	CfgSpeed100=0x40000000, CfgLink=0x80000000,
+};
+
+enum EECtrl_bits {
+	EE_ShiftClk=0x04, EE_DataIn=0x01, EE_ChipSelect=0x08, EE_DataOut=0x02,
+};
+
+enum PCIBusCfg_bits {
 	EepromReload=0x4,
 };
 
 /* Bits in the interrupt status/mask registers. */
-enum intr_status_bits {
-	IntrRxDone=0x0001, IntrRxIntr=0x0002, IntrRxErr=0x0004, IntrRxEarly=0x0008,
-	IntrRxIdle=0x0010, IntrRxOverrun=0x0020,
+enum IntrStatus_bits {
+	IntrRxDone=0x0001, IntrRxIntr=0x0002, IntrRxErr=0x0004, 
+	IntrRxEarly=0x0008, IntrRxIdle=0x0010, IntrRxOverrun=0x0020,
 	IntrTxDone=0x0040, IntrTxIntr=0x0080, IntrTxErr=0x0100,
 	IntrTxIdle=0x0200, IntrTxUnderrun=0x0400,
-	StatsMax=0x0800, LinkChange=0x4000,
-	WOLPkt=0x2000,
+	StatsMax=0x0800, SWInt=0x1000, WOLPkt=0x2000, LinkChange=0x4000, 
+	IntrHighBits=0x8000,
+	RxStatusFIFOOver=0x10000,
+	IntrPCIErr=0xf00000,
 	RxResetDone=0x1000000, TxResetDone=0x2000000,
-	IntrPCIErr=0x00f00000,
-	IntrNormalSummary=0x025f, IntrAbnormalSummary=0xCD20,
+	IntrAbnormalSummary=0xCD20,
 };
 
+/*
+ * Default Interrupts:
+ * Rx OK, Rx Packet Error, Rx Overrun, 
+ * Tx OK, Tx Packet Error, Tx Underrun, 
+ * MIB Service, Phy Interrupt, High Bits,
+ * Rx Status FIFO overrun,
+ * Received Target Abort, Received Master Abort, 
+ * Signalled System Error, Received Parity Error
+ */
 #define DEFAULT_INTR 0x00f1cd65
 
-/* Bits in the RxMode register. */
-enum rx_mode_bits {
-	AcceptErr=0x20, AcceptRunt=0x10,
-	AcceptBroadcast=0xC0000000,
-	AcceptMulticast=0x00200000, AcceptAllMulticast=0x20000000,
-	AcceptAllPhys=0x10000000, AcceptMyPhys=0x08000000,
+enum TxConfig_bits {
+	TxDrthMask=0x3f, TxFlthMask=0x3f00, 
+	TxMxdmaMask=0x700000, TxMxdma_512=0x0, 
+	TxMxdma_4=0x100000, TxMxdma_8=0x200000, TxMxdma_16=0x300000,
+	TxMxdma_32=0x400000, TxMxdma_64=0x500000, TxMxdma_128=0x600000,
+	TxMxdma_256=0x700000, TxCollRetry=0x800000,
+	TxAutoPad=0x10000000, TxMacLoop=0x20000000,
+	TxHeartIgn=0x40000000, TxCarrierIgn=0x80000000
 };
 
-/* Bits in WOLCmd register. */
-enum wol_bits {
+enum RxConfig_bits {
+	RxDrthMask=0x3e,
+	RxMxdmaMask=0x700000, RxMxdma_512=0x0, 
+	RxMxdma_4=0x100000, RxMxdma_8=0x200000, RxMxdma_16=0x300000,
+	RxMxdma_32=0x400000, RxMxdma_64=0x500000, RxMxdma_128=0x600000,
+	RxMxdma_256=0x700000,
+       	RxAcceptLong=0x8000000, RxAcceptTx=0x10000000, 
+	RxAcceptRunt=0x40000000, RxAcceptErr=0x80000000
+};
+
+enum ClkRun_bits {
+	PMEEnable=0x100, PMEStatus=0x8000,
+};
+
+enum WolCmd_bits {
 	WakePhy=0x1, WakeUnicast=0x2, WakeMulticast=0x4, WakeBroadcast=0x8,
 	WakeArp=0x10, WakePMatch0=0x20, WakePMatch1=0x40, WakePMatch2=0x80,
 	WakePMatch3=0x100, WakeMagic=0x200, WakeMagicSecure=0x400, 
@@ -388,23 +439,28 @@
 	WokePMatch3=0x40000000, WokeMagic=0x80000000, WakeOptsSummary=0x7ff
 };
 
-enum aneg_bits {
-	Aneg10BaseT=0x20, Aneg10BaseTFull=0x40, 
-	Aneg100BaseT=0x80, Aneg100BaseTFull=0x100,
+enum RxFilterAddr_bits {
+	RFCRAddressMask=0x3ff, 
+	AcceptMulticast=0x00200000, AcceptMyPhys=0x08000000,
+	AcceptAllPhys=0x10000000, AcceptAllMulticast=0x20000000,
+	AcceptBroadcast=0x40000000, RxFilterEnable=0x80000000
 };
 
-enum config_bits {
-	CfgPhyDis=0x200, CfgPhyRst=0x400, CfgAnegEnable=0x2000,
-	CfgAneg100=0x4000, CfgAnegFull=0x8000, CfgAnegDone=0x8000000,
-	CfgFullDuplex=0x20000000,
-	CfgSpeed100=0x40000000, CfgLink=0x80000000,
+enum StatsCtrl_bits {
+	StatsWarn=0x1, StatsFreeze=0x2, StatsClear=0x4, StatsStrobe=0x8,
 };
 
-enum bmcr_bits {
-	BMCRDuplex=0x100, BMCRAnegRestart=0x200, BMCRAnegEnable=0x1000,
-	BMCRSpeed=0x2000, BMCRPhyReset=0x8000,
+enum MIntrCtrl_bits {
+	MICRIntEn=0x2,
 };
 
+enum PhyCtrl_bits {
+	PhyAddrMask = 0xf,
+};
+
+#define SRR_REV_C	0x0302
+#define SRR_REV_D	0x0403
+
 /* The Rx and Tx buffer descriptors. */
 /* Note that using only 32 bit fields simplifies conversion to big-endian
    architectures. */
@@ -418,8 +474,19 @@
 /* Bits in network_desc.status */
 enum desc_status_bits {
 	DescOwn=0x80000000, DescMore=0x40000000, DescIntr=0x20000000,
-	DescNoCRC=0x10000000,
-	DescPktOK=0x08000000, RxTooLong=0x00400000,
+	DescNoCRC=0x10000000, DescPktOK=0x08000000, 
+	DescSizeMask=0xfff,
+
+	DescTxAbort=0x04000000, DescTxFIFO=0x02000000, 
+	DescTxCarrier=0x01000000, DescTxDefer=0x00800000,
+	DescTxExcDefer=0x00400000, DescTxOOWCol=0x00200000,
+	DescTxExcColl=0x00100000, DescTxCollCount=0x000f0000,
+	
+	DescRxAbort=0x04000000, DescRxOver=0x02000000,
+	DescRxDest=0x01800000, DescRxLong=0x00400000,
+	DescRxRunt=0x00200000, DescRxInvalid=0x00100000,
+	DescRxCRC=0x00080000, DescRxAlign=0x00040000,
+	DescRxLoop=0x00020000, DesRxColl=0x00010000,
 };
 
 struct netdev_private {
@@ -450,17 +517,21 @@
 	u32 tx_config, rx_config;
 	/* original contents of ClkRun register */
 	u32 SavedClkRun;
+	/* silicon revision */
+	u32 srr;
 	/* MII transceiver section. */
-	u16 advertising;			/* NWay media advertisement */
+	u16 advertising; /* NWay media advertisement */
 	unsigned int iosize;
 	spinlock_t lock;
 };
 
-static int  eeprom_read(long ioaddr, int location);
-static int  mdio_read(struct net_device *dev, int phy_id, int location);
+static int eeprom_read(long ioaddr, int location);
+static int mdio_read(struct net_device *dev, int phy_id, int reg);
+static void mdio_write(struct net_device *dev, int phy_id, int reg, u16 data);
 static void natsemi_reset(struct net_device *dev);
+static void natsemi_reload_eeprom(struct net_device *dev);
 static void natsemi_stop_rxtx(struct net_device *dev);
-static int  netdev_open(struct net_device *dev);
+static int netdev_open(struct net_device *dev);
 static void check_link(struct net_device *dev);
 static void netdev_timer(unsigned long data);
 static void tx_timeout(struct net_device *dev);
@@ -469,7 +540,7 @@
 static void drain_ring(struct net_device *dev);
 static void free_ring(struct net_device *dev);
 static void init_registers(struct net_device *dev);
-static int  start_tx(struct sk_buff *skb, struct net_device *dev);
+static int start_tx(struct sk_buff *skb, struct net_device *dev);
 static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs);
 static void netdev_error(struct net_device *dev, int intr_status);
 static void netdev_rx(struct net_device *dev);
@@ -486,7 +557,7 @@
 static int netdev_get_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd);
 static int netdev_set_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd);
 static void enable_wol_mode(struct net_device *dev, int enable_intr);
-static int  netdev_close(struct net_device *dev);
+static int netdev_close(struct net_device *dev);
 
 
 static int __devinit natsemi_probe1 (struct pci_dev *pdev,
@@ -516,9 +587,9 @@
 	 * to be brought to D0 in this manner.
 	 */
 	pci_read_config_dword(pdev, PCIPM, &tmp);
-	if (tmp & (0x03|0x100)) {
+	if (tmp & PCI_PM_CTRL_STATE_MASK) {
 		/* D0 state, disable PME assertion */
-		u32 newtmp = tmp & ~(0x03|0x100);
+		u32 newtmp = tmp & ~PCI_PM_CTRL_STATE_MASK;
 		pci_write_config_dword(pdev, PCIPM, newtmp);
 	}
 
@@ -571,7 +642,9 @@
 	spin_lock_init(&np->lock);
 
 	/* Reset the chip to erase previous misconfiguration. */
+	natsemi_reload_eeprom(dev);
 	natsemi_reset(dev);
+
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	if (dev->mem_start)
 		option = dev->mem_start;
@@ -616,20 +689,23 @@
 			printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);
 
-	np->advertising = mdio_read(dev, 1, 4);
+	np->advertising = mdio_read(dev, 1, MII_ADVERTISE);
 	if ((readl(ioaddr + ChipConfig) & 0xe000) != 0xe000) {
 		u32 chip_config = readl(ioaddr + ChipConfig);
 		printk(KERN_INFO "%s: Transceiver default autonegotiation %s "
 			   "10%s %s duplex.\n",
 			   dev->name,
-			   chip_config & 0x2000 ? "enabled, advertise" : "disabled, force",
-			   chip_config & 0x4000 ? "0" : "",
-			   chip_config & 0x8000 ? "full" : "half");
+			   chip_config & CfgAnegEnable ? "enabled, advertise" : "disabled, force",
+			   chip_config & CfgAneg100 ? "0" : "",
+			   chip_config & CfgAnegFull ? "full" : "half");
 	}
 	printk(KERN_INFO "%s: Transceiver status 0x%4.4x advertising %4.4x.\n",
-		   dev->name, (int)readl(ioaddr + BasicStatus), 
+		   dev->name, (int)mdio_read(dev, 1, MII_BMSR), 
 		   np->advertising);
 
+	/* save the silicon revision for later querying */
+	np->srr = readl(ioaddr + SiliconRev);
+
 	return 0;
 }
 
@@ -646,9 +722,6 @@
 */
 #define eeprom_delay(ee_addr)	readl(ee_addr)
 
-enum EEPROM_Ctrl_Bits {
-	EE_ShiftClk=0x04, EE_DataIn=0x01, EE_ChipSelect=0x08, EE_DataOut=0x02,
-};
 #define EE_Write0 (EE_ChipSelect)
 #define EE_Write1 (EE_ChipSelect | EE_DataIn)
 
@@ -694,18 +767,67 @@
 	The 83815 series has an internal transceiver, and we present the
 	management registers as if they were MII connected. */
 
-static int mdio_read(struct net_device *dev, int phy_id, int location)
+static int mdio_read(struct net_device *dev, int phy_id, int reg)
 {
-	if (phy_id == 1 && location < 32)
-		return readl(dev->base_addr+BasicControl+(location<<2))&0xffff;
+	if (phy_id == 1 && reg < 32)
+		return readl(dev->base_addr+BasicControl+(reg<<2))&0xffff;
 	else
 		return 0xffff;
 }
 
+static void mdio_write(struct net_device *dev, int phy_id, int reg, u16 data)
+{
+	struct netdev_private *np = dev->priv;
+	if (phy_id == 1 && reg < 32) {
+		writew(data, dev->base_addr+BasicControl+(reg<<2));
+		switch (reg) {
+			case MII_ADVERTISE: np->advertising = data; break;
+		}
+	}
+}
+
+/* CFG bits [13:16] [18:23] */
+#define CFG_RESET_SAVE 0xfde000
+/* WCSR bits [0:4] [9:10] */
+#define WCSR_RESET_SAVE 0x61f
+/* RFCR bits [20] [22] [27:31] */
+#define RFCR_RESET_SAVE 0xf8500000;
+
 static void natsemi_reset(struct net_device *dev)
 {
 	int i;
+	u32 cfg;
+	u32 wcsr;
+	u32 rfcr;
+	u16 pmatch[3];
+	u16 sopass[3];
+
+	/* 
+	 * Resetting the chip causes some registers to be lost.
+	 * Natsemi suggests NOT reloading the EEPROM while live, so instead
+	 * we save the state that would have been loaded from EEPROM
+	 * on a normal power-up (see the spec EEPROM map).  This assumes 
+	 * whoever calls this will follow up with init_registers() eventually.
+	 */
+
+	/* CFG */
+	cfg = readl(dev->base_addr + ChipConfig) & CFG_RESET_SAVE;
+	/* WCSR */
+	wcsr = readl(dev->base_addr + WOLCmd) & WCSR_RESET_SAVE;
+	/* RFCR */
+	rfcr = readl(dev->base_addr + RxFilterAddr) & RFCR_RESET_SAVE;
+	/* PMATCH */
+	for (i = 0; i < 3; i++) {
+		writel(i*2, dev->base_addr + RxFilterAddr);
+		pmatch[i] = readw(dev->base_addr + RxFilterData);
+	}
+	/* SOPAS */
+	for (i = 0; i < 3; i++) {
+		writel(0xa+(i*2), dev->base_addr + RxFilterAddr);
+		sopass[i] = readw(dev->base_addr + RxFilterData);
+	}
 
+	/* now whack the chip */
 	writel(ChipReset, dev->base_addr + ChipCmd);
 	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
 		if (!(readl(dev->base_addr + ChipCmd) & ChipReset))
@@ -720,6 +842,32 @@
 		   dev->name, i*5);
 	}
 
+	/* restore CFG */
+	cfg |= readl(dev->base_addr + ChipConfig) & ~CFG_RESET_SAVE;
+	writel(cfg, dev->base_addr + ChipConfig);
+	/* restore WCSR */
+	wcsr |= readl(dev->base_addr + WOLCmd) & ~WCSR_RESET_SAVE;
+	writel(wcsr, dev->base_addr + WOLCmd);
+	/* read RFCR */
+	rfcr |= readl(dev->base_addr + RxFilterAddr) & ~RFCR_RESET_SAVE;
+	/* restore PMATCH */ 
+	for (i = 0; i < 3; i++) {
+		writel(i*2, dev->base_addr + RxFilterAddr);
+		writew(pmatch[i], dev->base_addr + RxFilterData);
+	}
+	for (i = 0; i < 3; i++) {
+		writel(0xa+(i*2), dev->base_addr + RxFilterAddr);
+		writew(sopass[i], dev->base_addr + RxFilterData);
+	}
+	/* restore RFCR */
+	writel(rfcr, dev->base_addr + RxFilterAddr);
+	
+}
+
+static void natsemi_reload_eeprom(struct net_device *dev)
+{
+	int i;
+
 	writel(EepromReload, dev->base_addr + PCIBusCfg);
 	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
 		if (!(readl(dev->base_addr + PCIBusCfg) & EepromReload))
@@ -788,9 +936,9 @@
 
 	/* Set the timer to check for link beat. */
 	init_timer(&np->timer);
-	np->timer.expires = jiffies + 3*HZ;
+	np->timer.expires = jiffies + NATSEMI_TIMER_FREQ;
 	np->timer.data = (unsigned long)dev;
-	np->timer.function = &netdev_timer;				/* timer handler */
+	np->timer.function = &netdev_timer; /* timer handler */
 	add_timer(&np->timer);
 
 	return 0;
@@ -803,7 +951,7 @@
 	int duplex;
 	int chipcfg = readl(ioaddr + ChipConfig);
 
-	if(!(chipcfg & 0x80000000)) {
+	if(!(chipcfg & CfgLink)) {
 		if (netif_carrier_ok(dev)) {
 			if (debug)
 				printk(KERN_INFO "%s: no link. Disabling watchdog.\n",
@@ -819,20 +967,20 @@
 		netif_carrier_on(dev);
 	}
 
-	duplex = np->full_duplex || (chipcfg & 0x20000000 ? 1 : 0);
+	duplex = np->full_duplex || (chipcfg & CfgFullDuplex ? 1 : 0);
 
 	/* if duplex is set then bit 28 must be set, too */
-	if (duplex ^ !!(np->rx_config & 0x10000000)) {
+	if (duplex ^ !!(np->rx_config & RxAcceptTx)) {
 		if (debug)
 			printk(KERN_INFO "%s: Setting %s-duplex based on negotiated link"
 				   " capability.\n", dev->name,
 				   duplex ? "full" : "half");
 		if (duplex) {
-			np->rx_config |= 0x10000000;
-			np->tx_config |= 0xC0000000;
+			np->rx_config |= RxAcceptTx;
+			np->tx_config |= TxCarrierIgn | TxHeartIgn;
 		} else {
-			np->rx_config &= ~0x10000000;
-			np->tx_config &= ~0xC0000000;
+			np->rx_config &= ~RxAcceptTx;
+			np->tx_config &= ~(TxCarrierIgn | TxHeartIgn);
 		}
 		writel(np->tx_config, ioaddr + TxConfig);
 		writel(np->rx_config, ioaddr + RxConfig);
@@ -845,9 +993,21 @@
 	long ioaddr = dev->base_addr;
 	int i;
 
+	/* save the silicon revision for later */
 	if (debug > 4)
 		printk(KERN_DEBUG "%s: found silicon revision %xh.\n",
-				dev->name, readl(ioaddr + SiliconRev));
+				dev->name, np->srr);
+
+	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
+		if (readl(dev->base_addr + ChipConfig) & CfgAnegDone)
+			break;
+		udelay(10);
+	}
+	if (i==NATSEMI_HW_TIMEOUT && debug) {
+		printk(KERN_INFO 
+			"%s: autonegotiation did not complete in %d usec.\n",
+			dev->name, i*10);
+	}
 
 	/* On page 78 of the spec, they recommend some settings for "optimum
 	   performance" to be done in sequence.  These settings optimize some
@@ -856,26 +1016,26 @@
 	   Kennedy) recommends always setting them.  If you don't, you get 
 	   errors on some autonegotiations that make the device unusable.
 	*/
-	writew(0x0001, ioaddr + PGSEL);
-	writew(0x189C, ioaddr + PMDCSR);
-	writew(0x0000, ioaddr + TSTDAT);
-	writew(0x5040, ioaddr + DSPCFG);
-	writew(0x008C, ioaddr + SDCFG);
-	writew(0x0000, ioaddr + PGSEL);
+	writew(1, ioaddr + PGSEL);
+	writew(PMDCSR_VAL, ioaddr + PMDCSR);
+	writew(TSTDAT_VAL, ioaddr + TSTDAT);
+	writew(DSPCFG_VAL, ioaddr + DSPCFG);
+	writew(SDCFG_VAL, ioaddr + SDCFG);
+	writew(0, ioaddr + PGSEL);
 
 	/* Enable PHY Specific event based interrupts.  Link state change
 	   and Auto-Negotiation Completion are among the affected.
+	   Read the intr status to clear it (needed for wake events).
 	*/
-	writew(0x0002, ioaddr + MIntrCtrl);
+	readw(ioaddr + MIntrStatus);
+	writew(MICRIntEn, ioaddr + MIntrCtrl);
 
-	writel(np->ring_dma, ioaddr + RxRingPtr);
-	writel(np->ring_dma + RX_RING_SIZE * sizeof(struct netdev_desc), ioaddr + TxRingPtr);
+	/* clear any interrupts that are pending, such as wake events */
+	readl(ioaddr + IntrStatus);
 
-	for (i = 0; i < ETH_ALEN; i += 2) {
-		writel(i, ioaddr + RxFilterAddr);
-		writew(dev->dev_addr[i] + (dev->dev_addr[i+1] << 8),
-			   ioaddr + RxFilterData);
-	}
+	writel(np->ring_dma, ioaddr + RxRingPtr);
+	writel(np->ring_dma + RX_RING_SIZE * sizeof(struct netdev_desc), 
+		ioaddr + TxRingPtr);
 
 	/* Initialize other registers.
 	 * Configure the PCI bus bursts and FIFO thresholds.
@@ -891,12 +1051,13 @@
 	 * ECRETRY=1
 	 * ATP=1
 	 */
-	np->tx_config = 0x10f01002;
+	np->tx_config = TxAutoPad | TxCollRetry | TxMxdma_256 | (0x1002);
+	writel(np->tx_config, ioaddr + TxConfig);
+
 	/* DRTH 0x10: start copying to memory if 128 bytes are in the fifo
 	 * MXDMA 0: up to 256 byte bursts
 	 */
-	np->rx_config = 0x700020;
-	writel(np->tx_config, ioaddr + TxConfig);
+	np->rx_config = RxMxdma_256 | 0x20;
 	writel(np->rx_config, ioaddr + RxConfig);
 
 	/* Disable PME:
@@ -906,24 +1067,37 @@
 	 * With PME set the chip will scan incoming packets but
 	 * nothing will be written to memory. */
 	np->SavedClkRun = readl(ioaddr + ClkRun);
-	writel(np->SavedClkRun & ~0x100, ioaddr + ClkRun);
+	writel(np->SavedClkRun & ~PMEEnable, ioaddr + ClkRun);
+	if (np->SavedClkRun & PMEStatus) {
+		printk(KERN_NOTICE "%s: Wake-up event %8.8x\n", 
+			dev->name, readl(ioaddr + WOLCmd));
+	}
 
 	check_link(dev);
 	__set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
- 	writel(DEFAULT_INTR, ioaddr + IntrMask);
+	writel(DEFAULT_INTR, ioaddr + IntrMask);
 	writel(1, ioaddr + IntrEnable);
 
 	writel(RxOn | TxOn, ioaddr + ChipCmd);
-	writel(4, ioaddr + StatsCtrl); /* Clear Stats */
+	writel(StatsClear, ioaddr + StatsCtrl); /* Clear Stats */
 }
 
+/* 
+ * The frequency on this has been increased because of a nasty little problem.
+ * It seems that a reference set for this chip went out with incorrect info,
+ * and there exist boards that aren't quite right.  An unexpected voltage drop
+ * can cause the PHY to get itself in a weird state (basically reset..).
+ * NOTE: this only seems to affect revC chips.
+ */
 static void netdev_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = dev->priv;
-	int next_tick = 60*HZ;
+	int next_tick = 5*HZ;
+	long ioaddr = dev->base_addr;
+	u16 dspcfg;
 
 	if (debug > 3) {
 		/* DO NOT read the IntrStatus register, 
@@ -933,10 +1107,27 @@
 			   dev->name);
 	}
 	spin_lock_irq(&np->lock);
-	check_link(dev);
+
+	/* check for a nasty random phy-reset - use dspcfg as a flag */
+	writew(1, ioaddr+PGSEL);
+	dspcfg = readw(ioaddr+DSPCFG);
+	writew(0, ioaddr+PGSEL);
+	if (dspcfg != DSPCFG_VAL) {
+		if (!netif_queue_stopped(dev)) {
+			printk(KERN_INFO 
+				"%s: possible phy reset: re-initializing\n",
+				dev->name);
+			init_registers(dev);
+		} else {
+			/* hurry back */
+			next_tick = HZ;
+		}
+	} else {
+		/* init_registers() calls check_link() for the above case */
+		check_link(dev);
+	}
 	spin_unlock_irq(&np->lock);
-	np->timer.expires = jiffies + next_tick;
-	add_timer(&np->timer);
+	mod_timer(&np->timer, jiffies + next_tick);
 }
 
 static void dump_ring(struct net_device *dev)
@@ -946,15 +1137,18 @@
 	if (debug > 2) {
 		int i;
 		printk(KERN_DEBUG "  Tx ring at %p:\n", np->tx_ring);
-		for (i = 0; i < TX_RING_SIZE; i++)
+		for (i = 0; i < TX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x %8.8x.\n",
 				   i, np->tx_ring[i].next_desc,
-				   np->tx_ring[i].cmd_status, np->tx_ring[i].addr);
+				   np->tx_ring[i].cmd_status, 
+				   np->tx_ring[i].addr);
+		}
 		printk(KERN_DEBUG "  Rx ring %p:\n", np->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x %8.8x.\n",
 				   i, np->rx_ring[i].next_desc,
-				   np->rx_ring[i].cmd_status, np->rx_ring[i].addr);
+				   np->rx_ring[i].cmd_status, 
+				   np->rx_ring[i].addr);
 		}
 	}
 }
@@ -964,12 +1158,12 @@
 	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
-
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
 	if (netif_device_present(dev)) {
 		printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
-			   " resetting...\n", dev->name, readl(ioaddr + IntrStatus));
+			" resetting...\n", 
+			dev->name, readl(ioaddr + IntrStatus));
 		dump_ring(dev);
 
 		natsemi_reset(dev);
@@ -977,8 +1171,9 @@
 		init_ring(dev);
 		init_registers(dev);
 	} else {
-		printk(KERN_WARNING "%s: tx_timeout while in suspended state?\n",
-		   		dev->name);
+		printk(KERN_WARNING 
+			"%s: tx_timeout while in suspended state?\n",
+		   	dev->name);
 	}
 	spin_unlock_irq(&np->lock);
 	enable_irq(dev->irq);
@@ -1019,7 +1214,7 @@
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		np->rx_ring[i].next_desc = cpu_to_le32(np->ring_dma
 				+sizeof(struct netdev_desc)
-				 *((i+1)%RX_RING_SIZE));
+				*((i+1)%RX_RING_SIZE));
 		np->rx_ring[i].cmd_status = cpu_to_le32(DescOwn);
 		np->rx_skbuff[i] = NULL;
 	}
@@ -1107,7 +1302,8 @@
 	
 	if (netif_device_present(dev)) {
 		np->tx_ring[entry].cmd_status = cpu_to_le32(DescOwn | skb->len);
-		/* StrongARM: Explicitly cache flush np->tx_ring and skb->data,skb->len. */
+		/* StrongARM: Explicitly cache flush np->tx_ring and 
+		 * skb->data,skb->len. */
 		wmb();
 		np->cur_tx++;
 		if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
@@ -1148,15 +1344,19 @@
 			printk(KERN_DEBUG "%s: tx frame #%d finished with status %8.8xh.\n",
 					dev->name, np->dirty_tx,
 					le32_to_cpu(np->tx_ring[entry].cmd_status));
-		if (np->tx_ring[entry].cmd_status & cpu_to_le32(0x08000000)) {
+		if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescPktOK)) {
 			np->stats.tx_packets++;
 			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
-		} else {			/* Various Tx errors */
+		} else { /* Various Tx errors */
 			int tx_status = le32_to_cpu(np->tx_ring[entry].cmd_status);
-			if (tx_status & 0x04010000) np->stats.tx_aborted_errors++;
-			if (tx_status & 0x02000000) np->stats.tx_fifo_errors++;
-			if (tx_status & 0x01000000) np->stats.tx_carrier_errors++;
-			if (tx_status & 0x00200000) np->stats.tx_window_errors++;
+			if (tx_status & (DescTxAbort|DescTxExcColl)) 
+				np->stats.tx_aborted_errors++;
+			if (tx_status & DescTxFIFO) 
+				np->stats.tx_fifo_errors++;
+			if (tx_status & DescTxCarrier) 
+				np->stats.tx_carrier_errors++;
+			if (tx_status & DescTxOOWCol) 
+				np->stats.tx_window_errors++;
 			np->stats.tx_errors++;
 		}
 		pci_unmap_single(np->pci_dev,np->tx_dma[entry],
@@ -1219,7 +1419,7 @@
 		}
 	} while (1);
 
-	if (debug > 3)
+	if (debug > 4)
 		printk(KERN_DEBUG "%s: exiting interrupt.\n",
 			   dev->name);
 }
@@ -1240,7 +1440,7 @@
 				   entry, desc_status);
 		if (--boguscnt < 0)
 			break;
-		if ((desc_status & (DescMore|DescPktOK|RxTooLong)) != DescPktOK) {
+		if ((desc_status & (DescMore|DescPktOK|DescRxLong)) != DescPktOK) {
 			if (desc_status & DescMore) {
 				printk(KERN_WARNING "%s: Oversized(?) Ethernet frame spanned "
 					   "multiple buffers, entry %#x status %x.\n",
@@ -1252,14 +1452,19 @@
 					printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n",
 						   desc_status);
 				np->stats.rx_errors++;
-				if (desc_status & 0x06000000) np->stats.rx_over_errors++;
-				if (desc_status & 0x00600000) np->stats.rx_length_errors++;
-				if (desc_status & 0x00140000) np->stats.rx_frame_errors++;
-				if (desc_status & 0x00080000) np->stats.rx_crc_errors++;
+				if (desc_status & (DescRxAbort|DescRxOver)) 
+					np->stats.rx_over_errors++;
+				if (desc_status & (DescRxLong|DescRxRunt)) 
+					np->stats.rx_length_errors++;
+				if (desc_status & (DescRxInvalid|DescRxAlign)) 
+					np->stats.rx_frame_errors++;
+				if (desc_status & DescRxCRC) 
+					np->stats.rx_crc_errors++;
 			}
 		} else {
 			struct sk_buff *skb;
-			int pkt_len = (desc_status & 0x0fff) - 4; 	/* Omit CRC size. */
+			/* Omit CRC size. */
+			int pkt_len = (desc_status & DescSizeMask) - 4;
 			/* Check if the packet is long enough to accept without copying
 			   to a minimally-sized skbuff. */
 			if (pkt_len < rx_copybreak
@@ -1324,10 +1529,11 @@
 
 	spin_lock(&np->lock);
 	if (intr_status & LinkChange) {
-		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
-			   " %4.4x  partner %4.4x.\n", dev->name,
-			   (int)readl(ioaddr + AnegAdv), 
-			   (int)readl(ioaddr + AnegPeer));
+		printk(KERN_NOTICE 
+			"%s: Link changed: Autonegotiation advertising"
+			" %4.4x  partner %4.4x.\n", dev->name,
+			(int)mdio_read(dev, 1, MII_ADVERTISE), 
+			(int)mdio_read(dev, 1, MII_LPA));
 		/* read MII int status to clear the flag */
 		readw(ioaddr + MIntrStatus);
 		check_link(dev);
@@ -1336,7 +1542,7 @@
 		__get_stats(dev);
 	}
 	if (intr_status & IntrTxUnderrun) {
-		if ((np->tx_config & 0x3f) < 62)
+		if ((np->tx_config & TxDrthMask) < 62)
 			np->tx_config += 2;
 		if (debug > 2)
 			printk(KERN_NOTICE "%s: increasing Tx theshold, new tx cfg %8.8xh.\n",
@@ -1348,12 +1554,15 @@
 		printk(KERN_NOTICE "%s: Link wake-up event %8.8x\n",
 			   dev->name, wol_status);
 	}
-	if ((intr_status & ~(LinkChange|StatsMax|RxResetDone|TxResetDone|0xA7ff))
-		&& debug)
-		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
-			   dev->name, intr_status);
+	if (intr_status & RxStatusFIFOOver && debug) {
+		printk(KERN_NOTICE "%s: Rx status FIFO overrun\n", dev->name);
+	}
 	/* Hmmmmm, it's not clear how to recover from PCI faults. */
 	if (intr_status & IntrPCIErr) {
+		if (debug) {
+			printk(KERN_NOTICE "%s: PCI error %08x\n", dev->name,
+				intr_status & IntrPCIErr);
+		}
 		np->stats.tx_fifo_errors++;
 		np->stats.rx_fifo_errors++;
 	}
@@ -1453,11 +1662,12 @@
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
 		/* Unconditionally log net taps. */
 		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
-		rx_mode = AcceptBroadcast | AcceptAllMulticast | AcceptAllPhys
-			| AcceptMyPhys;
+		rx_mode = RxFilterEnable | AcceptBroadcast 
+			| AcceptAllMulticast | AcceptAllPhys | AcceptMyPhys;
 	} else if ((dev->mc_count > multicast_filter_limit)
 			   ||  (dev->flags & IFF_ALLMULTI)) {
-		rx_mode = AcceptBroadcast | AcceptAllMulticast | AcceptMyPhys;
+		rx_mode = RxFilterEnable | AcceptBroadcast 
+			| AcceptAllMulticast | AcceptMyPhys;
 	} else {
 		struct dev_mc_list *mclist;
 		int i;
@@ -1467,10 +1677,12 @@
 			set_bit_le(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x1ff,
 					mc_filter);
 		}
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
+		rx_mode = RxFilterEnable | AcceptBroadcast 
+			| AcceptMulticast | AcceptMyPhys;
 		for (i = 0; i < 64; i += 2) {
 			writew(HASH_TABLE + i, ioaddr + RxFilterAddr);
-			writew((mc_filter[i+1]<<8) + mc_filter[i], ioaddr + RxFilterData);
+			writew((mc_filter[i+1]<<8) + mc_filter[i], 
+				ioaddr + RxFilterData);
 		}
 	}
 	writel(rx_mode, ioaddr + RxFilterAddr);
@@ -1550,6 +1762,7 @@
 
 static int netdev_set_wol(struct net_device *dev, u32 newval)
 {
+	struct netdev_private *np = dev->priv;
 	u32 data = readl(dev->base_addr + WOLCmd) & ~WakeOptsSummary;
 
 	/* translate to bitmasks this chip understands */
@@ -1565,49 +1778,65 @@
 		data |= WakeArp;
 	if (newval & WAKE_MAGIC)
 		data |= WakeMagic;
-	if (newval & WAKE_MAGICSECURE)
-		data |= WakeMagicSecure;
+	if (np->srr >= SRR_REV_D) {
+		if (newval & WAKE_MAGICSECURE) {
+			data |= WakeMagicSecure;
+		}
+	}
 
 	writel(data, dev->base_addr + WOLCmd);
 
-	/* should we burn these into the EEPROM? */
-	
 	return 0;
 }
 
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur)
 {
+	struct netdev_private *np = dev->priv;
 	u32 regval = readl(dev->base_addr + WOLCmd);
 
 	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST 
-			| WAKE_ARP | WAKE_MAGIC | WAKE_MAGICSECURE);
+			| WAKE_ARP | WAKE_MAGIC);
+	
+	if (np->srr >= SRR_REV_D) {
+		/* SOPASS works on revD and higher */
+		*supported |= WAKE_MAGICSECURE;
+	}
 	*cur = 0;
+
 	/* translate from chip bitmasks */
-	if (regval & 0x1)
+	if (regval & WakePhy)
 		*cur |= WAKE_PHY;
-	if (regval & 0x2)
+	if (regval & WakeUnicast)
 		*cur |= WAKE_UCAST;
-	if (regval & 0x4)
+	if (regval & WakeMulticast)
 		*cur |= WAKE_MCAST;
-	if (regval & 0x8)
+	if (regval & WakeBroadcast)
 		*cur |= WAKE_BCAST;
-	if (regval & 0x10)
+	if (regval & WakeArp)
 		*cur |= WAKE_ARP;
-	if (regval & 0x200)
+	if (regval & WakeMagic)
 		*cur |= WAKE_MAGIC;
-	if (regval & 0x400)
+	if (regval & WakeMagicSecure) {
+		/* this can be on in revC, but it's broken */
 		*cur |= WAKE_MAGICSECURE;
+	}
 
 	return 0;
 }
 
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
+	struct netdev_private *np = dev->priv;
 	u16 *sval = (u16 *)newval;
-	u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+	u32 addr;
+	
+	if (np->srr < SRR_REV_D) {
+		return 0;
+	}
 
 	/* enable writing to these registers by disabling the RX filter */
-	addr &= ~0x80000000;
+	addr = readl(dev->base_addr + RxFilterAddr) & ~RFCRAddressMask;
+	addr &= ~RxFilterEnable;
 	writel(addr, dev->base_addr + RxFilterAddr);
 
 	/* write the three words to (undocumented) RFCR vals 0xa, 0xc, 0xe */
@@ -1621,19 +1850,25 @@
 	writew(sval[2], dev->base_addr + RxFilterData);
 	
 	/* re-enable the RX filter */
-	writel(addr | 0x80000000, dev->base_addr + RxFilterAddr);
-
-	/* should we burn this into the EEPROM? */
+	writel(addr | RxFilterEnable, dev->base_addr + RxFilterAddr);
 
 	return 0;
 }
 
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
+	struct netdev_private *np = dev->priv;
 	u16 *sval = (u16 *)data;
-	u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+	u32 addr;
+
+	if (np->srr < SRR_REV_D) {
+		sval[0] = sval[1] = sval[2] = 0;
+		return 0;
+	}
 
 	/* read the three words from (undocumented) RFCR vals 0xa, 0xc, 0xe */
+	addr = readl(dev->base_addr + RxFilterAddr) & ~RFCRAddressMask;
+
 	writel(addr | 0xa, dev->base_addr + RxFilterAddr);
 	sval[0] = readw(dev->base_addr + RxFilterData);
 
@@ -1643,6 +1878,8 @@
 	writel(addr | 0xe, dev->base_addr + RxFilterAddr);
 	sval[2] = readw(dev->base_addr + RxFilterData);
 	
+	writel(addr, dev->base_addr + RxFilterAddr);
+
 	return 0;
 }
 
@@ -1662,17 +1899,17 @@
 	ecmd->transceiver = XCVR_INTERNAL;
 
 	/* this isn't fully supported at higher layers */
-	ecmd->phy_address = readw(dev->base_addr + PhyCtrl) & 0xf;
+	ecmd->phy_address = readw(dev->base_addr + PhyCtrl) & PhyAddrMask;
 
-	tmp = readl(dev->base_addr + AnegAdv);
 	ecmd->advertising = ADVERTISED_TP;
-	if (tmp & Aneg10BaseT)
+	tmp = mdio_read(dev, 1, MII_ADVERTISE);
+	if (tmp & ADVERTISE_10HALF)
 		ecmd->advertising |= ADVERTISED_10baseT_Half;
-	if (tmp & Aneg10BaseTFull)
+	if (tmp & ADVERTISE_10FULL)
 		ecmd->advertising |= ADVERTISED_10baseT_Full;
-	if (tmp & Aneg100BaseT)
+	if (tmp & ADVERTISE_100HALF)
 		ecmd->advertising |= ADVERTISED_100baseT_Half;
-	if (tmp & Aneg100BaseTFull)
+	if (tmp & ADVERTISE_100FULL)
 		ecmd->advertising |= ADVERTISED_100baseT_Full;
 
 	tmp = readl(dev->base_addr + ChipConfig);
@@ -1734,30 +1971,29 @@
 		}
 		writel(tmp, dev->base_addr + ChipConfig);
 		/* turn on autonegotiation, and force a renegotiate */
-		tmp = readl(dev->base_addr + BasicControl);
-		tmp |= BMCRAnegEnable | BMCRAnegRestart;
-		writel(tmp, dev->base_addr + BasicControl);
-		np->advertising = mdio_read(dev, 1, 4);
+		tmp = mdio_read(dev, 1, MII_BMCR);
+		tmp |= (BMCR_ANENABLE | BMCR_ANRESTART);
+		mdio_write(dev, 1, MII_BMCR, tmp);
+		np->advertising = mdio_read(dev, 1, MII_ADVERTISE);
 	} else {
 		/* turn off auto negotiation, set speed and duplexity */
-		tmp = readl(dev->base_addr + BasicControl);
-		tmp &= ~(BMCRAnegEnable | BMCRSpeed | BMCRDuplex);
+		tmp = mdio_read(dev, 1, MII_BMCR);
+		tmp &= ~(BMCR_ANENABLE | BMCR_SPEED100 | BMCR_FULLDPLX);
 		if (ecmd->speed == SPEED_100) {
-			tmp |= BMCRSpeed;
+			tmp |= BMCR_SPEED100;
 		}
 		if (ecmd->duplex == DUPLEX_FULL) {
-			tmp |= BMCRDuplex;
+			tmp |= BMCR_FULLDPLX;
 		} else {
 			np->full_duplex = 0;
 		}
-		writel(tmp, dev->base_addr + BasicControl);
+		mdio_write(dev, 1, MII_BMCR, tmp);
 	}
 	return 0;
 }
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct netdev_private *np = dev->priv;
 	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
 
 	switch(cmd) {
@@ -1770,22 +2006,16 @@
 
 	case SIOCGMIIREG:		/* Read MII PHY register. */
 	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
-		data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
+		data->val_out = mdio_read(dev, data->phy_id & 0x1f, 
+			data->reg_num & 0x1f);
 		return 0;
 
 	case SIOCSMIIREG:		/* Write MII PHY register. */
 	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
-		if (data->phy_id == 1) {
-			u16 miireg = data->reg_num & 0x1f;
-			u16 value = data->val_in;
-			writew(value, dev->base_addr + BasicControl 
-					+ (miireg << 2));
-			switch (miireg) {
-			case 4: np->advertising = value; break;
-			}
-		}
+		mdio_write(dev, data->phy_id & 0x1f, data->reg_num & 0x1f, 
+			data->val_in);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -1795,16 +2025,24 @@
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
 	long ioaddr = dev->base_addr;
+	struct netdev_private *np = dev->priv;
 
 	if (debug > 1)
 		printk(KERN_INFO "%s: remaining active for wake-on-lan\n", 
 			dev->name);
+
 	/* For WOL we must restart the rx process in silent mode.
 	 * Write NULL to the RxRingPtr. Only possible if
 	 * rx process is stopped
 	 */
 	writel(0, ioaddr + RxRingPtr);
 
+	/* read WoL status to clear */
+	readl(ioaddr + WOLCmd);
+
+	/* PME on, clear status */
+	writel(np->SavedClkRun | PMEEnable | PMEStatus, ioaddr + ClkRun);
+
 	/* and restart the rx process */
 	writel(RxOn, ioaddr + ChipCmd);
 
@@ -1822,9 +2060,10 @@
 	struct netdev_private *np = dev->priv;
 
 	netif_stop_queue(dev);
+	netif_carrier_off(dev);
 
 	if (debug > 1) {
- 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
+		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
 			   dev->name, (int)readl(ioaddr + ChipCmd));
 		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
@@ -1835,9 +2074,13 @@
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
 
+	/* Disable and clear interrupts */
 	writel(0, ioaddr + IntrEnable);
-	writel(0, ioaddr + IntrMask);
-	writel(2, ioaddr + StatsCtrl); 	/* Freeze Stats */
+	readl(ioaddr + IntrMask);
+	readw(ioaddr + MIntrStatus);
+
+ 	/* Freeze Stats */
+	writel(StatsFreeze, ioaddr + StatsCtrl);
 	    
 	/* Stop the chip's Tx and Rx processes. */
 	natsemi_stop_rxtx(dev);
@@ -1865,20 +2108,15 @@
 
 	 {
 		u32 wol = readl(ioaddr + WOLCmd) & WakeOptsSummary;
-		u32 clkrun = np->SavedClkRun;
-		/* Restore PME enable bit */
 		if (wol) {
 			/* restart the NIC in WOL mode.
 			 * The nic must be stopped for this.
 			 */
 			enable_wol_mode(dev, 0);
-			/* make sure to enable PME */
-			clkrun |= 0x100;
+		} else {
+			/* Restore PME enable bit unmolested */
+			writel(np->SavedClkRun, ioaddr + ClkRun);
 		}
-		writel(clkrun, ioaddr + ClkRun);
-#if 0
-		writel(0x0200, ioaddr + ChipConfig); /* Power down Xcvr. */
-#endif
 	}
 	return 0;
 }
@@ -1913,8 +2151,8 @@
  *	* intr_handler: doesn't acquire the spinlock. suspend calls
  *		disable_irq() to enforce synchronization.
  *
- * netif_device_detach must occur under spin_unlock_irq(), interrupts from a detached
- * device would cause an irq storm.
+ * netif_device_detach must occur under spin_unlock_irq(), interrupts from a
+ * detached device would cause an irq storm.
  */
 
 static int natsemi_suspend (struct pci_dev *pdev, u32 state)
@@ -1945,7 +2183,6 @@
 		drain_ring(dev);
 		{
 			u32 wol = readl(ioaddr + WOLCmd) & WakeOptsSummary;
-			u32 clkrun = np->SavedClkRun;
 			/* Restore PME enable bit */
 			if (wol) {
 				/* restart the NIC in WOL mode.
@@ -1953,10 +2190,10 @@
 				 * FIXME: use the WOL interupt 
 				 */
 				enable_wol_mode(dev, 0);
-				/* make sure to enable PME */
-				clkrun |= 0x100;
+			} else {
+				/* Restore PME enable bit unmolested */
+				writel(np->SavedClkRun, ioaddr + ClkRun);
 			}
-			writel(clkrun, ioaddr + ClkRun);
 		}
 	} else {
 		netif_device_detach(dev);
@@ -1985,8 +2222,7 @@
 		netif_device_attach(dev);
 		spin_unlock_irq(&np->lock);
 
-		np->timer.expires = jiffies + 1*HZ;
-		add_timer(&np->timer);
+		mod_timer(&np->timer, jiffies + 1*HZ);
 	} else {
 		netif_device_attach(dev);
 	}

--------------B140C38C5B1CF59C0113CCD5--

