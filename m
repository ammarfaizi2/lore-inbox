Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVKET60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVKET60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVKET6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:58:25 -0500
Received: from havoc.gtf.org ([69.61.125.42]:26795 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932314AbVKET6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:58:23 -0500
Date: Sat, 5 Nov 2005 14:58:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver updates
Message-ID: <20051105195822.GA1627@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 Documentation/networking/s2io.txt    |  195 ++++++--
 MAINTAINERS                          |    9 
 drivers/net/Kconfig                  |   13 
 drivers/net/fec_8xx/Kconfig          |    8 
 drivers/net/fec_8xx/fec_mii.c        |   42 +
 drivers/net/fs_enet/fs_enet-main.c   |   21 
 drivers/net/ibm_emac/ibm_emac.h      |   22 -
 drivers/net/ibm_emac/ibm_emac_core.c |   20 
 drivers/net/ibm_emac/ibm_emac_mal.h  |    5 
 drivers/net/ibm_emac/ibm_emac_phy.c  |   12 
 drivers/net/pcnet32.c                |   87 ++-
 drivers/net/phy/mdio_bus.c           |    3 
 drivers/net/s2io.c                   |  762 ++++++++++++++++++-----------------
 drivers/net/s2io.h                   |   91 ++--
 drivers/net/wireless/airo.c          |    2 
 include/linux/phy.h                  |    3 
 16 files changed, 791 insertions(+), 504 deletions(-)

Ananda Raju:
      S2io: Multi buffer mode support

Don Fry:
      pcnet32: show name of failing device
      pcnet32: AT2700/2701 and Bugzilla 2699 & 4551
      pcnet32: Prevent hang with 79c976

Eugene Surovegin:
      PPC 44x EMAC driver: add 440SPe support
      PPC 44x EMAC driver: add 440GR support
      PPC 4xx EMAC driver: fix VSC8201 PHY initialization

Gabriel A. Devenyi:
      drivers/net/wireless/airo.c unsigned comparason

Matt Porter:
      phy address mask support for generic phy layer

Pantelis Antoniou:
      Maintainers for fs_enet
      fs_enet: Fix dma_unmap_single calls
      fec_8xx: Remove dependency on NETTA & NETPHONE
      fec_8xx: Add support for Intel PHY LX971

Ravinandan Arakali:
      S2io: Updated documentation

diff --git a/Documentation/networking/s2io.txt b/Documentation/networking/s2io.txt
index 6726b52..bd528ff 100644
--- a/Documentation/networking/s2io.txt
+++ b/Documentation/networking/s2io.txt
@@ -1,48 +1,153 @@
-S2IO Technologies XFrame 10 Gig adapter.
--------------------------------------------
+Release notes for Neterion's (Formerly S2io) Xframe I/II PCI-X 10GbE driver.
 
-I. Module loadable parameters.
-When loaded as a module, the driver provides a host of Module loadable
-parameters, so the device can be tuned as per the users needs.
-A list of the Module params is given below.
-(i)	ring_num: This can be used to program the number of
-		 receive rings used in the driver.
-(ii)	ring_len: This defines the number of descriptors each ring
-		 can have. There can be a maximum of 8 rings.
-(iii)	frame_len: This is an array of size 8. Using this we can 
-		 set the maximum size of the received frame that can
-		 be steered into the corrsponding receive ring.	
-(iv)	fifo_num: This defines the number of Tx FIFOs thats used in
-		 the driver. 
-(v)	fifo_len: Each element defines the number of 
- 		 Tx descriptors that can be associated with each 
-		 corresponding FIFO. There are a maximum of 8 FIFOs.
-(vi)	tx_prio: This is a bool, if module is loaded with a non-zero
-		value for tx_prio multi FIFO scheme is activated.
-(vii)	rx_prio: This is a bool, if module is loaded with a non-zero
-		value for tx_prio multi RING scheme is activated.
-(viii)	latency_timer: The value given against this param will be
-		 loaded	into the latency timer register in PCI Config
-		 space, else the register is left with its reset value.
-
-II. Performance tuning.
- By changing a few sysctl parameters.
-	Copy the following lines into a file and run the following command,
-	"sysctl -p <file_name>"
-### IPV4 specific settings
-net.ipv4.tcp_timestamps = 0 # turns TCP timestamp support off, default 1, reduces CPU use
-net.ipv4.tcp_sack = 0 # turn SACK support off, default on
-# on systems with a VERY fast bus -> memory interface this is the big gainer
-net.ipv4.tcp_rmem = 10000000 10000000 10000000 # sets min/default/max TCP read buffer, default 4096 87380 174760
-net.ipv4.tcp_wmem = 10000000 10000000 10000000 # sets min/pressure/max TCP write buffer, default 4096 16384 131072
-net.ipv4.tcp_mem = 10000000 10000000 10000000 # sets min/pressure/max TCP buffer space, default 31744 32256 32768
-                                                                                
-### CORE settings (mostly for socket and UDP effect)
-net.core.rmem_max = 524287 # maximum receive socket buffer size, default 131071
-net.core.wmem_max = 524287 # maximum send socket buffer size, default 131071
-net.core.rmem_default = 524287 # default receive socket buffer size, default 65535
-net.core.wmem_default = 524287 # default send socket buffer size, default 65535
-net.core.optmem_max = 524287 # maximum amount of option memory buffers, default 10240
-net.core.netdev_max_backlog = 300000 # number of unprocessed input packets before kernel starts dropping them, default 300
----End of performance tuning file---
+Contents
+=======
+- 1.  Introduction
+- 2.  Identifying the adapter/interface
+- 3.  Features supported
+- 4.  Command line parameters
+- 5.  Performance suggestions
+- 6.  Available Downloads 
+
+
+1.	Introduction:
+This Linux driver supports Neterion's Xframe I PCI-X 1.0 and
+Xframe II PCI-X 2.0 adapters. It supports several features 
+such as jumbo frames, MSI/MSI-X, checksum offloads, TSO, UFO and so on.
+See below for complete list of features.
+All features are supported for both IPv4 and IPv6.
+
+2.	Identifying the adapter/interface:
+a. Insert the adapter(s) in your system.
+b. Build and load driver 
+# insmod s2io.ko
+c. View log messages
+# dmesg | tail -40
+You will see messages similar to:
+eth3: Neterion Xframe I 10GbE adapter (rev 3), Version 2.0.9.1, Intr type INTA
+eth4: Neterion Xframe II 10GbE adapter (rev 2), Version 2.0.9.1, Intr type INTA
+eth4: Device is on 64 bit 133MHz PCIX(M1) bus
+
+The above messages identify the adapter type(Xframe I/II), adapter revision,
+driver version, interface name(eth3, eth4), Interrupt type(INTA, MSI, MSI-X).
+In case of Xframe II, the PCI/PCI-X bus width and frequency are displayed
+as well.
+
+To associate an interface with a physical adapter use "ethtool -p <ethX>".
+The corresponding adapter's LED will blink multiple times.
+
+3.	Features supported:
+a. Jumbo frames. Xframe I/II supports MTU upto 9600 bytes,
+modifiable using ifconfig command.
+
+b. Offloads. Supports checksum offload(TCP/UDP/IP) on transmit
+and receive, TSO.
+
+c. Multi-buffer receive mode. Scattering of packet across multiple
+buffers. Currently driver supports 2-buffer mode which yields
+significant performance improvement on certain platforms(SGI Altix,
+IBM xSeries).
+
+d. MSI/MSI-X. Can be enabled on platforms which support this feature
+(IA64, Xeon) resulting in noticeable performance improvement(upto 7%
+on certain platforms).
+
+e. NAPI. Compile-time option(CONFIG_S2IO_NAPI) for better Rx interrupt 
+moderation.
+
+f. Statistics. Comprehensive MAC-level and software statistics displayed
+using "ethtool -S" option.
+
+g. Multi-FIFO/Ring. Supports up to 8 transmit queues and receive rings, 
+with multiple steering options.
+
+4.  Command line parameters
+a. tx_fifo_num
+Number of transmit queues
+Valid range: 1-8
+Default: 1
+
+b. rx_ring_num
+Number of receive rings
+Valid range: 1-8
+Default: 1
+
+c. tx_fifo_len
+Size of each transmit queue
+Valid range: Total length of all queues should not exceed 8192
+Default: 4096
+
+d. rx_ring_sz 
+Size of each receive ring(in 4K blocks)
+Valid range: Limited by memory on system
+Default: 30 
+
+e. intr_type
+Specifies interrupt type. Possible values 1(INTA), 2(MSI), 3(MSI-X)
+Valid range: 1-3
+Default: 1 
+
+5.  Performance suggestions
+General:
+a. Set MTU to maximum(9000 for switch setup, 9600 in back-to-back configuration)
+b. Set TCP windows size to optimal value. 
+For instance, for MTU=1500 a value of 210K has been observed to result in 
+good performance.
+# sysctl -w net.ipv4.tcp_rmem="210000 210000 210000"
+# sysctl -w net.ipv4.tcp_wmem="210000 210000 210000"
+For MTU=9000, TCP window size of 10 MB is recommended.
+# sysctl -w net.ipv4.tcp_rmem="10000000 10000000 10000000"
+# sysctl -w net.ipv4.tcp_wmem="10000000 10000000 10000000"
+
+Transmit performance:
+a. By default, the driver respects BIOS settings for PCI bus parameters. 
+However, you may want to experiment with PCI bus parameters 
+max-split-transactions(MOST) and MMRBC (use setpci command). 
+A MOST value of 2 has been found optimal for Opterons and 3 for Itanium.  
+It could be different for your hardware.  
+Set MMRBC to 4K**.
+
+For example you can set 
+For opteron
+#setpci -d 17d5:* 62=1d 
+For Itanium
+#setpci -d 17d5:* 62=3d 
+
+For detailed description of the PCI registers, please see Xframe User Guide.
+
+b. Ensure Transmit Checksum offload is enabled. Use ethtool to set/verify this 
+parameter.
+c. Turn on TSO(using "ethtool -K")
+# ethtool -K <ethX> tso on
+
+Receive performance:
+a. By default, the driver respects BIOS settings for PCI bus parameters. 
+However, you may want to set PCI latency timer to 248.
+#setpci -d 17d5:* LATENCY_TIMER=f8
+For detailed description of the PCI registers, please see Xframe User Guide.
+b. Use 2-buffer mode. This results in large performance boost on
+on certain platforms(eg. SGI Altix, IBM xSeries).
+c. Ensure Receive Checksum offload is enabled. Use "ethtool -K ethX" command to 
+set/verify this option.
+d. Enable NAPI feature(in kernel configuration Device Drivers ---> Network 
+device support --->  Ethernet (10000 Mbit) ---> S2IO 10Gbe Xframe NIC) to 
+bring down CPU utilization.
+
+** For AMD opteron platforms with 8131 chipset, MMRBC=1 and MOST=1 are 
+recommended as safe parameters.
+For more information, please review the AMD8131 errata at
+http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26310.pdf
+
+6.  Available Downloads
+Neterion "s2io" driver in Red Hat and Suse 2.6-based distributions is kept up 
+to date, also the latest "s2io" code (including support for 2.4 kernels) is 
+available via "Support" link on the Neterion site:  http://www.neterion.com.
+
+For Xframe User Guide (Programming manual), visit ftp site ns1.s2io.com,
+user: linuxdocs password: HALdocs
+
+7. Support 
+For further support please contact either your 10GbE Xframe NIC vendor (IBM, 
+HP, SGI etc.) or click on the "Support" link on the Neterion site:  
+http://www.neterion.com.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 983f9e9..f08a143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -910,6 +910,15 @@ L:	linux-fbdev-devel@lists.sourceforge.n
 W:	http://linux-fbdev.sourceforge.net/
 S:	Maintained
 
+FREESCALE SOC FS_ENET DRIVER
+P:	Pantelis Antoniou
+M:	pantelis.antoniou@gmail.com
+P:	Vitaly Bordug
+M:	vbordug@ru.mvista.com
+L:	linuxppc-embedded@ozlabs.org
+L:	netdev@vger.kernel.org
+S:	Maintained
+
 FILE LOCKING (flock() and fcntl()/lockf())
 P:	Matthew Wilcox
 M:	matthew@wil.cx
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 57edae4..1958d9e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1203,7 +1203,7 @@ config IBM_EMAC_RX_SKB_HEADROOM
 
 config IBM_EMAC_PHY_RX_CLK_FIX
 	bool "PHY Rx clock workaround"
-	depends on IBM_EMAC && (405EP || 440GX || 440EP)
+	depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
 	help
 	  Enable this if EMAC attached to a PHY which doesn't generate
 	  RX clock if there is no link, if this is the case, you will 
@@ -2258,17 +2258,6 @@ config S2IO_NAPI
 
 	  If in doubt, say N.
 
-config 2BUFF_MODE
-	bool "Use 2 Buffer Mode on Rx side."
-	depends on S2IO
-	---help---
-	On enabling the 2 buffer mode, the received frame will be
-	split into 2 parts before being DMA'ed to the hosts memory.
-	The parts are the ethernet header and ethernet payload. 
-	This is useful on systems where DMA'ing to to unaligned 
-	physical memory loactions comes with a heavy price.
-	If not sure please say N.
-
 endmenu
 
 if !UML
diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index db36ac3..4560026 100644
--- a/drivers/net/fec_8xx/Kconfig
+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET && 8xx && (NETTA || NETPHONE)
+	depends on NET_ETHERNET
 	select MII
 
 config FEC_8XX_GENERIC_PHY
@@ -12,3 +12,9 @@ config FEC_8XX_DM9161_PHY
 	bool "Support DM9161 PHY"
 	depends on FEC_8XX
 	default n
+
+config FEC_8XX_LXT971_PHY
+	bool "Support LXT971/LXT972 PHY"
+	depends on FEC_8XX
+	default n
+
diff --git a/drivers/net/fec_8xx/fec_mii.c b/drivers/net/fec_8xx/fec_mii.c
index 803eb09..3b44ac1 100644
--- a/drivers/net/fec_8xx/fec_mii.c
+++ b/drivers/net/fec_8xx/fec_mii.c
@@ -203,6 +203,39 @@ static void dm9161_shutdown(struct net_d
 
 #endif
 
+#ifdef CONFIG_FEC_8XX_LXT971_PHY
+
+/* Support for LXT971/972 PHY */
+
+#define MII_LXT971_PCR		16 /* Port Control Register */
+#define MII_LXT971_SR2		17 /* Status Register 2 */
+#define MII_LXT971_IER		18 /* Interrupt Enable Register */
+#define MII_LXT971_ISR		19 /* Interrupt Status Register */
+#define MII_LXT971_LCR		20 /* LED Control Register */
+#define MII_LXT971_TCR		30 /* Transmit Control Register */
+
+static void lxt971_startup(struct net_device *dev)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+
+	fec_mii_write(dev, fep->mii_if.phy_id, MII_LXT971_IER, 0x00F2);
+}
+
+static void lxt971_ack_int(struct net_device *dev)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+
+	fec_mii_read(dev, fep->mii_if.phy_id, MII_LXT971_ISR);
+}
+
+static void lxt971_shutdown(struct net_device *dev)
+{
+	struct fec_enet_private *fep = netdev_priv(dev);
+
+	fec_mii_write(dev, fep->mii_if.phy_id, MII_LXT971_IER, 0x0000);
+}
+#endif
+
 /**********************************************************************************/
 
 static const struct phy_info phy_info[] = {
@@ -215,6 +248,15 @@ static const struct phy_info phy_info[] 
 	 .shutdown = dm9161_shutdown,
 	 },
 #endif
+#ifdef CONFIG_FEC_8XX_LXT971_PHY
+	{
+	 .id = 0x0001378e,
+	 .name = "LXT971/972",
+	 .startup = lxt971_startup,
+	 .ack_int = lxt971_ack_int,
+	 .shutdown = lxt971_shutdown,
+	},
+#endif
 #ifdef CONFIG_FEC_8XX_GENERIC_PHY
 	{
 	 .id = 0,
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 44fac73..9342d5b 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -130,7 +130,7 @@ static int fs_enet_rx_napi(struct net_de
 
 			skb = fep->rx_skbuff[curidx];
 
-			dma_unmap_single(fep->dev, skb->data,
+			dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
 				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
 				DMA_FROM_DEVICE);
 
@@ -144,7 +144,7 @@ static int fs_enet_rx_napi(struct net_de
 
 			skb = fep->rx_skbuff[curidx];
 
-			dma_unmap_single(fep->dev, skb->data,
+			dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
 				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
 				DMA_FROM_DEVICE);
 
@@ -268,7 +268,7 @@ static int fs_enet_rx_non_napi(struct ne
 
 			skb = fep->rx_skbuff[curidx];
 
-			dma_unmap_single(fep->dev, skb->data,
+			dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
 				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
 				DMA_FROM_DEVICE);
 
@@ -278,7 +278,7 @@ static int fs_enet_rx_non_napi(struct ne
 
 			skb = fep->rx_skbuff[curidx];
 
-			dma_unmap_single(fep->dev, skb->data,
+			dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
 				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
 				DMA_FROM_DEVICE);
 
@@ -399,7 +399,8 @@ static void fs_enet_tx(struct net_device
 			fep->stats.collisions++;
 
 		/* unmap */
-		dma_unmap_single(fep->dev, skb->data, skb->len, DMA_TO_DEVICE);
+		dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
+				skb->len, DMA_TO_DEVICE);
 
 		/*
 		 * Free the sk buffer associated with this last transmit. 
@@ -547,17 +548,19 @@ void fs_cleanup_bds(struct net_device *d
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	struct sk_buff *skb;
+	cbd_t *bdp;
 	int i;
 
 	/*
 	 * Reset SKB transmit buffers.  
 	 */
-	for (i = 0; i < fep->tx_ring; i++) {
+	for (i = 0, bdp = fep->tx_bd_base; i < fep->tx_ring; i++, bdp++) {
 		if ((skb = fep->tx_skbuff[i]) == NULL)
 			continue;
 
 		/* unmap */
-		dma_unmap_single(fep->dev, skb->data, skb->len, DMA_TO_DEVICE);
+		dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
+				skb->len, DMA_TO_DEVICE);
 
 		fep->tx_skbuff[i] = NULL;
 		dev_kfree_skb(skb);
@@ -566,12 +569,12 @@ void fs_cleanup_bds(struct net_device *d
 	/*
 	 * Reset SKB receive buffers 
 	 */
-	for (i = 0; i < fep->rx_ring; i++) {
+	for (i = 0, bdp = fep->rx_bd_base; i < fep->rx_ring; i++, bdp++) {
 		if ((skb = fep->rx_skbuff[i]) == NULL)
 			continue;
 
 		/* unmap */
-		dma_unmap_single(fep->dev, skb->data,
+		dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
 			L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
 			DMA_FROM_DEVICE);
 
diff --git a/drivers/net/ibm_emac/ibm_emac.h b/drivers/net/ibm_emac/ibm_emac.h
index 28c476f..644edbf 100644
--- a/drivers/net/ibm_emac/ibm_emac.h
+++ b/drivers/net/ibm_emac/ibm_emac.h
@@ -26,7 +26,8 @@
 /* This is a simple check to prevent use of this driver on non-tested SoCs */
 #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
     !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
-    !defined(CONFIG_440EP) && !defined(CONFIG_NP405H)
+    !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
+    !defined(CONFIG_440GR)
 #error	"Unknown SoC. Please, check chip user manual and make sure EMAC defines are OK"
 #endif
 
@@ -246,6 +247,25 @@ struct emac_regs {
 #define EMAC_STACR_PCDA_SHIFT		5
 #define EMAC_STACR_PRA_MASK		0x1f
 
+/*
+ * For the 440SPe, AMCC inexplicably changed the polarity of
+ * the "operation complete" bit in the MII control register.
+ */
+#if defined(CONFIG_440SPE)
+static inline int emac_phy_done(u32 stacr)
+{
+	return !(stacr & EMAC_STACR_OC);
+};
+#define EMAC_STACR_START 		EMAC_STACR_OC
+
+#else /* CONFIG_440SPE */
+static inline int emac_phy_done(u32 stacr)
+{
+	return stacr & EMAC_STACR_OC;
+};
+#define EMAC_STACR_START 		0
+#endif /* !CONFIG_440SPE */
+
 /* EMACx_TRTR */
 #if !defined(CONFIG_IBM_EMAC4)
 #define EMAC_TRTR_SHIFT			27
diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
index 943fbd1..eb7d694 100644
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -87,10 +87,11 @@ MODULE_LICENSE("GPL");
  */
 static u32 busy_phy_map;
 
-#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && (defined(CONFIG_405EP) || defined(CONFIG_440EP))
+#if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && \
+    (defined(CONFIG_405EP) || defined(CONFIG_440EP) || defined(CONFIG_440GR))
 /* 405EP has "EMAC to PHY Control Register" (CPC0_EPCTL) which can help us
  * with PHY RX clock problem.
- * 440EP has more sane SDR0_MFR register implementation than 440GX, which
+ * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX, which
  * also allows controlling each EMAC clock
  */
 static inline void EMAC_RX_CLK_TX(int idx)
@@ -100,7 +101,7 @@ static inline void EMAC_RX_CLK_TX(int id
 
 #if defined(CONFIG_405EP)
 	mtdcr(0xf3, mfdcr(0xf3) | (1 << idx));
-#else /* CONFIG_440EP */
+#else /* CONFIG_440EP || CONFIG_440GR */
 	SDR_WRITE(DCRN_SDR_MFR, SDR_READ(DCRN_SDR_MFR) | (0x08000000 >> idx));
 #endif
 
@@ -546,7 +547,7 @@ static int __emac_mdio_read(struct ocp_e
 
 	/* Wait for management interface to become idle */
 	n = 10;
-	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
@@ -556,11 +557,12 @@ static int __emac_mdio_read(struct ocp_e
 	out_be32(&p->stacr,
 		 EMAC_STACR_BASE(emac_opb_mhz()) | EMAC_STACR_STAC_READ |
 		 (reg & EMAC_STACR_PRA_MASK)
-		 | ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT));
+		 | ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT)
+		 | EMAC_STACR_START);
 
 	/* Wait for read to complete */
 	n = 100;
-	while (!((r = in_be32(&p->stacr)) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(r = in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
@@ -594,7 +596,7 @@ static void __emac_mdio_write(struct ocp
 
 	/* Wait for management interface to be idle */
 	n = 10;
-	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
@@ -605,11 +607,11 @@ static void __emac_mdio_write(struct ocp
 		 EMAC_STACR_BASE(emac_opb_mhz()) | EMAC_STACR_STAC_WRITE |
 		 (reg & EMAC_STACR_PRA_MASK) |
 		 ((id & EMAC_STACR_PCDA_MASK) << EMAC_STACR_PCDA_SHIFT) |
-		 (val << EMAC_STACR_PHYD_SHIFT));
+		 (val << EMAC_STACR_PHYD_SHIFT) | EMAC_STACR_START);
 
 	/* Wait for write to complete */
 	n = 100;
-	while (!(in_be32(&p->stacr) & EMAC_STACR_OC)) {
+	while (!emac_phy_done(in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n)
 			goto to;
diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
index 15b0bda..2a2d3b2 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.h
+++ b/drivers/net/ibm_emac/ibm_emac_mal.h
@@ -32,9 +32,10 @@
  * reflect the fact that 40x and 44x have slightly different MALs. --ebs
  */
 #if defined(CONFIG_405GP) || defined(CONFIG_405GPR) || defined(CONFIG_405EP) || \
-    defined(CONFIG_440EP) || defined(CONFIG_NP405H)
+    defined(CONFIG_440EP) || defined(CONFIG_440GR) || defined(CONFIG_NP405H)
 #define MAL_VERSION		1
-#elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP)
+#elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP) || \
+      defined(CONFIG_440SPE)
 #define MAL_VERSION		2
 #else
 #error "Unknown SoC, please check chip manual and choose MAL 'version'"
diff --git a/drivers/net/ibm_emac/ibm_emac_phy.c b/drivers/net/ibm_emac/ibm_emac_phy.c
index a27e49c..67935dd 100644
--- a/drivers/net/ibm_emac/ibm_emac_phy.c
+++ b/drivers/net/ibm_emac/ibm_emac_phy.c
@@ -236,12 +236,16 @@ static struct mii_phy_def genmii_phy_def
 };
 
 /* CIS8201 */
+#define MII_CIS8201_10BTCSR	0x16
+#define  TENBTCSR_ECHO_DISABLE	0x2000
 #define MII_CIS8201_EPCR	0x17
 #define  EPCR_MODE_MASK		0x3000
 #define  EPCR_GMII_MODE		0x0000
 #define  EPCR_RGMII_MODE	0x1000
 #define  EPCR_TBI_MODE		0x2000
 #define  EPCR_RTBI_MODE		0x3000
+#define MII_CIS8201_ACSR	0x1c
+#define  ACSR_PIN_PRIO_SELECT	0x0004
 
 static int cis8201_init(struct mii_phy *phy)
 {
@@ -269,6 +273,14 @@ static int cis8201_init(struct mii_phy *
 	}
 
 	phy_write(phy, MII_CIS8201_EPCR, epcr);
+	
+	/* MII regs override strap pins */
+	phy_write(phy, MII_CIS8201_ACSR, 
+		  phy_read(phy, MII_CIS8201_ACSR) | ACSR_PIN_PRIO_SELECT);
+
+	/* Disable TX_EN -> CRS echo mode, otherwise 10/HDX doesn't work */
+	phy_write(phy, MII_CIS8201_10BTCSR,
+		  phy_read(phy, MII_CIS8201_10BTCSR) | TENBTCSR_ECHO_DISABLE);
 
 	return 0;
 }
diff --git a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
index 70fe81a..be31922 100644
--- a/drivers/net/pcnet32.c
+++ b/drivers/net/pcnet32.c
@@ -22,8 +22,8 @@
  *************************************************************************/
 
 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.31a"
-#define DRV_RELDATE	"12.Sep.2005"
+#define DRV_VERSION	"1.31c"
+#define DRV_RELDATE	"01.Nov.2005"
 #define PFX		DRV_NAME ": "
 
 static const char *version =
@@ -260,6 +260,11 @@ static int homepna[MAX_UNITS];
  * v1.31   02 Sep 2005 Hubert WS Lin <wslin@tw.ibm.c0m> added set_ringparam().
  * v1.31a  12 Sep 2005 Hubert WS Lin <wslin@tw.ibm.c0m> set min ring size to 4
  *	   to allow loopback test to work unchanged.
+ * v1.31b  06 Oct 2005 Don Fry changed alloc_ring to show name of device
+ *	   if allocation fails
+ * v1.31c  01 Nov 2005 Don Fry Allied Telesyn 2700/2701 FX are 100Mbit only.
+ *	   Force 100Mbit FD if Auto (ASEL) is selected.
+ *	   See Bugzilla 2669 and 4551.
  */
 
 
@@ -408,7 +413,7 @@ static int pcnet32_get_regs_len(struct n
 static void pcnet32_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	void *ptr);
 static void pcnet32_purge_tx_ring(struct net_device *dev);
-static int pcnet32_alloc_ring(struct net_device *dev);
+static int pcnet32_alloc_ring(struct net_device *dev, char *name);
 static void pcnet32_free_ring(struct net_device *dev);
 
 
@@ -669,15 +674,17 @@ static int pcnet32_set_ringparam(struct 
     lp->rx_mod_mask = lp->rx_ring_size - 1;
     lp->rx_len_bits = (i << 4);
 
-    if (pcnet32_alloc_ring(dev)) {
+    if (pcnet32_alloc_ring(dev, dev->name)) {
 	pcnet32_free_ring(dev);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	return -ENOMEM;
     }
 
     spin_unlock_irqrestore(&lp->lock, flags);
 
     if (pcnet32_debug & NETIF_MSG_DRV)
-	printk(KERN_INFO PFX "Ring Param Settings: RX: %d, TX: %d\n", lp->rx_ring_size, lp->tx_ring_size);
+	printk(KERN_INFO PFX "%s: Ring Param Settings: RX: %d, TX: %d\n",
+	       dev->name, lp->rx_ring_size, lp->tx_ring_size);
 
     if (netif_running(dev))
 	pcnet32_open(dev);
@@ -981,7 +988,11 @@ static void pcnet32_get_regs(struct net_
     *buff++ = a->read_csr(ioaddr, 114);
 
     /* read bus configuration registers */
-    for (i=0; i<36; i++) {
+    for (i=0; i<30; i++) {
+	*buff++ = a->read_bcr(ioaddr, i);
+    }
+    *buff++ = 0;	/* skip bcr30 so as not to hang 79C976 */
+    for (i=31; i<36; i++) {
 	*buff++ = a->read_bcr(ioaddr, i);
     }
 
@@ -1340,7 +1351,8 @@ pcnet32_probe1(unsigned long ioaddr, int
     }
     lp->a = *a;
 
-    if (pcnet32_alloc_ring(dev)) {
+    /* prior to register_netdev, dev->name is not yet correct */
+    if (pcnet32_alloc_ring(dev, pci_name(lp->pci_dev))) {
 	ret = -ENOMEM;
 	goto err_free_ring;
     }
@@ -1448,48 +1460,63 @@ err_release_region:
 }
 
 
-static int pcnet32_alloc_ring(struct net_device *dev)
+/* if any allocation fails, caller must also call pcnet32_free_ring */
+static int pcnet32_alloc_ring(struct net_device *dev, char *name)
 {
     struct pcnet32_private *lp = dev->priv;
 
-    if ((lp->tx_ring = pci_alloc_consistent(lp->pci_dev, sizeof(struct pcnet32_tx_head) * lp->tx_ring_size,
-	&lp->tx_ring_dma_addr)) == NULL) {
+    lp->tx_ring = pci_alloc_consistent(lp->pci_dev,
+	    sizeof(struct pcnet32_tx_head) * lp->tx_ring_size,
+	    &lp->tx_ring_dma_addr);
+    if (lp->tx_ring == NULL) {
 	if (pcnet32_debug & NETIF_MSG_DRV)
-	    printk(KERN_ERR PFX "Consistent memory allocation failed.\n");
+	    printk("\n" KERN_ERR PFX "%s: Consistent memory allocation failed.\n",
+		    name);
 	return -ENOMEM;
     }
 
-    if ((lp->rx_ring = pci_alloc_consistent(lp->pci_dev, sizeof(struct pcnet32_rx_head) * lp->rx_ring_size,
-	&lp->rx_ring_dma_addr)) == NULL) {
+    lp->rx_ring = pci_alloc_consistent(lp->pci_dev,
+	    sizeof(struct pcnet32_rx_head) * lp->rx_ring_size,
+	    &lp->rx_ring_dma_addr);
+    if (lp->rx_ring == NULL) {
 	if (pcnet32_debug & NETIF_MSG_DRV)
-	    printk(KERN_ERR PFX "Consistent memory allocation failed.\n");
+	    printk("\n" KERN_ERR PFX "%s: Consistent memory allocation failed.\n",
+		    name);
 	return -ENOMEM;
     }
 
-    if (!(lp->tx_dma_addr = kmalloc(sizeof(dma_addr_t) * lp->tx_ring_size, GFP_ATOMIC))) {
+    lp->tx_dma_addr = kmalloc(sizeof(dma_addr_t) * lp->tx_ring_size,
+	    GFP_ATOMIC);
+    if (!lp->tx_dma_addr) {
 	if (pcnet32_debug & NETIF_MSG_DRV)
-	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	    printk("\n" KERN_ERR PFX "%s: Memory allocation failed.\n", name);
 	return -ENOMEM;
     }
     memset(lp->tx_dma_addr, 0, sizeof(dma_addr_t) * lp->tx_ring_size);
 
-    if (!(lp->rx_dma_addr = kmalloc(sizeof(dma_addr_t) * lp->rx_ring_size, GFP_ATOMIC))) {
+    lp->rx_dma_addr = kmalloc(sizeof(dma_addr_t) * lp->rx_ring_size,
+	    GFP_ATOMIC);
+    if (!lp->rx_dma_addr) {
 	if (pcnet32_debug & NETIF_MSG_DRV)
-	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	    printk("\n" KERN_ERR PFX "%s: Memory allocation failed.\n", name);
 	return -ENOMEM;
     }
     memset(lp->rx_dma_addr, 0, sizeof(dma_addr_t) * lp->rx_ring_size);
 
-    if (!(lp->tx_skbuff = kmalloc(sizeof(struct sk_buff *) * lp->tx_ring_size, GFP_ATOMIC))) {
+    lp->tx_skbuff = kmalloc(sizeof(struct sk_buff *) * lp->tx_ring_size,
+	    GFP_ATOMIC);
+    if (!lp->tx_skbuff) {
 	if (pcnet32_debug & NETIF_MSG_DRV)
-	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	    printk("\n" KERN_ERR PFX "%s: Memory allocation failed.\n", name);
 	return -ENOMEM;
     }
     memset(lp->tx_skbuff, 0, sizeof(struct sk_buff *) * lp->tx_ring_size);
 
-    if (!(lp->rx_skbuff = kmalloc(sizeof(struct sk_buff *) * lp->rx_ring_size, GFP_ATOMIC))) {
+    lp->rx_skbuff = kmalloc(sizeof(struct sk_buff *) * lp->rx_ring_size,
+	    GFP_ATOMIC);
+    if (!lp->rx_skbuff) {
 	if (pcnet32_debug & NETIF_MSG_DRV)
-	    printk(KERN_ERR PFX "Memory allocation failed.\n");
+	    printk("\n" KERN_ERR PFX "%s: Memory allocation failed.\n", name);
 	return -ENOMEM;
     }
     memset(lp->rx_skbuff, 0, sizeof(struct sk_buff *) * lp->rx_ring_size);
@@ -1592,12 +1619,18 @@ pcnet32_open(struct net_device *dev)
 	val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);
 
-    /* Allied Telesyn AT 2700/2701 FX looses the link, so skip that */
+    /* Allied Telesyn AT 2700/2701 FX are 100Mbit only and do not negotiate */
     if (lp->pci_dev->subsystem_vendor == PCI_VENDOR_ID_AT &&
-        (lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FX ||
-	 lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FX)) {
-	printk(KERN_DEBUG "%s: Skipping PHY selection.\n", dev->name);
-    } else {
+	    (lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FX ||
+	     lp->pci_dev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FX)) {
+	if (lp->options & PCNET32_PORT_ASEL) {
+	    lp->options = PCNET32_PORT_FD | PCNET32_PORT_100;
+	    if (netif_msg_link(lp))
+		printk(KERN_DEBUG "%s: Setting 100Mb-Full Duplex.\n",
+			dev->name);
+	}
+    }
+    {
 	/*
 	 * 24 Jun 2004 according AMD, in order to change the PHY,
 	 * DANAS (or DISPM for 79C976) must be set; then select the speed,
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index ad93b0d..5eab9c4 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -61,6 +61,9 @@ int mdiobus_register(struct mii_bus *bus
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
 		struct phy_device *phydev;
 
+		if (bus->phy_mask & (1 << i))
+			continue;
+
 		phydev = get_phy_device(bus, i);
 
 		if (IS_ERR(phydev))
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index 3f5e93a..9c49354 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -30,6 +30,8 @@
  * in the driver.
  * rx_ring_sz: This defines the number of descriptors each ring can have. This
  * is also an array of size 8.
+ * rx_ring_mode: This defines the operation mode of all 8 rings. The valid
+ *		values are 1, 2 and 3.
  * tx_fifo_num: This defines the number of Tx FIFOs thats used int the driver.
  * tx_fifo_len: This too is an array of 8. Each element defines the number of
  * Tx descriptors that can be associated with each corresponding FIFO.
@@ -65,12 +67,15 @@
 #include "s2io.h"
 #include "s2io-regs.h"
 
-#define DRV_VERSION "Version 2.0.9.1"
+#define DRV_VERSION "Version 2.0.9.3"
 
 /* S2io Driver name & version. */
 static char s2io_driver_name[] = "Neterion";
 static char s2io_driver_version[] = DRV_VERSION;
 
+int rxd_size[4] = {32,48,48,64};
+int rxd_count[4] = {127,85,85,63};
+
 static inline int RXD_IS_UP2DT(RxD_t *rxdp)
 {
 	int ret;
@@ -104,7 +109,7 @@ static inline int rx_buffer_level(nic_t 
 	mac_control = &sp->mac_control;
 	if ((mac_control->rings[ring].pkt_cnt - rxb_size) > 16) {
 		level = LOW;
-		if (rxb_size <= MAX_RXDS_PER_BLOCK) {
+		if (rxb_size <= rxd_count[sp->rxd_mode]) {
 			level = PANIC;
 		}
 	}
@@ -296,6 +301,7 @@ static unsigned int rx_ring_sz[MAX_RX_RI
     {[0 ...(MAX_RX_RINGS - 1)] = 0 };
 static unsigned int rts_frm_len[MAX_RX_RINGS] =
     {[0 ...(MAX_RX_RINGS - 1)] = 0 };
+static unsigned int rx_ring_mode = 1;
 static unsigned int use_continuous_tx_intrs = 1;
 static unsigned int rmac_pause_time = 65535;
 static unsigned int mc_pause_threshold_q0q3 = 187;
@@ -304,6 +310,7 @@ static unsigned int shared_splits;
 static unsigned int tmac_util_period = 5;
 static unsigned int rmac_util_period = 5;
 static unsigned int bimodal = 0;
+static unsigned int l3l4hdr_size = 128;
 #ifndef CONFIG_S2IO_NAPI
 static unsigned int indicate_max_pkts;
 #endif
@@ -357,10 +364,8 @@ static int init_shared_mem(struct s2io_n
 	int i, j, blk_cnt, rx_sz, tx_sz;
 	int lst_size, lst_per_page;
 	struct net_device *dev = nic->dev;
-#ifdef CONFIG_2BUFF_MODE
 	unsigned long tmp;
 	buffAdd_t *ba;
-#endif
 
 	mac_info_t *mac_control;
 	struct config_param *config;
@@ -458,7 +463,8 @@ static int init_shared_mem(struct s2io_n
 	/* Allocation and initialization of RXDs in Rings */
 	size = 0;
 	for (i = 0; i < config->rx_ring_num; i++) {
-		if (config->rx_cfg[i].num_rxd % (MAX_RXDS_PER_BLOCK + 1)) {
+		if (config->rx_cfg[i].num_rxd %
+		    (rxd_count[nic->rxd_mode] + 1)) {
 			DBG_PRINT(ERR_DBG, "%s: RxD count of ", dev->name);
 			DBG_PRINT(ERR_DBG, "Ring%d is not a multiple of ",
 				  i);
@@ -467,11 +473,15 @@ static int init_shared_mem(struct s2io_n
 		}
 		size += config->rx_cfg[i].num_rxd;
 		mac_control->rings[i].block_count =
-		    config->rx_cfg[i].num_rxd / (MAX_RXDS_PER_BLOCK + 1);
-		mac_control->rings[i].pkt_cnt =
-		    config->rx_cfg[i].num_rxd - mac_control->rings[i].block_count;
+			config->rx_cfg[i].num_rxd /
+			(rxd_count[nic->rxd_mode] + 1 );
+		mac_control->rings[i].pkt_cnt = config->rx_cfg[i].num_rxd -
+			mac_control->rings[i].block_count;
 	}
-	size = (size * (sizeof(RxD_t)));
+	if (nic->rxd_mode == RXD_MODE_1)
+		size = (size * (sizeof(RxD1_t)));
+	else
+		size = (size * (sizeof(RxD3_t)));
 	rx_sz = size;
 
 	for (i = 0; i < config->rx_ring_num; i++) {
@@ -486,15 +496,15 @@ static int init_shared_mem(struct s2io_n
 		mac_control->rings[i].nic = nic;
 		mac_control->rings[i].ring_no = i;
 
-		blk_cnt =
-		    config->rx_cfg[i].num_rxd / (MAX_RXDS_PER_BLOCK + 1);
+		blk_cnt = config->rx_cfg[i].num_rxd /
+				(rxd_count[nic->rxd_mode] + 1);
 		/*  Allocating all the Rx blocks */
 		for (j = 0; j < blk_cnt; j++) {
-#ifndef CONFIG_2BUFF_MODE
-			size = (MAX_RXDS_PER_BLOCK + 1) * (sizeof(RxD_t));
-#else
-			size = SIZE_OF_BLOCK;
-#endif
+			rx_block_info_t *rx_blocks;
+			int l;
+
+			rx_blocks = &mac_control->rings[i].rx_blocks[j];
+			size = SIZE_OF_BLOCK; //size is always page size
 			tmp_v_addr = pci_alloc_consistent(nic->pdev, size,
 							  &tmp_p_addr);
 			if (tmp_v_addr == NULL) {
@@ -504,11 +514,24 @@ static int init_shared_mem(struct s2io_n
 				 * memory that was alloced till the
 				 * failure happened.
 				 */
-				mac_control->rings[i].rx_blocks[j].block_virt_addr =
-				    tmp_v_addr;
+				rx_blocks->block_virt_addr = tmp_v_addr;
 				return -ENOMEM;
 			}
 			memset(tmp_v_addr, 0, size);
+			rx_blocks->block_virt_addr = tmp_v_addr;
+			rx_blocks->block_dma_addr = tmp_p_addr;
+			rx_blocks->rxds = kmalloc(sizeof(rxd_info_t)*
+						  rxd_count[nic->rxd_mode],
+						  GFP_KERNEL);
+			for (l=0; l<rxd_count[nic->rxd_mode];l++) {
+				rx_blocks->rxds[l].virt_addr =
+					rx_blocks->block_virt_addr +
+					(rxd_size[nic->rxd_mode] * l);
+				rx_blocks->rxds[l].dma_addr =
+					rx_blocks->block_dma_addr +
+					(rxd_size[nic->rxd_mode] * l);
+			}
+
 			mac_control->rings[i].rx_blocks[j].block_virt_addr =
 				tmp_v_addr;
 			mac_control->rings[i].rx_blocks[j].block_dma_addr =
@@ -528,62 +551,58 @@ static int init_shared_mem(struct s2io_n
 					      blk_cnt].block_dma_addr;
 
 			pre_rxd_blk = (RxD_block_t *) tmp_v_addr;
-			pre_rxd_blk->reserved_1 = END_OF_BLOCK;	/* last RxD
-								 * marker.
-								 */
-#ifndef	CONFIG_2BUFF_MODE
 			pre_rxd_blk->reserved_2_pNext_RxD_block =
 			    (unsigned long) tmp_v_addr_next;
-#endif
 			pre_rxd_blk->pNext_RxD_Blk_physical =
 			    (u64) tmp_p_addr_next;
 		}
 	}
-
-#ifdef CONFIG_2BUFF_MODE
-	/*
-	 * Allocation of Storages for buffer addresses in 2BUFF mode
-	 * and the buffers as well.
-	 */
-	for (i = 0; i < config->rx_ring_num; i++) {
-		blk_cnt =
-		    config->rx_cfg[i].num_rxd / (MAX_RXDS_PER_BLOCK + 1);
-		mac_control->rings[i].ba = kmalloc((sizeof(buffAdd_t *) * blk_cnt),
+	if (nic->rxd_mode >= RXD_MODE_3A) {
+		/*
+		 * Allocation of Storages for buffer addresses in 2BUFF mode
+		 * and the buffers as well.
+		 */
+		for (i = 0; i < config->rx_ring_num; i++) {
+			blk_cnt = config->rx_cfg[i].num_rxd /
+			   (rxd_count[nic->rxd_mode]+ 1);
+			mac_control->rings[i].ba =
+				kmalloc((sizeof(buffAdd_t *) * blk_cnt),
 				     GFP_KERNEL);
-		if (!mac_control->rings[i].ba)
-			return -ENOMEM;
-		for (j = 0; j < blk_cnt; j++) {
-			int k = 0;
-			mac_control->rings[i].ba[j] = kmalloc((sizeof(buffAdd_t) *
-						 (MAX_RXDS_PER_BLOCK + 1)),
-						GFP_KERNEL);
-			if (!mac_control->rings[i].ba[j])
+			if (!mac_control->rings[i].ba)
 				return -ENOMEM;
-			while (k != MAX_RXDS_PER_BLOCK) {
-				ba = &mac_control->rings[i].ba[j][k];
-
-				ba->ba_0_org = (void *) kmalloc
-				    (BUF0_LEN + ALIGN_SIZE, GFP_KERNEL);
-				if (!ba->ba_0_org)
-					return -ENOMEM;
-				tmp = (unsigned long) ba->ba_0_org;
-				tmp += ALIGN_SIZE;
-				tmp &= ~((unsigned long) ALIGN_SIZE);
-				ba->ba_0 = (void *) tmp;
-
-				ba->ba_1_org = (void *) kmalloc
-				    (BUF1_LEN + ALIGN_SIZE, GFP_KERNEL);
-				if (!ba->ba_1_org)
+			for (j = 0; j < blk_cnt; j++) {
+				int k = 0;
+				mac_control->rings[i].ba[j] =
+					kmalloc((sizeof(buffAdd_t) *
+						(rxd_count[nic->rxd_mode] + 1)),
+						GFP_KERNEL);
+				if (!mac_control->rings[i].ba[j])
 					return -ENOMEM;
-				tmp = (unsigned long) ba->ba_1_org;
-				tmp += ALIGN_SIZE;
-				tmp &= ~((unsigned long) ALIGN_SIZE);
-				ba->ba_1 = (void *) tmp;
-				k++;
+				while (k != rxd_count[nic->rxd_mode]) {
+					ba = &mac_control->rings[i].ba[j][k];
+
+					ba->ba_0_org = (void *) kmalloc
+					    (BUF0_LEN + ALIGN_SIZE, GFP_KERNEL);
+					if (!ba->ba_0_org)
+						return -ENOMEM;
+					tmp = (unsigned long)ba->ba_0_org;
+					tmp += ALIGN_SIZE;
+					tmp &= ~((unsigned long) ALIGN_SIZE);
+					ba->ba_0 = (void *) tmp;
+
+					ba->ba_1_org = (void *) kmalloc
+					    (BUF1_LEN + ALIGN_SIZE, GFP_KERNEL);
+					if (!ba->ba_1_org)
+						return -ENOMEM;
+					tmp = (unsigned long) ba->ba_1_org;
+					tmp += ALIGN_SIZE;
+					tmp &= ~((unsigned long) ALIGN_SIZE);
+					ba->ba_1 = (void *) tmp;
+					k++;
+				}
 			}
 		}
 	}
-#endif
 
 	/* Allocation and initialization of Statistics block */
 	size = sizeof(StatInfo_t);
@@ -669,11 +688,7 @@ static void free_shared_mem(struct s2io_
 		kfree(mac_control->fifos[i].list_info);
 	}
 
-#ifndef CONFIG_2BUFF_MODE
-	size = (MAX_RXDS_PER_BLOCK + 1) * (sizeof(RxD_t));
-#else
 	size = SIZE_OF_BLOCK;
-#endif
 	for (i = 0; i < config->rx_ring_num; i++) {
 		blk_cnt = mac_control->rings[i].block_count;
 		for (j = 0; j < blk_cnt; j++) {
@@ -685,29 +700,31 @@ static void free_shared_mem(struct s2io_
 				break;
 			pci_free_consistent(nic->pdev, size,
 					    tmp_v_addr, tmp_p_addr);
+			kfree(mac_control->rings[i].rx_blocks[j].rxds);
 		}
 	}
 
-#ifdef CONFIG_2BUFF_MODE
-	/* Freeing buffer storage addresses in 2BUFF mode. */
-	for (i = 0; i < config->rx_ring_num; i++) {
-		blk_cnt =
-		    config->rx_cfg[i].num_rxd / (MAX_RXDS_PER_BLOCK + 1);
-		for (j = 0; j < blk_cnt; j++) {
-			int k = 0;
-			if (!mac_control->rings[i].ba[j])
-				continue;
-			while (k != MAX_RXDS_PER_BLOCK) {
-				buffAdd_t *ba = &mac_control->rings[i].ba[j][k];
-				kfree(ba->ba_0_org);
-				kfree(ba->ba_1_org);
-				k++;
+	if (nic->rxd_mode >= RXD_MODE_3A) {
+		/* Freeing buffer storage addresses in 2BUFF mode. */
+		for (i = 0; i < config->rx_ring_num; i++) {
+			blk_cnt = config->rx_cfg[i].num_rxd /
+			    (rxd_count[nic->rxd_mode] + 1);
+			for (j = 0; j < blk_cnt; j++) {
+				int k = 0;
+				if (!mac_control->rings[i].ba[j])
+					continue;
+				while (k != rxd_count[nic->rxd_mode]) {
+					buffAdd_t *ba =
+						&mac_control->rings[i].ba[j][k];
+					kfree(ba->ba_0_org);
+					kfree(ba->ba_1_org);
+					k++;
+				}
+				kfree(mac_control->rings[i].ba[j]);
 			}
-			kfree(mac_control->rings[i].ba[j]);
+			kfree(mac_control->rings[i].ba);
 		}
-		kfree(mac_control->rings[i].ba);
 	}
-#endif
 
 	if (mac_control->stats_mem) {
 		pci_free_consistent(nic->pdev,
@@ -1894,20 +1911,19 @@ static int start_nic(struct s2io_nic *ni
 		val64 = readq(&bar0->prc_ctrl_n[i]);
 		if (nic->config.bimodal)
 			val64 |= PRC_CTRL_BIMODAL_INTERRUPT;
-#ifndef CONFIG_2BUFF_MODE
-		val64 |= PRC_CTRL_RC_ENABLED;
-#else
-		val64 |= PRC_CTRL_RC_ENABLED | PRC_CTRL_RING_MODE_3;
-#endif
+		if (nic->rxd_mode == RXD_MODE_1)
+			val64 |= PRC_CTRL_RC_ENABLED;
+		else
+			val64 |= PRC_CTRL_RC_ENABLED | PRC_CTRL_RING_MODE_3;
 		writeq(val64, &bar0->prc_ctrl_n[i]);
 	}
 
-#ifdef CONFIG_2BUFF_MODE
-	/* Enabling 2 buffer mode by writing into Rx_pa_cfg reg. */
-	val64 = readq(&bar0->rx_pa_cfg);
-	val64 |= RX_PA_CFG_IGNORE_L2_ERR;
-	writeq(val64, &bar0->rx_pa_cfg);
-#endif
+	if (nic->rxd_mode == RXD_MODE_3B) {
+		/* Enabling 2 buffer mode by writing into Rx_pa_cfg reg. */
+		val64 = readq(&bar0->rx_pa_cfg);
+		val64 |= RX_PA_CFG_IGNORE_L2_ERR;
+		writeq(val64, &bar0->rx_pa_cfg);
+	}
 
 	/*
 	 * Enabling MC-RLDRAM. After enabling the device, we timeout
@@ -2090,6 +2106,41 @@ static void stop_nic(struct s2io_nic *ni
 	}
 }
 
+int fill_rxd_3buf(nic_t *nic, RxD_t *rxdp, struct sk_buff *skb)
+{
+	struct net_device *dev = nic->dev;
+	struct sk_buff *frag_list;
+	u64 tmp;
+
+	/* Buffer-1 receives L3/L4 headers */
+	((RxD3_t*)rxdp)->Buffer1_ptr = pci_map_single
+			(nic->pdev, skb->data, l3l4hdr_size + 4,
+			PCI_DMA_FROMDEVICE);
+
+	/* skb_shinfo(skb)->frag_list will have L4 data payload */
+	skb_shinfo(skb)->frag_list = dev_alloc_skb(dev->mtu + ALIGN_SIZE);
+	if (skb_shinfo(skb)->frag_list == NULL) {
+		DBG_PRINT(ERR_DBG, "%s: dev_alloc_skb failed\n ", dev->name);
+		return -ENOMEM ;
+	}
+	frag_list = skb_shinfo(skb)->frag_list;
+	frag_list->next = NULL;
+	tmp = (u64) frag_list->data;
+	tmp += ALIGN_SIZE;
+	tmp &= ~ALIGN_SIZE;
+	frag_list->data = (void *) tmp;
+	frag_list->tail = (void *) tmp;
+
+	/* Buffer-2 receives L4 data payload */
+	((RxD3_t*)rxdp)->Buffer2_ptr = pci_map_single(nic->pdev,
+				frag_list->data, dev->mtu,
+				PCI_DMA_FROMDEVICE);
+	rxdp->Control_2 |= SET_BUFFER1_SIZE_3(l3l4hdr_size + 4);
+	rxdp->Control_2 |= SET_BUFFER2_SIZE_3(dev->mtu);
+
+	return SUCCESS;
+}
+
 /**
  *  fill_rx_buffers - Allocates the Rx side skbs
  *  @nic:  device private variable
@@ -2117,18 +2168,12 @@ int fill_rx_buffers(struct s2io_nic *nic
 	struct sk_buff *skb;
 	RxD_t *rxdp;
 	int off, off1, size, block_no, block_no1;
-	int offset, offset1;
 	u32 alloc_tab = 0;
 	u32 alloc_cnt;
 	mac_info_t *mac_control;
 	struct config_param *config;
-#ifdef CONFIG_2BUFF_MODE
-	RxD_t *rxdpnext;
-	int nextblk;
 	u64 tmp;
 	buffAdd_t *ba;
-	dma_addr_t rxdpphys;
-#endif
 #ifndef CONFIG_S2IO_NAPI
 	unsigned long flags;
 #endif
@@ -2138,8 +2183,6 @@ int fill_rx_buffers(struct s2io_nic *nic
 	config = &nic->config;
 	alloc_cnt = mac_control->rings[ring_no].pkt_cnt -
 	    atomic_read(&nic->rx_bufs_left[ring_no]);
-	size = dev->mtu + HEADER_ETHERNET_II_802_3_SIZE +
-	    HEADER_802_2_SIZE + HEADER_SNAP_SIZE;
 
 	while (alloc_tab < alloc_cnt) {
 		block_no = mac_control->rings[ring_no].rx_curr_put_info.
@@ -2148,159 +2191,145 @@ int fill_rx_buffers(struct s2io_nic *nic
 		    block_index;
 		off = mac_control->rings[ring_no].rx_curr_put_info.offset;
 		off1 = mac_control->rings[ring_no].rx_curr_get_info.offset;
-#ifndef CONFIG_2BUFF_MODE
-		offset = block_no * (MAX_RXDS_PER_BLOCK + 1) + off;
-		offset1 = block_no1 * (MAX_RXDS_PER_BLOCK + 1) + off1;
-#else
-		offset = block_no * (MAX_RXDS_PER_BLOCK) + off;
-		offset1 = block_no1 * (MAX_RXDS_PER_BLOCK) + off1;
-#endif
 
-		rxdp = mac_control->rings[ring_no].rx_blocks[block_no].
-		    block_virt_addr + off;
-		if ((offset == offset1) && (rxdp->Host_Control)) {
-			DBG_PRINT(INTR_DBG, "%s: Get and Put", dev->name);
+		rxdp = mac_control->rings[ring_no].
+				rx_blocks[block_no].rxds[off].virt_addr;
+
+		if ((block_no == block_no1) && (off == off1) &&
+					(rxdp->Host_Control)) {
+			DBG_PRINT(INTR_DBG, "%s: Get and Put",
+				  dev->name);
 			DBG_PRINT(INTR_DBG, " info equated\n");
 			goto end;
 		}
-#ifndef	CONFIG_2BUFF_MODE
-		if (rxdp->Control_1 == END_OF_BLOCK) {
+		if (off && (off == rxd_count[nic->rxd_mode])) {
 			mac_control->rings[ring_no].rx_curr_put_info.
 			    block_index++;
+			if (mac_control->rings[ring_no].rx_curr_put_info.
+			    block_index == mac_control->rings[ring_no].
+					block_count)
+				mac_control->rings[ring_no].rx_curr_put_info.
+					block_index = 0;
+			block_no = mac_control->rings[ring_no].
+					rx_curr_put_info.block_index;
+			if (off == rxd_count[nic->rxd_mode])
+				off = 0;
 			mac_control->rings[ring_no].rx_curr_put_info.
-			    block_index %= mac_control->rings[ring_no].block_count;
-			block_no = mac_control->rings[ring_no].rx_curr_put_info.
-				block_index;
-			off++;
-			off %= (MAX_RXDS_PER_BLOCK + 1);
-			mac_control->rings[ring_no].rx_curr_put_info.offset =
-			    off;
-			rxdp = (RxD_t *) ((unsigned long) rxdp->Control_2);
+				offset = off;
+			rxdp = mac_control->rings[ring_no].
+				rx_blocks[block_no].block_virt_addr;
 			DBG_PRINT(INTR_DBG, "%s: Next block at: %p\n",
 				  dev->name, rxdp);
 		}
 #ifndef CONFIG_S2IO_NAPI
 		spin_lock_irqsave(&nic->put_lock, flags);
 		mac_control->rings[ring_no].put_pos =
-		    (block_no * (MAX_RXDS_PER_BLOCK + 1)) + off;
+		    (block_no * (rxd_count[nic->rxd_mode] + 1)) + off;
 		spin_unlock_irqrestore(&nic->put_lock, flags);
 #endif
-#else
-		if (rxdp->Host_Control == END_OF_BLOCK) {
-			mac_control->rings[ring_no].rx_curr_put_info.
-			    block_index++;
-			mac_control->rings[ring_no].rx_curr_put_info.block_index
-			    %= mac_control->rings[ring_no].block_count;
-			block_no = mac_control->rings[ring_no].rx_curr_put_info
-			    .block_index;
-			off = 0;
-			DBG_PRINT(INTR_DBG, "%s: block%d at: 0x%llx\n",
-				  dev->name, block_no,
-				  (unsigned long long) rxdp->Control_1);
-			mac_control->rings[ring_no].rx_curr_put_info.offset =
-			    off;
-			rxdp = mac_control->rings[ring_no].rx_blocks[block_no].
-			    block_virt_addr;
-		}
-#ifndef CONFIG_S2IO_NAPI
-		spin_lock_irqsave(&nic->put_lock, flags);
-		mac_control->rings[ring_no].put_pos = (block_no *
-					 (MAX_RXDS_PER_BLOCK + 1)) + off;
-		spin_unlock_irqrestore(&nic->put_lock, flags);
-#endif
-#endif
-
-#ifndef	CONFIG_2BUFF_MODE
-		if (rxdp->Control_1 & RXD_OWN_XENA)
-#else
-		if (rxdp->Control_2 & BIT(0))
-#endif
-		{
+		if ((rxdp->Control_1 & RXD_OWN_XENA) &&
+			((nic->rxd_mode >= RXD_MODE_3A) &&
+				(rxdp->Control_2 & BIT(0)))) {
 			mac_control->rings[ring_no].rx_curr_put_info.
-			    offset = off;
+					offset = off;
 			goto end;
 		}
-#ifdef	CONFIG_2BUFF_MODE
-		/*
-		 * RxDs Spanning cache lines will be replenished only
-		 * if the succeeding RxD is also owned by Host. It
-		 * will always be the ((8*i)+3) and ((8*i)+6)
-		 * descriptors for the 48 byte descriptor. The offending
-		 * decsriptor is of-course the 3rd descriptor.
-		 */
-		rxdpphys = mac_control->rings[ring_no].rx_blocks[block_no].
-		    block_dma_addr + (off * sizeof(RxD_t));
-		if (((u64) (rxdpphys)) % 128 > 80) {
-			rxdpnext = mac_control->rings[ring_no].rx_blocks[block_no].
-			    block_virt_addr + (off + 1);
-			if (rxdpnext->Host_Control == END_OF_BLOCK) {
-				nextblk = (block_no + 1) %
-				    (mac_control->rings[ring_no].block_count);
-				rxdpnext = mac_control->rings[ring_no].rx_blocks
-				    [nextblk].block_virt_addr;
-			}
-			if (rxdpnext->Control_2 & BIT(0))
-				goto end;
-		}
-#endif
+		/* calculate size of skb based on ring mode */
+		size = dev->mtu + HEADER_ETHERNET_II_802_3_SIZE +
+				HEADER_802_2_SIZE + HEADER_SNAP_SIZE;
+		if (nic->rxd_mode == RXD_MODE_1)
+			size += NET_IP_ALIGN;
+		else if (nic->rxd_mode == RXD_MODE_3B)
+			size = dev->mtu + ALIGN_SIZE + BUF0_LEN + 4;
+		else
+			size = l3l4hdr_size + ALIGN_SIZE + BUF0_LEN + 4;
 
-#ifndef	CONFIG_2BUFF_MODE
-		skb = dev_alloc_skb(size + NET_IP_ALIGN);
-#else
-		skb = dev_alloc_skb(dev->mtu + ALIGN_SIZE + BUF0_LEN + 4);
-#endif
-		if (!skb) {
+		/* allocate skb */
+		skb = dev_alloc_skb(size);
+		if(!skb) {
 			DBG_PRINT(ERR_DBG, "%s: Out of ", dev->name);
 			DBG_PRINT(ERR_DBG, "memory to allocate SKBs\n");
 			if (first_rxdp) {
 				wmb();
 				first_rxdp->Control_1 |= RXD_OWN_XENA;
 			}
-			return -ENOMEM;
+			return -ENOMEM ;
+		}
+		if (nic->rxd_mode == RXD_MODE_1) {
+			/* 1 buffer mode - normal operation mode */
+			memset(rxdp, 0, sizeof(RxD1_t));
+			skb_reserve(skb, NET_IP_ALIGN);
+			((RxD1_t*)rxdp)->Buffer0_ptr = pci_map_single
+			    (nic->pdev, skb->data, size, PCI_DMA_FROMDEVICE);
+			rxdp->Control_2 &= (~MASK_BUFFER0_SIZE_1);
+			rxdp->Control_2 |= SET_BUFFER0_SIZE_1(size);
+
+		} else if (nic->rxd_mode >= RXD_MODE_3A) {
+			/*
+			 * 2 or 3 buffer mode -
+			 * Both 2 buffer mode and 3 buffer mode provides 128
+			 * byte aligned receive buffers.
+			 *
+			 * 3 buffer mode provides header separation where in
+			 * skb->data will have L3/L4 headers where as
+			 * skb_shinfo(skb)->frag_list will have the L4 data
+			 * payload
+			 */
+
+			memset(rxdp, 0, sizeof(RxD3_t));
+			ba = &mac_control->rings[ring_no].ba[block_no][off];
+			skb_reserve(skb, BUF0_LEN);
+			tmp = (u64)(unsigned long) skb->data;
+			tmp += ALIGN_SIZE;
+			tmp &= ~ALIGN_SIZE;
+			skb->data = (void *) (unsigned long)tmp;
+			skb->tail = (void *) (unsigned long)tmp;
+
+			((RxD3_t*)rxdp)->Buffer0_ptr =
+			    pci_map_single(nic->pdev, ba->ba_0, BUF0_LEN,
+					   PCI_DMA_FROMDEVICE);
+			rxdp->Control_2 = SET_BUFFER0_SIZE_3(BUF0_LEN);
+			if (nic->rxd_mode == RXD_MODE_3B) {
+				/* Two buffer mode */
+
+				/*
+				 * Buffer2 will have L3/L4 header plus 
+				 * L4 payload
+				 */
+				((RxD3_t*)rxdp)->Buffer2_ptr = pci_map_single
+				(nic->pdev, skb->data, dev->mtu + 4,
+						PCI_DMA_FROMDEVICE);
+
+				/* Buffer-1 will be dummy buffer not used */
+				((RxD3_t*)rxdp)->Buffer1_ptr =
+				pci_map_single(nic->pdev, ba->ba_1, BUF1_LEN,
+					PCI_DMA_FROMDEVICE);
+				rxdp->Control_2 |= SET_BUFFER1_SIZE_3(1);
+				rxdp->Control_2 |= SET_BUFFER2_SIZE_3
+								(dev->mtu + 4);
+			} else {
+				/* 3 buffer mode */
+				if (fill_rxd_3buf(nic, rxdp, skb) == -ENOMEM) {
+					dev_kfree_skb_irq(skb);
+					if (first_rxdp) {
+						wmb();
+						first_rxdp->Control_1 |=
+							RXD_OWN_XENA;
+					}
+					return -ENOMEM ;
+				}
+			}
+			rxdp->Control_2 |= BIT(0);
 		}
-#ifndef	CONFIG_2BUFF_MODE
-		skb_reserve(skb, NET_IP_ALIGN);
-		memset(rxdp, 0, sizeof(RxD_t));
-		rxdp->Buffer0_ptr = pci_map_single
-		    (nic->pdev, skb->data, size, PCI_DMA_FROMDEVICE);
-		rxdp->Control_2 &= (~MASK_BUFFER0_SIZE);
-		rxdp->Control_2 |= SET_BUFFER0_SIZE(size);
 		rxdp->Host_Control = (unsigned long) (skb);
 		if (alloc_tab & ((1 << rxsync_frequency) - 1))
 			rxdp->Control_1 |= RXD_OWN_XENA;
 		off++;
-		off %= (MAX_RXDS_PER_BLOCK + 1);
-		mac_control->rings[ring_no].rx_curr_put_info.offset = off;
-#else
-		ba = &mac_control->rings[ring_no].ba[block_no][off];
-		skb_reserve(skb, BUF0_LEN);
-		tmp = ((unsigned long) skb->data & ALIGN_SIZE);
-		if (tmp)
-			skb_reserve(skb, (ALIGN_SIZE + 1) - tmp);
-
-		memset(rxdp, 0, sizeof(RxD_t));
-		rxdp->Buffer2_ptr = pci_map_single
-		    (nic->pdev, skb->data, dev->mtu + BUF0_LEN + 4,
-		     PCI_DMA_FROMDEVICE);
-		rxdp->Buffer0_ptr =
-		    pci_map_single(nic->pdev, ba->ba_0, BUF0_LEN,
-				   PCI_DMA_FROMDEVICE);
-		rxdp->Buffer1_ptr =
-		    pci_map_single(nic->pdev, ba->ba_1, BUF1_LEN,
-				   PCI_DMA_FROMDEVICE);
-
-		rxdp->Control_2 = SET_BUFFER2_SIZE(dev->mtu + 4);
-		rxdp->Control_2 |= SET_BUFFER0_SIZE(BUF0_LEN);
-		rxdp->Control_2 |= SET_BUFFER1_SIZE(1);	/* dummy. */
-		rxdp->Control_2 |= BIT(0);	/* Set Buffer_Empty bit. */
-		rxdp->Host_Control = (u64) ((unsigned long) (skb));
-		if (alloc_tab & ((1 << rxsync_frequency) - 1))
-			rxdp->Control_1 |= RXD_OWN_XENA;
-		off++;
+		if (off == (rxd_count[nic->rxd_mode] + 1))
+			off = 0;
 		mac_control->rings[ring_no].rx_curr_put_info.offset = off;
-#endif
-		rxdp->Control_2 |= SET_RXD_MARKER;
 
+		rxdp->Control_2 |= SET_RXD_MARKER;
 		if (!(alloc_tab & ((1 << rxsync_frequency) - 1))) {
 			if (first_rxdp) {
 				wmb();
@@ -2325,6 +2354,67 @@ int fill_rx_buffers(struct s2io_nic *nic
 	return SUCCESS;
 }
 
+static void free_rxd_blk(struct s2io_nic *sp, int ring_no, int blk)
+{
+	struct net_device *dev = sp->dev;
+	int j;
+	struct sk_buff *skb;
+	RxD_t *rxdp;
+	mac_info_t *mac_control;
+	buffAdd_t *ba;
+
+	mac_control = &sp->mac_control;
+	for (j = 0 ; j < rxd_count[sp->rxd_mode]; j++) {
+		rxdp = mac_control->rings[ring_no].
+                                rx_blocks[blk].rxds[j].virt_addr;
+		skb = (struct sk_buff *)
+			((unsigned long) rxdp->Host_Control);
+		if (!skb) {
+			continue;
+		}
+		if (sp->rxd_mode == RXD_MODE_1) {
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				 ((RxD1_t*)rxdp)->Buffer0_ptr,
+				 dev->mtu +
+				 HEADER_ETHERNET_II_802_3_SIZE
+				 + HEADER_802_2_SIZE +
+				 HEADER_SNAP_SIZE,
+				 PCI_DMA_FROMDEVICE);
+			memset(rxdp, 0, sizeof(RxD1_t));
+		} else if(sp->rxd_mode == RXD_MODE_3B) {
+			ba = &mac_control->rings[ring_no].
+				ba[blk][j];
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				 ((RxD3_t*)rxdp)->Buffer0_ptr,
+				 BUF0_LEN,
+				 PCI_DMA_FROMDEVICE);
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				 ((RxD3_t*)rxdp)->Buffer1_ptr,
+				 BUF1_LEN,
+				 PCI_DMA_FROMDEVICE);
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				 ((RxD3_t*)rxdp)->Buffer2_ptr,
+				 dev->mtu + 4,
+				 PCI_DMA_FROMDEVICE);
+			memset(rxdp, 0, sizeof(RxD3_t));
+		} else {
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				((RxD3_t*)rxdp)->Buffer0_ptr, BUF0_LEN,
+				PCI_DMA_FROMDEVICE);
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				((RxD3_t*)rxdp)->Buffer1_ptr, 
+				l3l4hdr_size + 4,
+				PCI_DMA_FROMDEVICE);
+			pci_unmap_single(sp->pdev, (dma_addr_t)
+				((RxD3_t*)rxdp)->Buffer2_ptr, dev->mtu,
+				PCI_DMA_FROMDEVICE);
+			memset(rxdp, 0, sizeof(RxD3_t));
+		}
+		dev_kfree_skb(skb);
+		atomic_dec(&sp->rx_bufs_left[ring_no]);
+	}
+}
+
 /**
  *  free_rx_buffers - Frees all Rx buffers
  *  @sp: device private variable.
@@ -2337,77 +2427,17 @@ int fill_rx_buffers(struct s2io_nic *nic
 static void free_rx_buffers(struct s2io_nic *sp)
 {
 	struct net_device *dev = sp->dev;
-	int i, j, blk = 0, off, buf_cnt = 0;
-	RxD_t *rxdp;
-	struct sk_buff *skb;
+	int i, blk = 0, buf_cnt = 0;
 	mac_info_t *mac_control;
 	struct config_param *config;
-#ifdef CONFIG_2BUFF_MODE
-	buffAdd_t *ba;
-#endif
 
 	mac_control = &sp->mac_control;
 	config = &sp->config;
 
 	for (i = 0; i < config->rx_ring_num; i++) {
-		for (j = 0, blk = 0; j < config->rx_cfg[i].num_rxd; j++) {
-			off = j % (MAX_RXDS_PER_BLOCK + 1);
-			rxdp = mac_control->rings[i].rx_blocks[blk].
-				block_virt_addr + off;
-
-#ifndef CONFIG_2BUFF_MODE
-			if (rxdp->Control_1 == END_OF_BLOCK) {
-				rxdp =
-				    (RxD_t *) ((unsigned long) rxdp->
-					       Control_2);
-				j++;
-				blk++;
-			}
-#else
-			if (rxdp->Host_Control == END_OF_BLOCK) {
-				blk++;
-				continue;
-			}
-#endif
+		for (blk = 0; blk < rx_ring_sz[i]; blk++)
+			free_rxd_blk(sp,i,blk);
 
-			if (!(rxdp->Control_1 & RXD_OWN_XENA)) {
-				memset(rxdp, 0, sizeof(RxD_t));
-				continue;
-			}
-
-			skb =
-			    (struct sk_buff *) ((unsigned long) rxdp->
-						Host_Control);
-			if (skb) {
-#ifndef CONFIG_2BUFF_MODE
-				pci_unmap_single(sp->pdev, (dma_addr_t)
-						 rxdp->Buffer0_ptr,
-						 dev->mtu +
-						 HEADER_ETHERNET_II_802_3_SIZE
-						 + HEADER_802_2_SIZE +
-						 HEADER_SNAP_SIZE,
-						 PCI_DMA_FROMDEVICE);
-#else
-				ba = &mac_control->rings[i].ba[blk][off];
-				pci_unmap_single(sp->pdev, (dma_addr_t)
-						 rxdp->Buffer0_ptr,
-						 BUF0_LEN,
-						 PCI_DMA_FROMDEVICE);
-				pci_unmap_single(sp->pdev, (dma_addr_t)
-						 rxdp->Buffer1_ptr,
-						 BUF1_LEN,
-						 PCI_DMA_FROMDEVICE);
-				pci_unmap_single(sp->pdev, (dma_addr_t)
-						 rxdp->Buffer2_ptr,
-						 dev->mtu + BUF0_LEN + 4,
-						 PCI_DMA_FROMDEVICE);
-#endif
-				dev_kfree_skb(skb);
-				atomic_dec(&sp->rx_bufs_left[i]);
-				buf_cnt++;
-			}
-			memset(rxdp, 0, sizeof(RxD_t));
-		}
 		mac_control->rings[i].rx_curr_put_info.block_index = 0;
 		mac_control->rings[i].rx_curr_get_info.block_index = 0;
 		mac_control->rings[i].rx_curr_put_info.offset = 0;
@@ -2513,7 +2543,7 @@ static void rx_intr_handler(ring_info_t 
 {
 	nic_t *nic = ring_data->nic;
 	struct net_device *dev = (struct net_device *) nic->dev;
-	int get_block, get_offset, put_block, put_offset, ring_bufs;
+	int get_block, put_block, put_offset;
 	rx_curr_get_info_t get_info, put_info;
 	RxD_t *rxdp;
 	struct sk_buff *skb;
@@ -2532,21 +2562,22 @@ static void rx_intr_handler(ring_info_t 
 	get_block = get_info.block_index;
 	put_info = ring_data->rx_curr_put_info;
 	put_block = put_info.block_index;
-	ring_bufs = get_info.ring_len+1;
-	rxdp = ring_data->rx_blocks[get_block].block_virt_addr +
-		    get_info.offset;
-	get_offset = (get_block * (MAX_RXDS_PER_BLOCK + 1)) +
-		get_info.offset;
+	rxdp = ring_data->rx_blocks[get_block].rxds[get_info.offset].virt_addr;
 #ifndef CONFIG_S2IO_NAPI
 	spin_lock(&nic->put_lock);
 	put_offset = ring_data->put_pos;
 	spin_unlock(&nic->put_lock);
 #else
-	put_offset = (put_block * (MAX_RXDS_PER_BLOCK + 1)) +
+	put_offset = (put_block * (rxd_count[nic->rxd_mode] + 1)) +
 		put_info.offset;
 #endif
-	while (RXD_IS_UP2DT(rxdp) &&
-	       (((get_offset + 1) % ring_bufs) != put_offset)) {
+	while (RXD_IS_UP2DT(rxdp)) {
+		/* If your are next to put index then it's FIFO full condition */
+		if ((get_block == put_block) &&
+		    (get_info.offset + 1) == put_info.offset) {
+			DBG_PRINT(ERR_DBG, "%s: Ring Full\n",dev->name);
+			break;
+		}
 		skb = (struct sk_buff *) ((unsigned long)rxdp->Host_Control);
 		if (skb == NULL) {
 			DBG_PRINT(ERR_DBG, "%s: The skb is ",
@@ -2555,46 +2586,52 @@ static void rx_intr_handler(ring_info_t 
 			spin_unlock(&nic->rx_lock);
 			return;
 		}
-#ifndef CONFIG_2BUFF_MODE
-		pci_unmap_single(nic->pdev, (dma_addr_t)
-				 rxdp->Buffer0_ptr,
+		if (nic->rxd_mode == RXD_MODE_1) {
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+				 ((RxD1_t*)rxdp)->Buffer0_ptr,
 				 dev->mtu +
 				 HEADER_ETHERNET_II_802_3_SIZE +
 				 HEADER_802_2_SIZE +
 				 HEADER_SNAP_SIZE,
 				 PCI_DMA_FROMDEVICE);
-#else
-		pci_unmap_single(nic->pdev, (dma_addr_t)
-				 rxdp->Buffer0_ptr,
+		} else if (nic->rxd_mode == RXD_MODE_3B) {
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+				 ((RxD3_t*)rxdp)->Buffer0_ptr,
 				 BUF0_LEN, PCI_DMA_FROMDEVICE);
-		pci_unmap_single(nic->pdev, (dma_addr_t)
-				 rxdp->Buffer1_ptr,
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+				 ((RxD3_t*)rxdp)->Buffer1_ptr,
 				 BUF1_LEN, PCI_DMA_FROMDEVICE);
-		pci_unmap_single(nic->pdev, (dma_addr_t)
-				 rxdp->Buffer2_ptr,
-				 dev->mtu + BUF0_LEN + 4,
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+				 ((RxD3_t*)rxdp)->Buffer2_ptr,
+				 dev->mtu + 4,
 				 PCI_DMA_FROMDEVICE);
-#endif
+		} else {
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+					 ((RxD3_t*)rxdp)->Buffer0_ptr, BUF0_LEN,
+					 PCI_DMA_FROMDEVICE);
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+					 ((RxD3_t*)rxdp)->Buffer1_ptr,
+					 l3l4hdr_size + 4,
+					 PCI_DMA_FROMDEVICE);
+			pci_unmap_single(nic->pdev, (dma_addr_t)
+					 ((RxD3_t*)rxdp)->Buffer2_ptr,
+					 dev->mtu, PCI_DMA_FROMDEVICE);
+		}
 		rx_osm_handler(ring_data, rxdp);
 		get_info.offset++;
-		ring_data->rx_curr_get_info.offset =
-		    get_info.offset;
-		rxdp = ring_data->rx_blocks[get_block].block_virt_addr +
-		    get_info.offset;
-		if (get_info.offset &&
-		    (!(get_info.offset % MAX_RXDS_PER_BLOCK))) {
+		ring_data->rx_curr_get_info.offset = get_info.offset;
+		rxdp = ring_data->rx_blocks[get_block].
+				rxds[get_info.offset].virt_addr;
+		if (get_info.offset == rxd_count[nic->rxd_mode]) {
 			get_info.offset = 0;
-			ring_data->rx_curr_get_info.offset
-			    = get_info.offset;
+			ring_data->rx_curr_get_info.offset = get_info.offset;
 			get_block++;
-			get_block %= ring_data->block_count;
-			ring_data->rx_curr_get_info.block_index
-			    = get_block;
+			if (get_block == ring_data->block_count)
+				get_block = 0;
+			ring_data->rx_curr_get_info.block_index = get_block;
 			rxdp = ring_data->rx_blocks[get_block].block_virt_addr;
 		}
 
-		get_offset = (get_block * (MAX_RXDS_PER_BLOCK + 1)) +
-			    get_info.offset;
 #ifdef CONFIG_S2IO_NAPI
 		nic->pkts_to_process -= 1;
 		if (!nic->pkts_to_process)
@@ -3044,7 +3081,7 @@ int s2io_set_swapper(nic_t * sp)
 
 int wait_for_msix_trans(nic_t *nic, int i)
 {
-	XENA_dev_config_t __iomem *bar0 = nic->bar0;
+	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u64 val64;
 	int ret = 0, cnt = 0;
 
@@ -3065,7 +3102,7 @@ int wait_for_msix_trans(nic_t *nic, int 
 
 void restore_xmsi_data(nic_t *nic)
 {
-	XENA_dev_config_t __iomem *bar0 = nic->bar0;
+	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u64 val64;
 	int i;
 
@@ -3083,7 +3120,7 @@ void restore_xmsi_data(nic_t *nic)
 
 void store_xmsi_data(nic_t *nic)
 {
-	XENA_dev_config_t __iomem *bar0 = nic->bar0;
+	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u64 val64, addr, data;
 	int i;
 
@@ -3106,7 +3143,7 @@ void store_xmsi_data(nic_t *nic)
 
 int s2io_enable_msi(nic_t *nic)
 {
-	XENA_dev_config_t __iomem *bar0 = nic->bar0;
+	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u16 msi_ctrl, msg_val;
 	struct config_param *config = &nic->config;
 	struct net_device *dev = nic->dev;
@@ -3156,7 +3193,7 @@ int s2io_enable_msi(nic_t *nic)
 
 int s2io_enable_msi_x(nic_t *nic)
 {
-	XENA_dev_config_t __iomem *bar0 = nic->bar0;
+	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u64 tx_mat, rx_mat;
 	u16 msi_control; /* Temp variable */
 	int ret, i, j, msix_indx = 1;
@@ -5537,16 +5574,7 @@ static int rx_osm_handler(ring_info_t *r
 		((unsigned long) rxdp->Host_Control);
 	int ring_no = ring_data->ring_no;
 	u16 l3_csum, l4_csum;
-#ifdef CONFIG_2BUFF_MODE
-	int buf0_len = RXD_GET_BUFFER0_SIZE(rxdp->Control_2);
-	int buf2_len = RXD_GET_BUFFER2_SIZE(rxdp->Control_2);
-	int get_block = ring_data->rx_curr_get_info.block_index;
-	int get_off = ring_data->rx_curr_get_info.offset;
-	buffAdd_t *ba = &ring_data->ba[get_block][get_off];
-	unsigned char *buff;
-#else
-	u16 len = (u16) ((RXD_GET_BUFFER0_SIZE(rxdp->Control_2)) >> 48);;
-#endif
+
 	skb->dev = dev;
 	if (rxdp->Control_1 & RXD_T_CODE) {
 		unsigned long long err = rxdp->Control_1 & RXD_T_CODE;
@@ -5563,19 +5591,36 @@ static int rx_osm_handler(ring_info_t *r
 	rxdp->Host_Control = 0;
 	sp->rx_pkt_count++;
 	sp->stats.rx_packets++;
-#ifndef CONFIG_2BUFF_MODE
-	sp->stats.rx_bytes += len;
-#else
-	sp->stats.rx_bytes += buf0_len + buf2_len;
-#endif
+	if (sp->rxd_mode == RXD_MODE_1) {
+		int len = RXD_GET_BUFFER0_SIZE_1(rxdp->Control_2);
 
-#ifndef CONFIG_2BUFF_MODE
-	skb_put(skb, len);
-#else
-	buff = skb_push(skb, buf0_len);
-	memcpy(buff, ba->ba_0, buf0_len);
-	skb_put(skb, buf2_len);
-#endif
+		sp->stats.rx_bytes += len;
+		skb_put(skb, len);
+
+	} else if (sp->rxd_mode >= RXD_MODE_3A) {
+		int get_block = ring_data->rx_curr_get_info.block_index;
+		int get_off = ring_data->rx_curr_get_info.offset;
+		int buf0_len = RXD_GET_BUFFER0_SIZE_3(rxdp->Control_2);
+		int buf2_len = RXD_GET_BUFFER2_SIZE_3(rxdp->Control_2);
+		unsigned char *buff = skb_push(skb, buf0_len);
+
+		buffAdd_t *ba = &ring_data->ba[get_block][get_off];
+		sp->stats.rx_bytes += buf0_len + buf2_len;
+		memcpy(buff, ba->ba_0, buf0_len);
+
+		if (sp->rxd_mode == RXD_MODE_3A) {
+			int buf1_len = RXD_GET_BUFFER1_SIZE_3(rxdp->Control_2);
+
+			skb_put(skb, buf1_len);
+			skb->len += buf2_len;
+			skb->data_len += buf2_len;
+			skb->truesize += buf2_len;
+			skb_put(skb_shinfo(skb)->frag_list, buf2_len);
+			sp->stats.rx_bytes += buf1_len;
+
+		} else
+			skb_put(skb, buf2_len);
+	}
 
 	if ((rxdp->Control_1 & TCP_OR_UDP_FRAME) &&
 	    (sp->rx_csum)) {
@@ -5711,6 +5756,7 @@ MODULE_VERSION(DRV_VERSION);
 
 module_param(tx_fifo_num, int, 0);
 module_param(rx_ring_num, int, 0);
+module_param(rx_ring_mode, int, 0);
 module_param_array(tx_fifo_len, uint, NULL, 0);
 module_param_array(rx_ring_sz, uint, NULL, 0);
 module_param_array(rts_frm_len, uint, NULL, 0);
@@ -5722,6 +5768,7 @@ module_param(shared_splits, int, 0);
 module_param(tmac_util_period, int, 0);
 module_param(rmac_util_period, int, 0);
 module_param(bimodal, bool, 0);
+module_param(l3l4hdr_size, int , 0);
 #ifndef CONFIG_S2IO_NAPI
 module_param(indicate_max_pkts, int, 0);
 #endif
@@ -5843,6 +5890,13 @@ Defaulting to INTA\n");
 	sp->pdev = pdev;
 	sp->high_dma_flag = dma_flag;
 	sp->device_enabled_once = FALSE;
+	if (rx_ring_mode == 1)
+		sp->rxd_mode = RXD_MODE_1;
+	if (rx_ring_mode == 2)
+		sp->rxd_mode = RXD_MODE_3B;
+	if (rx_ring_mode == 3)
+		sp->rxd_mode = RXD_MODE_3A;
+
 	sp->intr_type = dev_intr_type;
 
 	if ((pdev->device == PCI_DEVICE_ID_HERC_WIN) ||
@@ -5895,7 +5949,7 @@ Defaulting to INTA\n");
 	config->rx_ring_num = rx_ring_num;
 	for (i = 0; i < MAX_RX_RINGS; i++) {
 		config->rx_cfg[i].num_rxd = rx_ring_sz[i] *
-		    (MAX_RXDS_PER_BLOCK + 1);
+		    (rxd_count[sp->rxd_mode] + 1);
 		config->rx_cfg[i].ring_priority = i;
 	}
 
@@ -6090,9 +6144,6 @@ Defaulting to INTA\n");
 		DBG_PRINT(ERR_DBG, "(rev %d), Version %s",
 				get_xena_rev_id(sp->pdev),
 				s2io_driver_version);
-#ifdef CONFIG_2BUFF_MODE
-		DBG_PRINT(ERR_DBG, ", Buffer mode %d",2);
-#endif
 		switch(sp->intr_type) {
 			case INTA:
 				DBG_PRINT(ERR_DBG, ", Intr type INTA");
@@ -6125,9 +6176,6 @@ Defaulting to INTA\n");
 		DBG_PRINT(ERR_DBG, "(rev %d), Version %s",
 					get_xena_rev_id(sp->pdev),
 					s2io_driver_version);
-#ifdef CONFIG_2BUFF_MODE
-		DBG_PRINT(ERR_DBG, ", Buffer mode %d",2);
-#endif
 		switch(sp->intr_type) {
 			case INTA:
 				DBG_PRINT(ERR_DBG, ", Intr type INTA");
@@ -6148,6 +6196,12 @@ Defaulting to INTA\n");
 			  sp->def_mac_addr[0].mac_addr[4],
 			  sp->def_mac_addr[0].mac_addr[5]);
 	}
+	if (sp->rxd_mode == RXD_MODE_3B)
+		DBG_PRINT(ERR_DBG, "%s: 2-Buffer mode support has been "
+			  "enabled\n",dev->name);
+	if (sp->rxd_mode == RXD_MODE_3A)
+		DBG_PRINT(ERR_DBG, "%s: 3-Buffer mode support has been "
+			  "enabled\n",dev->name);
 
 	/* Initialize device name */
 	strcpy(sp->name, dev->name);
diff --git a/drivers/net/s2io.h b/drivers/net/s2io.h
index 1cc24b5..419aad7 100644
--- a/drivers/net/s2io.h
+++ b/drivers/net/s2io.h
@@ -418,7 +418,7 @@ typedef struct list_info_hold {
 	void *list_virt_addr;
 } list_info_hold_t;
 
-/* Rx descriptor structure */
+/* Rx descriptor structure for 1 buffer mode */
 typedef struct _RxD_t {
 	u64 Host_Control;	/* reserved for host */
 	u64 Control_1;
@@ -439,49 +439,54 @@ typedef struct _RxD_t {
 #define	SET_RXD_MARKER		vBIT(THE_RXD_MARK, 0, 2)
 #define	GET_RXD_MARKER(ctrl)	((ctrl & SET_RXD_MARKER) >> 62)
 
-#ifndef CONFIG_2BUFF_MODE
-#define MASK_BUFFER0_SIZE       vBIT(0x3FFF,2,14)
-#define SET_BUFFER0_SIZE(val)   vBIT(val,2,14)
-#else
-#define MASK_BUFFER0_SIZE       vBIT(0xFF,2,14)
-#define MASK_BUFFER1_SIZE       vBIT(0xFFFF,16,16)
-#define MASK_BUFFER2_SIZE       vBIT(0xFFFF,32,16)
-#define SET_BUFFER0_SIZE(val)   vBIT(val,8,8)
-#define SET_BUFFER1_SIZE(val)   vBIT(val,16,16)
-#define SET_BUFFER2_SIZE(val)   vBIT(val,32,16)
-#endif
-
 #define MASK_VLAN_TAG           vBIT(0xFFFF,48,16)
 #define SET_VLAN_TAG(val)       vBIT(val,48,16)
 #define SET_NUM_TAG(val)       vBIT(val,16,32)
 
-#ifndef CONFIG_2BUFF_MODE
-#define RXD_GET_BUFFER0_SIZE(Control_2) (u64)((Control_2 & vBIT(0x3FFF,2,14)))
-#else
-#define RXD_GET_BUFFER0_SIZE(Control_2) (u8)((Control_2 & MASK_BUFFER0_SIZE) \
-							>> 48)
-#define RXD_GET_BUFFER1_SIZE(Control_2) (u16)((Control_2 & MASK_BUFFER1_SIZE) \
-							>> 32)
-#define RXD_GET_BUFFER2_SIZE(Control_2) (u16)((Control_2 & MASK_BUFFER2_SIZE) \
-							>> 16)
+
+} RxD_t;
+/* Rx descriptor structure for 1 buffer mode */
+typedef struct _RxD1_t {
+	struct _RxD_t h;
+
+#define MASK_BUFFER0_SIZE_1       vBIT(0x3FFF,2,14)
+#define SET_BUFFER0_SIZE_1(val)   vBIT(val,2,14)
+#define RXD_GET_BUFFER0_SIZE_1(_Control_2) \
+	(u16)((_Control_2 & MASK_BUFFER0_SIZE_1) >> 48)
+	u64 Buffer0_ptr;
+} RxD1_t;
+/* Rx descriptor structure for 3 or 2 buffer mode */
+
+typedef struct _RxD3_t {
+	struct _RxD_t h;
+
+#define MASK_BUFFER0_SIZE_3       vBIT(0xFF,2,14)
+#define MASK_BUFFER1_SIZE_3       vBIT(0xFFFF,16,16)
+#define MASK_BUFFER2_SIZE_3       vBIT(0xFFFF,32,16)
+#define SET_BUFFER0_SIZE_3(val)   vBIT(val,8,8)
+#define SET_BUFFER1_SIZE_3(val)   vBIT(val,16,16)
+#define SET_BUFFER2_SIZE_3(val)   vBIT(val,32,16)
+#define RXD_GET_BUFFER0_SIZE_3(Control_2) \
+	(u8)((Control_2 & MASK_BUFFER0_SIZE_3) >> 48)
+#define RXD_GET_BUFFER1_SIZE_3(Control_2) \
+	(u16)((Control_2 & MASK_BUFFER1_SIZE_3) >> 32)
+#define RXD_GET_BUFFER2_SIZE_3(Control_2) \
+	(u16)((Control_2 & MASK_BUFFER2_SIZE_3) >> 16)
 #define BUF0_LEN	40
 #define BUF1_LEN	1
-#endif
 
 	u64 Buffer0_ptr;
-#ifdef CONFIG_2BUFF_MODE
 	u64 Buffer1_ptr;
 	u64 Buffer2_ptr;
-#endif
-} RxD_t;
+} RxD3_t;
+
 
 /* Structure that represents the Rx descriptor block which contains
  * 128 Rx descriptors.
  */
-#ifndef CONFIG_2BUFF_MODE
 typedef struct _RxD_block {
-#define MAX_RXDS_PER_BLOCK             127
-	RxD_t rxd[MAX_RXDS_PER_BLOCK];
+#define MAX_RXDS_PER_BLOCK_1            127
+	RxD1_t rxd[MAX_RXDS_PER_BLOCK_1];
 
 	u64 reserved_0;
 #define END_OF_BLOCK    0xFEFFFFFFFFFFFFFFULL
@@ -492,18 +497,13 @@ typedef struct _RxD_block {
 					 * the upper 32 bits should
 					 * be 0 */
 } RxD_block_t;
-#else
-typedef struct _RxD_block {
-#define MAX_RXDS_PER_BLOCK             85
-	RxD_t rxd[MAX_RXDS_PER_BLOCK];
 
-#define END_OF_BLOCK    0xFEFFFFFFFFFFFFFFULL
-	u64 reserved_1;		/* 0xFEFFFFFFFFFFFFFF to mark last Rxd
-				 * in this blk */
-	u64 pNext_RxD_Blk_physical;	/* Phy ponter to next blk. */
-} RxD_block_t;
 #define SIZE_OF_BLOCK	4096
 
+#define RXD_MODE_1	0
+#define RXD_MODE_3A	1
+#define RXD_MODE_3B	2
+
 /* Structure to hold virtual addresses of Buf0 and Buf1 in
  * 2buf mode. */
 typedef struct bufAdd {
@@ -512,7 +512,6 @@ typedef struct bufAdd {
 	void *ba_0;
 	void *ba_1;
 } buffAdd_t;
-#endif
 
 /* Structure which stores all the MAC control parameters */
 
@@ -539,10 +538,17 @@ typedef struct {
 
 typedef tx_curr_get_info_t tx_curr_put_info_t;
 
+
+typedef struct rxd_info {
+	void *virt_addr;
+	dma_addr_t dma_addr;
+}rxd_info_t;
+
 /* Structure that holds the Phy and virt addresses of the Blocks */
 typedef struct rx_block_info {
-	RxD_t *block_virt_addr;
+	void *block_virt_addr;
 	dma_addr_t block_dma_addr;
+	rxd_info_t *rxds;
 } rx_block_info_t;
 
 /* pre declaration of the nic structure */
@@ -578,10 +584,8 @@ typedef struct ring_info {
 	int put_pos;
 #endif
 
-#ifdef CONFIG_2BUFF_MODE
 	/* Buffer Address store. */
 	buffAdd_t **ba;
-#endif
 	nic_t *nic;
 } ring_info_t;
 
@@ -647,8 +651,6 @@ typedef struct {
 
 /* Default Tunable parameters of the NIC. */
 #define DEFAULT_FIFO_LEN 4096
-#define SMALL_RXD_CNT	30 * (MAX_RXDS_PER_BLOCK+1)
-#define LARGE_RXD_CNT	100 * (MAX_RXDS_PER_BLOCK+1)
 #define SMALL_BLK_CNT	30
 #define LARGE_BLK_CNT	100
 
@@ -678,6 +680,7 @@ struct msix_info_st {
 
 /* Structure representing one instance of the NIC */
 struct s2io_nic {
+	int rxd_mode;
 #ifdef CONFIG_S2IO_NAPI
 	/*
 	 * Count of packets to be processed in a given iteration, it will be indicated
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 750c016..849ac88 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -2040,7 +2040,7 @@ static int mpi_send_packet (struct net_d
 	return 1;
 }
 
-static void get_tx_error(struct airo_info *ai, u32 fid)
+static void get_tx_error(struct airo_info *ai, s32 fid)
 {
 	u16 status;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 72cb67b..92a9696 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -72,6 +72,9 @@ struct mii_bus {
 	/* list of all PHYs on bus */
 	struct phy_device *phy_map[PHY_MAX_ADDR];
 
+	/* Phy addresses to be ignored when probing */
+	u32 phy_mask;
+
 	/* Pointer to an array of interrupts, each PHY's
 	 * interrupt at the index matching its address */
 	int *irq;
