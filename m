Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVCOShI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVCOShI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVCOShH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:37:07 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41136 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261721AbVCOS0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:26:05 -0500
Date: Tue, 15 Mar 2005 11:25:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again
Message-ID: <20050315182537.GW8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's too many things in here that've sat too long (I'd been hoping to
just delete the driver, but that hasn't happened yet, so).  A cobbled
together list of changes is:

- Update MDIO support for workqueues.
- Make use of <linux/mii.h>
- Add RPX6 support.
- Comment out set_multicast_list (broken).
- Rework tx_ring stuff so we have tx_free, not tx_Full/n_pkts.
- Other PHY updates/fixes.
- Leo Li: Rework FCC clock configuration, make it easier.
- 2.4 : VLAN header room, other misc bits.
- Kill MII_REG_NNN in favor of defines from <linux/mii.h>
- DM9161 PHY support (2.4, Myself & alebas@televes.com)
- PQ2ADS and PQ2FADS support bits (Myself & alebas@televes.com

From: Leo Li <leoli@freescale.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Alexandre Bastos <alebas@televes.com>

 arch/ppc/8260_io/Kconfig    |   11 
 arch/ppc/8260_io/fcc_enet.c |  969 +++++++++++++-------------------------------
 include/asm-ppc/cpm2.h      |    1 
 3 files changed, 301 insertions(+), 680 deletions(-)
--- linuxppc-2.6.11/arch/ppc/8260_io/Kconfig	2005-03-15 09:00:42.000000000 -0700
+++ linux-2.6.11/arch/ppc/8260_io/Kconfig	2005-03-02 00:38:26.000000000 -0700
@@ -42,7 +42,7 @@
 choice
 	prompt "Type of PHY"
 	depends on 8260 && USE_MDIO
-	default FCC_GENERIC_PHY
+	default FCC_LXT971
 
 config FCC_LXT970
 	bool "LXT970"
@@ -53,13 +53,6 @@
 config FCC_QS6612
 	bool "QS6612"
 
-config FCC_DM9131
-	bool "DM9131"
-
-config FCC_DM9161
-	bool "DM9161"
-
-config FCC_GENERIC_PHY
-	bool "Generic"
 endchoice
 endmenu
+
--- linuxppc-2.6.11/arch/ppc/8260_io/fcc_enet.c	2005-03-15 08:57:26.000000000 -0700
+++ linux-2.6.11/arch/ppc/8260_io/fcc_enet.c	2005-03-02 00:38:08.000000000 -0700
@@ -16,9 +16,6 @@
  * small packets.  Since this is a cache coherent processor and CPM,
  * I could also preallocate SKB's and use them directly on the interface.
  *
- * 2004-12	Leo Li (leoli@freescale.com)
- * - Rework the FCC clock configuration part, make it easier to configure.
- *
  */
 
 #include <linux/config.h>
@@ -37,8 +34,6 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
-#include <linux/mii.h>
-#include <linux/workqueue.h>
 #include <linux/bitops.h>
 
 #include <asm/immap_cpm2.h>
@@ -46,26 +41,6 @@
 #include <asm/mpc8260.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-#include <asm/signal.h>
-
-/* We can't use the PHY interrupt if we aren't using MDIO. */
-#if !defined(CONFIG_USE_MDIO)
-#undef PHY_INTERRUPT
-#endif
-
-/* If we have a PHY interrupt, we will advertise both full-duplex and half-
- * duplex capabilities.  If we don't have a PHY interrupt, then we will only
- * advertise half-duplex capabilities.
- */
-#define MII_ADVERTISE_HALF	(ADVERTISE_100HALF | ADVERTISE_10HALF | \
-				 ADVERTISE_CSMA)
-#define MII_ADVERTISE_ALL	(ADVERTISE_100FULL | ADVERTISE_10FULL | \
-				 MII_ADVERTISE_HALF)
-#ifdef PHY_INTERRUPT
-#define MII_ADVERTISE_DEFAULT	MII_ADVERTISE_ALL
-#else
-#define MII_ADVERTISE_DEFAULT	MII_ADVERTISE_HALF
-#endif
 #include <asm/cpm2.h>
 
 /* The transmitter timeout
@@ -90,6 +65,18 @@
 	const phy_cmd_t *shutdown;
 } phy_info_t;
 
+/* Register definitions for the PHY. */
+
+#define MII_REG_CR          0  /* Control Register                         */
+#define MII_REG_SR          1  /* Status Register                          */
+#define MII_REG_PHYIR1      2  /* PHY Identification Register 1            */
+#define MII_REG_PHYIR2      3  /* PHY Identification Register 2            */
+#define MII_REG_ANAR        4  /* A-N Advertisement Register               */
+#define MII_REG_ANLPAR      5  /* A-N Link Partner Ability Register        */
+#define MII_REG_ANER        6  /* A-N Expansion Register                   */
+#define MII_REG_ANNPTR      7  /* A-N Next Page Transmit Register          */
+#define MII_REG_ANLPRNPR    8  /* A-N Link Partner Received Next Page Reg. */
+
 /* values for phy_status */
 
 #define PHY_CONF_ANE	0x0001  /* 1 auto-negotiation enabled */
@@ -124,15 +111,13 @@
 #define TX_RING_MOD_MASK	15	/*   for this to work */
 
 /* The FCC stores dest/src/type, data, and checksum for receive packets.
- * size includes support for VLAN
  */
-#define PKT_MAXBUF_SIZE		1522
+#define PKT_MAXBUF_SIZE		1518
 #define PKT_MINBUF_SIZE		64
 
 /* Maximum input DMA size.  Must be a should(?) be a multiple of 4.
- * size includes support for VLAN
- */
-#define PKT_MAXDMA_SIZE		1524
+*/
+#define PKT_MAXDMA_SIZE		1520
 
 /* Maximum input buffer size.  Must be a multiple of 32.
 */
@@ -144,9 +129,8 @@
 static irqreturn_t fcc_enet_interrupt(int irq, void *dev_id, struct pt_regs *);
 static int fcc_enet_close(struct net_device *dev);
 static struct net_device_stats *fcc_enet_get_stats(struct net_device *dev);
-/* static void set_multicast_list(struct net_device *dev); */
+static void set_multicast_list(struct net_device *dev);
 static void fcc_restart(struct net_device *dev, int duplex);
-static void fcc_stop(struct net_device *dev);
 static int fcc_enet_set_mac_address(struct net_device *dev, void *addr);
 
 /* These will be configurable for the FCC choice.
@@ -157,65 +141,6 @@
  * help show what pins are used for each device.
  */
 
-/* Since the CLK setting changes greatly from board to board, I changed
- * it to a easy way.  You just need to specify which CLK number to use.
- * Note that only limited choices can be make on each port.
- */
-
-/* FCC1 Clock Source Configuration.  There are board specific. 
-   Can only choose from CLK9-12 */
-#ifdef CONFIG_SBC82xx
-#define F1_RXCLK	9
-#define F1_TXCLK	10
-#elif defined(CONFIG_ADS8272)
-#define F1_RXCLK	11
-#define F1_TXCLK	10
-#else
-#define F1_RXCLK	12
-#define F1_TXCLK	11
-#endif
-
-/* FCC2 Clock Source Configuration.  There are board specific. 
-   Can only choose from CLK13-16 */
-#ifdef CONFIG_ADS8272
-#define F2_RXCLK	15
-#define F2_TXCLK	16
-#else
-#define F2_RXCLK	13
-#define F2_TXCLK	14
-#endif
-
-/* FCC3 Clock Source Configuration.  There are board specific. 
-   Can only choose from CLK13-16 */
-#define F3_RXCLK	15
-#define F3_TXCLK	16
-
-/* Automatically generates register configurations */
-#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
-
-#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
-#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
-#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
-#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
-#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
-#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
-
-#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
-#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
-#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
-#define CMX1_CLK_MASK	((uint)0xff000000)
-
-#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
-#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
-#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
-#define CMX2_CLK_MASK	((uint)0x00ff0000)
-
-#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
-#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
-#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
-#define CMX3_CLK_MASK	((uint)0x0000ff00)
-
-
 /* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
  * but there is little variation among the choices.
  */
@@ -227,12 +152,30 @@
 #define PA1_RXER	((uint)0x00000020)
 #define PA1_TXDAT	((uint)0x00003c00)
 #define PA1_RXDAT	((uint)0x0003c000)
-#define PA1_PSORA_BOUT	(PA1_RXDAT | PA1_TXDAT)
-#define PA1_PSORA_BIN	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
+#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
+#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
 				PA1_RXDV | PA1_RXER)
-#define PA1_DIRA_BOUT	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
-#define PA1_DIRA_BIN	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
+#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
+#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
 
+#ifdef CONFIG_SBC82xx
+/* rx is clk9, tx is clk10 */
+#define PC_F1RXCLK     ((uint)0x00000100)
+#define PC_F1TXCLK     ((uint)0x00000200)
+#define CMX1_CLK_ROUTE ((uint)0x25000000)
+#define CMX1_CLK_MASK  ((uint)0xff000000)
+#elif defined(CONFIG_ADS8272)
+#define PC_F1RXCLK	((uint)0x00000400)
+#define PC_F1TXCLK	((uint)0x00000200)
+#define CMX1_CLK_ROUTE	((uint)0x36000000)
+#define CMX1_CLK_MASK	((uint)0xff000000)
+#else /* other boards */
+/* CLK12 is receive, CLK11 is transmit.  These are board specific. */
+#define PC_F1RXCLK	((uint)0x00000800)
+#define PC_F1TXCLK	((uint)0x00000400)
+#define CMX1_CLK_ROUTE	((uint)0x3e000000)
+#define CMX1_CLK_MASK	((uint)0xff000000)
+#endif
 
 /* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
  * but there is little variation among the choices.
@@ -245,12 +188,25 @@
 #define PB2_CRS		((uint)0x00000020)
 #define PB2_TXDAT	((uint)0x000003c0)
 #define PB2_RXDAT	((uint)0x00003c00)
-#define PB2_PSORB_BOUT	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
+#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
 				PB2_RXER | PB2_RXDV | PB2_TXER)
-#define PB2_PSORB_BIN	(PB2_TXEN)
-#define PB2_DIRB_BOUT	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
-#define PB2_DIRB_BIN	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
+#define PB2_PSORB1	(PB2_TXEN)
+#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
+#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
 
+/* CLK13 is receive, CLK14 is transmit.  These are board dependent.
+*/
+#ifdef CONFIG_ADS8272
+#define PC_F2RXCLK	((uint)0x00004000)
+#define PC_F2TXCLK	((uint)0x00008000)
+#define CMX2_CLK_ROUTE	((uint)0x00370000)
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+#else
+#define PC_F2RXCLK	((uint)0x00001000)
+#define PC_F2TXCLK	((uint)0x00002000)
+#define CMX2_CLK_ROUTE	((uint)0x00250000)
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+#endif
 
 /* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
  * but there is little variation among the choices.
@@ -261,61 +217,35 @@
 #define PB3_TXEN	((uint)0x00020000)
 #define PB3_COL		((uint)0x00040000)
 #define PB3_CRS		((uint)0x00080000)
-#ifndef CONFIG_RPX8260
 #define PB3_TXDAT	((uint)0x0f000000)
-#define PC3_TXDAT	((uint)0x00000000)
-#else
-#define PB3_TXDAT	((uint)0x0f000000) 
-#define PC3_TXDAT	0
-#endif
 #define PB3_RXDAT	((uint)0x00f00000)
-#define PB3_PSORB_BOUT	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
+#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
 				PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
-#define PB3_PSORB_BIN	(0)
-#define PB3_DIRB_BOUT	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
-#define PB3_DIRB_BIN	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
-
-#define PC3_PSORC_BOUT	(PC3_TXDAT)
-#define PC3_PSORC_BIN	(0)
-#define PC3_DIRC_BOUT	(0)
-#define PC3_DIRC_BIN	(PC3_TXDAT)
+#define PB3_PSORB1	(0)
+#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
+#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
 
+/* CLK15 is receive, CLK16 is transmit.  These are board dependent.
+*/
+#define PC_F3RXCLK	((uint)0x00004000)
+#define PC_F3TXCLK	((uint)0x00008000)
+#define CMX3_CLK_ROUTE	((uint)0x00003700)
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
 
 /* MII status/control serial interface.
 */
-#if defined(CONFIG_RPX8260)
-/* The EP8260 doesn't use Port C for MDIO */
-#define PC_MDIO		((uint)0x00000000)
-#define PC_MDCK		((uint)0x00000000)
-#elif defined(CONFIG_TQM8260)
+#ifdef	CONFIG_TQM8260
 /* TQM8260 has MDIO and MDCK on PC30 and PC31 respectively */
 #define PC_MDIO		((uint)0x00000002)
 #define PC_MDCK		((uint)0x00000001)
 #elif defined(CONFIG_ADS8272)
 #define PC_MDIO		((uint)0x00002000)
 #define PC_MDCK		((uint)0x00001000)
-#elif defined(CONFIG_EST8260) || defined(CONFIG_ADS8260) || defined(CONFIG_PQ2FADS)
-#define PC_MDIO		((uint)0x00400000)
-#define PC_MDCK		((uint)0x00200000)
 #else
 #define PC_MDIO		((uint)0x00000004)
 #define PC_MDCK		((uint)0x00000020)
 #endif
 
-#if defined(CONFIG_USE_MDIO) && (!defined(PC_MDIO) || !defined(PC_MDCK))
-#error "Must define PC_MDIO and PC_MDCK if using MDIO"
-#endif
-
-/* PHY addresses */
-/* default to dynamic config of phy addresses */
-#define FCC1_PHY_ADDR 0
-#ifdef CONFIG_PQ2FADS
-#define FCC2_PHY_ADDR 0
-#else
-#define FCC2_PHY_ADDR 2
-#endif
-#define FCC3_PHY_ADDR 3
-
 /* A table of information for supporting FCCs.  This does two things.
  * First, we know how many FCCs we have and they are always externally
  * numbered from zero.  Second, it holds control register and I/O
@@ -323,7 +253,6 @@
  */
 typedef struct fcc_info {
 	uint	fc_fccnum;
-	uint	fc_phyaddr; 
 	uint	fc_cpmblock;
 	uint	fc_cpmpage;
 	uint	fc_proff;
@@ -337,19 +266,33 @@
 
 static fcc_info_t fcc_ports[] = {
 #ifdef CONFIG_FCC1_ENET
-	{ 0, FCC1_PHY_ADDR, CPM_CR_FCC1_SBLOCK, CPM_CR_FCC1_PAGE, PROFF_FCC1, SIU_INT_FCC1,
+	{ 0, CPM_CR_FCC1_SBLOCK, CPM_CR_FCC1_PAGE, PROFF_FCC1, SIU_INT_FCC1,
 		(PC_F1RXCLK | PC_F1TXCLK), CMX1_CLK_ROUTE, CMX1_CLK_MASK,
+# if defined(CONFIG_TQM8260) || defined(CONFIG_ADS8272)
 		PC_MDIO, PC_MDCK },
+# else
+		0x00000004, 0x00000100 },
+# endif
 #endif
 #ifdef CONFIG_FCC2_ENET
-	{ 1, FCC2_PHY_ADDR, CPM_CR_FCC2_SBLOCK, CPM_CR_FCC2_PAGE, PROFF_FCC2, SIU_INT_FCC2,
+	{ 1, CPM_CR_FCC2_SBLOCK, CPM_CR_FCC2_PAGE, PROFF_FCC2, SIU_INT_FCC2,
 		(PC_F2RXCLK | PC_F2TXCLK), CMX2_CLK_ROUTE, CMX2_CLK_MASK,
+# if defined(CONFIG_TQM8260) || defined(CONFIG_ADS8272)
 		PC_MDIO, PC_MDCK },
+# elif defined(CONFIG_EST8260) || defined(CONFIG_ADS8260)
+		0x00400000, 0x00200000 },
+# else
+		0x00000002, 0x00000080 },
+# endif
 #endif
 #ifdef CONFIG_FCC3_ENET
-	{ 2, FCC3_PHY_ADDR, CPM_CR_FCC3_SBLOCK, CPM_CR_FCC3_PAGE, PROFF_FCC3, SIU_INT_FCC3,
+	{ 2, CPM_CR_FCC3_SBLOCK, CPM_CR_FCC3_PAGE, PROFF_FCC3, SIU_INT_FCC3,
 		(PC_F3RXCLK | PC_F3TXCLK), CMX3_CLK_ROUTE, CMX3_CLK_MASK,
+# if defined(CONFIG_TQM8260) || defined(CONFIG_ADS8272)
 		PC_MDIO, PC_MDCK },
+# else
+		0x00000001, 0x00000040 },
+# endif
 #endif
 };
 
@@ -367,6 +310,8 @@
 	ushort	skb_cur;
 	ushort	skb_dirty;
 
+	atomic_t n_pkts;  /* Number of packets in tx ring */
+
 	/* CPM dual port RAM relative addresses.
 	*/
 	cbd_t	*rx_bd_base;		/* Address of Rx and Tx buffers. */
@@ -376,7 +321,7 @@
 	volatile fcc_t	*fccp;
 	volatile fcc_enet_t	*ep;
 	struct	net_device_stats stats;
-	uint	tx_free;
+	uint	tx_full;
 	spinlock_t lock;
 
 #ifdef	CONFIG_USE_MDIO
@@ -384,8 +329,7 @@
 	uint	phy_id_done;
 	uint	phy_status;
 	phy_info_t	*phy;
-	struct work_struct phy_relink;
-	struct work_struct phy_display_config;
+	struct tq_struct phy_task;
 
 	uint	sequence_done;
 
@@ -410,13 +354,14 @@
 #ifdef	CONFIG_USE_MDIO
 static int	mii_queue(struct net_device *dev, int request, void (*func)(uint, struct net_device *));
 static uint	mii_send_receive(fcc_info_t *fip, uint cmd);
-static void	mii_do_cmd(struct net_device *dev, const phy_cmd_t *c);
+
+static void	fcc_stop(struct net_device *dev);
 
 /* Make MII read/write commands for the FCC.
 */
-#define mk_mii_read(REG)	(0x60020000 | (((REG) & 0x1f) << 18))
-#define mk_mii_write(REG, VAL)	(0x50020000 | (((REG) & 0x1f) << 18) | \
-						((VAL) & 0xffff))
+#define mk_mii_read(REG)	(0x60020000 | ((REG & 0x1f) << 18))
+#define mk_mii_write(REG, VAL)	(0x50020000 | ((REG & 0x1f) << 18) | \
+						(VAL & 0xffff))
 #define mk_mii_end	0
 #endif	/* CONFIG_USE_MDIO */
 
@@ -426,14 +371,20 @@
 {
 	struct fcc_enet_private *cep = (struct fcc_enet_private *)dev->priv;
 	volatile cbd_t	*bdp;
+	int idx;
+
+	if (!cep->link) {
+		/* Link is down or autonegotiation is in progress. */
+		return 1;
+	}
 
 	/* Fill in a Tx ring entry */
 	bdp = cep->cur_tx;
 
 #ifndef final_version
-	if (!cep->tx_free || (bdp->cbd_sc & BD_ENET_TX_READY)) {
+	if (bdp->cbd_sc & BD_ENET_TX_READY) {
 		/* Ooops.  All transmit buffers are full.  Bail out.
-		 * This should not happen, since the tx queue should be stopped.
+		 * This should not happen, since cep->tx_full should be set.
 		 */
 		printk("%s: tx queue full!.\n", dev->name);
 		return 1;
@@ -456,10 +407,21 @@
 	spin_lock_irq(&cep->lock);
 
 	/* Save skb pointer. */
-	cep->tx_skbuff[cep->skb_cur] = skb;
+	idx = cep->skb_cur & TX_RING_MOD_MASK;
+	if (cep->tx_skbuff[idx]) {
+		/* This should never happen (any more).
+		   Leave the sanity check in for now... */
+		printk(KERN_ERR "EEP. cep->tx_skbuff[%d] is %p not NULL in %s\n", 
+		       idx, cep->tx_skbuff[idx], __func__);
+		printk(KERN_ERR "Expect to lose %d bytes of sock space", 
+		       cep->tx_skbuff[idx]->truesize);
+	}
+	cep->tx_skbuff[idx] = skb;
 
 	cep->stats.tx_bytes += skb->len;
-	cep->skb_cur = (cep->skb_cur+1) & TX_RING_MOD_MASK;
+	cep->skb_cur++;
+
+	atomic_inc(&cep->n_pkts);
 
 	/* Send it on its way.  Tell CPM its ready, interrupt when done,
 	 * its the last BD of the frame, and to put the CRC on the end.
@@ -478,8 +440,14 @@
 	else
 		bdp++;
 
-	if (!--cep->tx_free)
-		netif_stop_queue(dev);
+
+	/* If the tx_ring is full, stop the queue */
+	if (atomic_read(&cep->n_pkts) >= (TX_RING_SIZE-1)) {
+	  if (!netif_queue_stopped(dev)) {
+		netif_stop_queue(dev);	  
+		cep->tx_full = 1;
+	  }
+	}
 
 	cep->cur_tx = (cbd_t *)bdp;
 
@@ -500,8 +468,8 @@
 	{
 		int	i;
 		cbd_t	*bdp;
-		printk(" Ring data dump: cur_tx %p tx_free %d cur_rx %p.\n",
-		       cep->cur_tx, cep->tx_free,
+		printk(" Ring data dump: cur_tx %p%s cur_rx %p.\n",
+		       cep->cur_tx, cep->tx_full ? " (full)" : "",
 		       cep->cur_rx);
 		bdp = cep->tx_bd_base;
 		printk(" Tx @base %p :\n", bdp);
@@ -519,7 +487,7 @@
 			       bdp->cbd_bufaddr);
 	}
 #endif
-	if (cep->tx_free)
+	if (!cep->tx_full)
 		netif_wake_queue(dev);
 }
 
@@ -532,22 +500,16 @@
 	volatile cbd_t	*bdp;
 	ushort	int_events;
 	int	must_restart;
+	int idx;
 
 	cep = (struct fcc_enet_private *)dev->priv;
 
 	/* Get the interrupt events that caused us to be here.
 	*/
 	int_events = cep->fccp->fcc_fcce;
-	cep->fccp->fcc_fcce = (int_events & cep->fccp->fcc_fccm);
+	cep->fccp->fcc_fcce = int_events;
 	must_restart = 0;
 
-#ifdef PHY_INTERRUPT
-	/* We have to be careful here to make sure that we aren't
-	 * interrupted by a PHY interrupt.
-	 */
-	disable_irq_nosync(PHY_INTERRUPT);
-#endif
-
 	/* Handle receive event in its own function.
 	*/
 	if (int_events & FCC_ENET_RXF)
@@ -568,7 +530,7 @@
 	    spin_lock(&cep->lock);
 	    bdp = cep->dirty_tx;
 	    while ((bdp->cbd_sc&BD_ENET_TX_READY)==0) {
-		if (cep->tx_free == TX_RING_SIZE)
+		if ((bdp==cep->cur_tx) && (cep->tx_full == 0))
 		    break;
 
 		if (bdp->cbd_sc & BD_ENET_TX_HB)	/* No heartbeat */
@@ -601,9 +563,12 @@
 			cep->stats.collisions++;
 
 		/* Free the sk buffer associated with this last transmit. */
-		dev_kfree_skb_irq(cep->tx_skbuff[cep->skb_dirty]);
-		cep->tx_skbuff[cep->skb_dirty] = NULL;
-		cep->skb_dirty = (cep->skb_dirty + 1) & TX_RING_MOD_MASK;
+		idx = cep->skb_dirty & TX_RING_MOD_MASK;
+		dev_kfree_skb_irq(cep->tx_skbuff[idx]);
+		cep->tx_skbuff[idx] = NULL;
+		cep->skb_dirty++;
+
+		atomic_dec(&cep->n_pkts);
 
 		/* Update pointer to next buffer descriptor to be transmitted. */
 		if (bdp->cbd_sc & BD_ENET_TX_WRAP)
@@ -623,7 +588,8 @@
 		/* Since we have freed up a buffer, the ring is no longer
 		 * full.
 		 */
-		if (!cep->tx_free++) {
+		if (cep->tx_full) {
+			cep->tx_full = 0;
 			if (netif_queue_stopped(dev)) {
 				netif_wake_queue(dev);
 			}
@@ -660,13 +626,8 @@
 	 * put them.
 	 */
 	if (int_events & FCC_ENET_BSY) {
-		cep->fccp->fcc_fcce = FCC_ENET_BSY;
 		cep->stats.rx_dropped++;
 	}
-
-#ifdef PHY_INTERRUPT
-	enable_irq(PHY_INTERRUPT);
-#endif
 	return IRQ_HANDLED;
 }
 
@@ -765,16 +726,8 @@
 static int
 fcc_enet_close(struct net_device *dev)
 {
-#ifdef	CONFIG_USE_MDIO
-	struct fcc_enet_private *fep = dev->priv;
-#endif
-
+	/* Don't know what to do yet. */
 	netif_stop_queue(dev);
-	fcc_stop(dev);
-#ifdef	CONFIG_USE_MDIO
-	if (fep->phy)
-		mii_do_cmd(dev, fep->phy->shutdown);
-#endif
 
 	return 0;
 }
@@ -831,14 +784,15 @@
 
 	s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);
 
-	if (mii_reg & BMSR_LSTATUS)
+	if (mii_reg & 0x0004)
 		s |= PHY_STAT_LINK;
-	if (mii_reg & BMSR_RFAULT)
+	if (mii_reg & 0x0010)
 		s |= PHY_STAT_FAULT;
-	if (mii_reg & BMSR_ANEGCOMPLETE)
+	if (mii_reg & 0x0020)
 		s |= PHY_STAT_ANC;
 
 	fep->phy_status = s;
+	fep->link = (s & PHY_STAT_LINK) ? 1 : 0;
 }
 
 static void mii_parse_cr(uint mii_reg, struct net_device *dev)
@@ -848,9 +802,9 @@
 
 	s &= ~(PHY_CONF_ANE | PHY_CONF_LOOP);
 
-	if (mii_reg & BMCR_ANENABLE)
+	if (mii_reg & 0x1000)
 		s |= PHY_CONF_ANE;
-	if (mii_reg & BMCR_LOOPBACK)
+	if (mii_reg & 0x4000)
 		s |= PHY_CONF_LOOP;
 
 	fep->phy_status = s;
@@ -863,59 +817,17 @@
 
 	s &= ~(PHY_CONF_SPMASK);
 
-	if (mii_reg & ADVERTISE_10HALF)
+	if (mii_reg & 0x0020)
 		s |= PHY_CONF_10HDX;
-	if (mii_reg & ADVERTISE_10FULL)
+	if (mii_reg & 0x0040)
 		s |= PHY_CONF_10FDX;
-	if (mii_reg & ADVERTISE_100HALF)
+	if (mii_reg & 0x0080)
 		s |= PHY_CONF_100HDX;
-	if (mii_reg & ADVERTISE_100FULL)
+	if (mii_reg & 0x00100)
 		s |= PHY_CONF_100FDX;
 
 	fep->phy_status = s;
 }
-
-/* ------------------------------------------------------------------------- */
-/* Generic PHY support.  Should work for all PHYs, but does not support link
- * change interrupts.
- */
-#ifdef CONFIG_FCC_GENERIC_PHY
-
-static phy_info_t phy_info_generic = {
-	0x00000000, /* 0-->match any PHY */
-	"GENERIC",
-
-	(const phy_cmd_t []) {  /* config */
-		/* advertise only half-duplex capabilities */
-		{ mk_mii_write(MII_ADVERTISE, MII_ADVERTISE_HALF),
-			mii_parse_anar },
-
-		/* enable auto-negotiation */
-		{ mk_mii_write(MII_BMCR, BMCR_ANENABLE), mii_parse_cr },
-		{ mk_mii_end, }
-	},
-	(const phy_cmd_t []) {  /* startup */
-		/* restart auto-negotiation */
-		{ mk_mii_write(MII_BMCR, BMCR_ANENABLE | BMCR_ANRESTART),
-			NULL },
-		{ mk_mii_end, }
-	},
-	(const phy_cmd_t []) { /* ack_int */
-		/* We don't actually use the ack_int table with a generic
-		 * PHY, but putting a reference to mii_parse_sr here keeps
-		 * us from getting a compiler warning about unused static
-		 * functions in the case where we only compile in generic
-		 * PHY support.
-		 */
-		{ mk_mii_read(MII_BMSR), mii_parse_sr },
-		{ mk_mii_end, }
-	},
-	(const phy_cmd_t []) {  /* shutdown */
-		{ mk_mii_end, }
-	},
-};
-#endif	/* ifdef CONFIG_FCC_GENERIC_PHY */
-
 /* ------------------------------------------------------------------------- */
 /* The Level one LXT970 is used by many boards				     */
 
@@ -955,26 +867,26 @@
 
 	(const phy_cmd_t []) {  /* config */
 #if 0
-//		{ mk_mii_write(MII_ADVERTISE, 0x0021), NULL },
+//		{ mk_mii_write(MII_REG_ANAR, 0x0021), NULL },
 
 		/* Set default operation of 100-TX....for some reason
 		 * some of these bits are set on power up, which is wrong.
 		 */
 		{ mk_mii_write(MII_LXT970_CONFIG, 0), NULL },
 #endif
-		{ mk_mii_read(MII_BMCR), mii_parse_cr },
-		{ mk_mii_read(MII_ADVERTISE), mii_parse_anar },
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) {  /* startup - enable interrupts */
 		{ mk_mii_write(MII_LXT970_IER, 0x0002), NULL },
-		{ mk_mii_write(MII_BMCR, 0x1200), NULL }, /* autonegotiate */
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) { /* ack_int */
 		/* read SR and ISR to acknowledge */
 
-		{ mk_mii_read(MII_BMSR), mii_parse_sr },
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
 		{ mk_mii_read(MII_LXT970_ISR), NULL },
 
 		/* find out the current status */
@@ -1039,29 +951,30 @@
 	"LXT971",
 
 	(const phy_cmd_t []) {  /* config */
-		/* configure link capabilities to advertise */
-		{ mk_mii_write(MII_ADVERTISE, MII_ADVERTISE_DEFAULT),
-			mii_parse_anar },
-
-		/* enable auto-negotiation */
-		{ mk_mii_write(MII_BMCR, BMCR_ANENABLE), mii_parse_cr },
+//		{ mk_mii_write(MII_REG_ANAR, 0x021), NULL }, /* 10  Mbps, HD */
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) {  /* startup - enable interrupts */
 		{ mk_mii_write(MII_LXT971_IER, 0x00f2), NULL },
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
 
-		/* restart auto-negotiation */
-		{ mk_mii_write(MII_BMCR, BMCR_ANENABLE | BMCR_ANRESTART),
-			NULL },
+		/* Somehow does the 971 tell me that the link is down
+		 * the first read after power-up.
+		 * read here to get a valid value in ack_int */
+
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) { /* ack_int */
 		/* find out the current status */
-		{ mk_mii_read(MII_BMSR), NULL },
-		{ mk_mii_read(MII_BMSR), mii_parse_sr },
+
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
 		{ mk_mii_read(MII_LXT971_SR2), mii_parse_lxt971_sr2 },
 
 		/* we only need to read ISR to acknowledge */
+
 		{ mk_mii_read(MII_LXT971_ISR), NULL },
 		{ mk_mii_end, }
 	},
@@ -1071,7 +984,8 @@
 	},
 };
 
-#endif /* CONFIG_FCC_LXT971 */
+#endif /* CONFIG_FEC_LXT970 */
+
 
 /* ------------------------------------------------------------------------- */
 /* The Quality Semiconductor QS6612 is used on the RPX CLLF                  */
@@ -1109,7 +1023,7 @@
 	"QS6612",
 
 	(const phy_cmd_t []) {  /* config */
-//	{ mk_mii_write(MII_ADVERTISE, 0x061), NULL }, /* 10  Mbps */
+//	{ mk_mii_write(MII_REG_ANAR, 0x061), NULL }, /* 10  Mbps */
 
 		/* The PHY powers up isolated on the RPX,
 		 * so send a command to allow operation.
@@ -1119,13 +1033,13 @@
 
 		/* parse cr and anar to get some info */
 
-		{ mk_mii_read(MII_BMCR), mii_parse_cr },
-		{ mk_mii_read(MII_ADVERTISE), mii_parse_anar },
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) {  /* startup - enable interrupts */
 		{ mk_mii_write(MII_QS6612_IMR, 0x003a), NULL },
-		{ mk_mii_write(MII_BMCR, 0x1200), NULL }, /* autonegotiate */
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) { /* ack_int */
@@ -1133,8 +1047,8 @@
 		/* we need to read ISR, SR and ANER to acknowledge */
 
 		{ mk_mii_read(MII_QS6612_ISR), NULL },
-		{ mk_mii_read(MII_BMSR), mii_parse_sr },
-		{ mk_mii_read(MII_EXPANSION), NULL },
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_read(MII_REG_ANER), NULL },
 
 		/* read pcr to get info */
 
@@ -1188,13 +1102,13 @@
 
 	(const phy_cmd_t []) {  /* config */
 		/* parse cr and anar to get some info */
-		{ mk_mii_read(MII_BMCR), mii_parse_cr },
-		{ mk_mii_read(MII_ADVERTISE), mii_parse_anar },
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) {  /* startup - enable interrupts */
 		{ mk_mii_write(MII_DM9131_INTR, 0x0002), NULL },
-		{ mk_mii_write(MII_BMCR, 0x1200), NULL }, /* autonegotiate */
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
 		{ mk_mii_end, }
 	},
 	(const phy_cmd_t []) { /* ack_int */
@@ -1202,8 +1116,8 @@
 		/* we need to read INTR, SR and ANER to acknowledge */
 
 		{ mk_mii_read(MII_DM9131_INTR), NULL },
-		{ mk_mii_read(MII_BMSR), mii_parse_sr },
-		{ mk_mii_read(MII_EXPANSION), NULL },
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_read(MII_REG_ANER), NULL },
 
 		/* read acsr to get info */
 
@@ -1218,147 +1132,7 @@
 
 
 #endif /* CONFIG_FEC_DM9131 */
-#ifdef CONFIG_FCC_DM9161
-/* ------------------------------------------------------------------------- */
-/* DM9161 Control register values */
-#define MIIM_DM9161_CR_STOP     0x0400
-#define MIIM_DM9161_CR_RSTAN    0x1200
-
-#define MIIM_DM9161_SCR         0x10
-#define MIIM_DM9161_SCR_INIT    0x0610
-
-/* DM9161 Specified Configuration and Status Register */
-#define MIIM_DM9161_SCSR        0x11
-#define MIIM_DM9161_SCSR_100F   0x8000
-#define MIIM_DM9161_SCSR_100H   0x4000
-#define MIIM_DM9161_SCSR_10F    0x2000
-#define MIIM_DM9161_SCSR_10H    0x1000
-/* DM9161 10BT register */
-#define MIIM_DM9161_10BTCSR 	0x12
-#define MIIM_DM9161_10BTCSR_INIT 0x7800
-/* DM9161 Interrupt Register */
-#define MIIM_DM9161_INTR        0x15
-#define MIIM_DM9161_INTR_PEND           0x8000
-#define MIIM_DM9161_INTR_DPLX_MASK      0x0800
-#define MIIM_DM9161_INTR_SPD_MASK       0x0400
-#define MIIM_DM9161_INTR_LINK_MASK      0x0200
-#define MIIM_DM9161_INTR_MASK           0x0100
-#define MIIM_DM9161_INTR_DPLX_CHANGE    0x0010
-#define MIIM_DM9161_INTR_SPD_CHANGE     0x0008
-#define MIIM_DM9161_INTR_LINK_CHANGE    0x0004
-#define MIIM_DM9161_INTR_INIT           0x0000
-#define MIIM_DM9161_INTR_STOP   \
-(MIIM_DM9161_INTR_DPLX_MASK | MIIM_DM9161_INTR_SPD_MASK \
-  | MIIM_DM9161_INTR_LINK_MASK | MIIM_DM9161_INTR_MASK)
-
-static void mii_parse_dm9161_sr(uint mii_reg, struct net_device * dev)
-{
-	volatile struct fcc_enet_private *fep = dev->priv;
-	uint regstat,  timeout=0xffff;
-	
-	while(!(mii_reg & 0x0020) && timeout--)
-	{
-		regstat=mk_mii_read(MII_BMSR);
-	        regstat |= fep->phy_addr <<23;
-	        mii_reg = mii_send_receive(fep->fip,regstat);
-	}
-				
-	mii_parse_sr(mii_reg, dev);
-}
-
-static void mii_parse_dm9161_scsr(uint mii_reg, struct net_device * dev)
-{
-	volatile struct fcc_enet_private *fep = dev->priv;
-	uint s = fep->phy_status;
-
-	s &= ~(PHY_STAT_SPMASK); 
-	switch((mii_reg >>12) & 0xf) {
-		case 1: 
-		{
-			s |= PHY_STAT_10HDX;
-			printk("10BaseT Half Duplex\n");
-			break;
-		}
-		case 2:
-		{
-			s |= PHY_STAT_10FDX;
-		        printk("10BaseT Full Duplex\n");
-			break;
-		}
-		case 4:
-	        {
-			s |= PHY_STAT_100HDX;
-		        printk("100BaseT Half Duplex\n");
-			break;
-		}
-		case 8: 
-		{
-			s |= PHY_STAT_100FDX; 
-			printk("100BaseT Full Duplex\n");
-			break;
-		}
-	}
-
-	fep->phy_status = s;
-	
-}
 
-static void mii_dm9161_wait(uint mii_reg, struct net_device *dev)
-{
-	int timeout = HZ;
-
-	/* Davicom takes a bit to come up after a reset,
-	 * so wait here for a bit */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(timeout);
-}
-
-static phy_info_t phy_info_dm9161 = {
-        0x00181b88,
-        "Davicom DM9161E",
-        (const phy_cmd_t[]) { /* config */
-                { mk_mii_write(MII_BMCR, MIIM_DM9161_CR_STOP), NULL}, 
-                /* Do not bypass the scrambler/descrambler */
-                { mk_mii_write(MIIM_DM9161_SCR, MIIM_DM9161_SCR_INIT), NULL},
-		/* Configure 10BTCSR register */
-		{ mk_mii_write(MIIM_DM9161_10BTCSR, MIIM_DM9161_10BTCSR_INIT),NULL}, 
-                /* Configure some basic stuff */
-                { mk_mii_write(MII_BMCR, 0x1000), NULL},
-		{ mk_mii_read(MII_BMCR), mii_parse_cr },
-		{ mk_mii_read(MII_ADVERTISE), mii_parse_anar },
-		{ mk_mii_end,} 
-        },
-       (const phy_cmd_t[]) { /* startup */
-                /* Restart Auto Negotiation */
-                { mk_mii_write(MII_BMCR, MIIM_DM9161_CR_RSTAN), NULL}, 
-                /* Status is read once to clear old link state */
-                { mk_mii_read(MII_BMSR), mii_dm9161_wait},
-                /* Auto-negotiate */
-                { mk_mii_read(MII_BMSR), mii_parse_dm9161_sr},
-                /* Read the status */
-                { mk_mii_read(MIIM_DM9161_SCSR), mii_parse_dm9161_scsr},
-                /* Clear any pending interrupts */
-                { mk_mii_read(MIIM_DM9161_INTR), NULL},
-                /* Enable Interrupts */
-                { mk_mii_write(MIIM_DM9161_INTR, MIIM_DM9161_INTR_INIT), NULL}, 
-                { mk_mii_end,}
-        },
-       (const phy_cmd_t[]) { /* ack_int */
-                { mk_mii_read(MIIM_DM9161_INTR), NULL},
-#if 0
-		{ mk_mii_read(MII_BMSR), NULL},
-		{ mk_mii_read(MII_BMSR), mii_parse_dm9161_sr},
-		{ mk_mii_read(MIIM_DM9161_SCSR), mii_parse_dm9161_scsr},
-#endif
-                { mk_mii_end,}
-        },
-        (const phy_cmd_t[]) { /* shutdown */
-	        { mk_mii_read(MIIM_DM9161_INTR),NULL}, 
-                { mk_mii_write(MIIM_DM9161_INTR, MIIM_DM9161_INTR_STOP), NULL}, 
-	        { mk_mii_end,}
-	},
-};
-#endif /* CONFIG_FCC_DM9161 */
 
 static phy_info_t *phy_info[] = {
 
@@ -1378,24 +1152,11 @@
 	&phy_info_dm9131,
 #endif /* CONFIG_FEC_DM9131 */
 
-#ifdef CONFIG_FCC_DM9161
-	&phy_info_dm9161,
-#endif /* CONFIG_FCC_DM9161 */
-
-#ifdef CONFIG_FCC_GENERIC_PHY
-	/* Generic PHY support.  This must be the last PHY in the table.
-	 * It will be used to support any PHY that doesn't match a previous
-	 * entry in the table.
-	 */
-	&phy_info_generic,
-#endif /* CONFIG_FCC_GENERIC_PHY */
-
 	NULL
 };
 
-static void mii_display_status(void *data)
+static void mii_display_status(struct net_device *dev)
 {
-	struct net_device *dev = data;
 	volatile struct fcc_enet_private *fep = dev->priv;
 	uint s = fep->phy_status;
 
@@ -1430,9 +1191,8 @@
 	printk(".\n");
 }
 
-static void mii_display_config(void *data)
+static void mii_display_config(struct net_device *dev)
 {
-	struct net_device *dev = data;
 	volatile struct fcc_enet_private *fep = dev->priv;
 	uint s = fep->phy_status;
 
@@ -1465,23 +1225,20 @@
 static void mii_relink(struct net_device *dev)
 {
 	struct fcc_enet_private *fep = dev->priv;
-	int duplex = 0;
+	int duplex;
 
-	fep->old_link = fep->link;
 	fep->link = (fep->phy_status & PHY_STAT_LINK) ? 1 : 0;
-
-#ifdef MDIO_DEBUG
-	printk("  mii_relink:  link=%d\n", fep->link);
-#endif
+	mii_display_status(dev);
+	fep->old_link = fep->link;
 
 	if (fep->link) {
+		duplex = 0;
 		if (fep->phy_status
 		    & (PHY_STAT_100FDX | PHY_STAT_10FDX))
 			duplex = 1;
 		fcc_restart(dev, duplex);
-#ifdef MDIO_DEBUG
-		printk("  mii_relink:  duplex=%d\n", duplex);
-#endif
+	} else {
+		fcc_stop(dev);
 	}
 }
 
@@ -1489,21 +1246,25 @@
 {
 	struct fcc_enet_private *fep = dev->priv;
 
-	mii_relink(dev);
-
-	schedule_work(&fep->phy_relink);
+	fep->phy_task.routine = (void *)mii_relink;
+	fep->phy_task.data = dev;
+	schedule_task(&fep->phy_task);
 }
 
 static void mii_queue_config(uint mii_reg, struct net_device *dev)
 {
 	struct fcc_enet_private *fep = dev->priv;
 
-	schedule_work(&fep->phy_display_config);
+	fep->phy_task.routine = (void *)mii_display_config;
+	fep->phy_task.data = dev;
+	schedule_task(&fep->phy_task);
 }
 
-phy_cmd_t phy_cmd_relink[] = { { mk_mii_read(MII_BMCR), mii_queue_relink },
+
+
+phy_cmd_t phy_cmd_relink[] = { { mk_mii_read(MII_REG_CR), mii_queue_relink },
 			       { mk_mii_end, } };
-phy_cmd_t phy_cmd_config[] = { { mk_mii_read(MII_BMCR), mii_queue_config },
+phy_cmd_t phy_cmd_config[] = { { mk_mii_read(MII_REG_CR), mii_queue_config },
 			       { mk_mii_end, } };
 
 
@@ -1516,11 +1277,10 @@
 	int	i;
 
 	fep = dev->priv;
-	printk("mii_reg: %08x\n", mii_reg);
 	fep->phy_id |= (mii_reg & 0xffff);
 
 	for(i = 0; phy_info[i]; i++)
-		if((phy_info[i]->id == (fep->phy_id >> 4)) || !phy_info[i]->id)
+		if(phy_info[i]->id == (fep->phy_id >> 4))
 			break;
 
 	if(!phy_info[i])
@@ -1528,7 +1288,6 @@
 		      dev->name, fep->phy_id);
 
 	fep->phy = phy_info[i];
-	fep->phy_id_done = 1;
 
 	printk("%s: Phy @ 0x%x, type %s (0x%08x)\n",
 		dev->name, fep->phy_addr, fep->phy->name, fep->phy_id);
@@ -1545,49 +1304,36 @@
 
 	fep = dev->priv;
 
-	if ((phytype = (mii_reg & 0xffff)) != 0xffff) {
+	if ((phytype = (mii_reg & 0xfff)) != 0xfff) {
 
 		/* Got first part of ID, now get remainder. */
 		fep->phy_id = phytype << 16;
-		mii_queue(dev, mk_mii_read(MII_PHYSID2), mii_discover_phy3);
+		mii_queue(dev, mk_mii_read(MII_REG_PHYIR2), mii_discover_phy3);
 	} else {
 		fep->phy_addr++;
 		if (fep->phy_addr < 32) {
-			mii_queue(dev, mk_mii_read(MII_PHYSID1),
+			mii_queue(dev, mk_mii_read(MII_REG_PHYIR1),
 							mii_discover_phy);
 		} else {
 			printk("fec: No PHY device found.\n");
 		}
 	}
 }
-#endif	/* CONFIG_USE_MDIO */
 
-#ifdef PHY_INTERRUPT
 /* This interrupt occurs when the PHY detects a link change. */
 static irqreturn_t
 mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
 {
 	struct	net_device *dev = dev_id;
 	struct fcc_enet_private *fep = dev->priv;
-	fcc_info_t *fip = fep->fip;
 
-	if (fep->phy) {
-		/* We don't want to be interrupted by an FCC
-		 * interrupt here.
-		 */
-		disable_irq_nosync(fip->fc_interrupt);
-
-		mii_do_cmd(dev, fep->phy->ack_int);
-		/* restart and display status */
-		mii_do_cmd(dev, phy_cmd_relink);
-
-		enable_irq(fip->fc_interrupt);
-	}
+	mii_do_cmd(dev, fep->phy->ack_int);
+	mii_do_cmd(dev, phy_cmd_relink);  /* restart and display status */
 	return IRQ_HANDLED;
 }
-#endif	/* ifdef PHY_INTERRUPT */
 
-#if 0 /* This should be fixed someday */
+#endif	/* CONFIG_USE_MDIO */
+
 /* Set or clear the multicast filter for this adaptor.
  * Skeleton taken from sunlance driver.
  * The CPM Ethernet implementation allows Multicast as well as individual
@@ -1637,8 +1383,8 @@
 
 			dmi = dev->mc_list;
 
-			for (i=0; i<dev->mc_count; i++, dmi = dmi->next) {
-				
+			for (i=0; i<dev->mc_count; i++) {
+		
 				/* Only support group multicast for now.
 				*/
 				if (!(dmi->dmi_addr[0] & 1))
@@ -1665,7 +1411,6 @@
 		}
 	}
 }
-#endif /* if 0 */
 
 
 /* Set the individual MAC address.
@@ -1737,7 +1482,7 @@
 		dev->watchdog_timeo = TX_TIMEOUT;
 		dev->stop = fcc_enet_close;
 		dev->get_stats = fcc_enet_get_stats;
-		/* dev->set_multicast_list = set_multicast_list; */
+		dev->set_multicast_list = set_multicast_list;
 		dev->set_mac_address = fcc_enet_set_mac_address;
 
 		init_fcc_startup(fip, dev);
@@ -1757,11 +1502,8 @@
 		/* Queue up command to detect the PHY and initialize the
 	 	* remainder of the interface.
 	 	*/
-		cep->phy_id_done = 0;
-		cep->phy_addr = fip->fc_phyaddr;
-		mii_queue(dev, mk_mii_read(MII_PHYSID1), mii_discover_phy);
-		INIT_WORK(&cep->phy_relink, mii_display_status, dev);
-		INIT_WORK(&cep->phy_display_config, mii_display_config, dev);
+		cep->phy_addr = 0;
+		mii_queue(dev, mk_mii_read(MII_REG_PHYIR1), mii_discover_phy);
 #endif	/* CONFIG_USE_MDIO */
 
 		fip++;
@@ -1807,36 +1549,29 @@
 	if (fip->fc_proff == PROFF_FCC1) {
 		/* Configure port A and C pins for FCC1 Ethernet.
 		 */
-		io->iop_pdira &= ~PA1_DIRA_BOUT;
-		io->iop_pdira |= PA1_DIRA_BIN;
-		io->iop_psora &= ~PA1_PSORA_BOUT;
-		io->iop_psora |= PA1_PSORA_BIN;
-		io->iop_ppara |= (PA1_DIRA_BOUT | PA1_DIRA_BIN);
+		io->iop_pdira &= ~PA1_DIRA0;
+		io->iop_pdira |= PA1_DIRA1;
+		io->iop_psora &= ~PA1_PSORA0;
+		io->iop_psora |= PA1_PSORA1;
+		io->iop_ppara |= (PA1_DIRA0 | PA1_DIRA1);
 	}
 	if (fip->fc_proff == PROFF_FCC2) {
 		/* Configure port B and C pins for FCC Ethernet.
 		 */
-		io->iop_pdirb &= ~PB2_DIRB_BOUT;
-		io->iop_pdirb |= PB2_DIRB_BIN;
-		io->iop_psorb &= ~PB2_PSORB_BOUT;
-		io->iop_psorb |= PB2_PSORB_BIN;
-		io->iop_pparb |= (PB2_DIRB_BOUT | PB2_DIRB_BIN);
+		io->iop_pdirb &= ~PB2_DIRB0;
+		io->iop_pdirb |= PB2_DIRB1;
+		io->iop_psorb &= ~PB2_PSORB0;
+		io->iop_psorb |= PB2_PSORB1;
+		io->iop_pparb |= (PB2_DIRB0 | PB2_DIRB1);
 	}
 	if (fip->fc_proff == PROFF_FCC3) {
 		/* Configure port B and C pins for FCC Ethernet.
 		 */
-		io->iop_pdirb &= ~PB3_DIRB_BOUT;
-		io->iop_pdirb |= PB3_DIRB_BIN;
-		io->iop_psorb &= ~PB3_PSORB_BOUT;
-		io->iop_psorb |= PB3_PSORB_BIN;
-		io->iop_pparb |= (PB3_DIRB_BOUT | PB3_DIRB_BIN);
-
-		io->iop_pdirc &= ~PC3_DIRC_BOUT;
-		io->iop_pdirc |= PC3_DIRC_BIN;
-		io->iop_psorc &= ~PC3_PSORC_BOUT;
-		io->iop_psorc |= PC3_PSORC_BIN;
-		io->iop_pparc |= (PC3_DIRC_BOUT | PC3_DIRC_BIN);
-
+		io->iop_pdirb &= ~PB3_DIRB0;
+		io->iop_pdirb |= PB3_DIRB1;
+		io->iop_psorb &= ~PB3_PSORB0;
+		io->iop_psorb |= PB3_PSORB1;
+		io->iop_pparb |= (PB3_DIRB0 | PB3_DIRB1);
 	}
 
 	/* Port C has clocks......
@@ -1964,11 +1699,6 @@
 	 */
 	eap = (unsigned char *)&(ep->fen_paddrh);
 	for (i=5; i>=0; i--) {
-
-/* 
- * The EP8260 only uses FCC3, so we can safely give it the real
- * MAC address.
- */
 #ifdef CONFIG_SBC82xx
 		if (i == 5) {
 			/* bd->bi_enetaddr holds the SCC0 address; the FCC
@@ -1978,17 +1708,15 @@
 			*eap++ = dev->dev_addr[i];
 		}
 #else
-#ifndef CONFIG_RPX8260
 		if (i == 3) {
 			dev->dev_addr[i] = bd->bi_enetaddr[i];
 			dev->dev_addr[i] |= (1 << (7 - fip->fc_fccnum));
 			*eap++ = dev->dev_addr[i];
-		} else
+		}
 #endif
-		{
+		else {
 			*eap++ = dev->dev_addr[i] = bd->bi_enetaddr[i];
 		}
-#endif
 	}
 
 	ep->fen_taddrh = 0;
@@ -2070,6 +1798,7 @@
 	while (cp->cp_cpcr & CPM_CR_FLG);
 
 	cep->skb_cur = cep->skb_dirty = 0;
+	atomic_set(&cep->n_pkts, 0);
 }
 
 /* Let 'er rip.
@@ -2083,56 +1812,25 @@
 	cep = (struct fcc_enet_private *)(dev->priv);
 	fccp = cep->fccp;
 
-#ifdef CONFIG_RPX8260
-#ifdef PHY_INTERRUPT
-	/* Route PHY interrupt to IRQ.  The following code only works for
-	 * IRQ1 - IRQ7.  It does not work for Port C interrupts.
-	 */
-	*((volatile u_char *) (RPX_CSR_ADDR + 13)) &= ~BCSR13_FETH_IRQMASK;
-	*((volatile u_char *) (RPX_CSR_ADDR + 13)) |=
-		((PHY_INTERRUPT - SIU_INT_IRQ1 + 1) << 4);
-#endif
-	/* Initialize MDIO pins. */
-	*((volatile u_char *) (RPX_CSR_ADDR + 4)) &= ~BCSR4_MII_MDC;
-	*((volatile u_char *) (RPX_CSR_ADDR + 4)) |=
-		BCSR4_MII_READ | BCSR4_MII_MDIO;
-	/* Enable external LXT971 PHY. */
-	*((volatile u_char *) (RPX_CSR_ADDR + 4)) |= BCSR4_EN_PHY;
-	udelay(1000);
-	*((volatile u_char *) (RPX_CSR_ADDR+ 4)) |= BCSR4_EN_MII;
-	udelay(1000);
-#endif	/* ifdef CONFIG_RPX8260 */
-
 	fccp->fcc_fcce = 0xffff;	/* Clear any pending events */
 
-	/* Leave FCC interrupts masked for now.  Will be unmasked by
-	 * fcc_restart().
+	/* Enable interrupts for transmit error, complete frame
+	 * received, and any transmit buffer we have also set the
+	 * interrupt flag.
 	 */
-	fccp->fcc_fccm = 0;
+	fccp->fcc_fccm = (FCC_ENET_TXE | FCC_ENET_RXF | FCC_ENET_TXB);
 
 	/* Install our interrupt handler.
 	*/
-	if (request_irq(fip->fc_interrupt, fcc_enet_interrupt, 0, "fenet",
-				dev) < 0)
+	if (request_irq(fip->fc_interrupt, fcc_enet_interrupt, 0,
+							"fenet", dev) < 0)
 		printk("Can't get FCC IRQ %d\n", fip->fc_interrupt);
 
-#ifdef	PHY_INTERRUPT
-#ifdef CONFIG_ADS8272
-	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, SA_SHIRQ,
-				"mii", dev) < 0)
-		printk(KERN_CRIT "Can't get MII IRQ %d\n", PHY_INTERRUPT);
-#else
-	/* Make IRQn edge triggered.  This does not work if PHY_INTERRUPT is
-	 * on Port C.
-	 */
-	((volatile cpm2_map_t *) CPM_MAP_ADDR)->im_intctl.ic_siexr |=
-		(1 << (14 - (PHY_INTERRUPT - SIU_INT_IRQ1)));
-
+#ifdef	CONFIG_USE_MDIO
 	if (request_irq(PHY_INTERRUPT, mii_link_interrupt, 0,
 							"mii", dev) < 0)
-		printk(KERN_CRIT "Can't get MII IRQ %d\n", PHY_INTERRUPT);
-#endif
-#endif	/* PHY_INTERRUPT */
+		printk("Can't get MII IRQ %d\n", fip->fc_interrupt);
+#endif	/* CONFIG_USE_MDIO */
 
 	/* Set GFMR to enable Ethernet operating mode.
 	 */
@@ -2149,14 +1847,10 @@
 	fccp->fcc_fpsmr = FCC_PSMR_ENCRC;
 
 #ifdef CONFIG_PQ2ADS
-	/* Enable the PHY. */
-	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
-	*(volatile uint *)(BCSR_ADDR + 4) |=  BCSR1_FETH_RST;
-#endif
-#if defined(CONFIG_PQ2ADS) || defined(CONFIG_PQ2FADS)
-	/* Enable the 2nd PHY. */
-	*(volatile uint *)(BCSR_ADDR + 12) &= ~BCSR3_FETHIEN2;
-	*(volatile uint *)(BCSR_ADDR + 12) |=  BCSR3_FETH2_RST;
+	/* Enable the PHY.
+	*/
+        *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
+        *(volatile uint *)(BCSR_ADDR + 4) |=  BCSR1_FETH_RST;
 #endif
 
 #if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
@@ -2178,74 +1872,54 @@
  * I wonder what "they" were thinking (maybe weren't) when they leave
  * the I2C in the CPM but I have to toggle these bits......
  */
-#ifdef CONFIG_RPX8260
-	/* The EP8260 has the MDIO pins in a BCSR instead of on Port C
-	 * like most other boards.
-	 */
-#define MDIO_ADDR ((volatile u_char *)(RPX_CSR_ADDR + 4))
-#define MAKE_MDIO_OUTPUT *MDIO_ADDR &= ~BCSR4_MII_READ
-#define MAKE_MDIO_INPUT  *MDIO_ADDR |=  BCSR4_MII_READ | BCSR4_MII_MDIO
-#define OUT_MDIO(bit)				\
-	if (bit)				\
-		*MDIO_ADDR |=  BCSR4_MII_MDIO;	\
-	else					\
-		*MDIO_ADDR &= ~BCSR4_MII_MDIO;
-#define IN_MDIO (*MDIO_ADDR & BCSR4_MII_MDIO)
-#define OUT_MDC(bit)				\
-	if (bit)				\
-		*MDIO_ADDR |=  BCSR4_MII_MDC;	\
-	else					\
-		*MDIO_ADDR &= ~BCSR4_MII_MDC;
-#else	/* ifdef CONFIG_RPX8260 */
-	/* This is for the usual case where the MDIO pins are on Port C.
-	 */
-#define MDIO_ADDR (((volatile cpm2_map_t *)CPM_MAP_ADDR)->im_ioport)
-#define MAKE_MDIO_OUTPUT MDIO_ADDR.iop_pdirc |= fip->fc_mdio
-#define MAKE_MDIO_INPUT MDIO_ADDR.iop_pdirc &= ~fip->fc_mdio
-#define OUT_MDIO(bit)				\
-	if (bit)				\
-		MDIO_ADDR.iop_pdatc |= fip->fc_mdio;	\
-	else					\
-		MDIO_ADDR.iop_pdatc &= ~fip->fc_mdio;
-#define IN_MDIO ((MDIO_ADDR.iop_pdatc) & fip->fc_mdio)
-#define OUT_MDC(bit)				\
-	if (bit)				\
-		MDIO_ADDR.iop_pdatc |= fip->fc_mdck;	\
-	else					\
-		MDIO_ADDR.iop_pdatc &= ~fip->fc_mdck;
-#endif	/* ifdef CONFIG_RPX8260 */
+
+#define FCC_PDATC_MDIO(bit)					\
+	if (bit)						\
+		io->iop_pdatc |= fip->fc_mdio;			\
+	else							\
+		io->iop_pdatc &= ~fip->fc_mdio;
+
+#define FCC_PDATC_MDC(bit)					\
+	if (bit)						\
+		io->iop_pdatc |= fip->fc_mdck;			\
+	else							\
+		io->iop_pdatc &= ~fip->fc_mdck;
 
 static uint
 mii_send_receive(fcc_info_t *fip, uint cmd)
 {
 	uint		retval;
 	int		read_op, i, off;
-	const int	us = 1;
+	volatile	cpm2_map_t		*immap;
+	volatile	iop_cpm2_t	*io;
+
+	immap = (cpm2_map_t *)CPM_MAP_ADDR;
+	io = &immap->im_ioport;
+
+	io->iop_pdirc |= (fip->fc_mdio | fip->fc_mdck);
 
 	read_op = ((cmd & 0xf0000000) == 0x60000000);
 
 	/* Write preamble
 	 */
-	OUT_MDIO(1);
-	MAKE_MDIO_OUTPUT;
-	OUT_MDIO(1);
 	for (i = 0; i < 32; i++)
 	{
-		udelay(us);
-		OUT_MDC(1);
-		udelay(us);
-		OUT_MDC(0);
+		FCC_PDATC_MDC(0);
+		FCC_PDATC_MDIO(1);
+		udelay(1);
+		FCC_PDATC_MDC(1);
+		udelay(1);
 	}
 
 	/* Write data
 	 */
 	for (i = 0, off = 31; i < (read_op ? 14 : 32); i++, --off)
 	{
-		OUT_MDIO((cmd >> off) & 0x00000001);
-		udelay(us);
-		OUT_MDC(1);
-		udelay(us);
-		OUT_MDC(0);
+		FCC_PDATC_MDC(0);
+		FCC_PDATC_MDIO((cmd >> off) & 0x00000001);
+		udelay(1);
+		FCC_PDATC_MDC(1);
+		udelay(1);
 	}
 
 	retval = cmd;
@@ -2254,111 +1928,68 @@
 	{
 		retval >>= 16;
 
-		MAKE_MDIO_INPUT;
-		udelay(us);
-		OUT_MDC(1);
-		udelay(us);
-		OUT_MDC(0);
+		FCC_PDATC_MDC(0);
+		io->iop_pdirc &= ~fip->fc_mdio;
+		udelay(1);
+		FCC_PDATC_MDC(1);
+		udelay(1);
+		FCC_PDATC_MDC(0);
+		udelay(1);
 
-		for (i = 0; i < 16; i++)
+		for (i = 0, off = 15; i < 16; i++, off--)
 		{
-			udelay(us);
-			OUT_MDC(1);
-			udelay(us);
+			FCC_PDATC_MDC(1);
 			retval <<= 1;
-			if (IN_MDIO)
+			if (io->iop_pdatc & fip->fc_mdio)
 				retval++;
-			OUT_MDC(0);
+			udelay(1);
+			FCC_PDATC_MDC(0);
+			udelay(1);
 		}
 	}
 
-	MAKE_MDIO_INPUT;
-	udelay(us);
-	OUT_MDC(1);
-	udelay(us);
-	OUT_MDC(0);
+	io->iop_pdirc |= (fip->fc_mdio | fip->fc_mdck);
+
+	for (i = 0; i < 32; i++)
+	{
+		FCC_PDATC_MDC(0);
+		FCC_PDATC_MDIO(1);
+		udelay(1);
+		FCC_PDATC_MDC(1);
+		udelay(1);
+	}
 
 	return retval;
 }
-#endif	/* CONFIG_USE_MDIO */
 
 static void
 fcc_stop(struct net_device *dev)
 {
-	struct fcc_enet_private	*fep= (struct fcc_enet_private *)(dev->priv);
-	volatile fcc_t	*fccp = fep->fccp;
-	fcc_info_t *fip = fep->fip;
-	volatile fcc_enet_t *ep = fep->ep;
-	volatile cpm_cpm2_t *cp = cpmp;
-	volatile cbd_t *bdp;
-	int i;
-
-	if ((fccp->fcc_gfmr & (FCC_GFMR_ENR | FCC_GFMR_ENT)) == 0)
-		return;	/* already down */
-
-	fccp->fcc_fccm = 0;
+	volatile fcc_t	*fccp;
+	struct fcc_enet_private	*fcp;
 
-	/* issue the graceful stop tx command */
-	while (cp->cp_cpcr & CPM_CR_FLG);
-	cp->cp_cpcr = mk_cr_cmd(fip->fc_cpmpage, fip->fc_cpmblock,
-				0x0c, CPM_CR_GRA_STOP_TX) | CPM_CR_FLG;
-	while (cp->cp_cpcr & CPM_CR_FLG);
+	fcp = (struct fcc_enet_private *)(dev->priv);
+	fccp = fcp->fccp;
 
 	/* Disable transmit/receive */
 	fccp->fcc_gfmr &= ~(FCC_GFMR_ENR | FCC_GFMR_ENT);
-
-	/* issue the restart tx command */
-	fccp->fcc_fcce = FCC_ENET_GRA;
-	while (cp->cp_cpcr & CPM_CR_FLG);
-	cp->cp_cpcr = mk_cr_cmd(fip->fc_cpmpage, fip->fc_cpmblock,
-				0x0c, CPM_CR_RESTART_TX) | CPM_CR_FLG;
-	while (cp->cp_cpcr & CPM_CR_FLG);
-
-	/* free tx buffers */
-	fep->skb_cur = fep->skb_dirty = 0;
-	for (i=0; i<=TX_RING_MOD_MASK; i++) {
-		if (fep->tx_skbuff[i] != NULL) {
-			dev_kfree_skb(fep->tx_skbuff[i]);
-			fep->tx_skbuff[i] = NULL;
-		}
-	}
-	fep->dirty_tx = fep->cur_tx = fep->tx_bd_base;
-	fep->tx_free = TX_RING_SIZE;
-	ep->fen_genfcc.fcc_tbptr = ep->fen_genfcc.fcc_tbase;
-
-	/* Initialize the tx buffer descriptors. */
-	bdp = fep->tx_bd_base;
-	for (i=0; i<TX_RING_SIZE; i++) {
-		bdp->cbd_sc = 0;
-		bdp->cbd_datlen = 0;
-		bdp->cbd_bufaddr = 0;
-		bdp++;
-	}
-	/* Set the last buffer to wrap. */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
 }
+#endif	/* CONFIG_USE_MDIO */
 
 static void
 fcc_restart(struct net_device *dev, int duplex)
 {
-	struct fcc_enet_private	*fep = (struct fcc_enet_private *)(dev->priv);
-	volatile fcc_t	*fccp = fep->fccp;
+	volatile fcc_t	*fccp;
+	struct fcc_enet_private	*fcp;
 
-	/* stop any transmissions in progress */
-	fcc_stop(dev);
+	fcp = (struct fcc_enet_private *)(dev->priv);
+	fccp = fcp->fccp;
 
 	if (duplex)
 		fccp->fcc_fpsmr |= FCC_PSMR_FDE | FCC_PSMR_LPB;
 	else
 		fccp->fcc_fpsmr &= ~(FCC_PSMR_FDE | FCC_PSMR_LPB);
 
-	/* Enable interrupts for transmit error, complete frame
-	 * received, and any transmit buffer we have also set the
-	 * interrupt flag.
-	 */
-	fccp->fcc_fccm = (FCC_ENET_TXE | FCC_ENET_RXF | FCC_ENET_TXB);
-
 	/* Enable transmit/receive */
 	fccp->fcc_gfmr |= FCC_GFMR_ENR | FCC_GFMR_ENT;
 }
@@ -2373,7 +2004,6 @@
 	fep->link = 0;
 
 	if (fep->phy) {
-		fcc_restart(dev, 0);	/* always start in half-duplex */
 		mii_do_cmd(dev, fep->phy->ack_int);
 		mii_do_cmd(dev, fep->phy->config);
 		mii_do_cmd(dev, phy_cmd_config);  /* display configuration */
@@ -2387,7 +2017,6 @@
 	return -ENODEV;		/* No PHY we understand */
 #else
 	fep->link = 1;
-	fcc_restart(dev, 0);	/* always start in half-duplex */
 	netif_start_queue(dev);
 	return 0;					/* Always succeed */
 #endif	/* CONFIG_USE_MDIO */
--- linuxppc-2.6.11/include/asm-ppc/cpm2.h	2005-03-15 08:57:27.000000000 -0700
+++ linux-2.6.11/include/asm-ppc/cpm2.h	2005-03-02 00:38:08.000000000 -0700
@@ -69,7 +69,6 @@
 #define CPM_CR_INIT_TX		((ushort)0x0002)
 #define CPM_CR_HUNT_MODE	((ushort)0x0003)
 #define CPM_CR_STOP_TX		((ushort)0x0004)
-#define CPM_CR_GRA_STOP_TX      ((ushort)0x0005)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
 #define CPM_CR_START_IDMA	((ushort)0x0009)

-- 
Tom Rini
http://gate.crashing.org/~trini/
