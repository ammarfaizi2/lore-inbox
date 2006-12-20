Return-Path: <linux-kernel-owner+w=401wt.eu-S965018AbWLTMlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWLTMlf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWLTMlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:41:35 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:4335 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965015AbWLTMlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:41:32 -0500
From: Divy Le Ray <None@chelsio.com>
Subject: [PATCH 1/10] cxgb3 - main header files
Date: Wed, 20 Dec 2006 04:41:25 -0800
To: jeff@garzik.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
Message-Id: <20061220124125.6286.17148.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divy Le Ray <divy@chelsio.com>

This patch implements the main header files of
the Chelsio T3 network driver.

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---

 drivers/net/cxgb3/adapter.h          |  255 ++++++++++++
 drivers/net/cxgb3/common.h           |  709 ++++++++++++++++++++++++++++++++++
 drivers/net/cxgb3/cxgb3_ioctl.h      |  165 ++++++++
 drivers/net/cxgb3/firmware_exports.h |  144 +++++++
 4 files changed, 1273 insertions(+), 0 deletions(-)

diff --git a/drivers/net/cxgb3/adapter.h b/drivers/net/cxgb3/adapter.h
new file mode 100755
index 0000000..16643f6
--- /dev/null
+++ b/drivers/net/cxgb3/adapter.h
@@ -0,0 +1,255 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver for Linux.
+ *
+ * Copyright (C) 2003-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+/* This file should not be included directly.  Include common.h instead. */
+
+#ifndef __T3_ADAPTER_H__
+#define __T3_ADAPTER_H__
+
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/timer.h>
+#include <linux/cache.h>
+#include "t3cdev.h"
+#include <asm/semaphore.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+
+typedef irqreturn_t(*intr_handler_t) (int, void *);
+
+struct vlan_group;
+
+struct port_info {
+	struct vlan_group *vlan_grp;
+	const struct port_type_info *port_type;
+	u8 port_id;
+	u8 rx_csum_offload;
+	u8 nqsets;
+	u8 first_qset;
+	struct cphy phy;
+	struct cmac mac;
+	struct link_config link_config;
+	struct net_device_stats netstats;
+	int activity;
+};
+
+enum {				/* adapter flags */
+	FULL_INIT_DONE = (1 << 0),
+	USING_MSI = (1 << 1),
+	USING_MSIX = (1 << 2),
+};
+
+struct rx_desc;
+struct rx_sw_desc;
+
+struct sge_fl {			/* SGE per free-buffer list state */
+	unsigned int buf_size;	/* size of each Rx buffer */
+	unsigned int credits;	/* # of available Rx buffers */
+	unsigned int size;	/* capacity of free list */
+	unsigned int cidx;	/* consumer index */
+	unsigned int pidx;	/* producer index */
+	unsigned int gen;	/* free list generation */
+	struct rx_desc *desc;	/* address of HW Rx descriptor ring */
+	struct rx_sw_desc *sdesc;	/* address of SW Rx descriptor ring */
+	dma_addr_t phys_addr;	/* physical address of HW ring start */
+	unsigned int cntxt_id;	/* SGE context id for the free list */
+	unsigned long empty;	/* # of times queue ran out of buffers */
+};
+
+/*
+ * Bundle size for grouping offload RX packets for delivery to the stack.
+ * Don't make this too big as we do prefetch on each packet in a bundle.
+ */
+# define RX_BUNDLE_SIZE 8
+
+struct rsp_desc;
+
+struct sge_rspq {		/* state for an SGE response queue */
+	unsigned int credits;	/* # of pending response credits */
+	unsigned int size;	/* capacity of response queue */
+	unsigned int cidx;	/* consumer index */
+	unsigned int gen;	/* current generation bit */
+	unsigned int polling;	/* is the queue serviced through NAPI? */
+	unsigned int holdoff_tmr;	/* interrupt holdoff timer in 100ns */
+	unsigned int next_holdoff;	/* holdoff time for next interrupt */
+	struct rsp_desc *desc;	/* address of HW response ring */
+	dma_addr_t phys_addr;	/* physical address of the ring */
+	unsigned int cntxt_id;	/* SGE context id for the response q */
+	spinlock_t lock;	/* guards response processing */
+	struct sk_buff *rx_head;	/* offload packet receive queue head */
+	struct sk_buff *rx_tail;	/* offload packet receive queue tail */
+
+	unsigned long offload_pkts;
+	unsigned long offload_bundles;
+	unsigned long eth_pkts;	/* # of ethernet packets */
+	unsigned long pure_rsps;	/* # of pure (non-data) responses */
+	unsigned long imm_data;	/* responses with immediate data */
+	unsigned long rx_drops;	/* # of packets dropped due to no mem */
+	unsigned long async_notif; /* # of asynchronous notification events */
+	unsigned long empty;	/* # of times queue ran out of credits */
+	unsigned long nomem;	/* # of responses deferred due to no mem */
+	unsigned long unhandled_irqs;	/* # of spurious intrs */
+};
+
+struct tx_desc;
+struct tx_sw_desc;
+
+struct sge_txq {		/* state for an SGE Tx queue */
+	unsigned long flags;	/* HW DMA fetch status */
+	unsigned int in_use;	/* # of in-use Tx descriptors */
+	unsigned int size;	/* # of descriptors */
+	unsigned int processed;	/* total # of descs HW has processed */
+	unsigned int cleaned;	/* total # of descs SW has reclaimed */
+	unsigned int stop_thres;	/* SW TX queue suspend threshold */
+	unsigned int cidx;	/* consumer index */
+	unsigned int pidx;	/* producer index */
+	unsigned int gen;	/* current value of generation bit */
+	unsigned int unacked;	/* Tx descriptors used since last COMPL */
+	struct tx_desc *desc;	/* address of HW Tx descriptor ring */
+	struct tx_sw_desc *sdesc;	/* address of SW Tx descriptor ring */
+	spinlock_t lock;	/* guards enqueueing of new packets */
+	unsigned int token;	/* WR token */
+	dma_addr_t phys_addr;	/* physical address of the ring */
+	struct sk_buff_head sendq;	/* List of backpressured offload packets */
+	struct tasklet_struct qresume_tsk;	/* restarts the queue */
+	unsigned int cntxt_id;	/* SGE context id for the Tx q */
+	unsigned long stops;	/* # of times q has been stopped */
+	unsigned long restarts;	/* # of queue restarts */
+};
+
+enum {				/* per port SGE statistics */
+	SGE_PSTAT_TSO,		/* # of TSO requests */
+	SGE_PSTAT_RX_CSUM_GOOD,	/* # of successful RX csum offloads */
+	SGE_PSTAT_TX_CSUM,	/* # of TX checksum offloads */
+	SGE_PSTAT_VLANEX,	/* # of VLAN tag extractions */
+	SGE_PSTAT_VLANINS,	/* # of VLAN tag insertions */
+
+	SGE_PSTAT_MAX		/* must be last */
+};
+
+struct sge_qset {		/* an SGE queue set */
+	struct sge_rspq rspq;
+	struct sge_fl fl[SGE_RXQ_PER_SET];
+	struct sge_txq txq[SGE_TXQ_PER_SET];
+	struct net_device *netdev;	/* associated net device */
+	unsigned long txq_stopped;	/* which Tx queues are stopped */
+	struct timer_list tx_reclaim_timer;	/* reclaims TX buffers */
+	unsigned long port_stats[SGE_PSTAT_MAX];
+} ____cacheline_aligned;
+
+struct sge {
+	struct sge_qset qs[SGE_QSETS];
+	spinlock_t reg_lock;	/* guards non-atomic SGE registers (eg context) */
+};
+
+struct adapter {
+	struct t3cdev tdev;
+	struct list_head adapter_list;
+	void __iomem *regs;
+	struct pci_dev *pdev;
+	unsigned long registered_device_map;
+	unsigned long open_device_map;
+	unsigned long flags;
+
+	const char *name;
+	int msg_enable;
+	unsigned int mmio_len;
+
+	struct adapter_params params;
+	unsigned int slow_intr_mask;
+	unsigned long irq_stats[IRQ_NUM_STATS];
+
+	struct {
+		unsigned short vec;
+		char desc[22];
+	} msix_info[SGE_QSETS + 1];
+
+	/* T3 modules */
+	struct sge sge;
+	struct mc7 pmrx;
+	struct mc7 pmtx;
+	struct mc7 cm;
+	struct mc5 mc5;
+
+	struct net_device *port[MAX_NPORTS];
+	unsigned int check_task_cnt;
+	struct delayed_work adap_check_task;
+	struct work_struct ext_intr_handler_task;
+
+	/*
+	 * Dummy netdevices are needed when using multiple receive queues with
+	 * NAPI as each netdevice can service only one queue.
+	 */
+	struct net_device *dummy_netdev[SGE_QSETS - 1];
+
+	struct dentry *debugfs_root;
+
+	struct mutex mdio_lock;
+	spinlock_t stats_lock;
+	spinlock_t work_lock;
+};
+
+static inline u32 t3_read_reg(struct adapter *adapter, u32 reg_addr)
+{
+	u32 val = readl(adapter->regs + reg_addr);
+
+	CH_DBG(adapter, MMIO, "read register 0x%x value 0x%x\n", reg_addr, val);
+	return val;
+}
+
+static inline void t3_write_reg(struct adapter *adapter, u32 reg_addr, u32 val)
+{
+	CH_DBG(adapter, MMIO, "setting register 0x%x to 0x%x\n", reg_addr, val);
+	writel(val, adapter->regs + reg_addr);
+}
+
+static inline struct port_info *adap2pinfo(struct adapter *adap, int idx)
+{
+	return netdev_priv(adap->port[idx]);
+}
+
+/*
+ * We use the spare atalk_ptr to map a net device to its SGE queue set.
+ * This is a macro so it can be used as l-value.
+ */
+#define dev2qset(netdev) ((netdev)->atalk_ptr)
+
+#define OFFLOAD_DEVMAP_BIT 15
+
+#define tdev2adap(d) container_of(d, struct adapter, tdev)
+
+static inline int offload_running(struct adapter *adapter)
+{
+	return test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map);
+}
+
+int t3_offload_tx(struct t3cdev *tdev, struct sk_buff *skb);
+
+void t3_os_ext_intr_handler(struct adapter *adapter);
+void t3_os_link_changed(struct adapter *adapter, int port_id, int link_status,
+			int speed, int duplex, int fc);
+
+void t3_sge_start(struct adapter *adap);
+void t3_sge_stop(struct adapter *adap);
+void t3_free_sge_resources(struct adapter *adap);
+void t3_sge_err_intr_handler(struct adapter *adapter);
+intr_handler_t t3_intr_handler(struct adapter *adap, int polling);
+int t3_eth_xmit(struct sk_buff *skb, struct net_device *dev);
+void t3_update_qset_coalesce(struct sge_qset *qs, const struct qset_params *p);
+int t3_sge_alloc_qset(struct adapter *adapter, unsigned int id, int nports,
+		      int irq_vec_idx, const struct qset_params *p,
+		      int ntxq, struct net_device *netdev);
+int t3_get_desc(const struct sge_qset *qs, unsigned int qnum, unsigned int idx,
+		unsigned char *data);
+irqreturn_t t3_sge_intr_msix(int irq, void *cookie);
+
+#endif				/* __T3_ADAPTER_H__ */
diff --git a/drivers/net/cxgb3/common.h b/drivers/net/cxgb3/common.h
new file mode 100755
index 0000000..60a979b
--- /dev/null
+++ b/drivers/net/cxgb3/common.h
@@ -0,0 +1,709 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver.
+ *
+ * Copyright (C) 2005-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+#ifndef __CHELSIO_COMMON_H
+#define __CHELSIO_COMMON_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include "version.h"
+
+#define CH_ERR(adap, fmt, ...)   dev_err(&adap->pdev->dev, fmt, ## __VA_ARGS__)
+#define CH_WARN(adap, fmt, ...)  dev_warn(&adap->pdev->dev, fmt, ## __VA_ARGS__)
+#define CH_ALERT(adap, fmt, ...) \
+	dev_printk(KERN_ALERT, &adap->pdev->dev, fmt, ## __VA_ARGS__)
+
+/*
+ * More powerful macro that selectively prints messages based on msg_enable.
+ * For info and debugging messages.
+ */
+#define CH_MSG(adapter, level, category, fmt, ...) do { \
+	if ((adapter)->msg_enable & NETIF_MSG_##category) \
+		dev_printk(KERN_##level, &adapter->pdev->dev, fmt, \
+			   ## __VA_ARGS__); \
+} while (0)
+
+#ifdef DEBUG
+# define CH_DBG(adapter, category, fmt, ...) \
+	CH_MSG(adapter, DEBUG, category, fmt, ## __VA_ARGS__)
+#else
+# define CH_DBG(adapter, category, fmt, ...)
+#endif
+
+/* Additional NETIF_MSG_* categories */
+#define NETIF_MSG_MMIO 0x8000000
+
+struct t3_rx_mode {
+	struct net_device *dev;
+	struct dev_mc_list *mclist;
+	unsigned int idx;
+};
+
+static inline void init_rx_mode(struct t3_rx_mode *p, struct net_device *dev,
+				struct dev_mc_list *mclist)
+{
+	p->dev = dev;
+	p->mclist = mclist;
+	p->idx = 0;
+}
+
+static inline u8 *t3_get_next_mcaddr(struct t3_rx_mode *rm)
+{
+	u8 *addr = NULL;
+
+	if (rm->mclist && rm->idx < rm->dev->mc_count) {
+		addr = rm->mclist->dmi_addr;
+		rm->mclist = rm->mclist->next;
+		rm->idx++;
+	}
+	return addr;
+}
+
+enum {
+	MAX_NPORTS = 2,		/* max # of ports */
+	MAX_FRAME_SIZE = 10240,	/* max MAC frame size, including header + FCS */
+	EEPROMSIZE = 8192,	/* Serial EEPROM size */
+	RSS_TABLE_SIZE = 64,	/* size of RSS lookup and mapping tables */
+	TCB_SIZE = 128,		/* TCB size */
+	NMTUS = 16,		/* size of MTU table */
+	NCCTRL_WIN = 32,	/* # of congestion control windows */
+};
+
+#define MAX_RX_COALESCING_LEN 16224U
+
+enum {
+	PAUSE_RX = 1 << 0,
+	PAUSE_TX = 1 << 1,
+	PAUSE_AUTONEG = 1 << 2
+};
+
+enum {
+	SUPPORTED_OFFLOAD = 1 << 24,
+	SUPPORTED_IRQ = 1 << 25
+};
+
+enum {				/* adapter interrupt-maintained statistics */
+	STAT_ULP_CH0_PBL_OOB,
+	STAT_ULP_CH1_PBL_OOB,
+	STAT_PCI_CORR_ECC,
+
+	IRQ_NUM_STATS		/* keep last */
+};
+
+enum {
+	SGE_QSETS = 8,		/* # of SGE Tx/Rx/RspQ sets */
+	SGE_RXQ_PER_SET = 2,	/* # of Rx queues per set */
+	SGE_TXQ_PER_SET = 3	/* # of Tx queues per set */
+};
+
+enum sge_context_type {		/* SGE egress context types */
+	SGE_CNTXT_RDMA = 0,
+	SGE_CNTXT_ETH = 2,
+	SGE_CNTXT_OFLD = 4,
+	SGE_CNTXT_CTRL = 5
+};
+
+enum {
+	AN_PKT_SIZE = 32,	/* async notification packet size */
+	IMMED_PKT_SIZE = 48	/* packet size for immediate data */
+};
+
+struct sg_ent {			/* SGE scatter/gather entry */
+	u32 len[2];
+	u64 addr[2];
+};
+
+#ifndef SGE_NUM_GENBITS
+/* Must be 1 or 2 */
+# define SGE_NUM_GENBITS 2
+#endif
+
+#define TX_DESC_FLITS 16U
+#define WR_FLITS (TX_DESC_FLITS + 1 - SGE_NUM_GENBITS)
+
+struct cphy;
+struct adapter;
+
+struct mdio_ops {
+	int (*read)(struct adapter *adapter, int phy_addr, int mmd_addr,
+		    int reg_addr, unsigned int *val);
+	int (*write)(struct adapter *adapter, int phy_addr, int mmd_addr,
+		     int reg_addr, unsigned int val);
+};
+
+struct adapter_info {
+	unsigned char nports;	/* # of ports */
+	unsigned char phy_base_addr;	/* MDIO PHY base address */
+	unsigned char mdien;
+	unsigned char mdiinv;
+	unsigned int gpio_out;	/* GPIO output settings */
+	unsigned int gpio_intr;	/* GPIO IRQ enable mask */
+	unsigned long caps;	/* adapter capabilities */
+	const struct mdio_ops *mdio_ops;	/* MDIO operations */
+	const char *desc;	/* product description */
+};
+
+struct port_type_info {
+	void (*phy_prep)(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *ops);
+	unsigned int caps;
+	const char *desc;
+};
+
+struct mc5_stats {
+	unsigned long parity_err;
+	unsigned long active_rgn_full;
+	unsigned long nfa_srch_err;
+	unsigned long unknown_cmd;
+	unsigned long reqq_parity_err;
+	unsigned long dispq_parity_err;
+	unsigned long del_act_empty;
+};
+
+struct mc7_stats {
+	unsigned long corr_err;
+	unsigned long uncorr_err;
+	unsigned long parity_err;
+	unsigned long addr_err;
+};
+
+struct mac_stats {
+	u64 tx_octets;		/* total # of octets in good frames */
+	u64 tx_octets_bad;	/* total # of octets in error frames */
+	u64 tx_frames;		/* all good frames */
+	u64 tx_mcast_frames;	/* good multicast frames */
+	u64 tx_bcast_frames;	/* good broadcast frames */
+	u64 tx_pause;		/* # of transmitted pause frames */
+	u64 tx_deferred;	/* frames with deferred transmissions */
+	u64 tx_late_collisions;	/* # of late collisions */
+	u64 tx_total_collisions;	/* # of total collisions */
+	u64 tx_excess_collisions;	/* frame errors from excessive collissions */
+	u64 tx_underrun;	/* # of Tx FIFO underruns */
+	u64 tx_len_errs;	/* # of Tx length errors */
+	u64 tx_mac_internal_errs;	/* # of internal MAC errors on Tx */
+	u64 tx_excess_deferral;	/* # of frames with excessive deferral */
+	u64 tx_fcs_errs;	/* # of frames with bad FCS */
+
+	u64 tx_frames_64;	/* # of Tx frames in a particular range */
+	u64 tx_frames_65_127;
+	u64 tx_frames_128_255;
+	u64 tx_frames_256_511;
+	u64 tx_frames_512_1023;
+	u64 tx_frames_1024_1518;
+	u64 tx_frames_1519_max;
+
+	u64 rx_octets;		/* total # of octets in good frames */
+	u64 rx_octets_bad;	/* total # of octets in error frames */
+	u64 rx_frames;		/* all good frames */
+	u64 rx_mcast_frames;	/* good multicast frames */
+	u64 rx_bcast_frames;	/* good broadcast frames */
+	u64 rx_pause;		/* # of received pause frames */
+	u64 rx_fcs_errs;	/* # of received frames with bad FCS */
+	u64 rx_align_errs;	/* alignment errors */
+	u64 rx_symbol_errs;	/* symbol errors */
+	u64 rx_data_errs;	/* data errors */
+	u64 rx_sequence_errs;	/* sequence errors */
+	u64 rx_runt;		/* # of runt frames */
+	u64 rx_jabber;		/* # of jabber frames */
+	u64 rx_short;		/* # of short frames */
+	u64 rx_too_long;	/* # of oversized frames */
+	u64 rx_mac_internal_errs;	/* # of internal MAC errors on Rx */
+
+	u64 rx_frames_64;	/* # of Rx frames in a particular range */
+	u64 rx_frames_65_127;
+	u64 rx_frames_128_255;
+	u64 rx_frames_256_511;
+	u64 rx_frames_512_1023;
+	u64 rx_frames_1024_1518;
+	u64 rx_frames_1519_max;
+
+	u64 rx_cong_drops;	/* # of Rx drops due to SGE congestion */
+
+	unsigned long tx_fifo_parity_err;
+	unsigned long rx_fifo_parity_err;
+	unsigned long tx_fifo_urun;
+	unsigned long rx_fifo_ovfl;
+	unsigned long serdes_signal_loss;
+	unsigned long xaui_pcs_ctc_err;
+	unsigned long xaui_pcs_align_change;
+};
+
+struct tp_mib_stats {
+	u32 ipInReceive_hi;
+	u32 ipInReceive_lo;
+	u32 ipInHdrErrors_hi;
+	u32 ipInHdrErrors_lo;
+	u32 ipInAddrErrors_hi;
+	u32 ipInAddrErrors_lo;
+	u32 ipInUnknownProtos_hi;
+	u32 ipInUnknownProtos_lo;
+	u32 ipInDiscards_hi;
+	u32 ipInDiscards_lo;
+	u32 ipInDelivers_hi;
+	u32 ipInDelivers_lo;
+	u32 ipOutRequests_hi;
+	u32 ipOutRequests_lo;
+	u32 ipOutDiscards_hi;
+	u32 ipOutDiscards_lo;
+	u32 ipOutNoRoutes_hi;
+	u32 ipOutNoRoutes_lo;
+	u32 ipReasmTimeout;
+	u32 ipReasmReqds;
+	u32 ipReasmOKs;
+	u32 ipReasmFails;
+
+	u32 reserved[8];
+
+	u32 tcpActiveOpens;
+	u32 tcpPassiveOpens;
+	u32 tcpAttemptFails;
+	u32 tcpEstabResets;
+	u32 tcpOutRsts;
+	u32 tcpCurrEstab;
+	u32 tcpInSegs_hi;
+	u32 tcpInSegs_lo;
+	u32 tcpOutSegs_hi;
+	u32 tcpOutSegs_lo;
+	u32 tcpRetransSeg_hi;
+	u32 tcpRetransSeg_lo;
+	u32 tcpInErrs_hi;
+	u32 tcpInErrs_lo;
+	u32 tcpRtoMin;
+	u32 tcpRtoMax;
+};
+
+struct tp_params {
+	unsigned int nchan;	/* # of channels */
+	unsigned int pmrx_size;	/* total PMRX capacity */
+	unsigned int pmtx_size;	/* total PMTX capacity */
+	unsigned int cm_size;	/* total CM capacity */
+	unsigned int chan_rx_size;	/* per channel Rx size */
+	unsigned int chan_tx_size;	/* per channel Tx size */
+	unsigned int rx_pg_size;	/* Rx page size */
+	unsigned int tx_pg_size;	/* Tx page size */
+	unsigned int rx_num_pgs;	/* # of Rx pages */
+	unsigned int tx_num_pgs;	/* # of Tx pages */
+	unsigned int ntimer_qs;	/* # of timer queues */
+};
+
+struct qset_params {		/* SGE queue set parameters */
+	unsigned int polling;	/* polling/interrupt service for rspq */
+	unsigned int coalesce_usecs;	/* irq coalescing timer */
+	unsigned int rspq_size;	/* # of entries in response queue */
+	unsigned int fl_size;	/* # of entries in regular free list */
+	unsigned int jumbo_size;	/* # of entries in jumbo free list */
+	unsigned int txq_size[SGE_TXQ_PER_SET];	/* Tx queue sizes */
+	unsigned int cong_thres;	/* FL congestion threshold */
+};
+
+struct sge_params {
+	unsigned int max_pkt_size;	/* max offload pkt size */
+	struct qset_params qset[SGE_QSETS];
+};
+
+struct mc5_params {
+	unsigned int mode;	/* selects MC5 width */
+	unsigned int nservers;	/* size of server region */
+	unsigned int nfilters;	/* size of filter region */
+	unsigned int nroutes;	/* size of routing region */
+};
+
+/* Default MC5 region sizes */
+enum {
+	DEFAULT_NSERVERS = 512,
+	DEFAULT_NFILTERS = 128
+};
+
+/* MC5 modes, these must be non-0 */
+enum {
+	MC5_MODE_144_BIT = 1,
+	MC5_MODE_72_BIT = 2
+};
+
+struct vpd_params {
+	unsigned int cclk;
+	unsigned int mclk;
+	unsigned int uclk;
+	unsigned int mdc;
+	unsigned int mem_timing;
+	u8 eth_base[6];
+	u8 port_type[MAX_NPORTS];
+	unsigned short xauicfg[2];
+};
+
+struct pci_params {
+	unsigned int vpd_cap_addr;
+	unsigned int pcie_cap_addr;
+	unsigned short speed;
+	unsigned char width;
+	unsigned char variant;
+};
+
+enum {
+	PCI_VARIANT_PCI,
+	PCI_VARIANT_PCIX_MODE1_PARITY,
+	PCI_VARIANT_PCIX_MODE1_ECC,
+	PCI_VARIANT_PCIX_266_MODE2,
+	PCI_VARIANT_PCIE
+};
+
+struct adapter_params {
+	struct sge_params sge;
+	struct mc5_params mc5;
+	struct tp_params tp;
+	struct vpd_params vpd;
+	struct pci_params pci;
+
+	const struct adapter_info *info;
+
+	unsigned short mtus[NMTUS];
+	unsigned short a_wnd[NCCTRL_WIN];
+	unsigned short b_wnd[NCCTRL_WIN];
+
+	unsigned int nports;	/* # of ethernet ports */
+	unsigned int stats_update_period;	/* MAC stats accumulation period */
+	unsigned int linkpoll_period;	/* link poll period in 0.1s */
+	unsigned int rev;	/* chip revision */
+};
+
+struct trace_params {
+	u32 sip;
+	u32 sip_mask;
+	u32 dip;
+	u32 dip_mask;
+	u16 sport;
+	u16 sport_mask;
+	u16 dport;
+	u16 dport_mask;
+	u32 vlan:12;
+	u32 vlan_mask:12;
+	u32 intf:4;
+	u32 intf_mask:4;
+	u8 proto;
+	u8 proto_mask;
+};
+
+struct link_config {
+	unsigned int supported;	/* link capabilities */
+	unsigned int advertising;	/* advertised capabilities */
+	unsigned short requested_speed;	/* speed user has requested */
+	unsigned short speed;	/* actual link speed */
+	unsigned char requested_duplex;	/* duplex user has requested */
+	unsigned char duplex;	/* actual link duplex */
+	unsigned char requested_fc;	/* flow control user has requested */
+	unsigned char fc;	/* actual link flow control */
+	unsigned char autoneg;	/* autonegotiating? */
+	unsigned int link_ok;	/* link up? */
+};
+
+#define SPEED_INVALID   0xffff
+#define DUPLEX_INVALID  0xff
+
+struct mc5 {
+	struct adapter *adapter;
+	unsigned int tcam_size;
+	unsigned char part_type;
+	unsigned char parity_enabled;
+	unsigned char mode;
+	struct mc5_stats stats;
+};
+
+static inline unsigned int t3_mc5_size(const struct mc5 *p)
+{
+	return p->tcam_size;
+}
+
+struct mc7 {
+	struct adapter *adapter;	/* backpointer to adapter */
+	unsigned int size;	/* memory size in bytes */
+	unsigned int width;	/* MC7 interface width */
+	unsigned int offset;	/* register address offset for MC7 instance */
+	const char *name;	/* name of MC7 instance */
+	struct mc7_stats stats;	/* MC7 statistics */
+};
+
+static inline unsigned int t3_mc7_size(const struct mc7 *p)
+{
+	return p->size;
+}
+
+struct cmac {
+	struct adapter *adapter;
+	unsigned int offset;
+	unsigned int nucast;	/* # of address filters for unicast MACs */
+	struct mac_stats stats;
+};
+
+enum {
+	MAC_DIRECTION_RX = 1,
+	MAC_DIRECTION_TX = 2,
+	MAC_RXFIFO_SIZE = 32768
+};
+
+/* IEEE 802.3ae specified MDIO devices */
+enum {
+	MDIO_DEV_PMA_PMD = 1,
+	MDIO_DEV_WIS = 2,
+	MDIO_DEV_PCS = 3,
+	MDIO_DEV_XGXS = 4
+};
+
+/* PHY loopback direction */
+enum {
+	PHY_LOOPBACK_TX = 1,
+	PHY_LOOPBACK_RX = 2
+};
+
+/* PHY interrupt types */
+enum {
+	cphy_cause_link_change = 1,
+	cphy_cause_fifo_error = 2
+};
+
+/* PHY operations */
+struct cphy_ops {
+	void (*destroy)(struct cphy *phy);
+	int (*reset)(struct cphy *phy, int wait);
+
+	int (*intr_enable)(struct cphy *phy);
+	int (*intr_disable)(struct cphy *phy);
+	int (*intr_clear)(struct cphy *phy);
+	int (*intr_handler)(struct cphy *phy);
+
+	int (*autoneg_enable)(struct cphy *phy);
+	int (*autoneg_restart)(struct cphy *phy);
+
+	int (*advertise)(struct cphy *phy, unsigned int advertise_map);
+	int (*set_loopback)(struct cphy *phy, int mmd, int dir, int enable);
+	int (*set_speed_duplex)(struct cphy *phy, int speed, int duplex);
+	int (*get_link_status)(struct cphy *phy, int *link_ok, int *speed,
+			       int *duplex, int *fc);
+	int (*power_down)(struct cphy *phy, int enable);
+};
+
+/* A PHY instance */
+struct cphy {
+	int addr;		/* PHY address */
+	struct adapter *adapter;	/* associated adapter */
+	unsigned long fifo_errors;	/* FIFO over/under-flows */
+	const struct cphy_ops *ops;	/* PHY operations */
+	int (*mdio_read)(struct adapter *adapter, int phy_addr, int mmd_addr,
+			 int reg_addr, unsigned int *val);
+	int (*mdio_write)(struct adapter *adapter, int phy_addr, int mmd_addr,
+			  int reg_addr, unsigned int val);
+};
+
+/* Convenience MDIO read/write wrappers */
+static inline int mdio_read(struct cphy *phy, int mmd, int reg,
+			    unsigned int *valp)
+{
+	return phy->mdio_read(phy->adapter, phy->addr, mmd, reg, valp);
+}
+
+static inline int mdio_write(struct cphy *phy, int mmd, int reg,
+			     unsigned int val)
+{
+	return phy->mdio_write(phy->adapter, phy->addr, mmd, reg, val);
+}
+
+/* Convenience initializer */
+static inline void cphy_init(struct cphy *phy, struct adapter *adapter,
+			     int phy_addr, struct cphy_ops *phy_ops,
+			     const struct mdio_ops *mdio_ops)
+{
+	phy->adapter = adapter;
+	phy->addr = phy_addr;
+	phy->ops = phy_ops;
+	if (mdio_ops) {
+		phy->mdio_read = mdio_ops->read;
+		phy->mdio_write = mdio_ops->write;
+	}
+}
+
+/* Accumulate MAC statistics every 180 seconds.  For 1G we multiply by 10. */
+#define MAC_STATS_ACCUM_SECS 180
+
+#define XGM_REG(reg_addr, idx) \
+	((reg_addr) + (idx) * (XGMAC0_1_BASE_ADDR - XGMAC0_0_BASE_ADDR))
+
+struct addr_val_pair {
+	unsigned int reg_addr;
+	unsigned int val;
+};
+
+#include "adapter.h"
+
+#ifndef PCI_VENDOR_ID_CHELSIO
+# define PCI_VENDOR_ID_CHELSIO 0x1425
+#endif
+
+#define for_each_port(adapter, iter) \
+	for (iter = 0; iter < (adapter)->params.nports; ++iter)
+
+#define adapter_info(adap) ((adap)->params.info)
+
+static inline int uses_xaui(const struct adapter *adap)
+{
+	return adapter_info(adap)->caps & SUPPORTED_AUI;
+}
+
+static inline int is_10G(const struct adapter *adap)
+{
+	return adapter_info(adap)->caps & SUPPORTED_10000baseT_Full;
+}
+
+static inline int is_offload(const struct adapter *adap)
+{
+	return adapter_info(adap)->caps & SUPPORTED_OFFLOAD;
+}
+
+static inline unsigned int core_ticks_per_usec(const struct adapter *adap)
+{
+	return adap->params.vpd.cclk / 1000;
+}
+
+static inline unsigned int is_pcie(const struct adapter *adap)
+{
+	return adap->params.pci.variant == PCI_VARIANT_PCIE;
+}
+
+void t3_set_reg_field(struct adapter *adap, unsigned int addr, u32 mask,
+		      u32 val);
+void t3_write_regs(struct adapter *adapter, const struct addr_val_pair *p,
+		   int n, unsigned int offset);
+int t3_wait_op_done_val(struct adapter *adapter, int reg, u32 mask,
+			int polarity, int attempts, int delay, u32 *valp);
+static inline int t3_wait_op_done(struct adapter *adapter, int reg, u32 mask,
+				  int polarity, int attempts, int delay)
+{
+	return t3_wait_op_done_val(adapter, reg, mask, polarity, attempts,
+				   delay, NULL);
+}
+int t3_mdio_change_bits(struct cphy *phy, int mmd, int reg, unsigned int clear,
+			unsigned int set);
+int t3_phy_reset(struct cphy *phy, int mmd, int wait);
+int t3_phy_advertise(struct cphy *phy, unsigned int advert);
+int t3_set_phy_speed_duplex(struct cphy *phy, int speed, int duplex);
+
+void t3_intr_enable(struct adapter *adapter);
+void t3_intr_disable(struct adapter *adapter);
+void t3_intr_clear(struct adapter *adapter);
+void t3_port_intr_enable(struct adapter *adapter, int idx);
+void t3_port_intr_disable(struct adapter *adapter, int idx);
+void t3_port_intr_clear(struct adapter *adapter, int idx);
+int t3_slow_intr_handler(struct adapter *adapter);
+int t3_phy_intr_handler(struct adapter *adapter);
+
+void t3_link_changed(struct adapter *adapter, int port_id);
+int t3_link_start(struct cphy *phy, struct cmac *mac, struct link_config *lc);
+const struct adapter_info *t3_get_adapter_info(unsigned int board_id);
+int t3_seeprom_read(struct adapter *adapter, u32 addr, u32 *data);
+int t3_seeprom_write(struct adapter *adapter, u32 addr, u32 data);
+int t3_seeprom_wp(struct adapter *adapter, int enable);
+int t3_read_flash(struct adapter *adapter, unsigned int addr,
+		  unsigned int nwords, u32 *data, int byte_oriented);
+int t3_load_fw(struct adapter *adapter, const u8 * fw_data, unsigned int size);
+int t3_get_fw_version(struct adapter *adapter, u32 *vers);
+int t3_check_fw_version(struct adapter *adapter);
+int t3_init_hw(struct adapter *adapter, u32 fw_params);
+void mac_prep(struct cmac *mac, struct adapter *adapter, int index);
+void early_hw_init(struct adapter *adapter, const struct adapter_info *ai);
+int t3_prep_adapter(struct adapter *adapter, const struct adapter_info *ai,
+		    int reset);
+void t3_led_ready(struct adapter *adapter);
+void t3_fatal_err(struct adapter *adapter);
+void t3_set_vlan_accel(struct adapter *adapter, unsigned int ports, int on);
+void t3_config_rss(struct adapter *adapter, unsigned int rss_config,
+		   const u8 * cpus, const u16 *rspq);
+int t3_read_rss(struct adapter *adapter, u8 * lkup, u16 *map);
+int t3_mps_set_active_ports(struct adapter *adap, unsigned int port_mask);
+int t3_cim_ctl_blk_read(struct adapter *adap, unsigned int addr,
+			unsigned int n, unsigned int *valp);
+int t3_mc7_bd_read(struct mc7 *mc7, unsigned int start, unsigned int n,
+		   u64 *buf);
+
+int t3_mac_reset(struct cmac *mac);
+void t3b_pcs_reset(struct cmac *mac);
+int t3_mac_enable(struct cmac *mac, int which);
+int t3_mac_disable(struct cmac *mac, int which);
+int t3_mac_set_mtu(struct cmac *mac, unsigned int mtu);
+int t3_mac_set_rx_mode(struct cmac *mac, struct t3_rx_mode *rm);
+int t3_mac_set_address(struct cmac *mac, unsigned int idx, u8 addr[6]);
+int t3_mac_set_num_ucast(struct cmac *mac, int n);
+const struct mac_stats *t3_mac_update_stats(struct cmac *mac);
+int t3_mac_set_speed_duplex_fc(struct cmac *mac, int speed, int duplex, int fc);
+
+void t3_mc5_prep(struct adapter *adapter, struct mc5 *mc5, int mode);
+int t3_mc5_init(struct mc5 *mc5, unsigned int nservers, unsigned int nfilters,
+		unsigned int nroutes);
+void t3_mc5_intr_handler(struct mc5 *mc5);
+int t3_read_mc5_range(const struct mc5 *mc5, unsigned int start, unsigned int n,
+		      u32 *buf);
+
+int t3_tp_set_coalescing_size(struct adapter *adap, unsigned int size, int psh);
+void t3_tp_set_max_rxsize(struct adapter *adap, unsigned int size);
+void t3_tp_set_offload_mode(struct adapter *adap, int enable);
+void t3_tp_get_mib_stats(struct adapter *adap, struct tp_mib_stats *tps);
+void t3_load_mtus(struct adapter *adap, unsigned short mtus[NMTUS],
+		  unsigned short alpha[NCCTRL_WIN],
+		  unsigned short beta[NCCTRL_WIN], unsigned short mtu_cap);
+void t3_read_hw_mtus(struct adapter *adap, unsigned short mtus[NMTUS]);
+void t3_get_cong_cntl_tab(struct adapter *adap,
+			  unsigned short incr[NMTUS][NCCTRL_WIN]);
+void t3_config_trace_filter(struct adapter *adapter,
+			    const struct trace_params *tp, int filter_index,
+			    int invert, int enable);
+int t3_config_sched(struct adapter *adap, unsigned int kbps, int sched);
+
+void t3_sge_prep(struct adapter *adap, struct sge_params *p);
+void t3_sge_init(struct adapter *adap, struct sge_params *p);
+int t3_sge_init_ecntxt(struct adapter *adapter, unsigned int id, int gts_enable,
+		       enum sge_context_type type, int respq, u64 base_addr,
+		       unsigned int size, unsigned int token, int gen,
+		       unsigned int cidx);
+int t3_sge_init_flcntxt(struct adapter *adapter, unsigned int id,
+			int gts_enable, u64 base_addr, unsigned int size,
+			unsigned int esize, unsigned int cong_thres, int gen,
+			unsigned int cidx);
+int t3_sge_init_rspcntxt(struct adapter *adapter, unsigned int id,
+			 int irq_vec_idx, u64 base_addr, unsigned int size,
+			 unsigned int fl_thres, int gen, unsigned int cidx);
+int t3_sge_init_cqcntxt(struct adapter *adapter, unsigned int id, u64 base_addr,
+			unsigned int size, int rspq, int ovfl_mode,
+			unsigned int credits, unsigned int credit_thres);
+int t3_sge_enable_ecntxt(struct adapter *adapter, unsigned int id, int enable);
+int t3_sge_disable_fl(struct adapter *adapter, unsigned int id);
+int t3_sge_disable_rspcntxt(struct adapter *adapter, unsigned int id);
+int t3_sge_disable_cqcntxt(struct adapter *adapter, unsigned int id);
+int t3_sge_read_ecntxt(struct adapter *adapter, unsigned int id, u32 data[4]);
+int t3_sge_read_fl(struct adapter *adapter, unsigned int id, u32 data[4]);
+int t3_sge_read_cq(struct adapter *adapter, unsigned int id, u32 data[4]);
+int t3_sge_read_rspq(struct adapter *adapter, unsigned int id, u32 data[4]);
+int t3_sge_cqcntxt_op(struct adapter *adapter, unsigned int id, unsigned int op,
+		      unsigned int credits);
+
+void t3_vsc8211_phy_prep(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *mdio_ops);
+void t3_ael1002_phy_prep(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *mdio_ops);
+void t3_ael1006_phy_prep(struct cphy *phy, struct adapter *adapter,
+			 int phy_addr, const struct mdio_ops *mdio_ops);
+void t3_qt2045_phy_prep(struct cphy *phy, struct adapter *adapter, int phy_addr,
+			const struct mdio_ops *mdio_ops);
+void t3_xaui_direct_phy_prep(struct cphy *phy, struct adapter *adapter,
+			     int phy_addr, const struct mdio_ops *mdio_ops);
+#endif				/* __CHELSIO_COMMON_H */
diff --git a/drivers/net/cxgb3/cxgb3_ioctl.h b/drivers/net/cxgb3/cxgb3_ioctl.h
new file mode 100755
index 0000000..1ee77b2
--- /dev/null
+++ b/drivers/net/cxgb3/cxgb3_ioctl.h
@@ -0,0 +1,165 @@
+/*
+ * This file is part of the Chelsio T3 Ethernet driver for Linux.
+ *
+ * Copyright (C) 2003-2006 Chelsio Communications.  All rights reserved.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the LICENSE file included in this
+ * release for licensing terms and conditions.
+ */
+
+#ifndef __CHIOCTL_H__
+#define __CHIOCTL_H__
+
+/*
+ * Ioctl commands specific to this driver.
+ */
+enum {
+	CHELSIO_SETREG = 1024,
+	CHELSIO_GETREG,
+	CHELSIO_SETTPI,
+	CHELSIO_GETTPI,
+	CHELSIO_GETMTUTAB,
+	CHELSIO_SETMTUTAB,
+	CHELSIO_GETMTU,
+	CHELSIO_SET_PM,
+	CHELSIO_GET_PM,
+	CHELSIO_GET_TCAM,
+	CHELSIO_SET_TCAM,
+	CHELSIO_GET_TCB,
+	CHELSIO_GET_MEM,
+	CHELSIO_LOAD_FW,
+	CHELSIO_GET_PROTO,
+	CHELSIO_SET_PROTO,
+	CHELSIO_SET_TRACE_FILTER,
+	CHELSIO_SET_QSET_PARAMS,
+	CHELSIO_GET_QSET_PARAMS,
+	CHELSIO_SET_QSET_NUM,
+	CHELSIO_GET_QSET_NUM,
+	CHELSIO_SET_PKTSCHED,
+};
+
+struct ch_reg {
+	uint32_t cmd;
+	uint32_t addr;
+	uint32_t val;
+};
+
+struct ch_cntxt {
+	uint32_t cmd;
+	uint32_t cntxt_type;
+	uint32_t cntxt_id;
+	uint32_t data[4];
+};
+
+/* context types */
+enum { CNTXT_TYPE_EGRESS, CNTXT_TYPE_FL, CNTXT_TYPE_RSP, CNTXT_TYPE_CQ };
+
+struct ch_desc {
+	uint32_t cmd;
+	uint32_t queue_num;
+	uint32_t idx;
+	uint32_t size;
+	uint8_t data[128];
+};
+
+struct ch_mem_range {
+	uint32_t cmd;
+	uint32_t mem_id;
+	uint32_t addr;
+	uint32_t len;
+	uint32_t version;
+	uint8_t buf[0];
+};
+
+struct ch_qset_params {
+	uint32_t cmd;
+	uint32_t qset_idx;
+	int32_t txq_size[3];
+	int32_t rspq_size;
+	int32_t fl_size[2];
+	int32_t intr_lat;
+	int32_t polling;
+	int32_t cong_thres;
+};
+
+struct ch_pktsched_params {
+	uint32_t cmd;
+	uint8_t sched;
+	uint8_t idx;
+	uint8_t min;
+	uint8_t max;
+	uint8_t binding;
+};
+
+#ifndef TCB_SIZE
+# define TCB_SIZE   128
+#endif
+
+/* TCB size in 32-bit words */
+#define TCB_WORDS (TCB_SIZE / 4)
+
+enum { MEM_CM, MEM_PMRX, MEM_PMTX };	/* ch_mem_range.mem_id values */
+
+struct ch_mtus {
+	uint32_t cmd;
+	uint32_t nmtus;
+	uint16_t mtus[NMTUS];
+};
+
+struct ch_pm {
+	uint32_t cmd;
+	uint32_t tx_pg_sz;
+	uint32_t tx_num_pg;
+	uint32_t rx_pg_sz;
+	uint32_t rx_num_pg;
+	uint32_t pm_total;
+};
+
+struct ch_tcam {
+	uint32_t cmd;
+	uint32_t tcam_size;
+	uint32_t nservers;
+	uint32_t nroutes;
+	uint32_t nfilters;
+};
+
+struct ch_tcb {
+	uint32_t cmd;
+	uint32_t tcb_index;
+	uint32_t tcb_data[TCB_WORDS];
+};
+
+struct ch_tcam_word {
+	uint32_t cmd;
+	uint32_t addr;
+	uint32_t buf[3];
+};
+
+struct ch_trace {
+	uint32_t cmd;
+	uint32_t sip;
+	uint32_t sip_mask;
+	uint32_t dip;
+	uint32_t dip_mask;
+	uint16_t sport;
+	uint16_t sport_mask;
+	uint16_t dport;
+	uint16_t dport_mask;
+	uint32_t vlan:12;
+	uint32_t vlan_mask:12;
+	uint32_t intf:4;
+	uint32_t intf_mask:4;
+	uint8_t proto;
+	uint8_t proto_mask;
+	uint8_t invert_match:1;
+	uint8_t config_tx:1;
+	uint8_t config_rx:1;
+	uint8_t trace_tx:1;
+	uint8_t trace_rx:1;
+};
+
+#define SIOCCHIOCTL SIOCDEVPRIVATE
+
+#endif
diff --git a/drivers/net/cxgb3/firmware_exports.h b/drivers/net/cxgb3/firmware_exports.h
new file mode 100755
index 0000000..3565f48
--- /dev/null
+++ b/drivers/net/cxgb3/firmware_exports.h
@@ -0,0 +1,144 @@
+/* 
+ * ----------------------------------------------------------------------------
+ * >>>>>>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
+ * ----------------------------------------------------------------------------
+ * Copyright 2004 (C) Chelsio Communications, Inc. (Chelsio)
+ *
+ * Chelsio Communications, Inc. owns the sole copyright to this software.
+ * You may not make a copy, you may not derive works herefrom, and you may
+ * not distribute this work to others. Other restrictions of rights may apply
+ * as well. This is unpublished, confidential information. All rights reserved.
+ * This software contains confidential information and trade secrets of Chelsio
+ * Communications, Inc. Use, disclosure, or reproduction is prohibited without
+ * the prior express written permission of Chelsio Communications, Inc.
+ * ----------------------------------------------------------------------------
+ * >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Warranty <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
+ * ----------------------------------------------------------------------------
+ * CHELSIO MAKES NO WARRANTY OF ANY KIND WITH REGARD TO THE USE OF THIS
+ * SOFTWARE, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
+ * ----------------------------------------------------------------------------
+ *
+ * This is the firmware_exports.h header file, firmware interface defines.
+ *
+ * Written January 2005 by felix marti (felix@chelsio.com)
+ */
+#ifndef _FIRMWARE_EXPORTS_H_
+#define _FIRMWARE_EXPORTS_H_
+
+/* WR OPCODES supported by the firmware.
+ */
+#define	FW_WROPCODE_FORWARD			0x01
+#define FW_WROPCODE_BYPASS			0x05
+
+#define FW_WROPCODE_TUNNEL_TX_PKT		0x03
+
+#define FW_WROPOCDE_ULPTX_DATA_SGL		0x00
+#define FW_WROPCODE_ULPTX_MEM_READ		0x02
+#define FW_WROPCODE_ULPTX_PKT			0x04
+#define FW_WROPCODE_ULPTX_INVALIDATE		0x06
+
+#define FW_WROPCODE_TUNNEL_RX_PKT		0x07
+
+#define FW_WROPCODE_OFLD_GETTCB_RPL		0x08
+#define FW_WROPCODE_OFLD_CLOSE_CON		0x09
+#define FW_WROPCODE_OFLD_TP_ABORT_CON_REQ	0x0A
+#define FW_WROPCODE_OFLD_HOST_ABORT_CON_RPL	0x0F
+#define FW_WROPCODE_OFLD_HOST_ABORT_CON_REQ	0x0B
+#define FW_WROPCODE_OFLD_TP_ABORT_CON_RPL	0x0C
+#define FW_WROPCODE_OFLD_TX_DATA		0x0D
+#define FW_WROPCODE_OFLD_TX_DATA_ACK		0x0E
+
+#define FW_WROPCODE_RI_RDMA_INIT		0x10
+#define FW_WROPCODE_RI_RDMA_WRITE		0x11
+#define FW_WROPCODE_RI_RDMA_READ_REQ		0x12
+#define FW_WROPCODE_RI_RDMA_READ_RESP		0x13
+#define FW_WROPCODE_RI_SEND			0x14
+#define FW_WROPCODE_RI_TERMINATE		0x15
+#define FW_WROPCODE_RI_RDMA_READ		0x16
+#define FW_WROPCODE_RI_RECEIVE			0x17
+#define FW_WROPCODE_RI_BIND_MW			0x18
+#define FW_WROPCODE_RI_FASTREGISTER_MR		0x19
+#define FW_WROPCODE_RI_LOCAL_INV		0x1A
+#define FW_WROPCODE_RI_MODIFY_QP		0x1B
+#define FW_WROPCODE_RI_BYPASS			0x1C
+
+#define FW_WROPOCDE_RSVD			0x1E
+
+#define FW_WROPCODE_SGE_EGRESSCONTEXT_RR	0x1F
+
+#define FW_WROPCODE_MNGT			0x1D
+#define FW_MNGTOPCODE_PKTSCHED_SET		0x00
+
+/* Maximum size of a WR sent from the host, limited by the SGE. 
+ *
+ * Note: WR coming from ULP or TP are only limited by CIM. 
+ */
+#define FW_WR_SIZE			128
+
+/* Maximum number of outstanding WRs sent from the host. Value must be
+ * programmed in the CTRL/TUNNEL/QP SGE Egress Context and used by 
+ * offload modules to limit the number of WRs per connection.
+ */
+#define FW_T3_WR_NUM			16
+#define FW_N3_WR_NUM			7
+
+#ifndef N3
+# define FW_WR_NUM			FW_T3_WR_NUM
+#else
+# define FW_WR_NUM			FW_N3_WR_NUM
+#endif
+
+/* FW_TUNNEL_NUM corresponds to the number of supported TUNNEL Queues. These
+ * queues must start at SGE Egress Context FW_TUNNEL_SGEEC_START and must
+ * start at 'TID' (or 'uP Token') FW_TUNNEL_TID_START.
+ *
+ * Ingress Traffic (e.g. DMA completion credit)  for TUNNEL Queue[i] is sent 
+ * to RESP Queue[i].
+ */
+#define FW_TUNNEL_NUM			8
+#define FW_TUNNEL_SGEEC_START		8
+#define FW_TUNNEL_TID_START		65544
+
+/* FW_CTRL_NUM corresponds to the number of supported CTRL Queues. These queues
+ * must start at SGE Egress Context FW_CTRL_SGEEC_START and must start at 'TID'
+ * (or 'uP Token') FW_CTRL_TID_START.
+ *
+ * Ingress Traffic for CTRL Queue[i] is sent to RESP Queue[i].
+ */
+#define FW_CTRL_NUM			8
+#define FW_CTRL_SGEEC_START		65528
+#define FW_CTRL_TID_START		65536
+
+/* FW_OFLD_NUM corresponds to the number of supported OFFLOAD Queues. These 
+ * queues must start at SGE Egress Context FW_OFLD_SGEEC_START. 
+ * 
+ * Note: the 'uP Token' in the SGE Egress Context fields is irrelevant for 
+ * OFFLOAD Queues, as the host is responsible for providing the correct TID in
+ * every WR.
+ *
+ * Ingress Trafffic for OFFLOAD Queue[i] is sent to RESP Queue[i].
+ */
+#define FW_OFLD_NUM			8
+#define FW_OFLD_SGEEC_START		0
+
+/*
+ * 
+ */
+#define FW_RI_NUM			1
+#define FW_RI_SGEEC_START		65527
+#define FW_RI_TID_START			65552
+
+/*
+ * The RX_PKT_TID 
+ */
+#define FW_RX_PKT_NUM			1
+#define FW_RX_PKT_TID_START		65553
+
+/* FW_WRC_NUM corresponds to the number of Work Request Context that supported
+ * by the firmware.
+ */
+#define FW_WRC_NUM			\
+    (65536 + FW_TUNNEL_NUM + FW_CTRL_NUM + FW_RI_NUM + FW_RX_PKT_NUM)
+
+#endif				/* _FIRMWARE_EXPORTS_H_ */
