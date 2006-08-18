Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWHRMOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWHRMOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWHRMOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:14:30 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:51086 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030334AbWHRMO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:14:28 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 5/7] ehea: main header files
Date: Fri, 18 Aug 2006 13:34:57 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608181334.57701.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/ehea/ehea.h    |  442 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ehea/ehea_hw.h |  292 +++++++++++++++++++++++++++++
 2 files changed, 734 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea.h	2006-08-18 00:01:02.926368649 -0700
@@ -0,0 +1,442 @@
+/*
+ *  linux/drivers/net/ehea/ehea.h
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __EHEA_H__
+#define __EHEA_H__
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/kthread.h>
+#include <linux/ethtool.h>
+#include <linux/if_vlan.h>
+#include <asm/ibmebus.h>
+#include <asm/of_device.h>
+#include <asm/abs_addr.h>
+#include <asm/semaphore.h>
+#include <asm/current.h>
+#include <asm/io.h>
+
+#define DRV_NAME	"ehea"
+#define DRV_VERSION	"EHEA_0018"
+
+#define EHEA_MSG_DEFAULT (NETIF_MSG_LINK)
+
+#define EHEA_NUM_TX_QP 1
+
+#ifdef EHEA_SMALL_QUEUES
+#define EHEA_MAX_CQE_COUNT      1020
+#define EHEA_MAX_ENTRIES_SQ     1020
+#define EHEA_MAX_ENTRIES_RQ1    4080
+#define EHEA_MAX_ENTRIES_RQ2    1020
+#define EHEA_MAX_ENTRIES_RQ3    1020
+#define EHEA_SWQE_REFILL_TH      100
+#else
+#define EHEA_MAX_CQE_COUNT     32000
+#define EHEA_MAX_ENTRIES_SQ    16000
+#define EHEA_MAX_ENTRIES_RQ1   32080
+#define EHEA_MAX_ENTRIES_RQ2    4020
+#define EHEA_MAX_ENTRIES_RQ3    4020
+#define EHEA_SWQE_REFILL_TH     1000
+#endif
+
+#define EHEA_MAX_ENTRIES_EQ 20
+
+#define EHEA_SG_SQ  2
+#define EHEA_SG_RQ1 1
+#define EHEA_SG_RQ2 0
+#define EHEA_SG_RQ3 0
+
+#define EHEA_MAX_PACKET_SIZE    9022	/* for jumbo frames */
+#define EHEA_RQ2_PKT_SIZE       1522
+#define EHEA_LL_PKT_SIZE         256	/* low latency */
+
+#define EHEA_MAX_RWQE           1000
+
+/* Send completion signaling */
+#define EHEA_SIG_IV             1000
+#define EHEA_SIG_IV_LONG           4
+
+/* Protection Domain Identifier */
+#define EHEA_PD_ID        0xaabcdeff
+
+#define EHEA_RQ2_THRESHOLD 	   1
+#define EHEA_RQ3_THRESHOLD 	   9	/* use RQ3 threshold of 1522 bytes */
+
+#define EHEA_SPEED_10G         10000
+#define EHEA_SPEED_1G           1000
+#define EHEA_SPEED_100M          100
+#define EHEA_SPEED_10M            10
+
+/* Broadcast/Multicast registration types */
+#define EHEA_BCMC_SCOPE_ALL	0x08
+#define EHEA_BCMC_SCOPE_SINGLE	0x00
+#define EHEA_BCMC_MULTICAST	0x04
+#define EHEA_BCMC_BROADCAST	0x00
+#define EHEA_BCMC_UNTAGGED	0x02
+#define EHEA_BCMC_TAGGED	0x00
+#define EHEA_BCMC_VLANID_ALL	0x01
+#define EHEA_BCMC_VLANID_SINGLE	0x00
+
+/* Use this define to kmallocate pHYP control blocks */
+#define H_CB_ALIGNMENT		4096
+
+#define EHEA_CACHE_LINE          128
+
+/* Memory Regions */
+#define EHEA_MR_MAX_TX_PAGES   20
+#define EHEA_MR_TX_DATA_PN      3
+#define EHEA_MR_ACC_CTRL       0x00800000
+#define EHEA_RWQES_PER_MR_RQ2  10
+#define EHEA_RWQES_PER_MR_RQ3  10
+
+
+void ehea_set_ethtool_ops(struct net_device *netdev);
+
+/* utility functions */
+
+#define ehea_info(fmt, args...) \
+	printk(KERN_INFO DRV_NAME ": " fmt "\n", ## args)
+
+#define ehea_error(fmt, args...) \
+	printk(KERN_ERR DRV_NAME ": Error in %s: " fmt "\n", __func__, ## args)
+
+#ifdef DEBUG
+#define ehea_debug(fmt, args...) \
+	printk(KERN_DEBUG DRV_NAME ": " fmt, ## args)
+#else
+#define ehea_debug(fmt, args...) do {} while (0)
+#endif
+
+#define EHEA_BMASK(pos, length) (((pos) << 16) + (length))
+
+#define EHEA_BMASK_IBM(from, to) (((63 - to) << 16) + ((to) - (from) + 1))
+
+#define EHEA_BMASK_SHIFTPOS(mask) (((mask) >> 16) & 0xffff)
+
+#define EHEA_BMASK_MASK(mask) \
+	(0xffffffffffffffffULL >> ((64 - (mask)) & 0xffff))
+
+#define EHEA_BMASK_SET(mask, value) \
+        ((EHEA_BMASK_MASK(mask) & ((u64)(value))) << EHEA_BMASK_SHIFTPOS(mask))
+
+#define EHEA_BMASK_GET(mask, value) \
+        (EHEA_BMASK_MASK(mask) & (((u64)(value)) >> EHEA_BMASK_SHIFTPOS(mask)))
+
+inline static void ehea_dump(void *adr, int len, char *msg) {
+	int x;
+	unsigned char *deb = adr;
+	for (x = 0; x < len; x += 16) {
+		ehea_info("%s adr=%p ofs=%04x %016lx %016lx\n", msg,
+			  deb, x, *((u64 *)&deb[0]), *((u64 *)&deb[8]));
+		deb += 16;
+	}
+}
+
+/*
+ * Generic ehea page
+ */
+struct ehea_page {
+	u8 entries[PAGE_SIZE];
+};
+
+/*
+ * Generic queue in linux kernel virtual memory
+ */
+struct hw_queue {
+	u64 current_q_offset;		/* current queue entry */
+	struct ehea_page **queue_pages;	/* array of pages belonging to queue */
+	u32 qe_size;			/* queue entry size */
+	u32 queue_length;      		/* queue length allocated in bytes */
+	u32 pagesize;
+	u32 toggle_state;		/* toggle flag - per page */
+	u32 reserved;			/* 64 bit alignment */
+};
+
+/*
+ * For pSeries this is a 64bit memory address where
+ * I/O memory is mapped into CPU address space
+ */
+struct h_epa {
+	u64 fw_handle;
+};
+
+struct h_epas {
+	struct h_epa kernel;	/* kernel space accessible resource,
+				   set to 0 if unused */
+	struct h_epa user;	/* user space accessible resource
+				   set to 0 if unused */
+	u32 pid;		/* PID of userspace epa checking */
+};
+
+struct ehea_qp;
+struct ehea_cq;
+struct ehea_eq;
+struct ehea_port;
+struct ehea_av;
+
+/*
+ * Queue attributes passed to ehea_create_qp()
+ */
+struct ehea_qp_init_attr {
+        /* input parameter */
+	u32 qp_token;           /* queue token */
+	u8 low_lat_rq1;
+	u8 signalingtype;       /* cqe generation flag */
+	u8 rq_count;            /* num of receive queues */
+	u8 eqe_gen;             /* eqe generation flag */
+	u16 max_nr_send_wqes;   /* max number of send wqes */
+	u16 max_nr_rwqes_rq1;   /* max number of receive wqes */
+	u16 max_nr_rwqes_rq2;
+	u16 max_nr_rwqes_rq3;
+	u8 wqe_size_enc_sq;
+	u8 wqe_size_enc_rq1;
+	u8 wqe_size_enc_rq2;
+	u8 wqe_size_enc_rq3;
+	u8 swqe_imm_data_len;   /* immediate data length for swqes */
+	u16 port_nr;
+	u16 rq2_threshold;
+	u16 rq3_threshold;
+	u64 send_cq_handle;
+	u64 recv_cq_handle;
+	u64 aff_eq_handle;
+
+        /* output parameter */
+	u32 qp_nr;
+	u16 act_nr_send_wqes;
+	u16 act_nr_rwqes_rq1;
+	u16 act_nr_rwqes_rq2;
+	u16 act_nr_rwqes_rq3;
+	u8 act_wqe_size_enc_sq;
+	u8 act_wqe_size_enc_rq1;
+	u8 act_wqe_size_enc_rq2;
+	u8 act_wqe_size_enc_rq3;
+	u32 nr_sq_pages;
+	u32 nr_rq1_pages;
+	u32 nr_rq2_pages;
+	u32 nr_rq3_pages;
+	u32 liobn_sq;
+	u32 liobn_rq1;
+	u32 liobn_rq2;
+	u32 liobn_rq3;
+};
+
+/*
+ * Event Queue attributes, passed as paramter
+ */
+struct ehea_eq_attr {
+	u32 type;
+	u32 max_nr_of_eqes;
+	u8 eqe_gen;        /* generate eqe flag */
+	u64 eq_handle;
+	u32 act_nr_of_eqes;
+	u32 nr_pages;
+	u32 ist1;          /* Interrupt service token */
+	u32 ist2;
+	u32 ist3;
+	u32 ist4;
+};
+
+
+/*
+ * Event Queue
+ */
+struct ehea_eq {
+	struct ehea_adapter *adapter;
+	struct hw_queue hw_queue;
+	u64 fw_handle;
+	struct h_epas epas;
+	spinlock_t spinlock;
+	struct ehea_eq_attr attr;
+};
+
+/*
+ * HEA Queues
+ */
+struct ehea_qp {
+	struct ehea_adapter *adapter;
+	u64 fw_handle;			/* QP handle for firmware calls */
+	struct hw_queue hw_squeue;
+	struct hw_queue hw_rqueue1;
+	struct hw_queue hw_rqueue2;
+	struct hw_queue hw_rqueue3;
+	struct h_epas epas;
+	struct ehea_qp_init_attr init_attr;
+};
+
+/*
+ * Completion Queue attributes
+ */
+struct ehea_cq_attr {
+        /* input parameter */
+	u32 max_nr_of_cqes;
+	u32 cq_token;
+	u64 eq_handle;
+
+        /* output parameter */
+	u32 act_nr_of_cqes;
+	u32 nr_pages;
+};
+
+/*
+ * Completion Queue
+ */
+struct ehea_cq {
+	struct ehea_adapter *adapter;
+	u64 fw_handle;
+	struct hw_queue hw_queue;
+	struct h_epas epas;
+	struct ehea_cq_attr attr;
+};
+
+/*
+ * Memory Region
+ */
+struct ehea_mr {
+	u64 handle;
+	u64 vaddr;
+	u32 lkey;
+};
+
+/*
+ * Port state information
+ */
+struct port_state {
+	int poll_max_processed;
+	int poll_receive_errors;
+	int ehea_poll;
+	int queue_stopped;
+	int min_swqe_avail;
+	u64 sqc_stop_sum;
+	int pkt_send;
+	int pkt_xmit;
+	int send_tasklet;
+	int nwqe;
+};
+
+#define EHEA_IRQ_NAME_SIZE 20
+
+/*
+ * Port resources
+ */
+struct ehea_port_res {
+	struct ehea_mr send_mr;       /* send memory region */
+	struct ehea_mr recv_mr;       /* receive memory region */
+	spinlock_t xmit_lock;
+	struct ehea_port *port;
+	char int_recv_name[EHEA_IRQ_NAME_SIZE];
+	char int_send_name[EHEA_IRQ_NAME_SIZE];
+	struct ehea_qp *qp;
+	struct ehea_cq *send_cq;
+	struct ehea_cq *recv_cq;
+	struct ehea_eq *send_eq;
+	struct ehea_eq *recv_eq;
+	spinlock_t send_lock;
+	struct sk_buff **skb_arr_rq1; /* skb array for rq1 */
+	struct sk_buff **skb_arr_rq2;
+	struct sk_buff **skb_arr_rq3;
+	struct sk_buff **skb_arr_sq;
+	int skb_arr_rq1_len;
+	int skb_arr_rq2_len;
+	int skb_arr_rq3_len;
+	int skb_arr_sq_len;
+	int skb_rq2_index;
+	int skb_rq3_index;
+	int skb_sq_index;
+	spinlock_t netif_queue;
+	atomic_t swqe_avail;
+	int swqe_ll_count;
+	int swqe_count;
+	u32 swqe_id_counter;
+	u64 tx_packets;
+	struct tasklet_struct send_comp_task;
+	spinlock_t recv_lock;
+	struct port_state p_state;
+	u64 rx_packets;
+	u32 poll_counter;
+};
+
+
+struct ehea_adapter {
+	u64 handle;
+	u8 num_ports;
+	struct ehea_port *port[16];
+	struct ehea_eq *neq;       /* notification event queue */
+	struct tasklet_struct neq_tasklet;
+	struct ehea_mr mr;
+	u32 pd;                    /* protection domain */
+	u64 max_mc_mac;            /* max number of multicast mac addresses */
+};
+
+
+struct ehea_mc_list {
+	struct list_head list;
+	u64 macaddr;
+};
+
+#define EHEA_MAX_PORT_RES 16
+struct ehea_port {
+	struct ehea_adapter *adapter;	 /* adapter that owns this port */
+	struct net_device *netdev;
+	struct net_device_stats stats;
+	struct ehea_port_res port_res[EHEA_MAX_PORT_RES];
+	struct device_node *of_dev_node; /* Open Firmware Device Node */
+	struct ehea_mc_list *mc_list;	 /* Multicast MAC addresses */
+	struct vlan_group *vgrp;
+	struct ehea_eq *qp_eq;
+	char int_aff_name[EHEA_IRQ_NAME_SIZE];
+	int allmulti;			 /* Indicates IFF_ALLMULTI state */
+	int promisc;		 	 /* Indicates IFF_PROMISC state */
+	int num_tx_qps;
+	u64 mac_addr;
+	u32 logical_port_id;
+	u32 port_speed;
+	u32 msg_enable;
+	u8 full_duplex;
+	u8 num_def_qps;
+};
+
+struct port_res_cfg {
+	int max_entries_rcq;
+	int max_entries_scq;
+	int max_entries_sq;
+	int max_entries_rq1;
+	int max_entries_rq2;
+	int max_entries_rq3;
+};
+
+#endif	/* __EHEA_H__ */
--- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_hw.h	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/ehea_hw.h	2006-08-18 00:01:02.912368521 -0700
@@ -0,0 +1,292 @@
+/*
+ *  linux/drivers/net/ehea/ehea_hw.h
+ *
+ *  eHEA ethernet device driver for IBM eServer System p
+ *
+ *  (C) Copyright IBM Corp. 2006
+ *
+ *  Authors:
+ *       Christoph Raisch <raisch@de.ibm.com>
+ *       Jan-Bernd Themann <themann@de.ibm.com>
+ *       Thomas Klein <tklein@de.ibm.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __EHEA_HW_H__
+#define __EHEA_HW_H__
+
+#define QPX_SQA_VALUE   EHEA_BMASK_IBM(48,63)
+#define QPX_RQ1A_VALUE  EHEA_BMASK_IBM(48,63)
+#define QPX_RQ2A_VALUE  EHEA_BMASK_IBM(48,63)
+#define QPX_RQ3A_VALUE  EHEA_BMASK_IBM(48,63)
+
+#define QPTEMM_OFFSET(x) offsetof(struct ehea_qptemm, x)
+
+struct ehea_qptemm {
+	u64 qpx_hcr;
+	u64 qpx_c;
+	u64 qpx_herr;
+	u64 qpx_aer;
+	u64 qpx_sqa;
+	u64 qpx_sqc;
+	u64 qpx_rq1a;
+	u64 qpx_rq1c;
+	u64 qpx_st;
+	u64 qpx_aerr;
+	u64 qpx_tenure;
+	u64 qpx_reserved1[(0x098 - 0x058) / 8];
+	u64 qpx_portp;
+	u64 qpx_reserved2[(0x100 - 0x0A0) / 8];
+	u64 qpx_t;
+	u64 qpx_sqhp;
+	u64 qpx_sqptp;
+	u64 qpx_reserved3[(0x140 - 0x118) / 8];
+	u64 qpx_sqwsize;
+	u64 qpx_reserved4[(0x170 - 0x148) / 8];
+	u64 qpx_sqsize;
+	u64 qpx_reserved5[(0x1B0 - 0x178) / 8];
+	u64 qpx_sigt;
+	u64 qpx_wqecnt;
+	u64 qpx_rq1hp;
+	u64 qpx_rq1ptp;
+	u64 qpx_rq1size;
+	u64 qpx_reserved6[(0x220 - 0x1D8) / 8];
+	u64 qpx_rq1wsize;
+	u64 qpx_reserved7[(0x240 - 0x228) / 8];
+	u64 qpx_pd;
+	u64 qpx_scqn;
+	u64 qpx_rcqn;
+	u64 qpx_aeqn;
+	u64 reserved49;
+	u64 qpx_ram;
+	u64 qpx_reserved8[(0x300 - 0x270) / 8];
+	u64 qpx_rq2a;
+	u64 qpx_rq2c;
+	u64 qpx_rq2hp;
+	u64 qpx_rq2ptp;
+	u64 qpx_rq2size;
+	u64 qpx_rq2wsize;
+	u64 qpx_rq2th;
+	u64 qpx_rq3a;
+	u64 qpx_rq3c;
+	u64 qpx_rq3hp;
+	u64 qpx_rq3ptp;
+	u64 qpx_rq3size;
+	u64 qpx_rq3wsize;
+	u64 qpx_rq3th;
+	u64 qpx_lpn;
+	u64 qpx_reserved9[(0x400 - 0x378) / 8];
+	u64 reserved_ext[(0x500 - 0x400) / 8];
+	u64 reserved2[(0x1000 - 0x500) / 8];
+};
+
+#define MRx_HCR_LPARID_VALID EHEA_BMASK_IBM(0, 0)
+
+#define MRMWMM_OFFSET(x) offsetof(struct ehea_mrmwmm, x)
+
+struct ehea_mrmwmm {
+	u64 mrx_hcr;
+	u64 mrx_c;
+	u64 mrx_herr;
+	u64 mrx_aer;
+	u64 mrx_pp;
+	u64 reserved1;
+	u64 reserved2;
+	u64 reserved3;
+	u64 reserved4[(0x200 - 0x40) / 8];
+	u64 mrx_ctl[64];
+};
+
+#define QPEDMM_OFFSET(x) offsetof(struct ehea_qpedmm, x)
+
+struct ehea_qpedmm {
+
+	u64 reserved0[(0x400) / 8];
+	u64 qpedx_phh;
+	u64 qpedx_ppsgp;
+	u64 qpedx_ppsgu;
+	u64 qpedx_ppdgp;
+	u64 qpedx_ppdgu;
+	u64 qpedx_aph;
+	u64 qpedx_apsgp;
+	u64 qpedx_apsgu;
+	u64 qpedx_apdgp;
+	u64 qpedx_apdgu;
+	u64 qpedx_apav;
+	u64 qpedx_apsav;
+	u64 qpedx_hcr;
+	u64 reserved1[4];
+	u64 qpedx_rrl0;
+	u64 qpedx_rrrkey0;
+	u64 qpedx_rrva0;
+	u64 reserved2;
+	u64 qpedx_rrl1;
+	u64 qpedx_rrrkey1;
+	u64 qpedx_rrva1;
+	u64 reserved3;
+	u64 qpedx_rrl2;
+	u64 qpedx_rrrkey2;
+	u64 qpedx_rrva2;
+	u64 reserved4;
+	u64 qpedx_rrl3;
+	u64 qpedx_rrrkey3;
+	u64 qpedx_rrva3;
+};
+
+#define CQX_FECADDER EHEA_BMASK_IBM(32, 63)
+#define CQX_FEC_CQE_CNT EHEA_BMASK_IBM(32, 63)
+#define CQX_N1_GENERATE_COMP_EVENT EHEA_BMASK_IBM(0, 0)
+#define CQX_EP_EVENT_PENDING EHEA_BMASK_IBM(0, 0)
+
+#define CQTEMM_OFFSET(x) offsetof(struct ehea_cqtemm, x)
+
+struct ehea_cqtemm {
+	u64 cqx_hcr;
+	u64 cqx_c;
+	u64 cqx_herr;
+	u64 cqx_aer;
+	u64 cqx_ptp;
+	u64 cqx_tp;
+	u64 cqx_fec;
+	u64 cqx_feca;
+	u64 cqx_ep;
+	u64 cqx_eq;
+	u64 reserved1;
+	u64 cqx_n0;
+	u64 cqx_n1;
+	u64 reserved2[(0x1000 - 0x60) / 8];
+};
+
+#define EQTEMM_OFFSET(x) offsetof(struct ehea_eqtemm, x)
+
+struct ehea_eqtemm {
+	u64 EQx_HCR;
+	u64 EQx_C;
+	u64 EQx_HERR;
+	u64 EQx_AER;
+	u64 EQx_PTP;
+	u64 EQx_TP;
+	u64 EQx_SSBA;
+	u64 EQx_PSBA;
+	u64 EQx_CEC;
+	u64 EQx_MEQL;
+	u64 EQx_XISBI;
+	u64 EQx_XISC;
+	u64 EQx_IT;
+};
+
+static inline u64 epa_load(struct h_epa epa, u32 offset)
+{
+	u64 addr = epa.fw_handle + offset;
+	u64 out;
+	out = *(volatile u64 *)addr;
+	return out;
+};
+
+static inline void epa_store(struct h_epa epa, u32 offset, u64 value)
+{
+	u64 addr = epa.fw_handle + offset;
+	*(u64 *) addr = value;
+	epa_load(epa, offset);	/* synchronize explicitly to eHEA */
+};
+
+static inline void epa_store_acc(struct h_epa epa, u32 offset, u64 value)
+{
+	u64 addr = epa.fw_handle + offset;
+	*(u64 *) addr = value;
+};
+
+#define epa_store_eq(epa, offset, value)\
+        epa_store(epa, EQTEMM_OFFSET(offset), value)
+#define epa_load_eq(epa, offset)\
+        epa_load(epa, EQTEMM_OFFSET(offset))
+
+#define epa_store_cq(epa, offset, value)\
+        epa_store(epa, CQTEMM_OFFSET(offset), value)
+#define epa_load_cq(epa, offset)\
+        epa_load(epa, CQTEMM_OFFSET(offset))
+
+#define epa_store_qp(epa, offset, value)\
+        epa_store(epa, QPTEMM_OFFSET(offset), value)
+#define epa_load_qp(epa, offset)\
+        epa_load(epa, QPTEMM_OFFSET(offset))
+
+#define epa_store_qped(epa, offset, value)\
+        epa_store(epa, QPEDMM_OFFSET(offset), value)
+#define epa_load_qped(epa, offset)\
+        epa_load(epa, QPEDMM_OFFSET(offset))
+
+#define epa_store_mrmw(epa, offset, value)\
+        epa_store(epa, MRMWMM_OFFSET(offset), value)
+#define epa_load_mrmw(epa, offset)\
+        epa_load(epa, MRMWMM_OFFSET(offset))
+
+#define epa_store_base(epa, offset, value)\
+        epa_store(epa, HCAGR_OFFSET(offset), value)
+#define epa_load_base(epa, offset)\
+        epa_load(epa, HCAGR_OFFSET(offset))
+
+static inline void ehea_update_sqa(struct ehea_qp *qp, u16 nr_wqes)
+{
+	struct h_epa epa = qp->epas.kernel;
+	epa_store_acc(epa, QPTEMM_OFFSET(qpx_sqa),
+		      EHEA_BMASK_SET(QPX_SQA_VALUE, nr_wqes));
+}
+
+static inline void ehea_update_rq3a(struct ehea_qp *qp, u16 nr_wqes)
+{
+	struct h_epa epa = qp->epas.kernel;
+	epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq3a),
+		      EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
+}
+
+static inline void ehea_update_rq2a(struct ehea_qp *qp, u16 nr_wqes)
+{
+	struct h_epa epa = qp->epas.kernel;
+	epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq2a),
+		      EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
+}
+
+static inline void ehea_update_rq1a(struct ehea_qp *qp, u16 nr_wqes)
+{
+	struct h_epa epa = qp->epas.kernel;
+	epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq1a),
+		      EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
+}
+
+static inline void ehea_update_feca(struct ehea_cq *cq, u32 nr_cqes)
+{
+	struct h_epa epa = cq->epas.kernel;
+	epa_store_acc(epa, CQTEMM_OFFSET(cqx_feca),
+		      EHEA_BMASK_SET(CQX_FECADDER, nr_cqes));
+}
+
+static inline void ehea_reset_cq_n1(struct ehea_cq *cq)
+{
+	struct h_epa epa = cq->epas.kernel;
+	epa_store_cq(epa, cqx_n1,
+		     EHEA_BMASK_SET(CQX_N1_GENERATE_COMP_EVENT, 1));
+}
+
+static inline void ehea_reset_cq_ep(struct ehea_cq *my_cq)
+{
+	struct h_epa epa = my_cq->epas.kernel;
+	epa_store_acc(epa, CQTEMM_OFFSET(cqx_ep),
+		      EHEA_BMASK_SET(CQX_EP_EVENT_PENDING, 0));
+}
+
+#endif	/* __EHEA_HW_H__ */
