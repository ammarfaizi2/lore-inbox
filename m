Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSFQO6u>; Mon, 17 Jun 2002 10:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSFQO6t>; Mon, 17 Jun 2002 10:58:49 -0400
Received: from host213-121-105-182.in-addr.btopenworld.com ([213.121.105.182]:20727
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S314278AbSFQO6d>; Mon, 17 Jun 2002 10:58:33 -0400
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
From: Matthew Hall <matt@ecsc.co.uk>
To: Marcus Sundberg <marcus@ingate.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <vevg8l25uq.fsf@inigo.ingate.se>
References: <1023799395.3064.49.camel@smelly.dark.lan>
	 <vesn3q2mkv.fsf@inigo.ingate.se> <1024070521.973.48.camel@smelly.dark.lan>
	  <vevg8l25uq.fsf@inigo.ingate.se>
Content-Type: multipart/mixed; boundary="=-OBdnq9Vv5K7aZxOPeYj1"
Organization: ECSC Ltd.
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 17 Jun 2002 15:58:26 +0100
Message-Id: <1024325906.12404.10.camel@smelly.dark.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OBdnq9Vv5K7aZxOPeYj1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcus, 
	Thanks for your help, I managed to fix some of the compilation errors
this one brought up with my limited c/kernel code knowledge and as far
as I can see, this (attached) version seems a little more stable
(crosses fingers). Hope you can put it to good use.
Cheers,
Matthew Hall

On Fri, 2002-06-14 at 17:16, Marcus Sundberg wrote:
> Matthew Hall <matt@ecsc.co.uk> writes:
> 
> > Hi,
> >  I don't suppose you could do me a favour? If at all possible, could you
> > send me the sundance.c, kern_compat.h and pci-scan.h files you used to
> > get this card working? I'm at my wits end and my boss needs this working
> > :)
> 
> Hi!
> 
> Well, I got it working, but not really usable...
> See http://marc.theaimsgroup.com/?l=linux-kernel&m=102269899408145&w=2
> for the problems I'm seeing.
> 
> But here's the driver I've been testing in any case. I'm not using
> Donald Becker's driver so you don't need a kern_compat.h or pci-scan.h.
> 
> //Marcus
> 
> 
> ______________________________________________________________________
> 
> -- 
> ---------------------------------------+--------------------------
>   Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
>  Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
-- 
Matthew Hall -- matt@ecsc.co.uk -- http://people.ecsc.co.uk/~matt/
Sig: When I was a boy I was told that anybody could become President. Now I'm
beginning to believe it. - Clarence Darrow 

--=-OBdnq9Vv5K7aZxOPeYj1
Content-Disposition: attachment; filename=sundance.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=sundance.c; charset=ISO-8859-1

#define USE_IO_OPS	1
/* sundance.c: A Linux device driver for the Sundance ST201 "Alta". */
/*
	Written 1999-2000 by Donald Becker.

	This software may be used and distributed according to the terms of
	the GNU General Public License (GPL), incorporated herein by reference.
	Drivers based on or derived from this code fall under the GPL and must
	retain the authorship, copyright and license notice.  This file is not
	a complete program and may only be used when the entire operating
	system is licensed under the GPL.

	The author may be reached as becker@scyld.com, or C/O
	Scyld Computing Corporation
	410 Severn Ave., Suite 210
	Annapolis MD 21403

	Support and updates available at
	http://www.scyld.com/network/sundance.html


	Version 1.01a (jgarzik):
	- Replace some MII-related magic numbers with constants

	Version 1.02 (D-Link):
	- Add new board to PCI ID list
	- Fix multicast bug

*/

#define DRV_NAME	"sundance"
#define DRV_VERSION	"1.02"
#define DRV_RELDATE	"17-Jan-2002"


/* The user-configurable values.
   These may be modified when a driver module is loaded.*/
static int debug =3D 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
static int max_interrupt_work =3D 30;
static int mtu;
/* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
   Typical is a 64 element hash table based on the Ethernet CRC.  */
static int multicast_filter_limit =3D 32;

/* Set the copy breakpoint for the copy-only-tiny-frames scheme.
   Setting to > 1518 effectively disables this feature.
   This chip can receive into offset buffers, so the Alpha does not
   need a copy-align. */
static int rx_copybreak;

/* media[] specifies the media type the NIC operates at.
		 autosense	Autosensing active media.
		 10mbps_hd 	10Mbps half duplex.
		 10mbps_fd 	10Mbps full duplex.
		 100mbps_hd 	100Mbps half duplex.
		 100mbps_fd 	100Mbps full duplex.
		 0		Autosensing active media.
		 1	 	10Mbps half duplex.
		 2	 	10Mbps full duplex.
		 3	 	100Mbps half duplex.
		 4	 	100Mbps full duplex.
*/
#define MAX_UNITS 8=09
static char *media[MAX_UNITS];
/* Operational parameters that are set at compile time. */

/* Keep the ring sizes a power of two for compile efficiency.
   The compiler will convert <unsigned>'%'<2^N> into a bit mask.
   Making the Tx ring too large decreases the effectiveness of channel
   bonding and packet priority, and more than 128 requires modifying the
   Tx error recovery.
   Large receive rings merely waste memory. */
#define TX_RING_SIZE	16
#define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */
#define RX_RING_SIZE	32
#define TX_TOTAL_SIZE	TX_RING_SIZE*sizeof(struct netdev_desc)
#define RX_TOTAL_SIZE	RX_RING_SIZE*sizeof(struct netdev_desc)

/* Operational parameters that usually are not changed. */
/* Time in jiffies before concluding the transmitter is hung. */
#define TX_TIMEOUT  (4*HZ)

#define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/

#ifndef __KERNEL__
#define __KERNEL__
#endif
#if !defined(__OPTIMIZE__)
#warning  You must compile this file with the correct options!
#warning  See the last lines of the source file.
#error You must compile this driver with "-O".
#endif

/* Include files, designed to support most kernel versions 2.0.0 and later.=
 */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/timer.h>
#include <linux/errno.h>
#include <linux/ioport.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
#include <linux/pci.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/skbuff.h>
#include <linux/init.h>
#include <linux/ethtool.h>
#include <linux/mii.h>
#include <linux/crc32.h>
#include <asm/uaccess.h>
#include <asm/processor.h>		/* Processor type for cache alignment. */
#include <asm/bitops.h>
#include <asm/io.h>
#include <linux/delay.h>
#include <linux/spinlock.h>

#ifndef __devexit_p
#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x
#else
#define __devexit_p(x) NULL
#endif
#endif


/* These identify the driver base version and may not be removed. */
static char version[] __devinitdata =3D
KERN_INFO DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE "  Written by Donald =
Becker\n"
KERN_INFO "  http://www.scyld.com/network/sundance.html\n";

MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
MODULE_DESCRIPTION("Sundance Alta Ethernet driver");
#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

MODULE_PARM(max_interrupt_work, "i");
MODULE_PARM(mtu, "i");
MODULE_PARM(debug, "i");
MODULE_PARM(rx_copybreak, "i");
MODULE_PARM(media, "1-" __MODULE_STRING(MAX_UNITS) "s");
MODULE_PARM_DESC(max_interrupt_work, "Sundance Alta maximum events handled =
per interrupt");
MODULE_PARM_DESC(mtu, "Sundance Alta MTU (all boards)");
MODULE_PARM_DESC(debug, "Sundance Alta debug level (0-5)");
MODULE_PARM_DESC(rx_copybreak, "Sundance Alta copy breakpoint for copy-only=
-tiny-frames");
/*
				Theory of Operation

I. Board Compatibility

This driver is designed for the Sundance Technologies "Alta" ST201 chip.

II. Board-specific settings

III. Driver operation

IIIa. Ring buffers

This driver uses two statically allocated fixed-size descriptor lists
formed into rings by a branch from the final descriptor to the beginning of
the list.  The ring sizes are set at compile time by RX/TX_RING_SIZE.
Some chips explicitly use only 2^N sized rings, while others use a
'next descriptor' pointer that the driver forms into rings.

IIIb/c. Transmit/Receive Structure

This driver uses a zero-copy receive and transmit scheme.
The driver allocates full frame size skbuffs for the Rx ring buffers at
open() time and passes the skb->data field to the chip as receive data
buffers.  When an incoming frame is less than RX_COPYBREAK bytes long,
a fresh skbuff is allocated and the frame is copied to the new skbuff.
When the incoming frame is larger, the skbuff is passed directly up the
protocol stack.  Buffers consumed this way are replaced by newly allocated
skbuffs in a later phase of receives.

The RX_COPYBREAK value is chosen to trade-off the memory wasted by
using a full-sized skbuff for small frames vs. the copying costs of larger
frames.  New boards are typically used in generously configured machines
and the underfilled buffers have negligible impact compared to the benefit =
of
a single allocation size, so the default value of zero results in never
copying packets.  When copying is done, the cost is usually mitigated by us=
ing
a combined copy/checksum routine.  Copying also preloads the cache, which i=
s
most useful with small frames.

A subtle aspect of the operation is that the IP header at offset 14 in an
ethernet frame isn't longword aligned for further processing.
Unaligned buffers are permitted by the Sundance hardware, so
frames are received into the skbuff at an offset of "+2", 16-byte aligning
the IP header.

IIId. Synchronization

The driver runs as two independent, single-threaded flows of control.  One
is the send-packet routine, which enforces single-threaded use by the
dev->tbusy flag.  The other thread is the interrupt handler, which is singl=
e
threaded by the hardware and interrupt handling software.

The send packet thread has partial control over the Tx ring and 'dev->tbusy=
'
flag.  It sets the tbusy flag whenever it's queuing a Tx packet. If the nex=
t
queue slot is empty, it clears the tbusy flag when finished otherwise it se=
ts
the 'lp->tx_full' flag.

The interrupt handler has exclusive control over the Rx ring and records st=
ats
from the Tx ring.  After reaping the stats, it marks the Tx queue entry as
empty by incrementing the dirty_tx mark. Iff the 'lp->tx_full' flag is set,=
 it
clears both the tx_full and tbusy flags.

IV. Notes

IVb. References

The Sundance ST201 datasheet, preliminary version.
http://cesdis.gsfc.nasa.gov/linux/misc/100mbps.html
http://cesdis.gsfc.nasa.gov/linux/misc/NWay.html

IVc. Errata

*/

=0C

enum pci_id_flags_bits {
        /* Set PCI command register bits before calling probe1(). */
        PCI_USES_IO=3D1, PCI_USES_MEM=3D2, PCI_USES_MASTER=3D4,
        /* Read and map the single following PCI BAR. */
        PCI_ADDR0=3D0<<4, PCI_ADDR1=3D1<<4, PCI_ADDR2=3D2<<4, PCI_ADDR3=3D3=
<<4,
        PCI_ADDR_64BITS=3D0x100, PCI_NO_ACPI_WAKE=3D0x200, PCI_NO_MIN_LATEN=
CY=3D0x400,
};
enum chip_capability_flags {CanHaveMII=3D1, };
#ifdef USE_IO_OPS
#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_IO  | PCI_ADDR0)
#else
#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR1)
#endif

static struct pci_device_id sundance_pci_tbl[] __devinitdata =3D {
	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},
	{0x1186, 0x1002, 0x1186, 0x1003, 0, 0, 1},
	{0x1186, 0x1002, 0x1186, 0x1012, 0, 0, 2},
	{0x1186, 0x1002, 0x1186, 0x1040, 0, 0, 3},
	{0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
	{0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
	{0,}
};
MODULE_DEVICE_TABLE(pci, sundance_pci_tbl);

struct pci_id_info {
        const char *name;
        struct match_info {
                int     pci, pci_mask, subsystem, subsystem_mask;
                int revision, revision_mask;                            /* =
Only 8 bits. */
        } id;
        enum pci_id_flags_bits pci_flags;
        int io_size;                            /* Needed for I/O region ch=
eck or ioremap(). */
        int drv_flags;                          /* Driver use, intended as =
capability flags. */
};


static struct pci_id_info pci_id_tbl[] =3D {
	{"D-Link DFE-550TX FAST Ethernet Adapter", {0x10021186, 0xffffffff,},
	 PCI_IOTYPE, 128, CanHaveMII},
	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter",
	 {0x10031186, 0xffffffff,},
	 PCI_IOTYPE, 128, CanHaveMII},
	{"D-Link DFE-580TX 4 port Server Adapter", {0x10121186, 0xffffffff,},
	 PCI_IOTYPE, 128, CanHaveMII},
	{"D-Link DFE-530TXS FAST Ethernet Adapter", {0x10021186, 0xffffffff,},
	 PCI_IOTYPE, 128, CanHaveMII},
	{"D-Link DL10050-based FAST Ethernet Adapter",
	 {0x10021186, 0xffffffff,},
	 PCI_IOTYPE, 128, CanHaveMII},
	{"Sundance Technology Alta", {0x020113F0, 0xffffffff,},
	 PCI_IOTYPE, 128, CanHaveMII},
	{0,},			/* 0 terminated list. */
};

/* This driver was written to use PCI memory space, however x86-oriented
   hardware often uses I/O space accesses. */
#ifdef USE_IO_OPS
#undef readb
#undef readw
#undef readl
#undef writeb
#undef writew
#undef writel
#define readb inb
#define readw inw
#define readl inl
#define writeb outb
#define writew outw
#define writel outl
#endif

/* Offsets to the device registers.
   Unlike software-only systems, device drivers interact with complex hardw=
are.
   It's not useful to define symbolic names for every register bit in the
   device.  The name can only partially document the semantics and make
   the driver longer and more difficult to read.
   In general, only the important configuration values or bits changed
   multiple times should be defined symbolically.
*/
enum alta_offsets {
	DMACtrl =3D 0x00,
	TxListPtr =3D 0x04,
	TxDMACtrl =3D 0x08,
	TxDescPoll =3D 0x0a,
	RxDMAStatus =3D 0x0c,
	RxListPtr =3D 0x10,
	RxDMACtrl =3D 0x14,
	RxDescPoll =3D 0x16,
	LEDCtrl =3D 0x1a,
	ASICCtrl =3D 0x30,
	EEData =3D 0x34,
	EECtrl =3D 0x36,
	TxThreshold =3D 0x3c,
	FlashAddr =3D 0x40,
	FlashData =3D 0x44,
	TxStatus =3D 0x46,
	DownCounter =3D 0x18,
	IntrClear =3D 0x4a,
	IntrEnable =3D 0x4c,
	IntrStatus =3D 0x4e,
	MACCtrl0 =3D 0x50,
	MACCtrl1 =3D 0x52,
	StationAddr =3D 0x54,
	MaxTxSize =3D 0x5A,
	RxMode =3D 0x5c,
	MIICtrl =3D 0x5e,
	MulticastFilter0 =3D 0x60,
	MulticastFilter1 =3D 0x64,
	RxOctetsLow =3D 0x68,
	RxOctetsHigh =3D 0x6a,
	TxOctetsLow =3D 0x6c,
	TxOctetsHigh =3D 0x6e,
	TxFramesOK =3D 0x70,
	RxFramesOK =3D 0x72,
	StatsCarrierError =3D 0x74,
	StatsLateColl =3D 0x75,
	StatsMultiColl =3D 0x76,
	StatsOneColl =3D 0x77,
	StatsTxDefer =3D 0x78,
	RxMissed =3D 0x79,
	StatsTxXSDefer =3D 0x7a,
	StatsTxAbort =3D 0x7b,
	StatsBcastTx =3D 0x7c,
	StatsBcastRx =3D 0x7d,
	StatsMcastTx =3D 0x7e,
	StatsMcastRx =3D 0x7f,
	/* Aliased and bogus values! */
	RxStatus =3D 0x0c,
};

/* Bits in the interrupt status/mask registers. */
enum intr_status_bits {
	IntrSummary=3D0x0001, IntrPCIErr=3D0x0002, IntrMACCtrl=3D0x0008,
	IntrTxDone=3D0x0004, IntrRxDone=3D0x0010, IntrRxStart=3D0x0020,
	IntrDrvRqst=3D0x0040,
	StatsMax=3D0x0080, LinkChange=3D0x0100,
	IntrTxDMADone=3D0x0200, IntrRxDMADone=3D0x0400,
};

/* Bits in the RxMode register. */
enum rx_mode_bits {
	AcceptAllIPMulti=3D0x20, AcceptMultiHash=3D0x10, AcceptAll=3D0x08,
	AcceptBroadcast=3D0x04, AcceptMulticast=3D0x02, AcceptMyPhys=3D0x01,
};
/* Bits in MACCtrl. */
enum mac_ctrl0_bits {
	EnbFullDuplex=3D0x20, EnbRcvLargeFrame=3D0x40,
	EnbFlowCtrl=3D0x100, EnbPassRxCRC=3D0x200,
};
enum mac_ctrl1_bits {
	StatsEnable=3D0x0020,	StatsDisable=3D0x0040, StatsEnabled=3D0x0080,
	TxEnable=3D0x0100, TxDisable=3D0x0200, TxEnabled=3D0x0400,
	RxEnable=3D0x0800, RxDisable=3D0x1000, RxEnabled=3D0x2000,
};

/* The Rx and Tx buffer descriptors. */
/* Note that using only 32 bit fields simplifies conversion to big-endian
   architectures. */
struct netdev_desc {
	u32 next_desc;
	u32 status;
	struct desc_frag { u32 addr, length; } frag[1];
};

/* Bits in netdev_desc.status */
enum desc_status_bits {
	DescOwn=3D0x8000,
	DescEndPacket=3D0x4000,
	DescEndRing=3D0x2000,
	LastFrag=3D0x80000000,
	DescIntrOnTx=3D0x8000,
	DescIntrOnDMADone=3D0x80000000,
	DisableAlign =3D 0x00000001,
};

#define PRIV_ALIGN	15 	/* Required alignment mask */
/* Use  __attribute__((aligned (L1_CACHE_BYTES)))  to maintain alignment
   within the structure. */
#define MII_CNT		4
struct netdev_private {
	/* Descriptor rings first for alignment. */
	struct netdev_desc *rx_ring;
	struct netdev_desc *tx_ring;
	struct sk_buff* rx_skbuff[RX_RING_SIZE];
	struct sk_buff* tx_skbuff[TX_RING_SIZE];
        dma_addr_t tx_ring_dma;
        dma_addr_t rx_ring_dma;
	struct net_device_stats stats;
	struct timer_list timer;	/* Media monitoring timer. */
	/* Frequently used values: keep some adjacent for cache effect. */
	spinlock_t lock;
	int chip_id, drv_flags;
	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
	spinlock_t txlock;					/* Group with Tx control cache line. */
	struct netdev_desc *last_tx;		/* Last Tx descriptor used. */
	unsigned int cur_tx, dirty_tx;
	unsigned int tx_full:1;				/* The Tx queue is full. */
	/* These values are keep track of the transceiver/media in use. */
	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
	unsigned int medialock:1;			/* Do not sense media. */
	unsigned int default_port:4;		/* Last dev->if_port value. */
	unsigned int an_enable:1;
	unsigned int speed;
	/* Multicast and receive mode. */
	spinlock_t mcastlock;				/* SMP lock multicast updates. */
	u16 mcast_filter[4];
	/* MII transceiver section. */
	int mii_cnt;						/* MII device addresses. */
	u16 advertising;					/* NWay media advertisement */
	unsigned char phys[MII_CNT];		/* MII device addresses, only first one used=
. */
	struct pci_dev *pci_dev;
};

/* The station address location in the EEPROM. */
#define EEPROM_SA_OFFSET	0x10

static int  eeprom_read(long ioaddr, int location);
static int  mdio_read(struct net_device *dev, int phy_id, int location);
static void mdio_write(struct net_device *dev, int phy_id, int location, in=
t value);
static int  netdev_open(struct net_device *dev);
static void check_duplex(struct net_device *dev);
static void netdev_timer(unsigned long data);
static void tx_timeout(struct net_device *dev);
static void init_ring(struct net_device *dev);
static int  start_tx(struct sk_buff *skb, struct net_device *dev);
static void intr_handler(int irq, void *dev_instance, struct pt_regs *regs)=
;
static void netdev_error(struct net_device *dev, int intr_status);
static int  netdev_rx(struct net_device *dev);
static void netdev_error(struct net_device *dev, int intr_status);
static void set_rx_mode(struct net_device *dev);
static struct net_device_stats *get_stats(struct net_device *dev);
static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
static int  netdev_close(struct net_device *dev);

=0C

static int __devinit sundance_probe1 (struct pci_dev *pdev,
				      const struct pci_device_id *ent)
{
	struct net_device *dev;
	struct netdev_private *np;
	static int card_idx;
	int chip_idx =3D ent->driver_data;
	int irq;
	int i;
	long ioaddr;
	u16 mii_ctl;
	void *ring_space;
	dma_addr_t ring_dma;


/* when built into the kernel, we only print version if device is found */
#ifndef MODULE
	static int printed_version;
	if (!printed_version++)
		printk(version);
#endif

	if (pci_enable_device(pdev))
		return -EIO;
	pci_set_master(pdev);

	irq =3D pdev->irq;

	dev =3D alloc_etherdev(sizeof(*np));
	if (!dev)
		return -ENOMEM;
	SET_MODULE_OWNER(dev);

	if (pci_request_regions(pdev, DRV_NAME))
		goto err_out_netdev;

#ifdef USE_IO_OPS
	ioaddr =3D pci_resource_start(pdev, 0);
#else
	ioaddr =3D pci_resource_start(pdev, 1);
	ioaddr =3D (long) ioremap (ioaddr, pci_id_tbl[chip_idx].io_size);
	if (!ioaddr)
		goto err_out_res;
#endif

	for (i =3D 0; i < 3; i++)
		((u16 *)dev->dev_addr)[i] =3D
			le16_to_cpu(eeprom_read(ioaddr, i + EEPROM_SA_OFFSET));

	dev->base_addr =3D ioaddr;
	dev->irq =3D irq;

	np =3D dev->priv;
	np->chip_id =3D chip_idx;
	np->drv_flags =3D pci_id_tbl[chip_idx].drv_flags;
	np->pci_dev =3D pdev;
	spin_lock_init(&np->lock);

	ring_space =3D pci_alloc_consistent(pdev, TX_TOTAL_SIZE, &ring_dma);
	if (!ring_space)
		goto err_out_cleardev;
	np->tx_ring =3D (struct netdev_desc *)ring_space;
	np->tx_ring_dma =3D ring_dma;

	ring_space =3D pci_alloc_consistent(pdev, RX_TOTAL_SIZE, &ring_dma);
	if (!ring_space)
		goto err_out_unmap_tx;
	np->rx_ring =3D (struct netdev_desc *)ring_space;
	np->rx_ring_dma =3D ring_dma;

	/* The chip-specific entries in the device structure. */
	dev->open =3D &netdev_open;
	dev->hard_start_xmit =3D &start_tx;
	dev->stop =3D &netdev_close;
	dev->get_stats =3D &get_stats;
	dev->set_multicast_list =3D &set_rx_mode;
	dev->do_ioctl =3D &netdev_ioctl;
	dev->tx_timeout =3D &tx_timeout;
	dev->watchdog_timeo =3D TX_TIMEOUT;
	pci_set_drvdata(pdev, dev);

	if (mtu)
		dev->mtu =3D mtu;

	i =3D register_netdev(dev);
	if (i)
		goto err_out_unmap_rx;

	printk(KERN_INFO "%s: %s at 0x%lx, ",
		   dev->name, pci_id_tbl[chip_idx].name, ioaddr);
	for (i =3D 0; i < 5; i++)
			printk("%2.2x:", dev->dev_addr[i]);
	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);

	if (1) {
		int phy, phy_idx =3D 0;
		np->phys[0] =3D 1;		/* Default setting */
		for (phy =3D 0; phy < 32 && phy_idx < MII_CNT; phy++) {
			int mii_status =3D mdio_read(dev, phy, 1);
			if (mii_status !=3D 0xffff  &&  mii_status !=3D 0x0000) {
				np->phys[phy_idx++] =3D phy;
				np->advertising =3D mdio_read(dev, phy, 4);
				printk(KERN_INFO "%s: MII PHY found at address %d, status "
					   "0x%4.4x advertising %4.4x.\n",
					   dev->name, phy, mii_status, np->advertising);
			}
		}
		np->mii_cnt =3D phy_idx;
		if (phy_idx =3D=3D 0)
			printk(KERN_INFO "%s: No MII transceiver found!, ASIC status %x\n",
				   dev->name, readl(ioaddr + ASICCtrl));
	}
	/* Parse override configuration */
	np->an_enable =3D 1;
	if (card_idx < MAX_UNITS) {
		if (media[card_idx] !=3D NULL) {
			np->an_enable =3D 0;
			if (strcmp (media[card_idx], "100mbps_fd") =3D=3D 0 ||
			    strcmp (media[card_idx], "4") =3D=3D 0) {
				np->speed =3D 100;
				np->full_duplex =3D 1;
			} else if (strcmp (media[card_idx], "100mbps_hd") =3D=3D 0
				   || strcmp (media[card_idx], "3") =3D=3D 0) {
				np->speed =3D 100;
				np->full_duplex =3D 0;
			} else if (strcmp (media[card_idx], "10mbps_fd") =3D=3D 0 ||
				   strcmp (media[card_idx], "2") =3D=3D 0) {
				np->speed =3D 10;
				np->full_duplex =3D 1;
			} else if (strcmp (media[card_idx], "10mbps_hd") =3D=3D 0 ||
				   strcmp (media[card_idx], "1") =3D=3D 0) {
				np->speed =3D 10;
				np->full_duplex =3D 0;
			} else {
				np->an_enable =3D 1;
			}
		}
	}

	/* Fibre PHY? */
	if (readl (ioaddr + ASICCtrl) & 0x80) {
		/* Default 100Mbps Full */
		if (np->an_enable) {
			np->speed =3D 100;
			np->full_duplex =3D 1;
			np->an_enable =3D 0;
		}
	}
	/* Reset PHY */
	mdio_write (dev, np->phys[0], MII_BMCR, BMCR_RESET);
	mdelay (300);
	mdio_write (dev, np->phys[0], MII_BMCR, BMCR_ANENABLE|BMCR_ANRESTART);
	/* Force media type */
	if (!np->an_enable) {
		mii_ctl =3D 0;
		mii_ctl |=3D (np->speed =3D=3D 100) ? BMCR_SPEED100 : 0;
		mii_ctl |=3D (np->full_duplex) ? BMCR_FULLDPLX : 0;
		mdio_write (dev, np->phys[0], MII_BMCR, mii_ctl);
		printk (KERN_INFO "Override speed=3D%d, %s duplex\n",
			np->speed, np->full_duplex ? "Full" : "Half");

	}

	/* Perhaps move the reset here? */
	/* Reset the chip to erase previous misconfiguration. */
	if (debug > 1)
		printk("ASIC Control is %x.\n", readl(ioaddr + ASICCtrl));
	writew(0x007f, ioaddr + ASICCtrl + 2);
	if (debug > 1)
		printk("ASIC Control is now %x.\n", readl(ioaddr + ASICCtrl));

	card_idx++;
	return 0;

err_out_unmap_rx:
        pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring, np->rx_ring_d=
ma);
err_out_unmap_tx:
        pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring, np->tx_ring_d=
ma);
err_out_cleardev:
	pci_set_drvdata(pdev, NULL);
#ifndef USE_IO_OPS
	iounmap((void *)ioaddr);
err_out_res:
#endif
	pci_release_regions(pdev);
err_out_netdev:
	kfree (dev);
	return -ENODEV;
}

=0C
/* Read the EEPROM and MII Management Data I/O (MDIO) interfaces. */
static int __devinit eeprom_read(long ioaddr, int location)
{
	int boguscnt =3D 1000;		/* Typical 190 ticks. */
	writew(0x0200 | (location & 0xff), ioaddr + EECtrl);
	do {
		if (! (readw(ioaddr + EECtrl) & 0x8000)) {
			return readw(ioaddr + EEData);
		}
	} while (--boguscnt > 0);
	return 0;
}

/*  MII transceiver control section.
	Read and write the MII registers using software-generated serial
	MDIO protocol.  See the MII specifications or DP83840A data sheet
	for details.

	The maximum data clock rate is 2.5 Mhz.  The minimum timing is usually
	met by back-to-back 33Mhz PCI cycles. */
#define mdio_delay() readb(mdio_addr)

/* Set iff a MII transceiver on any interface requires mdio preamble.
   This only set with older tranceivers, so the extra
   code size of a per-interface flag is not worthwhile. */
static const char mii_preamble_required =3D 1;

enum mii_reg_bits {
	MDIO_ShiftClk=3D0x0001, MDIO_Data=3D0x0002, MDIO_EnbOutput=3D0x0004,
};
#define MDIO_EnbIn  (0)
#define MDIO_WRITE0 (MDIO_EnbOutput)
#define MDIO_WRITE1 (MDIO_Data | MDIO_EnbOutput)

/* Generate the preamble required for initial synchronization and
   a few older transceivers. */
static void mdio_sync(long mdio_addr)
{
	int bits =3D 32;

	/* Establish sync by sending at least 32 logic ones. */
	while (--bits >=3D 0) {
		writeb(MDIO_WRITE1, mdio_addr);
		mdio_delay();
		writeb(MDIO_WRITE1 | MDIO_ShiftClk, mdio_addr);
		mdio_delay();
	}
}

static int mdio_read(struct net_device *dev, int phy_id, int location)
{
	long mdio_addr =3D dev->base_addr + MIICtrl;
	int mii_cmd =3D (0xf6 << 10) | (phy_id << 5) | location;
	int i, retval =3D 0;

	if (mii_preamble_required)
		mdio_sync(mdio_addr);

	/* Shift the read command bits out. */
	for (i =3D 15; i >=3D 0; i--) {
		int dataval =3D (mii_cmd & (1 << i)) ? MDIO_WRITE1 : MDIO_WRITE0;

		writeb(dataval, mdio_addr);
		mdio_delay();
		writeb(dataval | MDIO_ShiftClk, mdio_addr);
		mdio_delay();
	}
	/* Read the two transition, 16 data, and wire-idle bits. */
	for (i =3D 19; i > 0; i--) {
		writeb(MDIO_EnbIn, mdio_addr);
		mdio_delay();
		retval =3D (retval << 1) | ((readb(mdio_addr) & MDIO_Data) ? 1 : 0);
		writeb(MDIO_EnbIn | MDIO_ShiftClk, mdio_addr);
		mdio_delay();
	}
	return (retval>>1) & 0xffff;
}

static void mdio_write(struct net_device *dev, int phy_id, int location, in=
t value)
{
	long mdio_addr =3D dev->base_addr + MIICtrl;
	int mii_cmd =3D (0x5002 << 16) | (phy_id << 23) | (location<<18) | value;
	int i;

	if (mii_preamble_required)
		mdio_sync(mdio_addr);

	/* Shift the command bits out. */
	for (i =3D 31; i >=3D 0; i--) {
		int dataval =3D (mii_cmd & (1 << i)) ? MDIO_WRITE1 : MDIO_WRITE0;

		writeb(dataval, mdio_addr);
		mdio_delay();
		writeb(dataval | MDIO_ShiftClk, mdio_addr);
		mdio_delay();
	}
	/* Clear out extra bits. */
	for (i =3D 2; i > 0; i--) {
		writeb(MDIO_EnbIn, mdio_addr);
		mdio_delay();
		writeb(MDIO_EnbIn | MDIO_ShiftClk, mdio_addr);
		mdio_delay();
	}
	return;
}

=0C
static int netdev_open(struct net_device *dev)
{
	struct netdev_private *np =3D dev->priv;
	long ioaddr =3D dev->base_addr;
	int i;

	/* Do we need to reset the chip??? */

	i =3D request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
	if (i)
		return i;

	if (debug > 1)
		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
			   dev->name, dev->irq);

	init_ring(dev);

	writel(np->rx_ring_dma, ioaddr + RxListPtr);
	/* The Tx list pointer is written as packets are queued. */

	for (i =3D 0; i < 6; i++)
		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);

	/* Initialize other registers. */
	/* Configure the PCI bus bursts and FIFO thresholds. */

	if (dev->if_port =3D=3D 0)
		dev->if_port =3D np->default_port;

	np->mcastlock =3D (spinlock_t) SPIN_LOCK_UNLOCKED;

	set_rx_mode(dev);
	writew(0, ioaddr + IntrEnable);
	writew(0, ioaddr + DownCounter);
	/* Set the chip to poll every N*320nsec. */
	writeb(100, ioaddr + RxDescPoll);
	writeb(127, ioaddr + TxDescPoll);
	netif_start_queue(dev);

	/* Enable interrupts by setting the interrupt mask. */
	writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst | IntrTxDone
		   | StatsMax | LinkChange, ioaddr + IntrEnable);

	writew(StatsEnable | RxEnable | TxEnable, ioaddr + MACCtrl1);

	if (debug > 2)
		printk(KERN_DEBUG "%s: Done netdev_open(), status: Rx %x Tx %x "
			   "MAC Control %x, %4.4x %4.4x.\n",
			   dev->name, readl(ioaddr + RxStatus), readb(ioaddr + TxStatus),
			   readl(ioaddr + MACCtrl0),
			   readw(ioaddr + MACCtrl1), readw(ioaddr + MACCtrl0));

	/* Set the timer to check for link beat. */
	init_timer(&np->timer);
	np->timer.expires =3D jiffies + 3*HZ;
	np->timer.data =3D (unsigned long)dev;
	np->timer.function =3D &netdev_timer;				/* timer handler */
	add_timer(&np->timer);

	return 0;
}

static void check_duplex(struct net_device *dev)
{
	struct netdev_private *np =3D dev->priv;
	long ioaddr =3D dev->base_addr;
	int mii_lpa =3D mdio_read(dev, np->phys[0], MII_LPA);
	int negotiated =3D mii_lpa & np->advertising;
	int duplex;
=09
	/* Force media */
	if (!np->an_enable || mii_lpa =3D=3D 0xffff) {
		if (np->full_duplex)
			writew (readw (ioaddr + MACCtrl0) | EnbFullDuplex,
				ioaddr + MACCtrl0);
		return;
	}
	/* Autonegotiation */
	duplex =3D (negotiated & 0x0100) || (negotiated & 0x01C0) =3D=3D 0x0040;
	if (np->full_duplex !=3D duplex) {
		np->full_duplex =3D duplex;
		if (debug)
			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d "
				   "negotiated capability %4.4x.\n", dev->name,
				   duplex ? "full" : "half", np->phys[0], negotiated);
		writew(duplex ? 0x20 : 0, ioaddr + MACCtrl0);
	}
}

static void netdev_timer(unsigned long data)
{
	struct net_device *dev =3D (struct net_device *)data;
	struct netdev_private *np =3D dev->priv;
	long ioaddr =3D dev->base_addr;
	int next_tick =3D 10*HZ;

	if (debug > 3) {
		printk(KERN_DEBUG "%s: Media selection timer tick, intr status %4.4x, "
			   "Tx %x Rx %x.\n",
			   dev->name, readw(ioaddr + IntrEnable),
			   readb(ioaddr + TxStatus), readl(ioaddr + RxStatus));
	}
	check_duplex(dev);
	np->timer.expires =3D jiffies + next_tick;
	add_timer(&np->timer);
}

static void tx_timeout(struct net_device *dev)
{
	struct netdev_private *np =3D dev->priv;
	long ioaddr =3D dev->base_addr;

	printk(KERN_WARNING "%s: Transmit timed out, status %2.2x,"
		   " resetting...\n", dev->name, readb(ioaddr + TxStatus));

	{
		int i;
		printk(KERN_DEBUG "  Rx ring %p: ", np->rx_ring);
		for (i =3D 0; i < RX_RING_SIZE; i++)
			printk(" %8.8x", (unsigned int)np->rx_ring[i].status);
		printk("\n"KERN_DEBUG"  Tx ring %p: ", np->tx_ring);
		for (i =3D 0; i < TX_RING_SIZE; i++)
			printk(" %4.4x", np->tx_ring[i].status);
		printk("\n");
	}

	/* Perhaps we should reinitialize the hardware here. */
	dev->if_port =3D 0;
	/* Stop and restart the chip's Tx processes . */

	/* Trigger an immediate transmit demand. */
	writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst | IntrTxDone
		   | StatsMax | LinkChange, ioaddr + IntrEnable);

	dev->trans_start =3D jiffies;
	np->stats.tx_errors++;

	if (!np->tx_full)
		netif_wake_queue(dev);
}


/* Initialize the Rx and Tx rings, along with various 'dev' bits. */
static void init_ring(struct net_device *dev)
{
	struct netdev_private *np =3D dev->priv;
	int i;

	np->tx_full =3D 0;
	np->cur_rx =3D np->cur_tx =3D 0;
	np->dirty_rx =3D np->dirty_tx =3D 0;

	np->rx_buf_sz =3D (dev->mtu <=3D 1500 ? PKT_BUF_SZ : dev->mtu + 32);

	/* Initialize all Rx descriptors. */
	for (i =3D 0; i < RX_RING_SIZE; i++) {
		np->rx_ring[i].next_desc =3D cpu_to_le32(np->rx_ring_dma +=20
			((i+1)%RX_RING_SIZE)*sizeof(*np->rx_ring));
		np->rx_ring[i].status =3D 0;
		np->rx_ring[i].frag[0].length =3D 0;
		np->rx_skbuff[i] =3D 0;
	}

	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
	for (i =3D 0; i < RX_RING_SIZE; i++) {
		struct sk_buff *skb =3D dev_alloc_skb(np->rx_buf_sz);
		np->rx_skbuff[i] =3D skb;
		if (skb =3D=3D NULL)
			break;
		skb->dev =3D dev;		/* Mark as being used by this device. */
		skb_reserve(skb, 2);	/* 16 byte align the IP header. */
		np->rx_ring[i].frag[0].addr =3D cpu_to_le32(
			pci_map_single(np->pci_dev, skb->tail, np->rx_buf_sz,=20
				PCI_DMA_FROMDEVICE));
		np->rx_ring[i].frag[0].length =3D cpu_to_le32(np->rx_buf_sz | LastFrag);
	}
	np->dirty_rx =3D (unsigned int)(i - RX_RING_SIZE);

	for (i =3D 0; i < TX_RING_SIZE; i++) {
		np->tx_skbuff[i] =3D 0;
		np->tx_ring[i].status =3D 0;
	}
	return;
}

static int start_tx(struct sk_buff *skb, struct net_device *dev)
{
	struct netdev_private *np =3D dev->priv;
	struct netdev_desc *txdesc;
	unsigned entry;

	/* Note: Ordering is important here, set the field with the
	   "ownership" bit last, and only then increment cur_tx. */

	/* Calculate the next Tx descriptor entry. */
	entry =3D np->cur_tx % TX_RING_SIZE;
	np->tx_skbuff[entry] =3D skb;
	txdesc =3D &np->tx_ring[entry];

	txdesc->next_desc =3D 0;
	/* Note: disable the interrupt generation here before releasing. */
	txdesc->status =3D
		cpu_to_le32((entry<<2) | DescIntrOnDMADone | DescIntrOnTx | DisableAlign)=
;
	txdesc->frag[0].addr =3D cpu_to_le32(pci_map_single(np->pci_dev,=20
		skb->data, skb->len, PCI_DMA_TODEVICE));
	txdesc->frag[0].length =3D cpu_to_le32(skb->len | LastFrag);
	if (np->last_tx)
		np->last_tx->next_desc =3D cpu_to_le32(np->tx_ring_dma +
			entry*sizeof(struct netdev_desc));
	np->last_tx =3D txdesc;
	np->cur_tx++;

	/* On some architectures: explicitly flush cache lines here. */

	if (np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 1) {
		/* do nothing */
	} else {
		np->tx_full =3D 1;
		netif_stop_queue(dev);
	}
	/* Side effect: The read wakes the potentially-idle transmit channel. */
	if (readl(dev->base_addr + TxListPtr) =3D=3D 0)
		writel(np->tx_ring_dma + entry*sizeof(*np->tx_ring),
			dev->base_addr + TxListPtr);

	dev->trans_start =3D jiffies;

	if (debug > 4) {
		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
			   dev->name, np->cur_tx, entry);
	}
	return 0;
}

/* The interrupt handler does all of the Rx thread work and cleans up
   after the Tx thread. */
static void intr_handler(int irq, void *dev_instance, struct pt_regs *rgs)
{
	struct net_device *dev =3D (struct net_device *)dev_instance;
	struct netdev_private *np;
	long ioaddr;
	int boguscnt =3D max_interrupt_work;

	ioaddr =3D dev->base_addr;
	np =3D dev->priv;
	spin_lock(&np->lock);

	do {
		int intr_status =3D readw(ioaddr + IntrStatus);
		writew(intr_status & (IntrRxDone | IntrRxDMADone | IntrPCIErr |
			IntrDrvRqst | IntrTxDone | IntrTxDMADone | StatsMax |=20
			LinkChange), ioaddr + IntrStatus);

		if (debug > 4)
			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",
				   dev->name, intr_status);

		if (intr_status =3D=3D 0)
			break;

		if (intr_status & (IntrRxDone|IntrRxDMADone))
			netdev_rx(dev);

		if (intr_status & IntrTxDone) {
			int boguscnt =3D 32;
			int tx_status =3D readw(ioaddr + TxStatus);
			while (tx_status & 0x80) {
				if (debug > 4)
					printk("%s: Transmit status is %2.2x.\n",
						   dev->name, tx_status);
				if (tx_status & 0x1e) {
					np->stats.tx_errors++;
					if (tx_status & 0x10)  np->stats.tx_fifo_errors++;
#ifdef ETHER_STATS
					if (tx_status & 0x08)  np->stats.collisions16++;
#else
					if (tx_status & 0x08)  np->stats.collisions++;
#endif
					if (tx_status & 0x04)  np->stats.tx_fifo_errors++;
					if (tx_status & 0x02)  np->stats.tx_window_errors++;
					/* This reset has not been verified!. */
					if (tx_status & 0x10) {			/* Reset the Tx. */
						writew(0x001c, ioaddr + ASICCtrl + 2);
#if 0					/* Do we need to reset the Tx pointer here? */
						writel(np->tx_ring_dma
							+ np->dirty_tx*sizeof(*np->tx_ring),
							dev->base_addr + TxListPtr);
#endif
					}
					if (tx_status & 0x1e) 		/* Restart the Tx. */
						writew(TxEnable, ioaddr + MACCtrl1);
				}
				/* Yup, this is a documentation bug.  It cost me *hours*. */
				writew(0, ioaddr + TxStatus);
				tx_status =3D readb(ioaddr + TxStatus);
				if (--boguscnt < 0)
					break;
			}
		}
		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
			int entry =3D np->dirty_tx % TX_RING_SIZE;
			struct sk_buff *skb;

			if ( ! (np->tx_ring[entry].status & 0x00010000))
				break;
			skb =3D np->tx_skbuff[entry];
			/* Free the original skb. */
			pci_unmap_single(np->pci_dev,=20
				np->tx_ring[entry].frag[0].addr,=20
				skb->len, PCI_DMA_TODEVICE);
			dev_kfree_skb_irq(skb);
			np->tx_skbuff[entry] =3D 0;
		}
		if (np->tx_full
			&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
			/* The ring is no longer full, clear tbusy. */
			np->tx_full =3D 0;
			netif_wake_queue(dev);
		}

		/* Abnormal error summary/uncommon events handlers. */
		if (intr_status & (IntrDrvRqst | IntrPCIErr | LinkChange | StatsMax))
			netdev_error(dev, intr_status);
		if (--boguscnt < 0) {
			get_stats(dev);
			if (debug > 1)=20
				printk(KERN_WARNING "%s: Too much work at interrupt, "
				   "status=3D0x%4.4x / 0x%4.4x.\n",
				   dev->name, intr_status, readw(ioaddr + IntrClear));
#if 0
			/* Re-enable us in 3.2msec. */
			writew(0, ioaddr + IntrEnable);
			writew(1000, ioaddr + DownCounter);
			writew(IntrDrvRqst, ioaddr + IntrEnable);
#endif
			break;
		}
	} while (1);

	if (debug > 3)
		printk(KERN_DEBUG "%s: exiting interrupt, status=3D%#4.4x.\n",
			   dev->name, readw(ioaddr + IntrStatus));

	spin_unlock(&np->lock);
}

/* This routine is logically part of the interrupt handler, but separated
   for clarity and better register allocation. */
static int netdev_rx(struct net_device *dev)
{
	struct netdev_private *np =3D dev->priv;
	int entry =3D np->cur_rx % RX_RING_SIZE;
	int boguscnt =3D np->dirty_rx + RX_RING_SIZE - np->cur_rx;

	if (debug > 4) {
		printk(KERN_DEBUG " In netdev_rx(), entry %d status %4.4x.\n",
			   entry, np->rx_ring[entry].status);
	}

	/* If EOP is set on the next entry, it's a new packet. Send it up. */
	while (1) {
		struct netdev_desc *desc =3D &(np->rx_ring[entry]);
		u32 frame_status;
		int pkt_len;

		if (!(desc->status & DescOwn))
			break;
		frame_status =3D le32_to_cpu(desc->status);
		pkt_len =3D frame_status & 0x1fff;	/* Chip omits the CRC. */
		if (debug > 4)
			printk(KERN_DEBUG "  netdev_rx() status was %8.8x.\n",
				   frame_status);
		if (--boguscnt < 0)
			break;
		pci_dma_sync_single(np->pci_dev, desc->frag[0].addr,
			np->rx_buf_sz, PCI_DMA_FROMDEVICE);
	=09
		if (frame_status & 0x001f4000) {
			/* There was a error. */
			if (debug > 2)
				printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n",
					   frame_status);
			np->stats.rx_errors++;
			if (frame_status & 0x00100000) np->stats.rx_length_errors++;
			if (frame_status & 0x00010000) np->stats.rx_fifo_errors++;
			if (frame_status & 0x00060000) np->stats.rx_frame_errors++;
			if (frame_status & 0x00080000) np->stats.rx_crc_errors++;
			if (frame_status & 0x00100000) {
				printk(KERN_WARNING "%s: Oversized Ethernet frame,"
					   " status %8.8x.\n",
					   dev->name, frame_status);
			}
		} else {
			struct sk_buff *skb;

#ifndef final_version
			if (debug > 4)
				printk(KERN_DEBUG "  netdev_rx() normal Rx pkt length %d"
					   ", bogus_cnt %d.\n",
					   pkt_len, boguscnt);
#endif
			/* Check if the packet is long enough to accept without copying
			   to a minimally-sized skbuff. */
			if (pkt_len < rx_copybreak
				&& (skb =3D dev_alloc_skb(pkt_len + 2)) !=3D NULL) {
				skb->dev =3D dev;
				skb_reserve(skb, 2);	/* 16 byte align the IP header */
				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
				skb_put(skb, pkt_len);
			} else {
				pci_unmap_single(np->pci_dev,=20
					desc->frag[0].addr,
					np->rx_buf_sz,=20
					PCI_DMA_FROMDEVICE);
				skb_put(skb =3D np->rx_skbuff[entry], pkt_len);
				np->rx_skbuff[entry] =3D NULL;
			}
			skb->protocol =3D eth_type_trans(skb, dev);
			/* Note: checksum -> skb->ip_summed =3D CHECKSUM_UNNECESSARY; */
			netif_rx(skb);
			dev->last_rx =3D jiffies;
		}
		entry =3D (++np->cur_rx) % RX_RING_SIZE;
	}

	/* Refill the Rx ring buffers. */
	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
		struct sk_buff *skb;
		entry =3D np->dirty_rx % RX_RING_SIZE;
		if (np->rx_skbuff[entry] =3D=3D NULL) {
			skb =3D dev_alloc_skb(np->rx_buf_sz);
			np->rx_skbuff[entry] =3D skb;
			if (skb =3D=3D NULL)
				break;		/* Better luck next round. */
			skb->dev =3D dev;		/* Mark as being used by this device. */
			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
			np->rx_ring[entry].frag[0].addr =3D cpu_to_le32(
				pci_map_single(np->pci_dev, skb->tail,=20
					np->rx_buf_sz, PCI_DMA_FROMDEVICE));
		}
		/* Perhaps we need not reset this field. */
		np->rx_ring[entry].frag[0].length =3D
			cpu_to_le32(np->rx_buf_sz | LastFrag);
		np->rx_ring[entry].status =3D 0;
	}

	/* No need to restart Rx engine, it will poll. */
	return 0;
}

static void netdev_error(struct net_device *dev, int intr_status)
{
	long ioaddr =3D dev->base_addr;
	struct netdev_private *np =3D dev->priv;
	u16 mii_ctl, mii_advertise, mii_lpa;
	int speed;

	if (intr_status & IntrDrvRqst) {
		/* Stop the down counter and turn interrupts back on. */
		if (debug > 1)
			printk("%s: Turning interrupts back on.\n", dev->name);
		writew(0, ioaddr + IntrEnable);
		writew(0, ioaddr + DownCounter);
		writew(IntrRxDone | IntrRxDMADone | IntrPCIErr | IntrDrvRqst |
			   IntrTxDone | StatsMax | LinkChange, ioaddr + IntrEnable);
		/* Ack buggy InRequest */
		writew (IntrDrvRqst, ioaddr + IntrStatus);
	}
	if (intr_status & LinkChange) {
		if (np->an_enable) {
			mii_advertise =3D mdio_read (dev, np->phys[0], MII_ADVERTISE);
			mii_lpa=3D mdio_read (dev, np->phys[0], MII_LPA);
			mii_advertise &=3D mii_lpa;
			printk (KERN_INFO "%s: Link changed: ", dev->name);
			if (mii_advertise & ADVERTISE_100FULL)
				printk ("100Mbps, full duplex\n");
			else if (mii_advertise & ADVERTISE_100HALF)
				printk ("100Mbps, half duplex\n");
			else if (mii_advertise & ADVERTISE_10FULL)
				printk ("10Mbps, full duplex\n");
			else if (mii_advertise & ADVERTISE_10HALF)
				printk ("10Mbps, half duplex\n");
			else
				printk ("\n");

		} else {
			mii_ctl =3D mdio_read (dev, np->phys[0], MII_BMCR);
			speed =3D (mii_ctl & BMCR_SPEED100) ? 100 : 10;
			printk (KERN_INFO "%s: Link changed: %dMbps ,",
				dev->name, speed);
			printk ("%s duplex.\n", (mii_ctl & BMCR_FULLDPLX) ?
				"full" : "half");
		}
		check_duplex (dev);
	}
	if (intr_status & StatsMax) {
		get_stats(dev);
	}
	if (intr_status & IntrPCIErr) {
		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
			   dev->name, intr_status);
		/* We must do a global reset of DMA to continue. */
	}
}

static struct net_device_stats *get_stats(struct net_device *dev)
{
	long ioaddr =3D dev->base_addr;
	struct netdev_private *np =3D dev->priv;
	int i;

	/* We should lock this segment of code for SMP eventually, although
	   the vulnerability window is very small and statistics are
	   non-critical. */
	/* The chip only need report frame silently dropped. */
	np->stats.rx_missed_errors	+=3D readb(ioaddr + RxMissed);
	np->stats.tx_packets +=3D readw(ioaddr + TxFramesOK);
	np->stats.rx_packets +=3D readw(ioaddr + RxFramesOK);
	np->stats.collisions +=3D readb(ioaddr + StatsLateColl);
	np->stats.collisions +=3D readb(ioaddr + StatsMultiColl);
	np->stats.collisions +=3D readb(ioaddr + StatsOneColl);
	readb(ioaddr + StatsCarrierError);
	readb(ioaddr + StatsTxDefer);
	for (i =3D StatsTxDefer; i <=3D StatsMcastRx; i++)
		readb(ioaddr + i);
	np->stats.tx_bytes +=3D readw(ioaddr + TxOctetsLow);
	np->stats.tx_bytes +=3D readw(ioaddr + TxOctetsHigh) << 16;
	np->stats.rx_bytes +=3D readw(ioaddr + RxOctetsLow);
	np->stats.rx_bytes +=3D readw(ioaddr + RxOctetsHigh) << 16;

	return &np->stats;
}

static unsigned const ethernet_polynomial_le =3D 0xedb88320U;
static inline unsigned ether_crc_le(int length, unsigned char *data)
{
        unsigned int crc =3D 0xffffffff;  /* Initial value. */
        while(--length >=3D 0) {
                unsigned char current_octet =3D *data++;
                int bit;
                for (bit =3D 8; --bit >=3D 0; current_octet >>=3D 1) {
                        if ((crc ^ current_octet) & 1) {
                                crc >>=3D 1;
                                crc ^=3D ethernet_polynomial_le;
                        } else
                                crc >>=3D 1;
                }
        }
        return crc;
}



static void set_rx_mode(struct net_device *dev)
{
	long ioaddr =3D dev->base_addr;
	u16 mc_filter[4];			/* Multicast hash filter */
	u32 rx_mode;
	int i;

	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
		/* Unconditionally log net taps. */
		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
		memset(mc_filter, 0xff, sizeof(mc_filter));
		rx_mode =3D AcceptBroadcast | AcceptMulticast | AcceptAll | AcceptMyPhys;
	} else if ((dev->mc_count > multicast_filter_limit)
			   ||  (dev->flags & IFF_ALLMULTI)) {
		/* Too many to match, or accept all multicasts. */
		memset(mc_filter, 0xff, sizeof(mc_filter));
		rx_mode =3D AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
	} else if (dev->mc_count) {
		struct dev_mc_list *mclist;
		int bit;
		int index;
		int crc;
		memset (mc_filter, 0, sizeof (mc_filter));
		for (i =3D 0, mclist =3D dev->mc_list; mclist && i < dev->mc_count;
		     i++, mclist =3D mclist->next) {
			crc =3D ether_crc_le (ETH_ALEN, mclist->dmi_addr);
			for (index=3D0, bit=3D0; bit < 6; bit++, crc <<=3D 1)
				if (crc & 0x80000000) index |=3D 1 << bit;
			mc_filter[index/16] |=3D (1 << (index % 16));
		}
		rx_mode =3D AcceptBroadcast | AcceptMultiHash | AcceptMyPhys;
	} else {
		writeb(AcceptBroadcast | AcceptMyPhys, ioaddr + RxMode);
		return;
	}
	for (i =3D 0; i < 4; i++)
		writew(mc_filter[i], ioaddr + MulticastFilter0 + i*2);
	writeb(rx_mode, ioaddr + RxMode);
}

static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
{
	struct netdev_private *np =3D dev->priv;
	u32 ethcmd;
	=09
	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
		return -EFAULT;

        switch (ethcmd) {
        case ETHTOOL_GDRVINFO: {
		struct ethtool_drvinfo info =3D {ETHTOOL_GDRVINFO};
		strcpy(info.driver, DRV_NAME);
		strcpy(info.version, DRV_VERSION);
		strcpy(info.bus_info, np->pci_dev->slot_name);
		if (copy_to_user(useraddr, &info, sizeof(info)))
			return -EFAULT;
		return 0;
	}

        }
=09
	return -EOPNOTSUPP;
}

static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
	struct mii_ioctl_data *data =3D (struct mii_ioctl_data *)&rq->ifr_data;

	switch(cmd) {
	case SIOCETHTOOL:
		return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
	case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
		data->phy_id =3D ((struct netdev_private *)dev->priv)->phys[0] & 0x1f;
		/* Fall Through */

	case SIOCGMIIREG:		/* Read MII PHY register. */
	case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
		data->val_out =3D mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1=
f);
		return 0;

	case SIOCSMIIREG:		/* Write MII PHY register. */
	case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		mdio_write(dev, data->phy_id & 0x1f, data->reg_num & 0x1f, data->val_in);
		return 0;
	default:
		return -EOPNOTSUPP;
	}
}

static int netdev_close(struct net_device *dev)
{
	long ioaddr =3D dev->base_addr;
	struct netdev_private *np =3D dev->priv;
	struct sk_buff *skb;
	int i;

	netif_stop_queue(dev);

	if (debug > 1) {
		printk(KERN_DEBUG "%s: Shutting down ethercard, status was Tx %2.2x "
			   "Rx %4.4x Int %2.2x.\n",
			   dev->name, readb(ioaddr + TxStatus),
			   readl(ioaddr + RxStatus), readw(ioaddr + IntrStatus));
		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / %d.\n",
			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
	}

	/* Disable interrupts by clearing the interrupt mask. */
	writew(0x0000, ioaddr + IntrEnable);

	/* Stop the chip's Tx and Rx processes. */
	writew(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);

#ifdef __i386__
	if (debug > 2) {
		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
			   (int)(np->tx_ring_dma));
		for (i =3D 0; i < TX_RING_SIZE; i++)
			printk(" #%d desc. %4.4x %8.8x %8.8x.\n",
				   i, np->tx_ring[i].status, np->tx_ring[i].frag[0].addr,
				   np->tx_ring[i].frag[0].length);
		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
			   (int)(np->rx_ring_dma));
		for (i =3D 0; i < /*RX_RING_SIZE*/4 ; i++) {
			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x\n",
				   i, np->rx_ring[i].status, np->rx_ring[i].frag[0].addr,
				   np->rx_ring[i].frag[0].length);
		}
	}
#endif /* __i386__ debugging only */

	free_irq(dev->irq, dev);

	del_timer_sync(&np->timer);

	/* Free all the skbuffs in the Rx queue. */
	for (i =3D 0; i < RX_RING_SIZE; i++) {
		np->rx_ring[i].status =3D 0;
		np->rx_ring[i].frag[0].addr =3D 0xBADF00D0; /* An invalid address. */
		skb =3D np->rx_skbuff[i];
		if (skb) {
			pci_unmap_single(np->pci_dev,=20
				np->rx_ring[i].frag[0].addr, np->rx_buf_sz,=20
				PCI_DMA_FROMDEVICE);
			dev_kfree_skb(skb);
			np->rx_skbuff[i] =3D 0;
		}
	}
	for (i =3D 0; i < TX_RING_SIZE; i++) {
		skb =3D np->tx_skbuff[i];
		if (skb) {
			pci_unmap_single(np->pci_dev,=20
				np->tx_ring[i].frag[0].addr, skb->len,
				PCI_DMA_TODEVICE);
			dev_kfree_skb(skb);
			np->tx_skbuff[i] =3D 0;
		}
	}

	return 0;
}

static void __devexit sundance_remove1 (struct pci_dev *pdev)
{
	struct net_device *dev =3D pci_get_drvdata(pdev);
=09
	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */
	if (dev) {
		struct netdev_private *np =3D dev->priv;

		unregister_netdev(dev);
        	pci_free_consistent(pdev, RX_TOTAL_SIZE, np->rx_ring,=20
			np->rx_ring_dma);
	        pci_free_consistent(pdev, TX_TOTAL_SIZE, np->tx_ring,=20
			np->tx_ring_dma);
		pci_release_regions(pdev);
#ifndef USE_IO_OPS
		iounmap((char *)(dev->base_addr));
#endif
		kfree(dev);
		pci_set_drvdata(pdev, NULL);
	}
}

static struct pci_driver sundance_driver =3D {
	name:		DRV_NAME,
	id_table:	sundance_pci_tbl,
	probe:		sundance_probe1,
	remove:		__devexit_p(sundance_remove1),
};

static int __init sundance_init(void)
{
/* when a module, this is printed whether or not devices are found in probe=
 */
#ifdef MODULE
	printk(version);
#endif
	return pci_module_init(&sundance_driver);
}

static void __exit sundance_exit(void)
{
	pci_unregister_driver(&sundance_driver);
}

module_init(sundance_init);
module_exit(sundance_exit);

--=-OBdnq9Vv5K7aZxOPeYj1--

