Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTHaOMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbTHaOLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:11:52 -0400
Received: from havoc.gtf.org ([63.247.75.124]:18600 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262150AbTHaOJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:09:44 -0400
Date: Sun, 31 Aug 2003 10:09:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: marcelo@parcelfarce.linux.theplanet.co.uk
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [bk patches] 2.4.x net driver updates
Message-ID: <20030831140943.GA5198@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4

This will update the following files:

 drivers/net/3c527.c             |    7 
 drivers/net/8139cp.c            |  331 ++++++++++++++++------------------------
 drivers/net/8139too.c           |   70 ++++----
 drivers/net/eth16i.c            |    3 
 drivers/net/fmv18x.c            |    3 
 drivers/net/pcmcia/3c574_cs.c   |    9 -
 drivers/net/pcmcia/axnet_cs.c   |    3 
 drivers/net/pcmcia/pcnet_cs.c   |    3 
 drivers/net/pcmcia/xirc2ps_cs.c |    9 -
 drivers/net/seeq8005.c          |    4 
 drivers/net/yellowfin.c         |    4 
 11 files changed, 199 insertions(+), 247 deletions(-)

through these ChangeSets:

<purna@jcom.home.ne.jp> (03/08/31 1.1114)
   [netdrvr] fix skb_padto bugs introduced when skb_padto was introduced
   
   It seems that skb_padto security fixes in 2.4 and 2.5 trying
   to fix "CAN-2003-0001:Multiple ethernet NID device drivers
   do not pad frames with null bytes", do not put the skb_padto
   blocks in proper places in the  3c527, eth16i, fmv18x, seeq8005,
   yellowfin device drivers.   
   
   In case a driver calls skb_padto(), it is possible
   that the space available in the original skb buffer tailroom is less
   than the space to pad. In this case, in short, the skb_padto()
   will create a new skb buffer, copy data from the original
   skb buffer to a new skb buffer, free the original buffer,
   and finally return the new buffer.
   
   If this happens to the aforementioned device drivers, they come to
   point to wrong data. And, for 3c527 and yellowfin, the drivers can
   unexpectedly double free the original skb buffers since they still
   point to the original skb buffers. The attached patch against
   2.4.23pre1 fixes these issues.

<jgarzik@redhat.com> (03/08/31 1.1113)
   [netdrvr 8139too] remove useless board names
   
   The only thing that differentiated most of the entries in the
   board_info[] table and the board_t type was the vendor branding
   string for the board.  This table is a pain to maintain, so we
   prefer to simply use "RTL8129" or "RTL8139".

<lethal@linux-sh.org> (03/08/31 1.1112)
   [netdrvr 8139too] fix and pci ids needed for SH platform
   
   a.k.a. Sega Broadband Adapter.

<jgarzik@redhat.com> (03/08/31 1.1111)
   [netdrvr pcmcia] support SIOC[GS]MII{PHY,REG} ioctls
   
   Updated drivers;  3c574_cs, axnet_cs, pcnet_cs, xirc2ps_cs
   
   Thanks to Komuro for pointing this out.

<jgarzik@redhat.com> (03/08/31 1.1110)
   [netdrvr 8139too] make features more persistent; fix PCI DAC mode
   
   * only set PCIDAC (64-bit PCI) bit in hardware if
     sizeof(dma_addr_t) > 32.  Need a better test for whether
     64-bit mode is _really_ needed.
   * cache chip command register in private struct.  this allows
     the setting of rx-vlan, rx-csum, and other features to be
     persistent across the entire lifetime of the net device.
   * remove dead private struct members frag_skb, dropping_frag,
     and pci_using_dac.

<jgarzik@redhat.com> (03/08/31 1.1109)
   [netdrvr 8139cp] stats improvements and fixes
   
   * make sure rx_frags is still accounted
   * query RxMissed register, and clear, upon each get-stats func call

<jgarzik@redhat.com> (03/08/30 1.1108)
   [netdrvr 8139cp] bump version

<jgarzik@redhat.com> (03/08/30 1.1107)
   [netdrvr 8139cp] fix NAPI bug; remove board_type distinction, not needed

<jgarzik@redhat.com> (03/08/30 1.1106)
   [netdrvr 8139cp] small cleanups
   
   * remove netif_queue_stopped test, netif_wake_queue already does that
   * move vlan stuff to top of file
   * remove __dev markers
   * update todo list at top of file
   * remove pci_set_dma_mask argument casts; ULL suffixes preferred.

<jgarzik@redhat.com> (03/08/30 1.1105)
   [netdrvr 8139cp] remove mentions of RTL8169 (now handled by "r8169")

<jgarzik@redhat.com> (03/08/30 1.1104)
   [netdrvr 8139cp] update todo list in header

<jgarzik@redhat.com> (03/08/30 1.1103)
   [netdrvr 8139cp] support NAPI on RX path; Ditch RX frag handling.
   
   NAPI is turned on unconditionally for the RX path.  The hardware
   supports interrupt mitigation, so that should be investigated too.
   
   RX fragment handling removed.  We simply ensure that we alloc
   buffers large enough to hold incoming packets.  Any stray RX
   frags that occur (shouldn't be any) will be dropped.

<jgarzik@redhat.com> (03/08/30 1.1102)
   [netdrvr 8139cp] build TX checksumming code, but default OFF
   
   (previously it was ifdef'd)
   
   Also, bump version to 1.0.



diff -Nru a/drivers/net/3c527.c b/drivers/net/3c527.c
--- a/drivers/net/3c527.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/3c527.c	Sun Aug 31 10:06:32 2003
@@ -1083,15 +1083,16 @@
 	/* NP is the buffer we will be loading */
 	np=lp->tx_ring[lp->tx_ring_head].p; 
 
-	/* We will need this to flush the buffer out */
-	lp->tx_ring[lp->tx_ring_head].skb=skb;
-   	   
    	if(skb->len < ETH_ZLEN)
    	{
    		skb = skb_padto(skb, ETH_ZLEN);
    		if(skb == NULL)
    			goto out;
    	}
+
+	/* We will need this to flush the buffer out */
+	lp->tx_ring[lp->tx_ring_head].skb=skb;
+
 	np->length = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len; 
 			
 	np->data	= virt_to_bus(skb->data);
diff -Nru a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/8139cp.c	Sun Aug 31 10:06:32 2003
@@ -24,13 +24,13 @@
 		PCI suspend/resume  - Felipe Damasio <felipewd@terra.com.br>
 		LinkChg interrupt   - Felipe Damasio <felipewd@terra.com.br>
 			
-	TODO, in rough priority order:
+	TODO:
 	* Test Tx checksumming thoroughly
-	* dev->tx_timeout
-	* Constants (module parms?) for Rx work limit
+	* Implement dev->tx_timeout
+
+	Low priority TODO:
 	* Complete reset on PciErr
 	* Consider Rx interrupt mitigation using TimerIntr
-	* Handle netif_rx return value
 	* Investigate using skb->priority with h/w VLAN priority
 	* Investigate using High Priority Tx Queue with skb->priority
 	* Adjust Rx FIFO threshold and Max Rx DMA burst on Rx FIFO error
@@ -39,13 +39,17 @@
 	  Tx descriptor bit
 	* The real minimum of CP_MIN_MTU is 4 bytes.  However,
 	  for this to be supported, one must(?) turn on packet padding.
-	* Support external MII transceivers
+	* Support external MII transceivers (patch available)
+
+	NOTES:
+	* TX checksumming is considered experimental.  It is off by
+	  default, use ethtool to turn it on.
 
  */
 
 #define DRV_NAME		"8139cp"
-#define DRV_VERSION		"0.5"
-#define DRV_RELDATE		"Aug 26, 2003"
+#define DRV_VERSION		"1.1"
+#define DRV_RELDATE		"Aug 30, 2003"
 
 
 #include <linux/config.h>
@@ -68,9 +72,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-/* experimental TX checksumming feature enable/disable */
-#undef CP_TX_CHECKSUM
-
 /* VLAN tagging feature enable/disable */
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 #define CP_VLAN_TAG_USED 1
@@ -83,7 +84,7 @@
 #endif
 
 /* These identify the driver base version and may not be removed. */
-static char version[] __devinitdata =
+static char version[] =
 KERN_INFO DRV_NAME ": 10/100 PCI Ethernet driver v" DRV_VERSION " (" DRV_RELDATE ")\n";
 
 MODULE_AUTHOR("Jeff Garzik <jgarzik@pobox.com>");
@@ -157,6 +158,7 @@
 	TxConfig	= 0x40, /* Tx configuration */
 	ChipVersion	= 0x43, /* 8-bit chip version, inside TxConfig */
 	RxConfig	= 0x44, /* Rx configuration */
+	RxMissed	= 0x4C,	/* 24 bits valid, write clears */
 	Cfg9346		= 0x50, /* EEPROM select/control; Cfg reg [un]lock */
 	Config1		= 0x52, /* Config1 */
 	Config3		= 0x59, /* Config3 */
@@ -289,12 +291,11 @@
 	UWF             = (1 << 4),  /* Accept Unicast wakeup frame */
 	LANWake         = (1 << 1),  /* Enable LANWake signal */
 	PMEStatus	= (1 << 0),  /* PME status can be reset by PCI RST# */
-};
 
-static const unsigned int cp_intr_mask =
-	PciErr | LinkChg |
-	RxOK | RxErr | RxEmpty | RxFIFOOvr |
-	TxOK | TxErr | TxEmpty;
+	cp_norx_intr_mask = PciErr | LinkChg | TxOK | TxErr | TxEmpty,
+	cp_rx_intr_mask = RxOK | RxErr | RxEmpty | RxFIFOOvr,
+	cp_intr_mask = cp_rx_intr_mask | cp_norx_intr_mask,
+};
 
 static const unsigned int cp_rx_config =
 	  (RX_FIFO_THRESH << RxCfgFIFOShift) |
@@ -361,11 +362,7 @@
 
 	struct pci_dev		*pdev;
 	u32			rx_config;
-
-	struct sk_buff		*frag_skb;
-	unsigned		dropping_frag : 1;
-	unsigned		pci_using_dac : 1;
-	unsigned int		board_type;
+	u16			cpcmd;
 
 	unsigned int		wol_enabled : 1; /* Is Wake-on-LAN enabled? */
 	u32			power_state[16];
@@ -397,28 +394,9 @@
 static void cp_tx (struct cp_private *cp);
 static void cp_clean_rings (struct cp_private *cp);
 
-enum board_type {
-	RTL8139Cp,
-	RTL8169,
-};
-
-static struct cp_board_info {
-	const char *name;
-} cp_board_tbl[] __devinitdata = {
-	/* RTL8139Cp */
-	{ "RTL-8139C+" },
-
-	/* RTL8169 */
-	{ "RTL-8169" },
-};
-
 static struct pci_device_id cp_pci_tbl[] = {
 	{ PCI_VENDOR_ID_REALTEK, PCI_DEVICE_ID_REALTEK_8139,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139Cp },
-#if 0
-	{ PCI_VENDOR_ID_REALTEK, PCI_DEVICE_ID_REALTEK_8169,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8169 },
-#endif
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, cp_pci_tbl);
@@ -443,6 +421,31 @@
 };
 
 
+#if CP_VLAN_TAG_USED
+static void cp_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
+{
+	struct cp_private *cp = dev->priv;
+
+	spin_lock_irq(&cp->lock);
+	cp->vlgrp = grp;
+	cp->cpcmd |= RxVlanOn;
+	cpw16(CpCmd, cp->cpcmd);
+	spin_unlock_irq(&cp->lock);
+}
+
+static void cp_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
+{
+	struct cp_private *cp = dev->priv;
+
+	spin_lock_irq(&cp->lock);
+	cp->cpcmd &= ~RxVlanOn;
+	cpw16(CpCmd, cp->cpcmd);
+	if (cp->vlgrp)
+		cp->vlgrp->vlan_devices[vid] = NULL;
+	spin_unlock_irq(&cp->lock);
+}
+#endif /* CP_VLAN_TAG_USED */
+
 static inline void cp_set_rxbufsize (struct cp_private *cp)
 {
 	unsigned int mtu = cp->dev->mtu;
@@ -468,7 +471,7 @@
 		vlan_hwaccel_rx(skb, cp->vlgrp, be16_to_cpu(desc->opts2 & 0xffff));
 	} else
 #endif
-		netif_rx(skb);
+		netif_receive_skb(skb);
 }
 
 static void cp_rx_err_acct (struct cp_private *cp, unsigned rx_tail,
@@ -483,81 +486,14 @@
 		cp->net_stats.rx_frame_errors++;
 	if (status & RxErrCRC)
 		cp->net_stats.rx_crc_errors++;
-	if (status & RxErrRunt)
+	if ((status & RxErrRunt) || (status & RxErrLong))
 		cp->net_stats.rx_length_errors++;
-	if (status & RxErrLong)
+	if ((status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag))
 		cp->net_stats.rx_length_errors++;
 	if (status & RxErrFIFO)
 		cp->net_stats.rx_fifo_errors++;
 }
 
-static void cp_rx_frag (struct cp_private *cp, unsigned rx_tail,
-			struct sk_buff *skb, u32 status, u32 len)
-{
-	struct sk_buff *copy_skb, *frag_skb = cp->frag_skb;
-	unsigned orig_len = frag_skb ? frag_skb->len : 0;
-	unsigned target_len = orig_len + len;
-	unsigned first_frag = status & FirstFrag;
-	unsigned last_frag = status & LastFrag;
-
-	if (netif_msg_rx_status (cp))
-		printk (KERN_DEBUG "%s: rx %s%sfrag, slot %d status 0x%x len %d\n",
-			cp->dev->name,
-			cp->dropping_frag ? "dropping " : "",
-			first_frag ? "first " :
-			last_frag ? "last " : "",
-			rx_tail, status, len);
-
-	cp->cp_stats.rx_frags++;
-
-	if (!frag_skb && !first_frag)
-		cp->dropping_frag = 1;
-	if (cp->dropping_frag)
-		goto drop_frag;
-
-	copy_skb = dev_alloc_skb (target_len + RX_OFFSET);
-	if (!copy_skb) {
-		printk(KERN_WARNING "%s: rx slot %d alloc failed\n",
-		       cp->dev->name, rx_tail);
-
-		cp->dropping_frag = 1;
-drop_frag:
-		if (frag_skb) {
-			dev_kfree_skb_irq(frag_skb);
-			cp->frag_skb = NULL;
-		}
-		if (last_frag) {
-			cp->net_stats.rx_dropped++;
-			cp->dropping_frag = 0;
-		}
-		return;
-	}
-
-	copy_skb->dev = cp->dev;
-	skb_reserve(copy_skb, RX_OFFSET);
-	skb_put(copy_skb, target_len);
-	if (frag_skb) {
-		memcpy(copy_skb->data, frag_skb->data, orig_len);
-		dev_kfree_skb_irq(frag_skb);
-	}
-	pci_dma_sync_single(cp->pdev, cp->rx_skb[rx_tail].mapping,
-			    len, PCI_DMA_FROMDEVICE);
-	memcpy(copy_skb->data + orig_len, skb->data, len);
-
-	copy_skb->ip_summed = CHECKSUM_NONE;
-
-	if (last_frag) {
-		if (status & (RxError | RxErrFIFO)) {
-			cp_rx_err_acct(cp, rx_tail, status, len);
-			dev_kfree_skb_irq(copy_skb);
-		} else
-			cp_rx_skb(cp, copy_skb, &cp->rx_ring[rx_tail]);
-		cp->frag_skb = NULL;
-	} else {
-		cp->frag_skb = copy_skb;
-	}
-}
-
 static inline unsigned int cp_rx_csum_ok (u32 status)
 {
 	unsigned int protocol = (status >> 16) & 0x3;
@@ -571,12 +507,18 @@
 	return 0;
 }
 
-static void cp_rx (struct cp_private *cp)
+static int cp_rx_poll (struct net_device *dev, int *budget)
 {
+	struct cp_private *cp = dev->priv;
 	unsigned rx_tail = cp->rx_tail;
-	unsigned rx_work = 100;
+	unsigned rx_work = dev->quota;
+	unsigned rx;
 
-	while (rx_work--) {
+rx_status_loop:
+	rx = 0;
+	cpw16(IntrStatus, cp_rx_intr_mask);
+
+	while (1) {
 		u32 status, len;
 		dma_addr_t mapping;
 		struct sk_buff *skb, *new_skb;
@@ -596,7 +538,14 @@
 		mapping = cp->rx_skb[rx_tail].mapping;
 
 		if ((status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag)) {
-			cp_rx_frag(cp, rx_tail, skb, status, len);
+			/* we don't support incoming fragmented frames.
+			 * instead, we attempt to ensure that the
+			 * pre-allocated RX skbs are properly sized such
+			 * that RX fragments are never encountered
+			 */
+			cp_rx_err_acct(cp, rx_tail, status, len);
+			cp->net_stats.rx_dropped++;
+			cp->cp_stats.rx_frags++;
 			goto rx_next;
 		}
 
@@ -637,6 +586,7 @@
 		cp->rx_skb[rx_tail].skb = new_skb;
 
 		cp_rx_skb(cp, skb, desc);
+		rx++;
 
 rx_next:
 		cp->rx_ring[rx_tail].opts2 = 0;
@@ -647,12 +597,30 @@
 		else
 			desc->opts1 = cpu_to_le32(DescOwn | cp->rx_buf_sz);
 		rx_tail = NEXT_RX(rx_tail);
-	}
 
-	if (!rx_work)
-		printk(KERN_WARNING "%s: rx work limit reached\n", cp->dev->name);
+		if (!rx_work--)
+			break;
+	}
 
 	cp->rx_tail = rx_tail;
+
+	dev->quota -= rx;
+	*budget -= rx;
+
+	/* if we did not reach work limit, then we're done with
+	 * this round of polling
+	 */
+	if (rx_work) {
+		if (cpr16(IntrStatus) & cp_rx_intr_mask)
+			goto rx_status_loop;
+
+		cpw16_f(IntrMask, cp_intr_mask);
+		netif_rx_complete(dev);
+
+		return 0;	/* done */
+	}
+
+	return 1;		/* not done */
 }
 
 static irqreturn_t
@@ -670,12 +638,16 @@
 		printk(KERN_DEBUG "%s: intr, status %04x cmd %02x cpcmd %04x\n",
 		        dev->name, status, cpr8(Cmd), cpr16(CpCmd));
 
-	cpw16_f(IntrStatus, status);
+	cpw16(IntrStatus, status & ~cp_rx_intr_mask);
 
 	spin_lock(&cp->lock);
 
-	if (status & (RxOK | RxErr | RxEmpty | RxFIFOOvr))
-		cp_rx(cp);
+	if (status & (RxOK | RxErr | RxEmpty | RxFIFOOvr)) {
+		if (netif_rx_schedule_prep(dev)) {
+			cpw16_f(IntrMask, cp_norx_intr_mask);
+			__netif_rx_schedule(dev);
+		}
+	}
 	if (status & (TxOK | TxErr | TxEmpty | SWInt))
 		cp_tx(cp);
 	if (status & LinkChg)
@@ -688,6 +660,8 @@
 		pci_write_config_word(cp->pdev, PCI_STATUS, pci_status);
 		printk(KERN_ERR "%s: PCI bus error, status=%04x, PCI status=%04x\n",
 		       dev->name, status, pci_status);
+
+		/* TODO: reset hardware */
 	}
 
 	spin_unlock(&cp->lock);
@@ -747,7 +721,7 @@
 
 	cp->tx_tail = tx_tail;
 
-	if (netif_queue_stopped(cp->dev) && (TX_BUFFS_AVAIL(cp) > (MAX_SKB_FRAGS + 1)))
+	if (TX_BUFFS_AVAIL(cp) > (MAX_SKB_FRAGS + 1))
 		netif_wake_queue(cp->dev);
 }
 
@@ -789,7 +763,6 @@
 		txd->addr = cpu_to_le64(mapping);
 		wmb();
 
-#ifdef CP_TX_CHECKSUM
 		if (skb->ip_summed == CHECKSUM_HW) {
 			const struct iphdr *ip = skb->nh.iph;
 			if (ip->protocol == IPPROTO_TCP)
@@ -803,7 +776,6 @@
 			else
 				BUG();
 		} else
-#endif
 			txd->opts1 = cpu_to_le32(eor | len | DescOwn |
 						 FirstFrag | LastFrag);
 		wmb();
@@ -817,9 +789,7 @@
 		u32 first_len, first_eor;
 		dma_addr_t first_mapping;
 		int frag, first_entry = entry;
-#ifdef CP_TX_CHECKSUM
 		const struct iphdr *ip = skb->nh.iph;
-#endif
 
 		/* We must give this initial chunk to the device last.
 		 * Otherwise we could race with the device.
@@ -845,7 +815,7 @@
 						  this_frag->page_offset),
 						 len, PCI_DMA_TODEVICE);
 			eor = (entry == (CP_TX_RING_SIZE - 1)) ? RingEnd : 0;
-#ifdef CP_TX_CHECKSUM
+
 			if (skb->ip_summed == CHECKSUM_HW) {
 				ctrl = eor | len | DescOwn | IPCS;
 				if (ip->protocol == IPPROTO_TCP)
@@ -855,7 +825,6 @@
 				else
 					BUG();
 			} else
-#endif
 				ctrl = eor | len | DescOwn;
 
 			if (frag == skb_shinfo(skb)->nr_frags - 1)
@@ -880,7 +849,6 @@
 		txd->addr = cpu_to_le64(first_mapping);
 		wmb();
 
-#ifdef CP_TX_CHECKSUM
 		if (skb->ip_summed == CHECKSUM_HW) {
 			if (ip->protocol == IPPROTO_TCP)
 				txd->opts1 = cpu_to_le32(first_eor | first_len |
@@ -893,7 +861,6 @@
 			else
 				BUG();
 		} else
-#endif
 			txd->opts1 = cpu_to_le32(first_eor | first_len |
 						 FirstFrag | DescOwn);
 		wmb();
@@ -972,7 +939,9 @@
 
 static void __cp_get_stats(struct cp_private *cp)
 {
-	/* XXX implement */
+	/* only lower 24 bits valid; write any value to clear */
+	cp->net_stats.rx_missed_errors += (cpr32 (RxMissed) & 0xffffff);
+	cpw32 (RxMissed, 0);
 }
 
 static struct net_device_stats *cp_get_stats(struct net_device *dev)
@@ -992,11 +961,10 @@
 {
 	struct net_device *dev = cp->dev;
 
-	cpw16(IntrMask, 0);
-	cpr16(IntrMask);
+	cpw16(IntrStatus, ~(cpr16(IntrStatus)));
+	cpw16_f(IntrMask, 0);
 	cpw8(Cmd, 0);
-	cpw16(CpCmd, 0);
-	cpr16(CpCmd);
+	cpw16_f(CpCmd, 0);
 	cpw16(IntrStatus, ~(cpr16(IntrStatus)));
 	synchronize_irq();
 	udelay(10);
@@ -1028,11 +996,7 @@
 
 static inline void cp_start_hw (struct cp_private *cp)
 {
-	u16 pci_dac = cp->pci_using_dac ? PCIDAC : 0;
-	if (cp->board_type == RTL8169)
-		cpw16(CpCmd, pci_dac | PCIMulRW | RxChkSum);
-	else
-		cpw16(CpCmd, pci_dac | PCIMulRW | RxChkSum | CpRxOn | CpTxOn);
+	cpw16(CpCmd, cp->cpcmd);
 	cpw8(Cmd, RxOn | TxOn);
 }
 
@@ -1056,13 +1020,10 @@
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
 	/* Disable Wake-on-LAN. Can be turned on with ETHTOOL_SWOL */
-	if (cp->board_type == RTL8139Cp) {
-		cpw8(Config3, PARMEnable);
-		cp->wol_enabled = 0;
-	}
+	cpw8(Config3, PARMEnable);
+	cp->wol_enabled = 0;
+
 	cpw8(Config5, cpr8(Config5) & PMEStatus); 
-	if (cp->board_type == RTL8169)
-		cpw16(RxMaxSize, cp->rx_buf_sz);
 
 	cpw32_f(HiTxRingAddr, 0);
 	cpw32_f(HiTxRingAddr + 4, 0);
@@ -1255,8 +1216,6 @@
 
 	dev->mtu = new_mtu;
 	cp_set_rxbufsize(cp);		/* set new rx buf size */
-	if (cp->board_type == RTL8169)
-		cpw16(RxMaxSize, cp->rx_buf_sz);
 
 	rc = cp_init_rings(cp);		/* realloc and restart h/w */
 	cp_start_hw(cp);
@@ -1426,7 +1385,7 @@
 static int cp_set_rx_csum(struct net_device *dev, u32 data)
 {
 	struct cp_private *cp = dev->priv;
-	u16 cmd = cpr16(CpCmd), newcmd;
+	u16 cmd = cp->cpcmd, newcmd;
 
 	newcmd = cmd;
 
@@ -1437,6 +1396,7 @@
 
 	if (newcmd != cmd) {
 		spin_lock_irq(&cp->lock);
+		cp->cpcmd = newcmd;
 		cpw16_f(CpCmd, newcmd);
 		spin_unlock_irq(&cp->lock);
 	}
@@ -1581,29 +1541,6 @@
 	return rc;
 }
 
-#if CP_VLAN_TAG_USED
-static void cp_vlan_rx_register(struct net_device *dev, struct vlan_group *grp)
-{
-	struct cp_private *cp = dev->priv;
-
-	spin_lock_irq(&cp->lock);
-	cp->vlgrp = grp;
-	cpw16(CpCmd, cpr16(CpCmd) | RxVlanOn);
-	spin_unlock_irq(&cp->lock);
-}
-
-static void cp_vlan_rx_kill_vid(struct net_device *dev, unsigned short vid)
-{
-	struct cp_private *cp = dev->priv;
-
-	spin_lock_irq(&cp->lock);
-	cpw16(CpCmd, cpr16(CpCmd) & ~RxVlanOn);
-	if (cp->vlgrp)
-		cp->vlgrp->vlan_devices[vid] = NULL;
-	spin_unlock_irq(&cp->lock);
-}
-#endif
-
 /* Serial EEPROM section. */
 
 /*  EEPROM_Ctrl bits. */
@@ -1626,7 +1563,7 @@
 #define EE_READ_CMD		(6)
 #define EE_ERASE_CMD	(7)
 
-static int __devinit read_eeprom (void *ioaddr, int location, int addr_len)
+static int read_eeprom (void *ioaddr, int location, int addr_len)
 {
 	int i;
 	unsigned retval = 0;
@@ -1672,17 +1609,15 @@
 	pci_set_power_state (cp->pdev, 3);
 }
 
-static int __devinit cp_init_one (struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+static int cp_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *dev;
 	struct cp_private *cp;
 	int rc;
 	void *regs;
 	long pciaddr;
-	unsigned int addr_len, i;
+	unsigned int addr_len, i, pci_using_dac;
 	u8 pci_rev, cache_size;
-	unsigned int board_type = (unsigned int) ent->driver_data;
 
 #ifndef MODULE
 	static int version_printed;
@@ -1706,7 +1641,6 @@
 	SET_MODULE_OWNER(dev);
 	cp = dev->priv;
 	cp->pdev = pdev;
-	cp->board_type = board_type;
 	cp->dev = dev;
 	cp->msg_enable = (debug < 0 ? CP_DEF_MSG_ENABLE : debug);
 	spin_lock_init (&cp->lock);
@@ -1747,18 +1681,22 @@
 	}
 
 	/* Configure DMA attributes. */
-	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL)) {
-		cp->pci_using_dac = 1;
+	if ((sizeof(dma_addr_t) > 32) &&
+	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
+		pci_using_dac = 1;
 	} else {
-		rc = pci_set_dma_mask(pdev, (u64) 0xffffffff);
+		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
 		if (rc) {
 			printk(KERN_ERR PFX "No usable DMA configuration, "
 			       "aborting.\n");
 			goto err_out_res;
 		}
-		cp->pci_using_dac = 0;
+		pci_using_dac = 0;
 	}
 
+	cp->cpcmd = (pci_using_dac ? PCIDAC : 0) |
+		    PCIMulRW | RxChkSum | CpRxOn | CpTxOn;
+
 	regs = ioremap_nocache(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
@@ -1783,6 +1721,8 @@
 	dev->hard_start_xmit = cp_start_xmit;
 	dev->get_stats = cp_get_stats;
 	dev->do_ioctl = cp_ioctl;
+	dev->poll = cp_rx_poll;
+	dev->weight = 16;	/* arbitrary? from NAPI_HOWTO.txt. */
 #ifdef BROKEN
 	dev->change_mtu = cp_change_mtu;
 #endif
@@ -1791,9 +1731,7 @@
 	dev->tx_timeout = cp_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 #endif
-#ifdef CP_TX_CHECKSUM
-	dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
-#endif
+
 #if CP_VLAN_TAG_USED
 	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
 	dev->vlan_rx_register = cp_vlan_rx_register;
@@ -1806,11 +1744,10 @@
 	if (rc)
 		goto err_out_iomap;
 
-	printk (KERN_INFO "%s: %s at 0x%lx, "
+	printk (KERN_INFO "%s: RTL-8139C+ at 0x%lx, "
 		"%02x:%02x:%02x:%02x:%02x:%02x, "
 		"IRQ %d\n",
 		dev->name,
-		cp_board_tbl[board_type].name,
 		dev->base_addr,
 		dev->dev_addr[0], dev->dev_addr[1],
 		dev->dev_addr[2], dev->dev_addr[3],
@@ -1858,7 +1795,7 @@
 	return rc;
 }
 
-static void __devexit cp_remove_one (struct pci_dev *pdev)
+static void cp_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct cp_private *cp = dev->priv;
@@ -1931,7 +1868,7 @@
 	.name         = DRV_NAME,
 	.id_table     = cp_pci_tbl,
 	.probe        =	cp_init_one,
-	.remove       = __devexit_p(cp_remove_one),
+	.remove       = cp_remove_one,
 #ifdef CONFIG_PM
 	.resume       = cp_resume,
 	.suspend      = cp_suspend,
diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/8139too.c	Sun Aug 31 10:06:32 2003
@@ -122,6 +122,11 @@
 #define USE_IO_OPS 1
 #endif
 
+/* use a 16K rx ring buffer instead of the default 32K */
+#ifdef CONFIG_SH_DREAMCAST
+#define USE_BUF16K 1
+#endif
+
 /* define to 1 to enable copious debugging info */
 #undef RTL8139_DEBUG
 
@@ -164,7 +169,11 @@
 static int debug = -1;
 
 /* Size of the in-memory receive ring. */
+#ifdef USE_BUF16K
+#define RX_BUF_LEN_IDX	1	/* 0==8K, 1==16K, 2==32K, 3==64K */
+#else
 #define RX_BUF_LEN_IDX	2	/* 0==8K, 1==16K, 2==32K, 3==64K */
+#endif
 #define RX_BUF_LEN	(8192 << RX_BUF_LEN_IDX)
 #define RX_BUF_PAD	16
 #define RX_BUF_WRAP_PAD 2048 /* spare padding to handle lack of packet wrap */
@@ -211,18 +220,7 @@
 
 typedef enum {
 	RTL8139 = 0,
-	RTL8139_CB,
-	SMC1211TX,
-	/*MPX5030,*/
-	DELTA8139,
-	ADDTRON8139,
-	DFE538TX,
-	DFE690TXD,
-	FE2000VX,
-	ALLIED8139,
 	RTL8129,
-	FNW3603TX,
-	FNW3800TX,
 } board_t;
 
 
@@ -231,36 +229,29 @@
 	const char *name;
 	u32 hw_flags;
 } board_info[] __devinitdata = {
-	{ "RealTek RTL8139 Fast Ethernet", RTL8139_CAPS },
-	{ "RealTek RTL8139B PCI/CardBus", RTL8139_CAPS },
-	{ "SMC1211TX EZCard 10/100 (RealTek RTL8139)", RTL8139_CAPS },
-/*	{ MPX5030, "Accton MPX5030 (RealTek RTL8139)", RTL8139_CAPS },*/
-	{ "Delta Electronics 8139 10/100BaseTX", RTL8139_CAPS },
-	{ "Addtron Technolgy 8139 10/100BaseTX", RTL8139_CAPS },
-	{ "D-Link DFE-538TX (RealTek RTL8139)", RTL8139_CAPS },
-	{ "D-Link DFE-690TXD (RealTek RTL8139)", RTL8139_CAPS },
-	{ "AboCom FE2000VX (RealTek RTL8139)", RTL8139_CAPS },
-	{ "Allied Telesyn 8139 CardBus", RTL8139_CAPS },
+	{ "RealTek RTL8139", RTL8139_CAPS },
 	{ "RealTek RTL8129", RTL8129_CAPS },
-	{ "Planex FNW-3603-TX 10/100 CardBus", RTL8139_CAPS },
-	{ "Planex FNW-3800-TX 10/100 CardBus", RTL8139_CAPS },
 };
 
 
 static struct pci_device_id rtl8139_pci_tbl[] = {
 	{0x10ec, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
-	{0x10ec, 0x8138, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139_CB },
-	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SMC1211TX },
-/*	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MPX5030 },*/
-	{0x1500, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DELTA8139 },
-	{0x4033, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADDTRON8139 },
-	{0x1186, 0x1300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DFE538TX },
-	{0x1186, 0x1340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DFE690TXD },
-	{0x13d1, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, FE2000VX },
-	{0x1259, 0xa117, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ALLIED8139 },
-	{0x14ea, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, FNW3603TX },
-	{0x14ea, 0xab07, PCI_ANY_ID, PCI_ANY_ID, 0, 0, FNW3800TX },
-
+	{0x10ec, 0x8138, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1500, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x4033, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1186, 0x1300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1186, 0x1340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x13d1, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x1259, 0xa117, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x14ea, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x14ea, 0xab07, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+	{0x11db, 0x1234, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+
+#ifdef CONFIG_SH_SECUREEDGE5410
+	/* Bogus 8139 silicon reports 8129 without external PROM :-( */
+	{0x10ec, 0x8129, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
+#endif
 #ifdef CONFIG_8139TOO_8129
 	{0x10ec, 0x8129, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8129 },
 #endif
@@ -270,8 +261,8 @@
 	 * so we simply don't match on the main vendor id.
 	 */
 	{PCI_ANY_ID, 0x8139, 0x10ec, 0x8139, 0, 0, RTL8139 },
-	{PCI_ANY_ID, 0x8139, 0x1186, 0x1300, 0, 0, DFE538TX },
-	{PCI_ANY_ID, 0x8139, 0x13d1, 0xab06, 0, 0, FE2000VX },
+	{PCI_ANY_ID, 0x8139, 0x1186, 0x1300, 0, 0, RTL8139 },
+	{PCI_ANY_ID, 0x8139, 0x13d1, 0xab06, 0, 0, RTL8139 },
 
 	{0,}
 };
@@ -706,10 +697,17 @@
 	PCIErr | PCSTimeout | RxUnderrun | RxOverflow | RxFIFOOver |
 	TxErr | TxOK | RxErr | RxOK;
 
+#ifdef USE_BUF16K 
+static const unsigned int rtl8139_rx_config =
+	RxCfgRcv16K | RxNoWrap |
+	(RX_FIFO_THRESH << RxCfgFIFOShift) |
+	(RX_DMA_BURST << RxCfgDMAShift);
+#else
 static const unsigned int rtl8139_rx_config =
 	RxCfgRcv32K | RxNoWrap |
 	(RX_FIFO_THRESH << RxCfgFIFOShift) |
 	(RX_DMA_BURST << RxCfgDMAShift);
+#endif
 
 static const unsigned int rtl8139_tx_config =
 	(TX_DMA_BURST << TxDMAShift) | (TX_RETRY << TxRetryShift);
diff -Nru a/drivers/net/eth16i.c b/drivers/net/eth16i.c
--- a/drivers/net/eth16i.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/eth16i.c	Sun Aug 31 10:06:32 2003
@@ -1057,7 +1057,7 @@
 	int ioaddr = dev->base_addr;
 	int status = 0;
 	ushort length = skb->len;
-	unsigned char *buf = skb->data;
+	unsigned char *buf;
 	unsigned long flags;
 
 	if(length < ETH_ZLEN)
@@ -1067,6 +1067,7 @@
 			return 0;
 		length = ETH_ZLEN;
 	}
+	buf = skb->data;
 
 	netif_stop_queue(dev);
 		
diff -Nru a/drivers/net/fmv18x.c b/drivers/net/fmv18x.c
--- a/drivers/net/fmv18x.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/fmv18x.c	Sun Aug 31 10:06:32 2003
@@ -370,7 +370,7 @@
 	struct net_local *lp = dev->priv;
 	int ioaddr = dev->base_addr;
 	short length = skb->len;
-	unsigned char *buf = skb->data;
+	unsigned char *buf;
 	unsigned long flags;
 
 	/* Block a transmit from overlapping.  */
@@ -389,6 +389,7 @@
 			return 0;
 		length = ETH_ZLEN;
 	}
+	buf = skb->data;
 	
 	if (net_debug > 4)
 		printk("%s: Transmitting a packet of length %lu.\n", dev->name,
diff -Nru a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
--- a/drivers/net/pcmcia/3c574_cs.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/pcmcia/3c574_cs.c	Sun Aug 31 10:06:32 2003
@@ -1216,9 +1216,11 @@
 		  data[0], data[1], data[2], data[3]);
 
     switch(cmd) {
-	case SIOCDEVPRIVATE:		/* Get the address of the PHY in use. */
+	case SIOCGMIIPHY:		/* Get the address of the PHY in use. */
+	case SIOCDEVPRIVATE:
 		data[0] = phy;
-	case SIOCDEVPRIVATE+1:		/* Read the specified MII register. */
+	case SIOCGMIIREG:		/* Read the specified MII register. */
+	case SIOCDEVPRIVATE+1:
 		{
 			int saved_window;
 			unsigned long flags;
@@ -1232,7 +1234,8 @@
 			restore_flags(flags);
 			return 0;
 		}
-	case SIOCDEVPRIVATE+2:		/* Write the specified MII register */
+	case SIOCSMIIREG:		/* Write the specified MII register */
+	case SIOCDEVPRIVATE+2:
 		{
 			int saved_window;
 			unsigned long flags;
diff -Nru a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
--- a/drivers/net/pcmcia/axnet_cs.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/pcmcia/axnet_cs.c	Sun Aug 31 10:06:32 2003
@@ -843,11 +843,14 @@
     u16 *data = (u16 *)&rq->ifr_data;
     ioaddr_t mii_addr = dev->base_addr + AXNET_MII_EEP;
     switch (cmd) {
+    case SIOCGMIIPHY:
     case SIOCDEVPRIVATE:
 	data[0] = info->phy_id;
+    case SIOCGMIIREG:		/* Read MII PHY register. */
     case SIOCDEVPRIVATE+1:
 	data[3] = mdio_read(mii_addr, data[0], data[1] & 0x1f);
 	return 0;
+    case SIOCSMIIREG:		/* Write MII PHY register. */
     case SIOCDEVPRIVATE+2:
 	if (!capable(CAP_NET_ADMIN))
 	    return -EPERM;
diff -Nru a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/pcmcia/pcnet_cs.c	Sun Aug 31 10:06:32 2003
@@ -1236,11 +1236,14 @@
     u16 *data = (u16 *)&rq->ifr_data;
     ioaddr_t mii_addr = dev->base_addr + DLINK_GPIO;
     switch (cmd) {
+    case SIOCGMIIPHY:
     case SIOCDEVPRIVATE:
 	data[0] = info->phy_id;
+    case SIOCGMIIREG:		/* Read MII PHY register. */
     case SIOCDEVPRIVATE+1:
 	data[3] = mdio_read(mii_addr, data[0], data[1] & 0x1f);
 	return 0;
+    case SIOCSMIIREG:		/* Write MII PHY register. */
     case SIOCDEVPRIVATE+2:
 	if (!capable(CAP_NET_ADMIN))
 	    return -EPERM;
diff -Nru a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
--- a/drivers/net/pcmcia/xirc2ps_cs.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/pcmcia/xirc2ps_cs.c	Sun Aug 31 10:06:32 2003
@@ -1749,13 +1749,16 @@
 	return -EOPNOTSUPP;
 
     switch(cmd) {
-      case SIOCDEVPRIVATE:	/* Get the address of the PHY in use. */
+      case SIOCGMIIPHY:		/* Get the address of the PHY in use. */
+      case SIOCDEVPRIVATE:
 	data[0] = 0;		/* we have only this address */
 	/* fall trough */
-      case SIOCDEVPRIVATE+1:	/* Read the specified MII register. */
+      case SIOCGMIIREG:		/* Read the specified MII register. */
+      case SIOCDEVPRIVATE+1:
 	data[3] = mii_rd(ioaddr, data[0] & 0x1f, data[1] & 0x1f);
 	break;
-      case SIOCDEVPRIVATE+2:	/* Write the specified MII register */
+      case SIOCSMIIREG:		/* Write the specified MII register */
+      case SIOCDEVPRIVATE+2:
 	if (!capable(CAP_NET_ADMIN))
 	    return -EPERM;
 	mii_wr(ioaddr, data[0] & 0x1f, data[1] & 0x1f, data[2], 16);
diff -Nru a/drivers/net/seeq8005.c b/drivers/net/seeq8005.c
--- a/drivers/net/seeq8005.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/seeq8005.c	Sun Aug 31 10:06:32 2003
@@ -379,7 +379,7 @@
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
 	short length = skb->len;
-	unsigned char *buf = skb->data;
+	unsigned char *buf;
 
 	if(length < ETH_ZLEN)
 	{
@@ -388,6 +388,8 @@
 			return 0;
 		length = ETH_ZLEN;
 	}
+	buf = skb->data;
+
 	/* Block a timer-based transmit from overlapping */
 	netif_stop_queue(dev);
 	
diff -Nru a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
--- a/drivers/net/yellowfin.c	Sun Aug 31 10:06:32 2003
+++ b/drivers/net/yellowfin.c	Sun Aug 31 10:06:32 2003
@@ -867,8 +867,6 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = yp->cur_tx % TX_RING_SIZE;
 
-	yp->tx_skbuff[entry] = skb;
-
 	if (gx_fix) {	/* Note: only works for paddable protocols e.g.  IP. */
 		int cacheline_end = ((unsigned long)skb->data + skb->len) % 32;
 		/* Fix GX chipset errata. */
@@ -885,6 +883,8 @@
 			return 0;
 		}
 	}
+	yp->tx_skbuff[entry] = skb;
+
 #ifdef NO_TXSTATS
 	yp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(yp->pci_dev, 
 		skb->data, len, PCI_DMA_TODEVICE));
