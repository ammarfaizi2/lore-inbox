Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWGXQu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWGXQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWGXQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:50:29 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:21121 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S932224AbWGXQu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:50:27 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 24 Jul 2006 09:50:23 -0700
Message-ID: <ada64hnj6b4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Jul 2006 16:50:25.0396 (UTC) FILETIME=[42BB8B40:01C6AF41]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

to get a few fixes:

Dotan Barak:
      IB/mthca: Fix SRQ limit event range check

Michael S. Tsirkin:
      IB/uverbs: Fix unlocking in error paths
      IB/ipoib: Fix packet loss after hardware address update

Or Gerlitz:
      IB/ipoib: Fix oops with ipoib_debug_mcast set

Ralph Campbell:
      IB/ipath: Fix a data corruption
      IB/ipath: Fix ib_ipath driver to work with SRP
      IB/ipath: ipath_skip_sge() can break if num_sge > 1

Roland Dreier:
      IB/uverbs: Fix lockdep warnings
      IB/mthca: Initialize max_cmds before debug code prints it

Sean Hefty:
      IB/mad: Validate MADs for spec compliance

 drivers/infiniband/core/mad.c                  |   22 +++---
 drivers/infiniband/core/user_mad.c             |   87 +++++++++++++++++++++---
 drivers/infiniband/core/uverbs_cmd.c           |   42 ++++++++----
 drivers/infiniband/hw/ipath/ipath_driver.c     |   76 ++++++++++-----------
 drivers/infiniband/hw/ipath/ipath_keys.c       |   15 ++++
 drivers/infiniband/hw/ipath/ipath_verbs.c      |    5 -
 drivers/infiniband/hw/mthca/mthca_cmd.c        |    5 +
 drivers/infiniband/hw/mthca/mthca_srq.c        |    3 +
 drivers/infiniband/ulp/ipoib/ipoib.h           |    1 
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   23 ++++++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    8 +-
 include/rdma/ib_mad.h                          |    7 ++
 12 files changed, 209 insertions(+), 85 deletions(-)


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 5ed4dab..1c3cfbb 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -167,6 +167,15 @@ static int is_vendor_method_in_use(
 	return 0;
 }
 
+int ib_response_mad(struct ib_mad *mad)
+{
+	return ((mad->mad_hdr.method & IB_MGMT_METHOD_RESP) ||
+		(mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS) ||
+		((mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_BM) &&
+		 (mad->mad_hdr.attr_mod & IB_BM_ATTR_MOD_RESP)));
+}
+EXPORT_SYMBOL(ib_response_mad);
+
 /*
  * ib_register_mad_agent - Register to send/receive MADs
  */
@@ -570,13 +579,6 @@ int ib_unregister_mad_agent(struct ib_ma
 }
 EXPORT_SYMBOL(ib_unregister_mad_agent);
 
-static inline int response_mad(struct ib_mad *mad)
-{
-	/* Trap represses are responses although response bit is reset */
-	return ((mad->mad_hdr.method == IB_MGMT_METHOD_TRAP_REPRESS) ||
-		(mad->mad_hdr.method & IB_MGMT_METHOD_RESP));
-}
-
 static void dequeue_mad(struct ib_mad_list_head *mad_list)
 {
 	struct ib_mad_queue *mad_queue;
@@ -723,7 +725,7 @@ static int handle_outgoing_dr_smp(struct
 	switch (ret)
 	{
 	case IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY:
-		if (response_mad(&mad_priv->mad.mad) &&
+		if (ib_response_mad(&mad_priv->mad.mad) &&
 		    mad_agent_priv->agent.recv_handler) {
 			local->mad_priv = mad_priv;
 			local->recv_mad_agent = mad_agent_priv;
@@ -1551,7 +1553,7 @@ find_mad_agent(struct ib_mad_port_privat
 	unsigned long flags;
 
 	spin_lock_irqsave(&port_priv->reg_lock, flags);
-	if (response_mad(mad)) {
+	if (ib_response_mad(mad)) {
 		u32 hi_tid;
 		struct ib_mad_agent_private *entry;
 
@@ -1799,7 +1801,7 @@ static void ib_mad_complete_recv(struct 
 	}
 
 	/* Complete corresponding request */
-	if (response_mad(mad_recv_wc->recv_buf.mad)) {
+	if (ib_response_mad(mad_recv_wc->recv_buf.mad)) {
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
 		mad_send_wr = ib_find_send_mad(mad_agent_priv, mad_recv_wc);
 		if (!mad_send_wr) {
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index afe70a5..1273f88 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -112,8 +112,10 @@ struct ib_umad_device {
 struct ib_umad_file {
 	struct ib_umad_port    *port;
 	struct list_head	recv_list;
+	struct list_head	send_list;
 	struct list_head	port_list;
 	spinlock_t		recv_lock;
+	spinlock_t		send_lock;
 	wait_queue_head_t	recv_wait;
 	struct ib_mad_agent    *agent[IB_UMAD_MAX_AGENTS];
 	int			agents_dead;
@@ -177,12 +179,21 @@ static int queue_packet(struct ib_umad_f
 	return ret;
 }
 
+static void dequeue_send(struct ib_umad_file *file,
+			 struct ib_umad_packet *packet)
+ {
+	spin_lock_irq(&file->send_lock);
+	list_del(&packet->list);
+	spin_unlock_irq(&file->send_lock);
+ }
+
 static void send_handler(struct ib_mad_agent *agent,
 			 struct ib_mad_send_wc *send_wc)
 {
 	struct ib_umad_file *file = agent->context;
 	struct ib_umad_packet *packet = send_wc->send_buf->context[0];
 
+	dequeue_send(file, packet);
 	ib_destroy_ah(packet->msg->ah);
 	ib_free_send_mad(packet->msg);
 
@@ -370,6 +381,51 @@ static int copy_rmpp_mad(struct ib_mad_s
 	return 0;
 }
 
+static int same_destination(struct ib_user_mad_hdr *hdr1,
+			    struct ib_user_mad_hdr *hdr2)
+{
+	if (!hdr1->grh_present && !hdr2->grh_present)
+	   return (hdr1->lid == hdr2->lid);
+
+	if (hdr1->grh_present && hdr2->grh_present)
+	   return !memcmp(hdr1->gid, hdr2->gid, 16);
+
+	return 0;
+}
+
+static int is_duplicate(struct ib_umad_file *file,
+			struct ib_umad_packet *packet)
+{
+	struct ib_umad_packet *sent_packet;
+	struct ib_mad_hdr *sent_hdr, *hdr;
+
+	hdr = (struct ib_mad_hdr *) packet->mad.data;
+	list_for_each_entry(sent_packet, &file->send_list, list) {
+		sent_hdr = (struct ib_mad_hdr *) sent_packet->mad.data;
+
+		if ((hdr->tid != sent_hdr->tid) ||
+		    (hdr->mgmt_class != sent_hdr->mgmt_class))
+			continue;
+
+		/*
+		 * No need to be overly clever here.  If two new operations have
+		 * the same TID, reject the second as a duplicate.  This is more
+		 * restrictive than required by the spec.
+		 */
+		if (!ib_response_mad((struct ib_mad *) hdr)) {
+			if (!ib_response_mad((struct ib_mad *) sent_hdr))
+				return 1;
+			continue;
+		} else if (!ib_response_mad((struct ib_mad *) sent_hdr))
+			continue;
+
+		if (same_destination(&packet->mad.hdr, &sent_packet->mad.hdr))
+			return 1;
+	}
+
+	return 0;
+}
+
 static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
@@ -379,7 +435,6 @@ static ssize_t ib_umad_write(struct file
 	struct ib_ah_attr ah_attr;
 	struct ib_ah *ah;
 	struct ib_rmpp_mad *rmpp_mad;
-	u8 method;
 	__be64 *tid;
 	int ret, data_len, hdr_len, copy_offset, rmpp_active;
 
@@ -473,28 +528,36 @@ static ssize_t ib_umad_write(struct file
 	}
 
 	/*
-	 * If userspace is generating a request that will generate a
-	 * response, we need to make sure the high-order part of the
-	 * transaction ID matches the agent being used to send the
-	 * MAD.
+	 * Set the high-order part of the transaction ID to make MADs from
+	 * different agents unique, and allow routing responses back to the
+	 * original requestor.
 	 */
-	method = ((struct ib_mad_hdr *) packet->msg->mad)->method;
-
-	if (!(method & IB_MGMT_METHOD_RESP)       &&
-	    method != IB_MGMT_METHOD_TRAP_REPRESS &&
-	    method != IB_MGMT_METHOD_SEND) {
+	if (!ib_response_mad(packet->msg->mad)) {
 		tid = &((struct ib_mad_hdr *) packet->msg->mad)->tid;
 		*tid = cpu_to_be64(((u64) agent->hi_tid) << 32 |
 				   (be64_to_cpup(tid) & 0xffffffff));
+		rmpp_mad->mad_hdr.tid = *tid;
+	}
+
+	spin_lock_irq(&file->send_lock);
+	ret = is_duplicate(file, packet);
+	if (!ret)
+		list_add_tail(&packet->list, &file->send_list);
+	spin_unlock_irq(&file->send_lock);
+	if (ret) {
+		ret = -EINVAL;
+		goto err_msg;
 	}
 
 	ret = ib_post_send_mad(packet->msg, NULL);
 	if (ret)
-		goto err_msg;
+		goto err_send;
 
 	up_read(&file->port->mutex);
 	return count;
 
+err_send:
+	dequeue_send(file, packet);
 err_msg:
 	ib_free_send_mad(packet->msg);
 err_ah:
@@ -657,7 +720,9 @@ static int ib_umad_open(struct inode *in
 	}
 
 	spin_lock_init(&file->recv_lock);
+	spin_lock_init(&file->send_lock);
 	INIT_LIST_HEAD(&file->recv_list);
+	INIT_LIST_HEAD(&file->send_list);
 	init_waitqueue_head(&file->recv_wait);
 
 	file->port = port;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index bdf5d50..30923eb 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -42,6 +42,13 @@ #include <asm/uaccess.h>
 
 #include "uverbs.h"
 
+static struct lock_class_key pd_lock_key;
+static struct lock_class_key mr_lock_key;
+static struct lock_class_key cq_lock_key;
+static struct lock_class_key qp_lock_key;
+static struct lock_class_key ah_lock_key;
+static struct lock_class_key srq_lock_key;
+
 #define INIT_UDATA(udata, ibuf, obuf, ilen, olen)			\
 	do {								\
 		(udata)->inbuf  = (void __user *) (ibuf);		\
@@ -76,12 +83,13 @@ #define INIT_UDATA(udata, ibuf, obuf, il
  */
 
 static void init_uobj(struct ib_uobject *uobj, u64 user_handle,
-		      struct ib_ucontext *context)
+		      struct ib_ucontext *context, struct lock_class_key *key)
 {
 	uobj->user_handle = user_handle;
 	uobj->context     = context;
 	kref_init(&uobj->ref);
 	init_rwsem(&uobj->mutex);
+	lockdep_set_class(&uobj->mutex, key);
 	uobj->live        = 0;
 }
 
@@ -470,7 +478,7 @@ ssize_t ib_uverbs_alloc_pd(struct ib_uve
 	if (!uobj)
 		return -ENOMEM;
 
-	init_uobj(uobj, 0, file->ucontext);
+	init_uobj(uobj, 0, file->ucontext, &pd_lock_key);
 	down_write(&uobj->mutex);
 
 	pd = file->device->ib_dev->alloc_pd(file->device->ib_dev,
@@ -591,7 +599,7 @@ ssize_t ib_uverbs_reg_mr(struct ib_uverb
 	if (!obj)
 		return -ENOMEM;
 
-	init_uobj(&obj->uobject, 0, file->ucontext);
+	init_uobj(&obj->uobject, 0, file->ucontext, &mr_lock_key);
 	down_write(&obj->uobject.mutex);
 
 	/*
@@ -770,7 +778,7 @@ ssize_t ib_uverbs_create_cq(struct ib_uv
 	if (!obj)
 		return -ENOMEM;
 
-	init_uobj(&obj->uobject, cmd.user_handle, file->ucontext);
+	init_uobj(&obj->uobject, cmd.user_handle, file->ucontext, &cq_lock_key);
 	down_write(&obj->uobject.mutex);
 
 	if (cmd.comp_channel >= 0) {
@@ -1051,13 +1059,14 @@ ssize_t ib_uverbs_create_qp(struct ib_uv
 	if (!obj)
 		return -ENOMEM;
 
-	init_uobj(&obj->uevent.uobject, cmd.user_handle, file->ucontext);
+	init_uobj(&obj->uevent.uobject, cmd.user_handle, file->ucontext, &qp_lock_key);
 	down_write(&obj->uevent.uobject.mutex);
 
+	srq = cmd.is_srq ? idr_read_srq(cmd.srq_handle, file->ucontext) : NULL;
 	pd  = idr_read_pd(cmd.pd_handle, file->ucontext);
 	scq = idr_read_cq(cmd.send_cq_handle, file->ucontext);
-	rcq = idr_read_cq(cmd.recv_cq_handle, file->ucontext);
-	srq = cmd.is_srq ? idr_read_srq(cmd.srq_handle, file->ucontext) : NULL;
+	rcq = cmd.recv_cq_handle == cmd.send_cq_handle ?
+		scq : idr_read_cq(cmd.recv_cq_handle, file->ucontext);
 
 	if (!pd || !scq || !rcq || (cmd.is_srq && !srq)) {
 		ret = -EINVAL;
@@ -1125,7 +1134,8 @@ ssize_t ib_uverbs_create_qp(struct ib_uv
 
 	put_pd_read(pd);
 	put_cq_read(scq);
-	put_cq_read(rcq);
+	if (rcq != scq)
+		put_cq_read(rcq);
 	if (srq)
 		put_srq_read(srq);
 
@@ -1150,7 +1160,7 @@ err_put:
 		put_pd_read(pd);
 	if (scq)
 		put_cq_read(scq);
-	if (rcq)
+	if (rcq && rcq != scq)
 		put_cq_read(rcq);
 	if (srq)
 		put_srq_read(srq);
@@ -1751,7 +1761,7 @@ ssize_t ib_uverbs_create_ah(struct ib_uv
 	if (!uobj)
 		return -ENOMEM;
 
-	init_uobj(uobj, cmd.user_handle, file->ucontext);
+	init_uobj(uobj, cmd.user_handle, file->ucontext, &ah_lock_key);
 	down_write(&uobj->mutex);
 
 	pd = idr_read_pd(cmd.pd_handle, file->ucontext);
@@ -1775,7 +1785,7 @@ ssize_t ib_uverbs_create_ah(struct ib_uv
 	ah = ib_create_ah(pd, &attr);
 	if (IS_ERR(ah)) {
 		ret = PTR_ERR(ah);
-		goto err;
+		goto err_put;
 	}
 
 	ah->uobject  = uobj;
@@ -1811,6 +1821,9 @@ err_copy:
 err_destroy:
 	ib_destroy_ah(ah);
 
+err_put:
+	put_pd_read(pd);
+
 err:
 	put_uobj_write(uobj);
 	return ret;
@@ -1963,7 +1976,7 @@ ssize_t ib_uverbs_create_srq(struct ib_u
 	if (!obj)
 		return -ENOMEM;
 
-	init_uobj(&obj->uobject, cmd.user_handle, file->ucontext);
+	init_uobj(&obj->uobject, cmd.user_handle, file->ucontext, &srq_lock_key);
 	down_write(&obj->uobject.mutex);
 
 	pd  = idr_read_pd(cmd.pd_handle, file->ucontext);
@@ -1984,7 +1997,7 @@ ssize_t ib_uverbs_create_srq(struct ib_u
 	srq = pd->device->create_srq(pd, &attr, &udata);
 	if (IS_ERR(srq)) {
 		ret = PTR_ERR(srq);
-		goto err;
+		goto err_put;
 	}
 
 	srq->device    	   = pd->device;
@@ -2029,6 +2042,9 @@ err_copy:
 err_destroy:
 	ib_destroy_srq(srq);
 
+err_put:
+	put_pd_read(pd);
+
 err:
 	put_uobj_write(&obj->uobject);
 	return ret;
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index 823131d..f98518d 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -859,6 +859,38 @@ static void ipath_rcv_layer(struct ipath
 		__ipath_layer_rcv_lid(dd, hdr);
 }
 
+static void ipath_rcv_hdrerr(struct ipath_devdata *dd,
+			     u32 eflags,
+			     u32 l,
+			     u32 etail,
+			     u64 *rc)
+{
+	char emsg[128];
+	struct ipath_message_header *hdr;
+
+	get_rhf_errstring(eflags, emsg, sizeof emsg);
+	hdr = (struct ipath_message_header *)&rc[1];
+	ipath_cdbg(PKT, "RHFerrs %x hdrqtail=%x typ=%u "
+		   "tlen=%x opcode=%x egridx=%x: %s\n",
+		   eflags, l,
+		   ipath_hdrget_rcv_type((__le32 *) rc),
+		   ipath_hdrget_length_in_bytes((__le32 *) rc),
+		   be32_to_cpu(hdr->bth[0]) >> 24,
+		   etail, emsg);
+
+	/* Count local link integrity errors. */
+	if (eflags & (INFINIPATH_RHF_H_ICRCERR | INFINIPATH_RHF_H_VCRCERR)) {
+		u8 n = (dd->ipath_ibcctrl >>
+			INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
+			INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
+
+		if (++dd->ipath_lli_counter > n) {
+			dd->ipath_lli_counter = 0;
+			dd->ipath_lli_errors++;
+		}
+	}
+}
+
 /*
  * ipath_kreceive - receive a packet
  * @dd: the infinipath device
@@ -875,7 +907,6 @@ void ipath_kreceive(struct ipath_devdata
 	struct ipath_message_header *hdr;
 	u32 eflags, i, etype, tlen, pkttot = 0, updegr=0, reloop=0;
 	static u64 totcalls;	/* stats, may eventually remove */
-	char emsg[128];
 
 	if (!dd->ipath_hdrqtailptr) {
 		ipath_dev_err(dd,
@@ -938,26 +969,9 @@ reloop:
 				   "%x\n", etype);
 		}
 
-		if (eflags & ~(INFINIPATH_RHF_H_TIDERR |
-			       INFINIPATH_RHF_H_IHDRERR)) {
-			get_rhf_errstring(eflags, emsg, sizeof emsg);
-			ipath_cdbg(PKT, "RHFerrs %x hdrqtail=%x typ=%u "
-				   "tlen=%x opcode=%x egridx=%x: %s\n",
-				   eflags, l, etype, tlen, bthbytes[0],
-				   ipath_hdrget_index((__le32 *) rc), emsg);
-			/* Count local link integrity errors. */
-			if (eflags & (INFINIPATH_RHF_H_ICRCERR |
-				      INFINIPATH_RHF_H_VCRCERR)) {
-				u8 n = (dd->ipath_ibcctrl >>
-					INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT) &
-					INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK;
-
-				if (++dd->ipath_lli_counter > n) {
-					dd->ipath_lli_counter = 0;
-					dd->ipath_lli_errors++;
-				}
-			}
-		} else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
+		if (unlikely(eflags))
+			ipath_rcv_hdrerr(dd, eflags, l, etail, rc);
+		else if (etype == RCVHQ_RCV_TYPE_NON_KD) {
 				int ret = __ipath_verbs_rcv(dd, rc + 1,
 							    ebuf, tlen);
 				if (ret == -ENODEV)
@@ -981,25 +995,7 @@ reloop:
 		else if (etype == RCVHQ_RCV_TYPE_EXPECTED)
 			ipath_dbg("Bug: Expected TID, opcode %x; ignored\n",
 				  be32_to_cpu(hdr->bth[0]) & 0xff);
-		else if (eflags & (INFINIPATH_RHF_H_TIDERR |
-				   INFINIPATH_RHF_H_IHDRERR)) {
-			/*
-			 * This is a type 3 packet, only the LRH is in the
-			 * rcvhdrq, the rest of the header is in the eager
-			 * buffer.
-			 */
-			u8 opcode;
-			if (ebuf) {
-				bthbytes = (u8 *) ebuf;
-				opcode = *bthbytes;
-			}
-			else
-				opcode = 0;
-			get_rhf_errstring(eflags, emsg, sizeof emsg);
-			ipath_dbg("Err %x (%s), opcode %x, egrbuf %x, "
-				  "len %x\n", eflags, emsg, opcode, etail,
-				  tlen);
-		} else {
+		else {
 			/*
 			 * error packet, type of error	unknown.
 			 * Probably type 3, but we don't know, so don't
diff --git a/drivers/infiniband/hw/ipath/ipath_keys.c b/drivers/infiniband/hw/ipath/ipath_keys.c
index 46773c6..a5ca279 100644
--- a/drivers/infiniband/hw/ipath/ipath_keys.c
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c
@@ -197,6 +197,21 @@ int ipath_rkey_ok(struct ipath_ibdev *de
 	size_t off;
 	int ret;
 
+	/*
+	 * We use RKEY == zero for physical addresses
+	 * (see ipath_get_dma_mr).
+	 */
+	if (rkey == 0) {
+		sge->mr = NULL;
+		sge->vaddr = phys_to_virt(vaddr);
+		sge->length = len;
+		sge->sge_length = len;
+		ss->sg_list = NULL;
+		ss->num_sge = 1;
+		ret = 1;
+		goto bail;
+	}
+
 	mr = rkt->table[(rkey >> (32 - ib_ipath_lkey_table_size))];
 	if (unlikely(mr == NULL || mr->lkey != rkey)) {
 		ret = 0;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index 56ac336..d70a9b6 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -191,10 +191,6 @@ void ipath_skip_sge(struct ipath_sge_sta
 {
 	struct ipath_sge *sge = &ss->sge;
 
-	while (length > sge->sge_length) {
-		length -= sge->sge_length;
-		ss->sge = *ss->sg_list++;
-	}
 	while (length) {
 		u32 len = sge->length;
 
@@ -627,6 +623,7 @@ static int ipath_query_device(struct ib_
 	props->device_cap_flags = IB_DEVICE_BAD_PKEY_CNTR |
 		IB_DEVICE_BAD_QKEY_CNTR | IB_DEVICE_SHUTDOWN_PORT |
 		IB_DEVICE_SYS_IMAGE_GUID;
+	props->page_size_cap = PAGE_SIZE;
 	props->vendor_id = ipath_layer_get_vendorid(dev->dd);
 	props->vendor_part_id = ipath_layer_get_deviceid(dev->dd);
 	props->hw_ver = ipath_layer_get_pcirev(dev->dd);
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index d0f7731..deabc14 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -778,11 +778,12 @@ #define QUERY_FW_EQ_SET_CI_BASE_OFFSET 0
 		((dev->fw_ver & 0xffff0000ull) >> 16) |
 		((dev->fw_ver & 0x0000ffffull) << 16);
 
+	MTHCA_GET(lg, outbox, QUERY_FW_MAX_CMD_OFFSET);
+	dev->cmd.max_cmds = 1 << lg;
+
 	mthca_dbg(dev, "FW version %012llx, max commands %d\n",
 		  (unsigned long long) dev->fw_ver, dev->cmd.max_cmds);
 
-	MTHCA_GET(lg, outbox, QUERY_FW_MAX_CMD_OFFSET);
-	dev->cmd.max_cmds = 1 << lg;
 	MTHCA_GET(dev->catas_err.addr, outbox, QUERY_FW_ERR_START_OFFSET);
 	MTHCA_GET(dev->catas_err.size, outbox, QUERY_FW_ERR_SIZE_OFFSET);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index fab417c..b60a9d7 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -370,7 +370,8 @@ int mthca_modify_srq(struct ib_srq *ibsr
 		return -EINVAL;
 
 	if (attr_mask & IB_SRQ_LIMIT) {
-		if (attr->srq_limit > srq->max)
+		u32 max_wr = mthca_is_memfree(dev) ? srq->max - 1 : srq->max;
+		if (attr->srq_limit > max_wr)
 			return -EINVAL;
 
 		mutex_lock(&srq->mutex);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 3f89f5e..474aa21 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -212,6 +212,7 @@ struct ipoib_path {
 
 struct ipoib_neigh {
 	struct ipoib_ah    *ah;
+	union ib_gid        dgid;
 	struct sk_buff_head queue;
 
 	struct neighbour   *neighbour;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 1c6ea1c..cf71d2a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -404,6 +404,8 @@ static void path_rec_completion(int stat
 		list_for_each_entry(neigh, &path->neigh_list, list) {
 			kref_get(&path->ah->ref);
 			neigh->ah = path->ah;
+			memcpy(&neigh->dgid.raw, &path->pathrec.dgid.raw,
+			       sizeof(union ib_gid));
 
 			while ((skb = __skb_dequeue(&neigh->queue)))
 				__skb_queue_tail(&skqueue, skb);
@@ -510,6 +512,8 @@ static void neigh_add_path(struct sk_buf
 	if (path->ah) {
 		kref_get(&path->ah->ref);
 		neigh->ah = path->ah;
+		memcpy(&neigh->dgid.raw, &path->pathrec.dgid.raw,
+		       sizeof(union ib_gid));
 
 		ipoib_send(dev, skb, path->ah,
 			   be32_to_cpup((__be32 *) skb->dst->neighbour->ha));
@@ -633,6 +637,25 @@ static int ipoib_start_xmit(struct sk_bu
 		neigh = *to_ipoib_neigh(skb->dst->neighbour);
 
 		if (likely(neigh->ah)) {
+			if (unlikely(memcmp(&neigh->dgid.raw,
+					    skb->dst->neighbour->ha + 4,
+					    sizeof(union ib_gid)))) {
+				spin_lock(&priv->lock);
+				/*
+				 * It's safe to call ipoib_put_ah() inside
+				 * priv->lock here, because we know that
+				 * path->ah will always hold one more reference,
+				 * so ipoib_put_ah() will never do more than
+				 * decrement the ref count.
+				 */
+				ipoib_put_ah(neigh->ah);
+				list_del(&neigh->list);
+				ipoib_neigh_free(neigh);
+				spin_unlock(&priv->lock);
+				ipoib_path_lookup(skb, dev);
+				goto out;
+			}
+
 			ipoib_send(dev, skb, neigh->ah,
 				   be32_to_cpup((__be32 *) skb->dst->neighbour->ha));
 			goto out;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index ab40488..b5e6a7b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -264,6 +264,10 @@ static int ipoib_mcast_join_finish(struc
 		if (!ah) {
 			ipoib_warn(priv, "ib_address_create failed\n");
 		} else {
+			spin_lock_irq(&priv->lock);
+			mcast->ah = ah;
+			spin_unlock_irq(&priv->lock);
+
 			ipoib_dbg_mcast(priv, "MGID " IPOIB_GID_FMT
 					" AV %p, LID 0x%04x, SL %d\n",
 					IPOIB_GID_ARG(mcast->mcmember.mgid),
@@ -271,10 +275,6 @@ static int ipoib_mcast_join_finish(struc
 					be16_to_cpu(mcast->mcmember.mlid),
 					mcast->mcmember.sl);
 		}
-
-		spin_lock_irq(&priv->lock);
-		mcast->ah = ah;
-		spin_unlock_irq(&priv->lock);
 	}
 
 	/* actually send any queued packets */
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 5ff7755..585d28e 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -75,6 +75,7 @@ #define IB_MGMT_METHOD_REPORT_RESP		0x86
 #define IB_MGMT_METHOD_TRAP_REPRESS		0x07
 
 #define IB_MGMT_METHOD_RESP			0x80
+#define IB_BM_ATTR_MOD_RESP			cpu_to_be32(1)
 
 #define IB_MGMT_MAX_METHODS			128
 
@@ -247,6 +248,12 @@ struct ib_mad_send_buf {
 };
 
 /**
+ * ib_response_mad - Returns if the specified MAD has been generated in
+ *   response to a sent request or trap.
+ */
+int ib_response_mad(struct ib_mad *mad);
+
+/**
  * ib_get_rmpp_resptime - Returns the RMPP response time.
  * @rmpp_hdr: An RMPP header.
  */
