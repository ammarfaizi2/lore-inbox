Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWIVPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWIVPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWIVPX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:23:57 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:15722 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932457AbWIVPXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:23:54 -0400
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openfabrics-ewg@openib.org
Subject: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton Blanchard's new hvcall interface
Date: Fri, 22 Sep 2006 17:20:23 +0200
User-Agent: KMail/1.7.1
Cc: pmac@au1.ibm.com, hnguyen@de.ibm.com, raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_48/EF5v2jWzSHr3"
Message-Id: <200609221720.24191.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_48/EF5v2jWzSHr3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
Below is the patch of ehca according to Anton's new hvcall interface, which has been
committed in Paul's git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Besides the changes above this patch contains some coding style updates.
I created this patch against your git tree, branch for-2.6.19.

Thanks!
Hoang-Nam Nguyen


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_main.c |    9
 hcp_if.c    |  845 ++++++++++++++++++++---------------------------------------- hcp_if.h    |    2
 hipz_hw.h   |    2
 ipz_pt_fn.h |    7
 5 files changed, 300 insertions(+), 565 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 159b0be..0a0248f 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -5,6 +5,7 @@
  *
  *  Authors: Heiko J Schick <schickhj@de.ibm.com>
  *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Joachim Fenkes <fenkes@de.ibm.com>
  *
  *  Copyright (c) 2005 IBM Corporation
  *
@@ -48,7 +49,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0015");
+MODULE_VERSION("SVNEHCA_0016");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -268,7 +269,7 @@ int ehca_register_device(struct ehca_shc
   (1ull << IB_USER_VERBS_CMD_ATTACH_MCAST) |
   (1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
 
- shca->ib_device.node_type           = RDMA_NODE_IB_CA;
+ shca->ib_device.node_type           = IB_NODE_CA;
  shca->ib_device.phys_port_cnt       = shca->num_ports;
  shca->ib_device.dma_device          = &shca->ibmebus_dev->ofdev.dev;
  shca->ib_device.query_device        = ehca_query_device;
@@ -446,7 +447,7 @@ static ssize_t  ehca_show_##name(struct 
   kfree(rblock);            \
   return 0;            \
  }           \
-            \
+                                                                           \
  data = rblock->name;                                               \
  kfree(rblock);                                                     \
             \
@@ -749,7 +750,7 @@ int __init ehca_module_init(void)
  int ret;
 
  printk(KERN_INFO "eHCA Infiniband Device Driver "
-                  "(Rel.: SVNEHCA_0015)\n");
+                  "(Rel.: SVNEHCA_0016)\n");
  idr_init(&ehca_qp_idr);
  idr_init(&ehca_cq_idr);
  spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 260e82a..3fb46e6 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -48,27 +48,27 @@ #include "hcp_phyp.h"
 #include "hipz_fns.h"
 #include "ipz_pt_fn.h"
 
-#define H_ALL_RES_QP_ENHANCED_OPS       EHCA_BMASK_IBM(9,11)
-#define H_ALL_RES_QP_PTE_PIN            EHCA_BMASK_IBM(12,12)
-#define H_ALL_RES_QP_SERVICE_TYPE       EHCA_BMASK_IBM(13,15)
-#define H_ALL_RES_QP_LL_RQ_CQE_POSTING  EHCA_BMASK_IBM(18,18)
-#define H_ALL_RES_QP_LL_SQ_CQE_POSTING  EHCA_BMASK_IBM(19,21)
-#define H_ALL_RES_QP_SIGNALING_TYPE     EHCA_BMASK_IBM(22,23)
-#define H_ALL_RES_QP_UD_AV_LKEY_CTRL    EHCA_BMASK_IBM(31,31)
-#define H_ALL_RES_QP_RESOURCE_TYPE      EHCA_BMASK_IBM(56,63)
-
-#define H_ALL_RES_QP_MAX_OUTST_SEND_WR  EHCA_BMASK_IBM(0,15)
-#define H_ALL_RES_QP_MAX_OUTST_RECV_WR  EHCA_BMASK_IBM(16,31)
-#define H_ALL_RES_QP_MAX_SEND_SGE       EHCA_BMASK_IBM(32,39)
-#define H_ALL_RES_QP_MAX_RECV_SGE       EHCA_BMASK_IBM(40,47)
-
-#define H_ALL_RES_QP_ACT_OUTST_SEND_WR  EHCA_BMASK_IBM(16,31)
-#define H_ALL_RES_QP_ACT_OUTST_RECV_WR  EHCA_BMASK_IBM(48,63)
-#define H_ALL_RES_QP_ACT_SEND_SGE       EHCA_BMASK_IBM(8,15)
-#define H_ALL_RES_QP_ACT_RECV_SGE       EHCA_BMASK_IBM(24,31)
-
-#define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0,31)
-#define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32,63)
+#define H_ALL_RES_QP_ENHANCED_OPS       EHCA_BMASK_IBM(9, 11)
+#define H_ALL_RES_QP_PTE_PIN            EHCA_BMASK_IBM(12, 12)
+#define H_ALL_RES_QP_SERVICE_TYPE       EHCA_BMASK_IBM(13, 15)
+#define H_ALL_RES_QP_LL_RQ_CQE_POSTING  EHCA_BMASK_IBM(18, 18)
+#define H_ALL_RES_QP_LL_SQ_CQE_POSTING  EHCA_BMASK_IBM(19, 21)
+#define H_ALL_RES_QP_SIGNALING_TYPE     EHCA_BMASK_IBM(22, 23)
+#define H_ALL_RES_QP_UD_AV_LKEY_CTRL    EHCA_BMASK_IBM(31, 31)
+#define H_ALL_RES_QP_RESOURCE_TYPE      EHCA_BMASK_IBM(56, 63)
+
+#define H_ALL_RES_QP_MAX_OUTST_SEND_WR  EHCA_BMASK_IBM(0, 15)
+#define H_ALL_RES_QP_MAX_OUTST_RECV_WR  EHCA_BMASK_IBM(16, 31)
+#define H_ALL_RES_QP_MAX_SEND_SGE       EHCA_BMASK_IBM(32, 39)
+#define H_ALL_RES_QP_MAX_RECV_SGE       EHCA_BMASK_IBM(40, 47)
+
+#define H_ALL_RES_QP_ACT_OUTST_SEND_WR  EHCA_BMASK_IBM(16, 31)
+#define H_ALL_RES_QP_ACT_OUTST_RECV_WR  EHCA_BMASK_IBM(48, 63)
+#define H_ALL_RES_QP_ACT_SEND_SGE       EHCA_BMASK_IBM(8, 15)
+#define H_ALL_RES_QP_ACT_RECV_SGE       EHCA_BMASK_IBM(24, 31)
+
+#define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32, 63)
 
 /* direct access qp controls */
 #define DAQP_CTRL_ENABLE    0x01
@@ -95,35 +95,25 @@ static u32 get_longbusy_msecs(int longbu
  }
 }
 
-static long ehca_hcall_7arg_7ret(unsigned long opcode,
-     unsigned long arg1,
-     unsigned long arg2,
-     unsigned long arg3,
-     unsigned long arg4,
-     unsigned long arg5,
-     unsigned long arg6,
-     unsigned long arg7,
-     unsigned long *out1,
-     unsigned long *out2,
-     unsigned long *out3,
-     unsigned long *out4,
-     unsigned long *out5,
-     unsigned long *out6,
-     unsigned long *out7)
+static long ehca_plpar_hcall_norets(unsigned long opcode,
+        unsigned long arg1,
+        unsigned long arg2,
+        unsigned long arg3,
+        unsigned long arg4,
+        unsigned long arg5,
+        unsigned long arg6,
+        unsigned long arg7)
 {
  long ret;
  int i, sleep_msecs;
 
- ehca_gen_dbg("opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx arg5=%lx "
-       "arg6=%lx arg7=%lx", opcode, arg1, arg2, arg3, arg4, arg5,
-       arg6, arg7);
+ ehca_gen_dbg("opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
+       "arg5=%lx arg6=%lx arg7=%lx",
+       opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 
  for (i = 0; i < 5; i++) {
-  ret = plpar_hcall_7arg_7ret(opcode,
-         arg1, arg2, arg3, arg4,
-         arg5, arg6, arg7,
-         out1, out2, out3, out4,
-         out5, out6,out7);
+  ret = plpar_hcall_norets(opcode, arg1, arg2, arg3, arg4,
+      arg5, arg6, arg7);
 
   if (H_IS_LONG_BUSY(ret)) {
    sleep_msecs = get_longbusy_msecs(ret);
@@ -134,44 +124,30 @@ static long ehca_hcall_7arg_7ret(unsigne
   if (ret < H_SUCCESS)
    ehca_gen_err("opcode=%lx ret=%lx"
          " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
-         " arg5=%lx arg6=%lx arg7=%lx"
-         " out1=%lx out2=%lx out3=%lx out4=%lx"
-         " out5=%lx out6=%lx out7=%lx",
+         " arg5=%lx arg6=%lx arg7=%lx ",
          opcode, ret,
-         arg1, arg2, arg3, arg4,
-         arg5, arg6, arg7,
-         *out1, *out2, *out3, *out4,
-         *out5, *out6, *out7);
+         arg1, arg2, arg3, arg4, arg5,
+         arg6, arg7);
 
-  ehca_gen_dbg("opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx "
-        "out4=%lx out5=%lx out6=%lx out7=%lx",
-        opcode, ret, *out1, *out2, *out3, *out4, *out5,
-        *out6, *out7);
+  ehca_gen_dbg("opcode=%lx ret=%lx", opcode, ret);
   return ret;
+
  }
 
  return H_BUSY;
 }
 
-static long ehca_hcall_9arg_9ret(unsigned long opcode,
-     unsigned long arg1,
-     unsigned long arg2,
-     unsigned long arg3,
-     unsigned long arg4,
-     unsigned long arg5,
-     unsigned long arg6,
-     unsigned long arg7,
-     unsigned long arg8,
-     unsigned long arg9,
-     unsigned long *out1,
-     unsigned long *out2,
-     unsigned long *out3,
-     unsigned long *out4,
-     unsigned long *out5,
-     unsigned long *out6,
-     unsigned long *out7,
-     unsigned long *out8,
-     unsigned long *out9)
+static long ehca_plpar_hcall9(unsigned long opcode,
+         unsigned long *outs, /* array of 9 outputs */
+         unsigned long arg1,
+         unsigned long arg2,
+         unsigned long arg3,
+         unsigned long arg4,
+         unsigned long arg5,
+         unsigned long arg6,
+         unsigned long arg7,
+         unsigned long arg8,
+         unsigned long arg9)
 {
  long ret;
  int i, sleep_msecs;
@@ -182,13 +158,9 @@ static long ehca_hcall_9arg_9ret(unsigne
        arg8, arg9);
 
  for (i = 0; i < 5; i++) {
-  ret = plpar_hcall_9arg_9ret(opcode,
-         arg1, arg2, arg3, arg4,
-         arg5, arg6, arg7, arg8,
-         arg9,
-         out1, out2, out3, out4,
-         out5, out6, out7, out8,
-         out9);
+  ret = plpar_hcall9(opcode, outs,
+       arg1, arg2, arg3, arg4, arg5,
+       arg6, arg7, arg8, arg9);
 
   if (H_IS_LONG_BUSY(ret)) {
    sleep_msecs = get_longbusy_msecs(ret);
@@ -205,37 +177,35 @@ static long ehca_hcall_9arg_9ret(unsigne
          " out5=%lx out6=%lx out7=%lx out8=%lx"
          " out9=%lx",
          opcode, ret,
-         arg1, arg2, arg3, arg4,
-         arg5, arg6, arg7, arg8,
-         arg9,
-         *out1, *out2, *out3, *out4,
-         *out5, *out6, *out7, *out8,
-         *out9);
+         arg1, arg2, arg3, arg4, arg5,
+         arg6, arg7, arg8, arg9,
+         outs[0], outs[1], outs[2], outs[3],
+         outs[4], outs[5], outs[6], outs[7],
+         outs[8]);
 
   ehca_gen_dbg("opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx "
         "out4=%lx out5=%lx out6=%lx out7=%lx out8=%lx "
-        "out9=%lx", opcode, ret,*out1, *out2, *out3, *out4,
-        *out5, *out6, *out7, *out8, *out9);
+        "out9=%lx",
+        opcode, ret, outs[0], outs[1], outs[2], outs[3],
+        outs[4], outs[5], outs[6], outs[7], outs[8]);
   return ret;
 
  }
 
  return H_BUSY;
 }
-
 u64 hipz_h_alloc_resource_eq(const struct ipz_adapter_handle adapter_handle,
         struct ehca_pfeq *pfeq,
         const u32 neq_control,
         const u32 number_of_entries,
         struct ipz_eq_handle *eq_handle,
-        u32 * act_nr_of_entries,
-        u32 * act_pages,
-        u32 * eq_ist)
+        u32 *act_nr_of_entries,
+        u32 *act_pages,
+        u32 *eq_ist)
 {
  u64 ret;
- u64 dummy;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
  u64 allocate_controls;
- u64 act_nr_of_entries_out, act_pages_out, eq_ist_out;
 
  /* resource type */
  allocate_controls = 3ULL;
@@ -246,22 +216,15 @@ u64 hipz_h_alloc_resource_eq(const struc
  else /* notification event queue */
   allocate_controls = (1ULL << 63) | allocate_controls;
 
- ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-       adapter_handle.handle,  /* r4 */
-       allocate_controls,      /* r5 */
-       number_of_entries,      /* r6 */
-       0, 0, 0, 0,
-       &eq_handle->handle,     /* r4 */
-       &dummy,            /* r5 */
-       &dummy,            /* r6 */
-       &act_nr_of_entries_out, /* r7 */
-       &act_pages_out,    /* r8 */
-       &eq_ist_out,            /* r8 */
-       &dummy);
-
- *act_nr_of_entries = (u32)act_nr_of_entries_out;
- *act_pages         = (u32)act_pages_out;
- *eq_ist            = (u32)eq_ist_out;
+ ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+    adapter_handle.handle,  /* r4 */
+    allocate_controls,      /* r5 */
+    number_of_entries,      /* r6 */
+    0, 0, 0, 0, 0, 0);
+ eq_handle->handle = outs[0];
+ *act_nr_of_entries = (u32)outs[3];
+ *act_pages = (u32)outs[4];
+ *eq_ist = (u32)outs[5];
 
  if (ret == H_NOT_ENOUGH_RESOURCES)
   ehca_gen_err("Not enough resource - ret=%lx ", ret);
@@ -273,20 +236,11 @@ u64 hipz_h_reset_event(const struct ipz_
          struct ipz_eq_handle eq_handle,
          const u64 event_mask)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_RESET_EVENTS,
-        adapter_handle.handle, /* r4 */
-        eq_handle.handle,      /* r5 */
-        event_mask,            /* r6 */
-        0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_RESET_EVENTS,
+           adapter_handle.handle, /* r4 */
+           eq_handle.handle,      /* r5 */
+           event_mask,       /* r6 */
+           0, 0, 0, 0);
 }
 
 u64 hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
@@ -294,30 +248,21 @@ u64 hipz_h_alloc_resource_cq(const struc
         struct ehca_alloc_cq_parms *param)
 {
  u64 ret;
- u64 dummy;
- u64 act_nr_of_entries_out, act_pages_out;
- u64 g_la_privileged_out, g_la_user_out;
-
- ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-       adapter_handle.handle,     /* r4  */
-       2,                       /* r5  */
-       param->eq_handle.handle,   /* r6  */
-       cq->token,               /* r7  */
-       param->nr_cqe,             /* r8  */
-       0, 0,
-       &cq->ipz_cq_handle.handle, /* r4  */
-       &dummy,               /* r5  */
-       &dummy,               /* r6  */
-       &act_nr_of_entries_out,    /* r7  */
-       &act_pages_out,       /* r8  */
-       &g_la_privileged_out,      /* r9  */
-       &g_la_user_out);           /* r10 */
-
- param->act_nr_of_entries = (u32)act_nr_of_entries_out;
- param->act_pages = (u32)act_pages_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+    adapter_handle.handle,   /* r4  */
+    2,                  /* r5  */
+    param->eq_handle.handle, /* r6  */
+    cq->token,          /* r7  */
+    param->nr_cqe,           /* r8  */
+    0, 0, 0, 0);
+ cq->ipz_cq_handle.handle = outs[0];
+ param->act_nr_of_entries = (u32)outs[3];
+ param->act_pages = (u32)outs[4];
 
  if (ret == H_SUCCESS)
-  hcp_galpas_ctor(&cq->galpas, g_la_privileged_out, g_la_user_out);
+  hcp_galpas_ctor(&cq->galpas, outs[5], outs[6]);
 
  if (ret == H_NOT_ENOUGH_RESOURCES)
   ehca_gen_err("Not enough resources. ret=%lx", ret);
@@ -330,8 +275,9 @@ u64 hipz_h_alloc_resource_qp(const struc
         struct ehca_alloc_qp_parms *parms)
 {
  u64 ret;
- u64 dummy, allocate_controls, max_r10_reg;
- u64 qp_nr_out, r6_out, r7_out, r8_out, g_la_user_out, r11_out;
+ u64 allocate_controls;
+ u64 max_r10_reg;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
  u16 max_nr_receive_wqes = qp->init_attr.cap.max_recv_wr + 1;
  u16 max_nr_send_wqes = qp->init_attr.cap.max_send_wr + 1;
  int daqp_ctrl = parms->daqp_ctrl;
@@ -360,48 +306,36 @@ u64 hipz_h_alloc_resource_qp(const struc
   | EHCA_BMASK_SET(H_ALL_RES_QP_MAX_RECV_SGE,
      parms->max_recv_sge);
 
-
- ret = ehca_hcall_9arg_9ret(H_ALLOC_RESOURCE,
-       adapter_handle.handle,       /* r4  */
-       allocate_controls,               /* r5  */
-       qp->send_cq->ipz_cq_handle.handle,
-       qp->recv_cq->ipz_cq_handle.handle,
-       parms->ipz_eq_handle.handle,
-       ((u64)qp->token << 32) | parms->pd.value,
-       max_r10_reg,                       /* r10 */
-       parms->ud_av_l_key_ctl,            /* r11 */
-       0,
-       &qp->ipz_qp_handle.handle,
-       &qp_nr_out,                       /* r5  */
-       &r6_out,                       /* r6  */
-       &r7_out,                       /* r7  */
-       &r8_out,                       /* r8  */
-       &dummy,                       /* r9  */
-       &g_la_user_out,               /* r10 */
-       &r11_out,
-       &dummy);
-
- /* extract outputs */
- qp->real_qp_num = (u32)qp_nr_out;
-
+ ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+    adapter_handle.handle,            /* r4  */
+    allocate_controls,            /* r5  */
+    qp->send_cq->ipz_cq_handle.handle,
+    qp->recv_cq->ipz_cq_handle.handle,
+    parms->ipz_eq_handle.handle,
+    ((u64)qp->token << 32) | parms->pd.value,
+    max_r10_reg,                    /* r10 */
+    parms->ud_av_l_key_ctl,            /* r11 */
+    0);
+ qp->ipz_qp_handle.handle = outs[0];
+ qp->real_qp_num = (u32)outs[1];
  parms->act_nr_send_sges =
-  (u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_SEND_WR, r6_out);
+  (u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_SEND_WR, outs[2]);
  parms->act_nr_recv_wqes =
-  (u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_RECV_WR, r6_out);
+  (u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_RECV_WR, outs[2]);
  parms->act_nr_send_sges =
-  (u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_SEND_SGE, r7_out);
+  (u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_SEND_SGE, outs[3]);
  parms->act_nr_recv_sges =
-  (u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_RECV_SGE, r7_out);
+  (u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_RECV_SGE, outs[3]);
  parms->nr_sq_pages =
-  (u32)EHCA_BMASK_GET(H_ALL_RES_QP_SQUEUE_SIZE_PAGES, r8_out);
+  (u32)EHCA_BMASK_GET(H_ALL_RES_QP_SQUEUE_SIZE_PAGES, outs[4]);
  parms->nr_rq_pages =
-  (u32)EHCA_BMASK_GET(H_ALL_RES_QP_RQUEUE_SIZE_PAGES, r8_out);
+  (u32)EHCA_BMASK_GET(H_ALL_RES_QP_RQUEUE_SIZE_PAGES, outs[4]);
 
  if (ret == H_SUCCESS)
-  hcp_galpas_ctor(&qp->galpas, g_la_user_out, g_la_user_out);
+  hcp_galpas_ctor(&qp->galpas, outs[6], outs[6]);
 
  if (ret == H_NOT_ENOUGH_RESOURCES)
-  ehca_gen_err("Not enough resources. ret=%lx",ret);
+  ehca_gen_err("Not enough resources. ret=%lx", ret);
 
  return ret;
 }
@@ -411,7 +345,6 @@ u64 hipz_h_query_port(const struct ipz_a
         struct hipz_query_port *query_port_response_block)
 {
  u64 ret;
- u64 dummy;
  u64 r_cb = virt_to_abs(query_port_response_block);
 
  if (r_cb & (EHCA_PAGESIZE-1)) {
@@ -419,18 +352,11 @@ u64 hipz_h_query_port(const struct ipz_a
   return H_PARAMETER;
  }
 
- ret = ehca_hcall_7arg_7ret(H_QUERY_PORT,
-       adapter_handle.handle, /* r4 */
-       port_id,           /* r5 */
-       r_cb,           /* r6 */
-       0, 0, 0, 0,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
+ ret = ehca_plpar_hcall_norets(H_QUERY_PORT,
+          adapter_handle.handle, /* r4 */
+          port_id,              /* r5 */
+          r_cb,              /* r6 */
+          0, 0, 0, 0);
 
  if (ehca_debug_level)
   ehca_dmp(query_port_response_block, 64, "response_block");
@@ -441,7 +367,6 @@ u64 hipz_h_query_port(const struct ipz_a
 u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
        struct hipz_query_hca *query_hca_rblock)
 {
- u64 dummy;
  u64 r_cb = virt_to_abs(query_hca_rblock);
 
  if (r_cb & (EHCA_PAGESIZE-1)) {
@@ -450,17 +375,10 @@ u64 hipz_h_query_hca(const struct ipz_ad
   return H_PARAMETER;
  }
 
- return ehca_hcall_7arg_7ret(H_QUERY_HCA,
-        adapter_handle.handle, /* r4 */
-        r_cb,                  /* r5 */
-        0, 0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_QUERY_HCA,
+           adapter_handle.handle, /* r4 */
+           r_cb,                  /* r5 */
+           0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_register_rpage(const struct ipz_adapter_handle adapter_handle,
@@ -470,22 +388,13 @@ u64 hipz_h_register_rpage(const struct i
      const u64 logical_address_of_page,
      u64 count)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_REGISTER_RPAGES,
-        adapter_handle.handle,      /* r4  */
-        queue_type | pagesize << 8, /* r5  */
-        resource_handle,         /* r6  */
-        logical_address_of_page,    /* r7  */
-        count,                 /* r8  */
-        0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_REGISTER_RPAGES,
+           adapter_handle.handle,      /* r4  */
+           queue_type | pagesize << 8, /* r5  */
+           resource_handle,            /* r6  */
+           logical_address_of_page,    /* r7  */
+           count,                    /* r8  */
+           0, 0);
 }
 
 u64 hipz_h_register_rpage_eq(const struct ipz_adapter_handle adapter_handle,
@@ -507,23 +416,14 @@ u64 hipz_h_register_rpage_eq(const struc
          logical_address_of_page, count);
 }
 
-u32 hipz_h_query_int_state(const struct ipz_adapter_handle adapter_handle,
+u64 hipz_h_query_int_state(const struct ipz_adapter_handle adapter_handle,
       u32 ist)
 {
- u32 ret;
- u64 dummy;
-
- ret = ehca_hcall_7arg_7ret(H_QUERY_INT_STATE,
-       adapter_handle.handle, /* r4 */
-       ist,                   /* r5 */
-       0, 0, 0, 0, 0,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
+ u64 ret;
+ ret = ehca_plpar_hcall_norets(H_QUERY_INT_STATE,
+          adapter_handle.handle, /* r4 */
+          ist,                   /* r5 */
+          0, 0, 0, 0, 0);
 
  if (ret != H_SUCCESS && ret != H_BUSY)
   ehca_gen_err("Could not query interrupt state.");
@@ -576,25 +476,20 @@ u64 hipz_h_disable_and_get_wqe(const str
           void **log_addr_next_rq_wqe2processed,
           int dis_and_get_function_code)
 {
- u64 dummy, dummy1, dummy2;
-
- if (!log_addr_next_sq_wqe2processed)
-  log_addr_next_sq_wqe2processed = (void**)&dummy1;
- if (!log_addr_next_rq_wqe2processed)
-  log_addr_next_rq_wqe2processed = (void**)&dummy2;
-
- return ehca_hcall_7arg_7ret(H_DISABLE_AND_GETC,
-        adapter_handle.handle,     /* r4 */
-        dis_and_get_function_code, /* r5 */
-        qp_handle.handle,        /* r6 */
-        0, 0, 0, 0,
-        (void*)log_addr_next_sq_wqe2processed,
-        (void*)log_addr_next_rq_wqe2processed,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ u64 ret;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_DISABLE_AND_GETC, outs,
+    adapter_handle.handle,     /* r4 */
+    dis_and_get_function_code, /* r5 */
+    qp_handle.handle,    /* r6 */
+    0, 0, 0, 0, 0, 0);
+ if (log_addr_next_sq_wqe2processed)
+  *log_addr_next_sq_wqe2processed = (void*)outs[0];
+ if (log_addr_next_rq_wqe2processed)
+  *log_addr_next_rq_wqe2processed = (void*)outs[1];
+
+ return ret;
 }
 
 u64 hipz_h_modify_qp(const struct ipz_adapter_handle adapter_handle,
@@ -605,22 +500,13 @@ u64 hipz_h_modify_qp(const struct ipz_ad
        struct h_galpa gal)
 {
  u64 ret;
- u64 dummy;
- u64 invalid_attribute_identifier, rc_attrib_mask;
-
- ret = ehca_hcall_7arg_7ret(H_MODIFY_QP,
-       adapter_handle.handle,         /* r4 */
-       qp_handle.handle,           /* r5 */
-       update_mask,                   /* r6 */
-       virt_to_abs(mqpcb),           /* r7 */
-       0, 0, 0,
-       &invalid_attribute_identifier, /* r4 */
-       &dummy,                   /* r5 */
-       &dummy,                   /* r6 */
-       &dummy,                        /* r7 */
-       &dummy,                   /* r8 */
-       &rc_attrib_mask,               /* r9 */
-       &dummy);
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+ ret = ehca_plpar_hcall9(H_MODIFY_QP, outs,
+    adapter_handle.handle, /* r4 */
+    qp_handle.handle,      /* r5 */
+    update_mask,        /* r6 */
+    virt_to_abs(mqpcb),    /* r7 */
+    0, 0, 0, 0, 0);
 
  if (ret == H_NOT_ENOUGH_RESOURCES)
   ehca_gen_err("Insufficient resources ret=%lx", ret);
@@ -634,61 +520,37 @@ u64 hipz_h_query_qp(const struct ipz_ada
       struct hcp_modify_qp_control_block *qqpcb,
       struct h_galpa gal)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_QUERY_QP,
-        adapter_handle.handle, /* r4 */
-        qp_handle.handle,      /* r5 */
-        virt_to_abs(qqpcb),    /* r6 */
-        0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_QUERY_QP,
+           adapter_handle.handle, /* r4 */
+           qp_handle.handle,      /* r5 */
+           virt_to_abs(qqpcb),    /* r6 */
+           0, 0, 0, 0);
 }
 
 u64 hipz_h_destroy_qp(const struct ipz_adapter_handle adapter_handle,
         struct ehca_qp *qp)
 {
  u64 ret;
- u64 dummy;
- u64 ladr_next_sq_wqe_out, ladr_next_rq_wqe_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
 
  ret = hcp_galpas_dtor(&qp->galpas);
  if (ret) {
   ehca_gen_err("Could not destruct qp->galpas");
   return H_RESOURCE;
  }
- ret = ehca_hcall_7arg_7ret(H_DISABLE_AND_GETC,
-       adapter_handle.handle,     /* r4 */
-       /* function code */
-       1,                       /* r5 */
-       qp->ipz_qp_handle.handle,  /* r6 */
-       0, 0, 0, 0,
-       &ladr_next_sq_wqe_out,     /* r4 */
-       &ladr_next_rq_wqe_out,     /* r5 */
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
+ ret = ehca_plpar_hcall9(H_DISABLE_AND_GETC, outs,
+    adapter_handle.handle,     /* r4 */
+    /* function code */
+    1,                    /* r5 */
+    qp->ipz_qp_handle.handle,  /* r6 */
+    0, 0, 0, 0, 0, 0);
  if (ret == H_HARDWARE)
   ehca_gen_err("HCA not operational. ret=%lx", ret);
 
- ret = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-       adapter_handle.handle,     /* r4 */
-       qp->ipz_qp_handle.handle,  /* r5 */
-       0, 0, 0, 0, 0,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
+ ret = ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+          adapter_handle.handle,     /* r4 */
+          qp->ipz_qp_handle.handle,  /* r5 */
+          0, 0, 0, 0, 0);
 
  if (ret == H_RESOURCE)
   ehca_gen_err("Resource still in use. ret=%lx", ret);
@@ -701,20 +563,11 @@ u64 hipz_h_define_aqp0(const struct ipz_
          struct h_galpa gal,
          u32 port)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_DEFINE_AQP0,
-        adapter_handle.handle, /* r4 */
-        qp_handle.handle,      /* r5 */
-        port,                  /* r6 */
-        0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_DEFINE_AQP0,
+           adapter_handle.handle, /* r4 */
+           qp_handle.handle,      /* r5 */
+           port,                  /* r6 */
+           0, 0, 0, 0);
 }
 
 u64 hipz_h_define_aqp1(const struct ipz_adapter_handle adapter_handle,
@@ -724,24 +577,15 @@ u64 hipz_h_define_aqp1(const struct ipz_
          u32 * bma_qp_nr)
 {
  u64 ret;
- u64 dummy;
- u64 pma_qp_nr_out, bma_qp_nr_out;
-
- ret = ehca_hcall_7arg_7ret(H_DEFINE_AQP1,
-       adapter_handle.handle, /* r4 */
-       qp_handle.handle,      /* r5 */
-       port,           /* r6 */
-       0, 0, 0, 0,
-       &pma_qp_nr_out,        /* r4 */
-       &bma_qp_nr_out,        /* r5 */
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
-
- *pma_qp_nr = (u32)pma_qp_nr_out;
- *bma_qp_nr = (u32)bma_qp_nr_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_DEFINE_AQP1, outs,
+    adapter_handle.handle, /* r4 */
+    qp_handle.handle,      /* r5 */
+    port,                /* r6 */
+    0, 0, 0, 0, 0, 0);
+ *pma_qp_nr = (u32)outs[0];
+ *bma_qp_nr = (u32)outs[1];
 
  if (ret == H_ALIAS_EXIST)
   ehca_gen_err("AQP1 already exists. ret=%lx", ret);
@@ -756,22 +600,14 @@ u64 hipz_h_attach_mcqp(const struct ipz_
          u64 subnet_prefix, u64 interface_id)
 {
  u64 ret;
- u64 dummy;
-
- ret = ehca_hcall_7arg_7ret(H_ATTACH_MCQP,
-       adapter_handle.handle,     /* r4 */
-       qp_handle.handle,          /* r5 */
-       mcg_dlid,                  /* r6 */
-       interface_id,              /* r7 */
-       subnet_prefix,             /* r8 */
-       0, 0,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
+
+ ret = ehca_plpar_hcall_norets(H_ATTACH_MCQP,
+          adapter_handle.handle,  /* r4 */
+          qp_handle.handle,       /* r5 */
+          mcg_dlid,               /* r6 */
+          interface_id,           /* r7 */
+          subnet_prefix,          /* r8 */
+          0, 0);
 
  if (ret == H_NOT_ENOUGH_RESOURCES)
   ehca_gen_err("Not enough resources. ret=%lx", ret);
@@ -785,22 +621,13 @@ u64 hipz_h_detach_mcqp(const struct ipz_
          u16 mcg_dlid,
          u64 subnet_prefix, u64 interface_id)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_DETACH_MCQP,
-        adapter_handle.handle, /* r4 */
-        qp_handle.handle,    /* r5 */
-        mcg_dlid,            /* r6 */
-        interface_id,          /* r7 */
-        subnet_prefix,         /* r8 */
-        0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_DETACH_MCQP,
+           adapter_handle.handle, /* r4 */
+           qp_handle.handle,      /* r5 */
+           mcg_dlid,              /* r6 */
+           interface_id,          /* r7 */
+           subnet_prefix,         /* r8 */
+           0, 0);
 }
 
 u64 hipz_h_destroy_cq(const struct ipz_adapter_handle adapter_handle,
@@ -808,7 +635,6 @@ u64 hipz_h_destroy_cq(const struct ipz_a
         u8 force_flag)
 {
  u64 ret;
- u64 dummy;
 
  ret = hcp_galpas_dtor(&cq->galpas);
  if (ret) {
@@ -816,18 +642,11 @@ u64 hipz_h_destroy_cq(const struct ipz_a
   return H_RESOURCE;
  }
 
- ret = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-       adapter_handle.handle,     /* r4 */
-       cq->ipz_cq_handle.handle,  /* r5 */
-       force_flag != 0 ? 1L : 0L, /* r6 */
-       0, 0, 0, 0,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
+ ret = ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+          adapter_handle.handle,     /* r4 */
+          cq->ipz_cq_handle.handle,  /* r5 */
+          force_flag != 0 ? 1L : 0L, /* r6 */
+          0, 0, 0, 0);
 
  if (ret == H_RESOURCE)
   ehca_gen_err("H_FREE_RESOURCE failed ret=%lx ", ret);
@@ -839,7 +658,6 @@ u64 hipz_h_destroy_eq(const struct ipz_a
         struct ehca_eq *eq)
 {
  u64 ret;
- u64 dummy;
 
  ret = hcp_galpas_dtor(&eq->galpas);
  if (ret) {
@@ -847,18 +665,10 @@ u64 hipz_h_destroy_eq(const struct ipz_a
   return H_RESOURCE;
  }
 
- ret = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-       adapter_handle.handle,     /* r4 */
-       eq->ipz_eq_handle.handle,  /* r5 */
-       0, 0, 0, 0, 0,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy,
-       &dummy);
-
+ ret = ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+          adapter_handle.handle,     /* r4 */
+          eq->ipz_eq_handle.handle,  /* r5 */
+          0, 0, 0, 0, 0);
 
  if (ret == H_RESOURCE)
   ehca_gen_err("Resource in use. ret=%lx ", ret);
@@ -875,27 +685,19 @@ u64 hipz_h_alloc_resource_mr(const struc
         struct ehca_mr_hipzout_parms *outparms)
 {
  u64 ret;
- u64 dummy;
- u64 lkey_out;
- u64 rkey_out;
-
- ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-       adapter_handle.handle,            /* r4 */
-       5,                                /* r5 */
-       vaddr,                            /* r6 */
-       length,                           /* r7 */
-       (((u64)access_ctrl) << 32ULL),    /* r8 */
-       pd.value,                         /* r9 */
-       0,
-       &(outparms->handle.handle),       /* r4 */
-       &dummy,                           /* r5 */
-       &lkey_out,                        /* r6 */
-       &rkey_out,                        /* r7 */
-       &dummy,
-       &dummy,
-       &dummy);
- outparms->lkey = (u32)lkey_out;
- outparms->rkey = (u32)rkey_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+    adapter_handle.handle,            /* r4 */
+    5,                                /* r5 */
+    vaddr,                            /* r6 */
+    length,                           /* r7 */
+    (((u64)access_ctrl) << 32ULL),    /* r8 */
+    pd.value,                         /* r9 */
+    0, 0, 0);
+ outparms->handle.handle = outs[0];
+ outparms->lkey = (u32)outs[2];
+ outparms->rkey = (u32)outs[3];
 
  return ret;
 }
@@ -923,7 +725,6 @@ u64 hipz_h_register_rpage_mr(const struc
          queue_type,
          mr->ipz_mr_handle.handle,
          logical_address_of_page, count);
-
  return ret;
 }
 
@@ -932,24 +733,17 @@ u64 hipz_h_query_mr(const struct ipz_ada
       struct ehca_mr_hipzout_parms *outparms)
 {
  u64 ret;
- u64 dummy;
- u64 remote_len_out, remote_vaddr_out, acc_ctrl_pd_out, r9_out;
-
- ret = ehca_hcall_7arg_7ret(H_QUERY_MR,
-       adapter_handle.handle,     /* r4 */
-       mr->ipz_mr_handle.handle,  /* r5 */
-       0, 0, 0, 0, 0,
-       &outparms->len,            /* r4 */
-       &outparms->vaddr,          /* r5 */
-       &remote_len_out,           /* r6 */
-       &remote_vaddr_out,         /* r7 */
-       &acc_ctrl_pd_out,          /* r8 */
-       &r9_out,
-       &dummy);
-
- outparms->acl  = acc_ctrl_pd_out >> 32;
- outparms->lkey = (u32)(r9_out >> 32);
- outparms->rkey = (u32)(r9_out & (0xffffffff));
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_QUERY_MR, outs,
+    adapter_handle.handle,     /* r4 */
+    mr->ipz_mr_handle.handle,  /* r5 */
+    0, 0, 0, 0, 0, 0, 0);
+ outparms->len = outs[0];
+ outparms->vaddr = outs[1];
+ outparms->acl  = outs[4] >> 32;
+ outparms->lkey = (u32)(outs[5] >> 32);
+ outparms->rkey = (u32)(outs[5] & (0xffffffff));
 
  return ret;
 }
@@ -957,19 +751,10 @@ u64 hipz_h_query_mr(const struct ipz_ada
 u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle adapter_handle,
        const struct ehca_mr *mr)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-        adapter_handle.handle,    /* r4 */
-        mr->ipz_mr_handle.handle, /* r5 */
-        0, 0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+           adapter_handle.handle,    /* r4 */
+           mr->ipz_mr_handle.handle, /* r5 */
+           0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
@@ -982,28 +767,20 @@ u64 hipz_h_reregister_pmr(const struct i
      struct ehca_mr_hipzout_parms *outparms)
 {
  u64 ret;
- u64 dummy;
- u64 lkey_out, rkey_out;
-
- ret = ehca_hcall_7arg_7ret(H_REREGISTER_PMR,
-       adapter_handle.handle,    /* r4 */
-       mr->ipz_mr_handle.handle, /* r5 */
-       vaddr_in,              /* r6 */
-       length,                   /* r7 */
-       /* r8 */
-       ((((u64)access_ctrl) << 32ULL) | pd.value),
-       mr_addr_cb,               /* r9 */
-       0,
-       &dummy,                   /* r4 */
-       &outparms->vaddr,         /* r5 */
-       &lkey_out,                /* r6 */
-       &rkey_out,                /* r7 */
-       &dummy,
-       &dummy,
-       &dummy);
-
- outparms->lkey = (u32)lkey_out;
- outparms->rkey = (u32)rkey_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_REREGISTER_PMR, outs,
+    adapter_handle.handle,    /* r4 */
+    mr->ipz_mr_handle.handle, /* r5 */
+    vaddr_in,           /* r6 */
+    length,                   /* r7 */
+    /* r8 */
+    ((((u64)access_ctrl) << 32ULL) | pd.value),
+    mr_addr_cb,               /* r9 */
+    0, 0, 0);
+ outparms->vaddr = outs[1];
+ outparms->lkey = (u32)outs[2];
+ outparms->rkey = (u32)outs[3];
 
  return ret;
 }
@@ -1017,25 +794,18 @@ u64 hipz_h_register_smr(const struct ipz
    struct ehca_mr_hipzout_parms *outparms)
 {
  u64 ret;
- u64 dummy;
- u64 lkey_out, rkey_out;
-
- ret = ehca_hcall_7arg_7ret(H_REGISTER_SMR,
-       adapter_handle.handle,            /* r4 */
-       orig_mr->ipz_mr_handle.handle,    /* r5 */
-       vaddr_in,                         /* r6 */
-       (((u64)access_ctrl) << 32ULL),    /* r7 */
-       pd.value,                         /* r8 */
-       0, 0,
-       &(outparms->handle.handle),       /* r4 */
-       &dummy,                           /* r5 */
-       &lkey_out,                        /* r6 */
-       &rkey_out,                        /* r7 */
-       &dummy,
-       &dummy,
-       &dummy);
- outparms->lkey = (u32)lkey_out;
- outparms->rkey = (u32)rkey_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_REGISTER_SMR, outs,
+    adapter_handle.handle,            /* r4 */
+    orig_mr->ipz_mr_handle.handle,    /* r5 */
+    vaddr_in,                         /* r6 */
+    (((u64)access_ctrl) << 32ULL),    /* r7 */
+    pd.value,                         /* r8 */
+    0, 0, 0, 0);
+ outparms->handle.handle = outs[0];
+ outparms->lkey = (u32)outs[2];
+ outparms->rkey = (u32)outs[3];
 
  return ret;
 }
@@ -1046,23 +816,15 @@ u64 hipz_h_alloc_resource_mw(const struc
         struct ehca_mw_hipzout_parms *outparms)
 {
  u64 ret;
- u64 dummy;
- u64 rkey_out;
-
- ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-       adapter_handle.handle,      /* r4 */
-       6,                          /* r5 */
-       pd.value,                   /* r6 */
-       0, 0, 0, 0,
-       &(outparms->handle.handle), /* r4 */
-       &dummy,                     /* r5 */
-       &dummy,                     /* r6 */
-       &rkey_out,                  /* r7 */
-       &dummy,
-       &dummy,
-       &dummy);
-
- outparms->rkey = (u32)rkey_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+    adapter_handle.handle,      /* r4 */
+    6,                          /* r5 */
+    pd.value,                   /* r6 */
+    0, 0, 0, 0, 0, 0);
+ outparms->handle.handle = outs[0];
+ outparms->rkey = (u32)outs[3];
 
  return ret;
 }
@@ -1072,21 +834,13 @@ u64 hipz_h_query_mw(const struct ipz_ada
       struct ehca_mw_hipzout_parms *outparms)
 {
  u64 ret;
- u64 dummy;
- u64 pd_out, rkey_out;
-
- ret = ehca_hcall_7arg_7ret(H_QUERY_MW,
-       adapter_handle.handle,    /* r4 */
-       mw->ipz_mw_handle.handle, /* r5 */
-       0, 0, 0, 0, 0,
-       &dummy,                   /* r4 */
-       &dummy,                   /* r5 */
-       &dummy,                   /* r6 */
-       &rkey_out,                /* r7 */
-       &pd_out,                  /* r8 */
-       &dummy,
-       &dummy);
- outparms->rkey = (u32)rkey_out;
+ u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+ ret = ehca_plpar_hcall9(H_QUERY_MW, outs,
+    adapter_handle.handle,    /* r4 */
+    mw->ipz_mw_handle.handle, /* r5 */
+    0, 0, 0, 0, 0, 0, 0);
+ outparms->rkey = (u32)outs[3];
 
  return ret;
 }
@@ -1094,19 +848,10 @@ u64 hipz_h_query_mw(const struct ipz_ada
 u64 hipz_h_free_resource_mw(const struct ipz_adapter_handle adapter_handle,
        const struct ehca_mw *mw)
 {
- u64 dummy;
-
- return ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-        adapter_handle.handle,    /* r4 */
-        mw->ipz_mw_handle.handle, /* r5 */
-        0, 0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+           adapter_handle.handle,    /* r4 */
+           mw->ipz_mw_handle.handle, /* r5 */
+           0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
@@ -1114,7 +859,6 @@ u64 hipz_h_error_data(const struct ipz_a
         void *rblock,
         unsigned long *byte_count)
 {
- u64 dummy;
  u64 r_cb = virt_to_abs(rblock);
 
  if (r_cb & (EHCA_PAGESIZE-1)) {
@@ -1122,16 +866,9 @@ u64 hipz_h_error_data(const struct ipz_a
   return H_PARAMETER;
  }
 
- return ehca_hcall_7arg_7ret(H_ERROR_DATA,
-        adapter_handle.handle,
-        ressource_handle,
-        r_cb,
-        0, 0, 0, 0,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy,
-        &dummy);
+ return ehca_plpar_hcall_norets(H_ERROR_DATA,
+           adapter_handle.handle,
+           ressource_handle,
+           r_cb,
+           0, 0, 0, 0);
 }
diff --git a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
index 39956d8..587ebd4 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.h
+++ b/drivers/infiniband/hw/ehca/hcp_if.h
@@ -107,7 +107,7 @@ u64 hipz_h_register_rpage_eq(const struc
         const u64 logical_address_of_page,
         const u64 count);
 
-u32 hipz_h_query_int_state(const struct ipz_adapter_handle
+u64 hipz_h_query_int_state(const struct ipz_adapter_handle
       hcp_adapter_handle,
       u32 ist);
 
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index f5f4871..3fc92b0 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -184,8 +184,6 @@ struct hipz_mrmwmm {
 
 };
 
-#define MRX_HCR_LPARID_VALID EHCA_BMASK_IBM(0,0)
-
 #define MRMWMM_OFFSET(x) offsetof(struct hipz_mrmwmm,x)
 
 struct hipz_qpedmm {
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.h b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
index 7e55a31..2f13509 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.h
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
@@ -226,10 +226,9 @@ static inline void *ipz_eqit_eq_get_inc_
 {
  void *ret = ipz_qeit_get(queue);
  u32 qe = *(u8 *) ret;
- if ((qe >> 7) == (queue->toggle_state & 1))
-  ipz_qeit_eq_get_inc(queue); /* this is a good one */
- else
-  ret = NULL;
+ if ((qe >> 7) != (queue->toggle_state & 1))
+  return NULL;
+ ipz_qeit_eq_get_inc(queue); /* this is a good one */
  return ret;
 }
 

--Boundary-00=_48/EF5v2jWzSHr3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="svnehca_0016_roland_git.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="svnehca_0016_roland_git.patch"

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 159b0be..0a0248f 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -5,6 +5,7 @@
  *
  *  Authors: Heiko J Schick <schickhj@de.ibm.com>
  *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
+ *           Joachim Fenkes <fenkes@de.ibm.com>
  *
  *  Copyright (c) 2005 IBM Corporation
  *
@@ -48,7 +49,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0015");
+MODULE_VERSION("SVNEHCA_0016");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -268,7 +269,7 @@ int ehca_register_device(struct ehca_shc
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
 		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
 
-	shca->ib_device.node_type           = RDMA_NODE_IB_CA;
+	shca->ib_device.node_type           = IB_NODE_CA;
 	shca->ib_device.phys_port_cnt       = shca->num_ports;
 	shca->ib_device.dma_device          = &shca->ibmebus_dev->ofdev.dev;
 	shca->ib_device.query_device        = ehca_query_device;
@@ -446,7 +447,7 @@ static ssize_t  ehca_show_##name(struct 
 		kfree(rblock);					   	   \
 		return 0;					   	   \
 	}								   \
-									   \
+                                                                           \
 	data = rblock->name;                                               \
 	kfree(rblock);                                                     \
 									   \
@@ -749,7 +750,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0015)\n");
+	                 "(Rel.: SVNEHCA_0016)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index 260e82a..3fb46e6 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -48,27 +48,27 @@ #include "hcp_phyp.h"
 #include "hipz_fns.h"
 #include "ipz_pt_fn.h"
 
-#define H_ALL_RES_QP_ENHANCED_OPS       EHCA_BMASK_IBM(9,11)
-#define H_ALL_RES_QP_PTE_PIN            EHCA_BMASK_IBM(12,12)
-#define H_ALL_RES_QP_SERVICE_TYPE       EHCA_BMASK_IBM(13,15)
-#define H_ALL_RES_QP_LL_RQ_CQE_POSTING  EHCA_BMASK_IBM(18,18)
-#define H_ALL_RES_QP_LL_SQ_CQE_POSTING  EHCA_BMASK_IBM(19,21)
-#define H_ALL_RES_QP_SIGNALING_TYPE     EHCA_BMASK_IBM(22,23)
-#define H_ALL_RES_QP_UD_AV_LKEY_CTRL    EHCA_BMASK_IBM(31,31)
-#define H_ALL_RES_QP_RESOURCE_TYPE      EHCA_BMASK_IBM(56,63)
-
-#define H_ALL_RES_QP_MAX_OUTST_SEND_WR  EHCA_BMASK_IBM(0,15)
-#define H_ALL_RES_QP_MAX_OUTST_RECV_WR  EHCA_BMASK_IBM(16,31)
-#define H_ALL_RES_QP_MAX_SEND_SGE       EHCA_BMASK_IBM(32,39)
-#define H_ALL_RES_QP_MAX_RECV_SGE       EHCA_BMASK_IBM(40,47)
-
-#define H_ALL_RES_QP_ACT_OUTST_SEND_WR  EHCA_BMASK_IBM(16,31)
-#define H_ALL_RES_QP_ACT_OUTST_RECV_WR  EHCA_BMASK_IBM(48,63)
-#define H_ALL_RES_QP_ACT_SEND_SGE       EHCA_BMASK_IBM(8,15)
-#define H_ALL_RES_QP_ACT_RECV_SGE       EHCA_BMASK_IBM(24,31)
-
-#define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0,31)
-#define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32,63)
+#define H_ALL_RES_QP_ENHANCED_OPS       EHCA_BMASK_IBM(9, 11)
+#define H_ALL_RES_QP_PTE_PIN            EHCA_BMASK_IBM(12, 12)
+#define H_ALL_RES_QP_SERVICE_TYPE       EHCA_BMASK_IBM(13, 15)
+#define H_ALL_RES_QP_LL_RQ_CQE_POSTING  EHCA_BMASK_IBM(18, 18)
+#define H_ALL_RES_QP_LL_SQ_CQE_POSTING  EHCA_BMASK_IBM(19, 21)
+#define H_ALL_RES_QP_SIGNALING_TYPE     EHCA_BMASK_IBM(22, 23)
+#define H_ALL_RES_QP_UD_AV_LKEY_CTRL    EHCA_BMASK_IBM(31, 31)
+#define H_ALL_RES_QP_RESOURCE_TYPE      EHCA_BMASK_IBM(56, 63)
+
+#define H_ALL_RES_QP_MAX_OUTST_SEND_WR  EHCA_BMASK_IBM(0, 15)
+#define H_ALL_RES_QP_MAX_OUTST_RECV_WR  EHCA_BMASK_IBM(16, 31)
+#define H_ALL_RES_QP_MAX_SEND_SGE       EHCA_BMASK_IBM(32, 39)
+#define H_ALL_RES_QP_MAX_RECV_SGE       EHCA_BMASK_IBM(40, 47)
+
+#define H_ALL_RES_QP_ACT_OUTST_SEND_WR  EHCA_BMASK_IBM(16, 31)
+#define H_ALL_RES_QP_ACT_OUTST_RECV_WR  EHCA_BMASK_IBM(48, 63)
+#define H_ALL_RES_QP_ACT_SEND_SGE       EHCA_BMASK_IBM(8, 15)
+#define H_ALL_RES_QP_ACT_RECV_SGE       EHCA_BMASK_IBM(24, 31)
+
+#define H_ALL_RES_QP_SQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(0, 31)
+#define H_ALL_RES_QP_RQUEUE_SIZE_PAGES  EHCA_BMASK_IBM(32, 63)
 
 /* direct access qp controls */
 #define DAQP_CTRL_ENABLE    0x01
@@ -95,35 +95,25 @@ static u32 get_longbusy_msecs(int longbu
 	}
 }
 
-static long ehca_hcall_7arg_7ret(unsigned long opcode,
-				 unsigned long arg1,
-				 unsigned long arg2,
-				 unsigned long arg3,
-				 unsigned long arg4,
-				 unsigned long arg5,
-				 unsigned long arg6,
-				 unsigned long arg7,
-				 unsigned long *out1,
-				 unsigned long *out2,
-				 unsigned long *out3,
-				 unsigned long *out4,
-				 unsigned long *out5,
-				 unsigned long *out6,
-				 unsigned long *out7)
+static long ehca_plpar_hcall_norets(unsigned long opcode,
+				    unsigned long arg1,
+				    unsigned long arg2,
+				    unsigned long arg3,
+				    unsigned long arg4,
+				    unsigned long arg5,
+				    unsigned long arg6,
+				    unsigned long arg7)
 {
 	long ret;
 	int i, sleep_msecs;
 
-	ehca_gen_dbg("opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx arg5=%lx "
-		     "arg6=%lx arg7=%lx", opcode, arg1, arg2, arg3, arg4, arg5,
-		     arg6, arg7);
+	ehca_gen_dbg("opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
+		     "arg5=%lx arg6=%lx arg7=%lx",
+		     opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 
 	for (i = 0; i < 5; i++) {
-		ret = plpar_hcall_7arg_7ret(opcode,
-					    arg1, arg2, arg3, arg4,
-					    arg5, arg6, arg7,
-					    out1, out2, out3, out4,
-					    out5, out6,out7);
+		ret = plpar_hcall_norets(opcode, arg1, arg2, arg3, arg4,
+					 arg5, arg6, arg7);
 
 		if (H_IS_LONG_BUSY(ret)) {
 			sleep_msecs = get_longbusy_msecs(ret);
@@ -134,44 +124,30 @@ static long ehca_hcall_7arg_7ret(unsigne
 		if (ret < H_SUCCESS)
 			ehca_gen_err("opcode=%lx ret=%lx"
 				     " arg1=%lx arg2=%lx arg3=%lx arg4=%lx"
-				     " arg5=%lx arg6=%lx arg7=%lx"
-				     " out1=%lx out2=%lx out3=%lx out4=%lx"
-				     " out5=%lx out6=%lx out7=%lx",
+				     " arg5=%lx arg6=%lx arg7=%lx ",
 				     opcode, ret,
-				     arg1, arg2, arg3, arg4,
-				     arg5, arg6, arg7,
-				     *out1, *out2, *out3, *out4,
-				     *out5, *out6, *out7);
+				     arg1, arg2, arg3, arg4, arg5,
+				     arg6, arg7);
 
-		ehca_gen_dbg("opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx "
-			     "out4=%lx out5=%lx out6=%lx out7=%lx",
-			     opcode, ret, *out1, *out2, *out3, *out4, *out5,
-			     *out6, *out7);
+		ehca_gen_dbg("opcode=%lx ret=%lx", opcode, ret);
 		return ret;
+
 	}
 
 	return H_BUSY;
 }
 
-static long ehca_hcall_9arg_9ret(unsigned long opcode,
-				 unsigned long arg1,
-				 unsigned long arg2,
-				 unsigned long arg3,
-				 unsigned long arg4,
-				 unsigned long arg5,
-				 unsigned long arg6,
-				 unsigned long arg7,
-				 unsigned long arg8,
-				 unsigned long arg9,
-				 unsigned long *out1,
-				 unsigned long *out2,
-				 unsigned long *out3,
-				 unsigned long *out4,
-				 unsigned long *out5,
-				 unsigned long *out6,
-				 unsigned long *out7,
-				 unsigned long *out8,
-				 unsigned long *out9)
+static long ehca_plpar_hcall9(unsigned long opcode,
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
 	long ret;
 	int i, sleep_msecs;
@@ -182,13 +158,9 @@ static long ehca_hcall_9arg_9ret(unsigne
 		     arg8, arg9);
 
 	for (i = 0; i < 5; i++) {
-		ret = plpar_hcall_9arg_9ret(opcode,
-					    arg1, arg2, arg3, arg4,
-					    arg5, arg6, arg7, arg8,
-					    arg9,
-					    out1, out2, out3, out4,
-					    out5, out6, out7, out8,
-					    out9);
+		ret = plpar_hcall9(opcode, outs,
+				   arg1, arg2, arg3, arg4, arg5,
+				   arg6, arg7, arg8, arg9);
 
 		if (H_IS_LONG_BUSY(ret)) {
 			sleep_msecs = get_longbusy_msecs(ret);
@@ -205,37 +177,35 @@ static long ehca_hcall_9arg_9ret(unsigne
 				     " out5=%lx out6=%lx out7=%lx out8=%lx"
 				     " out9=%lx",
 				     opcode, ret,
-				     arg1, arg2, arg3, arg4,
-				     arg5, arg6, arg7, arg8,
-				     arg9,
-				     *out1, *out2, *out3, *out4,
-				     *out5, *out6, *out7, *out8,
-				     *out9);
+				     arg1, arg2, arg3, arg4, arg5,
+				     arg6, arg7, arg8, arg9,
+				     outs[0], outs[1], outs[2], outs[3],
+				     outs[4], outs[5], outs[6], outs[7],
+				     outs[8]);
 
 		ehca_gen_dbg("opcode=%lx ret=%lx out1=%lx out2=%lx out3=%lx "
 			     "out4=%lx out5=%lx out6=%lx out7=%lx out8=%lx "
-			     "out9=%lx", opcode, ret,*out1, *out2, *out3, *out4,
-			     *out5, *out6, *out7, *out8, *out9);
+			     "out9=%lx",
+			     opcode, ret, outs[0], outs[1], outs[2], outs[3],
+			     outs[4], outs[5], outs[6], outs[7], outs[8]);
 		return ret;
 
 	}
 
 	return H_BUSY;
 }
-
 u64 hipz_h_alloc_resource_eq(const struct ipz_adapter_handle adapter_handle,
 			     struct ehca_pfeq *pfeq,
 			     const u32 neq_control,
 			     const u32 number_of_entries,
 			     struct ipz_eq_handle *eq_handle,
-			     u32 * act_nr_of_entries,
-			     u32 * act_pages,
-			     u32 * eq_ist)
+			     u32 *act_nr_of_entries,
+			     u32 *act_pages,
+			     u32 *eq_ist)
 {
 	u64 ret;
-	u64 dummy;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 	u64 allocate_controls;
-	u64 act_nr_of_entries_out, act_pages_out, eq_ist_out;
 
 	/* resource type */
 	allocate_controls = 3ULL;
@@ -246,22 +216,15 @@ u64 hipz_h_alloc_resource_eq(const struc
 	else /* notification event queue */
 		allocate_controls = (1ULL << 63) | allocate_controls;
 
-	ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-				   adapter_handle.handle,  /* r4 */
-				   allocate_controls,      /* r5 */
-				   number_of_entries,      /* r6 */
-				   0, 0, 0, 0,
-				   &eq_handle->handle,     /* r4 */
-				   &dummy,	           /* r5 */
-				   &dummy,	           /* r6 */
-				   &act_nr_of_entries_out, /* r7 */
-				   &act_pages_out,	   /* r8 */
-				   &eq_ist_out,            /* r8 */
-				   &dummy);
-
-	*act_nr_of_entries = (u32)act_nr_of_entries_out;
-	*act_pages         = (u32)act_pages_out;
-	*eq_ist            = (u32)eq_ist_out;
+	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+				adapter_handle.handle,  /* r4 */
+				allocate_controls,      /* r5 */
+				number_of_entries,      /* r6 */
+				0, 0, 0, 0, 0, 0);
+	eq_handle->handle = outs[0];
+	*act_nr_of_entries = (u32)outs[3];
+	*act_pages = (u32)outs[4];
+	*eq_ist = (u32)outs[5];
 
 	if (ret == H_NOT_ENOUGH_RESOURCES)
 		ehca_gen_err("Not enough resource - ret=%lx ", ret);
@@ -273,20 +236,11 @@ u64 hipz_h_reset_event(const struct ipz_
 		       struct ipz_eq_handle eq_handle,
 		       const u64 event_mask)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_RESET_EVENTS,
-				    adapter_handle.handle, /* r4 */
-				    eq_handle.handle,      /* r5 */
-				    event_mask,	           /* r6 */
-				    0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_RESET_EVENTS,
+				       adapter_handle.handle, /* r4 */
+				       eq_handle.handle,      /* r5 */
+				       event_mask,	      /* r6 */
+				       0, 0, 0, 0);
 }
 
 u64 hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
@@ -294,30 +248,21 @@ u64 hipz_h_alloc_resource_cq(const struc
 			     struct ehca_alloc_cq_parms *param)
 {
 	u64 ret;
-	u64 dummy;
-	u64 act_nr_of_entries_out, act_pages_out;
-	u64 g_la_privileged_out, g_la_user_out;
-
-	ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-				   adapter_handle.handle,     /* r4  */
-				   2,	                      /* r5  */
-				   param->eq_handle.handle,   /* r6  */
-				   cq->token,	              /* r7  */
-				   param->nr_cqe,             /* r8  */
-				   0, 0,
-				   &cq->ipz_cq_handle.handle, /* r4  */
-				   &dummy,	              /* r5  */
-				   &dummy,	              /* r6  */
-				   &act_nr_of_entries_out,    /* r7  */
-				   &act_pages_out,	      /* r8  */
-				   &g_la_privileged_out,      /* r9  */
-				   &g_la_user_out);           /* r10 */
-
-	param->act_nr_of_entries = (u32)act_nr_of_entries_out;
-	param->act_pages = (u32)act_pages_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+				adapter_handle.handle,   /* r4  */
+				2,	                 /* r5  */
+				param->eq_handle.handle, /* r6  */
+				cq->token,	         /* r7  */
+				param->nr_cqe,           /* r8  */
+				0, 0, 0, 0);
+	cq->ipz_cq_handle.handle = outs[0];
+	param->act_nr_of_entries = (u32)outs[3];
+	param->act_pages = (u32)outs[4];
 
 	if (ret == H_SUCCESS)
-		hcp_galpas_ctor(&cq->galpas, g_la_privileged_out, g_la_user_out);
+		hcp_galpas_ctor(&cq->galpas, outs[5], outs[6]);
 
 	if (ret == H_NOT_ENOUGH_RESOURCES)
 		ehca_gen_err("Not enough resources. ret=%lx", ret);
@@ -330,8 +275,9 @@ u64 hipz_h_alloc_resource_qp(const struc
 			     struct ehca_alloc_qp_parms *parms)
 {
 	u64 ret;
-	u64 dummy, allocate_controls, max_r10_reg;
-	u64 qp_nr_out, r6_out, r7_out, r8_out, g_la_user_out, r11_out;
+	u64 allocate_controls;
+	u64 max_r10_reg;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 	u16 max_nr_receive_wqes = qp->init_attr.cap.max_recv_wr + 1;
 	u16 max_nr_send_wqes = qp->init_attr.cap.max_send_wr + 1;
 	int daqp_ctrl = parms->daqp_ctrl;
@@ -360,48 +306,36 @@ u64 hipz_h_alloc_resource_qp(const struc
 		| EHCA_BMASK_SET(H_ALL_RES_QP_MAX_RECV_SGE,
 				 parms->max_recv_sge);
 
-
-	ret = ehca_hcall_9arg_9ret(H_ALLOC_RESOURCE,
-				   adapter_handle.handle,	      /* r4  */
-				   allocate_controls,	              /* r5  */
-				   qp->send_cq->ipz_cq_handle.handle,
-				   qp->recv_cq->ipz_cq_handle.handle,
-				   parms->ipz_eq_handle.handle,
-				   ((u64)qp->token << 32) | parms->pd.value,
-				   max_r10_reg,	                      /* r10 */
-				   parms->ud_av_l_key_ctl,            /* r11 */
-				   0,
-				   &qp->ipz_qp_handle.handle,
-				   &qp_nr_out,	                      /* r5  */
-				   &r6_out,	                      /* r6  */
-				   &r7_out,	                      /* r7  */
-				   &r8_out,	                      /* r8  */
-				   &dummy,	                      /* r9  */
-				   &g_la_user_out,	              /* r10 */
-				   &r11_out,
-				   &dummy);
-
-	/* extract outputs */
-	qp->real_qp_num = (u32)qp_nr_out;
-
+	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+				adapter_handle.handle,	           /* r4  */
+				allocate_controls,	           /* r5  */
+				qp->send_cq->ipz_cq_handle.handle,
+				qp->recv_cq->ipz_cq_handle.handle,
+				parms->ipz_eq_handle.handle,
+				((u64)qp->token << 32) | parms->pd.value,
+				max_r10_reg,	                   /* r10 */
+				parms->ud_av_l_key_ctl,            /* r11 */
+				0);
+	qp->ipz_qp_handle.handle = outs[0];
+	qp->real_qp_num = (u32)outs[1];
 	parms->act_nr_send_sges =
-		(u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_SEND_WR, r6_out);
+		(u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_SEND_WR, outs[2]);
 	parms->act_nr_recv_wqes =
-		(u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_RECV_WR, r6_out);
+		(u16)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_OUTST_RECV_WR, outs[2]);
 	parms->act_nr_send_sges =
-		(u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_SEND_SGE, r7_out);
+		(u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_SEND_SGE, outs[3]);
 	parms->act_nr_recv_sges =
-		(u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_RECV_SGE, r7_out);
+		(u8)EHCA_BMASK_GET(H_ALL_RES_QP_ACT_RECV_SGE, outs[3]);
 	parms->nr_sq_pages =
-		(u32)EHCA_BMASK_GET(H_ALL_RES_QP_SQUEUE_SIZE_PAGES, r8_out);
+		(u32)EHCA_BMASK_GET(H_ALL_RES_QP_SQUEUE_SIZE_PAGES, outs[4]);
 	parms->nr_rq_pages =
-		(u32)EHCA_BMASK_GET(H_ALL_RES_QP_RQUEUE_SIZE_PAGES, r8_out);
+		(u32)EHCA_BMASK_GET(H_ALL_RES_QP_RQUEUE_SIZE_PAGES, outs[4]);
 
 	if (ret == H_SUCCESS)
-		hcp_galpas_ctor(&qp->galpas, g_la_user_out, g_la_user_out);
+		hcp_galpas_ctor(&qp->galpas, outs[6], outs[6]);
 
 	if (ret == H_NOT_ENOUGH_RESOURCES)
-		ehca_gen_err("Not enough resources. ret=%lx",ret);
+		ehca_gen_err("Not enough resources. ret=%lx", ret);
 
 	return ret;
 }
@@ -411,7 +345,6 @@ u64 hipz_h_query_port(const struct ipz_a
 		      struct hipz_query_port *query_port_response_block)
 {
 	u64 ret;
-	u64 dummy;
 	u64 r_cb = virt_to_abs(query_port_response_block);
 
 	if (r_cb & (EHCA_PAGESIZE-1)) {
@@ -419,18 +352,11 @@ u64 hipz_h_query_port(const struct ipz_a
 		return H_PARAMETER;
 	}
 
-	ret = ehca_hcall_7arg_7ret(H_QUERY_PORT,
-				   adapter_handle.handle, /* r4 */
-				   port_id,	          /* r5 */
-				   r_cb,	          /* r6 */
-				   0, 0, 0, 0,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
+	ret = ehca_plpar_hcall_norets(H_QUERY_PORT,
+				      adapter_handle.handle, /* r4 */
+				      port_id,	             /* r5 */
+				      r_cb,	             /* r6 */
+				      0, 0, 0, 0);
 
 	if (ehca_debug_level)
 		ehca_dmp(query_port_response_block, 64, "response_block");
@@ -441,7 +367,6 @@ u64 hipz_h_query_port(const struct ipz_a
 u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
 		     struct hipz_query_hca *query_hca_rblock)
 {
-	u64 dummy;
 	u64 r_cb = virt_to_abs(query_hca_rblock);
 
 	if (r_cb & (EHCA_PAGESIZE-1)) {
@@ -450,17 +375,10 @@ u64 hipz_h_query_hca(const struct ipz_ad
 		return H_PARAMETER;
 	}
 
-	return ehca_hcall_7arg_7ret(H_QUERY_HCA,
-				    adapter_handle.handle, /* r4 */
-				    r_cb,                  /* r5 */
-				    0, 0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_QUERY_HCA,
+				       adapter_handle.handle, /* r4 */
+				       r_cb,                  /* r5 */
+				       0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_register_rpage(const struct ipz_adapter_handle adapter_handle,
@@ -470,22 +388,13 @@ u64 hipz_h_register_rpage(const struct i
 			  const u64 logical_address_of_page,
 			  u64 count)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_REGISTER_RPAGES,
-				    adapter_handle.handle,      /* r4  */
-				    queue_type | pagesize << 8, /* r5  */
-				    resource_handle,	        /* r6  */
-				    logical_address_of_page,    /* r7  */
-				    count,	                /* r8  */
-				    0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_REGISTER_RPAGES,
+				       adapter_handle.handle,      /* r4  */
+				       queue_type | pagesize << 8, /* r5  */
+				       resource_handle,	           /* r6  */
+				       logical_address_of_page,    /* r7  */
+				       count,	                   /* r8  */
+				       0, 0);
 }
 
 u64 hipz_h_register_rpage_eq(const struct ipz_adapter_handle adapter_handle,
@@ -507,23 +416,14 @@ u64 hipz_h_register_rpage_eq(const struc
 				     logical_address_of_page, count);
 }
 
-u32 hipz_h_query_int_state(const struct ipz_adapter_handle adapter_handle,
+u64 hipz_h_query_int_state(const struct ipz_adapter_handle adapter_handle,
 			   u32 ist)
 {
-	u32 ret;
-	u64 dummy;
-
-	ret = ehca_hcall_7arg_7ret(H_QUERY_INT_STATE,
-				   adapter_handle.handle, /* r4 */
-				   ist,                   /* r5 */
-				   0, 0, 0, 0, 0,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
+	u64 ret;
+	ret = ehca_plpar_hcall_norets(H_QUERY_INT_STATE,
+				      adapter_handle.handle, /* r4 */
+				      ist,                   /* r5 */
+				      0, 0, 0, 0, 0);
 
 	if (ret != H_SUCCESS && ret != H_BUSY)
 		ehca_gen_err("Could not query interrupt state.");
@@ -576,25 +476,20 @@ u64 hipz_h_disable_and_get_wqe(const str
 			       void **log_addr_next_rq_wqe2processed,
 			       int dis_and_get_function_code)
 {
-	u64 dummy, dummy1, dummy2;
-
-	if (!log_addr_next_sq_wqe2processed)
-		log_addr_next_sq_wqe2processed = (void**)&dummy1;
-	if (!log_addr_next_rq_wqe2processed)
-		log_addr_next_rq_wqe2processed = (void**)&dummy2;
-
-	return ehca_hcall_7arg_7ret(H_DISABLE_AND_GETC,
-				    adapter_handle.handle,     /* r4 */
-				    dis_and_get_function_code, /* r5 */
-				    qp_handle.handle,	       /* r6 */
-				    0, 0, 0, 0,
-				    (void*)log_addr_next_sq_wqe2processed,
-				    (void*)log_addr_next_rq_wqe2processed,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	u64 ret;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_DISABLE_AND_GETC, outs,
+				adapter_handle.handle,     /* r4 */
+				dis_and_get_function_code, /* r5 */
+				qp_handle.handle,	   /* r6 */
+				0, 0, 0, 0, 0, 0);
+	if (log_addr_next_sq_wqe2processed)
+		*log_addr_next_sq_wqe2processed = (void*)outs[0];
+	if (log_addr_next_rq_wqe2processed)
+		*log_addr_next_rq_wqe2processed = (void*)outs[1];
+
+	return ret;
 }
 
 u64 hipz_h_modify_qp(const struct ipz_adapter_handle adapter_handle,
@@ -605,22 +500,13 @@ u64 hipz_h_modify_qp(const struct ipz_ad
 		     struct h_galpa gal)
 {
 	u64 ret;
-	u64 dummy;
-	u64 invalid_attribute_identifier, rc_attrib_mask;
-
-	ret = ehca_hcall_7arg_7ret(H_MODIFY_QP,
-				   adapter_handle.handle,         /* r4 */
-				   qp_handle.handle,	          /* r5 */
-				   update_mask,	                  /* r6 */
-				   virt_to_abs(mqpcb),	          /* r7 */
-				   0, 0, 0,
-				   &invalid_attribute_identifier, /* r4 */
-				   &dummy,	                  /* r5 */
-				   &dummy,	                  /* r6 */
-				   &dummy,                        /* r7 */
-				   &dummy,	                  /* r8 */
-				   &rc_attrib_mask,               /* r9 */
-				   &dummy);
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+	ret = ehca_plpar_hcall9(H_MODIFY_QP, outs,
+				adapter_handle.handle, /* r4 */
+				qp_handle.handle,      /* r5 */
+				update_mask,	       /* r6 */
+				virt_to_abs(mqpcb),    /* r7 */
+				0, 0, 0, 0, 0);
 
 	if (ret == H_NOT_ENOUGH_RESOURCES)
 		ehca_gen_err("Insufficient resources ret=%lx", ret);
@@ -634,61 +520,37 @@ u64 hipz_h_query_qp(const struct ipz_ada
 		    struct hcp_modify_qp_control_block *qqpcb,
 		    struct h_galpa gal)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_QUERY_QP,
-				    adapter_handle.handle, /* r4 */
-				    qp_handle.handle,      /* r5 */
-				    virt_to_abs(qqpcb),	   /* r6 */
-				    0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_QUERY_QP,
+				       adapter_handle.handle, /* r4 */
+				       qp_handle.handle,      /* r5 */
+				       virt_to_abs(qqpcb),    /* r6 */
+				       0, 0, 0, 0);
 }
 
 u64 hipz_h_destroy_qp(const struct ipz_adapter_handle adapter_handle,
 		      struct ehca_qp *qp)
 {
 	u64 ret;
-	u64 dummy;
-	u64 ladr_next_sq_wqe_out, ladr_next_rq_wqe_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
 
 	ret = hcp_galpas_dtor(&qp->galpas);
 	if (ret) {
 		ehca_gen_err("Could not destruct qp->galpas");
 		return H_RESOURCE;
 	}
-	ret = ehca_hcall_7arg_7ret(H_DISABLE_AND_GETC,
-				   adapter_handle.handle,     /* r4 */
-				   /* function code */
-				   1,	                      /* r5 */
-				   qp->ipz_qp_handle.handle,  /* r6 */
-				   0, 0, 0, 0,
-				   &ladr_next_sq_wqe_out,     /* r4 */
-				   &ladr_next_rq_wqe_out,     /* r5 */
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
+	ret = ehca_plpar_hcall9(H_DISABLE_AND_GETC, outs,
+				adapter_handle.handle,     /* r4 */
+				/* function code */
+				1,	                   /* r5 */
+				qp->ipz_qp_handle.handle,  /* r6 */
+				0, 0, 0, 0, 0, 0);
 	if (ret == H_HARDWARE)
 		ehca_gen_err("HCA not operational. ret=%lx", ret);
 
-	ret = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-				   adapter_handle.handle,     /* r4 */
-				   qp->ipz_qp_handle.handle,  /* r5 */
-				   0, 0, 0, 0, 0,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
+	ret = ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+				      adapter_handle.handle,     /* r4 */
+				      qp->ipz_qp_handle.handle,  /* r5 */
+				      0, 0, 0, 0, 0);
 
 	if (ret == H_RESOURCE)
 		ehca_gen_err("Resource still in use. ret=%lx", ret);
@@ -701,20 +563,11 @@ u64 hipz_h_define_aqp0(const struct ipz_
 		       struct h_galpa gal,
 		       u32 port)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_DEFINE_AQP0,
-				    adapter_handle.handle, /* r4 */
-				    qp_handle.handle,      /* r5 */
-				    port,                  /* r6 */
-				    0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_DEFINE_AQP0,
+				       adapter_handle.handle, /* r4 */
+				       qp_handle.handle,      /* r5 */
+				       port,                  /* r6 */
+				       0, 0, 0, 0);
 }
 
 u64 hipz_h_define_aqp1(const struct ipz_adapter_handle adapter_handle,
@@ -724,24 +577,15 @@ u64 hipz_h_define_aqp1(const struct ipz_
 		       u32 * bma_qp_nr)
 {
 	u64 ret;
-	u64 dummy;
-	u64 pma_qp_nr_out, bma_qp_nr_out;
-
-	ret = ehca_hcall_7arg_7ret(H_DEFINE_AQP1,
-				   adapter_handle.handle, /* r4 */
-				   qp_handle.handle,      /* r5 */
-				   port,	          /* r6 */
-				   0, 0, 0, 0,
-				   &pma_qp_nr_out,        /* r4 */
-				   &bma_qp_nr_out,        /* r5 */
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
-
-	*pma_qp_nr = (u32)pma_qp_nr_out;
-	*bma_qp_nr = (u32)bma_qp_nr_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_DEFINE_AQP1, outs,
+				adapter_handle.handle, /* r4 */
+				qp_handle.handle,      /* r5 */
+				port,	               /* r6 */
+				0, 0, 0, 0, 0, 0);
+	*pma_qp_nr = (u32)outs[0];
+	*bma_qp_nr = (u32)outs[1];
 
 	if (ret == H_ALIAS_EXIST)
 		ehca_gen_err("AQP1 already exists. ret=%lx", ret);
@@ -756,22 +600,14 @@ u64 hipz_h_attach_mcqp(const struct ipz_
 		       u64 subnet_prefix, u64 interface_id)
 {
 	u64 ret;
-	u64 dummy;
-
-	ret = ehca_hcall_7arg_7ret(H_ATTACH_MCQP,
-				   adapter_handle.handle,     /* r4 */
-				   qp_handle.handle,          /* r5 */
-				   mcg_dlid,                  /* r6 */
-				   interface_id,              /* r7 */
-				   subnet_prefix,             /* r8 */
-				   0, 0,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
+
+	ret = ehca_plpar_hcall_norets(H_ATTACH_MCQP,
+				      adapter_handle.handle,  /* r4 */
+				      qp_handle.handle,       /* r5 */
+				      mcg_dlid,               /* r6 */
+				      interface_id,           /* r7 */
+				      subnet_prefix,          /* r8 */
+				      0, 0);
 
 	if (ret == H_NOT_ENOUGH_RESOURCES)
 		ehca_gen_err("Not enough resources. ret=%lx", ret);
@@ -785,22 +621,13 @@ u64 hipz_h_detach_mcqp(const struct ipz_
 		       u16 mcg_dlid,
 		       u64 subnet_prefix, u64 interface_id)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_DETACH_MCQP,
-				    adapter_handle.handle, /* r4 */
-				    qp_handle.handle,	   /* r5 */
-				    mcg_dlid,	           /* r6 */
-				    interface_id,          /* r7 */
-				    subnet_prefix,         /* r8 */
-				    0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_DETACH_MCQP,
+				       adapter_handle.handle, /* r4 */
+				       qp_handle.handle,      /* r5 */
+				       mcg_dlid,              /* r6 */
+				       interface_id,          /* r7 */
+				       subnet_prefix,         /* r8 */
+				       0, 0);
 }
 
 u64 hipz_h_destroy_cq(const struct ipz_adapter_handle adapter_handle,
@@ -808,7 +635,6 @@ u64 hipz_h_destroy_cq(const struct ipz_a
 		      u8 force_flag)
 {
 	u64 ret;
-	u64 dummy;
 
 	ret = hcp_galpas_dtor(&cq->galpas);
 	if (ret) {
@@ -816,18 +642,11 @@ u64 hipz_h_destroy_cq(const struct ipz_a
 		return H_RESOURCE;
 	}
 
-	ret = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-				   adapter_handle.handle,     /* r4 */
-				   cq->ipz_cq_handle.handle,  /* r5 */
-				   force_flag != 0 ? 1L : 0L, /* r6 */
-				   0, 0, 0, 0,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
+	ret = ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+				      adapter_handle.handle,     /* r4 */
+				      cq->ipz_cq_handle.handle,  /* r5 */
+				      force_flag != 0 ? 1L : 0L, /* r6 */
+				      0, 0, 0, 0);
 
 	if (ret == H_RESOURCE)
 		ehca_gen_err("H_FREE_RESOURCE failed ret=%lx ", ret);
@@ -839,7 +658,6 @@ u64 hipz_h_destroy_eq(const struct ipz_a
 		      struct ehca_eq *eq)
 {
 	u64 ret;
-	u64 dummy;
 
 	ret = hcp_galpas_dtor(&eq->galpas);
 	if (ret) {
@@ -847,18 +665,10 @@ u64 hipz_h_destroy_eq(const struct ipz_a
 		return H_RESOURCE;
 	}
 
-	ret = ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-				   adapter_handle.handle,     /* r4 */
-				   eq->ipz_eq_handle.handle,  /* r5 */
-				   0, 0, 0, 0, 0,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy,
-				   &dummy);
-
+	ret = ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+				      adapter_handle.handle,     /* r4 */
+				      eq->ipz_eq_handle.handle,  /* r5 */
+				      0, 0, 0, 0, 0);
 
 	if (ret == H_RESOURCE)
 		ehca_gen_err("Resource in use. ret=%lx ", ret);
@@ -875,27 +685,19 @@ u64 hipz_h_alloc_resource_mr(const struc
 			     struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 dummy;
-	u64 lkey_out;
-	u64 rkey_out;
-
-	ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-				   adapter_handle.handle,            /* r4 */
-				   5,                                /* r5 */
-				   vaddr,                            /* r6 */
-				   length,                           /* r7 */
-				   (((u64)access_ctrl) << 32ULL),    /* r8 */
-				   pd.value,                         /* r9 */
-				   0,
-				   &(outparms->handle.handle),       /* r4 */
-				   &dummy,                           /* r5 */
-				   &lkey_out,                        /* r6 */
-				   &rkey_out,                        /* r7 */
-				   &dummy,
-				   &dummy,
-				   &dummy);
-	outparms->lkey = (u32)lkey_out;
-	outparms->rkey = (u32)rkey_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+				adapter_handle.handle,            /* r4 */
+				5,                                /* r5 */
+				vaddr,                            /* r6 */
+				length,                           /* r7 */
+				(((u64)access_ctrl) << 32ULL),    /* r8 */
+				pd.value,                         /* r9 */
+				0, 0, 0);
+	outparms->handle.handle = outs[0];
+	outparms->lkey = (u32)outs[2];
+	outparms->rkey = (u32)outs[3];
 
 	return ret;
 }
@@ -923,7 +725,6 @@ u64 hipz_h_register_rpage_mr(const struc
 					    queue_type,
 					    mr->ipz_mr_handle.handle,
 					    logical_address_of_page, count);
-
 	return ret;
 }
 
@@ -932,24 +733,17 @@ u64 hipz_h_query_mr(const struct ipz_ada
 		    struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 dummy;
-	u64 remote_len_out, remote_vaddr_out, acc_ctrl_pd_out, r9_out;
-
-	ret = ehca_hcall_7arg_7ret(H_QUERY_MR,
-				   adapter_handle.handle,     /* r4 */
-				   mr->ipz_mr_handle.handle,  /* r5 */
-				   0, 0, 0, 0, 0,
-				   &outparms->len,            /* r4 */
-				   &outparms->vaddr,          /* r5 */
-				   &remote_len_out,           /* r6 */
-				   &remote_vaddr_out,         /* r7 */
-				   &acc_ctrl_pd_out,          /* r8 */
-				   &r9_out,
-				   &dummy);
-
-	outparms->acl  = acc_ctrl_pd_out >> 32;
-	outparms->lkey = (u32)(r9_out >> 32);
-	outparms->rkey = (u32)(r9_out & (0xffffffff));
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_QUERY_MR, outs,
+				adapter_handle.handle,     /* r4 */
+				mr->ipz_mr_handle.handle,  /* r5 */
+				0, 0, 0, 0, 0, 0, 0);
+	outparms->len = outs[0];
+	outparms->vaddr = outs[1];
+	outparms->acl  = outs[4] >> 32;
+	outparms->lkey = (u32)(outs[5] >> 32);
+	outparms->rkey = (u32)(outs[5] & (0xffffffff));
 
 	return ret;
 }
@@ -957,19 +751,10 @@ u64 hipz_h_query_mr(const struct ipz_ada
 u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle adapter_handle,
 			    const struct ehca_mr *mr)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-				    adapter_handle.handle,    /* r4 */
-				    mr->ipz_mr_handle.handle, /* r5 */
-				    0, 0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+				       adapter_handle.handle,    /* r4 */
+				       mr->ipz_mr_handle.handle, /* r5 */
+				       0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
@@ -982,28 +767,20 @@ u64 hipz_h_reregister_pmr(const struct i
 			  struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 dummy;
-	u64 lkey_out, rkey_out;
-
-	ret = ehca_hcall_7arg_7ret(H_REREGISTER_PMR,
-				   adapter_handle.handle,    /* r4 */
-				   mr->ipz_mr_handle.handle, /* r5 */
-				   vaddr_in,	             /* r6 */
-				   length,                   /* r7 */
-				   /* r8 */
-				   ((((u64)access_ctrl) << 32ULL) | pd.value),
-				   mr_addr_cb,               /* r9 */
-				   0,
-				   &dummy,                   /* r4 */
-				   &outparms->vaddr,         /* r5 */
-				   &lkey_out,                /* r6 */
-				   &rkey_out,                /* r7 */
-				   &dummy,
-				   &dummy,
-				   &dummy);
-
-	outparms->lkey = (u32)lkey_out;
-	outparms->rkey = (u32)rkey_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_REREGISTER_PMR, outs,
+				adapter_handle.handle,    /* r4 */
+				mr->ipz_mr_handle.handle, /* r5 */
+				vaddr_in,	          /* r6 */
+				length,                   /* r7 */
+				/* r8 */
+				((((u64)access_ctrl) << 32ULL) | pd.value),
+				mr_addr_cb,               /* r9 */
+				0, 0, 0);
+	outparms->vaddr = outs[1];
+	outparms->lkey = (u32)outs[2];
+	outparms->rkey = (u32)outs[3];
 
 	return ret;
 }
@@ -1017,25 +794,18 @@ u64 hipz_h_register_smr(const struct ipz
 			struct ehca_mr_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 dummy;
-	u64 lkey_out, rkey_out;
-
-	ret = ehca_hcall_7arg_7ret(H_REGISTER_SMR,
-				   adapter_handle.handle,            /* r4 */
-				   orig_mr->ipz_mr_handle.handle,    /* r5 */
-				   vaddr_in,                         /* r6 */
-				   (((u64)access_ctrl) << 32ULL),    /* r7 */
-				   pd.value,                         /* r8 */
-				   0, 0,
-				   &(outparms->handle.handle),       /* r4 */
-				   &dummy,                           /* r5 */
-				   &lkey_out,                        /* r6 */
-				   &rkey_out,                        /* r7 */
-				   &dummy,
-				   &dummy,
-				   &dummy);
-	outparms->lkey = (u32)lkey_out;
-	outparms->rkey = (u32)rkey_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_REGISTER_SMR, outs,
+				adapter_handle.handle,            /* r4 */
+				orig_mr->ipz_mr_handle.handle,    /* r5 */
+				vaddr_in,                         /* r6 */
+				(((u64)access_ctrl) << 32ULL),    /* r7 */
+				pd.value,                         /* r8 */
+				0, 0, 0, 0);
+	outparms->handle.handle = outs[0];
+	outparms->lkey = (u32)outs[2];
+	outparms->rkey = (u32)outs[3];
 
 	return ret;
 }
@@ -1046,23 +816,15 @@ u64 hipz_h_alloc_resource_mw(const struc
 			     struct ehca_mw_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 dummy;
-	u64 rkey_out;
-
-	ret = ehca_hcall_7arg_7ret(H_ALLOC_RESOURCE,
-				   adapter_handle.handle,      /* r4 */
-				   6,                          /* r5 */
-				   pd.value,                   /* r6 */
-				   0, 0, 0, 0,
-				   &(outparms->handle.handle), /* r4 */
-				   &dummy,                     /* r5 */
-				   &dummy,                     /* r6 */
-				   &rkey_out,                  /* r7 */
-				   &dummy,
-				   &dummy,
-				   &dummy);
-
-	outparms->rkey = (u32)rkey_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_ALLOC_RESOURCE, outs,
+				adapter_handle.handle,      /* r4 */
+				6,                          /* r5 */
+				pd.value,                   /* r6 */
+				0, 0, 0, 0, 0, 0);
+	outparms->handle.handle = outs[0];
+	outparms->rkey = (u32)outs[3];
 
 	return ret;
 }
@@ -1072,21 +834,13 @@ u64 hipz_h_query_mw(const struct ipz_ada
 		    struct ehca_mw_hipzout_parms *outparms)
 {
 	u64 ret;
-	u64 dummy;
-	u64 pd_out, rkey_out;
-
-	ret = ehca_hcall_7arg_7ret(H_QUERY_MW,
-				   adapter_handle.handle,    /* r4 */
-				   mw->ipz_mw_handle.handle, /* r5 */
-				   0, 0, 0, 0, 0,
-				   &dummy,                   /* r4 */
-				   &dummy,                   /* r5 */
-				   &dummy,                   /* r6 */
-				   &rkey_out,                /* r7 */
-				   &pd_out,                  /* r8 */
-				   &dummy,
-				   &dummy);
-	outparms->rkey = (u32)rkey_out;
+	u64 outs[PLPAR_HCALL9_BUFSIZE];
+
+	ret = ehca_plpar_hcall9(H_QUERY_MW, outs,
+				adapter_handle.handle,    /* r4 */
+				mw->ipz_mw_handle.handle, /* r5 */
+				0, 0, 0, 0, 0, 0, 0);
+	outparms->rkey = (u32)outs[3];
 
 	return ret;
 }
@@ -1094,19 +848,10 @@ u64 hipz_h_query_mw(const struct ipz_ada
 u64 hipz_h_free_resource_mw(const struct ipz_adapter_handle adapter_handle,
 			    const struct ehca_mw *mw)
 {
-	u64 dummy;
-
-	return ehca_hcall_7arg_7ret(H_FREE_RESOURCE,
-				    adapter_handle.handle,    /* r4 */
-				    mw->ipz_mw_handle.handle, /* r5 */
-				    0, 0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_FREE_RESOURCE,
+				       adapter_handle.handle,    /* r4 */
+				       mw->ipz_mw_handle.handle, /* r5 */
+				       0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
@@ -1114,7 +859,6 @@ u64 hipz_h_error_data(const struct ipz_a
 		      void *rblock,
 		      unsigned long *byte_count)
 {
-	u64 dummy;
 	u64 r_cb = virt_to_abs(rblock);
 
 	if (r_cb & (EHCA_PAGESIZE-1)) {
@@ -1122,16 +866,9 @@ u64 hipz_h_error_data(const struct ipz_a
 		return H_PARAMETER;
 	}
 
-	return ehca_hcall_7arg_7ret(H_ERROR_DATA,
-				    adapter_handle.handle,
-				    ressource_handle,
-				    r_cb,
-				    0, 0, 0, 0,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy,
-				    &dummy);
+	return ehca_plpar_hcall_norets(H_ERROR_DATA,
+				       adapter_handle.handle,
+				       ressource_handle,
+				       r_cb,
+				       0, 0, 0, 0);
 }
diff --git a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
index 39956d8..587ebd4 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.h
+++ b/drivers/infiniband/hw/ehca/hcp_if.h
@@ -107,7 +107,7 @@ u64 hipz_h_register_rpage_eq(const struc
 			     const u64 logical_address_of_page,
 			     const u64 count);
 
-u32 hipz_h_query_int_state(const struct ipz_adapter_handle
+u64 hipz_h_query_int_state(const struct ipz_adapter_handle
 			   hcp_adapter_handle,
 			   u32 ist);
 
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index f5f4871..3fc92b0 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -184,8 +184,6 @@ struct hipz_mrmwmm {
 
 };
 
-#define MRX_HCR_LPARID_VALID EHCA_BMASK_IBM(0,0)
-
 #define MRMWMM_OFFSET(x) offsetof(struct hipz_mrmwmm,x)
 
 struct hipz_qpedmm {
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.h b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
index 7e55a31..2f13509 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.h
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
@@ -226,10 +226,9 @@ static inline void *ipz_eqit_eq_get_inc_
 {
 	void *ret = ipz_qeit_get(queue);
 	u32 qe = *(u8 *) ret;
-	if ((qe >> 7) == (queue->toggle_state & 1))
-		ipz_qeit_eq_get_inc(queue); /* this is a good one */
-	else
-		ret = NULL;
+	if ((qe >> 7) != (queue->toggle_state & 1))
+		return NULL;
+	ipz_qeit_eq_get_inc(queue); /* this is a good one */
 	return ret;
 }
 

--Boundary-00=_48/EF5v2jWzSHr3--
