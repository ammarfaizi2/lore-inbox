Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSJYLxR>; Fri, 25 Oct 2002 07:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSJYLxR>; Fri, 25 Oct 2002 07:53:17 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:47784 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261368AbSJYLxC>; Fri, 25 Oct 2002 07:53:02 -0400
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com
Subject: [PATCH] Updated znet driver for 2.5
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 25 Oct 2002 13:58:53 +0200
Message-ID: <wrp3cquu3uq.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi all,

I do not think a lot of people might care about this one, but since I
now have an "almost new" Zenith Z-Note (486@33, 16MB RAM... feel the
power, baby ;-), I felt the urge to get the znet driver out of the
CONFIG_OBSOLETE bit bucket, and bring it to the wonderfull world of
Linux-2.5.

So here is the change-log :

- Removed strange DMA snooping in znet_sent_packet, which lead to
  TX buffer corruption on my laptop.
- Use init_etherdev stuff.
- Use kmalloc-ed DMA buffers.
- Use as few global variables as possible.
- Use proper resources management.
- Use wireless/i82593.h as much as possible (structure, constants)
- Compiles as module or build-in.

Almost nothing have changed from the original driver. I just managed
to have the driver behave, which was enough to make a whole Debian
network install.

I certainly introduced a whole lot of bugs, so blame me, not
Donald. I'd be happy to get any sucess/bug report from
Z-Note/Thinkpad-300 users (though I won't hold my breath ;-).

I'd also appreciate any comment about what to change in this driver to
let it make it in 2.5.

        M.


--=-=-=
Content-Disposition: attachment; filename=znet.diff
Content-Description: znet patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.809   -> 1.810  
#	  drivers/net/znet.c	1.5     -> 1.6    
#	 drivers/net/Space.c	1.11    -> 1.12   
#	drivers/net/Config.in	1.51    -> 1.52   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/25	maz@hina.wild-wind.fr.eu.org	1.810
# o Resurected for Linux 2.5+ by Marc Zyngier <maz@wild-wind.fr.eu.org>
#   - Removed strange DMA snooping in znet_sent_packet, which lead to
#     TX buffer corruption on my laptop.
#   - Use init_etherdev stuff.
#   - Use kmalloc-ed DMA buffers.
#   - Use as few global variables as possible.
#   - Use proper resources management.
#   - Use wireless/i82593.h as much as possible (structure, constants)
#   - Compiles as module or build-in.
# --------------------------------------------
#
diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
--- a/drivers/net/Config.in	Fri Oct 25 12:31:25 2002
+++ b/drivers/net/Config.in	Fri Oct 25 12:31:25 2002
@@ -134,6 +134,7 @@
       tristate '    LP486E on board Ethernet' CONFIG_LP486E
       tristate '    ICL EtherTeam 16i/32 support' CONFIG_ETH16I
       tristate '    NE2000/NE1000 support' CONFIG_NE2000
+      dep_tristate '    Zenith Z-Note support (EXPERIMENTAL)' CONFIG_ZNET $CONFIG_EXPERIMENTAL
       if [ "$CONFIG_OBSOLETE" = "y" ]; then
 	 dep_tristate '    SEEQ8005 support (EXPERIMENTAL)' CONFIG_SEEQ8005 $CONFIG_EXPERIMENTAL
       fi
@@ -186,9 +187,6 @@
       fi
       dep_tristate '    VIA Rhine support' CONFIG_VIA_RHINE $CONFIG_PCI
       dep_mbool '      Use MMIO instead of PIO (EXPERIMENTAL)' CONFIG_VIA_RHINE_MMIO $CONFIG_VIA_RHINE $CONFIG_EXPERIMENTAL
-      if [ "$CONFIG_OBSOLETE" = "y" ]; then
-	 dep_bool '    Zenith Z-Note support (OBSOLETE)' CONFIG_ZNET $CONFIG_ISA
-      fi
       if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_MIPS" = "y" ]; then
 	 bool '    Philips SAA9730 Ethernet support (EXPERIMENTAL)' CONFIG_LAN_SAA9730
       fi
diff -Nru a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c	Fri Oct 25 12:31:25 2002
+++ b/drivers/net/Space.c	Fri Oct 25 12:31:25 2002
@@ -54,7 +54,6 @@
 extern int ne_probe(struct net_device *dev);
 extern int hp_probe(struct net_device *dev);
 extern int hp_plus_probe(struct net_device *dev);
-extern int znet_probe(struct net_device *);
 extern int express_probe(struct net_device *);
 extern int eepro_probe(struct net_device *);
 extern int el3_probe(struct net_device *);
@@ -269,9 +268,6 @@
 #endif
 #ifdef CONFIG_ETH16I
 	{eth16i_probe, 0},	/* ICL EtherTeam 16i/32 */
-#endif
-#ifdef CONFIG_ZNET		/* Zenith Z-Note and some IBM Thinkpads. */
-	{znet_probe, 0},
 #endif
 #ifdef CONFIG_EEXPRESS		/* Intel EtherExpress */
 	{express_probe, 0},
diff -Nru a/drivers/net/znet.c b/drivers/net/znet.c
--- a/drivers/net/znet.c	Fri Oct 25 12:31:25 2002
+++ b/drivers/net/znet.c	Fri Oct 25 12:31:25 2002
@@ -1,7 +1,5 @@
 /* znet.c: An Zenith Z-Note ethernet driver for linux. */
 
-static const char version[] = "znet.c:v1.02 9/23/94 becker@cesdis.gsfc.nasa.gov\n";
-
 /*
 	Written by Donald Becker.
 
@@ -62,6 +60,30 @@
 	functionality from the serial subsystem.
  */
 
+/* 10/2002
+
+   o Resurected for Linux 2.5+ by Marc Zyngier <maz@wild-wind.fr.eu.org> :
+
+   - Removed strange DMA snooping in znet_sent_packet, which lead to
+     TX buffer corruption on my laptop.
+   - Use init_etherdev stuff.
+   - Use kmalloc-ed DMA buffers.
+   - Use as few global variables as possible.
+   - Use proper resources management.
+   - Use wireless/i82593.h as much as possible (structure, constants)
+   - Compiles as module or build-in.
+
+   Tested on a vintage Zenith Z-Note 433Lnp+. Probably broken on
+   anything else. Testers (and detailed bug reports) are welcome :-).
+
+   o TODO :
+
+   - Properly handle multicast
+   - Understand why some traffic patterns add a 1s latency...
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
@@ -69,6 +91,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -79,52 +102,35 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 
+/* This include could be elsewhere, since it is not wireless specific */
+#include "wireless/i82593.h"
+
+static const char version[] __initdata = "znet.c:v1.02 9/23/94 becker@cesdis.gsfc.nasa.gov\n";
+
 #ifndef ZNET_DEBUG
 #define ZNET_DEBUG 1
 #endif
 static unsigned int znet_debug = ZNET_DEBUG;
+MODULE_PARM (znet_debug, "i");
+MODULE_PARM_DESC (znet_debug, "ZNet debug level");
+MODULE_LICENSE("GPL");
 
 /* The DMA modes we need aren't in <dma.h>. */
 #define DMA_RX_MODE		0x14	/* Auto init, I/O to mem, ++, demand. */
 #define DMA_TX_MODE		0x18	/* Auto init, Mem to I/O, ++, demand. */
 #define dma_page_eq(ptr1, ptr2) ((long)(ptr1)>>17 == (long)(ptr2)>>17)
-#define DMA_BUF_SIZE 8192
 #define RX_BUF_SIZE 8192
 #define TX_BUF_SIZE 8192
-
-/* Commands to the i82593 channel 0. */
-#define CMD0_CHNL_0			0x00
-#define CMD0_CHNL_1			0x10		/* Switch to channel 1. */
-#define CMD0_NOP (CMD0_CHNL_0)
-#define CMD0_PORT_1	CMD0_CHNL_1
-#define CMD1_PORT_0	1
-#define CMD0_IA_SETUP		1
-#define CMD0_CONFIGURE		2
-#define CMD0_MULTICAST_LIST 3
-#define CMD0_TRANSMIT		4
-#define CMD0_DUMP			6
-#define CMD0_DIAGNOSE		7
-#define CMD0_Rx_ENABLE		8
-#define CMD0_Rx_DISABLE		10
-#define CMD0_Rx_STOP		11
-#define CMD0_RETRANSMIT		12
-#define CMD0_ABORT			13
-#define CMD0_RESET			14
-
-#define CMD0_ACK 0x80
-
-#define CMD0_STAT0 (0 << 5)
-#define CMD0_STAT1 (1 << 5)
-#define CMD0_STAT2 (2 << 5)
-#define CMD0_STAT3 (3 << 5)
+#define DMA_BUF_SIZE (RX_BUF_SIZE + 16)	/* 8k + 16 bytes for trailers */
 
 #define TX_TIMEOUT	10
 
-#define net_local znet_private
 struct znet_private {
 	int rx_dma, tx_dma;
 	struct net_device_stats stats;
 	spinlock_t lock;
+	short sia_base, sia_size, io_size;
+	struct i82593_conf_block i593_init;
 	/* The starting, current, and end pointers for the packet buffers. */
 	ushort *rx_start, *rx_cur, *rx_end;
 	ushort *tx_start, *tx_cur, *tx_end;
@@ -132,40 +138,7 @@
 };
 
 /* Only one can be built-in;-> */
-static struct znet_private zn;
-static ushort dma_buffer1[DMA_BUF_SIZE/2];
-static ushort dma_buffer2[DMA_BUF_SIZE/2];
-static ushort dma_buffer3[DMA_BUF_SIZE/2 + 8];
-
-/* The configuration block.  What an undocumented nightmare.  The first
-   set of values are those suggested (without explanation) for ethernet
-   in the Intel 82586 databook.	 The rest appear to be completely undocumented,
-   except for cryptic notes in the Crynwr packet driver.  This driver uses
-   the Crynwr values verbatim. */
-
-static unsigned char i593_init[] = {
-  0xAA,					/* 0: 16-byte input & 80-byte output FIFO. */
-						/*	  threshold, 96-byte FIFO, 82593 mode. */
-  0x88,					/* 1: Continuous w/interrupts, 128-clock DMA.*/
-  0x2E,					/* 2: 8-byte preamble, NO address insertion, */
-						/*	  6-byte Ethernet address, loopback off.*/
-  0x00,					/* 3: Default priorities & backoff methods. */
-  0x60,					/* 4: 96-bit interframe spacing. */
-  0x00,					/* 5: 512-bit slot time (low-order). */
-  0xF2,					/* 6: Slot time (high-order), 15 COLL retries. */
-  0x00,					/* 7: Promisc-off, broadcast-on, default CRC. */
-  0x00,					/* 8: Default carrier-sense, collision-detect. */
-  0x40,					/* 9: 64-byte minimum frame length. */
-  0x5F,					/* A: Type/length checks OFF, no CRC input,
-						   "jabber" termination, etc. */
-  0x00,					/* B: Full-duplex disabled. */
-  0x3F,					/* C: Default multicast addresses & backoff. */
-  0x07,					/* D: Default IFS retriggering. */
-  0x31,					/* E: Internal retransmit, drop "runt" packets,
-						   synchr. DRQ deassertion, 6 status bytes. */
-  0x22,					/* F: Receive ring-buffer size (8K), 
-						   receive-stop register enable. */
-};
+static struct net_device *znet_dev;
 
 struct netidblk {
 	char magic[8];		/* The magic number (string) "NETIDBLK" */
@@ -182,33 +155,225 @@
 	char pad;
 };
 
-int znet_probe(struct net_device *dev);
 static int	znet_open(struct net_device *dev);
 static int	znet_send_packet(struct sk_buff *skb, struct net_device *dev);
 static void	znet_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void	znet_rx(struct net_device *dev);
 static int	znet_close(struct net_device *dev);
 static struct net_device_stats *net_get_stats(struct net_device *dev);
-static void set_multicast_list(struct net_device *dev);
 static void hardware_init(struct net_device *dev);
 static void update_stop_hit(short ioaddr, unsigned short rx_stop_offset);
 static void znet_tx_timeout (struct net_device *dev);
 
-#ifdef notdef
-static struct sigaction znet_sigaction = { &znet_interrupt, 0, 0, NULL, };
-#endif
+/* Request needed resources */
+static int znet_request_resources (struct net_device *dev)
+{
+	struct znet_private *znet = dev->priv;
+	unsigned long flags;
+		
+	if (request_irq (dev->irq, &znet_interrupt, 0, "ZNet", dev))
+		goto failed;
+	if (request_dma (znet->rx_dma, "ZNet rx"))
+		goto free_irq;
+	if (request_dma (znet->tx_dma, "ZNet tx"))
+		goto free_rx_dma;
+	if (!request_region (znet->sia_base, znet->sia_size, "ZNet SIA"))
+		goto free_tx_dma;
+	if (!request_region (dev->base_addr, znet->io_size, "ZNet I/O"))
+		goto free_sia;
+
+	return 0;				/* Happy ! */
+
+ free_sia:
+	release_region (znet->sia_base, znet->sia_size);
+ free_tx_dma:
+	flags = claim_dma_lock();
+	free_dma (znet->tx_dma);
+	release_dma_lock (flags);
+ free_rx_dma:
+	flags = claim_dma_lock();
+	free_dma (znet->rx_dma);
+	release_dma_lock (flags);
+ free_irq:
+	free_irq (dev->irq, dev);
+ failed:
+	return -1;
+}
+
+static void znet_release_resources (struct net_device *dev)
+{
+	struct znet_private *znet = dev->priv;
+	unsigned long flags;
+		
+	release_region (znet->sia_base, znet->sia_size);
+	release_region (dev->base_addr, znet->io_size);
+	flags = claim_dma_lock();
+	free_dma (znet->tx_dma);
+	free_dma (znet->rx_dma);
+	release_dma_lock (flags);
+	free_irq (dev->irq, dev);
+}
+
+/* Keep the magical SIA stuff in a single function... */
+static void znet_transceiver_power (struct net_device *dev, int on)
+{
+	struct znet_private *znet = dev->priv;
+	unsigned char v;
+
+	/* Turn on/off the 82501 SIA, using zenith-specific magic. */
+	/* Select LAN control register */
+	outb(0x10, znet->sia_base);
 
+	if (on)
+		v = inb(znet->sia_base + 1) | 0x84;
+	else
+		v = inb(znet->sia_base + 1) & ~0x84;
+		
+	outb(v, znet->sia_base+1); /* Turn on/off LAN power (bit 2). */
+}
+
+/* Init the i82593, with current promisc/mcast configuration.
+   Also used from hardware_init. */
+static void znet_set_multicast_list (struct net_device *dev)
+{
+	struct znet_private *znet = dev->priv;
+	short ioaddr = dev->base_addr;
+	struct i82593_conf_block *cfblk = &znet->i593_init;
+
+	memset(cfblk, 0x00, sizeof(struct i82593_conf_block));
+	
+        /* The configuration block.  What an undocumented nightmare.
+	   The first set of values are those suggested (without explanation)
+	   for ethernet in the Intel 82586 databook.  The rest appear to be
+	   completely undocumented, except for cryptic notes in the Crynwr
+	   packet driver.  This driver uses the Crynwr values verbatim. */
+
+	/* maz : Rewritten to take advantage of the wanvelan includes.
+	   At least we have names, not just blind values */
+	
+	/* Byte 0 */
+	cfblk->fifo_limit = 10;	/* = 16 B rx and 80 B tx fifo thresholds */
+	cfblk->forgnesi = 0;	/* 0=82C501, 1=AMD7992B compatibility */
+	cfblk->fifo_32 = 1;
+	cfblk->d6mod = 0;  	/* Run in i82593 advanced mode */
+	cfblk->throttle_enb = 1;
+
+	/* Byte 1 */
+	cfblk->throttle = 8;	/* Continuous w/interrupts, 128-clock DMA. */
+	cfblk->cntrxint = 0;	/* enable continuous mode receive interrupts */
+	cfblk->contin = 1;	/* enable continuous mode */
+
+	/* Byte 2 */
+	cfblk->addr_len = ETH_ALEN;
+	cfblk->acloc = 1;	/* Disable source addr insertion by i82593 */
+	cfblk->preamb_len = 2;	/* 8 bytes preamble */
+	cfblk->loopback = 0;	/* Loopback off */
+  
+	/* Byte 3 */
+	cfblk->lin_prio = 0;	/* Default priorities & backoff methods. */
+	cfblk->tbofstop = 0;
+	cfblk->exp_prio = 0;
+	cfblk->bof_met = 0;
+  
+	/* Byte 4 */
+	cfblk->ifrm_spc = 6;	/* 96 bit times interframe spacing */
+	
+	/* Byte 5 */
+	cfblk->slottim_low = 0; /* 512 bit times slot time (low) */
+	
+	/* Byte 6 */
+	cfblk->slottim_hi = 2;	/* 512 bit times slot time (high) */
+	cfblk->max_retr = 15;	/* 15 collisions retries */
+	
+	/* Byte 7 */
+	cfblk->prmisc = ((dev->flags & IFF_PROMISC) ? 1 : 0); /* Promiscuous mode */
+	cfblk->bc_dis = 0;	/* Enable broadcast reception */
+	cfblk->crs_1 = 0;	/* Don't transmit without carrier sense */
+	cfblk->nocrc_ins = 0;	/* i82593 generates CRC */
+	cfblk->crc_1632 = 0;	/* 32-bit Autodin-II CRC */
+	cfblk->crs_cdt = 0;	/* CD not to be interpreted as CS */
+	
+	/* Byte 8 */
+	cfblk->cs_filter = 0;  	/* CS is recognized immediately */
+	cfblk->crs_src = 0;	/* External carrier sense */
+	cfblk->cd_filter = 0;  	/* CD is recognized immediately */
+	
+	/* Byte 9 */
+	cfblk->min_fr_len = 64 >> 2; /* Minimum frame length 64 bytes */
+	
+	/* Byte A */
+	cfblk->lng_typ = 1;	/* Type/length checks OFF */
+	cfblk->lng_fld = 1; 	/* Disable 802.3 length field check */
+	cfblk->rxcrc_xf = 1;	/* Don't transfer CRC to memory */
+	cfblk->artx = 1;	/* Disable automatic retransmission */
+	cfblk->sarec = 1;	/* Disable source addr trig of CD */
+	cfblk->tx_jabber = 0;	/* Disable jabber jam sequence */
+	cfblk->hash_1 = 1; 	/* Use bits 0-5 in mc address hash */
+	cfblk->lbpkpol = 0; 	/* Loopback pin active high */
+	
+	/* Byte B */
+	cfblk->fdx = 0;		/* Disable full duplex operation */
+	
+	/* Byte C */
+	cfblk->dummy_6 = 0x3f; 	/* all ones, Default multicast addresses & backoff. */
+	cfblk->mult_ia = 0;	/* No multiple individual addresses */
+	cfblk->dis_bof = 0;	/* Disable the backoff algorithm ?! */
+	
+	/* Byte D */
+	cfblk->dummy_1 = 1; 	/* set to 1 */
+	cfblk->tx_ifs_retrig = 3; /* Hmm... Disabled */
+	cfblk->mc_all = (dev->mc_list || (dev->flags&IFF_ALLMULTI));/* multicast all mode */
+	cfblk->rcv_mon = 0;	/* Monitor mode disabled */
+	cfblk->frag_acpt = 0;	/* Do not accept fragments */
+	cfblk->tstrttrs = 0;	/* No start transmission threshold */
+	
+	/* Byte E */
+	cfblk->fretx = 1;	/* FIFO automatic retransmission */
+	cfblk->runt_eop = 0;	/* drop "runt" packets */
+	cfblk->hw_sw_pin = 0;	/* ?? */
+	cfblk->big_endn = 0;	/* Big Endian ? no... */
+	cfblk->syncrqs = 1;	/* Synchronous DRQ deassertion... */
+	cfblk->sttlen = 1;  	/* 6 byte status registers */
+	cfblk->rx_eop = 0;  	/* Signal EOP on packet reception */
+	cfblk->tx_eop = 0;  	/* Signal EOP on packet transmission */
+
+	/* Byte F */
+	cfblk->rbuf_size = RX_BUF_SIZE >> 12; /* Set receive buffer size */
+	cfblk->rcvstop = 1; 	/* Enable Receive Stop Register */
+
+	if (znet_debug > 2) {
+		int i;
+		unsigned char *c;
+
+		for (i = 0, c = (char *) cfblk; i < sizeof (*cfblk); i++)
+			printk ("%02X ", c[i]);
+		printk ("\n");
+	}
+	
+	*znet->tx_cur++ = sizeof(struct i82593_conf_block);
+	memcpy(znet->tx_cur, cfblk, sizeof(struct i82593_conf_block));
+	znet->tx_cur += sizeof(struct i82593_conf_block)/2;
+	outb(OP0_CONFIGURE | CR0_CHNL, ioaddr);
+
+	/* XXX FIXME maz : Add multicast adresses here, so having a
+	 * multicast address configured isn't equal to IFF_ALLMULTI */
+}
 
 /* The Z-Note probe is pretty easy.  The NETIDBLK exists in the safe-to-probe
    BIOS area.  We just scan for the signature, and pull the vital parameters
    out of the structure. */
 
-int __init znet_probe(struct net_device *dev)
+static int __init znet_probe (void)
 {
 	int i;
 	struct netidblk *netinfo;
+	struct znet_private *znet;
+	struct net_device *dev;
 	char *p;
 
+	if (znet_dev)				/* Only look for a single adaptor */
+		return -ENODEV;
+	
 	/* This code scans the region 0xf0000 to 0xfffff for a "NETIDBLK". */
 	for(p = (char *)phys_to_virt(0xf0000); p < (char *)phys_to_virt(0x100000); p++)
 		if (*p == 'N'  &&  strncmp(p, "NETIDBLK", 8) == 0)
@@ -219,6 +384,13 @@
 			printk(KERN_INFO "No Z-Note ethernet adaptor found.\n");
 		return -ENODEV;
 	}
+
+	if (!(znet_dev = dev = init_etherdev(0, sizeof(struct znet_private))))
+			return -ENOMEM;
+
+	znet = dev->priv;
+
+	SET_MODULE_OWNER (dev);
 	netinfo = (struct netidblk *)p;
 	dev->base_addr = netinfo->iobase1;
 	dev->irq = netinfo->irq1;
@@ -230,62 +402,67 @@
 		printk(" %2.2x", dev->dev_addr[i] = netinfo->netid[i]);
 
 	printk(", using IRQ %d DMA %d and %d.\n", dev->irq, netinfo->dma1,
-		netinfo->dma2);
+	       netinfo->dma2);
 
 	if (znet_debug > 1) {
 		printk(KERN_INFO "%s: vendor '%16.16s' IRQ1 %d IRQ2 %d DMA1 %d DMA2 %d.\n",
-			   dev->name, netinfo->vendor,
-			   netinfo->irq1, netinfo->irq2,
-			   netinfo->dma1, netinfo->dma2);
+		       dev->name, netinfo->vendor,
+		       netinfo->irq1, netinfo->irq2,
+		       netinfo->dma1, netinfo->dma2);
 		printk(KERN_INFO "%s: iobase1 %#x size %d iobase2 %#x size %d net type %2.2x.\n",
-			   dev->name, netinfo->iobase1, netinfo->iosize1,
-			   netinfo->iobase2, netinfo->iosize2, netinfo->nettype);
+		       dev->name, netinfo->iobase1, netinfo->iosize1,
+		       netinfo->iobase2, netinfo->iosize2, netinfo->nettype);
 	}
 
 	if (znet_debug > 0)
-		printk("%s%s", KERN_INFO, version);
+		printk(KERN_INFO "%s", version);
 
-	dev->priv = (void *) &zn;
-	zn.rx_dma = netinfo->dma1;
-	zn.tx_dma = netinfo->dma2;
-	zn.lock = SPIN_LOCK_UNLOCKED;
-
-	/* These should never fail.  You can't add devices to a sealed box! */
-	if (request_irq(dev->irq, &znet_interrupt, 0, "ZNet", dev)
-		|| request_dma(zn.rx_dma,"ZNet rx")
-		|| request_dma(zn.tx_dma,"ZNet tx")) {
-		printk(KERN_WARNING "%s: Not opened -- resource busy?!?\n", dev->name);
-		return -EBUSY;
+	znet->rx_dma = netinfo->dma1;
+	znet->tx_dma = netinfo->dma2;
+	znet->lock = SPIN_LOCK_UNLOCKED;
+	znet->sia_base = 0xe6;	/* Magic address for the 82501 SIA */
+	znet->sia_size = 2;
+	/* maz: Despite the '593 being advertised above as using a
+	 * single 8bits I/O port, this driver does many 16bits
+	 * access. So set io_size accordingly */
+	znet->io_size  = 2;
+
+	if (!(znet->rx_start = kmalloc (DMA_BUF_SIZE, GFP_KERNEL | GFP_DMA)))
+		goto free_netdev;
+	if (!(znet->tx_start = kmalloc (DMA_BUF_SIZE, GFP_KERNEL | GFP_DMA)))
+		goto free_rx;
+
+	if (!dma_page_eq (znet->rx_start, znet->rx_start + (RX_BUF_SIZE/2-1)) ||
+	    !dma_page_eq (znet->tx_start, znet->tx_start + (TX_BUF_SIZE/2-1))) {
+		printk (KERN_WARNING "tx/rx crossing DMA frontiers, giving up\n");
+		goto free_tx;
 	}
-
-	/* Allocate buffer memory.	We can cross a 128K boundary, so we
-	   must be careful about the allocation.  It's easiest to waste 8K. */
-	if (dma_page_eq(dma_buffer1, &dma_buffer1[RX_BUF_SIZE/2-1]))
-	  zn.rx_start = dma_buffer1;
-	else 
-	  zn.rx_start = dma_buffer2;
-
-	if (dma_page_eq(dma_buffer3, &dma_buffer3[RX_BUF_SIZE/2-1]))
-	  zn.tx_start = dma_buffer3;
-	else
-	  zn.tx_start = dma_buffer2;
-	zn.rx_end = zn.rx_start + RX_BUF_SIZE/2;
-	zn.tx_buf_len = TX_BUF_SIZE/2;
-	zn.tx_end = zn.tx_start + zn.tx_buf_len;
+	
+	znet->rx_end = znet->rx_start + RX_BUF_SIZE/2;
+	znet->tx_buf_len = TX_BUF_SIZE/2;
+	znet->tx_end = znet->tx_start + znet->tx_buf_len;
 
 	/* The ZNET-specific entries in the device structure. */
 	dev->open = &znet_open;
 	dev->hard_start_xmit = &znet_send_packet;
 	dev->stop = &znet_close;
 	dev->get_stats	= net_get_stats;
-	dev->set_multicast_list = &set_multicast_list;
+	dev->set_multicast_list = &znet_set_multicast_list;
 	dev->tx_timeout = znet_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 
-	/* Fill in the 'dev' with ethernet-generic values. */
-	ether_setup(dev);
-
 	return 0;
+
+ free_tx:
+	kfree (znet->tx_start);
+ free_rx:
+	kfree (znet->rx_start);
+ free_netdev:
+	unregister_netdev (dev);
+	kfree (dev);
+	znet_dev = NULL;
+
+	return -ENOMEM;
 }
 
 
@@ -296,9 +473,14 @@
 	if (znet_debug > 2)
 		printk(KERN_DEBUG "%s: znet_open() called.\n", dev->name);
 
-	/* Turn on the 82501 SIA, using zenith-specific magic. */
-	outb(0x10, 0xe6);					/* Select LAN control register */
-	outb(inb(0xe7) | 0x84, 0xe7);		/* Turn on LAN power (bit 2). */
+	/* These should never fail.  You can't add devices to a sealed box! */
+	if (znet_request_resources (dev)) {
+		printk(KERN_WARNING "%s: Not opened -- resource busy?!?\n", dev->name);
+		return -EBUSY;
+	}
+
+	znet_transceiver_power (dev, 1);
+	
 	/* According to the Crynwr driver we should wait 50 msec. for the
 	   LAN clock to stabilize.  My experiments indicates that the '593 can
 	   be initialized immediately.  The delay is probably needed for the
@@ -307,10 +489,17 @@
 	   Until this proves to be a problem we rely on the higher layers for the
 	   delay and save allocating a timer entry. */
 
+	/* maz : Well, I'm getting every time the following message
+	 * without the delay on a 486@33. This machine is much too
+	 * fast... :-) So maybe the Crynwr driver wasn't wrong after
+	 * all, even if the message is completly harmless on my
+	 * setup. */
+	mdelay (50);
+	
 	/* This follows the packet driver's lead, and checks for success. */
 	if (inb(ioaddr) != 0x10 && inb(ioaddr) != 0x00)
 		printk(KERN_WARNING "%s: Problem turning on the transceiver power.\n",
-			   dev->name);
+		       dev->name);
 
 	hardware_init(dev);
 	netif_start_queue (dev);
@@ -324,20 +513,20 @@
 	int ioaddr = dev->base_addr;
 	ushort event, tx_status, rx_offset, state;
 
-	outb (CMD0_STAT0, ioaddr);
+	outb (CR0_STATUS_0, ioaddr);
 	event = inb (ioaddr);
-	outb (CMD0_STAT1, ioaddr);
+	outb (CR0_STATUS_1, ioaddr);
 	tx_status = inw (ioaddr);
-	outb (CMD0_STAT2, ioaddr);
+	outb (CR0_STATUS_2, ioaddr);
 	rx_offset = inw (ioaddr);
-	outb (CMD0_STAT3, ioaddr);
+	outb (CR0_STATUS_3, ioaddr);
 	state = inb (ioaddr);
 	printk (KERN_WARNING "%s: transmit timed out, status %02x %04x %04x %02x,"
 	 " resetting.\n", dev->name, event, tx_status, rx_offset, state);
-	if (tx_status == 0x0400)
+	if (tx_status == TX_LOST_CRS)
 		printk (KERN_WARNING "%s: Tx carrier error, check transceiver cable.\n",
 			dev->name);
-	outb (CMD0_RESET, ioaddr);
+	outb (OP0_RESET, ioaddr);
 	hardware_init (dev);
 	netif_wake_queue (dev);
 }
@@ -345,7 +534,7 @@
 static int znet_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
-	struct net_local *lp = (struct net_local *)dev->priv;
+	struct znet_private *znet = dev->priv;
 	unsigned long flags;
 
 	if (znet_debug > 4)
@@ -354,7 +543,7 @@
 	netif_stop_queue (dev);
 	
 	/* Check that the part hasn't reset itself, probably from suspend. */
-	outb(CMD0_STAT0, ioaddr);
+	outb(CR0_STATUS_0, ioaddr);
 	if (inw(ioaddr) == 0x0010
 		&& inw(ioaddr) == 0x0000
 		&& inw(ioaddr) == 0x0010)
@@ -363,44 +552,33 @@
 	if (1) {
 		short length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
 		unsigned char *buf = (void *)skb->data;
-		ushort *tx_link = zn.tx_cur - 1;
+		ushort *tx_link = znet->tx_cur - 1;
 		ushort rnd_len = (length + 1)>>1;
 		
-		lp->stats.tx_bytes+=length;
-
-		{
-			short dma_port = ((zn.tx_dma&3)<<2) + IO_DMA2_BASE;
-			unsigned addr = inb(dma_port);
-			addr |= inb(dma_port) << 8;
-			addr <<= 1;
-			if (((int)zn.tx_cur & 0x1ffff) != addr)
-			  printk(KERN_WARNING "Address mismatch at Tx: %#x vs %#x.\n",
-					 (int)zn.tx_cur & 0xffff, addr);
-			zn.tx_cur = (ushort *)(((int)zn.tx_cur & 0xfe0000) | addr);
-		}
+		znet->stats.tx_bytes+=length;
 
-		if (zn.tx_cur >= zn.tx_end)
-		  zn.tx_cur = zn.tx_start;
-		*zn.tx_cur++ = length;
-		if (zn.tx_cur + rnd_len + 1 > zn.tx_end) {
-			int semi_cnt = (zn.tx_end - zn.tx_cur)<<1; /* Cvrt to byte cnt. */
-			memcpy(zn.tx_cur, buf, semi_cnt);
+		if (znet->tx_cur >= znet->tx_end)
+		  znet->tx_cur = znet->tx_start;
+		*znet->tx_cur++ = length;
+		if (znet->tx_cur + rnd_len + 1 > znet->tx_end) {
+			int semi_cnt = (znet->tx_end - znet->tx_cur)<<1; /* Cvrt to byte cnt. */
+			memcpy(znet->tx_cur, buf, semi_cnt);
 			rnd_len -= semi_cnt>>1;
-			memcpy(zn.tx_start, buf + semi_cnt, length - semi_cnt);
-			zn.tx_cur = zn.tx_start + rnd_len;
+			memcpy(znet->tx_start, buf + semi_cnt, length - semi_cnt);
+			znet->tx_cur = znet->tx_start + rnd_len;
 		} else {
-			memcpy(zn.tx_cur, buf, skb->len);
-			zn.tx_cur += rnd_len;
+			memcpy(znet->tx_cur, buf, skb->len);
+			znet->tx_cur += rnd_len;
 		}
-		*zn.tx_cur++ = 0;
+		*znet->tx_cur++ = 0;
 
-		spin_lock_irqsave(&lp->lock, flags);
+		spin_lock_irqsave(&znet->lock, flags);
 		{
-			*tx_link = CMD0_TRANSMIT + CMD0_CHNL_1;
+			*tx_link = OP0_TRANSMIT | CR0_CHNL;
 			/* Is this always safe to do? */
-			outb(CMD0_TRANSMIT + CMD0_CHNL_1,ioaddr);
+			outb(OP0_TRANSMIT | CR0_CHNL, ioaddr);
 		}
-		spin_unlock_irqrestore (&lp->lock, flags);
+		spin_unlock_irqrestore (&znet->lock, flags);
 
 		dev->trans_start = jiffies;
 		netif_start_queue (dev);
@@ -416,7 +594,7 @@
 static void	znet_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct net_device *dev = dev_id;
-	struct net_local *lp = (struct net_local *)dev->priv;
+	struct znet_private *znet = dev->priv;
 	int ioaddr;
 	int boguscnt = 20;
 
@@ -425,73 +603,77 @@
 		return;
 	}
 
-	spin_lock (&lp->lock);
+	spin_lock (&znet->lock);
 	
 	ioaddr = dev->base_addr;
 
-	outb(CMD0_STAT0, ioaddr);
+	outb(CR0_STATUS_0, ioaddr);
 	do {
 		ushort status = inb(ioaddr);
 		if (znet_debug > 5) {
 			ushort result, rx_ptr, running;
-			outb(CMD0_STAT1, ioaddr);
+			outb(CR0_STATUS_1, ioaddr);
 			result = inw(ioaddr);
-			outb(CMD0_STAT2, ioaddr);
+			outb(CR0_STATUS_2, ioaddr);
 			rx_ptr = inw(ioaddr);
-			outb(CMD0_STAT3, ioaddr);
+			outb(CR0_STATUS_3, ioaddr);
 			running = inb(ioaddr);
 			printk(KERN_DEBUG "%s: interrupt, status %02x, %04x %04x %02x serial %d.\n",
 				 dev->name, status, result, rx_ptr, running, boguscnt);
 		}
-		if ((status & 0x80) == 0)
+		if ((status & SR0_INTERRUPT) == 0)
 			break;
 
-		if ((status & 0x0F) == 4) {	/* Transmit done. */
+		if ((status & 0x0F) == SR0_TRANSMIT_DONE) {
 			int tx_status;
-			outb(CMD0_STAT1, ioaddr);
+			outb(CR0_STATUS_1, ioaddr);
 			tx_status = inw(ioaddr);
 			/* It's undocumented, but tx_status seems to match the i82586. */
-			if (tx_status & 0x2000) {
-				lp->stats.tx_packets++;
-				lp->stats.collisions += tx_status & 0xf;
+			if (tx_status & TX_OK) {
+				znet->stats.tx_packets++;
+				znet->stats.collisions += tx_status & TX_NCOL_MASK;
 			} else {
-				if (tx_status & 0x0600)  lp->stats.tx_carrier_errors++;
-				if (tx_status & 0x0100)  lp->stats.tx_fifo_errors++;
-				if (!(tx_status & 0x0040)) lp->stats.tx_heartbeat_errors++;
-				if (tx_status & 0x0020)  lp->stats.tx_aborted_errors++;
+				if (tx_status & (TX_LOST_CTS | TX_LOST_CRS))
+					znet->stats.tx_carrier_errors++;
+				if (tx_status & TX_UND_RUN)
+					znet->stats.tx_fifo_errors++;
+				if (!(tx_status & TX_HRT_BEAT))
+					znet->stats.tx_heartbeat_errors++;
+				if (tx_status & TX_MAX_COL)
+					znet->stats.tx_aborted_errors++;
 				/* ...and the catch-all. */
-				if ((tx_status | 0x0760) != 0x0760)
-				  lp->stats.tx_errors++;
+				if ((tx_status | (TX_LOST_CRS | TX_LOST_CTS | TX_UND_RUN | TX_HRT_BEAT | TX_MAX_COL)) != (TX_LOST_CRS | TX_LOST_CTS | TX_UND_RUN | TX_HRT_BEAT | TX_MAX_COL))
+					znet->stats.tx_errors++;
 			}
 			netif_wake_queue (dev);
 		}
 
-		if ((status & 0x40)
-			|| (status & 0x0f) == 11) {
+		if ((status & SR0_RECEPTION) ||
+		    (status & SR0_EVENT_MASK) == SR0_STOP_REG_HIT) {
 			znet_rx(dev);
 		}
 		/* Clear the interrupts we've handled. */
-		outb(CMD0_ACK,ioaddr);
+		outb(CR0_INT_ACK, ioaddr);
 	} while (boguscnt--);
 
-	spin_unlock (&lp->lock);
+	spin_unlock (&znet->lock);
 	
 	return;
 }
 
 static void znet_rx(struct net_device *dev)
 {
-	struct net_local *lp = (struct net_local *)dev->priv;
+	struct znet_private *znet = dev->priv;
 	int ioaddr = dev->base_addr;
 	int boguscount = 1;
 	short next_frame_end_offset = 0; 		/* Offset of next frame start. */
 	short *cur_frame_end;
 	short cur_frame_end_offset;
 
-	outb(CMD0_STAT2, ioaddr);
+	outb(CR0_STATUS_2, ioaddr);
 	cur_frame_end_offset = inw(ioaddr);
 
-	if (cur_frame_end_offset == zn.rx_cur - zn.rx_start) {
+	if (cur_frame_end_offset == znet->rx_cur - znet->rx_start) {
 		printk(KERN_WARNING "%s: Interrupted, but nothing to receive, offset %03x.\n",
 			   dev->name, cur_frame_end_offset);
 		return;
@@ -501,7 +683,7 @@
 	   the same area of the backwards links we now have.  This allows us to
 	   pass packets to the upper layers in the order they were received --
 	   important for fast-path sequential operations. */
-	 while (zn.rx_start + cur_frame_end_offset != zn.rx_cur
+	 while (znet->rx_start + cur_frame_end_offset != znet->rx_cur
 			&& ++boguscount < 5) {
 		unsigned short hi_cnt, lo_cnt, hi_status, lo_status;
 		int count, status;
@@ -510,10 +692,10 @@
 			/* Oh no, we have a special case: the frame trailer wraps around
 			   the end of the ring buffer.  We've saved space at the end of
 			   the ring buffer for just this problem. */
-			memcpy(zn.rx_end, zn.rx_start, 8);
+			memcpy(znet->rx_end, znet->rx_start, 8);
 			cur_frame_end_offset += (RX_BUF_SIZE/2);
 		}
-		cur_frame_end = zn.rx_start + cur_frame_end_offset - 4;
+		cur_frame_end = znet->rx_start + cur_frame_end_offset - 4;
 
 		lo_status = *cur_frame_end++;
 		hi_status = *cur_frame_end++;
@@ -538,7 +720,7 @@
 
 	/* Now step  forward through the list. */
 	do {
-		ushort *this_rfp_ptr = zn.rx_start + next_frame_end_offset;
+		ushort *this_rfp_ptr = znet->rx_start + next_frame_end_offset;
 		int status = this_rfp_ptr[-4];
 		int pkt_len = this_rfp_ptr[-2];
 	  
@@ -547,15 +729,20 @@
 				 " next %04x.\n", next_frame_end_offset<<1, status, pkt_len,
 				 this_rfp_ptr[-3]<<1);
 		/* Once again we must assume that the i82586 docs apply. */
-		if ( ! (status & 0x2000)) {				/* There was an error. */
-			lp->stats.rx_errors++;
-			if (status & 0x0800) lp->stats.rx_crc_errors++;
-			if (status & 0x0400) lp->stats.rx_frame_errors++;
-			if (status & 0x0200) lp->stats.rx_over_errors++; /* Wrong. */
-			if (status & 0x0100) lp->stats.rx_fifo_errors++;
-			if (status & 0x0080) lp->stats.rx_length_errors++;
+		if ( ! (status & RX_RCV_OK)) { /* There was an error. */
+			znet->stats.rx_errors++;
+			if (status & RX_CRC_ERR) znet->stats.rx_crc_errors++;
+			if (status & RX_ALG_ERR) znet->stats.rx_frame_errors++;
+#if 0
+			if (status & 0x0200) znet->stats.rx_over_errors++; /* Wrong. */
+			if (status & 0x0100) znet->stats.rx_fifo_errors++;
+#else
+			/* maz : Wild guess... */
+			if (status & RX_OVRRUN) znet->stats.rx_over_errors++;
+#endif
+			if (status & RX_SRT_FRM) znet->stats.rx_length_errors++;
 		} else if (pkt_len > 1536) {
-			lp->stats.rx_length_errors++;
+			znet->stats.rx_length_errors++;
 		} else {
 			/* Malloc up new buffer. */
 			struct sk_buff *skb;
@@ -564,18 +751,18 @@
 			if (skb == NULL) {
 				if (znet_debug)
 				  printk(KERN_WARNING "%s: Memory squeeze, dropping packet.\n", dev->name);
-				lp->stats.rx_dropped++;
+				znet->stats.rx_dropped++;
 				break;
 			}
 			skb->dev = dev;
 
-			if (&zn.rx_cur[(pkt_len+1)>>1] > zn.rx_end) {
-				int semi_cnt = (zn.rx_end - zn.rx_cur)<<1;
-				memcpy(skb_put(skb,semi_cnt), zn.rx_cur, semi_cnt);
-				memcpy(skb_put(skb,pkt_len-semi_cnt), zn.rx_start,
+			if (&znet->rx_cur[(pkt_len+1)>>1] > znet->rx_end) {
+				int semi_cnt = (znet->rx_end - znet->rx_cur)<<1;
+				memcpy(skb_put(skb,semi_cnt), znet->rx_cur, semi_cnt);
+				memcpy(skb_put(skb,pkt_len-semi_cnt), znet->rx_start,
 					   pkt_len - semi_cnt);
 			} else {
-				memcpy(skb_put(skb,pkt_len), zn.rx_cur, pkt_len);
+				memcpy(skb_put(skb,pkt_len), znet->rx_cur, pkt_len);
 				if (znet_debug > 6) {
 					unsigned int *packet = (unsigned int *) skb->data;
 					printk(KERN_DEBUG "Packet data is %08x %08x %08x %08x.\n", packet[0],
@@ -585,17 +772,17 @@
 		  skb->protocol=eth_type_trans(skb,dev);
 		  netif_rx(skb);
 		  dev->last_rx = jiffies;
-		  lp->stats.rx_packets++;
-		  lp->stats.rx_bytes += pkt_len;
+		  znet->stats.rx_packets++;
+		  znet->stats.rx_bytes += pkt_len;
 		}
-		zn.rx_cur = this_rfp_ptr;
-		if (zn.rx_cur >= zn.rx_end)
-			zn.rx_cur -= RX_BUF_SIZE/2;
-		update_stop_hit(ioaddr, (zn.rx_cur - zn.rx_start)<<1);
+		znet->rx_cur = this_rfp_ptr;
+		if (znet->rx_cur >= znet->rx_end)
+			znet->rx_cur -= RX_BUF_SIZE/2;
+		update_stop_hit(ioaddr, (znet->rx_cur - znet->rx_start)<<1);
 		next_frame_end_offset = this_rfp_ptr[-3];
 		if (next_frame_end_offset == 0)		/* Read all the frames? */
 			break;			/* Done for now */
-		this_rfp_ptr = zn.rx_start + next_frame_end_offset;
+		this_rfp_ptr = znet->rx_start + next_frame_end_offset;
 	} while (--boguscount);
 
 	/* If any worth-while packets have been received, dev_rint()
@@ -607,26 +794,19 @@
 /* The inverse routine to znet_open(). */
 static int znet_close(struct net_device *dev)
 {
-	unsigned long flags;
 	int ioaddr = dev->base_addr;
 
 	netif_stop_queue (dev);
 
-	outb(CMD0_RESET, ioaddr);			/* CMD0_RESET */
-
-	flags=claim_dma_lock();
-	disable_dma(zn.rx_dma);
-	disable_dma(zn.tx_dma);
-	release_dma_lock(flags);
-
-	free_irq(dev->irq, dev);
+	outb(OP0_RESET, ioaddr);			/* CMD0_RESET */
 
 	if (znet_debug > 1)
 		printk(KERN_DEBUG "%s: Shutting down ethercard.\n", dev->name);
 	/* Turn off transceiver power. */
-	outb(0x10, 0xe6);					/* Select LAN control register */
-	outb(inb(0xe7) & ~0x84, 0xe7);		/* Turn on LAN power (bit 2). */
-
+	znet_transceiver_power (dev, 0);
+	
+	znet_release_resources (dev);
+	
 	return 0;
 }
 
@@ -634,60 +814,30 @@
    closed. */
 static struct net_device_stats *net_get_stats(struct net_device *dev)
 {
-		struct net_local *lp = (struct net_local *)dev->priv;
+	struct znet_private *znet = dev->priv;
 
-		return &lp->stats;
+	return &znet->stats;
 }
 
-/* Set or clear the multicast filter for this adaptor.
-   As a side effect this routine must also initialize the device parameters.
-   This is taken advantage of in open().
-
-   N.B. that we change i593_init[] in place.  This (properly) makes the
-   mode change persistent, but must be changed if this code is moved to
-   a multiple adaptor environment.
- */
-static void set_multicast_list(struct net_device *dev)
+static void show_dma(struct net_device *dev)
 {
 	short ioaddr = dev->base_addr;
-
-	if (dev->flags&IFF_PROMISC) {
-		/* Enable promiscuous mode */
-		i593_init[7] &= ~3;		i593_init[7] |= 1;
-		i593_init[13] &= ~8;	i593_init[13] |= 8;
-	} else if (dev->mc_list || (dev->flags&IFF_ALLMULTI)) {
-		/* Enable accept-all-multicast mode */
-		i593_init[7] &= ~3;		i593_init[7] |= 0;
-		i593_init[13] &= ~8;	i593_init[13] |= 8;
-	} else {					/* Enable normal mode. */
-		i593_init[7] &= ~3;		i593_init[7] |= 0;
-		i593_init[13] &= ~8;	i593_init[13] |= 0;
-	}
-	*zn.tx_cur++ = sizeof(i593_init);
-	memcpy(zn.tx_cur, i593_init, sizeof(i593_init));
-	zn.tx_cur += sizeof(i593_init)/2;
-	outb(CMD0_CONFIGURE+CMD0_CHNL_1, ioaddr);
-#ifdef not_tested
-	if (num_addrs > 0) {
-		int addrs_len = 6*num_addrs;
-		*zn.tx_cur++ = addrs_len;
-		memcpy(zn.tx_cur, addrs, addrs_len);
-		outb(CMD0_MULTICAST_LIST+CMD0_CHNL_1, ioaddr);
-		zn.tx_cur += addrs_len>>1;
-	}
-#endif
-}
-
-void show_dma(void)
-{
+	unsigned char stat = inb (ioaddr);
+	struct znet_private *znet = dev->priv;
 	unsigned long flags;
-	short dma_port = ((zn.tx_dma&3)<<2) + IO_DMA2_BASE;
+	short dma_port = ((znet->tx_dma&3)<<2) + IO_DMA2_BASE;
 	unsigned addr = inb(dma_port);
-	addr |= inb(dma_port) << 8;
+	short residue;
 
-	flags=claim_dma_lock();
-	printk("Addr: %04x cnt:%3x...", addr<<1, get_dma_residue(zn.tx_dma));
-	release_dma_lock(flags);
+	addr |= inb(dma_port) << 8;
+	residue = get_dma_residue(znet->tx_dma);
+		
+	if (znet_debug > 1) {
+		flags=claim_dma_lock();
+		printk(KERN_DEBUG "Stat:%02x Addr: %04x cnt:%3x\n",
+		       stat, addr<<1, residue);
+		release_dma_lock(flags);
+	}
 }
 
 /* Initialize the hardware.  We have to do this when the board is open()ed
@@ -696,72 +846,78 @@
 {
 	unsigned long flags;
 	short ioaddr = dev->base_addr;
+	struct znet_private *znet = dev->priv;
 
-	zn.rx_cur = zn.rx_start;
-	zn.tx_cur = zn.tx_start;
+	znet->rx_cur = znet->rx_start;
+	znet->tx_cur = znet->tx_start;
 
 	/* Reset the chip, and start it up. */
-	outb(CMD0_RESET, ioaddr);
+	outb(OP0_RESET, ioaddr);
 
 	flags=claim_dma_lock();
-	disable_dma(zn.rx_dma); 		/* reset by an interrupting task. */
-	clear_dma_ff(zn.rx_dma);
-	set_dma_mode(zn.rx_dma, DMA_RX_MODE);
-	set_dma_addr(zn.rx_dma, (unsigned int) zn.rx_start);
-	set_dma_count(zn.rx_dma, RX_BUF_SIZE);
-	enable_dma(zn.rx_dma);
+	disable_dma(znet->rx_dma); 		/* reset by an interrupting task. */
+	clear_dma_ff(znet->rx_dma);
+	set_dma_mode(znet->rx_dma, DMA_RX_MODE);
+	set_dma_addr(znet->rx_dma, (unsigned int) znet->rx_start);
+	set_dma_count(znet->rx_dma, RX_BUF_SIZE);
+	enable_dma(znet->rx_dma);
 	/* Now set up the Tx channel. */
-	disable_dma(zn.tx_dma);
-	clear_dma_ff(zn.tx_dma);
-	set_dma_mode(zn.tx_dma, DMA_TX_MODE);
-	set_dma_addr(zn.tx_dma, (unsigned int) zn.tx_start);
-	set_dma_count(zn.tx_dma, zn.tx_buf_len<<1);
-	enable_dma(zn.tx_dma);
+	disable_dma(znet->tx_dma);
+	clear_dma_ff(znet->tx_dma);
+	set_dma_mode(znet->tx_dma, DMA_TX_MODE);
+	set_dma_addr(znet->tx_dma, (unsigned int) znet->tx_start);
+	set_dma_count(znet->tx_dma, znet->tx_buf_len<<1);
+	enable_dma(znet->tx_dma);
 	release_dma_lock(flags);
 	
 	if (znet_debug > 1)
-	  printk(KERN_DEBUG "%s: Initializing the i82593, tx buf %p... ", dev->name,
-			 zn.tx_start);
+	  printk(KERN_DEBUG "%s: Initializing the i82593, rx buf %p tx buf %p\n",
+			 dev->name, znet->rx_start,znet->tx_start);
 	/* Do an empty configure command, just like the Crynwr driver.  This
 	   resets to chip to its default values. */
-	*zn.tx_cur++ = 0;
-	*zn.tx_cur++ = 0;
-	printk("stat:%02x ", inb(ioaddr)); show_dma();
-	outb(CMD0_CONFIGURE+CMD0_CHNL_1, ioaddr);
-	*zn.tx_cur++ = sizeof(i593_init);
-	memcpy(zn.tx_cur, i593_init, sizeof(i593_init));
-	zn.tx_cur += sizeof(i593_init)/2;
-	printk("stat:%02x ", inb(ioaddr)); show_dma();
-	outb(CMD0_CONFIGURE+CMD0_CHNL_1, ioaddr);
-	*zn.tx_cur++ = 6;
-	memcpy(zn.tx_cur, dev->dev_addr, 6);
-	zn.tx_cur += 3;
-	printk("stat:%02x ", inb(ioaddr)); show_dma();
-	outb(CMD0_IA_SETUP + CMD0_CHNL_1, ioaddr);
-	printk("stat:%02x ", inb(ioaddr)); show_dma();
+	*znet->tx_cur++ = 0;
+	*znet->tx_cur++ = 0;
+	show_dma(dev);
+	outb(OP0_CONFIGURE | CR0_CHNL, ioaddr);
+
+	znet_set_multicast_list (dev);
+
+	*znet->tx_cur++ = 6;
+	memcpy(znet->tx_cur, dev->dev_addr, 6);
+	znet->tx_cur += 3;
+	show_dma(dev);
+	outb(OP0_IA_SETUP | CR0_CHNL, ioaddr);
+	show_dma(dev);
 
 	update_stop_hit(ioaddr, 8192);
-	if (znet_debug > 1)  printk("enabling Rx.\n");
-	outb(CMD0_Rx_ENABLE+CMD0_CHNL_0, ioaddr);
+	if (znet_debug > 1)  printk(KERN_DEBUG "enabling Rx.\n");
+	outb(OP0_RCV_ENABLE, ioaddr);
 	netif_start_queue (dev);
 }
 
 static void update_stop_hit(short ioaddr, unsigned short rx_stop_offset)
 {
-	outb(CMD0_PORT_1, ioaddr);
+	outb(OP0_SWIT_TO_PORT_1 | CR0_CHNL, ioaddr);
 	if (znet_debug > 5)
 	  printk(KERN_DEBUG "Updating stop hit with value %02x.\n",
-			 (rx_stop_offset >> 6) | 0x80);
-	outb((rx_stop_offset >> 6) | 0x80, ioaddr);
-	outb(CMD1_PORT_0, ioaddr);
+			 (rx_stop_offset >> 6) | CR1_STOP_REG_UPDATE);
+	outb((rx_stop_offset >> 6) | CR1_STOP_REG_UPDATE, ioaddr);
+	outb(OP1_SWIT_TO_PORT_0, ioaddr);
 }
-
-/*
- * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c znet.c"
- *  version-control: t
- *  kept-new-versions: 5
- *  c-indent-level: 4
- *  tab-width: 4
- * End:
- */
+
+static __exit void znet_cleanup (void)
+{
+#ifdef MODULE
+	if (znet_dev) {
+		struct znet_private *znet = znet_dev->priv;
+
+		kfree (znet->rx_start);
+		kfree (znet->tx_start);
+		unregister_netdev (znet_dev);
+		kfree (znet_dev);
+	}
+#endif
+}
+
+module_init (znet_probe);
+module_exit (znet_cleanup);

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
