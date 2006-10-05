Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWJESXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWJESXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWJESXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:23:42 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:7639 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751044AbWJESW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:22:58 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 5/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 11:04:28 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051104.28794.misha@fabric7.com>
X-OriginalArrivalTime: 05 Oct 2006 18:22:43.0031 (UTC) FILETIME=[3F935670:01C6E8AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding VIOC device driver. Device driver initialization/termination.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN linux-2.6.17/drivers/net/vioc/vioc_vnic.h 
linux-2.6.17.vioc/drivers/net/vioc/vioc_vnic.h
--- linux-2.6.17/drivers/net/vioc/vioc_vnic.h	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_vnic.h	2006-10-04 
10:10:04.000000000 -0700
@@ -0,0 +1,498 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#ifndef _VIOC_VNIC_H
+#define _VIOC_VNIC_H
+
+#include <linux/netdevice.h>
+#include <linux/if_ether.h>
+#include <linux/pci.h>
+
+#include "f7/vnic_defs.h"
+#include "f7/vnic_hw_registers.h"
+#include "f7/vioc_pkts_defs.h"
+
+/*
+ * VIOC PCI constants
+ */
+#define PCI_VENDOR_ID_FABRIC7  0xfab7
+#define PCI_DEVICE_ID_VIOC_1   0x0001
+#define PCI_DEVICE_ID_VIOC_8   0x0008
+#define PCI_DEVICE_ID_IOAPIC   0x7459
+
+#define VIOC_DRV_MODULE_NAME	"vioc"
+
+#define F7PF_HLEN_MIN   8	/* Minimal (kl=0) header */
+#define F7PF_HLEN_STD   10	/* Standard (kl=1) header */
+
+#define VNIC_MAX_MTU   9180
+#define VNIC_STD_MTU   1500
+
+/* VIOC device constants */
+#define VIOC_MAX_RXDQ		16
+#define VIOC_MAX_RXCQ		16
+#define VIOC_MAX_RXQ		4
+#define VIOC_MAX_TXQ		4
+#define VIOC_NAME_LEN		16
+
+/*
+ * VIOC device state
+ */
+
+#define VIOC_STATE_INIT                0
+#define VIOC_STATE_UP          (VIOC_STATE_INIT + 1)
+
+#define RX_DESC_SIZE   sizeof (struct rx_pktBufDesc_Phys_w)
+#define RX_DESC_QUANT  (4096/RX_DESC_SIZE)
+
+#define RXC_DESC_SIZE  sizeof (struct rxc_pktDesc_Phys_w)
+#define RXC_DESC_QUANT (4096/RXC_DESC_SIZE)
+
+#define TX_DESC_SIZE   sizeof (struct tx_pktBufDesc_Phys_w)
+#define TX_DESC_QUANT  (4096/TX_DESC_SIZE)
+
+#define RXS_DESC_SIZE  sizeof (struct rxc_pktStatusBlock_w)
+
+#define VIOC_COPYOUT_THRESHOLD	128
+#define VIOC_RXD_BATCH_BITS		32
+#define ALL_BATCH_SW_OWNED		0
+#define ALL_BATCH_HW_OWNED		0xffffffff
+
+#define VIOC_ANY_VNIC			0
+#define VIOC_NONE_TO_HW			(u32) -1
+
+/*
+ * Status of the Rx operation as reflected in Rx Completion Descriptor
+ */
+#define GET_VNIC_RXC_STATUS(rxcd)      (\
+       GET_VNIC_RXC_BADCRC(rxcd) |\
+       GET_VNIC_RXC_BADLENGTH(rxcd) |\
+       GET_VNIC_RXC_BADSMPARITY(rxcd) |\
+       GET_VNIC_RXC_PKTABORT(rxcd)\
+       )
+#define VNIC_RXC_STATUS_OK_W           0
+
+#define VNIC_RXC_STATUS_MASK (\
+               VNIC_RXC_ISBADLENGTH_W | \
+               VNIC_RXC_ISBADCRC_W | \
+               VNIC_RXC_ISBADSMPARITY_W | \
+               VNIC_RXC_ISPKTABORT_W \
+       )
+
+#define VIOC_IRQ_PARAM_VIOC_ID(param)  \
+       (int) (((u64) param >> 28) & 0xf)
+#define VIOC_IRQ_PARAM_INTR_ID(param)  \
+       (int) ((u64) param & 0xffff)
+#define VIOC_IRQ_PARAM_PARAM_ID(param) \
+       (int) (((u64) param >> 16) & 0xff)
+
+#define VIOC_IRQ_PARAM_SET(vioc, intr, param) \
+               ((((u64) vioc & 0xf) << 28) | \
+               (((u64) param & 0xff) << 16) | \
+               ((u64) intr & 0xffff))
+/*
+ * Return status codes
+ */
+#define E_VIOCOK       0
+#define E_VIOCMAX      1
+#define E_VIOCINTERNAL 2
+#define E_VIOCNETREGERR 3
+#define E_VIOCPARMERR  4
+#define E_VIOCNOOP     5
+#define E_VIOCTXFULL   6
+#define E_VIOCIFNOTFOUND 7
+#define E_VIOCMALLOCERR 8
+#define E_VIOCORDERR   9
+#define E_VIOCHWACCESS 10
+#define E_VIOCHWNOTREADY 11
+#define E_ALLOCERR     12
+#define E_VIOCRXHW     13
+#define E_VIOCRXCEMPTY 14
+
+/*
+ * From the HW statnd point, every VNIC has 4 RxQ - receive queues.
+ * Every RxQ is mapped to RxDQ (a ring with buffers for Rx Packets)
+ * and RxC queue (a ring with descriptors that reflect the status of the 
receive.
+ * I.e. when VIOC receives the packet on any of the 4 RxQ, it would use the 
mapping to determine where
+ * to get buffer for the packet (RxDQ) and where to post the result of the 
operation (RxC).
+ */
+
+struct rxd_q_prov {
+	u32 buf_size;
+	u32 entries;
+	u8 id;
+	u8 state;
+};
+
+struct vnic_prov_def {
+	struct rxd_q_prov rxd_ring[4];
+	u32 tx_entries;
+	u32 rxc_entries;
+	u8 rxc_id;
+	u8 rxc_intr_id;
+};
+
+struct vioc_run_param {
+	u32 rx_intr_timeout;
+	u32 rx_intr_cntout;
+	u32 rx_wdog_timeout;
+	u32 tx_pkts_per_bell;
+	u32 tx_pkts_per_irq;
+	int tx_intr_on_empty;
+};
+
+struct vioc_prov {
+	struct vnic_prov_def **vnic_prov_p;
+	struct vioc_run_param run_param;
+};
+
+struct vioc_irq {
+	int irq;
+	void *dev_id;
+};
+
+/*
+ * Wrapper around a pointer to a socket buffer
+ */
+struct vbuf {
+	volatile struct sk_buff *skb;
+	volatile dma_addr_t dma;
+	volatile u32 length;
+	volatile u32 special;
+	volatile unsigned long time_stamp;
+};
+
+struct rxc;
+
+/* Receive Completion set - RxC + NAPI device */
+struct napi_poll {
+	volatile u8 enabled;	/* if 0, Rx resource are not available */
+	volatile u8 stopped;	/* if 1, NAPI has stopped servicing set */
+	struct net_device poll_dev;	/* for NAPI */
+	u64 rx_interrupts;	/* Number of Rx Interrupts for VIOC stats */
+	struct rxc *rxc;
+};
+
+/* Rx Completion Queue */
+struct rxc {
+	u8 rxc_id;
+	u8 interrupt_id;
+	spinlock_t lock;
+	struct rxc_pktDesc_Phys_w *desc;
+	dma_addr_t dma;
+	u32 count;
+	u32 sw_idx;
+	u32 quota;
+	u32 budget;
+	void __iomem *va_of_vreg_ihcu_rxcintpktcnt;
+	void __iomem *va_of_vreg_ihcu_rxcinttimer;
+	void __iomem *va_of_vreg_ihcu_rxcintctl;
+	struct vioc_device *viocdev;
+	struct napi_poll napi;
+};
+
+/* Rx Descriptor Queue */
+struct rxdq {
+	u8 rxdq_id;
+	/* pointer to the Rx Buffer descriptor queue memory */
+	struct rx_pktBufDesc_Phys_w *desc;
+	dma_addr_t dma;
+	struct vbuf *vbuf;
+	u32 count;
+	u16 rx_buf_size;
+	/* A bit map of descriptors: 0 - owned by SW, 1 - owned by HW */
+	u32 *dmap;
+	u32 dmap_count;
+	/* dmap_idx is needed for proc fs */
+	u32 dmap_idx;
+	/* Descriptor desginated as a "fence", i.e. owned by SW. */
+	volatile u32 fence;
+	/* A counter that, when expires, forces a call to vioc_next_fence_run() */
+	volatile u32 skip_fence_run;
+	volatile u32 run_to_end;
+	volatile u32 to_hw;
+	volatile u32 starvations;
+	u32 prev_rxd_id;
+	u32 err_cnt;
+	u32 reset_cnt;
+	struct vioc_device *viocdev;
+};
+
+/* Tx Buffer Descriptor queue */
+struct txq {
+	u8 txq_id;		/* always TXQ0 for now */
+	u8 vnic_id;
+
+	spinlock_t lock;	/* interrupt-safe */
+	/*
+	 * Shadow of the TxD Control Register, keep it here, so we do
+	 * not have to read from HW
+	 */
+	u32 shadow_VREG_VENG_TXD_CTL;
+	/*
+	 * Address of the TxD Control Register when we ring the
+	 * bell. Keep this always ready, for expediency.
+	 */
+	void __iomem *va_of_vreg_veng_txd_ctl;
+	/*
+	 * pointer to the Tx Buffer Descriptor queue memory
+	 */
+	struct tx_pktBufDesc_Phys_w *desc;
+	dma_addr_t dma;
+	struct vbuf *vbuf;
+	u32 count;
+	u32 tx_pkts_til_irq;
+	u32 tx_pkts_til_bell;
+	u32 bells;
+	int do_ring_bell;
+	/* next descriptor to use for Tx */
+	volatile u32 next_to_use;
+	/* next descriptor to check completion of Tx */
+	volatile u32 next_to_clean;
+	/* Frags count */
+	volatile u32 frags;
+	/* Empty Tx descriptor slots */
+	volatile u32 empty;
+	u32 wraps;
+	u32 full;
+};
+
+/*  Rx Completion Status Block */
+struct rxs {
+	struct rxc_pktStatusBlock_w *block;
+	dma_addr_t dma;
+};
+
+typedef enum { RX_WDOG_DISABLED, RX_WDOG_EXPECT_PKT,
+	RX_WDOG_EXPECT_WDOGPKT
+} wdog_state_t;
+
+struct vioc_device_stats {
+	u64 tx_tasklets;	/* Number of Tx Interrupts */
+	u64 tx_timers;		/* Number of Tx watchdog timers */
+};
+
+#define        NETIF_STOP_Q    0xdead
+#define NETIF_START_Q  0xfeed
+
+struct vnic_device_stats {
+	u64 rx_fragment_errors;
+	u64 rx_dropped;
+	u64 skb_enqueued;	/* Total number of skb's enqueued */
+	u64 skb_freed;		/* Total number of skb's freed */
+	u32 netif_stops;	/* Number of times Tx was stopped */
+	u32 netif_last;		/* Last netif_  command */
+	u64 tx_on_empty_interrupts;	/* Number of Tx Empty Interrupts */
+	u32 headroom_misses;	/* Number of headroom misses */
+	u32 headroom_miss_drops;	/* Number of headroom misses */
+};
+
+struct vioc_ba {
+       void __iomem *virt;
+       unsigned long long phy;
+       unsigned long len;
+};
+
+struct vioc_device {
+	char name[VIOC_NAME_LEN];
+	u32 vioc_bits_version;
+	u32 vioc_bits_subversion;
+
+	u8 viocdev_idx;
+	u8 vioc_state;		/* Initialization state */
+	u8 mgmt_state;		/*  Management state */
+	u8 highdma;
+
+	u32 vnics_map;
+	u32 vnics_admin_map;
+	u32 vnics_link_map;
+
+	struct vioc_ba ba;	/* VIOC PCI Dev Base Address: virtual and phy */
+	struct vioc_ba ioapic_ba;	/* VIOC's IOAPIC Base Address: virtual and phy */
+	struct pci_dev *pdev;
+
+	/*
+	 * An array of pointers to net_device structures for
+	 * every subordinate VNIC
+	 */
+	struct net_device *vnic_netdev[VIOC_MAX_VNICS];
+	/*
+	 * An array describing all Rx Completion Descriptor Queues in VIOC
+	 */
+	struct rxc *rxc_p[VIOC_MAX_RXCQ];
+	struct rxc rxc_buf[VIOC_MAX_RXCQ];
+	/*
+	 * An array describing all Rx Descriptor Queues in VIOC
+	 */
+	struct rxdq *rxd_p[VIOC_MAX_RXDQ];
+	struct rxdq rxd_buf[VIOC_MAX_RXDQ];
+
+	/* Rx Completion Status Block */
+	struct rxs rxcstat;
+
+	/* ----- SIM SPECIFIC ------ */
+	/* * Round-robbin over Rx Completion queues */
+	u32 next_rxc_to_use;
+	/* Round-robbin over RxDQs, when checking them out */
+	u32 next_rxdq_to_use;
+
+	struct vioc_prov prov;	/* VIOC provisioning info */
+	struct vioc_device_stats vioc_stats;
+
+	struct timer_list bmc_wd_timer;
+	int bmc_wd_timer_active;
+
+	struct timer_list tx_timer;
+	int tx_timer_active;
+
+	u32 num_rx_irqs;
+	u32 num_irqs;
+	u32 last_msg_to_sim;
+};
+
+#define VIOC_BMC_INTR0 (1 << 0)
+#define VIOC_BMC_INTR1 (1 << 1)
+#define VIOC_BMC_INTR2 (1 << 2)
+#define VIOC_BMC_INTR3 (1 << 3)
+#define VIOC_BMC_INTR4 (1 << 4)
+#define VIOC_BMC_INTR5 (1 << 5)
+#define VIOC_BMC_INTR6 (1 << 6)
+#define VIOC_BMC_INTR7 (1 << 7)
+#define VIOC_BMC_INTR8 (1 << 8)
+#define VIOC_BMC_INTR9 (1 << 9)
+#define VIOC_BMC_INTR10        (1 << 10)
+#define VIOC_BMC_INTR11        (1 << 11)
+#define VIOC_BMC_INTR12        (1 << 12)
+#define VIOC_BMC_INTR13        (1 << 13)
+#define VIOC_BMC_INTR14        (1 << 14)
+#define VIOC_BMC_INTR15        (1 << 15)
+#define VIOC_BMC_INTR16        (1 << 16)
+#define VIOC_BMC_INTR17        (1 << 17)
+
+#define VNIC_NEXT_IDX(i, count) ((count == 0) ? 0: (((i) + 1) % (count)))
+#define VNIC_PREV_IDX(i, count) ((count == 0) ? 0: ((((i) == 0) ? ((count) - 
1): ((i) - 1))))
+
+#define VNIC_RING_BELL(vnic, q_idx) vnic_ring_bell(vnic, q_idx)
+
+#define TXDS_REQUIRED(skb) 1
+
+#define TXD_WATER_MARK                 8
+
+#define GET_DESC_PTR(R, i, type) (&(((struct type *)((R)->desc))[i]))
+#define RXD_PTR(R, i)          GET_DESC_PTR(R, i, rx_pktBufDesc_Phys_w)
+#define TXD_PTR(R, i)          GET_DESC_PTR(R, i, tx_pktBufDesc_Phys_w)
+#define RXC_PTR(R, i)          GET_DESC_PTR(R, i, rxc_pktBufDesc_Phys_w)
+
+/* Receive packet fragments */
+
+/* VNIC DEVICE */
+struct vnic_device {
+	u8 vnic_id;
+	u8 rxc_id;
+	u8 rxc_intr_id;
+
+	u32 qmap;		/* VNIC rx queues mappings */
+	u32 vnic_q_en;		/* VNIC queues enables */
+
+	struct txq txq;
+	struct vioc_device *viocdev;
+	struct net_device *netdev;
+	struct net_device_stats net_stats;
+	struct vnic_device_stats vnic_stats;
+
+	u8 hw_mac[ETH_ALEN];
+};
+
+/* vioc_transmit.c */
+extern int vioc_vnic_init(struct net_device *);
+extern void vioc_tx_timer(unsigned long data);
+
+/* vioc_driver.c */
+extern struct vioc_device *vioc_viocdev(u32 vioc_id);
+extern struct net_device *vioc_alloc_vnicdev(struct vioc_device *, int);
+
+/* vioc_irq.c */
+extern int vioc_irq_init(void);
+extern void vioc_irq_exit(void);
+extern void vioc_free_irqs(u32 viocdev_idx);
+extern int vioc_request_irqs(u32 viocdev_idx);
+
+extern int vioc_set_intr_func_param(int viocdev_idx, int intr_idx,
+				    int intr_param);
+
+extern void vioc_rxc_interrupt(void *input_param);
+extern void vioc_tx_interrupt(void *input_param);
+extern void vioc_bmc_interrupt(void *input_param);
+
+/* vioc_receive.c */
+extern int vioc_rx_poll(struct net_device *dev, int *budget);
+extern int vioc_next_fence_run(struct rxdq *);
+
+/* spp.c */
+extern int spp_init(void);
+extern void spp_terminate(void);
+extern void spp_msg_from_sim(int);
+
+/* spp_vnic.c */
+extern int spp_vnic_init(void);
+extern void spp_vnic_exit(void);
+
+/* vioc_spp.c */
+extern void vioc_vnic_prov(int, u32, u32, int);
+extern struct vnic_prov_def **vioc_prov_get(int);
+extern void vioc_hb_to_bmc(int vioc_id);
+extern int vioc_handle_reset_request(int);
+extern void vioc_os_reset_notifier_exit(void);
+extern void vioc_os_reset_notifier_init(void);
+
+
+
+static inline void vioc_rxc_interrupt_disable(struct rxc *rxc)
+{
+	writel(3, rxc->va_of_vreg_ihcu_rxcintctl);
+}
+
+static inline void vioc_rxc_interrupt_enable(struct rxc *rxc)
+{
+	writel(0, rxc->va_of_vreg_ihcu_rxcintctl);
+}
+
+static inline void vioc_rxc_interrupt_clear_pend(struct rxc *rxc)
+{
+	writel(2, rxc->va_of_vreg_ihcu_rxcintctl);
+}
+
+#define POLL_WEIGHT 		32
+#define RX_INTR_TIMEOUT		2
+#define RX_INTR_PKT_CNT		8
+#define TX_PKTS_PER_IRQ		64
+#define TX_PKTS_PER_BELL	1
+#define VIOC_CSUM_OFFLOAD	CHECKSUM_HW
+#define VIOC_TRACE			0
+
+#define VIOC_LISTEN_GROUP	1
+
+#endif				/* _VIOC_VNIC_H */
diff -uprN linux-2.6.17/drivers/net/vioc/vioc_driver.c 
linux-2.6.17.vioc/drivers/net/vioc/vioc_driver.c
--- linux-2.6.17/drivers/net/vioc/vioc_driver.c	1969-12-31 16:00:00.000000000 
-0800
+++ linux-2.6.17.vioc/drivers/net/vioc/vioc_driver.c	2006-10-04 
10:51:24.000000000 -0700
@@ -0,0 +1,872 @@
+/*
+ * Fabric7 Systems Virtual IO Controller Driver
+ * Copyright (C) 2003-2005 Fabric7 Systems.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * http://www.fabric7.com/
+ *
+ * Maintainers:
+ *    driver-support@fabric7.com
+ *
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/sysdev.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/errno.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#include "f7/vnic_hw_registers.h"
+#include "f7/vnic_defs.h"
+
+#include <linux/moduleparam.h>
+#include "vioc_vnic.h"
+#include "vioc_api.h"
+
+#include "driver_version.h"
+
+
+MODULE_AUTHOR("support@fabric7.com");
+MODULE_DESCRIPTION("VIOC interface driver");
+MODULE_LICENSE("GPL");
+
+MODULE_VERSION(VIOC_DISPLAY_VERSION);
+
+/*
+ * Standard parameters for ring provisioning.  Single TxQ per VNIC.
+ * Two RX sets per VIOC, with 3 RxDs, 1 RxC, 1 Rx interrupt per set.
+ */
+
+#define TXQ_SIZE			1024
+#define TX_INTR_ON_EMPTY	0
+
+#define VNIC_RXQ_MAP		0xf	/* Bits 0-3 for 4 VNIC queues */
+#define RXDQ_PERSET_COUNT	3
+#define RXDQ_COUNT			(RXSET_COUNT * RXDQ_PERSET_COUNT)
+/* RXDQ sizes (entry counts) must be multiples of this */
+#define RXDQ_ALIGN			VIOC_RXD_BATCH_BITS
+#define RXDQ_SIZE			2048
+#define RXDQ_JUMBO_SIZE		ALIGN(RXDQ_SIZE, RXDQ_ALIGN)
+#define RXDQ_STD_SIZE		ALIGN(RXDQ_SIZE, RXDQ_ALIGN)
+#define RXDQ_SMALL_SIZE		ALIGN(RXDQ_SIZE, RXDQ_ALIGN)
+#define RXDQ_EXTRA_SIZE		ALIGN(RXDQ_SIZE, RXDQ_ALIGN)
+
+#define RXC_COUNT			RXSET_COUNT
+#define RXC_SIZE			
(RXDQ_JUMBO_SIZE+RXDQ_STD_SIZE+RXDQ_SMALL_SIZE+RXDQ_EXTRA_SIZE)
+
+/* VIOC devices */
+static struct pci_device_id vioc_pci_tbl[] __devinitdata = {
+	{PCI_DEVICE(PCI_VENDOR_ID_FABRIC7, PCI_DEVICE_ID_VIOC_1)},
+	{PCI_DEVICE(PCI_VENDOR_ID_FABRIC7, PCI_DEVICE_ID_VIOC_8)},
+	{0,},
+};
+
+MODULE_DEVICE_TABLE(pci, vioc_pci_tbl);
+
+static spinlock_t vioc_idx_lock = SPIN_LOCK_UNLOCKED;
+static unsigned vioc_idx = 0;
+static struct vioc_device *vioc_devices[VIOC_MAX_VIOCS];
+
+static struct vioc_device *viocdev_new(int viocdev_idx, struct pci_dev *pdev)
+{
+	int k;
+	struct vioc_device *viocdev;
+
+	if (viocdev_idx >= VIOC_MAX_VIOCS)
+		return NULL;
+
+	viocdev = kmalloc(sizeof(struct vioc_device), GFP_KERNEL);
+	if (!viocdev)
+		return viocdev;
+
+	memset(viocdev, 0, sizeof(struct vioc_device));
+
+	viocdev->pdev = pdev;
+	viocdev->vioc_state = VIOC_STATE_INIT;
+	viocdev->viocdev_idx = viocdev_idx;
+
+	viocdev->prov.run_param.tx_pkts_per_bell = TX_PKTS_PER_BELL;
+	viocdev->prov.run_param.tx_pkts_per_irq = TX_PKTS_PER_IRQ;
+	viocdev->prov.run_param.tx_intr_on_empty = TX_INTR_ON_EMPTY;
+	viocdev->prov.run_param.rx_intr_timeout = RX_INTR_TIMEOUT;
+	viocdev->prov.run_param.rx_intr_cntout = RX_INTR_PKT_CNT;
+	viocdev->prov.run_param.rx_wdog_timeout = HZ / 4;
+
+	for (k = 0; k < VIOC_MAX_VNICS; k++) {
+		viocdev->vnic_netdev[k] = NULL;	/* spp */
+	}
+
+	vioc_devices[viocdev_idx] = viocdev;
+
+	return viocdev;
+}
+
+/*
+ * Remove all Rx descriptors from the queue.
+ */
+static void vioc_clear_rxq(struct vioc_device *viocdev, struct rxdq *rxdq)
+{
+	int j;
+
+	/* Disable this queue */
+	vioc_ena_dis_rxd_q(viocdev->viocdev_idx, rxdq->rxdq_id, 0);
+
+	if (rxdq->vbuf == NULL)
+		return;
+
+	for (j = 0; j < rxdq->count; j++) {
+		struct rx_pktBufDesc_Phys_w *rxd;
+		if (rxdq->vbuf[j].skb) {
+			pci_unmap_single(rxdq->viocdev->pdev,
+					 rxdq->vbuf[j].dma,
+					 rxdq->rx_buf_size, PCI_DMA_FROMDEVICE);
+			dev_kfree_skb_any((struct sk_buff *)rxdq->vbuf[j].skb);
+			rxdq->vbuf[j].skb = NULL;
+			rxdq->vbuf[j].dma = (dma_addr_t) NULL;
+		}
+		rxd = RXD_PTR(rxdq, j);
+		wmb();
+		CLR_VNIC_RX_OWNED(rxd);
+	}
+}
+
+/*
+ * Refill an empty Rx queue with Rx with Rx buffers
+ */
+static int vioc_refill_rxq(struct vioc_device *viocdev, struct rxdq *rxdq)
+{
+	int ret = 0;
+
+	memset(rxdq->vbuf, 0, rxdq->count * sizeof(struct vbuf));
+	memset(rxdq->dmap, 0, rxdq->dmap_count * (VIOC_RXD_BATCH_BITS / 8));
+
+	rxdq->fence = 0;
+	rxdq->to_hw = VIOC_NONE_TO_HW;
+	rxdq->starvations = 0;
+	rxdq->run_to_end = 0;
+	rxdq->skip_fence_run = rxdq->dmap_count / 4;
+
+	ret = vioc_next_fence_run(rxdq);
+	BUG_ON(ret != 0);
+	return ret;
+}
+
+struct vioc_device *vioc_viocdev(u32 viocdev_idx)
+{
+	if (viocdev_idx >= vioc_idx) {
+		BUG_ON(viocdev_idx >= vioc_idx);
+		return NULL;
+	}
+
+	BUG_ON(vioc_devices[viocdev_idx] == NULL);
+	return vioc_devices[viocdev_idx];
+}
+
+static void vioc_bmc_wdog(unsigned long data)
+{
+
+	struct vioc_device *viocdev = (struct vioc_device *)data;
+
+	if (!viocdev->bmc_wd_timer_active)
+		return;
+
+	/*
+	 * Send Heartbeat message to BMC
+	 */
+	vioc_hb_to_bmc(viocdev->viocdev_idx);
+
+	/*
+	 * Reset the timer
+	 */
+	mod_timer(&viocdev->bmc_wd_timer, jiffies + HZ);
+
+	return;
+}
+
+static int extract_vnic_prov(struct vioc_device *viocdev, 
+									struct vnic_device *vnicdev)
+{
+	struct vnic_prov_def *vr;
+	int j;
+
+	vr = viocdev->prov.vnic_prov_p[vnicdev->vnic_id];
+	if (vr == NULL) {
+		dev_err(&viocdev->pdev->dev, "vioc %d: vnic %d No provisioning set\n",
+		       viocdev->viocdev_idx, vnicdev->vnic_id);
+		return E_VIOCPARMERR;
+	}
+
+	if (vr->tx_entries == 0) {
+		dev_err(&viocdev->pdev->dev, "vioc %d: vnic %d Tx ring not provisioned\n",
+		       viocdev->viocdev_idx, vnicdev->vnic_id);
+		return E_VIOCPARMERR;
+	}
+
+	if (viocdev->rxc_p[vr->rxc_id] == NULL) {
+		dev_err(&viocdev->pdev->dev,
+		       "vioc %d: vnic %d RxC ring %d  not provisioned\n",
+		       viocdev->viocdev_idx, vnicdev->vnic_id, vr->rxc_id);
+		return E_VIOCPARMERR;
+	}
+
+	if (vr->rxc_intr_id >= viocdev->num_rx_irqs) {
+		dev_err(&viocdev->pdev->dev, "vioc %d: vnic %d IRQ %d INVALID (max %d)\n",
+		       viocdev->viocdev_idx, vnicdev->vnic_id,
+		       vr->rxc_intr_id, (viocdev->num_rx_irqs - 1));
+		return E_VIOCPARMERR;
+	}
+
+	vnicdev->txq.count = vr->tx_entries;
+	vnicdev->rxc_id = vr->rxc_id;
+	vnicdev->rxc_intr_id = vr->rxc_intr_id;
+
+	for (j = 0; j < 4; j++) {
+		struct rxd_q_prov *ring = &vr->rxd_ring[j];
+
+		if (ring->state == 0)
+			continue;
+
+		if (viocdev->rxd_p[ring->id] == NULL) {
+			dev_err(&viocdev->pdev->dev,
+			       "vioc %d: vnic %d RxD ring %d  not provisioned\n",
+			       viocdev->viocdev_idx, vnicdev->vnic_id,
+			       ring->id);
+			return E_VIOCPARMERR;
+		}
+
+		/* Set Rx queue ENABLE bit for BMC_VNIC_CFG register */
+		vnicdev->vnic_q_en |= (1 << j);
+
+	}
+	vnicdev->qmap =
+	    ((vr->rxd_ring[0].id & 0xf) << (0 + 8 * 0)) |
+	    ((vr->rxd_ring[0].state & 0x1) << (7 + 8 * 0)) |
+	    ((vr->rxd_ring[1].id & 0xf) << (0 + 8 * 1)) |
+	    ((vr->rxd_ring[1].state & 0x1) << (7 + 8 * 1)) |
+	    ((vr->rxd_ring[2].id & 0xf) << (0 + 8 * 2)) |
+	    ((vr->rxd_ring[2].state & 0x1) << (7 + 8 * 2)) |
+	    ((vr->rxd_ring[3].id & 0xf) << (0 + 8 * 3)) |
+	    ((vr->rxd_ring[3].state & 0x1) << (7 + 8 * 3));
+	return E_VIOCOK;
+}
+
+struct net_device *vioc_alloc_vnicdev(struct vioc_device *viocdev, int 
vnic_id)
+{
+	struct net_device *netdev;
+	struct vnic_device *vnicdev;
+
+	netdev = alloc_etherdev(sizeof(struct vnic_device));
+	if (!netdev) {
+		return NULL;
+	}
+
+	viocdev->vnic_netdev[vnic_id] = netdev;
+	vnicdev = netdev_priv(netdev);
+	vnicdev->viocdev = viocdev;
+	vnicdev->netdev = netdev;
+	vnicdev->vnic_id = vnic_id;
+	sprintf(&netdev->name[0], "ve%d.%02d", viocdev->viocdev_idx, vnic_id);
+	netdev->init = &vioc_vnic_init;	/* called when it is registered */
+	vnicdev->txq.vnic_id = vnic_id;
+
+	if (extract_vnic_prov(viocdev, vnicdev) != E_VIOCOK) {
+		free_netdev(netdev);
+		return NULL;
+	}
+
+	return netdev;
+}
+
+static void vioc_free_resources(struct vioc_device *viocdev, u32 viocidx)
+{
+	int i;
+	struct napi_poll *napi_p;
+	int start_j = jiffies;
+	int delta_j = 0;
+
+	for (i = 0; i < VIOC_MAX_RXCQ; i++) {
+		struct rxc *rxc = viocdev->rxc_p[i];
+		if (rxc == NULL)
+			continue;
+
+		napi_p = &rxc->napi;
+		/* Tell NAPI poll to stop */
+		napi_p->enabled = 0;
+
+		/* Make sure that NAPI poll gets the message */
+		netif_rx_schedule(&napi_p->poll_dev);
+
+		/* Wait for an ack from NAPI that it stopped,
+		 * so we can release resources
+		 */
+		while (!napi_p->stopped) {
+			schedule();
+			delta_j = jiffies - start_j;
+			if (delta_j > 10 * HZ) {
+				/* Looks like NAPI didn;t get to run.
+				 * Bail out hoping, we are not stuck
+				 * in NAPI poll.
+				 */
+				break;
+			}
+		}
+		if (rxc->dma) {
+			pci_free_consistent(viocdev->pdev,
+					    rxc->count * RXC_DESC_SIZE,
+					    rxc->desc, rxc->dma);
+			rxc->desc = NULL;
+			rxc->dma = (dma_addr_t) NULL;
+		}
+	}
+
+	for (i = 0; i < VIOC_MAX_RXDQ; i++) {
+		struct rxdq *rxdq = viocdev->rxd_p[i];
+		if (rxdq == NULL)
+			continue;
+
+		vioc_ena_dis_rxd_q(viocidx, rxdq->rxdq_id, 0);
+		if (rxdq->vbuf) {
+			vioc_clear_rxq(viocdev, rxdq);
+			vfree(rxdq->vbuf);
+			rxdq->vbuf = NULL;
+		}
+		if (rxdq->dmap) {
+			vfree(rxdq->dmap);
+			rxdq->dmap = NULL;
+		}
+		if (rxdq->dma) {
+			pci_free_consistent(viocdev->pdev,
+					    rxdq->count * RX_DESC_SIZE,
+					    rxdq->desc, rxdq->dma);
+			rxdq->desc = NULL;
+			rxdq->dma = (dma_addr_t) NULL;
+		}
+		viocdev->rxd_p[rxdq->rxdq_id] = NULL;
+	}
+
+	/* Free RxC status block */
+	if (viocdev->rxcstat.dma) {
+		pci_free_consistent(viocdev->pdev, RXS_DESC_SIZE,
+				    viocdev->rxcstat.block,
+				    viocdev->rxcstat.dma);
+		viocdev->rxcstat.block = NULL;
+		viocdev->rxcstat.dma = (dma_addr_t) NULL;
+	}
+
+}
+
+/*
+ * Initialize rxsets - RxS, RxCs and RxDs and push to VIOC.
+ * Return negative errno on failure.
+ */
+static int vioc_alloc_resources(struct vioc_device *viocdev, u32 viocidx)
+{
+	int j, i;
+	int ret;
+	struct vnic_prov_def *vr;
+	struct napi_poll *napi_p;
+	struct rxc *rxc;
+
+	dev_err(&viocdev->pdev->dev, "vioc%d: ENTER %s\n", viocidx, __FUNCTION__);
+
+	/* Allocate Rx Completion Status block */
+	viocdev->rxcstat.block = (struct rxc_pktStatusBlock_w *)
+	    pci_alloc_consistent(viocdev->pdev,
+				 RXS_DESC_SIZE * VIOC_MAX_RXCQ,
+				 &viocdev->rxcstat.dma);
+	if (!viocdev->rxcstat.block) {
+		dev_err(&viocdev->pdev->dev, "vioc%d: Could not allocate RxS\n", viocidx);
+		ret = -ENOMEM;
+		goto error;
+	}
+	/* Tell VIOC about this RxC Status block */
+	ret = vioc_set_rxs(viocidx, viocdev->rxcstat.dma);
+	if (ret) {
+		dev_err(&viocdev->pdev->dev, "vioc%d: Could not set RxS\n", viocidx);
+		goto error;
+	}
+
+	/* Based on provisioning request, setup RxCs and RxDs */
+	for (i = 0; i < VIOC_MAX_VNICS; i++) {
+		vr = viocdev->prov.vnic_prov_p[i];
+		if (vr == NULL) {
+			dev_err(&viocdev->pdev->dev,
+			       "vioc %d: vnic %d No provisioning set\n",
+			       viocdev->viocdev_idx, i);
+			goto error;
+		}
+
+		if (vr->rxc_id >= VIOC_MAX_RXCQ) {
+			dev_err(&viocdev->pdev->dev, "vioc%d: INVALID RxC %d provisioned\n",
+			       viocidx, vr->rxc_id);
+			goto error;
+		}
+		rxc = viocdev->rxc_p[vr->rxc_id];
+		if (rxc == NULL) {
+			rxc = &viocdev->rxc_buf[vr->rxc_id];
+			viocdev->rxc_p[vr->rxc_id] = rxc;
+			rxc->rxc_id = vr->rxc_id;
+			rxc->viocdev = viocdev;
+			rxc->quota = POLL_WEIGHT;
+			rxc->budget = POLL_WEIGHT;
+			rxc->count = vr->rxc_entries;
+
+			/* Allocate RxC ring memory */
+			rxc->desc = (struct rxc_pktDesc_Phys_w *)
+			    pci_alloc_consistent(viocdev->pdev,
+						 rxc->count * RXC_DESC_SIZE,
+						 &rxc->dma);
+			if (!rxc->desc) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Can't allocate RxC ring %d for %d entries\n",
+				       viocidx, rxc->rxc_id, rxc->count);
+				ret = -ENOMEM;
+				goto error;
+			}
+			rxc->interrupt_id = vr->rxc_intr_id;
+
+			rxc->va_of_vreg_ihcu_rxcinttimer =
+			    (&viocdev->ba)->virt + GETRELADDR(VIOC_IHCU, 0,
+							      (VREG_IHCU_RXCINTTIMER
+							       +
+							       (rxc->
+								interrupt_id <<
+								2)));
+
+			rxc->va_of_vreg_ihcu_rxcintpktcnt =
+			    (&viocdev->ba)->virt + GETRELADDR(VIOC_IHCU, 0,
+							      (VREG_IHCU_RXCINTPKTCNT
+							       +
+							       (rxc->
+								interrupt_id <<
+								2)));
+			rxc->va_of_vreg_ihcu_rxcintctl =
+			    (&viocdev->ba)->virt + GETRELADDR(VIOC_IHCU, 0,
+							      (VREG_IHCU_RXCINTCTL
+							       +
+							       (rxc->
+								interrupt_id <<
+								2)));
+			/* Set parameter (rxc->rxc_id), that will be passed to interrupt code */
+			ret = vioc_set_intr_func_param(viocdev->viocdev_idx,
+						       rxc->interrupt_id,
+						       rxc->rxc_id);
+			if (ret) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Could not set PARAM for INTR ID %d\n",
+				       viocidx, rxc->interrupt_id);
+				goto error;
+			}
+
+			/* Register RxC ring and interrupt */
+			ret = vioc_set_rxc(viocidx, rxc);
+			if (ret) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Could not set RxC %d\n",
+				       viocidx, vr->rxc_id);
+				goto error;
+			}
+
+			/* Initialize NAPI poll structure and device */
+			napi_p = &rxc->napi;
+			napi_p->enabled = 1;	/* ready for Rx poll */
+			napi_p->stopped = 0;	/* NOT stopped */
+			napi_p->rxc = rxc;
+			napi_p->poll_dev.weight = POLL_WEIGHT;
+			napi_p->poll_dev.priv = &rxc->napi;	/* Note */
+			napi_p->poll_dev.poll = &vioc_rx_poll;
+
+			dev_hold(&napi_p->poll_dev);
+			/* Enable the poll device */
+			set_bit(__LINK_STATE_START, &napi_p->poll_dev.state);
+			netif_start_queue(&napi_p->poll_dev);
+		};
+
+		/* Allocate Rx rings */
+		for (j = 0; j < 4; j++) {
+			struct rxd_q_prov *ring = &vr->rxd_ring[j];
+			struct rxdq *rxdq;
+
+			if (ring->id >= VIOC_MAX_RXDQ) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: BAD Provisioning request for RXD %d\n",
+				       viocidx, ring->id);
+				goto error;
+			}
+
+			rxdq = viocdev->rxd_p[ring->id];
+			if (rxdq != NULL)
+				continue;
+
+			if (ring->state == 0)
+				continue;
+
+			rxdq = &viocdev->rxd_buf[ring->id];
+			viocdev->rxd_p[ring->id] = rxdq;
+
+			rxdq->rxdq_id = ring->id;
+			rxdq->viocdev = viocdev;
+			rxdq->count = ring->entries;
+			rxdq->rx_buf_size = ring->buf_size;
+
+			/* skb array */
+			rxdq->vbuf = vmalloc(rxdq->count * sizeof(struct vbuf));
+			if (!rxdq->vbuf) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Can't allocate RxD vbuf (%d entries)\n",
+				       viocidx, rxdq->count);
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			/* Ring memory */
+			rxdq->desc = (struct rx_pktBufDesc_Phys_w *)
+			    pci_alloc_consistent(viocdev->pdev,
+						 rxdq->count * RX_DESC_SIZE,
+						 &rxdq->dma);
+			if (!rxdq->desc) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Can't allocate RxD ring (%d entries)\n",
+				       viocidx, rxdq->count);
+				ret = -ENOMEM;
+				goto error;
+			}
+			rxdq->dmap_count = rxdq->count / VIOC_RXD_BATCH_BITS;
+			/* Descriptor ownership bit map */
+			rxdq->dmap = (u32 *)
+			    vmalloc(rxdq->dmap_count *
+				    (VIOC_RXD_BATCH_BITS / 8));
+			if (!rxdq->dmap) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Could not allocate dmap\n",
+				       viocidx);
+				ret = -ENOMEM;
+				goto error;
+			}
+			/* Refill ring */
+			ret = vioc_refill_rxq(viocdev, rxdq);
+			if (ret) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Could not fill rxdq%d\n",
+				       viocidx, rxdq->rxdq_id);
+				goto error;
+			}
+			/* Tell VIOC about this queue */
+			ret = vioc_set_rxdq(viocidx, VIOC_ANY_VNIC,
+					    rxdq->rxdq_id, rxdq->rx_buf_size,
+					    rxdq->dma, rxdq->count);
+			if (ret) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Could not set rxdq%d\n",
+				       viocidx, rxdq->rxdq_id);
+				goto error;
+			}
+			/* Enable this queue */
+			ret = vioc_ena_dis_rxd_q(viocidx, rxdq->rxdq_id, 1);
+			if (ret) {
+				dev_err(&viocdev->pdev->dev,
+				       "vioc%d: Could not enable rxdq%d\n",
+				       viocidx, rxdq->rxdq_id);
+				goto error;
+			}
+		}		/* for 4 rings */
+	}
+
+	return 0;
+
+      error:
+	/* Caller is responsible for calling vioc_free_rxsets() */
+	return ret;
+}
+
+static void vioc_remove(struct pci_dev *pdev)
+{
+	struct vioc_device *viocdev = pci_get_drvdata(pdev);
+
+	if (!viocdev)
+		return;
+
+	/* Disable interrupts */
+	vioc_free_irqs(viocdev->viocdev_idx);
+
+	viocdev->vioc_state = VIOC_STATE_INIT;
+
+	if (viocdev->bmc_wd_timer.function) {
+		viocdev->bmc_wd_timer_active = 0;
+		del_timer_sync(&viocdev->bmc_wd_timer);
+	}
+
+	if (viocdev->tx_timer.function) {
+		viocdev->tx_timer_active = 0;
+		del_timer_sync(&viocdev->tx_timer);
+	}
+
+	vioc_vnic_prov(viocdev->viocdev_idx, 0, 0, 1);
+
+	vioc_free_resources(viocdev, viocdev->viocdev_idx);
+
+	/* Reset VIOC chip */
+	vioc_sw_reset(viocdev->viocdev_idx);
+
+#if defined(CONFIG_MSIX_MOD)
+	if (viocdev->num_irqs > 4) {
+		pci_disable_msix(viocdev->pdev);
+	} else {
+		pci_release_regions(viocdev->pdev);
+	}
+#else
+	pci_release_regions(viocdev->pdev);
+#endif
+
+	iounmap(viocdev->ba.virt);
+
+	if (viocdev->viocdev_idx < VIOC_MAX_VIOCS)
+		vioc_devices[viocdev->viocdev_idx] = NULL;
+
+	kfree(viocdev);
+	pci_set_drvdata(pdev, NULL);
+
+	pci_disable_device(pdev);
+}
+
+/*
+ * vioc_probe - Device Initialization Routine
+ * @pdev: PCI device information struct (VIOC PCI device)
+ * @ent: entry in vioc_pci_tbl
+ *
+ * Returns 0 on success, negative on failure
+ *
+ */
+static int __devinit vioc_probe(struct pci_dev *pdev, const
+				struct pci_device_id *ent)
+{
+	int cur_vioc_idx;
+	struct vioc_device *viocdev;
+	unsigned long long mmio_start = 0, mmio_len;
+	u32 param1, param2;
+	int ret;
+
+	viocdev = pci_get_drvdata(pdev);
+	if (viocdev) {
+		cur_vioc_idx = viocdev->viocdev_idx;
+		BUG_ON(viocdev != NULL);	/* should not happen */
+	} else {
+		spin_lock(&vioc_idx_lock);
+		cur_vioc_idx = vioc_idx++;
+		spin_unlock(&vioc_idx_lock);
+		if (cur_vioc_idx < VIOC_MAX_VIOCS) {
+			viocdev = viocdev_new(cur_vioc_idx, pdev);
+			BUG_ON(viocdev == NULL);
+			pci_set_drvdata(pdev, viocdev);
+		} else {
+			dev_err(&pdev->dev,
+			       "vioc_id %d > maximum supported, aborting.\n",
+			       cur_vioc_idx);
+			return -ENODEV;
+		}
+	}
+
+	sprintf(viocdev->name, "vioc%d", cur_vioc_idx);
+
+	if ((ret = pci_enable_device(pdev))) {
+		dev_err(&pdev->dev, "vioc%d: Cannot enable PCI device\n",
+		       cur_vioc_idx);
+		goto vioc_probe_err;
+	}
+
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
+		dev_err(&pdev->dev, "vioc%d: Cannot find PCI device base address\n",
+		       cur_vioc_idx);
+		ret = -ENODEV;
+		goto vioc_probe_err;
+	}
+
+	/* Initialize interrupts: get number if Rx IRQs, 2 or 16 are valid returns 
*/
+	viocdev->num_rx_irqs = vioc_request_irqs(cur_vioc_idx);
+
+	if (viocdev->num_rx_irqs == 0) {
+		dev_err(&pdev->dev, "vioc%d: Request IRQ failed\n", cur_vioc_idx);
+		goto vioc_probe_err;
+	}
+
+	pci_set_master(pdev);
+
+	/* Configure DMA attributes. */
+	if ((ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
+		if ((ret = pci_set_dma_mask(pdev, DMA_32BIT_MASK))) {
+			dev_err(&pdev->dev, "vioc%d: No usable DMA configuration\n",
+			       cur_vioc_idx);
+			goto vioc_probe_err;
+		}
+	} else {
+		viocdev->highdma = 1;
+	}
+
+	mmio_start = pci_resource_start(pdev, 0);
+	mmio_len = pci_resource_len(pdev, 0);
+
+	viocdev->ba.virt = ioremap(mmio_start, mmio_len);
+	viocdev->ba.phy = mmio_start;
+	viocdev->ba.len = mmio_len;
+
+	/* Soft reset the chip; pick up versions */
+	vioc_sw_reset(cur_vioc_idx);
+
+	viocdev->vioc_bits_version &= 0xff;
+
+	if (viocdev->vioc_bits_version < 0x74) {
+		dev_err(&pdev->dev, "VIOC version %x not supported, aborting\n",
+		       viocdev->vioc_bits_version);
+		ret = -EINVAL;
+		goto vioc_probe_err;
+	}
+
+	dev_info(&pdev->dev, "vioc%d: Detected VIOC version %x.%x\n",
+	       cur_vioc_idx,
+	       viocdev->vioc_bits_version, viocdev->vioc_bits_subversion);
+
+	viocdev->prov.vnic_prov_p = vioc_prov_get(viocdev->num_rx_irqs);
+
+	/* Allocate and provision resources */
+	if ((ret = vioc_alloc_resources(viocdev, cur_vioc_idx))) {
+		dev_err(&pdev->dev, "vioc%d: Could not allocate resources\n",
+		       cur_vioc_idx);
+		goto vioc_probe_err;
+	}
+
+	/*
+	 * Initialize heartbeat (watchdog) timer:
+	 */
+	if (viocdev->viocdev_idx == 0) {
+		/* Heartbeat is delivered ONLY by "master" VIOC in a
+		 * partition */
+		init_timer(&viocdev->bmc_wd_timer);
+		viocdev->bmc_wd_timer.function = &vioc_bmc_wdog;
+		viocdev->bmc_wd_timer.expires = jiffies + HZ;
+		viocdev->bmc_wd_timer.data = (unsigned long)viocdev;
+		add_timer(&viocdev->bmc_wd_timer);
+		viocdev->bmc_wd_timer_active = 1;
+	}
+
+	/* Disable all watchdogs by default */
+	viocdev->bmc_wd_timer_active = 0;
+
+	/*
+	 * Initialize tx_timer (tx watchdog) timer:
+	 */
+	init_timer(&viocdev->tx_timer);
+	viocdev->tx_timer.function = &vioc_tx_timer;
+	viocdev->tx_timer.expires = jiffies + HZ / 4;
+	viocdev->tx_timer.data = (unsigned long)viocdev;
+	add_timer(&viocdev->tx_timer);
+	/* !!! TESTING ONLY !!! */
+	viocdev->tx_timer_active = 1;
+
+	viocdev->vnics_map = 0;
+
+	param1 = vioc_rrd(viocdev->viocdev_idx, VIOC_BMC, 0, VREG_BMC_VNIC_EN);
+	param2 = vioc_rrd(viocdev->viocdev_idx, VIOC_BMC, 0, VREG_BMC_PORT_EN);
+	vioc_vnic_prov(viocdev->viocdev_idx, param1, param2, 1);
+
+	viocdev->vioc_state = VIOC_STATE_UP;
+
+	return ret;
+
+      vioc_probe_err:
+	vioc_remove(pdev);
+	return ret;
+}
+
+/*
+ * Set up "version" as a driver attribute.
+ */
+static ssize_t show_version(struct device_driver *drv, char *buf)
+{
+	sprintf(buf, "%s\n", VIOC_DISPLAY_VERSION);
+	return strlen(buf) + 1;
+}
+
+static DRIVER_ATTR(version, S_IRUGO, show_version, NULL);
+
+static struct pci_driver vioc_driver = {
+	.name = VIOC_DRV_MODULE_NAME,
+	.id_table = vioc_pci_tbl,
+	.probe = vioc_probe,
+	.remove = __devexit_p(vioc_remove),
+};
+
+static int __init vioc_module_init(void)
+{
+	int ret = 0;
+
+	memset(&vioc_devices, 0, sizeof(vioc_devices));
+	vioc_idx = 0;
+	spin_lock_init(&vioc_idx_lock);
+
+	vioc_irq_init();
+	spp_init();
+
+	ret = pci_module_init(&vioc_driver);
+	if (ret) {
+		printk(KERN_ERR "%s: pci_module_init() -> %d\n", __FUNCTION__,
+		       ret);
+		vioc_irq_exit();
+		return ret;
+	} else
+		driver_create_file(&vioc_driver.driver, &driver_attr_version);
+
+	vioc_os_reset_notifier_init();
+
+	return ret;
+}
+
+static void __exit vioc_module_exit(void)
+{
+	vioc_irq_exit();
+	spp_terminate();
+	flush_scheduled_work();
+	vioc_os_reset_notifier_exit();
+	driver_remove_file(&vioc_driver.driver, &driver_attr_version);
+	pci_unregister_driver(&vioc_driver);
+}
+
+module_init(vioc_module_init);
+module_exit(vioc_module_exit);
+
+#ifdef EXPORT_SYMTAB
+EXPORT_SYMBOL(vioc_viocdev);
+#endif				/* EXPORT_SYMTAB */


-- 
Misha Tomushev
misha@fabric7.com


