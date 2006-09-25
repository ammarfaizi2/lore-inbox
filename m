Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWIYOfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWIYOfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWIYOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:35:24 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:7734 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932186AbWIYOfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:35:21 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton Blanchard's new hvcall interface
Date: Mon, 25 Sep 2006 15:50:01 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>, pmac@au1.ibm.com
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609251550.01514.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

this eHEA patch reflects changes according to Anton's new hvcall interface
which has been commited in Paul's git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Thanks to this change our pHYP interface needs less lines of code.
In addition to the above changes the patch includes a bug fix (port state
notification) and minor changes (default queue length, coding style updates).


Thanks,
Jan-Bernd Themann

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---

 drivers/net/ehea/ehea.h      |   13 -
 drivers/net/ehea/ehea_main.c |   12
 drivers/net/ehea/ehea_phyp.c |  559 +++++++++++++++++--------------------------
 3 files changed, 244 insertions(+), 340 deletions(-)


diff -Nurp -X dontdiff kernel_ehea_28/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- kernel_ehea_28/drivers/net/ehea/ehea.h	2006-09-25 06:53:20.937708434 -0700
+++ patched_kernel/drivers/net/ehea/ehea.h	2006-09-25 06:16:39.152956418 -0700
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0028"
+#define DRV_VERSION	"EHEA_0033"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -50,6 +50,7 @@
 #define EHEA_MAX_ENTRIES_SQ  32767
 #define EHEA_MIN_ENTRIES_QP  127
 
+#define EHEA_SMALL_QUEUES
 #define EHEA_NUM_TX_QP 1
 
 #ifdef EHEA_SMALL_QUEUES
@@ -59,11 +60,11 @@
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
diff -Nurp -X dontdiff kernel_ehea_28/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- kernel_ehea_28/drivers/net/ehea/ehea_main.c	2006-09-25 06:53:20.938708444 -0700
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2006-09-25 06:16:39.153956426 -0700
@@ -544,7 +544,7 @@ static irqreturn_t ehea_send_irq_handler
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t ehea_recv_irq_handler(int irq, void *param, 
+static irqreturn_t ehea_recv_irq_handler(int irq, void *param,
 					 struct pt_regs *regs)
 {
 	struct ehea_port_res *pr = param;
@@ -553,7 +553,7 @@ static irqreturn_t ehea_recv_irq_handler
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t ehea_qp_aff_irq_handler(int irq, void *param, 
+static irqreturn_t ehea_qp_aff_irq_handler(int irq, void *param,
 					   struct pt_regs *regs)
 {
 	struct ehea_port *port = param;
@@ -769,7 +769,7 @@ static void ehea_parse_eqe(struct ehea_a
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
 				ret = ehea_sense_port_attr(
-					adapter->port[portnum]);
+					port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -821,7 +821,7 @@ static void ehea_parse_eqe(struct ehea_a
 		netif_stop_queue(port->netdev);
 		break;
 	default:
-		ehea_error("unknown event code %x", ec);
+		ehea_error("unknown event code %x, eqe=0x%lX", ec, eqe);
 		break;
 	}
 }
@@ -850,7 +850,7 @@ static void ehea_neq_tasklet(unsigned lo
 			    adapter->neq->fw_handle, event_mask);
 }
 
-static irqreturn_t ehea_interrupt_neq(int irq, void *param, 
+static irqreturn_t ehea_interrupt_neq(int irq, void *param,
 				      struct pt_regs *regs)
 {
 	struct ehea_adapter *adapter = param;
@@ -1845,7 +1845,7 @@ static int ehea_start_xmit(struct sk_buf
 
 	if (netif_msg_tx_queued(port)) {
 		ehea_info("post swqe on QP %d", pr->qp->init_attr.qp_nr);
-		ehea_dump(swqe, sizeof(*swqe), "swqe");
+		ehea_dump(swqe, 512, "swqe");
 	}
 
 	ehea_post_swqe(pr->qp, swqe);
diff -Nurp -X dontdiff kernel_ehea_28/drivers/net/ehea/ehea_phyp.c patched_kernel/drivers/net/ehea/ehea_phyp.c
--- kernel_ehea_28/drivers/net/ehea/ehea_phyp.c	2006-09-25 06:53:20.939708454 -0700
+++ patched_kernel/drivers/net/ehea/ehea_phyp.c	2006-09-25 06:16:39.153956426 -0700
@@ -44,71 +44,99 @@ static inline u16 get_order_of_qentries(
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
 
-	init_attr->qp_nr = (u32)r5_out;
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
+	u64 hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
-	cq_attr->act_nr_of_cqes = act_nr_of_cqes_out;
-	cq_attr->nr_pages = act_pages_out;
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
@@ -361,9 +367,8 @@ u64 ehea_h_alloc_resource_cq(const u64 a
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
+	u64 hret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
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
+	mr->handle = outs[0];
+	mr->lkey = (u32)outs[2];
 
 	return hret;
 }
 
 u64 ehea_h_disable_and_get_hea(const u64 adapter_handle, const u64 qp_handle)
 {
-	u64 hret, dummy, ladr_next_sq_wqe_out;
-	u64 ladr_next_rq1_wqe_out, ladr_next_rq2_wqe_out, ladr_next_rq3_wqe_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
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
+	u64 hret;
+ 	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
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
+	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
+				 outs,
+				 adapter_handle,		   /* R4 */
+				 5,				   /* R5 */
+				 vaddr,			           /* R6 */
+				 length,			   /* R7 */
+				 (((u64) access_ctrl) << 32ULL),   /* R8 */
+				 pd,				   /* R9 */
+				 0, 0, 0);			   /* R10-R12 */
 
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
