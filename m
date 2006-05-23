Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWEWVFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWEWVFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWEWVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:05:20 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:19125 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932206AbWEWVFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:05:18 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="428527340:sNHT38051908"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 23 May 2006 14:05:14 -0700
Message-ID: <ada1wuksb91.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 May 2006 21:05:15.0020 (UTC) FILETIME=[967284C0:01C67EAC]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This contains fixes for the new ipath driver.  The changes are a
little bit bigger than I would prefer at this stage in the release
cycle, but since the ipath driver is new in 2.6.17, there's no risk of
regressions against 2.6.16 ;)

Bryan O'Sullivan:
      IB/ipath: fix spinlock recursion bug
      IB/ipath: don't modify QP if changes fail
      IB/ipath: fix reporting of driver version to userspace
      IB/ipath: replace uses of LIST_POISON
      IB/ipath: fix NULL dereference during cleanup
      IB/ipath: enable GPIO interrupt on HT-460
      IB/ipath: enable PE800 receive interrupts on user ports
      IB/ipath: register as IB device owner
      IB/ipath: fix null deref during rdma ops
      IB/ipath: deref correct pointer when using kernel SMA

 drivers/infiniband/hw/ipath/ipath_driver.c    |   22 ++++-----
 drivers/infiniband/hw/ipath/ipath_eeprom.c    |    7 +--
 drivers/infiniband/hw/ipath/ipath_file_ops.c  |    6 ++
 drivers/infiniband/hw/ipath/ipath_ht400.c     |   21 +++++++-
 drivers/infiniband/hw/ipath/ipath_init_chip.c |    1 
 drivers/infiniband/hw/ipath/ipath_kernel.h    |    2 -
 drivers/infiniband/hw/ipath/ipath_keys.c      |    6 --
 drivers/infiniband/hw/ipath/ipath_layer.c     |   12 +++--
 drivers/infiniband/hw/ipath/ipath_pe800.c     |    2 +
 drivers/infiniband/hw/ipath/ipath_qp.c        |   64 +++++++++++++------------
 drivers/infiniband/hw/ipath/ipath_rc.c        |   15 +++---
 drivers/infiniband/hw/ipath/ipath_ruc.c       |    2 -
 drivers/infiniband/hw/ipath/ipath_verbs.c     |    7 ++-
 13 files changed, 92 insertions(+), 75 deletions(-)


diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index 3697eda..dddcdae 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -1905,19 +1905,19 @@ static void __exit infinipath_cleanup(vo
 			} else
 				ipath_dbg("irq is 0, not doing free_irq "
 					  "for unit %u\n", dd->ipath_unit);
-			dd->pcidev = NULL;
-		}
 
-		/*
-		 * we check for NULL here, because it's outside the kregbase
-		 * check, and we need to call it after the free_irq.  Thus
-		 * it's possible that the function pointers were never
-		 * initialized.
-		 */
-		if (dd->ipath_f_cleanup)
-			/* clean up chip-specific stuff */
-			dd->ipath_f_cleanup(dd);
+			/*
+			 * we check for NULL here, because it's outside
+			 * the kregbase check, and we need to call it
+			 * after the free_irq.  Thus it's possible that
+			 * the function pointers were never initialized.
+			 */
+			if (dd->ipath_f_cleanup)
+				/* clean up chip-specific stuff */
+				dd->ipath_f_cleanup(dd);
 
+			dd->pcidev = NULL;
+		}
 		spin_lock_irqsave(&ipath_devs_lock, flags);
 	}
 
diff --git a/drivers/infiniband/hw/ipath/ipath_eeprom.c b/drivers/infiniband/hw/ipath/ipath_eeprom.c
index f11a900..a2f1cea 100644
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c
@@ -505,11 +505,10 @@ static u8 flash_csum(struct ipath_flash 
  * ipath_get_guid - get the GUID from the i2c device
  * @dd: the infinipath device
  *
- * When we add the multi-chip support, we will probably have to add
- * the ability to use the number of guids field, and get the guid from
- * the first chip's flash, to use for all of them.
+ * We have the capability to use the ipath_nguid field, and get
+ * the guid from the first chip's flash, to use for all of them.
  */
-void ipath_get_guid(struct ipath_devdata *dd)
+void ipath_get_eeprom_info(struct ipath_devdata *dd)
 {
 	void *buf;
 	struct ipath_flash *ifp;
diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
index c347191..ada267e 100644
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c
@@ -139,7 +139,7 @@ static int ipath_get_base_info(struct ip
 	kinfo->spi_piosize = dd->ipath_ibmaxlen;
 	kinfo->spi_mtu = dd->ipath_ibmaxlen;	/* maxlen, not ibmtu */
 	kinfo->spi_port = pd->port_port;
-	kinfo->spi_sw_version = IPATH_USER_SWVERSION;
+	kinfo->spi_sw_version = IPATH_KERN_SWVERSION;
 	kinfo->spi_hw_version = dd->ipath_revision;
 
 	if (copy_to_user(ubase, kinfo, sizeof(*kinfo)))
@@ -1224,6 +1224,10 @@ static unsigned int ipath_poll(struct fi
 
 	if (tail == head) {
 		set_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag);
+		if(dd->ipath_rhdrhead_intr_off) /* arm rcv interrupt */
+			(void)ipath_write_ureg(dd, ur_rcvhdrhead,
+					       dd->ipath_rhdrhead_intr_off
+					       | head, pd->port_port);
 		poll_wait(fp, &pd->port_wait, pt);
 
 		if (test_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag)) {
diff --git a/drivers/infiniband/hw/ipath/ipath_ht400.c b/drivers/infiniband/hw/ipath/ipath_ht400.c
index 4652435..fac0a2b 100644
--- a/drivers/infiniband/hw/ipath/ipath_ht400.c
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c
@@ -607,7 +607,12 @@ static int ipath_ht_boardname(struct ipa
 	case 4:		/* Ponderosa is one of the bringup boards */
 		n = "Ponderosa";
 		break;
-	case 5:		/* HT-460 original production board */
+	case 5:
+		/*
+		 * HT-460 original production board; two production levels, with
+		 * different serial number ranges.   See ipath_ht_early_init() for
+		 * case where we enable IPATH_GPIO_INTR for later serial # range.
+		 */
 		n = "InfiniPath_HT-460";
 		break;
 	case 6:
@@ -642,7 +647,7 @@ static int ipath_ht_boardname(struct ipa
 	if (n)
 		snprintf(name, namelen, "%s", n);
 
-	if (dd->ipath_majrev != 3 || dd->ipath_minrev != 2) {
+	if (dd->ipath_majrev != 3 || (dd->ipath_minrev < 2 || dd->ipath_minrev > 3)) {
 		/*
 		 * This version of the driver only supports the HT-400
 		 * Rev 3.2
@@ -1520,6 +1525,18 @@ static int ipath_ht_early_init(struct ip
 	 */
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
 			 INFINIPATH_S_ABORT);
+
+	ipath_get_eeprom_info(dd);
+	if(dd->ipath_boardrev == 5 && dd->ipath_serial[0] == '1' &&
+		dd->ipath_serial[1] == '2' && dd->ipath_serial[2] == '8') {
+		/*
+		 * Later production HT-460 has same changes as HT-465, so
+		 * can use GPIO interrupts.  They have serial #'s starting
+		 * with 128, rather than 112.
+		 */
+		dd->ipath_flags |= IPATH_GPIO_INTR;
+		dd->ipath_flags &= ~IPATH_POLL_RX_INTR;
+	}
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/ipath/ipath_init_chip.c b/drivers/infiniband/hw/ipath/ipath_init_chip.c
index 16f640e..dc83250 100644
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c
@@ -879,7 +879,6 @@ int ipath_init_chip(struct ipath_devdata
 
 done:
 	if (!ret) {
-		ipath_get_guid(dd);
 		*dd->ipath_statusp |= IPATH_STATUS_CHIP_PRESENT;
 		if (!dd->ipath_f_intrsetup(dd)) {
 			/* now we can enable all interrupts from the chip */
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
index e6507f8..5d92d57 100644
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h
@@ -650,7 +650,7 @@ u32 __iomem *ipath_getpiobuf(struct ipat
 void ipath_init_pe800_funcs(struct ipath_devdata *);
 /* init HT-400-specific func */
 void ipath_init_ht400_funcs(struct ipath_devdata *);
-void ipath_get_guid(struct ipath_devdata *);
+void ipath_get_eeprom_info(struct ipath_devdata *);
 u64 ipath_snap_cntr(struct ipath_devdata *, ipath_creg);
 
 /*
diff --git a/drivers/infiniband/hw/ipath/ipath_keys.c b/drivers/infiniband/hw/ipath/ipath_keys.c
index aa33b0e..5ae8761 100644
--- a/drivers/infiniband/hw/ipath/ipath_keys.c
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c
@@ -136,9 +136,7 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 		ret = 1;
 		goto bail;
 	}
-	spin_lock(&rkt->lock);
 	mr = rkt->table[(sge->lkey >> (32 - ib_ipath_lkey_table_size))];
-	spin_unlock(&rkt->lock);
 	if (unlikely(mr == NULL || mr->lkey != sge->lkey)) {
 		ret = 0;
 		goto bail;
@@ -184,8 +182,6 @@ bail:
  * @acc: access flags
  *
  * Return 1 if successful, otherwise 0.
- *
- * The QP r_rq.lock should be held.
  */
 int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
 		  u32 len, u64 vaddr, u32 rkey, int acc)
@@ -196,9 +192,7 @@ int ipath_rkey_ok(struct ipath_ibdev *de
 	size_t off;
 	int ret;
 
-	spin_lock(&rkt->lock);
 	mr = rkt->table[(rkey >> (32 - ib_ipath_lkey_table_size))];
-	spin_unlock(&rkt->lock);
 	if (unlikely(mr == NULL || mr->lkey != rkey)) {
 		ret = 0;
 		goto bail;
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
index 9cb5258..9ec4ac7 100644
--- a/drivers/infiniband/hw/ipath/ipath_layer.c
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c
@@ -872,12 +872,13 @@ static void copy_io(u32 __iomem *piobuf,
 		update_sge(ss, len);
 		length -= len;
 	}
+	/* Update address before sending packet. */
+	update_sge(ss, length);
 	/* must flush early everything before trigger word */
 	ipath_flush_wc();
 	__raw_writel(last, piobuf);
 	/* be sure trigger word is written */
 	ipath_flush_wc();
-	update_sge(ss, length);
 }
 
 /**
@@ -943,17 +944,18 @@ int ipath_verbs_send(struct ipath_devdat
 	if (likely(ss->num_sge == 1 && len <= ss->sge.length &&
 		   !((unsigned long)ss->sge.vaddr & (sizeof(u32) - 1)))) {
 		u32 w;
+		u32 *addr = (u32 *) ss->sge.vaddr;
 
+		/* Update address before sending packet. */
+		update_sge(ss, len);
 		/* Need to round up for the last dword in the packet. */
 		w = (len + 3) >> 2;
-		__iowrite32_copy(piobuf, ss->sge.vaddr, w - 1);
+		__iowrite32_copy(piobuf, addr, w - 1);
 		/* must flush early everything before trigger word */
 		ipath_flush_wc();
-		__raw_writel(((u32 *) ss->sge.vaddr)[w - 1],
-			     piobuf + w - 1);
+		__raw_writel(addr[w - 1], piobuf + w - 1);
 		/* be sure trigger word is written */
 		ipath_flush_wc();
-		update_sge(ss, len);
 		ret = 0;
 		goto bail;
 	}
diff --git a/drivers/infiniband/hw/ipath/ipath_pe800.c b/drivers/infiniband/hw/ipath/ipath_pe800.c
index 6318067..02e8c75 100644
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c
@@ -1180,6 +1180,8 @@ static int ipath_pe_early_init(struct ip
 	 */
 	dd->ipath_rhdrhead_intr_off = 1ULL<<32;
 
+	ipath_get_eeprom_info(dd);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
index 1889071..9f8855d 100644
--- a/drivers/infiniband/hw/ipath/ipath_qp.c
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c
@@ -375,10 +375,10 @@ static void ipath_error_qp(struct ipath_
 
 	spin_lock(&dev->pending_lock);
 	/* XXX What if its already removed by the timeout code? */
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
+	if (!list_empty(&qp->piowait))
+		list_del_init(&qp->piowait);
 	spin_unlock(&dev->pending_lock);
 
 	wc.status = IB_WC_WR_FLUSH_ERR;
@@ -427,6 +427,7 @@ static void ipath_error_qp(struct ipath_
 int ipath_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		    int attr_mask)
 {
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
 	struct ipath_qp *qp = to_iqp(ibqp);
 	enum ib_qp_state cur_state, new_state;
 	unsigned long flags;
@@ -443,6 +444,19 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 				attr_mask))
 		goto inval;
 
+	if (attr_mask & IB_QP_AV)
+		if (attr->ah_attr.dlid == 0 ||
+		    attr->ah_attr.dlid >= IPS_MULTICAST_LID_BASE)
+			goto inval;
+
+	if (attr_mask & IB_QP_PKEY_INDEX)
+		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->dd))
+			goto inval;
+
+	if (attr_mask & IB_QP_MIN_RNR_TIMER)
+		if (attr->min_rnr_timer > 31)
+			goto inval;
+
 	switch (new_state) {
 	case IB_QPS_RESET:
 		ipath_reset_qp(qp);
@@ -457,13 +471,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 
 	}
 
-	if (attr_mask & IB_QP_PKEY_INDEX) {
-		struct ipath_ibdev *dev = to_idev(ibqp->device);
-
-		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->dd))
-			goto inval;
+	if (attr_mask & IB_QP_PKEY_INDEX)
 		qp->s_pkey_index = attr->pkey_index;
-	}
 
 	if (attr_mask & IB_QP_DEST_QPN)
 		qp->remote_qpn = attr->dest_qp_num;
@@ -479,12 +488,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 	if (attr_mask & IB_QP_ACCESS_FLAGS)
 		qp->qp_access_flags = attr->qp_access_flags;
 
-	if (attr_mask & IB_QP_AV) {
-		if (attr->ah_attr.dlid == 0 ||
-		    attr->ah_attr.dlid >= IPS_MULTICAST_LID_BASE)
-			goto inval;
+	if (attr_mask & IB_QP_AV)
 		qp->remote_ah_attr = attr->ah_attr;
-	}
 
 	if (attr_mask & IB_QP_PATH_MTU)
 		qp->path_mtu = attr->path_mtu;
@@ -499,11 +504,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 		qp->s_rnr_retry_cnt = qp->s_rnr_retry;
 	}
 
-	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
-		if (attr->min_rnr_timer > 31)
-			goto inval;
+	if (attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp->s_min_rnr_timer = attr->min_rnr_timer;
-	}
 
 	if (attr_mask & IB_QP_QKEY)
 		qp->qkey = attr->qkey;
@@ -710,10 +712,8 @@ struct ib_qp *ipath_create_qp(struct ib_
 			     init_attr->qp_type == IB_QPT_RC ?
 			     ipath_do_rc_send : ipath_do_uc_send,
 			     (unsigned long)qp);
-		qp->piowait.next = LIST_POISON1;
-		qp->piowait.prev = LIST_POISON2;
-		qp->timerwait.next = LIST_POISON1;
-		qp->timerwait.prev = LIST_POISON2;
+		INIT_LIST_HEAD(&qp->piowait);
+		INIT_LIST_HEAD(&qp->timerwait);
 		qp->state = IB_QPS_RESET;
 		qp->s_wq = swq;
 		qp->s_size = init_attr->cap.max_send_wr + 1;
@@ -734,7 +734,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 		ipath_reset_qp(qp);
 
 		/* Tell the core driver that the kernel SMA is present. */
-		if (qp->ibqp.qp_type == IB_QPT_SMI)
+		if (init_attr->qp_type == IB_QPT_SMI)
 			ipath_layer_set_verbs_flags(dev->dd,
 						    IPATH_VERBS_KERNEL_SMA);
 		break;
@@ -783,10 +783,10 @@ int ipath_destroy_qp(struct ib_qp *ibqp)
 
 	/* Make sure the QP isn't on the timeout list. */
 	spin_lock_irqsave(&dev->pending_lock, flags);
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
+	if (!list_empty(&qp->piowait))
+		list_del_init(&qp->piowait);
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 
 	/*
@@ -855,10 +855,10 @@ void ipath_sqerror_qp(struct ipath_qp *q
 
 	spin_lock(&dev->pending_lock);
 	/* XXX What if its already removed by the timeout code? */
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
-	if (qp->piowait.next != LIST_POISON1)
-		list_del(&qp->piowait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
+	if (!list_empty(&qp->piowait))
+		list_del_init(&qp->piowait);
 	spin_unlock(&dev->pending_lock);
 
 	ipath_cq_enter(to_icq(qp->ibqp.send_cq), wc, 1);
diff --git a/drivers/infiniband/hw/ipath/ipath_rc.c b/drivers/infiniband/hw/ipath/ipath_rc.c
index a4055ca..493b182 100644
--- a/drivers/infiniband/hw/ipath/ipath_rc.c
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c
@@ -57,7 +57,7 @@ static void ipath_init_restart(struct ip
 	qp->s_len = wqe->length - len;
 	dev = to_idev(qp->ibqp.device);
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next == LIST_POISON1)
+	if (list_empty(&qp->timerwait))
 		list_add_tail(&qp->timerwait,
 			      &dev->pending[dev->pending_index]);
 	spin_unlock(&dev->pending_lock);
@@ -356,7 +356,7 @@ static inline int ipath_make_rc_req(stru
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
 		spin_lock(&dev->pending_lock);
-		if (qp->timerwait.next == LIST_POISON1)
+		if (list_empty(&qp->timerwait))
 			list_add_tail(&qp->timerwait,
 				      &dev->pending[dev->pending_index]);
 		spin_unlock(&dev->pending_lock);
@@ -726,8 +726,8 @@ void ipath_restart_rc(struct ipath_qp *q
 	 */
 	dev = to_idev(qp->ibqp.device);
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
 	spin_unlock(&dev->pending_lock);
 
 	if (wqe->wr.opcode == IB_WR_RDMA_READ)
@@ -886,8 +886,8 @@ static int do_rc_ack(struct ipath_qp *qp
 	 * just won't find anything to restart if we ACK everything.
 	 */
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next != LIST_POISON1)
-		list_del(&qp->timerwait);
+	if (!list_empty(&qp->timerwait))
+		list_del_init(&qp->timerwait);
 	spin_unlock(&dev->pending_lock);
 
 	/*
@@ -1194,8 +1194,7 @@ static inline void ipath_rc_rcv_resp(str
 		     IB_WR_RDMA_READ))
 		goto ack_done;
 	spin_lock(&dev->pending_lock);
-	if (qp->s_rnr_timeout == 0 &&
-	    qp->timerwait.next != LIST_POISON1)
+	if (qp->s_rnr_timeout == 0 && !list_empty(&qp->timerwait))
 		list_move_tail(&qp->timerwait,
 			       &dev->pending[dev->pending_index]);
 	spin_unlock(&dev->pending_lock);
diff --git a/drivers/infiniband/hw/ipath/ipath_ruc.c b/drivers/infiniband/hw/ipath/ipath_ruc.c
index eb81424..d38f4f3 100644
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c
@@ -435,7 +435,7 @@ void ipath_no_bufs_available(struct ipat
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->pending_lock, flags);
-	if (qp->piowait.next == LIST_POISON1)
+	if (list_empty(&qp->piowait))
 		list_add_tail(&qp->piowait, &dev->piowait);
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 	/*
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index cb9e387..28fdbda 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -464,7 +464,7 @@ static void ipath_ib_timer(void *arg)
 	last = &dev->pending[dev->pending_index];
 	while (!list_empty(last)) {
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
-		list_del(&qp->timerwait);
+		list_del_init(&qp->timerwait);
 		qp->timer_next = resend;
 		resend = qp;
 		atomic_inc(&qp->refcount);
@@ -474,7 +474,7 @@ static void ipath_ib_timer(void *arg)
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
 		if (--qp->s_rnr_timeout == 0) {
 			do {
-				list_del(&qp->timerwait);
+				list_del_init(&qp->timerwait);
 				tasklet_hi_schedule(&qp->s_task);
 				if (list_empty(last))
 					break;
@@ -554,7 +554,7 @@ static int ipath_ib_piobufavail(void *ar
 	while (!list_empty(&dev->piowait)) {
 		qp = list_entry(dev->piowait.next, struct ipath_qp,
 				piowait);
-		list_del(&qp->piowait);
+		list_del_init(&qp->piowait);
 		tasklet_hi_schedule(&qp->s_task);
 	}
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
@@ -951,6 +951,7 @@ static void *ipath_register_ib_device(in
 	idev->dd = dd;
 
 	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
+	dev->owner = THIS_MODULE;
 	dev->node_guid = ipath_layer_get_guid(dd);
 	dev->uverbs_abi_ver = IPATH_UVERBS_ABI_VERSION;
 	dev->uverbs_cmd_mask =
