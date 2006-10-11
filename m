Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWJKJFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWJKJFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWJKJFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:05:03 -0400
Received: from havoc.gtf.org ([69.61.125.42]:20670 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965195AbWJKJEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:04:55 -0400
Date: Wed, 11 Oct 2006 05:04:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061011090453.GA24424@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/b44.c                |    9 -
 drivers/net/bonding/bond_alb.c   |    4 
 drivers/net/ehea/ehea.h          |   13 -
 drivers/net/ehea/ehea_main.c     |    6 
 drivers/net/ehea/ehea_phyp.c     |  573 ++++++++++++++++----------------------
 drivers/net/forcedeth.c          |   31 +-
 drivers/net/ibmveth.c            |   58 +++-
 drivers/net/mv643xx_eth.c        |    4 
 drivers/net/skge.c               |  220 +++++++++------
 drivers/net/skge.h               |   25 +-
 drivers/net/sky2.c               |   36 +-
 drivers/net/sky2.h               |   45 +++
 drivers/net/smc91x.h             |   18 +
 drivers/net/spider_net.c         |  246 ++++++++++------
 drivers/net/spider_net.h         |   35 +-
 drivers/net/spider_net_ethtool.c |    6 
 drivers/net/tulip/de2104x.c      |    8 -
 17 files changed, 725 insertions(+), 612 deletions(-)

Andrew Morton:
      ibmveth irq fix

Deepak Saxena:
      Update smc91x driver with ARM Versatile board info

Helge Deller:
      Fix section mismatch in de2104x.c

Jan-Bernd Themann:
      ehea: firmware (hvcall) interface changes
      ehea: fix port state notification, default queue sizes

Jeff Garzik:
      [netdrvr] b44: handle excessive multicast groups

Karsten Keil:
      bonding: fix deadlock on high loads in bond_alb_monitor()

Linas Vepstas:
      powerpc/cell spidernet ethtool -i version number info.
      powerpc/cell spidernet burst alignment patch.
      Spidernet module parm permissions
      powerpc/cell spidernet force-end fix
      powerpc/cell spidernet zlen min packet length
      powerpc/cell spidernet add missing netdev watchdog
      Spidernet fix register field definitions
      Spidernet stop queue when queue is full.
      powerpc/cell spidernet bogus rx interrupt bit
      powerpc/cell spidernet fix error interrupt print
      powerpc/cell spidernet stop error printing patch.
      powerpc/cell spidernet incorrect offset
      powerpc/cell spidernet low watermark patch.
      powerpc/cell spidernet NAPI polling info.
      powerpc/cell spidernet refine locking
      powerpc/cell spidernet
      powerpc/cell spidernet reduce DMA kicking
      powerpc/cell spidernet variable name change
      powerpc/cell spidernet DMA direction fix
      powerpc/cell spidernet release all descrs

Maxime Bizon:
      mv643xx_eth: Fix ethtool stats

Michael Buesch:
      b44: fix eeprom endianess issue

Michael Ellerman:
      ibmveth: Harden driver initilisation

Peter Zijlstra:
      forcedeth: hardirq lockdep warning

Santiago Leon:
      ibmveth: Add netpoll function
      ibmveth: kdump interrupt fix
      ibmveth: rename proc entry name
      ibmveth: fix int rollover panic

Stephen Hemminger:
      sky2: incorrect length on receive packets
      skge: fix stuck irq when fiber down
      skge: pause mapping for fiber
      skge: better flow control negotiation
      skge: version 1.9
      sky2: revert pci express extensions
      sky2: set lower pause threshold to prevent overrun

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index b124eee..1ec2174 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -1706,14 +1706,15 @@ static void __b44_set_rx_mode(struct net
 
 		__b44_set_mac_addr(bp);
 
-		if (dev->flags & IFF_ALLMULTI)
+		if ((dev->flags & IFF_ALLMULTI) ||
+		    (dev->mc_count > B44_MCAST_TABLE_SIZE))
 			val |= RXCONFIG_ALLMULTI;
 		else
 			i = __b44_load_mcast(bp, dev);
 
-		for (; i < 64; i++) {
+		for (; i < 64; i++)
 			__b44_cam_write(bp, zero, i);
-		}
+
 		bw32(bp, B44_RXCONFIG, val);
         	val = br32(bp, B44_CAM_CTRL);
 	        bw32(bp, B44_CAM_CTRL, val | CAM_CTRL_ENABLE);
@@ -2055,7 +2056,7 @@ static int b44_read_eeprom(struct b44 *b
 	u16 *ptr = (u16 *) data;
 
 	for (i = 0; i < 128; i += 2)
-		ptr[i / 2] = readw(bp->regs + 4096 + i);
+		ptr[i / 2] = cpu_to_le16(readw(bp->regs + 4096 + i));
 
 	return 0;
 }
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index e83bc82..3292316 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1433,7 +1433,7 @@ void bond_alb_monitor(struct bonding *bo
 		 * write lock to protect from other code that also
 		 * sets the promiscuity.
 		 */
-		write_lock(&bond->curr_slave_lock);
+		write_lock_bh(&bond->curr_slave_lock);
 
 		if (bond_info->primary_is_promisc &&
 		    (++bond_info->rlb_promisc_timeout_counter >= RLB_PROMISC_TIMEOUT)) {
@@ -1448,7 +1448,7 @@ void bond_alb_monitor(struct bonding *bo
 			bond_info->primary_is_promisc = 0;
 		}
 
-		write_unlock(&bond->curr_slave_lock);
+		write_unlock_bh(&bond->curr_slave_lock);
 
 		if (bond_info->rlb_rebalance) {
 			bond_info->rlb_rebalance = 0;
diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 23b451a..b40724f 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0028"
+#define DRV_VERSION	"EHEA_0034"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -50,6 +50,7 @@ #define EHEA_MAX_ENTRIES_RQ3 16383
 #define EHEA_MAX_ENTRIES_SQ  32767
 #define EHEA_MIN_ENTRIES_QP  127
 
+#define EHEA_SMALL_QUEUES
 #define EHEA_NUM_TX_QP 1
 
 #ifdef EHEA_SMALL_QUEUES
@@ -59,11 +60,11 @@ #define EHEA_DEF_ENTRIES_RQ1    4095
 #define EHEA_DEF_ENTRIES_RQ2    1023
 #define EHEA_DEF_ENTRIES_RQ3    1023
 #else
-#define EHEA_MAX_CQE_COUNT     32000
-#define EHEA_DEF_ENTRIES_SQ    16000
-#define EHEA_DEF_ENTRIES_RQ1   32080
-#define EHEA_DEF_ENTRIES_RQ2    4020
-#define EHEA_DEF_ENTRIES_RQ3    4020
+#define EHEA_MAX_CQE_COUNT      4080
+#define EHEA_DEF_ENTRIES_SQ     4080
+#define EHEA_DEF_ENTRIES_RQ1    8160
+#define EHEA_DEF_ENTRIES_RQ2    2040
+#define EHEA_DEF_ENTRIES_RQ3    2040
 #endif
 
 #define EHEA_MAX_ENTRIES_EQ 20
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index c6b3177..eb7d44d 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -766,7 +766,7 @@ static void ehea_parse_eqe(struct ehea_a
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
 				ret = ehea_sense_port_attr(
-					adapter->port[portnum]);
+					port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -818,7 +818,7 @@ static void ehea_parse_eqe(struct ehea_a
 		netif_stop_queue(port->netdev);
 		break;
 	default:
-		ehea_error("unknown event code %x", ec);
+		ehea_error("unknown event code %x, eqe=0x%lX", ec, eqe);
 		break;
 	}
 }
@@ -1841,7 +1841,7 @@ static int ehea_start_xmit(struct sk_buf
 
 	if (netif_msg_tx_queued(port)) {
 		ehea_info("post swqe on QP %d", pr->qp->init_attr.qp_nr);
-		ehea_dump(swqe, sizeof(*swqe), "swqe");
+		ehea_dump(swqe, 512, "swqe");
 	}
 
 	ehea_post_swqe(pr->qp, swqe);
diff --git a/drivers/net/ehea/ehea_phyp.c b/drivers/net/ehea/ehea_phyp.c
index 4a85aca..0b51a8c 100644
--- a/drivers/net/ehea/ehea_phyp.c
+++ b/drivers/net/ehea/ehea_phyp.c
@@ -44,71 +44,99 @@ #define H_ALL_RES_TYPE_EQ        3
 #define H_ALL_RES_TYPE_MR        5
 #define H_ALL_RES_TYPE_MW        6
 
-static long ehea_hcall_9arg_9ret(unsigned long opcode,
-         			 unsigned long arg1, unsigned long arg2,
-         			 unsigned long arg3, unsigned long arg4,
-         			 unsigned long arg5, unsigned long arg6,
-         			 unsigned long arg7, unsigned long arg8,
-         			 unsigned long arg9, unsigned long *out1,
-         			 unsigned long *out2,unsigned long *out3,
-         			 unsigned long *out4,unsigned long *out5,
-         			 unsigned long *out6,unsigned long *out7,
-         			 unsigned long *out8,unsigned long *out9)
+static long ehea_plpar_hcall_norets(unsigned long opcode,
+				    unsigned long arg1,
+				    unsigned long arg2,
+				    unsigned long arg3,
+				    unsigned long arg4,
+				    unsigned long arg5,
+				    unsigned long arg6,
+				    unsigned long arg7)
 {
-	long hret;
+	long ret;
 	int i, sleep_msecs;
 
 	for (i = 0; i < 5; i++) {
-		hret = plpar_hcall_9arg_9ret(opcode,arg1, arg2, arg3, arg4,
-					     arg5, arg6, arg7, arg8, arg9, out1,
-					     out2, out3, out4, out5, out6, out7,
-					     out8, out9);
-		if (H_IS_LONG_BUSY(hret)) {
-			sleep_msecs = get_longbusy_msecs(hret);
+		ret = plpar_hcall_norets(opcode, arg1, arg2, arg3, arg4,
+					 arg5, arg6, arg7);
+
+		if (H_IS_LONG_BUSY(ret)) {
+			sleep_msecs = get_longbusy_msecs(ret);
 			msleep_interruptible(sleep_msecs);
 			continue;
 		}
 
-		if (hret < H_SUCCESS)
-			ehea_error("op=%lx hret=%lx "
-				   "i1=%lx i2=%lx i3=%lx i4=%lx i5=%lx i6=%lx "
-				   "i7=%lx i8=%lx i9=%lx "
-				   "o1=%lx o2=%lx o3=%lx o4=%lx o5=%lx o6=%lx "
-				   "o7=%lx o8=%lx o9=%lx",
-				   opcode, hret, arg1, arg2, arg3, arg4, arg5,
-				   arg6, arg7, arg8, arg9, *out1, *out2, *out3,
-				   *out4, *out5, *out6, *out7, *out8, *out9);
-		return hret;
+		if (ret < H_SUCCESS)
+			ehea_error("opcode=%lx ret=%lx"
+				   " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
+				   " arg5=%lx arg6=%lx arg7=%lx ",
+				   opcode, ret,
+				   arg1, arg2, arg3, arg4, arg5,
+				   arg6, arg7);
+
+		return ret;
 	}
+
 	return H_BUSY;
 }
 
-u64 ehea_h_query_ehea_qp(const u64 adapter_handle, const u8 qp_category,
-			 const u64 qp_handle, const u64 sel_mask, void *cb_addr)
+static long ehea_plpar_hcall9(unsigned long opcode,
+			      unsigned long *outs, /* array of 9 outputs */
+			      unsigned long arg1,
+			      unsigned long arg2,
+			      unsigned long arg3,
+			      unsigned long arg4,
+			      unsigned long arg5,
+			      unsigned long arg6,
+			      unsigned long arg7,
+			      unsigned long arg8,
+			      unsigned long arg9)
 {
-	u64 dummy;
+	long ret;
+	int i, sleep_msecs;
 
-	if ((((u64)cb_addr) & (PAGE_SIZE - 1)) != 0) {
-		ehea_error("not on pageboundary");
-		return H_PARAMETER;
+	for (i = 0; i < 5; i++) {
+		ret = plpar_hcall9(opcode, outs,
+				   arg1, arg2, arg3, arg4, arg5,
+				   arg6, arg7, arg8, arg9);
+
+		if (H_IS_LONG_BUSY(ret)) {
+			sleep_msecs = get_longbusy_msecs(ret);
+			msleep_interruptible(sleep_msecs);
+			continue;
+		}
+
+		if (ret < H_SUCCESS)
+			ehea_error("opcode=%lx ret=%lx"
+				   " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
+				   " arg5=%lx arg6=%lx arg7=%lx arg8=%lx"
+				   " arg9=%lx"
+				   " out1=%lx out2=%lx out3=%lx out4=%lx"
+				   " out5=%lx out6=%lx out7=%lx out8=%lx"
+				   " out9=%lx",
+				   opcode, ret,
+				   arg1, arg2, arg3, arg4, arg5,
+				   arg6, arg7, arg8, arg9,
+				   outs[0], outs[1], outs[2], outs[3],
+				   outs[4], outs[5], outs[6], outs[7],
+				   outs[8]);
+
+		return ret;
 	}
 
-	return ehea_hcall_9arg_9ret(H_QUERY_HEA_QP,
-				    adapter_handle,	        /* R4 */
-				    qp_category,	        /* R5 */
-				    qp_handle,	                /* R6 */
-				    sel_mask,	                /* R7 */
-				    virt_to_abs(cb_addr),	/* R8 */
-				    0, 0, 0, 0,	                /* R9-R12 */
-				    &dummy,                     /* R4 */
-				    &dummy,                     /* R5 */
-				    &dummy,	                /* R6 */
-				    &dummy,	                /* R7 */
-				    &dummy,	                /* R8 */
-				    &dummy,	                /* R9 */
-				    &dummy,	                /* R10 */
-				    &dummy,	                /* R11 */
-				    &dummy);	                /* R12 */
+	return H_BUSY;
+}
+
+u64 ehea_h_query_ehea_qp(const u64 adapter_handle, const u8 qp_category,
+			 const u64 qp_handle, const u64 sel_mask, void *cb_addr)
+{
+	return ehea_plpar_hcall_norets(H_QUERY_HEA_QP,
+				       adapter_handle,	        /* R4 */
+				       qp_category,	        /* R5 */
+				       qp_handle,               /* R6 */
+				       sel_mask,                /* R7 */
+				       virt_to_abs(cb_addr),	/* R8 */
+				       0, 0);
 }
 
 /* input param R5 */
@@ -180,6 +208,7 @@ u64 ehea_h_alloc_resource_qp(const u64 a
 			     u64 *qp_handle, struct h_epas *h_epas)
 {
 	u64 hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
 	u64 allocate_controls =
 	    EHEA_BMASK_SET(H_ALL_RES_QP_EQPO, init_attr->low_lat_rq1 ? 1 : 0)
@@ -219,45 +248,29 @@ u64 ehea_h_alloc_resource_qp(const u64 a
 	    EHEA_BMASK_SET(H_ALL_RES_QP_TH_RQ2, init_attr->rq2_threshold)
 	    | EHEA_BMASK_SET(H_ALL_RES_QP_TH_RQ3, init_attr->rq3_threshold);
 
-	u64 r5_out = 0;
-	u64 r6_out = 0;
-	u64 r7_out = 0;
-	u64 r8_out = 0;
-	u64 r9_out = 0;
-	u64 g_la_user_out = 0;
-	u64 r11_out = 0;
-	u64 r12_out = 0;
-
-	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
-				    adapter_handle,		/* R4 */
-				    allocate_controls,		/* R5 */
-				    init_attr->send_cq_handle,	/* R6 */
-				    init_attr->recv_cq_handle,	/* R7 */
-				    init_attr->aff_eq_handle,	/* R8 */
-				    r9_reg,			/* R9 */
-				    max_r10_reg,		/* R10 */
-				    r11_in,			/* R11 */
-				    threshold,			/* R12 */
-				    qp_handle,			/* R4 */
-				    &r5_out,			/* R5 */
-				    &r6_out,			/* R6 */
-				    &r7_out,			/* R7 */
-				    &r8_out,			/* R8 */
-				    &r9_out,			/* R9 */
-				    &g_la_user_out,		/* R10 */
-				    &r11_out,			/* R11 */
-				    &r12_out);			/* R12 */
-
-	init_attr->qp_nr = (u32)r5_out;
+	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
+				 outs,
+				 adapter_handle,		/* R4 */
+				 allocate_controls,		/* R5 */
+				 init_attr->send_cq_handle,	/* R6 */
+				 init_attr->recv_cq_handle,	/* R7 */
+				 init_attr->aff_eq_handle,	/* R8 */
+				 r9_reg,			/* R9 */
+				 max_r10_reg,			/* R10 */
+				 r11_in,			/* R11 */
+				 threshold);			/* R12 */
+
+	*qp_handle = outs[0];
+	init_attr->qp_nr = (u32)outs[1];
 
 	init_attr->act_nr_send_wqes =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_SWQE, r6_out);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_SWQE, outs[2]);
 	init_attr->act_nr_rwqes_rq1 =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R1WQE, r6_out);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R1WQE, outs[2]);
 	init_attr->act_nr_rwqes_rq2 =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R2WQE, r6_out);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R2WQE, outs[2]);
 	init_attr->act_nr_rwqes_rq3 =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R3WQE, r6_out);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R3WQE, outs[2]);
 
 	init_attr->act_wqe_size_enc_sq = init_attr->wqe_size_enc_sq;
 	init_attr->act_wqe_size_enc_rq1 = init_attr->wqe_size_enc_rq1;
@@ -265,25 +278,25 @@ u64 ehea_h_alloc_resource_qp(const u64 a
 	init_attr->act_wqe_size_enc_rq3 = init_attr->wqe_size_enc_rq3;
 
 	init_attr->nr_sq_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_SQ, r8_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_SQ, outs[4]);
 	init_attr->nr_rq1_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ1, r8_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ1, outs[4]);
 	init_attr->nr_rq2_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ2, r9_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ2, outs[5]);
 	init_attr->nr_rq3_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ3, r9_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ3, outs[5]);
 
 	init_attr->liobn_sq =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_SQ, r11_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_SQ, outs[7]);
 	init_attr->liobn_rq1 =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ1, r11_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ1, outs[7]);
 	init_attr->liobn_rq2 =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ2, r12_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ2, outs[8]);
 	init_attr->liobn_rq3 =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ3, r12_out);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ3, outs[8]);
 
 	if (!hret)
-		hcp_epas_ctor(h_epas, g_la_user_out, g_la_user_out);
+		hcp_epas_ctor(h_epas, outs[6], outs[6]);
 
 	return hret;
 }
@@ -292,31 +305,24 @@ u64 ehea_h_alloc_resource_cq(const u64 a
 			     struct ehea_cq_attr *cq_attr,
 			     u64 *cq_handle, struct h_epas *epas)
 {
-	u64 hret, dummy, act_nr_of_cqes_out, act_pages_out;
-	u64 g_la_privileged_out, g_la_user_out;
-
-	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
-				    adapter_handle,		/* R4 */
-				    H_ALL_RES_TYPE_CQ,		/* R5 */
-				    cq_attr->eq_handle,		/* R6 */
-				    cq_attr->cq_token,		/* R7 */
-				    cq_attr->max_nr_of_cqes,	/* R8 */
-				    0, 0, 0, 0,			/* R9-R12 */
-				    cq_handle,			/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &act_nr_of_cqes_out,	/* R7 */
-				    &act_pages_out,		/* R8 */
-				    &g_la_privileged_out,	/* R9 */
-				    &g_la_user_out,		/* R10 */
-				    &dummy,	                /* R11 */
-				    &dummy);	                /* R12 */
-
-	cq_attr->act_nr_of_cqes = act_nr_of_cqes_out;
-	cq_attr->nr_pages = act_pages_out;
+	u64 hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
+				 outs,
+				 adapter_handle,		/* R4 */
+				 H_ALL_RES_TYPE_CQ,		/* R5 */
+				 cq_attr->eq_handle,		/* R6 */
+				 cq_attr->cq_token,		/* R7 */
+				 cq_attr->max_nr_of_cqes,	/* R8 */
+				 0, 0, 0, 0);			/* R9-R12 */
+
+	*cq_handle = outs[0];
+	cq_attr->act_nr_of_cqes = outs[3];
+	cq_attr->nr_pages = outs[4];
 
 	if (!hret)
-		hcp_epas_ctor(epas, g_la_privileged_out, g_la_user_out);
+		hcp_epas_ctor(epas, outs[5], outs[6]);
 
 	return hret;
 }
@@ -361,9 +367,8 @@ #define H_ALL_RES_EQ_ACT_EQ_IST_4    EHE
 u64 ehea_h_alloc_resource_eq(const u64 adapter_handle,
 			     struct ehea_eq_attr *eq_attr, u64 *eq_handle)
 {
-	u64 hret, dummy, eq_liobn, allocate_controls;
-	u64 ist1_out, ist2_out, ist3_out, ist4_out;
-	u64 act_nr_of_eqes_out, act_pages_out;
+	u64 hret, allocate_controls;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
 	/* resource type */
 	allocate_controls =
@@ -372,27 +377,20 @@ u64 ehea_h_alloc_resource_eq(const u64 a
 	    | EHEA_BMASK_SET(H_ALL_RES_EQ_INH_EQE_GEN, !eq_attr->eqe_gen)
 	    | EHEA_BMASK_SET(H_ALL_RES_EQ_NON_NEQ_ISN, 1);
 
-	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
-				    adapter_handle,		/* R4 */
-				    allocate_controls,		/* R5 */
-				    eq_attr->max_nr_of_eqes,	/* R6 */
-				    0, 0, 0, 0, 0, 0,		/* R7-R10 */
-				    eq_handle,			/* R4 */
-				    &dummy,			/* R5 */
-				    &eq_liobn,			/* R6 */
-				    &act_nr_of_eqes_out,	/* R7 */
-				    &act_pages_out,		/* R8 */
-				    &ist1_out,			/* R9 */
-				    &ist2_out,			/* R10 */
-				    &ist3_out,			/* R11 */
-				    &ist4_out);			/* R12 */
-
-	eq_attr->act_nr_of_eqes = act_nr_of_eqes_out;
-	eq_attr->nr_pages = act_pages_out;
-	eq_attr->ist1 = ist1_out;
-	eq_attr->ist2 = ist2_out;
-	eq_attr->ist3 = ist3_out;
-	eq_attr->ist4 = ist4_out;
+	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
+				 outs,
+				 adapter_handle,		/* R4 */
+				 allocate_controls,		/* R5 */
+				 eq_attr->max_nr_of_eqes,	/* R6 */
+				 0, 0, 0, 0, 0, 0);		/* R7-R10 */
+
+	*eq_handle = outs[0];
+	eq_attr->act_nr_of_eqes = outs[3];
+	eq_attr->nr_pages = outs[4];
+	eq_attr->ist1 = outs[5];
+	eq_attr->ist2 = outs[6];
+	eq_attr->ist3 = outs[7];
+	eq_attr->ist4 = outs[8];
 
 	return hret;
 }
@@ -402,31 +400,22 @@ u64 ehea_h_modify_ehea_qp(const u64 adap
 			  void *cb_addr, u64 *inv_attr_id, u64 *proc_mask,
 			  u16 *out_swr, u16 *out_rwr)
 {
-	u64 hret, dummy, act_out_swr, act_out_rwr;
-
-	if ((((u64)cb_addr) & (PAGE_SIZE - 1)) != 0) {
-		ehea_error("not on page boundary");
-		return H_PARAMETER;
-	}
-
-	hret = ehea_hcall_9arg_9ret(H_MODIFY_HEA_QP,
-				    adapter_handle,		/* R4 */
-				    (u64) cat,			/* R5 */
-				    qp_handle,			/* R6 */
-				    sel_mask,			/* R7 */
-				    virt_to_abs(cb_addr),	/* R8 */
-				    0, 0, 0, 0,			/* R9-R12 */
-				    inv_attr_id,		/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &act_out_swr,		/* R7 */
-				    &act_out_rwr,		/* R8 */
-				    proc_mask,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,			/* R11 */
-				    &dummy);			/* R12 */
-	*out_swr = act_out_swr;
-	*out_rwr = act_out_rwr;
+	u64 hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	hret = ehea_plpar_hcall9(H_MODIFY_HEA_QP,
+				 outs,
+				 adapter_handle,		/* R4 */
+				 (u64) cat,			/* R5 */
+				 qp_handle,			/* R6 */
+				 sel_mask,			/* R7 */
+				 virt_to_abs(cb_addr),		/* R8 */
+				 0, 0, 0, 0);			/* R9-R12 */
+
+	*inv_attr_id = outs[0];
+	*out_swr = outs[3];
+	*out_rwr = outs[4];
+	*proc_mask = outs[5];
 
 	return hret;
 }
@@ -435,122 +424,81 @@ u64 ehea_h_register_rpage(const u64 adap
 			  const u8 queue_type, const u64 resource_handle,
 			  const u64 log_pageaddr, u64 count)
 {
-	u64 dummy, reg_control;
+	u64  reg_control;
 
 	reg_control = EHEA_BMASK_SET(H_REG_RPAGE_PAGE_SIZE, pagesize)
 		    | EHEA_BMASK_SET(H_REG_RPAGE_QT, queue_type);
 
-	return ehea_hcall_9arg_9ret(H_REGISTER_HEA_RPAGES,
-				    adapter_handle,		/* R4 */
-				    reg_control,		/* R5 */
-				    resource_handle,		/* R6 */
-				    log_pageaddr,		/* R7 */
-				    count,			/* R8 */
-				    0, 0, 0, 0,			/* R9-R12 */
-				    &dummy,			/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &dummy,			/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,	                /* R11 */
-				    &dummy);	                /* R12 */
+	return ehea_plpar_hcall_norets(H_REGISTER_HEA_RPAGES,
+				       adapter_handle,		/* R4 */
+				       reg_control,		/* R5 */
+				       resource_handle,		/* R6 */
+				       log_pageaddr,		/* R7 */
+				       count,			/* R8 */
+				       0, 0);			/* R9-R10 */
 }
 
 u64 ehea_h_register_smr(const u64 adapter_handle, const u64 orig_mr_handle,
 			const u64 vaddr_in, const u32 access_ctrl, const u32 pd,
 			struct ehea_mr *mr)
 {
-	u64 hret, dummy, lkey_out;
-
-	hret = ehea_hcall_9arg_9ret(H_REGISTER_SMR,
-				    adapter_handle       ,          /* R4 */
-				    orig_mr_handle,                 /* R5 */
-				    vaddr_in,                       /* R6 */
-				    (((u64)access_ctrl) << 32ULL),  /* R7 */
-				    pd,                             /* R8 */
-				    0, 0, 0, 0,			    /* R9-R12 */
-				    &mr->handle,                    /* R4 */
-				    &dummy,                         /* R5 */
-				    &lkey_out,                      /* R6 */
-				    &dummy,                         /* R7 */
-				    &dummy,                         /* R8 */
-				    &dummy,                         /* R9 */
-				    &dummy,                         /* R10 */
-				    &dummy,                         /* R11 */
-				    &dummy);                        /* R12 */
-	mr->lkey = (u32)lkey_out;
+	u64 hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	hret = ehea_plpar_hcall9(H_REGISTER_SMR,
+				 outs,
+				 adapter_handle       ,        	 /* R4 */
+				 orig_mr_handle,                 /* R5 */
+				 vaddr_in,                       /* R6 */
+				 (((u64)access_ctrl) << 32ULL),  /* R7 */
+				 pd,                             /* R8 */
+				 0, 0, 0, 0);	   		 /* R9-R12 */
+
+	mr->handle = outs[0];
+	mr->lkey = (u32)outs[2];
 
 	return hret;
 }
 
 u64 ehea_h_disable_and_get_hea(const u64 adapter_handle, const u64 qp_handle)
 {
-	u64 hret, dummy, ladr_next_sq_wqe_out;
-	u64 ladr_next_rq1_wqe_out, ladr_next_rq2_wqe_out, ladr_next_rq3_wqe_out;
-
-	hret = ehea_hcall_9arg_9ret(H_DISABLE_AND_GET_HEA,
-				    adapter_handle,		/* R4 */
-				    H_DISABLE_GET_EHEA_WQE_P,	/* R5 */
-				    qp_handle,			/* R6 */
-				    0, 0, 0, 0, 0, 0,		/* R7-R12 */
-				    &ladr_next_sq_wqe_out,	/* R4 */
-				    &ladr_next_rq1_wqe_out,	/* R5 */
-				    &ladr_next_rq2_wqe_out,	/* R6 */
-				    &ladr_next_rq3_wqe_out,	/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,                     /* R11 */
-				    &dummy);                    /* R12 */
-	return hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	return ehea_plpar_hcall9(H_DISABLE_AND_GET_HEA,
+       				 outs,
+				 adapter_handle,		/* R4 */
+				 H_DISABLE_GET_EHEA_WQE_P,	/* R5 */
+				 qp_handle,			/* R6 */
+				 0, 0, 0, 0, 0, 0);             /* R7-R12 */
 }
 
 u64 ehea_h_free_resource(const u64 adapter_handle, const u64 res_handle)
 {
-	u64 dummy;
-
-	return ehea_hcall_9arg_9ret(H_FREE_RESOURCE,
-				    adapter_handle,	   /* R4 */
-				    res_handle,            /* R5 */
-				    0, 0, 0, 0, 0, 0, 0,   /* R6-R12 */
-				    &dummy,                /* R4 */
-				    &dummy,                /* R5 */
-				    &dummy,                /* R6 */
-				    &dummy,                /* R7 */
-				    &dummy,                /* R8 */
-				    &dummy,                /* R9 */
-				    &dummy,		   /* R10 */
-				    &dummy,                /* R11 */
-				    &dummy);               /* R12 */
+	return ehea_plpar_hcall_norets(H_FREE_RESOURCE,
+				       adapter_handle,	   /* R4 */
+				       res_handle,         /* R5 */
+				       0, 0, 0, 0, 0);     /* R6-R10 */
 }
 
 u64 ehea_h_alloc_resource_mr(const u64 adapter_handle, const u64 vaddr,
 			     const u64 length, const u32 access_ctrl,
 			     const u32 pd, u64 *mr_handle, u32 *lkey)
 {
-	u64 hret, dummy, lkey_out;
-
-	hret = ehea_hcall_9arg_9ret(H_ALLOC_HEA_RESOURCE,
-				    adapter_handle,		   /* R4 */
-				    5,				   /* R5 */
-				    vaddr,			   /* R6 */
-				    length,			   /* R7 */
-				    (((u64) access_ctrl) << 32ULL),/* R8 */
-				    pd,				   /* R9 */
-				    0, 0, 0,			   /* R10-R12 */
-				    mr_handle,			   /* R4 */
-				    &dummy,			   /* R5 */
-				    &lkey_out,			   /* R6 */
-				    &dummy,			   /* R7 */
-				    &dummy,			   /* R8 */
-				    &dummy,			   /* R9 */
-				    &dummy,			   /* R10 */
-				    &dummy,                        /* R11 */
-				    &dummy);                       /* R12 */
-	*lkey = (u32) lkey_out;
-
+	u64 hret;
+ 	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
+				 outs,
+				 adapter_handle,		   /* R4 */
+				 5,				   /* R5 */
+				 vaddr,			           /* R6 */
+				 length,			   /* R7 */
+				 (((u64) access_ctrl) << 32ULL),   /* R8 */
+				 pd,				   /* R9 */
+				 0, 0, 0);			   /* R10-R12 */
+
+	*mr_handle = outs[0];
+	*lkey = (u32)outs[2];
 	return hret;
 }
 
@@ -570,23 +518,14 @@ u64 ehea_h_register_rpage_mr(const u64 a
 
 u64 ehea_h_query_ehea(const u64 adapter_handle, void *cb_addr)
 {
-	u64 hret, dummy, cb_logaddr;
+	u64 hret, cb_logaddr;
 
 	cb_logaddr = virt_to_abs(cb_addr);
 
-	hret = ehea_hcall_9arg_9ret(H_QUERY_HEA,
-				    adapter_handle,		/* R4 */
-				    cb_logaddr,			/* R5 */
-				    0, 0, 0, 0, 0, 0, 0,	/* R6-R12 */
-				    &dummy,			/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &dummy,			/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,             	/* R11 */
-				    &dummy);            	/* R12 */
+	hret = ehea_plpar_hcall_norets(H_QUERY_HEA,
+				       adapter_handle,		/* R4 */
+				       cb_logaddr,		/* R5 */
+				       0, 0, 0, 0, 0);		/* R6-R10 */
 #ifdef DEBUG
 	ehea_dmp(cb_addr, sizeof(struct hcp_query_ehea), "hcp_query_ehea");
 #endif
@@ -597,36 +536,28 @@ u64 ehea_h_query_ehea_port(const u64 ada
 			   const u8 cb_cat, const u64 select_mask,
 			   void *cb_addr)
 {
-	u64 port_info, dummy;
+	u64 port_info;
 	u64 cb_logaddr = virt_to_abs(cb_addr);
 	u64 arr_index = 0;
 
 	port_info = EHEA_BMASK_SET(H_MEHEAPORT_CAT, cb_cat)
 		  | EHEA_BMASK_SET(H_MEHEAPORT_PN, port_num);
 
-	return ehea_hcall_9arg_9ret(H_QUERY_HEA_PORT,
-				    adapter_handle,		/* R4 */
-				    port_info,			/* R5 */
-				    select_mask,		/* R6 */
-				    arr_index,			/* R7 */
-				    cb_logaddr,			/* R8 */
-				    0, 0, 0, 0,			/* R9-R12 */
-				    &dummy,			/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &dummy,			/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,                     /* R11 */
-				    &dummy);                    /* R12 */
+	return ehea_plpar_hcall_norets(H_QUERY_HEA_PORT,
+				       adapter_handle,		/* R4 */
+				       port_info,		/* R5 */
+				       select_mask,		/* R6 */
+				       arr_index,		/* R7 */
+				       cb_logaddr,		/* R8 */
+				       0, 0);			/* R9-R10 */
 }
 
 u64 ehea_h_modify_ehea_port(const u64 adapter_handle, const u16 port_num,
 			    const u8 cb_cat, const u64 select_mask,
 			    void *cb_addr)
 {
-	u64 port_info, dummy, inv_attr_ident, proc_mask;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	u64 port_info;
 	u64 arr_index = 0;
 	u64 cb_logaddr = virt_to_abs(cb_addr);
 
@@ -635,29 +566,21 @@ u64 ehea_h_modify_ehea_port(const u64 ad
 #ifdef DEBUG
 	ehea_dump(cb_addr, sizeof(struct hcp_ehea_port_cb0), "Before HCALL");
 #endif
-	return ehea_hcall_9arg_9ret(H_MODIFY_HEA_PORT,
-				    adapter_handle,		/* R4 */
-				    port_info,			/* R5 */
-				    select_mask,		/* R6 */
-				    arr_index,			/* R7 */
-				    cb_logaddr,			/* R8 */
-				    0, 0, 0, 0,			/* R9-R12 */
-				    &inv_attr_ident,		/* R4 */
-				    &proc_mask,			/* R5 */
-				    &dummy,			/* R6 */
-				    &dummy,			/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,                     /* R11 */
-				    &dummy);                    /* R12 */
+	return ehea_plpar_hcall9(H_MODIFY_HEA_PORT,
+				 outs,
+				 adapter_handle,		/* R4 */
+				 port_info,			/* R5 */
+				 select_mask,			/* R6 */
+				 arr_index,			/* R7 */
+				 cb_logaddr,			/* R8 */
+				 0, 0, 0, 0);			/* R9-R12 */
 }
 
 u64 ehea_h_reg_dereg_bcmc(const u64 adapter_handle, const u16 port_num,
 			  const u8 reg_type, const u64 mc_mac_addr,
 			  const u16 vlan_id, const u32 hcall_id)
 {
-	u64 r5_port_num, r6_reg_type, r7_mc_mac_addr, r8_vlan_id, dummy;
+	u64 r5_port_num, r6_reg_type, r7_mc_mac_addr, r8_vlan_id;
 	u64 mac_addr = mc_mac_addr >> 16;
 
 	r5_port_num = EHEA_BMASK_SET(H_REGBCMC_PN, port_num);
@@ -665,41 +588,21 @@ u64 ehea_h_reg_dereg_bcmc(const u64 adap
 	r7_mc_mac_addr = EHEA_BMASK_SET(H_REGBCMC_MACADDR, mac_addr);
 	r8_vlan_id = EHEA_BMASK_SET(H_REGBCMC_VLANID, vlan_id);
 
-	return ehea_hcall_9arg_9ret(hcall_id,
-				    adapter_handle,		/* R4 */
-				    r5_port_num,		/* R5 */
-				    r6_reg_type,		/* R6 */
-				    r7_mc_mac_addr,		/* R7 */
-				    r8_vlan_id,			/* R8 */
-				    0, 0, 0, 0,			/* R9-R12 */
-				    &dummy,			/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &dummy,			/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,                     /* R11 */
-				    &dummy);                    /* R12 */
+	return ehea_plpar_hcall_norets(hcall_id,
+				       adapter_handle,		/* R4 */
+				       r5_port_num,		/* R5 */
+				       r6_reg_type,		/* R6 */
+				       r7_mc_mac_addr,		/* R7 */
+				       r8_vlan_id,		/* R8 */
+				       0, 0);			/* R9-R12 */
 }
 
 u64 ehea_h_reset_events(const u64 adapter_handle, const u64 neq_handle,
 			const u64 event_mask)
 {
-	u64 dummy;
-
-	return ehea_hcall_9arg_9ret(H_RESET_EVENTS,
-				    adapter_handle,		/* R4 */
-				    neq_handle,			/* R5 */
-				    event_mask,			/* R6 */
-				    0, 0, 0, 0, 0, 0,		/* R7-R12 */
-				    &dummy,			/* R4 */
-				    &dummy,			/* R5 */
-				    &dummy,			/* R6 */
-				    &dummy,			/* R7 */
-				    &dummy,			/* R8 */
-				    &dummy,			/* R9 */
-				    &dummy,			/* R10 */
-				    &dummy,                     /* R11 */
-				    &dummy);                    /* R12 */
+	return ehea_plpar_hcall_norets(H_RESET_EVENTS,
+				       adapter_handle,		/* R4 */
+				       neq_handle,		/* R5 */
+				       event_mask,		/* R6 */
+				       0, 0, 0, 0);		/* R7-R12 */
 }
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 99b7a41..c5ed635 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -2497,6 +2497,7 @@ static irqreturn_t nv_nic_irq_tx(int foo
 	u8 __iomem *base = get_hwbase(dev);
 	u32 events;
 	int i;
+	unsigned long flags;
 
 	dprintk(KERN_DEBUG "%s: nv_nic_irq_tx\n", dev->name);
 
@@ -2508,16 +2509,16 @@ static irqreturn_t nv_nic_irq_tx(int foo
 		if (!(events & np->irqmask))
 			break;
 
-		spin_lock_irq(&np->lock);
+		spin_lock_irqsave(&np->lock, flags);
 		nv_tx_done(dev);
-		spin_unlock_irq(&np->lock);
+		spin_unlock_irqrestore(&np->lock, flags);
 
 		if (events & (NVREG_IRQ_TX_ERR)) {
 			dprintk(KERN_DEBUG "%s: received irq with events 0x%x. Probably TX fail.\n",
 						dev->name, events);
 		}
 		if (i > max_interrupt_work) {
-			spin_lock_irq(&np->lock);
+			spin_lock_irqsave(&np->lock, flags);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_TX_ALL, base + NvRegIrqMask);
 			pci_push(base);
@@ -2527,7 +2528,7 @@ static irqreturn_t nv_nic_irq_tx(int foo
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_tx.\n", dev->name, i);
-			spin_unlock_irq(&np->lock);
+			spin_unlock_irqrestore(&np->lock, flags);
 			break;
 		}
 
@@ -2601,6 +2602,7 @@ static irqreturn_t nv_nic_irq_rx(int foo
 	u8 __iomem *base = get_hwbase(dev);
 	u32 events;
 	int i;
+	unsigned long flags;
 
 	dprintk(KERN_DEBUG "%s: nv_nic_irq_rx\n", dev->name);
 
@@ -2614,14 +2616,14 @@ static irqreturn_t nv_nic_irq_rx(int foo
 
 		nv_rx_process(dev, dev->weight);
 		if (nv_alloc_rx(dev)) {
-			spin_lock_irq(&np->lock);
+			spin_lock_irqsave(&np->lock, flags);
 			if (!np->in_shutdown)
 				mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-			spin_unlock_irq(&np->lock);
+			spin_unlock_irqrestore(&np->lock, flags);
 		}
 
 		if (i > max_interrupt_work) {
-			spin_lock_irq(&np->lock);
+			spin_lock_irqsave(&np->lock, flags);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_RX_ALL, base + NvRegIrqMask);
 			pci_push(base);
@@ -2631,7 +2633,7 @@ static irqreturn_t nv_nic_irq_rx(int foo
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_rx.\n", dev->name, i);
-			spin_unlock_irq(&np->lock);
+			spin_unlock_irqrestore(&np->lock, flags);
 			break;
 		}
 	}
@@ -2648,6 +2650,7 @@ static irqreturn_t nv_nic_irq_other(int 
 	u8 __iomem *base = get_hwbase(dev);
 	u32 events;
 	int i;
+	unsigned long flags;
 
 	dprintk(KERN_DEBUG "%s: nv_nic_irq_other\n", dev->name);
 
@@ -2660,14 +2663,14 @@ static irqreturn_t nv_nic_irq_other(int 
 			break;
 
 		if (events & NVREG_IRQ_LINK) {
-			spin_lock_irq(&np->lock);
+			spin_lock_irqsave(&np->lock, flags);
 			nv_link_irq(dev);
-			spin_unlock_irq(&np->lock);
+			spin_unlock_irqrestore(&np->lock, flags);
 		}
 		if (np->need_linktimer && time_after(jiffies, np->link_timeout)) {
-			spin_lock_irq(&np->lock);
+			spin_lock_irqsave(&np->lock, flags);
 			nv_linkchange(dev);
-			spin_unlock_irq(&np->lock);
+			spin_unlock_irqrestore(&np->lock, flags);
 			np->link_timeout = jiffies + LINK_TIMEOUT;
 		}
 		if (events & (NVREG_IRQ_UNKNOWN)) {
@@ -2675,7 +2678,7 @@ static irqreturn_t nv_nic_irq_other(int 
 						dev->name, events);
 		}
 		if (i > max_interrupt_work) {
-			spin_lock_irq(&np->lock);
+			spin_lock_irqsave(&np->lock, flags);
 			/* disable interrupts on the nic */
 			writel(NVREG_IRQ_OTHER, base + NvRegIrqMask);
 			pci_push(base);
@@ -2685,7 +2688,7 @@ static irqreturn_t nv_nic_irq_other(int 
 				mod_timer(&np->nic_poll, jiffies + POLL_WAIT);
 			}
 			printk(KERN_DEBUG "%s: too many iterations (%d) in nv_nic_irq_other.\n", dev->name, i);
-			spin_unlock_irq(&np->lock);
+			spin_unlock_irqrestore(&np->lock, flags);
 			break;
 		}
 
diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
index 4bac3cd..2802db2 100644
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -213,6 +213,7 @@ static void ibmveth_replenish_buffer_poo
 		}
 
 		free_index = pool->consumer_index++ % pool->size;
+		pool->consumer_index = free_index;
 		index = pool->free_map[free_index];
 
 		ibmveth_assert(index != IBM_VETH_INVALID_MAP);
@@ -238,7 +239,10 @@ static void ibmveth_replenish_buffer_poo
 		if(lpar_rc != H_SUCCESS) {
 			pool->free_map[free_index] = index;
 			pool->skbuff[index] = NULL;
-			pool->consumer_index--;
+			if (pool->consumer_index == 0)
+				pool->consumer_index = pool->size - 1;
+			else
+				pool->consumer_index--;
 			dma_unmap_single(&adapter->vdev->dev,
 					pool->dma_addr[index], pool->buff_size,
 					DMA_FROM_DEVICE);
@@ -326,6 +330,7 @@ static void ibmveth_remove_buffer_from_p
 			 DMA_FROM_DEVICE);
 
 	free_index = adapter->rx_buff_pool[pool].producer_index++ % adapter->rx_buff_pool[pool].size;
+	adapter->rx_buff_pool[pool].producer_index = free_index;
 	adapter->rx_buff_pool[pool].free_map[free_index] = index;
 
 	mb();
@@ -437,6 +442,31 @@ static void ibmveth_cleanup(struct ibmve
 						 &adapter->rx_buff_pool[i]);
 }
 
+static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
+        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+{
+	int rc, try_again = 1;
+
+	/* After a kexec the adapter will still be open, so our attempt to
+	* open it will fail. So if we get a failure we free the adapter and
+	* try again, but only once. */
+retry:
+	rc = h_register_logical_lan(adapter->vdev->unit_address,
+				    adapter->buffer_list_dma, rxq_desc.desc,
+				    adapter->filter_list_dma, mac_address);
+
+	if (rc != H_SUCCESS && try_again) {
+		do {
+			rc = h_free_logical_lan(adapter->vdev->unit_address);
+		} while (H_IS_LONG_BUSY(rc) || (rc == H_BUSY));
+
+		try_again = 0;
+		goto retry;
+	}
+
+	return rc;
+}
+
 static int ibmveth_open(struct net_device *netdev)
 {
 	struct ibmveth_adapter *adapter = netdev->priv;
@@ -502,12 +532,9 @@ static int ibmveth_open(struct net_devic
 	ibmveth_debug_printk("filter list @ 0x%p\n", adapter->filter_list_addr);
 	ibmveth_debug_printk("receive q   @ 0x%p\n", adapter->rx_queue.queue_addr);
 
+	h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_DISABLE);
 
-	lpar_rc = h_register_logical_lan(adapter->vdev->unit_address,
-					 adapter->buffer_list_dma,
-					 rxq_desc.desc,
-					 adapter->filter_list_dma,
-					 mac_address);
+	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
 
 	if(lpar_rc != H_SUCCESS) {
 		ibmveth_error_printk("h_register_logical_lan failed with %ld\n", lpar_rc);
@@ -905,6 +932,14 @@ static int ibmveth_change_mtu(struct net
 	return -EINVAL;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void ibmveth_poll_controller(struct net_device *dev)
+{
+	ibmveth_replenish_task(dev->priv);
+	ibmveth_interrupt(dev->irq, dev);
+}
+#endif
+
 static int __devinit ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 {
 	int rc, i;
@@ -977,6 +1012,9 @@ static int __devinit ibmveth_probe(struc
 	netdev->ethtool_ops           = &netdev_ethtool_ops;
 	netdev->change_mtu         = ibmveth_change_mtu;
 	SET_NETDEV_DEV(netdev, &dev->dev);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	netdev->poll_controller = ibmveth_poll_controller;
+#endif
  	netdev->features |= NETIF_F_LLTX;
 	spin_lock_init(&adapter->stats_lock);
 
@@ -1132,7 +1170,9 @@ static void ibmveth_proc_register_adapte
 {
 	struct proc_dir_entry *entry;
 	if (ibmveth_proc_dir) {
-		entry = create_proc_entry(adapter->netdev->name, S_IFREG, ibmveth_proc_dir);
+		char u_addr[10];
+		sprintf(u_addr, "%x", adapter->vdev->unit_address);
+		entry = create_proc_entry(u_addr, S_IFREG, ibmveth_proc_dir);
 		if (!entry) {
 			ibmveth_error_printk("Cannot create adapter proc entry");
 		} else {
@@ -1147,7 +1187,9 @@ static void ibmveth_proc_register_adapte
 static void ibmveth_proc_unregister_adapter(struct ibmveth_adapter *adapter)
 {
 	if (ibmveth_proc_dir) {
-		remove_proc_entry(adapter->netdev->name, ibmveth_proc_dir);
+		char u_addr[10];
+		sprintf(u_addr, "%x", adapter->vdev->unit_address);
+		remove_proc_entry(u_addr, ibmveth_proc_dir);
 	}
 }
 
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 2ffa3a5..9997081 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -2155,7 +2155,7 @@ static void eth_update_mib_counters(stru
 	for (offset = ETH_MIB_BAD_OCTETS_RECEIVED;
 			offset <= ETH_MIB_FRAMES_1024_TO_MAX_OCTETS;
 			offset += 4)
-		*(u32 *)((char *)p + offset) = read_mib(mp, offset);
+		*(u32 *)((char *)p + offset) += read_mib(mp, offset);
 
 	p->good_octets_sent += read_mib(mp, ETH_MIB_GOOD_OCTETS_SENT_LOW);
 	p->good_octets_sent +=
@@ -2164,7 +2164,7 @@ static void eth_update_mib_counters(stru
 	for (offset = ETH_MIB_GOOD_FRAMES_SENT;
 			offset <= ETH_MIB_LATE_COLLISION;
 			offset += 4)
-		*(u32 *)((char *)p + offset) = read_mib(mp, offset);
+		*(u32 *)((char *)p + offset) += read_mib(mp, offset);
 }
 
 /*
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index a4a58e4..e7e4149 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -43,7 +43,7 @@ #include <asm/irq.h>
 #include "skge.h"
 
 #define DRV_NAME		"skge"
-#define DRV_VERSION		"1.8"
+#define DRV_VERSION		"1.9"
 #define PFX			DRV_NAME " "
 
 #define DEFAULT_TX_RING_SIZE	128
@@ -197,8 +197,8 @@ static u32 skge_supported_modes(const st
 		else if (hw->chip_id == CHIP_ID_YUKON)
 			supported &= ~SUPPORTED_1000baseT_Half;
 	} else
-		supported = SUPPORTED_1000baseT_Full | SUPPORTED_FIBRE
-			| SUPPORTED_Autoneg;
+		supported = SUPPORTED_1000baseT_Full | SUPPORTED_1000baseT_Half
+			| SUPPORTED_FIBRE | SUPPORTED_Autoneg;
 
 	return supported;
 }
@@ -487,31 +487,37 @@ static void skge_get_pauseparam(struct n
 {
 	struct skge_port *skge = netdev_priv(dev);
 
-	ecmd->tx_pause = (skge->flow_control == FLOW_MODE_LOC_SEND)
-		|| (skge->flow_control == FLOW_MODE_SYMMETRIC);
-	ecmd->rx_pause = (skge->flow_control == FLOW_MODE_REM_SEND)
-		|| (skge->flow_control == FLOW_MODE_SYMMETRIC);
+	ecmd->rx_pause = (skge->flow_control == FLOW_MODE_SYMMETRIC)
+		|| (skge->flow_control == FLOW_MODE_SYM_OR_REM);
+	ecmd->tx_pause = ecmd->rx_pause || (skge->flow_control == FLOW_MODE_LOC_SEND);
 
-	ecmd->autoneg = skge->autoneg;
+	ecmd->autoneg = ecmd->rx_pause || ecmd->tx_pause;
 }
 
 static int skge_set_pauseparam(struct net_device *dev,
 			       struct ethtool_pauseparam *ecmd)
 {
 	struct skge_port *skge = netdev_priv(dev);
+	struct ethtool_pauseparam old;
 
-	skge->autoneg = ecmd->autoneg;
-	if (ecmd->rx_pause && ecmd->tx_pause)
-		skge->flow_control = FLOW_MODE_SYMMETRIC;
-	else if (ecmd->rx_pause && !ecmd->tx_pause)
-		skge->flow_control = FLOW_MODE_REM_SEND;
-	else if (!ecmd->rx_pause && ecmd->tx_pause)
-		skge->flow_control = FLOW_MODE_LOC_SEND;
-	else
-		skge->flow_control = FLOW_MODE_NONE;
+	skge_get_pauseparam(dev, &old);
+
+	if (ecmd->autoneg != old.autoneg)
+		skge->flow_control = ecmd->autoneg ? FLOW_MODE_NONE : FLOW_MODE_SYMMETRIC;
+	else {
+		if (ecmd->rx_pause && ecmd->tx_pause)
+			skge->flow_control = FLOW_MODE_SYMMETRIC;
+		else if (ecmd->rx_pause && !ecmd->tx_pause)
+			skge->flow_control = FLOW_MODE_SYM_OR_REM;
+		else if (!ecmd->rx_pause && ecmd->tx_pause)
+			skge->flow_control = FLOW_MODE_LOC_SEND;
+		else
+			skge->flow_control = FLOW_MODE_NONE;
+	}
 
 	if (netif_running(dev))
 		skge_phy_reset(skge);
+
 	return 0;
 }
 
@@ -854,6 +860,23 @@ static int skge_rx_fill(struct net_devic
 	return 0;
 }
 
+static const char *skge_pause(enum pause_status status)
+{
+	switch(status) {
+	case FLOW_STAT_NONE:
+		return "none";
+	case FLOW_STAT_REM_SEND:
+		return "rx only";
+	case FLOW_STAT_LOC_SEND:
+		return "tx_only";
+	case FLOW_STAT_SYMMETRIC:		/* Both station may send PAUSE */
+		return "both";
+	default:
+		return "indeterminated";
+	}
+}
+
+
 static void skge_link_up(struct skge_port *skge)
 {
 	skge_write8(skge->hw, SK_REG(skge->port, LNK_LED_REG),
@@ -862,16 +885,13 @@ static void skge_link_up(struct skge_por
 	netif_carrier_on(skge->netdev);
 	netif_wake_queue(skge->netdev);
 
-	if (netif_msg_link(skge))
+	if (netif_msg_link(skge)) {
 		printk(KERN_INFO PFX
 		       "%s: Link is up at %d Mbps, %s duplex, flow control %s\n",
 		       skge->netdev->name, skge->speed,
 		       skge->duplex == DUPLEX_FULL ? "full" : "half",
-		       (skge->flow_control == FLOW_MODE_NONE) ? "none" :
-		       (skge->flow_control == FLOW_MODE_LOC_SEND) ? "tx only" :
-		       (skge->flow_control == FLOW_MODE_REM_SEND) ? "rx only" :
-		       (skge->flow_control == FLOW_MODE_SYMMETRIC) ? "tx and rx" :
-		       "unknown");
+		       skge_pause(skge->flow_status));
+	}
 }
 
 static void skge_link_down(struct skge_port *skge)
@@ -884,6 +904,29 @@ static void skge_link_down(struct skge_p
 		printk(KERN_INFO PFX "%s: Link is down.\n", skge->netdev->name);
 }
 
+
+static void xm_link_down(struct skge_hw *hw, int port)
+{
+	struct net_device *dev = hw->dev[port];
+	struct skge_port *skge = netdev_priv(dev);
+	u16 cmd, msk;
+
+	if (hw->phy_type == SK_PHY_XMAC) {
+		msk = xm_read16(hw, port, XM_IMSK);
+		msk |= XM_IS_INP_ASS | XM_IS_LIPA_RC | XM_IS_RX_PAGE | XM_IS_AND;
+		xm_write16(hw, port, XM_IMSK, msk);
+	}
+
+	cmd = xm_read16(hw, port, XM_MMU_CMD);
+	cmd &= ~(XM_MMU_ENA_RX | XM_MMU_ENA_TX);
+	xm_write16(hw, port, XM_MMU_CMD, cmd);
+	/* dummy read to ensure writing */
+	(void) xm_read16(hw, port, XM_MMU_CMD);
+
+	if (netif_carrier_ok(dev))
+		skge_link_down(skge);
+}
+
 static int __xm_phy_read(struct skge_hw *hw, int port, u16 reg, u16 *val)
 {
 	int i;
@@ -992,7 +1035,15 @@ static const u16 phy_pause_map[] = {
 	[FLOW_MODE_NONE] =	0,
 	[FLOW_MODE_LOC_SEND] =	PHY_AN_PAUSE_ASYM,
 	[FLOW_MODE_SYMMETRIC] = PHY_AN_PAUSE_CAP,
-	[FLOW_MODE_REM_SEND]  = PHY_AN_PAUSE_CAP | PHY_AN_PAUSE_ASYM,
+	[FLOW_MODE_SYM_OR_REM]  = PHY_AN_PAUSE_CAP | PHY_AN_PAUSE_ASYM,
+};
+
+/* special defines for FIBER (88E1011S only) */
+static const u16 fiber_pause_map[] = {
+	[FLOW_MODE_NONE]	= PHY_X_P_NO_PAUSE,
+	[FLOW_MODE_LOC_SEND]	= PHY_X_P_ASYM_MD,
+	[FLOW_MODE_SYMMETRIC]	= PHY_X_P_SYM_MD,
+	[FLOW_MODE_SYM_OR_REM]	= PHY_X_P_BOTH_MD,
 };
 
 
@@ -1008,14 +1059,7 @@ static void bcom_check_link(struct skge_
 	status = xm_phy_read(hw, port, PHY_BCOM_STAT);
 
 	if ((status & PHY_ST_LSYNC) == 0) {
-		u16 cmd = xm_read16(hw, port, XM_MMU_CMD);
-		cmd &= ~(XM_MMU_ENA_RX | XM_MMU_ENA_TX);
-		xm_write16(hw, port, XM_MMU_CMD, cmd);
-		/* dummy read to ensure writing */
-		(void) xm_read16(hw, port, XM_MMU_CMD);
-
-		if (netif_carrier_ok(dev))
-			skge_link_down(skge);
+		xm_link_down(hw, port);
 		return;
 	}
 
@@ -1048,20 +1092,19 @@ static void bcom_check_link(struct skge_
 			return;
 		}
 
-
 		/* We are using IEEE 802.3z/D5.0 Table 37-4 */
 		switch (aux & PHY_B_AS_PAUSE_MSK) {
 		case PHY_B_AS_PAUSE_MSK:
-			skge->flow_control = FLOW_MODE_SYMMETRIC;
+			skge->flow_status = FLOW_STAT_SYMMETRIC;
 			break;
 		case PHY_B_AS_PRR:
-			skge->flow_control = FLOW_MODE_REM_SEND;
+			skge->flow_status = FLOW_STAT_REM_SEND;
 			break;
 		case PHY_B_AS_PRT:
-			skge->flow_control = FLOW_MODE_LOC_SEND;
+			skge->flow_status = FLOW_STAT_LOC_SEND;
 			break;
 		default:
-			skge->flow_control = FLOW_MODE_NONE;
+			skge->flow_status = FLOW_STAT_NONE;
 		}
 		skge->speed = SPEED_1000;
 	}
@@ -1191,17 +1234,7 @@ static void xm_phy_init(struct skge_port
 		if (skge->advertising & ADVERTISED_1000baseT_Full)
 			ctrl |= PHY_X_AN_FD;
 
-		switch(skge->flow_control) {
-		case FLOW_MODE_NONE:
-			ctrl |= PHY_X_P_NO_PAUSE;
-			break;
-		case FLOW_MODE_LOC_SEND:
-			ctrl |= PHY_X_P_ASYM_MD;
-			break;
-		case FLOW_MODE_SYMMETRIC:
-			ctrl |= PHY_X_P_BOTH_MD;
-			break;
-		}
+		ctrl |= fiber_pause_map[skge->flow_control];
 
 		xm_phy_write(hw, port, PHY_XMAC_AUNE_ADV, ctrl);
 
@@ -1235,14 +1268,7 @@ static void xm_check_link(struct net_dev
 	status = xm_phy_read(hw, port, PHY_XMAC_STAT);
 
 	if ((status & PHY_ST_LSYNC) == 0) {
-		u16 cmd = xm_read16(hw, port, XM_MMU_CMD);
-		cmd &= ~(XM_MMU_ENA_RX | XM_MMU_ENA_TX);
-		xm_write16(hw, port, XM_MMU_CMD, cmd);
-		/* dummy read to ensure writing */
-		(void) xm_read16(hw, port, XM_MMU_CMD);
-
-		if (netif_carrier_ok(dev))
-			skge_link_down(skge);
+		xm_link_down(hw, port);
 		return;
 	}
 
@@ -1276,15 +1302,20 @@ static void xm_check_link(struct net_dev
 		}
 
 		/* We are using IEEE 802.3z/D5.0 Table 37-4 */
-		if (lpa & PHY_X_P_SYM_MD)
-			skge->flow_control = FLOW_MODE_SYMMETRIC;
-		else if ((lpa & PHY_X_RS_PAUSE) == PHY_X_P_ASYM_MD)
-			skge->flow_control = FLOW_MODE_REM_SEND;
-		else if ((lpa & PHY_X_RS_PAUSE) == PHY_X_P_BOTH_MD)
-			skge->flow_control = FLOW_MODE_LOC_SEND;
+		if ((skge->flow_control == FLOW_MODE_SYMMETRIC ||
+		     skge->flow_control == FLOW_MODE_SYM_OR_REM) &&
+		    (lpa & PHY_X_P_SYM_MD))
+			skge->flow_status = FLOW_STAT_SYMMETRIC;
+		else if (skge->flow_control == FLOW_MODE_SYM_OR_REM &&
+			 (lpa & PHY_X_RS_PAUSE) == PHY_X_P_ASYM_MD)
+			/* Enable PAUSE receive, disable PAUSE transmit */
+			skge->flow_status  = FLOW_STAT_REM_SEND;
+		else if (skge->flow_control == FLOW_MODE_LOC_SEND &&
+			 (lpa & PHY_X_RS_PAUSE) == PHY_X_P_BOTH_MD)
+			/* Disable PAUSE receive, enable PAUSE transmit */
+			skge->flow_status = FLOW_STAT_LOC_SEND;
 		else
-			skge->flow_control = FLOW_MODE_NONE;
-
+			skge->flow_status = FLOW_STAT_NONE;
 
 		skge->speed = SPEED_1000;
 	}
@@ -1568,6 +1599,10 @@ static void genesis_mac_intr(struct skge
 		printk(KERN_DEBUG PFX "%s: mac interrupt status 0x%x\n",
 		       skge->netdev->name, status);
 
+	if (hw->phy_type == SK_PHY_XMAC &&
+	    (status & (XM_IS_INP_ASS | XM_IS_LIPA_RC)))
+		xm_link_down(hw, port);
+
 	if (status & XM_IS_TXF_UR) {
 		xm_write32(hw, port, XM_MODE, XM_MD_FTF);
 		++skge->net_stats.tx_fifo_errors;
@@ -1582,7 +1617,7 @@ static void genesis_link_up(struct skge_
 {
 	struct skge_hw *hw = skge->hw;
 	int port = skge->port;
-	u16 cmd;
+	u16 cmd, msk;
 	u32 mode;
 
 	cmd = xm_read16(hw, port, XM_MMU_CMD);
@@ -1591,8 +1626,8 @@ static void genesis_link_up(struct skge_
 	 * enabling pause frame reception is required for 1000BT
 	 * because the XMAC is not reset if the link is going down
 	 */
-	if (skge->flow_control == FLOW_MODE_NONE ||
-	    skge->flow_control == FLOW_MODE_LOC_SEND)
+	if (skge->flow_status == FLOW_STAT_NONE ||
+	    skge->flow_status == FLOW_STAT_LOC_SEND)
 		/* Disable Pause Frame Reception */
 		cmd |= XM_MMU_IGN_PF;
 	else
@@ -1602,8 +1637,8 @@ static void genesis_link_up(struct skge_
 	xm_write16(hw, port, XM_MMU_CMD, cmd);
 
 	mode = xm_read32(hw, port, XM_MODE);
-	if (skge->flow_control == FLOW_MODE_SYMMETRIC ||
-	    skge->flow_control == FLOW_MODE_LOC_SEND) {
+	if (skge->flow_status== FLOW_STAT_SYMMETRIC ||
+	    skge->flow_status == FLOW_STAT_LOC_SEND) {
 		/*
 		 * Configure Pause Frame Generation
 		 * Use internal and external Pause Frame Generation.
@@ -1631,7 +1666,11 @@ static void genesis_link_up(struct skge_
 	}
 
 	xm_write32(hw, port, XM_MODE, mode);
-	xm_write16(hw, port, XM_IMSK, XM_DEF_MSK);
+	msk = XM_DEF_MSK;
+	if (hw->phy_type != SK_PHY_XMAC)
+		msk |= XM_IS_INP_ASS;	/* disable GP0 interrupt bit */
+
+	xm_write16(hw, port, XM_IMSK, msk);
 	xm_read16(hw, port, XM_ISRC);
 
 	/* get MMU Command Reg. */
@@ -1779,11 +1818,17 @@ static void yukon_init(struct skge_hw *h
 				adv |= PHY_M_AN_10_FD;
 			if (skge->advertising & ADVERTISED_10baseT_Half)
 				adv |= PHY_M_AN_10_HD;
-		} else	/* special defines for FIBER (88E1011S only) */
-			adv |= PHY_M_AN_1000X_AHD | PHY_M_AN_1000X_AFD;
 
-		/* Set Flow-control capabilities */
-		adv |= phy_pause_map[skge->flow_control];
+			/* Set Flow-control capabilities */
+			adv |= phy_pause_map[skge->flow_control];
+		} else {
+			if (skge->advertising & ADVERTISED_1000baseT_Full)
+				adv |= PHY_M_AN_1000X_AFD;
+			if (skge->advertising & ADVERTISED_1000baseT_Half)
+				adv |= PHY_M_AN_1000X_AHD;
+
+			adv |= fiber_pause_map[skge->flow_control];
+		}
 
 		/* Restart Auto-negotiation */
 		ctrl |= PHY_CT_ANE | PHY_CT_RE_CFG;
@@ -1917,6 +1962,11 @@ static void yukon_mac_init(struct skge_h
 	case FLOW_MODE_LOC_SEND:
 		/* disable Rx flow-control */
 		reg |= GM_GPCR_FC_RX_DIS | GM_GPCR_AU_FCT_DIS;
+		break;
+	case FLOW_MODE_SYMMETRIC:
+	case FLOW_MODE_SYM_OR_REM:
+		/* enable Tx & Rx flow-control */
+		break;
 	}
 
 	gma_write16(hw, port, GM_GP_CTRL, reg);
@@ -2111,13 +2161,11 @@ static void yukon_link_down(struct skge_
 	ctrl &= ~(GM_GPCR_RX_ENA | GM_GPCR_TX_ENA);
 	gma_write16(hw, port, GM_GP_CTRL, ctrl);
 
-	if (skge->flow_control == FLOW_MODE_REM_SEND) {
+	if (skge->flow_status == FLOW_STAT_REM_SEND) {
+		ctrl = gm_phy_read(hw, port, PHY_MARV_AUNE_ADV);
+		ctrl |= PHY_M_AN_ASP;
 		/* restore Asymmetric Pause bit */
-		gm_phy_write(hw, port, PHY_MARV_AUNE_ADV,
-				  gm_phy_read(hw, port,
-						   PHY_MARV_AUNE_ADV)
-				  | PHY_M_AN_ASP);
-
+		gm_phy_write(hw, port, PHY_MARV_AUNE_ADV, ctrl);
 	}
 
 	yukon_reset(hw, port);
@@ -2164,19 +2212,19 @@ static void yukon_phy_intr(struct skge_p
 		/* We are using IEEE 802.3z/D5.0 Table 37-4 */
 		switch (phystat & PHY_M_PS_PAUSE_MSK) {
 		case PHY_M_PS_PAUSE_MSK:
-			skge->flow_control = FLOW_MODE_SYMMETRIC;
+			skge->flow_status = FLOW_STAT_SYMMETRIC;
 			break;
 		case PHY_M_PS_RX_P_EN:
-			skge->flow_control = FLOW_MODE_REM_SEND;
+			skge->flow_status = FLOW_STAT_REM_SEND;
 			break;
 		case PHY_M_PS_TX_P_EN:
-			skge->flow_control = FLOW_MODE_LOC_SEND;
+			skge->flow_status = FLOW_STAT_LOC_SEND;
 			break;
 		default:
-			skge->flow_control = FLOW_MODE_NONE;
+			skge->flow_status = FLOW_STAT_NONE;
 		}
 
-		if (skge->flow_control == FLOW_MODE_NONE ||
+		if (skge->flow_status == FLOW_STAT_NONE ||
 		    (skge->speed < SPEED_1000 && skge->duplex == DUPLEX_HALF))
 			skge_write8(hw, SK_REG(port, GMAC_CTRL), GMC_PAUSE_OFF);
 		else
@@ -3399,7 +3447,7 @@ #endif
 
 	/* Auto speed and flow control */
 	skge->autoneg = AUTONEG_ENABLE;
-	skge->flow_control = FLOW_MODE_SYMMETRIC;
+	skge->flow_control = FLOW_MODE_SYM_OR_REM;
 	skge->duplex = -1;
 	skge->speed = -1;
 	skge->advertising = skge_supported_modes(hw);
diff --git a/drivers/net/skge.h b/drivers/net/skge.h
index d0b47d4..537c0aa 100644
--- a/drivers/net/skge.h
+++ b/drivers/net/skge.h
@@ -2195,7 +2195,8 @@ enum {
 	XM_IS_RX_COMP	= 1<<0,	/* Bit  0:	Frame Rx Complete */
 };
 
-#define XM_DEF_MSK	(~(XM_IS_RXC_OV | XM_IS_TXC_OV | XM_IS_RXF_OV | XM_IS_TXF_UR))
+#define XM_DEF_MSK	(~(XM_IS_INP_ASS | XM_IS_LIPA_RC | \
+			   XM_IS_RXF_OV | XM_IS_TXF_UR))
 
 
 /*	XM_HW_CFG	16 bit r/w	Hardware Config Register */
@@ -2426,13 +2427,24 @@ struct skge_hw {
 	struct mutex	     phy_mutex;
 };
 
-enum {
-	FLOW_MODE_NONE 		= 0, /* No Flow-Control */
-	FLOW_MODE_LOC_SEND	= 1, /* Local station sends PAUSE */
-	FLOW_MODE_REM_SEND	= 2, /* Symmetric or just remote */
+enum pause_control {
+	FLOW_MODE_NONE 		= 1, /* No Flow-Control */
+	FLOW_MODE_LOC_SEND	= 2, /* Local station sends PAUSE */
 	FLOW_MODE_SYMMETRIC	= 3, /* Both stations may send PAUSE */
+	FLOW_MODE_SYM_OR_REM	= 4, /* Both stations may send PAUSE or
+				      * just the remote station may send PAUSE
+				      */
+};
+
+enum pause_status {
+	FLOW_STAT_INDETERMINATED=0,	/* indeterminated */
+	FLOW_STAT_NONE,			/* No Flow Control */
+	FLOW_STAT_REM_SEND,		/* Remote Station sends PAUSE */
+	FLOW_STAT_LOC_SEND,		/* Local station sends PAUSE */
+	FLOW_STAT_SYMMETRIC,		/* Both station may send PAUSE */
 };
 
+
 struct skge_port {
 	u32		     msg_enable;
 	struct skge_hw	     *hw;
@@ -2445,9 +2457,10 @@ struct skge_port {
 	struct net_device_stats net_stats;
 
 	struct work_struct   link_thread;
+	enum pause_control   flow_control;
+	enum pause_status    flow_status;
 	u8		     rx_csum;
 	u8		     blink_on;
-	u8		     flow_control;
 	u8		     wol;
 	u8		     autoneg;	/* AUTONEG_ENABLE, AUTONEG_DISABLE */
 	u8		     duplex;	/* DUPLEX_HALF, DUPLEX_FULL */
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 459c845..c10e7f5 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -683,7 +683,7 @@ static void sky2_mac_init(struct sky2_hw
 	sky2_write16(hw, SK_REG(port, TX_GMF_CTRL_T), GMF_OPER_ON);
 
 	if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
-		sky2_write8(hw, SK_REG(port, RX_GMF_LP_THR), 768/8);
+		sky2_write8(hw, SK_REG(port, RX_GMF_LP_THR), 512/8);
 		sky2_write8(hw, SK_REG(port, RX_GMF_UP_THR), 1024/8);
 		if (hw->dev[port]->mtu > ETH_DATA_LEN) {
 			/* set Tx GMAC FIFO Almost Empty Threshold */
@@ -1907,7 +1907,7 @@ static struct sk_buff *receive_copy(stru
 		pci_dma_sync_single_for_device(sky2->hw->pdev, re->data_addr,
 					       length, PCI_DMA_FROMDEVICE);
 		re->skb->ip_summed = CHECKSUM_NONE;
-		__skb_put(skb, length);
+		skb_put(skb, length);
 	}
 	return skb;
 }
@@ -1970,7 +1970,7 @@ static struct sk_buff *receive_new(struc
 	if (skb_shinfo(skb)->nr_frags)
 		skb_put_frags(skb, hdr_space, length);
 	else
-		skb_put(skb, hdr_space);
+		skb_put(skb, length);
 	return skb;
 }
 
@@ -2220,8 +2220,7 @@ static void sky2_hw_intr(struct sky2_hw 
 		/* PCI-Express uncorrectable Error occurred */
 		u32 pex_err;
 
-		pex_err = sky2_pci_read32(hw,
-					  hw->err_cap + PCI_ERR_UNCOR_STATUS);
+		pex_err = sky2_pci_read32(hw, PEX_UNC_ERR_STAT);
 
 		if (net_ratelimit())
 			printk(KERN_ERR PFX "%s: pci express error (0x%x)\n",
@@ -2229,20 +2228,15 @@ static void sky2_hw_intr(struct sky2_hw 
 
 		/* clear the interrupt */
 		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		sky2_pci_write32(hw,
-				 hw->err_cap + PCI_ERR_UNCOR_STATUS,
-				 0xffffffffUL);
+		sky2_pci_write32(hw, PEX_UNC_ERR_STAT,
+				       0xffffffffUL);
 		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 
-
-		/* In case of fatal error mask off to keep from getting stuck */
-		if (pex_err & (PCI_ERR_UNC_POISON_TLP | PCI_ERR_UNC_FCP
-			       | PCI_ERR_UNC_DLP)) {
+		if (pex_err & PEX_FATAL_ERRORS) {
 			u32 hwmsk = sky2_read32(hw, B0_HWE_IMSK);
 			hwmsk &= ~Y2_IS_PCI_EXP;
 			sky2_write32(hw, B0_HWE_IMSK, hwmsk);
 		}
-
 	}
 
 	if (status & Y2_HWE_L1_MASK)
@@ -2423,7 +2417,6 @@ static int sky2_reset(struct sky2_hw *hw
 	u16 status;
 	u8 t8;
 	int i;
-	u32 msk;
 
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
 
@@ -2464,13 +2457,9 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
 
 	/* clear any PEX errors */
-	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) {
-		hw->err_cap = pci_find_ext_capability(hw->pdev, PCI_EXT_CAP_ID_ERR);
-		if (hw->err_cap)
-			sky2_pci_write32(hw,
-					 hw->err_cap + PCI_ERR_UNCOR_STATUS,
-					 0xffffffffUL);
-	}
+	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP))
+		sky2_pci_write32(hw, PEX_UNC_ERR_STAT, 0xffffffffUL);
+
 
 	hw->pmd_type = sky2_read8(hw, B2_PMD_TYP);
 	hw->ports = 1;
@@ -2527,10 +2516,7 @@ static int sky2_reset(struct sky2_hw *hw
 		sky2_write8(hw, RAM_BUFFER(i, B3_RI_RTO_XS2), SK_RI_TO_53);
 	}
 
-	msk = Y2_HWE_ALL_MASK;
-	if (!hw->err_cap)
-		msk &= ~Y2_IS_PCI_EXP;
-	sky2_write32(hw, B0_HWE_IMSK, msk);
+	sky2_write32(hw, B0_HWE_IMSK, Y2_HWE_ALL_MASK);
 
 	for (i = 0; i < hw->ports; i++)
 		sky2_gmac_reset(hw, i);
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index f66109a..43d2acc 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -6,15 +6,24 @@ #define _SKY2_H
 
 #define ETH_JUMBO_MTU		9000	/* Maximum MTU supported */
 
-/* PCI device specific config registers */
+/* PCI config registers */
 enum {
 	PCI_DEV_REG1	= 0x40,
 	PCI_DEV_REG2	= 0x44,
+	PCI_DEV_STATUS  = 0x7c,
 	PCI_DEV_REG3	= 0x80,
 	PCI_DEV_REG4	= 0x84,
 	PCI_DEV_REG5    = 0x88,
 };
 
+enum {
+	PEX_DEV_CAP	= 0xe4,
+	PEX_DEV_CTRL	= 0xe8,
+	PEX_DEV_STA	= 0xea,
+	PEX_LNK_STAT	= 0xf2,
+	PEX_UNC_ERR_STAT= 0x104,
+};
+
 /* Yukon-2 */
 enum pci_dev_reg_1 {
 	PCI_Y2_PIG_ENA	 = 1<<31, /* Enable Plug-in-Go (YUKON-2) */
@@ -63,6 +72,39 @@ #define PCI_STATUS_ERROR_BITS (PCI_STATU
 			       PCI_STATUS_REC_MASTER_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
+
+enum pex_dev_ctrl {
+	PEX_DC_MAX_RRS_MSK	= 7<<12, /* Bit 14..12:	Max. Read Request Size */
+	PEX_DC_EN_NO_SNOOP	= 1<<11,/* Enable No Snoop */
+	PEX_DC_EN_AUX_POW	= 1<<10,/* Enable AUX Power */
+	PEX_DC_EN_PHANTOM	= 1<<9,	/* Enable Phantom Functions */
+	PEX_DC_EN_EXT_TAG	= 1<<8,	/* Enable Extended Tag Field */
+	PEX_DC_MAX_PLS_MSK	= 7<<5,	/* Bit  7.. 5:	Max. Payload Size Mask */
+	PEX_DC_EN_REL_ORD	= 1<<4,	/* Enable Relaxed Ordering */
+	PEX_DC_EN_UNS_RQ_RP	= 1<<3,	/* Enable Unsupported Request Reporting */
+	PEX_DC_EN_FAT_ER_RP	= 1<<2,	/* Enable Fatal Error Reporting */
+	PEX_DC_EN_NFA_ER_RP	= 1<<1,	/* Enable Non-Fatal Error Reporting */
+	PEX_DC_EN_COR_ER_RP	= 1<<0,	/* Enable Correctable Error Reporting */
+};
+#define  PEX_DC_MAX_RD_RQ_SIZE(x) (((x)<<12) & PEX_DC_MAX_RRS_MSK)
+
+/* PEX_UNC_ERR_STAT	 PEX Uncorrectable Errors Status Register (Yukon-2) */
+enum pex_err {
+	PEX_UNSUP_REQ 	= 1<<20, /* Unsupported Request Error */
+
+	PEX_MALFOR_TLP	= 1<<18, /* Malformed TLP */
+
+	PEX_UNEXP_COMP	= 1<<16, /* Unexpected Completion */
+
+	PEX_COMP_TO	= 1<<14, /* Completion Timeout */
+	PEX_FLOW_CTRL_P	= 1<<13, /* Flow Control Protocol Error */
+	PEX_POIS_TLP	= 1<<12, /* Poisoned TLP */
+
+	PEX_DATA_LINK_P = 1<<4,	/* Data Link Protocol Error */
+	PEX_FATAL_ERRORS= (PEX_MALFOR_TLP | PEX_FLOW_CTRL_P | PEX_DATA_LINK_P),
+};
+
+
 enum csr_regs {
 	B0_RAP		= 0x0000,
 	B0_CTST		= 0x0004,
@@ -1836,7 +1878,6 @@ struct sky2_hw {
 	struct net_device    *dev[2];
 
 	int		     pm_cap;
-	int		     err_cap;
 	u8	     	     chip_id;
 	u8		     chip_rev;
 	u8		     pmd_type;
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index 636dbfc..0c9f1e7 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -398,6 +398,24 @@ #define SMC_outsl(a, r, p, l)	writesl((a
 
 #define SMC_IRQ_FLAGS		(0)
 
+#elif	defined(CONFIG_ARCH_VERSATILE)
+
+#define SMC_CAN_USE_8BIT	1
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	1
+#define SMC_NOWAIT		1
+
+#define SMC_inb(a, r)		readb((a) + (r))
+#define SMC_inw(a, r)		readw((a) + (r))
+#define SMC_inl(a, r)		readl((a) + (r))
+#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
+#define SMC_outw(v, a, r)	writew(v, (a) + (r))
+#define SMC_outl(v, a, r)	writel(v, (a) + (r))
+#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
+#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
+
+#define SMC_IRQ_FLAGS		(0)
+
 #else
 
 #define SMC_CAN_USE_8BIT	1
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
index 46a0090..418138d 100644
--- a/drivers/net/spider_net.c
+++ b/drivers/net/spider_net.c
@@ -55,12 +55,13 @@ MODULE_AUTHOR("Utz Bacher <utz.bacher@de
 	      "<Jens.Osterkamp@de.ibm.com>");
 MODULE_DESCRIPTION("Spider Southbridge Gigabit Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(VERSION);
 
 static int rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_DEFAULT;
 static int tx_descriptors = SPIDER_NET_TX_DESCRIPTORS_DEFAULT;
 
-module_param(rx_descriptors, int, 0644);
-module_param(tx_descriptors, int, 0644);
+module_param(rx_descriptors, int, 0444);
+module_param(tx_descriptors, int, 0444);
 
 MODULE_PARM_DESC(rx_descriptors, "number of descriptors used " \
 		 "in rx chains");
@@ -300,7 +301,7 @@ static int
 spider_net_init_chain(struct spider_net_card *card,
 		       struct spider_net_descr_chain *chain,
 		       struct spider_net_descr *start_descr,
-		       int direction, int no)
+		       int no)
 {
 	int i;
 	struct spider_net_descr *descr;
@@ -315,7 +316,7 @@ spider_net_init_chain(struct spider_net_
 
 		buf = pci_map_single(card->pdev, descr,
 				     SPIDER_NET_DESCR_SIZE,
-				     direction);
+				     PCI_DMA_BIDIRECTIONAL);
 
 		if (pci_dma_mapping_error(buf))
 			goto iommu_error;
@@ -329,11 +330,6 @@ spider_net_init_chain(struct spider_net_
 	(descr-1)->next = start_descr;
 	start_descr->prev = descr-1;
 
-	descr = start_descr;
-	if (direction == PCI_DMA_FROMDEVICE)
-		for (i=0; i < no; i++, descr++)
-			descr->next_descr_addr = descr->next->bus_addr;
-
 	spin_lock_init(&chain->lock);
 	chain->head = start_descr;
 	chain->tail = start_descr;
@@ -346,7 +342,7 @@ iommu_error:
 		if (descr->bus_addr)
 			pci_unmap_single(card->pdev, descr->bus_addr,
 					 SPIDER_NET_DESCR_SIZE,
-					 direction);
+					 PCI_DMA_BIDIRECTIONAL);
 	return -ENOMEM;
 }
 
@@ -362,15 +358,15 @@ spider_net_free_rx_chain_contents(struct
 	struct spider_net_descr *descr;
 
 	descr = card->rx_chain.head;
-	while (descr->next != card->rx_chain.head) {
+	do {
 		if (descr->skb) {
 			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->buf_addr,
 					 SPIDER_NET_MAX_FRAME,
-					 PCI_DMA_FROMDEVICE);
+					 PCI_DMA_BIDIRECTIONAL);
 		}
 		descr = descr->next;
-	}
+	} while (descr != card->rx_chain.head);
 }
 
 /**
@@ -645,26 +641,41 @@ static int
 spider_net_prepare_tx_descr(struct spider_net_card *card,
 			    struct sk_buff *skb)
 {
-	struct spider_net_descr *descr = card->tx_chain.head;
+	struct spider_net_descr *descr;
 	dma_addr_t buf;
+	unsigned long flags;
+	int length;
 
-	buf = pci_map_single(card->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
+	length = skb->len;
+	if (length < ETH_ZLEN) {
+		if (skb_pad(skb, ETH_ZLEN-length))
+			return 0;
+		length = ETH_ZLEN;
+	}
+
+	buf = pci_map_single(card->pdev, skb->data, length, PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(buf)) {
 		if (netif_msg_tx_err(card) && net_ratelimit())
 			pr_err("could not iommu-map packet (%p, %i). "
-				  "Dropping packet\n", skb->data, skb->len);
+				  "Dropping packet\n", skb->data, length);
 		card->spider_stats.tx_iommu_map_error++;
 		return -ENOMEM;
 	}
 
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
+	descr = card->tx_chain.head;
+	card->tx_chain.head = descr->next;
+
 	descr->buf_addr = buf;
-	descr->buf_size = skb->len;
+	descr->buf_size = length;
 	descr->next_descr_addr = 0;
 	descr->skb = skb;
 	descr->data_status = 0;
 
 	descr->dmac_cmd_status =
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		switch (skb->nh.iph->protocol) {
 		case IPPROTO_TCP:
@@ -675,32 +686,51 @@ spider_net_prepare_tx_descr(struct spide
 			break;
 		}
 
+	/* Chain the bus address, so that the DMA engine finds this descr. */
 	descr->prev->next_descr_addr = descr->bus_addr;
 
+	card->netdev->trans_start = jiffies; /* set netdev watchdog timer */
 	return 0;
 }
 
-/**
- * spider_net_release_tx_descr - processes a used tx descriptor
- * @card: card structure
- * @descr: descriptor to release
- *
- * releases a used tx descriptor (unmapping, freeing of skb)
- */
-static inline void
-spider_net_release_tx_descr(struct spider_net_card *card)
+static int
+spider_net_set_low_watermark(struct spider_net_card *card)
 {
+	unsigned long flags;
+	int status;
+	int cnt=0;
+	int i;
 	struct spider_net_descr *descr = card->tx_chain.tail;
-	struct sk_buff *skb;
 
-	card->tx_chain.tail = card->tx_chain.tail->next;
-	descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
+	/* Measure the length of the queue. Measurement does not
+	 * need to be precise -- does not need a lock. */
+	while (descr != card->tx_chain.head) {
+		status = descr->dmac_cmd_status & SPIDER_NET_DESCR_NOT_IN_USE;
+		if (status == SPIDER_NET_DESCR_NOT_IN_USE)
+			break;
+		descr = descr->next;
+		cnt++;
+	}
 
-	/* unmap the skb */
-	skb = descr->skb;
-	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
-			PCI_DMA_TODEVICE);
-	dev_kfree_skb_any(skb);
+	/* If TX queue is short, don't even bother with interrupts */
+	if (cnt < card->num_tx_desc/4)
+		return cnt;
+
+	/* Set low-watermark 3/4th's of the way into the queue. */
+	descr = card->tx_chain.tail;
+	cnt = (cnt*3)/4;
+	for (i=0;i<cnt; i++)
+		descr = descr->next;
+
+	/* Set the new watermark, clear the old watermark */
+	spin_lock_irqsave(&card->tx_chain.lock, flags);
+	descr->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
+	if (card->low_watermark && card->low_watermark != descr)
+		card->low_watermark->dmac_cmd_status =
+		     card->low_watermark->dmac_cmd_status & ~SPIDER_NET_DESCR_TXDESFLG;
+	card->low_watermark = descr;
+	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+	return cnt;
 }
 
 /**
@@ -719,21 +749,29 @@ static int
 spider_net_release_tx_chain(struct spider_net_card *card, int brutal)
 {
 	struct spider_net_descr_chain *chain = &card->tx_chain;
+	struct spider_net_descr *descr;
+	struct sk_buff *skb;
+	u32 buf_addr;
+	unsigned long flags;
 	int status;
 
-	spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR);
-
 	while (chain->tail != chain->head) {
-		status = spider_net_get_descr_status(chain->tail);
+		spin_lock_irqsave(&chain->lock, flags);
+		descr = chain->tail;
+
+		status = spider_net_get_descr_status(descr);
 		switch (status) {
 		case SPIDER_NET_DESCR_COMPLETE:
 			card->netdev_stats.tx_packets++;
-			card->netdev_stats.tx_bytes += chain->tail->skb->len;
+			card->netdev_stats.tx_bytes += descr->skb->len;
 			break;
 
 		case SPIDER_NET_DESCR_CARDOWNED:
-			if (!brutal)
+			if (!brutal) {
+				spin_unlock_irqrestore(&chain->lock, flags);
 				return 1;
+			}
+
 			/* fallthrough, if we release the descriptors
 			 * brutally (then we don't care about
 			 * SPIDER_NET_DESCR_CARDOWNED) */
@@ -750,11 +788,25 @@ spider_net_release_tx_chain(struct spide
 
 		default:
 			card->netdev_stats.tx_dropped++;
-			return 1;
+			if (!brutal) {
+				spin_unlock_irqrestore(&chain->lock, flags);
+				return 1;
+			}
 		}
-		spider_net_release_tx_descr(card);
-	}
 
+		chain->tail = descr->next;
+		descr->dmac_cmd_status |= SPIDER_NET_DESCR_NOT_IN_USE;
+		skb = descr->skb;
+		buf_addr = descr->buf_addr;
+		spin_unlock_irqrestore(&chain->lock, flags);
+
+		/* unmap the skb */
+		if (skb) {
+			int len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+			pci_unmap_single(card->pdev, buf_addr, len, PCI_DMA_TODEVICE);
+			dev_kfree_skb(skb);
+		}
+	}
 	return 0;
 }
 
@@ -763,8 +815,12 @@ spider_net_release_tx_chain(struct spide
  * @card: card structure
  * @descr: descriptor address to enable TX processing at
  *
- * spider_net_kick_tx_dma writes the current tx chain head as start address
- * of the tx descriptor chain and enables the transmission DMA engine
+ * This routine will start the transmit DMA running if
+ * it is not already running. This routine ned only be
+ * called when queueing a new packet to an empty tx queue.
+ * Writes the current tx chain head as start address
+ * of the tx descriptor chain and enables the transmission
+ * DMA engine.
  */
 static inline void
 spider_net_kick_tx_dma(struct spider_net_card *card)
@@ -804,65 +860,43 @@ out:
 static int
 spider_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
+	int cnt;
 	struct spider_net_card *card = netdev_priv(netdev);
 	struct spider_net_descr_chain *chain = &card->tx_chain;
-	struct spider_net_descr *descr = chain->head;
-	unsigned long flags;
-	int result;
-
-	spin_lock_irqsave(&chain->lock, flags);
 
 	spider_net_release_tx_chain(card, 0);
 
-	if (chain->head->next == chain->tail->prev) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
-	}
+	if ((chain->head->next == chain->tail->prev) ||
+	   (spider_net_prepare_tx_descr(card, skb) != 0)) {
 
-	if (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE) {
 		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_LOCKED;
-		goto out;
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
 	}
 
-	if (spider_net_prepare_tx_descr(card, skb) != 0) {
-		card->netdev_stats.tx_dropped++;
-		result = NETDEV_TX_BUSY;
-		goto out;
-	}
-
-	result = NETDEV_TX_OK;
-
-	spider_net_kick_tx_dma(card);
-	card->tx_chain.head = card->tx_chain.head->next;
-
-out:
-	spin_unlock_irqrestore(&chain->lock, flags);
-	netif_wake_queue(netdev);
-	return result;
+	cnt = spider_net_set_low_watermark(card);
+	if (cnt < 5)
+		spider_net_kick_tx_dma(card);
+	return NETDEV_TX_OK;
 }
 
 /**
  * spider_net_cleanup_tx_ring - cleans up the TX ring
  * @card: card structure
  *
- * spider_net_cleanup_tx_ring is called by the tx_timer (as we don't use
- * interrupts to cleanup our TX ring) and returns sent packets to the stack
- * by freeing them
+ * spider_net_cleanup_tx_ring is called by either the tx_timer
+ * or from the NAPI polling routine.
+ * This routine releases resources associted with transmitted
+ * packets, including updating the queue tail pointer.
  */
 static void
 spider_net_cleanup_tx_ring(struct spider_net_card *card)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&card->tx_chain.lock, flags);
-
 	if ((spider_net_release_tx_chain(card, 0) != 0) &&
-	    (card->netdev->flags & IFF_UP))
+	    (card->netdev->flags & IFF_UP)) {
 		spider_net_kick_tx_dma(card);
-
-	spin_unlock_irqrestore(&card->tx_chain.lock, flags);
+		netif_wake_queue(card->netdev);
+	}
 }
 
 /**
@@ -1053,6 +1087,7 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
+	spider_net_cleanup_tx_ring(card);
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1243,12 +1278,15 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_PHYINT:
 	case SPIDER_NET_GMAC2INT:
 	case SPIDER_NET_GMAC1INT:
-	case SPIDER_NET_GIPSINT:
 	case SPIDER_NET_GFIFOINT:
 	case SPIDER_NET_DMACINT:
 	case SPIDER_NET_GSYSINT:
 		break; */
 
+	case SPIDER_NET_GIPSINT:
+		show_error = 0;
+		break;
+
 	case SPIDER_NET_GPWOPCMPINT:
 		/* PHY write operation completed */
 		show_error = 0;
@@ -1307,9 +1345,10 @@ spider_net_handle_error_irq(struct spide
 	case SPIDER_NET_GDTDCEINT:
 		/* chain end. If a descriptor should be sent, kick off
 		 * tx dma
-		if (card->tx_chain.tail == card->tx_chain.head)
+		if (card->tx_chain.tail != card->tx_chain.head)
 			spider_net_kick_tx_dma(card);
-		show_error = 0; */
+		*/
+		show_error = 0;
 		break;
 
 	/* case SPIDER_NET_G1TMCNTINT: not used. print a message */
@@ -1354,7 +1393,7 @@ spider_net_handle_error_irq(struct spide
 		if (netif_msg_intr(card))
 			pr_err("got descriptor chain end interrupt, "
 			       "restarting DMAC %c.\n",
-			       'D'+i-SPIDER_NET_GDDDCEINT);
+			       'D'-(i-SPIDER_NET_GDDDCEINT)/3);
 		spider_net_refill_rx_chain(card);
 		spider_net_enable_rxdmac(card);
 		show_error = 0;
@@ -1423,8 +1462,9 @@ spider_net_handle_error_irq(struct spide
 	}
 
 	if ((show_error) && (netif_msg_intr(card)))
-		pr_err("Got error interrupt, GHIINT0STS = 0x%08x, "
+		pr_err("Got error interrupt on %s, GHIINT0STS = 0x%08x, "
 		       "GHIINT1STS = 0x%08x, GHIINT2STS = 0x%08x\n",
+		       card->netdev->name,
 		       status_reg, error_reg1, error_reg2);
 
 	/* clear interrupt sources */
@@ -1460,6 +1500,8 @@ spider_net_interrupt(int irq, void *ptr)
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
+	if (status_reg & SPIDER_NET_TXINT)
+		netif_rx_schedule(netdev);
 
 	if (status_reg & SPIDER_NET_ERRINT )
 		spider_net_handle_error_irq(card, status_reg);
@@ -1599,7 +1641,7 @@ spider_net_enable_card(struct spider_net
 			     SPIDER_NET_INT2_MASK_VALUE);
 
 	spider_net_write_reg(card, SPIDER_NET_GDTDMACCNTR,
-			     SPIDER_NET_GDTDCEIDIS);
+			     SPIDER_NET_GDTBSTA | SPIDER_NET_GDTDCEIDIS);
 }
 
 /**
@@ -1615,17 +1657,26 @@ int
 spider_net_open(struct net_device *netdev)
 {
 	struct spider_net_card *card = netdev_priv(netdev);
-	int result;
+	struct spider_net_descr *descr;
+	int i, result;
 
 	result = -ENOMEM;
 	if (spider_net_init_chain(card, &card->tx_chain, card->descr,
-			PCI_DMA_TODEVICE, card->tx_desc))
+	                          card->num_tx_desc))
 		goto alloc_tx_failed;
+
+	card->low_watermark = NULL;
+
+	/* rx_chain is after tx_chain, so offset is descr + tx_count */
 	if (spider_net_init_chain(card, &card->rx_chain,
-			card->descr + card->rx_desc,
-			PCI_DMA_FROMDEVICE, card->rx_desc))
+	                          card->descr + card->num_tx_desc,
+	                          card->num_rx_desc))
 		goto alloc_rx_failed;
 
+	descr = card->rx_chain.head;
+	for (i=0; i < card->num_rx_desc; i++, descr++)
+		descr->next_descr_addr = descr->next->bus_addr;
+
 	/* allocate rx skbs */
 	if (spider_net_alloc_rx_skbs(card))
 		goto alloc_skbs_failed;
@@ -1878,10 +1929,7 @@ spider_net_stop(struct net_device *netde
 	spider_net_disable_rxdmac(card);
 
 	/* release chains */
-	if (spin_trylock(&card->tx_chain.lock)) {
-		spider_net_release_tx_chain(card, 1);
-		spin_unlock(&card->tx_chain.lock);
-	}
+	spider_net_release_tx_chain(card, 1);
 
 	spider_net_free_chain(card, &card->tx_chain);
 	spider_net_free_chain(card, &card->rx_chain);
@@ -2012,8 +2060,8 @@ spider_net_setup_netdev(struct spider_ne
 
 	card->options.rx_csum = SPIDER_NET_RX_CSUM_DEFAULT;
 
-	card->tx_desc = tx_descriptors;
-	card->rx_desc = rx_descriptors;
+	card->num_tx_desc = tx_descriptors;
+	card->num_rx_desc = rx_descriptors;
 
 	spider_net_setup_netdev_ops(netdev);
 
@@ -2252,6 +2300,8 @@ static struct pci_driver spider_net_driv
  */
 static int __init spider_net_init(void)
 {
+	printk(KERN_INFO "Spidernet version %s.\n", VERSION);
+
 	if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MIN) {
 		rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_MIN;
 		pr_info("adjusting rx descriptors to %i.\n", rx_descriptors);
diff --git a/drivers/net/spider_net.h b/drivers/net/spider_net.h
index a59deda..b3b4611 100644
--- a/drivers/net/spider_net.h
+++ b/drivers/net/spider_net.h
@@ -24,6 +24,8 @@
 #ifndef _SPIDER_NET_H
 #define _SPIDER_NET_H
 
+#define VERSION "1.1 A"
+
 #include "sungem_phy.h"
 
 extern int spider_net_stop(struct net_device *netdev);
@@ -47,7 +49,7 @@ #define SPIDER_NET_TX_DESCRIPTORS_DEFAUL
 #define SPIDER_NET_TX_DESCRIPTORS_MIN		16
 #define SPIDER_NET_TX_DESCRIPTORS_MAX		512
 
-#define SPIDER_NET_TX_TIMER			20
+#define SPIDER_NET_TX_TIMER			(HZ/5)
 
 #define SPIDER_NET_RX_CSUM_DEFAULT		1
 
@@ -189,7 +191,9 @@ #define SPIDER_NET_TXPAUSE_VALUE	0x00000
 #define SPIDER_NET_MACMODE_VALUE	0x00000001
 #define SPIDER_NET_BURSTLMT_VALUE	0x00000200 /* about 16 us */
 
-/* 1(0)					enable r/tx dma
+/* DMAC control register GDMACCNTR
+ *
+ * 1(0)				enable r/tx dma
  *  0000000				fixed to 0
  *
  *         000000			fixed to 0
@@ -198,6 +202,7 @@ #define SPIDER_NET_BURSTLMT_VALUE	0x0000
  *
  *                 000000		fixed to 0
  *                       00		burst alignment: 128 bytes
+ *                       11		burst alignment: 1024 bytes
  *
  *                         00000	fixed to 0
  *                              0	descr writeback size 32 bytes
@@ -208,10 +213,13 @@ #define SPIDER_NET_BURSTLMT_VALUE	0x0000
 #define SPIDER_NET_DMA_RX_VALUE		0x80000000
 #define SPIDER_NET_DMA_RX_FEND_VALUE	0x00030003
 /* to set TX_DMA_EN */
-#define SPIDER_NET_TX_DMA_EN		0x80000000
-#define SPIDER_NET_GDTDCEIDIS		0x00000002
-#define SPIDER_NET_DMA_TX_VALUE		SPIDER_NET_TX_DMA_EN | \
-					SPIDER_NET_GDTDCEIDIS
+#define SPIDER_NET_TX_DMA_EN           0x80000000
+#define SPIDER_NET_GDTBSTA             0x00000300
+#define SPIDER_NET_GDTDCEIDIS          0x00000002
+#define SPIDER_NET_DMA_TX_VALUE        SPIDER_NET_TX_DMA_EN | \
+                                       SPIDER_NET_GDTBSTA | \
+                                       SPIDER_NET_GDTDCEIDIS
+
 #define SPIDER_NET_DMA_TX_FEND_VALUE	0x00030003
 
 /* SPIDER_NET_UA_DESCR_VALUE is OR'ed with the unicast address */
@@ -320,13 +328,10 @@ enum spider_net_int2_status {
 	SPIDER_NET_GRISPDNGINT
 };
 
-#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GTTEDINT) | \
-				  (1 << SPIDER_NET_GDTDCEINT) | \
-				  (1 << SPIDER_NET_GDTFDCINT) )
+#define SPIDER_NET_TXINT	( (1 << SPIDER_NET_GDTFDCINT) )
 
-/* we rely on flagged descriptor interrupts*/
-#define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) | \
-				  (1 << SPIDER_NET_GRMFLLINT) )
+/* We rely on flagged descriptor interrupts */
+#define SPIDER_NET_RXINT	( (1 << SPIDER_NET_GDAFDCINT) )
 
 #define SPIDER_NET_ERRINT	( 0xffffffff & \
 				  (~SPIDER_NET_TXINT) & \
@@ -349,6 +354,7 @@ #define SPIDER_NET_DESCR_FRAME_END		0x40
 #define SPIDER_NET_DESCR_FORCE_END		0x50000000 /* used in rx and tx */
 #define SPIDER_NET_DESCR_CARDOWNED		0xA0000000 /* used in rx and tx */
 #define SPIDER_NET_DESCR_NOT_IN_USE		0xF0000000
+#define SPIDER_NET_DESCR_TXDESFLG		0x00800000
 
 struct spider_net_descr {
 	/* as defined by the hardware */
@@ -433,6 +439,7 @@ struct spider_net_card {
 
 	struct spider_net_descr_chain tx_chain;
 	struct spider_net_descr_chain rx_chain;
+	struct spider_net_descr *low_watermark;
 
 	struct net_device_stats netdev_stats;
 
@@ -448,8 +455,8 @@ struct spider_net_card {
 
 	/* for ethtool */
 	int msg_enable;
-	int rx_desc;
-	int tx_desc;
+	int num_rx_desc;
+	int num_tx_desc;
 	struct spider_net_extra_stats spider_stats;
 
 	struct spider_net_descr descr[0];
diff --git a/drivers/net/spider_net_ethtool.c b/drivers/net/spider_net_ethtool.c
index 589e436..91b9951 100644
--- a/drivers/net/spider_net_ethtool.c
+++ b/drivers/net/spider_net_ethtool.c
@@ -76,7 +76,7 @@ spider_net_ethtool_get_drvinfo(struct ne
 	/* clear and fill out info */
 	memset(drvinfo, 0, sizeof(struct ethtool_drvinfo));
 	strncpy(drvinfo->driver, spider_net_driver_name, 32);
-	strncpy(drvinfo->version, "0.1", 32);
+	strncpy(drvinfo->version, VERSION, 32);
 	strcpy(drvinfo->fw_version, "no information");
 	strncpy(drvinfo->bus_info, pci_name(card->pdev), 32);
 }
@@ -158,9 +158,9 @@ spider_net_ethtool_get_ringparam(struct 
 	struct spider_net_card *card = netdev->priv;
 
 	ering->tx_max_pending = SPIDER_NET_TX_DESCRIPTORS_MAX;
-	ering->tx_pending = card->tx_desc;
+	ering->tx_pending = card->num_tx_desc;
 	ering->rx_max_pending = SPIDER_NET_RX_DESCRIPTORS_MAX;
-	ering->rx_pending = card->rx_desc;
+	ering->rx_pending = card->num_rx_desc;
 }
 
 static int spider_net_get_stats_count(struct net_device *netdev)
diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index 2cfd963..f6b3a94 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -1730,7 +1730,7 @@ static void __init de21040_get_media_inf
 }
 
 /* Note: this routine returns extra data bits for size detection. */
-static unsigned __init tulip_read_eeprom(void __iomem *regs, int location, int addr_len)
+static unsigned __devinit tulip_read_eeprom(void __iomem *regs, int location, int addr_len)
 {
 	int i;
 	unsigned retval = 0;
@@ -1926,7 +1926,7 @@ bad_srom:
 	goto fill_defaults;
 }
 
-static int __init de_init_one (struct pci_dev *pdev,
+static int __devinit de_init_one (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
 {
 	struct net_device *dev;
@@ -2082,7 +2082,7 @@ err_out_free:
 	return rc;
 }
 
-static void __exit de_remove_one (struct pci_dev *pdev)
+static void __devexit de_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct de_private *de = dev->priv;
@@ -2164,7 +2164,7 @@ static struct pci_driver de_driver = {
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
-	.remove		= __exit_p(de_remove_one),
+	.remove		= __devexit_p(de_remove_one),
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,
