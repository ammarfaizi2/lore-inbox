Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135320AbRDRUtT>; Wed, 18 Apr 2001 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135321AbRDRUtH>; Wed, 18 Apr 2001 16:49:07 -0400
Received: from [63.109.146.2] ([63.109.146.2]:59887 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S135320AbRDRUss>;
	Wed, 18 Apr 2001 16:48:48 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B89@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: linux-kernel@vger.kernel.org
Cc: "'ionut@moisil.cs.columbia.edu'" <ionut@moisil.cs.columbia.edu>,
        "'steve@navaho.co.uk'" <steve@navaho.co.uk>,
        "'thockin@isunix.it.ilstu.edu'" <thockin@isunix.it.ilstu.edu>,
        "'jgarzik@mandrakesoft.com'" <jgarzik@mandrakesoft.com>,
        "'hozer@drgw.net'" <hozer@drgw.net>,
        "'knghtbrd@debian.org'" <knghtbrd@debian.org>,
        "'becker@scyld.com'" <becker@scyld.com>,
        "'root@frumious.unidec.co.uk'" <root@frumious.unidec.co.uk>,
        "'thockin@isunix.it.ilstu.edu'" <thockin@isunix.it.ilstu.edu>,
        "'jocelyn.mayer@netgem.com'" <jocelyn.mayer@netgem.com>
Subject: An improved natsemi driver for 2.2
Date: Wed, 18 Apr 2001 13:48:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0C848.F2CAEA37"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0C848.F2CAEA37
Content-Type: text/plain;
	charset="iso-8859-1"


This version of the natsemi driver is being successfully used by us (Myrio
Corporation) on hardware that has the 83815 chip on the motherboard, with
the 2.2.17 kernel.  It appears to work well with both multicast and unicast,
with decent throughput.  It requires the "pci-scan" module by Donald Becker
at scyld.com.

We would be very interested in any feedback on problems with 2.2.17 or
2.2.19, and our hope is that some experienced kernel developers will examine
it and alert us of potential problems we haven't tripped over yet.

Most of the code in this driver is by Donald Becker, of course. However, the
driver from scyld.com could not receive packets on our hardware. We started
from the modified version posted by Jocelyn Mayer.  That one sort of worked
for us but had problems. Our version backed out some of those changes, and
has fixes for CRC calculation, reading the MAC address from the EEPROM, and
other things. 

I (Torrey Hoffman) am not the developer of our version, although I did go
through it and clean it up a little.  I am the alleged "Linux expert" here,
and if there are problems with the driver I am the person to contact.

I'm cc'ing everyone on my "natsemi" address list, please trim followups.  
I do read the mailing list, but please cc me if responding.

Thanks.

Torrey Hoffman
torrey.hoffman@myrio.com
thoffman@hotmail.com




------_=_NextPart_000_01C0C848.F2CAEA37
Content-Type: application/octet-stream;
	name="myrio-natsemi.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="myrio-natsemi.c"

/* natsemi.c: A Linux PCI Ethernet driver for the NatSemi DP83810 =
series. */=0A=
/*=0A=
	Written/copyright 1999-2000 by Donald Becker.=0A=
=0A=
	This software may be used and distributed according to the terms of=0A=
	the GNU General Public License (GPL), incorporated herein by =
reference.=0A=
	Drivers based on or derived from this code fall under the GPL and =
must=0A=
	retain the authorship, copyright and license notice.  This file is =
not=0A=
	a complete program and may only be used when the entire operating=0A=
	system is licensed under the GPL.  License for under other terms may =
be=0A=
	available.  Contact the original author for details.=0A=
=0A=
	The original author may be reached as becker@scyld.com, or at=0A=
	Scyld Computing Corporation=0A=
	410 Severn Ave., Suite 210=0A=
	Annapolis MD 21403=0A=
=0A=
	Support information and updates available at=0A=
	http://www.scyld.com/network/netsemi.html=0A=
=0A=
    - A lot of changes By Jocelyn Mayer (jma) for Netgem - October =
2000=0A=
      The deal was to unfreeze a DP83815 Chip=0A=
=0A=
	April 2001 - Myrio Corporation=0A=
    - Fixes by Greg Smith to correctly deal with MAC address, improve =
=0A=
      throughput, etc.=0A=
    - Some cleanup and reformatting to make a clean patch by Torrey=0A=
      Hoffman (Torrey.Hoffman@myrio.com)=0A=
*/=0A=
=0A=
/* These identify the driver base version and may not be removed. */=0A=
static const char version1[] =3D=0A=
"natsemi.c:v1.05 8/7/2000  Written by Donald Becker =
<becker@scyld.com>\n";=0A=
static const char version2[] =3D=0A=
"  http://www.scyld.com/network/natsemi.html\n";=0A=
static const char version3[] =3D=0A=
//"  (unofficial 2.2.x version, October-December, 2000 Jocelyn Mayer =
(jma) for Netgem, mod 2/00 by (grs)\n";=0A=
"  Unofficial 2.2.x version, April 2001, Greg Smith (grs) for Myrio =
Corporation\n";=0A=
=0A=
/* Updated to recommendations in pci-skeleton v2.03. */=0A=
=0A=
/* Automatically extracted configuration info:=0A=
probe-func: natsemi_probe=0A=
config-in: tristate 'National Semiconductor DP83810 series PCI Ethernet =
support' CONFIG_NATSEMI=0A=
=0A=
c-help-name: National Semiconductor DP83810 series PCI Ethernet =
support=0A=
c-help-symbol: CONFIG_NATSEMI=0A=
c-help: This driver is for the National Semiconductor DP83810 =
series,=0A=
c-help: including the 83815 chip.=0A=
c-help: More specific information and updates are available from =0A=
c-help: http://www.scyld.com/network/natsemi.html=0A=
*/=0A=
=0A=
/* The user-configurable values.=0A=
   These may be modified when a driver module is loaded.*/=0A=
=0A=
static int debug =3D 1;			/* 1 normal messages, 0 quiet .. 7 verbose. =
*/=0A=
/* Maximum events (Rx packets, etc.) to handle at each interrupt. */=0A=
static int max_interrupt_work =3D 20;=0A=
static int mtu =3D 0;=0A=
/* Maximum number of multicast addresses to filter (vs. =
rx-all-multicast).=0A=
   This chip uses a 512 element hash table based on the Ethernet CRC.  =
*/=0A=
static int multicast_filter_limit =3D 100;=0A=
=0A=
/* Set the copy breakpoint for the copy-only-tiny-frames scheme.=0A=
   Setting to > 1518 effectively disables this feature. */=0A=
static int rx_copybreak =3D 0;=0A=
=0A=
/* Used to pass the media type, etc.=0A=
   Both 'options[]' and 'full_duplex[]' should exist for driver=0A=
   interoperability.=0A=
   The media type is usually passed in 'options[]'.=0A=
*/=0A=
#define MAX_UNITS 8		/* More are supported, limit only on options */=0A=
static int options[MAX_UNITS] =3D {-1, -1, -1, -1, -1, -1, -1, -1};=0A=
static int full_duplex[MAX_UNITS] =3D {-1, -1, -1, -1, -1, -1, -1, =
-1};=0A=
=0A=
/* Operational parameters that are set at compile time. */=0A=
=0A=
/* Keep the ring sizes a power of two for compile efficiency.=0A=
   The compiler will convert <unsigned>'%'<2^N> into a bit mask.=0A=
   Making the Tx ring too large decreases the effectiveness of =
channel=0A=
   bonding and packet priority.=0A=
   There are no ill effects from too-large receive rings. */=0A=
#define TX_RING_SIZE	16=0A=
#define TX_QUEUE_LEN	10		/* Limit ring entries actually used.  */=0A=
#define RX_RING_SIZE	32=0A=
=0A=
/* Operational parameters that usually are not changed. */=0A=
/* Time in jiffies before concluding the transmitter is hung. */=0A=
#define TX_TIMEOUT  (2*HZ)=0A=
#define RESET_TIMEOUT (5*HZ)=0A=
#define AUTONEGOCIATION_TIMEOUT (6*HZ)=0A=
#define RENEGOCIATE 1=0A=
#define RECONFIGURE 0=0A=
=0A=
#define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/=0A=
=0A=
#ifndef __KERNEL__=0A=
#define __KERNEL__=0A=
#endif=0A=
#if !defined(__OPTIMIZE__)=0A=
#warning  You must compile this file with the correct options!=0A=
#warning  See the last lines of the source file.=0A=
#error You must compile this driver with "-O".=0A=
#endif=0A=
=0A=
/* Include files, designed to support most kernel versions 2.0.0 and =
later. */=0A=
#include <linux/config.h>=0A=
#if defined(CONFIG_SMP) && ! defined(__SMP__)=0A=
#define __SMP__=0A=
#endif=0A=
#if defined(MODULE) && defined(CONFIG_MODVERSIONS) && ! =
defined(MODVERSIONS)=0A=
#define MODVERSIONS=0A=
#endif=0A=
=0A=
#include <linux/version.h>=0A=
#include <linux/module.h>=0A=
#if LINUX_VERSION_CODE < 0x20300  &&  defined(MODVERSIONS)=0A=
#include <linux/modversions.h>=0A=
#endif=0A=
=0A=
#include <linux/kernel.h>=0A=
#include <linux/string.h>=0A=
#include <linux/timer.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/ioport.h>=0A=
#include <linux/malloc.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/pci.h>=0A=
#include <linux/netdevice.h>=0A=
#include <linux/etherdevice.h>=0A=
#include <linux/skbuff.h>=0A=
#include <asm/processor.h>		/* Processor type for cache alignment. =
*/=0A=
#include <asm/bitops.h>=0A=
#include <asm/io.h>=0A=
=0A=
#ifdef INLINE_PCISCAN=0A=
#include "k_compat.h"=0A=
#else=0A=
#include "pci-scan.h"=0A=
#include "kern_compat.h"=0A=
#endif=0A=
=0A=
/* Condensed operations for readability. */=0A=
#define virt_to_le32desc(addr)  cpu_to_le32(virt_to_bus(addr))=0A=
#define le32desc_to_virt(addr)  bus_to_virt(le32_to_cpu(addr))=0A=
=0A=
#if (LINUX_VERSION_CODE >=3D 0x20100)  &&  defined(MODULE)=0A=
char kernel_version[] =3D UTS_RELEASE;=0A=
#endif=0A=
=0A=
/* jma: This driver seems to be fixed, now, so... */=0A=
#define embeded_version 1=0A=
=0A=
MODULE_AUTHOR("Donald Becker <becker@scyld.com>");=0A=
MODULE_DESCRIPTION("National Semiconductor DP83810-815 series PCI =
Ethernet driver");=0A=
MODULE_PARM(max_interrupt_work, "i");=0A=
MODULE_PARM(mtu, "i");=0A=
MODULE_PARM(debug, "i");=0A=
MODULE_PARM(rx_copybreak, "i");=0A=
MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");=0A=
MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");=0A=
=0A=
/*=0A=
				Theory of Operation=0A=
=0A=
I. Board Compatibility=0A=
=0A=
This driver is designed for National Semiconductor DP83815 PCI Ethernet =
NIC.=0A=
It also works with other chips in in the DP83810 series.=0A=
=0A=
II. Board-specific settings=0A=
=0A=
This driver requires the PCI interrupt line to be valid.=0A=
It honors the EEPROM-set values. =0A=
=0A=
III. Driver operation=0A=
=0A=
IIIa. Ring buffers=0A=
=0A=
This driver uses two statically allocated fixed-size descriptor =
lists=0A=
formed into rings by a branch from the final descriptor to the =
beginning of=0A=
the list.  The ring sizes are set at compile time by =
RX/TX_RING_SIZE.=0A=
The NatSemi design uses a 'next descriptor' pointer that the driver =
forms=0A=
into a list. =0A=
=0A=
IIIb/c. Transmit/Receive Structure=0A=
=0A=
This driver uses a zero-copy receive and transmit scheme.=0A=
The driver allocates full frame size skbuffs for the Rx ring buffers =
at=0A=
open() time and passes the skb->data field to the chip as receive =
data=0A=
buffers.  When an incoming frame is less than RX_COPYBREAK bytes =
long,=0A=
a fresh skbuff is allocated and the frame is copied to the new =
skbuff.=0A=
When the incoming frame is larger, the skbuff is passed directly up =
the=0A=
protocol stack.  Buffers consumed this way are replaced by newly =
allocated=0A=
skbuffs in a later phase of receives.=0A=
=0A=
The RX_COPYBREAK value is chosen to trade-off the memory wasted by=0A=
using a full-sized skbuff for small frames vs. the copying costs of =
larger=0A=
frames.  New boards are typically used in generously configured =
machines=0A=
and the underfilled buffers have negligible impact compared to the =
benefit of=0A=
a single allocation size, so the default value of zero results in =
never=0A=
copying packets.  When copying is done, the cost is usually mitigated =
by using=0A=
a combined copy/checksum routine.  Copying also preloads the cache, =
which is=0A=
most useful with small frames.=0A=
=0A=
A subtle aspect of the operation is that unaligned buffers are not =
permitted=0A=
by the hardware.  Thus the IP header at offset 14 in an ethernet frame =
isn't=0A=
longword aligned for further processing.  On copies frames are put into =
the=0A=
skbuff at an offset of "+2", 16-byte aligning the IP header.=0A=
=0A=
IIId. Synchronization=0A=
=0A=
The driver runs as two independent, single-threaded flows of control.  =
One=0A=
is the send-packet routine, which enforces single-threaded use by =
the=0A=
dev->tbusy flag.  The other thread is the interrupt handler, which is =
single=0A=
threaded by the hardware and interrupt handling software.=0A=
=0A=
The send packet thread has partial control over the Tx ring and =
'dev->tbusy'=0A=
flag.  It sets the tbusy flag whenever it's queuing a Tx packet. If the =
next=0A=
queue slot is empty, it clears the tbusy flag when finished otherwise =
it sets=0A=
the 'lp->tx_full' flag.=0A=
=0A=
The interrupt handler has exclusive control over the Rx ring and =
records stats=0A=
from the Tx ring.  After reaping the stats, it marks the Tx queue entry =
as=0A=
empty by incrementing the dirty_tx mark. Iff the 'lp->tx_full' flag is =
set, it=0A=
clears both the tx_full and tbusy flags.=0A=
=0A=
IV. Notes=0A=
=0A=
NatSemi PCI network controllers are very uncommon.=0A=
=0A=
IVb. References=0A=
=0A=
http://www.scyld.com/expert/100mbps.html=0A=
http://www.scyld.com/expert/NWay.html=0A=
No NatSemi datasheet was publically available at the initial release =
date.=0A=
=0A=
IVc. Errata=0A=
=0A=
None characterised.=0A=
*/=0A=
=0A=
=0C=0A=
=0A=
static void *natsemi_probe1(struct pci_dev *pdev, void *init_dev,=0A=
							long ioaddr, int irq, int chip_idx, int find_cnt);=0A=
#ifdef USE_IO_OPS=0A=
#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_IO  | PCI_ADDR0)=0A=
#else=0A=
#define PCI_IOTYPE (PCI_USES_MASTER | PCI_USES_MEM | PCI_ADDR1)=0A=
#endif=0A=
=0A=
static struct pci_id_info pci_id_tbl[] =3D {=0A=
	{"NatSemi DP83815", { 0x0020100B, 0xffffffff },=0A=
	 PCI_IOTYPE, 256, 0},=0A=
	{0,},						/* 0 terminated list. */=0A=
};=0A=
=0A=
struct drv_id_info natsemi_drv_id =3D {=0A=
	"natsemi", 0, PCI_CLASS_NETWORK_ETHERNET<<8, pci_id_tbl, =
natsemi_probe1, };=0A=
=0A=
/* Offsets to the device registers.=0A=
   Unlike software-only systems, device drivers interact with complex =
hardware.=0A=
   It's not useful to define symbolic names for every register bit in =
the=0A=
   device.=0A=
*/=0A=
enum register_offsets {=0A=
	ChipCmd=3D0x00, ChipConfig=3D0x04, EECtrl=3D0x08, PCIBusCfg=3D0x0C,=0A=
	IntrStatus=3D0x10, IntrMask=3D0x14, IntrEnable=3D0x18,=0A=
	TxRingPtr=3D0x20, TxConfig=3D0x24,=0A=
	RxRingPtr=3D0x30, RxConfig=3D0x34,  ClkRun=3D0x3C,=0A=
	WOLCmd=3D0x40, PauseCmd=3D0x44, RxFilterAddr=3D0x48, =
RxFilterData=3D0x4C,=0A=
	BootRomAddr=3D0x50, BootRomData=3D0x54, StatsCtrl=3D0x5C, =
StatsData=3D0x60,=0A=
	RxPktErrs=3D0x60, RxMissed=3D0x68, RxCRCErrs=3D0x64,=0A=
=0A=
	/* jma - Grundig */=0A=
	/* Implementation of a set of other registers of the DP83815 Chip =
*/=0A=
	BMCR=3D 0x80, BMSR =3D 0x84, PHYIDR1 =3D 0x88, PHYIDR2 =3D 0x8C,=0A=
	ANAR =3D 0x90, ANLPAR =3D 0x94, ANER =3D 0x98, ANNPTR =3D 0x9C,=0A=
	PHYSTS =3D 0xC0,=0A=
	MICR =3D 0xC4, MISR =3D 0xC8,=0A=
	/* Obscur things from National Semiconductor documentation for =
reseting the device */=0A=
    SiRevReg=3D 0x58,=0A=
	NATSEMI_OBSCUR_1 =3D 0xCC, NATSEMI_OBSCUR_2 =3D 0xE4, NATSEMI_OBSCUR_3 =
=3D 0xFC, =0A=
	NATSEMI_OBSCUR_4 =3D 0xF4, NATSEMI_OBSCUR_5 =3D 0xF8=0A=
};=0A=
=0A=
/* Bit in ChipCmd. */=0A=
enum ChipCmdBits {=0A=
	ChipReset=3D0x100, RxReset=3D0x20, TxReset=3D0x10, RxOff=3D0x08, =
RxOn=3D0x04,=0A=
	TxOff=3D0x02, TxOn=3D0x01,=0A=
};=0A=
=0A=
/* Bits in the interrupt status/mask registers. */=0A=
enum intr_status_bits {=0A=
	IntrRxDone=3D0x0001, IntrRxIntr=3D0x0002, IntrRxErr=3D0x0004, =
IntrRxEarly=3D0x0008,=0A=
	IntrRxIdle=3D0x0010, IntrRxOverrun=3D0x0020,=0A=
	IntrTxDone=3D0x0040, IntrTxIntr=3D0x0080, IntrTxErr=3D0x0100,=0A=
	IntrTxIdle=3D0x0200, IntrTxUnderrun=3D0x0400,=0A=
	StatsMax=3D0x0800, LinkChange=3D0x4000,=0A=
	WOLPkt=3D0x2000,=0A=
	RxResetDone=3D0x1000000, TxResetDone=3D0x2000000,=0A=
	IntrPCIErr=3D0x00f00000,=0A=
	IntrNormalSummary=3D0x0251, IntrAbnormalSummary=3D0xCD20, //grs ias=0A=
};=0A=
=0A=
/* Bits in the RxMode register. */=0A=
enum rx_mode_bits {=0A=
	AcceptErr=3D0x20, AcceptRunt=3D0x10,=0A=
	AcceptBroadcast=3D0xC0000000,=0A=
	AcceptMulticast=3D0x00200000, AcceptAllMulticast=3D0x20000000,=0A=
	AcceptAllPhys=3D0x10000000, AcceptMyPhys=3D0x08000000,=0A=
};=0A=
=0A=
/* The Rx and Tx buffer descriptors. */=0A=
/* Note that using only 32 bit fields simplifies conversion to =
big-endian=0A=
   architectures. */=0A=
struct netdev_desc {=0A=
	u32 next_desc;=0A=
	s32 cmd_status;=0A=
	u32 addr;=0A=
	u32 software_use;=0A=
};=0A=
=0A=
/* Bits in network_desc.status */=0A=
enum desc_status_bits {=0A=
	DescOwn=3D0x80000000, DescMore=3D0x40000000, DescIntr=3D0x20000000,=0A=
	DescNoCRC=3D0x10000000,=0A=
	DescPktOK=3D0x08000000, RxTooLong=3D0x00400000,=0A=
};=0A=
=0A=
#define PRIV_ALIGN	15 	/* Required alignment mask */=0A=
struct netdev_private {=0A=
	/* Descriptor rings first for alignment. */=0A=
	struct netdev_desc rx_ring[RX_RING_SIZE];=0A=
	struct netdev_desc tx_ring[TX_RING_SIZE];=0A=
	struct net_device *next_module;		/* Link for devices of this type. =
*/=0A=
	void *priv_addr;					/* Unaligned address for kfree */=0A=
	const char *product_name;=0A=
	/* The addresses of receive-in-place skbuffs. */=0A=
	struct sk_buff* rx_skbuff[RX_RING_SIZE];=0A=
	/* The saved address of a sent-in-place packet/buffer, for later =
free(). */=0A=
	struct sk_buff* tx_skbuff[TX_RING_SIZE];=0A=
	struct net_device_stats stats;=0A=
	struct timer_list timer;	/* Media monitoring timer. */=0A=
	/* Frequently used values: keep some adjacent for cache effect. */=0A=
	int chip_id, drv_flags;=0A=
	struct pci_dev *pci_dev;=0A=
	long in_interrupt;			/* Word-long for SMP locks. */=0A=
	struct netdev_desc *rx_head_desc;=0A=
	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices =
*/=0A=
	unsigned int cur_tx, dirty_tx;=0A=
	unsigned int rx_buf_sz;				/* Based on MTU+slack. */=0A=
	unsigned int tx_full:1;				/* The Tx queue is full. */=0A=
	/* These values are keep track of the transceiver/media in use. */=0A=
	unsigned int full_duplex:1;			/* Full-duplex operation requested. =
*/=0A=
	unsigned int duplex_lock:1;=0A=
	unsigned int medialock:1;			/* Do not sense media. */=0A=
	unsigned int default_port:4;		/* Last dev->if_port value. */=0A=
    int SavedClkRun; //grs=0A=
=0A=
    /* jma - I add this in the structure... should be a flag... */=0A=
    unsigned char speed;=0A=
=0A=
	/* Rx filter. */=0A=
	u32 cur_rx_mode;=0A=
	u32 rx_filter[16];=0A=
	/* FIFO and PCI burst thresholds. */=0A=
	int tx_config, rx_config;=0A=
	/* MII transceiver section. */=0A=
	u16 advertising;					/* NWay media advertisement */=0A=
};=0A=
=0A=
static int  eeprom_read(long ioaddr, int location);=0A=
static int  mdio_read(struct net_device *dev, int phy_id, int =
location);=0A=
static void mdio_write(struct net_device *dev, int phy_id, int =
location, int value);=0A=
static int  netdev_open(struct net_device *dev);=0A=
static void check_duplex(struct net_device *dev); =0A=
static void netdev_timer(unsigned long data);=0A=
static void tx_timeout(struct net_device *dev);=0A=
static void init_ring(struct net_device *dev);=0A=
static int  start_tx(struct sk_buff *skb, struct net_device *dev);=0A=
static void intr_handler(int irq, void *dev_instance, struct pt_regs =
*regs);=0A=
static void netdev_error(struct net_device *dev, int intr_status);=0A=
static int  netdev_rx(struct net_device *dev);=0A=
/* Removed by jma */=0A=
/*  static void netdev_error(struct device *dev, int intr_status); =
*/=0A=
static void set_rx_mode(struct net_device *dev);=0A=
static struct net_device_stats *get_stats(struct net_device *dev);=0A=
static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int =
cmd);=0A=
static int  netdev_close(struct net_device *dev);=0A=
/* Two functions added by jma */=0A=
static int Nastemi_auto_negociate(struct net_device *dev, int);=0A=
static int Natsemi_reset_and_config(long);=0A=
=0A=
=0C=0A=
=0A=
/* A list of our installed devices, for removing the driver module. =
*/=0A=
static struct net_device *root_net_dev =3D NULL;=0A=
=0A=
#ifndef MODULE=0A=
int natsemi_probe(struct net_device *dev)=0A=
{=0A=
	printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);=0A=
	return 0;=0A=
}=0A=
#endif=0A=
=0A=
static void *natsemi_probe1(struct pci_dev *pdev, void *init_dev,=0A=
							long ioaddr, int irq, int chip_idx, int find_cnt)=0A=
{=0A=
	struct net_device *dev;=0A=
	struct netdev_private *np;=0A=
	void *priv_mem;=0A=
	int i, option =3D find_cnt < MAX_UNITS ? options[find_cnt] : 0;=0A=
    int temp;=0A=
    =0A=
#ifndef embeded_version=0A=
    int config;=0A=
#endif=0A=
=0A=
	dev =3D init_etherdev(init_dev, 0);=0A=
=0A=
	printk(KERN_INFO "%s: %s at 0x%lx, ",=0A=
		   dev->name, pci_id_tbl[chip_idx].name, ioaddr);=0A=
=0A=
    /* grs ... change the way we get the MAC address    */=0A=
           =0A=
    /* force a reload from the eeprom */=0A=
    writel(readl(ioaddr+PCIBusCfg) | 0x4, ioaddr+PCIBusCfg);=0A=
    =0A=
    /* wait up to 10 jiffies for  eeprom to load */=0A=
    temp =3D jiffies + 10;=0A=
    while(readl(ioaddr+PCIBusCfg) & 0x4)=0A=
        if (temp <=3D jiffies)=0A=
            break;=0A=
=0A=
    if (readl(ioaddr+PCIBusCfg) & 0x4)=0A=
    {=0A=
        printk("natsemi error: eeprom failed forced load\n");=0A=
        return NULL;=0A=
    }=0A=
             =0A=
    /* look for check sum error, if bad, error out */=0A=
    if (readl(ioaddr+PCIBusCfg) & 0x1)=0A=
    {=0A=
        printk("natsemi error: configuration eeprom check sum =
error\n");=0A=
        return NULL;=0A=
    }=0A=
               =0A=
    /* grs ... read and print the mac address, put into dev */=0A=
    printk("\nMAC ADDR");=0A=
    for (i=3D0;i<3;i++)=0A=
    {=0A=
        writel(i*2, ioaddr+RxFilterAddr);=0A=
        temp =3D readw(ioaddr+RxFilterData);=0A=
        dev->dev_addr[i*2] =3D temp & 0xFF;=0A=
        dev->dev_addr[i*2 + 1] =3D  (temp>>8)&0xFF;=0A=
        printk(":%2.2x:%2.2x", temp & 0xFF, (temp>>8)&0xFF);=0A=
    }        =0A=
    printk("\n");=0A=
=0A=
    if ((dev->dev_addr[0] =3D=3D 0) &&=0A=
        (dev->dev_addr[1] =3D=3D 0) &&=0A=
        (dev->dev_addr[2] =3D=3D 0) &&=0A=
        (dev->dev_addr[3] =3D=3D 0) &&=0A=
        (dev->dev_addr[4] =3D=3D 0) &&=0A=
        (dev->dev_addr[5] =3D=3D 0))=0A=
    {=0A=
        printk("natsemi error: mac address is zero\n");=0A=
        return NULL;=0A=
    }  =0A=
    =0A=
#ifndef embeded_version=0A=
	if (debug > 3) {=0A=
		for (i =3D 0; i < 5; i++)=0A=
			printk(KERN_INFO "%2.2x:", dev->dev_addr[i]);=0A=
		printk(KERN_INFO "%2.2x, IRQ %d.\n", dev->dev_addr[i], irq);=0A=
	}=0A=
	/* Dump the EEPROM contents during development. */=0A=
	if (debug > 6) {=0A=
		for (i =3D 0; i < 64; i++)=0A=
			printkKERN_INFO ("%4.4x%s",=0A=
				   eeprom_read(ioaddr, i), i % 16 !=3D 15 ? " " : "\n");=0A=
	}=0A=
#endif=0A=
=0A=
	/* Reset the chip to erase previous misconfiguration. */=0A=
    if (Natsemi_reset_and_config(ioaddr))=0A=
        return NULL;=0A=
=0A=
	/* Make certain elements e.g. descriptor lists are aligned. */=0A=
	priv_mem =3D kmalloc(sizeof(*np) + PRIV_ALIGN, GFP_KERNEL);=0A=
	/* Check for the very unlikely case of no memory. */=0A=
	if (priv_mem =3D=3D NULL)=0A=
		return NULL;=0A=
=0A=
	dev->base_addr =3D ioaddr;=0A=
	dev->irq =3D irq;=0A=
=0A=
	dev->priv =3D np =3D (void *)(((long)priv_mem + PRIV_ALIGN) & =
~PRIV_ALIGN);=0A=
	memset(np, 0, sizeof(*np));=0A=
	np->priv_addr =3D priv_mem;=0A=
=0A=
	np->next_module =3D root_net_dev;=0A=
	root_net_dev =3D dev;=0A=
=0A=
	np->pci_dev =3D pdev;=0A=
	np->chip_id =3D chip_idx;=0A=
	np->drv_flags =3D pci_id_tbl[chip_idx].drv_flags;=0A=
=0A=
	if (dev->mem_start)=0A=
		option =3D dev->mem_start;=0A=
=0A=
	/* The lower four bits are the media type. */=0A=
	if (option > 0) {=0A=
		if (option & 0x200)=0A=
			np->full_duplex =3D 1;=0A=
		np->default_port =3D option & 15;=0A=
		if (np->default_port)=0A=
			np->medialock =3D 1;=0A=
	}=0A=
	if (find_cnt < MAX_UNITS  &&  full_duplex[find_cnt] > 0)=0A=
		np->full_duplex =3D 1;=0A=
=0A=
	if (np->full_duplex)=0A=
		np->duplex_lock =3D 1;=0A=
=0A=
	/* The chip-specific entries in the device structure. */=0A=
	dev->open =3D &netdev_open;=0A=
	dev->hard_start_xmit =3D &start_tx;=0A=
	dev->stop =3D &netdev_close;=0A=
	dev->get_stats =3D &get_stats;=0A=
	dev->set_multicast_list =3D &set_rx_mode;=0A=
	dev->do_ioctl =3D &mii_ioctl;=0A=
=0A=
	if (mtu)=0A=
		dev->mtu =3D mtu;=0A=
 =0A=
    /* Just for debugging */=0A=
#ifndef embeded_version=0A=
    if (debug > 4) {=0A=
        config =3D readl(ioaddr + ChipConfig);=0A=
        printk(KERN_INFO "Chip config:     0x%8.8x.\n", config);=0A=
    }=0A=
    /* end of this patch */=0A=
#endif=0A=
=0A=
	np->advertising =3D readl(ioaddr + 0x90);=0A=
#ifndef embeded_version=0A=
	if (debug > 3) {=0A=
		printk(KERN_INFO "%s: Transceiver status 0x%4.4x advertising =
%4.4x.\n",=0A=
			   dev->name, (int)readl(ioaddr + 0x84), np->advertising);=0A=
	}=0A=
#endif=0A=
=0A=
	return dev;=0A=
}=0A=
=0A=
/* jma: I made a new Reset routine, following National Semiconductor =
advices */=0A=
	/* Reset the chip to erase previous misconfiguration. */=0A=
static int Natsemi_reset_and_config(long ioaddr) {=0A=
    time_t start_reset =3D jiffies;=0A=
=0A=
#ifndef embeded_version=0A=
    if (debug > 4)=0A=
        printk(KERN_INFO "Reseting hardware \n");=0A=
#endif=0A=
    writel(0x8000, ioaddr + BMCR);=0A=
    while ((readl(ioaddr + BMCR) & 0x8000) & !((jiffies - start_reset) =
> (RESET_TIMEOUT))) {}=0A=
#ifndef embeded_version=0A=
    if (debug > 4)=0A=
        printk(KERN_INFO "Reset done \n");=0A=
#endif=0A=
=0A=
	if ((jiffies - start_reset) > (RESET_TIMEOUT)) {=0A=
#ifndef embeded_version=0A=
		if (debug > 1)=0A=
			printk(KERN_INFO "Natsemi Reset: timeout");=0A=
#endif=0A=
		return -1;=0A=
	}=0A=
	=0A=
	/* As National Semiconductor says it has to be in the doc,=0A=
	 * Don't really know what this has to do... */ =0A=
   =0A=
    /* grs ... only write the following if SRR=3D203h */=0A=
    printk("SRR =3D %x\n", readw(ioaddr + SiRevReg));=0A=
    =0A=
    if (readw(ioaddr +SiRevReg) =3D=3D 0x0203)=0A=
    {         =0A=
	    writel(0x0001, ioaddr + NATSEMI_OBSCUR_1);=0A=
	    writel(0x189C, ioaddr + NATSEMI_OBSCUR_2);=0A=
	    writel(0x0000, ioaddr + NATSEMI_OBSCUR_3);=0A=
	    writel(0x5040, ioaddr + NATSEMI_OBSCUR_4);=0A=
	    writel(0x008C, ioaddr + NATSEMI_OBSCUR_5);=0A=
	    /* Done as said by N.S. */=0A=
    }=0A=
	return 0;=0A=
=0A=
}=0A=
=0A=
/* jma: a new routine to perform autonegociation */=0A=
static int Nastemi_auto_negociate(struct net_device *dev, int recheck) =
{=0A=
    struct netdev_private *np =3D (struct netdev_private =
*)dev->priv;=0A=
    time_t start_time;=0A=
    static char negociation_done =3D 0;=0A=
    int config;=0A=
    unsigned long ioaddr =3D dev->base_addr;=0A=
=0A=
    if (recheck)=0A=
        negociation_done =3D 0;=0A=
    =0A=
    if (negociation_done) {=0A=
        writel(((readl(ioaddr + BMSR) | ((np->full_duplex << 8) | =0A=
                (((np->speed =3D 100) ? 1 : 0) << 13))) & 0xEFFF), =
ioaddr + BMSR );=0A=
#ifndef embeded_version=0A=
		if (debug > 6) =0A=
            printk(KERN_INFO "Reconfigure: %d\n", readl(ioaddr + =
BMSR));=0A=
#endif=0A=
    }=0A=
    else {=0A=
        start_time=3Djiffies;=0A=
#ifndef embeded_version=0A=
        if (debug > 6) =0A=
			printk(KERN_INFO "Trying Autonegociation.\n");=0A=
#endif=0A=
        writel(0x0081, ioaddr + ANLPAR);=0A=
=0A=
    /* We need to disable autonegociation, then enable it again */=0A=
        writel( readl(ioaddr + BMCR) & 0xEFFF, ioaddr + BMCR);=0A=
        writel( readl(ioaddr + BMCR) | 0x1200, ioaddr + BMCR);=0A=
=0A=
    /* then wait a little while... */ =0A=
        while (((!(readl(ioaddr + BMSR) & 0x0030)) | (readl(ioaddr + =
PHYSTS) & 0x0013)) &=0A=
                 !((jiffies - start_time) > (AUTONEGOCIATION_TIMEOUT))) =
{}=0A=
=0A=
#ifndef embeded_version=0A=
        if (((jiffies - start_time) > AUTONEGOCIATION_TIMEOUT) && =
(debug > 6))=0A=
            printk(KERN_INFO "Natsemi: Autonegociation Timeout.\n");=0A=
#endif=0A=
=0A=
        if (((readl (ioaddr + ANER) & 0x0010) | (readl(ioaddr + BMSR) & =
0x0010)) && (debug > 6)) {=0A=
#ifndef embeded_version=0A=
            printk(KERN_INFO "Natsemi: Autonegociation fault...\n");=0A=
#endif=0A=
        /* force 10BaseT Half Duplex Mode... */=0A=
            negociation_done =3D 0;=0A=
            writel( readl(ioaddr + BMCR) & 0xCEFF, ioaddr + BMCR);=0A=
            negociation_done =3D 1;=0A=
        }=0A=
        else {=0A=
#ifndef embeded_version=0A=
            if (debug > 6)=0A=
                printk(KERN_INFO "Autonegociation done... \n");=0A=
#endif=0A=
            negociation_done =3D 1;=0A=
        }=0A=
        if (!( readl(ioaddr + BMSR) & 0x0004)) {=0A=
#ifndef embeded_version=0A=
            if (debug > 6)=0A=
                printk(KERN_INFO "Link Problem...\n");=0A=
#endif=0A=
            negociation_done =3D 0;=0A=
        /* force 10BaseT Half Duplex Mode... (Maybe, we shouldn't) =
*/=0A=
            writel( readl(ioaddr + BMCR) & 0xCEFF, ioaddr + BMCR);=0A=
#ifndef embeded_version=0A=
            if (debug > 6) =0A=
                printk(KERN_INFO "Configure: %d\n", readl(ioaddr + =
BMSR));=0A=
#endif=0A=
        }=0A=
    }=0A=
=0A=
    /* Let's keep the speed and Duplex mode into the device structure =
*/=0A=
    config =3D readl(ioaddr + ChipConfig);=0A=
    np->full_duplex =3D (config & 0x20000000) ? 1 : 0;=0A=
    np->speed =3D (config & 40000000) ? 100 : 10;=0A=
    =0A=
    return 0; =0A=
}=0A=
=0A=
=0C=0A=
/* Read the EEPROM and MII Management Data I/O (MDIO) interfaces.=0A=
   The EEPROM code is for the common 93c06/46 EEPROMs with 6 bit =
addresses. */=0A=
=0A=
/* Delay between EEPROM clock transitions.=0A=
   No extra delay is needed with 33Mhz PCI, but future 66Mhz access may =
need=0A=
   a delay.  Note that pre-2.0.34 kernels had a cache-alignment bug =
that=0A=
   made udelay() unreliable.=0A=
   The old method of using an ISA access as a delay, __SLOW_DOWN_IO__, =
is=0A=
   depricated.=0A=
*/=0A=
#define eeprom_delay(ee_addr)	readl(ee_addr)=0A=
=0A=
enum EEPROM_Ctrl_Bits {=0A=
	EE_ShiftClk=3D0x04, EE_DataIn=3D0x01, EE_ChipSelect=3D0x08, =
EE_DataOut=3D0x02,=0A=
};=0A=
#define EE_Write0 (EE_ChipSelect)=0A=
#define EE_Write1 (EE_ChipSelect | EE_DataIn)=0A=
=0A=
/* The EEPROM commands include the alway-set leading bit. */=0A=
enum EEPROM_Cmds {=0A=
	EE_WriteCmd=3D(5 << 6), EE_ReadCmd=3D(6 << 6), EE_EraseCmd=3D(7 << =
6),=0A=
};=0A=
=0A=
static int eeprom_read(long addr, int location)=0A=
{=0A=
	int i;=0A=
	int retval =3D 0;=0A=
	int ee_addr =3D addr + EECtrl;=0A=
	int read_cmd =3D location | EE_ReadCmd;=0A=
	writel(EE_Write0, ee_addr);=0A=
=0A=
	/* Shift the read command bits out. */=0A=
	for (i =3D 10; i >=3D 0; i--) {=0A=
		short dataval =3D (read_cmd & (1 << i)) ? EE_Write1 : EE_Write0;=0A=
		writel(dataval, ee_addr);=0A=
		eeprom_delay(ee_addr);=0A=
		writel(dataval | EE_ShiftClk, ee_addr);=0A=
		eeprom_delay(ee_addr);=0A=
	}=0A=
	writel(EE_ChipSelect, ee_addr);=0A=
=0A=
	for (i =3D 16; i > 0; i--) {=0A=
		writel(EE_ChipSelect | EE_ShiftClk, ee_addr);=0A=
		eeprom_delay(ee_addr);=0A=
		retval =3D (retval << 1) | ((readl(ee_addr) & EE_DataOut) ? 1 : =
0);=0A=
		writel(EE_ChipSelect, ee_addr);=0A=
		eeprom_delay(ee_addr);=0A=
	}=0A=
=0A=
	/* Terminate the EEPROM access. */=0A=
	writel(EE_Write0, ee_addr);=0A=
	writel(0, ee_addr);=0A=
	return retval;=0A=
}=0A=
=0A=
/*  MII transceiver control section.=0A=
	The 83815 series has an internal transceiver, and we present the=0A=
	management registers as if they were MII connected. */=0A=
=0A=
static int mdio_read(struct net_device *dev, int phy_id, int =
location)=0A=
{=0A=
	if (phy_id =3D=3D 1 && location < 32)=0A=
		return readl(dev->base_addr + 0x80 + (location<<2)) & 0xffff;=0A=
	else=0A=
		return 0xffff;=0A=
}=0A=
=0A=
static void mdio_write(struct net_device *dev, int phy_id, int =
location, int value)=0A=
{=0A=
	if (phy_id =3D=3D 1 && location < 32)=0A=
		writew(value, dev->base_addr + 0x80 + (location<<2));=0A=
}=0A=
=0A=
=0C=0A=
static int netdev_open(struct net_device *dev)=0A=
{=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	long ioaddr =3D dev->base_addr;=0A=
	int i;=0A=
=0A=
	/* Do we need to reset the chip??? */=0A=
=0A=
	MOD_INC_USE_COUNT;=0A=
=0A=
	if (request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev)) =
{=0A=
		MOD_DEC_USE_COUNT;=0A=
		return -EAGAIN;=0A=
	}=0A=
=0A=
	if (debug > 1)=0A=
		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",=0A=
			   dev->name, dev->irq);=0A=
=0A=
	init_ring(dev);=0A=
=0A=
	writel(virt_to_bus(np->rx_ring), ioaddr + RxRingPtr);=0A=
	writel(virt_to_bus(np->tx_ring), ioaddr + TxRingPtr);=0A=
=0A=
	for (i =3D 0; i < 6; i +=3D 2) {=0A=
		writel(i, ioaddr + RxFilterAddr);=0A=
		writew(dev->dev_addr[i] + (dev->dev_addr[i+1] << 8),=0A=
			   ioaddr + RxFilterData);=0A=
	}=0A=
=0A=
=0A=
    =0A=
	/* Initialize other registers. */=0A=
	/* Configure the PCI bus bursts and FIFO thresholds. */=0A=
	/* Configure for standard, in-spec Ethernet. */=0A=
=0A=
	if (readl(ioaddr + ChipConfig) & 0x20000000) {	/* Full duplex */=0A=
		np->tx_config =3D 0xD0801002;=0A=
		np->rx_config =3D 0x10000020;=0A=
	} else {=0A=
		np->tx_config =3D 0x10801002;=0A=
		np->rx_config =3D 0x0020;=0A=
	}=0A=
    =0A=
	if (dev->if_port =3D=3D 0)=0A=
		dev->if_port =3D np->default_port;=0A=
=0A=
	/* Disable PME:=0A=
	 * The PME bit is initialized from the EEPROM contents.=0A=
	 * PCI cards probably have PME disabled, but motherboard=0A=
	 * implementations may have PME set to enable WakeOnLan. =0A=
	 * With PME set the chip will scan incoming packets but=0A=
	 * nothing will be written to memory. */=0A=
	np->SavedClkRun =3D readl(ioaddr + ClkRun);=0A=
	writel(np->SavedClkRun & ~0x100, ioaddr + ClkRun);=0A=
=0A=
	dev->tbusy =3D 0;=0A=
	dev->interrupt =3D 0;=0A=
	np->in_interrupt =3D 0;=0A=
=0A=
	check_duplex(dev);=0A=
	set_rx_mode(dev);=0A=
    =0A=
#ifndef embeded_version=0A=
    if (debug > 6)=0A=
        printk(KERN_INFO "Now, config:     0x%8.8x.\n", readl(ioaddr + =
ChipConfig));=0A=
#endif=0A=
=0A=
	dev->start =3D 1;=0A=
=0A=
	/* Enable interrupts by setting the interrupt mask. */=0A=
	writel(IntrNormalSummary | IntrAbnormalSummary | 0x1f, ioaddr + =
IntrMask);=0A=
	writel(1, ioaddr + IntrEnable);=0A=
=0A=
	writel(RxOn | TxOn, ioaddr + ChipCmd);=0A=
	writel(4, ioaddr + StatsCtrl); 					/* Clear Stats */=0A=
=0A=
	if (debug > 2)=0A=
		printk(KERN_DEBUG "%s: Done netdev_open(), status: %x.\n",=0A=
			   dev->name, (int)readl(ioaddr + ChipCmd));=0A=
=0A=
	/* Set the timer to check for link beat. */=0A=
	init_timer(&np->timer);=0A=
	np->timer.expires =3D jiffies + 3*HZ;=0A=
	np->timer.data =3D (unsigned long)dev;=0A=
	np->timer.function =3D &netdev_timer;				/* timer handler */=0A=
	add_timer(&np->timer);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void check_duplex(struct net_device *dev)=0A=
{=0A=
	struct netdev_private *np =3D dev->priv;=0A=
	long ioaddr =3D dev->base_addr;=0A=
	int duplex;=0A=
=0A=
	if (np->duplex_lock)=0A=
		return;=0A=
	duplex =3D readl(ioaddr + ChipConfig) & 0x20000000 ? 1 : 0;=0A=
	if (np->full_duplex !=3D duplex) {=0A=
		np->full_duplex =3D duplex;=0A=
		if (debug)=0A=
			printk(KERN_INFO "%s: Setting %s-duplex based on negotiated link"=0A=
				   " capability.\n", dev->name,=0A=
				   duplex ? "full" : "half");=0A=
		if (duplex) {=0A=
			np->rx_config |=3D 0x10000000;=0A=
			np->tx_config |=3D 0xC0000000;=0A=
		} else {=0A=
			np->rx_config &=3D ~0x10000000;=0A=
			np->tx_config &=3D ~0xC0000000;=0A=
		}=0A=
		writel(np->tx_config, ioaddr + TxConfig);=0A=
		writel(np->rx_config, ioaddr + RxConfig);=0A=
	}=0A=
}=0A=
=0A=
static void netdev_timer(unsigned long data)=0A=
{=0A=
	struct net_device *dev =3D (struct net_device *)data;=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
#ifndef embeded_version=0A=
	long ioaddr =3D dev->base_addr;=0A=
#endif=0A=
	int next_tick =3D 60*HZ;=0A=
=0A=
#ifndef embeded_version=0A=
	if (debug > 3)=0A=
		printk(KERN_DEBUG "%s: Media selection timer tick, status =
%8.8x.\n",=0A=
			   dev->name, (int)readl(ioaddr + IntrStatus));=0A=
#endif=0A=
/*=0A=
	if (test_bit(0, (void*)&dev->tbusy) &&=0A=
		np->cur_tx - np->dirty_tx > 1  &&=0A=
		(jiffies - dev->trans_start) > TX_TIMEOUT) {=0A=
		tx_timeout(dev);=0A=
	}=0A=
*/=0A=
    check_duplex(dev);    =0A=
	np->timer.expires =3D jiffies + next_tick;=0A=
	add_timer(&np->timer);=0A=
}=0A=
=0A=
static void tx_timeout(struct net_device *dev)=0A=
{=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	long ioaddr =3D dev->base_addr;=0A=
=0A=
	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"=0A=
		   " resetting...\n", dev->name, (int)readl(ioaddr + TxRingPtr));=0A=
=0A=
#ifndef __alpha__=0A=
	if (debug > 3)=0A=
	{=0A=
		int i;=0A=
		printk(KERN_DEBUG "  Rx ring %8.8x: ", (int)np->rx_ring);=0A=
		for (i =3D 0; i < RX_RING_SIZE; i++)=0A=
			printk(" %8.8x", (unsigned int)np->rx_ring[i].cmd_status);=0A=
		printk("\n"KERN_DEBUG"  Tx ring %8.8x: ", (int)np->tx_ring);=0A=
		for (i =3D 0; i < TX_RING_SIZE; i++)=0A=
			printk(" %4.4x", np->tx_ring[i].cmd_status);=0A=
		printk("\n");=0A=
	}=0A=
#endif=0A=
=0A=
	/* Perhaps we should reinitialize the hardware here. */=0A=
	dev->if_port =3D 0;=0A=
	/* Stop and restart the chip's Tx processes . */=0A=
=0A=
	/* Trigger an immediate transmit demand. */=0A=
=0A=
	dev->trans_start =3D jiffies;=0A=
	np->stats.tx_errors++;=0A=
    netif_wake_queue(dev);=0A=
	return;=0A=
}=0A=
=0A=
/* Initialize the Rx and Tx rings, along with various 'dev' bits. */=0A=
static void init_ring(struct net_device *dev)=0A=
{=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	int i;=0A=
=0A=
	np->tx_full =3D 0;=0A=
	np->cur_rx =3D np->cur_tx =3D 0;=0A=
	np->dirty_rx =3D np->dirty_tx =3D 0;=0A=
=0A=
	np->rx_buf_sz =3D (dev->mtu <=3D 1500 ? PKT_BUF_SZ : dev->mtu + =
32);=0A=
	np->rx_head_desc =3D &np->rx_ring[0];=0A=
=0A=
	/* Initialize all Rx descriptors. */=0A=
	for (i =3D 0; i < RX_RING_SIZE; i++) {=0A=
		np->rx_ring[i].next_desc =3D virt_to_le32desc(&np->rx_ring[i+1]);=0A=
		np->rx_ring[i].cmd_status =3D DescOwn;=0A=
		np->rx_skbuff[i] =3D 0;=0A=
	}=0A=
	/* Mark the last entry as wrapping the ring. */=0A=
	np->rx_ring[i-1].next_desc =3D virt_to_le32desc(&np->rx_ring[0]);=0A=
=0A=
	/* Fill in the Rx buffers.  Handle allocation failure gracefully. =
*/=0A=
	for (i =3D 0; i < RX_RING_SIZE; i++) {=0A=
		struct sk_buff *skb =3D dev_alloc_skb(np->rx_buf_sz);=0A=
		np->rx_skbuff[i] =3D skb;=0A=
		if (skb =3D=3D NULL)=0A=
			break;=0A=
		skb->dev =3D dev;			/* Mark as being used by this device. */=0A=
		np->rx_ring[i].addr =3D virt_to_le32desc(skb->tail);=0A=
		np->rx_ring[i].cmd_status =3D=0A=
			cpu_to_le32(DescIntr | np->rx_buf_sz);=0A=
	}=0A=
	np->dirty_rx =3D (unsigned int)(i - RX_RING_SIZE);=0A=
=0A=
	for (i =3D 0; i < TX_RING_SIZE; i++) {=0A=
		np->tx_skbuff[i] =3D 0;=0A=
		np->tx_ring[i].next_desc =3D virt_to_le32desc(&np->tx_ring[i+1]);=0A=
		np->tx_ring[i].cmd_status =3D 0;=0A=
	}=0A=
	np->tx_ring[i-1].next_desc =3D virt_to_le32desc(&np->tx_ring[0]);=0A=
	return;=0A=
}=0A=
=0A=
static int start_tx(struct sk_buff *skb, struct net_device *dev)=0A=
{=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	unsigned entry;=0A=
=0A=
	/* Note: Ordering is important here, set the field with the=0A=
	   "ownership" bit last, and only then increment cur_tx. */=0A=
=0A=
	/* Calculate the next Tx descriptor entry. */=0A=
	entry =3D np->cur_tx % TX_RING_SIZE;=0A=
=0A=
	np->tx_skbuff[entry] =3D skb;=0A=
=0A=
	np->tx_ring[entry].addr =3D virt_to_le32desc(skb->data);=0A=
	np->tx_ring[entry].cmd_status =3D cpu_to_le32(DescOwn|DescIntr | =
skb->len);=0A=
	np->cur_tx++;=0A=
=0A=
	/* StrongARM: Explicitly cache flush np->tx_ring and =
skb->data,skb->len. */=0A=
=0A=
	if (np->cur_tx - np->dirty_tx >=3D TX_QUEUE_LEN - 1)=0A=
		np->tx_full =3D 1; //grs=0A=
 	else=0A=
		clear_bit(0, (void*)&dev->tbusy);=0A=
	/* Wake the potentially-idle transmit channel. */=0A=
	writel(TxOn, dev->base_addr + ChipCmd);=0A=
=0A=
	dev->trans_start =3D jiffies;=0A=
=0A=
	if (debug > 4) {=0A=
		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",=0A=
			   dev->name, np->cur_tx, entry);=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
/* The interrupt handler does all of the Rx thread work and cleans =
up=0A=
   after the Tx thread. */=0A=
static void intr_handler(int irq, void *dev_instance, struct pt_regs =
*rgs)=0A=
{=0A=
	struct net_device *dev =3D (struct net_device *)dev_instance;=0A=
	struct netdev_private *np;=0A=
	long ioaddr;=0A=
	int boguscnt =3D max_interrupt_work;=0A=
=0A=
#ifndef embeded_version			/* Can never occur. */=0A=
	if (dev =3D=3D NULL) {=0A=
#ifndef embeded_version=0A=
		printk (KERN_ERR "Netdev interrupt handler(): IRQ %d for unknown "=0A=
				"device.\n", irq);=0A=
#endif=0A=
		return;=0A=
	}=0A=
#endif=0A=
=0A=
	ioaddr =3D dev->base_addr;=0A=
	np =3D (struct netdev_private *)dev->priv;=0A=
#if defined(__i386__)=0A=
	/* A lock to prevent simultaneous entry bug on Intel SMP machines. =
*/=0A=
	if (test_and_set_bit(0, (void*)&dev->interrupt)) {=0A=
		printk(KERN_ERR"%s: SMP simultaneous entry of an interrupt =
handler.\n",=0A=
			   dev->name);=0A=
		dev->interrupt =3D 0;	/* Avoid halting machine. */=0A=
		return;=0A=
	}  =0A=
#else=0A=
	if (dev->interrupt) {=0A=
		printk(KERN_ERR "%s: Re-entering the interrupt handler.\n", =
dev->name);=0A=
		return;=0A=
	}=0A=
	dev->interrupt =3D 1;  =0A=
#endif=0A=
=0A=
	do {=0A=
		u32 intr_status =3D readl(ioaddr + IntrStatus);=0A=
=0A=
		/* Acknowledge all of the current interrupt sources ASAP. */=0A=
		writel(intr_status & 0x000ffff, ioaddr + IntrStatus);=0A=
=0A=
		if (debug > 4)=0A=
			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",=0A=
				   dev->name, intr_status);=0A=
=0A=
		if (intr_status =3D=3D 0)=0A=
			break;=0A=
=0A=
		if (intr_status & (IntrRxDone | IntrRxIntr))=0A=
			netdev_rx(dev);=0A=
=0A=
	    /* Abnormal error summary/uncommon events handlers. */=0A=
		if (intr_status & IntrAbnormalSummary)=0A=
			netdev_error(dev, intr_status);=0A=
            =0A=
		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {=0A=
			int entry =3D np->dirty_tx % TX_RING_SIZE;=0A=
			if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescOwn))=0A=
				break;=0A=
			if (np->tx_ring[entry].cmd_status & cpu_to_le32(0x08000000)) {=0A=
				np->stats.tx_packets++;=0A=
#if LINUX_VERSION_CODE > 0x20127=0A=
				np->stats.tx_bytes +=3D np->tx_skbuff[entry]->len;=0A=
#endif=0A=
			} else {            /* Various Tx errors */=0A=
 				int tx_status =3D le32_to_cpu(np->tx_ring[entry].cmd_status);=0A=
				if (tx_status & 0x04010000) np->stats.tx_aborted_errors++;=0A=
				if (tx_status & 0x02000000) np->stats.tx_fifo_errors++;=0A=
				if (tx_status & 0x01000000) np->stats.tx_carrier_errors++;=0A=
				if (tx_status & 0x00200000) np->stats.tx_window_errors++;=0A=
				np->stats.tx_errors++;=0A=
			}=0A=
			/* Free the original skb. */=0A=
			dev_free_skb(np->tx_skbuff[entry]);=0A=
			np->tx_skbuff[entry] =3D 0;=0A=
		}=0A=
		if (np->tx_full=0A=
			&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {=0A=
            /* The ring is no longer full, wake queue. */=0A=
			np->tx_full =3D 0;=0A=
			clear_bit(0, (void*)&dev->tbusy);=0A=
			netif_wake_queue(dev);=0A=
		}=0A=
=0A=
		if (--boguscnt < 0) {=0A=
			printk(KERN_WARNING "%s: Too much work at interrupt, "=0A=
				   "status=3D0x%4.4x.\n",=0A=
				   dev->name, intr_status);=0A=
			break;=0A=
		}=0A=
	} while (1);=0A=
=0A=
	if (debug > 3)=0A=
		printk(KERN_DEBUG "%s: exiting interrupt, status=3D%#4.4x.\n",=0A=
			   dev->name, (int)readl(ioaddr + IntrStatus));=0A=
=0A=
#if defined(__i386__)=0A=
	clear_bit(0, (void*)&dev->interrupt);=0A=
#else=0A=
	dev->interrupt =3D 0;=0A=
#endif=0A=
	return;=0A=
}=0A=
=0A=
/* This routine is logically part of the interrupt handler, but =
separated=0A=
   for clarity and better register allocation. */=0A=
static int netdev_rx(struct net_device *dev)=0A=
{=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	int entry =3D np->cur_rx % RX_RING_SIZE;=0A=
	int boguscnt =3D np->dirty_rx + RX_RING_SIZE - np->cur_rx;=0A=
	s32 desc_status =3D le32_to_cpu(np->rx_head_desc->cmd_status);=0A=
=0A=
	/* If the driver owns the next entry it's a new packet. Send it up. =
*/=0A=
	while (desc_status < 0) {        /* e.g. & DescOwn */=0A=
		if (debug > 4)=0A=
			printk(KERN_DEBUG "  In netdev_rx() entry %d status was =
%8.8x.\n",=0A=
				   entry, desc_status);=0A=
		if (--boguscnt < 0)=0A=
			break;=0A=
		if ((desc_status & (DescMore|DescPktOK|RxTooLong)) !=3D DescPktOK) =
{=0A=
			if (desc_status & DescMore) {=0A=
				printk(KERN_WARNING "%s: Oversized(?) Ethernet frame spanned "=0A=
					   "multiple buffers, entry %#x status %x.\n",=0A=
					   dev->name, np->cur_rx, desc_status);=0A=
				np->stats.rx_length_errors++;=0A=
			} else {=0A=
				/* There was a error. */=0A=
#ifndef embeded_version=0A=
				if (debug > 2)=0A=
					printk(KERN_DEBUG "  netdev_rx() Rx error was %8.8x.\n",=0A=
						   desc_status);=0A=
#endif=0A=
				np->stats.rx_errors++;=0A=
				if (desc_status & 0x06000000) np->stats.rx_over_errors++;=0A=
				if (desc_status & 0x00600000) np->stats.rx_length_errors++;=0A=
				if (desc_status & 0x00140000) np->stats.rx_frame_errors++;=0A=
				if (desc_status & 0x00080000) np->stats.rx_crc_errors++;=0A=
			}=0A=
		} else {=0A=
			struct sk_buff *skb;=0A=
			int pkt_len =3D (desc_status & 0x0fff) - 4; 	/* Omit CRC size. */=0A=
			/* Check if the packet is long enough to accept without copying=0A=
			   to a minimally-sized skbuff. */=0A=
			if (pkt_len < rx_copybreak=0A=
				&& (skb =3D dev_alloc_skb(pkt_len + 2)) !=3D NULL) {=0A=
				skb->dev =3D dev;=0A=
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */=0A=
#if HAS_IP_COPYSUM=0A=
				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);=0A=
				skb_put(skb, pkt_len);=0A=
#else=0A=
				memcpy(skb_put(skb, pkt_len), np->rx_skbuff[entry]->tail,=0A=
					   pkt_len);=0A=
#endif=0A=
			} else {=0A=
				char *temp =3D skb_put(skb =3D np->rx_skbuff[entry], pkt_len);=0A=
				np->rx_skbuff[entry] =3D NULL;=0A=
#ifndef embeded_version				/* Remove after testing. */=0A=
				if (le32desc_to_virt(np->rx_ring[entry].addr) !=3D temp)=0A=
					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "=0A=
						   "do not match in netdev_rx: %p vs. %p / %p.\n",=0A=
						   dev->name,=0A=
						   le32desc_to_virt(np->rx_ring[entry].addr),=0A=
						   skb->head, temp);=0A=
#endif=0A=
			}=0A=
#ifndef embeded_version				/* Remove after testing. */=0A=
			/* You will want this info for the initial debug. */=0A=
			if (debug > 5)=0A=
				printk(KERN_DEBUG "  Rx data %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:"=0A=
					   "%2.2x %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x %2.2x%2.2x "=0A=
					   "%d.%d.%d.%d.\n",=0A=
					   skb->data[0], skb->data[1], skb->data[2], skb->data[3],=0A=
					   skb->data[4], skb->data[5], skb->data[6], skb->data[7],=0A=
					   skb->data[8], skb->data[9], skb->data[10],=0A=
					   skb->data[11], skb->data[12], skb->data[13],=0A=
					   skb->data[14], skb->data[15], skb->data[16],=0A=
					   skb->data[17]);=0A=
#endif=0A=
			skb->protocol =3D eth_type_trans(skb, dev);=0A=
			/* W/ hardware checksum: skb->ip_summed =3D CHECKSUM_UNNECESSARY; =
*/=0A=
			netif_rx(skb);=0A=
			dev->last_rx =3D jiffies;=0A=
			np->stats.rx_packets++;=0A=
#if LINUX_VERSION_CODE > 0x20127=0A=
			np->stats.rx_bytes +=3D pkt_len;=0A=
#endif=0A=
		}=0A=
		entry =3D (++np->cur_rx) % RX_RING_SIZE;=0A=
		np->rx_head_desc =3D &np->rx_ring[entry];=0A=
		desc_status =3D le32_to_cpu(np->rx_head_desc->cmd_status);=0A=
	}=0A=
=0A=
	/* Refill the Rx ring buffers. */=0A=
	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {=0A=
		struct sk_buff *skb;=0A=
		entry =3D np->dirty_rx % RX_RING_SIZE;=0A=
		if (np->rx_skbuff[entry] =3D=3D NULL) {=0A=
			skb =3D dev_alloc_skb(np->rx_buf_sz);=0A=
			np->rx_skbuff[entry] =3D skb;=0A=
			if (skb =3D=3D NULL)=0A=
				break;				/* Better luck next round. */=0A=
			skb->dev =3D dev;			/* Mark as being used by this device. */=0A=
			np->rx_ring[entry].addr =3D virt_to_le32desc(skb->tail);=0A=
		}=0A=
		np->rx_ring[entry].cmd_status =3D=0A=
			cpu_to_le32(DescIntr | np->rx_buf_sz);=0A=
	}=0A=
=0A=
	/* Restart Rx engine if stopped. */=0A=
  	writel(RxOn, dev->base_addr + ChipCmd);=0A=
	return 0;=0A=
}=0A=
=0A=
static void netdev_error(struct net_device *dev, int intr_status)=0A=
{=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	long ioaddr =3D dev->base_addr;=0A=
=0A=
	if (intr_status & LinkChange) {=0A=
		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"=0A=
			   " %4.4x  partner %4.4x.\n", dev->name,=0A=
			   (int)readl(ioaddr + 0x90), (int)readl(ioaddr + 0x94));=0A=
		check_duplex(dev);=0A=
	}=0A=
	if (intr_status & StatsMax) {=0A=
		get_stats(dev);=0A=
	}=0A=
	if (intr_status & IntrTxUnderrun) {=0A=
		if ((np->tx_config & 0x3f) < 62)=0A=
			np->tx_config +=3D 2;=0A=
		writel(np->tx_config, ioaddr + TxConfig);=0A=
	}=0A=
	if (intr_status & WOLPkt) {=0A=
		int wol_status =3D readl(ioaddr + WOLCmd);=0A=
		printk(KERN_NOTICE "%s: Link wake-up event %8.8x",=0A=
			   dev->name, wol_status);=0A=
	}=0A=
	/*=0A=
	if ((intr_status & =
~(LinkChange|StatsMax|RxResetDone|TxResetDone|0xA7ff))=0A=
	*/=0A=
	if ((intr_status & =
~(LinkChange|StatsMax|RxResetDone|TxResetDone|0x83ff))=0A=
		&& debug)=0A=
		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",=0A=
			   dev->name, intr_status);=0A=
	/* Hmmmmm, it's not clear how to recover from PCI faults. */=0A=
	if (intr_status & IntrPCIErr) {=0A=
		np->stats.tx_fifo_errors++;=0A=
		np->stats.rx_fifo_errors++;=0A=
	}=0A=
}=0A=
=0A=
static struct net_device_stats *get_stats(struct net_device *dev)=0A=
{=0A=
	long ioaddr =3D dev->base_addr;=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
=0A=
	/* We should lock this segment of code for SMP eventually, although=0A=
	   the vulnerability window is very small and statistics are=0A=
	   non-critical. */=0A=
	/* The chip only need report frame silently dropped. */=0A=
	np->stats.rx_crc_errors	+=3D readl(ioaddr + RxCRCErrs);=0A=
	np->stats.rx_missed_errors	+=3D readl(ioaddr + RxMissed);=0A=
=0A=
	return &np->stats;=0A=
}=0A=
=0A=
/* The little-endian AUTODIN II ethernet CRC calculations.=0A=
   A big-endian version is also available.=0A=
   This is slow but compact code.  Do not use this routine for bulk =
data,=0A=
   use a table-based routine instead.=0A=
   This is common code and should be moved to net/core/crc.c.=0A=
   Chips may use the upper or lower CRC bits, and may reverse and/or =
invert=0A=
   them.  Select the endian-ness that results in minimal =
calculations.=0A=
*/=0A=
/*=0A=
 * This common polynomial calculation doesn't work for the 83815, =0A=
 * use the modified dp83815_crc routine below instead.=0A=
*/=0A=
#ifdef 0 =0A=
static unsigned const ethernet_polynomial_le =3D 0xedb88320U;=0A=
static inline unsigned ether_crc_le(int length, unsigned char *data)=0A=
{=0A=
	unsigned int crc =3D 0xffffffff;	/* Initial value. */=0A=
	while(--length >=3D 0) {=0A=
		unsigned char current_octet =3D *data++;=0A=
		int bit;=0A=
		for (bit =3D 8; --bit >=3D 0; current_octet >>=3D 1) {=0A=
		 	if ((crc ^ current_octet) & 1) {=0A=
			 	crc >>=3D 1;=0A=
				crc ^=3D ethernet_polynomial_le;=0A=
			} else=0A=
				crc >>=3D 1;=0A=
		}=0A=
	}=0A=
	return crc;=0A=
}=0A=
#endif=0A=
=0A=
#define DP_POLYNOMIAL			0x04C11DB7=0A=
/* dp83815_crc - computer CRC for hash table entries */=0A=
static int   dp83815_crc (char * mc_addr)=0A=
{=0A=
    u32 crc;=0A=
    u8 cur_byte;=0A=
    u8 msb;=0A=
    u8 byte, bit;=0A=
=0A=
    crc =3D ~0;=0A=
    for (byte=3D0; byte<6; byte++) {=0A=
        cur_byte =3D *mc_addr++;=0A=
        for (bit=3D0; bit<8; bit++) {=0A=
            msb =3D crc >> 31;=0A=
            crc <<=3D 1;=0A=
            if (msb ^ (cur_byte & 1)) {=0A=
                crc ^=3D DP_POLYNOMIAL;=0A=
                crc |=3D 1;=0A=
            }=0A=
            cur_byte >>=3D 1;=0A=
        }=0A=
    }=0A=
    crc >>=3D 23;=0A=
=0A=
    return (crc);=0A=
}=0A=
=0A=
=0A=
/* =0A=
  grs, changed multicast hashing since crc calc was incorrect and=0A=
  be_write was writing wrong bit.  now works on x86 machines.=0A=
*/=0A=
static void set_rx_mode(struct net_device *dev)=0A=
{=0A=
	long ioaddr =3D dev->base_addr;=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	u16 mc_filter[32];			/* Multicast hash filter */=0A=
	u32 rx_mode;=0A=
=0A=
	if (dev->flags & IFF_PROMISC) {		    /* Set promiscuous. */=0A=
		/* Unconditionally log net taps. */  =0A=
		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);=0A=
		rx_mode =3D AcceptBroadcast | AcceptAllMulticast | AcceptAllPhys=0A=
			| AcceptMyPhys;=0A=
	} else if ((dev->mc_count > multicast_filter_limit)=0A=
			   ||  (dev->flags & IFF_ALLMULTI)) {=0A=
		rx_mode =3D AcceptBroadcast | AcceptAllMulticast | AcceptMyPhys;=0A=
	} else {=0A=
		struct dev_mc_list *mclist;=0A=
		int i;=0A=
		memset(mc_filter, 0, sizeof(mc_filter));=0A=
		for (i =3D 0, mclist =3D dev->mc_list; mclist && i < =
dev->mc_count;=0A=
			 i++, mclist =3D mclist->next) {=0A=
			set_bit(dp83815_crc(mclist->dmi_addr) & 0x1ff, mc_filter);=0A=
		}=0A=
		rx_mode =3D AcceptBroadcast | AcceptMulticast | AcceptMyPhys;=0A=
		for (i =3D 0; i < 32; i++) {=0A=
			writew(0x200 + (i<<1), ioaddr + RxFilterAddr);=0A=
			writew(mc_filter[i], ioaddr + RxFilterData);=0A=
		}=0A=
	}=0A=
    =0A=
    /* =0A=
	   (grs) write 0 first to this register to "zero" enable bit, if it is =
set=0A=
	   per previous call to set_rx_mode=0A=
	*/=0A=
    writel(0, ioaddr +  RxFilterAddr);=0A=
    =0A=
	writel(rx_mode, ioaddr + RxFilterAddr);=0A=
	np->cur_rx_mode =3D rx_mode;=0A=
}=0A=
=0A=
static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int =
cmd)=0A=
{=0A=
	struct netdev_private *np =3D dev->priv;=0A=
	u16 *data =3D (u16 *)&rq->ifr_data;=0A=
=0A=
	switch(cmd) {=0A=
	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */=0A=
		data[0] =3D 1;=0A=
		/* Fall Through */=0A=
	case SIOCDEVPRIVATE+1:		/* Read the specified MII register. */=0A=
		data[3] =3D mdio_read(dev, data[0] & 0x1f, data[1] & 0x1f);=0A=
		return 0;=0A=
	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */=0A=
		if (!capable(CAP_NET_ADMIN))=0A=
			return -EPERM;=0A=
		if (data[0] =3D=3D 1) {=0A=
			u16 miireg =3D data[1] & 0x1f;=0A=
			u16 value =3D data[2];=0A=
			writew(value, dev->base_addr + 0x80 + (miireg << 2));=0A=
			switch (miireg) {=0A=
			case 0:=0A=
				/* Check for autonegotiation on or reset. */=0A=
				np->duplex_lock =3D (value & 0x9000) ? 0 : 1;=0A=
				if (np->duplex_lock)=0A=
					np->full_duplex =3D (value & 0x0100) ? 1 : 0;=0A=
				break;=0A=
			case 4: np->advertising =3D value; break;=0A=
			}=0A=
		}=0A=
		return 0;=0A=
	default:=0A=
		return -EOPNOTSUPP;=0A=
	}=0A=
}=0A=
=0A=
static int netdev_close(struct net_device *dev)=0A=
{=0A=
	long ioaddr =3D dev->base_addr;=0A=
	struct netdev_private *np =3D (struct netdev_private *)dev->priv;=0A=
	int i;=0A=
=0A=
    =0A=
	dev->start =3D 0;=0A=
	dev->tbusy =3D 1;=0A=
=0A=
#ifndef embeded_version=0A=
	if (debug > 1) {=0A=
		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x "=0A=
			   "Int %2.2x.\n",=0A=
			   dev->name, (int)readl(ioaddr + ChipCmd),=0A=
			   (int)readl(ioaddr + IntrStatus));=0A=
		printk(KERN_DEBUG "%s: Queue pointers were Tx %d / %d,  Rx %d / =
%d.\n",=0A=
			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, =
np->dirty_rx);=0A=
	}=0A=
#endif=0A=
=0A=
	/* Disable interrupts using the mask. */=0A=
	writel(0, ioaddr + IntrMask);=0A=
	writel(0, ioaddr + IntrEnable);=0A=
	writel(2, ioaddr + StatsCtrl); 					/* Freeze Stats */=0A=
=0A=
	/* Stop the chip's Tx and Rx processes. */=0A=
	writel(RxOff | TxOff, ioaddr + ChipCmd);=0A=
=0A=
	del_timer(&np->timer);=0A=
=0A=
#ifdef __i386__=0A=
#ifndef embeded_version=0A=
	if (debug > 4) {=0A=
		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",=0A=
			   (int)virt_to_bus(np->tx_ring));=0A=
		for (i =3D 0; i < TX_RING_SIZE; i++)=0A=
			printk(" #%d desc. %8.8x %8.8x.\n",=0A=
				   i, np->tx_ring[i].cmd_status, np->tx_ring[i].addr);=0A=
		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",=0A=
			   (int)virt_to_bus(np->rx_ring));=0A=
		for (i =3D 0; i < RX_RING_SIZE; i++) {=0A=
			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x\n",=0A=
				   i, np->rx_ring[i].cmd_status, np->rx_ring[i].addr);=0A=
		}=0A=
	}=0A=
#endif=0A=
#endif /* __i386__ debugging only */=0A=
=0A=
	free_irq(dev->irq, dev);=0A=
=0A=
	/* Free all the skbuffs in the Rx queue. */=0A=
	for (i =3D 0; i < RX_RING_SIZE; i++) {=0A=
		np->rx_ring[i].cmd_status =3D 0;=0A=
		np->rx_ring[i].addr =3D 0xBADF00D0; /* An invalid address. */=0A=
		if (np->rx_skbuff[i]) {=0A=
#if LINUX_VERSION_CODE < 0x20100=0A=
			np->rx_skbuff[i]->free =3D 1;=0A=
#endif=0A=
			dev_free_skb(np->rx_skbuff[i]);=0A=
		}=0A=
		np->rx_skbuff[i] =3D 0;=0A=
	}=0A=
	for (i =3D 0; i < TX_RING_SIZE; i++) {=0A=
		if (np->tx_skbuff[i])=0A=
			dev_free_skb(np->tx_skbuff[i]);=0A=
		np->tx_skbuff[i] =3D 0;=0A=
	}=0A=
=0A=
	/* Restore PME enable bit */=0A=
	writel(np->SavedClkRun, ioaddr + ClkRun);=0A=
=0A=
#if 0=0A=
	writel(0x0200, ioaddr + ChipConfig); /* Power down Xcvr. */=0A=
#endif=0A=
=0A=
	MOD_DEC_USE_COUNT;=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
=0C=0A=
#ifdef MODULE=0A=
int init_module(void)=0A=
{=0A=
	/* Emit version even if no cards detected. */=0A=
	printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);=0A=
  	return pci_drv_register(&natsemi_drv_id, NULL); =0A=
}=0A=
=0A=
void cleanup_module(void)=0A=
{=0A=
	struct net_device *next_dev;=0A=
=0A=
  	pci_drv_unregister(&natsemi_drv_id); =0A=
=0A=
	/* No need to check MOD_IN_USE, as sys_delete_module() checks. */=0A=
	while (root_net_dev) {=0A=
		struct netdev_private *np =3D (void *)(root_net_dev->priv);=0A=
		unregister_netdev(root_net_dev);=0A=
		iounmap((char *)root_net_dev->base_addr);=0A=
		next_dev =3D np->next_module;=0A=
		if (np->priv_addr)=0A=
			kfree(np->priv_addr);=0A=
		kfree(root_net_dev);=0A=
		root_net_dev =3D next_dev;=0A=
	} =0A=
}=0A=
=0A=
#endif  /* MODULE */=0A=
=0A=
/*=0A=
 * Local variables:=0A=
 *  compile-command: "gcc -DMODULE -Wall -Wstrict-prototypes -O6 -c =
natsemi.c"=0A=
 *  simple-compile-command: "gcc -DMODULE -O6 -c natsemi.c"=0A=
 *  c-indent-level: 4=0A=
 *  c-basic-offset: 4=0A=
 *  tab-width: 4=0A=
 * End:=0A=
 */=0A=

------_=_NextPart_000_01C0C848.F2CAEA37--
