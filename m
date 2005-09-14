Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVINPia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVINPia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVINPia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:38:30 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:17624 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030189AbVINPi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:38:29 -0400
In-Reply-To: <20050914131414.GA1095@havoc.gtf.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [git patches] net driver fixes
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
From: Frank Pavlic <pavlic@de.ibm.com>
Message-ID: <OFA34209F3.7B24497C-ONC125707C.0056132C-C125707C.0056326B@de.ibm.com>
Date: Wed, 14 Sep 2005 17:38:26 +0200
X-MIMETrack: Serialize by Router on D12ML068/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/09/2005 17:38:27,
	Serialize complete at 14/09/2005 17:38:27
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff ,
didn't you get the qeth patches ? let me know if not I will resend them 
once again ....
Thanks



linux-kernel-owner@vger.kernel.org wrote on 14.09.2005 15:14:14:

> 
> Please pull from 'upstream-fixes' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 
> to obtain the following fixes:
> 
> 
>  drivers/net/Kconfig            |    2 
>  drivers/net/e100.c             |    4 -
>  drivers/net/e1000/e1000_main.c |    1 
>  drivers/net/ixgb/ixgb_main.c   |    2 
>  drivers/net/s2io.c             |    9 ++-
>  drivers/net/sk98lin/skge.c     |   12 ++---
>  drivers/net/skge.c             |   98 
> ++++++++++++++++++++++-------------------
>  drivers/net/skge.h             |    2 
>  drivers/net/tulip/xircom_cb.c  |    2 
>  drivers/net/wireless/airo.c    |    5 +-
>  drivers/s390/net/ctcmain.c     |   41 +++++++++--------
>  11 files changed, 94 insertions(+), 84 deletions(-)
> 
> 
> 
> Andrew Morton:
>   s2io warning fixes
> 
> Frank Pavlic:
>   s390: ctc driver fixes
> 
> John W. Linville:
>   e1000: correct rx_dropped counting
>   e100: correct rx_dropped and add rx_missed_errors
>   ixgb: correct rx_dropped counting
> 
> Keith Owens:
>   Correct xircom_cb use of CONFIG_NET_POLL_CONTROLLER
> 
> matthieu castet:
>   airo : fix channel number in scan
> 
> Stephen Hemminger:
>   sk98lin: remove PCI id info for cards for conflicting devices
>   skge: gmac register access errors in dual port
> 
> 
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1951,7 +1951,7 @@ config SKGE
>     ---help---
>       This driver support the Marvell Yukon or SysKonnect 
SK-98xx/SK-95xx
>       and related Gigabit Ethernet adapters. It is a new smaller driver
> -     driver with better performance and more complete ethtool support.
> +     with better performance and more complete ethtool support.
> 
>       It does not support the link failover and network management 
>       features that "portable" vendor supplied sk98lin driver does.
> diff --git a/drivers/net/e100.c b/drivers/net/e100.c
> --- a/drivers/net/e100.c
> +++ b/drivers/net/e100.c
> @@ -1387,13 +1387,13 @@ static void e100_update_stats(struct nic
>        ns->collisions += nic->tx_collisions;
>        ns->tx_errors += le32_to_cpu(s->tx_max_collisions) +
>           le32_to_cpu(s->tx_lost_crs);
> -      ns->rx_dropped += le32_to_cpu(s->rx_resource_errors);
>        ns->rx_length_errors += le32_to_cpu(s->rx_short_frame_errors) +
>           nic->rx_over_length_errors;
>        ns->rx_crc_errors += le32_to_cpu(s->rx_crc_errors);
>        ns->rx_frame_errors += le32_to_cpu(s->rx_alignment_errors);
>        ns->rx_over_errors += le32_to_cpu(s->rx_overrun_errors);
>        ns->rx_fifo_errors += le32_to_cpu(s->rx_overrun_errors);
> +      ns->rx_missed_errors += le32_to_cpu(s->rx_resource_errors);
>        ns->rx_errors += le32_to_cpu(s->rx_crc_errors) +
>           le32_to_cpu(s->rx_alignment_errors) +
>           le32_to_cpu(s->rx_short_frame_errors) +
> @@ -1727,12 +1727,10 @@ static inline int e100_rx_indicate(struc
> 
>     if(unlikely(!(rfd_status & cb_ok))) {
>        /* Don't indicate if hardware indicates errors */
> -      nic->net_stats.rx_dropped++;
>        dev_kfree_skb_any(skb);
>     } else if(actual_size > ETH_DATA_LEN + VLAN_ETH_HLEN) {
>        /* Don't indicate oversized frames */
>        nic->rx_over_length_errors++;
> -      nic->net_stats.rx_dropped++;
>        dev_kfree_skb_any(skb);
>     } else {
>        nic->net_stats.rx_packets++;
> diff --git a/drivers/net/e1000/e1000_main.c 
b/drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c
> +++ b/drivers/net/e1000/e1000_main.c
> @@ -2544,7 +2544,6 @@ e1000_update_stats(struct e1000_adapter 
>        adapter->stats.crcerrs + adapter->stats.algnerrc +
>        adapter->stats.rlec + adapter->stats.mpc + 
>        adapter->stats.cexterr;
> -   adapter->net_stats.rx_dropped = adapter->stats.mpc;
>     adapter->net_stats.rx_length_errors = adapter->stats.rlec;
>     adapter->net_stats.rx_crc_errors = adapter->stats.crcerrs;
>     adapter->net_stats.rx_frame_errors = adapter->stats.algnerrc;
> diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
> --- a/drivers/net/ixgb/ixgb_main.c
> +++ b/drivers/net/ixgb/ixgb_main.c
> @@ -1616,8 +1616,6 @@ ixgb_update_stats(struct ixgb_adapter *a
>         adapter->stats.icbc +
>         adapter->stats.ecbc + adapter->stats.mpc;
> 
> -   adapter->net_stats.rx_dropped = adapter->stats.mpc;
> -
>     /* see above
>      * adapter->net_stats.rx_length_errors = adapter->stats.rlec;
>      */
> diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
> --- a/drivers/net/s2io.c
> +++ b/drivers/net/s2io.c
> @@ -428,7 +428,7 @@ static int init_shared_mem(struct s2io_n
>              DBG_PRINT(INIT_DBG, 
>              "%s: Zero DMA address for TxDL. ", dev->name);
>              DBG_PRINT(INIT_DBG, 
> -            "Virtual address %llx\n", (u64)tmp_v);
> +            "Virtual address %p\n", tmp_v);
>              tmp_v = pci_alloc_consistent(nic->pdev,
>                         PAGE_SIZE, &tmp_p);
>              if (!tmp_v) {
> @@ -657,9 +657,10 @@ static void free_shared_mem(struct s2io_
>                     mac_control->zerodma_virt_addr,
>                     (dma_addr_t)0);
>           DBG_PRINT(INIT_DBG, 
> -         "%s: Freeing TxDL with zero DMA addr. ", dev->name);
> -         DBG_PRINT(INIT_DBG, "Virtual address %llx\n",
> -         (u64)(mac_control->zerodma_virt_addr));
> +              "%s: Freeing TxDL with zero DMA addr. ",
> +            dev->name);
> +         DBG_PRINT(INIT_DBG, "Virtual address %p\n",
> +            mac_control->zerodma_virt_addr);
>        }
>        kfree(mac_control->fifos[i].list_info);
>     }
> diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
> --- a/drivers/net/sk98lin/skge.c
> +++ b/drivers/net/sk98lin/skge.c
> @@ -5216,17 +5216,15 @@ static struct pci_device_id skge_pci_tbl
>     { PCI_VENDOR_ID_3COM, 0x80eb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>     { PCI_VENDOR_ID_SYSKONNECT, 0x4300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 
},
>     { PCI_VENDOR_ID_SYSKONNECT, 0x4320, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 
},
> -   { PCI_VENDOR_ID_DLINK, 0x4c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> +/* DLink card does not have valid VPD so this driver gags
> + *   { PCI_VENDOR_ID_DLINK, 0x4c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> + */
>     { PCI_VENDOR_ID_MARVELL, 0x4320, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -#if 0   /* don't handle Yukon2 cards at the moment -- 
> mlindner@syskonnect.de */
> -   { PCI_VENDOR_ID_MARVELL, 0x4360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -   { PCI_VENDOR_ID_MARVELL, 0x4361, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -#endif
>     { PCI_VENDOR_ID_MARVELL, 0x5005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>     { PCI_VENDOR_ID_CNET, 0x434e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -   { PCI_VENDOR_ID_LINKSYS, 0x1032, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> +   { PCI_VENDOR_ID_LINKSYS, 0x1032, PCI_ANY_ID, 0x0015, },
>     { PCI_VENDOR_ID_LINKSYS, 0x1064, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> -   { 0, }
> +   { 0 }
>  };
> 
>  MODULE_DEVICE_TABLE(pci, skge_pci_tbl);
> diff --git a/drivers/net/skge.c b/drivers/net/skge.c
> --- a/drivers/net/skge.c
> +++ b/drivers/net/skge.c
> @@ -42,7 +42,7 @@
>  #include "skge.h"
> 
>  #define DRV_NAME      "skge"
> -#define DRV_VERSION      "0.9"
> +#define DRV_VERSION      "1.0"
>  #define PFX         DRV_NAME " "
> 
>  #define DEFAULT_TX_RING_SIZE   128
> @@ -669,7 +669,7 @@ static void skge_led(struct skge_port *s
>                   PHY_M_LED_BLINK_RT(BLINK_84MS) |
>                   PHY_M_LEDC_TX_CTRL |
>                   PHY_M_LEDC_DP_CTRL);
> - 
> +
>           gm_phy_write(hw, port, PHY_MARV_LED_OVER,
>                   PHY_M_LED_MO_RX(MO_LED_OFF) |
>                   (skge->speed == SPEED_100 ?
> @@ -876,7 +876,7 @@ static int skge_rx_fill(struct skge_port
> 
>  static void skge_link_up(struct skge_port *skge)
>  {
> -   skge_write8(skge->hw, SK_REG(skge->port, LNK_LED_REG), 
> +   skge_write8(skge->hw, SK_REG(skge->port, LNK_LED_REG),
>            LED_BLK_OFF|LED_SYNC_OFF|LED_ON);
> 
>     netif_carrier_on(skge->netdev);
> @@ -987,6 +987,8 @@ static void genesis_reset(struct skge_hw
>  {
>     const u8 zero[8]  = { 0 };
> 
> +   skge_write8(hw, SK_REG(port, GMAC_IRQ_MSK), 0);
> +
>     /* reset the statistics module */
>     xm_write32(hw, port, XM_GP_PORT, XM_GP_RES_STAT);
>     xm_write16(hw, port, XM_IMSK, 0xffff);   /* disable XMAC IRQs */
> @@ -1021,8 +1023,6 @@ static void bcom_check_link(struct skge_
>     (void) xm_phy_read(hw, port, PHY_BCOM_STAT);
>     status = xm_phy_read(hw, port, PHY_BCOM_STAT);
> 
> -   pr_debug("bcom_check_link status=0x%x\n", status);
> -
>     if ((status & PHY_ST_LSYNC) == 0) {
>        u16 cmd = xm_read16(hw, port, XM_MMU_CMD);
>        cmd &= ~(XM_MMU_ENA_RX | XM_MMU_ENA_TX);
> @@ -1106,8 +1106,6 @@ static void bcom_phy_init(struct skge_po
>        { 0x17, 0x0013 }, { 0x15, 0x0A04 }, { 0x18, 0x0420 },
>     };
> 
> -   pr_debug("bcom_phy_init\n");
> -
>     /* read Id from external PHY (all have the same address) */
>     id1 = xm_phy_read(hw, port, PHY_XMAC_ID1);
> 
> @@ -1340,6 +1338,8 @@ static void genesis_stop(struct skge_por
>     int port = skge->port;
>     u32 reg;
> 
> +   genesis_reset(hw, port);
> +
>     /* Clear Tx packet arbiter timeout IRQ */
>     skge_write16(hw, B3_PA_CTRL,
>             port == 0 ? PA_CLR_TO_TX1 : PA_CLR_TO_TX2);
> @@ -1465,7 +1465,6 @@ static void genesis_link_up(struct skge_
>     u16 cmd;
>     u32 mode, msk;
> 
> -   pr_debug("genesis_link_up\n");
>     cmd = xm_read16(hw, port, XM_MMU_CMD);
> 
>     /*
> @@ -1578,7 +1577,6 @@ static void yukon_init(struct skge_hw *h
>     struct skge_port *skge = netdev_priv(hw->dev[port]);
>     u16 ctrl, ct1000, adv;
> 
> -   pr_debug("yukon_init\n");
>     if (skge->autoneg == AUTONEG_ENABLE) {
>        u16 ectrl = gm_phy_read(hw, port, PHY_MARV_EXT_CTRL);
> 
> @@ -1677,9 +1675,11 @@ static void yukon_mac_init(struct skge_h
> 
>     /* WA code for COMA mode -- set PHY reset */
>     if (hw->chip_id == CHIP_ID_YUKON_LITE &&
> -       hw->chip_rev >= CHIP_REV_YU_LITE_A3)
> -      skge_write32(hw, B2_GP_IO,
> -              (skge_read32(hw, B2_GP_IO) | GP_DIR_9 | GP_IO_9));
> +       hw->chip_rev >= CHIP_REV_YU_LITE_A3) {
> +      reg = skge_read32(hw, B2_GP_IO);
> +      reg |= GP_DIR_9 | GP_IO_9;
> +      skge_write32(hw, B2_GP_IO, reg);
> +   }
> 
>     /* hard reset */
>     skge_write32(hw, SK_REG(port, GPHY_CTRL), GPC_RST_SET);
> @@ -1687,10 +1687,12 @@ static void yukon_mac_init(struct skge_h
> 
>     /* WA code for COMA mode -- clear PHY reset */
>     if (hw->chip_id == CHIP_ID_YUKON_LITE &&
> -       hw->chip_rev >= CHIP_REV_YU_LITE_A3)
> -      skge_write32(hw, B2_GP_IO,
> -              (skge_read32(hw, B2_GP_IO) | GP_DIR_9)
> -              & ~GP_IO_9);
> +       hw->chip_rev >= CHIP_REV_YU_LITE_A3) {
> +      reg = skge_read32(hw, B2_GP_IO);
> +      reg |= GP_DIR_9;
> +      reg &= ~GP_IO_9;
> +      skge_write32(hw, B2_GP_IO, reg);
> +   }
> 
>     /* Set hardware config mode */
>     reg = GPC_INT_POL_HI | GPC_DIS_FC | GPC_DIS_SLEEP |
> @@ -1729,7 +1731,7 @@ static void yukon_mac_init(struct skge_h
>     }
> 
>     gma_write16(hw, port, GM_GP_CTRL, reg);
> -   skge_read16(hw, GMAC_IRQ_SRC);
> +   skge_read16(hw, SK_REG(port, GMAC_IRQ_SRC));
> 
>     yukon_init(hw, port);
> 
> @@ -1801,20 +1803,26 @@ static void yukon_stop(struct skge_port 
>     struct skge_hw *hw = skge->hw;
>     int port = skge->port;
> 
> -   if (hw->chip_id == CHIP_ID_YUKON_LITE &&
> -       hw->chip_rev >= CHIP_REV_YU_LITE_A3) {
> -      skge_write32(hw, B2_GP_IO,
> -              skge_read32(hw, B2_GP_IO) | GP_DIR_9 | GP_IO_9);
> -   }
> +   skge_write8(hw, SK_REG(port, GMAC_IRQ_MSK), 0);
> +   yukon_reset(hw, port);
> 
>     gma_write16(hw, port, GM_GP_CTRL,
>            gma_read16(hw, port, GM_GP_CTRL)
>            & ~(GM_GPCR_TX_ENA|GM_GPCR_RX_ENA));
>     gma_read16(hw, port, GM_GP_CTRL);
> 
> +   if (hw->chip_id == CHIP_ID_YUKON_LITE &&
> +       hw->chip_rev >= CHIP_REV_YU_LITE_A3) {
> +      u32 io = skge_read32(hw, B2_GP_IO);
> +
> +      io |= GP_DIR_9 | GP_IO_9;
> +      skge_write32(hw, B2_GP_IO, io);
> +      skge_read32(hw, B2_GP_IO);
> +   }
> +
>     /* set GPHY Control reset */
> -   skge_write32(hw, SK_REG(port, GPHY_CTRL), GPC_RST_SET);
> -   skge_write32(hw, SK_REG(port, GMAC_CTRL), GMC_RST_SET);
> +   skge_write8(hw, SK_REG(port, GPHY_CTRL), GPC_RST_SET);
> +   skge_write8(hw, SK_REG(port, GMAC_CTRL), GMC_RST_SET);
>  }
> 
>  static void yukon_get_stats(struct skge_port *skge, u64 *data)
> @@ -1873,10 +1881,8 @@ static void yukon_link_up(struct skge_po
>     int port = skge->port;
>     u16 reg;
> 
> -   pr_debug("yukon_link_up\n");
> -
>     /* Enable Transmit FIFO Underrun */
> -   skge_write8(hw, GMAC_IRQ_MSK, GMAC_DEF_MSK);
> +   skge_write8(hw, SK_REG(port, GMAC_IRQ_MSK), GMAC_DEF_MSK);
> 
>     reg = gma_read16(hw, port, GM_GP_CTRL);
>     if (skge->duplex == DUPLEX_FULL || skge->autoneg == AUTONEG_ENABLE)
> @@ -1896,7 +1902,6 @@ static void yukon_link_down(struct skge_
>     int port = skge->port;
>     u16 ctrl;
> 
> -   pr_debug("yukon_link_down\n");
>     gm_phy_write(hw, port, PHY_MARV_INT_MASK, 0);
> 
>     ctrl = gma_read16(hw, port, GM_GP_CTRL);
> @@ -2112,7 +2117,6 @@ static int skge_up(struct net_device *de
>     skge_write8(hw, Q_ADDR(rxqaddr[port], Q_CSR), CSR_START | 
CSR_IRQ_CL_F);
>     skge_led(skge, LED_MODE_ON);
> 
> -   pr_debug("skge_up completed\n");
>     return 0;
> 
>   free_rx_ring:
> @@ -2135,15 +2139,20 @@ static int skge_down(struct net_device *
> 
>     netif_stop_queue(dev);
> 
> +   skge_write8(skge->hw, SK_REG(skge->port, LNK_LED_REG), LED_OFF);
> +   if (hw->chip_id == CHIP_ID_GENESIS)
> +      genesis_stop(skge);
> +   else
> +      yukon_stop(skge);
> +
> +   hw->intr_mask &= ~portirqmask[skge->port];
> +   skge_write32(hw, B0_IMSK, hw->intr_mask);
> +
>     /* Stop transmitter */
>     skge_write8(hw, Q_ADDR(txqaddr[port], Q_CSR), CSR_STOP);
>     skge_write32(hw, RB_ADDR(txqaddr[port], RB_CTRL),
>             RB_RST_SET|RB_DIS_OP_MD);
> 
> -   if (hw->chip_id == CHIP_ID_GENESIS)
> -      genesis_stop(skge);
> -   else
> -      yukon_stop(skge);
> 
>     /* Disable Force Sync bit and Enable Alloc bit */
>     skge_write8(hw, SK_REG(port, TXA_CTRL),
> @@ -2367,8 +2376,6 @@ static void genesis_set_multicast(struct
>     u32 mode;
>     u8 filter[8];
> 
> -   pr_debug("genesis_set_multicast flags=%x count=%d\n", 
> dev->flags, dev->mc_count);
> -
>     mode = xm_read32(hw, port, XM_MODE);
>     mode |= XM_MD_ENA_HASH;
>     if (dev->flags & IFF_PROMISC)
> @@ -2530,8 +2537,6 @@ static int skge_poll(struct net_device *
>     unsigned int to_do = min(dev->quota, *budget);
>     unsigned int work_done = 0;
> 
> -   pr_debug("skge_poll\n");
> -
>     for (e = ring->to_clean; work_done < to_do; e = e->next) {
>        struct skge_rx_desc *rd = e->desc;
>        struct sk_buff *skb;
> @@ -2672,9 +2677,9 @@ static void skge_error_irq(struct skge_h
>     if (hw->chip_id == CHIP_ID_GENESIS) {
>        /* clear xmac errors */
>        if (hwstatus & (IS_NO_STAT_M1|IS_NO_TIST_M1))
> -         skge_write16(hw, SK_REG(0, RX_MFF_CTRL1), MFF_CLR_INSTAT);
> +         skge_write16(hw, RX_MFF_CTRL1, MFF_CLR_INSTAT);
>        if (hwstatus & (IS_NO_STAT_M2|IS_NO_TIST_M2))
> -         skge_write16(hw, SK_REG(0, RX_MFF_CTRL2), MFF_CLR_INSTAT);
> +         skge_write16(hw, RX_MFF_CTRL2, MFF_CLR_INSTAT);
>     } else {
>        /* Timestamp (unused) overflow */
>        if (hwstatus & IS_IRQ_TIST_OV)
> @@ -3000,9 +3005,6 @@ static int skge_reset(struct skge_hw *hw
> 
>     skge_write32(hw, B0_IMSK, hw->intr_mask);
> 
> -   if (hw->chip_id != CHIP_ID_GENESIS)
> -      skge_write8(hw, GMAC_IRQ_MSK, 0);
> -
>     spin_lock_bh(&hw->phy_lock);
>     for (i = 0; i < hw->ports; i++) {
>        if (hw->chip_id == CHIP_ID_GENESIS)
> @@ -3230,6 +3232,11 @@ static void __devexit skge_remove(struct
>     dev0 = hw->dev[0];
>     unregister_netdev(dev0);
> 
> +   skge_write32(hw, B0_IMSK, 0);
> +   skge_write16(hw, B0_LED, LED_STAT_OFF);
> +   skge_pci_clear(hw);
> +   skge_write8(hw, B0_CTST, CS_RST_SET);
> +
>     tasklet_kill(&hw->ext_tasklet);
> 
>     free_irq(pdev->irq, hw);
> @@ -3238,7 +3245,7 @@ static void __devexit skge_remove(struct
>     if (dev1)
>        free_netdev(dev1);
>     free_netdev(dev0);
> -   skge_write16(hw, B0_LED, LED_STAT_OFF);
> +
>     iounmap(hw->regs);
>     kfree(hw);
>     pci_set_drvdata(pdev, NULL);
> @@ -3257,7 +3264,10 @@ static int skge_suspend(struct pci_dev *
>           struct skge_port *skge = netdev_priv(dev);
>           if (netif_running(dev)) {
>              netif_carrier_off(dev);
> -            skge_down(dev);
> +            if (skge->wol)
> +               netif_stop_queue(dev);
> +            else
> +               skge_down(dev);
>           }
>           netif_device_detach(dev);
>           wol |= skge->wol;
> diff --git a/drivers/net/skge.h b/drivers/net/skge.h
> --- a/drivers/net/skge.h
> +++ b/drivers/net/skge.h
> @@ -2008,7 +2008,7 @@ enum {
>     GM_IS_RX_FF_OR   = 1<<1,   /* Receive FIFO Overrun */
>     GM_IS_RX_COMPL   = 1<<0,   /* Frame Reception Complete */
> 
> -#define GMAC_DEF_MSK   (GM_IS_TX_CO_OV | GM_IS_RX_CO_OV | 
GM_IS_TX_FF_UR)
> +#define GMAC_DEF_MSK   (GM_IS_RX_FF_OR | GM_IS_TX_FF_UR)
> 
>  /*   GMAC_LINK_CTRL   16 bit   GMAC Link Control Reg (YUKON only) */
>                    /* Bits 15.. 2:   reserved */
> diff --git a/drivers/net/tulip/xircom_cb.c 
b/drivers/net/tulip/xircom_cb.c
> --- a/drivers/net/tulip/xircom_cb.c
> +++ b/drivers/net/tulip/xircom_cb.c
> @@ -117,7 +117,7 @@ static int xircom_open(struct net_device
>  static int xircom_close(struct net_device *dev);
>  static void xircom_up(struct xircom_private *card);
>  static struct net_device_stats *xircom_get_stats(struct net_device 
*dev);
> -#if CONFIG_NET_POLL_CONTROLLER
> +#ifdef CONFIG_NET_POLL_CONTROLLER
>  static void xircom_poll_controller(struct net_device *dev);
>  #endif
> 
> diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
> --- a/drivers/net/wireless/airo.c
> +++ b/drivers/net/wireless/airo.c
> @@ -6852,7 +6852,10 @@ static inline char *airo_translate_scan(
>     /* Add frequency */
>     iwe.cmd = SIOCGIWFREQ;
>     iwe.u.freq.m = le16_to_cpu(bss->dsChannel);
> -   iwe.u.freq.m = frequency_list[iwe.u.freq.m] * 100000;
> +   /* iwe.u.freq.m containt the channel (starting 1), our 
> +    * frequency_list array start at index 0...
> +    */
> +   iwe.u.freq.m = frequency_list[iwe.u.freq.m - 1] * 100000;
>     iwe.u.freq.e = 1;
>     current_ev = iwe_stream_add_event(current_ev, end_buf, &iwe, 
> IW_EV_FREQ_LEN);
> 
> diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
> --- a/drivers/s390/net/ctcmain.c
> +++ b/drivers/s390/net/ctcmain.c
> @@ -1,5 +1,5 @@
>  /*
> - * $Id: ctcmain.c,v 1.74 2005/03/24 09:04:17 mschwide Exp $
> + * $Id: ctcmain.c,v 1.78 2005/09/07 12:18:02 pavlic Exp $
>   *
>   * CTC / ESCON network driver
>   *
> @@ -37,10 +37,9 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   *
> - * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.74 $
> + * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.78 $
>   *
>   */
> -
>  #undef DEBUG
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -135,7 +134,7 @@ static const char *dev_event_names[] = {
>     "TX down",
>     "Restart",
>  };
> -
> +
>  /**
>   * Events of the channel statemachine
>   */
> @@ -249,7 +248,7 @@ static void
>  print_banner(void)
>  {
>     static int printed = 0;
> -   char vbuf[] = "$Revision: 1.74 $";
> +   char vbuf[] = "$Revision: 1.78 $";
>     char *version = vbuf;
> 
>     if (printed)
> @@ -334,7 +333,7 @@ static const char *ch_state_names[] = {
>     "Restarting",
>     "Not operational",
>  };
> -
> +
>  #ifdef DEBUG
>  /**
>   * Dump header and first 16 bytes of an sk_buff for debugging purposes.
> @@ -671,7 +670,7 @@ static void
>  fsm_action_nop(fsm_instance * fi, int event, void *arg)
>  {
>  }
> -
> +
>  /**
>   * Actions for channel - statemachines.
> 
> 
*****************************************************************************/
> @@ -1514,7 +1513,6 @@ ch_action_reinit(fsm_instance *fi, int e
>      fsm_addtimer(&privptr->restart_timer, 1000, DEV_EVENT_RESTART, 
dev);
>  }
> 
> -
>  /**
>   * The statemachine for a channel.
>   */
> @@ -1625,7 +1623,7 @@ static const fsm_node ch_fsm[] = {
>  };
> 
>  static const int CH_FSM_LEN = sizeof (ch_fsm) / sizeof (fsm_node);
> -
> +
>  /**
>   * Functions related to setup and device detection.
> 
> 
*****************************************************************************/
> @@ -1976,7 +1974,7 @@ ctc_irq_handler(struct ccw_device *cdev,
>        fsm_event(ch->fsm, CH_EVENT_IRQ, ch);
> 
>  }
> -
> +
>  /**
>   * Actions for interface - statemachine.
> 
> 
*****************************************************************************/
> @@ -2209,13 +2207,18 @@ transmit_skb(struct channel *ch, struct 
>     int rc = 0;
> 
>     DBF_TEXT(trace, 5, __FUNCTION__);
> +   /* we need to acquire the lock for testing the state
> +    * otherwise we can have an IRQ changing the state to 
> +    * TXIDLE after the test but before acquiring the lock.
> +    */
> +   spin_lock_irqsave(&ch->collect_lock, saveflags);
>     if (fsm_getstate(ch->fsm) != CH_STATE_TXIDLE) {
>        int l = skb->len + LL_HEADER_LENGTH;
> 
> -      spin_lock_irqsave(&ch->collect_lock, saveflags);
> -      if (ch->collect_len + l > ch->max_bufsize - 2)
> -         rc = -EBUSY;
> -      else {
> +      if (ch->collect_len + l > ch->max_bufsize - 2) {
> +         spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> +         return -EBUSY;
> +      } else {
>           atomic_inc(&skb->users);
>           header.length = l;
>           header.type = skb->protocol;
> @@ -2231,7 +2234,7 @@ transmit_skb(struct channel *ch, struct 
>        int ccw_idx;
>        struct sk_buff *nskb;
>        unsigned long hi;
> -
> +      spin_unlock_irqrestore(&ch->collect_lock, saveflags);
>        /**
>         * Protect skb against beeing free'd by upper
>         * layers.
> @@ -2256,6 +2259,7 @@ transmit_skb(struct channel *ch, struct 
>           if (!nskb) {
>              atomic_dec(&skb->users);
>              skb_pull(skb, LL_HEADER_LENGTH + 2);
> +            ctc_clear_busy(ch->netdev);
>              return -ENOMEM;
>           } else {
>              memcpy(skb_put(nskb, skb->len),
> @@ -2281,6 +2285,7 @@ transmit_skb(struct channel *ch, struct 
>               */
>              atomic_dec(&skb->users);
>              skb_pull(skb, LL_HEADER_LENGTH + 2);
> +            ctc_clear_busy(ch->netdev);
>              return -EBUSY;
>           }
> 
> @@ -2327,9 +2332,10 @@ transmit_skb(struct channel *ch, struct 
>        }
>     }
> 
> +   ctc_clear_busy(ch->netdev);
>     return rc;
>  }
> -
> +
>  /**
>   * Interface API for upper network layers
> 
> 
*****************************************************************************/
> @@ -2421,7 +2427,6 @@ ctc_tx(struct sk_buff *skb, struct net_d
>     dev->trans_start = jiffies;
>     if (transmit_skb(privptr->channel[WRITE], skb) != 0)
>        rc = 1;
> -   ctc_clear_busy(dev);
>     return rc;
>  }
> 
> @@ -2610,7 +2615,6 @@ stats_write(struct device *dev, struct d
>     return count;
>  }
> 
> -
>  static void
>  ctc_netdev_unregister(struct net_device * dev)
>  {
> @@ -2685,7 +2689,6 @@ ctc_proto_store(struct device *dev, stru
>     return count;
>  }
> 
> -
>  static ssize_t
>  ctc_type_show(struct device *dev, struct device_attribute *attr, char 
*buf)
>  {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

