Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWDSSoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWDSSoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWDSSoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:44:11 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:9240 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750905AbWDSSoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:44:10 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] InfiniBand fixes for 2.6.17-rc2
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 19 Apr 2006 11:44:03 -0700
Message-ID: <adahd4p9zik.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Apr 2006 18:44:06.0062 (UTC) FILETIME=[3C8294E0:01C663E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This is mostly (by total lines of patch) cleanups for the ipath driver,
with a few other fixes thrown in.

The exact changes and patch are:

Adrian Bunk:
      IB/mthca: make a function static

Hal Rosenstock:
      IB/mad: Fix RMPP version check during agent registration

Roland Dreier:
      IB/srp: Remove request from list when SCSI abort succeeds
      IB/ipath: Make more names static
      IB/ipath: Fix whitespace

 drivers/infiniband/core/mad.c              |    5 -
 drivers/infiniband/hw/ipath/ipath_diag.c   |   12 ---
 drivers/infiniband/hw/ipath/ipath_driver.c |    2 
 drivers/infiniband/hw/ipath/ipath_intr.c   |    4 -
 drivers/infiniband/hw/ipath/ipath_kernel.h |    1 
 drivers/infiniband/hw/ipath/ipath_layer.c  |    2 
 drivers/infiniband/hw/ipath/ipath_pe800.c  |   10 +-
 drivers/infiniband/hw/ipath/ipath_qp.c     |  124 ++++++++++++++--------------
 drivers/infiniband/hw/ipath/ipath_ud.c     |    4 -
 drivers/infiniband/hw/ipath/ipath_verbs.c  |  122 ++++++++++++++--------------
 drivers/infiniband/hw/ipath/ipath_verbs.h  |    5 -
 drivers/infiniband/hw/mthca/mthca_mad.c    |    2 
 drivers/infiniband/ulp/srp/ib_srp.c        |   18 ++--
 13 files changed, 147 insertions(+), 164 deletions(-)


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 3a702da..469b692 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -228,10 +228,7 @@ struct ib_mad_agent *ib_register_mad_age
 				goto error1;
 		}
 		/* Make sure class supplied is consistent with RMPP */
-		if (ib_is_mad_class_rmpp(mad_reg_req->mgmt_class)) {
-			if (!rmpp_version)
-				goto error1;
-		} else {
+		if (!ib_is_mad_class_rmpp(mad_reg_req->mgmt_class)) {
 			if (rmpp_version)
 				goto error1;
 		}
diff --git a/drivers/infiniband/hw/ipath/ipath_diag.c b/drivers/infiniband/hw/ipath/ipath_diag.c
index cd533cf..7d3fb69 100644
--- a/drivers/infiniband/hw/ipath/ipath_diag.c
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c
@@ -365,15 +365,3 @@ static ssize_t ipath_diag_write(struct f
 bail:
 	return ret;
 }
-
-void ipath_diag_bringup_link(struct ipath_devdata *dd)
-{
-	if (diag_set_link || (dd->ipath_flags & IPATH_LINKACTIVE))
-		return;
-
-	diag_set_link = 1;
-	ipath_cdbg(VERBOSE, "Trying to set to set link active for "
-		   "diag pkt\n");
-	ipath_layer_set_linkstate(dd, IPATH_IB_LINKARM);
-	ipath_layer_set_linkstate(dd, IPATH_IB_LINKACTIVE);
-}
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index 58a94ef..e7617c3 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -1729,7 +1729,7 @@ void ipath_free_pddata(struct ipath_devd
 	}
 }
 
-int __init infinipath_init(void)
+static int __init infinipath_init(void)
 {
 	int ret;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_intr.c b/drivers/infiniband/hw/ipath/ipath_intr.c
index 60f5f41..0bcb428 100644
--- a/drivers/infiniband/hw/ipath/ipath_intr.c
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c
@@ -172,8 +172,8 @@ static void handle_e_ibstatuschanged(str
 				   "was %s\n", dd->ipath_unit,
 				   ib_linkstate(lstate),
 				   ib_linkstate((unsigned)
-				   		dd->ipath_lastibcstat
-				   		& IPATH_IBSTATE_MASK));
+						dd->ipath_lastibcstat
+						& IPATH_IBSTATE_MASK));
 	}
 	else {
 		lstate = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
index 159d0ae..0ce5f19 100644
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h
@@ -528,7 +528,6 @@ extern spinlock_t ipath_devs_lock;
 extern struct ipath_devdata *ipath_lookup(int unit);
 
 extern u16 ipath_layer_rcv_opcode;
-extern int ipath_verbs_registered;
 extern int __ipath_layer_intr(struct ipath_devdata *, u32);
 extern int ipath_layer_intr(struct ipath_devdata *, u32);
 extern int __ipath_layer_rcv(struct ipath_devdata *, void *,
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
index 2cabf63..69ed110 100644
--- a/drivers/infiniband/hw/ipath/ipath_layer.c
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c
@@ -52,7 +52,7 @@ static int (*layer_rcv)(void *, void *, 
 static int (*layer_rcv_lid)(void *, void *);
 static int (*verbs_piobufavail)(void *);
 static void (*verbs_rcv)(void *, void *, void *, u32);
-int ipath_verbs_registered;
+static int ipath_verbs_registered;
 
 static void *(*layer_add_one)(int, struct ipath_devdata *);
 static void (*layer_remove_one)(void *);
diff --git a/drivers/infiniband/hw/ipath/ipath_pe800.c b/drivers/infiniband/hw/ipath/ipath_pe800.c
index e693a7a..e1dc4f7 100644
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c
@@ -305,8 +305,8 @@ static const struct ipath_cregs ipath_pe
  * we'll print them and continue.  We reuse the same message buffer as
  * ipath_handle_errors() to avoid excessive stack usage.
  */
-void ipath_pe_handle_hwerrors(struct ipath_devdata *dd, char *msg,
-	size_t msgl)
+static void ipath_pe_handle_hwerrors(struct ipath_devdata *dd, char *msg,
+				     size_t msgl)
 {
 	ipath_err_t hwerrs;
 	u32 bits, ctrl;
@@ -552,7 +552,7 @@ static int ipath_pe_boardname(struct ipa
  * freeze mode), and enable hardware errors as errors (along with
  * everything else) in errormask
  */
-void ipath_pe_init_hwerrors(struct ipath_devdata *dd)
+static void ipath_pe_init_hwerrors(struct ipath_devdata *dd)
 {
 	ipath_err_t val;
 	u64 extsval;
@@ -577,7 +577,7 @@ void ipath_pe_init_hwerrors(struct ipath
  * ipath_pe_bringup_serdes - bring up the serdes
  * @dd: the infinipath device
  */
-int ipath_pe_bringup_serdes(struct ipath_devdata *dd)
+static int ipath_pe_bringup_serdes(struct ipath_devdata *dd)
 {
 	u64 val, tmp, config1;
 	int ret = 0, change = 0;
@@ -694,7 +694,7 @@ int ipath_pe_bringup_serdes(struct ipath
  * @dd: the infinipath device
  * Called when driver is being unloaded
  */
-void ipath_pe_quiet_serdes(struct ipath_devdata *dd)
+static void ipath_pe_quiet_serdes(struct ipath_devdata *dd)
 {
 	u64 val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_serdesconfig0);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
index 6058d70..1889071 100644
--- a/drivers/infiniband/hw/ipath/ipath_qp.c
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c
@@ -188,8 +188,8 @@ static void free_qpn(struct ipath_qp_tab
  * Allocate the next available QPN and put the QP into the hash table.
  * The hash table holds a reference to the QP.
  */
-int ipath_alloc_qpn(struct ipath_qp_table *qpt, struct ipath_qp *qp,
-		    enum ib_qp_type type)
+static int ipath_alloc_qpn(struct ipath_qp_table *qpt, struct ipath_qp *qp,
+			   enum ib_qp_type type)
 {
 	unsigned long flags;
 	u32 qpn;
@@ -232,7 +232,7 @@ bail:
  * Remove the QP from the table so it can't be found asynchronously by
  * the receive interrupt routine.
  */
-void ipath_free_qp(struct ipath_qp_table *qpt, struct ipath_qp *qp)
+static void ipath_free_qp(struct ipath_qp_table *qpt, struct ipath_qp *qp)
 {
 	struct ipath_qp *q, **qpp;
 	unsigned long flags;
@@ -358,6 +358,65 @@ static void ipath_reset_qp(struct ipath_
 }
 
 /**
+ * ipath_error_qp - put a QP into an error state
+ * @qp: the QP to put into an error state
+ *
+ * Flushes both send and receive work queues.
+ * QP r_rq.lock and s_lock should be held.
+ */
+
+static void ipath_error_qp(struct ipath_qp *qp)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ib_wc wc;
+
+	_VERBS_INFO("QP%d/%d in error state\n",
+		    qp->ibqp.qp_num, qp->remote_qpn);
+
+	spin_lock(&dev->pending_lock);
+	/* XXX What if its already removed by the timeout code? */
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	if (qp->piowait.next != LIST_POISON1)
+		list_del(&qp->piowait);
+	spin_unlock(&dev->pending_lock);
+
+	wc.status = IB_WC_WR_FLUSH_ERR;
+	wc.vendor_err = 0;
+	wc.byte_len = 0;
+	wc.imm_data = 0;
+	wc.qp_num = qp->ibqp.qp_num;
+	wc.src_qp = 0;
+	wc.wc_flags = 0;
+	wc.pkey_index = 0;
+	wc.slid = 0;
+	wc.sl = 0;
+	wc.dlid_path_bits = 0;
+	wc.port_num = 0;
+
+	while (qp->s_last != qp->s_head) {
+		struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
+
+		wc.wr_id = wqe->wr.wr_id;
+		wc.opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+		if (++qp->s_last >= qp->s_size)
+			qp->s_last = 0;
+		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 1);
+	}
+	qp->s_cur = qp->s_tail = qp->s_head;
+	qp->s_hdrwords = 0;
+	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
+
+	wc.opcode = IB_WC_RECV;
+	while (qp->r_rq.tail != qp->r_rq.head) {
+		wc.wr_id = get_rwqe_ptr(&qp->r_rq, qp->r_rq.tail)->wr_id;
+		if (++qp->r_rq.tail >= qp->r_rq.size)
+			qp->r_rq.tail = 0;
+		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc, 1);
+	}
+}
+
+/**
  * ipath_modify_qp - modify the attributes of a queue pair
  * @ibqp: the queue pair who's attributes we're modifying
  * @attr: the new attributes
@@ -821,65 +880,6 @@ void ipath_sqerror_qp(struct ipath_qp *q
 }
 
 /**
- * ipath_error_qp - put a QP into an error state
- * @qp: the QP to put into an error state
- *
- * Flushes both send and receive work queues.
- * QP r_rq.lock and s_lock should be held.
- */
-
-void ipath_error_qp(struct ipath_qp *qp)
-{
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
-	struct ib_wc wc;
-
-	_VERBS_INFO("QP%d/%d in error state\n",
-		    qp->ibqp.qp_num, qp->remote_qpn);
-
-	spin_lock(&dev->pending_lock);
-	/* XXX What if its already removed by the timeout code? */
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
-	spin_unlock(&dev->pending_lock);
-
-	wc.status = IB_WC_WR_FLUSH_ERR;
-	wc.vendor_err = 0;
-	wc.byte_len = 0;
-	wc.imm_data = 0;
-	wc.qp_num = qp->ibqp.qp_num;
-	wc.src_qp = 0;
-	wc.wc_flags = 0;
-	wc.pkey_index = 0;
-	wc.slid = 0;
-	wc.sl = 0;
-	wc.dlid_path_bits = 0;
-	wc.port_num = 0;
-
-	while (qp->s_last != qp->s_head) {
-		struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
-
-		wc.wr_id = wqe->wr.wr_id;
-		wc.opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
-		if (++qp->s_last >= qp->s_size)
-			qp->s_last = 0;
-		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 1);
-	}
-	qp->s_cur = qp->s_tail = qp->s_head;
-	qp->s_hdrwords = 0;
-	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
-
-	wc.opcode = IB_WC_RECV;
-	while (qp->r_rq.tail != qp->r_rq.head) {
-		wc.wr_id = get_rwqe_ptr(&qp->r_rq, qp->r_rq.tail)->wr_id;
-		if (++qp->r_rq.tail >= qp->r_rq.size)
-			qp->r_rq.tail = 0;
-		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc, 1);
-	}
-}
-
-/**
  * ipath_get_credit - flush the send work queue of a QP
  * @qp: the qp who's send work queue to flush
  * @aeth: the Acknowledge Extended Transport Header
diff --git a/drivers/infiniband/hw/ipath/ipath_ud.c b/drivers/infiniband/hw/ipath/ipath_ud.c
index 5ff3de6..01cfb30 100644
--- a/drivers/infiniband/hw/ipath/ipath_ud.c
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c
@@ -46,8 +46,8 @@
  * This is called from ipath_post_ud_send() to forward a WQE addressed
  * to the same HCA.
  */
-void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
-		       u32 length, struct ib_send_wr *wr, struct ib_wc *wc)
+static void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
+			      u32 length, struct ib_send_wr *wr, struct ib_wc *wc)
 {
 	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
 	struct ipath_qp *qp;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index 9f27fd3..8d2558a 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -41,7 +41,7 @@
 /* Not static, because we don't want the compiler removing it */
 const char ipath_verbs_version[] = "ipath_verbs " IPATH_IDSTR;
 
-unsigned int ib_ipath_qp_table_size = 251;
+static unsigned int ib_ipath_qp_table_size = 251;
 module_param_named(qp_table_size, ib_ipath_qp_table_size, uint, S_IRUGO);
 MODULE_PARM_DESC(qp_table_size, "QP table size");
 
@@ -87,7 +87,7 @@ const enum ib_wc_opcode ib_ipath_wc_opco
 /*
  * System image GUID.
  */
-__be64 sys_image_guid;
+static __be64 sys_image_guid;
 
 /**
  * ipath_copy_sge - copy data to SGE memory
@@ -1110,7 +1110,7 @@ static void ipath_unregister_ib_device(v
 	ib_dealloc_device(ibdev);
 }
 
-int __init ipath_verbs_init(void)
+static int __init ipath_verbs_init(void)
 {
 	return ipath_verbs_register(ipath_register_ib_device,
 				    ipath_unregister_ib_device,
@@ -1118,33 +1118,33 @@ int __init ipath_verbs_init(void)
 				    ipath_ib_timer);
 }
 
-void __exit ipath_verbs_cleanup(void)
+static void __exit ipath_verbs_cleanup(void)
 {
 	ipath_verbs_unregister();
 }
 
 static ssize_t show_rev(struct class_device *cdev, char *buf)
 {
-        struct ipath_ibdev *dev =
-                container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
-        int vendor, boardrev, majrev, minrev;
-
-        ipath_layer_query_device(dev->dd, &vendor, &boardrev,
-                                 &majrev, &minrev);
-        return sprintf(buf, "%d.%d\n", majrev, minrev);
+	struct ipath_ibdev *dev =
+		container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	int vendor, boardrev, majrev, minrev;
+
+	ipath_layer_query_device(dev->dd, &vendor, &boardrev,
+				 &majrev, &minrev);
+	return sprintf(buf, "%d.%d\n", majrev, minrev);
 }
 
 static ssize_t show_hca(struct class_device *cdev, char *buf)
 {
-        struct ipath_ibdev *dev =
-                container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
-        int ret;
-
-        ret = ipath_layer_get_boardname(dev->dd, buf, 128);
-        if (ret < 0)
-                goto bail;
-        strcat(buf, "\n");
-        ret = strlen(buf);
+	struct ipath_ibdev *dev =
+		container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	int ret;
+
+	ret = ipath_layer_get_boardname(dev->dd, buf, 128);
+	if (ret < 0)
+		goto bail;
+	strcat(buf, "\n");
+	ret = strlen(buf);
 
 bail:
 	return ret;
@@ -1152,40 +1152,40 @@ bail:
 
 static ssize_t show_stats(struct class_device *cdev, char *buf)
 {
-        struct ipath_ibdev *dev =
-                container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
-        int i;
-        int len;
-
-        len = sprintf(buf,
-                      "RC resends  %d\n"
-                      "RC QACKs    %d\n"
-                      "RC ACKs     %d\n"
-                      "RC SEQ NAKs %d\n"
-                      "RC RDMA seq %d\n"
-                      "RC RNR NAKs %d\n"
-                      "RC OTH NAKs %d\n"
-                      "RC timeouts %d\n"
-                      "RC RDMA dup %d\n"
-                      "piobuf wait %d\n"
-                      "no piobuf   %d\n"
-                      "PKT drops   %d\n"
-                      "WQE errs    %d\n",
-                      dev->n_rc_resends, dev->n_rc_qacks, dev->n_rc_acks,
-                      dev->n_seq_naks, dev->n_rdma_seq, dev->n_rnr_naks,
-                      dev->n_other_naks, dev->n_timeouts,
-                      dev->n_rdma_dup_busy, dev->n_piowait,
-                      dev->n_no_piobuf, dev->n_pkt_drops, dev->n_wqe_errs);
-        for (i = 0; i < ARRAY_SIZE(dev->opstats); i++) {
+	struct ipath_ibdev *dev =
+		container_of(cdev, struct ipath_ibdev, ibdev.class_dev);
+	int i;
+	int len;
+
+	len = sprintf(buf,
+		      "RC resends  %d\n"
+		      "RC QACKs    %d\n"
+		      "RC ACKs     %d\n"
+		      "RC SEQ NAKs %d\n"
+		      "RC RDMA seq %d\n"
+		      "RC RNR NAKs %d\n"
+		      "RC OTH NAKs %d\n"
+		      "RC timeouts %d\n"
+		      "RC RDMA dup %d\n"
+		      "piobuf wait %d\n"
+		      "no piobuf   %d\n"
+		      "PKT drops   %d\n"
+		      "WQE errs    %d\n",
+		      dev->n_rc_resends, dev->n_rc_qacks, dev->n_rc_acks,
+		      dev->n_seq_naks, dev->n_rdma_seq, dev->n_rnr_naks,
+		      dev->n_other_naks, dev->n_timeouts,
+		      dev->n_rdma_dup_busy, dev->n_piowait,
+		      dev->n_no_piobuf, dev->n_pkt_drops, dev->n_wqe_errs);
+	for (i = 0; i < ARRAY_SIZE(dev->opstats); i++) {
 		const struct ipath_opcode_stats *si = &dev->opstats[i];
 
-                if (!si->n_packets && !si->n_bytes)
-                        continue;
-                len += sprintf(buf + len, "%02x %llu/%llu\n", i,
+		if (!si->n_packets && !si->n_bytes)
+			continue;
+		len += sprintf(buf + len, "%02x %llu/%llu\n", i,
 			       (unsigned long long) si->n_packets,
-                               (unsigned long long) si->n_bytes);
-        }
-        return len;
+			       (unsigned long long) si->n_bytes);
+	}
+	return len;
 }
 
 static CLASS_DEVICE_ATTR(hw_rev, S_IRUGO, show_rev, NULL);
@@ -1194,25 +1194,25 @@ static CLASS_DEVICE_ATTR(board_id, S_IRU
 static CLASS_DEVICE_ATTR(stats, S_IRUGO, show_stats, NULL);
 
 static struct class_device_attribute *ipath_class_attributes[] = {
-        &class_device_attr_hw_rev,
-        &class_device_attr_hca_type,
-        &class_device_attr_board_id,
-        &class_device_attr_stats
+	&class_device_attr_hw_rev,
+	&class_device_attr_hca_type,
+	&class_device_attr_board_id,
+	&class_device_attr_stats
 };
 
 static int ipath_verbs_register_sysfs(struct ib_device *dev)
 {
-        int i;
+	int i;
 	int ret;
 
-        for (i = 0; i < ARRAY_SIZE(ipath_class_attributes); ++i)
-                if (class_device_create_file(&dev->class_dev,
-                                             ipath_class_attributes[i])) {
-                        ret = 1;
+	for (i = 0; i < ARRAY_SIZE(ipath_class_attributes); ++i)
+		if (class_device_create_file(&dev->class_dev,
+					     ipath_class_attributes[i])) {
+			ret = 1;
 			goto bail;
 		}
 
-        ret = 0;
+	ret = 0;
 
 bail:
 	return ret;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
index b824632..fcafbc7 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h
@@ -577,8 +577,6 @@ int ipath_init_qp_table(struct ipath_ibd
 
 void ipath_sqerror_qp(struct ipath_qp *qp, struct ib_wc *wc);
 
-void ipath_error_qp(struct ipath_qp *qp);
-
 void ipath_get_credit(struct ipath_qp *qp, u32 aeth);
 
 void ipath_do_rc_send(unsigned long data);
@@ -607,9 +605,6 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 
 void ipath_restart_rc(struct ipath_qp *qp, u32 psn, struct ib_wc *wc);
 
-void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
-		       u32 length, struct ib_send_wr *wr, struct ib_wc *wc);
-
 int ipath_post_ud_send(struct ipath_qp *qp, struct ib_send_wr *wr);
 
 void ipath_ud_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
index f235c7e..4730863 100644
--- a/drivers/infiniband/hw/mthca/mthca_mad.c
+++ b/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -49,7 +49,7 @@ enum {
 	MTHCA_VENDOR_CLASS2 = 0xa
 };
 
-int mthca_update_rate(struct mthca_dev *dev, u8 port_num)
+static int mthca_update_rate(struct mthca_dev *dev, u8 port_num)
 {
 	struct ib_port_attr *tprops = NULL;
 	int                  ret;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 5f2b3f6..5bb5574 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -617,6 +617,14 @@ static void srp_unmap_data(struct scsi_c
 		     scmnd->sc_data_direction);
 }
 
+static void srp_remove_req(struct srp_target_port *target, struct srp_request *req,
+			   int index)
+{
+	list_del(&req->list);
+	req->next = target->req_head;
+	target->req_head = index;
+}
+
 static void srp_process_rsp(struct srp_target_port *target, struct srp_rsp *rsp)
 {
 	struct srp_request *req;
@@ -664,9 +672,7 @@ static void srp_process_rsp(struct srp_t
 			scmnd->host_scribble = (void *) -1L;
 			scmnd->scsi_done(scmnd);
 
-			list_del(&req->list);
-			req->next = target->req_head;
-			target->req_head = rsp->tag & ~SRP_TAG_TSK_MGMT;
+			srp_remove_req(target, req, rsp->tag & ~SRP_TAG_TSK_MGMT);
 		} else
 			req->cmd_done = 1;
 	}
@@ -1188,12 +1194,10 @@ static int srp_send_tsk_mgmt(struct scsi
 	spin_lock_irq(target->scsi_host->host_lock);
 
 	if (req->cmd_done) {
-		list_del(&req->list);
-		req->next = target->req_head;
-		target->req_head = req_index;
-
+		srp_remove_req(target, req, req_index);
 		scmnd->scsi_done(scmnd);
 	} else if (!req->tsk_status) {
+		srp_remove_req(target, req, req_index);
 		scmnd->result = DID_ABORT << 16;
 		ret = SUCCESS;
 	}
