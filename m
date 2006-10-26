Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423393AbWJZESE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423393AbWJZESE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 00:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423395AbWJZESE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 00:18:04 -0400
Received: from havoc.gtf.org ([69.61.125.42]:53147 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1423393AbWJZESB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 00:18:01 -0400
Date: Thu, 26 Oct 2006 00:17:54 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] e100, e1000 fixes
Message-ID: <20061026041754.GA12545@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The e100 fix finally fixes the netconsole problems.

The e1000 fixes look pretty safe, but don't have hardware at the
moment to test.  A non-Intel list member verified the e1000 stuff at
least works for him.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/e100.c                |   10 +++++++--
 drivers/net/e1000/e1000_ethtool.c |    4 +++-
 drivers/net/e1000/e1000_hw.h      |    6 +++--
 drivers/net/e1000/e1000_main.c    |   41 +++++++++++++++++++++++++------------
 4 files changed, 42 insertions(+), 19 deletions(-)

Auke Kok:
      e1000: FIX: 82542 doesn't support WoL
      e1000: Increment version to 7.2.9-k4
      e100: account for closed interface when shutting down

Bruce Allan:
      e1000: FIX: fix wrong txdctl threshold bitmasks

Jesse Brandeburg:
      e1000: FIX: don't poke at manageability registers for incompatible adapters
      e1000: FIX: Disable Packet Split for non jumbo frames
      e1000: FIX: Don't limit descriptor size to 4kb for PCI-E adapters
      e1000: FIX: move length adjustment due to crc stripping disabled.

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index a3a08a5..19ab344 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2719,7 +2719,10 @@ static int e100_suspend(struct pci_dev *
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	netif_poll_disable(nic->netdev);
+#ifdef CONFIG_E100_NAPI
+	if (netif_running(netdev))
+		netif_poll_disable(nic->netdev);
+#endif
 	del_timer_sync(&nic->watchdog);
 	netif_carrier_off(nic->netdev);
 
@@ -2763,7 +2766,10 @@ static void e100_shutdown(struct pci_dev
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
 
-	netif_poll_disable(nic->netdev);
+#ifdef CONFIG_E100_NAPI
+	if (netif_running(netdev))
+		netif_poll_disable(nic->netdev);
+#endif
 	del_timer_sync(&nic->watchdog);
 	netif_carrier_off(nic->netdev);
 
diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
index 773821e..c564adb 100644
--- a/drivers/net/e1000/e1000_ethtool.c
+++ b/drivers/net/e1000/e1000_ethtool.c
@@ -461,7 +461,8 @@ e1000_get_regs(struct net_device *netdev
 	regs_buff[24] = (uint32_t)phy_data;  /* phy local receiver status */
 	regs_buff[25] = regs_buff[24];  /* phy remote receiver status */
 	if (hw->mac_type >= e1000_82540 &&
-	   hw->media_type == e1000_media_type_copper) {
+	    hw->mac_type < e1000_82571 &&
+	    hw->media_type == e1000_media_type_copper) {
 		regs_buff[26] = E1000_READ_REG(hw, MANC);
 	}
 }
@@ -1690,6 +1691,7 @@ static int e1000_wol_exclusion(struct e1
 	int retval = 1; /* fail by default */
 
 	switch (hw->device_id) {
+	case E1000_DEV_ID_82542:
 	case E1000_DEV_ID_82543GC_FIBER:
 	case E1000_DEV_ID_82543GC_COPPER:
 	case E1000_DEV_ID_82544EI_FIBER:
diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
index 112447f..449a603 100644
--- a/drivers/net/e1000/e1000_hw.h
+++ b/drivers/net/e1000/e1000_hw.h
@@ -1961,9 +1961,9 @@ #define E1000_RXDCTL_WTHRESH 0x003F0000 
 #define E1000_RXDCTL_GRAN    0x01000000 /* RXDCTL Granularity */
 
 /* Transmit Descriptor Control */
-#define E1000_TXDCTL_PTHRESH 0x000000FF /* TXDCTL Prefetch Threshold */
-#define E1000_TXDCTL_HTHRESH 0x0000FF00 /* TXDCTL Host Threshold */
-#define E1000_TXDCTL_WTHRESH 0x00FF0000 /* TXDCTL Writeback Threshold */
+#define E1000_TXDCTL_PTHRESH 0x0000003F /* TXDCTL Prefetch Threshold */
+#define E1000_TXDCTL_HTHRESH 0x00003F00 /* TXDCTL Host Threshold */
+#define E1000_TXDCTL_WTHRESH 0x003F0000 /* TXDCTL Writeback Threshold */
 #define E1000_TXDCTL_GRAN    0x01000000 /* TXDCTL Granularity */
 #define E1000_TXDCTL_LWTHRESH 0xFE000000 /* TXDCTL Low Threshold */
 #define E1000_TXDCTL_FULL_TX_DESC_WB 0x01010000 /* GRAN=1, WTHRESH=1 */
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index fa84983..8d04752 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -35,7 +35,7 @@ #define DRIVERNAPI
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-#define DRV_VERSION "7.2.9-k2"DRIVERNAPI
+#define DRV_VERSION "7.2.9-k4"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
 static char e1000_copyright[] = "Copyright (c) 1999-2006 Intel Corporation.";
 
@@ -699,7 +699,10 @@ #endif
 		                    phy_data);
 	}
 
-	if ((adapter->en_mng_pt) && (adapter->hw.mac_type < e1000_82571)) {
+	if ((adapter->en_mng_pt) &&
+	    (adapter->hw.mac_type >= e1000_82540) &&
+	    (adapter->hw.mac_type < e1000_82571) &&
+	    (adapter->hw.media_type == e1000_media_type_copper)) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
 		manc |= (E1000_MANC_ARP_EN | E1000_MANC_EN_MNG2HOST);
 		E1000_WRITE_REG(&adapter->hw, MANC, manc);
@@ -1076,8 +1079,9 @@ #endif
 
 	flush_scheduled_work();
 
-	if (adapter->hw.mac_type < e1000_82571 &&
-	   adapter->hw.media_type == e1000_media_type_copper) {
+	if (adapter->hw.mac_type >= e1000_82540 &&
+	    adapter->hw.mac_type < e1000_82571 &&
+	    adapter->hw.media_type == e1000_media_type_copper) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
 		if (manc & E1000_MANC_SMBUS_EN) {
 			manc |= E1000_MANC_ARP_EN;
@@ -1804,9 +1808,11 @@ #ifndef CONFIG_E1000_DISABLE_PACKET_SPLI
 	 * followed by the page buffers.  Therefore, skb->data is
 	 * sized to hold the largest protocol header.
 	 */
+	/* allocations using alloc_page take too long for regular MTU
+	 * so only enable packet split for jumbo frames */
 	pages = PAGE_USE_COUNT(adapter->netdev->mtu);
-	if ((adapter->hw.mac_type > e1000_82547_rev_2) && (pages <= 3) &&
-	    PAGE_SIZE <= 16384)
+	if ((adapter->hw.mac_type >= e1000_82571) && (pages <= 3) &&
+	    PAGE_SIZE <= 16384 && (rctl & E1000_RCTL_LPE))
 		adapter->rx_ps_pages = pages;
 	else
 		adapter->rx_ps_pages = 0;
@@ -2986,6 +2992,11 @@ e1000_xmit_frame(struct sk_buff *skb, st
 		return NETDEV_TX_OK;
 	}
 
+	/* 82571 and newer doesn't need the workaround that limited descriptor
+	 * length to 4kB */
+	if (adapter->hw.mac_type >= e1000_82571)
+		max_per_txd = 8192;
+
 #ifdef NETIF_F_TSO
 	mss = skb_shinfo(skb)->gso_size;
 	/* The controller does a simple calculation to
@@ -3775,9 +3786,6 @@ #endif
 
 		length = le16_to_cpu(rx_desc->length);
 
-		/* adjust length to remove Ethernet CRC */
-		length -= 4;
-
 		if (unlikely(!(status & E1000_RXD_STAT_EOP))) {
 			/* All receives must fit into a single buffer */
 			E1000_DBG("%s: Receive packet consumed multiple"
@@ -3805,6 +3813,10 @@ #endif
 			}
 		}
 
+		/* adjust length to remove Ethernet CRC, this must be
+		 * done after the TBI_ACCEPT workaround above */
+		length -= 4;
+
 		/* code added for copybreak, this should improve
 		 * performance for small packets with large amounts
 		 * of reassembly being done in the stack */
@@ -4773,8 +4785,9 @@ #endif
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 	}
 
-	if (adapter->hw.mac_type < e1000_82571 &&
-	   adapter->hw.media_type == e1000_media_type_copper) {
+	if (adapter->hw.mac_type >= e1000_82540 &&
+	    adapter->hw.mac_type < e1000_82571 &&
+	    adapter->hw.media_type == e1000_media_type_copper) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
 		if (manc & E1000_MANC_SMBUS_EN) {
 			manc |= E1000_MANC_ARP_EN;
@@ -4825,8 +4838,9 @@ e1000_resume(struct pci_dev *pdev)
 
 	netif_device_attach(netdev);
 
-	if (adapter->hw.mac_type < e1000_82571 &&
-	   adapter->hw.media_type == e1000_media_type_copper) {
+	if (adapter->hw.mac_type >= e1000_82540 &&
+	    adapter->hw.mac_type < e1000_82571 &&
+	    adapter->hw.media_type == e1000_media_type_copper) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
 		manc &= ~(E1000_MANC_ARP_EN);
 		E1000_WRITE_REG(&adapter->hw, MANC, manc);
@@ -4944,6 +4958,7 @@ static void e1000_io_resume(struct pci_d
 	netif_device_attach(netdev);
 
 	if (adapter->hw.mac_type >= e1000_82540 &&
+	    adapter->hw.mac_type < e1000_82571 &&
 	    adapter->hw.media_type == e1000_media_type_copper) {
 		manc = E1000_READ_REG(&adapter->hw, MANC);
 		manc &= ~(E1000_MANC_ARP_EN);
